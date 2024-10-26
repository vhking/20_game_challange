_basic :: #import "Basic";
_raylib :: #import "raylib";

main :: () {
    _basic.print("Hello World\n");
    
    _raylib.InitWindow(360, 640, "Flappy Bird");
    
    start_screen_texture := _raylib.LoadTexture("data/ui/message.png"); 
    background_day_texture := _raylib.LoadTexture("data/assets/background-day.png");
    //_basic.array_add(*tiles, LoadTexture("data/ui/message.png"));
    
    
    _raylib.SetTargetFPS(60);
    
    game_started := false;
    
    while(!_raylib.WindowShouldClose()) {
        
        _raylib.BeginDrawing();
        {
            _raylib.ClearBackground(_raylib.BLACK);
            
            if !game_started {
                _raylib.DrawTextureEx(background_day_texture, _raylib.Vector2.{0, 0}, .0, 1.5, _raylib.WHITE);
                _raylib.DrawTextureEx(start_screen_texture, _raylib.Vector2.{0, 0}, .0, 2, _raylib.WHITE);
            } 
            
            //else {
            //    //
            //}
        }
        _raylib.EndDrawing();
    }
    
    _raylib.CloseWindow();
}