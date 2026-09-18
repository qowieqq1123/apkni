







def_class("UISystemZongMenSurrenderListWin",UIWindowBase)









function UISystemZongMenSurrenderListWin:bindComponents()

self.background=UIButton.get(self,0)
self.arrow=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.ScrollView=UIObject.get(self,3)
self.infoList=UIObject.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)



end


function UISystemZongMenSurrenderListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.infoList);self.infoList=nil;
end















local _this=nil
local _itemCmp={
name=0,
button=1,
}



function UISystemZongMenSurrenderListWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSystemZMInit,self.onSystemZMInit)
self:addNotify(notifyConfig.onSystemZMFightFlagChanged,self.onSystemZMFightFlagChanged)
end


function UISystemZongMenSurrenderListWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenSurrenderListWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.arrow:setChildAnchoredPosition(argtable.arrow)
self:refreshView()
end


function UISystemZongMenSurrenderListWin:onHide()

end





function UISystemZongMenSurrenderListWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
UIManager:closeWindow(self.__name)
end
end

function UISystemZongMenSurrenderListWin:refreshView()
local dataList=systemZongMenModel:getFightFlagLookup(systemZongMenFightFlagType.eSurrender)
if#dataList>0 then
self.infoList:setChildLayoutGroupCreateItems(#dataList,function(index)
local item=self.infoList:getChildLayoutGroupGridItem(index-1)
local serial=dataList[index]
local infoData=systemZongMenModel:getInfoData(serial)
local nameStr=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
item:SetChildText(_itemCmp.name,nameStr)
item:SetChildButtonClick(_itemCmp.button,function()
self:onBackground()

local unitKey=systemZongMenModel:convertUnitKey(serial)
if worldController:isInWorld()and worldModel:isSameWorld(infoData.worldId)then
worldController:clickUnit(unitKey)
else
worldController:enterWorld(infoData.worldId,{clickUnit=unitKey})
end
end)
end)
local height=Mathf.Clamp(7.5+#dataList*102.5,0,500)
self.root:setChildSizeDelta(422,height)
self.ScrollView:setChildScrollRectEnable(height>=500)
else
self:onBackground()
end
end

function UISystemZongMenSurrenderListWin.onSystemZMInit()
_this:refreshView()
end

function UISystemZongMenSurrenderListWin.onSystemZMFightFlagChanged(serial,oldFlag,newFlag)
if oldFlag==systemZongMenFightFlagType.eSurrender or newFlag==systemZongMenFightFlagType.eSurrender then
_this:refreshView()
end
end