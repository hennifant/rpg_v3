extends StaticBody2D

var direction:int = 0

var dialog = ["[color=yellow]Marissa[/color] \n Ich bin so trocken. Kannst du mir Schleim von [color=aqua]Slimer[/color] bringen?"]
var quest_dialog = ["[color=yellow]Marissa[/color] \n Hast du meinen [color=aqua]Schmierstoff[/color] schon?"]
var comp_dialog = ["[color=yellow]Marissa[/color] \n Vielen Dank, hier hast du etwas für dein Bewusstsein"]

var quest_given: bool = false
var quest_name: String = "Ungeschmiert"
var quest_des: String = "Ziehe los und besorge Schleim für Marissa, damit die Party steigen kann.."

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
	if quest_given == false:
		ND.NPCDialog = dialog
		get_tree().call_group("GUI_Dialog", "reset")
		QM.Quests.ActiveQuests.append(quest_name)
		QM.Quests.QuestDescription.append(quest_des)
		get_tree().call_group("Quest", "add_quest")
		quest_given = true
		
	elif quest_given == true and QM.Quests.Marissa.MarissaQuest == false:
		ND.NPCDialog = quest_dialog
		get_tree().call_group("GUI_Dialog", "reset")
	
	elif quest_given == true and QM.Quests.Marissa.MarissaQuest == true and QM.Quests.Marissa.MarissaClaimed == false:
		ND.NPCDialog = comp_dialog
		get_tree().call_group("GUI_Dialog", "reset")
		get_tree().call_group("Quest", "remove_quest", quest_name, quest_des)
		QM.Quests.Marissa.MarissaClaimed = true
		PlayerStats.Stats.CurrentExperience + 300
	#	get_tree().call_group("Inventory", "add_item", item.HealthPotion)

	
	elif QM.Quests.Marissa.MarissaClaimed == true:
		ND.NPCDialog = comp_dialog
		get_tree().call_group("GUI_Dialog", "reset")
