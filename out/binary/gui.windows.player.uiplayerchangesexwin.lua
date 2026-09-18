







def_class("UIPlayerChangeSexWin",UIWindowBase)









function UIPlayerChangeSexWin:bindComponents()

self.UIPlayerChangeSexWin=UIWindowLua.new(self,0)
self.bg=UIObject.get(self,1)
self.btnConfirm=UIButton.get(self,2)
self.change=UIObject.get(self,3)
self.costBg=UIObject.get(self,4)
self.costItem=UIBaseItem.get(self,5)
self.current=UIObject.get(self,6)
self.effect=UIObject.get(self,7)
self.leftBg=UIImage.get(self,8)
self.leftModel=UIObject.get(self,9)
self.leftPanel=UIObject.get(self,10)
self.leftSpineMask=UIObject.get(self,11)
self.rightBg=UIImage.get(self,12)
self.rightModel=UIObject.get(self,13)
self.rightPanel=UIObject.get(self,14)
self.rightSpineMask=UIObject.get(self,15)
self.root=UIObject.get(self,16)
self.showChangeSexRoot=UIObject.get(self,17)
self.topPanel=UIObject.get(self,18)
self.yixingchenggong=UIObject.get(self,19)
self.zushixingxiang=UIObject.get(self,20)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)



end


function UIPlayerChangeSexWin:unbindComponents()
local _UIObject_release=UIObject.release
self.UIPlayerChangeSexWin:deleteSelf();self.UIPlayerChangeSexWin=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.change);self.change=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.costItem);self.costItem=nil;
_UIObject_release(self.current);self.current=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.leftBg);self.leftBg=nil;
_UIObject_release(self.leftModel);self.leftModel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.leftSpineMask);self.leftSpineMask=nil;
_UIObject_release(self.rightBg);self.rightBg=nil;
_UIObject_release(self.rightModel);self.rightModel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.rightSpineMask);self.rightSpineMask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.showChangeSexRoot);self.showChangeSexRoot=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.yixingchenggong);self.yixingchenggong=nil;
_UIObject_release(self.zushixingxiang);self.zushixingxiang=nil;
end


















local abName="ui/windows/player/player_changesex_atlas_pak.ab"
local womanBgName="image_xinyixing_4"
local manBgName="image_xinyixing_6"
local womanSexIcon="image_xinyixing_8"
local manSexIcon="image_xinyixing_9"


function UIPlayerChangeSexWin:onLoaded(...)
self:bindComponents()
self.costList=playerImageConfig.getPlayerImageSexChangedCost()

self.costItem:setBaseItemClickEvent(function()
self:onCostItemClick()
end)
self.bg:setChildUIModelShowTarget(6235,1,nil,eAnimationID.enter)
self.costBg:setChildUIModelShowTarget(6236,1,nil,eAnimationID.enter)
end


function UIPlayerChangeSexWin:__delete()
local playerImage=playerImageModel:getPlayerImage()
self.playerImage=playerImage
playerImageModel:savePreviewPlayerImage()
self:unbindComponents()
end




function UIPlayerChangeSexWin:onShow(argtable,afterOnloaded)
local playerImage=playerImageModel:getPlayerImage()
self.playerImage=playerImage
self.leftModel:setActive(true)
self.rightModel:setActive(true)
self:freshModel(self.leftModel)
self:freshChangeSexModel(self.rightModel)
self:freshSpineMask()

self.root:setChildCanvasGroupAlpha(0)
self.current:setChildCanvasGroupAlpha(0)
self.change:setChildCanvasGroupAlpha(0)
self.winlua:SetChildDOScale(self.leftPanel:getID(),1,1,nil)
self.winlua:SetChildDOScale(self.rightPanel:getID(),1,1,nil)
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,1,nil)
self.current:setChildCanvasGroupDOFade(1,1,nil)
self.change:setChildCanvasGroupDOFade(1,1,nil)
end)

local graynum=0
if self:checkChangeSex()then
self.btnConfirm:setActive(true)
graynum=0
else
self.winlua:SetChildButtonEnable(self.btnConfirm:getID(),true,true)
graynum=1
end

local costList=self.costList
local cost=costList[1]
local itemid=cost[1]
local item_data={itemid=itemid,itemcount=1}
local conf={itemid=itemid,itemcount=1,showCountBG=false,gray=graynum,showname=false,colorEffect=false}
local propData=itemsComponentHelper.getCommonFillData(item_data,conf)
self.costItem:setChildPropData(propData)
end


