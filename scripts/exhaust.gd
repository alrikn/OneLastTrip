extends AnimatedSprite2D

var player: RigidBody2D

func _ready():
       visible = false
       player = get_parent() as RigidBody2D

func _physics_process(_delta):
       if not player:
              print(" not player")
              return

       # When the player is applying upward thrust
       if player.apply_upwards_acc:
              if !visible and player.exploding == false:
                     visible = true
                     play("thrust")  # plays and loops your thrust animation
       else:
              if visible:
                     visible = false
                     stop()
