extends HSlider

export var audio_bus_name := "Master"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _ready() -> void:
	value = db2linear(AudioServer.get_bus_volume_db(_bus))*100
	print(value)

func _on_Volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_bus, linear2db(value/100))
	Save.save_data["volume"] = value
	Save.push_stats()
