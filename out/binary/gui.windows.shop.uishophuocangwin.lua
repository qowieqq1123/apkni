







def_class("UIShopHuoCangWin",UIWindowBase)








function UIShopHuoCangWin:bindComponents()

self.leftDialogue=UIButton.get(self,0)
self.leftdialogueinfo=UIObject.get(self,1)
self.ScrollView=UIScrollViewSlow.get(self,2)
self.nuItem=UIObject.get(self,3)

self.leftDialogue:setButtonClick(function()self:onLeftDialogue()end)



end


function UIShopHuoCangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftDialogue);self.leftDialogue=nil;
_UIObject_release(self.leftdialogueinfo);self.leftdialogueinfo=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.nuItem);self.nuItem=nil;
end



















local _colomn=4
function UIShopHuoCangWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
end


function UIShopHuoCangWin:__delete()
self:unbindComponents()
end




function UIShopHuoCangWin:onShow(argtable,afterOnloaded)
local itemList=bagControl.getBagItemsByFilter(BAG_TYPE.eShopHuoCang,{},true,false)or{}
local showNum=#itemList
if showNum<=0 then
self.nuItem:setActive(true)
else
self.nuItem:setActive(false)
local showRow=math.ceil(showNum/_colomn)
self.ScrollView:freshSlowGrids(showNum,showRow,4)
end
end



function UIShopHuoCangWin:onHide()

end

function UIShopHuoCangWin:bindGrid(index,widget)
local itemList=bagControl.getBagItemsByFilter(BAG_TYPE.eShopHuoCang,{},true,false)or{}
local itemInfo=itemList[index]
local isTemp=itemInfo==nil
if isTemp then
widget:SetSelfActive(false)
else
local itemid=itemInfo.itemid
local num=itemInfo.itemcount
local numStr=num>1 and num or''
widget:SetSelfActive(true)
local conf={
showname=false,
showStageBg=false,
showCountBG=num>1,
itemcount=numStr,
stage="",
}
local item_data={itemid=itemid,itemcount=0}
local prop=itemsComponentHelper.getCommonFillData(item_data,conf)

widget:SetPropData(prop)
end
end





function UIShopHuoCangWin:onLeftDialogue()
self:closeSelf()
end

function UIShopHuoCangWin:onClickGrid(...)
itemsComponentHelper.onItemClick(...)
end

function UIShopHuoCangWin:refresh()
local itemList=bagControl.getBagItemsByFilter(BAG_TYPE.eShopHuoCang,{},true,false)or{}
local showNum=#itemList
if showNum<=0 then
self.nuItem:setActive(true)
self.ScrollView:clearSlowItems()
else
self.nuItem:setActive(false)
local showRow=math.ceil(showNum/_colomn)
self.ScrollView:clearSlowItems()
self.ScrollView:freshSlowGrids(showNum,showRow,_colomn,true)
end

end



