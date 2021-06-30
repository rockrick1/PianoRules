extends Node2D

const REGULAR = 1
const SHARP = 1
const FLAT = 2

var type : String = "semibreve"
var accidental : int = REGULAR


func _ready():
	pass


func sharp():
	accidental = SHARP
	$FlatSprite.set_visible(false)
	$SharpSprite.set_visible(true)

func flat():
	accidental = FLAT
	$FlatSprite.set_visible(true)
	$SharpSprite.set_visible(false)

func regular():
	accidental = REGULAR
	$FlatSprite.set_visible(false)
	$SharpSprite.set_visible(false)
