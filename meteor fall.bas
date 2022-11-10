 rem Generated 19/07/2022 10:00:00 by Visual bB Version 1.0.0.568
 rem ************************************************************
 rem *<Game Name>                                               *
 rem *<slogan>                                                  *
 rem *<Atariando - Guilherme Xavier and Augusto Baffa>	         *
 rem *<guix@puc-rio.br / abaffa@puc-rio.br>                     *
 rem *<free>                                                    *
 rem ************************************************************

 set kernel_options pfcolors
 set tv ntsc

 ; include 6lives_statusbar.asm
 ; statusbarlength = 144
 const scorefade = 0
 scorecolor = $1C

 dim sounda = a
 dim soundb = b
 dim counter = c
 dim d = d 
 dim e = e 
 dim player0control = f 
 dim meteor_control = g
 dim h = h
 dim meteor_impact_position = i
 dim j = j
 dim k = k 
 dim l = l
 dim meteor_speed = m
 dim n = n 
 dim o = o 
 dim dash_cooldown = p
 dim q = q 
 dim rand16 = r
 dim statusbarcolor = s 
 dim t = t 
 dim rand_temp = u 
 dim v = v
 dim meteor_draw_mode = w 
 dim x = x
 dim y = y
 dim z = z 
 dim _sc1 = score
 dim _sc2 = score+1
 dim _sc3 = score+2

 rem start/restart ........................................................................

start_restart

 AUDV0 = 0 : AUDV1 = 0
 a = 0 : b = 0 : c = 0 : d = 0 : e = 0 : f = 0 : g = 0 : h = 0 : i = 0
 j = 0 : k = 0 : l = 0 : m = 0 : n = 0 : o = 0 : p = 0 : q = 0 : r = 0
 s = 0 : t = 0 : u = 0 : v = 0 : w = 0 : x = 0 : z = 0
 player0y = 200 : player1y = 200 : bally = 200

 rem title ........................................................................

titlescreen

 scorecolor = $1E
 ; statusbarcolor = $00
 COLUBK = $1C  

 playfield:
 ................................
 .XX.XX.XX.XXX.XX.XXX.XXX........
 .X.X.X.X...X..X..X.X.X.X........
 .X...X.XX..X..XX.X.X.XX.........
 .X...X.X...X..X..X.X.X.X........
 .X...X.XX..X..XX.XXX.X.X........
 ................................
 .XXX.XX..X...X..................
 .XX.X..X.X...X..................
 .X..XXXX.X...X..................
 .X..X..X.XXX.XXX................
end 

 pfcolors:
   $32
   $32
   $32
   $32
   $32
   $32
   $32
   $32
   $32
   $32
   $32
end

 drawscreen

 if joy0fire then goto main_setup
 
 goto titlescreen

 rem main_setup ........................................................................

main_setup

 player0x = 85
 player0y = 85

 player1x = 10
 player1y = 55

 ballx = 55
 bally = 100
 
 j = 1
 k = 0
 meteor_speed = 2

 dash_cooldown = 0

 missile0x = 100
 missile0y = 85
 missile0height = 8

 missile1x = 120
 missile1y = 85
 missile1height = 8

 scorecolor = $1C
 ; statusbarcolor = $1C

 ; CTRLPF = $04  
 NUSIZ0 = $00 
 ;NUSIZ1 = $00
 COLUBK = $00
 COLUP0 = $02
 COLUP1 = $08
 COLUPF = $8A

 z = 1
 rem mainloop ........................................................................

main

 COLUP0 = $1C
 COLUP1 = $08

  if (rand&1) = 0 && player1y = 0 then meteor_draw_mode = $07 : missile0height = 20 : missile1height = 20
  if (rand&1) = 1 && player1y = 0 then meteor_draw_mode = $00 : missile0height = 8 : missile1height = 8

  NUSIZ1 = meteor_draw_mode

  if dash_cooldown > 0 then dash_cooldown = dash_cooldown + 1
  if dash_cooldown > 50 then dash_cooldown = 0

  player0control=player0control+1
  rem POSSIBLY INEFFICIENT CODE, SEPARATE COLOR INFO FOR EACH FRAME...
  if player0control = 10 then player0:
        %11000011
        %11000100
        %01000010
        %01001110
        %01000001
        %01001001
        %01000010
        %00111110
end
  
  if player0control = 20 then player0:
        %11000011
        %11000110
        %01000000
        %01001111
        %01000000
        %01001000
        %01000011
        %00111110
end

  


  if player0control=20 then player0control=0

  if joy0right then z = 1 : player0x = player0x + 1
  if joy0left then z = -1 : player0x = player0x - 1
  if z = 1 then REFP0 = 0
  if z = -1 then REFP0 = 8
 
  if player0x > 137 then player0x = 137
  if player0x < 17 then player0x = 17

  meteor_control=meteor_control+1

   if meteor_control = 10 then player1:
        %00011000
        %00100100
        %01011010
        %00100100
        %01001010
        %01000010
        %01010010
        %00111100
