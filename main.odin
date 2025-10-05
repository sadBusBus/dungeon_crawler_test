package dungeon_crawler_test

import "core:c"
import rl "vendor:raylib"
import "core:math/linalg"

main :: proc() {
    rl.SetTraceLogLevel(.ERROR)
    rl.SetConfigFlags({.MSAA_4X_HINT , .VSYNC_HINT})
    rl.InitWindow(1920,1080,"Dungeon Test")
    defer rl.CloseWindow()

    camera := rl.Camera3D{
        position    = {4,4,4},
        target      = {0,0,0},
        up          = {0,1,0},
        fovy        = 60,
        projection  = .PERSPECTIVE
    }

    rl.SetTargetFPS(144)

    for !rl.WindowShouldClose(){

        rl.BeginDrawing()
        defer rl.EndDrawing()

        rl.ClearBackground({128,180,255,255})

        rl.BeginMode3D(camera)

        rl.DrawCube({0,0,0},1,1,1,{255,120,0,255})
        rl.EndMode3D()

        rl.DrawFPS(10,10)
    }
}

