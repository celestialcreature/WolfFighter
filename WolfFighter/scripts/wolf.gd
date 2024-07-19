extends CharacterBody2D

@export var SPEED = 25
@export var health: int = 100
@export var attack: int = 10
@export var defense: int = 5
@export var type = "Beast"

var player_chase=false
var playerAttackRange = false
var player_cooldown = true
var player = null
var time=0.0


func _physics_process(delta):
	check_damage()
	if player_chase:
		position += (player.position - position)/SPEED
		$AnimatedSprite2D.play("run")
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	move_and_slide()
	

func _ready():
	$AnimatedSprite2D.play("idlestand2")

func _on_vision_body_entered(body):
	$AnimatedSprite2D.play("bark")

func _on_vision_body_exited(body):
	$AnimatedSprite2D.play("idlestand2")

func _on_attack_range_body_entered(body):
	player = body
	player_chase = true
	

func _on_attack_range_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass

func _on_hit_range_body_entered(body):
#	print(body)
	if body.has_method("player"):
		playerAttackRange = true
		print("Player in range")


func _on_hit_range_body_exited(body):
	if body.has_method("player"):
		playerAttackRange = false
		print("player out of range")

func check_damage():
#	print("Player in Range: ", playerAttackRange)
#	print("Player is Attaking: ", global.playerIsAttacking)
#	print("cooldown: ", player_cooldown)
#	print()
#						
	if playerAttackRange and global.playerIsAttacking == true && player_cooldown == true:
		health -= 20
		$Health_Bar.value -= 20
		print("Wolf Health = ", health)
		if health <= 0:
			self.queue_free()
			print("Wolf Dead")
			pass
		player_cooldown == false


func _on_hurt_range_body_entered(body):
	pass # Replace with function body.


func _on_hurt_range_body_exited(body):
	pass # Replace with function body.


#func _on_player_attack_cooldown_timeout():
#
#	pass # Replace with function body.


func _on_player_attack_cooldown_timeout():
	player_cooldown = true
	pass # Replace with function body.
