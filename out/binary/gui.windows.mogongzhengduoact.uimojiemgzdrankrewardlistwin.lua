







def_class("UIMoJieMGZDRankRewardListWin",UIWindowBase)









function UIMoJieMGZDRankRewardListWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.dropItem=UIObject.get(self,2)
self.menuGridPanel=UIObject.get(self,3)
self.rankScrollView=UILoopListView.new(self,4)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rankScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIMoJieMGZDRankRewardListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dropItem);self.dropItem=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
self.rankScrollView:deleteSelf();self.rankScrollView=nil;
end
















local rankItemCmpIndex={
bg=0,
rankText=1,
rewardScrollView=2,
}
local pageConfig=
{
[1]={
page=1,
name='个人\n战绩',
checkReddot=function()
return false
end,
ranktype="rankRewards1",
},
[2]={
page=2,
name='仙盟\n战绩',
checkReddot=function()
return false
end,
ranktype='rankRewards3',
},
[3]={
page=3,
name='个人\n战陨',
checkReddot=function()
return false
end,
ranktype='rankRewards2',
},

}
local _this=nil
local menu_slot_name='button_dytab'



function UIMoJieMGZDRankRewardListWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMoJieMGZDRankRewardListWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieMGZDRankRewardListWin:onShow(argtable,afterOnloaded)
self.level=argtable.level
self.selectLevel=self.level

self.baseConfig=cfgHelper.get(cfg_mogongzhengduobaseconfig_get,1)
self.levelConfig=cfg_mogongduanweirewardconfig()
local page=1

local idx=pageConfig[page].page
if afterOnloaded then
local cnt=#pageConfig
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=pageConfig[i]
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
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end

self:onMenuItemClick(idx)

if self.level>0 then
self:showWindow("UIXingYu_JYZFLevelDropDownWin",{
parent=self,
item=self.dropItem:getWidgetBase(),
node='bottom',
})
end
end


function UIMoJieMGZDRankRewardListWin:onHide()

end
function UIMoJieMGZDRankRewardListWin:onClickMask()
return self:onCloseBtn()
end
function UIMoJieMGZDRankRewardListWin:onCloseBtn()
self:closeSelf()
end
function UIMoJieMGZDRankRewardListWin:refresh()
local cfgrank=self:getTypeReward(self.curPage)

local temp=cfgrank

self.rewardCfgList=temp
local _slotName='item'
self.rankScrollView:initData(_slotName,self.rewardCfgList)
end
function UIMoJieMGZDRankRewardListWin:onFreshAction(i,widget)
self:fillItem(widget,i)
end
function UIMoJieMGZDRankRewardListWin:onStartAction()

end
function UIMoJieMGZDRankRewardListWin:fillItem(widget,index)
local rewardCfg=self.rewardCfgList[index]

local minRank=rewardCfg[1]
local maxRank=rewardCfg[2]

local rankStr
local rewards

if type(minRank)=='table'then
rewards=rewardCfg
rankStr='有积分但未上榜'
else
if minRank==maxRank then
rankStr=FMT.fmt("第{0}名",minRank)
else
rankStr=FMT.fmt("第{0}-{1}名",minRank,maxRank)
end
rewards=rewardCfg[3]

if self.selectLevel>0 then
local type=pageConfig[self.curPage].ranktype
local levelConf=self.levelConfig[self.selectLevel][type][index][3]
rewards=table.concatTable(levelConf,rewardCfg[3])
end
end
widget:SetChildText(rankItemCmpIndex.rankText,rankStr)


local len=rewards~=nil and#rewards or 0
widget:SetChildScrollViewCreateGrids(rankItemCmpIndex.rewardScrollView,len,len)
local grids=widget:GetChildScrollViewItemWidgets(rankItemCmpIndex.rewardScrollView)
local count=grids.Count
local data={}

for i=1,count do
local widget1=grids[i-1]
local reward=rewards[i]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
widgetHelper.setNormalRewardItem(widget1,0,data)
local widget2=widget1:GetChildWidgetBase(0)
widget2:SetChildActive(14,reward.duanwei and reward.duanwei==1 or false)
end
end

function UIMoJieMGZDRankRewardListWin:getTypeReward(flag)
local type=pageConfig[flag].ranktype
return self.baseConfig[type]
end



function UIMoJieMGZDRankRewardListWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIMoJieMGZDRankRewardListWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=pageConfig[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,isReddot)
end

function UIMoJieMGZDRankRewardListWin:onMenuItemClick(idx)

local cfg=pageConfig[idx]
if cfg.page==self.curPage then
return
end
local old=self.curPage
self.curPage=cfg.page
if old~=nil then
local idx_=old
self:refreshMenuItemSelect(nil,idx_,false)
end
self:refreshMenuItemSelect(nil,idx,true)
self:refreshMenuPage()
end

function UIMoJieMGZDRankRewardListWin:refreshMenuPage()
self:refresh()
end

function UIMoJieMGZDRankRewardListWin:onChangeLevel(level)
self.selectLevel=level

self:refresh()
end
