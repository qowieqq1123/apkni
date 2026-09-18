






local _MODULENAME="jiuchongtianjieGuideController"

gameState.addListener(def_table(_MODULENAME))
jiuchongtianjieGuideController.name=_MODULENAME
jiuchongtianjieGuideController.data={}


local _guidActorListReqInterval=60


function jiuchongtianjieGuideController:onAppStart()

jiuchongtianjieGuideModel:onAppStart()

socketManager:register_receiver(34,151,self.recv_34_151)
socketManager:register_receiver(34,152,self.recv_34_152)
socketManager:register_receiver(34,153,self.recv_34_153)
socketManager:register_receiver(34,154,self.recv_34_154)
socketManager:register_receiver(34,155,self.recv_34_155)
socketManager:register_receiver(34,156,self.recv_34_156)
socketManager:register_receiver(34,157,self.recv_34_157)


end


function jiuchongtianjieGuideController:onEnterState(isReconnect)
jiuchongtianjieGuideModel:onEnterState()

notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.enterXianJie,self.enterXianJie)
notifySystem:listenNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
end


function jiuchongtianjieGuideController:onProtocolReq()
jiuchongtianjieGuideModel:onProtocolReq()

jiuchongtianjieGuideController:checkShowSuccessWin()
end


function jiuchongtianjieGuideController:onLeaveState(isReconnect)
jiuchongtianjieGuideModel:onLeaveState(isReconnect)

self.data={}

notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.enterXianJie,self.enterXianJie)
notifySystem:removelistener(notifyConfig.onXianMengChange,self.onXianMengChange)
end


function jiuchongtianjieGuideController:onLostConnection()

end


function jiuchongtianjieGuideController:onReConnection(isInitPro)

end




function jiuchongtianjieGuideController:req_xjGuideActorList()
socketManager:send_34_152()
end



function jiuchongtianjieGuideController:req_xjGuideAsk(actorId)
socketManager:send_34_153(actorId)
end


function jiuchongtianjieGuideController:req_xjGuideAskConfirm()
socketManager:send_34_154()
end


function jiuchongtianjieGuideController:req_xjGuideHelpList()
socketManager:send_34_155()
end


function jiuchongtianjieGuideController:req_xjGuideSupport(actorId)
socketManager:send_34_156(actorId)
end


function jiuchongtianjieGuideController:req_xjGuideRecv()
socketManager:send_34_157()
end




function jiuchongtianjieGuideController.recv_34_151(args)

local guideLen=args[1]
local guideList=args[2]or{}
local view=args[3]==1
local recv=args[4]==1
local askLen=args[5]
local askList=args[6]or{}
local helpLen=args[7]
local helpList=args[8]

jiuchongtianjieGuideModel:setInitData(guideLen,guideList,view,recv,askLen,askList,helpLen,helpList)

jiuchongtianjieGuideController:freshXianJieJieYinInfo()
end


function jiuchongtianjieGuideController.recv_34_152(guideLen,guideList)
jiuchongtianjieGuideModel:setGuideActorInfo(guideLen,guideList)
end


function jiuchongtianjieGuideController.recv_34_153(actorId,ret)
if ret==1 then
UIManager.info("今日已求助对方")
return
elseif ret==2 then
UIManager.info("对方本周已援助")
jiuchongtianjieGuideModel:removeCurrentShowGuidActor(actorId)
return
elseif ret==0 then
jiuchongtianjieGuideModel:addAskActor(actorId)
JiuChongTianJieEnterController:refreshReddot(notifyConfig.onJctjProgressChange)
end
end


function jiuchongtianjieGuideController.recv_34_154()
jiuchongtianjieGuideModel:changeViewState(true)
notifySystem:postNotify(notifyConfig.onJctjProgressChange)
end


function jiuchongtianjieGuideController.recv_34_155(helpLen,helpList)
jiuchongtianjieGuideModel:setDetailHelpList(helpLen,helpList)

jiuchongtianjieGuideController:freshXianJieJieYinInfo()
end


