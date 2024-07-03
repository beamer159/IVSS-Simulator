@tool
class_name Dropoff
extends Button


signal drop_changed(old_value: Draggable)

enum Type {
	DATA
}

@export var type: Type

@export var label: String:
	set(v):
		label = v
		text = v

@export var area: Vector2:
	set(v):
		area = v
		custom_minimum_size = area


var drop: Draggable:
	set(v):
		var old_value = drop
		drop = v
		disabled = drop == null
		drop_changed.emit(old_value)


func attempt_drop(draggable: Draggable):
	match type:
		Type.DATA:
			if not draggable is Data:
				return
	drop = draggable


func _on_pressed():
	drop = null
