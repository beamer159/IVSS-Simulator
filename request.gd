class_name Request
extends PanelContainer


signal finished


enum Format {
	BINARY,
	BASE64,
	HEX
}

enum FinishType {
	CORRECT,
	INCORRECT,
	TIMEOUT
}

var key_size: int
var format: Format
@onready var dropoff = %Dropoff


func _ready() -> void:
	%Progress.value = %Progress.max_value
	key_size = randi_range(1, 4) * 8
	format = Format.get(Format.keys().pick_random())
	%Label.text = str("Please provide me a ", key_size * 8, "-bit symmetric key. I need it to be ", Format.keys()[format].to_lower(), "-encoded.")
	%Dropoff.drop_changed.connect(_on_drop_changed)


func _process(delta: float) -> void:
	%Progress.value -= delta


func _on_drop_changed(_old_value: Draggable):
	var string = %Dropoff.drop.data.get_string_from_ascii()
	var raw: PackedByteArray = string.hex_decode()
	if raw.is_empty():
		if format == Format.HEX:
			_finish(FinishType.INCORRECT)
			return
		else:
			raw = Marshalls.base64_to_raw(string)
			if raw.is_empty():
				if format == Format.BASE64:
					_finish(FinishType.INCORRECT)
					return
				else:
					raw = %Dropoff.drop.data
	var finish_type: FinishType = FinishType.CORRECT if raw.size() == key_size \
		else FinishType.INCORRECT
	_finish(finish_type)


func _finish(finish_type: FinishType):
	finished.emit(finish_type)
	%Dropoff.drop.queue_free()
	queue_free()


func _on_progress_value_changed(value: float) -> void:
	if value == %Progress.min_value:
		finished.emit(FinishType.TIMEOUT)
		queue_free()
