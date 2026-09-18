







def_class("UIXJCaravanEscort_victoryWin",UIWindowBase)









function UIXJCaravanEscort_victoryWin:bindComponents()

self.Pool=UIGameobjectClone.new(self,0)
self.ResIcon=UIImage.get(self,1)
self.ResTx=UIText.get(self,2)
self.ResRoot=UIObject.get(self,3)
self.ScrollView=UIScrollView.get(self,4)
self.Middle=UIObject.get(self,5)
self.centerTipsTx=UIText.get(self,6)
self.TipsTx=UIText.get(self,7)
self.progressBar=UIProgress.get(self,8)
self.TextNum=UIText.get(self,9)
self.TitleIcon=UIImage.get(self,10)
self.TitleTx=UIText.get(self,11)
self.Content=UIObject.get(self,12)



end


function UIXJCaravanEscort_victoryWin:unbindComponents()
local _UIObject_release=UIObject.release
self.Pool:deleteSelf();self.Pool=nil;
_UIObject_release(self.ResIcon);self.ResIcon=nil;
_UIObject_release(self.ResTx);self.ResTx=nil;
_UIObject_release(self.ResRoot);self.ResRoot=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Middle);self.Middle=nil;
_UIObject_release(self.centerTipsTx);self.centerTipsTx=nil;
_UIObject_release(self.TipsTx);self.TipsTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.TextNum);self.TextNum=nil;
_UIObject_release(self.TitleIcon);self.TitleIcon=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.Content);self.Content=nil;
end
















local _divTime=0.1
local this



function UIXJCaravanEscort_victoryWin:onLoaded(...)
this=self
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
end


function UIXJCaravanEscort_victoryWin:__delete()
self:unbindComponents()
end




function UIXJCaravanEscort_victoryWin:onShow(argtable,afterOnloaded)

self.argtable=argtable or{}
self.battleId=self.argtable.battleId

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
if self.argtable and self.argtable.tgsldata then
self.TitleTx:setText("")
end

local tips=self.argtable.tips
self.TipsTx:setText(tips or"")

local center_tips=self.argtable.center_tips
self.centerTipsTx:setText(center_tips or"")
if center_tips then
self.Middle:setChildAnchoredPos(0,-63)
end
local progressData=self.argtable.progress
self.progressBar:setActive(progressData~=nil)
if progressData then
self.progressBar:setProgressValue(math.floor(progressData[1]/progressData[2]*10000),10000)
if progressData[3]then
self:delayDo(2,function()
self.progressBar:setProgress(math.floor(progressData[3]/progressData[2]*10000),10000)
end)
end
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
if items and#items>0 then











if items[1].sortWeight then
table.sort(items,function(a,b)
return a.sortWeight>b.sortWeight
end)
else
local list=table.deepCopy(items)
for i,v in pairs(list)do
local itemid=v.itemid
if not itemid then
itemid=v.param_1
v.itemid=v.param_1
v.num=v.param_2
end

local itemguid=v.itemguid
if itemid==nil and itemguid then
itemid=itemsModel.getItem(itemguid).itemid
v.itemid=itemid
end
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local rareLv=itemsConfig.getRareLv(itemid)
local sortWeight=rareLv*10000
sortWeight=sortWeight+color*1000
if itemsConfig.isEquip(itemid)then
sortWeight=sortWeight+100
end
v.sortWeight=sortWeight
end

table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)
items=list
end

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
end
end


function UIXJCaravanEscort_victoryWin:onHide()

end



