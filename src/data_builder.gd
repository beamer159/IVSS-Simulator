extends Node


signal data_built


func build(bytes: PackedByteArray, position: Vector2):
	var data = preload("res://src/data.tscn").instantiate()
	data.data = bytes
	data.position = position
	data_built.emit(data)
