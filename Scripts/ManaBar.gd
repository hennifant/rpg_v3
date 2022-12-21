extends Control

onready var Mana_bar = $ManaBar
onready var update_tween = $Tween

onready var Mana_Tween = $ManaBarUnder
onready var MP = $MP


func _ready():
	Mana_bar.value = PlayerStats.Stats.CurrentMana
	_on_max_mana_updated()

func _process(delta):
	_on_mana_updated(PlayerStats.Stats.CurrentMana)

func _on_mana_updated(mana):
	Mana_bar.value = PlayerStats.Stats.CurrentMana
	MP.text = str(PlayerStats.Stats.CurrentMana) + " MP/" + str(PlayerStats.Stats.MaxMana) + " MP"
	update_tween.interpolate_property(Mana_Tween, "value", Mana_Tween.value, mana, 0.05, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()

func _on_max_mana_updated():
	Mana_bar.max_value = PlayerStats.Stats.MaxMana
	Mana_Tween.max_value = PlayerStats.Stats.MaxMana
