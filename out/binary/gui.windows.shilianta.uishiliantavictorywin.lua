







def_class("UIShiLianTaVictoryWin",UIWindowBase)









function UIShiLianTaVictoryWin:bindComponents()

self.BottomTxt=UIText.get(self,0)
self.buttonBg=UIObject.get(self,1)
self.Content=UIObject.get(self,2)
self.empty=UIText.get(self,3)
self.MiddleTxt=UIText.get(self,4)
self.Pool=UIGameobjectClone.new(self,5)
self.ResIcon=UIImage.get(self,6)
self.ResRoot=UIObject.get(self,7)
self.ResTx=UIText.get(self,8)
self.ScrollView=UIScrollView.get(self,9)
self.TextNum=UIText.get(self,10)
self.TitleIcon=UIObject.get(self,11)
self.TitleTx=UIText.get(self,12)



end


function UIShiLianTaVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.BottomTxt);self.BottomTxt=nil;
_UIObject_release(self.buttonBg);self.buttonBg=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.MiddleTxt);self.MiddleTxt=nil;
self.Pool:deleteSelf();self.Pool=nil;
_UIObject_release(self.ResIcon);self.ResIcon=nil;
_UIObject_release(self.ResRoot);self.ResRoot=nil;
_UIObject_release(self.ResTx);self.ResTx=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.TextNum);self.TextNum=nil;
_UIObject_release(self.TitleIcon);self.TitleIcon=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
end
















local _divTime=0.1



function UIShiLianTaVictoryWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
end


function UIShiLianTaVictoryWin:__delete()
self:unbindComponents()
end



































function UIShiLianTaVictoryWin:onShow(argtable,afterOnloaded)
self.argtable=argtable or{}

local title=self.argtable.title
if title then
self.TitleTx:setActive(title.text~=nil)
if title.text then self.TitleTx:setText(title.text)end
self.TitleIcon:setActive(title.icon~=nil)
if title.icon then self.TitleIcon:setSprite(title.icon.abName,title.icon.assetName)end
self.TextNum:setActive(title.num~=nil)
if title.num then self.TextNum:setText(title.num)end
else
self.TitleTx:setActive(true)
self.TitleTx:setText("<color=#7D3B17>获得物品</color>")
end


local middle=self.argtable.middle
if middle then
self.MiddleTxt:setActive(middle.text~=nil)
if middle.text then self.MiddleTxt:setText(middle.text)end
end


local bottom=self.argtable.bottom
if bottom then
self.buttonBg:setActive(bottom.text~=nil)
self.BottomTxt:setActive(bottom.text~=nil)
if bottom.text then self.BottomTxt:setText(bottom.text)end
end


local money=self.argtable.money
self.ResRoot:setActive(money~=nil)
if money then
self.ResIcon:setActive(money.icon~=nil)
if money.icon then self.ResIcon:setSprite(money.icon.abName,money.icon.assetName)end
self.ResTx:setActive(money.text~=nil)
if money.text then self.ResTx:setText(money.text)end
end

local items=self.argtable.items
if items and next(items)then

table.sort(items,function(a,b)
local aW=a.sortWeight or 0
local bW=b.sortWeight or 0
return aW>bW
end)

local cnt=#items
self.winlua:SetChildSizeDelta(self.Content:getID(),cnt*90+8,100)
if cnt<=7 then
self.Content:setAnchors(0.5,1,0.5,1)
end
local config={}

for i,v in ipairs(items)do
v.conf={showname=false}
local singleInfo={}
singleInfo.name='UIShowPrizeChildItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=i
singleInfo.delay=0.8+_divTime*(i-1)
singleInfo.args=v
config[#config+1]=singleInfo
end
self.Pool:createObjectList(config)
self.empty:setActive(false)
else
self.empty:setActive(true)
end
end


function UIShiLianTaVictoryWin:onHide()

end



