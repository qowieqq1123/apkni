






local _MODULENAME="LittleWorldModel"


def_table(_MODULENAME)
LittleWorldModel.name=_MODULENAME
LittleWorldModel.data={}
LittleWorldModel.flData={}

eLittleWorldDataKey=
{
world_lv="world_lv",
xh_val="xh_val",
p_val="p_val",
s_val="s_val",
}


eLittleWorldAttr=
{
xhVal=1,
population=2,
stableVal=3,
}


function LittleWorldModel:onAppStart()
local starsStarConfig=cfg_starsstarconfig()

end


function LittleWorldModel:onEnterState(isReconnect)
LittleWorldModel:loadEventData()
end


function LittleWorldModel:onProtocolReq()

end


function LittleWorldModel:onLeaveState(isReconnect)

self.data={}
self.flData={}
end

function LittleWorldModel:initLittleWorldInfo(world_lv,xh_val,p_val,s_val)
self.data.world_lv=world_lv
self.data.xh_val=xh_val
self.data.p_val=p_val
self.data.s_val=s_val
end

function LittleWorldModel:setLittleWorldInfo(key,val)
self.data[key]=val
end

function LittleWorldModel:getLittleWorldInfo()
return self.data
end

function LittleWorldModel:setLittleWorldLevel(world_lv)
self.data.world_lv=world_lv
end

function LittleWorldModel:getLittleWorldLevel()
return self.data.world_lv or 1
end

function LittleWorldModel:setLittleWorldPopulation(p_val)
self.data.p_val=p_val
end

function LittleWorldModel:getLittleWorldPopulation()
return mathHelper.int64_to_number(self.data.p_val)
end

function LittleWorldModel:getLittleWorldXianghuo()
return moneyModel.getMoney(eMoneyType.mtIncense)
end

function LittleWorldModel:getLittleWorldStability()
return self.data.s_val
end

function LittleWorldModel:checkXiangHuoEnough()
if not systemModel.isOpen(SYSTEM_DEFINE.eSmallWorld)then
return false
end
local lv=LittleWorldModel:getLittleWorldLevel()
return lv>=4 and LittleWorldModel:getLittleWorldXianghuo()>=LittleWorldModel.getXiaoHuoValMax(lv)
end

function LittleWorldModel:setMoneyStartSec(money_start_sec)
self.data.money_start_sec=money_start_sec
end

function LittleWorldModel:getMoneyStartSec()
return self.data.money_start_sec
end

function LittleWorldModel:setItemStartSec(item_start_sec)
self.data.item_start_sec=item_start_sec
end

function LittleWorldModel:getItemStartSec()
return self.data.item_start_sec
end



function LittleWorldModel:initFaLingInfo(orderList)
local data={}
if orderList then
for i,v in ipairs(orderList)do
data[v.param_1]=v.param_2
end
end
self.flData=data
end

function LittleWorldModel:setFaLingInfo(id,sec)
self.flData[id]=sec
end


function LittleWorldModel:getLastFaLingTime(flId)
return self.flData[flId]
end

function LittleWorldModel:getFaLingCDRemain(flId)
if not self:getLastFaLingTime(flId)then return end
local cd=cfgHelper.get(cfg_smallworldorderconfig_get,flId,"cd_time")
if cd then
return cd-(timeHelper.getServerShortTime()-self.flData[flId])
end
return 0
end


function LittleWorldModel:setXiuShiInfo(xiuShiList)
if not xiuShiList then return end
self.data.xiuShiInfo={}
local nameList=cfgHelper.get(cfg_smallworldconfig_get,1,"xiushi_name")
for i,c in ipairs(nameList)do
self.data.xiuShiInfo[i]=xiuShiList[i]or 0
end
end

function LittleWorldModel:getXiuShiInfo()
return self.data.xiuShiInfo
end


function LittleWorldModel:getXiuShiNumById(id)
return self.data.xiuShiInfo[id]
end


function LittleWorldModel:recordEvent(content,eventId,args,timeStamp)
local time=tonumber(tostring(timeStamp))
local tdatas=self:getEventData()
if#tdatas>=20 then
table.remove(tdatas,1)
end
local data={eventId=eventId,content=content,time=time,isNew=true}
table.insert(tdatas,data)
self:setEventData(tdatas)

self:saveEventData()
end

function LittleWorldModel:getEventData()
return self.data.eventDatas or{}
end

function LittleWorldModel:setEventData(data)
self.data.eventDatas=data
end

function LittleWorldModel:isHaveNewEvent()
local data=self:getEventData()
local len=#data
return len>0 and data[len].isNew or false
end

function LittleWorldModel:setEventRead()
local data=self:getEventData()
for i,v in ipairs(data)do
v.isNew=false
end
end

function LittleWorldModel:loadEventData()
local datas=userActorSetting.get('littleWorldEventDatas',{})
self.data.eventDatas=datas
end

function LittleWorldModel:saveEventData()
userActorSetting.set('littleWorldEventDatas',self.data.eventDatas)
userActorSetting.flush(true)
end


function LittleWorldModel:getBuildingData()
local datas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,SLG_SYSTEM_TYPE.eLittleWorld)
if#datas>0 then
return datas[1]
end
end

function LittleWorldModel:getFirstRewardLeftTime()
if not self.data.item_start_sec then
return 0
end
local productTime=LittleWorldModel.getMoneyProductTime()
local now=timeHelper.getServerShortTime()
return productTime*gameUtilityModel.getGameYearSecond()-(now-self.data.money_start_sec)
end


function LittleWorldModel:canGetReward()
return self:canGetRewardMoney()or self:canGetRewardItem()
end

function LittleWorldModel:canGetRewardMoney()
if not self.data.money_start_sec then
return
end
local productTime=LittleWorldModel.getMoneyProductTime()
local now=timeHelper.getServerShortTime()
return now-self.data.money_start_sec>=productTime*gameUtilityModel.getGameYearSecond()
end

function LittleWorldModel:canGetRewardItem()
if not self.data.item_start_sec then
return
end
local productTime=LittleWorldModel.getItemProductTime()
if productTime==0 then
return
end
local now=timeHelper.getServerShortTime()
return now-self.data.item_start_sec>=productTime*gameUtilityModel.getGameYearSecond()
end


function LittleWorldModel:hideBuilding(flag)
local bdId=SLG_SYSTEM_TYPE.eLittleWorld
local sfId=zongmenModel:getMountainId()
local buildingList=zongmenModel:getAllBuildingDataByBdType(sfId,bdId)
if buildingList then
for i,v in ipairs(buildingList)do
_MapManager.SetFadeToColor(v.entityId,Color.New(1,1,1,flag and 1 or 0),0,nil)
end
else
local data=isometricMapSystem:getRepairDataByID(sfId,bdId)
if data then
_MapManager.SetFadeToColor(data.guid,Color.New(1,1,1,flag and 1 or 0),0,nil)
end
end
end
