extends KinematicBody2D

var Health = SlimerStats.Health
var Speed =  SlimerStats.Speed
var Velocity = Vector2.ZERO
var Follow = false

onready var obj = get_parent().get_node("Player") 


func _ready():
	add_to_group("Enemy")

func _process(delta):
	FollowPlayer()
	animate()
	move_and_slide(Velocity)

func hurt(dmg):
	if Health > 0:
		Health -= dmg
	if Health <= 0:
		PlayerStats.Stats.CurrentExperience += 20
		QM.Quests.Marissa.MarissaQuest = true
		self.queue_free()
	print(str(Health))

func animate():
	if Velocity.x > 0:
		$AnimatedSprite.flip_h = true
	if Velocity.x < 0:
		$AnimatedSprite.flip_h = false

func FollowPlayer():
	if Follow == true:
		Velocity = position.direction_to(obj.position) * Speed


func _on_Detection_body_entered(body):
	# check if body is our player
	if body.name == "Player":
	# set follow to true
		Follow = true


func _on_Damage_body_entered(body):
	if body.name == "Player":
		var calc = ((SlimerStats.Attack - PlayerStats.Stats.Defense) + 5 ) * 2
		if calc > 0:
			body.Hurt(calc)
		else:
			body.Hurt(1)
