







def_class("UILingShuCiFuPreviewWin",UIWindowBase)









function UILingShuCiFuPreviewWin:bindComponents()

self.boxDesc=UIText.get(self,0)
self.leftBtn=UIButton.get(self,1)
self.levelText=UIText.get(self,2)
self.list=UIObject.get(self,3)
self.menu_anim_1=UIObject.get(self,4)
self.menu_anim_2=UIObject.get(self,5)
self.menu_anim_3=UIObject.get(self,6)
self.menu_anim_4=UIObject.get(self,7)
self.menu_anim_5=UIObject.get(self,8)
self.menu_anim_6=UIObject.get(self,9)
self.menuAnimGrid=UIObject.get(self,10)
self.menulist=UIObject.get(self,11)
self.rewardPanel=UIObject.get(self,12)
self.rightBtn=UIButton.get(self,13)
self.rulePanel=UIObject.get(self,14)
self.scrollView=UIScrollView.get(self,15)
self.ScrollView=UIObject.get(self,16)
self.spe=UIObject.get(self,17)
self.Title=UIText.get(self,18)
self.victoryItem=UIBaseItem.get(self,19)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)
self.menu_anim={
self.menu_anim_1,
self.menu_anim_2,
self.menu_anim_3,
self.menu_anim_4,
self.menu_anim_5,
self.menu_anim_6,
}



end


function UILingShuCiFuPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.boxDesc);self.boxDesc=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.levelText);self.levelText=nil;
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menu_anim_2);self.menu_anim_2=nil;
_UIObject_release(self.menu_anim_3);self.menu_anim_3=nil;
_UIObject_release(self.menu_anim_4);self.menu_anim_4=nil;
_UIObject_release(self.menu_anim_5);self.menu_anim_5=nil;
_UIObject_release(self.menu_anim_6);self.menu_anim_6=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
_UIObject_release(self.menulist);self.menulist=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.rulePanel);self.rulePanel=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.spe);self.spe=nil;
_UIObject_release(self.Title);self.Title=nil;
_UIObject_release(self.victoryItem);self.victoryItem=nil;
self.menu_anim=nil;
end
















local _this

local _CMP_INDEX={
cmpSelfItem=0,
cmpReddot=1,
cmpName=2,
comNumBg=3,
comNumTx=4,
}
local body_id={
back=2016,
menu=2017,
}
local menu_slot_name='button_dytab'




function UILingShuCiFuPreviewWin:onLoaded(...)
self:bindComponents()
_this=self

self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)
end


function UILingShuCiFuPreviewWin:__delete()
self:unbindComponents()

_this=nil
end




function UILingShuCiFuPreviewWin:onShow(argtable,afterOnloaded)
if argtable.act_id then
self.actID=argtable.act_id
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
self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subId)
local data=self.info:getData()
if not data then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.actID,self.subType,self.subId))
return
end
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
local data=self.info:getData()
self.curLevel=self.curLevel or data.level or 1
self.maxLv=#self.config.reward_preview
if self.curLevel>self.maxLv then
self.curLevel=self.maxLv
end
self.selectMenuIdx=1
self.activeSubMenu={
{name="奖励"},
{name="规则"},
}
self.showMenuNum=#self.activeSubMenu
self.showMenu=self.showMenuNum>1
if not self.info.data then

else
self:onLoadFinish(true)
self:refreshPanel()
self:freshMenuList()
end
end


function UILingShuCiFuPreviewWin:onHide()

end


function UILingShuCiFuPreviewWin:refreshPanel()
self.rewardPanel:setActive(self.selectMenuIdx==1)
self.rulePanel:setActive(self.selectMenuIdx==2)
if self.selectMenuIdx==1 then
self:refreshRewardPanel()
else
self:refreshRulePanel()
end
local titleTxt=self.activeSubMenu[self.selectMenuIdx].name
self.Title:setText(titleTxt)
end

function UILingShuCiFuPreviewWin:refreshRewardPanel()
local list=self.info:getPreviewListByLevel(self.curLevel)
local len=#list
local col=8
local num=math.ceil(len/col)*col
self.ScrollView:setChildScrollViewCreateGrids(num,col)
self.grids=self.ScrollView:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=list[i]
if data then
local itemId=data[1]
item:SetChildActive(-1,true)
local itemCount=data[2]
local rates=data[3]/100
local itemConfig=itemsConfig.getConfig(itemId)
local countStr=itemCount>1 and mathHelper.formatNumber(itemCount)or''
local iconName=iconHelper.getIconName(itemId)
local conf=
{
itemid=itemId,
iconName=iconName,
color=itemConfig.color,
itemcount=countStr,
showCountBG=itemCount>1,
}
local prop=itemsComponentHelper.getCommonSpecialFillData(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
tipsManager.showTips({itemid=itemId})
end)
item:SetChildText(1,itemConfig.name)
item:SetChildText(2,FMT.fmt("{0}%",rates))
else
item:SetChildActive(-1,false)
end
end

