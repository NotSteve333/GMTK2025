extends Obstacle
class_name tree

@onready var layers: Node2D = $TreeLayers

var num_layers: int
var wind: Vector2

func _ready() -> void:
	num_layers = layers.get_child_count()

func _physics_process(delta: float) -> void:
	wind = get_parent().get_parent().wind
	for i in layers.get_children():
		i.nudge(wind, 1.0)
