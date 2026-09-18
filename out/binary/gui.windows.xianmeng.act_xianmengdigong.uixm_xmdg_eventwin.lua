







def_class("UIXM_XMDG_eventWin",UIWindowBase)









function UIXM_XMDG_eventWin:bindComponents()

self.beginBtn=UIButton.get(self,0)
self.checkBtn=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.condSpeobj=UIObject.get(self,3)
self.condTxt=UIText.get(self,4)
self.continuTxt=UIText.get(self,5)
self.descTxt=UIText.get(self,6)
self.eventPlotImg=UIImage.get(self,7)
self.frameSp=UIObject.get(self,8)
self.headItem=UIObject.get(self,9)
self.leftArrow=UIButton.get(self,10)
self.nextRoot=UIObject.get(self,11)
self.rewardBtn=UIButton.get(self,12)
self.rewardPanel=UIObject.get(self,13)
self.rightArrow=UIButton.get(self,14)
self.root=UIObject.get(self,15)
self.ruleBtn=UIButton.get(self,16)
self.time1DescTxt=UIText.get(self,17)
self.time1Progress=UIObject.get(self,18)
self.time1ProgressImg=UIObject.get(self,19)
self.time2Progress=UIObject.get(self,20)
self.time2ProgressImg=UIObject.get(self,21)
self.time2ProgresTxt=UIText.get(self,22)
self.tipsObj=UIObject.get(self,23)
self.tipsObjBtn=UIButton.get(self,24)
self.tipsTxt=UIText.get(self,25)
self.titleTxt=UIText.get(self,26)
self.warmingBtn=UIButton.get(self,27)

self.beginBtn:setButtonClick(function()self:onBeginBtn()end)

self.checkBtn:setButtonClick(function()self:onCheckBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.tipsObjBtn:setButtonClick(function()self:onTipsObjBtn()end)

self.warmingBtn:setButtonClick(function()self:onWarmingBtn()end)



end


function UIXM_XMDG_eventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.beginBtn);self.beginBtn=nil;
_UIObject_release(self.checkBtn);self.checkBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.condSpeobj);self.condSpeobj=nil;
_UIObject_release(self.condTxt);self.condTxt=nil;
_UIObject_release(self.continuTxt);self.continuTxt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.eventPlotImg);self.eventPlotImg=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.headItem);self.headItem=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.nextRoot);self.nextRoot=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.time1DescTxt);self.time1DescTxt=nil;
_UIObject_release(self.time1Progress);self.time1Progress=nil;
_UIObject_release(self.time1ProgressImg);self.time1ProgressImg=nil;
_UIObject_release(self.time2Progress);self.time2Progress=nil;
_UIObject_release(self.time2ProgressImg);self.time2ProgressImg=nil;
_UIObject_release(self.time2ProgresTxt);self.time2ProgresTxt=nil;
_UIObject_release(self.tipsObj);self.tipsObj=nil;
_UIObject_release(self.tipsObjBtn);self.tipsObjBtn=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.warmingBtn);self.warmingBtn=nil;
end
















local _this=nil


function UIXM_XMDG_eventWin:onLoaded(...)
_this=self
self:bindComponents()
self.eventPosLookup={}
end


function UIXM_XMDG_eventWin:__delete()
_this=nil
self:unbindComponents()
self.eventPosLookup=nil
end


function UIXM_XMDG_eventWin:onHide()

end




function UIXM_XMDG_eventWin:onShow(argtable,afterOnloaded)
self.roomid=argtable.roomid
self.eventPos=argtable.eventPos
self.m_room=xianmengdigongModel:getRoom(self.roomid)
self.m_event=self.m_room:getEvent(self.eventPos)
if self.m_event==nil then
loggerUtil.logErrFMT('没找到仙盟地宫事件 roomid : {0} eventPos:{1}',tostring(self.roomid),tostring(self.eventPos))
end
if argtable.cleanPosLookup then
self.eventPosLookup={}
end
self.eventPosLookup[self.eventPos]=true
self.eventcfg=cfgHelper.get1(cfg_guilddigongeventconfig_get,self.m_event.eventId)
self:initManList()


self.firstIn=false
self:updataNext()
self:refreshInfo()
self:refreshArrow()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4113,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.35,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
end
end

