extends Area

var playerOnArea
var poisonInterval = 1
var currentDamage = 0
var canTakeDamage = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playerOnArea and canTakeDamage:
		canTakeDamage = false
		damage_player()
	pass


func _on_MushroonPoison_body_entered(body):
	if body.is_in_group("Player"):
		playerOnArea = true
		canTakeDamage = true
	pass

func _on_MushroonPoison_body_exited(body):
	if body.is_in_group("Player"):
		playerOnArea = false
	pass
	
func damage_player():
	currentDamage += 25
	yield(get_tree().create_timer(poisonInterval), "timeout")
	canTakeDamage = true
	print("damage", currentDamage)
