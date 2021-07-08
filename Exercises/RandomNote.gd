extends "res://Exercises/Exercise.gd"

var last_note : int = -1
var pitch_range : Array

func _init(controller):
	ExerciseController = controller
	pitch_range = ExerciseController.pitch_range
	next_step()

################################################################################

func _delete_current_notes():
	ExerciseController.kill_all_notes()

# generates a random pitch value, different from the last
func _spawn_random_note():
	var pitch = last_note
	while pitch == last_note:
		pitch = randi() % (pitch_range[1] - pitch_range[0]) + pitch_range[0]
	ExerciseController.add_note(pitch)
	last_note = pitch

func next_step():
#	_delete_current_notes()
	_spawn_random_note()
