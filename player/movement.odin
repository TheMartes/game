package player

import rl "vendor:raylib"

InitMovement :: proc() {
        baseMovement := CurrentPlayer.base_speed*rl.GetFrameTime()

        if (rl.IsKeyDown(.A) && !CurrentPlayer.is_attacking) {
            if (CurrentPlayer.player_vel.x > 0) {
                CurrentPlayer.player_vel.x = 0
            } else if (!(CurrentPlayer.player_vel.x < CurrentPlayer.base_speed * -1)) {
                CurrentPlayer.player_vel.x += -baseMovement
            }
            CurrentAnimation = AvailableAnimations.walking

            CurrentPlayer.player_flip = true
            CurrentPlayer.is_attacking = false
        } else if (rl.IsKeyDown(.D) && !CurrentPlayer.is_attacking) {
            if (CurrentPlayer.player_vel.x < 0) {
                CurrentPlayer.player_vel.x = 0
            } else if (!(CurrentPlayer.player_vel.x > CurrentPlayer.base_speed)) {
                CurrentPlayer.player_vel.x += baseMovement
            }
            CurrentAnimation = AvailableAnimations.walking

            CurrentPlayer.player_flip = false
            CurrentPlayer.is_attacking = false
        } else if (rl.IsKeyDown(.F)) {
            CurrentAnimation = AvailableAnimations.attack
            CurrentPlayer.is_attacking = true
        } else {
            CurrentPlayer.player_vel.x = 0
            if (!CurrentPlayer.is_attacking) {
                CurrentAnimation = AvailableAnimations.idle
                CurrentAnimation = AvailableAnimations.idle
                
                CurrentPlayer.player_vel.x = 0
                CurrentPlayer.is_attacking = false
            }
        }

        CurrentPlayer.player_vel.y += 2000 * rl.GetFrameTime()

        if (rl.IsKeyDown(.SPACE) && CurrentPlayer.player_grounded) {
            CurrentPlayer.player_vel.y = -600
            CurrentPlayer.player_grounded = false
        }

        CurrentPlayer.player_pos += CurrentPlayer.player_vel * rl.GetFrameTime()

        if (CurrentPlayer.player_pos.y > f32(rl.GetScreenHeight() - 60 * 4)) {
            CurrentPlayer.player_pos.y = f32(rl.GetScreenHeight() - 60 * 4)
            CurrentPlayer.player_grounded = true
        }
}
