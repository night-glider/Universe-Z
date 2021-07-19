extends Node2D

var server:bool = false
var server_peer:int = 1
var my_peer_id:int

var ship = preload("res://objects/ship.tscn")

var player_pos = [] #TODO ЗАМЕНИТЬ НА ЧТО-ТО НОРМАЛЬНОЕ
var player_peer = []

var nearby_ships = []

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")

func server_create():
	var peer = NetworkedMultiplayerENet.new()
	peer.always_ordered = false
	peer.transfer_mode = NetworkedMultiplayerPeer.TRANSFER_MODE_UNRELIABLE
	peer.create_server(6969, 10)
	get_tree().network_peer = peer
	server = true
	server_peer = get_tree().get_network_unique_id()
	my_peer_id = get_tree().get_network_unique_id()
	
	#player_pos.append(Vector2(0,0))
	#player_peer.append(my_peer_id)
	
	_player_connected(my_peer_id)

func server_connect(ip:String):
	var peer = NetworkedMultiplayerENet.new()
	peer.always_ordered = false
	peer.transfer_mode = NetworkedMultiplayerPeer.TRANSFER_MODE_UNRELIABLE
	peer.create_client(ip, 6969)
	get_tree().network_peer = peer
	server = false
	my_peer_id = get_tree().get_network_unique_id()
	
	#player_pos.append(Vector2(0,0))
	#player_peer.append(my_peer_id)
	
	_player_connected(my_peer_id)

""" Функции, обрабатываемые сервером"""

remotesync func player_update(pos:Vector2):
	
	for i in player_peer.size():
		if player_peer[i] == get_tree().get_rpc_sender_id():
			player_pos[i] = pos

remotesync func playership_update(_id, _pos, _rot):
	
	for element in Globals.Ship_manager.player_ships:
		if element.id == _id:
			element.pos = _pos
			element.rot = _rot


""" Функции, обрабатываемые Клиентом"""

remotesync func ship_update(_id, _pos, _rot):
	for element in nearby_ships:
		if element.idd == _id:
			element.update_state(_pos, _rot)
			return
	
	var new_ship = ship.instance()
	new_ship.init(_id, _pos, _rot)
	get_tree().get_root().add_child(new_ship)
	nearby_ships.append(new_ship)

remotesync func player_ship_create(_id, _pos, _rot):
	var ship = load("res://objects/player_ship.tscn").instance()
	ship.idd = _id
	ship.position = _pos
	ship.rotation = _rot
	get_tree().get_root().add_child(ship)

func _player_connected(id):
	player_pos.append(Vector2(0,0))
	player_peer.append(id)
	
	if server:
		var new_ship = Globals.Ship_manager.create_player_ship()
		rpc_id(id, "player_ship_create", new_ship.id, new_ship.pos, new_ship.rot)
	
