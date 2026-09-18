









local xjNotHandleTeamEntity={}


function xjNotHandleTeamEntity:onSpeedUp()


self:refreshTeam()
end

function xjNotHandleTeamEntity:setMoveEase(ease)
self.moveEase=ease
end

function xjNotHandleTeamEntity:clearMoveEase()
self.moveEase=nil
end

function xjNotHandleTeamEntity:getSpeedMulti()
return 1
end

function xjNotHandleTeamEntity:getSpeedCnt()
return 1
end


function xjNotHandleTeamEntity:checkLOD()
local sceneidx=self:getTeamSceneIndex()
if xianjieModel:checkSceneIndex(sceneidx)then
return true
end
return false
end


function xjNotHandleTeamEntity:onCreateWidget(widget)

self:refreshTeam(widget,true)
end

function xjNotHandleTeamEntity:initModel(widget)

if not self.showModel then
self.showModel=true


local modelId=self.teamModelId
local modelScale=self.teamModelScale or 1
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams(1)
widget:SetChildActive(1,true)
widget:SetChildSceneEntityCreateModel(0,modelId,{},'Entity',entCfg.sortOrder,modelScale,nil,false)

widget:SetChildSceneEntityAddBoxCollider(0,Vector2.New(4.5,2.5),Vector2.zero,boxParams,helper.LAYER_ACTOR)
if deviceHelper.getAPILevel()>=352 then
widget:SetChildSceneEntitySetShaderRenderQueue(0,3000,8)
end

if self.isHideModel then
widget:SetChildActive(1,false)
end
end
end

function xjNotHandleTeamEntity:clearModel(widget)
self:clearTweener()
if self.showModel then
self.showModel=nil
widget:SetChildSceneEntityRemoveModel(0)
end
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),0)
widget:SetChildRotation(1,0,0,0)
self:clearSpeedupEffect(widget)
end

function xjNotHandleTeamEntity:refreshModel(widget)
widget=widget or self:getWidget()
if self.showModel then
self.showModel=true


local modelId=self.teamModelId
local modelScale=self.teamModelScale or 1
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams(1)

widget:SetChildSceneEntityRemoveModel(0)
widget:SetChildSceneEntityCreateModel(0,modelId,{},'Entity',entCfg.sortOrder,modelScale,nil,false)

widget:SetChildSceneEntityAddBoxCollider(0,Vector2.New(4.5,2.5),Vector2.zero,boxParams,helper.LAYER_ACTOR)
if deviceHelper.getAPILevel()>=352 then
widget:SetChildSceneEntitySetShaderRenderQueue(0,3000,8)
end

local atkSize,atkOffset
local moveTagIndex=xianjieController:getMoveTagListIndex(self.moveTagList)
local sceneidx_,cpos,lerp_time_,spos,epos,speed_,isLast,sPos2,ePos2=xianjieController:getMoveTagLerpMovePos(self.moveTagList,moveTagIndex,nil,atkSize,atkOffset)
local stateID,flipX,flipY,realAngle,normalAngel=xianjieModel.getMarchTeamModelState(sPos2,ePos2)
widget:SetChildSceneEntityPlayAnimation(0,stateID,1,nil)
widget:SetChildSceneEntityFlipXY(0,flipX,flipY)






end
end

function xjNotHandleTeamEntity:clearSpeedupEffect(widget)
if self.speedupEffectID then
self.speedupEffectID=nil
widget:SetChildShowEffect(2,0,false)
end
end

function xjNotHandleTeamEntity:refreshTeam(widget,isInit)
widget=widget or self:getWidget()
if widget==nil then return end


local moveTagIndex=xianjieController:getMoveTagListIndex(self.moveTagList)
local tag=self.moveTagList[moveTagIndex]
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

local atkSize,atkOffset
local sceneidx_,cpos,lerp_time_,spos,epos,speed_,isLast,sPos2,ePos2=xianjieController:getMoveTagLerpMovePos(self.moveTagList,moveTagIndex,nil,atkSize,atkOffset)

widget:SetChildActive(1,true)
widget:SetChildPosition(1,cpos)
local stateID,flipX,flipY,realAngle,normalAngel=xianjieModel.getMarchTeamModelState(sPos2,ePos2)
widget:SetChildSceneEntityPlayAnimation(0,stateID,1,nil)
widget:SetChildSceneEntityFlipXY(0,flipX,flipY)

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

if isInit then
if not self.isHideModel and not self.fightMark then

