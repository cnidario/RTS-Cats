extends Node

class_name Player

signal selection_changed(new_selection)
var selection = [] setget set_selection

func _ready():
	for u in get_node("../Units").get_children():
		u.owner_player = self
		if u.owner_player == self:
			u.connect("clicked", self, "_unit_clicked")

func set_selection(sel):
	selection_changed(selection, sel)
	selection = sel
	emit_signal("selection_changed", selection)

func _unit_clicked(unit):
	set_selection([unit])

func clear_selection():
	set_selection([])

func selection_changed(old, selection):
	match len(selection):
		# deselection, cleanup
		0:
			deselect_all(old)
		# single unit selection
		1:
			select_single_unit(old, selection[0])
		_:
			pass

func select_single_unit(old, unit: Unit):
	$Camera2D/HUD.single_unit_selected(unit)
	deselect_units(old)
	unit.selected = true

func deselect_all(old):
	$Camera2D/HUD.clear_unit_selection()
	deselect_units(old)

func deselect_units(units):
	for u in units:
		u.selected = false
