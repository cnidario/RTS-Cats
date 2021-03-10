extends StaticBody2D
class_name Structure

enum ResearchType { Archery }
enum BuildingType { Archery, Castle, Forge, Hall, House, Monastery, Post, University }
const ICONSPATH = "res://Sprites/Icons/"
const building_descriptions = {
		BuildingType.Archery: {
			name = "archery",
			image = ICONSPATH + "build_archery.png",
			build_cost = [20, 10, 10, 0], #madera, piedra, oro, comida
			time_cost = 100,
			hitpoints = 1000,
			research_requirements = [ ResearchType.Archery ]
		},
		BuildingType.Castle: {
			name = "castle",
			image = ICONSPATH + "build_castle.png",
			build_cost = [20, 10, 10, 0],
			time_cost = 100,
			hitpoints = 1000,
			research_requirements = [ ]
		}
}


signal clicked(structure)
func _on_ClickArea_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		emit_signal("clicked", self)
