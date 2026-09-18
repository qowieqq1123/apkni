







def_class("UIMonthRuleWin",UIWindowBase)









function UIMonthRuleWin:bindComponents()

self.txTitle=UIText.get(self,0)
self.text1=UIText.get(self,1)
self.text2=UIText.get(self,2)
self.text3=UIText.get(self,3)
self.btncloses=UIButton.get(self,4)

self.btncloses:setButtonClick(function()self:onBtncloses()end)



end


function UIMonthRuleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.txTitle);self.txTitle=nil;
_UIObject_release(self.text1);self.text1=nil;
_UIObject_release(self.text2);self.text2=nil;
_UIObject_release(self.text3);self.text3=nil;
_UIObject_release(self.btncloses);self.btncloses=nil;
end


















function UIMonthRuleWin:onLoaded(...)
self:bindComponents()
end

function UIMonthRuleWin:__delete()
self:unbindComponents()
end

function UIMonthRuleWin:onShow(argtable,afterOnloaded)









local name=argtable.name
local title=argtable.title or"月卡续订规则"
local _desclist={}
local str=cfgHelper.get1(cfg_lang_get,name)or""
if str~=nil then
table.insert(_desclist,str)
end

local cfg={}
self.txTitle:setText(title)
self.text1:setText(str)


























end

function UIMonthRuleWin:onHide()

end




function UIMonthRuleWin:OnClickClose()
self:closeSelf()
end

function UIMonthRuleWin:onBtncloses()
self:closeSelf()
end