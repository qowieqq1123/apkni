









local xjTeamEntity={}


function xjTeamEntity:onSpeedUp()
local teamHandle=self:getTeamHandle()
self.moveTagList=teamHandle:getMoveTagList(self.movePath,self.beginTime)

if xianguanModel:get_PZXJ_march_guid()==teamHandle.marchguid_str then
local delay=xianguanModel:get_delay_PZXJ_marchd()
if delay>0 then
timeEventController.delayDo(delay,function()
if self and self:getWidget()then
xianjieController:invokeEntityHudFunc(self.hudExID,'onPZXJTeQuanHide')
self:playPZXJSpeedupEffect()
end
end)
else
self:playPZXJSpeedupEffect()
end
xianguanModel:set_PZXJ_march_guid()
else
self:refreshTeam()
end
end

function xjTeamEntity:setMoveEase(ease)
self.moveEase=ease
end

function xjTeamEntity:clearMoveEase()
self.moveEase=nil
end

function xjTeamEntity:getSpeedMulti()
local teamHandle=self:getTeamHandle()
return teamHandle:getSpeedMulti()
end

function xjTeamEntity:getSpeedCnt()
local teamHandle=self:getTeamHandle()
return teamHandle:getSpeedCnt()
end


function xjTeamEntity:checkLOD()
local sceneidx=self:getTeamSceneIndex()
if xianjieModel:checkSceneIndex(sceneidx)then
return true
end
return false
end


function xjTeamEntity:onCreateWidget(widget)

self:refreshTeam(widget,true)
end

function xjTeamEntity:initModel(widget)

local flag=xianjieController:getJianHuaMode()
if not self.showModel or not flag then
self.showModel=true

local teamHandle=self:getTeamHandle()
local modelset=teamHandle:getMarchTeamModelSet()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams(1)
widget:SetChildActive(1,true)
widget:SetChildSceneEntityCreateModel(0,modelset.modelID,{},'Entity',entCfg.sortOrder,modelset.scale,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
if deviceHelper.getAPILevel()>=352 then
widget:SetChildSceneEntitySetShaderRenderQueue(0,3000,8)
end

self:initSpeedupEffect(widget)
self:initSFXSSpeedupEffect(widget)

if self.isHideModel then
widget:SetChildActive(1,false)
end
end
end

function xjTeamEntity:clearModel(widget)
self:clearTweener()
if self.showModel then
self.showModel=nil
widget:SetChildSceneEntityRemoveModel(0)
end
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),0)
widget:SetChildRotation(1,0,0,0)
self:clearSpeedupEffect(widget)
self:clearSFXSSpeedupEffect(widget)
self:clearPZXJSpeedupEffect(widget)
end

function xjTeamEntity:clearSpeedupEffect(widget)
if self.speedupEffectID then
self.speedupEffectID=nil
widget:SetChildShowEffect(2,0,false)
end
end

function xjTeamEntity:initSpeedupEffect(widget)
if self.fightMark then return end
local speedcnt=self:getSpeedCnt()
local effectId=xianjieModel:getMarchSpeedEffect(speedcnt)or 0
self.speedupEffectID=effectId>0 and effectId or nil

local sortingLayer=helper.getSortingLayerID("Entity")
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildShowEffectEx(2,effectId or 0,sortingLayer,entCfg.sortOrder-1,effectId~=nil)
widget:SetChildScale(2,Vector3.New(0.2,0.2,0.2))
end

function xjTeamEntity:refreshTeam(widget,isInit)
widget=widget or self:getWidget()
if widget==nil then return end


local teamHandle=self:getTeamHandle(self)
local moveTagIndex=xianjieController:getMoveTagListIndex(self.moveTagList)
local tag=self.moveTagList[moveTagIndex]
if not tag then

end
local sceneidx=tag[3]
local etime=tag[5]
local speed=tag[6]
local sameScene=xianjieModel:checkSceneIndex(sceneidx)
local changeSpeed=false
if self.curSpeed~=speed then
self.curSpeed=speed
changeSpeed=true
end
if isInit then
self.isHideModel=nil
end

if sameScene then
self:clearTweener()
self:initModel(widget)

local atkSize,atkOffset=teamHandle:getAtkTargetParams()
local sceneidx_,cpos,lerp_time_,spos,epos,speed_,isLast,sPos2,ePos2=xianjieController:getMoveTagLerpMovePos(self.moveTagList,moveTagIndex,nil,atkSize,atkOffset)

widget:SetChildActive(1,true)
widget:SetChildPosition(1,cpos)
local stateID,flipX,flipY,realAngle,normalAngel=xianjieModel.getMarchTeamModelState(sPos2,ePos2)
widget:SetChildSceneEntityPlayAnimation(0,stateID,1,nil)
widget:SetChildSceneEntityFlipXY(0,flipX,flipY)

local flag=xianjieController:getJianHuaMode()
if flag then
widget:SetChildSceneEntityFreezeAnimation(0,stateID,1)
end

