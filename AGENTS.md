# Agent Guidelines for Dino Roguelike

## Project Type
Godot 4.4 game project using GDScript with GL Compatibility renderer.

## Code Style (GDScript)
- **Indentation**: Use tabs (as per .editorconfig)
- **Encoding**: UTF-8
- **Naming**: snake_case for variables/functions, PascalCase for classes/nodes
- **Node inheritance**: Use `extends` keyword (e.g., `extends CharacterBody2D`)
- **Variables**: Declare with `var` keyword, use type hints when possible
- **Scene structure**: Main scenes in `src/`, assets in `assets/`
- **File organization**: `.gd` scripts alongside `.tscn` scene files

## GENERAL PRINCIPLES
Prioritize readability and maintainability over cleverness

Keep functions short and focused on one task

Write self-explanatory code to minimize the need for comments

Use scenes as reusable, modular components

Avoid unnecessary nesting in the scene tree

Commit only working code unless pushing to a feature branch

## CODING STANDARDS
Language: GDScript (Godot’s built-in scripting language)

Indentation: 4 spaces (no tabs)

Max line length: 100 characters

Use snake_case for variables and functions

Use PascalCase for class names and scene file names

Always use explicit types when possible

Avoid magic numbers – use constants or configuration variables

Use match instead of chained if/else when checking enums or discrete values

Use @onready for node references when possible

Never use get_node() with hard-coded strings in production code – use $Node shorthand or exported NodePaths

Example:

`@onready var player_sprite: Sprite2D = $PlayerSprite`

## NAMING CONVENTIONS
Variables:

snake_case

Descriptive and specific names

Boolean variables should start with is_, has_, can_, or should_

Examples:

player_health

is_enemy_visible

should_reload

Functions:

snake_case

Named using verb_noun pattern for clarity

Examples:

move_player()

update_health_bar()

spawn_enemy_wave()

Classes:

PascalCase

Class name should match the script filename and scene (if attached to a scene)

Scenes:

PascalCase

Use suffixes to indicate purpose: MainMenu.tscn, EnemyAI.tscn, HealthBar.tscn

Nodes:

Use consistent naming for standard elements: e.g., Sprite, Collision, Timer

Prefix optional: e.g., player_sprite, enemy_collision

Signals:

Use past tense to indicate event: health_depleted, enemy_spawned

Scripts:

Match the class and scene name

Use suffix if needed: Enemy.gd, EnemyAI.gd, GameController.gd

Constants:

SCREAMING_SNAKE_CASE

Examples:

MAX_HEALTH

TILE_SIZE

## FILE STRUCTURE
res://
├── assets/ # Art, audio, fonts, etc.
│ ├── sprites/
│ ├── audio/
│ ├── fonts/
├── scenes/ # All .tscn files
│ ├── ui/
│ ├── levels/
│ ├── characters/
├── scripts/ # All .gd files
│ ├── core/ # Game singleton, utilities
│ ├── entities/ # Player, NPCs, enemies
│ ├── ui/ # UI scripts
├── globals/ # AutoLoad scripts (singleton/global state)
├── data/ # JSON, config files
├── addons/ # Godot plugins
└── main.tscn # Entry point of the game

Notes:

Each scene and its script should live in their respective folders, but with mirrored structure

Avoid deeply nested folders

## SCENES AND SCRIPTING
One scene per logical component (enemy, player, UI element, etc.)

Use composition over inheritance

Scripts should attach to the top-level node of their scene

Avoid cyclic dependencies and tight coupling

Keep UI logic separate from gameplay logic

AUTOLoads (Singletons)
Should only be used for global state or services

Prefix with Global or Manager if useful (e.g., AudioManager, GameState)

Keep them slim, and don’t overload with logic that belongs in scene scripts

## VERSION CONTROL
Use .gitignore to exclude .import, .godot, and export/ folders

Commit scenes and scripts together

Lock scene files when editing to avoid merge conflicts

## DOCUMENTATION AND COMMENTS
Comment why, not what – only if not obvious

Use docstring-style comments for functions where needed

If writing complex logic, explain edge cases or assumptions

## TESTING AND DEBUGGING
Use assertions for assumptions in development

Use debug prints prefixed with [DEBUG] and remove them before release

Create test scenes for features like movement, animation, etc.

## CODE REVIEWS
Review all PRs for naming, structure, and clarity

Avoid merging unfinished features into main

Keep feature branches short-lived

## Input Maps

Wherever possible, use Input Maps. Instead of hardcoding input keys and buttons, add a named input into project.godot under the heading `[input]`. For example, this would add a named input called "jump" and add a binding to the space key (with no modifiers):
```
jump={
"deadzone": 0.2,
"events": [Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":32,"key_label":0,"unicode":32,"location":0,"echo":false,"script":null)
]
}
```

