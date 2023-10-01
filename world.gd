extends Node

signal Game_Start
signal Game_Over

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("FPS: ", Engine.get_frames_per_second())
	pass

func _on_start_game_pressed():
	Game_Start.emit()
	pass # Replace with function body.

func _on_game_start():
	print("STARTIN THE GAME")
	pass # Replace with function body.

func _on_game_over():
	print("DA GAME BE ENDIN")
	
func _on_player_player_died():
	Game_Over.emit()


