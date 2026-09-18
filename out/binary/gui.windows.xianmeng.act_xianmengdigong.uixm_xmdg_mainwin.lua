







def_class("UIXM_XMDG_MainWin",UIWindowBase)









function UIXM_XMDG_MainWin:bindComponents()

self.bottomPanel=UIObject.get(self,0)
self.buffBtn=UIButton.get(self,1)
self.bufflvTxt=UIText.get(self,2)
self.changeBtn=UIButton.get(self,3)
self.chatBtn=UIButton.get(self,4)
self.closeSignBtn=UIButton.get(self,5)
self.closeTimeObj=UIObject.get(self,6)
self.closeTimeTxt=UIText.get(self,7)
self.cloud=UIObject.get(self,8)
self.dzBtn=UIButton.get(self,9)
self.eventBtn=UIButton.get(self,10)
self.eventNumTxt=UIText.get(self,11)
self.flagroot=UIObject.get(self,12)
self.freeEventBtn=UIButton.get(self,13)
self.freeEventBtnReddot=UIObject.get(self,14)
self.leftPanel=UIObject.get(self,15)
self.lockBtn=UIButton.get(self,16)
self.message2Txt=UIText.get(self,17)
self.messageFrame=UIObject.get(self,18)
self.messageMask=UIObject.get(self,19)
self.messageTxt=UIText.get(self,20)
self.money1Root=UIObject.get(self,21)
self.money2Root=UIObject.get(self,22)
self.noteBtn=UIButton.get(self,23)
self.noteBtnReddot=UIObject.get(self,24)
self.openTimeTxt=UIText.get(self,25)
self.passBtn=UIButton.get(self,26)
self.passBtnReddot=UIObject.get(self,27)
self.rightPanel=UIObject.get(self,28)
self.root=UIObject.get(self,29)
self.ruleBtn=UIButton.get(self,30)
self.shopBtn=UIButton.get(self,31)
self.shopBtnReddot=UIObject.get(self,32)
self.signBtn=UIButton.get(self,33)
self.signRoot=UIObject.get(self,34)
self.topPanel=UIObject.get(self,35)
self.uiRoot=UIObject.get(self,36)

self.buffBtn:setButtonClick(function()self:onBuffBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.chatBtn:setButtonClick(function()self:onChatBtn()end)

self.closeSignBtn:setButtonClick(function()self:onCloseSignBtn()end)

self.dzBtn:setButtonClick(function()self:onDzBtn()end)

self.eventBtn:setButtonClick(function()self:onEventBtn()end)

self.freeEventBtn:setButtonClick(function()self:onFreeEventBtn()end)

self.lockBtn:setButtonClick(function()self:onLockBtn()end)

self.noteBtn:setButtonClick(function()self:onNoteBtn()end)

self.passBtn:setButtonClick(function()self:onPassBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.signBtn:setButtonClick(function()self:onSignBtn()end)



end


function UIXM_XMDG_MainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.buffBtn);self.buffBtn=nil;
_UIObject_release(self.bufflvTxt);self.bufflvTxt=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.chatBtn);self.chatBtn=nil;
_UIObject_release(self.closeSignBtn);self.closeSignBtn=nil;
_UIObject_release(self.closeTimeObj);self.closeTimeObj=nil;
_UIObject_release(self.closeTimeTxt);self.closeTimeTxt=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.dzBtn);self.dzBtn=nil;
_UIObject_release(self.eventBtn);self.eventBtn=nil;
_UIObject_release(self.eventNumTxt);self.eventNumTxt=nil;
_UIObject_release(self.flagroot);self.flagroot=nil;
_UIObject_release(self.freeEventBtn);self.freeEventBtn=nil;
_UIObject_release(self.freeEventBtnReddot);self.freeEventBtnReddot=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.lockBtn);self.lockBtn=nil;
_UIObject_release(self.message2Txt);self.message2Txt=nil;
_UIObject_release(self.messageFrame);self.messageFrame=nil;
_UIObject_release(self.messageMask);self.messageMask=nil;
_UIObject_release(self.messageTxt);self.messageTxt=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.money2Root);self.money2Root=nil;
_UIObject_release(self.noteBtn);self.noteBtn=nil;
_UIObject_release(self.noteBtnReddot);self.noteBtnReddot=nil;
_UIObject_release(self.openTimeTxt);self.openTimeTxt=nil;
_UIObject_release(self.passBtn);self.passBtn=nil;
_UIObject_release(self.passBtnReddot);self.passBtnReddot=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.shopBtnReddot);self.shopBtnReddot=nil;
_UIObject_release(self.signBtn);self.signBtn=nil;
_UIObject_release(self.signRoot);self.signRoot=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this=nil
local maskWins={
['UIXM_XMDG_MapWin']=true,
['UIXM_XMDG_MapNoneWin']=true,
['UIXM_XMDG_MainWin']=true,
}


