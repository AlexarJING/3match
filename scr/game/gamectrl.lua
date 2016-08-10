function ctrl()
	if love.mouse.isDown("l") and leftisdown==false then
	 leftisdown=true 
	 mousex,mousey= love.mouse.getPosition()
	end
	if not(love.mouse.isDown("l")) and leftisdown==true then
		dx= love.mouse.getX()-mousex
		dy= love.mouse.getY()-mousey
		distance=math.getDistance(0,0,dx,dy)
		if distance>30 and math.abs(dy)<30 and dx>0 then
 			frame:fall(90)
		end --向右靠
		if distance>30 and math.abs(dy)<30 and dx<0 then 
			frame:fall(-90)
		end --向左靠
		if distance>30 and math.abs(dx)<30 and dy<0 then header:switch() end --调整
		if (distance>30 and math.abs(dx)<30 and dy>0) or distance<=30 then
			header:fall()
			header:new()
		end --下落
	end
	if not(love.mouse.isDown("l")) then leftisdown=false end
	if love.mouse.isDown("r") and rightisdown==false then header:switch(); rightisdown=true end  --header变换
	if not(love.mouse.isDown("r")) then rightisdown=false end
	mx=math.floor((love.mouse.getX()-24)/32)
	if mx<1 then mx=1 end
	if mx>6 then mx=6 end
	header.nb1x=mx
	header.nb2x=mx+1
	header:update()
end
