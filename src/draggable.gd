class_name Draggable
extends Control


signal drag_begun

var dropoffs: Array[Dropoff]
var process_buttons: Dictionary
var output: Control


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		drag_begun.emit(self)


func _on_element_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		move_to_front()


func _on_drop_changed(old_value: Draggable, dropoff: Dropoff):
	for button in process_buttons.keys():
		button.disabled = process_buttons[button].any(func(d): return d.drop == null)
	if dropoff.drop != null:
		dropoff.drop.hide()
	if old_value != null:
		old_value.move_to_front()
		old_value.show()
		old_value.position = output.global_position + Vector2(output.size.x, 0)


func clear_dropoffs():
	for dropoff in dropoffs.filter(func(d: Dropoff): return d.drop is Data):
		dropoff.drop.queue_free()
		dropoff.drop = null


func get_output_position() -> Vector2:
	return output.global_position + Vector2(output.size.x, 0)
