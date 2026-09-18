







def_class("UIXM_XMDG_eventRewardWin",UIWindowBase)









function UIXM_XMDG_eventRewardWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.rewardScrollView=UIObject.get(self,2)
self.rewardBtn=UIButton.get(self,3)
self.itemGridPanel=UIObject.get(self,4)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIXM_XMDG_eventRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
end
















local _this=nil


function UIXM_XMDG_eventRewardWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_XMDG_eventRewardWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_eventRewardWin:onHide()

end




function UIXM_XMDG_eventRewardWin:onShow(argtable,afterOnloaded)
self:refreshView()

self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4110,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.2,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
end

function UIXM_XMDG_eventRewardWin:refreshView()
local list=xianmengdigongModel:getAllHasRewardEventEx()or{}
self.rewardlist={}
if#list>0 then
for i,d in ipairs(list)do
local room=xianmengdigongModel:getRoom2(d.x,d.y)
local event=room:getEvent(d.eventPos)
local eventname=cfgHelper.get2(cfg_guilddigongeventconfig_get,event.eventId,'title')
local dzguid=d.dzguid
local dzname=UIDiscipleModel:getDiscipleName(dzguid)or event:getDZName(dzguid)
local rewards=d.rewards
local state=event:getState()
local hasReward=state==xmdgEventState.eReward

local data1={}
data1.hasReward=hasReward
data1.desc=FMT.fmt(cfgHelper.getlang('xmgd_tips_3'),dzname or'',eventname)
data1.rewards={}
if rewards[1]~=nil and#rewards[1]>0 then
for i2,v in ipairs(rewards[1])do
local itemConfig=itemsConfig.getConfig(v.param_1)
table.insert(data1.rewards,{v.param_1,v.param_2,itemConfig.color})
end
if#data1.rewards>1 then
table.sort(data1.rewards,function(a,b)
return a[3]>b[3]
end)
end
end
table.insert(self.rewardlist,data1)

if rewards[2]~=nil and#rewards[2]>0 then
local data={}
data.hasReward=hasReward
data.desc=FMT.fmt(cfgHelper.getlang('xmgd_tips_4'),dzname,eventname)
data.rewards={}
for i2,v in ipairs(rewards[2])do
local itemConfig=itemsConfig.getConfig(v.param_1)
table.insert(data.rewards,{v.param_1,v.param_2,itemConfig.color})
end
if#data.rewards>1 then
table.sort(data.rewards,function(a,b)
return a[3]>b[3]
end)
end
table.insert(self.rewardlist,data)
end
if rewards[3]~=nil and#rewards[3]>0 then
local data={}
data.hasReward=hasReward
data.desc=FMT.fmt(cfgHelper.getlang('xmgd_tips_5'),dzname,eventname)
data.rewards={}
for i2,v in ipairs(rewards[3])do
local itemConfig=itemsConfig.getConfig(v.param_1)
table.insert(data.rewards,{v.param_1,v.param_2,itemConfig.color})
end
if#data.rewards>1 then
table.sort(data.rewards,function(a,b)
return a[3]>b[3]
end)
end
table.insert(self.rewardlist,data)
end
end
end
local c=#self.rewardlist
self.itemGridPanel:setChildLayoutGroupCreateItems(c,function(idx)
if _this==nil then return end
_this:initGridItem(nil,idx)
end)
if c==1 then
self.rewardScrollView:setChildSizeDelta(808,300)
else
self.rewardScrollView:setChildSizeDelta(808,471)
end
end

function UIXM_XMDG_eventRewardWin:initGridItem(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local d=self.rewardlist[idx]

item:SetChildText(0,d.desc)

local rewards=d.rewards
local c=#rewards
item:SetChildLayoutGroupCreateItems(1,c)
local grids=item:GetChildLayoutGroupGridList(1)
for i=1,c do
local itemReward=grids[i-1]
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
itemReward:SetChildPropData(0,prop)
itemReward:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=false
itemReward:SetChildActive(1,showSign)



end

local hasReward=d.hasReward
item:SetChildActive(2,not hasReward)
end

function UIXM_XMDG_eventRewardWin:refreshGridItemSign(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildActive(2,true)
end

function UIXM_XMDG_eventRewardWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_XMDG_eventRewardWin:onRewardBtn()
local list=xianmengdigongModel:getAllHasRewardEventEx()
if list~=nil and#list>0 then
local eventList={}
for i,d in ipairs(list)do
table.insert(eventList,{d.x,d.y,d.eventPos})
end
xianmengdigongController:send_20_113(eventList)
else
UIManager.info('暂无奖励可领')
end
end

function UIXM_XMDG_eventRewardWin:rec_refreh()
self:refreshView()
end

function UIXM_XMDG_eventRewardWin:rec_rewards()
local grids=self.itemGridPanel:getChildLayoutGroupGridList()
local c=#self.rewardlist
for i=1,c do
local item=grids[i-1]
self:refreshGridItemSign(item,i)
end
end
