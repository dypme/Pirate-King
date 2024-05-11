extends CanvasLayer

onready var health_bar: = $Control/HBoxContainer/ProgressBar

func _ready() -> void:
	Singleton.ship_health = 150
	Singleton.connect("ship_health_updated", self, "_on_Health_updated")

func _on_Health_updated() -> void:
	health_bar.value = Singleton.ship_health
