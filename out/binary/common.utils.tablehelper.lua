






_remove=table.remove
_insert=table.insert
_sort=table.sort

defaultT={}
local mt={
__newindex=function(t,k,v)
logErr('不能修改defaultT')
end,
}
setmetatable(defaultT,mt)


function table.toString(table_obj,space_count)
local print_str=""
space_count=space_count or 0
print_str=print_str.."{\n"

for key,value in pairs(table_obj)do
local str_temp=""
if type(value)=="table"then
str_temp=tostring(key).." = "..table_to_string(value,space_count+4)
elseif type(value)=="string"then
value=string.gsub(value,"\n","    ")
str_temp=tostring(key).." = \""..tostring(value).."\""
else
str_temp=tostring(key).." = "..tostring(value)
end

if type(key)=="string"then
str_temp="[ \""..key.."\" ]"..str_temp
else
str_temp="[ "..key.." ]"..str_temp
end


print_str=print_str..string.rep(' ',space_count+4)..str_temp..",\n"
end
print_str=print_str..string.rep(' ',space_count).."}"
return print_str
end


function table.numsEx(t)
if not t then
return 0
end
local count=0
for k,v in pairs(t)do
count=count+1
end
return count
end



function table.containsKey(tb,key)
for k,v in pairs(tb)do
if k==key then
return true
end
end
return false
end

function table.findValue(tb,val)
for k,v in pairs(tb)do
if v==val then
return k
end
end
end

function table.findValueEx(tb,val,convert)
for k,v in pairs(tb)do
if convert(v)==convert(val)then
return k
end
end
end

function table.containsValue(tb,val)
for k,v in pairs(tb)do
if v==val then
return true
end
end
return false
end

function table.containsValueEx(tb,val,convert)
for k,v in pairs(tb)do
if convert(v)==convert(val)then
return true
end
end
return false
end


function table.containsTableValue(ta,tb)
for i,v in ipairs(ta)do
if table.containsValue(tb,v)then
return true
end
end
return false
end


function table.removeValue(tb,val)
if#tb<=0 then return false end
local exist=false
for i=#tb,1,-1 do
if val==tb[i]then
table.remove(tb,i)
exist=true
end
end
return exist
end

function table.removeValueEx(tb,val,convert)
if#tb<=0 then return false end
local exist=false
for i=#tb,1,-1 do
if convert(val)==convert(tb[i])then
table.remove(tb,i)
exist=true
end
end
return exist
end


