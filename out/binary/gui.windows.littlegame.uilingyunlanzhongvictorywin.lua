







def_class("UILingYunLanZhongVictoryWin",UIWindowBase)









function UILingYunLanZhongVictoryWin:bindComponents()

self.Middle=UIObject.get(self,0)
self.TitleTx=UIText.get(self,1)
self.gradeInfo=UIObject.get(self,2)
self.ScrollView=UIScrollView.get(self,3)
self.Content=UIObject.get(self,4)
self.TipsTx=UIText.get(self,5)
self.centerTipsTx=UIText.get(self,6)
self.curlayer=UIText.get(self,7)
self.todaymaxlayer=UIText.get(self,8)
self.curupimg=UIObject.get(self,9)
self.Pool=UIGameobjectClone.new(self,10)



end


function UILingYunLanZhongVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Middle);self.Middle=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.gradeInfo);self.gradeInfo=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.TipsTx);self.TipsTx=nil;
_UIObject_release(self.centerTipsTx);self.centerTipsTx=nil;
_UIObject_release(self.curlayer);self.curlayer=nil;
_UIObject_release(self.todaymaxlayer);self.todaymaxlayer=nil;
_UIObject_release(self.curupimg);self.curupimg=nil;
self.Pool:deleteSelf();self.Pool=nil;
end
















local _divTime=0.15
local this




function UILingYunLanZhongVictoryWin:onLoaded(...)
self:bindComponents()
this=self
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
end


function UILingYunLanZhongVictoryWin:__delete()
self:unbindComponents()
end




function UILingYunLanZhongVictoryWin:onShow(argtable,afterOnloaded)
self.argtable=argtable or{}


local title=self.argtable.title
if title then
self.TitleTx:setActive(title.text~=nil)
if title.text then self.TitleTx:setText(title.text)end
else
self.TitleTx:setActive(true)
self.TitleTx:setText("<color=#7D3B17>获得物品</color>")
end

local tips=self.argtable.tips
self.TipsTx:setText(tips or"")


if self.argtable.effectData then
local curLayerNum=self.argtable.effectData.floor
local todayMaxLayerNum=self.argtable.effectData.todayfloor
self.curlayer:setText(FMT.fmt("层数：{0}",curLayerNum))
self.todaymaxlayer:setText(FMT.fmt("本日最高层数：{0}",todayMaxLayerNum))
end


local items=self.argtable.items
if items then
table.sort(items,function(a,b)
return a.sortWeight>b.sortWeight
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
singleInfo.delay=1+_divTime*(i-1)
singleInfo.args=v
config[#config+1]=singleInfo

end
self.Pool:createObjectList(config)
end

end


function UILingYunLanZhongVictoryWin:onHide()

end





function UILingYunLanZhongVictoryWin:onHeadIcon()
end



function UILingYunLanZhongVictoryWin:onHeadIcontwo()
end



function UILingYunLanZhongVictoryWin:onShareBtn()
end

