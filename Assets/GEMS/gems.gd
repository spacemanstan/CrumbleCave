extends Node3D

func _ready():
	#default to gem a on spawn
	chooseGem("a")

func chooseGem(choice):
	$gem_a.hide()
	$gem_b.hide()
	$gem_c.hide()
	$gem_d.hide()
	match choice:
		"a":
			name = "Gem A"
			$gem_a.show()
		"b":
			name = "Gem B"
			$gem_b.show()
		"c":
			name = "Gem C"
			$gem_c.show()
		"d":
			name = "Gem D"
			$gem_d.show()
