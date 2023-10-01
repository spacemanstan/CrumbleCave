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
			$OmniLight3D.omni_range = 2.
			gemName = "Gem A"
			$gem_a.show()
		"b":
			$OmniLight3D.omni_range = 2.5
			gemName = "Gem B"
			$gem_b.show()
		"c":
			$OmniLight3D.omni_range = 3.
			gemName = "Gem C"
			$gem_c.show()
		"d":
			$OmniLight3D.omni_range = 4.
			gemName = "Gem D"
			$gem_d.show()
