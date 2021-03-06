tool
extends EditorPlugin

var use_bts_editor = true

var InspectorPlugin = preload('./inspector_plugin/inspector_plugin.gd')
var inspector_plugin

var remote_debug = preload('./remote_debug/RemoteDebug.gd').new()

var BTSCompiler = preload('./compiler/Compiler.gd')

var BTSEditor = preload('res://addons/naive_behavior_tree/editor/script_editor/BTSEditor.tscn')
var bts_editor

var clean_confirm_dialog:ConfirmationDialog

func _enter_tree() -> void:
	inspector_plugin = InspectorPlugin.new()
	add_inspector_plugin(inspector_plugin)
	
	inspector_plugin.connect('compile_button_pressed', self, '_on_compile_button_pressed')
	inspector_plugin.connect('clean_button_pressed', self, '_on_clean_button_pressed')
	
	clean_confirm_dialog = ConfirmationDialog.new()
	get_editor_interface().get_base_control().add_child(clean_confirm_dialog)
	clean_confirm_dialog.connect('confirmed', self, '_confirm_clean_file')
	
	bts_editor = BTSEditor.instance()
	get_editor_interface().get_editor_viewport().add_child(bts_editor)
	make_visible(false)
	

func _ready() -> void:
	bts_editor.init(self)
	add_child(remote_debug)
	

func _exit_tree() -> void:
	bts_editor.queue_free()
	
	remove_inspector_plugin(inspector_plugin)
	inspector_plugin = null
	
	clean_confirm_dialog.queue_free()

#----- Overrides -----
func has_main_screen() -> bool:
	return use_bts_editor

func make_visible(visible: bool) -> void:
	if bts_editor:
		bts_editor.visible = visible

func handles(object: Object) -> bool:
	if object is BehaviorTreeScriptResource:
		return true
	return false

func edit(object: Object) -> void:
	if object is BehaviorTreeScriptResource:
		bts_editor.edit(object)
	

func save_external_data() -> void:
	bts_editor.save()

func get_plugin_name() -> String:
	return 'Naive Behavior Tree Plugin'

func get_plugin_icon() -> Texture:
	return preload("res://addons/naive_behavior_tree/icon.svg")
#----- Methods -----
func compile_task_function(res:BehaviorTreeScriptResource):
	print('Begin to compile bts: "%s"...' % res.resource_path)
	if compile(res):
		print('Compile bts: "%s" success!' % res.resource_path)
	else:
		printerr('Compile bts: "%s" fail!' % res.resource_path)
	
func set_children_owner(p:Node, o:Node):
	for child in p.get_children():
		child.owner = o
		set_children_owner(child, o)
	

func compile(res:BehaviorTreeScriptResource):
	var path = res.resource_path
	var basename = path.get_basename()
	var fileNmae = path.get_file().replace('.' + path.get_extension(), '')
	var ext = 'tscn'
	var output = '%s.%s' % [basename, ext]
	
	var dir = Directory.new()
	var err = dir.open('res://')
	if err != OK:
		printerr('Can\'t open root directory, code: %d' % err)
		return false
		
	if dir.file_exists(output):
		printerr('File: "%s" exists! Please clean before compile.' % output)
		return false
	
	var source = res.data
	
	var compiler = BTSCompiler.new()
	compiler.init()
	
	var bt = compiler.compile(source, path)
	if bt == null:
		printerr('Can\'t compile bts: "%s"' % path)
		return false
	bt.name = fileNmae
	set_children_owner(bt, bt)
	
	var ps = PackedScene.new()
	ps.pack(bt)
	
	err = ResourceSaver.save(output, ps)
	if err != OK:
		printerr('Can\'t save the output: "%s", code: %d' % [output, err])
		bt.queue_free()
		return false
	return true
	

func clean_file(res:BehaviorTreeScriptResource):
	var path = res.resource_path
	var basename = path.get_basename()
	var ext = 'tscn'
	var output = '%s.%s' % [basename, ext]
	
	print('Cleaning file "%s"' % output)
	var dir = Directory.new()
	var err = dir.open('res://')
	if err != OK:
		printerr('Can\'t open root directory, code: %d' % err)
		return
		
	if not dir.file_exists(output):
		printerr('File: "%s" does not exist!' % output)
		return
	
	err = dir.remove(output)
	if err != OK:
		printerr('Can\'t remove file: "%s", code: %d' % [output, err])
		return
	
	print('Clean done.')
#----- Signals -----
func _on_compile_button_pressed(res:BehaviorTreeScriptResource):
	compile_task_function(res)

func _on_clean_button_pressed(res:BehaviorTreeScriptResource):
	clean_confirm_dialog.dialog_text = 'Are you sure to delete the result of compiling "%s"?\nThese may do some unchangable influences to your project!' % res.resource_path
	clean_confirm_dialog.set_meta('res', res)
	clean_confirm_dialog.popup_centered()

func _confirm_clean_file():
	if clean_confirm_dialog.has_meta('res'):
		clean_file(clean_confirm_dialog.get_meta('res'))