function UIXM_XMDG_MainWin:onLoaded(...)
_this=self
self:bindComponents()
self.winLookup={}
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:addNotify(notifyConfig.showUI,self.showUI)
self:addNotify(notifyConfig.closeUI,self.closeUI)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.inNewbie,self.setEnableDrag)

reddotClassManager.register_event(REDDIT_TYPE.eXianMengDiGong,self.refreshShopReddot)
reddotClassManager.register_event(REDDIT_SUB_TYPE.sXMDGPass,self.refreshPassReddot)

self.is_enableDrag=true
local cav=self:getChildCanvas(-1)
self.root:setChildCanvas(cav[1],cav[2]+8)
xianmengdigongController:autoReadGLChatNotice()
end


function UIXM_XMDG_MainWin:__delete()
self:unbindComponents()
reddotClassManager.unregister_event(REDDIT_TYPE.eXianMengDiGong,self.refreshShopReddot)
reddotClassManager.unregister_event(REDDIT_SUB_TYPE.sXMDGPass,self.refreshPassReddot)
self:clearAllFMTweener()
UIManager:closeWindow('UIXM_XMDG_MapWin')
UIManager:closeWindow('UIXM_XMDG_MapNoneWin')
_this=nil
end

function UIXM_XMDG_MainWin.refreshShopReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this.shopBtnReddot:setActive(flag)
end

function UIXM_XMDG_MainWin.refreshPassReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this.passBtnReddot:setActive(flag)
end


function UIXM_XMDG_MainWin:onHide()
self:enableDrag(false)
end

function UIXM_XMDG_MainWin:onLostConnection()
self:enableDrag(false)
end

function UIXM_XMDG_MainWin.onLimitActStateChange(actID,state)
if actID~=LIMIT_ACT_TYPE.eXianMengDiGong then return end
if _this==nil then return end

if state==limitActivitiesModel.actDoingState then


elseif state==limitActivitiesModel.actPreviewState or state==limitActivitiesModel.actIdleState then

_this.actState=state
local callback=function()
if _this==nil then return end
_this:refreshView()
end
UIManager:showWindow("UIFightPrepareLoading",{para=1,startCallback=callback})
end
end

function UIXM_XMDG_MainWin:checkWinLookup()
for k,v in pairs(self.winLookup)do
if v then
return false
end
end
return true
end

function UIXM_XMDG_MainWin.showUI(name)
if _this==nil or not _this.isVisible then return end
if maskWins[name]==nil then
_this.winLookup[name]=true
local flag_=false

if _this.is_enableDrag~=flag_ then
_this:enableDrag(flag_,true)
end
end
end

function UIXM_XMDG_MainWin.closeUI(name)
if _this==nil then return end
_this.winLookup[name]=nil
if not _this.isVisible then return end
local flag=_this:checkWinLookup()

if flag then
_this:enableDrag(true)
end
end

function UIXM_XMDG_MainWin.setEnableDrag(id,flag)
if not _this then return end

if flag then
_this:enableDrag(false)
else
_this:enableDrag(true)
end
end

function UIXM_XMDG_MainWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
_this:refreshMoneyItemEx(moneyType,lastVal)
end




function UIXM_XMDG_MainWin:onShow(argtable,afterOnloaded)
self:clearAllFMTweener()
self.isFull=argtable.isFull
local targetPos
local extraParams=argtable.extraParams
local openShop
local openNote
local movePos
if extraParams then
targetPos=extraParams.targetPos
if targetPos==nil then
movePos=extraParams.movePos
end
openShop=extraParams.openShop
openNote=extraParams.openNote
self.jumpClick=extraParams.jumpClick
end
if afterOnloaded then
self.targetPos=targetPos
end
self.targetPos_temp=targetPos

self.actState=limitActivitiesModel:checkActState(LIMIT_ACT_TYPE.eXianMengDiGong)
self:refreshView()

