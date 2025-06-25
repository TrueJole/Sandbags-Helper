extends Control

const NE = preload("res://Views/NE.tscn")
const ES = preload("res://Views/ES.tscn")
const SW = preload("res://Views/SW.tscn")
const WN = preload("res://Views/WN.tscn")
const GRID = preload("res://Views/grid.tscn")

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
		$DirectionLabel.visible = true

var sandbags: Array[Array]

const directions: Dictionary = {0: "NE", 1: "ES",2: "SW",3: "WN"}
const views: Dictionary = {0: NE, 1: ES,2: SW,3: WN}

var view: Node

var count: int:
	set(value):
		count = value
		$CountLabel.text = str(count) + "/12"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	count = 0
	sandbags.resize(8)
	for array: Array[int] in sandbags:
		array.resize(8)
	direction = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$DirectionLabel.text = str(directions[direction])

func _on_left_button_up() -> void:
	direction -= 1

func _on_right_button_up() -> void:
	direction += 1

func _on_reset_button_up() -> void:
	sandbags = []
	sandbags.resize(8)
	count = 0
	for array: Array[int] in sandbags:
		array.resize(8)
	direction = 0
	$Grid.text = "Show Grid"
	$Grid.set_pressed_no_signal(false)

func _on_grid_toggled(toggled_on: bool) -> void:
	print('Grid Visibility:', toggled_on)
	$Left.visible = not toggled_on
	$Right.visible = not toggled_on
	$DirectionLabel.visible = not toggled_on
	if toggled_on:
		view.queue_free()
		view = GRID.instantiate()
		add_child(view)
		move_child(view, 0)
		$Grid.text = "Show Stairs"
	else:
		direction = direction
		$Grid.text = "Show Grid"
	
