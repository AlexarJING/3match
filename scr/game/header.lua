local block=require "scr.game.block"
local headerclass=class{
	init=function(self)
		self.block={}; for i=1,7,1 do self.block[i]={} end --初始化
		for i=1,7,1 do 
			for j=1,2,1 do 
				self.block[i][j]=block(-1,i,j)
			end 
		end
		self.rotation=0
	end 
}

function headerclass:draw()
	canvas_header:clear()
	self.block[self.nb1x][self.nb1y]:draw("header")
	self.block[self.nb2x][self.nb2y]:draw("header")
end

function headerclass:new()
	self.nb1=block(math.randomInt(1,toptype),3,1)
	self.nb2=block(math.randomInt(1,toptype),4,1)
	self.nb1x=3;self.nb1y=1
	self.nb2x=4;self.nb2y=1
	self.block[3][1]=self.nb1
	self.block[4][1]=self.nb2
end 

function headerclass:fall()
	--要加入动画
	for i=1,7,1 do
		for j=1,2,1 do
			if self.block[i][j].block_type~=-1 then
				if frame.block[i][j].block_type~=-1 then --gameover
				end 
				frame.block[i][j]=self.block[i][j]
				self.block[i][j]=block(-1,i,j)
			end 
		end 
	end 
end

function headerclass:switch()
	local bt=self.nb2
	self.nb2=self.nb1
	self.nb1=bt
end

function headerclass:update()
	for i=1,7,1 do 
		for j=1,2,1 do 
			self.block[i][j]=block(-1,i,j)
		end 
	end
	self.block[self.nb1x][self.nb1y]=self.nb1
	self.block[self.nb2x][self.nb2y]=self.nb2
	self.block[self.nb2x][self.nb2y].x=self.nb2x
	self.block[self.nb1x][self.nb1y].x=self.nb1x
end

return headerclass