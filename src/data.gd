class_name Data
extends "draggable.gd"


const charset = "¡¢£¤¥¦§¨©«¬®°±¶·»¼½¾¿Æ×ØÞßæð÷øþŒœ!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ſƒΓΔΘΛΞΠΣΦΨΩαβγδεζηθικλμνξπρςστυφχψωЂЄЉЊЋЏБДЖИЛЧШЬЭЮЯбђ†‡•‰₣₤€℅ℓ⅛⅜⅝⅞∂√∞∫≈≠≤≥◊ϑϒϖѤѦѨѪѬѮѴҀ҂ҔҦҨҴӃӘӾԂԄԈԊԎẞתשרקצץפףעסנןמםלכךיטחזהדגבא₪"


var data: PackedByteArray:
	set(v):
		data = v
		%Value.text = ""
		for i in data:
			%Value.text += charset[i]


func _on_delete_pressed() -> void:
	queue_free()
