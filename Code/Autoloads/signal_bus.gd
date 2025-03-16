extends Node


# Managers
signal LoadManager(id:StringName)
signal ManagerLoaded(id:StringName)
signal LoadScene(id:StringName, display_loading_screen:bool)
signal SceneLoaded(id:StringName)
signal Save()

# Levels
signal LevelReady(id:StringName)

# Ship Actions
signal ActionTimer(action_id:StringName, current_time:float, max_time:float)
signal ActionToggled(action_id:StringName, toggle:bool)

# Ship
signal ShipReady(ship:Node2D)
signal CharacterShipReady(ship:CharacterBodyShip)


# UI
signal DamageNumber(damage:Damage, pos:Vector2)
signal ToggleLoadingScreen(toggle:bool)
