







def_class("UIMoJieRankRewardListWin",UIWindowBase)









function UIMoJieRankRewardListWin:bindComponents()

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


function UIMoJieRankRewardListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.rankScrollView:deleteSelf();self.rankScrollView=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
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
name='个人\n诛魔',
checkReddot=function()
return false
end,
ranktype=3,
},
[2]={
page=2,
name='仙盟\n诛魔',
checkReddot=function()
return false
end,
ranktype=4,
},
[3]={
page=3,
name='个人\n仙伐',
checkReddot=function()
return false
end,
ranktype=1,
},
[4]={
page=4,
name='个人\n仙陨',
checkReddot=function()
return false
end,
ranktype=2,
},

}
local _this=nil
local menu_slot_name='button_dytab'
local rewardrank=
{
xf=1,
xs=2,
zm=3,
zmxm=4,
}
local rewardtype=
{
rank=1,
xfz=2,
zmgx=3
}



function UIMoJieRankRewardListWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMoJieRankRewardListWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieRankRewardListWin:onShow(argtable,afterOnloaded)
local enterData=xianjieModel:getMoJieEnterData()
self.mojiecfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
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
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end

self:onMenuItemClick(idx)
end


function UIMoJieRankRewardListWin:onHide()

end
function UIMoJieRankRewardListWin:onClickMask()
return self:onCloseBtn()
end
function UIMoJieRankRewardListWin:onCloseBtn()
self:closeSelf()
end
function UIMoJieRankRewardListWin:refresh()
local rankType=self.rankType
local cfgrank=self:getTypeReward(rewardtype.rank)
local cfgrewards=cfgrank[rankType]

local temp={}
for k,v in ipairs(cfgrewards)do
table.insert(temp,v)
end
if cfgrewards[0]then
table.insert(temp,cfgrewards[0])
end


self.rewardCfgList=temp
local _slotName='item'
self.rankScrollView:initData(_slotName,self.rewardCfgList)
end
function UIMoJieRankRewardListWin:onFreshAction(i,widget)
self:fillItem(widget,i)
end
function UIMoJieRankRewardListWin:onStartAction()

end
function UIMoJieRankRewardListWin:fillItem(widget,index)
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

function UIMoJieRankRewardListWin:getTypeReward(flag)
local cfgrank=self.mojiecfg.rank
return cfgrank[flag]
end



function UIMoJieRankRewardListWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIMoJieRankRewardListWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.showPageCfgList[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,isReddot)
end

function UIMoJieRankRewardListWin:onMenuItemClick(idx)
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

function UIMoJieRankRewardListWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=self.showPageCfgList[idx]
local ranktype=cfg.ranktype
self.rankType=ranktype
self:refresh()
end