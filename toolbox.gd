extends PanelContainer


func setup(rng: Rng, base64: Base64, hex: Hex):
	%Rng.toggled.connect(func(t): _on_toggled(t, rng))
	%Base64.toggled.connect(func(t): _on_toggled(t, base64))
	%Hex.toggled.connect(func(t): _on_toggled(t, hex))


func _on_toggled(toggled_on: bool, to_toggle: Control):
	to_toggle.visible = toggled_on

