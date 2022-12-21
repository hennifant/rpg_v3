extends CanvasLayer

onready var GameOver = preload("res://Util/Resources/GameOver.tscn").instance()

func _process(delta):
	GameOver()
	if Input.is_action_just_released("quest_hide"):
		$QuestLog.visible = !$QuestLog.visible
	#if Input.is_action_just_released("Inventory"):
	#	$Inventory.visible = not $Inventory.visible

func GameOver():
	if PlayerStats.Stats.CurrentHealth <= 0:
		get_tree().paused = true
		self.add_child(GameOver)
