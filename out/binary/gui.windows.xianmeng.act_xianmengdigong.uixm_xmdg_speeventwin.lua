







def_class("UIXM_XMDG_speEventWin",UIWindowBase)









function UIXM_XMDG_speEventWin:bindComponents()

self.beginBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.condSpeobj=UIObject.get(self,2)
self.condTxt=UIText.get(self,3)
self.descTxt=UIText.get(self,4)
self.eventPlotImg=UIImage.get(self,5)
self.frameSp=UIObject.get(self,6)
self.headItem=UIObject.get(self,7)
self.nextRoot=UIObject.get(self,8)
self.rewardBtn=UIButton.get(self,9)
self.rewardPanel=UIObject.get(self,10)
self.root=UIObject.get(self,11)
self.ruleBtn=UIButton.get(self,12)
self.time1DescTxt=UIText.get(self,13)
self.time1Progress=UIObject.get(self,14)
self.time1ProgressImg=UIObject.get(self,15)
self.timesBg=UIImage.get(self,16)
self.timestext=UIText.get(self,17)
self.titleTxt=UIText.get(self,18)
self.warmingBtn=UIButton.get(self,19)

self.beginBtn:setButtonClick(function()self:onBeginBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.warmingBtn:setButtonClick(function()self:onWarmingBtn()end)



end


function UIXM_XMDG_speEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.beginBtn);self.beginBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.condSpeobj);self.condSpeobj=nil;
_UIObject_release(self.condTxt);self.condTxt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.eventPlotImg);self.eventPlotImg=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.headItem);self.headItem=nil;
_UIObject_release(self.nextRoot);self.nextRoot=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.time1DescTxt);self.time1DescTxt=nil;
_UIObject_release(self.time1Progress);self.time1Progress=nil;
_UIObject_release(self.time1ProgressImg);self.time1ProgressImg=nil;
_UIObject_release(self.timesBg);self.timesBg=nil;
_UIObject_release(self.timestext);self.timestext=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.warmingBtn);self.warmingBtn=nil;
end


















local _this=nil

function UIXM_XMDG_speEventWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_XMDG_speEventWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXM_XMDG_speEventWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local speRoom=xianmengdigongModel:getSpeRoomData()
self.eventPos=argtable.eventPos or 1
self.m_event=speRoom:getEvent(self.eventPos)
if self.m_room and self.m_room.getEvent then
local authoritative=self.m_room:getEvent(self.eventPos)
if authoritative then
self.m_event=authoritative
end
end

self.m_room=speRoom
self.eventcfg=cfgHelper.get1(cfg_guilddigongeventconfig_get,self.m_event.eventId)
self:initManList()

