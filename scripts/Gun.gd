extends Area2D

func _on_Gun_body_entered(body):
	if body.name == "Player": body.tiene_arma(true)
	get_node(".").queue_free()
