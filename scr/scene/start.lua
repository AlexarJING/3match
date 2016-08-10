local scene = Gamestate.new()
function scene:init()
	print("this is in start")	
end 

function scene:enter()
end
local triangles={}
function scene:update()
	
	if love.keyboard.isDown("1") then Gamestate.switch(state.game) end 
	if love.keyboard.isDown("2") then
		triangles=love.math.triangulate(100, 100, 200, 100, 150, 200,200,200,450,350,255,128,153,50)
	end 
end 

function scene:draw()
	love.graphics.setColor(255, 255, 255, 125)
	love.graphics.polygon('fill', 100, 100, 200, 100, 150, 200,200,200,450,350,255,128,153,50)
	if triangles==nil then return end
	love.graphics.setColor(255, 0, 0, 125)
	for k,v in ipairs(triangles) do
		for k2,v2 in ipairs(v) do 
			triangles[k][k2]=triangles[k][k2]+1
		end 
		love.graphics.polygon("fill", v)
	end
end

function scene:leave()
end 
return scene
--[[
		init             = __NULL__,
		enter            = __NULL__,
		leave            = __NULL__,
		update           = __NULL__,
		draw             = __NULL__,
		focus            = __NULL__,
		keyreleased      = __NULL__,
		keypressed       = __NULL__,
		mousepressed     = __NULL__,
		mousereleased    = __NULL__,
		joystickpressed  = __NULL__,
		joystickreleased = __NULL__,
		quit             = __NULL__,]]