do
local ev=self.m_event
local ok,st=pcall(function()return ev and ev:getState()end)
platformSDK.printSDK('[XMDG][speEventWin.onShow]',
'eventPos='..tostring(self.eventPos),
'ev='..tostring(ev),
'eventId='..tostring(ev and ev.eventId),
'myRewardFlag='..tostring(ev and ev.myRewardFlag),
'startTime='..tostring(ev and ev.startTime),
'jinDu='..tostring(ev and ev.jinDu),
'dzCount='..tostring(ev and ev.dzList and#ev.dzList or 0),
'state='..tostring(ok and st or'ERR')
)
end

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4113,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.35,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
end

self.completed=false
self.firstIn=false
self:refreshTimeObj()

if self.m_event then
local state=self.m_event:getState()
local times=xianmengdigongModel:getExploreTimes(self.m_event.eventId)or 0
if state==xmdgEventState.eDoing and times>0 then
if self.timesBg then
self.timesBg:setActive(true)
end
if self.timestext then
self.timestext:setActive(true)
self.timestext:setText(FMT.fmt("探索{0}次",times))
end
else
if self.timesBg then
self.timesBg:setActive(false)
end
if self.timestext then
self.timestext:setActive(false)
end
end
end

self:refreshInfo()
if self.completed then
self:closeSelf()
end
end


function UIXM_XMDG_speEventWin:onHide()

end


function UIXM_XMDG_speEventWin:initManList()
local m_event=self.m_event
self.manlist={}
if m_event.dzList then
for i,man in ipairs(m_event.dzList)do
table.insert(self.manlist,man)
end
end
end

function UIXM_XMDG_speEventWin:updataNext()
self.nextRoot:setActive(not self.firstIn)

end

function UIXM_XMDG_speEventWin:refreshInfo()
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


local rwcfg=cfgHelper.get1(cfg_awardconfig_get,cfg.playerReward)
local list=rwcfg.showItems or{}
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
self:refreshManPanel()
self.rewardBtn:setActive(self.eventcfg.shopReward~=nil)

self:refreshTimeObj()
end

function UIXM_XMDG_speEventWin:refreshTimeObj()
local cfg=self.eventcfg
local showTime1=cfg.eventType==xmdgEventType.eCommon
local showTime2=cfg.eventType==xmdgEventType.eLimit
local state=self.m_event:getState()

showTime1=showTime1 and state==xmdgEventState.eDoing
showTime2=showTime2 and state==xmdgEventState.eDoing
self.time1Progress:setActive(showTime1)

if self.updateTimer==nil then
self.updateTimer=self:setTimer(1,0,function()
self:refreshTimeDesc()
end)
self:refreshTimeDesc()
end
end

function UIXM_XMDG_speEventWin:refreshTimeDesc()
local cfg=self.eventcfg
local state,cur,max,lerp_t=self.m_event:getState()
if state==xmdgEventState.eDoing then
local rate=cur/max
if cfg.eventType==xmdgEventType.eCommon then
self.time1ProgressImg:setChildIconFillAmount(rate)
local str=FMT.fmt('预计所需时间：{0}',timeHelper.format_time_stamp3(lerp_t))
self.time1DescTxt:setText(str)
end
elseif state==xmdgEventState.eIdle then

else
if self.m_event then
if state==xmdgEventState.eFinish or state==xmdgEventState.eFailed then
xianmengdigongModel:clearExploreTimes(self.m_event.eventId)
end
end
if cfg.eventType==xmdgEventType.eCommon then
UIManager.info('事件已完成')
elseif cfg.eventType==xmdgEventType.eLimit then
UIManager.info('没有及时处理紧急事件')
end
self.completed=true
end
end

function UIXM_XMDG_speEventWin:refreshManPanel()
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



local showBeginBtn=self.eventcfg.eventType==xmdgEventType.eLimit and curman>=maxnum
self.beginBtn:setActive(showBeginBtn)
end

function UIXM_XMDG_speEventWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_XMDG_speEventWin:onAddDZClick()




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
args.callback=function(dzguid,times)
if _this==nil then return end
_this:onSelectBack(dzguid,times)
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

function UIXM_XMDG_speEventWin:onSelectBack(dzguid,times)
times=times or 1
local cfg=self.eventcfg
if cfg.eventType==xmdgEventType.eCommon then
local speRoom=xianmengdigongModel:getSpeRoomData()
if speRoom and speRoom.getEvent then
self.m_room=speRoom
local ev=speRoom:getEvent(self.eventPos or 1)
if ev then
self.m_event=ev
self.eventPos=ev.eventPos
self.eventcfg=cfgHelper.get1(cfg_guilddigongeventconfig_get,ev.eventId)
cfg=self.eventcfg
end
end

local x=self.m_room.base.x
local y=self.m_room.base.y
local eventPos=self.m_event.eventPos

platformSDK.printSDK('[XMDG][speEventWin][send20_106]',
'x='..tostring(x),
'y='..tostring(y),
'eventPos='..tostring(eventPos),
'eventId='..tostring(self.m_event and self.m_event.eventId),
'dzguid='..tostring(dzguid),
'times='..tostring(times)
)

if self.m_event then
xianmengdigongModel:setExploreTimes(self.m_event.eventId,times)
end
if self.timesBg then
self.timesBg:setActive(true)
end
if self.timestext then
self.timestext:setActive(true)
self.timestext:setText(FMT.fmt("探索{0}次",times))
end
xianmengdigongController:send_20_106(x,y,eventPos,dzguid,times)
elseif cfg.eventType==xmdgEventType.eLimit then
self.manlist={}
self.manlist[1]=xianmengdigongModel:newEventMan(dzguid)

self:refreshManPanel()
end
end

function UIXM_XMDG_speEventWin:onBeginBtn()
local man=self.manlist[1]
if man then

end
end

function UIXM_XMDG_speEventWin:onCheckBtn()
UIManager:showWindow('UIXM_XMDG_eventCheckWin',{roomid=self.roomid,eventPos=self.eventPos})
end

function UIXM_XMDG_speEventWin:onBlockClick()
if self.firstIn then
self.firstIn=false
xianmengdigongModel:setFirstInEvent(self.m_event.eventId)
self:updataNext()
end
end

function UIXM_XMDG_speEventWin:onRuleBtn()
local d={}
d.title='事件规则'
d.mode=3
d.num=5
d.name='act_xmdg_event_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXM_XMDG_speEventWin:onWarmingBtn()
local pos=Vector2.New(15,30)
local str=self.eventcfg.warmTips
local posItem=self.warmingBtn
UIManager:showWindow('UIConditionTipsOne',{str=str,pos=pos,posItem=posItem,showType=2})
end

function UIXM_XMDG_speEventWin:onTime2Click()
if self.tipsObjStr==nil then
self.tipsObjStr=cfgHelper.getlang('xmgd_tips_1')or'xmgd_tips_1'
self.tipsTxt:setText(self.tipsObjStr)
end
self.tipsObj:setActive(true)
end

function UIXM_XMDG_speEventWin:onTipsObjBtn()
self.tipsObj:setActive(false)
end

function UIXM_XMDG_speEventWin:onCondSpeBG()
local specfg=UIDiscipleModel:getSpecialityConfig(self.cond_spe[2],self.cond_spe[3])
specfg.specialitytype=self.cond_spe[2]
local speitem=self.condSpeobj:getChildWidgetBase()
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',config=specfg})
end

function UIXM_XMDG_speEventWin:onRewardBtn()
local cfg=self.eventcfg
local desc='以下物品在事件完成后进入贡献商店'
self:showWindow('UIXM_XMDG_rewardShowWin',{rewardid=cfg.shopReward,posx=178,posy=-80,desc=desc})
end

function UIXM_XMDG_speEventWin:rec_event(room,event)
if not self.m_room or not self.m_room:compare(room)then
return
end
if event==nil or event.eventPos==nil then
return
end

local authoritative=room.getEvent and room:getEvent(event.eventPos)or nil
if authoritative~=nil then
self.m_room=room
self.m_event=authoritative
self.eventPos=authoritative.eventPos or self.eventPos
self.eventcfg=cfgHelper.get1(cfg_guilddigongeventconfig_get,authoritative.eventId)
end


do
platformSDK.printSDK('[XMDG][speEventWin.rec_event]',
'room='..tostring(room),
'pushEvent='..tostring(event),
'useEvent='..tostring(self.m_event)
)
end

self:initManList()
self:refreshTimeObj()
self:refreshManPanel()
end

function UIXM_XMDG_speEventWin:onCloseBtn()
self:closeSelf()
end
