extends Control

@onready var button_file_dialog = $ButtonFileDialog
@onready var file_dialog = $FileDialog
@onready var path_exe = $VBoxContainer/BrotatoExePath/Path
@onready var drop = $VBoxContainer/Drop


# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().files_dropped.connect(on_files_dropped)
	
	# Check if game exe is stored
	if (Store.data.game_exe):
		path_exe.text = Store.data.game_exe
		button_file_dialog.hide()
	else:
		drop.hide()

func on_files_dropped(files):
	print(files)
	for file in files:
		# check if .pkg file
		
		# copy file in game folder
		Utils.file_copy(file, Store.data.game_path)


func _on_button_file_dialog_pressed():
	file_dialog.show()

func _on_file_dialog_file_selected(path):
	print("file selected")
	Store.data.game_exe = path
	var path_split = path.split('/')
	Store.data.game_path = path.replace(path_split[path_split.size() - 1] , '')
	print(Store.data.game_exe)
	print(Store.data.game_path)
