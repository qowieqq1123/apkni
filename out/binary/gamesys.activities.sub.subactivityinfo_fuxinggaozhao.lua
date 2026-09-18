





local subActivityInfo_fuxinggaozhao={name='fuxinggaozhao'}

function subActivityInfo_fuxinggaozhao:onInit()

end

function subActivityInfo_fuxinggaozhao:onStart()

end

function subActivityInfo_fuxinggaozhao:onDelete()

end

function subActivityInfo_fuxinggaozhao:checkReddot()
if not self.data then
return false
end

if self.data.luckynum>=0 and self.data.recv==0 then
return true
end
if self.data.luckynum==-1 and self.data.ownList==nil then
return true
end
end














function subActivityInfo_fuxinggaozhao:getRankJackpot()
if not self.data then
return
end
local data=self.data
local ranklist=data.ranklist or{}
local rank={}
local actorid=playerModel:getActorID()
local serverID=playerModel:getActorServerID()
for i,v in ipairs(ranklist)do
if tostring(actorid)==tostring(v.actorid)and serverID==v.serverid then
table.insert(rank,i)
end
end
return rank
end

function subActivityInfo_fuxinggaozhao:getOwnJackpot()
if not self.data then
return
end
local data=self.data
local ownList=data.ownList or{}
local luckynum=data.luckynum

local own1=ownList[1]
local own2=ownList[2]
local anum=0
if own1 then
local number=own1.number
local valid=own1.valid
if valid==1 then
for i=1,6 do
local num=math.floor(number/(10^(6-i))%10)
if num==luckynum then
anum=anum+1
end
end
end
end
if own2 then
local number=own2.number
local valid=own2.valid
if valid==1 then
for i=1,6 do
local num=math.floor(number/(10^(6-i))%10)
if num==luckynum then
anum=anum+1
end
end
end
end
if anum>0 then
return anum
end
end



return subActivityInfo_fuxinggaozhao