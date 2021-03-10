extends Control

var buttons = []

func clear_buttons():
	buttons = []
	$HBoxContainer.get_children().clear()
func add_button(btn):
	buttons.append(btn)
	$HBoxContainer.add_child(btn)
	print(buttons)

func set_portrait_info(image: String, name: String):
	$UnitName/UnitNameLabel.text = name
	$portrait_img.texture = load("res://Sprites/Portraits/" + image)

func update_current_hp(current_hp, max_hp):
	$UnitInfo/UnitHitpointsLabel.text = "%d/%d hp" % [current_hp, max_hp]

func single_unit_selected(unit: Unit):
	print("single unit selected")
	set_portrait_info(unit.unit_descrition["portrait_img"], unit.unit_descrition["unit_type"])
	visible = true

func clear_unit_selection():
	visible = false
