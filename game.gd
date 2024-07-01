extends Node


var dragging: Control:
	set(value):
		dragging = value
		set_process_input(dragging != null)


var ignored_event: InputEvent


func _ready() -> void:
	$Toolbox.setup(%Rng, %Base64, %Hex)
	%Rng.data_builder.data_built.connect(_on_data_built)
	%Base64.data_builder.data_built.connect(_on_data_built)
	%Hex.data_builder.data_built.connect(_on_data_built)
	_connect_draggable(%Rng)
	_connect_draggable(%Base64)
	_connect_draggable(%Hex)
	dragging = null


func _connect_draggable(draggable: Draggable) -> void:
	draggable.dragged.connect(_on_dragged)
	draggable.event_ignored.connect(_on_event_ignored)
	for dropoff in draggable.dropoffs:
		dropoff.received_drop.connect(_on_received_drop)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		dragging.position += event.relative
	elif event.is_action_released("drag"):
		dragging = null


func _on_dragged(p_dragging: Control, event: InputEvent):
	if event == ignored_event:
		return
	p_dragging.move_to_front()
	dragging = p_dragging
	get_viewport().set_input_as_handled()


func _on_received_drop(dropoff: Dropoff):
	if dragging != null and dragging != dropoff.owner:
		dropoff.attempt_drop(dragging)
		dragging = null
		get_viewport().set_input_as_handled()


func _on_event_ignored(p_ignored_event: InputEvent):
	ignored_event = p_ignored_event


func _on_data_built(data: Data) -> void:
	_connect_draggable(data)
	$Items.add_child(data)
