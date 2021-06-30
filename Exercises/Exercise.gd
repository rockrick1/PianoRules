extends Node

var ExerciseController : Node
var note_scene

func _init():
	note_scene = load("res://Objects/Note.tscn")

func read_MIDI(input):
	print("reading midi :D "+input)
	pass
