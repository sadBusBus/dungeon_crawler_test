package dungeon_crawler_test

import "core:c"
import rl "vendor:raylib"
import "core:math/linalg"

main :: proc() {
    rl.SetTraceLogLevel(.ERROR)
    rl.SetConfigFlags({.MSAA_4X_HINT , .VSYNC_HINT})
    defer rl.CloseWindow()

    rl.SetTargetFPS(144)

    for !rl.WindowShouldClose(){

        rl.BeginDrawing()
        defer rl.EndDrawing()

        rl.ClearBackground({128,180,255,255})
        rl.DrawFPS(10,10)
    }
}

