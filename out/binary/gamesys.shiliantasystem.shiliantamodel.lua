






local _MODULENAME="shiLianTaModel"




def_table(_MODULENAME)
shiLianTaModel.name=_MODULENAME


shiLianTaModel.data={}

function shiLianTaModel:onAppStart()
local version=pfwindowslController:getGameVersion()
local rewardTopId=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,'rewardTopLayer')
local rewardCfgs=cfg_traintowerjieduanrewardconfig()
local cfgCnt=#rewardCfgs
rewardTopId=rewardTopId[version]or cfgCnt
rewardTopId=math.min(rewardTopId,cfgCnt)
self.rewardTopId=rewardTopId
self.rewardTopLayer=rewardCfgs[rewardTopId].layer
self.rewardTopLayer_begin=self.rewardTopLayer[1]
self.rewardTopLayer_end=self.rewardTopLayer[#self.rewardTopLayer]

self.topLayer=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,'topLayer')
self.topLayerReward=#rewardCfgs
for i,v in ipairs(rewardCfgs)do
if self.topLayer>=v.layer[1]and self.topLayer<=v.layer[#v.layer]then
self.topLayerReward=i
break
end
end
self.finalRewardId=math.min(self.topLayerReward,self.rewardTopId)
local finalLayers=rewardCfgs[self.finalRewardId].layer
self.finalRewardLayer=finalLayers[1]
for i,v in ipairs(finalLayers)do
if self.topLayer>=v then
self.finalRewardLayer=v
else
break
end
end
end


function shiLianTaModel:onEnterState()

end


function shiLianTaModel:onLeaveState()

self.data={}
end


function shiLianTaModel:onServerDataInitFinish()

end




shiLianTaModel.RewardPanelType=
{
NotClear=1,
Clear=2,
}

shiLianTaModel.RankPanelName=
{
"排行",
"奖励",
}

shiLianTaModel.RankPanelType=
{
Rank=1,
Reward=2,
}

shiLianTaModel.UnlockCondition=
{
ZongMengLevel=1,
Task=2,
}


function shiLianTaModel.getLayerReward(layer)
local cfg=cfgHelper.get1(cfg_traintowerconfig_get,layer)
if cfg then
local rewardId=cfg.rewardId
return cfgHelper.get2(cfg_awardconfig_get,rewardId,"staticItems")
end
end

function shiLianTaModel.getLayerMonsterList(layer,index)
index=index or 1
local cfg=cfgHelper.get1(cfg_traintowerconfig_get,layer)
if cfg then
local gwzList=cfg.gwzList
local gwz=gwzList[index]
return cfgHelper.get2(cfg_monstergroup_get,gwz,"monList"),gwz
end
end

function shiLianTaModel:initSectionRewardConfig()
self.SectionRewardConfig={}
local cfg=cfg_traintowerjieduanrewardconfig()
for i,v in ipairs(cfg)do
for _,layer in ipairs(v.layer)do
self.SectionRewardConfig[layer]=v
end
end
end

function shiLianTaModel:getAimerLayerReward(layer)
if not self.SectionRewardConfig then
self:initSectionRewardConfig()
end
if self.SectionRewardConfig[layer]then
local rewardId=self.SectionRewardConfig[layer].rewardId
return cfgHelper.get2(cfg_awardconfig_get,rewardId,"staticItems")
end
end

function shiLianTaModel:getSectionLayer()
return self.SectionRewardConfig
end

function shiLianTaModel:isSectionLayer(layer)
return self.SectionRewardConfig[layer]
end

function shiLianTaModel:getAimLayer(layer)
if not self.SectionRewardConfig then
self:initSectionRewardConfig()
end
if not self.SectionRewardConfig[layer]then
local l
for k,v in pairs(self.SectionRewardConfig)do
if layer<k then
if not l then
l=k
end
if l>=k then
l=k
end
end
end
if l then
return l,2
end
return layer,3
else
return layer,1
end
end

function shiLianTaModel:getAimLayerItem()
local aimLayer=shiLianTaModel:getSectionSelectLayer()
local sectionLayer=shiLianTaModel:isSectionLayer(aimLayer)
if sectionLayer then

local list=self:getSectionRewardData()
if list then
local itemList=table.deepCopy(list)
local showReward=sectionLayer.showReward
table.sort(itemList,function(a,b)
return(showReward[a[1]]or 0)>(showReward[b[1]]or 0)
end)
return itemList[1]
end
else
local curLayer=shiLianTaModel:getCurLayer()
local aimLayer,reType=shiLianTaModel:getAimLayer(curLayer)
if reType~=3 then
sectionLayer=shiLianTaModel:isSectionLayer(aimLayer)
if sectionLayer then

local list=self:getAimerLayerReward(aimLayer)
if list then
local itemList=table.deepCopy(list)
local showReward=sectionLayer.showReward
table.sort(itemList,function(a,b)
return(showReward[a[1]]or 0)>(showReward[b[1]]or 0)
end)
return itemList[1]
end
end
end
end
end


function shiLianTaModel:getAimLayerSelectTimes(aimLayer)
if not self.SectionRewardConfig then
self:initSectionRewardConfig()
end
if not self.SectionRewardConfig[aimLayer]then
return 0
end
local layers=self.SectionRewardConfig[aimLayer].layer
local times=0
for i,v in ipairs(layers)do
if v>aimLayer then
break
end
times=times+1
end
return times
end



function shiLianTaModel:getBuildingData()
local datas=zongmenModel:getBuildingDataByBdType(zongmenModel:getMountainId(),SLG_SYSTEM_TYPE.eShiLianTa)
if#datas>0 then
return datas[1]
end
end

function shiLianTaModel:addHUD(hudid)
self.hudid=hudid
end

function shiLianTaModel:getHUD()
return self.hudid
end

function shiLianTaModel:checkUnlockCondition()
local unlockCfg=cfg_traintowerglobalconfig_get(1).unlockCondition
if not unlockCfg then
return true
else
local check=true
local check_str=''
for i,v in ipairs(unlockCfg)do
local cond=v[1]
local num=v[2]
if cond==self.UnlockCondition.ZongMengLevel then

local lv=zongmenModel:getLevel()
if lv<num then
check=false
check_str=FMT.fmt('宗门达到{0}级解锁',num)
break
end
elseif cond==self.UnlockCondition.Task then

if not taskModel:checkTaskFinish(num)then
local taskCfg=taskModel:getTaskConfig(num)
check=false
check_str=FMT.fmt('完成任务“{0}”解锁',taskCfg.name)
break
end
end

end
return check,check_str
end
end

function shiLianTaModel:isInit()
return self.data.curLayer~=nil
end


function shiLianTaModel:setPlayingBattle(battleId)
self.data.battleId=battleId
end

function shiLianTaModel:getPlayingBattle()
return self.data.battleId
end


function shiLianTaModel:setClearLayerData(isClearAll,curLayer)
self.data.isClearAll=isClearAll
self.data.curLayer=curLayer
end


function shiLianTaModel:getCurLayer()
return self.data.curLayer or 1
end


function shiLianTaModel:getClearLayer()
local isClearAll=self:isClearAll()
return isClearAll and self:getCurLayer()or self:getCurLayer()-1
end



function shiLianTaModel:getCurAimLayer()
local isClearAll=self:isClearAll()
local state=self:getSectionRewardState()
local curLayer=(isClearAll or state)and self:getCurLayer()or self:getCurLayer()-1
local layer,reType=self:getAimLayer(curLayer)
return layer,reType
end


function shiLianTaModel:isClearAll()
return self.data.isClearAll==1
end

function shiLianTaModel:getClearAll()
return self.data.isClearAll
end

function shiLianTaModel:setTempTeamData(teamGuidList)
self.data.teamGuidList=teamGuidList
end

function shiLianTaModel:getTempTeamData()
return self.data.teamGuidList
end


function shiLianTaModel:setFirstClearRewardLayerFlagList(len,list)
self.data.firstClearRewardLayerFlagList={}
if len>0 then
for i,v in ipairs(list)do
self.data.firstClearRewardLayerFlagList[v]=true
end
end
end

function shiLianTaModel:setFirstClearRewardLayerFlag(layer)
self.data.firstClearRewardLayerFlagList={}
local taskCfg=cfg_traintowerrankrewardconfig()
for k,v in pairs(taskCfg)do
if v.id<=layer then
self.data.firstClearRewardLayerFlagList[v.id]=true
end
end
end


function shiLianTaModel:getFirstClearRewardLayerFlagList()
return self.data.firstClearRewardLayerFlagList or{}
end

function shiLianTaModel:checkFirstClearRewardReddot()
local layerList=shiLianTaModel:getFirstClearRewardLayerList()
for layer,v in pairs(layerList)do
if not shiLianTaModel:getFirstClearRewardLayerFlag(layer)then
return true
end
end
end

function shiLianTaModel:checkAllReddot()
return(not shiLianTaModel:getSectionRewardState())or(shiLianTaModel:checkFirstClearRewardReddot()or false)
end

function shiLianTaModel:getFirstClearRewardLayerFlag(layer)
return self.data.firstClearRewardLayerFlagList[layer]
end


function shiLianTaModel:setFirstClearRewardLayerList(len,list)
self.data.firstClearRewardLayerList={}
if len>0 then
for i,v in ipairs(list)do
self.data.firstClearRewardLayerList[v.layer]=v
end
end
end

function shiLianTaModel:getFirstClearRewardLayerList()
return self.data.firstClearRewardLayerList or{}
end


function shiLianTaModel:setSectionRewardData(len,itemList)
if len>0 then
self.data.selectRewardData={}
for i,v in ipairs(itemList)do
table.insert(self.data.selectRewardData,{v.param_1,v.param_2})
end
else
self.data.selectRewardData=nil
end
end


function shiLianTaModel:getSectionRewardData()
return self.data.selectRewardData
end

function shiLianTaModel:setSectionRewardState(state)
self.data.selectRewardState=state
end

function shiLianTaModel:getSectionRewardState()
return self.data.selectRewardState
end

function shiLianTaModel:setSectionSelectLayer(layer)
self.data.SelectLayer=layer
end

function shiLianTaModel:getSectionSelectLayer()




return self.data.SelectLayer
end


function shiLianTaModel:getSectionSelectTimes()








return self.data.selectTimes or 0
end

function shiLianTaModel:setSectionSelectTimes(times)
self.data.selectTimes=times
end

function shiLianTaModel:setRankData(len,rankList)
if len>0 then
self.data.rankData=rankList
end
end

function shiLianTaModel:getRankData()
return self.data.rankData or{}
end

function shiLianTaModel:getMyRank()
local rankData=self:getRankData()
local actorId=playerModel:getActorID()
for i,v in ipairs(rankData)do
if actorId==v.actorId then
return v
end
end
end

function shiLianTaModel:setSelectZhenFa(zhenFaId)
self.data.selectZhenFa=zhenFaId
end

function shiLianTaModel:getSelectZhenFa()
return self.data.selectZhenFa or 0
end


function shiLianTaModel:isFightShow()
local battleId=shiLianTaModel:getPlayingBattle()
if battleId then
local battle=fightModel:getBattle(battleId)
if battle then
return battle.isShowWindow
end
end
return false
end

function shiLianTaModel:setFightingLayer(layer)
shiLianTaModel.data.fightingLayer=layer
end

function shiLianTaModel:getFightingLayer()
return shiLianTaModel.data.fightingLayer
end

function shiLianTaModel:setOtherTeamData(recordId,recordData)
if not self.data.recordData then
self.data.recordData={}
end
self.data.recordData[recordId]=recordData
end
function shiLianTaModel:getOtherTeamData(recordId)
if not self.data.recordData then
self.data.recordData={}
end
return self.data.recordData[recordId]
end

function shiLianTaModel:setOtherFightLogData(recordId,otherFightLog)
if not self.data.otherFightLog then
self.data.otherFightLog={}
end
self.data.otherFightLog[recordId]=otherFightLog
end
function shiLianTaModel:getOtherFightLogData(recordId)
if not self.data.otherFightLog then
self.data.otherFightLog={}
end
return self.data.otherFightLog[recordId]
end

function shiLianTaModel:insertGuaJIReward(list)
if not self.data.guaJIReward then
self.data.guaJIReward={}
end
for i,v in ipairs(list)do
table.insert(self.data.guaJIReward,v)
end
end
function shiLianTaModel:getGuaJIReward()
return self.data.guaJIReward or{}
end
function shiLianTaModel:clearGuaJIReward()
self.data.guaJIReward={}
end

function shiLianTaModel:setGuaJILayer(layer)
self.data.guaJILayer=layer
end
function shiLianTaModel:getGuaJILayer()
return self.data.guaJILayer
end

function shiLianTaModel:setGuaJILoseLayer(layer)
self.data.guaJILoseLayer=layer
end
function shiLianTaModel:getGuaJILoseLayer()
return self.data.guaJILoseLayer
end

function shiLianTaModel:setGuaJILoseArgs(atgs)
self.data.guaJILoseArgs=atgs
end
function shiLianTaModel:getGuaJILoseArgs()
return self.data.guaJILoseArgs
end

function shiLianTaModel:isZMLevelNotEnough(layer,warring)
local cfg=cfgHelper.get1(cfg_traintowerconfig_get,layer)
if cfg then
local curZMLevel=zongmenModel:getLevel()
local zmLevel=cfg.zmLevel
local notEnough=zmLevel~=nil and curZMLevel<zmLevel
if notEnough and warring then
UIManager.error(FMT.fmt("宗门{0}级可挑战",zmLevel))
end
return notEnough
end
end



function shiLianTaModel:setShiLianZhengTuData(len,list)
self.data.shiLianZhengTuData={}
if len<=0 then
return
end

for i,v in ipairs(list)do
local menuId=v.tagId
local dataItem={
menuId=menuId,
rechargeFlag=v.czFlag,
freeLayerMax=v.freeLayerMax,
moneyLayerMax=v.moneyLayerMax,
}

self.data.shiLianZhengTuData[menuId]=dataItem
end
end

function shiLianTaModel:setShiLianZhengTuDataByMenuId(menuId,freeMax,moneyMax)
if not self.data.shiLianZhengTuData then
self.data.shiLianZhengTuData={}
end

if not self.data.shiLianZhengTuData[menuId]then
shiLianTaModel:createShiLianZhengTuDataByMenuId(menuId)
end

self.data.shiLianZhengTuData[menuId].freeLayerMax=freeMax
self.data.shiLianZhengTuData[menuId].moneyLayerMax=moneyMax
end

function shiLianTaModel:setShiLianZhengTuRechargeByMenuId(menuId)
if not self.data.shiLianZhengTuData then
self.data.shiLianZhengTuData={}
end

if not self.data.shiLianZhengTuData[menuId]then
shiLianTaModel:createShiLianZhengTuDataByMenuId(menuId)
end

self.data.shiLianZhengTuData[menuId].rechargeFlag=1
end

function shiLianTaModel:createShiLianZhengTuDataByMenuId(menuId)
if not self.data.shiLianZhengTuData then
self.data.shiLianZhengTuData={}
end

if not self.data.shiLianZhengTuData[menuId]then
self.data.shiLianZhengTuData[menuId]={
menuId=menuId,
rechargeFlag=0,
freeLayerMax=0,
moneyLayerMax=0,
}
end
end


function shiLianTaModel:getShiLianZhengTuDataByMenuId(menuId)
if not self.data.shiLianZhengTuData then
self.data.shiLianZhengTuData={}
end

if not self.data.shiLianZhengTuData[menuId]then
shiLianTaModel:createShiLianZhengTuDataByMenuId(menuId)
end

return self.data.shiLianZhengTuData[menuId]
end


function shiLianTaModel:checkShiLianZhengTuIsRechargeByMenuId(menuId)

local menuCfg=cfgHelper.get1(cfg_traintowerzhengtutagconfig_get,menuId)
if not menuCfg then
logErr(FMT.fmt("找不到页签id为{0}对应的试炼奖励列表 请检查配置是否正确",menuId))
return false
elseif not menuCfg.czId then

return true
end

if not self.data.shiLianZhengTuData then
self.data.shiLianZhengTuData={}
end

local data=self.data.shiLianZhengTuData[menuId]
if data then
return data.rechargeFlag==1
end

return false
end





function shiLianTaModel:checkShiLianZhengTuTaskState(menuId,targetFloor)
local taskState=0
local menuData=shiLianTaModel:getShiLianZhengTuDataByMenuId(menuId)

local isGotFree=menuData.freeLayerMax>=targetFloor
local isGotBuy=menuData.moneyLayerMax>=targetFloor
if not isGotFree and not isGotBuy then

taskState=0
elseif isGotFree and not isGotBuy then

taskState=1
elseif isGotFree and isGotBuy then

taskState=2
end

return taskState
end


