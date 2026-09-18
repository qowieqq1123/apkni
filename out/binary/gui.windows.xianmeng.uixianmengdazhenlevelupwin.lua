







def_class("UIXianMengDaZhenLevelUpWin",UIWindowBase)









function UIXianMengDaZhenLevelUpWin:bindComponents()

self.attrList=UIObject.get(self,0)
self.background=UIButton.get(self,1)
self.effect=UIObject.get(self,2)
self.levelRoot=UIObject.get(self,3)
self.newLvTx=UIText.get(self,4)
self.oldLvTx=UIText.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIXianMengDaZhenLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrList);self.attrList=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.levelRoot);self.levelRoot=nil;
_UIObject_release(self.newLvTx);self.newLvTx=nil;
_UIObject_release(self.oldLvTx);self.oldLvTx=nil;
end















local _this=nil
local _attrCmp={
newTx=1,
oldTx=0,
arrow=2,
}



function UIXianMengDaZhenLevelUpWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianMengDaZhenLevelUpWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianMengDaZhenLevelUpWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.oldLv=argtable.oldLv
self.newLv=argtable.newLv
self:refreshView()
end


function UIXianMengDaZhenLevelUpWin:onHide()

end




function UIXianMengDaZhenLevelUpWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIXianMengDaZhenLevelUpWin:refreshView()
self.oldLvTx:setText(FMT.fmt("仙盟大阵：{0}级",self.oldLv))
self.newLvTx:setText(FMT.fmt("{0}级",self.newLv))
self.winlua:ForceLayoutRect(self.levelRoot:getID())

local oldCfg=cfgHelper.get1(cfg_devildomdazhenconfig_get,self.oldLv)
local newCfg=cfgHelper.get1(cfg_devildomdazhenconfig_get,self.newLv)
self.effect:setChildShowEffect(newCfg.showEffect[1],false)

local attrCnt=#oldCfg.showAttrs
self.attrList:setChildLayoutGroupCreateItems(attrCnt+2,function(index)
local item=self.attrList:getChildLayoutGroupGridItem(index-1)
if index<=attrCnt then
local oldAttr=oldCfg.showAttrs[index]
local newAttr=newCfg.showAttrs[index]
local attrId=oldAttr[1]
local oldVal=oldAttr[2]
local newVal=newAttr[2]
item:SetChildText(_attrCmp.oldTx,helper.getAttributeStr(attrId,oldVal,2,"{0}：{1}"))
item:SetChildActive(_attrCmp.arrow,oldVal~=newVal)
item:SetChildText(_attrCmp.newTx,oldVal~=newVal and helper.getAttributeStrEx(attrId,newVal,2)or"")
elseif index==attrCnt+1 then
local oldVal=oldCfg.max
local newVal=newCfg.max
item:SetChildText(_attrCmp.oldTx,FMT.fmt("驻防部队：{0}",oldVal))
item:SetChildActive(_attrCmp.arrow,oldVal~=newVal)
item:SetChildText(_attrCmp.newTx,oldVal~=newVal and newVal or"")
elseif index==attrCnt+2 then
local oldVal=oldCfg.shield
local newVal=newCfg.shield
item:SetChildText(_attrCmp.oldTx,FMT.fmt("城防值：{0}",mathHelper.formatNumber(oldVal)))
item:SetChildActive(_attrCmp.arrow,oldVal~=newVal)
item:SetChildText(_attrCmp.newTx,oldVal~=newVal and mathHelper.formatNumber(newVal)or"")
end
end)
end
