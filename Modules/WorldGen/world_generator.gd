extends Node

var flat = FastNoiseLite.new()
var hilly = FastNoiseLite.new()
@onready var tilemap = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	flat.seed = randi()
	hilly.seed = randi()
	flat.fractal_type = FastNoiseLite.FRACTAL_NONE
	hilly.fractal_type = FastNoiseLite.FRACTAL_NONE
	flat.noise_type = FastNoiseLite.TYPE_PERLIN
	hilly.noise_type = FastNoiseLite.TYPE_PERLIN
	flat.frequency = 0.05
	hilly.frequency = 0.05
	hilly.domain_warp_enabled = 1
	hilly.domain_warp_fractal_type = FastNoiseLite.DOMAIN_WARP_FRACTAL_NONE
	
	var radius = 300/PI
	var step = PI/300
	
	for x in range(-300,300):
		var sample1 = 50 + round(flat.get_noise_2dv(Vector2i((radius*cos(x*step)),(radius*sin(x*step))))*5)
		var sample2 = 30 + round(hilly.get_noise_2dv(Vector2i((radius*cos(x*step)),(radius*sin(x*step))))*20)
		var sample
		if(x < 200 and x > -200):
			sample = sample1
		elif(x >= 220 or x <= -220):
			sample = sample2
		elif (x >= 200 and x < 220):
			var ratio = (x-199.0)/20.0
			sample = (sample2*ratio)+(sample1*(1-ratio))
		elif(x <= -200 and x > -220):
			var ratio = -(x+199.0)/20.0
			sample = (sample2*ratio)+(sample1*(1-ratio))
		
		#tilemap.set_cell(0,Vector2i(x,sample),0,Vector2i(0,0))
		if(x < 0):
			tilemap.set_cell(0,Vector2i(x+300,sample),0,Vector2i(0,0))
		elif(x>= 0):
			tilemap.set_cell(0,Vector2i(x-300,sample),0,Vector2i(0,0))
			
		if(x == -300):
			print(sample2)
		if(x == 299):
			print(sample2)
		#tilemap.set_cell(0,Vector2i(x,50 + sample2),0,Vector2i(0,0))
		#tilemap.set_cell(0,Vector2i(x,10),0,Vector2i(0,0))
		#tilemap.set_cell(0,Vector2i((radius*cos(x*step)),(radius*sin(x*step))),0,Vector2i(0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
