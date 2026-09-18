def_class('fightPreSelect',{})


function fightPreSelect:__init(onEvent)
self.entitityPool={}
self.curEntity=nil
self.isShow=false
self.onEventChange=onEvent
end

local defaultMask={1,2,3,4,5}


function fightPreSelect:show(stateID,selectMask,onLoadFinish,resetCamera)
if self.isShow then
return
end

fightManager.cleanEntity()

resetCamera=resetCamera==nil and true
self.isShow=true

local stageCfg=fightModel:getStage(stateID or fightStage.defStageID)
if not stageCfg then
loggerUtil.logErrFMT(FMT.fmt("没有此地图配置id:{0}",stateID))
return
end
fightManager.loadStage(stageCfg.assetbundle,onLoadFinish)
if resetCamera then
fightManager.resetCamera(true,0)
end
fightManager.initCameraEffect(stageCfg)
fightManager.playSceneEffect(stageCfg)
fightManager.setState(fightSceneTypo.preSelect)
selectMask=selectMask or defaultMask

self:setSelectMask(selectMask)

self:registerEasyTouch(true)
self.entitityPool={}

self:startTimer()
buildlightController:setBLState(false)
end

function fightPreSelect:setSelectMask(selectMask)
self.mask={}
for i,v in pairs(selectMask)do
self.mask[v]=true
end
fightManager.setSelectMask(selectMask)
end


function fightPreSelect:registerEasyTouch(register)
if register then
local onTouchEvent=function(guid,evtType,posIndex)

local curEnt
if guid~=-1 then
for _,ent in pairs(self.entitityPool)do
if ent.guid==guid then
curEnt=ent
if evtType==1 then
posIndex=curEnt:getIndex()
end
break
end
end
end
if evtType==1 then
if curEnt~=nil and self.mask[curEnt.id]then
self.curEntity=curEnt
fightManager.setSelectEntity(self.curEntity.guid)
curEnt:runAnimator(eAnimationID.move)
end
elseif evtType==3 then
if self.curEntity~=nil then
self:setEntityIndex(self.curEntity,posIndex)
self.curEntity=nil
end
end

if self.onEventChange~=nil then
self.onEventChange(evtType,guid,posIndex)
end
end
fightManager.registerEasyTouch(true,onTouchEvent)
else
fightManager.registerEasyTouch(false)
end
end

function fightPreSelect:exchangeEntityIndex(index,Targetindex)
local ent=self.entitityPool[index]
local tarEnt=self.entitityPool[Targetindex]
if tarEnt~=nil then
if tarEnt.id~=-1 then
tarEnt:setIndex(index)
self.entitityPool[index]=tarEnt
end
end
if ent~=nil then
if ent.id~=-1 then
ent:setIndex(Targetindex)
self.entitityPool[Targetindex]=ent
end
end
end

function fightPreSelect:setEntityIndex(ent,index)
if ent.id==-1 then
notifySystem:postNotify(notifyConfig.onPreSelectRemoveEntity,ent)
ent:remove()
self.entitityPool[ent.id]=nil
else
local preEnt=self.entitityPool[index]
if preEnt~=nil then
if ent.id~=-1 then
preEnt:setIndex(ent.id)
preEnt:runAnimator(eAnimationID.jump4)
self.entitityPool[ent.id]=preEnt

if preEnt.assistant then
preEnt.assistant:setIndex(ent.id+stagePosWeight.assist)
preEnt.assistant:runAnimator(eAnimationID.jump4)
self.entitityPool[ent.id+stagePosWeight.assist]=preEnt.assistant
end
end
else
self.entitityPool[ent.id]=nil
end
if index==-1 then
ent:setIndex(ent.id)
ent:runAnimator(eAnimationID.jump4)
else
ent:setIndex(index)
ent:runAnimator(eAnimationID.jump4)

