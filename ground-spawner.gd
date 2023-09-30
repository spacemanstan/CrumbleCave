extends Node3D

@export var tile: PackedScene
@export var MapSize : Vector2 = Vector2(32,32)
@export_group("Map Gen")
@export var mapSeedIsRandom : bool = false
@export var Noise_Type : FastNoiseLite.NoiseType = FastNoiseLite.TYPE_SIMPLEX_SMOOTH 
@export var Octaves : int = 4
@export var Lacunarity : float = 2
@export var Frequency : float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(MapSize.x/2-MapSize.x,MapSize.x/2):
		for z in range (MapSize.y/2-MapSize.x,MapSize.y/2):
			var nt = tile.instantiate()
			var y = getGroundHeight(x, z)
			nt.position = Vector3(x,y,z)
			add_child(nt)
			nt.set_owner(get_tree().edited_scene_root)

func getGroundHeight(x, z):
	var noise = FastNoiseLite.new()
	noise.noise_type = Noise_Type
	noise.fractal_octaves = Octaves
	noise.fractal_lacunarity = Lacunarity
	noise.frequency = Frequency
	noise.seed = 0
	if(mapSeedIsRandom):
		noise.seed = randi()
	return noise.get_noise_2d(x,z) + 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
