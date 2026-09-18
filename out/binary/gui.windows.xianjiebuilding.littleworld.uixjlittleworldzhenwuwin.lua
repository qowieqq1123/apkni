







def_class("UIXJLittleWorldZhenWuWin",UIWindowBase)









function UIXJLittleWorldZhenWuWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.emptySp=UIText.get(self,1)
self.kongRoot=UIObject.get(self,2)
self.kongWidget_1=UIObject.get(self,3)
self.kongWidget_2=UIObject.get(self,4)
self.kongWidget_3=UIObject.get(self,5)
self.kongWidget_4=UIObject.get(self,6)
self.left=UIObject.get(self,7)
self.levelPanel=UIObject.get(self,8)
self.right=UIObject.get(self,9)
self.shuomingButton=UIButton.get(self,10)
self.techanScrollView=UIObject.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.shuomingButton:setButtonClick(function()self:onShuomingButton()end)
self.kongWidget={
self.kongWidget_1,
self.kongWidget_2,
self.kongWidget_3,
self.kongWidget_4,
}



end


function UIXJLittleWorldZhenWuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.emptySp);self.emptySp=nil;
_UIObject_release(self.kongRoot);self.kongRoot=nil;
_UIObject_release(self.kongWidget_1);self.kongWidget_1=nil;
_UIObject_release(self.kongWidget_2);self.kongWidget_2=nil;
_UIObject_release(self.kongWidget_3);self.kongWidget_3=nil;
_UIObject_release(self.kongWidget_4);self.kongWidget_4=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.levelPanel);self.levelPanel=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.shuomingButton);self.shuomingButton=nil;
_UIObject_release(self.techanScrollView);self.techanScrollView=nil;
self.kongWidget=nil;
end



















function UIXJLittleWorldZhenWuWin:onLoaded(...)
self:bindComponents()

end


function UIXJLittleWorldZhenWuWin:__delete()
self:unbindComponents()
end




function UIXJLittleWorldZhenWuWin:onShow(argtable,afterOnloaded)
self.left:setChildAnchoredPos(-512,0)
local t=self.left:setChildDOAnchorPosX(0,0.5)
t:SetDelay(0.3)
self.right:setChildAnchoredPos(512,0)
local t=self.right:setChildDOAnchorPosX(0,0.5)
t:SetDelay(0.3)
self:refreshLeft()
self:refreshRight()
if not self.isThisShow then
UIManager:invokeUIMethod("UIPlanent","setAnimator",3)
UIManager:invokeUIMethod("UIPlanent","enableAutoRotate",false)
self.isThisShow=true
end
end

function UIXJLittleWorldZhenWuWin:onShowArgRecv(argtable)
self:onShow(argtable)
end



function UIXJLittleWorldZhenWuWin:onHide()
if self.isThisShow then
UIManager:invokeUIMethod("UIPlanent","setAnimator",4)
UIManager:invokeUIMethod("UIPlanent","enableAutoRotate",true)
self.isThisShow=nil
end
end

function UIXJLittleWorldZhenWuWin:recvEquiped()
self:refreshLeft()
self:refreshRight()
end

function UIXJLittleWorldZhenWuWin:refreshLeft()
local slotList=LittleWorldModel:getZhenWuSlot()or{}
local haveActive=LittleWorldModel:haveZhenWuCanActive()
local haveEquip=LittleWorldModel:isZhenWuCanEquip()
for idx,item in ipairs(self.kongWidget)do
local widget=item:getChildWidgetBase()
local slot=slotList[idx]
if slot then
widget:SetChildActive(3,false)
widget:SetChildActive(4,true)

local zwConfig=cfgHelper.get(cfg_smallworldtownconfig_get,slot)

local starCfg=cfg_smallworldtownstarconfig_get(slot)
local showStar=starCfg[1]~=nil

local data=LittleWorldModel:getZhenWuData(slot)
local star=data or 0
widget:SetChildIcon(0,LittleWorldModel.get_zw_big_icon(zwConfig.show_icon_l),true)
widget:SetChildText(6,zwConfig.show_name)
widget:SetChildActive(1,showStar)
widget:SetChildStarNumber(1,star)

