extends RayCast

func _input(event):
	var collided: Area = get_collider()
	if collided is Door:
		collided._on_mouse_entered()
