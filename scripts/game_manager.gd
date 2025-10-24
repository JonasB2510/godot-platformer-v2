extends Node

var score = 0

@onready var coin_summary: Label = %CoinSummary

func add_point():
	score += 1
	coin_summary.text = "You have collected %s coins." %[str(score)]
