





local _string_format=string.format
string.format=function(formatstring,...)
if...==nil then
return formatstring
end
local args={...}
local i=0
for v in string.gmatch(formatstring,'%%%a')do
i=i+1
if v=='%s'then
args[i]=tostring(args[i])
end
end
return _string_format(formatstring,unpack(args))
end


xpcall=function(f,msgh,arg1,...)
local rets={pcall(f,arg1,...)}
if not rets[1]then
msgh(rets[2])
end
return unpack(rets)
end


local _random=math.random
math.random=function(m,n)
if m then
if n then
if n<m then
n=m
end
return _random(m,n)
else
return _random(m)
end
else
return _random()
end
end