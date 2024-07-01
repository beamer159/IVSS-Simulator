extends Control
class_name Draggable


signal dragged
signal event_ignored

var drag_blacklist: Array[Control]
var dropoffs: Array[Dropoff]
var process_buttons: Dictionary
var output: Control


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drag") \
	and Rect2(position, size).has_point(event.position) \
	and mouse_filter != MOUSE_FILTER_IGNORE:
		if drag_blacklist.any(func(c): return Draggable._control_has_point(c, event.position)):
			event_ignored.emit(event)
		else:
			dragged.emit(self, event)


static func _control_has_point(control: Control, point: Vector2):
	return Rect2(control.global_position, control.size).has_point(point)


func _on_drop_changed():
	for button in process_buttons.keys():
		button.disabled = process_buttons[button].any(func(d): return d.drop == null)


func clear_dropoffs():
	for dropoff in dropoffs:
		var delete: Draggable = dropoff.drop
		dropoff.drop = null
		delete.queue_free()


func get_output_position() -> Vector2:
	return output.global_position + Vector2(output.size.x, 0)
