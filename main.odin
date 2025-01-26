package main

import rl "vendor:raylib"
import "core:fmt"
import "player"
import "world"

developer : bool

main :: proc() {
    rl.SetConfigFlags({rl.ConfigFlag.WINDOW_RESIZABLE})

    developer = true

    rl.InitWindow(1920, 1080, "The Mr. Bomberman")

    player.InitializePlayer()

    // load bg
    bg := rl.LoadTexture("assets/bg.png")
    platform := rl.LoadTexture("assets/platform.png")
    defer(rl.UnloadTexture(bg))
    defer(rl.UnloadTexture(platform))

    // font := rl.LoadFont("assets/font.ttf")
    font := rl.LoadFont("assets/mono.ttf")

    bgDestCanvas := rl.Rectangle{
        0,
        0,
        f32(rl.GetScreenWidth()),
        f32(rl.GetScreenHeight()),
    }

    bgSourceCanvas := rl.Rectangle{
        0,
        0,
        f32(bg.width),
        f32(bg.height),
    }

    // Define the main loop
    for !rl.WindowShouldClose() {

        rl.BeginDrawing()

        // Background
        rl.DrawTexturePro(bg, bgSourceCanvas, bgDestCanvas, rl.Vector2{0, 0}, 0, rl.WHITE)

        // Player specific
        player.HandlePlayerAnimation()
        player.HandleMovement()

        // Jump platforms
        world.DrawPlatforms(platform)

        // Developer info
        if (developer) {
            rl.DrawFPS(50, 30)
            rl.DrawTextEx(font, fmt.ctprintf("POS  x:%f y:%f", player.CurrentPlayer.player_pos.x, player.CurrentPlayer.player_pos.y), rl.Vector2{50, 50}, 32, 1, rl.WHITE)
            rl.DrawTextEx(font, fmt.ctprintf("VEL  x:%f y:%f", player.CurrentPlayer.player_vel.x, player.CurrentPlayer.player_vel.y), rl.Vector2{50, 70}, 32, 1, rl.WHITE)
            rl.DrawTextEx(font, fmt.ctprintf("MOUSE    x:%f y:%f", rl.GetMousePosition().x, rl.GetMousePosition().y), rl.Vector2{50, 90}, 32, 1, rl.WHITE)
        }

        rl.EndDrawing()
    }

    rl.CloseWindow()
}
