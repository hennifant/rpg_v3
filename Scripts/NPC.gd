extends StaticBody2D

var direction:int = 0

var dialog = ["[color=yellow]Martha[/color] \n I'm scared! Can you kill that scary [color=aqua]Bat[/color] over there?"]
#var quest_dialog = ["[color=yellow]Martha[/color] \n Have you killed the [color=aqua]Bat[/color] yet?"]
#var comp_dialog = ["[color=yellow]Martha[/color] \n Thank you for helping me, here is a potion for your trouble."]

#var quest_given: bool = false
#var quest_name: String = "Vampire Delight"
#var quest_des: String = "Set forth to the forest and kill the bat that is terrorizing Martha and return."

func _ready():
	self.add_to_group("NPC")

func _process(delta):
	$AnimatedSprite.frame = direction


func facedown():
	direction = 0
func faceup():
	direction = 1
func faceleft():
	direction = 2
func faceright():
	direction = 3

func Dialog_Start():
	#if quest_given == false:
		ND.NPCDialog = dialog
		get_tree().call_group("GUI_Dialog", "reset")
#		QM.Quests.ActiveQuests.append(quest_name)
	#	QM.Quests.QuestDescription.append(quest_des)
		get_tree().call_group("Quest", "add_quest")
#		quest_given = true
		
	#elif quest_given == true and QM.Quests.Martha.MarthaQuest == false:
	#	ND.NPCDialog = quest_dialog
		get_tree().call_group("GUI_Dialog", "reset")
	
	#elif quest_given == true and QM.Quests.Martha.MarthaQuest == true and QM.Quests.Martha.MarthaClaimed == false:
	#	ND.NPCDialog = comp_dialog
		get_tree().call_group("GUI_Dialog", "reset")
	#	get_tree().call_group("Quest", "remove_quest", quest_name, quest_des)
	#	QM.Quests.Martha.MarthaClaimed = true
	#	PlayerStats.Stats.CurrentExperience + 300
	#	get_tree().call_group("Inventory", "add_item", item.HealthPotion)

	
	#elif QM.Quests.Martha.MarthaClaimed == true:
	#	ND.NPCDialog = comp_dialog
		get_tree().call_group("GUI_Dialog", "reset")
