extends Control

const DATA_PATH = "user://mods.json"
const GET_MODS_URL = "https://visionary-maamoul-4af947.netlify.app/.netlify/functions/getMods"

var mod_data = []

@export var UI_Mod_Card: PackedScene

@onready var http_request = $CanvasLayer/HTTPRequest
@onready var mod_list = $TextureRect/MarginContainer/ScrollContainer/ModList

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request.connect("request_completed", Callable(self, "_on_request_compleded"))
	get_tree().connect("files_dropped", Callable(self, "_on_file_dropped"))
	
	# check if stored data exists 
	if(file_check(DATA_PATH)):
		mod_data = file_load(DATA_PATH)
	else:
		# if not send http request
		http_request.request(GET_MODS_URL)
	
	# use the data to build the UI
	generate_UI()

func file_save(content, path):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(content))

func file_load(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return JSON.parse_string(content)

func file_check(path):
	return FileAccess.file_exists(path)

func generate_UI():
	for mod in mod_data:
		var mod_card = UI_Mod_Card.instantiate()
		mod_list.add_child(mod_card)
		mod_card.update_data(mod)
	
func clear_UI():
	for child in mod_list.get_children():
		child.free()

func _on_request_compleded(result, response_code, headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	mod_data = data.data

	# Save to json File
	file_save(mod_data, DATA_PATH)
	
	# Refresh UI
	clear_UI()
	
	generate_UI()


func _on_button_pressed():
	http_request.request(GET_MODS_URL)

func _on_file_dropped(files, screen):
	print(files)
