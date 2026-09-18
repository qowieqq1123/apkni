







def_class("UIXM_XMDG_roomWin",UIWindowBase)









function UIXM_XMDG_roomWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.roomBG=UIImage.get(self,2)
self.titleTxt=UIText.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.event1GridPanel=UIObject.get(self,5)
self.event2GridPanel=UIObject.get(self,6)
self.rankBtn=UIButton.get(self,7)
self.rankReddot=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)



end


function UIXM_XMDG_roomWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roomBG);self.roomBG=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.event1GridPanel);self.event1GridPanel=nil;
_UIObject_release(self.event2GridPanel);self.event2GridPanel=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rankReddot);self.rankReddot=nil;
end
















local _this=nil


function UIXM_XMDG_roomWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_XMDG_roomWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_roomWin:onHide()

end




function UIXM_XMDG_roomWin:onShow(argtable,afterOnloaded)
self.roomid=argtable.roomid
self.m_room=xianmengdigongModel:getRoom(self.roomid)

local cfg=cfgHelper.get1(cfg_guilddigongroomconfig_get,self.m_room.roomConfId)
local skinID=cfg.skinID
local abname,bgicon=xianmengdigongModel:getRoomBIconName(skinID)
self.roomBG:setSprite(abname,bgicon)
local name_str=cfg.name
self.titleTxt:setText(name_str)

self:refreshView()

if self.updateTimer==nil then
self.updateTimer=self:setTimer(1,0,function()
self:updataTime()
end)
end

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4118,1,{},2044,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.15,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
end
self:refreshRankBtnShow()
self:refreshRankBtn()

if argtable.seqIdx then
self.seqIdx=argtable.seqIdx
else
local seqList=xianmengdigongModel:getAllEventSequenceList_doing_idle()
for i,v in ipairs(seqList)do
if v==self.roomid then
self.seqIdx=i
break
end
end
end
end

function UIXM_XMDG_roomWin:updataTime()
if self.needRebuild==true then
self.needRebuild=nil
self:refreshView()
return
end

local c=#self.eventslist
if c>0 then
local grids=self.event1GridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:refreshEvent1ItemTime(item,i)
end
end
local c=#self.events2list
if c>0 then
local grids=self.event2GridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:refreshEvent2ItemTime(item,i)
end
end
end

function UIXM_XMDG_roomWin:refreshRankBtn()
local isReddot=self.m_room:hasRankReward()
self.rankReddot:setActive(isReddot)
end

function UIXM_XMDG_roomWin:refreshRankBtnShow()
self.rankBtn:setActive(self.m_room:hasRank())
end

function UIXM_XMDG_roomWin:refreshView()
local events=self.m_room:getEvents_doing_idle()
self.eventslist={}
self.events2list={}
for i,event in ipairs(events)do
if event:isLimitEvent()then
table.insert(self.events2list,event)
else
table.insert(self.eventslist,event)
end
end
self.event1GridPanel:setChildLayoutGroupCreateItems(#self.eventslist,function(idx)
if _this==nil then return end
_this:initEvent1Item(nil,idx)
end)
self.event2GridPanel:setChildLayoutGroupCreateItems(#self.events2list,function(idx)
if _this==nil then return end
_this:initEvent2Item(nil,idx)
end)
end



function UIXM_XMDG_roomWin:findEvent1(eventPos)
for idx,event in ipairs(self.eventslist)do
if event.eventPos==eventPos then
return idx
end
end
end

function UIXM_XMDG_roomWin:initEvent1Item(item,idx)
if item==nil then
item=self.event1GridPanel:getChildLayoutGroupGridItem(idx-1)
end
local event=self.eventslist[idx]

item:SetChildLocalPos(-1,event.posx,event.posy,0)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onEevent1Click(idx)
end)







self:refreshEvent1Item(item,idx)
self:refreshEvent1ItemTime(item,idx)
end

function UIXM_XMDG_roomWin:refreshEvent1Item(item,idx)
if item==nil then
item=self.event1GridPanel:getChildLayoutGroupGridItem(idx-1)
end
local event=self.eventslist[idx]
local dzList=event.dzList
local maxnum=event.maxman
local curman=event.curman
local hasman=curman>0
item:SetChildActive(3,hasman)
item:SetChildActive(4,hasman)
if hasman then
local n=math.min(3,maxnum)
item:SetChildLayoutGroupCreateItems(3,n)
local grids=item:GetChildLayoutGroupGridList(3)
for i=1,n do
local itemHead=grids[i-1]
local data=dzList[i]
local has=data~=nil
itemHead:SetChildActive(0,not has)
itemHead:SetChildActive(1,has)
local showSign=false
if has then

local image=UIDiscipleModel.calculationDiscipleImageBase(data)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelHeadIconBGByColor(itemHead,1,image.color)
comHelper.setChildModelRawImageEx(2,itemHead,modelParams,eHeadCenterType.eHead,1,false)

showSign=event:hasDZ(data.dzGuid)
end

itemHead:SetChildActive(3,showSign)

local showmulti=i>=3 and curman>=3
itemHead:SetChildActive(4,showmulti)
end
end
end

