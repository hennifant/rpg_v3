extends Control

func _process(delta):
	# Check if pause button pressed
	if Input.is_action_just_released("Pause"):
	# if so pause the tree
		get_tree().paused = not get_tree().paused
	# change visibility of pause menu
		self.visible = get_tree().paused

func _on_Resume_pressed():
	get_tree().paused = false
	self.visible = false

func _on_Exit_pressed():
	get_tree().quit()

func _on_Quests_pressed():
	get_parent().get_node("QuestLog").visible = true

func _on_Inventory_pressed():
	get_parent().get_node("Inventory").show()

func _on_Options_pressed():
	get_parent().get_node("Settings").show()
