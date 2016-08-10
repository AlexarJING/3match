function math.getDistance(x1,y1,x2,y2)
	return math.sqrt((x1-x2)^2+(y1-y2)^2)
end 

function math.combinenum(a,b,c)
	return a+b*c
end

function math.resolvenum(num,c)
	return num%c,(num-num%c)/c
end


function table.find(tab1,tab2)
	local find
	find=true
	where=0
	for k,v in pairs(tab1) do
		if table.concat(v,"")==table.concat(tab2,"") then return k end
	end
	return nil
end

function math.randomInt(x,y)
	num=math.floor(math.random()*(y-x+1)+x)
	return num
end

function math.getSign(num)
	if num>0 then return 1 end
	if num<0 then return -1 end
	return 0
end 