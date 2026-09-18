







def_class("UIXianJie_monsterFaZeWin",UIWindowBase)









function UIXianJie_monsterFaZeWin:bindComponents()

self.background=UIButton.get(self,0)
self.fazeList=UIObject.get(self,1)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIXianJie_monsterFaZeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.fazeList);self.fazeList=nil;
end















local _this=nil



function UIXianJie_monsterFaZeWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianJie_monsterFaZeWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJie_monsterFaZeWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.fazes=argtable.fazes

self.fazeList:setChildLayoutGroupCreateItems(#self.fazes,function(index)
local item=self.fazeList:getChildLayoutGroupGridItem(index-1)
local faze=self.fazes[index]
local fazeID=faze[1]
local fazeLv=faze[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
if fazeCfg then
local descparm=fazeCfg.descparm
local desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLv]))or fazeCfg.desc
local checkGo=item:GetChildGameObject(3)
local width=item:GetChildSizeDeltaX(3)
desc=comHelper.getCheckLayoutStr(checkGo,width,desc)
item:SetChildCSImageIcon(0,fazeCfg.image,false)
item:SetChildText(1,fazeCfg.name)
item:SetChildText(2,desc)
else
loggerUtil.logErrFMT("没有对应的法则配置：{0}",fazeID)
end
end)
self.winlua:ForceLayoutVertical(self.fazeList:getID())
end


function UIXianJie_monsterFaZeWin:onHide()

end




function UIXianJie_monsterFaZeWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

