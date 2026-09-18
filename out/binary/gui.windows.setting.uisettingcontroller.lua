







UISettingController=gameState.addListener({})

local kuangType=KUANGE_TYPE
local unlockType=KUANGE_UNLOCK_TYPE
local kuangHideType=KUANGE_HIDE_TYPE

local _init
local openCreateNameTaskid=nil


local jumpKuangTabType={
[kuangType.head]=SEC_FULL_TAB_TYPE.head,
[kuangType.headKuang]=SEC_FULL_TAB_TYPE.headkuang,
[kuangType.chatKuang]=SEC_FULL_TAB_TYPE.chatkuang,
[kuangType.zongmen]=SEC_FULL_TAB_TYPE.eSetting_ZongMen,
[kuangType.feijian]=SEC_FULL_TAB_TYPE.eSetting_FeiJian,
[kuangType.yunzhou]=SEC_FULL_TAB_TYPE.eSetting_YunZhou,
}

function UISettingController:onAppStart()
socketManager:register_receiver(254,13,UISettingController.recv_254_13)
socketManager:register_receiver(254,14,UISettingController.recv_254_14)
socketManager:register_receiver(254,15,UISettingController.recv_254_15)
socketManager:register_receiver(254,135,UISettingController.recv_254_135)


socketManager:register_receiver(254,18,UISettingController.recv_254_18)
socketManager:register_receiver(254,19,UISettingController.recv_254_19)

socketManager:register_receiver(254,128,UISettingController.recv_254_128)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
UISettingModel:on_app_start()

notifySystem:listenNotify(notifyConfig.loadActorSetting,self.setFrame)
notifySystem:listenNotify(notifyConfig.initPro,self.setSystemTestData)
end

function UISettingController:onEnterState()
UISettingModel:on_enter_state()

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
UISettingController:clearHeadExpireTimer()
end

function UISettingController:onLeaveState()
UISettingModel:on_leave_state()
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:removelistener(notifyConfig.loadActorSetting,self.setFrame)

notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onRankListRefresh,self.onRankListRefresh)
UISettingController:clearHeadExpireTimer()
end


function UISettingController.onNewDay()

local config=UISettingModel:getWinNameConfig()
if config then
for k,win in ipairs(config)do

local winName=win[1]
UIManager:invokeUIMethod(winName,'refreshTestWin')
end
end
end

function UISettingController:onProtocolReq()
UISettingModel:initHeadCfg()
UISettingModel:initChatKuangCfg()
UISettingModel:initRedDotShowcase()
openCreateNameTaskid=cfgHelper.get3(cfg_noviciateconfig_get,"zmChangeNameTask","value",1)

if systemModel.isOpen(SYSTEM_DEFINE.eZongMengSuit)then
rankListController:req_rankList_data(eRankListType.eDuJieFeiSheng)
end
if systemModel.isOpen(SYSTEM_DEFINE.eTeamShowcase)then
UISettingController.req_get_team_254_128()
end
end


function UISettingController.onNewDay5am()

local dataList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eTestTagData,"systemTestData",{})

if dataList then
for k,v in pairs(dataList)do

v.submitCount=0
v.sendTime=timeHelper.getServerLongTime()
end
UISettingModel:setTestDataList(dataList)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eTestTagData,'systemTestData',dataList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eTestTagData)
end
UIManager:invokeUIMethod("UITestTagBtnWin",'refreshData')
local config=UISettingModel:getWinNameConfig()
if config then
for k,win in ipairs(config)do
UIManager:invokeUIMethod(win,'refreshTestWin')
end
end
end


function UISettingController.setSystemTestData()
local dataList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eTestTagData,"systemTestData",{})

UISettingModel:setTestDataList(dataList)
end


function UISettingController.setFrame()
local frame=userActorSetting.get('setFrame',nil)
if frame then
gameHelper.setFrame(frame)
end
end

function UISettingController:onReConnection()
timeEventController.delayDo(1,function()
UISettingController:checkOpenCreateZMNameWin()
end)
end


function UISettingController:onLostConnection()
UISettingController:clearHeadExpireTimer()
end

function UISettingController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
UISettingController:onEnterHome()
end
end

function UISettingController:onEnterHome()
if not _init then
_init=true

end
end

