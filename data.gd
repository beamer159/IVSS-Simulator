extends "draggable.gd"
class_name Data


const charset = "αβΓγδζηΘθιΛλμΞξΠπρΣσςτυΦφΨψΩωͱͶͷϐ!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ϑϘϙϚϛϞϟϠϡϢϣϤϥϦϧϨϩϪϫϬϭϮϯϰϱ¡¢£¤¥¦§©«¬®±¶»¼½¾¿Æ×Þßæ÷þ♩♪♫♬♭♮♯☼☾☆∀∂∃∆∇∈∋√∝∞∟∠∩∫∴∵≀≈≤≥⊂⊃⊢⊣⊥⊨⊩□▭▯△▷▽◁◇○◸◹◺◿←↑→↓↔↕↖↗↘↙⌗⌘ƆƍƐƱƸǝɅɐɥɯɹʇʍʎʞʁſ"


var data: PackedByteArray:
	set(v):
		data = v
		%Value.text = ""
		for i in data:
			%Value.text += charset[i]


func _ready():
	drag_blacklist.append(%Delete)


func _on_delete_pressed() -> void:
	queue_free()
