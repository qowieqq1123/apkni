







def_class("UIWorldWin",UIWindowBase)









function UIWorldWin:bindComponents()

self.chat=UIObject.get(self,0)
self.chatBtn=UIButton.get(self,1)
self.chatContent=UIObject.get(self,2)
self.chatCreater=UIGameobjectClone.new(self,3)
self.chatReddot=UIObject.get(self,4)
self.chatRedPacket=UIObject.get(self,5)
self.chatScrollView=UIObject.get(self,6)
self.Edge=UIObject.get(self,7)
self.EdgeIcon_1=UIButton.get(self,8)
self.EdgeIcon_2=UIButton.get(self,9)
self.EdgeIcon_3=UIButton.get(self,10)
self.EdgeIcon_4=UIButton.get(self,11)
self.EdgeName_1=UIText.get(self,12)
self.EdgeName_2=UIText.get(self,13)
self.EdgeName_3=UIText.get(self,14)
self.EdgeName_4=UIText.get(self,15)
self.eventBg=UIButton.get(self,16)
self.eventBgLS=UIButton.get(self,17)
self.infoBtn=UIButton.get(self,18)
self.infoBtnReddot=UIObject.get(self,19)
self.mapBtn=UIButton.get(self,20)
self.Money3TipsPanel=UIObject.get(self,21)
self.Money3TipsTx=UIText.get(self,22)
self.moneybar=UIObject.get(self,23)
self.moneyBars_1=UIButton.get(self,24)
self.moneyBars_2=UIButton.get(self,25)
self.moneyBars_3=UIButton.get(self,26)
self.numText=UIText.get(self,27)
self.progressBtn=UIButton.get(self,28)
self.progressTx=UIText.get(self,29)
self.TeamBg=UIObject.get(self,30)
self.TeamList=UIScrollView.get(self,31)
self.ttReddot=UIObject.get(self,32)
self.tuiTuBtn=UIButton.get(self,33)
self.uiRoot=UIObject.get(self,34)

self.chatBtn:setButtonClick(function()self:onChatBtn()end)

self.EdgeIcon_1:setButtonClick(function()self:onEdgeIcon_1()end)

self.EdgeIcon_2:setButtonClick(function()self:onEdgeIcon_2()end)

self.EdgeIcon_3:setButtonClick(function()self:onEdgeIcon_3()end)

self.EdgeIcon_4:setButtonClick(function()self:onEdgeIcon_4()end)

self.eventBg:setButtonClick(function()self:onEventBg()end)

