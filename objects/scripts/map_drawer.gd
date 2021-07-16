extends Node2D
const ROOM_SIZE = 100

func _draw():
	if Multiplayer.server:
		for element in Multiplayer.player_pos:
			draw_circle(element/20, 1000/20, Color.blue)
		
		""" Рисование кораблей"""
		for element in ShipManager.ships:
			if element.virtualized:
				draw_circle(element.pos/20, 10, Color.red)
			else:
				draw_circle(element.pos/20, 10, Color.gray)
			
		
		

func _process(delta):
	update()
