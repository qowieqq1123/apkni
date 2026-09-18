






local _MODULENAME="zmvisitchallengeController"

gameState.addListener(def_table(_MODULENAME))
zmvisitchallengeController.name=_MODULENAME
zmvisitchallengeController.data={}

function zmvisitchallengeController:onAppStart()

zmvisitchallengeModel:onAppStart()

socketManager:register_receiver(25,30,self.recv_25_30)
socketManager:register_receiver(25,31,self.recv_25_31)
socketManager:register_receiver(25,32,self.recv_25_32)


end


function zmvisitchallengeController:onEnterState(isReconnect)
zmvisitchallengeModel:onEnterState()

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDayFiveAm)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.building_event,self.onZongMengLevelChange)
end


function zmvisitchallengeController:onProtocolReq()
zmvisitchallengeModel:onProtocolReq()
end


function zmvisitchallengeController:onLeaveState(isReconnect)
zmvisitchallengeModel:onLeaveState(isReconnect)

self.data={}

notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDayFiveAm)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.building_event,self.onZongMengLevelChange)
end


function zmvisitchallengeController:onLostConnection()

end


function zmvisitchallengeController:onReConnection(isInitPro)

end


function zmvisitchallengeController:req_25_31()
socketManager:send_25_31()
end

function zmvisitchallengeController:req_25_32()
socketManager:send_25_32()
end

function zmvisitchallengeController.recv_25_30(challenge_id,max_pass_id,recv_flag,refresh_sec)


if challenge_id>0 then
local data={
challengeid=challenge_id,
maxPassId=max_pass_id,
recvFlag=recv_flag,
freshStamp=refresh_sec
}
zmvisitchallengeModel:setChallengeData(data)
end

zmvisitchallengeModel:checkNeedReqChallengeOpen()


zmvisitchallengeModel:refreshCheckReddot()
end

function zmvisitchallengeController.recv_25_31(reward_flag)
zmvisitchallengeModel:setBigRewardFlag()
UIManager:invokeUIMethod('UIZongMenVisitorChallengeMainWin',"refreshRewardPart")
zmvisitchallengeController:freshVisitorHud()
zmvisitchallengeModel:refreshCheckReddot()
end

function zmvisitchallengeController.recv_25_32(challenge_id)
local data={
challengeid=challenge_id,
maxPassId=0,
recvFlag=0,
freshStamp=timeHelper.getServerShortTime()
}

zmvisitchallengeModel:setChallengeData(data)
zmvisitchallengeController:onEnterHome()
zmvisitchallengeModel:refreshCheckReddot()
end


function zmvisitchallengeController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
zmvisitchallengeController:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
zmvisitchallengeController:onLeaveHome()
end
end

function zmvisitchallengeController.onNewDayFiveAm(islogin)
if not islogin then
if systemModel.isOpen(SYSTEM_DEFINE.eVisitor)then
local isFinish=zmvisitchallengeModel:checkFinishAllLevel()
if isFinish then
local callback=function()
zmvisitchallengeModel:checkNeedReqChallengeOpen()
end

local visitor=zmvisitchallengeModel:getVisitor()
if visitor then
zmvisitchallengeController:showEndByChallengeId(false,callback)
else
callback()
end
end
end
end
end

function zmvisitchallengeController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eVisitor then
zmvisitchallengeModel:checkNeedReqChallengeOpen()
end
end

function zmvisitchallengeController.onZongMengLevelChange(type,level,exp,lastlv)
if type==buildingEvent.zongmenLevelUp and level~=lastlv then
zmvisitchallengeModel:checkNeedReqChallengeOpen()
end
end



function zmvisitchallengeController:showPrepareWin(challenge_id,level_id)

if zmvisitchallengeModel:checkChallengeFinishByLevelId(level_id)then
return
end

local name=cfgHelper.get2(cfg_visitorchallengeconfig_get,challenge_id,'name')

local levelCfg=cfgHelper.get2(cfg_visitorchallengelayerconfig_get,challenge_id,level_id)
local groupID=levelCfg.mon_id
local monsterList=cfgHelper.get2(cfg_monstergroup_get,groupID,'monList')
local view_fight=levelCfg.view_fight

local layerTxt=FMT.fmt('第{0}关',level_id)


local faZeList2Args={}

