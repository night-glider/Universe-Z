extends Node2D

var ships = []

func _init():
	for i in Globals.SHIP_SPAWN_COUNT:
		var new_ship = ship_class.new()
		new_ship.init()
		new_ship.pos = Vector2(rand_range(-10000,10000), rand_range(-10000,10000))
		ships.append(new_ship)

func _process(delta):
	for element in ships:
		element.virtualized = true
		for i in Multiplayer.player_pos.size():
			if element.pos.distance_to(Multiplayer.player_pos[i]) < 1000:
				element.virtualized = false
				Multiplayer.rpc_unreliable_id(Multiplayer.player_peer[i], "ship_update", element.id, element.pos, element.rot)
		element.tick()
	
	if Input.is_action_pressed("ui_accept"):
		for element2 in Multiplayer.player_pos:
			OS.alert(str(element2))
