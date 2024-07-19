extends CharacterBody2D

@export var SPEED = 200
@export var health = 100
@export var type = "Human"
@export var STAMINA: float = 10
var stamina: float = STAMINA

var enemyInRange = false
var enemyCooldown = true
var playerAlive = true

func player():
	pass

func _ready():
	$AnimatedSprite2D.play("frontidle")

func move_player():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("rightwalk")
	if Input.is_action_just_released("right"):
		$AnimatedSprite2D.play("rightidle")
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("leftwalk")
	if Input.is_action_just_released("left"):
		$AnimatedSprite2D.play("leftidle")
	if Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("frontwalk")
	if Input.is_action_just_released("down"):
		$AnimatedSprite2D.play("frontidle")
	if Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("upwalk")
	if Input.is_action_just_released("up"):
		$AnimatedSprite2D.play("upidle")
	if Input.is_action_pressed("special"): 
		if stamina > 0:
			stamina -= 1
			velocity *= 3
	if !Input.is_action_pressed("special"):
		while stamina < STAMINA:
			stamina += 0.001

func _physics_process(delta):
	move_player()
	#print(health)
	enemy_attack()
	move_and_slide()
	
	if health <= 0:
		playerAlive = false
		health = 0
		print("dead")
		#add game over here

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemyInRange = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemyInRange = false

func enemy_attack():
	if enemyInRange and enemyCooldown == true:
		health = health - 20
		enemyCooldown = false
		$attackCooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	enemyCooldown = true
