def_class('fightStage',{})


fightStage.defStageID=10

function fightStage:__init()

end



function fightStage:create(stageID,onFinish,argstable,index,fadeInTime,clearOld,onClose)
if stageID and stageID>0 and downAssetManager:needDownLoadBattleStageNotice(stageID)then
stageID=self.defStageID
end

index=index or 1

self.index=index

local curStage=fightModel:getStageList(index)

local stage=nil

local finishCall=function(abName,flag)
argstable=argstable or{}
argstable.fightStage=stage
argstable.isLoaded=flag
if onFinish~=nil then
onFinish(argstable)
end
end

if curStage and curStage.stageID==stageID then

if clearOld then
curStage:clear()
end
stage=curStage
if onFinish then
finishCall(nil,true)
end
if curStage.onClose then
curStage.onClose()
end
curStage.onClose=onClose
return curStage
else

if clearOld then
if curStage then
curStage:close()
end
end
stage=fightStage()
end

stage:show(stageID,finishCall,index,fadeInTime,onClose)
fightModel:createStageList(index,stage)

return stage
end





function fightStage:show(stageID,onFinish,index,fadeInTime,onClose)
shaderHelper.setCommomEffectFadeBaseHeight(fightModel.fightWorldBaseHeight)
self.index=index
self.onClose=onClose
if stageID>0 then
self.stageCfg=fightModel:getStage(stageID)
else
self.stageCfg=nil
self.BLinteractWorldNPC=stageID
end
self.stageID=stageID

self:loadStage(onFinish,index,fadeInTime)
self:startTimer()
self.entityPool={}
self.entityIndex=100
self.isOpen=true
self.mainHud=nil
UIManager:showWindow('UIFightMainHUD')
fightManager.stageFadeToColor(0,Color.New(1,1,1,1))
fightManager.resetDotLight(0)
if stageID==screenStageType.interactWorldNPC then

else
buildlightController:setBLState(false)
end

end

function fightStage:loadStage(onFinish,index,fadeInTime)
if self.stageCfg then
local isLoad=fightManager.loadStage(self.stageCfg.assetbundle,onFinish,index,fadeInTime)
if isLoad then
self:resetCamera()
end
fightManager.initCameraEffect(self.stageCfg)
fightManager.playSceneEffect(self.stageCfg)
fightManager.setState(-1,index)
fightManager.setSelectMask({})
else
onFinish()
end
end

function fightStage:resetCamera()
fightManager.stageFadeToColor(0,Color.New(1,1,1,1))
fightManager.resetDotLight(0)
local cameraPara=self.stageCfg.initCamera


if cameraPara then
if next(cameraPara)then
fightManager.initCamera(Vector3.New(cameraPara[1][1],cameraPara[1][2],cameraPara[1][3]),
Vector3.New(cameraPara[2][1],cameraPara[2][2],cameraPara[2][3]),
Vector3.New(cameraPara[3][1],cameraPara[3][2],cameraPara[3][3]),
Vector3.New(cameraPara[4][1],cameraPara[4][2],cameraPara[4][3]),
cameraPara[5])
end
else
fightManager.setCameraActive(false,fightCameraMode.fight)
end
end

function fightStage:startTimer(delayTime)
if self.updateTimer==nil then
local updateFunc=function()
local deltaTime=Time.deltaTime
self:update(deltaTime)
end

self.updateTimer=timer.new()
self.updateTimer:start(0,updateFunc)
end
end

function fightStage:update(deltaTime)
if self.entityPool then
for i,v in pairs(self.entityPool)do
v:update(deltaTime)
end
end
end

function fightStage:close(reserveStage)
local curStage=fightModel:getStageList(self.index)
if curStage==nil then return end

if curStage.stageID~=self.stageID then
return
end

self.isOpen=false

fightModel:closeStageList(self.index)

if self.updateTimer~=nil then
self.updateTimer:cancel()
self.updateTimer=nil
end
if not reserveStage then
if self.stageCfg~=nil then
fightManager.resetCamera()
fightManager.clearStage(false)
end
end

if self.entityPool then
for i,ent in pairs(self.entityPool)do
ent:remove()
end
end
if buildlightModel:isChangeOpenBL_fightStage()then
local BLinteractWorldNPC=self.BLinteractWorldNPC
if BLinteractWorldNPC then

else
buildlightController:setBLState(true)
end
end
self.BLinteractWorldNPC=nil
self.stageCfg=nil
self.entityPool=nil
if self.onClose~=nil then
self.onClose(self.stageID)
end
end

function fightStage:clear()
if self.entityPool then
for i,ent in pairs(self.entityPool)do
ent:remove()
end
self.entityPool={}
end
end





function fightStage:addEntity(index,typo,typoData,pos,flipx)
local rawData
if typo==fightEntityType.diZi then
rawData=fightModel:createEntityInfo(typoData,1,1)
else
rawData=fightModel:createMonsterInfo(typoData,1,1)
end

local ent=self.entityPool[index]
if ent==nil then
local model=rawData.model
ent=entity()
ent:initObj(model.body,model.componets,pos,model.scale,flipx)
self:pushEntity(index,ent)
end
end

function fightStage:addEntityEx(pos,bodyID,slotsID,scale,flipX,callback)
self.entityIndex=self.entityIndex+1
local ent=entity()
ent:initObj(bodyID,slotsID,pos,scale,flipX,callback)
self:pushEntity(self.entityIndex,ent)
return self.entityIndex,ent
end

function fightStage:pushEntity(id,ent)
self.entityPool[id]=ent
end


function fightStage:getEntity(index)
return self.entityPool[index]
end

function fightStage:getEntityPool()
return self.entityPool
end

function fightStage:removeEntity(index)
local ent=self.entityPool[index]
if ent~=nil then
ent:hide()
self.entityPool[index]=nil
end
end


function fightStage:runBehavior(index,btName,onCompele)
local ent=self.entityPool[index]
if ent~=nil then
ent:runBehavior(btName,{},onCompele)
end
end

function fightStage:runBehaviorNoEntity(btName,onCompele)
return fBTBehaviorMrg:run(btName,onCompele)
end



