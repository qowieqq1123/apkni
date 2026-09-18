







def_class("UISubAct_shizhuanchoujian_reward_win",UIWindowBase)









function UISubAct_shizhuanchoujian_reward_win:bindComponents()

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
self.Textone=UIText.get(self,21)
self.rolepanel=UIObject.get(self,22)
self.suitone=UIObject.get(self,23)
self.suittwo=UIObject.get(self,24)
self.suitthree=UIObject.get(self,25)
self.suitfour=UIObject.get(self,26)
self.suitfive=UIObject.get(self,27)



end


function UISubAct_shizhuanchoujian_reward_win:unbindComponents()
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
_UIObject_release(self.Textone);self.Textone=nil;
_UIObject_release(self.rolepanel);self.rolepanel=nil;
_UIObject_release(self.suitone);self.suitone=nil;
_UIObject_release(self.suittwo);self.suittwo=nil;
_UIObject_release(self.suitthree);self.suitthree=nil;
_UIObject_release(self.suitfour);self.suitfour=nil;
_UIObject_release(self.suitfive);self.suitfive=nil;
end
















local _this
local menu_slot_name='button_dytab'
local rankScrollViewHeight={412,509}
local abnameyc='ui/windows/activities/sub_yunchengtanbao/yunchengtanbao_atlas_pak.ab'


function UISubAct_shizhuanchoujian_reward_win:onLoaded(...)
self:bindComponents()
_this=self
self.suitperfab={self.suitone,self.suittwo,self.suitthree,self.suitfour,self.suitfive}
end


function UISubAct_shizhuanchoujian_reward_win:__delete()
self:unbindComponents()
end




function UISubAct_shizhuanchoujian_reward_win:onShow(argtable,afterOnloaded)
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
end

self.selectMenuIndex=1

self:refreshRankPanel()

end


function UISubAct_shizhuanchoujian_reward_win:onHide()

end



function UISubAct_shizhuanchoujian_reward_win:refresh(isInit)
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
UISubAct_shizhuanchoujian_reward_win:refreshMenuItemSelect(item,i,i==self.selectMenuIndex)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end

end

self:refreshRankPanel()
end


function UISubAct_shizhuanchoujian_reward_win:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end


function UISubAct_shizhuanchoujian_reward_win:onMenuItemClick(menuIndex)
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



function UISubAct_shizhuanchoujian_reward_win:refreshRankPanel(refreshTypeIndex)

if _this.selectMenuIndex==1 then


_this.rewardpanel:setActive(true)
_this.rulepanel:setActive(false)
_this.winlua:SetChildText(_this.titleTxt:getID(),'奖励预览')


local config=cfg_lotteryact3config_get(_this.subId)
_this.Textone:setText(FMT.fmt("{0}",config.rewardtxt))


local reward_glv=config.reward_glv or""


local suitdata=config.spinelist
for i=1,#suitdata do
if suitdata[i]then
_this.suitperfab[i]:setActive(true)

local cfg=suitdata[i]
local widget=_this.suitperfab[i]:getWidgetBase()
local jobicon=UIDiscipleModel:getJobIconName(cfg[2])
local modelid=cfg[3]
local itemid=cfg[1]or-1
local scale=config.suitscale[2]or 0.8
widget:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
widget:SetChildUIModelShowTarget(2,modelid,scale,{},eAnimationID.stand,false,true)
widget:SetChildActive(4,false)
local func=function()
_this:onRewardItemClick(itemid,i)
end
widget:SetChildButtonClick(5,func,true)
widget:SetChildText(6,reward_glv)
else
_this.suitperfab[i]:setActive(false)
end
end


if#suitdata<5 then
_this.suitperfab[#suitdata+1]:setActive(true)
local widget=_this.suitperfab[#suitdata+1]:getWidgetBase()

widget:SetChildActive(4,true)
widget:SetChildText(6,reward_glv)
end


local rewards2=config.rewards


local num=#rewards2
_this.goods2Creater:setChildLayoutGroupCreateItems(num)
local grids2=_this.goods2Creater:getChildLayoutGroupGridList()
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
_this:onClickItem(...)
end)
end


elseif _this.selectMenuIndex==2 then


_this.rewardpanel:setActive(false)
_this.rulepanel:setActive(true)
_this.winlua:SetChildText(_this.titleTxt:getID(),'规则说明')
end
end


function UISubAct_shizhuanchoujian_reward_win:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UISubAct_shizhuanchoujian_reward_win:onRewardItemClick(itemId,itemIndex)
if itemId and itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end

