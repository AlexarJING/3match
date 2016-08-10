local scene = Gamestate.new()
frame=require "scr.game.frame"()
header=require "scr.game.header"()
canvas=nil --声明游戏画布
canvas_frame = love.graphics.newCanvas(224, 224)
canvas_header= love.graphics.newCanvas(224, 64)
canvas_block = love.graphics.newCanvas(31, 31)
toptype=1
require "scr.game.gamectrl"
header:new()
gameAnimation={}
require"scr.game.ani_ctrl"
inplay=false
function scene:init()
	
end

function scene:enter()
end

function scene:update()
	inplay=animationCtrl()
	if inplay==false then ctrl() end 
	if inplay==false then frame:fall(0) end
	if inplay==false then frame:combine() end
	frame:draw()
	header:draw()
end 
function scene:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.line(23, 99, 249, 99, 249,325,23,325,23,99)
	love.graphics.draw(canvas_frame,24,100)
	love.graphics.draw(canvas_header,24,67)
	animationRender(24,100)
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