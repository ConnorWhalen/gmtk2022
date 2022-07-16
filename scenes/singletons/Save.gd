extends Node

var SAVE_FILE_NAME = "user://save_file.save"

enum STAT_INDEX {
	SPEED = 0,
	EFFICIENCY = 1,
	RUDDER = 2,
	PADDLE = 3,
	STAT_INDEX_max,
}

var save_data

func _ready():
	save_data = pull_stats()

func pull_stats():
	var save_file = File.new()

	var save_stats_tmp = {}

	save_file.open(SAVE_FILE_NAME, File.READ)
	var save_object = save_file.get_var()

	# fetch save, provide default if not found
	if save_object:
		save_stats_tmp = save_object
	else:
		save_stats_tmp["cash"] = 0
		save_stats_tmp["stats"] = []
		for i in range(STAT_INDEX.STAT_INDEX_max):
			save_stats_tmp["stats"].append({"count": 0})

	save_file.close()

	return save_stats_tmp

func push_stats():

	var save_file = File.new()
	save_file.open(SAVE_FILE_NAME, File.WRITE)
	save_file.store_var(save_data)
	save_file.close()

func reset_stats():
	var save_file = File.new()
	save_file.open(SAVE_FILE_NAME, File.WRITE)
	save_file.close()
	save_data = pull_stats()
