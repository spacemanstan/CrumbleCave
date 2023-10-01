extends Control

var inventory: Array[ItemData]
var hbox: HBoxContainer

func _ready():
	hbox = $CenterContainer/HBoxContainer
	populate_inventory()

func populate_inventory():
	# Clear the existing items first
	clear_inventory()
	for item_data in inventory:
		add_item_to_inventory(item_data)

func add_item_to_inventory(item_data: ItemData):
	inventory.append(item_data)  # Add to inventory list
	var item_display = TextureRect.new()
	item_display.texture = item_data.texture
	hbox.add_child(item_display)

# clears the whole inventory
func clear_inventory():
	inventory.clear()
	for child in hbox.get_children():
		hbox.remove_child(child)
		child.queue_free()
	
# on reciept of red_gem_collected create an ItemData and push into inventory array
func _on_gems_red_gem_collected(body):
	var item = ItemData.new()
	item.name = body.name
	var placeholder = PlaceholderTexture2D.new()
	placeholder.set_size(Vector2(65,150))
	item.texture = placeholder
	add_item_to_inventory(item)
	print("PLAYER COLLECTED ", body.gemName)

func _on_world_game_over():
	clear_inventory()

func _on_world_game_start():
	clear_inventory()
