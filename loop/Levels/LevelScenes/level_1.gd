extends Level

@onready var rng = RandomNumberGenerator.new()

@export var wind = Vector2.ZERO
@export var max_wind: float = 10.0
var dist_range = 4.0

func _process(_delta: float) -> void:
	wind += Vector2(rng.randfn(0.0, dist_range), rng.randfn(0.0, dist_range))
	print(wind)
	if abs(wind.x) > max_wind:
		wind.x = rng.randfn(0.0, dist_range)
	if abs(wind.y) > max_wind:
		wind.y = rng.randfn(0.0, dist_range)
