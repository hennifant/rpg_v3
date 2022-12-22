extends Control

var selecteditem: String = ""


onready var UseButton = $TabContainer/Consumables/UseButton
onready var ItemsList = $TabContainer/Consumables/ItemList

#------------------------------------
# Stats

onready var StatsDisplay = $TabContainer/Equip/Stats

#------------------------------------
# Equipment

onready var EquipmentList = $TabContainer/Equip/ItemList
onready var EmptyWeapon = preload("res://Textures/UI/Equip/EmptyMelee.png")
onready var EquippedWeapon = preload("res://Textures/UI/Equip/EquippedyMelee.png")
onready var EmptyHelmet = preload("res://Textures/UI/Equip/EmptyHelmet.png")
onready var EquippedHelmet = preload("res://Textures/UI/Equip/EquippedyHelmet.png")
onready var EmptyBody = preload("res://Textures/UI/Equip/EmptyChest.png")
onready var EquippedBody = preload("res://Textures/UI/Equip/EquippedyChest.png")
onready var EmptyBoots = preload("res://Textures/UI/Equip/EmptyBoots.png")
onready var EquippedBoots = preload("res://Textures/UI/Equip/EquippedBoots.png")

var Equipmentitem
var Equippeditem: String = ""


func _ready():
	self.add_to_group("Inventory")
	item.Load_Equippables()
	item.Load_Consumables()
	item.loading = true
	item.Equipment_Loading = true
	add_equipment("Scimitar", item.Scimitar)
	add_equipment("Sword", item.Sword)
	add_equipment("Steel Helmet", item.Helmet)
	print("Equipment: " + str(item.Inventory.Equipment.Inventory))
	print("Helmet Equipped: " + str(item.Equippables.Equipped.Helmet))
	print("Weapon Equipped: " + str(item.Equippables.Equipped.Weapon))



func _process(delta):
#	goldcount()
	playerstats()
	if item.loading == true:
		yield(get_tree().create_timer(0.1),"timeout")
		Load_Icons()
	if item.Equipment_Loading == true:
		Load_Equipment()


func Load_Icons():
	if item.my_index <= item.Inventory.Consumables.Inventory.size() - 1:
		ItemsList.add_icon_item(item.Inventory.Consumables.Inventory[item.my_index])
		item.my_index += 1
	elif item.my_index > item.Inventory.Consumables.Inventory.size() - 1:
		item.loading = false


func _on_TabContainer_tab_selected(tab):
	if tab == 0:
		UseButton.visible = true


func _on_ItemList_item_selected(index):
	ItemsList.set_item_tooltip_enabled(index, true)
	if ItemsList.get_item_icon(index) == item.HealthPotion:
		ItemsList.set_item_tooltip(index, "Health Potion \n This item heals 20 hp")
		selecteditem = "Health Potion"
		
	elif ItemsList.get_item_icon(index) == item.Cake:
		ItemsList.set_item_tooltip(index, "Cake \n This is cak, it is not a lie.e")
		selecteditem = "Cake"


func _on_UseButton_pressed():
	if selecteditem == "Health Potion" and PlayerStats.Stats.CurrentHealth < PlayerStats.Stats.MaxHealth:
		PlayerStats.Stats.CurrentHealth += 20
		$Consume.play()
		if PlayerStats.Stats.CurrentHealth > PlayerStats.Stats.MaxHealth:
			PlayerStats.Stats.CurrentHealth = PlayerStats.Stats.MaxHealth
		remove_item()
	elif selecteditem == "Health Potion" and PlayerStats.Stats.CurrentHealth == PlayerStats.Stats.MaxHealth:
		print("Can't use this right now")


func add_item(icon):
	ItemsList.add_icon_item(icon)
	item.Inventory.Consumables.Inventory.append(icon)
	item.Save_Consumables()