if self.actTimer==nil then
local func=function()
self:timerRefresh()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end

if afterOnloaded then
self:initMessage()
else
self:jumpTargetPos(self.targetPos)
end
if openShop then
self:onShopBtn()
end
if openNote~=nil then
UIManager:showWindow('UIXM_XMDG_NoteMainWin',{page=openNote})
end
if movePos then
self:delayDo(1.5,function()
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','jumpRoom2',movePos[1],movePos[2],nil,argtable.jumpClick)
end)
end

local isreddot=reddotClassManager.get_reddot(REDDIT_TYPE.eXianMengDiGong)
self.shopBtnReddot:setActive(isreddot)

if afterOnloaded then

end

end

function UIXM_XMDG_MainWin:jumpTargetPos(targetPos)
if targetPos then
local room=xianmengdigongModel:getRoom2(targetPos[1],targetPos[2])
if room then
self:jumpRoom(room)
end
end
end

function UIXM_XMDG_MainWin:onShowArgRecv(argtable)
local extraParams=argtable.extraParams
local openShop
local openNote
local targetPos
if extraParams then
openShop=extraParams.openShop
openNote=extraParams.openNote
targetPos=extraParams.targetPos
end
self:jumpTargetPos(targetPos)
if openShop then
self:onShopBtn()
end
if openNote~=nil then
UIManager:showWindow('UIXM_XMDG_NoteMainWin',{page=openNote})
end
end

function UIXM_XMDG_MainWin:timerRefresh()
self:refreshActTimer()
self:updateMessage()
end

function UIXM_XMDG_MainWin:refreshActTimer()
local time
if self.actState==limitActivitiesModel.actPreviewState or self.actState==limitActivitiesModel.actIdleState then
time=limitActivitiesModel:getActStartLeftTime(LIMIT_ACT_TYPE.eXianMengDiGong)
self.openTimeTxt:setText(FMT.fmt('正在探寻地宫，{0}后即可发现入口',timeHelper.formatSimpleTime(time)))
else
time=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eXianMengDiGong)
self.closeTimeTxt:setText(FMT.fmt('距离地宫关闭剩余：{0}',timeHelper.format_time_stamp3(time)))
end
end

function UIXM_XMDG_MainWin:refreshView()
local isDoing=self.actState==limitActivitiesModel.actDoingState



self.cloud:setActive(not isDoing)
self.closeTimeObj:setActive(isDoing)
self.rightPanel:setActive(isDoing)
self.topPanel:setActive(isDoing)
self.bottomPanel:setActive(isDoing)

if not isDoing then
self.flagroot:setActive(false)
else
self.flagroot:setActive(xianmengdigongModel:is_Showtips())
end

self:leaveSignModel()
if isDoing then
self:initMoneyData({{eMoneyType.mtDiGongContribute},{eMoneyType.mtDiGongXingDongLi}})
self:refreshBuff()
self:refreshEventBtn()
self:refreshSignBtn()

self:refreshFreeEventBtn()
self:refreshLockBtn()
self:refreshPassBtn()

UIManager:closeWindow('UIXM_XMDG_MapNoneWin')
local win=UIManager:findActiveWindow('UIXM_XMDG_MapWin')
if win==nil then
local targetPos=nil
local targetLocalPos=nil
if self.targetPos then
local room=xianmengdigongModel:getRoom2(self.targetPos[1],self.targetPos[2])
if room then
targetPos=self.targetPos
targetLocalPos={room.base.posx,room.base.posy}
end
end
UIManager:showWindow('UIXM_XMDG_MapWin',{targetPos=targetPos,targetLocalPos=targetLocalPos,jumpClick=self.jumpClick})
self.jumpClick=nil
else
if not UIManager:isActive('UIXM_XMDG_MapWin')then
UIManager:showWindow('UIXM_XMDG_MapWin',{targetPos=self.targetPos_temp,jumpClick=self.jumpClick})
self.jumpClick=nil
end
end

self:refreshNoteBtnReddot()
else


UIManager:closeWindow('UIXM_XMDG_MapWin')
local win=UIManager:findActiveWindow('UIXM_XMDG_MapNoneWin')
if win==nil then
UIManager:showWindow('UIXM_XMDG_MapNoneWin')
else
if not UIManager:isActive('UIXM_XMDG_MapNoneWin')then
UIManager:showWindow('UIXM_XMDG_MapNoneWin')
end
end
end
end

