extends Node2D

var idd


func _process(delta):
	rotation = position.angle_to_point(Vector2(1000,1000))
	position = position.move_toward( Vector2(1000,1000), 1)
	Multiplayer.rpc_unreliable_id(Multiplayer.server_peer, "playership_update", idd, position, rotation)
