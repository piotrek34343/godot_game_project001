extends Sprite2D
@onready var decorative_object: Sprite2D = $"."


func _on_decorobjectarea_2d_body_entered(body: Node2D) -> void:
	decorative_object.z_index=11
	print("area entered")

func _on_decorobjectarea_2d_body_exited(body: Node2D) -> void:
	decorative_object.z_index=8
	print("area exited")
