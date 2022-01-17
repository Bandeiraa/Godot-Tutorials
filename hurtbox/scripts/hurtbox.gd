extends Area2D
class_name Hurtbox

export(int) var damage

func on_body_entered(body) -> void:
	if body.is_in_group("Enemy"):
		body.update_health(damage)
		
		
func on_area_entered(area) -> void:
	if area.is_in_group("Enemy"):
		area.update_health(damage)
