extends Node


# Ship Actions
signal ActionTimer(action_id:StringName, current_time:float, max_time:float)
signal ActionToggled(action_id:StringName, toggle:bool)

# Ship
signal ShipReady(ship:Node2D)
signal CharacterShipReady(ship:CharacterBodyShip)


# UI
signal DamageNumber(damage:Damage, pos:Vector2)
