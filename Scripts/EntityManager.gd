extends Node
const Unit = preload("res://Scenes/Units/Unit.tscn")
const Structure = preload("res://Scenes/Structure.tscn")
const Defs = preload("Defs.gd")

class_name EntityManager
signal unit_created(unit)
signal unit_destroyed(unit)
signal structure_created(structure)
signal structure_destroyed(structure)

func init(units, structures):
	for u in units:
		u.init(Defs.unit_descriptions[Defs.UnitType.Aldeano])
		emit_signal("unit_created", u)
	for s in structures:
		emit_signal("structure_created", s)
		
## UNITS

func _create_unit(pos: Vector2):
	var unit = Unit.instance()
	unit.position = pos
	emit_signal("unit_created", unit)
	return unit
func destroy_unit(unit: Unit):
	emit_signal("unit_destroyed", unit)
	unit.queue_free()
	
func create_unit_type(pos: Vector2, unit_type):
	var u: Unit = _create_unit(pos)
	var unit_desc = Defs.unit_descriptions[unit_type]
	u.init(unit_desc)
	return u

func create_structure(pos: Vector2):
	var structure = Structure.instance()
	structure.position = pos
	emit_signal("structure_created", structure)
	return structure
func destroy_structure(structure: Structure):
	emit_signal("structure_destroyed", structure)
	structure.queue_free()


