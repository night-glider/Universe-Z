extends Control



func _on_Button_pressed():
	Multiplayer.server_create()
	get_tree().change_scene("res://World.tscn")


func _on_Button2_pressed():
	Multiplayer.server_connect($LineEdit.text)
	get_tree().change_scene("res://World.tscn")
