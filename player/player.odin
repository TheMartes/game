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

PlayerCollisionBox : rl.Rectangle
AvailableAnimations : PlayerAnimations
CurrentAnimation : PlayerAnimation
CurrentPlayer : Player

InitializePlayer :: proc() {
    CurrentPlayer = Player{
        1500, // base speed
        5, // scale factor
        rl.Vector2{320, 240}, // player pos
        rl.Vector2{0, 0}, // player velocity
        false, // grounded
        false, // flip
        0, // frame timer
        0, // current frame
    }

    PlayerCollisionBox = rl.Rectangle{
        CurrentPlayer.player_pos.x - 16,
        CurrentPlayer.player_pos.y - 16,
        32,
        32,
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
