extends Node3D

@export var tile: PackedScene
@export var MapSize : Vector2 = Vector2(32,32)
@export_range(0,1) var MissingChance : float = 0.8
@export_group("Map Gen")
@export var MapSeedIsRandom : bool = true
@export var DefaultSeedValue : int = 0
@export var Noise_Type : FastNoiseLite.NoiseType = FastNoiseLite.TYPE_SIMPLEX_SMOOTH 
@export var Octaves : int = 4
@export var Lacunarity : float = 2
@export var Frequency : float = 0.5

var noise = FastNoiseLite.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	noise.noise_type = Noise_Type
	noise.fractal_octaves = Octaves
	noise.fractal_lacunarity = Lacunarity
	noise.frequency = Frequency
	noise.seed = DefaultSeedValue
	generateTileMap(Vector2(0,0))

func getGroundHeight(x, z):
	return noise.get_noise_2d(x,z) + 1

func clearTileMap():
	for child in get_children():
		child.queue_free()

# Makes sure that There is a tile at Spawn Pos
func generateTileMap(SpawnPos):
	if(MapSeedIsRandom):
		noise.seed = randi()
		
	for x in range(MapSize.x/2-MapSize.x,MapSize.x/2):
		for z in range (MapSize.y/2-MapSize.x,MapSize.y/2):
			var y = -0.01
			if(Vector2(x,z) == SpawnPos || randf() <= MissingChance):
				y = getGroundHeight(x, z)
				
			var nt = tile.instantiate()
			nt.position = Vector3(x,y,z)
			add_child(nt)
			#nt.set_owner(get_tree().edited_scene_root)


func _on_world_game_start():
	clearTileMap()
	generateTileMap(Vector2(0,0))