local str=''
local effectConfig=LittleWorldModel.getZWEffectConfig(slot,star)
local idx=1
if effectConfig then
for i,v in ipairs(effectConfig)do
local effType=v[1]
local effArgs=v[2]

for t,v2 in pairs(effArgs)do
local desc=LittleWorldModel:getZhenWuEffectDesc(effType,t,v2)
str=FMT.fmt("{0}{1}{2}",str,desc,idx>=1 and"\n"or"")
idx=idx+1
end
end
end
widget:SetChildText(2,str)
else
widget:SetChildActive(3,true)
widget:SetChildActive(4,false)
end

local active=haveActive or(not slot and haveEquip)
LittleWorldController:doPunchRotation(self,widget,7,idx,active)

widget:SetChildButtonClick(5,function()
self:showWindow("UIXJLittleWorldZhenWuBagWin",{selectGroup=idx})


end)
end
end

function UIXJLittleWorldZhenWuWin:refreshRight()
local rewardList={}
local level=LittleWorldModel:getLittleWorldLevel()
local moneyDrop=LittleWorldModel.get_money_drop_id1(level)
if moneyDrop then
local rcfg=cfgHelper.get1(cfg_awardconfig_get,moneyDrop)
local rewards=rcfg.showItems
rewardList=attrListHelper.concatList(rewardList,rewards)
end
local itemDrop=LittleWorldModel.get_item_drop_id1(level)
if itemDrop then
local rcfg=cfgHelper.get1(cfg_awardconfig_get,itemDrop)
local rewards=rcfg.showItems
rewardList=attrListHelper.concatList(rewardList,rewards)
end

local rewardUpList={}
local rewardUpPercentList={}
local speList={}

local zhenWuSlot=LittleWorldModel:getZhenWuSlot()
for k,v in pairs(zhenWuSlot)do
local star=LittleWorldModel:getZhenWuData(v)
if star then
local zwEffect=LittleWorldModel.getZWEffectConfig(v,star)
if zwEffect then
for i,v in ipairs(zwEffect)do
local effType=v[1]
local effArgs=v[2]
if effType==eZhenWuEffectType.eItemAddSpeed then
for itemId,val in pairs(effArgs)do
local newFlag=true
for _,v1 in ipairs(rewardList)do
if v1[1]==itemId then
newFlag=false
break
end
end
if newFlag then
rewardList[#rewardList]={itemId,0}
end
if val[2]==1 then
rewardUpPercentList[itemId]=(rewardUpPercentList[itemId]or 0)+val[1]
else
rewardUpList[itemId]=(rewardUpList[itemId]or 0)+val[1]
end
local desc=LittleWorldModel:getZhenWuEffectDesc(effType,itemId,val)
table.insert(speList,desc)
end

else
for t,v2 in pairs(effArgs)do
local desc=LittleWorldModel:getZhenWuEffectDesc(effType,t,v2)
table.insert(speList,desc)
end
end
end
end
end
end

self.levelPanel:setChildLayoutGroupCreateItems(#rewardList)
local childGrids=self.levelPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
if childItem then
local reward=rewardList[i]
local itemid=reward[1]
childItem:SetChildIcon(1,iconHelper.getIconName(itemid),false)
childItem:SetChildText(2,reward[2])

local upReward=rewardUpList[itemid]
local upPercent=rewardUpPercentList[itemid]
local addflag=upReward~=nil or upPercent~=nil
if addflag then
local add=0
if upPercent then
add=mathHelper.floor((reward[2]+(upReward or 0))*upPercent/100+(upReward or 0))
end
if add==0 then
addflag=false
end
childItem:SetChildText(4,add)
end
childItem:SetChildActive(3,addflag)
if reward[2]==0 and not addflag then
childItem:SetChildActive(-1,false)
end
end
end
local length=#speList

if length>0 then
self.techanScrollView:setChildScrollViewCreateGrids(length,1)
local grids=self.techanScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildText(1,speList[i])
end
self.emptySp:setActive(false)
else
self.techanScrollView:setChildScrollViewCreateGrids(length,1)
self.emptySp:setActive(true)
end
end




function UIXJLittleWorldZhenWuWin:onShuomingButton()
end

function UIXJLittleWorldZhenWuWin:onCloseBtn()
UIFullLittleWorldControl:showMainWindow()
end