function UISettingController.checkOpenCreateZMNameWin()
local zmName=UISettingModel:getZMName()
if zmName~=''then
return
end
local taskId=openCreateNameTaskid
local isFinish=taskModel:checkTaskFinish(taskId)
local taskData=taskModel:getTaskInfo(taskId)
local canCreate=isFinish or taskData and taskModel:getTaskState(taskData).state>=taskModel.taskRewardState

if canCreate then
if mainControl:isSceneType(eSceneType.eZongmen)then
msgWinControl:addMsgWin(msgWinType.eZMCreateName,nil,nil,true)
end
end
end


function UISettingController.onTaskChange(taskid,taskstate)
if taskid==openCreateNameTaskid then
UISettingController:checkOpenCreateZMNameWin()
end
end

function UISettingController:onEnterScene(sceneType,first,firstScene)
if sceneType==eSceneType.eZongmen then
UISettingController:checkOpenCreateZMNameWin()
end
end


function UISettingController:req_setting_data()
socketManager:send_254_13()
end


function UISettingController:reqUseKuang(typo,id)
socketManager:send_254_14(typo,id)
end


function UISettingController:req_unlock(typo,id,idx)
socketManager:send_254_15(typo,id,idx or 0)
end


function UISettingController:req_upStar(typo,id)
socketManager:send_254_135(typo,id)
end












function UISettingController:req_change_zongmen_name(str,suffix)
socketManager:send_254_18(str,suffix)
end


function UISettingController:req_change_actor_name(str,isNotice)
socketManager:send_254_19(str,isNotice)
end


function UISettingController:req_cdkey_reward(cdkeylist)

local len=#cdkeylist
socketManager:send_254_50(len,cdkeylist,0)
end


function UISettingController.recv_254_13(array)
local headid=array[1]
local kuangid=array[2]
local headLen=array[3]
local headArray=array[4]
local kuangLen=array[5]
local kuangArray=array[6]
local zmName=array[7]
local zmName_changecnt=array[8]
local actorName_changecnt=array[9]
local chatkuangid=array[10]
local chatkuanglen=array[11]
local chatkuangArray=array[12]
local settingLen=array[13]
local settingList=array[14]
UISettingModel:setZMName(zmName)
UISettingModel:setZMNameChangeCnt(zmName_changecnt)
UISettingModel:setActorNameChangeCnt(actorName_changecnt)
UISettingModel:init_head_data(headid,headLen,headArray)
UISettingModel:init_head_kuang_data(kuangid,kuangLen,kuangArray)
UISettingModel:initChatKuangData(chatkuangid,chatkuanglen,chatkuangArray)
UISettingModel:initSettingData(settingLen,settingList)

notifySystem:postNotify(notifyConfig.onSettingDataInit)

local headEndTime=UISettingModel:isExpireHeadType(kuangType.head,headid)
local headKuangEndTime=UISettingModel:isExpireHeadType(kuangType.headKuang,kuangid)
if headEndTime~=-1 or headKuangEndTime~=-1 then

UISettingController:setHeadExpireTimer()
end
end



function UISettingController.recv_254_14(typo,id)
if UISettingModel:getChangeWithExpireMarkByKuangType(typo)then

UISettingModel:setChangeWithExpireMark(typo,nil)
else

UIManager.info('使用成功')
end
if typo==kuangType.head or typo==kuangType.headKuang then
if typo==kuangType.head then
UISettingModel:set_cur_head(id)
else
UISettingModel:set_cur_head_kuang(id)
end
local win1=UIManager:findActiveWindow('UIHeadSelectWin')
if win1 then
win1:refreshCurData(true)
win1:refreshCurInfo()
win1:refreshScrollerView()
end

local win2=UIManager:findActiveWindow('UIPlayerInfoWin')
if win2 then
win2:refreshHead()
end

notifySystem:postNotify(notifyConfig.onActorHeadChange)

if UISettingModel:isExpireHeadType(typo,id)~=-1 then

