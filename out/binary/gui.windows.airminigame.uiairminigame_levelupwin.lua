







def_class("UIAirMiniGame_levelUpWin",UIWindowBase)









function UIAirMiniGame_levelUpWin:bindComponents()

self.mask=UIObject.get(self,0)
self.moneyRefreshBtn=UIButton.get(self,1)
self.itemRefreshBtn=UIButton.get(self,2)
self.attrGridGroup=UIObject.get(self,3)
self.moneyCostIcon=UIImage.get(self,4)
self.moneyCostCountText=UIText.get(self,5)
self.itemCostIcon=UIObject.get(self,6)
self.itemCostCountText=UIText.get(self,7)
self.nowLevelText=UIText.get(self,8)
self.nextLevelText=UIText.get(self,9)
self.clickMask=UIObject.get(self,10)
self.moneyRoot=UIObject.get(self,11)
self.moneyBtn=UIButton.get(self,12)

self.moneyRefreshBtn:setButtonClick(function()self:onMoneyRefreshBtn()end)

self.itemRefreshBtn:setButtonClick(function()self:onItemRefreshBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)



end


function UIAirMiniGame_levelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.moneyRefreshBtn);self.moneyRefreshBtn=nil;
_UIObject_release(self.itemRefreshBtn);self.itemRefreshBtn=nil;
_UIObject_release(self.attrGridGroup);self.attrGridGroup=nil;
_UIObject_release(self.moneyCostIcon);self.moneyCostIcon=nil;
_UIObject_release(self.moneyCostCountText);self.moneyCostCountText=nil;
_UIObject_release(self.itemCostIcon);self.itemCostIcon=nil;
_UIObject_release(self.itemCostCountText);self.itemCostCountText=nil;
_UIObject_release(self.nowLevelText);self.nowLevelText=nil;
_UIObject_release(self.nextLevelText);self.nextLevelText=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
end
















local _this
local attrGridItemCmp={
name=0,
icon=1,
attrText=2,
selectBtn=3,
}




function UIAirMiniGame_levelUpWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIAirMiniGame_levelUpWin:__delete()
_this=nil
self:clearFadeTweener()
self:unbindComponents()
end




function UIAirMiniGame_levelUpWin:onShow(argtable,afterOnloaded)
self.attrGridGroup:setChildCanvasGroupAlpha(0)
self:refresh(true)
end


function UIAirMiniGame_levelUpWin:onHide()
self:clearFadeTweener()
end

function UIAirMiniGame_levelUpWin:refresh(isInit)
self.nowLevel=airModel:getLevel()


self:refreshMoney()

local processData=airModel:getActorProcessData()
self.attrRandIdList=processData.settlementData.attrRandIdList
self:refreshBtnPanel()
if self.attrRandIdList then

self.nowLevelText:setText(FMT.fmt("{0}级",self.nowLevel))
self.nextLevelText:setText(FMT.fmt("{0}级",self.nowLevel+1))

self:clearFadeTweener()
local fun=function()
if not _this then return end

self:refreshAttrGroup()


self.fadeTweener=self.attrGridGroup:setChildCanvasGroupDOFade(1,0.5)
self.clickMask:setActive(false)
self.isInFade=nil
end

if not isInit then

self.clickMask:setActive(true)
self.fadeTweener=self.attrGridGroup:setChildCanvasGroupDOFade(0,0.5,fun)
self.isInFade=true
else
return fun()
end
end
end

function UIAirMiniGame_levelUpWin:refreshBtnPanel()

self.refreshCost=airController:getLevelUpAttrRefreshCost()
local moneyIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
if moneyIconName then
self.moneyCostIcon:setImageIcon(moneyIconName,false)
end
local costStr=tostring(self.refreshCost)
local moneyCount=airModel:getMoney()
if moneyCount<self.refreshCost then
costStr=FMT.cfmt(FONT_COLOR.eRedColor,costStr)
end
self.moneyCostCountText:setText(self.refreshCost)


local isShowCostRefreshBtn=self:checkIsCanShowCostRefreshBtn()
self.itemRefreshBtn:setActive(isShowCostRefreshBtn)

if isShowCostRefreshBtn then

local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"costMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.lvUpAttrRefreshCount_itemCost or 0
self.itemCostCountText:setText(FMT.fmt("{0}/{1}",maxRefreshNum-refreshCount,maxRefreshNum))
end
end
end

