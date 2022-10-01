extends Area

var open = false

export var close_angle = Vector3(0,0,0)
export var open_angle = Vector3(0,0,0)
onready var tween = $Tween

var in_animation = false

func _on_mouse_entered():
	if not in_animation:
		if !open:
			in_animation = true
			tween.interpolate_property(self, "rotation_degrees", close_angle, open_angle, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		if open:
			in_animation = true
			tween.interpolate_property(self, "rotation_degrees", open_angle, close_angle, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		tween.start()


func _on_Tween_completed():
	in_animation = false
	open = !open