if ent.assistant then
ent.assistant:setIndex(index+stagePosWeight.assist)
ent.assistant:runAnimator(eAnimationID.jump4)
self.entitityPool[index+stagePosWeight.assist]=ent.assistant
else
if ent.dataGuid then
self:initLingShou(ent,index,ent.baseInfo.typo,ent.dataGuid,ent.posType)
end
end
end
self.entitityPool[ent.id]=ent
end
end

function fightPreSelect:clearEntity(isLeft)
local entLeft=false
for i,ent in pairs(self.entitityPool)do
entLeft=fightModel:isLeft(i)
if(isLeft and entLeft)or((not isLeft)and not entLeft)then
notifySystem:postNotify(notifyConfig.onPreSelectRemoveEntity,ent)
ent:remove()
self.entitityPool[i]=nil
end
end
end

function fightPreSelect:clearAllEntity()
for i,ent in pairs(self.entitityPool)do
notifySystem:postNotify(notifyConfig.onPreSelectRemoveEntity,ent)
ent:remove()
self.entitityPool[i]=nil
end
end

function fightPreSelect:closeSelectStage()
self.isShow=false
for i,ent in pairs(self.entitityPool)do
ent:remove()
end
self.entitityPool={}

if self.updateTimer~=nil then
self.updateTimer:cancel()
self.updateTimer=nil
end

fightManager.clearStage()
fightManager.resetCamera(false)

fightModel:setPreSelectEntity(nil)

if buildlightModel:isChangeOpenBL_fightPreSelect()then
buildlightController:setBLState(true)
end
end

function fightPreSelect:recordPreSelect()
fightModel:setPreSelectEntity(self.entitityPool)
end





function fightPreSelect:addEntity(index,typo,typoData,postData,posTypo,behavior,tips)
local rawData
if typo==fightEntityType.diZi then
rawData=fightModel:createEntityInfo(typoData,1,1)
else
rawData=fightModel:createMonsterInfo(typoData,1,1)
end

local ent=self.entitityPool[index]
if ent==nil then
ent=fightEntity(nil,posTypo or stagePosType.TwoThree,index,rawData,true)
self.entitityPool[index]=ent
ent:show()

ent.dataGuid=typoData
else
ent:init(nil,posTypo or stagePosType.TwoThree,index,rawData,true)
self.entitityPool[index]=ent
ent:show()
ent.dataGuid=typoData
end
if index==-1 then
self.curEntity=ent
fightManager.setSelectEntity(ent.guid)
ent:runAnimator(eAnimationID.move)
else
if behavior then
ent:runBehavior(behavior,{},nil)
else
self:appear(typo,typoData,ent)
end
self:initLingShou(ent,index,typo,typoData,posTypo,behavior)
end

if typo==fightEntityType.diZi then
self:initFaBao(ent,typoData)
end

if tips then
ent:flowText(flowObjTypo.tip,{strPara=tips,nunPara=nil,stayTime=1})
end

notifySystem:postNotify(notifyConfig.onPreSelectAddEntity,ent,postData)
end

function fightPreSelect:addEntityEx(index,typo,typoData,postData,posTypo,behavior,tips)
local rawData
local dataGuid
if typo==fightEntityType.diZi then

local arrangeDZ=typoData
dataGuid=arrangeDZ.discipleguid
rawData=fightModel:createEntityInfoEx(arrangeDZ,1,1)
else
dataGuid=typoData
rawData=fightModel:createMonsterInfo(typoData,1,1)
end

local ent=self.entitityPool[index]
if ent==nil then
ent=fightEntity(nil,posTypo or stagePosType.TwoThree,index,rawData,true)
self.entitityPool[index]=ent
ent:show()

ent.dataGuid=dataGuid
else
ent:init(nil,posTypo or stagePosType.TwoThree,index,rawData,true)
self.entitityPool[index]=ent
ent:show()
ent.dataGuid=dataGuid
end
if index==-1 then
self.curEntity=ent
fightManager.setSelectEntity(ent.guid)
ent:runAnimator(eAnimationID.move)
else
if behavior then
ent:runBehavior(behavior,{},nil)
else
self:appear(typo,typoData,ent)
end
self:initLingShouEx(ent,index,typo,typoData,posTypo,behavior)
end

