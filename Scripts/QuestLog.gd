extends Control

var quest_act: int = 0

func _ready():
	self.add_to_group("Quest")
	$QuestList.set_allow_reselect(true)
	add_quest()


func add_quest():
	var quest_icon = preload("res://Textures/UI/Icons/Day.png")
	if quest_act < QM.Quests.ActiveQuests.size():
		$QuestList.add_item(QM.Quests.ActiveQuests[quest_act], quest_icon)
		quest_act += 1
	else:
		return


func remove_quest(quest, quest_des):
	if quest in QM.Quests.ActiveQuests:
		var removed_quest = QM.Quests.ActiveQuests.find(quest)
		$QuestList.remove_item(removed_quest)
		QM.Quests.ActiveQuests.erase(quest)
		QM.Quests.QuestDescription.erase(quest_des)
		$QuestDescription.text = ""
		quest_act -= 1


func _on_QuestList_item_selected(index):
	$QuestDescription.text = QM.Quests.QuestDescription[index]


func _on_Exit_pressed():
	self.visible = false
