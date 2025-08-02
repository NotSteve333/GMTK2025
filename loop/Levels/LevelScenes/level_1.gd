extends Level

@onready var rng = RandomNumberGenerator.new()

@export var wind = Vector2.UP
@export var time_scale: float = 0

var angle_range = .1

func _process(delta: float) -> void:
	wind = wind.rotated(rng.randfn(0.0, angle_range))
	time_scale += delta
