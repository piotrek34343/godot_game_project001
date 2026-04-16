extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attacktimer: Timer = $attacktimer
@onready var player: CharacterBody2D = $"."

const BASESPEED = 250
var idledirectiony=1
var attacksqueued=false
var attackvariant=1
#delayed direction
var ddx=0
var ddy=0
func _physics_process(delta: float) -> void:
	#input
	var directionx := Input.get_axis("left", "right")
	var directiony := Input.get_axis("up", "down")
	var run := 1+0.5*int(Input.is_action_pressed("run"))
	var attack := Input.is_action_pressed("attack")
	var SPEED := run * BASESPEED * (delta*50)
	var STOP := SPEED
#movement
	if attack==true or attacktimer.is_stopped()==false:
		SPEED*=(attacktimer.time_left+0.2)**3
	ddy=move_toward(ddy,directiony,3*delta)
	ddx=move_toward(ddx,directionx,3*delta)
	velocity.y = ddy * SPEED
	velocity.x = ddx * SPEED
	if ddx==0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if ddy==0:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	#saving the y direction
	if directiony:
		idledirectiony=directiony
	if directionx:
		idledirectiony=0
	#sprite, animations
	if directionx>0:
		animated_sprite.flip_h=false
	else:
		if directionx<0:
			animated_sprite.flip_h=true
	if attack==true:
		if attacktimer.is_stopped():
			attacktimer.start()
			if idledirectiony<0:
				if attackvariant==2:
					animated_sprite.play("attack_up_2")
					attackvariant=1
				else:
					animated_sprite.play("attack_up_1")
					attackvariant=2
			else:
				if idledirectiony>0:
					if attackvariant==2:
						animated_sprite.play("attack_down_2")
						attackvariant=1
					else:
						animated_sprite.play("attack_down_1")
						attackvariant=2
				else:
					if attackvariant==2:
						animated_sprite.play("attack_side_2")
						attackvariant=1
					else:
						animated_sprite.play("attack_side_1")
						attackvariant=2
	else:
		if directionx==0 and directiony==0 and attacktimer.is_stopped():
			animated_sprite.play("idle")
		else:
			if attacktimer.is_stopped():
				animated_sprite.play("run")
		attackvariant=1
			

	move_and_slide()