function UIXM_XMDG_MainWin:enableDrag(flag,lockTime)
self.is_enableDrag=flag
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','enableDrag',flag,lockTime)
UIManager:invokeUIMethod('UIXM_XMDG_MapNoneWin','enableDrag',flag,lockTime)
end

function UIXM_XMDG_MainWin:check_enableDrag()
return self.is_enableDrag
end

function UIXM_XMDG_MainWin:jumpRoom(room)
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','jumpRoom',room)
end

function UIXM_XMDG_MainWin:jumpRoom2(pos)
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','jumpRoom2',pos[1],pos[2])
end

function UIXM_XMDG_MainWin:refreshBuff()
local lv=xianmengdigongModel:getBufflv()
local showbtn=lv>0
self.buffBtn:setActive(showbtn)
if showbtn then
self.bufflvTxt:setText(tostring(lv))
end
end



function UIXM_XMDG_MainWin:setMoneyRootCanves(flag,sortLayer,sortOrder)
if flag then
self.topPanel:setChildCanvas(sortLayer,sortOrder)
else
self.topPanel:setChildRemoveCanvas()
end
end

function UIXM_XMDG_MainWin:initMoneyData(datas)
local moneyList={}
local moneyLookup={}
for i=1,2 do
local data=datas[i]
local moneyType=data[1]
local isAdd=data[2]
local widgetName=FMT.fmt('money{0}Root',i)
local widget=self[widgetName]:getChildWidgetBase()
local d={widget,moneyType,isAdd}
moneyList[i]=d
if moneyType then
moneyLookup[moneyType]=d
end
end
self.moneyList=moneyList
self.moneyLookup=moneyLookup

for i,money in ipairs(self.moneyList)do
self:initMoneyItem(money)
end
end

function UIXM_XMDG_MainWin:initMoneyItem(money)
local moneyType=money[2]
local widget=money[1]
local isshow=moneyType~=nil
widget:SetChildActive(-1,isshow)
if isshow then
local isAdd=money[3]~=1
local moneyVal=moneyModel.getMoney(moneyType)
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(1,iconHelper.getIconName(moneyType),false)
widget:SetChildText(2,moneyStr)
widget:SetChildActive(3,isAdd)
widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onAddClick(moneyType)
end)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:clickMoney(moneyType)
end)
end
end

function UIXM_XMDG_MainWin:refreshMoneyItemEx(moneyType,lastVal)
if not self.moneyLookup then return end
local money=self.moneyLookup[moneyType]
if money then
self:refreshMoneyItem(money,lastVal)
end
end

function UIXM_XMDG_MainWin:refreshMoneyItem(money,lastVal)
local moneyType=money[2]
local widget=money[1]
local isshow=moneyType~=nil
widget:SetChildActive(-1,isshow)
if isshow then
local moneyVal=moneyModel.getMoney(moneyType)
self:clearFMTweener(moneyType)
if self.fmTweener==nil then self.fmTweener={}end
self.fmTweener[moneyType]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(2,moneyStr)
end,moneyVal,1)
end
end

function UIXM_XMDG_MainWin:onAddClick(moneyType)
self:clickMoney(moneyType)
end

function UIXM_XMDG_MainWin:clickMoney(moneyType)
gainControl:showGainWin(moneyType)
end

function UIXM_XMDG_MainWin:clearFMTweener(mtype)
if self.fmTweener==nil then return end
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UIXM_XMDG_MainWin:clearAllFMTweener()
if self.fmTweener then
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self.fmTweener=nil
end
end





function UIXM_XMDG_MainWin:refreshSignBtn()
local myActorid=playerModel:getActorID()
local isshow=xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpAllyLeader)or xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpViceLeader)
self.signBtn:setActive(isshow)
end

function UIXM_XMDG_MainWin:onSignBtn()
local myActorid=playerModel:getActorID()
if not xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpAllyLeader)and
not xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpViceLeader)then
UIManager.error('盟主或副盟主才可选择')
return
end
self:enterSignModel()
end

function UIXM_XMDG_MainWin:onCloseSignBtn()
self:leaveSignModel()
end

function UIXM_XMDG_MainWin:enterSignModel()
if self.signModel==nil then
self.signModel=true