local direction=ePos2-sPos2
local eulerAngles=CS.GameInterface.GetChildEulerAngle(Vector3.right,direction,Vector3.up)
widget:SetChildRotation(2,90,eulerAngles.y,eulerAngles.z)
local addAnglesList={
[-3]=-15,
[-1]=15,
[1]=-15,
[3]=15,
}
local angelIndex=math.floor(normalAngel/45)
local addAngle=addAnglesList[angelIndex]or 0
widget:SetChildRotation(4,0,0,normalAngel+addAngle)

widget:SetChildRotation(1,0,0,realAngle-normalAngel)




if lerp_time_>0 then
local key=self:getKey()
self.moveTweener=widget:SetChildDOMove(1,epos,lerp_time_,function()
self.moveTweener=nil
if not isLast then
local key_=self:getKey()
if key_==key then
self:refreshTeam()
self:changeLOD()
end
end
end)
self.moveTweener:SetEase(self.moveEase or DG.Tweening.Ease.Linear)
end

if self.isHideModel then
widget:SetChildActive(1,false)
end
else
self.changeSceneTime=etime
self:clearModel(widget)
end
self:refreshInvisibleEffect(widget)

if isInit then
if not self.isHideModel and not self.fightMark then

local boxParams2=self:handleBoxParams(2)
local enemyTypo=teamHandle.enemyType
if xianjieController.curlodLevel<=xianjieController.hideOtherLineLOD or enemyTypo~=xjEnemyType.eStranger then
self:drawMyLines(speed,boxParams2)
end
end
else
if changeSpeed then
if self:hasLine()then
self:setLinesSpeed(speed)
end
self:initSpeedupEffect(widget)
self:initSFXSSpeedupEffect(widget)
end
end
end

function xjTeamEntity:checkLine()
if self.inAOI_mark and not self.fightMark then
if self.isHideModel or xianjieController.curlodLevel>xianjieController.hideOtherLineLOD then
if self:hasLine()then
local teamHandle=self:getTeamHandle()
local enemyTypo=teamHandle.enemyType
if self.isHideModel or enemyTypo==xjEnemyType.eStranger then
self:removeMyLines(false)
end
end
else
if not self:hasLine()then
local boxParams2=self:handleBoxParams(2)
local moveTagIndex=xianjieController:getMoveTagListIndex(self.moveTagList)
local tag=self.moveTagList[moveTagIndex]
self:drawMyLines(tag[6],boxParams2)
end
end
else
if self:hasLine()then
self:removeMyLines(true)
end
end
end



function xjTeamEntity:onRemoveWidget(widget)
self:clearModel(widget)
xianjieModel:leaveSceneState(xjSceneStateType.eClickLine)
end

function xjTeamEntity:clearTweener()
if self.moveTweener~=nil then


self.moveTweener:Kill()
self.moveTweener=nil
end
end


function xjTeamEntity:onMyClick(boxParams,clickPos)
local widget=self:getWidget()
if widget==nil then return end
local typo=boxParams[1]
if typo==1 then

local clickEntKey=self:getKey()
xianjieModel:enterSceneState_clickTeam_before(clickEntKey)
else

local teamHandle=self:getTeamHandle()
local isIgnoreArea=teamHandle and teamHandle.isIgnoreArea
local flag,spos,epos,cpos=xianjieController:getMovePathClickPos(self.movePath,clickPos,isIgnoreArea)
if flag then
xianjieController:lookAtPosition(cpos,nil,0.2,nil,DG.Tweening.Ease.Linear)
local clickEntKey=self:getKey()
xianjieModel:enterSceneState(xjSceneStateType.eClickLine,clickEntKey,spos,epos,cpos)
end
end
end


function xjTeamEntity:onUpdate()
if self.changeSceneTime then
local cTime=gameUtilityModel.getServerShortTime2()
if cTime>=self.changeSceneTime then
self.changeSceneTime=nil
self:refreshTeam()
self:changeLOD()
end
end
self:checkLine()
end

function xjTeamEntity:getTeamSceneIndex()
local moveTagIndex=xianjieController:getMoveTagListIndex(self.moveTagList)
local tag=self.moveTagList[moveTagIndex]
if tag then
return tag[3]
end
end

function xjTeamEntity:getTeamPos()
local teamHandle=self:getTeamHandle()
local moveTagIndex=xianjieController:getMoveTagListIndex(self.moveTagList)
local atkSize,atkOffset=teamHandle:getAtkTargetParams()
local sceneidx,cpos=xianjieController:getMoveTagLerpMovePos(self.moveTagList,moveTagIndex,true,atkSize,atkOffset)
return sceneidx,cpos
end

function xjTeamEntity:getTeamPosStart()
local tag=self.moveTagList[1]
local sceneidx=tag[3]
local spos=tag[1]
return sceneidx,spos
end

