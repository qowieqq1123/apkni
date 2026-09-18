






























function printLog(tag,fmt,...)
local t={
"[",
string.upper(tostring(tag)),
"] ",
string.format(tostring(fmt),...)
}

end

function printError(fmt,...)
printLog("ERR",fmt,...)

end

function printInfo(fmt,...)
if type(DEBUG)~="number"or DEBUG<2 then return end
printLog("INFO",fmt,...)
end

local function dump_value_(v)
if type(v)=="string"then
v="\""..v.."\""
end
return tostring(v)
end

function dump(value,desciption,nesting)
if type(nesting)~="number"then nesting=3 end

local lookupTable={}
local result={}

local traceback=string.split(debug.traceback("",2),"\n")


local function dump_(value,desciption,indent,nest,keylen)
desciption=desciption or"<var>"
local spc=""
if type(keylen)=="number"then
spc=string.rep(" ",keylen-string.len(dump_value_(desciption)))
end
if type(value)~="table"then
result[#result+1]=string.format("%s%s%s = %s",indent,dump_value_(desciption),spc,dump_value_(value))
elseif lookupTable[tostring(value)]then
result[#result+1]=string.format("%s%s%s = *REF*",indent,dump_value_(desciption),spc)
else
lookupTable[tostring(value)]=true
if nest>nesting then
result[#result+1]=string.format("%s%s = *MAX NESTING*",indent,dump_value_(desciption))
else
result[#result+1]=string.format("%s%s = {",indent,dump_value_(desciption))
local indent2=indent.."    "
local keys={}
local keylen=0
local values={}
for k,v in pairs(value)do
keys[#keys+1]=k
local vk=dump_value_(k)
local vkl=string.len(vk)
if vkl>keylen then keylen=vkl end
values[k]=v
end
table.sort(keys,function(a,b)
if type(a)=="number"and type(b)=="number"then
return a<b
else
return tostring(a)<tostring(b)
end
end)
for i,k in ipairs(keys)do
dump_(values[k],k,indent2,nest+1,keylen)
end
result[#result+1]=string.format("%s}",indent)
end
end
end
dump_(value,desciption,"- ",1)

for i,line in ipairs(result)do

end
end

function dumpErr(value,desciption,nesting)
if type(nesting)~="number"then nesting=10 end

local lookupTable={}
local result={}

local traceback=string.split(debug.traceback("",2),"\n")
logErr("dump from: "..string.trim(traceback[3]))

local function dump_(value,desciption,indent,nest,keylen)
desciption=desciption or"<var>"
local spc=""
if type(keylen)=="number"then
spc=string.rep(" ",keylen-string.len(dump_value_(desciption)))
end
if type(value)~="table"then
result[#result+1]=string.format("%s%s%s = %s",indent,dump_value_(desciption),spc,dump_value_(value))
elseif lookupTable[tostring(value)]then
result[#result+1]=string.format("%s%s%s = *REF*",indent,dump_value_(desciption),spc)
else
lookupTable[tostring(value)]=true
if nest>nesting then
result[#result+1]=string.format("%s%s = *MAX NESTING*",indent,dump_value_(desciption))
else
result[#result+1]=string.format("%s%s = {",indent,dump_value_(desciption))
local indent2=indent.."    "
local keys={}
local keylen=0
local values={}
for k,v in pairs(value)do
keys[#keys+1]=k
local vk=dump_value_(k)
local vkl=string.len(vk)
if vkl>keylen then keylen=vkl end
values[k]=v
end
table.sort(keys,function(a,b)
if type(a)=="number"and type(b)=="number"then
return a<b
else
return tostring(a)<tostring(b)
end
end)
for i,k in ipairs(keys)do
dump_(values[k],k,indent2,nest+1,keylen)
end
result[#result+1]=string.format("%s}",indent)
end
end
end
dump_(value,desciption,"- ",1)

for i,line in ipairs(result)do
logErr(line)
end
end

function printf(fmt,...)

end

function checknumber(value,base)
return tonumber(value,base)or 0
end

function checkint(value)
return math.round(checknumber(value))
end

function checkbool(value)
return(value~=nil and value~=false)
end

function checktable(value)
if type(value)~="table"then value={}end
return value
end

function isset(hashtable,key)
local t=type(hashtable)
return(t=="table"or t=="userdata")and hashtable[key]~=nil
end

local setmetatableindex_
setmetatableindex_=function(t,index)
if type(t)=="userdata"then
local peer=tolua.getpeer(t)
if not peer then
peer={}
tolua.setpeer(t,peer)
end
setmetatableindex_(peer,index)
else
local mt=getmetatable(t)
if not mt then mt={}end
if not mt.__index then
mt.__index=index
setmetatable(t,mt)
elseif mt.__index~=index then
setmetatableindex_(mt,index)
end
end
end
setmetatableindex=setmetatableindex_

function clone(object)
local lookup_table={}
local function _copy(object)
if type(object)~="table"then
return object
elseif lookup_table[object]then
return lookup_table[object]
end
local newObject={}
lookup_table[object]=newObject
for key,value in pairs(object)do
newObject[_copy(key)]=_copy(value)
end
return setmetatable(newObject,getmetatable(object))
end
return _copy(object)
end

function math.newrandomseed()
local ok,socket=pcall(function()
return require("socket")
end)

if ok then
math.randomseed(socket.gettime()*1000)
else
math.randomseed(os.time())
end
math.random()
math.random()
math.random()
math.random()
end

function math.round(value)
value=checknumber(value)
return math.floor(value+0.5)
end

local pi_div_180=math.pi/180
function math.angle2radian(angle)
return angle*pi_div_180
end

local pi_mul_180=math.pi*180
function math.radian2angle(radian)
return radian/pi_mul_180
end

function io.exists(path)
local file=io.open(path,"r")
if file then
io.close(file)
return true
end
return false
end

function io.readfile(path)
local file=io.open(path,"r")
if file then
local content=file:read("*a")
io.close(file)
return content
end
return nil
end

function io.writefile(path,content,mode)
mode=mode or"w+b"
local file=io.open(path,mode)
if file then
if file:write(content)==nil then return false end
io.close(file)
return true
else
return false
end
end

function io.pathinfo(path)
local pos=string.len(path)
local extpos=pos+1
while pos>0 do
local b=string.byte(path,pos)
if b==46 then
extpos=pos
elseif b==47 then
break
end
pos=pos-1
end

local dirname=string.sub(path,1,pos)
local filename=string.sub(path,pos+1)
extpos=extpos-pos
local basename=string.sub(filename,1,extpos-1)
local extname=string.sub(filename,extpos)
return{
dirname=dirname,
filename=filename,
basename=basename,
extname=extname
}
end

function io.filesize(path)
local size=false
local file=io.open(path,"r")
if file then
local current=file:seek()
size=file:seek("end")
file:seek("set",current)
io.close(file)
end
return size
end

function table.nums(t)
local count=0
for k,v in pairs(t)do
count=count+1
end
return count
end

function table.keys(hashtable)
local keys={}
for k,v in pairs(hashtable)do
keys[#keys+1]=k
end
return keys
end

function table.values(hashtable)
local values={}
for k,v in pairs(hashtable)do
values[#values+1]=v
end
return values
end

function table.merge(dest,src)
for k,v in pairs(src)do
dest[k]=v
end
end

function table.insertto(dest,src,begin)
begin=checkint(begin)
if begin<=0 then
begin=#dest+1
end

local len=#src
for i=0,len-1 do
dest[i+begin]=src[i+1]
end
end

function table.indexof(array,value,begin)
for i=begin or 1,#array do
if array[i]==value then return i end
end
return-1
end

function table.keyof(hashtable,value)
for k,v in pairs(hashtable)do
if v==value then return k end
end
return nil
end

function table.removebyvalue(array,value,removeall)
local c,i,max=0,1,#array
while i<=max do
if array[i]==value then
table.remove(array,i)
c=c+1
i=i-1
max=max-1
if not removeall then break end
end
i=i+1
end
return c
end

function table.map(t,fn)
for k,v in pairs(t)do
t[k]=fn(v,k)
end
end

function table.walk(t,fn)
for k,v in pairs(t)do
fn(v,k)
end
end

function table.filter(t,fn)
for k,v in pairs(t)do
if not fn(v,k)then t[k]=nil end
end
end

function table.unique(t,bArray)
local check={}
local n={}
local idx=1
for k,v in pairs(t)do
if not check[v]then
if bArray then
n[idx]=v
idx=idx+1
else
n[k]=v
end
check[v]=true
end
end
return n
end



function table.empty(t)
if not t then return true end
return _G.next(t)==nil
end

string._htmlspecialchars_set={}
string._htmlspecialchars_set["&"]="&amp;"
string._htmlspecialchars_set["\""]="&quot;"
string._htmlspecialchars_set["'"]="&#039;"
string._htmlspecialchars_set["<"]="&lt;"
string._htmlspecialchars_set[">"]="&gt;"

function string.htmlspecialchars(input)
for k,v in pairs(string._htmlspecialchars_set)do
input=string.gsub(input,k,v)
end
return input
end

function string.restorehtmlspecialchars(input)
for k,v in pairs(string._htmlspecialchars_set)do
input=string.gsub(input,v,k)
end
return input
end

function string.nl2br(input)
return string.gsub(input,"\n","<br />")
end

function string.text2html(input)
input=string.gsub(input,"\t","    ")
input=string.htmlspecialchars(input)
input=string.gsub(input," ","&nbsp;")
input=string.nl2br(input)
return input
end

function string.ltrim(input)
return string.gsub(input,"^[ \t\n\r]+","")
end

function string.rtrim(input)
return string.gsub(input,"[ \t\n\r]+$","")
end

function string.trim(input)
input=string.gsub(input,"^[ \t\n\r]+","")
return string.gsub(input,"[ \t\n\r]+$","")
end

function string.ucfirst(input)
return string.upper(string.sub(input,1,1))..string.sub(input,2)
end

local function urlencodechar(char)
return"%"..string.format("%02X",string.byte(char))
end
function string.urlencode(input)

input=string.gsub(tostring(input),"\n","\r\n")

input=string.gsub(input,"([^%w%.%- ])",urlencodechar)

return string.gsub(input," ","+")
end

function string.urldecode(input)
input=string.gsub(input,"+"," ")
input=string.gsub(input,"%%(%x%x)",function(h)return string.char(checknumber(h,16))end)
input=string.gsub(input,"\r\n","\n")
return input
end

function string.utf8len(input)
local len=string.len(input)
local left=len
local cnt=0
local arr={0,0xc0,0xe0,0xf0,0xf8,0xfc}
while left~=0 do
local tmp=string.byte(input,-left)
local i=#arr
while arr[i]do
if tmp>=arr[i]then
left=left-i
break
end
i=i-1
end
cnt=cnt+1
end
return cnt
end

function string.formatnumberthousands(num)
local formatted=tostring(checknumber(num))
local k
while true do
formatted,k=string.gsub(formatted,"^(-?%d+)(%d%d%d)",'%1,%2')
if k==0 then break end
end
return formatted
end






function string.cutfloat(num,n,fillZero)
local u=math.pow(10,n);
num=num*u;
num=(num-num%(num<0 and-1 or 1))/u;
return fillZero
and string.format("%."..n.."f",num)
or tostring(num);
end

local cjson=require'cjson'

function io.readjsonfile(path)
local file=io.open(path,"r")
if file then
local content=file:read("*all")
if content==nil or content==""then
return nil
end
local ret=cjson.decode(content)
io.close(file)
return ret
end
return nil
end

function io.writejsonfile(path,content,mode)
mode=mode or"w+b"
local file=io.open(path,mode)
if file then
cjson.encode_sparse_array(true)
if file:write(cjson.encode(content))==nil then
return false
end
io.close(file)
return true
else
return false
end
end


















local _GetAPILevel=CS.AppDataModel.API_LEVEL_NUM
local _AppConfig_GetInt=CS.AppDataModel.AppConfig_GetInt

local buildin_api_level=-1

function API_LEVEL_PCALL(required_api_level,func,...)
if not buildin_api_level or buildin_api_level<0 then
buildin_api_level=_GetAPILevel
end

if required_api_level>buildin_api_level then

return false,'API_LEVEL require ='..required_api_level..' buildin = '..buildin_api_level
end
local args={...}
local ret=nil
local s,e=pcall(function()
ret={func(unpack(args))}
end)

if not s then
return false,e
end
return true,ret
end


function API_LEVEL_PCALL_EX(required_api_level,newfunc,oldfunc,except_api_level)
if not buildin_api_level or buildin_api_level<0 then
buildin_api_level=_GetAPILevel
end

local ret=nil
local s,e


if buildin_api_level>=required_api_level then
if not except_api_level or except_api_level~=buildin_api_level then
s=pcall(function()
ret={newfunc()}
end)
if s then
return true,ret
end

end
end

s,e=pcall(function()
ret={oldfunc()}
end)

if not s then
return false,e
end
return true,ret
end

local BUILDIN_API_LEVEL=1
local meta_lookup={}
local ENABLE_LOG_ERROR=false






function SET_API_LEVEL(level)
if loggerUtil.isEnable()then
BUILDIN_API_LEVEL=_AppConfig_GetInt("customBuildinAPILevel",level)
ENABLE_LOG_ERROR=true
else
BUILDIN_API_LEVEL=level
end
end

SET_API_LEVEL(deviceHelper.getAPILevel())





function SET_API_LEVEL_PCALL(required_api_level,class,name,isField,default)
if webGLHelper:checkSkipAPICheck(required_api_level)then return end
if pfCommonHelper.checkSkipAPICheck(required_api_level)then return end
local meta=getmetatable(class)
if not meta or meta.__index==nil then
error("class must has meta")
end
local enough=required_api_level<=BUILDIN_API_LEVEL


local lookup=rawget(meta_lookup,meta)
if lookup==nil then
lookup={}
local __old_index=meta.__index
rawset(meta_lookup,meta,lookup)

assert(type(__old_index)=='function')

meta.__index=function(t,k)
local f=rawget(lookup,k)

if f==nil then
return __old_index(t,k)
else
if isField then
if enough then
return __old_index(t,k)
else
return f()
end
else
return f
end
end
end

end

local pcall_method=nil

if enough and not isField then
local old_method=class[name]

pcall_method=function(...)
local ret=nil
local s,e=pcall(function(...)
ret={old_method(...)}
end,...)

if not s then
if ENABLE_LOG_ERROR then
logErr(name,e)
end
return default
end
return table.unpackEx(ret)
end
else

pcall_method=function()
if ENABLE_LOG_ERROR or deviceHelper.isRunEditor()then
logErr(FMT.fmt("当前方法{0}必须apilevel大于{1}（当前{2}）才能调用，默认返回值{3}",name,required_api_level,BUILDIN_API_LEVEL,tostring(default)))
end
return default
end
end


if rawget(class,name)then
rawset(class,name,nil)
end
rawset(lookup,name,pcall_method)
end

function SET_API_LEVEL_CLASS(required_api_level,namespace,classname,default)
if webGLHelper:checkSkipAPICheck(required_api_level)then return end
if pfCommonHelper.checkSkipAPICheck(required_api_level)then return end
local enough=required_api_level<=BUILDIN_API_LEVEL
if enough then return end


local meta=getmetatable(namespace[classname])
if meta==nil then
namespace[classname]={}
local self=namespace[classname]
meta={
__index=function(t,k)
if ENABLE_LOG_ERROR or deviceHelper.isRunEditor()then
logErr(FMT.fmt("当前类{0}必须apilevel大于{1}（当前{2}）才能调用，默认返回值{3}",classname,required_api_level,BUILDIN_API_LEVEL,tostring(default)))
end
return default
end,
__newindex=function(r,b)
if ENABLE_LOG_ERROR or deviceHelper.isRunEditor()then
logErr(FMT.fmt("当前类{0}必须apilevel大于{1}（当前{2}）才能调用，默认返回值{3}",classname,required_api_level,BUILDIN_API_LEVEL,tostring(default)))
end
end
}
setmetatable(self,meta)
end
end