function UIXM_XMDG_eventWin:initManList()
local m_event=self.m_event
self.manlist={}
if m_event.dzList then
for i,man in ipairs(m_event.dzList)do
table.insert(self.manlist,man)
end
end
end

function UIXM_XMDG_eventWin:updataNext()
self.nextRoot:setActive(not self.firstIn)
self.continuTxt:setActive(self.firstIn)
end

function UIXM_XMDG_eventWin:refreshArrow()
local seqList=xianmengdigongModel:getAllEventSequenceList_doing_idle()
local isShow=false
if#seqList>1 then
isShow=true
elseif#seqList==1 then
local roomid=seqList[1]
local room=xianmengdigongModel:getRoom(roomid)
local events=room:getEvents_doing_idle()
if#events>1 then
isShow=true
end
end

self.leftArrow:setActive(isShow)
self.rightArrow:setActive(isShow)
self:doSwingArrow(isShow)
end

function UIXM_XMDG_eventWin:doSwingArrow(isShow)
if isShow then
if self.leftSwingTweener==nil and self.rightSwingTweener==nil then
local leftPos=self.leftArrow:getChildLocalPosition()
local tweener=self.leftArrow:setChildDOLocalMoveX(leftPos.x-10,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.leftSwingTweener=tweener

local rightPos=self.rightArrow:getChildLocalPosition()
local tweener=self.rightArrow:setChildDOLocalMoveX(rightPos.x+10,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.rightSwingTweener=tweener
end
else
if self.leftSwingTweener then
self.leftSwingTweener:Complete()
self.leftSwingTweener:Kill()
self.leftSwingTweener=nil
end
if self.rightSwingTweener then
self.rightSwingTweener:Complete()
self.rightSwingTweener:Kill()
self.rightSwingTweener=nil
end
end
end

function UIXM_XMDG_eventWin:refreshInfo()
local cfg=self.eventcfg

self.titleTxt:setText(cfg.title)

local iconname=iconHelper.getEventChahuaIcon(cfg.plotIcon)
self.eventPlotImg:setImageIcon(iconname,true)

self.descTxt:setText(cfg.plotDesc)

local showWarm=cfg.warmTips~=nil
self.warmingBtn:setActive(showWarm)

local dzNeed=cfg.dzNeed
local cond_str=''
self.cond_spe=nil
if dzNeed and#dzNeed>0 then
local n=0
for i,v in ipairs(dzNeed)do
local s
if v[1]==1 then
n=n+1
s=xianmengdigongModel:get_eventCond_desc4(v[2],v[3])
elseif v[1]==2 then
self.cond_spe=v
end
if s then
if n==1 then
cond_str=s
else
cond_str=FMT.fmt('{0}  {1}',cond_str,s)
end
end
end
else
cond_str='无'
end
local cond_title=FMT.fmt('<color=#efb150>要求：</color>{0}',cond_str)
self.condTxt:setText(cond_title)
local showspe=self.cond_spe~=nil
local specfg
if showspe then
specfg=UIDiscipleModel:getSpecialityConfig(self.cond_spe[2],self.cond_spe[3])
showspe=specfg~=nil






end
self.condSpeobj:setActive(showspe)
if showspe then
local specfg=UIDiscipleModel:getSpecialityConfig(self.cond_spe[2],self.cond_spe[3])
local speitem=self.condSpeobj:getChildWidgetBase()
UIDiscipleModel.refreshSpecialityItemExx(speitem,specfg)
speitem:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onCondSpeBG()
end)
end

local rewards={}
local zmlv=zongmenModel:getLevel()
local list=zongmenControl:getRewardConfigData(cfg.playerReward,zmlv)
if list~=nil and#list>0 then
for i2,v2 in ipairs(list)do
local itemcfg=itemsConfig.getConfig(v2[1])
table.insert(rewards,{v2[1],v2[2],itemcfg.color})
end
end
local c=#rewards
if c>1 then
table.sort(rewards,function(a,b)
return a[3]>b[3]
end)
end
self.rewardPanel:setChildLayoutGroupCreateItems(c)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<=0
item:SetChildActive(1,showSign)
end

self:refreshTimeObj()

self:refreshManPanel()
end

function UIXM_XMDG_eventWin:refreshTimeObj()
local cfg=self.eventcfg
local showTime1=cfg.eventType==xmdgEventType.eCommon
local showTime2=cfg.eventType==xmdgEventType.eLimit
local state=self.m_event:getState()
showTime1=showTime1 and state==xmdgEventState.eDoing
showTime2=showTime2 and state==xmdgEventState.eDoing
self.time1Progress:setActive(showTime1)
self.time2Progress:setActive(showTime2)
if self.updateTimer==nil then
self.updateTimer=self:setTimer(1,0,function()
self:refreshTimeDesc()
end)
self:refreshTimeDesc()
end
end

function UIXM_XMDG_eventWin:refreshTimeDesc()
local cfg=self.eventcfg
local state,cur,max,lerp_t=self.m_event:getState()
if state==xmdgEventState.eDoing then
local rate=cur/max
if cfg.eventType==xmdgEventType.eCommon then
self.time1ProgressImg:setChildIconFillAmount(rate)
local str=FMT.fmt('预计所需时间：{0}',timeHelper.format_time_stamp3(lerp_t))
self.time1DescTxt:setText(str)
elseif cfg.eventType==xmdgEventType.eLimit then
self.time2ProgressImg:setChildIconFillAmount(rate)
local lerp=max-cur
if lerp<0 then lerp=0 end
self.time2ProgresTxt:setText(timeHelper.format_time_stamp3(lerp))
end
elseif state==xmdgEventState.eIdle then

else
if cfg.eventType==xmdgEventType.eCommon then
UIManager.info('事件已完成')
elseif cfg.eventType==xmdgEventType.eLimit then
UIManager.info('没有及时处理紧急事件')
end
self:closeSelf()
end
end

function UIXM_XMDG_eventWin:refreshManPanel()
local m_event=self.m_event
local dzList=self.manlist
local maxnum=m_event.maxman
local curman=#dzList
local mydz=m_event:getMyDZ()
local hasMy=mydz~=nil

local widget=self.headItem:getChildWidgetBase()
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onAddDZClick()
end)
widget:SetChildActive(1,hasMy)
widget:SetChildActive(4,hasMy)
if hasMy then