function UIAirMiniGame_levelUpWin:refreshAttrGroup()
local count=#self.attrRandIdList

self.attrGridGroup:setChildLayoutGroupCreateItems(count,function(index)
local widget=self.attrGridGroup:getChildLayoutGroupGridItem(index-1)
local attrRandId=self.attrRandIdList[index]
local attrRandCfg=cfgHelper.get(cfg_airrandattrconfig_get,attrRandId)
if attrRandCfg then
widget:SetChildActive(-1,true)

local name=attrRandCfg.name
local color=attrRandCfg.color
widget:SetChildText(attrGridItemCmp.name,FMT.cfmt(color,name))


local iconName=attrRandCfg.icon
local abName="ui/windows/airminigame/air_attr_icon_l_atlas_pak.ab"
if iconName then

widget:SetChildActive(attrGridItemCmp.icon,true)
widget:SetChildCSImageSprite(attrGridItemCmp.icon,abName,iconName)
else
widget:SetChildActive(attrGridItemCmp.icon,false)
end


local attrId=attrRandCfg.attr_type
local attrVal=attrRandCfg.attrVal
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrName=attrCfg.attrname
local attrSign=attrVal>=0 and'+'or''
local attrValStr=airController:getAttrStr(attrId,attrVal)
widget:SetChildText(attrGridItemCmp.attrText,FMT.fmt("{0}{1}{2}",attrName,attrSign,attrValStr))


widget:SetChildButtonClick(attrGridItemCmp.selectBtn,function()
self:onAttrSelectBtnClick(attrRandId)
end,true)
else
widget:SetChildActive(-1,false)
end
end)
end


function UIAirMiniGame_levelUpWin:clearFadeTweener()
if self.fadeTweener then
self.fadeTweener:Complete()
self.fadeTweener:Kill()
self.fadeTweener=nil
end
end

function UIAirMiniGame_levelUpWin:checkIsCanShowCostRefreshBtn()
local costParams=cfgHelper.getdef(cfg_airfubenconfig,'flush_consume')
local costItemId=costParams and costParams[1]or nil
if not costItemId then
return false
end


local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"costMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.lvUpAttrRefreshCount_itemCost or 0
if refreshCount>=maxRefreshNum then
return false
end
end


local itemNum=bagModel.getItemCountById(costItemId)
local uesNum=costParams and costParams[2]or 1
if not itemNum or itemNum<uesNum then
return false
end

return true
end

function UIAirMiniGame_levelUpWin:refreshMoney()
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyVal=airModel:getMoney()
local moneyIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,moneyIconName,false)
widget:SetChildText(1,moneyStr)
end




function UIAirMiniGame_levelUpWin:onMoneyRefreshBtn()
if self.isInFade then
return
end


local moneyCount=airModel:getMoney()
if moneyCount<self.refreshCost then
UIManager.error("云游精粹不足，无法刷新")
return
end


local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.lvUpAttrRefreshCount or 0
if refreshCount>=maxRefreshNum then
UIManager.error("刷新次数不足，无法刷新")
return
end
end


airController:refreshLevelUpAttrData(self.refreshCost,1)
end



function UIAirMiniGame_levelUpWin:onItemRefreshBtn()
if self.isInFade then
return
end

local costParams=cfgHelper.getdef(cfg_airfubenconfig,'flush_consume')
local costItemId=costParams and costParams[1]or nil
if not costItemId then
return
end


local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"costMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.lvUpAttrRefreshCount_itemCost or 0
if refreshCount>=maxRefreshNum then
UIManager.error("刷新次数不足，无法刷新")
return
end
end


local itemNum=bagModel.getItemCountById(costItemId)
local uesNum=costParams and costParams[2]or 1
if not itemNum or itemNum<uesNum then
local itemName=itemsConfig.getItemName(costItemId)
UIManager.error("{0}不足，无法刷新",itemName)
return
end


airController:refreshLevelUpAttrData(nil,2)
end

function UIAirMiniGame_levelUpWin:onAttrSelectBtnClick(attrRandId)
if self.isInFade then
return
end
airController:levelUpAddAttr(self.nowLevel,attrRandId)
end

function UIAirMiniGame_levelUpWin:onMoneyBtn()

end

