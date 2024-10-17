extends Node

# Variável que referencia a scene do Inimigo para instanciar várias cópias
@export var enemy_scene: PackedScene
var score

func _ready():
	new_game()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()

func _on_enemy_timer_timeout():
	# Cria uma nova instancia do Enemy scene
	var enemy = enemy_scene.instantiate()
	# Escolha uma localização randomica no Path2D
	var enemy_spawn_position = $EnemyPath/EnemySpawnPosition
	enemy_spawn_position.progress_ratio = randf()	
	# Define a direção perpendicular ao path Direction 
	# (Ex: Path apontando para baixo, Direction deve ser para esquerda)
	var direction = enemy_spawn_position.rotation + PI / 2
	# Define a posição do mob para a localização aleatória
	enemy.position = enemy_spawn_position.position
	# Adiciona algumas aleatoriedades na direção
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	# Velocidade do mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)
	# Adiciona enamy na Main scene
	add_child(enemy)

func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()
