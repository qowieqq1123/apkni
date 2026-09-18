







def_class("UIDialgueBackPanel",UIWindowBase)









function UIDialgueBackPanel:bindComponents()

self.bg=UIButton.get(self,0)





end


function UIDialgueBackPanel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
end


















function UIDialgueBackPanel:onLoaded(...)

if not UIManager:isActive("UIOtherDiscipleMainWin")and not UIManager:isActive("UICommonShowPrizeWin")then
self:setAsFirstSibling()
end
end

function UIDialgueBackPanel:__delete()

end

function UIDialgueBackPanel:onShow(argtable,afterOnloaded)
if argtable then
self.winlua:SetChildColor(0,argtable)
end
end

function UIDialgueBackPanel:onHide()

end



function UIDialgueBackPanel:closeSelf()
UIManager:closeWindow('UIEquipGainWin')
UIManager:closeWindow('UIFuBaoGainWin')
UIManager:closeWindow('UINewEquipGainWin')
UIManager:closeWindow('UIVocEquipGainWin')
UIManager:closeWindow('UIDialgueBackPanel')
tipsManager.closeTips()
end
