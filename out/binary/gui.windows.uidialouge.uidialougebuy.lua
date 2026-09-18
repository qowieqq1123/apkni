







def_class("UIDialougeBuy",UIWindowBase)









function UIDialougeBuy:bindComponents()

self.cancelButton=UIButton.get(self,0)
self.cancelText=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.contentTx=UILinkImageText.get(self,3)
self.itemList=UIObject.get(self,4)
self.okButton=UIButton.get(self,5)
self.okText=UIText.get(self,6)
self.root=UIObject.get(self,7)
self.tipsTx=UIText.get(self,8)
self.titleText=UIText.get(self,9)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeBuy:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.contentTx);self.contentTx=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UIDialougeBuy:onLoaded(...)
self:bindComponents()
end


function UIDialougeBuy:__delete()
self:unbindComponents()
end




function UIDialougeBuy:onShow(argtable,afterOnloaded)

self.titleText:setText(showdata.title)


if showdata.canceltext~=nil then
self.cancelText:setText(showdata.canceltext)
else
self.cancelButton:setActive(false)
end

if showdata.canvasindex then
self.winlua:SetCanvasIndex(10,showdata.canvasindex)
end


if showdata.oktext~=nil then
self.okText:setText(showdata.oktext)
else
self.okButton:setActive(false)
end


if showdata.showclosebtn then
self.closeBtn:setActive(showdata.showclosebtn)
else
self.closeBtn:setActive(false)
end

if showdata.content then
self.contentTx:setText(showdata.content)
else
self.contentTx:setText("")
end

if showdata.tips then
self.tipsTx:setText(showdata.tips)
else
self.tipsTx:setText("")
end
self.winlua:ForceLayoutRect(self.tipsTx:getID())

if showdata.items then
self.itemList:setChildLayoutGroupCreateItems(#showdata.items,function(index)
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local data=showdata.items[index]
local showCountBG=false
local countStr=""
if data.itemcount then
showCountBG=data.itemcount>1
countStr=showCountBG and mathHelper.formatNumber(data.itemcount)or""
elseif data.countStr then
showCountBG=true
countStr=data.countStr
else
local itemCount=itemsModel.getCount(data.itemid)
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=data.itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
else
self.itemList:setActive(false)
end

self.showdata=showdata
self.id=showdata.id
end


function UIDialougeBuy:onHide()

end





function UIDialougeBuy:onCancelButton()
local cancelcallback=self.showdata.cancelcallback
self.showdata:deleteSelf()

self:close()
if cancelcallback then
cancelcallback()
end
end



function UIDialougeBuy:onCloseBtn()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end



function UIDialougeBuy:onOkButton()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeBuy:onBGClick()
if self.showdata.bgClick then
self:onCancelButton()
end
end
