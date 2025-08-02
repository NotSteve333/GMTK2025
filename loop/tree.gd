extends Obstacle
class_name tree

@onready var layers: Node2D = $TreeLayers

var rgn: RandomNumberGenerator

var num_layers: int
var wind_scale: float = 5.0
var t: float
var wind: Vector2

func _ready() -> void:
	num_layers = layers.get_child_count()

func _physics_process(_delta: float) -> void:
	wind = get_parent().get_parent().wind
	t = get_parent().get_parent().time_scale
	for i in layers.get_children():
		i.set_position(wind.rotated(randfn(0.0, .5)) * wind_scale * sin(t + randfn(0.0, 0.2) / 100.0))
