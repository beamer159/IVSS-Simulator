@tool
class_name HashFunction
extends "draggable.gd"


@export var hash_function: HashingContext.HashType:
	set(v):
		hash_function = v
		%Label.text = hash_name

var hash_name: String:
	get:
		match hash_function:
			HashingContext.HashType.HASH_MD5:
				return "MD5"
			HashingContext.HashType.HASH_SHA1:
				return "SHA1"
			HashingContext.HashType.HASH_SHA256:
				return "SHA256"
			_:
				return "UNKNOWN HASH FUNCTION"
