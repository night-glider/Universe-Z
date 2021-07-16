extends Node2D

var pos
var idd

var timer = 60

func init(_id, _pos, _rot):
	idd = _id
	position = _pos
	rotation = _rot

func update_state(_pos, _rot):
	position = _pos
	rotation = _rot
	timer = 60

func _process(delta):
	timer-=1
	if timer < 0:
		Multiplayer.nearby_ships.erase( self)
		queue_free()
