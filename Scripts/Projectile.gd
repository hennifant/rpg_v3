extends Node2D

var motion = Vector2(0, 500)

func _process(delta):
	translate(motion * delta)

func _on_Timer_timeout():
	self.queue_free()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		pass
	if body.is_in_group("Enemy"):
		var calc = ((PlayerStats.Stats.MagicAttack - SlimerStats.MagicDefense) + 5 ) * 2
		if calc > 0:
			body.hurt(calc)
			self.queue_free()
		else:
			body.hurt(1)
			self.queue_free()
	else:
		self.queue_free()