if typo==fightEntityType.diZi then
self:initFaBaoEx(ent,typoData)
end

if tips then
ent:flowText(flowObjTypo.tip,{strPara=tips,nunPara=nil,stayTime=1})
end

notifySystem:postNotify(notifyConfig.onPreSelectAddEntity,ent,postData)
end

function fightPreSelect:initFaBao(ent,guid)
local equip=equipsHelper.getEquipByDizi(guid,EQUIP_TYPE.eFabao)
if not equip then
equip=otherPlayerModel:getDZEquipData(guid,EQUIP_TYPE.eFabao)
end
if equip then
if equip.itemData then
if ent.fabaoObjID~=nil then
ent.hud:stopText(ent.fabaoObjID)
ent.fabaoObjID=nil
end
ent.fabaoObjID=ent.hud:flowText(flowObjTypo.fabao,{equipPara=equip})
end
end
end


function fightPreSelect:initFaBaoEx(ent,typoData)

local arrangeDZ=typoData
local equip=otherPlayerModel:getArrangeDZ_equipData(arrangeDZ,EQUIP_TYPE.eFabao)
if arrangeDZ.equipLookup==nil then
local fabaoList=arrangeDZ.fabaoList or{}
equip=fabaoList[1]
end
if equip then
if equip.itemData then
if ent.fabaoObjID~=nil then
ent.hud:stopText(ent.fabaoObjID)
ent.fabaoObjID=nil
end
ent.fabaoObjID=ent.hud:flowText(flowObjTypo.fabao,{equipPara=equip})
end
end
end


function fightPreSelect:addEntityShield(shieldId,isLeft)
local rawData=fightModel:createShieldInfo(shieldId,1,1)
local index=isLeft and 51 or 52
local ent=self.entitityPool[index]
if ent==nil then
ent=fightShield(nil,stagePosType.TwoThree,index,rawData,true)
self.entitityPool[index]=ent
ent:show()
else
ent:init(nil,stagePosType.TwoThree,index,rawData,true)
self.entitityPool[index]=ent
ent:show()
end
end

function fightPreSelect:initLingShou(mainEnt,mainIndex,typo,typoData,posTypo,behavior)
local posIndex=mainIndex+stagePosWeight.assist
local lsData=nil
if typo==fightEntityType.diZi then
if UIDiscipleModel:isMyActorDZ(typoData)then
local ls_guid=UIDiscipleModel:getDZLingShou(typoData)
if ls_guid then
lsData=lingshouModel:getLingShouData(ls_guid)
end
else
lsData=otherPlayerModel:getDZLingShouData(typoData)
end
end


if lsData then
local id=lsData.id
local ls_guid=lsData.guid
local modelId=lingshouModel:getLingShouModel(ls_guid)

local ent=self.entitityPool[posIndex]
if ent==nil then

ent=fightEntity(nil,posTypo or stagePosType.TwoThree,posIndex,fightModel:getAssistantInfo({id,modelId}),nil,fightAssistantType.eLingShou)
self.entitityPool[posIndex]=ent
ent:show()
end

if behavior then
ent:runBehavior(behavior,{},nil)
else
ent:runAnimator(eAnimationID.jump4)
end

mainEnt.assistant=ent
end
end


function fightPreSelect:initLingShouEx(mainEnt,mainIndex,typo,typoData,posTypo,behavior)
local posIndex=mainIndex+stagePosWeight.assist
local lsData=nil
if typo==fightEntityType.diZi then

local arrangeDZ=typoData
lsData=otherPlayerModel:getArrangeDZ_lingshou(arrangeDZ)
end
if lsData then
local id=lsData.id
local ls_guid=lsData.guid
local modelId=lingshouModel:getLingShouModel(ls_guid)

local ent=self.entitityPool[posIndex]
if ent==nil then

