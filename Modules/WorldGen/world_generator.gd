extends Node

var surface = FastNoiseLite.new()
@onready var tilemap = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	surface.seed = randi()
	surface.noise_type = FastNoiseLite.TYPE_PERLIN
	for x in range(0,100):
		tilemap.set_cell(0,Vector2i(x,10+int(surface.get_noise_1d(x)*5)),0,Vector2i(0,0))
		#tilemap.set_cell(0,Vector2i(x,10),0,Vector2i(0,0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

