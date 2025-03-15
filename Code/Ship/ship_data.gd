class_name ShipData extends Resource


@export var id:StringName = ""
@export var ship_uid:String

# Basics
@export_category("Stats")
@export var base_hp:float = 100.0
@export var base_lives:int = 1
@export var base_speed:float = 400.0
@export var base_damp:float = 0.3
@export var base_acceleration:float = 1100.0
@export var base_friction:float = 100.0
@export var base_armor:float = 0.0
@export var base_shield:float = 0.0
@export var base_crit_chance:float = 0.0
@export var base_crit_damage:float = 0.0

# Resistances
@export var base_physical_resistance:float = 0.0
@export var base_energy_resistance:float = 0.0
@export var base_plasma_resistance:float = 0.0
@export var base_explosive_resistance:float = 0.0

# Ship upgrades
@export_category("Upgrades")
@export var all_ship_upgrades:Array[Resource]

@export_category("UI")
@export var small_icon_uid:String
@export var large_icon_uid:String
@export var loc_display_name:String
@export var debug_display_name:String
@export var loc_description:String
@export var debug_description:String


# Getters
# HP
var current_hp:float
var max_hp:float:
	get: return base_hp + _get_value_from_ship_upgrades(&"hp") + _get_value_from_run_upgrades(&"hp")
var current_lives:int
var max_lives:int:
	get: return base_lives + int(_get_value_from_ship_upgrades(&"lives")) + int(_get_value_from_run_upgrades(&"lives"))

# Movement
var speed:float:
	get: return base_speed + _get_value_from_ship_upgrades(&"speed") + _get_value_from_run_upgrades(&"speed")
var dampening:float:
	get: return base_damp + _get_value_from_ship_upgrades(&"dampening") + _get_value_from_run_upgrades(&"dampening")

# Attack
var damage:float:
	get: return _get_value_from_ship_upgrades(&"damage") + _get_value_from_run_upgrades(&"damage")
var attack_speed:float:
	get: return _get_value_from_ship_upgrades(&"attack_speed") + _get_value_from_run_upgrades(&"attack_speed")
var projectile_speed:float:
	get: return _get_value_from_ship_upgrades(&"projectile_speed") + _get_value_from_run_upgrades(&"projectile_speed")
var projectile_size:float:
	get: return _get_value_from_ship_upgrades(&"projectile_size") + _get_value_from_run_upgrades(&"projectile_size")
var projectile_life_time_distance:float:
	get: return _get_value_from_ship_upgrades(&"projectile_life_time_distance") + _get_value_from_run_upgrades(&"projectile_life_time_distance")
var crit_chance:float:
	get: return base_crit_chance + _get_value_from_ship_upgrades(&"crit_chance") + _get_value_from_run_upgrades(&"crit_chance")
var crit_damage:float:
	get: return base_crit_damage + _get_value_from_ship_upgrades(&"crit_damage") + _get_value_from_run_upgrades(&"crit_damage")
var projectile_peirce_count:float:
	get: return _get_value_from_ship_upgrades(&"projectile_peirce_count") + _get_value_from_run_upgrades(&"projectile_peirce_count")

# Defenses
var current_armor:float
var max_armor:float:
	get: return base_armor + _get_value_from_ship_upgrades(&"armor") + _get_value_from_run_upgrades(&"armor")
var current_shield:float
var max_shield:float:
	get: return base_shield + _get_value_from_ship_upgrades(&"shield") + _get_value_from_run_upgrades(&"shield")

# Resistances
var physical_resist:float:
	get: return base_physical_resistance + _get_value_from_ship_upgrades(&"physical_resist") + _get_value_from_run_upgrades(&"physical_resist")
var energy_resist:float:
	get: return base_energy_resistance + _get_value_from_ship_upgrades(&"energy_resist") + _get_value_from_run_upgrades(&"energy_resist")
var plasma_resist:float:
	get: return base_plasma_resistance + _get_value_from_ship_upgrades(&"plasma_resist") + _get_value_from_run_upgrades(&"plasma_resist")
var explosive_resist:float:
	get: return base_explosive_resistance + _get_value_from_ship_upgrades(&"explosive_resist") + _get_value_from_run_upgrades(&"explosive_resist")

# Upgrades
var active_ship_upgrades:Array = []
var active_run_upgrades:Array = []


func setup_data(ship_upgrades:Array = []) -> void:
	active_ship_upgrades = ship_upgrades
	current_hp = max_hp
	current_lives = max_lives
	current_armor = max_armor
	current_shield = max_shield


func _get_value_from_ship_upgrades(_variable_name:StringName = "") -> float:
	# TODO: make this search all active SHIP upgrades for all instances of the variable and send them all back as one
	return 0.0


func _get_value_from_run_upgrades(_variable_name:StringName = "") -> float:
	# TODO: make this search all active RUN upgrades for all instances of the variable and send them all back as one
	return 0.0
