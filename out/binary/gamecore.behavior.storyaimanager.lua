







storyAIManager=gameState.addListener({})


local needHideWin=
{
'UISMBaiShanEventWin',
}

local _storyGuidList
local _storyBTBDList
local _storyDzList

function storyAIManager:onAppStart()

end

function storyAIManager:onEnterState(isReconnect)
if isReconnect then
return
end
_storyGuidList={}
_storyBTBDList={}
_storyDzList={}
storyAIManager:loadFirstStoryPlayState()

end

function storyAIManager:onLeaveState(isReconnect)
if isReconnect then
if self:isPlayingStory()then
self:stopStoryBehavior()
end
return
end
storyAIManager:removeAllStoryEntity()
_storyGuidList=nil
_storyBTBDList=nil
_storyDzList=nil
isometricMapSystem:leaveStoryMode()

end







function storyAIManager:stopStoryBehavior()
storyAICommonManager:executeEndCallBack()
storyAICommonManager:executeFunctionEndCallBack()
storyAIManager:removeAllStoryEntity(true)
worldStoryAIManager:removeAllStoryEntity(true)
xianjieStoryAIManager:removeAllStoryEntity(true)
end



function storyAIManager:isPlayingStory()
return self.storyBT~=nil
end



function storyAIManager:startStoryBehavior(fileName,initData,callBack,closeTips,closeWin)
if not mainControl:isSceneLoaded(eSceneType.eZongmen)then
return
end
UIManager.enableMoneyTips(false)
initData=initData or{}
initData.stateId=1
storyAICommonManager:setBehaviorName(fileName)
if callBack then
storyAICommonManager:setBehaviorFunctionEndCallBack(callBack)
end
self.storyBT=behaviorManager:addBehaviorTree(fileName,nil,true,initData)
_storyBTBDList={}

isometricMapSystem:enterStoryMode(closeTips,closeWin)
self:hideNeedWin()

storyAICommonManager:posStoryNotify(true)
end


function storyAIManager:startZMDiscipleAI(index,cmdData)
local netData=UIDiscipleModel:getPlotDiscipleByIndex(index)
if netData then
local dzId=netData.discipleguid
aiManager:addCommandToDisciple(dzId,cmdData)
_storyDzList[tostring(dzId)]=dzId
end
end


function storyAIManager:recoverZMDiscipleAI()
for k,dzId in pairs(_storyDzList)do
_storyDzList[tostring(dzId)]=nil
end
end


function storyAIManager:skipZMDiscipleAI(index,aiType)
local netData=UIDiscipleModel:getPlotDiscipleByIndex(index)
if netData then
local dzId=netData.discipleguid
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
local btData=aiDefineData[aiType]
if bt and btData then
if bt.file==btData.name then
bt:skip()
end
end
end
end


function storyAIManager:removeAllStoryEntity(changeMode)
if self.storyBT then
UIManager.enableMoneyTips(true)
behaviorManager:removeBehaviorTree(self.storyBT)
self.storyBT=nil
for i,v in ipairs(_storyGuidList)do
_MapManager.RemoveTilemapObject(v)
end
local effectList=self:getStoryBTBlackBoard('effectidList')
if effectList then
for i,v in ipairs(effectList)do
_stopEffect(v)
end
end
self:recoverZMDiscipleAI()
storyAIManager:firstSetZongMenCameraPos(true)
end
if changeMode then
isometricMapSystem:leaveStoryMode()
self:showHideWin()
end
end


function storyAIManager:createStoryRole(npcid,scaleType,pos,offset,scale)
local guid
local image=npcModel:getImageInfoOutSide(npcid,scaleType)
if image then
local bodyid=image.body
local componets=image.componets
scale=scale or isometricMapSystem:getModelScale(bodyid)
local mapId=zongmenModel:getMountainId()
guid=isometricMapSystem:createRoleEntity(objectType.eRole,mapId,0,bodyid,componets,SortingLayers.ITBuilding,scale,pos,offset)
_MapManager.ShowShadow(guid,true)
else
logErr(FMT.fmt("没有找到npcid:{0}的配置",npcid))
end
table.insert(_storyGuidList,guid)
return guid
end


function storyAIManager:createStoryBuild(buildid,level,pos)
local mdata=isometricMapSystem:getModelByStatus(buildid,level,0,planStatus.eDefault)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=isometricMapSystem:countOffset(bx,by)

local guid=_MapManager.CreateTilemapObject(objectType.eStillSundrise,mdata.model,nil,mdata.layer,mdata.scale,1,pos,offset)
table.insert(_storyGuidList,guid)
return guid
end

function storyAIManager:setStoryBTBlackBoard(key,value)
_storyBTBDList[key]=value
end

function storyAIManager:getStoryBTBlackBoard(key)
return _storyBTBDList[key]
end


function storyAIManager:passStory()
if self.storyBT then
self.storyBT:setSharedVar('stateId',0)
self.storyBT:broke()
self.storyBT:reset()
end
end

function storyAIManager:hideNeedWin()
for i,v in ipairs(needHideWin)do
UIManager:hideWindow(v)
end
end

function storyAIManager:showHideWin()
for i,v in ipairs(needHideWin)do
local win=UIManager:findActiveWindow(v)
if win then
local args=UIManager:getArgs(v)
UIManager:showWindow(v,args)
end
end
end


function storyAIManager:firstSetZongMenCameraPos(record)
local haveFirstTask=taskModel:hasFirstInZongMenPlot()
local needAuto=cfgHelper.getglobal1('autojuqingtree')

if haveFirstTask and not self.isPlayed and needAuto then
if record then
self:saveFirstStoryPlayState()
end
return true
end
return false
end


function storyAIManager:loadFirstStoryPlayState()
self.isPlayed=userActorSetting.get('isPlayedFirstStory',false)
end

function storyAIManager:isPlayFirstStoryPlayState()
return userActorSetting.get('isPlayedFirstStory',false)
end

function storyAIManager:saveFirstStoryPlayState()
self.isPlayed=true
userActorSetting.set('isPlayedFirstStory',self.isPlayed)
userActorSetting.flush()
end