self.eventBgLS:setButtonClick(function()self:onEventBgLS()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.mapBtn:setButtonClick(function()self:onMapBtn()end)

self.moneyBars_1:setButtonClick(function()self:onMoneyBars_1()end)

self.moneyBars_2:setButtonClick(function()self:onMoneyBars_2()end)

self.moneyBars_3:setButtonClick(function()self:onMoneyBars_3()end)

self.progressBtn:setButtonClick(function()self:onProgressBtn()end)

self.tuiTuBtn:setButtonClick(function()self:onTuiTuBtn()end)
self.EdgeIcon={
self.EdgeIcon_1,
self.EdgeIcon_2,
self.EdgeIcon_3,
self.EdgeIcon_4,
}
self.EdgeName={
self.EdgeName_1,
self.EdgeName_2,
self.EdgeName_3,
self.EdgeName_4,
}
self.moneyBars={
self.moneyBars_1,
self.moneyBars_2,
self.moneyBars_3,
}



end


function UIWorldWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.chat);self.chat=nil;
_UIObject_release(self.chatBtn);self.chatBtn=nil;
_UIObject_release(self.chatContent);self.chatContent=nil;
self.chatCreater:deleteSelf();self.chatCreater=nil;
_UIObject_release(self.chatReddot);self.chatReddot=nil;
_UIObject_release(self.chatRedPacket);self.chatRedPacket=nil;
_UIObject_release(self.chatScrollView);self.chatScrollView=nil;
_UIObject_release(self.Edge);self.Edge=nil;
_UIObject_release(self.EdgeIcon_1);self.EdgeIcon_1=nil;
_UIObject_release(self.EdgeIcon_2);self.EdgeIcon_2=nil;
_UIObject_release(self.EdgeIcon_3);self.EdgeIcon_3=nil;
_UIObject_release(self.EdgeIcon_4);self.EdgeIcon_4=nil;
_UIObject_release(self.EdgeName_1);self.EdgeName_1=nil;
_UIObject_release(self.EdgeName_2);self.EdgeName_2=nil;
_UIObject_release(self.EdgeName_3);self.EdgeName_3=nil;
_UIObject_release(self.EdgeName_4);self.EdgeName_4=nil;
_UIObject_release(self.eventBg);self.eventBg=nil;
_UIObject_release(self.eventBgLS);self.eventBgLS=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.infoBtnReddot);self.infoBtnReddot=nil;
_UIObject_release(self.mapBtn);self.mapBtn=nil;
_UIObject_release(self.Money3TipsPanel);self.Money3TipsPanel=nil;
_UIObject_release(self.Money3TipsTx);self.Money3TipsTx=nil;
_UIObject_release(self.moneybar);self.moneybar=nil;
_UIObject_release(self.moneyBars_1);self.moneyBars_1=nil;
_UIObject_release(self.moneyBars_2);self.moneyBars_2=nil;
_UIObject_release(self.moneyBars_3);self.moneyBars_3=nil;
_UIObject_release(self.numText);self.numText=nil;
_UIObject_release(self.progressBtn);self.progressBtn=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.TeamBg);self.TeamBg=nil;
_UIObject_release(self.TeamList);self.TeamList=nil;
_UIObject_release(self.ttReddot);self.ttReddot=nil;
_UIObject_release(self.tuiTuBtn);self.tuiTuBtn=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.EdgeIcon=nil;
self.EdgeName=nil;
self.moneyBars=nil;
end
















local _this=nil
local _Moneys={eMoneyType.mtLingShi,eMoneyType.mtLingYu,eMoneyType.mtLingPai}
local _showMoneyTips3=false
local _teamWidth={
[1]=117,
[2]=176,
[3]=235,
[0]=264,
}
local _filterTask={
"worldDispatchTask_ZongMen_Mystery","worldDispatchTask_Run_Tour","worldDispatchTask_Fly_Tour",
}



function UIWorldWin:onLoaded(...)
self:bindComponents()
_this=self
self.TeamList:setClickAction(function(...)self:onClickTeamItem(...)end)

notifySystem:listenNotify(notifyConfig.on_money_changed,self.onUpdateMoney)
notifySystem:listenNotify(notifyConfig.on_money_init,self.onInitMoney)


notifySystem:listenNotify(notifyConfig.enterWorld,self.enterWorldCompleted)
notifySystem:listenNotify(notifyConfig.onStartMissionInWorld,self.onStartMissionInWorld)
notifySystem:listenNotify(notifyConfig.onStopMissionInWorld,self.onStopMissionInWorld)
notifySystem:listenNotify(notifyConfig.touchUp,self.on_touch_up)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
self:addNotify(notifyConfig.on_UIWorldWin_infoBtn_reddotChange,self.on_UIWorldWin_infoBtn_reddotChange)
self:addNotify(notifyConfig.onRecvMessage,function(...)self:onRecvMessage(...)end)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.onZongMengLevelChange,self.onZongMengLevelChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
self:addNotify(notifyConfig.onSubActivityOpen,self.onSubActivityOpen)
self:addNotify(notifyConfig.onCSJDGuildDataChange,self.onCSJDGuildDataChange)
self:addNotify(notifyConfig.onXMHBGuildDataChange,self.onXMHBGuildDataChange)
self:addNotify(notifyConfig.onWorldBlockStateChanged,self.onWorldBlockStateChangedEx)
self:addNotify(notifyConfig.on_mystery_event_finish,self.on_mystery_event_finish)
self.touchOverUI_Money3Tips=function(over)self:touchOverUI_Money3(over)end
self.winlua:SetTouchOverUI(self.Money3TipsPanel:getID(),self.touchOverUI_Money3Tips)
self:initMoneyBar()
self.forceTeamShow=true

