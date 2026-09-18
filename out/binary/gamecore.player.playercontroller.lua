







local _MODULENAME="playerController"
gameState.addListener(def_table(_MODULENAME))
playerController.name=_MODULENAME

function playerController:onAppStart()
socketManager:register_receiver(0,1,playerController.do_protocol_0_1)
socketManager:register_receiver(0,2,playerController.do_protocol_0_2)
socketManager:register_receiver(254,42,playerController.onAttrChanged)

socketManager:register_receiver(254,31,self.onZongmenFightChanged)
socketManager:register_receiver(254,34,self.onWorldParamsChanged)


playerController.testModel=true
end

function playerController:onEnterState()
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
end

function playerController:onLeaveState()
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
playerModel:resetData()
end

function playerController:onLostConnection()


end

function playerController:onProtocolReq()
playerModel:onProtocolReq()
end

function playerController.onTestModelChange()
playerController.testModel=not playerController.testModel
notifySystem:postNotify(notifyConfig.onTestModelChange,playerController.testModel)
end


function playerController:onMinuteUpdate(delay)


playerController:requireHeartBeat(gameUtilityModel.getServerShortTime())
end



function playerController:requireHeartBeat(send_time)
socketManager:send_0_2(send_time)
end






function playerController.do_protocol_0_1(args)










timeHelper.setServerZone(args[9])
gameUtilityModel.init_BASE_TWO_SECOND(args[9])
local player=playerModel:InitNetData(args[1],args[2],args[3],args[4],args[5])
gameUtilityModel.initData(args[8],args[7])
gameUtilityModel.setServerPlatform(args[6])
gameUtilityModel.startOnlineTimer(args[10])
gameState:onPlayerCreate(player)

timeEventController.addMinuteTimerHandler(playerController.name,playerController)

notifySystem:postNotify(notifyConfig.onActorDataInit)

houtaiController:requestOptions2()
end


function playerController.do_protocol_0_2(server_time)

local diff=os.difftime(server_time,gameUtilityModel.getServerShortTime())

if diff~=0 then
gameUtilityModel.asyncServerTime(server_time)
end
end

function playerController.onZongmenFightChanged(fight64,pushtype,fight64Top15,fight64Top15History)
local fight=tonumber(tostring(fight64))
local oldVal=playerModel:getActorFightValue()
playerModel:setFight(fight)

local fightTop15=tonumber(tostring(fight64Top15))
local fightTop15History=mathHelper.int64_to_number(fight64Top15History)
local oldValTop15=playerModel:getActorTop15FightValue()
playerModel:setTop15Fight(fightTop15,fightTop15History)
fightUpRemindController.onZongmenTop15FightChanged(oldValTop15,fightTop15)
if pushtype~=2 then
fightUpRemindController.onZongmenFightChanged(oldVal,fight)
end
if fight~=oldVal then

notifySystem:postNotify(notifyConfig.onZongMenFightChange,oldVal,fight)
end
end

function playerController.onWorldParamsChanged(worldlv,jingjielv,liantilv,fight64,loyality)
local oldVal=playerModel:getActorFightValue()






homeBuffModel.setStableVal(loyality)







end

function playerController.onAttrChanged(len,array)
if len>0 then
for i,v in ipairs(array)do
if v.param_1==4 then
playerModel:setRecharge(tonumber(tostring(v.param_2)))
end
end
end
end










function playerController:setWidgetHeadKuang(widget,index,icon,animType,anim,isGray,animationId,stopAnim)

widget:SetChildUIModelEnableInitUISpinePara(index,false,true)
widget:SetChildQualityEffect(index,-1)

widget:SetChildUIModelRemoveTarget(index)

widget:SetChildCSImageIcon(index,"",false)

if animType and not isGray then

if animType==HeadKuangAnimType.eSequence then

widget:SetChildAnimationStringID(index,anim,false)
elseif animType==HeadKuangAnimType.eSpine then

local animId=animationId or eAnimationID.stand
widget:SetChildUIModelShowTarget(index,anim,1,{},animId,stopAnim)
end


widget:SetChildImageExGray(index,false)
else

local kuangStr=""
if icon and icon>0 then
kuangStr=iconHelper.getHeadKuangIcon(icon)
end
widget:SetChildIcon(index,kuangStr,false)

