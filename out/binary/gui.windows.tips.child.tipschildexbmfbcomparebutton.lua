







def_class("tipsChildExBMFBCompareButton",UICloneObject)





tipsChildExBMFBCompareButton.abName="ui/windows/tips/child/tipschildexbmfbcomparebutton.ab"

tipsChildExBMFBCompareButton.assetName="tipsChildExBMFBCompareButton"


function tipsChildExBMFBCompareButton:bindComponents()

self.compareBtn=UIButton.get(self,0)
self.compareExBtn=UIButton.get(self,1)
self.root=UIObject.get(self,2)

self.compareBtn:setButtonClick(function()self:onCompareBtn()end)

self.compareExBtn:setButtonClick(function()self:onCompareExBtn()end)

end


function tipsChildExBMFBCompareButton:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.compareBtn);self.compareBtn=nil;
_UIObject_release(self.compareExBtn);self.compareExBtn=nil;
_UIObject_release(self.root);self.root=nil;
end









function tipsChildExBMFBCompareButton:onLoaded(...)
self:bindComponents()
end


function tipsChildExBMFBCompareButton:__delete()
self:unbindComponents()
end




function tipsChildExBMFBCompareButton:onShow(argtable,afterOnloaded)
self.args=argtable.argtable
end


function tipsChildExBMFBCompareButton:onHide()

end

function tipsChildExBMFBCompareButton:onCompareBtn()
self:showCompareTipsWin(false,TIPS_TYPE.eCommonFabao,TIPS_COLOR_TYPE.eFabao,self.args.attach.baseOldItemGuid,self.args.attach.baseNewItemGuid)
end

function tipsChildExBMFBCompareButton:onCompareExBtn()
self:showCompareTipsWin(true,TIPS_TYPE.eCommonBenMingFaBao,nil,self.args.attach.oldItemGuid,self.args.itemguid)
end

function tipsChildExBMFBCompareButton:showCompareTipsWin(isEx,tipsType,colorType,leftGuid,rightGuid)
local args={}

args.leftArgs={
itemguid=leftGuid,
formType=TIPS_FORM_TYPE.eFaBaoRefineCompare,
attach={},
isExtraTips=isEx,
tipsType=tipsType,
colorType=colorType,
}

args.rightArgs={
itemguid=rightGuid,
formType=TIPS_FORM_TYPE.eFaBaoRefineCompare,
attach={},
isExtraTips=isEx,
tipsType=tipsType,
colorType=colorType,
}

args.sourceArgs=self.args

UIManager:showWindow("UIBMFBCompareTipsWin",args)

end