func remove_item():
	print(item.Inventory.Consumables.Inventory)
	var itemindex = ItemsList.get_selected_items()
	var removed_item = ItemsList.get_item_icon(itemindex[0])
	ItemsList.remove_item(itemindex[0])
	
	if removed_item in item.Inventory.Consumables.Inventory:
		item.Inventory.Consumables.Inventory.erase(removed_item)
		item.Save_Consumables()
		print(item.Inventory.Consumables.Inventory)


#	------------------------------------------------------------

# Gold Tracker

func goldcount():
	$CurrencyAmount.text = str(item.Inventory.Currency.Gold)
	if item.Inventory.Currency.Gold >= 999999:
		item.Inventory.Currency.Gold = 999999


#	------------------------------------------------------------

# Player Stats


func playerstats():
	StatsDisplay.text = "Health: " + str(PlayerStats.Stats.CurrentHealth) + "/" + str(PlayerStats.Stats.MaxHealth) \
	+ "\nMana: " + str(PlayerStats.Stats.CurrentMana) + "/" + str(PlayerStats.Stats.MaxMana) \
	+ "\nExperience: " + str(PlayerStats.Stats.CurrentExperience) + "/" + str(PlayerStats.Stats.MaxExperience) \
	+ "\nAttack: " + str(PlayerStats.Stats.Attack) \
	+ "\nDefense: " + str(PlayerStats.Stats.Defense) \
	+ "\nMagic Attack: " + str(PlayerStats.Stats.MagicAttack) \
	+ "\nMagic Defense: " + str(PlayerStats.Stats.MagicDefense) \
	+ "\nSpeed: " + str(PlayerStats.Stats.Speed) \
	+ "\nLuck: " + str(PlayerStats.Stats.Luck) \
	+ "\nAccuracy: " + str(PlayerStats.Stats.Accuracy)

#	------------------------------------------------------------

# Equipment List

func add_equipment(name = "default", icon = null):
	EquipmentList.add_item(name, icon)
	item.Inventory.Equipment.Inventory.append(icon)
	item.Inventory.Equipment.Name.append(name)
	item.Save_Consumables()

func remove_equipment():
	var itemindex = EquipmentList.get_selected_items()
	var removed_item = EquipmentList.get_item_icon(itemindex[0])
	EquipmentList.remove_item(itemindex[0])
	
	if removed_item in item.Inventory.Equipment.Inventory:
		item.Inventory.Equipment.Inventory.erase(removed_item)
		item.Save_Consumables()


func _on_ItemList__Equipment_selected(index):
	if EquipmentList.get_item_icon(index) == item.Sword:
		EquipmentList.set_item_tooltip(index, "Attack +2")
		Equipmentitem = "Sword"
		print(Equipmentitem)
	
	elif EquipmentList.get_item_icon(index) == item.Scimitar:
		EquipmentList.set_item_tooltip(index, "Attack +3")
		Equipmentitem = "Scimitar"

	elif EquipmentList.get_item_icon(index) == item.Helmet:
		EquipmentList.set_item_tooltip(index, "Defense +3")
		Equipmentitem = "Steel Helmet"


func _on_EquipButton_pressed():
	if Equipmentitem in item.Equippables.WeaponType.Sword:
		if Equipmentitem == "Sword"  and item.Equippables.Equipped.Weapon.size() <= 0:
			Equippeditem = Equipmentitem
			PlayerStats.Stats.Attack += 2
			item.Equippables.Equipped.Weapon.append("Sword")
			$TabContainer/Equip/WeaponText.text = Equippeditem
			$TabContainer/Equip/Weapon.texture = EquippedWeapon
			$TabContainer/Equip/UnequipText.visible = false
			$Equip.play()
		
		elif Equipmentitem == "Scimitar"  and item.Equippables.Equipped.Weapon.size() <= 0:
			Equippeditem = Equipmentitem
			PlayerStats.Stats.Attack += 3
			item.Equippables.Equipped.Weapon.append("Scimitar")
			$TabContainer/Equip/WeaponText.text = Equippeditem
			$TabContainer/Equip/Weapon.texture = EquippedWeapon
			$TabContainer/Equip/UnequipText.visible = false
			$Equip.play()
			
		else:
			$TabContainer/Equip/UnequipText.visible = true
		
		item.Save_Equippables()
		print("Helmet Equipped: " + str(item.Equippables.Equipped.Helmet))
		print("Weapon Equipped: " + str(item.Equippables.Equipped.Weapon))
			
			
	if Equipmentitem in item.Equippables.Armour.Helmet:
		if Equipmentitem == "Steel Helmet"  and item.Equippables.Equipped.Helmet.size() <= 0:
			Equippeditem = Equipmentitem
			PlayerStats.Stats.Defense += 3
			item.Equippables.Equipped.Helmet.append(Equippeditem)
			$TabContainer/Equip/HeadText.text = Equippeditem
			$TabContainer/Equip/Head.texture = EquippedHelmet
			$TabContainer/Equip/UnequipText.visible = false
			$Equip.play()
		
		else:
			$TabContainer/Equip/UnequipText.visible = true
			
		item.Save_Equippables()
		print("Helmet Equipped: " + str(item.Equippables.Equipped.Helmet))
		print("Weapon Equipped: " + str(item.Equippables.Equipped.Weapon))


