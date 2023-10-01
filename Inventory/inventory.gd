extends Control

var inventory: Array[ItemData]
var hbox: HBoxContainer
var focused_index: int = -1  # The index of the focused item in the HBoxContainer
var total_weight = 0
var score = 0

func _ready():
	hbox = $CenterContainer/HBoxContainer
	populate_inventory()

func _process(delta):
	#TODO add inventory max quantity
	if Input.is_action_just_pressed("ui_scroll_left"):
		if focused_index > 0:  # if not the first item
			focused_index -= 1
		focus_item_at_index(focused_index)
	elif Input.is_action_just_pressed("ui_scroll_right"):
		if focused_index < hbox.get_child_count() - 1:  # if not the last item
			focused_index += 1
		focus_item_at_index(focused_index)
	elif Input.is_action_just_pressed("discard"):
		remove_item_from_inventory()
	calculate_weight_and_score()
	
# calculate the current total weight and score for the player
func calculate_weight_and_score():
	total_weight = 0
	score = 0
	for item_data in inventory:
		total_weight += item_data.weight
		score += item_data.weight * item_data.weight
	print("Total Weight:", total_weight)
	print("Score:", score)

# populate the inventory
func populate_inventory():
	clear_inventory()
	for item_data in inventory:
		add_item_to_inventory(item_data)
	# If there's only one item in the inventory, focus on it
	if hbox.get_child_count() == 1:
		focused_index = 0
		focus_item_at_index(focused_index)

func add_item_to_inventory(item_data: ItemData):
	inventory.append(item_data)
	var item_display = TextureRect.new()
	var item_highlight = ColorRect.new()
	item_highlight.set_size(Vector2(80,160))
	item_highlight.color = Color(1,1,0,1)
	item_highlight.visible = false  # Start with highlight hidden
	item_display.texture = item_data.texture
	item_display.add_child(item_highlight)
	item_highlight.z_index = -1
	item_highlight.position = Vector2(-2.5, -2.5)
	hbox.add_child(item_display)
	
	# If it's the only item in the inventory after adding, focus on it
	if hbox.get_child_count() == 1:
		focused_index = 0
		focus_item_at_index(focused_index)

func focus_item_at_index(index: int):
	for i in range(hbox.get_child_count()):
		var item_display = hbox.get_child(i)
		var highlight = item_display.get_child(0)
		highlight.visible = (i == index)  # Show highlight only if it's the focused item

func remove_item_from_inventory():
	if focused_index == -1:  # Nothing to discard
		return
	# Remove from display
	var item_display = hbox.get_child(focused_index)
	hbox.remove_child(item_display)
	item_display.queue_free()
	# Remove from inventory array
	inventory.erase(focused_index)
	# Adjust focus
	if focused_index >= hbox.get_child_count():  # If the last item was discarded, adjust focus
		focused_index = hbox.get_child_count() - 1
	if focused_index != -1:  # If there are still items left, refocus
		focus_item_at_index(focused_index)
	else:
		# If no items left, reset the focus
		unfocus_all_items()

func unfocus_all_items():
	focused_index = -1
	for i in range(hbox.get_child_count()):
		var item_display = hbox.get_child(i)
		var highlight = item_display.get_child(0)
		highlight.visible = false

func clear_inventory():
	focused_index = -1  # Reset focused item
	inventory.clear()
	for child in hbox.get_children():
		hbox.remove_child(child)
		child.queue_free()

func _on_gems_red_gem_collected(body):
	var item = ItemData.new()
	item.name = body.gemName
	item.weight = body.weight
	var placeholder = PlaceholderTexture2D.new()
	placeholder.set_size(Vector2(75,155))
	# Handle the different textures and add them to the ItemData
	# TODO: replace placeholder with proper textures for each Gem type
	match item.name:
		"Gem A":
			item.texture = placeholder
		"Gem B":
			item.texture = placeholder
		"Gem C":
			item.texture = placeholder
		"Gem D":
			item.texture = placeholder
	add_item_to_inventory(item)
	print("PLAYER COLLECTED ", body.gemName)

func _on_world_game_over():
	clear_inventory()

func _on_world_game_start():
	clear_inventory()