myxpcall(function()
self.mainHandler=chatMessageMainHandler.create(self.chatCreater,self.chatContent:getID(),self)
self:registerChatMainHandle()
self.chatCreater:setRefreshAction(function(...)self:onFinishChatCreatAction(...)end)
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eMain,self.mainHandler)
end)
end



function UIWorldWin:__delete()
self:endAllReddotPunchRotation()
self:unregisterChatMainHandle()

notifySystem:removelistener(notifyConfig.on_money_changed,self.onUpdateMoney)
notifySystem:removelistener(notifyConfig.on_money_init,self.onInitMoney)

notifySystem:removelistener(notifyConfig.enterWorld,self.enterWorldCompleted)
notifySystem:removelistener(notifyConfig.onStartMissionInWorld,self.onStartMissionInWorld)
notifySystem:removelistener(notifyConfig.onStopMissionInWorld,self.onStopMissionInWorld)
notifySystem:removelistener(notifyConfig.touchUp,self.on_touch_up)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)

_showMoneyTips3=false
_this=nil
self.chatCreater:setRefreshAction(nil)


self:unbindComponents()
end

function UIWorldWin.on_system_open(sysId)
if _this==nil or _this.isClose then return end
if sysId==SYSTEM_DEFINE.eGuanQia then
_this.tuiTuBtn:setActive(true)
end
end

function UIWorldWin.onZongMengLevelChange()
if _this==nil or _this.isClose then return end
_this:freshChatReddot()
end

function UIWorldWin.onNewDay()
if _this==nil or _this.isClose then return end
_this:freshChatReddot()
end

function UIWorldWin.on_UIWorldWin_infoBtn_reddotChange()
if _this==nil then return end
_this:refreshInfoBtnReddot()
end

function UIWorldWin:onReConnection()
self.chatCreater:recycleAll()
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eMain,self.handler)
end




function UIWorldWin:onShow(argtable,afterOnloaded)

if self.mainHandler then
self.mainHandler:resumeRecvMsg()
end

self:freshChatReddot()
self:refreshInfoBtnReddot()
self:setContentBottom()
self.onInitMoney()
self:refreshMoney3TipsPanel(_showMoneyTips3)


self:refreshTaskList()
if worldController:isInWorld()then
worldController:markCameraViewChange()
end

self.ttReddot:setActive(false)
self:setContentBottom()

self.tuiTuBtn:setActive(systemModel.isOpen(SYSTEM_DEFINE.eGuanQia))

self:refreshEventWin()

self:initRedPacket()
self:refreshRedPacket()
end


function UIWorldWin:OnEnable()

end


function UIWorldWin:OnDisable()

end

function UIWorldWin:onHide()

self:refreshMoney3TipsPanel(false)
if self.mainHandler then
self.mainHandler:pauseRecvMsg()
end
end



function UIWorldWin.onUpdateMoney(moneyType,lastVal,val)
for i,v in ipairs(_this.moneyBars)do
if moneyType==_Moneys[i]then
local wb=v:getChildWidgetBase()
local desc=moneyModel.getMoneyDesc1(moneyType)
wb:SetChildText(1,desc)
break
end
end
end

function UIWorldWin.onInitMoney()
for i,v in ipairs(_this.moneyBars)do
if _Moneys[i]then
local wb=v:getChildWidgetBase()
local desc=moneyModel.getMoneyDesc1(_Moneys[i])
wb:SetChildText(1,desc)
end
end
end

