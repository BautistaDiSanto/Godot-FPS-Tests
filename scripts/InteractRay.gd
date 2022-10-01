extends RayCast

func _input(event):
	var collided = get_collider()
	if collided and collided.is_in_group("Interact"):
		print('interactable')
		if Input.is_action_just_pressed("interact"):
			collided._on_mouse_entered()

	return event
