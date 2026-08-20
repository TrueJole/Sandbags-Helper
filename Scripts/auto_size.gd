extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		var global_theme: Theme = ThemeDB.get_project_theme()
		global_theme.set_font_size("font_size", "Button", 35)
	
