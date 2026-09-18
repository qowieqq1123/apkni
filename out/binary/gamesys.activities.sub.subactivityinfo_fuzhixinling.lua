









local subActivityInfo_fuzhixinling={name='subActivityInfo_fuzhixinling'}

function subActivityInfo_fuzhixinling:onInit()
end

function subActivityInfo_fuzhixinling:onStart()
self.planreward={}
self:searchAllPlanReward()

self._on_building_event=function(...)
self:on_building_event(...)
end
self._on_recvPro=function(...)
self:on_recvPro(...)
end
self._onPlanStepChange=function(...)
self:onPlanStepChange(...)
end
self:listenNotify(notifyConfig.building_event,self._on_building_event)
self:listenNotify(notifyConfig.onPlanStepChange,self._onPlanStepChange)
self:listenNotify(notifyConfig.recvPro,self._on_recvPro)
end

function subActivityInfo_fuzhixinling:onDelete()

self.planreward={}
end

function subActivityInfo_fuzhixinling:checkReddot()
return self.data==nil or self.data<=0
end

function subActivityInfo_fuzhixinling:on_recvPro(protoId,subProtoId)
if protoId==3 and subProtoId==18 then
self.planreward={}
self:searchAllPlanReward()
end
end

function subActivityInfo_fuzhixinling:onPlanStepChange(ubdId,cStep,oStep)
self:checkPlanReward(ubdId,cStep,oStep)
end

function subActivityInfo_fuzhixinling:on_building_event(eType,param1,param2,param3,param4)







if eType==buildingEvent.planStart then

local ubdId=param2
self:searchPlanReward(ubdId,0)
elseif eType==buildingEvent.planCancel then

local ubdId=param2
self:clearPlanRewardEx(ubdId)
elseif eType==buildingEvent.planComplete then

local ubdId=param2
self:clearPlanRewardEx(ubdId)


end
end

function subActivityInfo_fuzhixinling:searchAllPlanReward()
local itemId=self:getSubActConfig("reward_id")
local mesgs=self:getSubActConfig("gg_mesg")
for k,sfId in pairs(mapIdType)do
local bdDatas=zongmenModel:getAllBuildingData(sfId)
for g,bdData in pairs(bdDatas)do
if mesgs[bdData.build_id]and bdData.rewardList and#bdData.rewardList>0 then
self:searchPlanRewardImp(itemId,bdData,0)
end
end
end
end

function subActivityInfo_fuzhixinling:searchPlanReward(ubdId,step)
local itemId=self:getSubActConfig("reward_id")
local bdData=zongmenModel:getBuildingData(ubdId)
self:searchPlanRewardImp(itemId,bdData,step)
end

function subActivityInfo_fuzhixinling:searchPlanRewardImp(itemId,bdData,step)
local rewardList=bdData.rewardList or{}
for index,timeData in ipairs(rewardList)do
if step<=timeData.times then
for i,v in ipairs(timeData.speRewardList)do
if v.param_3==self.act_id and v.param_4==self.sub_act_id then
self:setPlanReward(bdData.un_build_id,timeData.times,v.param_1,v.param_2)
break
end
end
end
end
end

function subActivityInfo_fuzhixinling:setPlanReward(ubdId,step,itemid,itemnum)
if not self.planreward[ubdId]then
self.planreward[ubdId]={}
end
if not self.planreward[ubdId][step]then
self.planreward[ubdId][step]={
ubdId=ubdId,
step=step,
itemList={}
}
end
local data=self.planreward[ubdId][step]
data.itemList[itemid]=itemnum






end

function subActivityInfo_fuzhixinling:getPlantRewards(ubdId)
return self.planreward[ubdId]
end

function subActivityInfo_fuzhixinling:getPlantReward(ubdId,step)
if self.planreward[ubdId]then
return self.planreward[ubdId][step]
end
end

function subActivityInfo_fuzhixinling:getAllPlantRewards()
return self.planreward
end

function subActivityInfo_fuzhixinling:clearPlanRewardEx(ubdId)
self.planreward[ubdId]={}
end

function subActivityInfo_fuzhixinling:clearPlanReward(ubdId,step)
if self.planreward[ubdId]then
self.planreward[ubdId][step]=nil
end
end

function subActivityInfo_fuzhixinling:checkPlanReward(ubdId,nStep,oStep)
local infos=self:getPlantRewards(ubdId)
if infos then
for s,info in pairs(infos)do
if nStep>=info.step and info.step>(oStep or 0)then
local bdData=zongmenModel:getBuildingData(ubdId)
local str=self:getSubActConfig("gg_mesg",bdData.build_id)
if str then
local itemStr=nil
for itemId,itemNum in pairs(info.itemList)do
local item_config=itemsConfig.getConfig(itemId)
local itemName=item_config.name
local iStr=FMT.cfmt(item_config.color,"{0}*{1}",itemName,itemNum)
if itemStr==nil then
itemStr=iStr
else
itemStr=FMT.fmt("{0}、{1}",itemStr,iStr)
end
end
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local dzName=UIDiscipleModel:getDiscipleName(bdData.dizi_id)
local bdName=bdCfg.name
str=cfg_lang_get(str,false)
str=FMT.fmt(str,dzName,bdName,itemStr or"")
local timeStamp=timeHelper.getServerLongTime()
local year=gameUtilityModel.getGameYearPassByLongStamp(timeStamp)
local yearStr=FMT.fmt('第{0}年',year)
local title=FMT.cfmt(FONT_COLOR.eNomalGrayColor,yearStr)

chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},str,title)
self:clearPlanReward(ubdId,info.step)
end
end
end
end
end

return subActivityInfo_fuzhixinling