function xjTeamEntity:getTeamPosEnd()
local tag=self.moveTagList[#self.moveTagList]
local sceneidx=tag[3]
local epos=tag[2]
return sceneidx,epos
end


function xjTeamEntity:standbyFight()
self.fightMark=true
local widget=self:getWidget()
if widget then
self:clearSpeedupEffect(widget)
self:clearSFXSSpeedupEffect(widget)
self:clearPZXJSpeedupEffect(widget)
self:removeMyLines(true)
end
end


function xjTeamEntity:refreshInvisibleEffect(widget,isForceStop)
if not isForceStop and self.isHideModel~=nil then
return
end


local teamHandle=self:getTeamHandle()
local isHideModel=false
local isInvisible=false
if not isForceStop then
if teamHandle.teamType~=xjTeamHandleType.eJiJieChuZheng and teamHandle.teamType~=xjTeamHandleType.eMoJunFenShenAttack then
local actorId
local zmData
if teamHandle.enemyType==xjEnemyType.eSelf then
actorId=playerModel:getActorID()
zmData=xianjieModel:getMyZongMenData()
else
local spValueNameList={
[xjTeamHandleType.eMarchSpy]="srcactorid",
[xjTeamHandleType.eMarchYuanZhu]="srcactorid",
[xjTeamHandleType.eAttackRole]="srcactorid",
[xjTeamHandleType.eCarryRepair]="srcactorid",
[xjTeamHandleType.eMarchMJSLDebuffAdd]="srcactorid",
[xjTeamHandleType.eMarchMJBoxCJ]="srcactorid",
}
local valueName=spValueNameList[teamHandle.teamType]or"actorid"
actorId=teamHandle.teamData[valueName]
zmData=xianjieModel:getZongMenData(actorId)
end
isInvisible=xianjieModel:isZmInvisible(actorId)
local enemyType=xianjieModel:checkEnemyType2(actorId,zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
isHideModel=isInvisible and not isFriend
end
end

if not isHideModel then
widget:SetChildActive(1,true)
if isInvisible then







widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0.5),0)

else
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),0)
end
else
widget:SetChildActive(1,false)
end
self.isHideModel=isHideModel
end

function xjTeamEntity:clearSFXSSpeedupEffect(widget)
if self.speedupEffectID_SFXS then
self.speedupEffectID_SFXS=nil
widget:SetChildShowEffect(4,0,false)
end
end

function xjTeamEntity:initSFXSSpeedupEffect(widget)
widget=widget or self:getWidget()
if widget==nil then return end
if self.fightMark then return end


local effectId=self:getSFXSSpeedUpEffectId()

self.speedupEffectID_SFXS=nil
if effectId and effectId>0 then
self.speedupEffectID_SFXS=effectId
end

local sortingLayer=helper.getSortingLayerID("Entity")
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildShowEffectEx(4,effectId or 0,sortingLayer,entCfg.sortOrder+1,effectId~=nil)
widget:SetChildScale(4,Vector3.New(0.5,0.5,0.5))
end

function xjTeamEntity:getSFXSSpeedUpEffectId()
local teamHandle=self:getTeamHandle()
local effectId
local teamData=teamHandle and teamHandle.teamData or nil
local marchType=teamData and teamData.marchtype or nil
if marchType then

if teamData and teamData.marcheffect and teamData.marcheffect==1 then

effectId=10766
end
end

return effectId
end

function xjTeamEntity:clearPZXJSpeedupEffect(widget)
if self.speedupEffectID_PZXJ then
self.speedupEffectID_PZXJ=nil
widget:SetChildShowEffect(4,0,false)
end
end

function xjTeamEntity:playPZXJSpeedupEffect(widget)
widget=widget or self:getWidget()
if widget==nil then return end
if self.fightMark then return end

self:clearSpeedupEffect(widget)

self:clearTweener()
self:setMoveEase(DG.Tweening.Ease.InCubic)

local sortingLayer=helper.getSortingLayerID("Entity")
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)

widget:SetChildScale(0,Vector3.New(0,0,0))
widget:SetChildShowEffectEx(5,22649,sortingLayer,entCfg.sortOrder+1,true)
widget:SetChildScale(5,Vector3.New(3,3,3))
local sequence=Lua.SequenceProxy.New()
sequence:AppendInterval(0.2)
sequence:AppendCallback(function()
widget:SetChildShowEffectEx(6,22651,sortingLayer,entCfg.sortOrder+1,true)
widget:SetChildLocalPosY(6,7)
widget:SetChildScale(0,Vector3.New(1,1,1))
end)
sequence:AppendInterval(0.8)
sequence:AppendCallback(function()
self.PZXJEffectFirst=true
self:refreshTeam()
self:initPZXJSpeedupEffect(widget)
self:clearMoveEase()
end)

end

function xjTeamEntity:initPZXJSpeedupEffect(widget)
if self.PZXJEffectFirst then
self.PZXJEffectFirst=nil
local sortingLayer=helper.getSortingLayerID("Entity")
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildShowEffectEx(4,22650,sortingLayer,entCfg.sortOrder+1,true)
widget:SetChildScale(4,Vector3.New(1.5,1.5,1.5))
self.speedupEffectID_PZXJ=true
end
end


return xjTeamEntity
