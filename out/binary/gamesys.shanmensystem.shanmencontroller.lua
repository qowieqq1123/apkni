






local _MODULENAME="shanmenController"




gameState.addListener(def_table(_MODULENAME))
shanmenController.data={}
local initData=nil
local checkShanMenTeZhi=nil

function shanmenController:onAppStart()
shanmenModel:onAppStart()


socketManager:register_receiver(3,191,shanmenController.recv_3_191)
socketManager:register_receiver(3,192,shanmenController.recv_3_192)
socketManager:register_receiver(3,193,shanmenController.recv_3_193)
socketManager:register_receiver(3,194,shanmenController.recv_3_194)



end


function shanmenController:onEnterState(isReconnect)
shanmenModel:onEnterState(isReconnect)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onDisciplePosChange,self.onDisciplePosChange)
end


function shanmenController:onServerDataInitFinish()
shanmenModel:onServerDataInitFinish()
end


function shanmenController:onLeaveState(isReconnect)
initData=nil
checkShanMenTeZhi=nil
shanmenModel:onLeaveState(isReconnect)

self.data={}
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onDisciplePosChange,self.onDisciplePosChange)
end

function shanmenController:onProtocolReq()
if initData then
shanmenController.recv_3_191(initData)
initData=nil
end
end


function shanmenController:onLostConnection()

end

function shanmenController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
shanmenController:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
shanmenController:onLeaveHome()
end
end

function shanmenController.onDisciplePosChange(dis_guid,oldpost,post)
if oldpost==eZongMenPostType.eZhangMen or post==eZongMenPostType.eZhangMen then

shanmenModel:checkZMZhangMenTypeOptionEventNpcModel()
end
end

function shanmenController:onEnterHome()

if shanmenModel:checkHaveShanmen()then
shanmenModel:createBaiShanRole()

shanmenModel:createAllOptionEventNpcModel()
end
timeEventController.addNormalTimerHandler(1,'shanmenController',shanmenController)
end

function shanmenController:onLeaveHome()
shanmenModel:removeAllModel()

shanmenModel:removeAllOptionEventNpcModel()
shanmenModel:clearOptionEventNPCSpeakIntervalTimer()

timeEventController.removeNormalTimerHandler(1,'shanmenController')
notifySystem:postNotify(notifyConfig.onShanMenVisitChange,SHANMEN_TYPE.eBaiShan)
end

function shanmenController:onNormalUpdate(delay)
local curTime=gameUtilityModel.getServerShortTime()
local interval=shanmenModel.getBaiShanConfigField('interval')
local lastTime=shanmenModel:getLastBaiShanTime()
if lastTime and curTime>lastTime+interval then
local datas=shanmenModel:getBaiShanData()
local maxnum=shanmenModel.getBaiShanConfigField('maxnum')
if#datas<maxnum then
shanmenController:req_baishan_event()
end
end
end




function shanmenController:req_shanmen_data()
if shanmenModel:checkHaveShanmen()then
socketManager:send_3_191()
end
end


function shanmenController:req_baishan_event()
socketManager:send_3_192()
end



function shanmenController:req_banshai_success(discipleguid)
socketManager:send_3_193(discipleguid)
end



function shanmenController:req_banshai_fail(discipleguid)
socketManager:send_3_194(discipleguid)
end










function shanmenController.recv_3_191(args)
local lastsec=args[1]
local baishanlistlen=args[2]
local baishanList=args[3]
local daily=args[4]
local shield=args[5]
local guilderLen=args[6]
local guilderList=args[7]

if initProControl.isDone()then
shanmenModel:setLastBaiShanTime(lastsec)
shanmenModel:initBaiShanData(baishanlistlen,baishanList)
if shanmenModel:checkHaveShanmen()then
shanmenModel:createBaiShanRole()
end


