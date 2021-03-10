extends Node2D
class_name Unit

const Commands = preload("Commands.gd")
const CommandType = Commands.CommandType

var owner_player: Node

signal clicked(unit)
signal unit_hp_changed(unit)

var command = Commands.StopCommand.new()
var current_path = []
var destination
var base_speed = 150
var speed = Vector2.ZERO
const EPS = 2.5
var map
var debug_path = true
var selected setget set_selected
var current_hp = 0

var unit_desc

func _ready():
	map = get_node("../../GameMap")
	
func init(unit_desc):
	self.unit_desc = unit_desc.duplicate()
	$sprite.texture = load(unit_desc.sprite_img)
	current_hp = unit_desc.hitpoints
	update_hpbar()
	
func _draw():
	if current_path:
		var before_point = to_local(position)
		for p in current_path:
			draw_line(before_point, to_local(p), Color(0,1,0), 2, true)
			before_point = to_local(p)
# convert map coordinates to global coordinates
func cell_path_to_global(path):
	var global_path = []
	for i in range(len(path)-1):
		var p = path[i]
		global_path.append(map.map_to_world(p) + map.cell_size/2)
	global_path.append(destination)
	return global_path
func _process(delta):
	var pathfinder = get_node("../../Pathfinder")
	if debug_path:
		update()
	match command.command_type():
		CommandType.STOP:
			speed = Vector2.ZERO
		CommandType.MOVE:
			var move_cmd = command as Commands.MoveCommand
			destination = move_cmd.to
			var to_cell = map.world_to_map(move_cmd.to)
			var current_cell = map.world_to_map(position)
			var path = pathfinder.calculate_path(current_cell, to_cell)
			path.pop_front()
			if path:
				current_path = cell_path_to_global(path)
			command = Commands.StopCommand.new()
	calculate_speed()
	if speed != Vector2.ZERO:
		self.set_position(position + speed * delta)
func calculate_speed():
	if current_path:
		var next_dest = current_path[0]
		if (next_dest - position).length() < EPS:
			current_path.pop_front()
			calculate_speed()
		else:
			var direction = (next_dest - position).normalized()
			speed = direction * base_speed
	else:
		speed = Vector2.ZERO
func set_command(cmd):
	command = cmd
	
func calc_collision_rect(collision_shape):
	var p = global_position
	var extents = collision_shape.shape.extents
	return Rect2(p - extents, extents*2)

func _input(event):
	if event.is_action_pressed("click") or event.is_action_pressed("right_click"):
		var collision_rect = calc_collision_rect($Area2D/CollisionShape2D)
		if collision_rect.has_point(get_global_mouse_position()):
			get_tree().set_input_as_handled()
			if event.is_action_pressed("click"):
				emit_signal("clicked", self)
			elif event.is_action_pressed("right_click"):
				pass

func set_selected(newval):
	selected = newval
	$SelectionLine.visible = selected
		
func update_hpbar():
	var percentage = (current_hp as float) / unit_desc.hitpoints
	$HealthBar/Green.rect_scale.x = percentage
