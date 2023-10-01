extends Node3D


@export var stone_D : PackedScene
@export var stone_E : PackedScene
@export var stone_F : PackedScene
@export var MapSize : Vector2 = Vector2(32,32)
@export_range(0,1) var MissingChance : float = 0.8
@export_group("Map Gen")
@export var MapSeedIsRandom : bool = true
@export var DefaultSeedValue : int = 0
@export var Noise_Type : FastNoiseLite.NoiseType = FastNoiseLite.TYPE_SIMPLEX_SMOOTH 
@export var Octaves : int = 4
@export var Lacunarity : float = 2
@export var Frequency : float = 0.5
@export_category("Gems")
@export var Gem : PackedScene
@export var numberOfGems : int = 6

var noise = FastNoiseLite.new()
var gems = []
# Called when the node enters the scene tree for the first time.
func _ready():
	noise.noise_type = Noise_Type
	noise.fractal_octaves = Octaves
	noise.fractal_lacunarity = Lacunarity
	noise.frequency = Frequency
	noise.seed = DefaultSeedValue
	generateTileMap(Vector2(0,0))
	generateGems(numberOfGems)

func getGroundHeight(x, z):
	return noise.get_noise_2d(x,z) + 1

func clearChildren():
	for child in get_children():
		child.queue_free()

# Makes sure that There is a tile at Spawn Pos
func generateTileMap(SpawnPos):
	var tiles = [stone_D, stone_E, stone_F]
	if(MapSeedIsRandom):
		noise.seed = randi()
		
	for x in range(MapSize.x/2-MapSize.x,MapSize.x/2):
		for z in range (MapSize.y/2-MapSize.y,MapSize.y/2):
			var y = -0.01
			if(Vector2(x,z) == SpawnPos || randf() <= MissingChance):
				y = getGroundHeight(x, z)
			y -= 1
			var nt = tiles[randi_range(0,2)].instantiate()
			nt.position = Vector3(x,y,z)
			nt.rotate_y(randi_range(0,3) * PI/2)
			add_child(nt)
			#nt.set_owner(get_tree().edited_scene_root)

func randomizeGem(gem):
	gem.position = Vector3(
			randi_range(MapSize.x/2-MapSize.x,MapSize.x/2), 
			2, 
			randi_range(MapSize.y/2-MapSize.y,MapSize.y/2)
		)
	gem.chooseGem(["a","b","c","d"].pick_random())

func generateGems(numGems):
	for i in range(numGems):
		var ng = Gem.instantiate()
		randomizeGem(ng)
		add_child(ng)
		

func _on_world_game_start():
	clearChildren()
	generateGems(numberOfGems)
	generateTileMap(Vector2(0,0))


func _on_player_collided_with_gem(gem):
	randomizeGem(gem)
	
