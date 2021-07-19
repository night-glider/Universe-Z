extends Object
class_name player_ship_class

var virtualized:bool = false
var spd:float = 1
var pos:Vector2 = Vector2(0,0)
var target_pos:Vector2 = Vector2(0,0)
var id:int

var rot:float = 0
var rot_spd:float = 1

func init():
	id = get_instance_id()
	pass



func tick():
	pass
