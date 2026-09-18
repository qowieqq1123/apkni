







def_class("UIWDCQZZJGWin",UIWindowBase)









function UIWDCQZZJGWin:bindComponents()

self.backCloseBtn=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.desc=UIText.get(self,2)
self.fightLevelImg=UIImage.get(self,3)
self.fightLevellayout=UIObject.get(self,4)
self.fightLevelTxt=UIText.get(self,5)
self.Root=UIObject.get(self,6)
self.uiRoot=UIObject.get(self,7)

self.backCloseBtn:setButtonClick(function()self:onBackCloseBtn()end)



end


function UIWDCQZZJGWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backCloseBtn);self.backCloseBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.fightLevelImg);self.fightLevelImg=nil;
_UIObject_release(self.fightLevellayout);self.fightLevellayout=nil;
_UIObject_release(self.fightLevelTxt);self.fightLevelTxt=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local imgMCList={
"image_zuizhongmingci_wz3",
"image_zuizhongmingci_wz2",
"image_zuizhongmingci_wz1"
}

local txtMcList={
[4]='4',
[5]='8',
[6]='16',
[7]='32',
}




function UIWDCQZZJGWin:onLoaded(...)
self:bindComponents()
end


function UIWDCQZZJGWin:__delete()
self:unbindComponents()
end




function UIWDCQZZJGWin:onShow(argtable,afterOnloaded)

local playActorId=playerModel:getActorID()
local gameInfo=WDCQModel:getRankRoleInfoLookUp(playActorId)

self.group=gameInfo.groupId
self.stage=gameInfo.stageId
self.rank=WDCQModel:getRankRoleInfoLookUp(playActorId,2)

local isShowLevelImg=self.rank<=3
self.fightLevelImg:setActive(isShowLevelImg)
self.fightLevellayout:setActive(not isShowLevelImg)
local stageName2=WDCQCRankNmae[self.rank]
if isShowLevelImg then
local levelImgIcon=imgMCList[self.rank]
self.fightLevelImg:setCSImageSprite('ui/windows/lundaodahui/lundaojinji_atlas_pak.ab',levelImgIcon)
else
local txtRank=txtMcList[self.rank]
self.fightLevelTxt:setText(txtRank)
stageName2=FMT.fmt("{0}强",txtRank)
end

local result=self.rank==WDCQCRankEnum.eChampion or self.rank==WDCQCRankEnum.eThird
local resultStr=result and"获胜"or"惜败"

local stages=cfgHelper.get1(cfg_wendingcangqiongmatchconfig_get,self.group)
local len=#stages
local stageName1
if result then
stageName1=stages[self.stage].name
else
local toNextStage=self.stage
stageName1=stages[toNextStage].name
end

local desc=FMT.fmt("祖师在问鼎苍穹-{0}中{1}\n获得最终名次<color=#c82c2c><size=34>{2}！</size></color>",stageName1,resultStr,stageName2)
self.desc:setText(desc)

WDCQController.setMsgWinOpenFlag(msgWinType.eWDCQZZJG,true,false)

self.bgModel:setChildUIModelShowTarget(5578,1,nil,eAnimationID.enter)

self.winlua:ForceLayoutRect(self.fightLevellayout:getID())
end


function UIWDCQZZJGWin:onHide()

end





function UIWDCQZZJGWin:onBackCloseBtn()
self:closeSelf()
end

