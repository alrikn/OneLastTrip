extends AnimatedSprite2D

var player: RigidBody2D

func _ready():
       visible = false
       player = get_parent() as RigidBody2D
       animation = "thrust"

func _physics_process(_delta):
       if not player:
              print(" not player")
              return

       # When the player is applying upward thrust
       if player.apply_upwards_acc:
              if !visible and player.exploding == false:
                     visible = true
                     play()  # resume from current frame
       else:
              if visible:
                     visible = false
                     pause()  # keep frame position instead of resetting to 0
