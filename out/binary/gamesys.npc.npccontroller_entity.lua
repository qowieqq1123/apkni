







local stopEffect=CS.GameInterface.StopEffect
local worldStageEntityDistance=2
local test_worldLookNPCHigh

local worldLookNPCHighLookup={
[0]=13,
[1]=13,
[2]=9,
[3]=9,
}

function npcController:testWorldLookNPCHigh(v)
test_worldLookNPCHigh=v
end
function npcController:getWordLookNPCHigh(worldid)
if test_worldLookNPCHigh~=nil then
return test_worldLookNPCHigh
end
return worldLookNPCHighLookup[worldid]or worldLookNPCHighLookup[0]
end




function npcController:onEnterWorld(worldid)
npcController:initWorldNPCEntity(worldid)
end

function npcController:onLeaveWorld()
npcController:clearWorldNPCEntity()
end

function npcController:initWorldNPCEntity(worldid)
npcController:clearWorldNPCEntity()

npcController.worldNPCEntityLookup={}
local allDatas=npcModel:getAllNPCLookup()or{}
for _,npcItemData in pairs(allDatas)do
local npcData=npcItemData.npcData
if NPC_TYPE:isWorldNPC(npcData.npctype)then
local worldid_=npcData.worldid
if worldid_==worldid then
npcController:initWorldNPCEntityEx(npcItemData,worldid)
end
end
end
end

function npcController:newWorldNPCEntity(npcItemData,worldid)
if worldid==nil then return end
local npcData=npcItemData.npcData
if NPC_TYPE:isWorldNPC(npcData.npctype)then
local worldid_=npcData.worldid
if worldid_==worldid then
npcController:initWorldNPCEntityEx(npcItemData,worldid)
end
end
end

function npcController:initWorldNPCEntityEx(npcItemData,worldid)
local lookup=npcController.worldNPCEntityLookup
local npcid=npcItemData.npcid
if lookup[npcid]==nil then
local entity={}
entity.npcid=npcid
local unitKey=FMT.fmt('{0}_{1}',eWorldUnitTpye.NPC,npcid)
local posVector=npcItemData.posVector

local data={eWorldUnitTpye.NPC,npcid}
local modelID=npcModel:getNPCWorldModelID(npcid)
local modelSettings=worldModel:getModelSettings(modelID,eWorldUnitTpye.NPC)
local hudSetting=worldModel:getHUDSetting(14)
worldController:pushUnit(unitKey,posVector.pos,data,modelSettings,hudSetting,nil)
worldController:setUnitFlipX(unitKey,posVector.flip)
entity.unitKey=unitKey
entity.pos=posVector.pos
entity.side=posVector.side
entity.flip=posVector.flip
entity.guid=posVector.guid
entity.worldid=worldid
lookup[npcid]=entity
end
end

function npcController:getWorldNPCEntity(npcid)
local lookup=npcController.worldNPCEntityLookup
if lookup~=nil then
return lookup[npcid]
end
end

function npcController:clearWorldNPCEntity(clean)
local lookup=npcController.worldNPCEntityLookup
if lookup~=nil then
for k,entity in pairs(lookup)do
if clean then
worldPositionLibrary:eraseData(entity.guid)
end
worldController:popUnit(entity.unitKey)
end
npcController.worldNPCEntityLookup=nil
end
end

function npcController:showWorldEntityStage(npcid,showSmoke)
if npcController:checkStageLoading()then
return false
end
local npcEntity=npcController.worldNPCEntityLookup[npcid]
if npcEntity==nil then
return false
end
if npcid==self.stageNPCID then
if not UIManager:isActive('UINPCInteractWin')then
local params2={npcid=npcid}
worldController:changeRightView('UINPCInteractWin',params2)
else
UIManager:invokeUIMethod('UINPCInteractWin','changeNPC',npcid)
end
return false
end

local oldWorldCameraHigh=self.worldCameraHigh
if self.stageNPCID~=nil or self.mStage~=nil then
npcController:clearWorldEntityStage()
worldController:resetRightView()
end

self.showSmoke=showSmoke==nil or showSmoke==true
local worldNPCPos=npcEntity.pos
self.worldNPCPos=worldNPCPos
self.worldNPCSide=npcEntity.side
self.worldNPCWorldID=npcEntity.worldid
local dis=worldStageEntityDistance
if npcEntity.side==0 then

self.worldDZPos=Vector3(worldNPCPos.x+dis,worldNPCPos.y,worldNPCPos.z)
self.worldCameraPos=Vector3(worldNPCPos.x+dis/2,worldNPCPos.y,worldNPCPos.z)
else

self.worldDZPos=Vector3(worldNPCPos.x-dis,worldNPCPos.y,worldNPCPos.z)
self.worldCameraPos=Vector3(worldNPCPos.x-dis/2,worldNPCPos.y,worldNPCPos.z)
end
if oldWorldCameraHigh~=nil then
self.worldCameraHigh=oldWorldCameraHigh
else
self.worldCameraHigh=worldController:getCameraPosition().y
end

