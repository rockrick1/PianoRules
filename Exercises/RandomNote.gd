extends "res://Exercises/Exercise.gd"

const pitch_range = [36,96] # change this to dynamic later

func _init(controller):
	ExerciseController = controller

################################################################################

func _spawn_random_note():
	var pitch = randi() % (pitch_range[1] - pitch_range[0]) + pitch_range[0]
	ExerciseController.add_note(pitch)
