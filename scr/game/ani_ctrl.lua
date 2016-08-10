local spriteAnimation=class{
	init=function(self,animationData,x,y,callbackfunc,alpha)
		self.ani_data=animationData
		self.maxframe=#animationData
		self.x=x
		self.y=y
		self.func=callbackfunc
		self.alpha=alpha
		self.index=1
		table.insert(gameAnimation, self)
	end 
}

function addOneFrame(where,what,x,y,r,ws,hs,ox,oy,frame,alpha)
	tab={}
	x=x or 0;tab.x=x
	y=y or 0;tab.y=y
	r=r or 0;tab.r=r
	ws=ws or 1;tab.ws=ws
	hs=hs or 1;tab.hs=hs
	ox=ox or 0;tab.ox=ox
	oy=oy or 0;tab.oy=oy
	frame=frame or 1 ; tab.frame=frame
	alpha=alpha or 255;tab.alpha=alpha
	tab.img=what
	table.insert(where,tab)
end

function animationCtrl()
	if #gameAnimation==0 then return false end 
	for k,v in pairs(gameAnimation) do
		v.index=v.index+1/v.ani_data[math.floor(v.index+1)].frame
	end
	repeat
		toggle=true
		for k,v in pairs(gameAnimation) do
			if v.index>=v.maxframe then
				v.func(v.x,v.y)
				table.remove(gameAnimation, k)
				toggle=false
				break
			end
		end
	until toggle==true
	return true
end

function animationRender(offx,offy)
	if #gameAnimation==0 then return end
	for k,v in pairs(gameAnimation) do
		love.graphics.setColor(255, 255, 255, v.alpha)
		love.graphics.draw(v.ani_data[v.index].img, 
						v.ani_data[v.index].x+offx, 
						v.ani_data[v.index].y+offy, 
						v.ani_data[v.index].r, 
						v.ani_data[v.index].sx,
						v.ani_data[v.index].sy,
						v.ani_data[v.index].ox,
						v.ani_data[v.index].oy)
	end	
end


function ani_A2B(what,idx,idy,x1,y1,x2,y2,alpha,dt)
	local frameSet={}
	local stepx=math.abs(x1-x2)/(dt*30)*math.getSign(x2-x1)
	local stepy=math.abs(y1-y2)/(dt*30)*math.getSign(y2-y1)
	local y=nil ;local x=nil 
	for x=x1,x2,stepx do 
		y=y or y1
		y=y+stepy
		if y>y2 and stepy>0 or y<y2 and stepy<0 then break end
		addOneFrame(frameSet,what,x,y)
	end
	frame.block[idx][idy].visible=false
	f=function(x,y) 
		frame.block[x][y].visible=true
	end
	if #frameSet==0 then return end
	spriteAnimation(frameSet,idx,idy,f,alpha)
end


return spriteAnimation

