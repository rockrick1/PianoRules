extends AcceptDialog

var pitch_range : Array
var ExerciseController : Node

var start_label : Control
var end_label : Control

func _init(controller):
	ExerciseController = controller
	pitch_range = ExerciseController.pitch_range
	start_label = $Buttons/Start/Label
	end_label = $Buttons/End/Label


func _on_Start_Up_pressed():
	pitch_range[0] = pitch_range[0] + 1
	start_label.set_text(str(pitch_range[0]))


func _on_Start_Down_pressed():
	pitch_range[0] = pitch_range[0] - 1
	start_label.set_text(str(pitch_range[0]))


func _on_End_Up_pressed():
	pitch_range[1] = pitch_range[1] + 1
	end_label.set_text(str(pitch_range[1]))


func _on_End_Down_pressed():
	pitch_range[1] = pitch_range[1] - 1
	end_label.set_text(str(pitch_range[1]))
