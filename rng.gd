class_name Rng
extends "draggable.gd"


var crypto: Crypto = Crypto.new()
@onready var data_builder = $DataBuilder


func _ready():
	output = %Output


func _on_generate_pressed() -> void:
	if %Size.text.is_valid_int():
		var data_size = int(%Size.text)
		var data = crypto.generate_random_bytes(data_size)
		data_builder.build(data, get_output_position())
		%Size.clear()
