extends Node

const Commands = preload("Commands.gd")

class_name CommandManager

var entity_manager: EntityManager
var selection_manager: SelectionManager
var game_map

func init(entity_manager, selection_manager, game_map):
	self.entity_manager = entity_manager
	self.selection_manager = selection_manager
	self.game_map = game_map
	game_map.connect("right_clicked", self, "_on_map_right_clicked")

func _on_map_right_clicked(position):
	var move_cmd = Commands.MoveCommand.new(position)
	if selection_manager.is_single_selection():
		var unit = selection_manager.selection[0] as Unit
		unit.set_command(move_cmd)
