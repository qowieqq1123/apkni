







def_class("UISubAct_GuBaoShiLian_FaZeListWin",UIWindowBase)









function UISubAct_GuBaoShiLian_FaZeListWin:bindComponents()

self.background=UIButton.get(self,0)
self.fazeList=UIObject.get(self,1)
self.fazeView=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)



end


function UISubAct_GuBaoShiLian_FaZeListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.fazeList);self.fazeList=nil;
_UIObject_release(self.fazeView);self.fazeView=nil;
end















local _this=nil
local _maxHeigh=384
local _itemCmp={
desc=0,
icon=1,
line=2,
name=3,
desc2=4,
}



function UISubAct_GuBaoShiLian_FaZeListWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_GuBaoShiLian_FaZeListWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_GuBaoShiLian_FaZeListWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.fazeDatas=argtable.fazeDatas
if#self.fazeDatas>0 then
self:refreshView()
else
self:onBackground()
end
end


function UISubAct_GuBaoShiLian_FaZeListWin:onHide()

end




function UISubAct_GuBaoShiLian_FaZeListWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_GuBaoShiLian_FaZeListWin:refreshView()
local fazeCount=#self.fazeDatas
self.fazeList:setChildLayoutGroupCreateItems(fazeCount,function(index)
local item=self.fazeList:getChildLayoutGroupGridItem(index-1)
local fazeData=self.fazeDatas[index]
local fazeID=fazeData[1]
local fazeLV=fazeData[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local descparm=fazeCfg.descparm
local iconName=fazeCfg.image
local fazeName=fazeCfg.name
local desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLV]))or fazeCfg.desc
local checkObj=item:GetChildGameObject(_itemCmp.desc2)
local checkWidth=item:GetChildSizeDeltaX(_itemCmp.desc2)
local descStr=comHelper.getCheckLayoutStr(checkObj,checkWidth,desc)
item:SetChildCSImageIcon(_itemCmp.icon,iconName,false)
item:SetChildText(_itemCmp.name,fazeName)
item:SetChildText(_itemCmp.desc,descStr)
item:SetChildActive(_itemCmp.line,index~=fazeCount)
end)
self.winlua:ForceLayoutRect(self.fazeList:getID())
local contentHeight=self.fazeList:getChildSizeDeltaY()
self.winlua:SetChildScrollRectEnable(self.fazeView:getID(),contentHeight>_maxHeigh)
local oWidth=self.fazeView:getChildSizeDeltaX()
self.fazeView:setChildSizeDelta(oWidth,math.min(contentHeight,_maxHeigh))
end