local boxParams2=self:handleBoxParams(2)
local enemyTypo=xjEnemyType.eSelf
if xianjieController.curlodLevel<=xianjieController.hideOtherLineLOD or enemyTypo~=xjEnemyType.eStranger then
self:drawMyLines(speed,boxParams2)
end
end
else
if changeSpeed then
if self:hasLine()then
self:setLinesSpeed(speed)
end
end
end
end

function xjNotHandleTeamEntity:checkLine()
if self.inAOI_mark and not self.fightMark then
if self.isHideModel or not self.isShowLine or xianjieController.curlodLevel>xianjieController.hideOtherLineLOD then
if self:hasLine()then
local enemyTypo=xjEnemyType.eSelf
if self.isHideModel or not self.isShowLine or enemyTypo==xjEnemyType.eStranger then
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



function xjNotHandleTeamEntity:onRemoveWidget(widget)
if self.isShowLine then
self:setIsShowLine(nil)
self:checkLine()
end
self:clearModel(widget)
xianjieModel:leaveSceneState(xjSceneStateType.eClickLine)
end

function xjNotHandleTeamEntity:clearTweener()
if self.moveTweener~=nil then


self.moveTweener:Kill()
self.moveTweener=nil
end
end


function xjNotHandleTeamEntity:onMyClick(boxParams,clickPos)
local widget=self:getWidget()
if widget==nil then return end
local typo=boxParams[1]
if typo==1 then

local clickEntKey=self:getKey()
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey)
else

local flag,spos,epos,cpos=xianjieController:getMovePathClickPos(self.movePath,clickPos)
if flag then
xianjieController:lookAtPosition(cpos,nil,0.2,nil,DG.Tweening.Ease.Linear)
local clickEntKey=self:getKey()
xianjieModel:enterSceneState(xjSceneStateType.eClickLine,clickEntKey,spos,epos,cpos)
end
end
end


function xjNotHandleTeamEntity:onUpdate()
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

function xjNotHandleTeamEntity:getTeamSceneIndex()
local moveTagIndex=xianjieController:getMoveTagListIndex(self.moveTagList)
local tag=self.moveTagList[moveTagIndex]
if tag then
return tag[3]
end
end

function xjNotHandleTeamEntity:getTeamPos()
local moveTagIndex=xianjieController:getMoveTagListIndex(self.moveTagList)
local atkSize,atkOffset
local sceneidx,cpos=xianjieController:getMoveTagLerpMovePos(self.moveTagList,moveTagIndex,true,atkSize,atkOffset)
return sceneidx,cpos
end

function xjNotHandleTeamEntity:getTeamPosStart()
local tag=self.moveTagList[1]
local sceneidx=tag[3]
local spos=tag[1]
return sceneidx,spos
end

function xjNotHandleTeamEntity:getTeamPosEnd()
local tag=self.moveTagList[#self.moveTagList]
local sceneidx=tag[3]
local epos=tag[2]
return sceneidx,epos
end


function xjNotHandleTeamEntity:standbyFight()
self.fightMark=true
local widget=self:getWidget()
if widget then
self:clearSpeedupEffect(widget)
self:removeMyLines(true)
end
end

function xjNotHandleTeamEntity:getLineColor()
local enemyType=self.enemyType
if enemyType==xjEnemyType.eSelf then
return sceneLineType.eGreenArrow
elseif enemyType==xjEnemyType.eAllies then
return sceneLineType.eBlueArrow
elseif enemyType==xjEnemyType.eEnemy then
return sceneLineType.eRedArrow
elseif enemyType==xjEnemyType.eStranger then
return sceneLineType.eGrayArrow
end
end

function xjNotHandleTeamEntity:drawMyLines(speed,boxParams)
if not self.isShowLine then
return
end

self:removeMyLines(false)
local prefabType=self:getLineColor()
local layer=helper.LAYER_ACTOR
self:addLineImp(prefabType,layer,speed,boxParams)
end

function xjNotHandleTeamEntity:addLineImp(prefabType,layer,speed,boxParams)

local enemyTypo=self.enemyType

if enemyTypo==xjEnemyType.eSelf or enemyTypo==xjEnemyType.eAllies then
xianjieController.lineRealCount=xianjieController.lineRealCount+1
self:drawPosListToLines(prefabType,nil,speed,layer,boxParams)
else
if xianjieController.lineRealCount>xianjieController.maxShowLine then

xianjieController.lineDrawCache[self]={self,speed,boxParams}
else
xianjieController.lineRealCount=xianjieController.lineRealCount+1
self:drawPosListToLines(prefabType,nil,speed,layer,boxParams)
end
end
end

function xjNotHandleTeamEntity:setIsShowLine(isShowLine)
self.isShowLine=isShowLine
end

return xjNotHandleTeamEntity