self.stageNPCID=npcid

local callback=function()
npcController:setWorldEntityStageReady()
end
npcController:createWorldEntityStage(callback)
return true
end

function npcController:setWorldEntityStageReady()

local moveBack=function()

worldController:showObjectRoot(false)
worldController:displayHUD(false)
worldController:displaySymbol(false)
UIManager:invokeUIMethod('UIWorldWin','forceShowTeam',false)



self.stageEntityList[2].entity:setVisible(true)

local showFunc=function()
if npcController.stageEntityList==nil then
return
end
local dz_entity=npcController.stageEntityList[1].entity
dz_entity:setVisible(true)
end

if self.showSmoke then
local dz_entity=self.stageEntityList[1].entity
dz_entity:playEffect(3,Vector3.zero,false,true)
timeEventController.delayDo(0.5,showFunc)
else
showFunc()
end

if not UIManager:isActive('UINPCInteractWin')then
local params={npcid=self.stageNPCID}
worldController:changeRightView('UINPCInteractWin',params)
else
UIManager:invokeUIMethod('UINPCInteractWin','changeNPC',self.stageNPCID)
end
end
timeEventController.delayDo(0.1,moveBack)


local minZoom=npcController:getWordLookNPCHigh(self.worldNPCWorldID)
worldController:lookAtPosition_Duration(npcController.worldCameraPos,minZoom,0.6,nil,DG.Tweening.Ease.OutExpo)
end

function npcController:closeWorldEntityStage(cameraReturn)
if self.stageEntityList==nil then
return
end
npcController:clearWorldEntityStage()


worldController:showObjectRoot(true)
worldController:displayHUD(true)
worldController:displaySymbol(true)
UIManager:invokeUIMethod('UIWorldWin','forceShowTeam',true)


local worldCameraHigh=self.worldCameraHigh
if worldCameraHigh~=nil then
if cameraReturn==nil then cameraReturn=true end
if cameraReturn then
local cameraPos=worldController:getCameraPosition()
local range=worldController:getCameraZoomRange()
local height=Mathf.Clamp(worldCameraHigh,range[1],range[2])
worldController:lookAtPosition_Duration(cameraPos,height,0.6,nil,DG.Tweening.Ease.InQuart)
end
self.worldCameraHigh=nil
end
end


function npcController:closeWorldEntityStageEx()
if self.stageEntityList==nil then
return
end
npcController:clearWorldEntityStage()

worldController:showObjectRoot(true)
worldController:displayHUD(true)
worldController:displaySymbol(true)
UIManager:invokeUIMethod('UIWorldWin','forceShowTeam',true)

end

function npcController:checkStageLoading()
if npcController.loadIndex~=nil and npcController.loadIndex>0 then
return true
end
return false
end
function npcController:createWorldEntityStage(callback)
if npcController:checkStageLoading()then
return
end

npcController.loadIndex=0
local loadBack=function()
npcController.loadIndex=npcController.loadIndex+1
if npcController.loadIndex==3 then
npcController.loadIndex=nil
if callback then
callback()
end
end
end


self.mStage=fightStage:create(screenStageType.interactWorldNPC,loadBack,nil,nil,nil,true)

self.stageEntityList={}

local dzId=npcModel:getInteractDZ()
local model1=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId,true,1)
local pos1=self.worldDZPos
local scale1=1
local idx,entity=self.mStage:addEntityEx(pos1,model1.body,model1.componets,scale1,false,loadBack)
entity:setVisible(false)
entity:flipX(self.worldNPCSide==1)
local d={}
d.entity=entity
d.entityIndex=idx
self.stageEntityList[1]=d

local imagecfg=npcModel:getNPCImageCfg(self.stageNPCID)
local model2=npcModel:getImageInfoOutSide(imagecfg.id,1)
local pos2=self.worldNPCPos
local scale2=1
local idx2,entity2=self.mStage:addEntityEx(pos2,model2.body,model2.componets,scale2,false,loadBack)
entity2:setVisible(false)
entity2:flipX(self.worldNPCSide==0)
local d2={}
d2.entity=entity2
d2.entityIndex=idx2
self.stageEntityList[2]=d2
end

function npcController:rebuildWorldInteractNPCDZ()
if self.mStage==nil then return end
local d=self.stageEntityList[1]
if d~=nil then
self.mStage:removeEntity(d.entityIndex)
self.stageEntityList[1]=1
end

local dzId=npcModel:getInteractDZ()
local model1=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId,true,1)
local pos1=self.worldDZPos
local scale1=1
local idx,entity=self.mStage:addEntityEx(pos1,model1.body,model1.componets,scale1,false,nil)
entity:flipX(self.worldNPCSide==1)
d={}
d.entity=entity
d.entityIndex=idx
self.stageEntityList[1]=d