function table.addValue(tb,val)
if#tb>0 then
for i=1,#tb do
if val==tb[i]then
return
end
end
end
tb[#tb+1]=val
end


function table.deletelist(list,indexlist)
if indexlist==nil then return list end

local temp={}
local lookup={}
for _,v in ipairs(indexlist)do
lookup[v]=true
end

for i,v in ipairs(list)do
if not lookup[i]then
temp[#temp+1]=v
end
end
return temp
end



function table.insertRange(list,range,index)
for i=#range,1,-1 do
_insert(list,index,range[i])
end
end


function table.getRange(range,index)
local list={}
for i=index,#range do
list[#list+1]=range[i]
end
return list
end


function table.addRange(list,range)
for i=1,#range do
list[#list+1]=range[i]
end
end


function table.reverse(tab)
local tmp={}
for i=#tab,1,-1 do
tmp[#tmp+1]=tab[i]
end
return tmp
end


function table.deepCopy(input,cache,clear)
if input==nil then return end
if clear~=false then
if cache then
table.clear(cache)
else
cache={}
end
end
for k,v in pairs(input)do
if type(v)=='table'then
cache[k]=table.deepCopy(v)
else
cache[k]=v
end
end
return cache
end


function table.weakCopy(input)
if input==nil then return end
local o={}
for k,v in pairs(input)do
o[k]=v
end
return o
end


function table.refClone(input)
if input==nil then return end
local o={}
for k,v in pairs(input)do
local t={}
t.cfg=v
o[k]=t
end
return o
end



function table.concatTable(table1,table2,...)
if table1==nil then return table2 end
if table2==nil then return table1 end
local temp={}
for _,v in ipairs(table1)do
temp[#temp+1]=v
end

for _,v in ipairs(table2)do
if not table.containsValue(temp,v)then
temp[#temp+1]=v
end
end
return table.concatTable(temp,...)
end


function table.concatTableX(table1,table2,...)
if table1==nil then return table2 end
if table2==nil then return table1 end
local temp={}
for _,v in ipairs(table1)do
temp[#temp+1]=v
end

for _,v in ipairs(table2)do
temp[#temp+1]=v
end
return table.concatTableX(temp,...)
end


function table.concatTableXX(list1,list2)
local temp={}
local insert=function(list)
for _,v1 in ipairs(temp)do
if v1[1]==list[1]then
v1[2]=v1[2]+list[2]
return
end
end
temp[#temp+1]={list[1],list[2]}
end

if list1 then
for _,v in pairs(list1)do
insert(v)
end
end

if list2 then
for _,v in pairs(list2)do
insert(v)
end
end
return temp
end

local templist={}


function table.insertTable(list1,list2,idx)



local n=#list1
if idx==nil or idx>n then idx=n+1 end
if list2~=nil and#list2>0 then
local n2=0
if idx<=n then
for i=idx,n do
n2=n2+1
templist[n2]=list1[i]
end
end
local idx_=idx
for _,v in ipairs(list2)do
list1[idx_]=v
idx_=idx_+1
end

if n2>0 then
for i=1,n2 do
list1[idx_]=templist[i]
templist[i]=nil
idx_=idx_+1
end
end
end
end



function table.contrastTable(t1,t2)
if type(t1)~=type(t2)or type(t1)~='table'then return false end
if#t1~=#t2 then return false end
for i,v in ipairs(t1)do
if t1[i]~=t2[i]then
return false
end
end
return true
end

function table.checkCreateSubTable(table1,subKeys)
local temp=table1
for i,v in ipairs(subKeys)do
if not temp[v]then
temp[v]={}
elseif type(temp[v])~="table"then
return false
end
temp=temp[v]
end
return true
end


function table.toTable(startidx,endIdx)
if startidx==nil or endIdx==nil or endIdx<startidx then return{}end
local temp={}
local endIndex=endIdx-startidx+1
local idx=startidx
for i=1,endIndex do
temp[i]=idx
idx=idx+1
end
return temp
end

function table.isDiff(table1,table2)
if table1==nil and table2~=nil then return true end
if table1~=nil and table2==nil then return true end
if#table1~=#table2 then return true end
for i,v in ipairs(table1)do
if tostring(v)~=tostring(table2[i])then
return true
end
end
return false
end

function table.isDiffValue(table1,table2)
if table1==nil and table2~=nil then return true end
if table1~=nil and table2==nil then return true end
if#table1~=#table2 then return true end
for i,v in ipairs(table1)do
if v~=table2[i]then
return true
end
end
return false
end

function table.sub(table1,startIndex,endIndex)
if table1==nil then return end
if endIndex==nil then endIndex=#table1 end
if startIndex>endIndex then return end
if#table1==0 then return{}end
local temp={}
local index=0
for i=startIndex,endIndex do
if table1[i]then
index=index+1
temp[index]=table1[i]
end
end
return temp
end


function table.randomIndex(t,ignoreIndex)
if t==nil or type(t)~='table'or#t<=0 then return end
local temp=t
if ignoreIndex then
if type(ignoreIndex)~='number'then return end
temp={}
for i,v in ipairs(t)do
if i~=ignoreIndex then
temp[#temp+1]=v
end
end
end
return temp[math.random(1,#temp)]
end




function table.randomWeight(t,n,totalWeight)
n=n or 1
if t==nil or type(t)~='table'or#t<=0 or(t[1]~=nil and type(t[1])~='table')or
(t[1][n]~=nil and type(t[1][n])~='number')then
return nil,-1
end
if#t==1 then
return t[1],1
end
if not totalWeight then
totalWeight=0
for _,info in ipairs(t)do
totalWeight=totalWeight+info[n]
end
end
if totalWeight<=0 then
return nil,-2
end

local rand=math.floor(math.random()*totalWeight)+1
local rate=0
for idx,info in ipairs(t)do
rate=rate+info[n]
if rand<=rate then
return info,idx
end
end
end

function table.equals(ta,tb)
if ta==nil and tb~=nil then return false end
if tb==nil and ta~=nil then return false end
local lena=0
for i,v in pairs(ta)do
lena=lena+1
end

for i,v in pairs(tb)do
lena=lena-1
if lena<0 then return false end
end
if lena~=0 then return false end
for k,v in pairs(ta)do
if tb[k]==nil then return false end
local atype=type(v)
local btype=type(tb[k])
if atype~=btype then return false end

if atype=='table'then
local v1=tb[k]
local ret=table.equals(v,v1)
if not ret then
return false
end
else
if tb[k]~=v then
return false
end
end
end
return true
end


local lazyMethodLookupKey={}
function table.setLazyMethod(tb,methodName,methodCreator)
local meta=GETMETATABLE(tb)
local lazyMethodLookup=RAWGET(tb,lazyMethodLookupKey)


if not lazyMethodLookup then
lazyMethodLookup={}
RAWSET(tb,lazyMethodLookupKey,lazyMethodLookup)
local meta=GETMETATABLE(tb)
if not meta then
meta={
__index=function(t,k)
local m=RAWGET(lazyMethodLookup,k)
local func=methodCreator()
RAWSET(t,k,func)
return func
end
}
SETMETATABLE(tb,meta)
else
local __oldIndex=meta.__index
local redirect_index={}
local redirect_index_func=nil
if type(__oldIndex)=='table'then
redirect_index_func=function(t,k)
return __oldIndex[k]
end
else
redirect_index_func=__oldIndex
end
SETMETATABLE(redirect_index,{__index=__oldIndex})
meta.__index=function(t,k)
local m=RAWGET(lazyMethodLookup,k)
if not m then
return redirect_index_func(t,k)
end
local func=methodCreator(t)
RAWSET(t,k,func)
return func
end
end
end
RAWSET(lazyMethodLookup,methodName,methodCreator)
end


function table.unpackEx(t)
local len=0
for i,_ in pairs(t)do
if len<i then
len=i
end
end
local unpackx
unpackx=function(t,i,j)
i=i or 1
j=j or 1
if i<=j then
local v=t[i]
if v==nil then
return nil,unpackx(t,i+1,j)
else
return v,unpackx(t,i+1,j)
end
end
end
return unpackx(t,1,len)
end

function table.clear(t)
for k,v in pairs(t)do
t[k]=nil
end
end

function table.replaceKey(t,replacename,val)
for k,v in pairs(t)do
if k==replacename then
t[k]=val
return true
elseif type(v)=='table'then
return table.replaceKey(v,replacename,val)
end
end
return false
end




function table.getValueUpIdx(tbl,val)
local get_idx=0
for i,v in ipairs(tbl)do
if v[1]<=val then
get_idx=i
else
break
end
end
return get_idx
end


function table.concatPairs(scr,dest)
if dest==nil then
return scr
end
for k,v in pairs(scr)do
if dest[k]==nil then
dest[k]=v
end
end
return dest
end


function table.getKeyValue(T,key,...)
if T==nil then return end
if key==nil then return T end
local data=T[key]
local temp=data==nil
if key and temp then return nil end
if temp then return T end
return table.getKeyValue(data,...)
end


function table.getNumberStartIndex(T,target)
if T==nil then return end
local left,right=1,#T
if target>T[right]then return end
while left<=right do
local mid=math.floor((left+right)/2)
local mid_val=T[mid]
if mid_val==target then
return mid
elseif mid_val<target then
left=mid+1
else
right=mid-1
end
end
end


local calNum=0
function table.getBiggerNumberStartIndex(T,target)
if T==nil or#T==0 then return end
local left,right=1,#T
if target>T[right]then return end
calNum=0
local total=right
while left<=right do
local mid=math.floor((left+right)/2)
if T[mid]<target then
left=mid+1
else
right=mid-1
end
calNum=calNum+1

end
return left
end


function table.getBiggerValueStartIndex(T,target,attrname)
if T==nil or#T==0 then return end
local left,right=1,#T
if target>T[right][attrname]then return end
while left<=right do
local mid=math.floor((left+right)/2)
if T[mid][attrname]<target then
left=mid+1
else
right=mid-1
end
end
return left
end


function table.getSmallgerNumberStartIndex(T,target)
if T==nil or#T==0 then return end
local left,right=1,#T
if target<T[1]then return end
local result=nil
while left<=right do
local mid=math.floor((left+right)/2)
if T[mid]<=target then
result=mid
left=mid+1
else
right=mid-1
end
end
return result
end


function table.getSmallgerValueStartIndex(T,target,attrname)
if T==nil or#T==0 then return end
local left,right=1,#T
if target<T[1][attrname]then return end
local result=nil
while left<=right do
local mid=math.floor((left+right)/2)
if T[mid][attrname]<=target then
result=mid
left=mid+1
else
right=mid-1
end
end
return left
end
