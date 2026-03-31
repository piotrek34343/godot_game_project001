extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attacktimer: Timer = $attacktimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const BASESPEED = 250
var idledirectiony=1
var attacksqueued=false
var attackvariant=1
#momentum opposite of actual momentum
var momentumx=1
var momentumy=1
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
		SPEED=0
	if directionx:
		velocity.x = directionx * SPEED
		if momentumx<velocity.x:
			momentumx+=1
	else:
		velocity.x = move_toward(velocity.x, 0, STOP)
		velocity.x*=momentumx
		if momentumx>0:
			momentumx-=1
	if directiony:
		velocity.y = directiony * SPEED
		if momentumy<velocity.y:
			momentumy+=1
	else:
		velocity.y = move_toward(velocity.y, 0, STOP)
		velocity.y*=SPEED* momentumy
		if momentumy>0:
			momentumy-=1
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