entity:setVisible(false)
local showFunc=function()
if npcController.stageEntityList==nil then
return
end
local dz_entity=npcController.stageEntityList[1].entity
dz_entity:setVisible(true)
end
timeEventController.delayDo(0.5,showFunc)
entity:playEffect(3,Vector3.zero,false,true)
end

function npcController:worldInteractDZTalk(str,time,canvas)
if self.stageEntityList==nil then
return
end








UIManager:invokeUIMethod('UINPCInteractWin','dzTalk',str,time,canvas)
end

function npcController:worldInteractNPCTalk(str,time,canvas)
if self.stageEntityList==nil then
return
end








UIManager:invokeUIMethod('UINPCInteractWin','npcTalk',str,time,canvas)
end

function npcController:worldInteractNPCEmot(emotid,expressionid,time)
if self.stageEntityList==nil then
return
end
local d=self.stageEntityList[2]
local entity=d.entity
local npcEmotID=self.npcEmotID
if npcEmotID~=nil then
entity:stopText(npcEmotID)
end
time=time or 3
self.npcEmotID=entity:flowText(flowObjTypo.biaoQing,{strPara=nil,nunPara=emotid,stayTime=time})
if expressionid and expressionid>0 then
self.npc_expressionid=expressionid
entity:setExpression(expressionid)
local func=function()
if self.stageEntityList==nil then
return
end
if self.npc_expressionid then
self.npc_expressionid=nil
self.stageEntityList[2].entity:setExpression(0)
end
end
timeEventController.delayDo(time,func)
end
end

function npcController:worldInteractDZEmot(emotid,expressionid,time)
if self.stageEntityList==nil then
return
end
local d=self.stageEntityList[1]
local entity=d.entity
local dzEmotID=self.dzEmotID
if dzEmotID~=nil then
entity:stopText(dzEmotID)
end
time=time or 3
self.dzEmotID=entity:flowText(flowObjTypo.biaoQing,{strPara=nil,nunPara=emotid,stayTime=time})
if expressionid and expressionid>0 then
self.dz_expressionid=expressionid
entity:setExpression(expressionid)
local func=function()
if self.stageEntityList==nil then
return
end
if self.dz_expressionid then
self.dz_expressionid=nil
self.stageEntityList[1].entity:setExpression(0)
end
end
timeEventController.delayDo(time,func)
end
end

function npcController:worldInteractNPCHit(time,time2,injury)
if self.stageEntityList==nil then
return
end

for i,d in ipairs(self.stageEntityList)do
local entity=d.entity
entity:setColor(Color.New(0,0,0,0))
end

npcController:clearFightEffect()
local effectPos=Vector3.zero
effectPos.x=self.worldCameraPos.x-self.worldNPCPos.x
self.fightEffect=self.stageEntityList[2].entity:playEffect(worldDispatchFactory.fightEffect,effectPos,false,false)

local func=function()
if npcController.stageEntityList==nil then
return
end

npcController:clearFightEffect()

for i,d in ipairs(self.stageEntityList)do
local entity=d.entity
entity:setColor(Color.white)
end
npcController:worldInteractDZEmot(1,5,time2)
local str=FMT.fmt('<color=#c82c2c>负伤值+{0}</color>',injury)
local args={[1]=0,[2]=str}
if npcController.worldNPCSide==0 then

args.startPos=Vector3.New(85,-45,0)
args.entPos=Vector3.New(85,145,0)
else

args.startPos=Vector3.New(-85,-45,0)
args.entPos=Vector3.New(-85,145,0)
end
commonTipsHelper.addThrowOutAndSliderTipsEx(args)
end
timeEventController.delayDo(time,func)
end

function npcController:clearFightEffect()
if self.fightEffect then
stopEffect(self.fightEffect)
self.fightEffect=nil
end
end

function npcController:getStageNPCID()
return self.stageNPCID
end

function npcController:clearWorldEntityStage()
if self.stageEntityList~=nil then
local dz_entity=self.stageEntityList[1].entity
local npc_entity=self.stageEntityList[2].entity

local dzTalkID=self.dzTalkID
if dzTalkID~=nil then
dz_entity:stopText(dzTalkID)
end

local npcTalkID=self.npcTalkID
if npcTalkID~=nil then
npc_entity:stopText(npcTalkID)
end
local npcEmotID=self.npcEmotID
if npcEmotID~=nil then
npc_entity:stopText(npcEmotID)
end
self.npc_expressionid=nil
local dzEmotID=self.dzEmotID
if dzEmotID~=nil then
npc_entity:stopText(dzEmotID)
end
self.dz_expressionid=nil
self.stageEntityList=nil
end
npcController:clearFightEffect()
if self.mStage~=nil then
self.mStage:close()
self.mStage=nil
end
self.stageNPCID=nil
self.dzTalkID=nil
self.npcTalkID=nil
self.npcEmotID=nil
end

