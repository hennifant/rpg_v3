extends Control

var dialog: Array = ["test"]
var page: int = 0


var finished: bool = false
var talking: bool = false

onready var DialogText = $DialogText
onready var DialogBG = $TextureRect

func _ready():
	DialogText.visible = false
	DialogBG.visible = false
	add_to_group("GUI_Dialog")
	DialogText.bbcode_text = dialog[page]

func _process(delta):
	checklength()
	arrow()


func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		if page < dialog.size() - 1:
			page += 1
			DialogText.visible_characters = 0
			finished = false
			DialogText.bbcode_text = dialog[page]
		else:
			DialogText.visible = false
			DialogBG.visible = false
			finished = false

func checklength():
	if talking == true:
		if DialogText.visible_characters == DialogText.get_total_character_count():
			finished = true

func arrow():
	$Arrow.visible = finished
	$AnimationPlayer.play("ArrowBounce")


func reset():
	dialog = ND.NPCDialog
	page = 0
	DialogText.visible_characters = 0
	DialogText.visible = true
	DialogBG.visible = true
	finished = false
	talking = true
	DialogText.bbcode_text = dialog[page]


func _on_CharacterTimer_timeout():
	DialogText.visible_characters += 1
