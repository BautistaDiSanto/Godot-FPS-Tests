extends RayCast

onready var CrossairText = $InGameUI/CrossairText
onready var CrossairActive = $InGameUI/CrossairActive
onready var CrossairInactive = $InGameUI/CrossairInactive


func _process(delta):
	var collided = get_collider()
	if collided and collided.is_in_group("Interactable"):
		CrossairText.text = collided.interactionMessage
		CrossairActive.visible = true
		CrossairInactive.visible = false
		if Input.is_action_just_pressed("interact"):
			collided._on_mouse_entered()
			
	else: 
		CrossairText.text = ""
		CrossairActive.visible = false
		CrossairInactive.visible = true
		
	return delta

