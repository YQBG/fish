extends Node2D  

@export var fish_scene: PackedScene
@export var fish_count: int = 1  # 生成的鱼的数量
@onready var tile_map_layer: TileMapLayer = $Fishpond
  

func _ready(): 
	#随机化随机数发生器的种子
	randomize()
	#拿到鱼塘区域的数据
	var pond_area = tile_map_layer.get_used_rect()
	generate_fish(fish_count,pond_area)
	
# 生成指定数量的鱼并将其放置在鱼塘区域内
func generate_fish(count: int, pond_area: Rect2) -> void:
	#将鱼塘的位置和大小坐标转换为全局坐标
	var global_pos = tile_map_layer.map_to_local(pond_area.position)
	var global_size = tile_map_layer.map_to_local(pond_area.size)
	
	for i in range(count):
		# 生成一个随机位置
		var rand_position = Vector2(
			#这里做减法是因为拿到的位置有偏差，在生成鱼的坐标的时候会有概率出现鱼的坐标在鱼塘外。
			#我也不知道应该如何调整，索性就减去具体的数字。
			randf_range(global_pos.x, (global_pos.x + global_size.x) - 75), 
			randf_range(global_pos.y, (global_pos.y + global_size.y) - 60)
		)
		# 实例化鱼对象
		var fish_instance = fish_scene.instantiate()
		# 设置鱼对象的全局位置
		fish_instance.global_position = rand_position
		# 将鱼添加到节点中
		add_child(fish_instance)
		#将鱼塘区域pond_area作为参数传递过去
		fish_instance.set_pond_area(pond_area)
