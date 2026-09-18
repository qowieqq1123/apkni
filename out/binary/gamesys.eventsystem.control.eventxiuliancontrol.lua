





eventxiulianControl=gameState.addListener({})
eventxiulianControl.mainType=EVENT_TYPE.eNomal
eventxiulianControl.subType=EVENT_NORMAL_SUB_TYPE.eDiziXiulian
local _localCheckList='event_xiulian_check_list'




local oldPrint=print
local print=function(...)
oldPrint(...)
end





function eventxiulianControl:onAppStart()
self:init()
notifySystem:listenNotify(notifyConfig.onDiscipleInit,function(...)self:onDiziProInit(...)end)
notifySystem:listenNotify(notifyConfig.onDiscipleInjuryChange,function(...)self:onDiziInjuryChange(...)end)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,function(...)self:onDiziAdd(...)end)
notifySystem:listenNotify(notifyConfig.on_system_open,function(...)self:onSystemOpen(...)end)
socketManager:register_receiver(11,21,function(...)self:onRecvNextXiulian(...)end)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,function(...)self:onDiscipleStateChange(...)end)
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,function(...)self:onDiscipleRemove(...)end)
end

function eventxiulianControl:onEnterState()

end

function eventxiulianControl:onLeaveState()
self:init()
end

function eventxiulianControl:init()
self:stopTimer()

self.logWait=false
self.isReadLocalList=nil
self.systemOpen=false
self.listNum=0
self.isInitDiziData=false
self.localDzList=nil
self.localDzLookup=nil
self.dzList={}
self.dzLookup={}
self.lastReqStamp=0
self.nextStamp=0
self.initStamp=nil
self.isRecvStamp=false
self.firstCricleFinish=false
self.isChange=false
self.tempList={}
self.dznum=nil
self.dznumDirty=nil

end






function eventxiulianControl:onSystemInit()
if systemModel.isOpen(SYSTEM_DEFINE.eCultivate)then
self.systemOpen=true

else

end
end

function eventxiulianControl:onSystemOpen(sysid)
if SYSTEM_DEFINE.eCultivate==sysid then
self.systemOpen=true

end
end

function eventxiulianControl:onDiziProInit()
if self.isInitDiziData then return end
self.isInitDiziData=true
local dizilist=UIDiscipleModel:getAllDiscipleDataX()
local hasDizi=dizilist~=nil
if not hasDizi then return end
self:startTimer()
end

function eventxiulianControl:onRecvNextXiulian(shortStamp)
local stamp=timeHelper.convertLongStamp(shortStamp)
self.nextStamp=stamp
if self.initStamp==nil then
self.initStamp=stamp

local curStamp=timeHelper.getServerLongTime()
local minStamp=curStamp-90000
if self.initStamp<minStamp then
self.initStamp=minStamp
self.nextStamp=minStamp
loggerUtil.logErrFMT('修炼事件下发时间戳太小：{0}',timeHelper.getFormatByStamp(stamp))
end
end

self.isRecvStamp=true

end

function eventxiulianControl:onDiscipleStateChange(guid,stateType,o,c)
if stateType==DISCIPLE_STATE_TYPE.eChuiWei then
self.dznumDirty=true
end
end

function eventxiulianControl:onDiziAdd()
self.dznumDirty=true
if self:getDiziLength()==1 then
self:freshNextStamp(timeHelper.getServerLongTime())
end
self:startTimer()
end

function eventxiulianControl:onDiscipleRemove()
self.dznumDirty=true
end


function eventxiulianControl:getDiziLength()
if self.dznum==nil or self.dznumDirty~=false then
self.dznumDirty=false
local dizilist=UIDiscipleModel:getAllDiscipleDataX()
local hasDizi=dizilist~=nil
local num=0
if hasDizi then
for _,v in pairs(dizilist)do
local diziguid=v.netData.net.discipleguidStr
local diziInfo=self:getDizi(diziguid)
if diziInfo then
num=num+1
end
end
end
self.dznum=num
end
return self.dznum
end


function eventxiulianControl:onDiziInjuryChange(diziguid)
if UIDiscipleModel:checkInjuryType(diziguid,eInjuryType.eImminent)then
self:deleDizi(diziguid)
end
end














