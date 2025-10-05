package dungeon_crawler_test

import "core:c"
import rl "vendor:raylib"
import "core:math/linalg"
import rlgl "vendor:raylib/rlgl"


DrawQuad3D :: proc(points: [4]rl.Vector3 , tex: rl.Texture2D, color: rl.Color = rl.WHITE){

    rlgl.Begin(rlgl.TRIANGLES)

    rlgl.SetTexture(tex.id)

    rlgl.Color4ub(color.r,color.g,color.b ,color.a)
    rlgl.Vertex3f(expand_values(points[0])); rlgl.TexCoord2f(0,0)
    rlgl.Vertex3f(expand_values(points[1])); rlgl.TexCoord2f(0,1)
    rlgl.Vertex3f(expand_values(points[2])); rlgl.TexCoord2f(1,1)

    rlgl.Vertex3f(expand_values(points[2])); rlgl.TexCoord2f(1,1)
    rlgl.Vertex3f(expand_values(points[3])); rlgl.TexCoord2f(1,0)
    rlgl.Vertex3f(expand_values(points[0])); rlgl.TexCoord2f(0,0)
    rlgl.End()
}

main :: proc() {
    rl.SetTraceLogLevel(.ERROR)
    rl.SetConfigFlags({.MSAA_4X_HINT , .VSYNC_HINT})
    rl.InitWindow(1920,1080,"Dungeon Test")
    defer rl.CloseWindow()

    camera := rl.Camera3D{
        position    = {10,1.8,0},
        target      = {0,0,0},
        up          = {0,1,0},
        fovy        = 60,
        projection  = .PERSPECTIVE
    }
    test := rl.LoadTexture("res/test.png")
    defer rl.UnloadTexture(test)

    rl.SetTargetFPS(144)

    for !rl.WindowShouldClose(){

        dt := rl.GetFrameTime()
        {
            movement: rl.Vector3
            if rl.IsKeyDown(.W) || rl.IsKeyDown(.UP) { movement.x += 1 }
            if rl.IsKeyDown(.S) || rl.IsKeyDown(.DOWN) { movement.x -= 1 }

            movement = linalg.normalize0(movement)
            movement *= 4 * dt

            dr: rl.Vector3
            if rl.IsKeyDown(.A) || rl.IsKeyDown(.LEFT) { dr.x -= 1 }
            if rl.IsKeyDown(.D) || rl.IsKeyDown(.RIGHT) { dr.x += 1 }

            dr *= dt * 100

            rl.UpdateCameraPro(&camera, movement = movement, rotation=dr, zoom=0)
        }
        //rl.DisableCursor()

        rl.BeginDrawing()
        defer rl.EndDrawing()

        rl.ClearBackground({245,245,245,255})

        rl.BeginMode3D(camera)



        //rl.DrawCube({0,0.5,0},1,1,1,{255,128,0,255})
        //rl.DrawCubeWires({0,0.5,0},1,1,1,{255,255,255,255})


        DrawQuad3D({
            {0,1,1},
            {3,1,1},
            {3,0,1},
            {0,0,1}}, tex = test)

        DrawQuad3D({
            {0,0,+1},
            {3,0,+1},
            {3,0,-1},
            {0,0,-1}}, tex = test)

        DrawQuad3D({
            {0,0,-1},
            {3,0,-1},
            {3,1,-1},
            {0,1,-1}}, tex = test)

        rl.DrawGrid(100,0.25)

        rl.EndMode3D()

        rl.DrawFPS(10,10)
}

}