function UIWorldWin:clickMoney(idx)
local moneyType=_Moneys[idx]
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end




function UIWorldWin:setMoneyBarPos(posType,sortLayer,sortOrder)
if posType==1 then

elseif posType==2 then

else

end
end









function UIWorldWin.onWorldBlockStateChangedEx(world,block,state)
if state==worldBlockModel.BLOCKSTATE.OPEN then
_this:refreshEventWin_ls()
end
end

function UIWorldWin.on_mystery_event_finish(guid,endData)
_this:refreshEventWin_ls()
end

function UIWorldWin.enterWorldCompleted(tpye,world)
if tpye==eWorldEnterPhase.PanelReady then
_this:onInitEdge(world)
end
end

function UIWorldWin.onClickMoney(index)
_this:clickMoney(index)
end

function UIWorldWin:showUI(visible)


local scale=visible and Vector3.one or Vector3.New(0,1,1)
self.uiRoot:setScale(scale)

end

function UIWorldWin:onChatBtn()



end

function UIWorldWin:initMoneyBar()
if webGLHelper:isNeedAdaption()then
self.moneybar:setChildAnchoredPosition3D(Vector3.New(-250,0,0))
end
for i,v in ipairs(self.moneyBars)do
local wb=v:getChildWidgetBase()
local mType=_Moneys[i]
if mType then
local icon=iconHelper.getMoneyIconName(mType)

wb:SetChildIcon(0,icon,false)
if mType~=eMoneyType.mtLingPai then
wb:SetChildButtonClickWithID(2,self.onClickMoney,i)
else
wb:SetChildButtonClickWithID(2,self.onClickMoney2,i)
end
else
v:setActive(false)
end
end
end

function UIWorldWin:setMoneyBarCanvas(sortLayer,sortOrder)
for i,v in ipairs(self.moneyBars)do
v:setChildCanvas(sortLayer,sortOrder)
end
end

function UIWorldWin:removeMoneyBarCanvas()
for i,v in ipairs(self.moneyBars)do
v:setChildRemoveCanvas()
end
end

function UIWorldWin.onClickMoney2(index)
moneySystem:showBuyTips(_Moneys[index])
end










function UIWorldWin:onProgressBtn()
UIManager:showWindow("UIWorldProgressWin")
end






function UIWorldWin:onInitEdge(world)

if world then
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world)
local nearWorlds=worldCfg.nearWorld
for i,v in ipairs(self.EdgeIcon)do
local near=nearWorlds[i]
local rootCmp=v

if near then
local nearCfg=cfgHelper.get1(cfg_worldconfig_get,near)
self.winlua:SetChildCSImageSprite(rootCmp:getID(),"ui/windows/world/sharedtextures/dashijie_scene_icon_altas.ab",nearCfg.icon)

end
rootCmp:setActive(false)
end
end
end

function UIWorldWin:onEdgeIcon_1()
self.onClickEdgeBtn(1)
end

function UIWorldWin:onEdgeIcon_2()
self.onClickEdgeBtn(2)
end

function UIWorldWin:onEdgeIcon_3()
self.onClickEdgeBtn(3)
end

function UIWorldWin:onEdgeIcon_4()
self.onClickEdgeBtn(4)
end

function UIWorldWin.onClickEdgeBtn(index)
local aspect=bitHelper.set_1(0,index-1)
worldController.onOutRange(aspect)
end

function UIWorldWin:onEdgeTips(index,show)
self.EdgeIcon[index]:setActive(show)
end











function UIWorldWin.onStartMissionInWorld(taskKey,unitType,tableId,array)
if _this==nil or _this.isClose then return end
_this:refreshTaskList()
end

function UIWorldWin.onStopMissionInWorld(key,isCompleted)
if _this==nil or _this.isClose then return end
_this:refreshTaskList()
end

function UIWorldWin.filterTaskShow(task)


