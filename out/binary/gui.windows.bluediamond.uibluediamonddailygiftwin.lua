







def_class("UIBlueDiamondDailyGiftWin",UIWindowBase)









function UIBlueDiamondDailyGiftWin:bindComponents()

self.Content=UIObject.get(self,0)
self.receiveBtn=UIButton.get(self,1)
self.root=UIObject.get(self,2)
self.ScrollerView=UIObject.get(self,3)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)



end


function UIBlueDiamondDailyGiftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollerView);self.ScrollerView=nil;
end
















local CmpItemIndex={
desc=0,
levelRewardBtn=1,
rewardScrollerView=2,
receiveBtn=3,
receiveText=4,
receiveIcon=5,
lockDesc=6,
uplevelDesc=7,
ylq=8,
}

local _this=nil
local _abname="ui/windows/bluediamond/bluediamond_atlas_pak.ab"




function UIBlueDiamondDailyGiftWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onActorBlueDiamondChange,self.onActorBlueDiamondChange)
end


function UIBlueDiamondDailyGiftWin:__delete()
self:unbindComponents()
_this=nil
end

function UIBlueDiamondDailyGiftWin.onActorBlueDiamondChange()
_this:refreshPanel()
end




function UIBlueDiamondDailyGiftWin:onShow(argtable,afterOnloaded)
self:refreshPanel()

if afterOnloaded then
self:initRoot()
end
end

function UIBlueDiamondDailyGiftWin:onShowArgRecv(argtable)
self:initRoot()
end

function UIBlueDiamondDailyGiftWin:initRoot()
self.root:setChildCanvasGroupAlpha(0)
local cavasGroup=self.root:getCommonComponent('CanvasGroup')
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end
if self.tweener then
self.tweener:Kill(false)
self.tweener=nil
end
self.delayTimer=self:delayDo(0.3,function()
if not _this then return end
_this.tweener=_DOTweenProxy.DOFade(cavasGroup,1,0.5)
_this.tweener:SetDelay(0.2)
_this.delayTimer=nil
end)
end


function UIBlueDiamondDailyGiftWin:onHide()

end

function UIBlueDiamondDailyGiftWin:refreshPanel()
local giftList=rechargeModel:getSortBlueDiamondLiBaoList(shopLibaoType.blueDiamondDailyGift,true)
local iconInfo=playerModel:getActorIconInfo()
local info=playerModel.getBlueinfo(iconInfo.blueinfo)
self.canGetList=self:getCanGetList(giftList)
local isGray=not self.canGetList or not next(self.canGetList)
self.receiveBtn:setGray(isGray)

local len=#giftList
self.ScrollerView:setChildScrollViewCreateGrids(len,len)
local grids=self.ScrollerView:getChildScrollViewItemWidgets()
for i=1,len do
local widget=grids[i-1]

local conf=giftList[i]
local groupList=rechargeModel:getXiangouGroupList(conf.id)
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(conf.id)
local isGot=buyNum>=conf.maxcount
local isOpen=rechargeModel:checkXianGouLiBaoOpen(conf.conditions)
local abname
local iconname
if isGot then
abname=globalABLookup.global
iconname="image_dyyilingqu_2"
else
abname=globalABLookup.global
iconname="image_dykelingqu_1"
end

local type,desc1,desc2=self:getTaskDesc(conf.conditions)
widget:SetChildText(CmpItemIndex.desc,desc1)
widget:SetChildText(CmpItemIndex.lockDesc,desc2 or"")

if type==6 then
widget:SetChildText(CmpItemIndex.receiveText,info.isSBule and"续费豪华版"or"开通豪华版")
widget:SetChildCSImageSprite(CmpItemIndex.receiveIcon,_abname,"icon_lztq_2")
elseif type==7 then
widget:SetChildText(CmpItemIndex.receiveText,info.isYear and"续费年费蓝钻"or"开通年费蓝钻")
widget:SetChildCSImageSprite(CmpItemIndex.receiveIcon,_abname,"icon_lztq_1")
else
widget:SetChildText(CmpItemIndex.receiveText,info.isBule and"续费蓝钻"or"开通蓝钻")
widget:SetChildCSImageSprite(CmpItemIndex.receiveIcon,_abname,"icon_lztq_1")
end
widget:SetChildActive(CmpItemIndex.levelRewardBtn,groupList~=nil)
widget:SetChildActive(CmpItemIndex.lockDesc,not isOpen and desc2~=nil)
widget:SetChildActive(CmpItemIndex.ylq,isOpen)
widget:SetChildCSImageSprite(CmpItemIndex.ylq,abname,iconname)

widget:SetChildButtonClick(CmpItemIndex.receiveBtn,function()
platformSDK:reqQQEvent("buy_vip")
end)

if groupList~=nil then
widget:SetChildButtonClick(CmpItemIndex.levelRewardBtn,function()
_this:showWindow("UIBlueDiamondLevelRewardTipsWin",{list=groupList})
end)
end

local rewards=rechargeModel:getXianGouLiBaoRewards(conf.rewards)
widget:SetChildLayoutGroupCreateItems(CmpItemIndex.rewardScrollerView,#rewards,function(index)
local item=widget:GetChildLayoutGroupGridItem(CmpItemIndex.rewardScrollerView,index-1)

local itemID=rewards[index][1]
local num=rewards[index][2]
local str=''
if num>0 then
str=tostring(num)
end
local graynum=isGot and 1 or 0
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=str~='',showStage=true,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)

item:SetChildActive(1,not isGot and isOpen)
end)
end
end

function UIBlueDiamondDailyGiftWin:getTaskDesc(conditions)
if conditions==nil then
return nil,""
end
local iconInfo=playerModel:getActorIconInfo()
local info=playerModel.getBlueinfo(iconInfo.blueinfo)
for i,v in pairs(conditions)do
if v[1]==6 then
if not info.isBule then
return v[1],"蓝钻豪华版额外领取","您还不是豪华蓝钻\n无法领取本礼包"
else
return v[1],"蓝钻豪华版额外领取","您还不是豪华蓝钻\n无法领取本礼包"
end
elseif v[1]==7 then
return v[1],"年费蓝钻贵族额外领取","您还不是年费蓝钻\n无法领取本礼包"

elseif v[1]==8 then
return v[1],FMT.fmt("蓝钻贵族（LV{0}）",v[2]),"您还不是蓝钻贵族\n无法领取本礼包"
end
end
return nil,""
end

function UIBlueDiamondDailyGiftWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UIBlueDiamondDailyGiftWin:getCanGetList(giftList)
local list={}
for i,v in pairs(giftList)do
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(v.id)
local isOpen=rechargeModel:checkXianGouLiBaoOpen(v.conditions)
local sellOut=buyNum>=v.maxcount
local price=v.price
if isOpen and not sellOut then
if price and price[2]==0 then
table.insert(list,{v.id,1})
end
end
end
return list
end




function UIBlueDiamondDailyGiftWin:onReceiveBtn()
if not self.canGetList or not next(self.canGetList)then
UIManager.error('没有可领取的奖励')
return
end
rechargeController:reqXianGouLiBaoListBuy(self.canGetList)
end

