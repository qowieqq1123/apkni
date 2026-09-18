
local string_gfind=string.gmatch
local string_sub=string.sub
local table_concat=table.concat
local table_insert=table.insert
local string_find=string.find
local string_gsub=string.gsub
local string_len=string.len


local _argkeys={}
local _argIndexes={}
for i=1,9,1 do
local k=string.format('%d',i-1)
_argkeys[k]=i
_argIndexes[i]=k
end

local _split_cache_look_up={}
local _split_function={}

local outTableRegex='{([%a%d%p]+)}'
local outDataRegex='{([%a%d%p]+)}'

local _Global_replaceFunctions={}


function gen_split(delimiter)
local split_func=_split_function[delimiter]
if split_func then
return split_func
end


local _split_cache={}

setmetatable(_split_cache,{__mode='v'})

_split_cache_look_up[delimiter]=_split_cache


local function split(input,delimiter)
local arr=_split_cache[input]
if arr then

return arr
end

local pos=0


local st,sp=string_find(input,delimiter,pos,true)
if not st then
return nil
end

arr={}
table_insert(arr,string_sub(input,pos,st-1))
pos=sp+1

while true do
local st,sp=string_find(input,delimiter,pos,true)
if not st then break end
table_insert(arr,string_sub(input,pos,st-1))
pos=sp+1
end

table_insert(arr,string_sub(input,pos))
_split_cache[input]=arr

return arr
end

split_func=function(a)return split(a,delimiter)end
_split_function[delimiter]=split_func
return split_func
end

local split=gen_split(',')

local function outTable_gsub(name)
local f=_Global_replaceFunctions[name]
local r
if f then
r=f()
else
local ret=split(name)
if ret then
local f=_Global_replaceFunctions[ret[1]]
if f then
r=f(ret)
end
end
end
return r or name
end




local function outTableS(content)
local ret=string_gsub(content,outTableRegex,outTable_gsub)
return ret
end




local function outTableF(content,func,args)
local ret=string_gsub(content,outTableRegex,
function(name)
local arg_index=rawget(_argkeys,name)
local r=nil
if arg_index then
r=args[arg_index]
else
local f=func[name]
if f then
r=f()
else
local ret=split(name)
if ret then
local f=func[ret[1]]
if f then
r=f(ret,args)
end
end
end
end
return r or name
end)
return ret
end




local function outData(content,funcTable,dataTable,argTable)

local cb=nil
if argTable and#argTable>0 then
cb=function(name)
local r=nil
local f=funcTable[name]
if f then
r=funcTable[name](funcTable,dataTable)
else
local arg_index=rawget(_argkeys,name)
r=argTable[arg_index]
if not r then
r=dataTable[name]
end
end
return r or name
end
else
cb=function(name)
local r=nil
local f=funcTable[name]
if f then
r=funcTable[name](funcTable,dataTable)
else
r=dataTable[name]
end
return r or name
end
end

local ret=string_gsub(content,outDataRegex,cb)
return ret
end


FMT={}
FMT.getSplitFunction=gen_split

local function outTable(content,args)
if FMT.debug and args then

end
if not args then
return outTableS(content)
else
return outTableF(content,_Global_replaceFunctions,args)
end
end

function FMT.setReplaceFunction(k,func)
_Global_replaceFunctions[k]=func
end


function FMT.cfmt(fontColor,content,...)
local desc=FMT.fmt(content,...)
local colorStr=FONT_COLOR_FMT[fontColor]
assert(colorStr,string.format('没有找到匹配的颜色:%s',tostring(fontColor)))
return FMT.fmt(colorStr,desc)
end


function FMT.cfmt1(fontColor,content,...)
local desc=FMT.fmt(content,...)
local colorStr=FONT_TIPS_COLOR_FMT[fontColor]
assert(colorStr,string.format('没有找到匹配的颜色:%s',tostring(fontColor)))
return FMT.fmt(colorStr,desc)
end


function FMT.cfmt2(colorCode,content,...)
local desc=FMT.fmt(content,...)
local colorStr=string.format('<color=%s>{0}</color>',colorCode)
return FMT.fmt(colorStr,desc)
end


function FMT.cfmt3(colorCode,content,...)
local desc=FMT.fmt(content,...)
local colorStr=string.format('<color=#%s>{0}</color>',colorCode)
return FMT.fmt(colorStr,desc)
end

function FMT.fmt(content,...)
local args={...}
for i,v in ipairs(args)do
args[rawget(_argIndexes,i)]=tostring(v)
end
local ret=string_gsub(content,"{(%d)}",args)
return ret
end

function FMT.out(content,a,...)
if not a then
return outTableS(content)
else
return outTable(content,{a,...})
end
end

function FMT.fmtTable(content,argtable)
for i,v in ipairs(argtable)do
argtable[rawget(_argIndexes,i)]=v
end
local ret=string_gsub(content,"{(%d+)}",argtable)
return ret
end

FMT.outTable=outTable
FMT.outTableS=outTableS
FMT.outTableF=outTableF
FMT.outData=outData

local _FMT_meta={
__index=function(t,k)
local f=rawget(_Global_replaceFunctions,k)
if not f then
return nil
end
return f()
end
}

setmetatable(FMT,_FMT_meta)















































































