for i,v in ipairs(_filterTask)do
if task.name==v then
return false
end
end
return task.state~=eWorldTripState.Unplayed and#task.disciples>0
end

function UIWorldWin:refreshTaskList()
self.taskList=worldTaskModel:getAllTaskSortList(worldTaskModel.sortTaskTime,self.filterTaskShow)
local count=#self.taskList
local show=self.forceTeamShow and count>0
self.TeamBg:setActive(show)
if show then
self.TeamBg:setChildSizeDelta(_teamWidth[count]or _teamWidth[0],76)
self.TeamList:freshGridsNum(count,1,count,false)
for i=1,count do
local item=self.TeamList:getGridObjectByindex(i-1)
local task=worldTaskModel:getTask(self.taskList[i])
local discipleguid=task.disciples[1]
if UIDiscipleModel:getDiscipleData(discipleguid)then
comHelper.setChildModelRawImage(item,discipleguid,0,0,eHeadCenterType.eHead,0.7)
end
end
end
end

function UIWorldWin:forceShowTeam(show)
self.forceTeamShow=show
self:refreshTaskList()
end

function UIWorldWin:onClickTeamItem(id,index,guid,attach)
local taskKey=self.taskList[index]
if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task then
local keys={
worldTaskModel:convertTaskUnitKey(taskKey,1),
task.target_key
}

if task.target_type==eWorldUnitTpye.MYSTERY then
local typo=MysteryModel:get_mystery_sence_type(task.target_id)
if typo==MysterySenceType.ResPoint then
local data,guid,subIdx=worldResPointDataModel:findMysteryData(task.target_id)
local key=worldResPointBaseModel:convertUnitKey(guid,subIdx)
table.insert(keys,key)
elseif typo==MysterySenceType.ZiYuan then
local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(task.target_id)
if group then
local key=table.concat({group[1],group[2]},"-")
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.RESMYSTERY,key})
table.insert(keys,unitKey)
end
end
elseif task.target_type==eWorldUnitTpye.HUNTMONSTERTEAM then
keys={}
local teamData=huntMonsterTeamModel:getTeamData(task.world)
if huntMonsterTeamModel:isTeamComplete(teamData)then
worldController:changeLeftView("UIWorldUnitListWin2",{tab=2,extra={world=task.world,showhunt=true}})
return
else
for i,v in ipairs(teamData.monsters)do
if huntMonsterTeamModel:findMonsterWorld(v)==task.world then
table.insert(keys,v)
end
end
end
end
if#keys>0 then
if worldModel:isSameWorld(task.world)then
for i,v in ipairs(keys)do
if worldController:haveUnit(v)then
worldController:lookAtUnit(v)
return
end
end
else
local worldName=cfgHelper.get2(cfg_worldconfig_get,task.world,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
local args={lookAtUnit=keys}
worldController:enterWorld(task.world,args)
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end
end
end
end

function UIWorldWin:onMoneyBars_1()
self:clickMoney(1)
end

function UIWorldWin:onMoneyBars_2()
self:clickMoney(2)
end

function UIWorldWin:onMoneyBars_3()


self:clickMoney(3)
end





function UIWorldWin:touchOverUI_Money3(over)
if not over then
self:refreshMoney3TipsPanel(over)
end
end

function UIWorldWin:on_touch_up(fingerIndex,touchCount,screenPoint,guid)
if _showMoneyTips3 then
_this:refreshMoney3TipsPanel(false)
end
end

function UIWorldWin:refreshMoney3TipsPanel(show)

_showMoneyTips3=show

self.Money3TipsPanel:setActive(show)
self:stopMoney3Tick()
if show then
self:startMoney3Tick()
end
end

function UIWorldWin:startMoney3Tick()
self:updateMoney3Tick()
if not self.money3Tick then
self.money3Tick=self:setTimer(1,0,function()
self:updateMoney3Tick()
end)
end
end

function UIWorldWin:updateMoney3Tick()
local moneytype=_Moneys[3]
local check,buidId=moneyAutoIncreaseModel:checkBuilding(moneytype)
local moneyname=moneyModel.getMoneyName(moneytype)
if check then
if moneyAutoIncreaseModel:isNotMax(moneytype)then
local least=moneyAutoIncreaseModel:getLeastTime(moneytype)
least=math.max(least,0)
local autoCfg=cfgHelper.get2(cfg_moneyconfig_get,moneytype,'autoincr')
self.Money3TipsTx:setText(FMT.fmt("将在<color=#29ad0f>{0}</color>后恢复{1}令牌",timeHelper.format_time_stamp(least,true),autoCfg[2]))
else
self.Money3TipsTx:setText(FMT.fmt("{0}已达上限",moneyname))
end
else
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,buidId)
self.Money3TipsTx:setText(FMT.fmt("尚未建造{0}无法恢复{1}",bdCfg.name,moneyname))
end
end

