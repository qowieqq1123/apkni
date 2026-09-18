





xianjieStoryAIManager=gameState.addListener({})


function xianjieStoryAIManager:onAppStart()

end

function xianjieStoryAIManager:onEnterState(isReconnect)
if isReconnect then
return
end
end

function xianjieStoryAIManager:onLeaveState(isReconnect)
if isReconnect then
return
end
xianjieStoryAIManager:removeAllStoryEntity()
xianjieController:leaveStoryMode()
end


function xianjieStoryAIManager:isPlayingStory()
return self.storyBT~=nil
end

function xianjieStoryAIManager:startStoryBehavior(fileName,initData,callback)
if not mainControl:isSceneLoaded(eSceneType.eXianJie)then
return
end
initData=initData or{}
initData.stateId=1
storyAICommonManager:setBehaviorName(fileName)
if callback then
storyAICommonManager:setBehaviorFunctionEndCallBack(callback)
end

self.storyBT=behaviorManager:addBehaviorTree(fileName,nil,true,initData)


xianjieController:enterStoryMode()

storyAICommonManager:posStoryNotify(true)
end


function xianjieStoryAIManager:removeAllStoryEntity(changeMode)
if self.storyBT then
behaviorManager:removeBehaviorTree(self.storyBT)
self.storyBT=nil
end
xianjieController:removeAllStoryEntity()
if changeMode then
xianjieController:leaveStoryMode()
end
end

local _argTypeEnum={
eZongMenPos=1,
eZongMenEffectPos=2,
}
function xianjieStoryAIManager:setXianJieBehaviorShareArgs(argType)
if self.storyBT==nil then
logErr("未使用仙魔界剧情控制器开启")
return
end

local shareData={}

if argType==_argTypeEnum.eZongMenPos then
local sceneidx=xianjieModel:getSceneIndex()
local pos=xianjienSceneIndexType:isMoJie(sceneidx)and xianjieModel:getZongMenOutPos_mojie()or xianjieModel:getZongMenOutPos()
if pos==nil then
return false
end
local gridWidth,gridHeight=xianjieModel:getZongMenSize()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(pos[2],pos[3],gridWidth,gridHeight)
local cPos=xianjieController:worldGridPos2WorldPos41(gridX_c,gridZ_c,pos[1])
shareData.Share_ZongMen_Pos={cPos.x,cPos.y,cPos.z}
elseif argType==_argTypeEnum.eZongMenEffectPos then
local sceneidx=xianjieModel:getSceneIndex()
local pos=xianjienSceneIndexType:isMoJie(sceneidx)and xianjieModel:getZongMenOutPos_mojie()or xianjieModel:getZongMenOutPos()
if pos==nil then
return false
end
local gridWidth,gridHeight=xianjieModel:getZongMenSize()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(pos[2],pos[3],gridWidth,gridHeight)
local cPos=xianjieController:worldGridPos2WorldPos41(gridX_c,gridZ_c,pos[1])
local modelset=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'modelSet_zm')
local offset=modelset.offset or{0,0,0}
shareData.Share_ZongMen_Effect_Pos={cPos.x+offset[1],cPos.y+offset[2],cPos.z+offset[3]}
end

if next(shareData)==nil then
logErr(FMT.fmt("缺少参数类型的参数处理,参数类型：{0}",argType))
return false
end

behaviorManager:setSharedValues(self.storyBT,shareData)
return true
end
