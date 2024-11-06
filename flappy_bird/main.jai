_basic :: #import "Basic";
_raylib :: #import "raylib";
_random :: #import "Random";



bird_forward: _raylib.Texture2D;
bird_down: _raylib.Texture2D;
bird_up: _raylib.Texture2D;

Bird :: struct {
    position: _raylib.Vector2;
    speed: float;
    can_jump: bool;
}

main :: () {
    _basic.print("Hello World\n");
    
    _raylib.InitWindow(360, 640, "Flappy Bird");
    
    start_screen_texture := _raylib.LoadTexture("data/ui/message.png"); 
    background_day_texture := _raylib.LoadTexture("data/assets/background-day.png");
    base_platform_texture := _raylib.LoadTexture("data/assets/base.png");
    pipe_green_texture := _raylib.LoadTexture("data/assets/pipe-green.png");
    
    bird_mid := _raylib.LoadTexture("data/assets/yellowbird-midflap"); 
    bird_down := _raylib.LoadTexture("data/assets/yellowbird-downflap");
    bird_up := _raylib.LoadTexture("data/assets/yellowbird-upflap");
    
    _raylib.SetTargetFPS(60);
    
    game_started := false;
    
    mouse_position := _raylib.GetMousePosition();
    
    up_force := 20;
    const_down_force := 10;
    
    pipe_one_x := 360          + (pipe_green_texture.width * 2);
    pipe_two_x := pipe_one_x   + (pipe_green_texture.width * 6);
    pipe_one_y := 100.0;
    pipe_two_y := 200.0;
    //pipe_three_x := pipe_two_x   + (pipe_green_texture.width * 6);
    //pipe_four_x :=  pipe_three_x + (pipe_green_texture.width * 4);
    
    pipe_scale := 2.0;
    //bird: Bird;
    //bird.position = _raylib.Vector2.{xx (360 - (bird_mid.width / 2)), xx (640 + (bird_mid.height / 2))}

    
    lastDeltaTime:    float64 = 0.016667;
    currentDeltaTime: float;
    while(!_raylib.WindowShouldClose()) {
        
        // update
        if (_raylib.IsKeyDown(xx _raylib.KeyboardKey.KEY_S) && !game_started) game_started = true;
        
        
        
        //if(_raylib.IsKeyDown(xx _raylib.KeyboardKey.KEY_W) && game_started) 
        
        currentDeltaTime, lastDeltaTime = calculate_delta_time(currentDeltaTime, lastDeltaTime);
	    //currentDeltaTime = ndt;
	    //lastDeltaTime    = ldt;
        
        if game_started && (pipe_one_x < xx -(pipe_green_texture.width * pipe_scale)) {
            pipe_one_x = xx (360 + (pipe_green_texture.width * pipe_scale)); 
            pipe_one_y = _random.random_get_within_range(200.0, 250.0);
        } else {
            pipe_one_x   -= xx (100 * currentDeltaTime);
        }
        
        if game_started && (pipe_two_x < xx -(pipe_green_texture.width * pipe_scale)) {
            pipe_two_x = xx (360 + (pipe_green_texture.width * pipe_scale)); 
            pipe_two_y = _random.random_get_within_range(150.0, 250.0);
        } else { 
            pipe_two_x -= xx (100 * currentDeltaTime);
        }
        
        
        _basic.print("one: %, two: % \n", pipe_one_y, pipe_two_y);
        //if game_started && (pipe_three_x < xx -(pipe_green_texture.width * pipe_scale)) then pipe_three_x = xx (360 + (pipe_green_texture.width * pipe_scale)); else pipe_three_x -= xx (100 * currentDeltaTime);
        //if game_started && (pipe_four_x  < xx -(pipe_green_texture.width * pipe_scale)) then pipe_four_x  = xx (360 + (pipe_green_texture.width * pipe_scale)); else pipe_four_x  -= xx (100 * currentDeltaTime);
        
        // update
        //_basic.print("pipe_one_x % \n", pipe_one_x);
        //_basic.print(" %   -= xx (100 * %) ->  \n", pipe_one_x, currentDeltaTime);
        
        _raylib.BeginDrawing();
        {
            _raylib.ClearBackground(_raylib.BLACK);
            
            mouse_position = _raylib.GetMousePosition();         
            
            if !game_started {
                _raylib.DrawTextureEx(background_day_texture, _raylib.Vector2.{0, -40}, .0, 1.5, _raylib.WHITE);
                
                _raylib.DrawTextureEx(pipe_green_texture, _raylib.Vector2.{xx (pipe_green_texture.width * 2), 100 }, 180.0, pipe_scale, _raylib.WHITE);
                _raylib.DrawTextureEx(pipe_green_texture, _raylib.Vector2.{0,                                 360},    0.0, pipe_scale, _raylib.WHITE);

                _raylib.DrawTextureEx(base_platform_texture, _raylib.Vector2.{0, 560}, .0, 1.5, _raylib.WHITE);
                        
                _raylib.DrawTextureEx(start_screen_texture, _raylib.Vector2.{0, 0}, .0, 2, _raylib.WHITE);
            } else {
                // |      | 1 2 3 4
                // |     1| 2 3 4
                // |    1 2 3 4
                // |  1 2 3 4
                // | 1 2 3|4 
                // |p p p p
                //p|p p p p 
                //_raylib.DrawTextureEx(pipe_green_texture, _raylib.Vector2.{360, 0}, 180.0, 2, _raylib.WHITE);
                _raylib.DrawTextureEx(background_day_texture, _raylib.Vector2.{0, -40}, .0, 1.5, _raylib.WHITE);
                
                _raylib.DrawTextureEx(pipe_green_texture, _raylib.Vector2.{ xx  pipe_one_x,                                 xx (240 + pipe_one_y) },   0.0, pipe_scale, _raylib.WHITE);
                _raylib.DrawTextureEx(pipe_green_texture, _raylib.Vector2.{ xx (pipe_one_x + pipe_green_texture.width * 2), xx  pipe_one_y        }, 180.0, pipe_scale, _raylib.WHITE);
                
                _raylib.DrawTextureEx(pipe_green_texture, _raylib.Vector2.{ xx  pipe_two_x,                                 xx (240 + pipe_two_y) },   0.0, pipe_scale, _raylib.WHITE);
                _raylib.DrawTextureEx(pipe_green_texture, _raylib.Vector2.{ xx (pipe_two_x + pipe_green_texture.width * 2), xx  pipe_two_y        }, 180.0, pipe_scale, _raylib.WHITE);
                //_raylib.DrawTextureEx(pipe_green_texture, _raylib.Vector2.{xx pipe_three_x, 360}, 0.0, pipe_scale, _raylib.WHITE);
                //_raylib.DrawTextureEx(pipe_green_texture, _raylib.Vector2.{xx pipe_four_x,  360}, 0.0, pipe_scale, _raylib.WHITE);
            
                _raylib.DrawTextureEx(base_platform_texture, _raylib.Vector2.{0, 560}, .0, 1.5, _raylib.WHITE);
                // TODO:
                // - draw the bird.
                //_raylib.DrawTextureEx()
                // - add force to the bird   
                // - scroll the pipes
                // - collision
                // - scroll the background
                // 
                //draw_bird();
            }           
            
            text := _basic.tprint("x:% y:%", cast(s32) mouse_position.x, cast(s32) mouse_position.y);
            
            _raylib.DrawText(text.data, 20, 20, 20, _raylib.GRAY);
            _raylib.DrawCircle(cast(s32) mouse_position.x, cast(s32) mouse_position.y, 10.0, _raylib.WHITE);
            //else {
            //    //
            //}
        }
        _raylib.EndDrawing();
    }
    
    _raylib.CloseWindow();
}

