







def_class("UIDialougeBuyWithConsume",UIWindowBase)









function UIDialougeBuyWithConsume:bindComponents()

self.root=UIObject.get(self,0)
self.rewardview=UIObject.get(self,1)
self.tip=UIText.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.titleText=UIText.get(self,4)
self.cancelButton=UIButton.get(self,5)
self.okButton=UIButton.get(self,6)
self.cancelText=UIText.get(self,7)
self.okText=UIText.get(self,8)
self.Content=UIObject.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeBuyWithConsume:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rewardview);self.rewardview=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.Content);self.Content=nil;
end



















function UIDialougeBuyWithConsume:onLoaded(...)
self:bindComponents()

self.rewardview:setChildScrollViewInit(0.5,false,nil,nil)
end


function UIDialougeBuyWithConsume:__delete()
self:unbindComponents()
end




function UIDialougeBuyWithConsume:onShow(showdata,afterOnloaded)

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


if showdata.tip then
self.tip:setText(showdata.tip)
else
self.tip:setActive(false)
end

self.showdata=showdata
self.id=showdata.id

self.itemlist=showdata.itemlist
if self.itemlist then
local len=#self.itemlist
local propData={}

for i,itemdata in ipairs(self.itemlist)do
local countStr
if itemdata.itemcount>=itemdata.needcount then
countStr=itemdata.itemcount
else
countStr=toColorString(FONT_COLOR.eRedColor,itemdata.itemcount)
end
local countColor=itemdata.needcount>itemdata.itemcount and FONT_COLOR.eRedColor or FONT_COLOR.eGrayWhiteTxtColor
local showCount=Mathf.Min(itemdata.needcount,itemdata.itemcount)
countStr=FMT.fmt('{0}',toColorString(countColor,showCount))
local conf={itemid=itemdata.itemid,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
table.insert(propData,prop)
end

local refreshCB=function(grid,data,prop)
grid:SetChildPropData(0,prop)
grid:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(data.itemid)
end)
end
self.rewardview:setChildScrollViewCreateGrids(1,0)
local grids=self.rewardview:getChildScrollViewItemWidgets()
for index=1,grids.Count do
local grid=grids[index-1]
local data=self.itemlist[index]
local prop=propData[index]
refreshCB(grid,data,prop)
end
end
end


function UIDialougeBuyWithConsume:onHide()

end





function UIDialougeBuyWithConsume:onCloseBtn()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()
self:close()
if closecallback then
closecallback()
end
end



function UIDialougeBuyWithConsume:onCancelButton()
local cancelcallback=self.showdata.cancelcallback
self.showdata:deleteSelf()
self:close()
if cancelcallback then
cancelcallback()
end
end



function UIDialougeBuyWithConsume:onOkButton()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

