extends Node


func file_save(content, path):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(content))

func file_load(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return JSON.parse_string(content)

func file_check(path):
	return FileAccess.file_exists(path)
	
func file_copy(src, dest):
	var file_name = get_file_from_path(src)
	return DirAccess.copy_absolute(src, str(dest,'/',file_name))
	
func remove_file_from_path(path):
	var path_split = path.split('/')
	return path.replace(path_split[path_split.size() - 1] , '')
	
func get_file_from_path(path):
	var path_split = path.split('\\')
	print(path_split)
	return path_split[path_split.size() - 1]
