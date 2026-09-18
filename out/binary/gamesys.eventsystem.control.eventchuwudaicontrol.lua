





eventChuWuDaiControl=gameState.addListener({})
eventChuWuDaiControl.mainType=EVENT_TYPE.eNomal
eventChuWuDaiControl.subType=EVENT_NORMAL_SUB_TYPE.eChuWuDai
local _localCheckList='event_chuwudai_check_list'




local oldPrint=print
local print=function(...)
end





function eventChuWuDaiControl:onAppStart()
self:init()
notifySystem:listenNotify(notifyConfig.onDiscipleInit,function(...)self:onDZProInit(...)end)
notifySystem:listenNotify(notifyConfig.onDiscipleInjuryChange,function(...)self:onDZInjuryChange(...)end)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,function(...)self:onDZAdd(...)end)
socketManager:register_receiver(11,26,function(...)self:onRecvNextStamp(...)end)
end

function eventChuWuDaiControl:onEnterState()

end

function eventChuWuDaiControl:onLeaveState()
self:init()
end

function eventChuWuDaiControl:init()
self:stopTimer()
self.logWait=false
self.isReadLocalList=nil
self.listNum=0
self.isInitDZData=false
self.localDZList=nil
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
end





function eventChuWuDaiControl:onDZProInit()
if self.isInitDZData then return end
self.isInitDZData=true
local dzlist=UIDiscipleModel:getAllDiscipleDataX()
local hasDZ=dzlist~=nil
if not hasDZ then return end
self:startTimer()
end

function eventChuWuDaiControl:onRecvNextStamp(shortStamp)
local stamp=timeHelper.convertLongStamp(shortStamp)
self.nextStamp=stamp
if self.initStamp==nil then
self.initStamp=stamp
local curStamp=timeHelper.getServerLongTime()
local minStamp=curStamp-90000
if self.initStamp<minStamp then
self.initStamp=minStamp
self.nextStamp=minStamp
loggerUtil.logErrFMT('储物袋事件下发时间戳太小：{0}',timeHelper.getFormatByStamp(stamp))
end
end
self.isRecvStamp=true

end

function eventChuWuDaiControl:onDZAdd()
if self:getDzCount()==1 then
self:freshNextStamp(timeHelper.getServerLongTime())
end
self:startTimer()
end

function eventChuWuDaiControl:onDZInjuryChange(dzguid)
if UIDiscipleModel:checkInjuryType(dzguid,eInjuryType.eImminent)then
self:delDZ(tostring(dzguid))
end
end



function eventChuWuDaiControl:getDzCount()
local dzlist=UIDiscipleModel:getAllDiscipleDataX()
local hasDZ=dzlist~=nil
local num=0
if hasDZ then
for _,v in pairs(dzlist)do
local strDzGuid=v.netData.net.discipleguidStr
local dzInfo=self:getDZ(strDzGuid)
if dzInfo then
num=num+1
end
end
end
return num
end





function eventChuWuDaiControl:startTimer()
if self.ticktimer then return end
self.ticktimer=timer.new()
self.ticktimer:start(0.11,function()
self:update()
end)
end

function eventChuWuDaiControl:stopTimer()
if self.ticktimer then
self.ticktimer:cancel()
end
self.ticktimer=nil
end

function eventChuWuDaiControl:update()
if not systemModel.isOpen(SYSTEM_DEFINE.eStorageBag)then return end
if fightModel:haveBattleShow()then return end
local dzlist=UIDiscipleModel:getAllDiscipleDataX()
if dzlist==nil then return end
if not self.isRecvStamp then return end
self:initDZList(true)
self:logWaitTime()
self:dequeue()
end

function eventChuWuDaiControl:initDZList(update)
local dzlist=UIDiscipleModel:getAllDiscipleDataX()
local hasDZ=dzlist~=nil
if not hasDZ then return end

self:readLocalData()

