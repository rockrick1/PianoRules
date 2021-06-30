extends Control

onready var NoteMapping = load("res://Scripts/NoteMapping.gd")
onready var BaseExercise = load("res://Exercises/Exercise.gd")
onready var Note = load("res://Objects/Note.tscn")

var tone_offset : float

var current_ex

func _ready():
	tone_offset = $VSplitContainer/TextureRect/Anchor77.position.y - $VSplitContainer/TextureRect/Anchor60.position.y
	tone_offset /= 10
	print(tone_offset)
	load_exercise("RandomNote")

func load_exercise(ex_name):
	print("loading exercise " + ex_name)
	var exercise_script = load("res://Exercises/" + ex_name + ".gd")
	current_ex = exercise_script.new(self)

func get_note_position_by_pitch(pitch) -> Vector2:
	var note_str = NoteMapping.get_map()[pitch]
	var octave = int(note_str[0])
	var full_note = note_str.substr(1)
	var note = note_str[1]
	print(octave, " ",note, " ", full_note)
	var note_offset = NoteMapping.get_offsets()[note]
	
	var octave_offset = tone_offset * 7
	
	var dist = (note_offset * tone_offset) + ((octave - 6) * octave_offset)
	var pos = $VSplitContainer/TextureRect/Anchor60.position + Vector2((note_offset % 2) * -50, dist)
	return pos

func add_note(pitch):
	# pitch 60 = 6C
	var note = Note.instance()
	note.position = get_note_position_by_pitch(pitch)
	$VSplitContainer/TextureRect/Notes.add_child(note)
	print("add note in pitch "+str(pitch))

func exercise_next_step():
	pass


func _on_Button_pressed():
	current_ex._spawn_random_note()
