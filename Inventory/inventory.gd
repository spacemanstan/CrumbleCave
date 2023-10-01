extends Control

var inventory: InventoryData
var hbox: HBoxContainer

func _ready():
	hbox = $CenterContainer/HBoxContainer
	inventory = preload("res://Inventory/inventory.tres")
	populate_inventory()

func populate_inventory():
	# Clear the existing items first
	for child in hbox.get_children():
		hbox.remove_child(child)
		child.queue_free()
	
	for item_data in inventory.item_datas:
		add_item_to_inventory(item_data)

func add_item_to_inventory(item_data: ItemData):
	var item_display = TextureRect.new()
	item_display.texture = item_data.texture
	hbox.add_child(item_display)

func remove_item_from_inventory(item_data: ItemData):
	for child in hbox.get_children():
		if child.texture == item_data.texture:
			hbox.remove_child(child)
			child.queue_free()
			break  # remove this line if you want to remove all instances of the item


