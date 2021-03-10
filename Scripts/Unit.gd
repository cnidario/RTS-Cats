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
	map = get_node("../../Map")
	
func init(unit_desc):
	self.unit_desc = unit_desc.duplicate()
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
			var path = map.calculate_path(current_cell, to_cell)
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

func _input(event):
	if event.is_action_pressed("click"):
		var ev = make_input_local(event)
		if Rect2(Vector2(-16,25), Vector2(16, 25)).has_point(ev.position):
			get_tree().set_input_as_handled()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		emit_signal("clicked", self)

func set_selected(newval):
	selected = newval
	$SelectionLine.visible = selected
		
func update_hpbar():
	var percentage = (current_hp as float) / unit_desc.hitpoints
	$HealthBar/Green.rect_scale.x = percentage
