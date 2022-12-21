extends KinematicBody2D

var velocity: Vector2 = Vector2()
var speed: int  = 150
var direction: String = "Down"
var attack: bool = false
var talking = false

onready var AttackPivot = $AttackPivot
onready var WeaponHitbox = $AttackPivot/WeaponHitbox 
onready var InteractArea = $InteractArea
onready var InteractionBox = $InteractArea/InteractionBox

const Projectile = preload("res://Util/Resources/FireballProjectile.tscn")


func _ready():
	WeaponHitbox.disabled = true
	InteractionBox.disabled = true


func _process(delta):
#	LevelingUp()
	Interact()
	attack()
	move()
	move_and_slide(velocity)

#func LevelingUp():
#	if PlayerStats.levelingup == true:
#		$AnimationPlayer.play("LevelUp")
#		yield(get_tree().create_timer(1.2),"timeout")
#		PlayerStats.levelingup = false

func move():
	velocity = Vector2()
	if attack == false:
		if Input.is_action_pressed("LEFT"):
			direction = "Left"
			$Position.position = Vector2(-14, 0)
			AttackPivot.rotation_degrees = 90
			AttackPivot.position = Vector2(0,0)
			InteractArea.rotation_degrees = 90
			InteractArea.position = Vector2(0,0)
			velocity.x = -speed
			get_node("AnimatedSprite").play("Left")
			
		elif Input.is_action_pressed("RIGHT"):
			direction = "Right"
			$Position.position = Vector2(14, 0)
			AttackPivot.rotation_degrees = 270
			AttackPivot.position = Vector2(0,5)
			InteractArea.rotation_degrees = 270
			InteractArea.position = Vector2(0,5)
			velocity.x = speed
			$AnimatedSprite.play("Right")
			
		elif Input.is_action_pressed("UP"):
			direction = "Up"
			$Position.position = Vector2(0, -14)
			AttackPivot.rotation_degrees = 180
			AttackPivot.position = Vector2(0,5)
			InteractArea.rotation_degrees = 180
			InteractArea.position = Vector2(0,5)
			velocity.y = -speed
			$AnimatedSprite.play("Up")
			
		elif Input.is_action_pressed("DOWN"):
			direction = "Down"
			$Position.position = Vector2(0, 14)
			AttackPivot.rotation_degrees = 0
			AttackPivot.position = Vector2(0,0)
			InteractArea.rotation_degrees = 0
			InteractArea.position = Vector2(0,0)
			velocity.y = speed
			$AnimatedSprite.play("Down")
			
		else:
			idle()
	velocity = velocity.normalized() * speed


func idle():
	if attack == false and direction == "Left":
		$AnimatedSprite.play("Left")
		$AnimatedSprite.frame = 1
		
	elif attack == false and direction == "Right":
		$AnimatedSprite.play("Right")
		$AnimatedSprite.frame = 1
		
	elif attack == false and direction == "Up":
		$AnimatedSprite.play("Up")
		$AnimatedSprite.frame = 1
		
	elif attack == false and direction == "Down":
		$AnimatedSprite.play("Down")
		$AnimatedSprite.frame = 1


func Interact():
	if Input.is_action_pressed("Interact"):
		InteractionBox.disabled = false
		yield(get_tree().create_timer(0.2),"timeout")
		InteractionBox.disabled = true


func attack():
	if Input.is_action_just_released("Attack"):
		attack = true
		if direction == "Left":
			$AnimatedSprite.play("AttackLeft")
			WeaponHitbox.disabled = false
			yield(get_tree().create_timer(0.4),"timeout")
			WeaponHitbox.disabled = true
			attack = false
			
		if direction == "Right":
			$AnimatedSprite.play("AttackRight")
			WeaponHitbox.disabled = false
			yield(get_tree().create_timer(0.4),"timeout")
			WeaponHitbox.disabled = true
			attack =false
			
		if direction == "Up":
			$AnimatedSprite.play("AttackUp")
			WeaponHitbox.disabled = false
			yield(get_tree().create_timer(0.4),"timeout")
			WeaponHitbox.disabled = true
			attack = false
			
		if direction == "Down":
			$AnimatedSprite.play("AttackDown")
			WeaponHitbox.disabled = false
			yield(get_tree().create_timer(0.4),"timeout")
			WeaponHitbox.disabled = true
			attack = false

		var position_spawn = $Position.global_position
		create_projectile(position_spawn)


func create_projectile(pos):
	var projectile = Projectile.instance()
	projectile.set_position(pos)
	get_parent().add_child(projectile)
	if direction == "Left":
		get_parent().get_node("Projectile").motion = Vector2(-500, 0)
		
	if direction == "Right":
		get_parent().get_node("Projectile").motion = Vector2(500, 0)
		
	if direction == "Up":
		get_parent().get_node("Projectile").motion = Vector2(0, -500)
		
	if direction == "Down":
		get_parent().get_node("Projectile").motion = Vector2(0, 500)
	return projectile


func _on_AttackPivot_body_entered(body):
	if body.is_in_group("Enemy"):
		print("Ouch")


func _on_InteractArea_body_entered(body):
	if body.is_in_group("NPC"):
		if direction == "Left":
			body.faceright()
			body.Dialog_Start()

		elif direction == "Right":
			body.faceleft()
			body.Dialog_Start()

		elif direction == "Up":
			body.facedown()
			body.Dialog_Start()

		elif direction == "Down":
			body.faceup()
			body.Dialog_Start()


func Hurt(dmg):
	PlayerStats.Stats.CurrentHealth -= dmg
	#$Hurt.play()
	print(PlayerStats.Stats.CurrentHealth)
