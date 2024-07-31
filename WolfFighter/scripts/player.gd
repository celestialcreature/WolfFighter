extends CharacterBody2D

@export var SPEED = 200
@export var health = 100
@export var type = "Human"
@export var MAX_STAMINA: float = 10
var cur_stamina: float = MAX_STAMINA

var enemyInRange = false
var enemyCooldown = true
var playerAlive = true

@onready var stamina_bar = get_node("Stamina_Bar")



func _ready():
	$AnimatedSprite2D.play("frontidle")

func move_player():
	if playerAlive == true:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		velocity = input_direction * SPEED
		if Input.is_action_pressed("right"):
			$AnimatedSprite2D.play("rightwalk")
			$meele_attack_area.rotation_degrees = -90
		if Input.is_action_just_released("right"):
			$AnimatedSprite2D.play("rightidle")
			
		if Input.is_action_pressed("left"):
			$AnimatedSprite2D.play("leftwalk")
			$meele_attack_area.rotation_degrees = 90
		if Input.is_action_just_released("left"):
			$AnimatedSprite2D.play("leftidle")
			
		if Input.is_action_pressed("down"):
			$AnimatedSprite2D.play("frontwalk")
			$meele_attack_area.rotation_degrees = 0
		if Input.is_action_just_released("down"):
			$AnimatedSprite2D.play("frontidle")
			
		if Input.is_action_pressed("up"):
			$AnimatedSprite2D.play("upwalk")
			$meele_attack_area.rotation_degrees = 180
		if Input.is_action_just_released("up"):
			$AnimatedSprite2D.play("upidle")
			
		if Input.is_action_pressed("special"): 
			if cur_stamina > 0:
				cur_stamina -= 1
				#TextureProgressBar
				stamina_bar.value -= 1
				velocity *= 3
		if !Input.is_action_pressed("special"):
			while cur_stamina < MAX_STAMINA:
				cur_stamina += 0.001
				stamina_bar.value += 0.001
				
#		if Input.is_action_pressed("attack_1"):
#			$meele_attack_area/cut_collision_box.disabled = false
#			$meele_attack_area/Cut_animation.visible = true
#			player_attack()
#		if Input.is_action_just_released("attack_1"):
#			$meele_attack_area/cut_collision_box.disabled = true
#			$meele_attack_area/Cut_animation.visible = false
#			player_attack_reset()
			pass

func _physics_process(delta):
	move_player()
	#print("Player: " + str(health))
	enemy_attack()
	move_and_slide()
	
	if health <= 0 && playerAlive == true:
		playerAlive = false
		health = 0
		$AnimatedSprite2D.play("Dead")
		print("Player: dead")
		#add game over here

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemyInRange = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemyInRange = false

func enemy_attack():
	if enemyInRange and enemyCooldown == true && playerAlive == true:
		health = health - 20
		$Health_Bar.value -= 20
		enemyCooldown = false
		$enemyAttackCooldown.start()
		print("Player: " + str(health))

#func _on_attack_cooldown_timeout():
#	enemyCooldown = true

#func player_attack():
#	$meele_attack_area/cut_collision_box.disabled = false
#	$meele_attack_area/Cut_animation.visible = true
#	global.playerIsAttacking = true
#	for i in 4:
#		$meele_attack_area.position = Vector2i(i,0)
#	$meele_attack_area/cut_collision_box.disabled = true
#	$meele_attack_area/Cut_animation.visible = false
#	$meele_attack_area.position = Vector2i(0,0)
#	pass
	
#func player_attack_reset():
#	$meele_attack_area/cut_collision_box.disabled = true
#	$meele_attack_area/Cut_animation.visible = false
#	$meele_attack_area.position = Vector2i(0,0)
#	global.playerIsAttacking = false
#	pass

#func _on_player_attack_cooldown_timeout():
#	pass # Replace with function body.
#
#
#func _on_meele_attack_area_area_entered(area):
##	if area.is_in_group("hurtbox")
##		area.takeDamage()
#	pass # Replace with function body.




func _on_meele_attack_area_body_entered(body):
	print("wolf is hit")
	global.playerIsAttacking = true
	if body.has_method("enemy"):
		body.playerAttackRange = true
