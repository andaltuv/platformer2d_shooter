extends Area2D

var bala_mov = Vector2()
var bala_vel = 90
var direccion = 1

func direccion_bala(dir):
	print(dir)
	direccion = dir
	if dir == -1:
		$Sprite.flip_h = true
		
func _physics_process(delta):
	bala_mov.x += bala_vel * delta * direccion
	translate(bala_mov)

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_Bala_area_entered(area):
	area.queue_free()
