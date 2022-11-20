extends Node

const DATA_PATH = "user://mods.json"

var data = {
	'game_path': '',
	'game_exe': '',
	'mod_data': [],
	'installed_mods': []
}

func _ready():
	if(Utils.file_check(DATA_PATH)):
		data = Utils.file_load(DATA_PATH)
	else:
		print("No save file found!")

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		# save data
		Utils.file_save(data, DATA_PATH)
		
		get_tree().quit() # default behavior
