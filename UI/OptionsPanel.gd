extends PopupMenu

var EC : Node # ExerciseController

var note_range_scene = preload("res://UI/NoteRange.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_add_config_options()

################################################################################

func _add_config_options():
	add_radio_check_item("Assist mode", 1)
	add_radio_check_item("Hard assist mode", 2)
	add_separator("", 10)
	add_item("Note range", 11)
	add_item("Quit", 100)

func _on_OptionsPanel_id_pressed(id):
	var idx = get_item_index(id)
	match id:
		1:
			EC.assist_mode = not EC.assist_mode
			EC.hard_assist_mode = false
			EC.Assist.visible = EC.assist_mode
			EC.HardAssist.visible = EC.hard_assist_mode
			var hard_assist_idx = get_item_index(2)
			set_item_checked(idx, EC.assist_mode)
			set_item_checked(hard_assist_idx, EC.hard_assist_mode)
		2:
			EC.hard_assist_mode = not EC.hard_assist_mode
			EC.assist_mode = false
			EC.Assist.visible = EC.assist_mode
			EC.HardAssist.visible = EC.hard_assist_mode
			var assist_idx = get_item_index(1)
			set_item_checked(idx, EC.hard_assist_mode)
			set_item_checked(assist_idx, EC.assist_mode)
		11:
			var note_range = note_range_scene.instance()
			note_range.init(EC)
			EC.add_child(note_range)
			note_range.visible = true
		100:
			get_tree().quit()
