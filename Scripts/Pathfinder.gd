extends Node

class_name Pathfinder

var game_map

var astar_node = AStar.new()
var obstacles = []
var map_size
var cell_size

func init(game_map):
	self.game_map = game_map
	map_size = game_map.map_size
	cell_size = game_map.cell_size
	obstacles = _calculate_obstacle_cells()
	var walkable_cells_list = _astar_add_walkable_cells(obstacles)
	_astar_connect_walkable_cells_diagonal(walkable_cells_list)

func _calculate_obstacle_cells():
	var ground_tilemap = game_map.get_node("Ground")
	# obstacles only from ground tilemap
	var obstacles = ground_tilemap.get_used_cells_by_id(6)
	obstacles = obstacles + ground_tilemap.get_used_cells_by_id(7)
	return obstacles
	
func _astar_connect_walkable_cells_diagonal(points_array):
	for point in points_array:
		var point_index = calculate_point_index(point)
		for local_y in range(3):
			for local_x in range(3):
				var point_relative = Vector2(point.x + local_x - 1, point.y + local_y - 1)
				var point_relative_index = calculate_point_index(point_relative)
				if point_relative == point or is_outside_map_bounds(point_relative):
					continue
				if not astar_node.has_point(point_relative_index):
					continue
				astar_node.connect_points(point_index, point_relative_index, true)

func _astar_add_walkable_cells(obstacle_list = []):
	var points_array = []
	for y in range(map_size.y):
		for x in range(map_size.x):
			var point = Vector2(x, y)
			if point in obstacle_list:
				continue
			points_array.append(point)
			var point_index = calculate_point_index(point)
			astar_node.add_point(point_index, Vector3(point.x, point.y, 0.0))
	return points_array

func calculate_path(path_start_position, path_end_position):
	var start_point_index = calculate_point_index(path_start_position)
	var end_point_index = calculate_point_index(path_end_position)
	var point_path3 = astar_node.get_point_path(start_point_index, end_point_index)
	var point_path = []
	for p in point_path3:
		point_path.append(Vector2(p.x, p.y))
	return point_path

func is_outside_map_bounds(point):
	return point.x < 0 or point.y < 0 or point.x >= map_size.x or point.y >= map_size.y
func calculate_point_index(point):
	return point.x + map_size.x * point.y
