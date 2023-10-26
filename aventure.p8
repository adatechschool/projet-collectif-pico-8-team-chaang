pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--jeu d'aventure
--nadege

function _init()
	create_player()
	init_msg()
end

function _update()
	if not messages[1] then
	 player_movement()
	end
	update_camera()
	update_msg()
end

function _draw()
	cls()
	draw_map()
	draw_player()
	draw_ui()
	draw_msg()
end
-->8
--map

function draw_map()
	map(0,0,0,0)
end

function check_flag(flag,x,y)
 local sprite=mget(x,y)
	return	fget(sprite,flag)
end

function update_camera()
	camx=mid(0,p.x-7.5,127-15)
	camy=mid(0,p.y-7.5,32-15)
	camera(camx*8,camy*8)
end

function next_tile(x,y)
	sprite=mget(x,y)
	mset(x,y,sprite+1)
end

function pick_up_key(x,y)
	next_tile(x,y)
	p.keys+=1
	sfx(0)
end

function open_door(x,y)
	next_tile(x,y)
	p.keys-=1
	sfx(1)
end

function old_camera()
	camx=flr(p.x/16)*16
	camy=flr(p.y/16)*16
	camera(camx*8,camy*8)
end
-->8
--player

function create_player()
	p={
	x=6,y=4,
	ox=0,oy=0,
	start_ox=0,start_oy=0,
	anim_t=0,
	sprite=9,
	keys=0
	}
end

function player_movement()
	newx=p.x
	newy=p.y
	if btnp(➡️) then
	 newx+=1
	 newox=-8
	 newoy=0
 end
	if btnp(⬅️) then
	 newx-=1
	 newox=8
	 newoy=0
	end
	if btnp(⬇️) then
	 newy+=1
	 newox=0
	 newoy=-8
	end
	if btnp(⬆️) then
	 newy-=1
	 newox=0
	 newoy=8
	end
	
	interact(newx,newy)
	
	if not check_flag(0,newx,newy) then
		p.x=mid(0,newx,127)
		p.y=mid(0,newy,63)
		p.start_ox=newox
		p.start_oy=newoy
		p.anim_t=1
	end
	
	--animation
	p.anim_t-=max(p.anim_t-0.125,0)
 p.ox=p.start_ox 
end

function interact(x,y)
	if check_flag(1,x,y) then
		pick_up_key(x,y)
	elseif check_flag(2,x,y)
	and p.keys>0 then
		open_door(x,y)
	end
	if x==22 and y==17 then
		create_msg("panneau",
		[[
  je suis le panneau 
  d'introduction !
		]])
	end
	if x==13 and y==9 then
		create_msg("stephanie",
		[[
  bonjour
		]])
	end
	if y==27 and (x>6 and x<10) 
	and not in_water	then
	create_msg("fee de l'eau",
	[[
  j'espere que tu sais nager...
	]])
	in_water=true
	end 
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end
-->8
--ui

function draw_ui()
	camera(0,0)
	palt(0,false)
	palt(12,true)
	spr(22,2,2)
	palt()
	print_outline("X"..p.keys,10,2)
end

function print_outline(text,x,y)
	 print(text,x-1,y,0)
	 print(text,x+1,y,0)
	 print(text,x,y-1,0)
	 print(text,x,y+1,0)
		print(text,x,y,7)
end
-->8
--messages

function init_msg()
	messages={}
end

function create_msg(name,...)
	msg_title=name
	messages={...}
end

function update_msg()
	if (btn(❎)) then
		deli(messages,1)
	end
end