calculate_delta_time :: (current: float, last: float64) -> deltaTime: float, lastDeltaTime: float64 {
    deltaTime: float; lastDeltaTime: float64;

    now          := _basic.seconds_since_init();
    lastDeltaTime = now;
    deltaTime     = cast(float)(now - last);

    if deltaTime > 0.16 then deltaTime =  0.16;
    
    return deltaTime, lastDeltaTime;
}

//draw_bird :: () {
//
//}
//
//update_bird :: (bird: Bird, EnvItem *envItems, int envItemsLength, float delta)
//{
//    if (IsKeyDown(KEY_LEFT)) player->position.x -= PLAYER_HOR_SPD*delta;
//    if (IsKeyDown(KEY_RIGHT)) player->position.x += PLAYER_HOR_SPD*delta;
//    if (IsKeyDown(KEY_SPACE) && player->canJump)
//    {
//        player->speed = -PLAYER_JUMP_SPD;
//        player->canJump = false;
//    }
//
//    bool hitObstacle = false;
//    for (int i = 0; i < envItemsLength; i++)
//    {
//        EnvItem *ei = envItems + i;
//        Vector2 *p = &(player->position);
//        if (ei->blocking &&
//            ei->rect.x <= p->x &&
//            ei->rect.x + ei->rect.width >= p->x &&
//            ei->rect.y >= p->y &&
//            ei->rect.y <= p->y + player->speed*delta)
//        {
//            hitObstacle = true;
//            player->speed = 0.0f;
//            p->y = ei->rect.y;
//            break;
//        }
//    }
//
//    if (!hitObstacle)
//    {
//        player->position.y += player->speed*delta;
//        player->speed += G*delta;
//        player->canJump = false;
//    }
//    else player->canJump = true;
//}
