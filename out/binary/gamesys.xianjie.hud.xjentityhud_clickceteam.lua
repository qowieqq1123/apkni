









local xjEntityHud_clickCETeam={}
local poslp={
[1]={
{-138,-2},
},
[2]={
{-138,-2},{148,-2},
},
[3]={
{-104,92},{-104,-97},{114,92},
},
[4]={
{-104,92},{-104,-97},{114,92},{116,-97},
},
[5]={
{-104,92},{-138,-2},{-104,-97},{114,92},{148,-2}
},
[6]={
{-104,92},{-138,-2},{-104,-97},{114,92},{148,-2},{116,-97},
},
}
local _this

function xjEntityHud_clickCETeam:onInit()
self.needFollow=true
end


function xjEntityHud_clickCETeam:onCreateWidget(widget)

local ent=xianjieController:getEntity(self.m_key)
if ent then


end
local trans=ent:getHudBindingTransform()
xianjieController:setFollowTarget(trans)
_this=self

widget:SetChildCanvasGroupAlpha(6,1)

local enemyType=ent.enemyType
local btns={}

widget:SetChildButtonClick(0,function()
self:onBeginClick()
end)
btns[#btns+1]={0}


local isShowDetailBtn=true
widget:SetChildActive(1,isShowDetailBtn)
if isShowDetailBtn then
widget:SetChildButtonClick(1,function()
self:onDetailClick()
end)
btns[#btns+1]={1}
end


widget:SetChildButtonClick(2,function()
self:onEndClick()
end)
btns[#btns+1]={2}


local isShowChallengeBtn=enemyType~=xjEnemyType.eSelf and enemyType~=xjEnemyType.eAllies
widget:SetChildActive(3,isShowChallengeBtn)
if isShowChallengeBtn then
widget:SetChildButtonClick(3,function()
self:onChallengeClick()
end)
btns[#btns+1]={3}
end







local lp=poslp[4]
for i,v in ipairs(btns)do
v[2]=lp[v[1]+1]
end
if not self.showAnim then
self.showAnim=true
for i,v in ipairs(btns)do
local pos=v[2]
widget:SetChildAnchoredPos(v[1],0,0)
widget:SetChildDOAnchorPos(v[1],Vector3.New(pos[1],pos[2]),0.25,nil)
end
else
for i,v in ipairs(btns)do
local pos=v[2]
widget:SetChildAnchoredPos(v[1],pos[1],pos[2])
end
end


local name=self:getOwnerName()
local name_str=xianjieModel.getColorStrByEnemyType(enemyType,name)
widget:SetChildText(5,name_str)

self:refreshTime(widget)
end

function xjEntityHud_clickCETeam:refreshTime(widget)
local ent=xianjieController:getEntity(self.m_key)
local endTime=ent and ent.endTime or nil
local nowTime=timeHelper.getServerShortTime()
local lerpTime=endTime and endTime-nowTime or 0
if lerpTime<0 then
lerpTime=0
end
lerpTime=math.ceil(lerpTime)
local time_str=timeHelper.format_time_stamp(lerpTime,true)
widget:SetChildText(4,time_str)
end


function xjEntityHud_clickCETeam:onRemoveWidget(widget)
local ent=xianjieController:getEntity(self.m_key)
if ent then


end

xianjieController:removeFollowTarget()

xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)
_this=nil
end


function xjEntityHud_clickCETeam:onUpdate()
local widget=self:getWidget()
if widget then
self:refreshTime(widget)
end
end

function xjEntityHud_clickCETeam:onBeginClick()
if not self:checkWidget()then return end
local clickEntKey=self.m_key

xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)

local sceneidx,spos=xianjieController:invokeEntityFunc(clickEntKey,'getTeamPosStart')
if xianjieModel:checkSceneIndex(sceneidx)then
xianjieController:lookAtPosition(spos,nil,0.2,nil,DG.Tweening.Ease.Linear)
else
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local func=function()
xianjieController:lookAtPosition(spos,nil,0.2,nil,DG.Tweening.Ease.Linear)
end
xianjieController:jumpXianJie(sceneType,nil,func)
end
end

function xjEntityHud_clickCETeam:onDetailClick()
if not self:checkWidget()then return end
local ent=xianjieController:getEntity(self.m_key)
local guidStr=ent.guidStr
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
local guid=shipData and shipData.xianzhouStruct and shipData.xianzhouStruct.xianzhou_guid

local showType=2
xianjieController:openXJCaravanEscortShipMsgWin(showType,guid,nil,false)


end

function xjEntityHud_clickCETeam:onChallengeClick()
if not self:checkWidget()then return end
local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if not isActDoing then
UIManager.error("不在活动开启时间内，无法掠夺")
return
end
local ent=xianjieController:getEntity(self.m_key)
local guidStr=ent.guidStr
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
local shipGuid=shipData and shipData.xianzhouStruct and shipData.xianzhouStruct.xianzhou_guid
local nowTime=timeHelper.getServerShortTime()
local endTime
local startTime
local isExpire=false








if shipData then
local shipBaseData=shipData.xianzhouStruct


local isSelfXm=false
local selfHasXM=xianmengModel:hasXM()
local xmData=shipData.guildInfo
if xmData then
local xmGuid=xmData.param_1
isSelfXm=selfHasXM and xianmengModel:isMyXM(xmGuid)or false
end
if isSelfXm then
UIManager.error("同仙盟仙舟，无法掠夺")
return
end

local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)

local maxBeRobbedTimes=baseCfg.be_robbed_times
local curRobbedTimes=shipBaseData.robbed_times
if curRobbedTimes>=maxBeRobbedTimes then
UIManager.error("该仙舟可掠夺次数不足，无法掠夺")
return
end


local selfEscortData=xianJieCaravanEscortModel:getSelfEscortData()
local maxRobNum=baseCfg and baseCfg.rob_times or 0
local curRobNum=selfEscortData and selfEscortData.robTimes or 0
if curRobNum>=maxRobNum then
UIManager.error("已达掠夺次数上限")
return
end

local shipId=shipBaseData.xianzhou_id

local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
startTime=shipBaseData.start_sec or 0
endTime=startTime+duration
isExpire=startTime>0 and nowTime>=endTime or false
end
if isExpire then
UIManager.error("该仙舟已完成护送，无法掠夺")
return
end
end


local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local mapId=baseCfg.map_id
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
xianJieCaravanEscortModel:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end
local defTeamList={}
local detailData=xianJieCaravanEscortModel:getShipTeamDetailDataByGuid(shipGuid)
local defDzList=detailData and detailData.dzList
if defDzList then
for i,netData in ipairs(defDzList)do
local has=netData~=nil and(netData.flag==nil or netData.flag>0)
if has then
defTeamList[i]={guid=netData.discipleguid,typo=fightEntityType.diZi,netData=netData,}
end
end
end

local flag=0
local winArgs={
enterTxt='掠夺队伍',
mapId=mapId,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,
monsterListEx=defTeamList,
enterCallBack=function(selectList,zfId,mapId)
local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if not isActDoing then
UIManager.error("不在活动开启时间内，无法掠夺")
return
end

local nowTime=timeHelper.getServerShortTime()
local isExpire=startTime>0 and nowTime>=endTime or false
if isExpire then

return UIManager:invokeUIMethod("UIFightPrepareWin","onCloseFunc")
end

fightLaunchController:sendFight(eBattleLaunch.xjCaravanEscort,selectList,mapId,zfId,{shipGuid,flag})
end,
cancelCallBack=function()
fightController:closeSelectStage()
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
if entityData then
local getEntityDataFunc=function()
return xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
end
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
else

local shipNowSceneIdx,pos=entityData:getTeamPos()
if shipNowSceneIdx then
local nowSceneIdx=xianjieModel:getSceneIndex()
if nowSceneIdx~=shipNowSceneIdx then
local sceneType=xianjieModel:sceneIndex2SceneType(shipNowSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
end
end)
end
end
end
end
end,
}






fightController.showPrepareWin(fightPreSelectModel.fightType.xjCaravanEscortAtkTeam,winArgs)


xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)
end

function xjEntityHud_clickCETeam:onEndClick()
if not self:checkWidget()then return end
local clickEntKey=self.m_key

xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)

local sceneidx,epos=xianjieController:invokeEntityFunc(clickEntKey,'getTeamPosEnd')
if xianjieModel:checkSceneIndex(sceneidx)then
xianjieController:lookAtPosition(epos,nil,0.2,nil,DG.Tweening.Ease.Linear)
else
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local func=function()
xianjieController:lookAtPosition(epos,nil,0.2,nil,DG.Tweening.Ease.Linear)
end
xianjieController:jumpXianJie(sceneType,nil,func)
end
end


function xjEntityHud_clickCETeam:onDelete()

end

function xjEntityHud_clickCETeam:getOwnerName()
local ent=xianjieController:getEntity(self.m_key)
local guidStr=ent.guidStr
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)
if shipData and shipData.name then
return shipData.name
end
return'佚名'
end

return xjEntityHud_clickCETeam