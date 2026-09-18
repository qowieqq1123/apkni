







def_class("UIMoJieGate_passListWin",UIWindowBase)









function UIMoJieGate_passListWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.askListGroup=UIObject.get(self,4)
self.noAskTipsText=UIText.get(self,5)
self.whiteListGroup=UIObject.get(self,6)
self.noWhiteTipsText=UIText.get(self,7)
self.autoApplyBtn=UIButton.get(self,8)
self.autoApplyNotSelect=UIImage.get(self,9)
self.autoApplySelect=UIImage.get(self,10)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.autoApplyBtn:setButtonClick(function()self:onAutoApplyBtn()end)



end


function UIMoJieGate_passListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.askListGroup);self.askListGroup=nil;
_UIObject_release(self.noAskTipsText);self.noAskTipsText=nil;
_UIObject_release(self.whiteListGroup);self.whiteListGroup=nil;
_UIObject_release(self.noWhiteTipsText);self.noWhiteTipsText=nil;
_UIObject_release(self.autoApplyBtn);self.autoApplyBtn=nil;
_UIObject_release(self.autoApplyNotSelect);self.autoApplyNotSelect=nil;
_UIObject_release(self.autoApplySelect);self.autoApplySelect=nil;
end



















function UIMoJieGate_passListWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieGate_passListWin:__delete()
self:unbindComponents()
end




function UIMoJieGate_passListWin:onShow(argtable,afterOnloaded)
self.gateId=argtable.gateId
self.bgModel:setChildUIModelShowTarget(6249,1,nil,eAnimationID.enter)
self:refresh()
end


function UIMoJieGate_passListWin:onHide()

end

function UIMoJieGate_passListWin:refresh()
xianjieModel:setMoJieGateReadAskMark(self.gateId)

UIManager:invokeUIMethod("UIMoJieGate_infoWin","refreshWhiteListBtn")


UIManager:invokeUIMethod('UIXianJieFuncStorageWin','refreshGateApply')


self:refreshLeftPanel()


self:refreshWhiteListPanel()
end


function UIMoJieGate_passListWin:refreshLeftPanel()

self:refreshAskListPanel()


self:refreshAutoApplyBtn()
end

function UIMoJieGate_passListWin:refreshWhiteListPanel()
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil

local whiteList=gateData and gateData.whiteList or nil
local count=whiteList and#whiteList or 0
self.noWhiteTipsText:setActive(count<=0)
self.whiteListGroup:setChildLayoutGroupCreateItems(count,function(index)
local widget=self.whiteListGroup:getChildLayoutGroupGridItem(index-1)
local wlXmData=whiteList[index]
local wlXmGuid=wlXmData and wlXmData.param_1 or nil
if wlXmGuid then
widget:SetChildActive(-1,true)

local xmName=wlXmData.param_3 or"未知仙盟"
widget:SetChildText(0,xmName)

widget:SetChildButtonClick(1,function()
return self:onClickRemoveBtn(wlXmGuid)
end)
else
widget:SetChildActive(-1,false)
end
end)
end

function UIMoJieGate_passListWin:refreshAskListPanel()
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil

local askList=gateData and gateData.askList or nil
local count=askList and#askList or 0
self.noAskTipsText:setActive(count<=0)
self.askListGroup:setChildLayoutGroupCreateItems(count,function(index)
local widget=self.askListGroup:getChildLayoutGroupGridItem(index-1)
local askXmData=askList[index]
local askXmGuid=askXmData and askXmData.param_1 or nil
if askXmGuid then
widget:SetChildActive(-1,true)

local xmName=askXmData.param_3 or"未知仙盟"
widget:SetChildText(0,xmName)

widget:SetChildButtonClick(1,function()
return self:onClickApplyBtn(askXmGuid)
end)
else
widget:SetChildActive(-1,false)
end
end)
end

function UIMoJieGate_passListWin:refreshAutoApplyBtn(gateId)
if gateId and gateId~=self.gateId then
return
end

local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local passType=gateData and gateData.askSetting or 0
local isAutoApply=passType==1

self.autoApplySelect:setActive(isAutoApply)
end

function UIMoJieGate_passListWin:refreshByGateId(gateId)
if not gateId or self.gateId==gateId then
return self:refresh()
end
end




function UIMoJieGate_passListWin:onClickMask()
self:onCloseBtn()
end



function UIMoJieGate_passListWin:onCloseBtn()
self:closeSelf()
end



function UIMoJieGate_passListWin:onAutoApplyBtn()

local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local season_id=gateData and gateData.seasonId or 1
local stageId=gateData and gateData.stageId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS
local passType=gateData and gateData.askSetting or 0
if passType==0 then
passType=1
elseif passType==1 then
passType=0
end

local gateId=self.gateId
xianjieController:reqSetGatePassType(season_id,chapter_idx,gateId,passType)
end


function UIMoJieGate_passListWin:onClickRemoveBtn(xmGuid)

local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local season_id=gateData and gateData.seasonId or 1
local stageId=gateData and gateData.stageId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS

local gateId=self.gateId
xianjieController:reqRemoveGatePass(season_id,chapter_idx,gateId,xmGuid)
end

function UIMoJieGate_passListWin:onClickApplyBtn(xmGuid)

local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local season_id=gateData and gateData.seasonId or 1
local stageId=gateData and gateData.stageId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS

local gateId=self.gateId
xianjieController:reqAllowGatePass(season_id,chapter_idx,gateId,xmGuid)
end