self.bottomPanel:setChildDOLocalMoveY(-70,0.35)
self.topPanel:setChildDOLocalMoveY(25,0.35)
self.leftPanel:setChildDOLocalMoveX(-52.5,0.35)
self.rightPanel:setChildDOLocalMoveX(60,0.35)
self.uiRoot:setChildCanvasGroupDOFade(0,0.35)
self:delayDo(0.25,function()
self.signRoot:setChildDOLocalMoveY(0,0.35)
self.signRoot:setChildCanvasGroupDOFade(1,0.35)
end)

UIManager:invokeUIMethod('UIXM_XMDG_MapWin','refreshFloatSign',false)
end
end

function UIXM_XMDG_MainWin:leaveSignModel()
if self.signModel==true then
self.signModel=nil
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','reqGL')
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','hideFloatSign')


self.signRoot:setChildDOLocalMoveY(-70,0.35)
self.signRoot:setChildCanvasGroupDOFade(0,0.35)
self:delayDo(0.25,function()
self.bottomPanel:setChildDOLocalMoveY(0,0.35)
self.topPanel:setChildDOLocalMoveY(0,0.35)
self.leftPanel:setChildDOLocalMoveX(0,0.35)
self.rightPanel:setChildDOLocalMoveX(0,0.35)
self.uiRoot:setChildCanvasGroupDOFade(1,0.35)
end)
else
if not self.initSignRoot then
self.initSignRoot=true
self.signRoot:setChildCanvasGroupAlpha(0)
self.signRoot:setChildDOLocalMoveY(-70,0)
end
end
end

function UIXM_XMDG_MainWin:checkSignModel()
return self.signModel==true
end





function UIXM_XMDG_MainWin:initMessage()
self.messageSpeed=150
self.messageSpace=1.5
self.messageObjLookup={}
self.messageObjLookup[1]=self.messageTxt
self.messageObjLookup[2]=self.message2Txt
self.messageObjUsedLookup={}
self.messageList={}
self.messageBoxWidth=self.messageMask:getChildSizeDeltaX()
end

function UIXM_XMDG_MainWin:updateMessage()
local c=#self.messageList
if c<2 then
local l_time
if c>0 then
for i,meassge in ipairs(self.messageList)do
if l_time==nil or meassge.endTime>l_time then
l_time=meassge.endTime
end
end
end
if l_time==nil or Time.realtimeSinceStartup>l_time then
self:addMessage()
end
end
end

function UIXM_XMDG_MainWin:addMessage()
local obj_idx=nil
for idx,obj in pairs(self.messageObjLookup)do
if self.messageObjUsedLookup[idx]==nil then
obj_idx=idx
break
end
end
if obj_idx then
local message_str=xianmengdigongModel:getDGOneNoteStr()
if message_str then
self.messageFrame:setActive(true)

local message={}
message.obj_idx=obj_idx
local obj=self.messageObjLookup[obj_idx]
self.messageObjUsedLookup[obj_idx]=true
obj:setChildCanvasGroupAlpha(0)
obj:setText(message_str)
self:delayDo(0.2,function()
local w=obj:getChildSizeDeltaX()
local time=(w+self.messageBoxWidth)/self.messageSpeed
local time2=w/self.messageSpeed+self.messageSpace
message.endTime=Time.realtimeSinceStartup+time2
local h_w=self.messageBoxWidth/2
obj:setChildAnchoredPos(h_w,2)
local tweener=obj:setChildDOAnchorPosX(-h_w-w,time,function()
if _this==nil then return end
self:removeMessage(obj_idx)
end)
tweener:SetEase(_Ease.Linear)
obj:setChildCanvasGroupAlpha(1)
table.insert(self.messageList,message)
end)
end
end
end

function UIXM_XMDG_MainWin:removeMessage(idx)
local f
for i,message_ in ipairs(self.messageList)do
if message_.obj_idx==idx then
f=i
break
end
end
if f then
local message=table.remove(self.messageList,f)
local obj_idx=message.obj_idx
local obj=self.messageObjLookup[obj_idx]
obj:setChildCanvasGroupAlpha(0)
self.messageObjUsedLookup[obj_idx]=nil
end
end

function UIXM_XMDG_MainWin:refreshNoteBtnReddot()
self.noteBtnReddot:setActive(xianmengdigongModel:getAllDGNoteReddot())
end



