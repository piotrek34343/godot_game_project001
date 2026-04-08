extends RayCast2D
@onready var enemyraycast: RayCast2D = $"."
var flip=-1
var rvalue=1
func _process(delta: float) -> void:
	if enemyraycast.collide_with_bodies!=true:
		enemyraycast.rotation=move_toward(enemyraycast.rotation,enemyraycast.rotation+(rvalue*flip),delta)
		flip=flip*-1
		rvalue=rvalue*2
		print("not colliding")
	else:
		flip=-1
		rvalue=1
#musze sprobowac stworzyc area collider mask 2(player) 
#sktore bedzie zwracalo body ktorego bede mogl uzyc jako cel
