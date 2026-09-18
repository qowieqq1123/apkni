







def_class("tipsChildMainFabaoButton",UICloneObject)





tipsChildMainFabaoButton.abName="ui/windows/tips/child/tipschildmainfabaobutton.ab"

tipsChildMainFabaoButton.assetName="tipsChildMainFabaoButton"


function tipsChildMainFabaoButton:bindComponents()

self.btn=UIButton.get(self,0)
self.btnTxt=UIText.get(self,1)

self.btn:setButtonClick(function()self:onBtn()end)

end


function tipsChildMainFabaoButton:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btn);self.btn=nil;
_UIObject_release(self.btnTxt);self.btnTxt=nil;
end








function tipsChildMainFabaoButton:onLoaded(...)
self:bindComponents()
end

function tipsChildMainFabaoButton:__delete()
self:unbindComponents()
end

function tipsChildMainFabaoButton:onShow(args,afterOnloaded)
local data=args.argtable
local itemguid=data.itemguid
self.itemguid=itemguid
self.index=data.attach.index
end

function tipsChildMainFabaoButton:onHide()

end




function tipsChildMainFabaoButton:onBtn()
UIManager:callWindowFunc('UIBenMingFabaoWin','onSelectMainFaBao',self.index,self.itemguid)
UIManager:closeWindow('UIMultiTipsWin')
end