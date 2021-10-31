extends StaticBody2D
class_name Structure

signal clicked(structure)
func _on_ClickArea_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		emit_signal("clicked", self)
