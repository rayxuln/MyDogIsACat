extends DataModel


var health:float = 90
var hunger:float = 50 # 饥饿度，越小越饿
var thirsty:float = 50 # 口渴度，越小越渴
var tire:float = 0 # 疲惫度，越大越疲惫
var poop:float = 0 # 排泄度，越大越需要排泄

var hunger_threshold = 45

var max_health:float = 100
var max_hunger:float = 100
var max_thirsty:float = 100
var max_tire:float = 100
var max_poop:float = 100

var hunger_rate:float = 0.1 # 每刻饥饿减少的概率
var thirsty_rate:float = 0.1 # 每刻口渴度减少的概率
var tire_rate:float = 0.2 # 每刻疲惫的概率
var poop_rate:float = 0.3 # 排泄转换程度


