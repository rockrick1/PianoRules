extends Node2D

const accidentals = {
	"regular" : 0,
	"sharp" : 1,
	"flat" : 2,
}

var type : String = "semibreve"
var accidental : int = 0
var pitch : int
var note_str : String
var alive : bool = true

export (float) var shake_offset


func _ready():
	var mat = $NoteSprite.get_material()
	mat.set_shader_param("strength", 0.0)

func _process(delta):
	$NoteSprite.offset.x = shake_offset
	$FlatSprite.offset.x = shake_offset
	$SharpSprite.offset.x = shake_offset

func miss():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("miss")

func hit():
	if not alive:
		return
	alive = false
	$AnimationPlayer.stop()
	$AnimationPlayer.play("hit")

func sharp():
	accidental = accidentals["sharp"]
	$FlatSprite.set_visible(false)
	$SharpSprite.set_visible(true)

func flat():
	accidental = accidentals["flat"]
	$FlatSprite.set_visible(true)
	$SharpSprite.set_visible(false)

func regular():
	accidental = accidentals["regular"]
	$FlatSprite.set_visible(false)
	$SharpSprite.set_visible(false)

func get_accidentals():
	return accidentals

func die():
	queue_free()
