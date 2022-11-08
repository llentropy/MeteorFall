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
 dim meteorcontrol = g
 dim h = h
 dim i = i
 dim j = j
 dim k = k 
 dim l = l
 dim m = m
 dim n = n 
 dim o = o 
 dim p = p
 dim q = q 
 dim rand16 = r
 dim statusbarcolor = s 
 dim t = t 
 dim u = u 
 dim v = v
 dim w = w 
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

 player1x = 55
 player1y = 55

 ballx = 55
 bally = 30

 missile0x = 100
 missile0y = 55

 missile1x = 120
 missile1y = 55

 scorecolor = $1C
 ; statusbarcolor = $1C

 ; CTRLPF = $04  
 NUSIZ0 = $00 
 NUSIZ1 = $00
 COLUBK = $00
 COLUP0 = $02
 COLUP1 = $08
 COLUPF = $1E

 z = 1
 rem mainloop ........................................................................

main

 COLUP0 = $1C
 COLUP1 = $08

 ballheight = 8
 bally = bally + 2

 ; missile0x = missile0x + 1
 missile1x = missile1x - 1

 if missile1x < 8 then missile1x = 140

 score = score + 1 
 ; statusbarcolor = $30
 ; statusbarlength = statusbarlength - 1

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
 


  meteorcontrol=meteorcontrol+1

   if meteorcontrol = 10 then player1:
        %00011000
        %00100100
        %01011010
        %00100100
        %01001010
        %01000010
        %01010010
        %00111100
end

  if meteorcontrol = 20 then player1:
        %00011000
        %01000010
        %10011001
        %00100100
        %01010010
        %01001010
        %01000010
        %00111100
end

  if meteorcontrol = 30 then player1:
        %00000000
        %01100100
        %00011000
        %00100101
        %11000010
        %01100010
        %01000110
        %00111100
end

  if meteorcontrol = 40 then player1:
        %00000000
        %01000000
        %00011000
        %00100101
        %01011010
        %11000111
        %01001010
        %00111100
end


  if meteorcontrol = 40 then meteorcontrol = 0

end

 drawscreen

 playfield:
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
end

 pfcolors:
   $60
   $60
   $62
   $64
   $64
   $66
   $68
   $68
   $6A
   $6C
   $6E
end


  rem sounds
  if sounda > 0 then sounda = sounda - 1 : AUDV1 = 4 : AUDC1 = 4 : AUDF0 = sounda else AUDV1 = 0 
  if soundb > 0 then soundb = soundb - 1 : AUDV1 = 4 : AUDC1 = 4 : AUDF1 = soundb else AUDV1 = 0

  goto main

gameover

 playfield:
 ................................
 ................................
 ................................
 .XXX.XX..X.X.XXX..XX.X.X.XXX.XX.
 .X...X.X.XXX.X.X.X.X.X.X.X.X.X..
 .X.X.XXX.X.X.XX..X.X.X.X.XX..X..
 .X.X.X.X.X.X.X...X.X.XX..X...X..
 ..XX.X.X.X.X.XXX.XX..X...XXX.X..
 ................................
 ................................
 ................................
end

 AUDV0 = 0 : AUDV1 = 0
 sounda = 0 : soundb = 0 
 player0x = 145 : player0y = 20 
 player1x = 200 : player1y = 200 
 missile1x = 200 : missile1y = 200
 ballx = 200 : bally = 200
 if joy0fire then counter = counter + 1 else counter = 0
 if counter > 50 then reboot

 if switchreset then reboot

 drawscreen

 goto gameover 
