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

export (float) var offset


func _ready():
	var mat = $NoteSprite.get_material()
	mat.set_shader_param("strength", 0.0)

func _process(delta):
	$NoteSprite.offset.x = offset
	$FlatSprite.offset.x = offset
	$SharpSprite.offset.x = offset

func miss():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("miss")

func hit():
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

func die():
	queue_free()

func get_accidentals():
	return accidentals
