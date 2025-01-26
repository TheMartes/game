package player

import rl "vendor:raylib"
import "core:fmt"

HandlePlayerAnimation :: proc() {
        player_run_width := f32(CurrentAnimation.texture.width)
        player_run_height := f32(CurrentAnimation.texture.height)

        CurrentPlayer.anim_frame_timer += rl.GetFrameTime()

        if (CurrentPlayer.anim_frame_timer >= CurrentAnimation.frame_length) {
            CurrentPlayer.anim_current_frame += 1
            CurrentPlayer.anim_frame_timer = 0

            if (CurrentPlayer.anim_current_frame == CurrentAnimation.num_frames) {
                CurrentPlayer.anim_current_frame = 0

                CurrentAnimation = AvailableAnimations.idle
            }
        }

        draw_player_source := rl.Rectangle{
            f32(CurrentPlayer.anim_current_frame) * player_run_width / f32(CurrentAnimation.num_frames),
            0,
            player_run_width / f32(CurrentAnimation.num_frames), 
            player_run_height
        }

        if CurrentPlayer.player_flip {
            draw_player_source.width = -draw_player_source.width
        }

        draw_player_dest := rl.Rectangle{
            CurrentPlayer.player_pos.x, 
            CurrentPlayer.player_pos.y, 
            player_run_width * f32(CurrentPlayer.scale_factor) / f32(CurrentAnimation.num_frames), 
            player_run_height * f32(CurrentPlayer.scale_factor)
        }

        rl.DrawTexturePro(CurrentAnimation.texture, draw_player_source, draw_player_dest, 0, 0, rl.WHITE)
}