comHelper.setChildModelHeadIconBG(widget,1,mydz)

comHelper.setChildModelRawImage(widget,mydz,2,0,eHeadCenterType.eHead)

local hp=xianmengdigongModel:getDZBlood(mydz)
widget:SetChildIconFillAmount(5,hp/10000)
end

local isGray=false
local desc_str
if hasMy then
desc_str=playerModel:getActorName()
else
if curman>=maxnum then
desc_str='已满员'
isGray=true
else
desc_str='可派遣'
end
end
widget:SetChildText(3,desc_str)

widget:SetChildGraphicGray(0,isGray,true)

local showCheckBtn=self.eventcfg.eventType~=xmdgEventType.eLimit
self.checkBtn:setActive(showCheckBtn)
local showBeginBtn=self.eventcfg.eventType==xmdgEventType.eLimit and curman>=maxnum
self.beginBtn:setActive(showBeginBtn)
end

function UIXM_XMDG_eventWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_XMDG_eventWin:onAddDZClick()
if xianmengdigongModel:checkPassFlag(true)then
return
end

local m_event=self.m_event
local dzList=self.manlist
local maxnum=m_event.maxman
local curman=#dzList
local mydz=m_event:getMyDZ()
local hasMy=mydz~=nil
local cfg=self.eventcfg
local select_dz_=nil
local checkAdd=false
local err_str

