extends Node2D

var pos:Vector2 = Vector2(0,0)

func _process(delta):
	$Camera2D/Label.text = str(Multiplayer.nearby_ships)
	
	if Input.is_action_pressed("ui_down"):
		pos.y+=20
		$Camera2D.position.y+=20
	if Input.is_action_pressed("ui_up"):
		pos.y-=20
		$Camera2D.position.y-=20
	if Input.is_action_pressed("ui_left"):
		pos.x-=20
		$Camera2D.position.x-=20
	if Input.is_action_pressed("ui_right"):
		pos.x+=20
		$Camera2D.position.x+=20
	Multiplayer.rpc_unreliable_id(Multiplayer.server_peer, "player_update", pos)
