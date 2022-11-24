extends RayCast

onready var CrossairText = $InGameUI/Control/CrossairText
onready var Crossair = $InGameUI/Control/Crossair

func _process(delta):
	var collided = get_collider()
	if collided and collided.is_in_group("Interactable"):
		CrossairText.text = collided.interactionMessage
		Crossair.value = 1
		if Input.is_action_just_pressed("interact"):
			collided._on_mouse_entered()
			
	else: 
		CrossairText.text = ""
		Crossair.value = 0
		
	return delta

