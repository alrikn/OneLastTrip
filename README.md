# One Last Trip 🚀

A physics-based arcade rescue game made in Godot 4. Pilot a rocket, try not to crash, and save as many people as you can before escaping.

## 🎮 Features

* **Physics Flight:** You control the thrust and torque. There's a custom PD-controller stabilizer mapped to the spacebar to keep you from spinning out completely.
* **Arcade Scoring:** Stop near victims to rescue them (+10 points), but exploding costs you (-5 points). 
* **Win/Loss:** The game ends if you run out of time, or you win if you fly high enough to reach the escape line.
* **Save Data:** High scores are automatically saved to your local machine.

## 🛠️ How to run it from the terminal

If you want to run this directly from your command line without opening the Godot Editor, you just need the Godot 4 binary set up in your system's PATH.

### Setting up the Godot binary (Linux/Unix)

1. Download the standard Godot 4 Linux build from the [official site](https://godotengine.org/).
2. Unzip it to get the binary file (e.g., `Godot_v4.x-stable_linux.x86_64`).
3. Move and rename the binary so your terminal recognizes the `godot` command globally:
   ```bash
   sudo cp Godot_v4.x-stable_linux.x86_64 ~/.local/bin/godot
   chmod +x ~/.local/bin/godot
    ```

### Execution

Once `godot` is recognized as a command, navigate to the root folder of this project and run:
```bash
    godot --path .
```

## ⌨️ Controls

- Up Arrow: Main Thrust 
- Left Arrow: Rotate Left
- Right Arrow: Rotate Right
- S Key: Auto-Stabilize
- R Key: Self-Destruct



## 📄 License & Credits
See [CREDITS.md](./CREDITS.md) for asset attributions and licenses.