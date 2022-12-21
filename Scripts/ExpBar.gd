extends Control

onready var exp_bar = $ExpBar
onready var XP = $XP

func _ready():
	exp_bar.value = PlayerStats.Stats.CurrentExperience
	_on_max_exp_updated()

func _process(delta):
	_on_exp_updated(PlayerStats.Stats.CurrentExperience)

func _on_exp_updated(experience):
	exp_bar.value = PlayerStats.Stats.CurrentExperience
	XP.text = str(PlayerStats.Stats.CurrentExperience) + " EXP"

func _on_max_exp_updated():
	exp_bar.max_value = PlayerStats.Stats.MaxExperience
