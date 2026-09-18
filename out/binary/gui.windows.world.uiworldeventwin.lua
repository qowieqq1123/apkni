







def_class("UIWorldEventWin",UIWindowBase)







local imageAB=""

local itemKid={
nameTx=0,
iconImg=1,
bgBtn=2,
contentTx=3,
}

local _this=nil

function UIWorldEventWin:bindComponents()

self.TextTitlle=UIText.get(self,0)
self.TextContent=UIText.get(self,1)
self.ImagePicture=UIImage.get(self,2)
self.ItemList=UIScrollView.get(self,3)
self.TextTips=UIText.get(self,4)



end


function UIWorldEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.TextTitlle);self.TextTitlle=nil;
_UIObject_release(self.TextContent);self.TextContent=nil;
_UIObject_release(self.ImagePicture);self.ImagePicture=nil;
_UIObject_release(self.ItemList);self.ItemList=nil;
_UIObject_release(self.TextTips);self.TextTips=nil;
end



















function UIWorldEventWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIWorldEventWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWorldEventWin:onShow(argtable,afterOnloaded)
if not argtable then return end
self.name=argtable.name
self.content=argtable.content
self.items=argtable.items
self.tips=argtable.tips
self.closeFunc=argtable.close
self.selectFunc=argtable.choose
self.recordFunc=argtable.record

self.TextTitlle:setText(self.name)
self.TextContent:setText(self.content)
self.TextTips:setText(self.tips or"")
local itemCnt=#self.items
local showCnt=itemCnt+1
self.ItemList:freshGridsNum(showCnt,showCnt,1,false)
for i=1,itemCnt do
local itemData=self.items[i]
local item=self.ItemList:getGridObjectByindex(i-1)
local haveIcon=itemData.icon~=nil
item:SetChildActive(itemKid.nameTx,haveIcon)
item:SetChildActive(itemKid.iconImg,haveIcon)
item:SetChildActive(itemKid.contentTx,not haveIcon)
if itemData.icon then
item:SetChildText(itemKid.nameTx,itemData.name)
item:SetChildIcon(itemKid.iconImg,itemData.icon,false)
else
item:SetChildText(itemKid.contentTx,itemData.name)
end




item:SetChildButtonClickWithID(itemKid.bgBtn,function(idx)self:onClickItem(idx)end,i)
end

local item=self.ItemList:getGridObjectByindex(showCnt-1)
item:SetChildActive(itemKid.contentTx,true)
item:SetChildText(itemKid.contentTx,"离开")
item:SetChildButtonClick(itemKid.bgBtn,function()self:onClickClose()end)

if self.recordFunc and self.recordFunc()then
self.ItemList:setActive(false)
end
end


function UIWorldEventWin:onHide()

end



function UIWorldEventWin:onClickClose()
if self.closeFunc then self.closeFunc()end
self:closeSelf()
end

function UIWorldEventWin:onClickItem(i)
if self.selectFunc then
self.ItemList:setActive(false)
self.selectFunc(i)
end
end