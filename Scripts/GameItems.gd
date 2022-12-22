extends Node

onready var HealthPotion = preload("res://Textures/UI/Icons/BottleRed.png")
onready var Cake = preload("res://Textures/UI/Icons/Cake.png")


onready var Sword = preload("res://Textures/UI/Icons/Sword1.png")
onready var Scimitar = preload("res://Textures/UI/Icons/Sword2.png")
onready var Helmet = preload("res://Textures/UI/Icons/SteelHelmet1.png")

var loading: bool = false
var my_index: int = 0

var SAVE_PATH = "user://InventoryConsumables.bin"
var config_file = ConfigFile.new()

var SAVE_PATH_INV = "user://InventoryEquippables.bin"
var Equip_Index: int = 0
var Equipment_Loading: bool = false

var Inventory = {
	"Currency": {
		"Gold": 0
	},
	"Consumables": {
		"Inventory": []
	},
	"Equipment": {
		"Inventory": [],
		"Name": []
	}
}

var Equippables = {
	"Armour": {
		"Helmet": ["Helmet", "Steel Helmet"],
		"Body": [],
		"Boots": []
	},
	"WeaponType": {
		"Sword": ["Sword", "Scimitar"]
	},
	"Equipped": {
		"Helmet": [],
		"Body": [],
		"Boots": [],
		"Weapon": []
	}
}


func Save_Consumables():
	for section in Inventory.keys():
		for key in Inventory[section]:
			config_file.set_value(section, key, Inventory[section][key])
	config_file.save_encrypted_pass(SAVE_PATH, "Teaching is Great")
#	OS.shell_open(OS.get_user_data_dir())

func Load_Consumables():
	var error = config_file.load_encrypted_pass(SAVE_PATH, "Teaching is Great")
	if error != OK:
		print("Failed loading settings Error code: 32")
		return null
	
	for section in Inventory.keys():
		for key in Inventory[section]:
			Inventory[section][key] = config_file.get_value(section, key, null)


func Save_Equippables():
	for section in Equippables.keys():
		for key in Equippables[section]:
			config_file.set_value(section, key, Equippables[section][key])
	config_file.save_encrypted_pass(SAVE_PATH_INV, "Teaching is Great")
#	OS.shell_open(OS.get_user_data_dir())

func Load_Equippables():
	var error = config_file.load_encrypted_pass(SAVE_PATH_INV, "Teaching is Great")
	if error != OK:
		print("Failed loading settings Error code: 32")
		return null
	
	for section in Equippables.keys():
		for key in Equippables[section]:
			Equippables[section][key] = config_file.get_value(section, key, null)
