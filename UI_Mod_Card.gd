extends VBoxContainer

@onready var mod_name = $Name
@onready var author = $ModInfo/Author
@onready var description = $ModInfo/Description
@onready var game_version = $ModInfo/GameVersion
@onready var last_updated = $ModInfo/LastUpdated
@onready var download_page = $ModInfo/DownloadPage

var dowload_page_url = ""

func update_data(mod_data):
	mod_name.text = mod_data.name
	author.text = mod_data.author
	description.text = mod_data.description
	game_version.text = mod_data.game_version
	last_updated.text = mod_data.last_updated
	download_page.text = "Download Page"
	dowload_page_url = mod_data.download_path



func _on_download_page_pressed():
	OS.shell_open(dowload_page_url)