function eventxiulianControl:startTimer()
if self.ticktimer then return end
self.ticktimer=timer.new()
self.ticktimer:start(0.07,function()
self:update()
end)
end

function eventxiulianControl:stopTimer()
if self.ticktimer then
self.ticktimer:cancel()
end
self.ticktimer=nil
end

function eventxiulianControl:update()
if not systemModel.isOpen(SYSTEM_DEFINE.eCultivate)then return end
if fightModel:haveBattleShow()then return end
local dizilist=UIDiscipleModel:getAllDiscipleDataX()
if dizilist==nil then return end
if not self.isRecvStamp then return end
self:initDiziList(true)
self:logWaitTime()
self:dequeue()
end

function eventxiulianControl:initDiziList(update)
local dizilist=UIDiscipleModel:getAllDiscipleDataX()
local hasDizi=dizilist~=nil
if not hasDizi then return end

self:readLocalData()

local num=0
local localDzList=self.localDzList
if#localDzList>0 and not self.isReadLocalList then
self.isReadLocalList=true
local flag=false
for i,strGuid in pairs(localDzList)do
self:addDizi(strGuid)
end

else

if update then
if#self.tempList>0 then
local len=10
while#self.tempList>0 and len>0 do
len=len-1
local dzguidStr=_remove(self.tempList,1)
local netData=UIDiscipleModel:getDiscipleDataByStr(dzguidStr)
if netData and self.dzLookup[dzguidStr]==nil then
self:initAddDizi(netData)
end
end
else
for i,v in pairs(dizilist)do
self.tempList[#self.tempList+1]=v.netData.net.discipleguidStr
end
end
else
table.clear(self.tempList)
for i,v in pairs(dizilist)do
local netData=v.netData.net
if self.dzLookup[netData.discipleguidStr]==nil then
self:initAddDizi(netData)
end
end
end

self:freshLocalFile(true)
end
end

function eventxiulianControl:freshNextStamp(stamp)
local space=self:getNextSpaceTime()
if space==nil then return end
local nextStamp=stamp+space

self.nextStamp=nextStamp
end

function eventxiulianControl:getNextSpaceTime()
local num=self:getDiziLength()
if num==0 then return end
local conf=eventConfig.getCommonConfig().cultivateconf
local div=((num/conf[2])-1)*conf[3]
local space=math.floor((conf[1]+div)/num*60)
return space
end


function eventxiulianControl:getCheckDiziList()
return self.dzList
end

function eventxiulianControl:getCheckDiziLength()
return#self:getCheckDiziList()
end

function eventxiulianControl:hasDzInList()
return self:getCheckDiziLength()>0
end

function eventxiulianControl:addDizi(strGuid)
local diziInfo=self:getDizi(strGuid)
if not diziInfo then return false end
return self:addDiziImp(strGuid)
end

function eventxiulianControl:addDiziImp(strGuid)
local dzLookup=self.dzLookup
local checklist=self.dzList
if dzLookup[strGuid]then return end
checklist[#checklist+1]=strGuid
dzLookup[strGuid]=#checklist
self.listNum=self.listNum+1
self:addLocalData(strGuid)
return true
end

function eventxiulianControl:initAddDizi(netData)
if netData then

if UIDiscipleModel:checkDiscipleState2ByData(netData,DISCIPLE_STATE_TYPE.eChuiWei)then return false end

self:addDiziImp(netData.discipleguidStr)
end
end

function eventxiulianControl:dequeueDizi(idx,remove)
local dzLookup=self.dzLookup
local checklist=self.dzList
local strGuid=checklist[idx]
if strGuid==nil then return end
if remove then
dzLookup[strGuid]=nil
table.remove(checklist,idx)
self:removeLocalData(strGuid)
self.listNum=self.listNum-1
end

return strGuid
end

function eventxiulianControl:deleDizi(strGuid)
local dzLookup=self.dzLookup
local checklist=self.dzList
if not dzLookup[strGuid]then return end
local idx=dzLookup[strGuid]
dzLookup[strGuid]=nil
local len=#checklist
table.remove(checklist,idx)
self:removeLocalData(strGuid)
self.listNum=self.listNum-1
if len>#checklist then

end
end

function eventxiulianControl:dequeue()
if not self.isRecvStamp then return end
if not self:hasDzInList()then
if self.isInitDiziData then

end
return
end
self:triggerEvent()
self.firstCricleFinish=true

end









function eventxiulianControl:triggerEvent()
local stamp=timeHelper.getServerLongTime()
local nextStamp=self.nextStamp
if stamp<nextStamp then return end
local space=self:getNextSpaceTime()
if space==nil then return end
while stamp>=nextStamp do
local len=#self.dzList
if len<=0 then
if not self.firstCricleFinish then
self:initDiziList()
else break end
end
local idx=math.random(1,len)
local strGuid=self:dequeueDizi(idx,true)
if strGuid==nil then break end
if UIDiscipleModel:isZMDisciple(strGuid)then
local triggerArray=self:createTriggerInfo(strGuid,nextStamp)
if triggerArray then
eventTriggerContorl:enQueue(triggerArray)
nextStamp=nextStamp+space
self.nextStamp=nextStamp
end
end
end
end

function eventxiulianControl:createTriggerInfo(strGuid,timeStamp)
if strGuid==nil then

return false
end
if UIDiscipleModel:getDiscipleData(strGuid)==nil then
self:deleDizi(strGuid)

return false
end
local diziname=UIDiscipleModel:getDiscipleName(strGuid)
if UIDiscipleModel:checkInjuryType(strGuid,eInjuryType.eImminent)then
self:deleDizi(strGuid)

return false
end
local paramList=self:creatParamList(strGuid)
local mainType=self.mainType
local subType=self.subType

return eventTriggerModel.creatClientTriggerData(mainType,subType,1,paramList,nil,timeStamp)
end


function eventxiulianControl:creatParamList(diziguid)
return{diziguid}
end

function eventxiulianControl:getDiziID(paramList)
return paramList and paramList[1]
end

function eventxiulianControl:handleParamListToTxt(paramList)
if paramList==nil then
logErr('修炼事件没有找到任何参数')
return
end
local temp={}
local diziguid=tostring(paramList[1])
local diziInfo=self:getDizi(diziguid)
if not diziInfo then

return
end
local name=diziInfo.disciplename
temp.dizi1={diziguid=diziguid,diziname=name}
return temp
end

function eventxiulianControl:getDizi(strGuid)
local diziInfo=UIDiscipleModel:getDiscipleDataByStr(strGuid)
if diziInfo==nil or UIDiscipleModel:checkDiscipleState2ByStr(strGuid,DISCIPLE_STATE_TYPE.eChuiWei)then return end
return diziInfo
end


function eventxiulianControl:addLocalData(strGuid)
self:readLocalData()
local localDzList=self.localDzList
local localDzLookup=self.localDzLookup
if localDzLookup[strGuid]then return end
localDzLookup[strGuid]=true
localDzList[#localDzList+1]=strGuid
end

function eventxiulianControl:removeLocalData(strGuid)
self:readLocalData()
local localDzList=self.localDzList
local localDzLookup=self.localDzLookup
if localDzLookup[strGuid]==nil then return end
localDzLookup[strGuid]=nil
for i,v in ipairs(localDzList)do
if v==strGuid then
table.remove(localDzList,i)
break
end
end
self.isChange=true
self:freshLocalFile(true)
end

function eventxiulianControl:readLocalData()
if self.localDzList==nil or self.localDzLookup==nil then
self.localDzList={}
self.localDzLookup={}
local localDzList=self.localDzList
local localDzLookup=self.localDzLookup
local list=userActorArraySetting.get(ACTOR_SETTING_TYPE.eEvent,_localCheckList,{})
for i,v in ipairs(list)do
localDzList[#localDzList+1]=v
localDzLookup[v]=true
end
end
end

function eventxiulianControl:freshLocalFile(canDelay)
if not self.isChange then return end
self.isChange=false
eventControl.freshLocalVal(_localCheckList,self.localDzList,canDelay)
end

function eventxiulianControl:clearLocalFile()
eventControl.freshLocalVal(_localCheckList,nil,true)
end

function eventxiulianControl:getChange(localDzList)
return table.isDiff(localDzList,self.localDzList)
end


function eventxiulianControl:showInJianwenChannel(timeStamp,paramList)
return timeStamp and self.initStamp and timeStamp>=self.initStamp or false
end

function eventxiulianControl:log(...)

end


function eventxiulianControl:logWaitTime()












end
