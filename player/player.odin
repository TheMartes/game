package player

import rl "vendor:raylib"

Player :: struct {
    base_speed: f32,
    scale_factor: i32,
    player_pos: rl.Vector2,
    player_vel: rl.Vector2,
    player_grounded: bool,
    player_flip: bool,
    anim_frame_timer: f32,
    anim_current_frame: int,
    is_attacking: bool,
}

PlayerAnimations :: struct {
    walking: PlayerAnimation,
    idle: PlayerAnimation,
    attack: PlayerAnimation,
    // hurt: PlayerAnimation,
    // death: PlayerAnimation,
}

PlayerAnimation :: struct {
    name: string,
    texture: rl.Texture2D,
    num_frames: int,
    frame_length: f32,
}

AvailableAnimations : PlayerAnimations
CurrentAnimation : PlayerAnimation
CurrentPlayer : Player

InitializePlayer :: proc() {
    CurrentPlayer = Player{
        500, // base speed
        4, // scale factor
        rl.Vector2{320, 240}, // player pos
        rl.Vector2{0, 0}, // player velocity
        false, // grounded
        false, // flip
        0, // frame timer
        0, // current frame
        false, // is attacking
    }

    AvailableAnimations = PlayerAnimations{
        PlayerAnimation{
            "walking",
            rl.LoadTexture("assets/soldier_walking.png"),
            8,
            f32(0.1)
        },
        PlayerAnimation{
            "idle",
            rl.LoadTexture("assets/soldier_idle.png"),
            6,
            f32(0.1)
        },
        PlayerAnimation{
            "attack",
            rl.LoadTexture("assets/soldier_attack.png"),
            6,
            f32(0.1)
        },
    }

    CurrentAnimation = AvailableAnimations.idle
}