func _on_UnequipButton_pressed():
	if Equippeditem in item.Equippables.Equipped.Weapon:
		if Equippeditem == "Sword":
			Equippeditem = ""
			PlayerStats.Stats.Attack -= 2
		
		elif Equippeditem == "Scimitar":
			Equippeditem = ""
			PlayerStats.Stats.Attack -= 3
		
		$TabContainer/Equip/WeaponText.text = "Weapon"
		$TabContainer/Equip/Weapon.texture = EmptyWeapon
		item.Equippables.Equipped.Weapon.clear()
		item.Save_Equippables()
	
	if Equipmentitem in item.Equippables.Equipped.Helmet:
		if Equippeditem == "Steel Helmet":
			Equippeditem = ""
			PlayerStats.Stats.Defense -= 3
		
		$TabContainer/Equip/HeadText.text = "Head"
		$TabContainer/Equip/Head.texture = EmptyHelmet
		item.Equippables.Equipped.Helmet.clear()
		item.Save_Equippables()


func Load_Equipment():
	if item.Equip_Index <= item.Inventory.Equipment.Inventory.size() - 1:
		EquipmentList.add_item(item.Inventory.Equipment.Name[item.Equip_Index],item.Inventory.Equipment.Inventory[item.Equip_Index])
		item.Equip_Index += 1
	
	if item.Equippables.Equipped.Helmet.size() > 0:
		$TabContainer/Equip/HeadText.text = item.Equippables.Equipped.Helmet[0]
		$TabContainer/Equip/Head.texture = EquippedHelmet
	
	if item.Equippables.Equipped.Body.size() > 0:
		$TabContainer/Equip/BodyText.text = item.Equippables.Equipped.Body[0]
		$TabContainer/Equip/Body.texture = EquippedBody
		
	if item.Equippables.Equipped.Boots.size() > 0:
		$TabContainer/Equip/BootsText.text = item.Equippables.Equipped.Boots[0]
		$TabContainer/Equip/Boots.texture = EquippedBoots
		
	if item.Equippables.Equipped.Weapon.size() > 0:
		$TabContainer/Equip/WeaponText.text = item.Equippables.Equipped.Weapon[0]
		$TabContainer/Equip/Weapon.texture = EquippedWeapon
	
	elif item.Equip_Index > item.Inventory.Equipment.Inventory.size() - 1:
		item.Equipment_Loading = false


func _on_UnWeap_pressed():
	if Equippeditem == "Sword":
		Equippeditem = ""
		PlayerStats.Stats.Attack -= 2
		
	elif Equippeditem == "Scimitar":
		Equippeditem = ""
		PlayerStats.Stats.Attack -= 3
		
	$TabContainer/Equip/WeaponText.text = "Weapon"
	$TabContainer/Equip/Weapon.texture = EmptyWeapon
	item.Equippables.Equipped.Weapon.clear()
	item.Save_Equippables()


func _on_TabContainer_pre_popup_pressed():
	pass # Replace with function body.