end

  if meteor_control = 20 then player1:
        %00011000
        %01000010
        %10011001
        %00100100
        %01010010
        %01001010
        %01000010
        %00111100
end

  if meteor_control = 30 then player1:
        %00000000
        %01100100
        %00011000
        %00100101
        %11000010
        %01100010
        %01000110
        %00111100
end

  if meteor_control = 40 then player1:
        %00000000
        %01000000
        %00011000
        %00100101
        %01011010
        %11000111
        %01001010
        %00111100
end


  if meteor_control = 40 then meteor_control = 0

  player1y = player1y + meteor_speed
  if player1y <= 90 then goto jmp_meteor_fall
    missile0y = 85
    missile1y = 85 
    player1y = 0 
    meteor_impact_position = player1x : COLUBK = $1E 
    
    rand_temp = rand&13
    if rand_temp = 0 then player1x = 50
    if rand_temp = 1 then player1x = 60
    if rand_temp = 2 then player1x = 70
    if rand_temp = 3 then player1x = 80
    if rand_temp = 4 then player1x = 90
    if rand_temp = 5 then player1x = 100
    if rand_temp = 6 then player1x = 110
    if rand_temp = 7 then player1x = 120
    if rand_temp >= 8 then player1x = player0x

    score = score + 10 
    missile0x = meteor_impact_position - 4
    missile1x = meteor_impact_position + 4
    sounda = 10
    soundb = 10
    
 

jmp_meteor_fall

  missile0x = missile0x - meteor_speed
  missile1x = missile1x + meteor_speed
  if meteor_impact_position - missile0x > 25 then missile0y = 200
  if missile1x - meteor_impact_position > 25 then missile1y = 200
  if missile0x <= 16 || missile0x >= 160 then missile0y = 200
  if missile0x <= 16 || missile1x >= 160 then missile1y = 200

  ;if joy0fire then player0x = rand&127

  if joy0fire && joy0left && dash_cooldown = 0 then player0x = player0x - 8 : dash_cooldown = 1
  if joy0fire && joy0right && dash_cooldown = 0 then player0x = player0x + 8 : dash_cooldown = 1

  if collision(missile0, player0) then goto gameover
  if collision(missile1, player0) then goto gameover
  if collision(player1, player0) then goto gameover

  if player0x > 160 then player0x = 16
  if player0x < 16 then player0x = 160


end

 drawscreen

 playfield:
 ................................
 .......................XXXXXX...
 ......................XXXXXXXX..
 .......................XXXXXX...
 ................................
 ................................
 ................................
 .XXX............................
 XX.XX...........................
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

 pfcolors:
   $1A
   $1A
   $1A
   $1A
   $1A
   $1A
   $06
   $06
   $06
   $C4
   $C4
end


  rem sounds
  if sounda > 0 then sounda = sounda - 1 : AUDV1 = 4 : AUDC1 = 4 : AUDF0 = sounda else AUDV1 = 0 
  if soundb > 0 then soundb = soundb - 1 : AUDV1 = 7 : AUDC1 = 8 : AUDF1 = soundb else AUDV1 = 0

  COLUBK = $00

  goto main

gameover

      playfield:
................................
...XX.X..X.XXX.X.X..X.XXX.XXX...
...X...X....X..X.XX.X.X....X....
...XX..XX...X..X.X.XX.X....X....
...X..X..X..X..X.X..X.X....X....
...XX.X..X..X..X.X..X.XXX..X....
................................
................................
................................
................................
................................
end 

  pfcolors:
   $0E
   $40
   $40
   $40
   $40
   $40
   $0E
   $0E
   $0E
   $0E
   $0E
end

  player0control=player0control+1
  rem POSSIBLY INEFFICIENT CODE, SEPARATE COLOR INFO FOR EACH FRAME...
  if player0control = 10 then player0:
        %01000010
        %10100101
        %10011001
        %10000001
        %01000010
        %10000001
        %10011001
        %10100101
        %01000010
end
   if player0control = 10 then player0color:
    $0E;
    $0E;
    $0E;
    $0E;
    $0E;
    $0E;
    $0E;
    $0E;
    $0E;
end
  if player0control = 20 then player0:
        %00000000
        %01000010
        %10100101
        %10011001
        %01000010
        %10011001
        %10100101
        %01000010
        %00000000
end
 
  if player0control = 30 then player0:
        %01000010
        %10100101
        %10011001
        %10000001
        %01000010
        %10000001
        %10011001
        %10100101
        %01000010
end
  

 if player0control = 30 then player0control = 0

 AUDV0 = 0 : AUDV1 = 0
 sounda = 0 : soundb = 0 
 player1x = 200 : player1y = 200 
 missile0x = 200 : missile0y = 200
 missile1x = 200 : missile1y = 200
 ballx = 200 : bally = 200
 ; if joy0fire then counter = counter + 1 else counter = 0
 if joy0fire then reboot

 if switchreset then reboot

 drawscreen

 goto gameover 
