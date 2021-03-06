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
	$CommandManager.init($EntityManager, $SelectionManager, $GameMap)
	$Pathfinder.init($GameMap)
	#test
	var p = $Player/Camera2D.get_camera_position()
	var unit1: Unit = $EntityManager.create_unit_type(p + Vector2(100, 100), Defs.UnitType.Espadachin)
	var unit2: Unit = $EntityManager.create_unit_type(p + Vector2(338, 100), Defs.UnitType.Arquero)
	var unit3: Unit = $EntityManager.create_unit_type(p + Vector2(260, 420), Defs.UnitType.Mago)
	$Units.add_child(unit1)
	$Units.add_child(unit2)
	$Units.add_child(unit3)
	var structure = $EntityManager.create_structure(p + Vector2(600, 128))
	$Structures.add_child(structure)
		
func _input(event):
	if event.is_action_pressed("click"):
		# si llega hasta aquí el click es que nadie lo cogio
		$SelectionManager.clear_selection()
		print("clear sel")
		
func place_building():
	var p = $GameMap.world_to_buildings(get_global_mouse_position())
	$GameMap.place_building(p)
