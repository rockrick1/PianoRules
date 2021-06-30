extends Node2D

const accidentals = {
	"regular" : 0,
	"sharp" : 1,
	"flat" : 2,
}

var type : String = "semibreve"
var accidental : int = 0


func _ready():
	pass


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
