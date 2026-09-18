





serializeHelper={}



local _rep=string.rep

function serializeHelper.serialize(o,nl,tgap)
local table_concat=table.concat
local string_find=string.find
local string_format=string.format
local t={}
local tab=''
nl=nl or'\n'
tgap=tgap or'    '
local function serialize(o,tab)
if type(o)=='number'then
t[#t+1]=tostring(o)
elseif tonumber(o)then
if string_find(o,'+')then
t[#t+1]=string_format('%q',o)
else
t[#t+1]=tostring(o)
end
elseif type(o)=='string'then
t[#t+1]=string_format('%q',o)
elseif type(o)=='table'then
t[#t+1]='{'..nl
for k,v in pairs(o)do
if type(k)=='number'then
t[#t+1]=string_format(tab..' [%s]=',k)
else
t[#t+1]=string_format(tab..' [\'%s\']=',k)
end
serialize(v,tab..tgap)
t[#t+1]=','..nl
end
t[#t+1]=tab..'}'..nl
elseif type(o)=='boolean'then
if o then
t[#t+1]='true'
else
t[#t+1]='false'
end
else
t[#t+1]=tostring(o)
end
end

serialize(o,tab)

return table_concat(t)
end


function serializeHelper.serializeEx(o,nl,tgap)



error('')





local table_concat=table.concat
local string_find=string.find
local string_format=string.format
local t=''

nl=nl or'\n'
tgap=tgap or'\t'
local function serialize(o,depth)
assert(depth<255,'serialize to deep')
local tab=_rep(tgap,depth)
if type(o)=='number'then
t=t..tostring(o)
elseif tonumber(o)then
if string_find(o,'+')then
t=t..string_format('%q',o)
else
t=t..tostring(o)
end
elseif type(o)=='string'then
t=t..string_format('%q',o)
elseif type(o)=='table'then
t=t..'{'

for k,v in pairs(o)do
serialize(v,depth+1)
t=t..','

end

t=t..'}'


elseif type(o)=='boolean'then
if o then
t=t..'true'
else
t=t..'false'
end
else

t=t..'int64.new(\''..tostring(o)..'\')'
end
end
serialize(o,0)

t=string.gsub(t,',}','}')
return string.sub(t,2,string.len(t)-1)
end


function serializeHelper.unserialize(lua)
local t=type(lua)
if t=="nil"or lua==""then
return nil
elseif t=="number"or t=="string"or t=="boolean"then
lua=tostring(lua)
else
error("can not unserialize a "..t.." type.")
end
lua="return "..lua
local func=loadstring(lua)
if func==nil then
return nil
end
return func()
end


function serializeHelper.formatCode(content)
local space=0
local t={}
local spaceChar='\t'
local lineChar='\n'
local insertSpace=function()
if space>0 then
for i=1,space do
t[#t+1]=spaceChar
end
end
end
local isChar=function(char)
return char and char~=''and char~='{'and char~='}'and char~=','or false
end
local len=string.len(content)
local skip={}
for i=1,len do
if not skip[i]then
local st=string.sub(content,i,i)
local nextSt=i<len and string.sub(content,i+1,i+1)or''
local needInsertSpace=false
if st=='{'then
t[#t+1]=lineChar
insertSpace()
t[#t+1]=st
needInsertSpace=isChar(nextSt)
if needInsertSpace then
t[#t+1]=lineChar
end
space=space+1
elseif st=='}'and nextSt==','then
space=space-1
t[#t+1]=lineChar
insertSpace()
t[#t+1]=st
t[#t+1]=nextSt
local nextSt=string.sub(content,i+1,i+1)
needInsertSpace=isChar(nextSt)
skip[i+1]=true
elseif st=='}'then
space=space-1
t[#t+1]=lineChar
insertSpace()
t[#t+1]=st
needInsertSpace=isChar(nextSt)
elseif st==','then
t[#t+1]=st
needInsertSpace=isChar(nextSt)
if needInsertSpace then
t[#t+1]=lineChar
end
else
t[#t+1]=st
end
if needInsertSpace then
insertSpace()
end
end
end
return table.concat(t,"")
end
