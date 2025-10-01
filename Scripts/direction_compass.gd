extends Control
@onready var n_label: RichTextLabel = $NLabel
@onready var e_label: RichTextLabel = $ELabel
@onready var s_label: RichTextLabel = $SLabel
@onready var w_label: RichTextLabel = $WLabel

var tween: Tween

const DURATION: float = 0.3

func _ready() -> void:
	tween = create_tween()
	tween.stop()

func turnRight() -> void:
	# fininish rotating
	if tween.is_running():
		tween.custom_step(DURATION)
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_parallel(true)
	
	tween.tween_property(self, "rotation", rotation + deg_to_rad(90), DURATION)
	tween.tween_property(n_label, "rotation", n_label.rotation - deg_to_rad(90), DURATION)
	tween.tween_property(e_label, "rotation", e_label.rotation - deg_to_rad(90), DURATION)
	tween.tween_property(s_label, "rotation", s_label.rotation - deg_to_rad(90), DURATION)
	tween.tween_property(w_label, "rotation", w_label.rotation - deg_to_rad(90), DURATION)

func turnLeft() -> void:
	# fininish rotating
	if tween.is_running():
		tween.custom_step(DURATION)
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_parallel(true)
	
	tween.tween_property(self, "rotation", rotation - deg_to_rad(90), DURATION)
	tween.tween_property(n_label, "rotation", n_label.rotation + deg_to_rad(90), DURATION)
	tween.tween_property(e_label, "rotation", e_label.rotation + deg_to_rad(90), DURATION)
	tween.tween_property(s_label, "rotation", s_label.rotation + deg_to_rad(90), DURATION)
	tween.tween_property(w_label, "rotation", w_label.rotation + deg_to_rad(90), DURATION)
