extends Node2D
const Commands = preload("Commands.gd")
const CommandButton = preload("res://Scenes/CommandButton.tscn")

onready var units = []
var selected_unit

func _ready():
	for u in $Units.get_children():
		units.append(u)

func _process(delta):
	if Input.is_mouse_button_pressed(2) and selected_unit:
		var command = Commands.MoveCommand.new(get_global_mouse_position())
		selected_unit.set_command(command)
		
func _input(event):
	if event.is_action_pressed("click"):
		# si llega hasta aquí el click es que nadie lo cogio
		$Player.clear_selection()
		
func place_building():
	var p = $Map.world_to_buildings(get_global_mouse_position())
	$Map.place_building(p)
