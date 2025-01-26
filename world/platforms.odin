package world

import rl "vendor:raylib"

DrawPlatforms :: proc(platform: rl.Texture2D) {
    rl.DrawTextureEx(platform, rl.Vector2{200, 400}, 45, 3, rl.WHITE)
}