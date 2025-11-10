# TODO list

this is a todo list to investigate and/or implement things that i hear about or am struggling to understand. (not ordered)

- [ ] investigate state machine that deals with input
- [x] why does rotation slow down and stop, but linear velocity doesn't
  - its because of default values in godot engine (we can change it in tscn file):
    | Property       | Default | Effect                   |
    | -------------- | ------- | ------------------------ |
    | `linear_damp`  | 0       | no slowdown              |
    | `angular_damp` | 1       | rotation slows and stops |

- [ ] how to implement rotation
- [ ] how to implement thrust based of the players angle (so making a rocket), instead of absolute up and down
- [ ] find out how to measure speed
- [ ] figure out how to display a text box with lin vel, rot vel, height
- [ ] figure how to ensure that the player is never under the camera (i feel like we should always be able to see it fall), while still keeping camera smoothness.