local bigReward=self.info:getPreviewBigRewardByLevel(self.curLevel)
if bigReward then
local itemId=bigReward[1]
local itemCount=bigReward[2]
local rates=bigReward[3]/100
local itemConfig=itemsConfig.getConfig(itemId)
local countStr=itemCount>1 and mathHelper.formatNumber(itemCount)or''
local iconName=iconHelper.getIconName(itemConfig.icon)
local conf=
{
itemid=itemId,
iconName=iconName,
color=itemConfig.color,
itemcount=countStr,
showCountBG=itemCount>1,
}
local prop=itemsComponentHelper.getCommonSpecialFillData(conf)
self.victoryItem:setChildPropData(prop)
self.victoryItem:setBaseItemClickEvent(function(...)
tipsManager.showTips({itemid=itemId})
end)
self.boxDesc:setText(FMT.fmt("{0}：{1}%",itemConfig.name,rates))
end

if self.maxLv>1 then
self.levelText:setText(FMT.fmt("{0}级灵树奖励预览",self.curLevel))
else
self.levelText:setText("灵树奖励预览")
end

self.leftBtn:setActive(self.curLevel>1)
self.rightBtn:setActive(self.curLevel<self.maxLv)
end

function UILingShuCiFuPreviewWin:refreshRulePanel()
local datas=self.config.reward_rule
local len=#datas
self.list:setChildLayoutGroupCreateItems(len,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local str=datas[index]
item:SetChildText(0,str)
end)
self.winlua:ForceLayoutRect(self.list:getID())
end

function UILingShuCiFuPreviewWin:onLoadFinish(isNew)
self.animLock1=nil
self:clearMenuTweener()
self.menuAnimGrid:setChildCanvasGroupAlpha(0)
self.menulist:setChildCanvasGroupAlpha(0)
local func=function()
self.menuAnimGrid:setChildCanvasGroupAlpha(1)
for i,v in ipairs(self.menu_anim)do
local isshow=i<=self.showMenuNum
local anim=self.menu_anim[i]
local func2=function()
if isshow then
local item=self.scrollView:getGridObjectByindex(i-1)

local name
if self.selectMenuIdx==i then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,name)
end
end
local cb=nil
if isNew then
cb=func2
end
anim:setChildUIModelShowTarget(body_id.menu,1,{},eAnimationID.common_window_enter,false,false,0,cb)
if not isNew then
func2()
end
anim:setActive(isshow)
end
end
self:delayDo(0.1,func)
self.animLock1=true
local func1=function()
self.animLock1=nil
self.menulist:setChildCanvasGroupAlpha(0)
local fun3=function()
self.menuTweener=nil
end
self.menuTweener=self.menulist:setChildCanvasGroupDOFade(1,1,fun3)
end
self:delayDo(0.4,func1)
end

function UILingShuCiFuPreviewWin:clearMenuTweener()
if self.menuTweener~=nil then
self.menuTweener:Complete()
self.menuTweener=nil
end
end

function UILingShuCiFuPreviewWin:freshMenuList()
if self.showMenu then
local tNum=#self.activeSubMenu


self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(self.activeSubMenu)do
self:fillMenu(i,v)
end
end
end

function UILingShuCiFuPreviewWin:fillMenu(index,config)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildText(_CMP_INDEX.cmpName,self.activeSubMenu[index].name)
local anim=self.menu_anim[index]

local name
if self.selectMenuIdx==index then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,name)

item:SetChildActive(_CMP_INDEX.cmpReddot,false)
end

function UILingShuCiFuPreviewWin:freshMenuSelect(index,is_select)
if index==nil then
return
end
local activeSubMenu=self.activeSubMenu
local config=activeSubMenu[index]
if config==nil then
return
end

local anim=self.menu_anim[index]
if is_select then
anim:setChildModelAnimationState(eAnimationID.common_window_dianji)
end

local name
if is_select then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,name)
end

function UILingShuCiFuPreviewWin:on_click_callback(id,index,guid,attach)
if self.animLock1==true then return end
if index==self.selectMenuIdx then
return
end
if self.activeSubMenu and self.activeSubMenu[index]then
self:freshMenuSelect(self.selectMenuIdx,false)
self:freshMenuSelect(index,true)
self.selectMenuIdx=index
self:refreshPanel()
end
end



function UILingShuCiFuPreviewWin:onLeftBtn()
if self.curLevel<=1 then return end
self.curLevel=self.curLevel-1
self:refreshPanel()
end

function UILingShuCiFuPreviewWin:onRightBtn()
if self.curLevel>=self.maxLv then return end
self.curLevel=self.curLevel+1
self:refreshPanel()
end
