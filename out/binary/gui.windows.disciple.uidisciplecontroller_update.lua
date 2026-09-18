







local _temp={}
local _dequeuelen=nil
local updataLookup=
{

[1]={
check=function()

local dzStrGUIDQueue=UIDiscipleController:getDiscipleStrGUIDJJQueue()
if dzStrGUIDQueue then
table.clear(_temp)
_dequeuelen=_dequeuelen or deviceHelper.isRunWebGL()and 2 or 5
for i=1,_dequeuelen do
local strGUID=dzStrGUIDQueue:dequeue()
if strGUID~=nil then
local netData=UIDiscipleModel:getDiscipleData(strGUID)
if netData~=nil then
local curTime=gameUtilityModel.getServerShortTime()
if netData.tempchecktm==nil or curTime-netData.tempchecktm>3 then
netData.tempchecktm=curTime
local guid=netData.discipleguid
local jjlv=netData.jingjielv
if UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData,30)then
if UIDiscipleModel:checkNextJJNeedBroke(jjlv)then

if strGUID~=UIDiscipleController.skipUpdataDiscipleAutoBroke and not UIDiscipleModel:checkJJBrokeByHand(jjlv)then

if netData.jingjieBrokeLock==nil or curTime-netData.jingjieBrokeLock>=60 then
netData.jingjieBrokeLock=curTime
FeiShengTaiController.sendJingJieBroke(guid)
else




end
end
else
_temp[#_temp+1]=guid
end
else

local jjlv_,point=UIDiscipleModel:getDiscipleJJLevelAndPointByData(netData)
if netData.tempJJPoint==nil then netData.tempJJPoint=point end
local old_point=netData.tempJJPoint
if old_point~=point then
netData.tempJJPoint=point
_temp[#_temp+1]=guid
end
end
end
end
end

end
if#_temp>0 then
UIDiscipleController:requireRefreshDiscipleInfoList(_temp)
end
end
end,
cond=function()
if xianjieController:isPauseUpdateInXianJie()then return false end
if fightModel:haveBattleShow()then return false end
return worldController:checkNoticiateBlockOpen()
end
},

[2]={
check=function()
local speTimePassLookup=UIDiscipleModel:getDZSpeTimePass()
if speTimePassLookup then
for guid_str,netData in pairs(speTimePassLookup)do
table.clear(_temp)
if UIDiscipleModel:hasAnyTimeSpecialityByData(netData)then
for specialityType,vv in pairs(netData.speTimePasslookup)do
for _,spe in ipairs(vv)do
if UIDiscipleModel:checkDZSpeTimeOver(spe)then
_insert(_temp,{specialityType,spe})
end
end
end
end
if#_temp>0 then
for i,d in ipairs(_temp)do
local specialitystruct={}
specialitystruct.specialitytype=d[1]
specialitystruct.specialityInfo=d[2]
UIDiscipleController.do_protocol_2_13(netData.discipleguid,0,specialitystruct)
end
end
end

end
end,
},
}

function UIDiscipleController.checkTimeUpdate()
for k,v in pairs(updataLookup)do
if v.cond then
if v.cond()then
v.check()
end
else
v.check()
end
end
end

function UIDiscipleController:getDiscipleStrGUIDJJQueue()
if self.dzStrGUIDQueue==nil or self.dzStrGUIDQueue:isEmpty()then

self.dzStrGUIDQueue=queue.New()
local allDz=UIDiscipleModel:getAllDiscipleDataX()
for strGUID,netData in pairs(allDz)do
self.dzStrGUIDQueue:enqueue(strGUID)
end
end

return self.dzStrGUIDQueue
end

function UIDiscipleController:clearDiscipleStrGUIDJJQueue()
self.dzStrGUIDQueue=nil
end

function UIDiscipleController:setSkipUpdataDiscipleAutoBroke(discipleguid)
self.skipUpdataDiscipleAutoBroke=tostring(discipleguid)
end
