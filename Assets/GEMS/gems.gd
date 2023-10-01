extends Node3D

var gemName = "undefined"
var weight = 0

func _process(delta):
	rotate_y(0.5 * delta)

func chooseGem(choice):
	$gem_a.hide()
	$gem_b.hide()
	$gem_c.hide()
	$gem_d.hide()
	match choice:
		"a":
			$OmniLight3D.omni_range = 2.
			gemName = "Gem A"
			weight = 2
			$gem_a.show()
		"b":
			$OmniLight3D.omni_range = 2.5
			gemName = "Gem B"
			weight = 4
			$gem_b.show()
		"c":
			$OmniLight3D.omni_range = 3.
			gemName = "Gem C"
			weight = 6
			$gem_c.show()
		"d":
			$OmniLight3D.omni_range = 4.
			gemName = "Gem D"
			weight = 8
			$gem_d.show()
