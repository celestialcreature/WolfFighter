extends Area2D


func player():
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
		$cut_collision_box.disabled = true
		$Cut_animation.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack_1"):
		$cut_collision_box.disabled = false
		$Cut_animation.visible = true

	if Input.is_action_just_released("attack_1"):
		$cut_collision_box.disabled = true
		$Cut_animation.visible = false

func deal_damage():
	return 20