function UIXM_XMDG_MainWin:onRuleBtn()
local d={}
d.title='活动规则'
d.mode=3
d.num=6
d.name='act_xmdg_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXM_XMDG_MainWin:onShopBtn()

local panelparams={}
panelparams.isFull=false
UIFullCommonControl:showCommonWindow('UIXM_XMDG_ShopForeWin',panelparams)
end

function UIXM_XMDG_MainWin:onChatBtn()
UIManager:showWindow('UIChatWin')
end

function UIXM_XMDG_MainWin:onNoteBtn()
UIManager:showWindow('UIXM_XMDG_NoteMainWin')
end

function UIXM_XMDG_MainWin:onBuffBtn()
local pos=Vector2.New(15,-50)
local str='当前所有妖兽的强化buff层数'
local posItem=self.buffBtn
UIManager:showWindow('UIConditionTipsOne',{str=str,pos=pos,posItem=posItem,showType=4})
end

function UIXM_XMDG_MainWin:onDzBtn()
local winParams={
titleName='弟子信息',
extraWin='UIXM_XMDG_DiZiWin',
extraParams={},
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end

function UIXM_XMDG_MainWin:onChangeBtn()
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','moveCamera2TargetPos')
end

function UIXM_XMDG_MainWin:refreshEventBtn()
local list=xianmengdigongModel:getAllHasRewardEvent()
local num=0
if list~=nil then
num=#list
end
local isshow=num>0
self.eventBtn:setActive(isshow)
if isshow then
self.eventNumTxt:setText(tostring(num))
end
end

function UIXM_XMDG_MainWin:onEventBtn()
xianmengdigongController:openEventRewardWin()
end

function UIXM_XMDG_MainWin:onClickClose()
if self.isFull then
UIFullCommonControl:closeUI()
else
self:closeSelf()
end
end

function UIXM_XMDG_MainWin:rec_buffchange()
self:refreshBuff()
end

function UIXM_XMDG_MainWin:rec_changeMap()
local old=self.actState
self.actState=limitActivitiesModel:checkActState(LIMIT_ACT_TYPE.eXianMengDiGong)
if old~=self.actState then
local callback=function()
if _this==nil then return end
_this:refreshView()
end
UIManager:showWindow("UIFightPrepareLoading",{para=1,startCallback=callback})
else
self:refreshView()
end
end

function UIXM_XMDG_MainWin:refreshFreeEventBtn()

self.freeEventBtn:setActive(xianmengdigongModel:isUnlockAll())
end

function UIXM_XMDG_MainWin:onFreeEventBtn()
local ok=false
if xianmengdigongController and xianmengdigongController.tryRescueSpeRewardStuck then
ok=pcall(function()
xianmengdigongController:tryRescueSpeRewardStuck('clickFreeEventBtn')
end)
end
self:showWindow("UIXM_XMDG_speEventWin")
end

function UIXM_XMDG_MainWin:refreshLockBtn()
local myActorid=playerModel:getActorID()
local isLeader=xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpAllyLeader)or xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpViceLeader)
self.lockBtn:setActive(isLeader)
end

function UIXM_XMDG_MainWin:onLockBtn()
self:showWindow("UIXM_XMDG_lockRoomWin")
end

function UIXM_XMDG_MainWin:refreshPassBtn()
local open=xianmengdigongModel:getPassFirstTimeOpen()
local isShow=open and self.actState==limitActivitiesModel.actDoingState
self.passBtn:setActive(isShow)
if isShow then
self:refreshPassBtnReddot()
end
end

function UIXM_XMDG_MainWin:refreshPassBtnReddot()
local rewardReddot=reddotClassManager.get_reddot(REDDIT_SUB_TYPE.sXMDGPass)
self.passBtnReddot:setActive(rewardReddot)
local limitInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianMengDiGong)
local endTime=tostring(limitInfo.end_time)
self.roundPassReddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'xmdgPassReddot',0)~=endTime
end

function UIXM_XMDG_MainWin:onPassBtn()
if self.roundPassReddot then
local limitInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianMengDiGong)
local endTime=tostring(limitInfo.end_time)
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,'xmdgPassReddot',endTime,0)
xianmengdigongController.refreshXMDGPassReddot()
end
UIFullXMDGMiLingControl:showWindowMiLingWin({nextFunc=function()
xianmengdigongController:finishFightOpen()
end})
end