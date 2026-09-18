
storyAICommonManager=gameState.addListener({})

local endCallType={
eZhiYinLuaFunc=1,
eFightZMMonster=2,
eRuoZhiYin=3,
}

local _func=
{
[endCallType.eZhiYinLuaFunc]=function(luaFunc)
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,luaFunc)
end,
[endCallType.eFightZMMonster]=function(SundriseId,newbieArgs)
local mapId=zongmenModel:getMountainId()
local data=isometricMapSystem:findSundriesByID(mapId,SundriseId)
if data then
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,data.id)
local groupId=cfg.rewards_conf.monTeamId
local serverGuid=data.serverGuid
local mcfg=cfgHelper.get1(cfg_monstergroup_get,groupId)
if newbieArgs then
if newbieArgs[1]==1 then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,newbieArgs[2])
elseif newbieArgs[1]==2 then
weakGuideController:beginGuide(newbieArgs[2])
end
end
fightController.showPrepareWin(fightPreSelectModel.fightType.zongmenMonster,
{
enterTxt='宗门',
skipDiscipleInjuryCheck=true,
isHomeBattle=true,
monsterList=mcfg.monList,
groupId=groupId,
enterCallBack=function(guidList,zfId)
local sfid=zongmenModel:getMountainId()
fightLaunchController:sendFight(eBattleLaunch.zongmenMonster,guidList,mcfg.mapId or 0,zfId,{sfid,serverGuid})
end
}
)
else
logErr(FMT.fmt('没有找到id：{0}的随机怪物触发战斗',SundriseId))
end
end,
[endCallType.eRuoZhiYin]=function(guideID)
weakGuideController:beginGuide(guideID)
end,
}

function storyAICommonManager:onAppStart()

end

function storyAICommonManager:onEnterState(isReconnect)

end

function storyAICommonManager:onLeaveState(isReconnect)

end


function storyAICommonManager:setBehaviorName(fileName)
self.fileName=fileName
self.functionEndCallBack=nil
end


function storyAICommonManager:setBehaviorFunctionEndCallBack(callBack)
self.functionEndCallBack=callBack
end


function storyAICommonManager:executeEndCallBack()
if not self.fileName then
return
end
local config=cfgHelper.get1(cfg_storybehaviortreeconfig_get,self.fileName)
if config then
local callTab=config.endcallback
local eType=callTab[1]
local params=callTab[2]

local func=_func[eType]
if func then
func(unpack(params))
end
else
logErr(FMT.fmt('{0}行为树添加了执行结束回调的节点，没有配置结束回调',self.fileName))
end
self.fileName=nil
end


function storyAICommonManager:executeFunctionEndCallBack()
if self.functionEndCallBack then
local callBack=self.functionEndCallBack
callBack()
end
self:posStoryNotify(false)
end

function storyAICommonManager:isPlayingStory()
return worldStoryAIManager:isPlayingStory()or storyAIManager:isPlayingStory()
end

function storyAICommonManager:posStoryNotify(flag)
notifySystem:postNotify(notifyConfig.inStory,self.fileName,flag)
end

function storyAICommonManager:startStoryBehavior(fileName,initData,callBack)
if mainControl:isSceneLoaded(eSceneType.eZongmen)then
storyAIManager:startStoryBehavior(fileName,initData,callBack)
elseif mainControl:isSceneLoaded(eSceneType.eWorld)then
worldStoryAIManager:startStoryBehavior(fileName,initData,callBack)
elseif mainControl:isSceneLoaded(eSceneType.eXianJie)then
xianjieStoryAIManager:startStoryBehavior(fileName,initData,callBack)
end
end