function UIPlayerChangeSexWin:onHide()

end






function UIPlayerChangeSexWin:onBtnConfirm()
if self:checkChangeSex()then
self.current:setActive(false)
self.change:setActive(false)
self.topPanel:setActive(false)
self.costBg:setActive(false)

local centerPostion=self.zushixingxiang:getChildPosition()
local tweener=self.winlua:SetChildDOMove(self.leftPanel:getID(),centerPostion,1)
self.winlua:SetChildDOMove(self.rightPanel:getID(),centerPostion,1)
self.winlua:SetChildDOScale(self.leftPanel:getID(),0.4,1,nil)
self.tweener=tweener
tweener:SetEase(_Ease.Linear)
tweener:OnComplete(function()
self.showChangeSexRoot:setActive(true)
self.yixingchenggong:setChildShowEffect(22654,true)
self.effect:setChildShowEffect(22655,true)
local playerImageChangeSex=playerImageModel:getPreviewPlayerImage()
self.playerImage=playerImageChangeSex
playerImageModel:savePreviewPlayerImage(self.playerImage)
playerImageController:reqChangeSex()
end)
else

local costList=self.costList
local cost=costList[1]
local itemid=cost[1]
gainControl:showGainWin(itemid)
UIManager.info('祖师还未拥有阴阳易形丹，无法进行阴阳转换')
end
end


function UIPlayerChangeSexWin:freshModel(model)

local sex=playerModel:getActorSex()
local playerImage=table.deepCopy(self.playerImage)
playerImageController.setPlayerModel(self.winlua,model:getID(),playerImage,0.7,eAnimationID.idle,0,0,playerController:supportDynamic())
end

function UIPlayerChangeSexWin:freshChangeSexModel(model)
local sex=playerModel:getActorSex()
local ChangeSex
if sex==1 then
ChangeSex=0
else
ChangeSex=1
end
local playerImage=table.deepCopy(self.playerImage)
for tabid,id in pairs(playerImage)do
local cfg=playerImageConfig.getSubConfig(tabid,id)
local changeSexId=cfg and cfg.sex_change_id or nil
if changeSexId~=nil then
playerImage[tabid]=changeSexId
else
playerImage[tabid]=playerImageConfig.getDefaultImage(tabid,ChangeSex)
end
end

playerImageModel:savePreviewPlayerImage(playerImage)
playerImageController.setPlayerModel(self.winlua,model:getID(),playerImage,0.7,eAnimationID.idle,0,0,playerController:supportDynamic())
end

function UIPlayerChangeSexWin:freshSpineMask()
local leftWidget=self.leftPanel:getChildWidgetBase()
local rightWidget=self.rightPanel:getChildWidgetBase()

local sex=playerModel:getActorSex()
if sex==0 then
leftWidget:SetChildCSImageSprite(0,abName,womanBgName)
leftWidget:SetChildCSImageSprite(1,abName,womanSexIcon)
self.leftSpineMask:setChildUIModelShowTarget(6239,1,nil,eAnimationID.enter)
rightWidget:SetChildCSImageSprite(0,abName,manBgName)
rightWidget:SetChildCSImageSprite(1,abName,manSexIcon)
self.rightSpineMask:setChildUIModelShowTarget(6237,1,nil,eAnimationID.enter)
else
leftWidget:SetChildCSImageSprite(0,abName,manBgName)
leftWidget:SetChildCSImageSprite(1,abName,manSexIcon)
self.leftSpineMask:setChildUIModelShowTarget(6237,1,nil,eAnimationID.enter)
rightWidget:SetChildCSImageSprite(0,abName,womanBgName)
rightWidget:SetChildCSImageSprite(1,abName,womanSexIcon)
self.rightSpineMask:setChildUIModelShowTarget(6239,1,nil,eAnimationID.enter)
end
end

function UIPlayerChangeSexWin:onCostItemClick()
local costList=self.costList
local cost=costList[1]
local itemid=cost[1]
tipsManager.showTips({itemid=itemid,itemguid=nil})
end

function UIPlayerChangeSexWin:checkChangeSex()
local costList=self.costList
local cost=costList[1]
local itemid=cost[1]
local need=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=itemBagModel:getItemCountByItemID(itemid)
end
if have<need then
return false
else
return true
end
end