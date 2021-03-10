extends Node

enum CommandType { NONE, STOP, MOVE }
class Command:
	func command_type():
		pass
class MoveCommand extends Command:
	var to = Vector2.ZERO
	func _init(to_pos):
		to = to_pos
	func command_type():
		return CommandType.MOVE
class StopCommand extends Command:
	func command_type():
		return CommandType.STOP
