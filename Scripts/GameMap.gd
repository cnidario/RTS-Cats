extends Node2D
class_name GameMap

signal right_clicked(position)

export(Vector2) var map_size = Vector2.ONE * 16
export(Vector2) var cell_size = Vector2(128, 128)

func place_building(pos):
	if pos.x < 0 or pos.x >= map_size.x or pos.y < 1 or pos.y >= map_size.y:
		print("not valid building place")
		return
	if $Buildings.get_cellv(pos) != TileMap.INVALID_CELL  \
			or $Buildings.get_cellv(pos - Vector2(0, 1)) != TileMap.INVALID_CELL:
		print("building place occupied")
		return
	$Buildings.set_cellv(pos, 1)
	$Buildings.set_cellv(pos - Vector2(0, 1), 0)

func world_to_map(pos: Vector2):
	return $Ground.world_to_map(pos)
func map_to_world(pos: Vector2):
	return $Ground.map_to_world(pos)
func world_to_buildings(pos: Vector2):
	return $Buildings.world_to_map(pos)

func _input(event):
	if Input.is_action_pressed("right_click"):
		emit_signal("right_clicked", get_global_mouse_position())
