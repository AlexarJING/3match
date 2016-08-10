local block=require "scr.game.block"
local frameclass=class{
	init=function(self)
		math.randomseed(os.time()); math.random();
		self.block={}; for i=1,7,1 do self.block[i]={} end --初始化
		for i=1,7,1 do 
			for j=1,7,1 do 
				self.block[i][j]=block(-1,i,j)
			end 
		end
		self.rotation=0
	end 	
}
function frameclass:draw()
	canvas_frame:clear()
	for i=1,7,1 do
		for j=1,7,1 do
			if self.block[i][j].block_type~=-1 then
				self.block[i][j]:draw()
			end 
		end 
	end 
end


function frameclass:fall(deg)
	if deg==0 then  
		repeat
			toggle=true
			for x=1,7,1 do
				for y=6,1,-1 do 
					for w=7,y,-1 do 
						if self.block[x][w].block_type==-1 and self.block[x][y].block_type~=-1 then
							self.block[x][w]=block(self.block[x][y].block_type,x,w)
							self.block[x][y]=block(-1,x,y)
							ani_A2B(self.block[x][w]:convert2obj(),x,w,(x-1)*32,(y-1)*32,(x-1)*32,(w-1)*32,255,1)
							toggle=false
							inplay=true			
						end 
					end
				end
			end
		until toggle==true
	end
	if deg==90 then  
		repeat
			toggle=true
			for x=6,1,-1 do
				for y=7,1,-1 do 
					for w=7,x,-1 do
						if self.block[w][y].block_type==-1 and self.block[x][y].block_type~=-1 then
							self.block[w][y]=block(self.block[x][y].block_type,w,y)
							self.block[x][y]=block(-1,x,y)
							ani_A2B(self.block[w][y]:convert2obj(),w,y,(x-1)*32,(y-1)*32,(w-1)*32,(y-1)*32,255,1)
							toggle=false
							inplay=true			
						end 
					end
				end
			end
		until toggle==true
	end
	if deg==-90 then  
		repeat
			toggle=true
			for x=2,7,1 do
				for y=7,1,-1 do 
					for w=1,x,1 do 
						if self.block[w][y].block_type==-1 and self.block[x][y].block_type~=-1 then
							self.block[w][y]=block(self.block[x][y].block_type,w,y)
							self.block[x][y]=block(-1,x,y)
							ani_A2B(self.block[w][y]:convert2obj(),w,y,(x-1)*32,(y-1)*32,(w-1)*32,(y-1)*32,255,1)
							toggle=false
							inplay=true			
						end 
					end
				end
			end
		until toggle==true
	end
end 


local function findsame(self,x,y,block_type)
	foundtab={}
	trytab={}
	tab={x,y}
	table.insert(foundtab,tab)
	table.insert(trytab,tab)
	repeat --把当前点的位置加入待测列表，检测周围，如果周围不在找到列表中则加入找到列表和待测列表，直到待测列表为空
		x,y=unpack(trytab[1])
		if x+1<=7 then 
			if self.block[x+1][y].block_type==block_type then 
				tab={x+1,y}
				if not(table.find(foundtab,tab)) then
					table.insert(foundtab,tab)
					table.insert(trytab,tab)
				end
			end 
		end
		if x-1>=1 then 
			if self.block[x-1][y].block_type==block_type then 
				tab={x-1,y}
				if not(table.find(foundtab,tab)) then
					table.insert(foundtab,tab)
					table.insert(trytab,tab)
				end
			end 
		end
		if y-1>=1 then 
			if self.block[x][y-1].block_type==block_type then 
				tab={x,y-1}
				if not(table.find(foundtab,tab)) then
					table.insert(foundtab,tab)
					table.insert(trytab,tab)
				end
			end 
		end
		if y+1<=7 then 
			if self.block[x][y+1].block_type==block_type then 
				tab={x,y+1}
				if not(table.find(foundtab,tab)) then
					table.insert(foundtab,tab)
					table.insert(trytab,tab)
				end
			end 
		end	
		table.remove(trytab,1)

	until #trytab==0
	if #foundtab>=3 then --当相同大于3个时进行合并
		block_type=block_type+1
		if block_type>11 then block_type=11 end
		toptype=block_type
		x,y=unpack(foundtab[1])
		self.block[x][y]=block(block_type,x,y)
		for i=2,#foundtab,1 do
			x,y=unpack(foundtab[i])
			self.block[x][y]=block(-1,x,y)
		end
		return foundtab
	end 
	return {}
end

local function testfind(self)
	for x=1,7,1 do
		for y=1,7,1 do 
			if self.block[x][y].block_type~=-1 then
				local tab=findsame(self,x,y,self.block[x][y].block_type)
				if  #tab~= 0 then --如果找到了 
					return tab
				end
			end 
		end
	end
	return {}
end



function frameclass:combine()
	local tab=testfind(self)
	if #tab==0 then return end
	tx,ty=unpack(tab[1])
	for i=2,#tab,1 do
		ox,oy=unpack(tab[i])
		ani_A2B(self.block[tx][ty]:convert2obj(),tx,ty,(ox-1)*32,(oy-1)*32,(tx-1)*32,(ty-1)*32,255/3,1)
		inplay=true
	end
	--合并动画效果、数据结算
end

return frameclass
