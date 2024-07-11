class_name Hasher
extends "draggable.gd"


@onready var data_builder = $DataBuilder


func _ready() -> void:
	process_buttons[%Hash] = [%HashFunction, %Data]
	output = %Output
	dropoffs.append(%HashFunction)
	dropoffs.append(%Data)
	%HashFunction.drop_changed.connect(_on_hash_function_changed)
	%Data.drop_changed.connect(_on_drop_changed.bind(%Data))


func _on_hash_function_changed(old_value: Draggable) -> void:
	_on_drop_changed(old_value, %HashFunction)
	var hash_function: HashFunction = %HashFunction.drop
	var hash_name = " " if hash_function == null else hash_function.hash_name
	%HashFunction.text = "Hash\nFunction\n<%s>" % hash_name


func _on_hash_pressed() -> void:
	var ctx: HashingContext = HashingContext.new()
	ctx.start(%HashFunction.drop.hash_function)
	ctx.update(%Data.drop.data)
	var digest: PackedByteArray = ctx.finish()
	$DataBuilder.build(digest, get_output_position())
	clear_dropoffs()
