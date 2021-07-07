extends Control

onready var NoteMapping = load("res://Scripts/NoteMapping.gd")
onready var BaseExercise = load("res://Exercises/Exercise.gd")
onready var Note = load("res://Objects/Note.tscn")

onready var InputReader : Node
onready var NoteGroup : Node
onready var OptionsPanel : Node
onready var Assist : Node
onready var HardAssist : Node

var note_range_open : bool = false

var assist_mode : bool = false
var hard_assist_mode : bool = false
var pitch_range = [60,90]
var any_octave : bool = false

var combo : int = 0

var tone_offset : float

var current_ex

func _ready():
	# generate a new random seed
	randomize()
	
	# input reading scene
	InputReader = $InputReader
	
	# parent node for all the notes on screen
	NoteGroup = $MarginContainer/VSplitContainer/MarginContainer/TextureRect/Notes
	
	# options panel, with many settings
	OptionsPanel = $MarginContainer/VSplitContainer/OptionsPanel
	
	# Assist nodes
	Assist = $MarginContainer/VSplitContainer/MarginContainer/TextureRect/Assist
	HardAssist = $MarginContainer/VSplitContainer/MarginContainer/TextureRect/HardAssist
	Assist.visible = false
	HardAssist.visible = false
	
	$MarginContainer/VSplitContainer/OptionsPanel.EC = self
	
	tone_offset = $MarginContainer/VSplitContainer/MarginContainer/TextureRect/Anchor77.position.y - $MarginContainer/VSplitContainer/MarginContainer/TextureRect/Anchor60.position.y
	tone_offset /= 10
	
	print(tone_offset)
	load_exercise("RandomNote")

func _process(_delta):
	# process note hits from input
	for note in NoteGroup.get_children():
		for pitch in get_just_pressed_keys():
			var note_str = NoteMapping.get_map()[note.pitch]
			var input_note_str = NoteMapping.get_map()[pitch]
			# hit!
			if note.pitch == pitch or (any_octave && note_str.substr(1) == input_note_str.substr(1)):
				print("you got it bro!")
				_set_combo(combo + 1)
				current_ex.next_step()
			# wrong note pressed :(
			else:
				print("man, u suck...")
				_set_combo(0)
				break
	InputReader.just_pressed.clear()
	InputReader.just_released.clear()

func load_exercise(ex_name):
	print(">>>loading exercise: " + ex_name)
	var exercise_script = load("res://Exercises/" + ex_name + ".gd")
	current_ex = exercise_script.new(self)

func get_note_position_by_name(note_str) -> Vector2:
	var octave = int(note_str[0])
	var full_note = note_str.substr(1)
	var note = note_str[1]
	var note_offset = NoteMapping.get_offsets()[note]
	var octave_offset = tone_offset * 7
	var dist = (note_offset * tone_offset) + ((octave - 6) * octave_offset)
	var pos = $MarginContainer/VSplitContainer/MarginContainer/TextureRect/Anchor60.position + Vector2(((note_offset + octave) % 2) * -50, dist)
	return pos

func add_note(pitch):
	# pitch 60 = 6C
	var note = Note.instance()
	var note_str = NoteMapping.get_map()[pitch]
	note.position = get_note_position_by_name(note_str)
	note.pitch = pitch
	note.note_str = note_str
	var full_note = note_str.substr(1)
	if "#" in full_note:
		note.sharp()
	elif "b" in full_note:
		note.flat()
	$MarginContainer/VSplitContainer/MarginContainer/TextureRect/Notes.add_child(note)
	print("add note in pitch "+str(pitch))

# murders all notes on screen
func kill_all_notes():
	for note in NoteGroup.get_children():
		note.queue_free()

func get_pressed_keys():
	return InputReader.currently_pressed.keys()

func get_just_pressed_keys():
	return InputReader.just_pressed.keys()

func get_just_released_keys():
	return InputReader.just_released.keys()

func is_key_pressed(pitch):
	return InputReader.currently_pressed.has(pitch)

func is_key_just_pressed(pitch):
	return InputReader.just_pressed.has(pitch)

func is_key_just_released(pitch):
	return InputReader.just_released.has(pitch)


func _on_NextStep_pressed():
	current_ex.next_step()


func _on_Configs_pressed():
	OptionsPanel.visible = not OptionsPanel.visible
#	$OptionsPanel.popup()

func _set_combo(combo):
	self.combo = combo
	$MarginContainer/VSplitContainer/Combo.set_text("Combo: "+str(combo))

################################################################################
# Options panel functions #
