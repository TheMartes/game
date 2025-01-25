package main

import rl "vendor:raylib"
import "player"

main :: proc() {
    rl.InitWindow(1280, 720, "welcome to the game")
    player.InitializePlayer()

    // load bg
    bg := rl.LoadTexture("assets/bg.png")
    defer(rl.UnloadTexture(bg))

    font := rl.LoadFont("assets/font.ttf")

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

        rl.ClearBackground(rl.RAYWHITE)
        rl.DrawTexturePro(bg, bgSourceCanvas, bgDestCanvas, rl.Vector2{0, 0}, 0, rl.WHITE)
        rl.DrawTextEx(font, "Level 1", rl.Vector2{200, 200}, 35, 1, rl.GRAY)

        player.InitMovement()
        player.HandlePlayerAnimation()

        rl.EndDrawing()
    }

    rl.CloseWindow()
}