UISettingController:setHeadExpireTimer()
end
elseif typo==kuangType.chatKuang then
UISettingModel:setCurrentChatKuang(id)
UIManager:callWindowFunc('UIChatKuangSettingWin','onKuangUseChanged',id)
elseif typo==kuangType.zongmen then
UISettingModel:setSettingId(typo,id)
xianjieModel:refreshMyZongMenData("sectdress",id)
UIManager:callWindowFunc('UISettingZongMenSelectWin','onSettingUseChanged',id)
elseif typo==kuangType.feijian then
UISettingModel:setSettingId(typo,id)
UIManager:callWindowFunc('UISettingFeiJianSelectWin','onSettingUseChanged',id)
elseif typo==kuangType.yunzhou then
UISettingModel:setSettingId(typo,id)
UIManager:callWindowFunc('UISettingYunZhouSelectWin','onSettingUseChanged',id)
UIManager:callWindowFunc('UIXianJie_YunZhouPrepareWin','refreshYZModel')
end
end


function UISettingController.recv_254_15(typo,id,idx,expiresec)
local isSingleUse=false
local isAutoUse=false
local useDesc=""
if typo==kuangType.head or typo==kuangType.headKuang then
local isActive=false
if UISettingModel:isUnlockHead(typo,id)then
local typeStr=""
if typo==kuangType.head then
typeStr="头像"
elseif typo==kuangType.headKuang then
typeStr="头像框"
end

UIManager.info(FMT.fmt("{0}时限已延长",typeStr))
else

UIManager.info('解锁成功')
isActive=true
end
UISettingModel:add_unlock_data(typo,id,expiresec)


local kuangCfg=cfgHelper.get1(cfg_headportraitframeconfig_get,id)
if isActive and typo==kuangType.headKuang then
if kuangCfg and kuangCfg.jumps then
isSingleUse=true
UISettingController:showHeadTangCuangWin(id,typo,expiresec)
end
end
if kuangCfg and kuangCfg.attr or kuangCfg.jzattr then
UISettingController.jzAttrChange(typo,id)
end
elseif typo==kuangType.chatKuang then
local isActive=false
local unlock=UISettingModel:isChatKuangUnlock(id)
UISettingModel:add_unlock_data(typo,id,expiresec)
UIManager:callWindowFunc('UIChatKuangSettingWin','onKuangUnlock',id)
if unlock then
UIManager.info("气泡框时限已延长")
else
local cfg=cfgHelper.get1(cfg_bubbleframeconfig_get,id)
isAutoUse=true
useDesc=FMT.fmt("是否使用<color=#ca631d>{0}</color>气泡框？",cfg.name)
UIManager.info('解锁成功')
isActive=true
end

local kuangCfg=cfg_bubbleframeconfig_get(id)
if isActive then
if kuangCfg and kuangCfg.jumps then
isSingleUse=true
UISettingController:showHeadTangCuangWin(id,typo,expiresec)
end
end
if kuangCfg and kuangCfg.attr or kuangCfg.jzattr then
UISettingController.jzAttrChange(typo,id)
end

elseif typo==kuangType.zongmen then
UISettingModel:add_unlock_data(typo,id,expiresec)
UIManager:callWindowFunc('UISettingZongMenSelectWin','onSettingUnlock',id)
UIManager.info('解锁成功')
UISettingController.jzAttrChange(typo,id)
elseif typo==kuangType.feijian then
UISettingModel:add_unlock_data(typo,id,expiresec)
UIManager:callWindowFunc('UISettingFeiJianSelectWin','onSettingUnlock',id)
UIManager.info('解锁成功')
elseif typo==kuangType.yunzhou then
UISettingModel:add_unlock_data(typo,id,expiresec)
UIManager:callWindowFunc('UISettingYunZhouSelectWin','onSettingUnlock',id)
UIManager.info('解锁成功')
UISettingController.jzAttrChange(typo,id)
end


if typo==kuangType.head then
if id~=UISettingModel:get_cur_head()then

local cfg=cfgHelper.get1(cfg_headportraitconfig_get,id)
isAutoUse=true
useDesc=FMT.fmt("是否使用<color=#ca631d>{0}</color>头像？",cfg.name)
end
elseif typo==kuangType.headKuang then
if id~=UISettingModel:get_cur_head_kuang()then

