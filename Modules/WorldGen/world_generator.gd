extends Node

var flat = FastNoiseLite.new()
var hilly = FastNoiseLite.new()
var caves = FastNoiseLite.new()
var ores = FastNoiseLite.new()
@onready var tilemap = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_surface()
	generate_ores()
	generate_caves()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_ores():
	for x in range(-300,300):
		for y in range(10,300):
			if(randi_range(0,1500) == 1):
				var pat_num = randi_range(0,2)
				tilemap.set_pattern(0,Vector2i(x,y),tilemap.tile_set.get_pattern(pat_num))
				if x >= 295:
					tilemap.set_pattern(0,Vector2i(-300-(300-x),y),tilemap.tile_set.get_pattern(pat_num))

func generate_caves():
	caves.seed = randi()
	caves.frequency = 0.02
	caves.noise_type = FastNoiseLite.TYPE_VALUE
	var radius = 300/PI
	var step = PI/300
	for x in range(-300,300):
		for y in range(-300,300):
			var origin_dist = round(sqrt(pow(x,2)+pow(y,2)))
			if(origin_dist > 10):
				var value = caves.get_noise_3d((radius*cos(x*step)),(radius*sin(x*step)),y)
				if(value > -0.1 and value < 0.1):
					tilemap.erase_cell(0,Vector2i(x,y))
			elif(origin_dist > 5):
				var value = caves.get_noise_3d((radius*cos(x*step)),(radius*sin(x*step)),y)
				var ratio = origin_dist-5/5
				value = value*ratio
				if(value > -0.1 and value < 0.1):
					tilemap.erase_cell(0,Vector2i(x,y))
				
				#tilemap.set_cell(0,Vector2i(x,y),0,Vector2i(0,0))

func generate_surface():
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
		var sample1 = round(flat.get_noise_2dv(Vector2i((radius*cos(x*step)),(radius*sin(x*step))))*5)
		var sample2 = -30 + round(hilly.get_noise_2dv(Vector2i((radius*cos(x*step)),(radius*sin(x*step))))*20)
		var sample
		if((x >= 15 and x < 200) or (x >= -200 and x < -15)):
			sample = sample1
		elif(x >= 220 or x < -220):
			sample = sample2
		elif (x >= 200 and x < 220):
			var ratio = (x-199.0)/20.0
			sample = (sample2*ratio)+(sample1*(1-ratio))
		elif (x >= -5 and x < 5):
			sample = 0
		elif (x >= -15 and x < -5):
			var ratio = -(x+5.0)/10.0
			sample = sample1*ratio
		elif (x >= 5 and x < 15):
			var ratio = (x-4.0)/10.0
			sample = sample1*ratio
		elif(x < -200 and x >= -220):
			var ratio = -(x+199.0)/20.0
			sample = (sample2*ratio)+(sample1*(1-ratio))
		
		#tilemap.set_cell(0,Vector2i(x,sample),0,Vector2i(0,0))
		tilemap.set_cell(0,Vector2i(x,round(sample)),0,Vector2i(2,0))
		
		var plant_test = randi_range(1,20)
		if(plant_test == 1):
			tilemap.set_cell(0,Vector2i(x,round(sample)-1),0,Vector2i(3,2))
		if(plant_test >= 2 and plant_test < 4):
			tilemap.set_cell(0,Vector2i(x,round(sample)-1),0,Vector2i(3,5))
		if(plant_test >= 4 and plant_test < 6):
			tilemap.set_cell(0,Vector2i(x,round(sample)-1),0,Vector2i(2,5))
		if(plant_test >= 6 and plant_test < 8):
			tilemap.set_cell(0,Vector2i(x,round(sample)-1),0,Vector2i(1,6))
		if(plant_test >= 8 and plant_test < 10):
			tilemap.set_cell(0,Vector2i(x,round(sample)-1),0,Vector2i(1,4))
			
		for y in range(round(sample)+1,300):
			tilemap.set_cell(0,Vector2i(x,y),0,Vector2i(0,0))
	
