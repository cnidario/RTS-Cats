extends Node2D

const Defs = preload("Defs.gd")
const HUDButton = preload("res://Scenes/HUDButton.tscn")

var selection_manager: SelectionManager
var buttons = []

func init(selection_manager: SelectionManager):
	self.selection_manager = selection_manager
	selection_manager.connect("selection_changed", self, "_on_selection_changed")

func set_portrait_info(image: String, name: String):
	$UnitTextInfo/UnitNameLabel.text = name
	$portrait_img.texture = load(image)

func update_current_hp(current_hp, max_hp):
	$UnitTextInfo/UnitHitpointsLabel.text = "%d/%d hp" % [current_hp, max_hp]
	
func unit_hp_changed(unit: Unit):
	update_current_hp(unit.current_hp, unit.unit_desc.hitpoints)

func single_unit_selected(unit: Unit):
	set_portrait_info(unit.unit_desc.portrait_img, unit.unit_desc.name)
	update_current_hp(unit.current_hp, unit.unit_desc.hitpoints)
	clear_buttons()
	show_actions(unit)
	visible = true
	
func show_actions(unit: Unit):
	if unit.unit_desc.type == Defs.UnitType.Aldeano:
		for building_desc in Defs.building_descriptions.values():
			var btn = HUDButton.instance()
			btn.icon = load(building_desc.image)
			add_button(btn, building_desc)

func clear_buttons():
	for btn in buttons:
		btn.disconnect("pressed", self, "_btn_pressed")
		btn.disconnect("mouse_entered", self, "_btn_over")
		btn.disconnect("mouse_exited", self, "_btn_exit")
	buttons = []
	for btn in $CommandContainer.get_children():
		$CommandContainer.remove_child(btn)
		btn.queue_free()
func add_button(btn, building_desc):
	buttons.append(btn)
	$CommandContainer.add_child(btn)
	btn.connect("pressed", self, "_btn_pressed", [building_desc])
	btn.connect("mouse_entered", self, "_btn_over", [building_desc])
	btn.connect("mouse_exited", self, "_btn_exit", [building_desc])
	
func _btn_pressed(btn, building_desc):
	print("button pressed: ", btn)
func _btn_over(building_desc):
	print("button over: ")
	$BuildExtendedInfo/wood_lbl.text = "%d" % building_desc.build_cost[0]
	$BuildExtendedInfo/stone_lbl.text = "%d" % building_desc.build_cost[1]
	$BuildExtendedInfo/gold_lbl.text = "%d" % building_desc.build_cost[2]
	$BuildExtendedInfo/food_lbl.text = "%d" % building_desc.build_cost[3]
	$BuildExtendedInfo.visible = true
func _btn_exit(btn):
	$BuildExtendedInfo.visible = false
	
var _selection = []
func _on_selection_changed():
	for u in _selection:
		u.disconnect("unit_hp_changed", self, "unit_hp_changed")
	_selection = selection_manager.selection
	for u in _selection:
		u.connect("unit_hp_changed", self, "unit_hp_changed")
	if selection_manager.is_empty_selection():
		visible = false
	elif selection_manager.is_single_selection():
		single_unit_selected(_selection[0])
	
	
