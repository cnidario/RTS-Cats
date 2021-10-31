
const PORTRAITSPATH = "res://Sprites/Portraits/"
const UNITSPATH = "res://Sprites/Unit/"
const ICONSPATH = "res://Sprites/Icons/"

enum UnitType { Aldeano, Espadachin, Arquero, Mago }
enum ResearchType { Archery }
enum BuildingType { Archery, Castle, Forge, Hall, House, Monastery, Post, University }
enum ActionType { Build }
const building_descriptions = {
		BuildingType.Archery: {
			name = "archery",
			image = ICONSPATH + "build_archery.png",
			build_cost = [60, 10, 15, 0], #madera, piedra, oro, comida
			time_cost = 100,
			hitpoints = 1000,
			research_requirements = [ ResearchType.Archery ]
		},
		BuildingType.Castle: {
			name = "castle",
			image = ICONSPATH + "build_castle.png",
			build_cost = [30, 50, 10, 0],
			time_cost = 100,
			hitpoints = 1000,
			research_requirements = [ ]
		},
		BuildingType.Forge: {
			name = "forge",
			image = ICONSPATH + "build_forge.png",
			build_cost = [30, 30, 20, 0],
			time_cost = 100,
			hitpoints = 1000,
			research_requirements = [ ]
		},
		BuildingType.Hall: {
			name = "castle",
			image = ICONSPATH + "build_hall.png",
			build_cost = [100, 100, 50, 10],
			time_cost = 100,
			hitpoints = 1000,
			research_requirements = [ ]
		},
		BuildingType.House: {
			name = "house",
			image = ICONSPATH + "build_house.png",
			build_cost = [5, 5, 5, 0],
			time_cost = 100,
			hitpoints = 1000,
			research_requirements = [ ]
		},
		BuildingType.Monastery: {
			name = "monasteryy",
			image = ICONSPATH + "build_monastery.png",
			build_cost = [10, 30, 10, 0],
			time_cost = 100,
			hitpoints = 1000,
			research_requirements = [ ]
		},
		BuildingType.Post: {
			name = "post",
			image = ICONSPATH + "build_post.png",
			build_cost = [10, 10, 5, 0],
			time_cost = 100,
			hitpoints = 1000,
			research_requirements = [ ]
		},
		BuildingType.University: {
			name = "university",
			image = ICONSPATH + "build_university.png",
			build_cost = [60, 50, 40, 0],
			time_cost = 100,
			hitpoints = 1000,
			research_requirements = [ ]
		}
}

const unit_descriptions = {
	UnitType.Aldeano: {
		type = UnitType.Aldeano,
		name = "aldeano",
		hitpoints = 5,
		attack = 1,
		defense = 1,
		attack_range = 10,
		speed = 10,
		portrait_img = PORTRAITSPATH + "3p.png",
		sprite_img = UNITSPATH + "medievalUnit_01.png"
	},
	UnitType.Espadachin: {
		type = UnitType.Espadachin,
		name = "espadachin",
		hitpoints = 20,
		attack = 10,
		defense = 20,
		attack_range = 10,
		speed = 10,
		portrait_img = PORTRAITSPATH + "1p.png",
		sprite_img = UNITSPATH + "medievalUnit_03.png",
		actions = []
	},
	UnitType.Arquero: {
		type = UnitType.Arquero,
		name = "arquero",
		hitpoints = 10,
		attack = 15,
		defense = 10,
		attack_range = 150,
		speed = 10,
		portrait_img = PORTRAITSPATH + "2p.png",
		sprite_img = UNITSPATH + "archerUnit.png",
		actions = []
	},
	UnitType.Mago: {
		type = UnitType.Mago,
		name = "mago",
		hitpoints = 10,
		attack = 20,
		defense = 5,
		attack_range = 120,
		speed = 10,
		portrait_img = PORTRAITSPATH + "4p.png",
		sprite_img = UNITSPATH + "medievalUnit_05.png",
		actions = []
	}
}