function jiuchongtianjieGuideController.recv_34_156(actorId,ret)
if ret==1 then
UIManager.info("对方已得到援助")
jiuchongtianjieGuideModel:removeHelpActor(actorId)
return
elseif ret==2 then
UIManager.info("对方天魔劫已完成")
jiuchongtianjieGuideModel:removeHelpActor(actorId)
return
elseif ret==0 then
UIManager.info("援助成功")
jiuchongtianjieGuideModel:changeHelpActorHelpState(actorId)
UIManager:invokeUIMethod("UIXianJieJieYin_SupportWin",'refreshAll')


end
end

function jiuchongtianjieGuideController.recv_34_157()
jiuchongtianjieGuideModel:changeRecvState(true)

jiuchongtianjieGuideController:freshXianJieJieYinInfo()
end


function jiuchongtianjieGuideController:checkReqXjGuideActorList()
local list,len,reqStamp=jiuchongtianjieGuideModel:getGuideActorList()
local curTime=timeHelper.getServerShortTime()

if len<=0 and(curTime-reqStamp>_guidActorListReqInterval)then
xianmengController:reqXMDataDetail()
self:req_xjGuideActorList()
end
end

function jiuchongtianjieGuideController:checkHasSupportActor()
local list,len=jiuchongtianjieGuideModel:getGuideList()
return len>0
end

function jiuchongtianjieGuideController:checkAskedActor(actorId)
local list,len=jiuchongtianjieGuideModel:getAskList()

for index,askedActorId in ipairs(list)do
if mathHelper.compareInt64(askedActorId,actorId)then
return true
end
end

return false
end

function jiuchongtianjieGuideController:checkIsCanPlayJieYinSucess()
local viewState=jiuchongtianjieGuideModel:getViewState()
local hasSupportActor=jiuchongtianjieGuideController:checkHasSupportActor()
local subSys=JiuChongTianJieEnterModel:getSubSysClass(JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie)
local isFinish=subSys:checkFinish()


return(not viewState)and hasSupportActor and(not isFinish)
end

function jiuchongtianjieGuideController:checkShowAskEnter()
if not jiuchongtianjieGuideController.isOpen()then
return false
end

local jyCfg=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eXianJieJieYin)
local subSys=JiuChongTianJieEnterModel:getSubSysClass(JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie)
local isFinish=subSys:checkFinish()
local isLock=systemModel.isOpen(jyCfg.sysid)

local selectFunc=function(data)
return data.jingjielv>=90
end
local dzList=UIDiscipleModel:getSortList(selectFunc)
local hasDz=#dzList>0




return(isLock and hasDz)or jiuchongtianjieGuideModel:getViewState()
end

function jiuchongtianjieGuideController:checkHasAskCount()
local list,len=jiuchongtianjieGuideModel:getAskList()
local askCount=jiuchongtianjieGuideController:getDayAskCount()
return askCount>len
end

function jiuchongtianjieGuideController:checkShowSuccessWin()
local state=jiuchongtianjieGuideController:checkIsCanPlayJieYinSucess()

if state then
msgWinControl:addMsgWin(msgWinType.eXianJieJieYinAskSuccess,{},{},true)
end
end


function jiuchongtianjieGuideController:getAskReddot()

local isShowEnter=jiuchongtianjieGuideController:checkShowAskEnter()
if not isShowEnter then return false end

local isView=jiuchongtianjieGuideModel:getViewState()
local hasCount=jiuchongtianjieGuideController:checkHasAskCount()
local isCanPlayJieYin=jiuchongtianjieGuideController:checkIsCanPlayJieYinSucess()
local subSys=JiuChongTianJieEnterModel:getSubSysClass(JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie)
local isFinish=subSys:checkFinish()

if isFinish then
return false
end

return((not isView)and hasCount)or isCanPlayJieYin
end


function jiuchongtianjieGuideController:getSupportedCount()
local list,len=jiuchongtianjieGuideModel:getHelpList()
local count=0
if len>0 then
for index,data in ipairs(list)do
if data.param_2==1 then
count=count+1
end
end
end
return count
end

