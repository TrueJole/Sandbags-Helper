extends Button

@export var x_coordinate: int
@export var y_coordinate: int

@export var standard_color: Color
@export var sandbag_color: Color

func _ready() -> void:
	# check if sandbag is located here
	# subtract one to convert to 0 indexed
	if get_parent().get_parent().get_parent().sandbags[x_coordinate-1][y_coordinate-1]:
		set_pressed_no_signal(true)
		$ColorRect.color = sandbag_color
	else:
		set_pressed_no_signal(false)
		$ColorRect.color = standard_color
	print('Loaded:', button_pressed)

func _on_toggled(toggled_on: bool) -> void:
	print('Toggled:', button_pressed)
	get_parent().get_parent().get_parent().sandbags[x_coordinate-1][y_coordinate-1] = toggled_on
	if toggled_on:
		$ColorRect.color = sandbag_color
		get_parent().get_parent().get_parent().count += 1
	else:
		$ColorRect.color = standard_color
		get_parent().get_parent().get_parent().count -= 1
