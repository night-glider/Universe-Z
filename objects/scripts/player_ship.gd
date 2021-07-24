extends Node2D

var idd


func _process(delta):
	if Input.is_action_pressed("move_forward"):
		position.x -= cos(rotation)*10
		position.y -= sin(rotation)*10
	if Input.is_action_pressed("rotate_left"):
		rotation-=0.05
	if Input.is_action_pressed("rotate_right"):
		rotation+=0.05
	
	
	Multiplayer.rpc_unreliable_id(Multiplayer.server_peer, "playership_update", idd, position, rotation)
