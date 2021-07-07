extends AcceptDialog

var pitch_range : Array
var ExerciseController : Node
var NoteMapping

var start_label : Control
var end_label : Control

func init(controller):
	ExerciseController = controller
	NoteMapping = controller.NoteMapping
	pitch_range = ExerciseController.pitch_range
	start_label = $Buttons/Start/Label
	end_label = $Buttons/End/Label
	var start = NoteMapping.get_map()[pitch_range[0]]
	var end = NoteMapping.get_map()[pitch_range[1]]
	start_label.set_text(start)
	end_label.set_text(end)


func _on_Start_Up_pressed():
	pitch_range[0] = pitch_range[0] + 1
	var start = NoteMapping.get_map()[pitch_range[0]]
	start_label.set_text(start)


func _on_Start_Down_pressed():
	pitch_range[0] = pitch_range[0] - 1
	var start = NoteMapping.get_map()[pitch_range[0]]
	start_label.set_text(start)


func _on_End_Up_pressed():
	pitch_range[1] = pitch_range[1] + 1
	var end = NoteMapping.get_map()[pitch_range[1]]
	end_label.set_text(end)


func _on_End_Down_pressed():
	pitch_range[1] = pitch_range[1] - 1
	var end = NoteMapping.get_map()[pitch_range[1]]
	end_label.set_text(end)
