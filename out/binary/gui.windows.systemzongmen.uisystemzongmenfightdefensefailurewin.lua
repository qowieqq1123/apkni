







def_class("UISystemZongMenFightDefenseFailureWin",UIWindowBase)









function UISystemZongMenFightDefenseFailureWin:bindComponents()

self.desc=UIText.get(self,0)
self.closeTips=UIButton.get(self,1)
self.view_1=UIObject.get(self,2)
self.view_2=UIObject.get(self,3)
self.effect=UIObject.get(self,4)
self.closeTx=UIText.get(self,5)
self.itemList=UIObject.get(self,6)
self.buffList=UIObject.get(self,7)

self.closeTips:setButtonClick(function()self:onCloseTips()end)
self.view={
self.view_1,
self.view_2,
}



end


function UISystemZongMenFightDefenseFailureWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.view_1);self.view_1=nil;
_UIObject_release(self.view_2);self.view_2=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.closeTx);self.closeTx=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.buffList);self.buffList=nil;
self.view=nil;
end















local _this=nil
local _stepType={
eItem=1,
eBuff=2,
}



function UISystemZongMenFightDefenseFailureWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISystemZongMenFightDefenseFailureWin:__delete()
self:unbindComponents()
_this=nil

if self.sequence and self.sequence:IsActive()then
self.sequence:Kill()
self.sequence=nil
end
end




function UISystemZongMenFightDefenseFailureWin:onShow(argtable,afterOnloaded)
self.itemDatas=argtable.itemDatas
self.stepIndex=(self.itemDatas and#self.itemDatas>0)and 0 or 1
self.desc:setText(argtable.desc or"")
self:initItemList()
self:initBuffList()
self:onCloseTips()
end


function UISystemZongMenFightDefenseFailureWin:onHide()

end





function UISystemZongMenFightDefenseFailureWin:onCloseTips()
if self.sequence then return end

local oldStep=self.stepIndex
self.stepIndex=self.stepIndex+1
local oldView=self.view[oldStep]
local newView=self.view[self.stepIndex]

if newView then
newView:setActive(true)
self.sequence=Lua.SequenceProxy.New()
if oldView and self.winlua:GetChildActiveSelf(oldView:getID())then
oldView:setChildCanvasGroupAlpha(1)
local tweener1=oldView:setChildCanvasGroupDOFade(0,0.5)
self.sequence:Join(tweener1)
end
local tweener2=newView:setChildCanvasGroupDOFade(1,0.5)
self.sequence:Join(tweener2)
self.sequence:AppendCallback(function()
if oldView then
oldView:setActive(false)
end
self.sequence=nil
end)
else
self:closeSelf()
end
end

function UISystemZongMenFightDefenseFailureWin:initItemList()
local count=self.itemDatas and#self.itemDatas or 0
self.itemList:setChildLayoutGroupCreateItems(count,function(index)
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local itemData=self.itemDatas[index]
local itemId=itemData.itemid
local itemNum=math.min(itemData.num,0)
item:SetChildCSImageIcon(0,iconHelper.getIconName(itemId),false)




item:SetChildText(1,FMT.fmt("-{0}",mathHelper.formatNumber3(math.abs(itemNum),true)))
end)
self.winlua:SetChildScrollRectEnable(self.view_1:getID(),count>3)
end

function UISystemZongMenFightDefenseFailureWin:initBuffList()
local buffId=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"defFailBuffId")
self.buffList:setChildLayoutGroupCreateItems(1,function(index)
local item=self.buffList:getChildLayoutGroupGridItem(index-1)
local config=cfg_guildstateconfig_get(buffId)
item:SetChildCSImageIcon(0,iconHelper.getBuffIcon(config.icon),false)
item:SetChildText(1,config.name)
item:SetChildText(2,homeBuffModel:getBuffDescByStateId(buffId))
end)
self.winlua:SetChildScrollRectEnable(self.view_2:getID(),false)
end