local cfg=cfgHelper.get1(cfg_headportraitframeconfig_get,id)
isAutoUse=true
useDesc=FMT.fmt("是否使用<color=#ca631d>{0}</color>头像框？",cfg.name)
end
end
if isSingleUse then
UISettingController:reqUseKuang(typo,id)
else
if isAutoUse then
local show_data={
type='UIDialouge',
title='提示',
content=useDesc,
oktext='使用',
canceltext='取消',
okcallback=function()
UISettingController:reqUseKuang(typo,id)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

local win=UIManager:findActiveWindow('UIHeadSelectWin')
if win then
win:refreshCurInfo()
win:refreshScrollerView()
end
end
end

reddotControl.on_change_catch_type(CATCH_TYPE.eSetingTypeChange)
end


function UISettingController.recv_254_135(typo,id,star)
if typo==kuangType.zongmen then
UISettingModel:up_star_data(typo,id,star)
UIManager:callWindowFunc('UISettingZongMenSelectWin','onSettingUnlock',id)
UISettingController.jzAttrChange(typo,id)
elseif typo==kuangType.yunzhou then
UISettingModel:up_star_data(typo,id,star)
UIManager:callWindowFunc('UISettingYunZhouSelectWin','onSettingUnlock',id)
UISettingController.jzAttrChange(typo,id)
end

UIManager:showWindow("UISettingUpStarSuccessWin",{typo,id,star-1,star})
UIManager:callWindowFunc('UISettingUpStarWin','freshPanel')
reddotControl.on_change_catch_type(CATCH_TYPE.eSetingTypeChange)
end












function UISettingController.recv_254_18(name,ret)
if ret==0 then
if UISettingModel:getFirstZongMenNameState()then
UIManager.info('赋名成功')
UISettingModel:saveFirstZongMenNameState(false)
else
UIManager.info('修改成功')
end

AudioManager.playAudio(586)
UISettingModel:setZMName(name)
UISettingModel:setZMNameChangeCnt()
UIManager:callWindowFunc('UIPlayerInfoWin','refreshZMName')
UIManager:callWindowFunc('UIChangeZMNameWin','closeSelf')
UIManager:callWindowFunc('UICreateZMNameWin','closeSelf')

notifySystem:postNotify(notifyConfig.onZongMenNameChange)
else
if ret==-1 then
UIManager.error('名字中含有敏感字符')
elseif ret==-13 then
UIManager.error('请输入中文名称')
end
end
end



















function UISettingController.recv_254_19(name,ret)
if ret==0 then
UIManager.info('修改成功')
playerModel:setActorName(name)
UISettingModel:setActorNameChangeCnt()
UIManager:callWindowFunc('UIPlayerInfoWin','refreshPlayerName')
UIManager:callWindowFunc('UIChangePlayerNameWin','closeSelf')

notifySystem:postNotify(notifyConfig.onActorNameChange)
else
local s=UICreateRoleModel.getCreateRoleError(ret)
if s~=nil then
UIManager.error(s)
end
end
end


function UISettingController.req_get_team_254_128()
socketManager:send_254_128(2,0,defaultT)
end


function UISettingController.req_set_team_254_128(discipleList)
socketManager:send_254_128(1,#discipleList,discipleList)
end

function UISettingController.recv_254_128(len,discipleList)
UISettingModel:setShowcaseTeamList(discipleList)
UIManager:invokeUIMethod("UISettingWin","freshTeamList")
end


function UISettingController:setHeadExpireTimer()
self:clearHeadExpireTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local headId=UISettingModel:get_cur_head()
local kuangId=UISettingModel:get_cur_head_kuang()
local expireType=nil

local headEndTime=UISettingModel:isExpireHeadType(kuangType.head,headId)or 0
local headKuangEndTime=UISettingModel:isExpireHeadType(kuangType.headKuang,kuangId)or 0

if headEndTime==-1 and headKuangEndTime==-1 then

self:clearHeadExpireTimer()
else

local expireTime=nil
local otherExpireTime=-1
if headEndTime==-1 then

expireType=kuangType.headKuang
expireTime=headKuangEndTime
elseif headKuangEndTime==-1 then

expireType=kuangType.head
expireTime=headEndTime
else

if headEndTime<=headKuangEndTime then
expireType=kuangType.head
expireTime=headEndTime
otherExpireTime=headKuangEndTime
else
expireType=kuangType.headKuang
expireTime=headKuangEndTime
otherExpireTime=headEndTime
end
end

local lerp=expireTime and expireTime-nowTime or 0
if lerp<=0 then

if otherExpireTime==-1 then

self:clearHeadExpireTimer()
end

local removeId=expireType==kuangType.head and headId or kuangId
UISettingModel:remove_unlock_data(expireType,removeId)

local newId=UISettingModel:getUnExpireHeadId(expireType)


UISettingModel:setChangeWithExpireMark(expireType,true)
UISettingController:reqUseKuang(expireType,newId)
UISettingModel:setExperienceListData(expireType,removeId,expireTime)
end
end
end

self.headExpireTimer=timer.new()
self.headExpireTimer:start(1,func)

func()
end


function UISettingController:clearHeadExpireTimer()
if self.headExpireTimer then
self.headExpireTimer:cancel()
self.headExpireTimer=nil
end
end


function UISettingController:checkUnlockByItemId(type,itemId)
local id=nil
local cfg=nil















if type==kuangType.zongmen or type==kuangType.feijian or type==kuangType.yunzhou then
return false
end

local cfg=UISettingConfig.getSelfAllCfg(type)
for i,v in ipairs(cfg)do
if v.unlock and v.unlock.type==2 then
local cfgItemId=v.unlock.param[1]
if cfgItemId==itemId then
id=v.id
break
end
end
end

local isActive=UISettingModel:isUnlockHead(type,id)
return isActive,id
end


function UISettingController:useItemUnlockHead(type,headId)
local cfg=nil

if type==kuangType.head then

cfg=cfgHelper.get1(cfg_headportraitconfig_get,headId)

elseif type==kuangType.headKuang then

cfg=cfgHelper.get1(cfg_headportraitframeconfig_get,headId)

elseif type==kuangType.chatKuang then

cfg=cfgHelper.get1(cfg_bubbleframeconfig_get,headId)
end

if cfg.unlock then
local cost=cfg.unlock.param
local itemid=cost[1]
local needCount=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else

have=itemBagModel:getItemCountByItemID(itemid)
end
if have<needCount then
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
return
end

UISettingController:req_unlock(type,headId)
end
end


function UISettingController.on_building_event(etype,level,exp,lastLv)
if etype==buildingEvent.zongmenLevelUp then
UISettingModel:initHeadCfg()
UISettingModel:initChatKuangCfg()
end
end


function UISettingController:getSecFullTabByTab(tab)
local secFullTab=jumpKuangTabType[tab]
if not secFullTab then
logErr(FMT.fmt("跳转至头像设置页面出错 找不到tab:{0} 所对应的二级页签",tab))
return
end

return secFullTab
end


function UISettingController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eZongMengSuit then
rankListController:req_rankList_data(eRankListType.eDuJieFeiSheng)
elseif sysId==SYSTEM_DEFINE.eTeamShowcase then
UISettingModel:initRedDotShowcase()
reddotControl.on_change_catch_type(CATCH_TYPE.eShowcaseTeam)
timeEventController.delayDo(3,function()
UISettingController.req_get_team_254_128()
end)
end
end

function UISettingController.onRankListRefresh(rankType)
if rankType==eRankListType.eDuJieFeiSheng then
UIManager:callWindowFunc('UISettingZongMenSelectWin','freshView')
UIManager:callWindowFunc('UISettingFeiJianSelectWin','freshView')
UIManager:callWindowFunc('UISettingYunZhouSelectWin','freshView')
reddotControl.on_change_catch_type(CATCH_TYPE.eSetingTypeChange)
end
end

function UISettingController.jzAttrChange(type,settingId)
local settingcfg=UISettingConfig.getCfg(type,settingId)
local starNum=UISettingModel:getStarNum(type,settingId)
local jzattr=settingcfg.jzattr
if jzattr then
if starNum>0 then
jzattr=settingcfg.star_jzattr[starNum]
end
for i,v in ipairs(jzattr)do
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aSettingType,v[1])
end
end
if jzattr or settingcfg.attr then
UIDiscipleModel:setAllDiscipleAttrListDirty()
end
end



function UISettingController:showHeadTangCuangWin(headKuangId,typo,expiresec)
local temp=
{
headKuangId=headKuangId,
typo=typo,
expiresec=expiresec,
}
UIManager:showWindow('UIHeadTangCuangWin',temp)
end