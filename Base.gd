extends Control

@onready var http_request = $CanvasLayer/HTTPRequest


var mod_links = []

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request.connect("request_completed", Callable(self, "_on_request_compleded"))
	
	
func _on_request_compleded(result, response_code, headers, body):
	var parser = XMLParser.new()
	parser.open_buffer(body)
	
	while parser.read() != ERR_FILE_EOF:
		var node_name = parser.get_node_name()
		if node_name == "a" and parser.has_attribute("href"):
			var attribute_0 = parser.get_attribute_value(0)
			if attribute_0.begins_with("/Mod:"):
				if mod_links.find(attribute_0) == -1:
					print(attribute_0)
					mod_links.append(attribute_0)
	
	print(mod_links)


func _on_button_pressed():
	http_request.request("https://brotato.wiki.spellsandguns.com/Modding")
