package player

import rl "vendor:raylib"
import "core:fmt"
import "core:math"
import "core:time"

HandleMovement :: proc() {
        baseMovement := CurrentPlayer.base_speed * rl.GetFrameTime()

        if (rl.IsKeyDown(.A) && !PlayerHitLeftBoundary()) {
            if (CurrentPlayer.player_vel.x > 0) {
                CurrentPlayer.player_vel.x = 0
            } else if (!(CurrentPlayer.player_vel.x < CurrentPlayer.base_speed * -1)) {
                CurrentPlayer.player_vel.x += -baseMovement
            }

            CurrentAnimation = AvailableAnimations.walking
            CurrentPlayer.player_flip = true
        } else if (rl.IsKeyDown(.D) && !PlayerHitRightBoundary()) {
            if (CurrentPlayer.player_vel.x < 0) {
                CurrentPlayer.player_vel.x = 0
            } else if (!(CurrentPlayer.player_vel.x > CurrentPlayer.base_speed)) {
                CurrentPlayer.player_vel.x += baseMovement
            }

            CurrentAnimation = AvailableAnimations.walking
            CurrentPlayer.player_flip = false
        } else {
            CurrentPlayer.player_vel.x = 0
            CurrentAnimation = AvailableAnimations.idle
        }

        /*
            This is gravity
            2000 is the world boundary
        */
        if (CurrentPlayer.player_vel.y < 2000) {
            CurrentPlayer.player_vel.y += 2000 * rl.GetFrameTime()
        }

        if (rl.IsKeyDown(.SPACE) && CurrentPlayer.player_grounded) {
            CurrentPlayer.player_vel.y = -1500
            CurrentPlayer.player_grounded = false
        }

        RegisterJumpZone()

        CurrentPlayer.player_pos += CurrentPlayer.player_vel * rl.GetFrameTime()

        if (CurrentPlayer.player_pos.y > f32(rl.GetScreenHeight() - 80 * CurrentPlayer.scale_factor)) {
            CurrentPlayer.player_pos.y = f32(rl.GetScreenHeight() - 80 * CurrentPlayer.scale_factor)
            CurrentPlayer.player_grounded = true
        }
}

PlayerHitLeftBoundary :: proc() -> bool {
    if (CurrentPlayer.player_pos.x < -220) {
        return true
    }

    return false
}

PlayerHitRightBoundary :: proc() -> bool {
    if (CurrentPlayer.player_pos.x > 1640) {
        return true
    }

    return false
}


/**
 * The moment you hit the JumpZone gradually increase player velocity towards the other end of arena
 * We should disable all movement inputs whilst flying -> create new player prop
 * 
 * JumpZone should be more specific, now it's just a giant box, which u can hit by going left
 * We should make an arch?
 */
RegisterJumpZone :: proc() {
    playerCollision := rl.Vector2{
        CurrentPlayer.player_pos.x + f32(50 * CurrentPlayer.scale_factor),
        CurrentPlayer.player_pos.y + f32(51 * CurrentPlayer.scale_factor), // a bit bigger to match the feet location
    }

    playerRadius := f32(30)

    /** LEFT JUMPZONE */
    leftJumpBoxStart := rl.Vector2{195, 411}
    leftJumpBoxEnd := rl.Vector2{395, 613}

    // Debug hitboxes
    // rl.DrawCircleV(playerCollision, playerRadius, rl.RED)
    // rl.DrawLineEx(leftJumpBoxStart, leftJumpBoxEnd, 10, rl.RED)

    if rl.CheckCollisionCircleLine(playerCollision, playerRadius, leftJumpBoxStart, leftJumpBoxEnd) {
        CurrentPlayer.player_flip = false

        // TODO: finish player push
    }
}
