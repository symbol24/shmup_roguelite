class_name ProjectileShootData extends ActionData


@export var projectile_uid:String = ""
@export var proj_type:Enums.Projectile_Type = Enums.Projectile_Type.MOVING

@export_category("Damage Stuff")
@export var proj_damage:float = 0.0
@export var proj_count_per_attack:int = 1
@export var delay_between_proj:float = 0.1
## Attacks per second.
@export var proj_attack_speed:float = 1.0
## Bonus Projectile size, should always be 0 on projectile data. Its a multiplyer.
@export var proj_projectile_size:float = 0.0
@export var proj_crit_chance:float = 0.0
@export var proj_crit_damage:float = 0.0
@export var proj_damage_type:Enums.Damage_Type
@export var proj_sub_damage_types:Array[Enums.Damage_Sub_Type]
@export var proj_pierce_count:float = 1.0

@export_group("Moving")
@export var speed:float = 1000.0
## Distance should be a squared value as the comparison is done to "distance_to_squared"
@export var life_time_distance:float = 2500.0

@export_group("Laser")
@export var length:float = 100.0
@export var attacks_per_second:int = 1
@export var max_charge:float = 10.0
@export var charge_time:float = 3.0
@export var minimum_shoot_time:float = 0.5
@export var rotation_speed:float = 10.0
@export var rotation_multiplier:float = 0.1

@export_group("Fixed")
@export var dampening:float = 0.0
@export var area_size:float = 1.0
@export var projectile_life_time:float = 0.0
