







def_class("UIWDCQCSJGWin",UIWindowBase)









function UIWDCQCSJGWin:bindComponents()

self.backCloseBtn=UIButton.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.descGroup=UIText.get(self,2)
self.descResult=UIText.get(self,3)
self.gameLevelImg=UIImage.get(self,4)
self.resultTitleSpine=UIObject.get(self,5)
self.Root=UIObject.get(self,6)
self.uiRoot=UIObject.get(self,7)

self.backCloseBtn:setButtonClick(function()self:onBackCloseBtn()end)



end


function UIWDCQCSJGWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backCloseBtn);self.backCloseBtn=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.descGroup);self.descGroup=nil;
_UIObject_release(self.descResult);self.descResult=nil;
_UIObject_release(self.gameLevelImg);self.gameLevelImg=nil;
_UIObject_release(self.resultTitleSpine);self.resultTitleSpine=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local transStageIdxList={
[1]=5,
[2]=6,
[3]=7,
[4]=4,
[5]=2,
[6]=1,
}




function UIWDCQCSJGWin:onLoaded(...)
self:bindComponents()
end


function UIWDCQCSJGWin:__delete()
self:unbindComponents()
end




function UIWDCQCSJGWin:onShow(argtable,afterOnloaded)
self.result=argtable.result
self.group=argtable.group
self.stage=argtable.stage
self.toStage=argtable.toStage
local descGroup=argtable.descGroup
local descResult=argtable.descResult
self.closeCallBack=argtable.closeCallBack

local spineId=self.result and 5585 or 5586
self.bgSpine:setChildUIModelShowTarget(spineId,1,nil,eAnimationID.enter)

local rusultTitleEffectId=self.result and 20452 or 20453
self.resultTitleSpine:setChildShowEffect(rusultTitleEffectId,true)

local idx=transStageIdxList[self.toStage]
local iconName=FMT.fmt("image_saijiygbt_{0}",idx)
self.gameLevelImg:setCSImageSprite('ui/windows/lundaodahui/lundaodahuiyugao_atlas_pak.ab',iconName)

self.descGroup:setText(descGroup)
self.descResult:setText(descResult)

WDCQController.setMsgWinOpenFlag(msgWinType.eWDCQCSJG,self.stage,0)
end


function UIWDCQCSJGWin:onHide()

end



function UIWDCQCSJGWin:onBackCloseBtn()
jumpManager:jump({id=JUMP_TYPE.eWDCangQiong,args={group=self.group,stage=self.toStage}})
end