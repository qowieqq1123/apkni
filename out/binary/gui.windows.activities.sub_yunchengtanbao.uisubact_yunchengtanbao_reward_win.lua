







def_class("UISubAct_yunchengtanbao_reward_win",UIWindowBase)









function UISubAct_yunchengtanbao_reward_win:bindComponents()

self.titleTxt=UIText.get(self,0)
self.menuGridPanel=UIObject.get(self,1)
self.rankScrollView=UIObject.get(self,2)
self.rankItem=UIObject.get(self,3)
self.timeTxt=UIText.get(self,4)
self.noItemTips=UIText.get(self,5)
self.rankGridPanel=UIObject.get(self,6)
self.rankTips=UIText.get(self,7)
self.rewardpanel=UIObject.get(self,8)
self.rulepanel=UIObject.get(self,9)
self.rwScrollView=UIObject.get(self,10)
self.one=UIObject.get(self,11)
self.icontex=UIText.get(self,12)
self.rwScrollView2=UIObject.get(self,13)
self.two=UIObject.get(self,14)
self.icontex2=UIText.get(self,15)
self.rwScrollView3=UIObject.get(self,16)
self.three=UIObject.get(self,17)
self.icontex3=UIText.get(self,18)
self.goods2Creater=UIObject.get(self,19)
self.ruletext=UIText.get(self,20)
self.four=UIObject.get(self,21)
self.rwScrollView4=UIObject.get(self,22)



end


function UISubAct_yunchengtanbao_reward_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.rankItem);self.rankItem=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
_UIObject_release(self.rankTips);self.rankTips=nil;
_UIObject_release(self.rewardpanel);self.rewardpanel=nil;
_UIObject_release(self.rulepanel);self.rulepanel=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.one);self.one=nil;
_UIObject_release(self.icontex);self.icontex=nil;
_UIObject_release(self.rwScrollView2);self.rwScrollView2=nil;
_UIObject_release(self.two);self.two=nil;
_UIObject_release(self.icontex2);self.icontex2=nil;
_UIObject_release(self.rwScrollView3);self.rwScrollView3=nil;
_UIObject_release(self.three);self.three=nil;
_UIObject_release(self.icontex3);self.icontex3=nil;
_UIObject_release(self.goods2Creater);self.goods2Creater=nil;
_UIObject_release(self.ruletext);self.ruletext=nil;
_UIObject_release(self.four);self.four=nil;
_UIObject_release(self.rwScrollView4);self.rwScrollView4=nil;
end

















local _this
local menu_slot_name='button_dytab'
local rankScrollViewHeight={412,509}
local abnameyc='ui/windows/activities/sub_yunchengtanbao/yunchengtanbao_atlas_pak.ab'


function UISubAct_yunchengtanbao_reward_win:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_yunchengtanbao_reward_win:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_yunchengtanbao_reward_win:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
if argtable.selectMenuIndex then
self.selectMenuIndex=argtable.selectMenuIndex
end

self.rewardslist1=cfg_cloudcitytreasureactconfig_get(_this.subId).rewardslist
self.rewardslist2=cfg_cloudcitytreasureactconfig_get(_this.subId).rewardslist2

self.selectMenuIndex=1
self:refresh(true)
end
end


function UISubAct_yunchengtanbao_reward_win:onHide()

end



function UISubAct_yunchengtanbao_reward_win:refresh(isInit)
if isInit then
local raceList={1,2}
local yeqianname={'奖励','规则'}
local cnt=#raceList
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()

for i=1,cnt do
local item=grids[i-1]
local reaceName=yeqianname[i]
item:SetChildText(1,reaceName)
local isSelected=i==self.selectMenuIndex
local func=function()
if _this==nil then return end
if isSelected then

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,i==self.selectMenuIndex)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end

end

self:refreshRankPanel()
end


function UISubAct_yunchengtanbao_reward_win:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end


function UISubAct_yunchengtanbao_reward_win:onMenuItemClick(menuIndex)
if menuIndex==self.selectMenuIndex then
return
end

local old=self.selectMenuIndex
self.selectMenuIndex=menuIndex
if old~=nil then
self:refreshMenuItemSelect(nil,old,false)
end
self:refreshMenuItemSelect(nil,menuIndex,true)


self:refreshRankPanel()
end



function UISubAct_yunchengtanbao_reward_win:refreshRankPanel(refreshTypeIndex)

if self.selectMenuIndex==1 then


_this.rewardpanel:setActive(true)
_this.rulepanel:setActive(false)
_this.winlua:SetChildText(_this.titleTxt:getID(),'奖励预览')
local cfgreward_1=_this.rewardslist1[1]
local cfgreward_2=_this.rewardslist1[2]
local cfgreward_3=_this.rewardslist1[3]


_this.winlua:SetChildText(_this.icontex:getID(),cfgreward_1[1])
local rewardList=cfgreward_1[2]
local len=#rewardList
_this.rwScrollView:setChildScrollViewCreateGrids(len,len)
local grids=_this.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local itemid=rewardList[i][1]
local num=rewardList[i][2]
local gailv=rewardList[i][3]

