extends Area2D


@onready var directional_light_2d: DirectionalLight2D = $"../DirectionalLight2D"

@onready var player_light: PointLight2D = $"../player/PointLight2D"


func _on_body_entered(_body: Node2D) -> void:
	
	if _body.is_in_group("playergroup"):
		print("You Win!!!")
		directional_light_2d.enabled = false
		player_light.enabled = false
		
	