if baishanlistlen>0 and not checkShanMenTeZhi then
for k,v in ipairs(baishanList)do
local len=1
local type=addSpeType.mountain
local data=baishanList[k]
local index=k
TeZhiTuJianModel:checkIsHaveSpeCanActive(data,type,len,index)
end
end
checkShanMenTeZhi=true
else
initData=args
end

shanMenDaZhenModel:setShanMenDaZhenShieldValue(shield)
shanMenDaZhenModel:setShanMenDaZhenTeamDiziList(guilderLen,guilderList)

UIManager:invokeUIMethod('UIShanMenDaZhen_mainWin','refresh')


shanMenDaZhenController:refreshDaZhenHUD()


shanMenDaZhenController:refreshWorldDaZhenEffectShow()

notifySystem:postNotify(notifyConfig.onShanMenDaZhenInitData)


guildOrderController:checkAddAI_delay(GUILD_ORDER_TYPE.eAutoBaiShan,1.2,true)
end





function shanmenController.recv_3_192(lastsec,baishanlistlen,baishanList)
shanmenModel:setLastBaiShanTime(lastsec)
if baishanlistlen>0 then
for i,v in ipairs(baishanList)do
UIDiscipleModel:addDiscipleDataTemp(v)
end


local oldData=shanmenModel:getBaiShanData()
local oldLen=#oldData

shanmenModel:addBaiShanData(baishanList)


for k,v in ipairs(baishanList)do
local len=1
local type=addSpeType.mountain
local data=baishanList[k]
local index=k+oldLen
TeZhiTuJianModel:checkIsHaveSpeCanActive(data,type,len,index)
end


local mesg=FMT.fmt(cfg_lang_get('shanmen_dizi_tips_1'),gameUtilityModel.getGameYear())
local msgType=chatConfig.getLangMsgType('shanmen_dizi_tips_1')
chatControl.reqSystemMesg(msgType,{CHAT_CHANNNEL.eSystem},mesg)
local args={
iconName='icon_zmzt_3',
title='弟子拜山',
content=shanmenModel.getBaiShanConfigField('chatstr'),
time=shanmenModel.getBaiShanConfigField('showtime'),
callback=function(isClick)
if isClick then
shanmenController:playSMAnim(SHANMEN_TYPE.eBaiShan)
end
end,
}

msgWinControl:addMsgWin(msgWinType.eTopEventWin,args)

notifySystem:postNotify(notifyConfig.onShanMenVisitChange,SHANMEN_TYPE.eBaiShan)


guildOrderController:checkAddAI_delay(GUILD_ORDER_TYPE.eAutoBaiShan,1.2,true)
end


eventOptionControl:showEventDialogue()
end

function shanmenController:playSMAnim(showType)
local func=function(...)





if showType==SHANMEN_TYPE.eOptionEvent then
local pos=shanmenModel:getFirstOptionEventNPCPos()
if pos then
local weakGuideId=3560
weakGuideController:beginGuide(weakGuideId,pos)
end
elseif showType==SHANMEN_TYPE.eBaiShan then
local pos=shanmenModel:getFirstBaiShanDzPos()
if pos then
local weakGuideId=3561
weakGuideController:beginGuide(weakGuideId,pos)
end
end
end

local cameraTargetPosList=shanmenModel.getShanmenOptionConfigField('cameraTargetPos')
local cameraTargetPos
if cameraTargetPosList and showType then
cameraTargetPos=cameraTargetPosList[showType]
end

if cameraTargetPos then
local cp=_MapManager.ToVector3Int(cameraTargetPos[1],cameraTargetPos[2],0)
local pos=_MapManager.GetCellCenterWorld(mapIdType.zhufeng,cp,mapLayer.Data)
isometricMapSystem:moveCameraToPositionEx(mapIdType.zhufeng,pos,true,func)
else

local bdType=shanmenModel.getBaiShanConfigField('buildid')
local smData=zongmenModel:findBuildingDataByType(zongmenModel:getMountainId(),bdType)
isometricMapSystem:moveCameraToObjectEx(smData.entityId,true,func)
end

