extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Automatically update the pwa 
	if JavaScriptBridge.pwa_needs_update():
		JavaScriptBridge.pwa_update()
