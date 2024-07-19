extends Control

@export var rows:int
@export var cols:int

@onready var inventory_gui = $Inventory_GUI

var inventory: Resource = preload("res://Modules/Inventory/player_inventory.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_gui.init_gui(rows, cols)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
