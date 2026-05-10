extends Control

@onready var save: Button = $VBoxContainer/Save
@onready var copy: Button = $VBoxContainer/Copy

func _on_save_pressed() -> void:
	print('Saving')
	var img: Image = $SubViewportContainer/SubViewport.get_texture().get_image()
	if OS.get_name() == "Web":
		var buf = img.save_jpg_to_buffer(0.8)
		JavaScriptBridge.download_buffer(buf,"Grid_" + Time.get_date_string_from_system() + "_" + Time.get_time_string_from_system().replace(":", "-") + ".jpg")
	else:
		img.save_jpg(OS.get_system_dir(OS.SYSTEM_DIR_PICTURES) + "/Grid_" + Time.get_date_string_from_system() + "_" + Time.get_time_string_from_system().replace(":", "-") + ".jpg", 0.75)
	save.text = "Saved"
	await get_tree().create_timer(3).timeout
	save.text = "Save Image"

var copyText: Array[Array] = [
	["Error", 3],
	["Error", 3],
	["stop", 3],
	["Error", 3],
	["it's not working", 3],
	["Error", 3],
	["take a hint, dude", 3],
	["Error", 3],
	["""LOOK I have spent HOURS trying to get 
	this copy feature to work. But I have failed.
	Instead, I decided to put in this little easter egg.
	How ironic. Next time you're annoyed that you have
	to drag and drop the downloaded image into the
	Discord, think about this instead.
	I apologize.""", 30],
	["Copied Succesfully", 3]
	]

var counter: int
func _on_copy_pressed() -> void:
	print('Copying')
	var img: Image = $SubViewportContainer/SubViewport.get_texture().get_image()
	if OS.get_name() == "Web":
		copy.text = copyText[counter][0]
		if counter == 9:
			var navigator = JavaScriptBridge.get_interface("navigator")
			var clipboard = navigator.clipboard
			clipboard.writeText("Gotcha")
	else:
		print('Feature not available')
		img.save_jpg(OS.get_system_dir(OS.SYSTEM_DIR_PICTURES) + "/Grid_" + Time.get_date_string_from_system() + "_" + Time.get_time_string_from_system().replace(":", "-") + ".jpg", 0.75)
		copy.text = "NA"
		
	await get_tree().create_timer(copyText[counter][1]).timeout
	counter += 1;
	if counter >= 10:
		counter = 0
	copy.text = "Copy Image"
