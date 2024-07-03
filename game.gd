extends Node


var dragging: Draggable:
	set(v):
		dragging = v
		set_process_input(dragging != null)

var hovering: Dropoff


func _ready() -> void:
	$Toolbox.setup(%Rng, %Base64, %Hex)
	%Rng.data_builder.data_built.connect(_on_data_built)
	%Base64.data_builder.data_built.connect(_on_data_built)
	%Hex.data_builder.data_built.connect(_on_data_built)
	%RequestList.request_created.connect(_on_request_created)
	_connect_draggable(%Rng)
	_connect_draggable(%Base64)
	_connect_draggable(%Hex)
	dragging = null


func _input(event: InputEvent) -> void:
	if event.is_action_released("drag"):
		dragging.mouse_filter = Control.MOUSE_FILTER_STOP
		if hovering != null:
			hovering.attempt_drop(dragging)
			hovering = null
		dragging = null
	elif event is InputEventMouseMotion:
		dragging.position += event.relative


func _on_request_created(request: Request):
	request.dropoff.mouse_entered.connect(_on_hover_begun.bind(request.dropoff))
	request.dropoff.mouse_exited.connect(_on_hover_ended)

func _connect_draggable(draggable: Draggable) -> void:
	draggable.drag_begun.connect(_on_drag_begun)
	for dropoff in draggable.dropoffs:
		dropoff.mouse_entered.connect(_on_hover_begun.bind(dropoff))
		dropoff.mouse_exited.connect(_on_hover_ended)


func _on_drag_begun(draggable: Draggable):
	dragging = draggable
	dragging.move_to_front()
	dragging.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_hover_begun(dropoff: Dropoff):
	if dragging != null:
		hovering = dropoff


func _on_hover_ended():
	if dragging != null:
		hovering = null


func _on_data_built(data: Data) -> void:
	_connect_draggable(data)
	$Items.add_child(data)
