@tool
extends Button
class_name Dropoff

signal received_drop
signal drop_changed

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
		drop = v
		if drop == null:
			disabled = true
		else:
			drop.hide()
			drop.mouse_filter = Control.MOUSE_FILTER_IGNORE
			disabled = false
			var style: StyleBoxFlat = get_theme_stylebox("panel").duplicate()
			style.bg_color = Color(0.1, 0.4, 0.1, 0.6)
		drop_changed.emit()


func _input(event: InputEvent) -> void:
	if event.is_action("drag") and Rect2(global_position, size).has_point(event.position):
		if event.is_released():
			received_drop.emit(self)


func attempt_drop(draggable: Draggable):
	if drop != null:
		return
	match type:
		Type.DATA:
			if not draggable is Data:
				return
	drop = draggable


func _on_pressed() -> void:
	drop.move_to_front()
	drop.position = get_owner().get_output_position()
	drop.show()
	drop.mouse_filter = Control.MOUSE_FILTER_STOP
	drop = null
	disabled = true
