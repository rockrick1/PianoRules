extends "res://Exercises/Exercise.gd"

var NoteMapping

var last_note : int = -1
var pitch_range : Array

func _init(controller):
	ExerciseController = controller
	NoteMapping = load("res://Scripts/NoteMapping.gd")
	pitch_range = ExerciseController.pitch_range
	next_step()

################################################################################

func _delete_current_notes():
	ExerciseController.kill_all_notes()

# generates a random pitch value, different from the last
func _spawn_random_note():
	var pitch = last_note
	var note_str
	if pitch > - 1:
		note_str = NoteMapping.get_map()[pitch]
	# if accidentals are disabled, keep generating a new note until it doesn't
	# have one
	while pitch == last_note or ((not ExerciseController.accidentals) and ("#" in note_str or "b" in note_str)):
		pitch = randi() % (pitch_range[1] - pitch_range[0]) + pitch_range[0]
		note_str = NoteMapping.get_map()[pitch]
	ExerciseController.add_note(pitch)
	last_note = pitch

func next_step():
#	_delete_current_notes()
	_spawn_random_note()
