class_name ShipList extends Resource


@export var ships:Array[ShipData] = []


func get_ship_by_id(_id:StringName) -> ShipData:
	for each in ships:
		if each.id == _id:
			return each
			
	print("No ship wit id %s found." % _id)
	return null
