extends Control

const NE = preload("res://Views/NE.tscn")
const ES = preload("res://Views/ES.tscn")
const SW = preload("res://Views/SW.tscn")
const WN = preload("res://Views/WN.tscn")
const GRID = preload("res://Views/grid.tscn")
const INFO = preload("res://Views/info.tscn")

const SESSION_FILENAME: String = "user://session.json"

var direction: int:
	set(value):
		direction = value
		if direction < 0:
			direction += 4
		elif direction > 3:
			direction -= 4
		
		if view: view.queue_free()
		
		view = views[direction].instantiate()
		add_child(view)
		move_child(view, 0)
		$Left.visible = true
		$Right.visible = true
		$DirectionCompass.visible = true

var sandbags: Array[Array]

#const directions: Dictionary = {0: "NE", 1: "ES",2: "SW",3: "WN"}
const views: Dictionary = {0: NE, 1: ES,2: SW,3: WN}

var view: Node
@onready var grid: Button = $HBoxContainer/Grid
@onready var info: Button = $HBoxContainer/Info

var count: int:
	set(value):
		count = value
		$CountLabel.text = str(count) + "/12"
		save_session()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_last_session()
	direction = 0

func load_last_session():
	count = 0
	sandbags.resize(8)
	for array: Array[int] in sandbags:
		array.resize(8)
	var file: FileAccess = FileAccess.open(SESSION_FILENAME, FileAccess.READ)
	if FileAccess.file_exists(SESSION_FILENAME):
		var session: Dictionary = JSON.to_native(JSON.parse_string(file.get_as_text()))
		print(session)
		if session["sandbags"]:
			sandbags = session["sandbags"] 
		count = session["count"]
		print("Loaded session")
	else:
		print("No session found")

func save_session():
	if sandbags:
		var file: FileAccess = FileAccess.open(SESSION_FILENAME, FileAccess.WRITE)
		var session: Dictionary = {"sandbags": sandbags, "count": count}
		file.store_string(JSON.stringify(JSON.from_native(session)))
		print("Saving session")

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_left"):
		_on_left_button_up()
	if event.is_action_released("ui_right"):
		_on_right_button_up()

func _on_left_button_up() -> void:
	$DirectionCompass.turnLeft()
	direction -= 1

func _on_right_button_up() -> void:
	$DirectionCompass.turnRight()
	direction += 1

func _on_reset_button_up() -> void:
	sandbags = []
	sandbags.resize(8)
	count = 0
	for array: Array[int] in sandbags:
		array.resize(8)
	direction = 0
	grid.text = "Show Grid"
	grid.set_pressed_no_signal(false)

func _on_grid_toggled(toggled_on: bool) -> void:
	print('Grid Visibility:', toggled_on)
	$Left.visible = not toggled_on
	$Right.visible = not toggled_on
	$DirectionCompass.visible = not toggled_on
	if toggled_on:
		view.queue_free()
		view = GRID.instantiate()
		add_child(view)
		move_child(view, 0)
		grid.text = "Show Stairs"
	else:
		direction = direction
		grid.text = "Show Grid"

func _on_info_pressed() -> void:
	var temp = INFO.instantiate()
	add_child(temp)

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	get_viewport().get_window().mode = Window.MODE_FULLSCREEN if toggled_on else Window.MODE_WINDOWED
