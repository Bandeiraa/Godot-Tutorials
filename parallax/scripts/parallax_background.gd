extends ParallaxBackground

onready var cloud_layer: ParallaxLayer = get_node("ParallaxLayer1")
onready var light_environment: CanvasModulate = get_node("LightEnvironment")

export(Color) var ambient_color

export(float) var layer_speed = 9.6

export(bool) var ambient_light = false

func _ready() -> void:
	light_environment.visible = ambient_light
	light_environment.color = ambient_color
	
	
func _physics_process(delta: float) -> void:
	cloud_layer.motion_offset.x -= layer_speed * delta