local layerfzlist=levelCfg.fazelist
local len=#layerfzlist
local newfaze=len>0
if len>0 then
for i=1,len do
local fzId=layerfzlist[i][1]
local fzlv=layerfzlist[i][2]
local fzRuleCfg=cfgHelper.getSSlawRule(fzId)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local fzdesc=not hasParam and fzRuleCfg.desc or
string.format(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
faZeList2Args[#faZeList2Args+1]={name=fzRuleCfg.name,icon=fzRuleCfg.image,desc=fzdesc}
end
end

local extraWin='UIFightPrepareZMVCConditionWin'
local extraParams={challenge_id=challenge_id,level_id=level_id}


local winArgs=
{
enterTxt=name,
groupId=groupID,
monsterList=monsterList,
showZhenFa=false,
skipShouYuanCheck=true,
monsterFight=view_fight,
skipDiscipleStateCheck=true,


place=layerTxt,
statePriorityCheck=false,

closeByCloud=true,
closeByCloudDelay=1,
extraWin=extraWin,
extraParams=extraParams,
cancelCallBack=function()

UIFullZMVisitChallengeControl:showZMVisitChallengeWin()

zmvisitchallengeModel:setInFight(false)
end,
enterCallBack=function(teamList,zfId)
local mapId=cfgHelper.get2(cfg_monstergroup_get,groupID,"mapId")
local fightKey=fightLaunchController:sendFight(eBattleLaunch.visitorChallenge,teamList,mapId or 0,zfId or 0)
self.fightKey=fightKey
end,
}
zmvisitchallengeModel:setInFight(true)
local fightType=fightPreSelectModel.fightType.visitorChallenge
fightController.showPrepareWin(fightType,winArgs,nil,true)
end

function zmvisitchallengeController:enterFightScene()
return false
end


function zmvisitchallengeController:createEntity(mapId,challengeid)


if not isometricMapSystem:IsInHome()then return end

if not systemModel.isOpen(SYSTEM_DEFINE.eVisitor)then return end

if zmvisitchallengeModel:checkFinishAllLevel()and zmvisitchallengeModel:getBigRewardFlag()==1 then
return
end

if challengeid==0 then
return
end

local visitorCfg=cfgHelper.get1(cfg_visitorchallengeconfig_get,challengeid)
local npcid=visitorCfg.npcid
local imagecfg=npcModel:getNPCImageCfg(npcid)
local image=npcModel:getImageInfoOutSide(imagecfg.id,2)
if image then
local bodyid=image.body
local componets=image.componets
local scale=isometricMapSystem:getModelScale(bodyid)or 1
local pos=visitorCfg.visitorpos or{-6,-48}
local x=pos[1]
local y=pos[2]
pos=_MapManager.ToVector3Int(x,y,0)
local guid=isometricMapSystem:createRoleEntity(objectType.eChallengeVisitor,mapId,0,bodyid,componets,SortingLayers.ITBuilding,scale,pos)
if not isometricMapSystem:isInNormalMode()then

_MapManager.SetObjectDisplay(objectType.eChallengeVisitor,false)
end

local offset=_MapManager.GetObjectHeadOffset(guid)
local hud=hudControl:addHUD(INSTANCE_TYPE.eChallengeVisitor,guid,offset,true,true,function(id)
zmvisitchallengeController:freshVisitorHud(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(1,function()
if zmvisitchallengeModel:checkFirstClickNpc(challengeid)then

zmvisitchallengeController:showStartByChallengeId(challengeid)
zmvisitchallengeController:freshVisitorHud(id)
else
UIFullZMVisitChallengeControl:showZMVisitChallengeWin()
end
end)
end)
local hideColor=Color.New(1,1,1,0)
_MapManager.SetFadeToColor(guid,hideColor,0,nil)
local target=Color.New(1,1,1,1)
local duration=1
_MapManager.SetFadeToColor(guid,target,duration,nil)

local bt=nil
zmvisitchallengeModel:setVisitor(mapId,guid,bt,hud,challengeid)
else
logErr(FMT.fmt("缺少npc：{0} 配置",npcid))
end
end

function zmvisitchallengeController:showStartByChallengeId(challenge_id)
if not zmvisitchallengeModel:checkFirstClickNpc(challenge_id)then return end

local challengeBaseCfg=cfgHelper.get1(cfg_visitorchallengeconfig_get,challenge_id)

local startCallBack=function()
zmvisitchallengeController:showOpenSelectWin(challenge_id)
end

if challengeBaseCfg.startstoryid~=nil then
self:startStory(challengeBaseCfg.startstoryid,challenge_id,startCallBack)
else
startCallBack()
end

self.data.inShowFisrtClick=true
end

function zmvisitchallengeController:showEndByChallengeId(isShowStory,callback)
if self.data.inShowEndClick then return end

local challenge_id=zmvisitchallengeModel:getOpenChallengeId()
local challengeBaseCfg=cfgHelper.get1(cfg_visitorchallengeconfig_get,challenge_id)
local visitor=zmvisitchallengeModel:getVisitor()
if visitor.entHud then
hudControl:removeHUD(visitor.entHud)
end


local removeFunc=function()
if visitor then
local target=Color.New(1,1,1,0)

_MapManager.SetFadeToColor(visitor.entGuid,target,1,function()
if visitor.entGuid then
_MapManager.RemoveTilemapObject(visitor.entGuid)
zmvisitchallengeModel:resetVisitor()
end
if callback then
callback()
end
end)
end
end

local endCallBack=function()
if visitor then
local guid=visitor.entGuid
local targetPos=_MapManager.ToVector3Int(-8,-50,0)
_MapManager.RunAnimator(guid,eAnimationID.run)
_MapManager.MoveToPosition(guid,targetPos,removeFunc,nil,2,-1)
else
if callback then
callback()
end
end
end

if challengeBaseCfg.endstoryid~=nil and isShowStory then
self:startStory(challengeBaseCfg.endstoryid,challenge_id,endCallBack)
else
endCallBack()
end

self.data.inShowEndClick=true
end

function zmvisitchallengeController:startStory(startstory_id,challenge_id,callback)

local challengeBaseCfg=cfgHelper.get1(cfg_visitorchallengeconfig_get,challenge_id)

local npcId=challengeBaseCfg.npcId or 205
local npcData=npcModel:getImageInfoOutSide(npcId)

local storyArgs={
npcData=npcData,
}
worldStoryController:showStoryTree(startstory_id,callback,nil,nil,storyArgs)
end

function zmvisitchallengeController:showOpenSelectWin(challenge_id)
local challengeBaseCfg=cfgHelper.get1(cfg_visitorchallengeconfig_get,challenge_id)

local btnList={
{

name=challengeBaseCfg.optionnamelist[1],
icon="",
click=function()
zmvisitchallengeModel:setVisitorChallengeState(challenge_id)
UIFullZMVisitChallengeControl:showZMVisitChallengeWin()
zmvisitchallengeModel:refreshCheckReddot()
end
},
}


local args={
content=challengeBaseCfg.content,
btnList=btnList,
name=challengeBaseCfg.name,
isEnd=true,
icon=challengeBaseCfg.eventicon,
}

UIManager:showWindow('UIVisitorChallengeOptionSelectWin',args)
end

function zmvisitchallengeController:onEnterHome()
local challengeId=zmvisitchallengeModel:getOpenChallengeId()
zmvisitchallengeController:createEntity(mapIdType.zhufeng,challengeId)
end

function zmvisitchallengeController:onLeaveHome()








end

function zmvisitchallengeController:freshVisitorHud(hud)
local challengeid=zmvisitchallengeModel:getOpenChallengeId()
local visitor=zmvisitchallengeModel:getVisitor()
hud=hud or visitor.entHud

local widget=hudControl:getHUDWidget(hud)

if zmvisitchallengeModel:checkFirstClickNpc(challengeid)then
widget:SetChildCSImageSprite(0,globalABLookup.global,'icon_sjgantanhao')
elseif zmvisitchallengeModel:checkFinishAllLevel()and zmvisitchallengeModel:getBigRewardFlag()==0 then
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,'icon_fangshigx')
else
widget:SetChildCSImageSprite(0,globalABLookup.global,'icon_sjgantanhao')
end

end

function zmvisitchallengeController:setSpeakContent(bt)
local level=bt:getSharedVar('level')
local challengeid=zmvisitchallengeModel:getOpenChallengeId()
local speakContentOption=cfgHelper.get3(cfg_visitorchallengelayerconfig_get,challengeid,level,'monsterspeaklist')
local randomIndex=Mathf.Random(1,#speakContentOption)
local content=speakContentOption[randomIndex][1]
bt:setSharedVar('speakContent',content)
end

function zmvisitchallengeController:changeZmVisitorModelShow(isShow)
local visitor=zmvisitchallengeModel:getVisitor()
if visitor then
local hudId=visitor.entHud
if hudId then
local hudWidget=hudControl:getHUDWidget(hudId)
hudWidget:SetChildActive(-1,isShow)
end

local guid=visitor.entGuid
if guid then
local npcEntity=_EntityManager:GetEntity(guid)

npcEntity:SetVisible(isShow)
end
end

end