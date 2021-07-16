extends Object
class_name ship_class

var virtualized:bool = true
var spd:float = 1
var pos:Vector2 = Vector2(0,0)
var target_pos:Vector2 = Vector2(0,0)
var id:int

var rot:float = 0
var rot_spd:float = 1

func init():
	id = get_instance_id()
	init_instruction()
	pass

func init_instruction():
	target_pos = Vector2(rand_range(-10000, 10000), rand_range(-10000, 10000))

func tick2():
	if pos.distance_squared_to(target_pos) < 10:
		init_instruction()
	rot = pos.angle_to_point(target_pos)
	pos = pos.move_toward(target_pos, spd)

func tick1():
	if pos.distance_squared_to(target_pos) < 10:
		init_instruction()
	pos = pos.move_toward(target_pos, spd)
	pass

func tick():
	if virtualized:
		tick1()
	else:
		tick2()
