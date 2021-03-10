extends Node
class_name SelectionManager

enum SelectionType { EMPTY, SINGLE, MULTIPLE }

signal selection_changed()
var entity_manager: EntityManager
var selection = []

func init(entity_manager: EntityManager):
	self.entity_manager = entity_manager
	self.entity_manager.connect("unit_created", self, "_on_unit_created")
	self.entity_manager.connect("unit_destroyed", self, "_on_unit_destroyed")

func is_multiple_selection():
	return len(selection) > 1
func is_empty_selection():
	return len(selection) == 0
func clear_selection():
	for u in selection:
		u.selected = false
	selection = []
	emit_signal("selection_changed")

func _on_unit_created(unit: Unit):
	unit.connect("clicked", self, "_on_unit_clicked")
func _on_unit_destroyed(unit: Unit):
	unit.disconnect("clicked", self, "_on_unit_clicked")

func _on_unit_clicked(unit: Unit):
	selection = [unit]
	unit.selected = true
	emit_signal("selection_changed")
