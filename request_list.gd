extends PanelContainer


signal request_created

var pending: int:
	set(v):
		pending = v
		%Pending.text = str("Pending: ", pending)

var fullfilled: int:
	set(v):
		fullfilled = v
		%Fullfilled.text = str("Fullfilled: ", fullfilled)

var failed: int:
	set(v):
		failed = v
		%Failed.text = str("Failed: ", failed)


func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.set_loops(10)
	tween.tween_callback(create_request)
	tween.tween_interval(10)
	tween.play()


func create_request() -> void:
	var request: Request = preload("res://request.tscn").instantiate()
	%Requests.add_child(request)
	request.finished.connect(_on_request_finished)
	pending += 1
	request_created.emit(request)


func _on_request_finished(finish_type: Request.FinishType) -> void:
	pending -= 1
	match finish_type:
		Request.FinishType.CORRECT:
			fullfilled += 1
		_:
			failed += 1
