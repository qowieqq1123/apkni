









local guildOrderAI_autoDuJie={name='autoDuJie'}


function guildOrderAI_autoDuJie:onInit()
self:listenNotify(notifyConfig.onDiscipleNewID,function(...)
self:onDiscipleNewID(...)
end)
self:listenNotify(notifyConfig.onDiscipleRemove,function(...)
self:onDiscipleRemove(...)
end)
self.coolDownTime=4
self.maxBrokeNum=7
end


function guildOrderAI_autoDuJie:onDelete()
self.coolDownTime=nil
self:clearDiscipleStrGUIDJJQueue()
end

function guildOrderAI_autoDuJie:checkCond()

if UIManager:isActive('UIDiscipleSelectWin')or UIManager:isActive('UIDiscipleMainWin')
or UIManager:isActive('UIDiscipleJingJieBrokeWin')or UIManager:isActive('UIDiscipleJingJieBrokeWin_afterTX')then
return false
end
return true
end


function guildOrderAI_autoDuJie:onUpdate()
if xianjieController:isPauseUpdateInXianJie()then return end
local orderID=self.orderID
local setup,cfg=guildOrderModel:getSetupData(orderID)
if not setup.isOpen then
return guildOrderAIState.eClosed
end
if not self:checkCond()then

self:SetCoolDown(self.coolDownTime)
return guildOrderAIState.eCond
end

local floor_=cfg.jjcengRange[setup.jjcengIndex]
local list={}

local dzStrGUIDQueue=self:getDiscipleStrGUIDJJQueue()
if dzStrGUIDQueue then
for i=1,5 do
local strGUID=dzStrGUIDQueue:dequeue()
if strGUID~=nil then
local netData=UIDiscipleModel:getDiscipleDataByStr(strGUID)
if netData~=nil then
local strGuid=netData.discipleguidStr
local jjlv=netData.jingjielv
if UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData,30)then
if UIDiscipleModel:checkNextJJNeedBroke(jjlv)then

if UIDiscipleModel:checkJJBrokeByHand(jjlv)and UIDiscipleModel:checkJJAutoBrokeConditon(jjlv)then
if UIDiscipleModel:checkJJAutoBrokeConditon(jjlv)and UIDiscipleModel:checkJJAutoBrokeConditon2(strGuid)
and UIDiscipleModel:checkJJAutoBrokeConditon3(jjlv)then

local floor=UIDiscipleModel:getJJFloor(jjlv)
if floor<=floor_ then

local curTime=gameUtilityModel.getServerShortTime()
if netData.jingjieBrokeLock==nil or curTime-netData.jingjieBrokeLock>=60 then
table.insert(list,netData)
end
end
end
end
end
end
end
end
end
end
local c=#list
if c<=0 then

self:SetCoolDown(self.coolDownTime)
elseif c<=self.maxBrokeNum then
local curTime=gameUtilityModel.getServerShortTime()
for i,netData in ipairs(list)do
netData.jingjieBrokeLock=curTime
FeiShengTaiController.sendJingJieBroke(netData.discipleguid)
end

self:SetCoolDown(self.coolDownTime)
else

local curTime=gameUtilityModel.getServerShortTime()
for i=1,self.maxBrokeNum do
local netData=list[i]
if netData then
netData.jingjieBrokeLock=curTime
FeiShengTaiController.sendJingJieBroke(netData.discipleguid)
end
end
end
return guildOrderAIState.eReplay
end


function guildOrderAI_autoDuJie:getDiscipleStrGUIDJJQueue()
if self.dzStrGUIDQueue==nil or self.dzStrGUIDQueue:isEmpty()then

self.dzStrGUIDQueue=queue.New()
local allDz=UIDiscipleModel:getAllDiscipleDataX()
for strGUID,netData in pairs(allDz)do
self.dzStrGUIDQueue:enqueue(strGUID)
end
end

return self.dzStrGUIDQueue
end

function guildOrderAI_autoDuJie:clearDiscipleStrGUIDJJQueue()
self.dzStrGUIDQueue=nil
end


function guildOrderAI_autoDuJie:onDiscipleNewID(disguid,dzid)
self:clearDiscipleStrGUIDJJQueue()
end

function guildOrderAI_autoDuJie:onDiscipleRemove(reason,guid)
if reason and reason==discipleRemoveReason.eKickout then
self:clearDiscipleStrGUIDJJQueue()
end
end


return guildOrderAI_autoDuJie
