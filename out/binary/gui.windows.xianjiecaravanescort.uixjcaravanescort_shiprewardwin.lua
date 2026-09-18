







def_class("UIXJCaravanEscort_shipRewardWin",UIWindowBase)









function UIXJCaravanEscort_shipRewardWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.rewardTypeGroup=UIObject.get(self,4)
self.confirmBtn=UIButton.get(self,5)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)



end


function UIXJCaravanEscort_shipRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rewardTypeGroup);self.rewardTypeGroup=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
end
















local rewardTypeItemCmpIndex={
titleName=0,
rewardGroup=1,
nowSelectFlag=2,
selectBg=3,
click=4,
}
local _this




function UIXJCaravanEscort_shipRewardWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXJCaravanEscort_shipRewardWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXJCaravanEscort_shipRewardWin:onShow(argtable,afterOnloaded)
self.posIdx=argtable and argtable.posIdx or 1

if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),6318,1,{},eAnimationID.enter)
end

self:refresh()
end


function UIXJCaravanEscort_shipRewardWin:onHide()

end

function UIXJCaravanEscort_shipRewardWin:refresh()
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(self.posIdx)
if posData then
local posBaseData=posData.xianzhouStruct
local shipId=posBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
local rewardTypeIdx=posBaseData.reward_idx
if rewardTypeIdx<=0 then
rewardTypeIdx=xianJieCaravanEscortModel:getShipPosSelectRewardTypeIdx(self.posIdx)or 1
end
self.nowSelectTypeIdx=rewardTypeIdx
if not self.clickSelectTypeIdx then
self.clickSelectTypeIdx=rewardTypeIdx
end

local rewardTypeList=shipCfg.showRewards

self.rewardTypeGroup:setChildLayoutGroupCreateItems(#rewardTypeList,function(index)
local rewardTypeWidget=self.rewardTypeGroup:getChildLayoutGroupGridItem(index-1)
local rewardCfg=rewardTypeList[index]
if rewardCfg then
rewardTypeWidget:SetChildActive(-1,true)


local typeName=rewardCfg[1]
rewardTypeWidget:SetChildText(rewardTypeItemCmpIndex.titleName,typeName)


local rewards=rewardCfg[2]
local rewardCount=#rewards
rewardTypeWidget:SetChildLayoutGroupCreateItems(rewardTypeItemCmpIndex.rewardGroup,rewardCount,function(index)
local rwItem=rewardTypeWidget:GetChildLayoutGroupGridItem(rewardTypeItemCmpIndex.rewardGroup,index-1)
local itemData=rewards[index]
local itemid=itemData[1]
local itemnum=itemData[2]
local itemcount,showCountBG
if itemnum>1 or itemData.range~=nil then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then
return
end
_this:onClickItem(...)
end)
end)


local isSelect=self.nowSelectTypeIdx==index
rewardTypeWidget:SetChildActive(rewardTypeItemCmpIndex.nowSelectFlag,isSelect)
local isClick=self.clickSelectTypeIdx==index
rewardTypeWidget:SetChildActive(rewardTypeItemCmpIndex.selectBg,isClick)


rewardTypeWidget:SetChildButtonClick(rewardTypeItemCmpIndex.click,function()
return self:onClickRewardType(index)
end,true)

else
rewardTypeWidget:SetChildActive(-1,false)
end

end)

end
end





function UIXJCaravanEscort_shipRewardWin:onClickMask()
return self:onCloseBtn()
end



function UIXJCaravanEscort_shipRewardWin:onCloseBtn()
self:closeSelf()
end



function UIXJCaravanEscort_shipRewardWin:onConfirmBtn()
xianJieCaravanEscortModel:setShipPosSelectRewardTypeIdx(self.posIdx,self.clickSelectTypeIdx)

UIManager:invokeUIMethod("UIXJCaravanEscort_shipMsgWin","refreshInfoPanel")


return self:onCloseBtn()
end


function UIXJCaravanEscort_shipRewardWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UIXJCaravanEscort_shipRewardWin:onClickRewardType(index)
if index==self.clickSelectTypeIdx then
return
end
self.clickSelectTypeIdx=index
return self:refresh()
end