function UIWorldWin:stopMoney3Tick()
if self.money3Tick then
self:stopTimerByID(self.money3Tick)
self.money3Tick=nil
end
end

function UIWorldWin:onTuiTuBtn()
UILiLianControl:showLiLianWindow()
end


function UIWorldWin:registerChatMainHandle()
if not self.isMainHandle then
self.isMainHandle=true
chatControl.registerMainHandler(MAIN_HOLD_TYPE.eMain,self.mainHandler)
end
end

function UIWorldWin:unregisterChatMainHandle()
if self.isMainHandle then
self.isMainHandle=false
chatControl.unregisterMainHandler(MAIN_HOLD_TYPE.eMain,self.mainHandler)
end
end

function UIWorldWin:onFinishChatCreatAction(assetName,guid,luaid,isInit)
if not isInit then
self:setContentBottom(true)
self.chatCreater:callChildFunc(luaid,'playAni')
end
end

function UIWorldWin:freshChatReddot()
local channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eXianmeng,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.ePrivate}
local num=0
for _,channelId in ipairs(channels)do
if chatControl.hasNewMesgByChannel(channelId)then
num=num+chatControl.getNewestMesgNumByChannel(channelId)
end
end
local reddot=num>0
self.chatReddot:setActive(reddot)
self.chatReddotIndex=self:doPunchRotation(self.widget,self.chatReddot:getID(),self.chatReddotIndex,reddot)
if num>99 then
num='99+'
elseif num<=0 then
num=''
end
self.numText:setText(num)
end


function UIWorldWin:onRecvMessage()
self:freshChatReddot()
end

function UIWorldWin:onReadNewestMesg(channel,actorid)
self:freshChatReddot()
end


function UIWorldWin:setContentBottom(ani)

local height=self.winlua:GetChildSizeDeltaY(self.chatContent:getID())
self.winlua:SetStopChildScrollRect(self.chatScrollView:getID())
self.winlua:SetChildDOAnchorPosY(self.chatContent:getID(),0,ani and 0.2 or 0)
end


function UIWorldWin:refreshEventWin()
self:refreshEventWin_base()
self:refreshEventWin_ls()
end

function UIWorldWin:refreshEventWin_base()
local num=worldDailyEventModel:get_unit_count()
self.eventBg:setActive(num>0)
if num>0 then
local widget=self.eventBg:getChildWidgetBase()
widget:SetChildText(1,FMT.fmt("事件（剩余:{0}）",num))
widget:SetChildCSImageSprite(2,'ui/windows/disciple2/otherdiziicons_atlas_pak.ab',"image_gongfakuangdi_1")
widget:SetChildScale(2,Vector3.New(0.35,0.35,0.35))
widget:SetChildShowEffect(4,10324,true)
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
end
end

function UIWorldWin:refreshEventWin_ls()
local num=worldResPointDataModel:getCatchLingShouResNum()
self.eventBgLS:setActive(num>0)
if num>0 then
local widget=self.eventBgLS:getChildWidgetBase()
widget:SetChildText(1,FMT.fmt("灵兽（剩余:{0}）",num))
widget:SetChildCSImageSprite(2,'ui/windows/disciple2/otherdiziicons_atlas_pak.ab',"icon_lingchonzhuabu_1_")