if cfg.eventType==xmdgEventType.eCommon then
if not hasMy then
if curman<maxnum then
checkAdd=true
else
err_str='该事件已满员'
end
else
err_str=xianmengdigongController.getHasManTips()
end
elseif cfg.eventType==xmdgEventType.eLimit then
select_dz_=mydz
checkAdd=true
end
if checkAdd then
local args={eventId=m_event.eventId,select_dz=select_dz_}
args.callback=function(dzguid)
if _this==nil then return end
_this:onSelectBack(dzguid)
end
local winParams={
titleName='派遣弟子',
extraWin='UIXM_XMDG_eventSelectDZWin',
extraParams=args,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
else
if err_str then
UIManager.error(err_str)
end
end
end

function UIXM_XMDG_eventWin:onSelectBack(dzguid)
local cfg=self.eventcfg
if cfg.eventType==xmdgEventType.eCommon then
local x=self.m_room.base.x
local y=self.m_room.base.y
local eventPos=self.m_event.eventPos
xianmengdigongController:send_20_106(x,y,eventPos,dzguid,1)
elseif cfg.eventType==xmdgEventType.eLimit then
self.manlist={}
self.manlist[1]=xianmengdigongModel:newEventMan(dzguid)

self:refreshManPanel()
end
end

function UIXM_XMDG_eventWin:onBeginBtn()
local man=self.manlist[1]
if man then

end
end

function UIXM_XMDG_eventWin:onCheckBtn()
UIManager:showWindow('UIXM_XMDG_eventCheckWin',{roomid=self.roomid,eventPos=self.eventPos})
end

function UIXM_XMDG_eventWin:onBlockClick()
if self.firstIn then
self.firstIn=false
xianmengdigongModel:setFirstInEvent(self.m_event.eventId)
self:updataNext()
end
end

function UIXM_XMDG_eventWin:onLeftArrow()
local eventPosList=self.m_room:getEventPosList()
local ok=false
local tEventPos=eventPosList[#eventPosList]
for i=#eventPosList,1,-1 do
local eventPos=eventPosList[i]
if not self.eventPosLookup[eventPos]then
local event=self.m_room:getEvent(eventPos)
if event then
local state=event:getState()
if state==xmdgEventState.eIdle or state==xmdgEventState.eDoing then
tEventPos=eventPos
ok=true
break
end
end
end
end
if ok then
self:onShow({roomid=self.roomid,eventPos=tEventPos})
return
end
UIManager:invokeUIMethod('UIXM_XMDG_roomWin','rec_previousRoom')
end

function UIXM_XMDG_eventWin:onRightArrow()
local eventPosList=self.m_room:getEventPosList()
local ok=false
local tEventPos=eventPosList[1]
for i,eventPos in ipairs(eventPosList)do
if not self.eventPosLookup[eventPos]then
local event=self.m_room:getEvent(eventPos)
if event then
local state=event:getState()
if state==xmdgEventState.eIdle or state==xmdgEventState.eDoing then
tEventPos=eventPos
ok=true
break
end
end
end
end
if ok then
self:onShow({roomid=self.roomid,eventPos=tEventPos})
return
end
UIManager:invokeUIMethod('UIXM_XMDG_roomWin','rec_nextRoom')
end

function UIXM_XMDG_eventWin:onRuleBtn()
local d={}
d.title='事件规则'
d.mode=3
d.num=5
d.name='act_xmdg_event_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXM_XMDG_eventWin:onWarmingBtn()
local pos=Vector2.New(15,30)
local str=self.eventcfg.warmTips
local posItem=self.warmingBtn
UIManager:showWindow('UIConditionTipsOne',{str=str,pos=pos,posItem=posItem,showType=2})
end

function UIXM_XMDG_eventWin:onTime2Click()
if self.tipsObjStr==nil then
self.tipsObjStr=cfgHelper.getlang('xmgd_tips_1')or'xmgd_tips_1'
self.tipsTxt:setText(self.tipsObjStr)
end
self.tipsObj:setActive(true)
end

function UIXM_XMDG_eventWin:onTipsObjBtn()
self.tipsObj:setActive(false)
end

function UIXM_XMDG_eventWin:onCondSpeBG()
local specfg=UIDiscipleModel:getSpecialityConfig(self.cond_spe[2],self.cond_spe[3])
specfg.specialitytype=self.cond_spe[2]
local speitem=self.condSpeobj:getChildWidgetBase()
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',config=specfg})
end

function UIXM_XMDG_eventWin:onRewardBtn()
local cfg=self.eventcfg
local desc='以下物品在事件完成后进入贡献商店'
self:showWindow('UIXM_XMDG_rewardShowWin',{rewardid=cfg.shopReward,posx=178,posy=-80,desc=desc})
end

function UIXM_XMDG_eventWin:rec_event(room,event)
if self.m_room:compare(room)and self.m_event.eventPos==event.eventPos then
self:initManList()
self:refreshTimeObj()
self:refreshManPanel()
end
end

function UIXM_XMDG_eventWin:onCloseBtn()
self:closeSelf()
end
