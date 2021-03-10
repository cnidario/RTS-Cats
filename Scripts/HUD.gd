extends Control

var selection_manager: SelectionManager
var buttons = []

func init(selection_manager: SelectionManager):
	self.selection_manager = selection_manager
	selection_manager.connect("selection_changed", self, "_on_selection_changed")

func clear_buttons():
	buttons = []
	$HBoxContainer.get_children().clear()
func add_button(btn):
	buttons.append(btn)
	$HBoxContainer.add_child(btn)
	print(buttons)

func set_portrait_info(image: String, name: String):
	$UnitName/UnitNameLabel.text = name
	$portrait_img.texture = load(image)

func update_current_hp(current_hp, max_hp):
	$UnitInfo/UnitHitpointsLabel.text = "%d/%d hp" % [current_hp, max_hp]
	
func unit_hp_changed(unit: Unit):
	update_current_hp(unit.current_hp, unit.unit_desc.hitpoints)

func single_unit_selected(unit: Unit):
	set_portrait_info(unit.unit_desc.portrait_img, unit.unit_desc.name)
	update_current_hp(unit.current_hp, unit.unit_desc.hitpoints)
	visible = true
	
var _selection = []
func _on_selection_changed():
	for u in _selection:
		u.disconnect("unit_hp_changed", self, "unit_hp_changed")
	_selection = selection_manager.selection
	for u in _selection:
		u.connect("unit_hp_changed", self, "unit_hp_changed")
	if selection_manager.is_empty_selection():
		visible = false
	elif !selection_manager.is_multiple_selection():
		single_unit_selected(_selection[0])
	
	
	