end




function shanmenController.recv_3_193(discipleguid,lastsec)
shanmenModel:setLastBaiShanTime(lastsec)
shanmenModel:removeBaiShanModel(discipleguid,true)
shanmenModel:setBaiShanState(discipleguid,1)



UIManager:invokeUIMethod('UIShanMenBaiShanNewWin','refreshState',discipleguid)
UIManager:invokeUIMethod('UIShanMenBaiShanNewWin','toNext',0)
UIManager:invokeUIMethod('UIShanMenBaiShanNewWin','refreshDZItem',discipleguid)

eventOptionControl:showEventDialogue()
notifySystem:postNotify(notifyConfig.onShanMenVisitChange,SHANMEN_TYPE.eBaiShan)
end




function shanmenController.recv_3_194(discipleguid,lastsec)
shanmenModel:setLastBaiShanTime(lastsec)
shanmenModel:changeModel(SHANMEN_TYPE.eBaiShan,discipleguid)
shanmenModel:playSMDzBehaviour(discipleguid,shanmenTreeType.eBaiShanFail)
shanmenModel:setBaiShanState(discipleguid,-1)



UIManager:invokeUIMethod('UIShanMenBaiShanNewWin','refreshState',discipleguid)
UIManager:invokeUIMethod('UIShanMenBaiShanNewWin','toNext',0)
UIManager:invokeUIMethod('UIShanMenBaiShanNewWin','refreshDZItem',discipleguid)

eventOptionControl:showEventDialogue()
notifySystem:postNotify(notifyConfig.onShanMenVisitChange,SHANMEN_TYPE.eBaiShan)
end




function shanmenController:showBaiShanWin(guid)
if not isometricMapSystem:isInNormalMode()then

return
end

local dzId=shanmenModel:getBsDiscipleguidByGuid(guid)
if dzId then
UIManager:showWindow('UIShanMenBaiShanNewWin',dzId)
end
end

function shanmenController:showBaiShanWinByDZID(dzId)
UIManager:showWindow('UIShanMenBaiShanNewWin',dzId)
end

function shanmenController:showOpenEventWinByEventGuid(eventGuid)
if eventOptionModel.getShowOptionEventResultIsOpening()then

return
end

if not shanmenModel:checkOptionEventNPCCanClick(eventGuid)then

return
end


local args=eventOptionModel.getOpenEventWinParamByEventGuid(eventGuid)
local eventGuidStr=tostring(eventGuid)
local callbackFunc=function()
eventLocalOptionModel.setOptionEventNpcWatchedStartStory(true,eventGuidStr)
UIManager:showWindow('UIEventOptionSelectWin',args)
shanmenModel:checkOptionEventNpcChangeFinishStartModelByEventGuid(eventGuid)
end


local isWatched=false
local localNpcData=eventLocalOptionModel.getOptionEventNpcData(eventGuidStr)
if localNpcData and localNpcData.isWatchedStartStory then
isWatched=localNpcData.isWatchedStartStory
end

if not isWatched and args and args.startStoryId then

local storyId=args.startStoryId
local npcData=args.npcData
local eventguid=eventGuid
local storyArgs={

npcData=npcData,
eventguid=eventguid,


}

worldStoryController:showStoryTree(storyId,callbackFunc,nil,nil,storyArgs)
else

callbackFunc()
end
end

function shanmenController:changeShanMenModelShow(isShow)
if isShow==nil then
isShow=false
end
shanmenModel:changeOptionEventNpcShow(isShow)
shanmenModel:changeBaiShanDzShow(isShow)
xiangongpingdingController:changeRoleShow(isShow)
zmvisitchallengeController:changeZmVisitorModelShow(isShow)
shanmenModel:setIsShanMenModelHide(not isShow)


UIManager:callWindowFunc('UIFuncStorageWin','refreshShiWuBtn')
end
