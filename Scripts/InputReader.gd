extends Node

onready var NoteMapping = load("res://Scripts/NoteMapping.gd")

var currently_pressed : Dictionary = {}
var just_pressed : Dictionary = {}
var just_released : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.open_midi_inputs()

	print(OS.get_connected_midi_inputs())

	for current_midi_input in OS.get_connected_midi_inputs():
		print(current_midi_input)


# via <https://github.com/godotengine/godot/blob/master/core/os/input_event.h>
enum GlobalScope_MidiMessageList {
	MIDI_MESSAGE_NOTE_OFF = 0x8,
	MIDI_MESSAGE_NOTE_ON = 0x9,
	MIDI_MESSAGE_AFTERTOUCH = 0xA,
	MIDI_MESSAGE_CONTROL_CHANGE = 0xB,
	MIDI_MESSAGE_PROGRAM_CHANGE = 0xC,
	MIDI_MESSAGE_CHANNEL_PRESSURE = 0xD,
	MIDI_MESSAGE_PITCH_BEND = 0xE,
};


const MIDI_EVENT_PROPERTIES = ["channel", "message", "pitch", "velocity", "instrument", "pressure", "controller_number", "controller_value"]


func get_midi_message_description(event : InputEventMIDI):

	if GlobalScope_MidiMessageList.values().has(event.message):
		return GlobalScope_MidiMessageList.keys()[event.message - 0x08]
	return event.message

# TODO: Add the black keys.
const OCTAVE_KEY_INDEX = ["WhiteKey1", "BlackKey1", "WhiteKey2", "BlackKey2", "WhiteKey3", "WhiteKey4", "BlackKey3", "WhiteKey5", "BlackKey4", "WhiteKey6", "BlackKey5", "WhiteKey7"]


func _unhandled_input(event : InputEvent):
	if (event is InputEventMIDI):

		var event_dump : String = ""
		var played_note : String = ""
		var props : Dictionary = {}

		#event_dump += "chn: {channel} msg: {message}\n".format({"channel": event.channel, "message": event.message})
		#event_dump += "  pitch: {pitch} vel: {velocity}\n".format({"pitch": event.pitch, "velocity": event.velocity})

		event_dump += "event: {0}\n".format([get_midi_message_description(event)])

		for current_property in MIDI_EVENT_PROPERTIES:
			props[current_property] = event.get(current_property)
			event_dump += "  {0}: {1}\n".format([current_property, event.get(current_property)])

		event_dump += "\n"

		# Currently played note is the pitch in the message
		played_note = NoteMapping.get_map()[props["pitch"]]

		# Note: If the instrument isn't keyboard related it will possibly mess up the display.
		var key_index = event.pitch % 12

		match event.message:
			MIDI_MESSAGE_NOTE_ON:
				currently_pressed[props.pitch] = props
				just_pressed[props.pitch] = props
#				print(event_dump)
				print(played_note)

			MIDI_MESSAGE_NOTE_OFF:
				currently_pressed.erase(props.pitch)
				just_released[props.pitch] = props
