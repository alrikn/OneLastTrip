# TODO list

this is a todo list to investigate and/or implement things that i hear about or am struggling to understand or simply want to implement. (not ordered)

- [ ] investigate state machine that deals with input
- [x] why does rotation slow down and stop, but linear velocity doesn't
  - its because of default values in godot engine (we can change it in tscn file):
    | Property       | Default | Effect                   |
    | -------------- | ------- | ------------------------ |
    | `linear_damp`  | 0       | no slowdown              |
    | `angular_damp` | 1       | rotation slows and stops |

- [x] how to implement rotation
- [x] how to implement thrust based of the players angle (so making a rocket), instead of absolute up and down
- [x] find out how to measure speed
- [x] figure out how to display a text box with lin vel, rot vel, height
- [ ] figure how to ensure that the player is never under the camera (i feel like we should always be able to see it fall), while still keeping camera smoothness.
- [ ] figure out how to implement a sprite sheet for the rocket exhaust.
- [ ] figure out how to make it explode if its touching ground and on its side (or if it touches the ground too fast)
  - [ ] make a explosion sprite sheet for death
- [x] make a reset button
- [ ] implement an animation (preferably programmatically), displaying white exhaust smoke for the rotation acceleration and linear accelaration
  - [ ] every exhaust frame has to be 28px wide by 79px high
