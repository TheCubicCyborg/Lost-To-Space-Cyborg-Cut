extends Control

@onready var grid = $NinePatchRect/GridContainer
@onready var nine_patch = $NinePatchRect

var item_slot = preload("res://Modules/Inventory/inventory_slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func init_gui(rows, cols):
	nine_patch.size = Vector2((cols*20 + (cols-1)*2 + 6),(rows*20 + (rows-1)*2 + 6))
	grid.columns = cols
	for x in range(rows):
		for y in range(cols):
			var instance = item_slot.instantiate()
			grid.add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
