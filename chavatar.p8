pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--chavatar

function _init()
	create_player()
end

function _update()
	player_movement()
	update_camera()

end

function _draw()
	cls()
	draw_map()
	draw_player()
end


-->8
function draw_map()
	map(0,0,0,0,128,64)
end

function check_flag(flag,x,y)
	local sprite=mget(x,y)
	return fget(sprite,flag)
end

function update_camera()
	local camx=mid(0,p.x-7.5,127-15)
	local camy=mid(0,p.y-7.5,63-15)
	camera(camx*8,camy*8)
end
-->8
--player

function create_player()
	p={
		x=6;
		y=4;
		sprite=16
	}
end

function player_movement()
	newx=p.x
	newy=p.y
	
	if (btnp(⬅️)) newx-=1
	if (btnp(➡️)) newx+=1
	if (btnp(⬆️)) newy-=1
	if (btnp(⬇️)) newy+=1
	
	if not check_flag(0,newx,newy) then
		p.x=mid(0,newx,127)
		p.y=mid(0,newy,63)
	else
	sfx(0)
		end
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end
	
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
00150150001501500015015000150150001501500015015000550550005505500055055000000000000000000000000000000000000000000000000000000000
00555550005555500015555500155555001555550015555501155555011555550115555500000000000000000000000000000000000000000000000000000000
00573530005735300055573500555735005557350055573500555735505557350055573500000000000000000000000000000000000000000000000000000000
00555f5000555f500005555f0005555f0005555f0005555f5005555f0505555f5005555f00000000000000000000000000000000000000000000000000000000
000550000c0550c00c55500000555100011550000015550005055110115551101505500000000000000000000000000000000000000000000000000000000000
00555500005555000005510000c5510000055c0000155c00005555c0c55555c0c155510000000000000000000000000000000000000000000000000000000000
0c0510c0000510000c50100000051000011050000001500001555000000000000555551000000000000000000000000000000000000000000000000000000000
0005100000051000000010000005100000005000000150001c00000000000000000000c000000000000000000000000000000000000000000000000000000000
0000500000006060000000005dd5d66d098909898884949844555444585585850098900000980000000444444444444444440000000000000000000000000000
00084000066686860000000056666666009808908459498888444480454545540098800000088000004888888888888888844400000000000000000000000000
000845006860606000000000566655d609800089899488850884888044d444440099890000098000048899999999999999888444000000000000000000000000
0048840066668660000000005666666504840484954884990988890045445d450000890000008900488995555555555559999888000000000000000000000000
054484506886668600000000565dd66548584858488599940998900044d844440000890000009000889955445445d45445599998000000000000000000000000
0444884006860860000000005555566d854585458849945800980000844544850098890000090000899544d44548454d4d455559000000000000000000000000
5444484500888800000000005dd666665444544485994588000890004484445400980000009800009955454dd454445454544d55000000000000000000000000
4444484400688600000000005555555544444444549458840098000045445844000890000009000055d4d455844d844844d454d4000000000000000000000000
5444484506886860000000005dd66666544454448495888900989000454444440008990000098000000000000000000000000000000000000000000000000000
44444484006886000000000055555555444444444998859400980000f44f544f0098000000009000000000000000000000000000000000000000000000000000
00000000ac436211e3ec00967df1276995c4d047f48557d700000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000010000000000000101010101010001020200000000000101000001000000000000000000000000010101010000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
3737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737320000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000360000000000000000000000000000000036000000000000000000003600000000000000000000000000360000000000000000000000000000000036000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000380000000000000000000000000000000038000000000000000000003800000000000000000000000000380000000000000000000000000000000038000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000390000000000000000000000000000000039000000000000000000003900000000000000000000000000380000000000000000000000000000000039000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000390000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3b3c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3737373c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000003a3b3c000000000000000000000000000000000000310000000000000000003a37373737373c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000003a3737373c00000000000000000000000000000000003000000000000000003a373737373737373c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3333333333333333333333333333333333333333343433333333333333333333333333333333333333333333333333333333333333333335353533333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000b02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
