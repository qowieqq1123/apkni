







def_class("UIAirMiniGame_reviveWin",UIWindowBase)









function UIAirMiniGame_reviveWin:bindComponents()

self.name=UIText.get(self,0)
self.icon=UIObject.get(self,1)
self.desc=UIText.get(self,2)
self.applyBtn=UIButton.get(self,3)
self.applyBtnText=UIText.get(self,4)
self.useCount=UIText.get(self,5)
self.useTextRoot=UIObject.get(self,6)
self.useCost=UIText.get(self,7)
self.useCostIcon=UIImage.get(self,8)
self.giveUpBtn=UIButton.get(self,9)
self.mask=UIButton.get(self,10)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.giveUpBtn:setButtonClick(function()self:onGiveUpBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIAirMiniGame_reviveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.applyBtnText);self.applyBtnText=nil;
_UIObject_release(self.useCount);self.useCount=nil;
_UIObject_release(self.useTextRoot);self.useTextRoot=nil;
_UIObject_release(self.useCost);self.useCost=nil;
_UIObject_release(self.useCostIcon);self.useCostIcon=nil;
_UIObject_release(self.giveUpBtn);self.giveUpBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
end
















local _this




function UIAirMiniGame_reviveWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIAirMiniGame_reviveWin:__delete()
_this=nil

airController:pauseGame(false)
self:unbindComponents()
end




function UIAirMiniGame_reviveWin:onShow(argtable,afterOnloaded)

airController:pauseGame(true)

local processData=airModel:getActorProcessData()
processData.isOnDead=true
airModel:setActorProcessData(processData)
airController:setIsOnlyRefreshWinFlag(true)


airController:reqSaveFbProcessData(false)



self.costParams=cfgHelper.getdef(cfg_airfubenconfig,'revive_consume')
local costItemId=self.costParams[1]
local costCount=self.costParams[2]
self.useCost:setText(costCount)
self.useCostIcon:setImageIcon(iconHelper.getIconName(costItemId),false)
end


function UIAirMiniGame_reviveWin:onHide()

end

function UIAirMiniGame_reviveWin:onReviveRecv()
local processData=airModel:getActorProcessData()
processData.isOnDead=nil
if processData.reviveCount then
processData.reviveCount=processData.reviveCount+1
else
processData.reviveCount=1
end
airModel:setActorProcessData(processData)
airController:setIsOnlyRefreshWinFlag(true)
airController:reqSaveFbProcessData()


local ent=airActorSystem:getActor()
if ent then
ent:onRevive()
end

self:closeSelf()
end





function UIAirMiniGame_reviveWin:onApplyBtn()
if self.isSelect then
return
end


local costItemId=self.costParams[1]
local costCount=self.costParams[2]
local cb=function()
if not _this then return end
_this.isSelect=true

return airController:reqReviveActor()
end
if costItemId~=eMoneyType.mtLingYu then

local moneyCount=itemsModel.getCount(costItemId)
if moneyCount<costCount then
UIManager.error(FMT.fmt("{0}不足，无法复活",itemsConfig.getItemName(costItemId)))
return
end
return cb()
else

moneySystem:useMoney(costItemId,costCount,cb,WARNING_TYPE.eWarning)
end
end



function UIAirMiniGame_reviveWin:onGiveUpBtn()
if self.isSelect then
return
end

self.isSelect=true
local processData=airModel:getActorProcessData()
processData.isOnDead=nil
airModel:setActorProcessData(processData)



local ent=airActorSystem:getActor()
if ent then
ent:onDead(true)
end

self:closeSelf()
end



function UIAirMiniGame_reviveWin:onMask()
end

