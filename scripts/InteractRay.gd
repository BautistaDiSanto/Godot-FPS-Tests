extends RayCast

onready var crossair = $CanvasLayer/InGameUI/Crossair

func _input(event):
	var collided = get_collider()
	if collided is Door:
		collided._on_mouse_entered()
	return event
