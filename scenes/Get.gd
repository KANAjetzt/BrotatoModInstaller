extends MarginContainer

const GET_MODS_URL = "https://visionary-maamoul-4af947.netlify.app/.netlify/functions/getMods"

@export var UI_Mod_Card: PackedScene

@onready var http_request = $CanvasLayer/HTTPRequest
@onready var mod_list = $ScrollContainer/ModList

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request.connect("request_completed", Callable(self, "_on_request_compleded"))
	
	# check if stored data exists 
	if(Store.data.mod_data.size() == 0):
		http_request.request(GET_MODS_URL)
	
	# use the data to build the UI
	generate_UI()



func generate_UI():
	for mod in Store.data.mod_data:
		var mod_card = UI_Mod_Card.instantiate()
		mod_list.add_child(mod_card)
		mod_card.update_data(mod)
	
func clear_UI():
	for child in mod_list.get_children():
		child.free()

func _on_request_compleded(result, response_code, headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	Store.data.mod_data = data.data
	
	# Refresh UI
	clear_UI()
	
	generate_UI()


func _on_button_pressed():
	http_request.request(GET_MODS_URL)


