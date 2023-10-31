pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--jeu de shooter
--nadege

function _init()
	p={x=60,y=90,speed=4}
	bullets={}
	enemies={}
	explosions={}
	create_stars()
	score=0
end

function _update60()
	update_player()
	update_bullets()
	update_stars()
	if #enemies==0 then
		spawn_enemies(ceil(rnd(4)))
	end
	update_enemies()
	update_explosions()
end

function _draw()
	cls(7)
	--stars
	for i in all(stars) do
		pset(i.x,i.y,i.col)
	end
	--vaisseau
	spr(1,p.x,p.y)
	--enemies
	for i in all(enemies) do
		spr(3,i.x,i.y)
	end
	--explosions
	draw_explosions()
	--bullets
	for i in all(bullets) do
	spr(2,i.x,i.y)
	end
	--score
	print("score:\n"..score,2,2,1)
end
-->8
--bullets

function shoot()
	new_bullet={
		x=p.x,
		y=p.y,
		speed=4
	}
	add(bullets,new_bullet)
	sfx(0)
end

function update_bullets()
	for i in all(bullets) do
		i.y-=i.speed
		if i.y < -8 then
			del(bullets,b)
		end
	end
end
-->8
--stars

function create_stars()
	stars={}
	for i=1,14 do 
		new_star={
			x=rnd(128),
			y=rnd(128),
			col=rnd({2,13}),
			speed=0.5+rnd(0.5)
		}
		add(stars,new_star)
	end
	for i=1,9 do 
		new_star={
			x=rnd(128),
			y=rnd(128),
			col=rnd({7,8,14}),
			speed=1.5+rnd(1.5)
		}
		add(stars,new_star)
	end
end

function update_stars()
	for i in all(stars) do
		i.y+=i.speed
		if i.y > 128 then
			i.y=0
			i.x=rnd(128)
		end
	end
end
-->8
--enemies

function spawn_enemies(amount)
	gap=(128-8*amount)/(amount+1)
	for i=1, amount do
		new_enemy={
			x=gap*i+8*(i-1),
			y=-20,
			life=2
	 }
	add(enemies,new_enemy)
	end
end

function update_enemies()
	for e in all(enemies) do
		e.y+=0.3
		if e.y > 128 then
			del(enemies,e)
		end
		--collision
		for b in all(bullets) do 
			if collision(e,b) then
				create_explosion(b.x+4,b.y+2)
				del(bullets,b)
				e.life-=1
				if e.life==0 then
					del(enemies,e)
					score+=100
				end
			end
		end
	end
end

	--descend a la moitie de l'ecran
		--if i.y < 30 then
		--i.y+=0.3
		--end
-->8
--collisions

function collision(a,b)
	if a.x > b.x + 8 
	or a.y > b.y + 8
	or a.x + 8 < b.x
	or a.y + 8 < b.y then
		return false
	else
		return true
	end
end
-->8
--explosions

function create_explosion(x,y)
 		sfx(1)
	add(explosions,{x=x,y=y,timer=0})
end

function update_explosions()
	for e in all(explosions) do 
		e.timer+=1
		if e.timer==13 then
			del(explosions,e)
		end
	end
end

function draw_explosions()
	circ(x,y,rayon,couleur)
	for e in all(explosions) do
		circ(e.x,e.y,e.timer/2,
		     8 + e.timer%2)
	end
end
-->8
--player

function update_player()
	if (btn(➡️)) p.x+=p.speed
	if (btn(⬅️)) p.x-=p.speed
	if (btn(⬆️)) p.y-=p.speed
	if (btn(⬇️)) p.y+=p.speed
	if (btnp(❎)) shoot()
end
__gfx__
000000000000000000200200000004b00000b30009900990004444000aaafa000000000000000000000000000000000000000000000000000000000000000000
00000000008008000020020000fa9a3b00eb32009449944904444440afafafa00000000000000000000000000000000000000000000000000000000000000000
007007000080080000e00e000faaaa030e82882090099009444ff444aaaafaf00000000000000000000000000000000000000000000000000000000000000000
00077000082c728000000000ffaaaa000ea88a209094490944499444878787800000000000000000000000000000000000000000000000000000000000000000
00077000082cc28000e00e00faaaa9000e88882049400494f444444f878787800000000000000000000000000000000000000000000000000000000000000000
007007002882288200000000aaaa90000e88a800049999409f4444f9878787800000000000000000000000000000000000000000000000000000000000000000
000000002888888200000000aaa90000008882000044440009ffff90878787800000000000000000000000000000000000000000000000000000000000000000
00000000090220900000000099000000000820000000000000999900878787800000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000170101e040220202d6402f62032630236201a020130200e0300a040030400203000000000000000000000000000000028000000000000000000000000000000000000000000000000000000000000000
000100003d65039650326502b6502265019650116500d6500b6500865000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
