extends RayCast2D
@onready var enemyraycast: RayCast2D = $"."
var scan_range=deg_to_rad(90.0)
var scan_speed=2.0
var time =0.0
func _process(delta: float) -> void:
	if 1==0:
		if enemyraycast.is_colliding()!=true:
			time+=delta*scan_speed
			var target_rotation = sin(time)* scan_range
			enemyraycast.rotation=target_rotation
			print("not colliding")
		else:
			print("colliding")
#musze sprobowac stworzyc area collider mask 2(player) 
#sktore bedzie zwracalo body ktorego bede mogl uzyc jako cel