local num=0
local localDZList=self.localDZList
local saveNum=#localDZList
if#localDZList>0 and not self.isReadLocalList then
self.isReadLocalList=true
local flag=false
for i,v in pairs(localDZList)do
self:addDZ(v)
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
for i,v in pairs(dzlist)do
self.tempList[#self.tempList+1]=v.netData.net.discipleguidStr
end
end
else
table.clear(self.tempList)
for i,v in pairs(dzlist)do
local netData=v.netData.net
if self.dzLookup[netData.discipleguidStr]==nil then
self:initAddDizi(netData)
end
end
end
self:freshLocalFile(true)
end
end

function eventChuWuDaiControl:freshNextStamp(stamp)
local space=self:getNextSpaceTime()
if space==nil then return end
local nextStamp=stamp+space

self.nextStamp=nextStamp
end

function eventChuWuDaiControl:getNextSpaceTime()
local num=self:getDzCount()
if num==0 then return end
local conf=eventConfig.getCommonConfig().storagebagconf
local div=((num/conf[2])-1)*conf[3]
local space=math.floor((conf[1]+div)/num*60)
return space
end


function eventChuWuDaiControl:getCheckDZList()
return self.dzList
end

function eventChuWuDaiControl:getCheckDZCount()
return#self:getCheckDZList()
end

function eventChuWuDaiControl:hasDzInList()
return self:getCheckDZCount()>0
end

function eventChuWuDaiControl:addDZ(strGuid)
local dzInfo=self:getDZ(strGuid)
if not dzInfo then return false end
return self:addDiziImp(strGuid)
end

function eventChuWuDaiControl:addDiziImp(strGuid)
local dzLookup=self.dzLookup
local checklist=self.dzList
if dzLookup[strGuid]then return end
checklist[#checklist+1]=strGuid
dzLookup[strGuid]=#checklist
self.listNum=self.listNum+1
self:addLocalData(strGuid)
return true
end

function eventChuWuDaiControl:initAddDizi(netData)
if netData then

if UIDiscipleModel:checkDiscipleState2ByData(netData,DISCIPLE_STATE_TYPE.eChuiWei)then return false end

self:addDiziImp(netData.discipleguidStr)
end
end

function eventChuWuDaiControl:dequeueDZ(idx,remove)
local dzLookup=self.dzLookup
local checklist=self.dzList
local strDzGuid=checklist[idx]
if strDzGuid==nil then return end
if remove then
dzLookup[strDzGuid]=nil
table.remove(checklist,idx)
self:removeLocalData(strDzGuid)
self.listNum=self.listNum-1
end

return strDzGuid
end

function eventChuWuDaiControl:delDZ(strDzGuid)
local dzLookup=self.dzLookup
local checklist=self.dzList
if not dzLookup[strDzGuid]then return end
local idx=dzLookup[strDzGuid]
dzLookup[strDzGuid]=nil
local len=#checklist
table.remove(checklist,idx)
self:removeLocalData(strDzGuid)
self.listNum=self.listNum-1
if len>#checklist then

end
end

function eventChuWuDaiControl:dequeue()
if not self.isRecvStamp then return end
if not self:hasDzInList()then return end
self:triggerEvent()
self.firstCricleFinish=true
end


function eventChuWuDaiControl:triggerEvent()
local stamp=timeHelper.getServerLongTime()
local nextStamp=self.nextStamp
if stamp<nextStamp then return end
local space=self:getNextSpaceTime()
if space==nil then return end
while stamp>=nextStamp do
local len=#self.dzList
if len<=0 then
if not self.firstCricleFinish then
self:initDZList()
else break end
end
local idx=math.random(1,len)
local strDzGuid=self:dequeueDZ(idx,true)
if strDzGuid==nil then break end
if UIDiscipleModel:isZMDisciple(strDzGuid)then
local triggerArray=self:createTriggerInfo(strDzGuid,nextStamp)
if triggerArray then
eventTriggerContorl:enQueue(triggerArray)
nextStamp=nextStamp+space
self.nextStamp=nextStamp
end
end
end
end

function eventChuWuDaiControl:createTriggerInfo(strDzGuid,timeStamp)
if strDzGuid==nil then

return false
end
if UIDiscipleModel:getDiscipleData(strDzGuid)==nil then
self:delDZ(strDzGuid)

return false
end
local dzname=UIDiscipleModel:getDiscipleName(strDzGuid)
if UIDiscipleModel:checkInjuryType(strDzGuid,eInjuryType.eImminent)then
self:delDZ(strDzGuid)
self:log(FMT.fmt('储物袋事件 弟子{0}频死，无法触发',dzname))
return false
end
local paramList=self:creatParamList(strDzGuid)
local mainType=self.mainType
local subType=self.subType

return eventTriggerModel.creatClientTriggerData(mainType,subType,1,paramList,nil,timeStamp)
end


function eventChuWuDaiControl:creatParamList(dzguid)
return{dzguid}
end

function eventChuWuDaiControl:getDiziID(paramList)
return paramList and paramList[1]
end

function eventChuWuDaiControl:handleParamListToTxt(paramList)
if paramList==nil then
logErr('储物袋事件没有找到任何参数')
return
end
local temp={}
local dzguid=paramList[1]
local dzInfo=self:getDZ(tostring(dzguid))
if not dzInfo then

return
end
local name=dzInfo.disciplename
temp.dizi1={diziguid=dzguid,diziname=name}
return temp
end

function eventChuWuDaiControl:getDZ(strDzGuid)
local dzInfo=UIDiscipleModel:getDiscipleDataByStr(strDzGuid)
if dzInfo==nil or UIDiscipleModel:checkDiscipleState2ByStr(strDzGuid,DISCIPLE_STATE_TYPE.eChuiWei)then return end
return dzInfo
end


function eventChuWuDaiControl:addLocalData(strDzGuid)
self:readLocalData()
local localDZList=self.localDZList
local localDzLookup=self.localDzLookup
if localDzLookup[strDzGuid]then return end
localDzLookup[strDzGuid]=true
localDZList[#localDZList+1]=strDzGuid
self.isChange=true
end

function eventChuWuDaiControl:removeLocalData(strDzGuid)
self:readLocalData()
local localDZList=self.localDZList
local localDzLookup=self.localDzLookup
if localDzLookup[strDzGuid]==nil then return end
localDzLookup[strDzGuid]=nil
for i,v in ipairs(localDZList)do
if v==strDzGuid then
table.remove(localDZList,i)
break
end
end
self.isChange=true
self:freshLocalFile(true)
end

function eventChuWuDaiControl:readLocalData()
if self.localDZList==nil or self.localDzLookup==nil then
self.localDZList={}
self.localDzLookup={}
local localDZList=self.localDZList
local localDzLookup=self.localDzLookup
local list=userActorArraySetting.get(ACTOR_SETTING_TYPE.eEvent,_localCheckList,{})
for i,v in ipairs(list)do
localDZList[#localDZList+1]=v
localDzLookup[v]=true
end
end
end

function eventChuWuDaiControl:freshLocalFile(canDelay)
if not self.isChange then return end
self.isChange=false
eventControl.freshLocalVal(_localCheckList,self.localDZList,canDelay)
end

function eventChuWuDaiControl:clearLocalFile()
eventControl.freshLocalVal(_localCheckList,nil,true)
end

function eventChuWuDaiControl:getChange(localDZList)
return table.isDiff(localDZList,self.localDZList)
end


function eventChuWuDaiControl:showInJianwenChannel(timeStamp,paramList)
return timeStamp and self.initStamp and timeStamp>=self.initStamp or false
end

function eventChuWuDaiControl:log(...)

end


function eventChuWuDaiControl:logWaitTime()












end
