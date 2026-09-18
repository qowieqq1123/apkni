






local _MODULENAME="tiandaoshuController"
gameState.addListener(def_table(_MODULENAME))

tiandaoshuController.name=_MODULENAME
tiandaoshuController.corrected=false
tiandaoshuController.updating=false
tiandaoshuController.data={}

function tiandaoshuController:onAppStart()

tiandaoshuModel:onAppStart()


socketManager:register_receiver(6,65,self.recv_6_65)

socketManager:register_receiver(6,71,self.recv_6_71)
socketManager:register_receiver(6,72,self.recv_6_72)
socketManager:register_receiver(6,73,self.recv_6_73)
socketManager:register_receiver(6,74,self.recv_6_74)
socketManager:register_receiver(6,75,self.recv_6_75)
socketManager:register_receiver(6,76,self.recv_6_76)


notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)
notifySystem:listenNotify(notifyConfig.onTiandaoshuFruitComprehend,self.onTiandaoshuFruitComprehend)
notifySystem:listenNotify(notifyConfig.onTiandaoshuFruitComplete,self.onTiandaoshuFruitComplete)
notifySystem:listenNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:listenNotify(notifyConfig.onMountainChange,self.onMountainChange)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end


function tiandaoshuController:onEnterState(isReconnect)
tiandaoshuModel:onEnterState()
end


function tiandaoshuController:onProtocolReq()
if not self.corrected then
self.corrected=true

self:correctServerData()
end
end


function tiandaoshuController:onLeaveState(isReconnect)
tiandaoshuModel:onLeaveState(isReconnect)
if not isReconnect then
self:clearBuildModel()
end
end


function tiandaoshuController:onLostConnection()

end


function tiandaoshuController:onReConnection(isInitPro)

end

function tiandaoshuController.on_building_event(bdType,level,exp,lastLv)
if bdType==buildingEvent.zongmenLevelUp then
local temp=tiandaoshuModel:checkAllFruitActive(tiandaoshuModel.eFruitCondition.eZongMengLevel)
tiandaoshuController.send_6_74(temp)
end
end

function tiandaoshuController.onXianMengLevelChange(oldlv,guildlevel,oldexp,guildexp)
if oldlv~=guildlevel then
local temp=tiandaoshuModel:checkAllFruitActive(tiandaoshuModel.eFruitCondition.eXianMengLevel)
tiandaoshuController.send_6_74(temp)
end
end

function tiandaoshuController.onTiandaoshuFruitComprehend(voc,stage,fruit,current,delta)
if delta>0 then
local temp=tiandaoshuModel:checkVocFruitActive(voc,tiandaoshuModel.eFruitCondition.eCurrentVocCount)
tiandaoshuController.send_6_74(temp)
end
end

function tiandaoshuController.onTiandaoshuFruitComplete(voc,stage,fruit,flag)
if flag>0 then
local temp=tiandaoshuModel:checkVocFruitActive(voc,tiandaoshuModel.eFruitCondition.eCurrentVocComplete)
tiandaoshuController.send_6_74(temp)
end
end

function tiandaoshuController:onNormalUpdate(delay)
local finish={}
local nowTime=timeHelper.getServerShortTime()

for i,v in ipairs(self.data)do
local fruitData=tiandaoshuModel:getFruitData(v.voc,v.stage,v.fruit)
if fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
if fruitData.cdTime+fruitData.duration<=nowTime then
fruitData.status=tiandaoshuModel.eFruitStatus.eNormal
notifySystem:postNotify(notifyConfig.onTiandaoshuFruitStatusChanged,fruitData.voc,fruitData.stage,fruitData.id,fruitData.status)
table.insert(finish,{i,v.voc,v.stage,v.fruit})
end
else
table.insert(finish,i)
end
end

for i=#finish,1,-1 do
local rData=finish[i]
local index=rData[1]
table.remove(self.data,index)
end


if#self.data<=0 then
self:stopUpdateTimer()
end
end


function tiandaoshuController:correctServerData()
local data=tiandaoshuModel:getAllData()
local temp1={}
local temp2={}

for voc,vocData in pairs(data)do
local sList,fList=tiandaoshuModel:checkCorrectVocStage(voc)
temp1=table.concatTableX(temp1,sList)
temp2=table.concatTableX(temp2,fList)
end
tiandaoshuController.send_6_73(temp1)
tiandaoshuController.send_6_74(temp2)
end



function tiandaoshuController.send_6_65(voc)
socketManager:send_6_65(voc)
end



function tiandaoshuController.send_6_72(voc)
socketManager:send_6_72(voc)
end



function tiandaoshuController.send_6_73(list)
local cnt=list and#list or 0
if cnt>0 then
socketManager:send_6_73(cnt,list)
end
end



function tiandaoshuController.send_6_74(array)
local cnt=array and#array or 0
if cnt>0 then
socketManager:send_6_74(cnt,array)
end
end





function tiandaoshuController.send_6_75(voc,stage,fruit)
socketManager:send_6_75(voc,stage,fruit)
end






function tiandaoshuController.send_6_76(voc,stage,fruit,times)
socketManager:send_6_76(voc,stage,fruit,times or 1)
end



function tiandaoshuController.recv_6_65(voc)
UIManager.info('重置成功')
tiandaoshuModel:activeVocData(voc)
notifySystem:postNotify(notifyConfig.onTiandaoshuReset,voc)

tiandaoshuModel:dirtyVocDiscipleAttribute(voc)
tiandaoshuModel:dirtyVocDiscipleSkill(voc)
end




function tiandaoshuController.recv_6_71(len,arary)
tiandaoshuModel:setAllData(arary or{})

