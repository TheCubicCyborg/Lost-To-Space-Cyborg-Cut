extends Control

@export var rows: int
@export var cols: int

@onready var grid = $NinePatchRect/GridContainer
@onready var nine_patch = $NinePatchRect

var item_slot = preload("res://inventory_slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	nine_patch.size = Vector2((cols*20 + (cols-1)*2 + 6),(rows*20 + (rows-1)*2 + 6))
	grid.columns = cols
	for x in range(rows):
		for y in range(cols):
			var instance = item_slot.instantiate()
			grid.add_child(instance)
			instance.inventory_manager = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
