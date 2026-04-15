extends Area2D

func _ready() -> void:
	print("Area2D ready! Name: ", name)
	print("Monitoring: ", monitoring)
	print("Monitorable: ", monitorable)
	print("Collision Layer: ", collision_layer)
	print("Collision Mask: ", collision_mask)
	
	var shape = get_child(0)
	if shape:
		print("Has shape child: ", shape.name)
		print("Shape resource: ", shape.shape)
		print("Shape disabled: ", shape.disabled)
	else:
		print("❌ NO SHAPE CHILD FOUND!")
	

func _on_body_entered(body: Node) -> void:
	print("🎉 BODY ENTERED: ", body.name)

func _on_area_entered(area: Area2D) -> void:
	print("🎉 AREA ENTERED: ", area.name)

#func _process(_delta) -> void:
	# See what bodies are overlapping every frame
	#var bodies = get_overlapping_bodies()
	#if bodies.size() > 0:
	#	print("Overlapping bodies: ", bodies.map(func(b): return b.name))