widget:SetChildShowEffect(4,10324,true)
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
end
end

function UIWorldWin:onEventBg()
local num=worldDailyEventModel:get_unit_count()
if num>0 then
local guid=worldDailyEventModel:get_unit_key(self.lastEvent)
worldDailyEventController:jumpToEvent(guid)
self.lastEvent=guid
end
end

function UIWorldWin:onEventBgLS()
local num=worldResPointDataModel:getCatchLingShouResNum()
if num>0 then
local list=worldResPointDataModel:getLingShouCatchResDataList(worldModel.world)
if list and#list>0 then
local guid=list[1]
local unitKey=worldResPointBaseModel:convertUnitKey(guid,1)
worldController:lookAtUnit(unitKey)
else
local key,data=worldResPointDataModel:getNextCatchLingShouResData()
if key==nil or data==nil then
logErr("联系技术检查，到达此处 界面不应该有显示")
else

local worldId=data.world





local worldName=cfgHelper.get2(cfg_worldconfig_get,worldId,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('是否前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
local position=worldPositionConfig:getPosition(data.world,{data.datas[1].x,data.datas[1].z})
local args={lookAt=position}
local flag=mainControl:enterWorld({worldId,args},function()
worldDailyEventController.onClickObjectInWorld({worldModel.UNITTYPE.RESPOINT,key})
end)
end,
showclosebtn=false,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()
end

end
end
end



function UIWorldWin:onInfoBtn()
worldController:changeLeftView("UIWorldUnitListWin2")
end

function UIWorldWin:refreshInfoBtnReddot()
local isReddot=npcModel:getWorldAreaNPCReddot()or mysteryZiYuanFuBenModel:checkPassReddot()or huntMonsterTeamModel:existTeamComplete()or systemZongMenModel:getAllReddot()
self.infoBtnReddot:setActive(isReddot)
end







function UIWorldWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UIWorldWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end

function UIWorldWin:initRedPacket()
local subList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCaiShenJiaDao)
local list={}
for index,info in ipairs(subList)do

table.insert(list,info)

end
if#list>1 then
table.sort(list,function(a,b)
return a.start_time<b.start_time
end)
end
self.redpacketInfo_CSJD=list[1]

local sub_actList_xmhb=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXianMengHongBao)
if#sub_actList_xmhb>0 then
self.redpacketInfo_XMHB=sub_actList_xmhb[1]
end
end

function UIWorldWin:refreshRedPacket()
if self.redpacketInfo_CSJD or self.redpacketInfo_XMHB then
local count=0
if self.redpacketInfo_CSJD then
local count_csjd=self.redpacketInfo_CSJD:countGuildDataStatus(eCSJDRedPacketStatus.eNormal)
count=count+count_csjd
end
if self.redpacketInfo_XMHB then
local count_xmhb=self.redpacketInfo_XMHB:getGuildDataCanGetRedPacketCount()
count=count+count_xmhb
end

self.chatRedPacket:setActive(count>0)
else
self.chatRedPacket:setActive(false)
end
end

function UIWorldWin.onSubActivityStateChange(actId,subType,subId,state)
if subType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
_this:initRedPacket()
_this:refreshRedPacket()
end
end

function UIWorldWin.onSubActivityOpen(actId,subType,subId,flag)
if subType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
_this:initRedPacket()
_this:refreshRedPacket()
end
end

function UIWorldWin.onCSJDGuildDataChange(actId,subType,subId,guid,reSort)
if reSort then
_this:refreshRedPacket()
end
end

function UIWorldWin.onXMHBGuildDataChange(actId,subType,subId,guid,reSort)
if reSort then
_this:refreshRedPacket()
end
end
