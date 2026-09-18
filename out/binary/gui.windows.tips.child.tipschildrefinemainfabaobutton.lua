







def_class("tipsChildRefineMainFabaoButton",UICloneObject)





tipsChildRefineMainFabaoButton.abName="ui/windows/tips/child/tipschildrefinemainfabaobutton.ab"

tipsChildRefineMainFabaoButton.assetName="tipsChildRefineMainFabaoButton"


function tipsChildRefineMainFabaoButton:bindComponents()

self.btn=UIButton.get(self,0)
self.btnTxt=UIText.get(self,1)

self.btn:setButtonClick(function()self:onBtn()end)

end


function tipsChildRefineMainFabaoButton:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btn);self.btn=nil;
_UIObject_release(self.btnTxt);self.btnTxt=nil;
end









function tipsChildRefineMainFabaoButton:onLoaded(...)
self:bindComponents()
end


function tipsChildRefineMainFabaoButton:__delete()
self:unbindComponents()
end




function tipsChildRefineMainFabaoButton:onShow(args,afterOnloaded)
local data=args.argtable
local itemguid=data.itemguid
self.itemguid=itemguid
self.index=data.attach.index
end


function tipsChildRefineMainFabaoButton:onHide()

end

function tipsChildRefineMainFabaoButton:onBtn()
UIManager:callWindowFunc('UIBenMingAgainRefineWin','onSelectMainFaBao',self.index,self.itemguid)
UIManager:closeWindow('UIMultiTipsWin')
end