ent=fightEntity(nil,posTypo or stagePosType.TwoThree,posIndex,fightModel:getAssistantInfo({id,modelId}),nil,fightAssistantType.eLingShou)
self.entitityPool[posIndex]=ent
ent:show()
end

if behavior then
ent:runBehavior(behavior,{},nil)
else
ent:runAnimator(eAnimationID.jump4)
end

mainEnt.assistant=ent
end
end

function fightPreSelect:appear(typo,typoData,ent)
if typo==fightEntityType.monster then
local monsterCfg=cfg_monsterconfig_get(typoData)
if monsterCfg and monsterCfg.appear then
local appearCfg=monsterCfg.appear
local appearType=appearCfg[1]
if appearType==1 then

local effectid=appearCfg[2]
local flipX=appearCfg[3]or false
local tips=appearCfg[5]
if effectid~=nil and effectid>0 then
local stay=appearCfg[4]or 1
ent:setVisible(false)
local func=function()
ent:setVisible(true)
ent:flipX(flipX)
if tips then
ent:flowText(flowObjTypo.tip,{strPara=tips,nunPara=nil,stayTime=1})
end
end
if stay>0 then
timeEventController.delayDo(stay,func)
else
func()
end
ent:playEffect(effectid,Vector3.zero,false,true)
else
if tips then
ent:flowText(flowObjTypo.tip,{strPara=tips,nunPara=nil,stayTime=1})
end
end
elseif appearType==2 then

local effectid=appearCfg[2]
local flipX=appearCfg[3]or false
local movePos=appearCfg[4]
local moveTime=appearCfg[5]
local curPos=Vector3.New(movePos[1],movePos[2],movePos[3])
local tips=appearCfg[7]
local dstPos=ent:getPosition()
ent:setVisible(false)
ent:moveTo(curPos,false,0.1,1,function()
ent:setVisible(true)
end)
local movefunc=function()
ent:flipX(flipX)
local func=function()
ent:runAnimator(eAnimationID.stand)
if tips then
ent:flowText(flowObjTypo.tip,{strPara=tips,nunPara=nil,stayTime=1})
end
end
ent:moveTo(dstPos,false,moveTime or 1,1,func)
ent:runAnimator(eAnimationID.run)
end
if effectid~=nil and effectid>0 then
local stay=appearCfg[6]or 1
if stay>0 then
timeEventController.delayDo(stay,movefunc)
else
movefunc()
end
ent:playEffect(effectid,Vector3.zero,false,true)
else
movefunc()
end
end
else
ent:runAnimator(eAnimationID.jump4)
end
else
ent:runAnimator(eAnimationID.jump4)
end
end

function fightPreSelect:entityTalk(index,tipStr,stay)
local entity=self:getEntity(index)
if entity then
entity:flowText(flowObjTypo.tip,{strPara=tipStr,nunPara=nil,stayTime=stay or 1})
end
end

function fightPreSelect:startTimer()
if self.updateTimer==nil then
local updateFunc=function()
local deltaTime=Time.deltaTime
self:update(deltaTime)
end

self.updateTimer=timer.new()
self.updateTimer:start(0,updateFunc)

end
end

function fightPreSelect:update(deltaTime)
if self.entitityPool then
for i,v in pairs(self.entitityPool)do
v:update(deltaTime)
end
else
loggerUtil.logErrFMT("战斗布阵场景已关闭,entityPool为空")
end
end



function fightPreSelect:removeEntity(index)
local ent=self.entitityPool[index]
if ent~=nil then
if ent.fabaoObjID~=nil then
ent.hud:stopText(ent.fabaoObjID)
ent.fabaoObjID=nil
end
notifySystem:postNotify(notifyConfig.onPreSelectRemoveEntity,ent)
ent:remove()
self.entitityPool[index]=nil


if ent.assistant then
ent.assistant:remove()
self.entitityPool[index+stagePosWeight.assist]=nil
end
end
end

function fightPreSelect:getEntity(index)
return self.entitityPool[index]
end

