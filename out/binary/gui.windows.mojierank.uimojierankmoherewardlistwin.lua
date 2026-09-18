







def_class("UIMoJieRankMoHeRewardListWin",UIWindowBase)









function UIMoJieRankMoHeRewardListWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.rankScrollView=UILoopListView.new(self,2)
self.menuGridPanel=UIObject.get(self,3)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rankScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIMoJieRankMoHeRewardListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.rankScrollView:deleteSelf();self.rankScrollView=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
end


















local pageConfig=
{
[1]={
page=1,
name='个人',
checkReddot=function()
return false
end,
ranktype=1,
},
[2]={
page=2,
name='仙盟',
checkReddot=function()
return false
end,
ranktype=2,
},
}
local menu_slot_name='button_dytab'
local rankItemCmpIndex={
bg=0,
rankText=1,
rewardScrollView=2,
}

local rewardtype=
{
personal=1,
XM=2,
}
local _this

function UIMoJieRankMoHeRewardListWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIMoJieRankMoHeRewardListWin:__delete()
self:unbindComponents()
end




function UIMoJieRankMoHeRewardListWin:onShow(argtable,afterOnloaded)
local nowsaijiid=xianjieController:getMoJieSaiJiID()
self.mojiecfg=cfgHelper.get1(cfg_mojiemoherankconfig_get,nowsaijiid)
if self.mojiecfg then
self.rankType=argtable and argtable.rankType or 1
local page=1
self.showPageCfgList={}
self.pageLookup={}
for i,v in ipairs(pageConfig)do
local idx=#self.showPageCfgList+1
self.showPageCfgList[idx]=v
self.pageLookup[v.page]=idx
if self.rankType==v.ranktype then
page=v.page
end
end
local idx=self.pageLookup[page]
if afterOnloaded then
local cnt=#self.showPageCfgList
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=self.showPageCfgList[i]
item:SetChildText(1,cfg.name)
local isSelected=i==idx
local func=function()
if _this==nil then return end
if isSelected then
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,isSelected)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end

self:onMenuItemClick(idx)
end


end


function UIMoJieRankMoHeRewardListWin:onHide()

end

function UIMoJieRankMoHeRewardListWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end


function UIMoJieRankMoHeRewardListWin:onMenuItemClick(idx)
local cfg=self.showPageCfgList[idx]
if cfg.page==self.curPage then
return
end
local old=self.curPage
self.curPage=cfg.page
if old~=nil then
local idx_=self.pageLookup[old]
self:refreshMenuItemSelect(nil,idx_,false)
end
self:refreshMenuItemSelect(nil,idx,true)
self:refreshMenuPage()
end


function UIMoJieRankMoHeRewardListWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=self.showPageCfgList[idx]
local ranktype=cfg.ranktype
self.rankType=ranktype
self:refresh()
end

function UIMoJieRankMoHeRewardListWin:refresh()
local rankType=self.rankType
local cfgrank,baodicfg=self:getTypeReward(self.curPage)
local cfgrewards=cfgrank[rankType]

local temp={}
for k,v in ipairs(cfgrank)do
table.insert(temp,v)
end
if baodicfg then
table.insert(temp,baodicfg)
end


self.rewardCfgList=temp
local _slotName='item'
self.rankScrollView:initData(_slotName,self.rewardCfgList)
end


function UIMoJieRankMoHeRewardListWin:getTypeReward(flag)
if flag==1 then
return self.mojiecfg.reward1,self.mojiecfg.reward3
elseif flag==2 then
return self.mojiecfg.reward2,self.mojiecfg.reward4
end
end

function UIMoJieRankMoHeRewardListWin:onFreshAction(i,widget)
self:fillItem(widget,i)
end
function UIMoJieRankMoHeRewardListWin:onStartAction()

end
function UIMoJieRankMoHeRewardListWin:fillItem(widget,index)
local rewardCfg=self.rewardCfgList[index]

local minRank=rewardCfg[1]
local maxRank=rewardCfg[2]

local rankStr
local rewards

if index==#self.rewardCfgList then
rewards=rewardCfg
rankStr='有积分但未上榜'
else
if minRank==maxRank then
rankStr=FMT.fmt("第{0}名",minRank)
else
rankStr=FMT.fmt("第{0}-{1}名",minRank,maxRank)
end
rewards=rewardCfg[3]
end
widget:SetChildText(rankItemCmpIndex.rankText,rankStr)


local len=rewards~=nil and#rewards or 0
widget:SetChildScrollViewCreateGrids(rankItemCmpIndex.rewardScrollView,len,len)
local grids=widget:GetChildScrollViewItemWidgets(rankItemCmpIndex.rewardScrollView)
local count=grids.Count
local data={}
for i=1,count do
table.clear(data)
local widget1=grids[i-1]
local reward=rewards[i]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
widgetHelper.setNormalRewardItem(widget1,0,data)
end
end




function UIMoJieRankMoHeRewardListWin:onClickMask()
return self:onCloseBtn()
end
function UIMoJieRankMoHeRewardListWin:onCloseBtn()
self:closeSelf()
end

