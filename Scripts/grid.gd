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

var counter: int
func _on_copy_pressed() -> void:
	print('Copying')
	var imgage_buffer = $SubViewportContainer/SubViewport.get_texture().get_image().save_png_to_buffer()
	if OS.get_name() == "Web":
		var byte_array: Array = []
		byte_array.assign(imgage_buffer)
		var byte_string := JSON.stringify(byte_array)
		var copy_js_code := """
	    (async () => {
	        try {
	            const bytes = new Uint8Array(%s);

	            const blob = new Blob([bytes], { type: 'image/png' });

	            await navigator.clipboard.write([
	                new ClipboardItem({
	                    'image/png': blob
	                })
	            ]);

				console.log("Image copied to clipboard");
	        } catch (err) {
				console.error("Clipboard write failed:", err);
	        }
	    })();
		""" % byte_string
		JavaScriptBridge.eval(copy_js_code)
		print("Copied grid.")
		copy.text = "Copied"
		await get_tree().create_timer(3).timeout
		copy.text = "Copy Image"
	else:
		print('Feature not available')
		copy.text = "NA"
