







def_class("UICommonUseItem_goodChangeWin",UIWindowBase)









function UICommonUseItem_goodChangeWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.descText=UIText.get(self,1)
self.goodItem=UIObject.get(self,2)
self.cancelBtn=UIButton.get(self,3)
self.cancelText=UIText.get(self,4)
self.commitText=UIText.get(self,5)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UICommonUseItem_goodChangeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.goodItem);self.goodItem=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.commitText);self.commitText=nil;
end

















function UICommonUseItem_goodChangeWin:onLoaded(...)
self:bindComponents()
end


function UICommonUseItem_goodChangeWin:__delete()
self:unbindComponents()
end


function UICommonUseItem_goodChangeWin:onHide()

end




function UICommonUseItem_goodChangeWin:onShow(argtable,afterOnloaded)

self.titleTxt:setText(argtable.title or'提示')

local desc=argtable.desc or''
self.descText:setText(desc)

local item=self.goodItem:getChildWidgetBase()
local itemid=argtable.itemid
local itemnum=argtable.itemnum
local num_str=tostring(itemnum)
local conf={itemid=itemid,itemcount=num_str,showname=false,showStage=true,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)

local itemid2=argtable.itemid2
local itemnum2=argtable.itemnum2
local num_str2=tostring(itemnum2)
local conf2={itemid=itemid2,itemcount=num_str2,showname=false,showStage=true,showCountBG=true}
local prop2=itemsComponentHelper.getCommonFillDataSmall(conf2)
item:SetChildPropData(1,prop2)
item:SetBaseItemClickEvent(1,function(...)
self:onItemClick(...)
end)

local showCancel=argtable.showCancel
if showCancel==nil then showCancel=true end
self.cancelBtn:setActive(showCancel)
if showCancel then
self.cancelText:setText(argtable.cancelName or'取消')
end
self.commitText:setText(argtable.commitName or'确定')

self.cancelCB=argtable.cancelCB
self.commitCB=argtable.commitCB
end

function UICommonUseItem_goodChangeWin:onItemClick(itemid,index,guid,attach)
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UICommonUseItem_goodChangeWin:onCommitBtn()
local cb=self.commitCB
self:closeSelf()
if cb then
cb()
end
end

function UICommonUseItem_goodChangeWin:onCancelBtn()
local cb=self.cancelCB
self:closeSelf()
if cb then
cb()
end
end