local fruitList=tiandaoshuModel:findFruits_Status(tiandaoshuModel.eFruitStatus.eCountDown)
for index,fruitData in ipairs(fruitList)do
table.insert(tiandaoshuController.data,{voc=fruitData.voc,stage=fruitData.stage,fruit=fruitData.id})
end
if#tiandaoshuController.data>0 then
tiandaoshuController:startUpdateTimer()
end

local logined=initProControl.isDone()
if logined then
tiandaoshuController.corrected=true

tiandaoshuController:correctServerData()

else
tiandaoshuController.corrected=false
end

tiandaoshuModel:dirtyAllDiscipleAttribute()
tiandaoshuModel:dirtyAllDiscipleSkill()

notifySystem:postNotify(notifyConfig.onTiandaoshuInited,logined)

end



function tiandaoshuController.recv_6_72(voc)
tiandaoshuModel:activeVocData(voc)
notifySystem:postNotify(notifyConfig.onTiandaoshuVocActived,voc)

end




function tiandaoshuController.recv_6_73(len,array)
if len>0 then
local temp={}
local Voc=nil
local Min=nil
local Max=nil
for i,v in ipairs(array)do
local voc=v.param_1
local stage=v.param_2
Voc=voc
Min=Min and math.min(Min,stage)or stage
Max=Min and math.max(Min,stage)or stage

tiandaoshuModel:activeStageData(voc,stage)

local actives,unactives=tiandaoshuModel:findStageDefaultFruits(voc,stage)
temp=table.concatTableX(temp,actives)
for k,w in ipairs(unactives)do
tiandaoshuModel:initFruitData(w[1],w[2],w[3])
end

end
tiandaoshuController.send_6_74(temp)

notifySystem:postNotify(notifyConfig.onTiandaoshuStageActived,Voc,Min,Max)
end
end




function tiandaoshuController.recv_6_74(len,array)
if len>0 then
local tips=false
local newStatisticsList={}
local oldStatisticsList={}
for i,v in ipairs(array)do
local fruitData,isNewStatistics=tiandaoshuModel:activeFruitData(v.param_1,v.param_2,v.param_3)
if fruitData then
notifySystem:postNotify(notifyConfig.onTiandaoshuFruitStatusChanged,fruitData.voc,fruitData.stage,fruitData.id,fruitData.status)
end

local fruitCfg=tiandaoshuConfig:getFruitConfig(v.param_1,v.param_2,v.param_3)
if fruitCfg.unlockShow==1 then
tips=true
end
if isNewStatistics then
local list=newStatisticsList[fruitData.voc]
if list==nil then
list={}
newStatisticsList[fruitData.voc]=list
end
list[fruitCfg.statisticsType]=true
else
local list=oldStatisticsList[fruitData.voc]
if list==nil then
list={}
oldStatisticsList[fruitData.voc]=list
end
list[fruitCfg.statisticsType]=(list[fruitCfg.statisticsType]or 0)+fruitData.max
end
end
if tips then
UIManager.info("有封印的果实解锁了")
end
notifySystem:postNotify(notifyConfig.onTiandaoshuStatisticsTypeChange,oldStatisticsList,newStatisticsList)
end

end





function tiandaoshuController.recv_6_75(voc,stage,fruit)
local fruitData,isNewStatistics=tiandaoshuModel:unsealFruitData(voc,stage,fruit)
if fruitData then
notifySystem:postNotify(notifyConfig.onTiandaoshuFruitStatusChanged,fruitData.voc,fruitData.stage,fruitData.id,fruitData.status)

local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
local newStatisticsList={}
local oldStatisticsList={}
if isNewStatistics then
local list=newStatisticsList[fruitData.voc]
if list==nil then
list={}
newStatisticsList[fruitData.voc]=list
end
list[fruitCfg.statisticsType]=true
else
local list=oldStatisticsList[fruitData.voc]
if list==nil then
list={}
oldStatisticsList[fruitData.voc]=list
end
list[fruitCfg.statisticsType]=(list[fruitCfg.statisticsType]or 0)+fruitData.max
end
notifySystem:postNotify(notifyConfig.onTiandaoshuStatisticsTypeChange,oldStatisticsList,newStatisticsList)
end

end







function tiandaoshuController.recv_6_76(voc,stage,fruit,count,time)
local fruitData,dComplete,dCount=tiandaoshuModel:setFruitCount(voc,stage,fruit,count,time)
local config=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
if fruitData then
if fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
table.insert(tiandaoshuController.data,{voc=voc,stage=stage,fruit=fruit})
tiandaoshuController:startUpdateTimer()
end
notifySystem:postNotify(notifyConfig.onTiandaoshuFruitStatusChanged,voc,stage,fruit,fruitData.status)
notifySystem:postNotify(notifyConfig.onTiandaoshuFruitComprehend,voc,stage,fruit,fruitData.count,dCount,dComplete)
if dComplete~=0 then
notifySystem:postNotify(notifyConfig.onTiandaoshuFruitComplete,voc,stage,fruit,dComplete)
end
notifySystem:postNotify(notifyConfig.onTiandaoshuStatisticsCountChange,voc,config.statisticsType,dCount)
end

tiandaoshuModel:dirtyVocDiscipleAttribute(voc)


















if config.skill then
tiandaoshuModel:dirtyVocDiscipleSkill(voc)










end












end




function tiandaoshuController:startUpdateTimer()
if not self.updating then
timeEventController.addNormalTimerHandler(1,self.name,self)
self.updating=true
end
end

function tiandaoshuController:stopUpdateTimer()
if self.updating then
timeEventController.removeNormalTimerHandler(1,self.name)
self.updating=false
end
end

