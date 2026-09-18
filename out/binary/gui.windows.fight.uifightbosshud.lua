







def_class("UIFightBossHUD",UIWindowBase)
require("lua.gui.windows.fight.FightBossHUD")









function UIFightBossHUD:bindComponents()

self.scrollview=UIScrollView.get(self,0)
self.bar1=UIWindowLua.new(self,1)
self.bar2=UIWindowLua.new(self,2)
self.bar3=UIWindowLua.new(self,3)
self.leftscrollview=UIScrollView.get(self,4)
self.leftbar1=UIWindowLua.new(self,5)
self.leftbar2=UIWindowLua.new(self,6)
self.leftbar3=UIWindowLua.new(self,7)


self.sprite_image_zdbossxietiao_1=0
self.sprite_image_zdbossxietiao_2=1
self.sprite_image_zdbossxietiao_3=2
self.sprite_image_zdbossxietiao_0=3
self.sprite_image_zdbossxietiao_4=4

end


function UIFightBossHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
self.bar1:deleteSelf();self.bar1=nil;
self.bar2:deleteSelf();self.bar2=nil;
self.bar3:deleteSelf();self.bar3=nil;
_UIObject_release(self.leftscrollview);self.leftscrollview=nil;
self.leftbar1:deleteSelf();self.leftbar1=nil;
self.leftbar2:deleteSelf();self.leftbar2=nil;
self.leftbar3:deleteSelf();self.leftbar3=nil;
end
















local bars={1,2,3}



function UIFightBossHUD:onLoaded(...)
self:bindComponents()

self.argsList={}
self.hudList={}
self.bars={
self.bar1,
self.bar2,
self.bar3,
}
self.leftbars={
self.leftbar1,
self.leftbar2,
self.leftbar3,
}
end


function UIFightBossHUD:__delete()
self:unbindComponents()

self.argsList=nil
self.hudList=nil
end




function UIFightBossHUD:onShow(args)
local entityHud=args
if entityHud and entityHud.entity.isLeft and entityHud.entity:isLeft()then
for i,v in ipairs(self.bars)do
v:setActive(false)
end
bars={5,6,7}
else
for i,v in ipairs(self.leftbars)do
v:setActive(false)
end
bars={1,2,3}
end
self:freshView()
end


function UIFightBossHUD:onHide()

end





function UIFightBossHUD:freshView()
self.argsList=entityHUDCtr:getBossHudList()


















for i,v in ipairs(bars)do
local info=self.argsList[i]
if info then
self.winlua:SetChildActive(v,true)
local itemwidget=self.winlua:GetChildWidgetBase(v)

if not self.hudList[info]and itemwidget then
local hud=FightBossHUD(info)
self.hudList[info]=hud

hud:setItem(itemwidget)
hud:bindComponents()
hud:initHud()
end
else
self.winlua:SetChildActive(v,false)
end

end
end

function UIFightBossHUD:releaseAllHud()
for info,hud in pairs(self.hudList)do
hud:releaseHud()
end
self.hudList=nil
end

function UIFightBossHUD:hideAllTxPanel()
for i,v in ipairs(bars)do
local info=self.argsList[i]
if info then
self.winlua:SetChildActive(v,true)
local itemwidget=self.winlua:GetChildWidgetBase(v)
itemwidget:SetChildActive(20,false)
end
end
end