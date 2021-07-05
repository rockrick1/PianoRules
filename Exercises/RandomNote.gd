extends "res://Exercises/Exercise.gd"

const pitch_range = [36,96] # change this to dynamic later

var last_note : int = -1

func _init(controller):
	ExerciseController = controller
	next_step()

################################################################################

func _delete_current_notes():
	ExerciseController.kill_all_notes()

func _spawn_random_note():
	var pitch = last_note
	while pitch == last_note:
		pitch = randi() % (pitch_range[1] - pitch_range[0]) + pitch_range[0]
	ExerciseController.add_note(pitch)

func next_step():
	_delete_current_notes()
	_spawn_random_note()
