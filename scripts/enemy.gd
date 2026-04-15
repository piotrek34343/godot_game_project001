extends CharacterBody2D
@onready var aggroarea: Area2D = $aggroarea
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attacktimer: Timer = $attacktimer
@onready var enemy: CharacterBody2D = $"."
const BASESPEED = 200
var idledirectiony=1
var attacksqueued=false
var attackvariant=1
#delayed direction
var ddx=0
var ddy=0
var target_player
func _ready() -> void:
	print("enemy.gd Ready")
func _on_body_entered(body: CharacterBody2D) -> void:
	target_player = body
	print("body entered")

func _on_body_exited(body: CharacterBody2D) -> void:
	if body == target_player:
		target_player = null
		print("body exited")


func _physics_process(delta: float) -> void:
	#input
	var directionx=0.0
	var directiony=0.0
	var run := 1+1*int(Input.is_action_pressed("run"))
	var attack := Input.is_action_pressed("attack")
	var SPEED := run * BASESPEED * (delta*50)
	var STOP := SPEED
#movement
	var direction=0
	if target_player:
		print("target player")
		directionx =(target_player.global_position.x - global_position.x)/300
		directiony =(target_player.global_position.y - global_position.y)/300
	if attack==true or attacktimer.is_stopped()==false:
		SPEED*=0.1
	ddy=move_toward(ddy,directiony,3*delta)
	ddx=move_toward(ddx,directionx,3*delta)
	velocity.y = ddy * SPEED
	velocity.x = ddx * SPEED
	if ddx==0:
		velocity.x = move_toward(velocity.x, 0, STOP)
	if ddy==0:
		velocity.y = move_toward(velocity.y, 0, STOP)
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
				animated_sprite.play("attack_up")
			else:
				if idledirectiony>0:
					animated_sprite.play("attack_down")
				else:
					animated_sprite.play("attack_side")
	else:
		if directionx==0 and directiony==0 and attacktimer.is_stopped():
			animated_sprite.play("idle")
		else:
			if attacktimer.is_stopped():
				animated_sprite.play("run")
		attackvariant=1
			

	move_and_slide()