function jiuchongtianjieGuideController:checkIsCanReceiveSupportRewad()
local isSupported=jiuchongtianjieGuideController:checkFinishSupportedActor()
local recv=jiuchongtianjieGuideModel:getRecvState()
return isSupported and(not recv)
end

function jiuchongtianjieGuideController:checkHasHelpActor()
local list,len=jiuchongtianjieGuideModel:getHelpList()
return len>0
end

function jiuchongtianjieGuideController:checkHasCanSupportActor()
local list,len=jiuchongtianjieGuideModel:getHelpList()
local canHelpCount=jiuchongtianjieGuideController:getDaySupportCount()
local curHelpCount=0
if len>0 then
for index,data in ipairs(list)do
if data.param_2==1 then
curHelpCount=curHelpCount+1
end
end
end
return canHelpCount>curHelpCount and len>curHelpCount
end

function jiuchongtianjieGuideController:checkFinishSupportedActor()
local list,len=jiuchongtianjieGuideModel:getHelpList()
local canHelpCount=jiuchongtianjieGuideController:getDaySupportCount()
local curHelpCount=0
if len>0 then
for index,data in ipairs(list)do
if data.param_2==1 then
curHelpCount=curHelpCount+1
end
end
end
return curHelpCount>=canHelpCount
end

function jiuchongtianjieGuideController:checkSupportActor(actorId)
local list,len=jiuchongtianjieGuideModel:getHelpList()
if len>0 then
for index,data in ipairs(list)do
if mathHelper.compareInt64(data.param_1,actorId)then
return data.param_2==1
end
end
end
return false
end

function jiuchongtianjieGuideController:checkShowSupportEnter()
if not jiuchongtianjieGuideController.isOpen()then
return false
end

if not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
return false
end


local isFinishCJXYTask_1=seasonController:checkSeasonStageEndedForce(0,1)
if not isFinishCJXYTask_1 then
return false
end


local isUnLockXianYuEnter=systemModel.isOpen(SYSTEM_DEFINE.eXianYuEnter)
if not isUnLockXianYuEnter then
return false
end


local isCanReceive=jiuchongtianjieGuideController:checkIsCanReceiveSupportRewad()
local hasCanAskActor=jiuchongtianjieGuideController:checkHasCanSupportActor()

return hasCanAskActor or isCanReceive
end

function jiuchongtianjieGuideController:freshXianJieJieYinInfo()







self:freshFuncStorageBtn()
end

function jiuchongtianjieGuideController:freshFuncStorageBtn()
UIManager:invokeUIMethod("UIFuncStorageWin","refreshXianJieJieYinBtn")
UIManager:invokeUIMethod("UIXianJieFuncStorageWin","refreshFuncButton","JieYin")
end

function jiuchongtianjieGuideController:playSupportPlot(key,pos,effectid)
key=key or"guideffect"
effectid=effectid or 22623
pos=pos or{-1.2,3,-48.19}
local initData={
pos=pos,
key=key,
effectid=effectid,
}
xianjieStoryAIManager:startStoryBehavior("xj_xianjiejieyin",initData,function()
jiuchongtianjieGuideController:freshXianJieJieYinInfo()
UIManager:showWindow("UIXianJieJieYin_SupportWin")
end)
end

function jiuchongtianjieGuideController:checkHasSupportCount()
local len=jiuchongtianjieGuideController:getSupportedCount()
local supportCount=jiuchongtianjieGuideController:getDaySupportCount()
return supportCount>len
end


function jiuchongtianjieGuideController:getSupportReddot()
local isShowEnter=jiuchongtianjieGuideController:checkShowSupportEnter()
if not isShowEnter then return false end

local isRecv=jiuchongtianjieGuideModel:getRecvState()


local isCanReceive=jiuchongtianjieGuideController:checkIsCanReceiveSupportRewad()
local helpNewFlag=jiuchongtianjieGuideModel:getHelpNewFlag()



return(not isRecv)and(isCanReceive or helpNewFlag)
end



function jiuchongtianjieGuideController:checkFirstReqHelpList()
if not jiuchongtianjieGuideController.isOpen()then
return
end

if not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
return
end

jiuchongtianjieGuideController:req_xjGuideHelpList()
end