function draw_msg()
	if messages[1] then
		local y=100
		rectfill(6,y,
		6+#msg_title*4,y+6,2)
		print(msg_title,7,y+1,7)
		rectfill(2,y+9,125,y+21,13)
		print(messages[1],0,y+10,7)
	end
end
__gfx__
0000000033333333333333333333333333bbbb33111111114444444444444444333333330eeeee003333333300000000ddddddddffffffffccc1c1cc00000000
000000003333333333a33333333337333bbaabb311111111444444444ffffff433333333eeee4ee03bb3333300000000ddddddddfdfdfdffc1ccccc100000000
00700700333333333a9a3333333379733bbbab1311111111dddddddd4f444f44333333a3e41441e033bb33b300000000ddddddddffffffffccc1cccc00000000
000770003333333333a33333333337333bbbbd1311111111cccccccc4ffffff4aaaaaa3aee4444e0333b3bb300000000dddddddddfdfdfdfcccccc1c00000000
000770003333333333333a333373333331dbdd1311111111111111114444f444a33333a3eeaaaae033333bb300000000ddddddddffffffffc1cc1ccc00000000
00700700333333333333a9a3379733333311113311111111111111114ffffff4333333330a66660033333b3300000000ddddddddfdfdfdfdcccccc1c00000000
000000003333333333333a333373333333322333111111111111111144444444333333330a2222003333333300000000ddddddddffffffffcc1ccccc00000000
000000003333333333333333333333333314423311111111111111114ffffff4333333330a6006003333333300000000dddddddddfdfdfdf1ccc1cc100000000
dddddadddddddddd33333a33333333330444444014420001cccccccc377777730044440000000000000000000000000000000000000000000000000000000000
daaaadaddddddddd3aaaa3a3333333334405050444520000ccccc0cc77ffff775555555500000000000000000000000000000000000000000000000000000000
5a555a55555555555a555a55555555559405050495520000c0000a0c77f0f0f70444444000000000000000000000000000000000000000000000000000000000
4455554444555544445555444455554494444444954200000aaaa0a077fffff70454454000000000000000000000000000000000000000000000000000000000
dd4444dddd4444dd334444333344443344444414444200000a000a0c33cccc330454454000000000000000000000000000000000000000000000000000000000
ddd44dddddd44ddd33344333333443339444446494420000c0ccc0cc3dddadd30444444000000000000000000000000000000000000000000000000000000000
d544445dd544445d35444453354444539424444494200000cccccccccccccccc0050050000000000000000000000000000000000000000000000000000000000
d555555dd555555d35555553355555534224242442000000cccccccc336336330500005000000000000000000000000000000000000000000000000000000000
0055555500005000000060605dd5d66d098909898884949844555444585585850098900000980000000444444444444444440000555555555555550000000000
05666666000840000666868656666666009808908459498888444480454545540098800000088000004888888888888888844400666666666666665000000000
56d6dd6d0008450068606060566655d609800089899488850884888044d444440099890000098000048899999999999999888444dd6dd6dddd6d6d6500000000
5ddd5d5500488400666686605666666504840484954884990988890045445d45000089000000890048899555555555555999988855d55d55555dd5d500000000
055505000544845068866686565dd66548584858488599940998900044d844440000890000009000889955445445d45445599998005005000005505000000000
0000000004448840068608605555566d854585458849945800980000844544850098890000090000899544d44548454d4d455559000000000000000000000000
0000000054444845008888005dd666665444544485994588000890004484445400980000009800009955454dd454445454544d55000000000000000000000000
0000000044444844006886005555555544444444549458840098000045445844000890000009000055d4d455844d844844d454d4000000000000000000000000
ccccccccc1111cccc11cccccc11ccccccccccccccccccc3cc7c77c119fa9f9f90040404000999999999999999999990000000000000000000000000000000000
cccccccc1177111c1c71cccc1c71ccccccc3ccc33cccc33c1ccc11cca7ff9faf0099999009ffffffffffffffffffff9000000000000000000000000000000000
cccccccc1cc7cc11c1cc1cccc11ccccccc33cc3b3ccc33ccc11ccc7cf9a97a9f009999909f6f6f6f6f66f6f66f66ff6900000000000000000000000000000000
cccccccc1cccccc1cc11c11ccccc11ccc3b3cc3b3cc33cc37cc111119ffa99f94004440496669696969969699699669900000000000000000000000000000000
cccccccc1cccccc1cccc1c71ccc1c71cc3b3c33b3cc3cc33111ccc11a979f7fa9999999909090909090090900900990000000000000000000000000000000000
cccccccc11ccccc1ccc1ccc1c11c11cc3b3c33b33c33c33cccc1cccc9f9faf9f9044440900000000000000000000000000000000000000000000000000000000
ccccccccc111cc11cc1ccc1c1c71cccc3b3c3b333c3c33ccc11c111cf9af9af79948849900000000000000000000000000000000000000000000000000000000
ccccccccccc1111cccc111ccc11ccccc3b3c3b3cc33c3ccc1cccccc1a7f9ff999948849900000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0d0d0d0d0d0d0d0d010101010101010104010104010101010101010101010101010d0d0d0d0d0d0d0d0d0d0d0d0d0d01010101010101010101010101010
1010101010101010101010101010101010101010101010101010101040101010101010101010404010401010101010101010d0d0d0d0d0d0d0d0d0d0d0d0d0d0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d0d0
__gff__
0000000001010100000000010001000002010201050000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0404040401040404040404040101010101010101010104040404040404120404040401010101010101010103010101010101040404040404040101010101010404040404040101010101010101010101010101010101010101010101040404040404040404040404040404040101010101010101010404040404040404040404
04040404010104040401010101010101010101010101010104040404040101040404040404040401010101010101010101010101010101010101040404040404040404040401010104040404040404010101010101010a0101010101010104040404040404040404040404010112010404040404040404040404040404040404
04040404040101010101010a0101010101010101010101010101040404040104040404040404010101010101010101010101010101010104040404040404040404040404040112010404040404040101010101010101010101010101010101010104040404040404010101010404040404040404040404040404040404040404
0404040404040101010101010101010101010101010201010101010101010104040404040401010101010101010101010a01010101010101040404040404040404040404010101040404040401010101010101010101010103010101010101010101040404040101010404040404040404040404040404040404040404040401
01040404040101010101010101010101010101010101010101010101040404040404040401010101010101010101010101010101010101010104040404040404040404010104040404040401010101010101010a0101010101010101010101010101010104010104040404040404040404040404040404040404040404040112
0104040401010101010101010101010101010101010101010101010101040404040404040101010a01010101010101010101010101010101010104040404040404040101040404040404010101010101010101010101010101010101010101010101010101010104040404040404040401010101010101010104040404040101
0104040401010101010101010101030301010101010101010101010101040404040404010101010101010102010101010101010103010101010101040404040404010104040404040401010101010101010101010101010101010101010a01010101010101010101010404040404040101010101010101010104040404010104
010404010101010101010101010101010101010101010101010101010101040404040101010101010101020101010101010101010301010101010104040404010101040404040404010101010101010a010101010101010101010101010101010101010101010101010104040401010101010101010101010101040404010104
01040101010101010101010101010101010101010101010101010101010104040404010101010101010101010101010101010101010101010101010104040101010404040104040101010101010101010101010101010101010101010101010101010101010101010101010101010103010101010a0101010101010404010404
0101010101010101010101010117010101010101010101010101010101010104040101010101010101010101010101010a010101010101010101010104040101040404010104040101010101010101010101010101010101010d0d0d0d0d0d0d0d0d0d0d01010101010101010101010101010101010101010101010101010404
01010101010101010101010101010101010101010102010101010101010101040101010101010101010101010101010101010101010101010101010101010104040404010404010101010101010101010101010101010101010d0c0c0c0c0c0c0c0c0c0d0101010d0d0d0d0d0101010101010101010101010101010101040404
01010101010101010101010101010101010101010201010101010101010101010101010101010a0101010101010101010101010101010101010a010101010404040404010401010101010a0101010101010202010101010101140c0c0c0c0c0c0c0c0c0d0101010d0c0c0c0d0d0d0d0d01010101010101010101010101040404
010101010a010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010a010101010101010104040404010101010101010101010101010101030101010101010d0d0d0d0d0d0d0d0c0c0d0101010d0c0c0c0c0c0c0c0d01010101010101010101010101040404
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010606060601010101010101010101010101010101010101040404010101010101010101010101010101010101010101010101010101010d0c0c0d0101010d0c0c0d0d0d0c0c0d01010101010101010101010101010404
010101060606060607060606060606010101010101010101010a010101010101010101010101010606060505050506060101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010d0c0c0d0101010d0c0c0d010d0c0c0d0d010106060606010101010101010104
0606060505050505070505050505050601010101010101010101010101010101010101010106060505050101010505050601010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010d0c0c0d0101010d0c0c0d010d0c0c0c0d010605050505060606060101010101
0505050501010101010101010101050506010101010101010101010101010101010101060605050501010101010101050507060606010101010101010a01010101010101010101010101010101010101010101010101010101010103010101010d0c0c0d0101010d0c0c0d010d0d0d0c0d010505010105050505050601010101
010101010101010101010101010101050506010101011801010101010101010101060705050501010101010a010101010507050505060601010101010101010101010101010101010101010101010101010101010101010101010101010101010d0c0c0d0104040d0c0c0d0101010d0c0d060501010101010101050506010101
01010101010101010101010101010101050501010101010101010101010101010605070501010101010101010101010101010101050505060601010101010101010101010101010101010a0101010101010101010101010101010101010101010d0c0c0d0104040d0c0c0d0101010d0c0d05050d0d0d01010101010505060606
010101010301010101010101010101010105010101010101010101010101060605050101010101010d0d0d0d0d0d01010101010104010505050601010101010101010101010101010101010101010106060606060601010101010101010101010d0c0c0d0d0d0d0d0c0c0d0101010d0c0c070c0c0c0d01010101010105050505
010103010101010101010a01010101010105060101010102010101010606050505010101010d0d0d0d0c0c0c0c0d0d0d0d01010104040101050506010101010101010101030101010101010101060605050505050507060101010101010101010d0c0c0c0c0c0c0c0c0c0d0101010d0d0d050d0c0c0d0d0d0d0d0d0101010101
0101010101010101010101010101010101050506060101010101010605050501010101010d0d0c0c0c0c0c0c0c0c0c0c0d0d0d0404010101010505010101010101010103010101010101010101050505010101010507050606060606010101010d0c0c0c0c0c0c0c0c0c0d010104040406050d0c0c0c0c0c0c0c0d0d0d0d0d0d
01010101010101010101010101010101010105050506060606060605050101010101010d0c0c0c0d0d0d0d0d0d0d0d0c0c0c0d0d04010101010105060101010101010101010101010101010106050101010101010101050505050505060101010d0d0d0d0d0d0d0d0d0d0d010101040405050d0d0d0d0d0c0c0c0c0c0c0c0c0c
0d0d0d0d0d0d0d0d0d140d0101010101010101040505050505050505010101010101010d0c0c0d0d0c0c0c0c0c0c0d0d0c0c0c0d01010101010105050101010101010101010101010101010605010101010101010a0101010101040505060601010101010101010101010101010101060501010101010d0c0c0c0c0c0c0c0c0d
0c0c0c0c0c0c0c0c0c0c0d01010101010104010401010101010101010101010101010d0d0c0d0d0c0c0c0c0c0c0c0c0d0d0c0c0c0d010101010101050601010101010101010101010101010505010101010101010101010101010404050505060606060606010101010101010106060505010d0d0d0d0d0c0c0d0d0d0d0d0d0d
0c0d0d0d0d0d0d0d0d0d0d01010101010101010104010101010401040101010101010d0c0c0d0c0c0c0d0d0d0d0c0c0c0d0c0c0c0d01010a010101050506060601010101010106060606060501010101010101010101010101010104010105050505050505060606070606060605050501040d0c0c0c0c0c0c0c0c0c0d0c0c0c
0c0c0c0c0c0c0c0c0c0c0d0101010101010104010112010a010101010101040101010d0c0c0d0c0c0d0d0c0c0d0c0c0c0d0c0c0d01010101010101010105050506060706060605050505050101010101010101010101010101010401040101010101010105050505070505050505010101010d0c0c0d0d0d0c0c0d0c0d0c0c0c
0d0d0d0d0d0d0d0e0e0e0d01010101010101010104010401010104010101010101010d0c0c0d0c0c0d0c0c0c0c0c0c0c0d0c0c0d01010101010101010101010505050705050505010404010101010101010101010101020101010101010101010101010101010101010101010101010101040d0c0c0c0c0d0d0d0d0c0d0c100c
0c0c0c0c0c0c0c0c0c0c0d0101010101010101010101010101010101010101010101140c0d0d0c0c0d0c0c0c0c0c0c0d0d0c0d0d01010a01010101010101010101010101040401040104010101010101010a01010101010101010101040101010101010101010101010101010101010101010d0c0c0c0c0c0c0c0c0c0d0c0c0c
0c0c0c0c0c0c0c0c0c0c0d0101010a010104010101010104010401010401010101010d0d0d0d0c0c0d0c100c0c0d0d0d0c0c0d010101010101010a010101010101010101010404011204010101010101010101010101010101010101010101010101010101010101010101010101010101010d0d0d0d0d0c0c0d0c0c0d0c0c0c
0c0c0c0d0d0d0d0d0d0d0d0101010101010101040104010401010101010101010101010d0d0d0c0c0d0d0d0d0d0d0c0c0c0d0d0101010a010101010101010101010101010101040101040101010101010101010201010101010a0101010101020102010101010101010401010a01010101010d0c0c0c0c0c0c0d0c0c0d0c0c0c
0c100c0c0c0c0c0c0c0c0d010101010101040101010101010104010104010a01010101010d0d0c0c0c0c0c0c0c0c0c0c0d0d0101010101010101010101010101010a0101010101010401010101010101010101010101010101010101010101010101010101010104040101010101010101010d0c100c0c0c0c0d0c0c0c0c0c0c
__sfx__
00050000260502405020050000002b050300503305000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000e00000d65025650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