function UIXM_XMDG_roomWin:refreshEvent1ItemTime(item,idx)
if item==nil then
item=self.event1GridPanel:getChildLayoutGroupGridItem(idx-1)
end
local event=self.eventslist[idx]
local state,cur,max,lerp_t=event:getState()
if state==xmdgEventState.eDoing then
local rate=cur/max
item:SetChildIconFillAmount(1,rate)
local str=timeHelper.format_time_stamp(lerp_t,true)
item:SetChildText(2,str)
elseif state==xmdgEventState.eIdle then
item:SetChildIconFillAmount(1,0)
item:SetChildText(2,'')
else
self.needRebuild=true
end
end

function UIXM_XMDG_roomWin:onEevent1Click(idx)
local event=self.eventslist[idx]
local state=event:getState()
if state==xmdgEventState.eDoing or state==xmdgEventState.eIdle then
self:showWindow('UIXM_XMDG_eventWin',{roomid=self.roomid,eventPos=event.eventPos,cleanPosLookup=true})
end
end





function UIXM_XMDG_roomWin:findEvent2(eventPos)
for idx,event in ipairs(self.events2list)do
if event.eventPos==eventPos then
return idx
end
end
end

function UIXM_XMDG_roomWin:initEvent2Item(item,idx)
if item==nil then
item=self.event2GridPanel:getChildLayoutGroupGridItem(idx-1)
end

item:SetChildLocalPos(-1,event.posx,event.posy,0)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onEevent2Click(idx)
end)







self:refreshEvent2ItemTime(item,idx)
end

function UIXM_XMDG_roomWin:refreshEvent2ItemTime(item,idx)
if item==nil then
item=self.event1GridPanel:getChildLayoutGroupGridItem(idx-1)
end
local event=self.events2list[idx]
local state,cur,max,lerp_t=event:getState()
if state==xmdgEventState.eDoing then
local rate=lerp_t/max
item:SetChildIconFillAmount(1,rate)
local str=timeHelper.format_time_stamp(lerp_t,true)
item:SetChildText(2,str)
else
self.needRebuild=true
end
end

function UIXM_XMDG_roomWin:onEevent2Click(idx)
local event=self.events2list[idx]
local state=event:getState()
if state==xmdgEventState.eDoing then
self:showWindow('UIXM_XMDG_eventWin',{roomid=self.roomid,eventPos=event.eventPos,cleanPosLookup=true})
end
end



function UIXM_XMDG_roomWin:rec_refreshEvent(roomid,eventPos)
if roomid==self.roomid then
local idx=self:findEvent1(eventPos)
if idx then
local item=self.event1GridPanel:getChildLayoutGroupGridItem(idx-1)
self:refreshEvent1Item(item,idx)
self:refreshEvent1ItemTime(item,idx)
else
idx=self:findEvent2(eventPos)
if idx then
local item=self.event2GridPanel:getChildLayoutGroupGridItem(idx-1)
self:refreshEvent2ItemTime(item,idx)
end
end
end
end

function UIXM_XMDG_roomWin:rec_rankReward()
self:refreshRankBtn()
end

function UIXM_XMDG_roomWin:onCloseBtn()
self:closeSelf()
end

function UIXM_XMDG_roomWin:onRankBtn()
self:showWindow("UIXM_XMDG_bossRankWin",{roomid=self.roomid})
end

function UIXM_XMDG_roomWin:rec_previousRoom()
local seqIdx=self.seqIdx-1
local seqList=xianmengdigongModel:getAllEventSequenceList_doing_idle()
if seqIdx<=0 then
seqIdx=#seqList
end
local roomid=seqList[seqIdx]
local room=xianmengdigongModel:getRoom(roomid)
local eventPosList=room:getEventPosList()
local tEventPos=eventPosList[1]
for i,eventPos in ipairs(eventPosList)do
local event=room:getEvent(eventPos)
local state=event:getState()
if state==xmdgEventState.eIdle or state==xmdgEventState.eDoing then
tEventPos=event.eventPos
break
end
end
self:onShow({roomid=roomid,seqIdx=seqIdx})
self:showWindow('UIXM_XMDG_eventWin',{roomid=roomid,eventPos=tEventPos,cleanPosLookup=true})
end

function UIXM_XMDG_roomWin:rec_nextRoom()
local seqIdx=self.seqIdx+1
local seqList=xianmengdigongModel:getAllEventSequenceList_doing_idle()
if seqIdx>#seqList then
seqIdx=1
end
local roomid=seqList[seqIdx]
local room=xianmengdigongModel:getRoom(roomid)
local eventPosList=room:getEventPosList()
local tEventPos=eventPosList[1]
for i,eventPos in ipairs(eventPosList)do
local event=room:getEvent(eventPos)
local state=event:getState()
if state==xmdgEventState.eIdle or state==xmdgEventState.eDoing then
tEventPos=event.eventPos
break
end
end
self:onShow({roomid=roomid,seqIdx=seqIdx})
self:showWindow('UIXM_XMDG_eventWin',{roomid=roomid,eventPos=tEventPos,cleanPosLookup=true})
end
