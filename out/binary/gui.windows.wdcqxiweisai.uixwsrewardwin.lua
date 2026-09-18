







def_class("UIXWSRewardWin",UIWindowBase)









function UIXWSRewardWin:bindComponents()

self.scrollView=UILoopListView.new(self,0)
self.rewardContent=UIObject.get(self,1)
self.ToggleGroup=UIObject.get(self,2)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXWSRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
self.scrollView:deleteSelf();self.scrollView=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.ToggleGroup);self.ToggleGroup=nil;
end


















local itemCmp={
rankBg=0,
rank=1,
rewardContent=2,
tipsRoot=3,
spebg1=4,
spebg2=5,
tips=6,
}
local abName="ui/windows/ranklist/ranklist_atlas_pak.ab"
local _this=nil
local menu_slot_name='button_dytab'


function UIXWSRewardWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXWSRewardWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXWSRewardWin:onShow(argtable,afterOnloaded)
self.showRewardGonpList=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'showRewardGonpList')

self.showRewardGonpList=self:filteredShowGroup(self.showRewardGonpList)

self.groupIndexLookup={}
for i,v in ipairs(self.showRewardGonpList)do
self.groupIndexLookup[v]=i
end
self.selectGroup=argtable and argtable.selectGroup or XiWeiSaiModel:getData_group()

local cnt=#self.showRewardGonpList
self.ToggleGroup:setChildLayoutGroupCreateItems(cnt)
for i=1,cnt do
local group=self.showRewardGonpList[i]
local item=self.ToggleGroup:getChildLayoutGroupGridItem(i-1)
item:SetChildButtonClickWithID(0,self.onToggleChange,group,true)
item:SetChildText(1,WDCQCGroupNmae[group])
local isSelected=self.selectGroup==group
local func=function()
if isSelected then

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)





local isreddot=false











item:SetChildActive(3,isreddot)
end
self:refresh()
end


function UIXWSRewardWin:onHide()

end

function UIXWSRewardWin:refresh()

local cfg=cfg_wendingcangqionghaixuanposconfig()
local group=self.selectGroup
local groupCfg=cfg[group]
local rankList={}
for i,v in ipairs(groupCfg)do
rankList[i]={v.pos_id,v.rewards}
end
local attend_reward=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'attend_reward')
rankList[#rankList+1]={0,attend_reward}
self.scrollView:initData("item",rankList)








end

function UIXWSRewardWin:onFreshAction(index,widget,data)
local pos=data[1]
local rewards=data[2]
if pos==0 then
widget:SetChildText(itemCmp.rank,"")
widget:SetChildText(itemCmp.tips,FMT.fmt("（至少挑战过{0}次）",1))
widget:SetChildActive(itemCmp.tipsRoot,true)
else
widget:SetChildText(itemCmp.rank,pos)
widget:SetChildActive(itemCmp.tipsRoot,false)
end
if pos<=3 and pos>0 then
widget:SetChildActive(itemCmp.rankBg,true)
widget:SetChildActive(itemCmp.spebg1,true)
widget:SetChildActive(itemCmp.spebg2,true)
widget:SetChildCSImageSprite(itemCmp.rankBg,abName,FMT.fmt("icon_phbmingci_{0}",pos))
widget:SetChildCSImageSprite(itemCmp.spebg1,abName,FMT.fmt("frame_phbkuang_{0}",pos))
widget:SetChildCSImageSprite(itemCmp.spebg2,abName,FMT.fmt("frame_phbkuang_{0}",pos))
else
widget:SetChildActive(itemCmp.rankBg,false)
widget:SetChildActive(itemCmp.spebg1,false)
widget:SetChildActive(itemCmp.spebg2,false)
end
if rewards then

widget:SetChildLayoutGroupCreateItems(itemCmp.rewardContent,#rewards,function(subIndex)
local item=widget:GetChildLayoutGroupGridItem(itemCmp.rewardContent,subIndex-1)
local itemdata=rewards[subIndex]
widgetHelper.setNormalRewardItem(item,0,itemdata)
end)
end
end

function UIXWSRewardWin:onStartAction()

end


function UIXWSRewardWin.onToggleChange(group)

if _this.selectGroup~=group then
if _this.selectGroup then
_this:setToggleOn(_this.selectGroup,false)
end
_this.selectGroup=group

_this:setToggleOn(_this.selectGroup,true)
_this:refresh()
end
end

function UIXWSRewardWin:setToggleOn(group,on)
local index=self.groupIndexLookup[group]
local item=self.ToggleGroup:getChildLayoutGroupGridItem(index-1)
if on then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,on and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIXWSRewardWin:filteredShowGroup(groupList)
local maxLv=zongmenModel:getZongMenLimitLv()
local list={}
for _,group in ipairs(groupList)do
local allGroupCfgList=cfg_xianfawendaolevelconfig()
local cfg=allGroupCfgList[group]
local min=UIXianFaWenDaoControl:getPlatFormIdCfg(cfg.min)
if maxLv>=min then
list[#list+1]=group
end
end
return list
end



function UIXWSRewardWin:onCloseClick()
self:closeSelf()
end