local gailvtxt=FMT.fmt('{0}%',gailv)
item:SetChildText(1,gailvtxt)
item:SetChildCSImageSprite(2,abnameyc,'image_yunctb_03')
local cfg=itemsConfig.getConfig(itemid)
item:SetChildIcon(0,iconHelper.getItemIconName(cfg.icon),false)
if num>0 then
item:SetChildActive(5,true)
item:SetChildCSImageSprite(5,abnameyc,'image_te_1C')
item:SetChildText(6,num)
else
item:SetChildActive(5,false)
end

item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onClickItem(itemid)
end,true)
end

_this.winlua:SetChildText(_this.icontex2:getID(),cfgreward_2[1])
local rewardList2=cfgreward_2[2]
local len2=#rewardList2
_this.rwScrollView2:setChildScrollViewCreateGrids(len2,len2)
local grids2=_this.rwScrollView2:getChildScrollViewItemWidgets()
local count=grids2.Count
for i=1,count do
local item=grids2[i-1]
local itemid=rewardList2[i][1]
local num=rewardList2[i][2]
local gailv=rewardList2[i][3]

local gailvtxt=FMT.fmt('{0}%',gailv)
item:SetChildText(1,gailvtxt)
item:SetChildCSImageSprite(2,abnameyc,'image_yunctb_02')
local cfg=itemsConfig.getConfig(itemid)
item:SetChildIcon(0,iconHelper.getItemIconName(cfg.icon),false)

if num>0 then
item:SetChildActive(5,true)
item:SetChildCSImageSprite(5,abnameyc,'image_te_1A')
item:SetChildText(6,num)
else
item:SetChildActive(5,false)
end

item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onClickItem(itemid)
end,true)
end

_this.winlua:SetChildText(_this.icontex3:getID(),cfgreward_3[1])
local rewardList3=cfgreward_3[2]
local _num=0
if#rewardList3>=6 then
_num=6
else
_num=#rewardList3
end
local len3=_num
_this.rwScrollView3:setChildScrollViewCreateGrids(len3,len3)
local grids3=_this.rwScrollView3:getChildScrollViewItemWidgets()
local count=grids3.Count
for i=1,count do
local item=grids3[i-1]
local itemid=rewardList3[i][1]
local num=rewardList3[i][2]
local gailv=rewardList3[i][3]

local gailvtxt=FMT.fmt('{0}%',gailv)
item:SetChildText(1,gailvtxt)
item:SetChildCSImageSprite(2,abnameyc,'image_yunctb_01')
local cfg=itemsConfig.getConfig(itemid)
item:SetChildIcon(0,iconHelper.getItemIconName(cfg.icon),false)

if num>0 then
item:SetChildActive(5,true)
item:SetChildCSImageSprite(5,abnameyc,'image_te_1B')
item:SetChildText(6,num)
else
item:SetChildActive(5,false)
end

item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onClickItem(itemid)
end,true)
end

if _num==6 then

local len4=#rewardList3-_num
if len4>0 then
_this.four:setActive(true)
_this.rwScrollView4:setChildScrollViewCreateGrids(len4,len4)
local grids4=_this.rwScrollView4:getChildScrollViewItemWidgets()
local count4=grids4.Count
for i=1,count4 do
local item=grids4[i-1]
local itemid=rewardList3[i+_num][1]
local num=rewardList3[i+_num][2]
local gailv=rewardList3[i+_num][3]

local gailvtxt=FMT.fmt('{0}%',gailv)
item:SetChildText(1,gailvtxt)
item:SetChildCSImageSprite(2,abnameyc,'image_yunctb_01')
local cfg=itemsConfig.getConfig(itemid)
item:SetChildIcon(0,iconHelper.getItemIconName(cfg.icon),false)

if num>0 then
item:SetChildActive(5,true)
item:SetChildCSImageSprite(5,abnameyc,'image_te_1B')
item:SetChildText(6,num)
else
item:SetChildActive(5,false)
end

item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onClickItem(itemid)
end,true)
end
end
end



local rewards2=_this.rewardslist2
local num=#rewards2
self.goods2Creater:setChildLayoutGroupCreateItems(num)
local grids2=self.goods2Creater:getChildLayoutGroupGridList()
for i=1,num do
local item=grids2[i-1]
local reward=rewards2[i]
local itemid=reward[1]
local rate=reward[2]
local name=FMT.fmt('{0}%',rate)
local conf={itemid=itemid,itemcount='',showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildText(1,name)
item:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end

elseif self.selectMenuIndex==2 then


_this.rewardpanel:setActive(false)
_this.rulepanel:setActive(true)
local rule_text=cfg_cloudcitytreasureactconfig_get(_this.subId).ruletext or""
_this.ruletext:setText(rule_text)
_this.winlua:SetChildText(_this.titleTxt:getID(),'规则说明')
end
end


function UISubAct_yunchengtanbao_reward_win:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end
