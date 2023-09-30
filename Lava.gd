extends Node3D

@export var riseRate : float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += riseRate * delta
	pass


func _on_world_game_start():
	set_process(true)
	pass # Replace with function body.



func _on_world_game_over():
	position.y = 0
	set_process(false)
	pass # Replace with function body.
