extends "draggable.gd"
class_name Base64


@onready var data_builder = $DataBuilder


func _ready() -> void:
	drag_blacklist.append(%Encode)
	drag_blacklist.append(%Decode)
	drag_blacklist.append(%Data)
	process_buttons[%Encode] = [%Data]
	process_buttons[%Decode] = [%Data]
	dropoffs.append(%Data)
	output = %Output
	%Data.drop_changed.connect(_on_drop_changed)


func handle(c: Control):
	if c is Data:
		handle_data(c.value)
		c.queue_free()


func handle_data(data: PackedByteArray) -> void:
	var bytes: PackedByteArray
	if %Encode.is_pressed():
		bytes = Marshalls.raw_to_base64(data).to_ascii_buffer()
	else:
		bytes = Marshalls.base64_to_raw(data.get_string_from_ascii())
		if bytes.is_empty():
			bytes = Crypto.new().generate_random_bytes(data.size() * 3 / 4)
	$DataBuilder.build(bytes, position + Vector2(size.x, 0))


func _on_encode_pressed() -> void:
	var bytes: PackedByteArray = Marshalls.raw_to_base64(%Data.drop.data).to_ascii_buffer()
	$DataBuilder.build(bytes, get_output_position())
	clear_dropoffs()


func _on_decode_pressed() -> void:
	var bytes: PackedByteArray = Marshalls.base64_to_raw(%Data.drop.data.get_string_from_ascii())
	if bytes.is_empty():
		bytes = Crypto.new().generate_random_bytes(%Data.drop.data.size() * 3 / 4)
	$DataBuilder.build(bytes, get_output_position())
	clear_dropoffs()
