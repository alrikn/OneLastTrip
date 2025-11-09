# godot_vscode

This was my attempt at using godot (essentially for the first time), in vscode.
I have never worked with game engines, nor have i ever played with game pysics, so i am learning a lot.


## A few reminders of what i learned
This serves both as reminders for me so that i don't make the same mistakes, and also reminds me that there is still plenty of stuff that i don't know (in what i use).


- you can't update the player (or pyhsics in general) willy nilly, you got to ensure they are in proper built-in funcs, and you have to update them with proper funcs.
  - the 2 funcs that i have seen that you can update physics in:
    - func _physics_process(_delta):
    - func _integrate_forces(state):
  - and you can also apparently update values with set_deferred("position", Vector2(100, 100)), (example), but i haven't gotten it to work for me
- if you need to set a timer, here's how you do it (the timer func you link doesn't (can't?) take an input i think):
```gdscript
var timer_code = Timer.new()
    add_child(timer_code) # Add it as a child to the scene tree
    timer_code.wait_time = 2.0 # Set the duration to 5 seconds
    timer_code.one_shot = true # Make it stop after one timer
    # Connect the timeout signal to a function in this script
    timer_code.timeout.connect(_on_timer_code_timeout)
    timer_code.start() # Start the timer
```