if isGray~=nil then
widget:SetChildImageExGray(index,isGray)
end
end
end

function playerController:setWidgetHeadKuangEx(widget,index,iconInfo,isGray,animationId,stopAnim)
iconInfo=iconInfo or playerModel:getActorIconInfo()
local kuangId,iconid=mathHelper.splitToInt16(iconInfo.actoricon)
local kuangIcon=playerModel:getActorFrameIconById(kuangId)
local kuangAnimType,kuangAnim=playerModel:getActorFrameAnimById(kuangId)
playerController:setWidgetHeadKuang(widget,index,kuangIcon,kuangAnimType,kuangAnim,isGray,animationId,stopAnim)
end


local _defualtIconInfo={actoricon=65537}

function playerController:checkIconInfo(iconInfo)
if iconInfo==nil then return end
if iconInfo.actoricon==0 and(iconInfo.piList==nil or#iconInfo.piList==0)then
return _defualtIconInfo
end
return iconInfo
end


function playerController:setWidgetHead96(widget,index,iconInfo,args)
iconInfo=playerController:checkIconInfo(iconInfo)or playerModel:getActorIconInfo()
local scale=0.6
local offsetX=0
local offsetY=-40
local ani=eAnimationID.idle
local actoricon=iconInfo.actoricon
local kuangId,iconid=mathHelper.splitToInt16(actoricon)
local playerImage=iconInfo.piList
local isdefault=cfgHelper.get2(cfg_headportraitconfig_get,iconid,'isdef')==1
local gray=args and args.gray or false
local enableFadeCompatible=args and args.enableFadeCompatible or false
widget:SetChildUIModelRemoveTarget(index)
if isdefault and playerImage~=nil and next(playerImage)~=nil then
local action=function()
widget:SetChildIcon(index,"",false)
widget:SetChildUIModelGray(index,gray)
end
playerImageController.setPlayerModel(widget,index,playerImage,scale,ani,offsetX,offsetY,false,action,enableFadeCompatible)
else
local headicon=playerModel:getActorIconById(iconid)
local iconname=iconHelper.getHeadIcon(headicon)
widget:SetChildIcon(index,iconname,false)
widget:SetChildImageExGray(index,gray)
end
if args and args.updateRendererSize then
widget:SetChildUIModelUpdateRendererSize(index,true)
end
end

function playerController:setWidgetRawImageHead(widget,iconIdx,rawimageIdx,iconInfo,gray)
iconInfo=playerController:checkIconInfo(iconInfo)or playerModel:getActorIconInfo()
local scale=1.2
local offsetX=0
local offsetY=0
local ani=eAnimationID.idle
local size=1
local centerType=eHeadCenterType.eHead

local actoricon=iconInfo.actoricon
local kuangId,iconid=mathHelper.splitToInt16(actoricon)
local playerImage=iconInfo.piList
local isdefault=cfgHelper.get2(cfg_headportraitconfig_get,iconid,'isdef')==1
if isdefault and playerImage~=nil and next(playerImage)~=nil then
widget:SetChildIcon(iconIdx,"",false)
widget:SetChildActive(rawimageIdx,true)
playerImageController.setPlayerRawImage(widget,rawimageIdx,playerImage,scale,ani,offsetX,offsetY,centerType,size,gray)
else
widget:SetChildActive(rawimageIdx,false)
local headicon=playerModel:getActorIconById(iconid)
local iconname=iconHelper.getHeadIcon(headicon)
widget:SetChildIcon(iconIdx,iconname,false)
end
end


function playerController:setWidgetBlueDiamond(widget,index,iconInfo,isGray)
iconInfo=iconInfo or playerModel:getActorIconInfo()

local info=playerModel.getBlueinfo(iconInfo.blueinfo)
if info.isBule and blueDiamondModel:isHasBlueDiamond()then
widget:SetChildActive(index,true)
local buleWidget=widget:GetChildWidgetBase(index)
local iconname=blueDiamondModel.getBuleDiamondIcon(info)
buleWidget:SetChildCSImageSprite(0,globalABLookup.bluediamondIcon,iconname)
if info.isYear then
buleWidget:SetChildCSImageSprite(1,globalABLookup.bluediamondIcon,"image_nian_1")
end
buleWidget:SetChildActive(1,info.isYear)
else
widget:SetChildActive(index,false)
end

end

HEAD_SCALE_TYPE=
{
e60x60=0.625,
e96x96=1,
}


function playerController:setHeadIcon(widget,index,args)
if args~=nil then
local iconInfo=playerController:checkIconInfo(args.iconInfo)or
playerModel:getActorIconInfo()
local scale=args.scale or 1
local gray=args.gray or false
local stopHeadKuangAnim=args.stopHeadKuangAnim or nil
local func=function(guid)
local _widget=widget:GetChildExpandUIEx(guid)
if _widget then
playerController:setWidgetHead96(_widget,1,iconInfo,args)
playerController:setWidgetHeadKuangEx(_widget,2,iconInfo,gray,nil,stopHeadKuangAnim)
playerController:setWidgetBlueDiamond(_widget,3,iconInfo,gray)
_widget:SetChildScale(0,Vector3(scale,scale,scale))
_widget:SetChildLocalPosition(-1,Vector3(0,0,0))
if args.blueDiamondPos then
_widget:SetChildLocalPosition(3,Vector3(args.blueDiamondPos[1],args.blueDiamondPos[2],0))
end
end
end
widget:SetChildCommonItemSign(index,INSTANCE_TYPE.eUIHeadItem,func)
else
widget:SetChildCommonItemSign(index,INSTANCE_TYPE.eUIHeadItem,nil)
end
end


function playerController:setRawImageHeadIcon(widget,index,args)
if args~=nil then
local iconInfo=playerController:checkIconInfo(args.iconInfo)or
playerModel:getActorIconInfo()
local scale=args.scale or 1
local gray=args.gray or false
local stopHeadKuangAnim=args.stopHeadKuangAnim or nil
local func=function(guid)
local _widget=widget:GetChildExpandUIEx(guid)
if _widget then
playerController:setWidgetRawImageHead(_widget,1,3,iconInfo,gray)
playerController:setWidgetHeadKuangEx(_widget,2,iconInfo,gray,nil,stopHeadKuangAnim)
playerController:setWidgetBlueDiamond(_widget,4,iconInfo,gray)
_widget:SetChildScale(0,Vector3(scale,scale,scale))
_widget:SetChildLocalPosition(-1,Vector3(0,0,0))
_widget:SetChildImageExGray(1,gray)
if args.blueDiamondPos then
_widget:SetChildLocalPosition(4,Vector3(args.blueDiamondPos[1],args.blueDiamondPos[2],0))
end
end
end
widget:SetChildCommonItemSign(index,INSTANCE_TYPE.eHeadRawImageItem,func)
else
widget:SetChildCommonItemSign(index,INSTANCE_TYPE.eHeadRawImageItem,nil)
end
end


function playerController:setImage(widget,index,sex,iconInfo,dynamic,scale,replace)
scale=scale or 1
local playerImage=iconInfo.piList or playerImageModel:getDefaultImage(sex)
if replace then
for i,v in pairs(replace)do
playerImage[i]=v
end
end
playerImageController.setPlayerModel(widget,index,playerImage,scale,eAnimationID.idle,0,0,dynamic)
end

function playerController:supportDynamic()
return deviceHelper.getAPILevel()>=11
end

function playerController.checkOpenCreatePlayerNameWin()
local check=playerModel:checkActorNameDefault()
if check==nil or check==false then return end

local taskId=cfgHelper.get3(cfg_noviciateconfig_get,'playerChangeNameTask','value',1)
local isFinish=taskModel:checkTaskFinish(taskId)
local taskData=taskModel:getTaskInfo(taskId)
local canCreate=isFinish or taskData and taskModel:getTaskState(taskData).state>=taskModel.taskFinishState

if canCreate then
if mainControl:isSceneType(eSceneType.eZongmen)then
msgWinControl:addMsgWin(msgWinType.ePlayerCreateName,nil,nil,true)
end
end
end


function playerController.onTaskChange(taskid,taskstate)
if taskid==cfgHelper.get3(cfg_noviciateconfig_get,'playerChangeNameTask','value',1)then
playerController:checkOpenCreatePlayerNameWin()
end
end

function playerController:onEnterScene(sceneType,first,firstScene)
if sceneType==eSceneType.eZongmen then
playerController:checkOpenCreatePlayerNameWin()
end
end
