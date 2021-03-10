enum UnitType { Aldeano, Espadachin, Arquero, Mago }
const PORTRAITSPATH = "res://Sprites/Portraits/"
const UNITSPATH = "res://Sprites/Unit/"
const unit_descriptions = {
	UnitType.Aldeano: {
		name = "aldeano",
		hitpoints = 5,
		attack = 1,
		defense = 1,
		attack_range = 1,
		speed = 10,
		portrait_img = PORTRAITSPATH + "3p.png",
		sprite_img = UNITSPATH + "medievalUnit_01.png",
		actions = []
	},
	UnitType.Espadachin: {
		name = "espadachin",
		hitpoints = 20,
		attack = 10,
		defense = 20,
		attack_range = 1,
		speed = 10,
		portrait_img = PORTRAITSPATH + "1p.png",
		sprite_img = UNITSPATH + "medievalUnit_03.png",
		actions = []
	}
}
