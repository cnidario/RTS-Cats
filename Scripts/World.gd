extends Node2D
const Commands = preload("Commands.gd")
const Defs = preload("Defs.gd")
const CommandButton = preload("res://Scenes/CommandButton.tscn")

onready var units = []
var selected_unit

func _ready():
	$SelectionManager.init($EntityManager)
	$EntityManager.init($Units.get_children(), $Structures.get_children())
	$HUDLayer/HUD.init($SelectionManager)
	#test
	var p = $Player/Camera2D.get_camera_position()
	var unit: Unit = $EntityManager.create_unit_type(p + Vector2(100, 100), Defs.UnitType.Espadachin)
	$Units.add_child(unit)
	var structure = $EntityManager.create_structure(p + Vector2(600, 128))
	$Structures.add_child(structure)

func _process(delta):
	if Input.is_mouse_button_pressed(2) and selected_unit:
		var command = Commands.MoveCommand.new(get_global_mouse_position())
		selected_unit.set_command(command)
		
func _input(event):
	if event.is_action_pressed("click"):
		# si llega hasta aquí el click es que nadie lo cogio
		$SelectionManager.clear_selection()
		
func place_building():
	var p = $Map.world_to_buildings(get_global_mouse_position())
	$Map.place_building(p)
