extends Node

var Stats = {
	Level = 1,
	CurrentHealth = 40,
	MaxHealth = 100,
	CurrentMana = 120,
	MaxMana = 120,
	CurrentExperience = 10,
	MaxExperience = 300,

	Attack = 20,
	Defense = 10,
	Speed = 30,
	MagicAttack = 10,
	MagicDefense = 5,
	Willpower = 20,
	Luck = 30,
	Accuracy = 15,
}

#var Stats = {
#	"Player":{
#		"Level": [1],
#		"CurrentHealth": [10],
#		"MaxHealth":[100],
#		"CurrentMana": [120],
#		"MaxMana": [120],
#		"CurrentExperience": [0],
#		"MaxExperience": [300],
#		"Attack": [20],
#		"Defense": [10],
#		"Speed": [30],
#		"MagicAttack": [10],
#		"MagicDefense": [5],
#		"Willpower": [20],
#		"Luck": [30],
#		"Accuracy": [15],
#	}
#}

var levelingup:bool = false

var SAVE_PATH = "user://Stats.bin"
var config_file = ConfigFile.new()
#func _process(delta):
#	Level_Up()
#	xp_check()

func Level_Up():
	if Stats.CurrentExperience >= Stats.MaxExperience:
		levelingup = true
		if Stats.Level <= 10:
			Stats.Level += 1
			Stats.MaxHealth += 5
			Stats.MaxMana += 10
			Stats.MaxExperience += 50
			Stats.CurrentExperience -= Stats.MaxExperience
			Stats.CurrentHealth = Stats.MaxHealth
			
			Stats.Attack += 3
			Stats.Defense += 2
			Stats.Speedt += 3
			Stats.MagicAttack += 2
			Stats.MagicDefense += 1
			Stats.Willpower += 1
			Stats.Luck += 2
			Stats.Accuracy += 2
			print(Stats)
		elif Stats.Level <= 20 and Stats.Level > 10:
			Stats.Level += 1
			Stats.MaxHealth += 6
			Stats.MaxMana += 10
			Stats.CurrentExperience -= Stats.MaxExperience
			Stats.MaxExperience += 100
			Stats.CurrentHealth = Stats.MaxHealth
			
			Stats.Attack += 3
			Stats.Defense += 2
			Stats.Speedt += 3
			Stats.MagicAttack += 2
			Stats.MagicDefense += 1
			Stats.Willpower += 1
			Stats.Luck += 2
			Stats.Accuracy += 2
			
		elif Stats.Level <= 30 and Stats.Level > 20:
			Stats.Level += 1
			Stats.MaxHealth += 7
			Stats.MaxMana += 10
			Stats.CurrentExperience -= Stats.MaxExperience
			Stats.MaxExperience += 150
			Stats.CurrentHealth = Stats.MaxHealth
			
			Stats.Attack += 3
			Stats.Defense += 2
			Stats.Speedt += 3
			Stats.MagicAttack += 2
			Stats.MagicDefense += 1
			Stats.Willpower += 1
			Stats.Luck += 2
			Stats.Accuracy += 2
			
		elif Stats.Level <= 40 and Stats.Level > 30:
			Stats.Level += 1
			Stats.MaxHealth += 8
			Stats.MaxMana += 10
			Stats.CurrentExperience -= Stats.MaxExperience
			Stats.MaxExperience += 200
			Stats.CurrentHealth = Stats.MaxHealth
			
			Stats.Attack += 3
			Stats.Defense += 2
			Stats.Speedt += 3
			Stats.MagicAttack += 2
			Stats.MagicDefense += 1
			Stats.Willpower += 1
			Stats.Luck += 2
			Stats.Accuracy += 2
			
		elif Stats.Level <= 50 and Stats.Level > 40:
			Stats.Level += 1
			Stats.MaxHealth += 9
			Stats.MaxMana += 10
			Stats.CurrentExperience -= Stats.MaxExperience
			Stats.MaxExperience += 250
			Stats.CurrentHealth = Stats.MaxHealth
			
			Stats.Attack += 3
			Stats.Defense += 2
			Stats.Speedt += 3
			Stats.MagicAttack += 2
			Stats.MagicDefense += 1
			Stats.Willpower += 1
			Stats.Luck += 2
			Stats.Accuracy += 2
			
		elif Stats.Level > 50:
			Stats.Level += 1
			Stats.MaxHealth += 10
			Stats.MaxMana += 10
			Stats.CurrentExperience -= Stats.MaxExperience
			Stats.MaxExperience += 300
			Stats.CurrentHealth = Stats.MaxHealth
			
			Stats.Attack += 3
			Stats.Defense += 2
			Stats.Speedt += 3
			Stats.MagicAttack += 2
			Stats.MagicDefense += 1
			Stats.Willpower += 1
			Stats.Luck += 2
			Stats.Accuracy += 2
			
func xp_check():
	if Stats.CurrentExperience < 0:
		Stats.CurrentExperience = 0

