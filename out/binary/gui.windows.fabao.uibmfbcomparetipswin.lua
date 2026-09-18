







def_class("UIBMFBCompareTipsWin",UIWindowBase)









function UIBMFBCompareTipsWin:bindComponents()

self.arrow=UIObject.get(self,0)
self.bg=UIObject.get(self,1)
self.creater=UIGameobjectClone.new(self,2)
self.createrExt=UIGameobjectClone.new(self,3)
self.leftTipsNode=UIObject.get(self,4)
self.returnBtn=UIButton.get(self,5)
self.rightTipsNode=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.xin=UIObject.get(self,8)

self.returnBtn:setButtonClick(function()self:onReturnBtn()end)



end


function UIBMFBCompareTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.bg);self.bg=nil;
self.creater:deleteSelf();self.creater=nil;
self.createrExt:deleteSelf();self.createrExt=nil;
_UIObject_release(self.leftTipsNode);self.leftTipsNode=nil;
_UIObject_release(self.returnBtn);self.returnBtn=nil;
_UIObject_release(self.rightTipsNode);self.rightTipsNode=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.xin);self.xin=nil;
end
















local _xinPosList={-32,-46}




function UIBMFBCompareTipsWin:onLoaded(...)
self:bindComponents()
end


function UIBMFBCompareTipsWin:__delete()
self:unbindComponents()
end




function UIBMFBCompareTipsWin:onShow(argtable,afterOnloaded)
self.args=argtable

if afterOnloaded then
tipsManager.closeTips()
end

self:showLeftTips()

self:showRightTips()
end


function UIBMFBCompareTipsWin:onHide()

end


function UIBMFBCompareTipsWin:showLeftTips()
local args={
argtable=self.args.leftArgs,
}
local nodeIdx=self.leftTipsNode:getID()

self.creater:createObject('UITipsItem',nodeIdx,0,args)
end

function UIBMFBCompareTipsWin:showRightTips()
local args={
argtable=self.args.rightArgs,
}
local nodeIdx=self.rightTipsNode:getID()

self.creater:createObject('UITipsItem',nodeIdx,0,args)

local isEx=self.args.rightArgs.isExtraTips
local posIndex=isEx and 2 or 1
local xinPosY=_xinPosList[posIndex]
self.xin:setChildAnchoredPos(-21.79,xinPosY)
end





function UIBMFBCompareTipsWin:onReturnBtn()
local args={itemguid=self.args.sourceArgs.itemguid,openCallBack=function()
UIManager:invokeUIMethod('UIBMFBCompareTipsWin','closeSelf')
end}
args.formType=TIPS_FORM_TYPE.eFaBaoRefineCompare
args.attach={
oldItemGuid=self.args.sourceArgs.attach.oldItemGuid,
baseOldItemGuid=self.args.sourceArgs.attach.baseOldItemGuid,
baseNewItemGuid=self.args.sourceArgs.attach.baseNewItemGuid,
}
tipsManager.showTips(args)

end

