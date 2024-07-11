extends PanelContainer


func setup(rng: Rng, base64: Base64, hex: Hex, hasher: Hasher, md5: HashFunction, sha1: HashFunction, sha256: HashFunction):
	%Rng.toggled.connect(func(t): _on_toggled(t, rng))
	%Base64.toggled.connect(func(t): _on_toggled(t, base64))
	%Hex.toggled.connect(func(t): _on_toggled(t, hex))
	%Hasher.toggled.connect(func(t): _on_toggled(t, hasher))
	%MD5.toggled.connect(func(t): _on_toggled(t, md5))
	%SHA1.toggled.connect(func(t): _on_toggled(t, sha1))
	%SHA256.toggled.connect(func(t): _on_toggled(t, sha256))


func _on_toggled(toggled_on: bool, to_toggle: Control):
	to_toggle.visible = toggled_on