function jiuchongtianjieGuideController.onNewDay()
if not jiuchongtianjieGuideController.isOpen()then
return
end

jiuchongtianjieGuideModel:resetAskList()


end

function jiuchongtianjieGuideController.onNewWeek()
if not jiuchongtianjieGuideController.isOpen()then
return
end
jiuchongtianjieGuideModel:changeRecvState(false)

jiuchongtianjieGuideModel:resetHelpList()
jiuchongtianjieGuideController:freshXianJieJieYinInfo()
end

function jiuchongtianjieGuideController.on_home_event(etype)
if not jiuchongtianjieGuideController.isOpen()then
return
end
if etype==homeEvent.eEnterHome then
jiuchongtianjieGuideController:checkShowSuccessWin()
end
end

function jiuchongtianjieGuideController.enterXianJie(sceneType)
if not jiuchongtianjieGuideController.isOpen()then
return
end

if xianjienSceneType.eXianJie==sceneType then
jiuchongtianjieGuideController:freshXianJieJieYinInfo()
end
end

function jiuchongtianjieGuideController.onXianMengChange()
if not jiuchongtianjieGuideController.isOpen()then
return
end
jiuchongtianjieGuideModel:changeGuideListDirty()
jiuchongtianjieGuideModel:changeHelpListDirty()
end


function jiuchongtianjieGuideController:getDayAskCount()
local guide=cfgHelper.get2(cfg_jctjbaseconfig_get,1,'guide')
return guide[1]
end

function jiuchongtianjieGuideController:getDaySupportCount()
local guide=cfgHelper.get2(cfg_jctjbaseconfig_get,1,'guide')
return guide[2]
end

function jiuchongtianjieGuideController:getSupportReward()
local guide=cfgHelper.get2(cfg_jctjbaseconfig_get,1,'guide')
return guide[3]
end


function jiuchongtianjieGuideController.isOpen()
return true
end


local _fixEntPos={-1.2,0.5,-52.19}
function jiuchongtianjieGuideController:removeHud()
if self.data.entkey then
xianjieController:removeEntity(self.data.entkey)
end
end

function jiuchongtianjieGuideController:checkFreshXianJieJieYinHud()
if mainControl:isSceneType(eSceneType.eXianJie)then
local curSceneType=xianjieModel:getScenceType()or-1
if curSceneType==xianjienSceneType.eXianJie then
self:removeHud()
self.data.entkey=xianjieController:addEntity(XJ_ENTITY_TYPE.eJieYin,{pos=_fixEntPos},true)
end
end
end

function jiuchongtianjieGuideController:jumpLookAtHud()
local enterCallBack=function()
jiuchongtianjieGuideController:lookAtHud()
end
if mainControl:isSceneType(eSceneType.eXianJie)then
local curSceneType=xianjieModel:getScenceType()or-1
if curSceneType==xianjienSceneType.eXianJie then
enterCallBack()
else
xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,enterCallBack)
end
else
xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,enterCallBack)
end
end

function jiuchongtianjieGuideController:jumpLookAtHudShowDialouge()
local enterCallBack=function()
xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,function()
jiuchongtianjieGuideController:lookAtHud()
UIManager:showWindow("UIXianJieJieYin_SupportWin")
end)
end

local dialougeFunc=function()
local showdata=
{
type='UIDialouge',
title='提示',
content='是否前往仙界进行飞升接引?',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function()
enterCallBack()
end,
showclosebtn=true,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()
end
if mainControl:isSceneType(eSceneType.eXianJie)then
local curSceneType=xianjieModel:getScenceType()or-1
if curSceneType==xianjienSceneType.eXianJie then
jiuchongtianjieGuideController:lookAtHud()
UIManager:showWindow("UIXianJieJieYin_SupportWin")
else
dialougeFunc()
end
else
dialougeFunc()
end
end

function jiuchongtianjieGuideController:lookAtHud()
local pos=Vector3(_fixEntPos[1],_fixEntPos[2],_fixEntPos[3])
xianjieController:lookAtPosition(pos,nil,0.2,nil,DG.Tweening.Ease.InQuint,nil)
end


