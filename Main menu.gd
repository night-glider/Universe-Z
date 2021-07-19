extends Control



func _on_Button_pressed():
	var shipm = load("res://singletons/ShipManager.tscn").instance()
	get_node("/root").add_child(shipm)
	Globals.Ship_manager = shipm
	Multiplayer.server_create()
	get_tree().change_scene("res://World.tscn")


func _on_Button2_pressed():
	Multiplayer.server_connect($LineEdit.text)
	get_tree().change_scene("res://World.tscn")
