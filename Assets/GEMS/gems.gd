extends Node3D

var gemName = "undefined"

func _process(delta):
	rotate_y(0.5 * delta)

func chooseGem(choice):
	$gem_a.hide()
	$gem_b.hide()
	$gem_c.hide()
	$gem_d.hide()
	match choice:
		"a":
			gemName = "Gem A"
			$gem_a.show()
		"b":
			gemName = "Gem B"
			$gem_b.show()
		"c":
			gemName = "Gem C"
			$gem_c.show()
		"d":
			gemName = "Gem D"
			$gem_d.show()
