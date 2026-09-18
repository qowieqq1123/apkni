







def_class("UIXBTipsWin",UIWindowBase)









function UIXBTipsWin:bindComponents()

self.blackImg=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.title1=UIObject.get(self,2)
self.title2=UIObject.get(self,3)
self.title3=UIObject.get(self,4)
self.lvl=UIText.get(self,5)
self.itemlist=UIObject.get(self,6)
self.tiptxt=UIText.get(self,7)
self.nextlvl=UIText.get(self,8)
self.desc1=UIText.get(self,9)
self.desc2=UIText.get(self,10)
self.sjimg=UIObject.get(self,11)
self.nextnum=UIText.get(self,12)
self.sjtxt=UIText.get(self,13)
self.title4=UIObject.get(self,14)

self.blackImg:setButtonClick(function()self:onBlackImg()end)



end


function UIXBTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.lvl);self.lvl=nil;
_UIObject_release(self.itemlist);self.itemlist=nil;
_UIObject_release(self.tiptxt);self.tiptxt=nil;
_UIObject_release(self.nextlvl);self.nextlvl=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.sjimg);self.sjimg=nil;
_UIObject_release(self.nextnum);self.nextnum=nil;
_UIObject_release(self.sjtxt);self.sjtxt=nil;
_UIObject_release(self.title4);self.title4=nil;
end



















function UIXBTipsWin:onLoaded(...)
self:bindComponents()
end


function UIXBTipsWin:__delete()
self:unbindComponents()
end




function UIXBTipsWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)

local XBLevel=xianjiexianbangModel:getXBLevel()
self.lvl:setText(FMT.fmt("当前等级{0}级",XBLevel))
local nextlvl=XBLevel+1
local nextcfglvl=cfg_xianbanglevelconfig_get(nextlvl)
if nextcfglvl then
self.title2:setActive(true)
self.title3:setActive(true)
self.title4:setActive(false)
else
self.title2:setActive(false)
self.title3:setActive(false)
self.title4:setActive(true)
end


local cfglvl=cfg_xianbanglevelconfig_get(XBLevel)
if cfglvl.odds then
local widget=self.itemlist:getChildWidgetBase()
for i=1,5 do
local value=cfglvl.odds[i]
if value then
widget:SetChildText(i-1,FMT.fmt("{0}%",math.floor(value/100)))
end
end
end


local taskMax=cfglvl.taskMax
self.tiptxt:setText(FMT.fmt("最大任务存在数量: {0}",taskMax))


self.desc1:setText("")

if cfglvl.updesc then
self.desc1:setText(cfglvl.updesc)
end
if nextcfglvl then


self.nextlvl:setText(FMT.fmt("下一等级:  {0}",nextlvl))


else

self.nextlvl:setText("已满级")

end


local upLevel=cfglvl.upLevel
local nownumn=xianjiexianbangModel:getXBfinishNum()
local str=FMT.fmt("完成{0}个仙榜任务({1}/{2})",upLevel,nownumn,upLevel)
self.sjtxt:setText(str)
end


function UIXBTipsWin:onHide()

end

function UIXBTipsWin:onBlackImg()
self:closeSelf()
end

