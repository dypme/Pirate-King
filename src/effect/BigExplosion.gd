extends Node2D

signal peak_explosion

func on_peak_explosion() -> void:
	emit_signal("peak_explosion")
