
local blockclass=class{
	init=function(self,block_type,x,y)
		self.block_type=block_type
		x=x or 0
		y=y or 0
		self.x=x
		self.y=y
		self.visible=true
		--if block_type>0 then self.img= love.graphics.newImage("res/img/"..tostring(block_type)..".png") end
		local color={{255,100,100,255},
					 {255,175,100,255},
					 {255,255,100,255},
					 {175,255,100,255},
					 {100,255,100,255},
					 {100,255,175,255},
					 {100,255,255,255},
					 {100,175,255,255},
					 {100,100,255,255},
					 {175,100,255,255},
					 {255,100,255,255},
					}
		if block_type>0 then self.color=color[block_type] end
	end 
}
function blockclass:draw(where)
	if self.visible==false then return end
	if where=="header" then
		canvas_header:renderTo(function()
		love.graphics.setColor(unpack(self.color))
		local x=self.x*32-32
		local y=self.y*32-32
		love.graphics.polygon("fill", x,y,x+31,y,x+31,y+31,x,y+31)
		end	)
	return
	end
	canvas_frame:renderTo(function()
		love.graphics.setColor(unpack(self.color))
		local x=self.x*32-32
		local y=self.y*32-32
		love.graphics.polygon("fill", x,y,x+31,y,x+31,y+31,x,y+31)
	end	)	
end

function blockclass:convert2obj()
	canvas_block:renderTo(function()
		love.graphics.setColor(unpack(self.color))
		love.graphics.polygon("fill", 0,0,31,0,31,31,0,31)
		end	)
		love.graphics.setColor(255,255,255,255)
	return love.graphics.newImage(canvas_block:getImageData( ))
end 

return blockclass