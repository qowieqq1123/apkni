







def_class("UIFightBossBoxHUD",UIWindowBase)
require("lua.gui.windows.fight.FightBossHUD")
require("lua.gui.windows.fight.FightBossBoxHUD")









function UIFightBossBoxHUD:bindComponents()

self.scrollview=UIScrollView.get(self,0)
self.bar1=UIWindowLua.new(self,1)
self.bar2=UIWindowLua.new(self,2)
self.bar3=UIWindowLua.new(self,3)
self.box=UIObject.get(self,4)
self.UIFightBossBoxHUD=UIWindowLua.new(self,5)


self.sprite_image_zdbossxietiao_1=0
self.sprite_image_zdbossxietiao_2=1
self.sprite_image_zdbossxietiao_3=2
self.sprite_image_zdbossxietiao_0=3
self.sprite_image_zdbossxietiao_4=4

end


function UIFightBossBoxHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
self.bar1:deleteSelf();self.bar1=nil;
self.bar2:deleteSelf();self.bar2=nil;
self.bar3:deleteSelf();self.bar3=nil;
_UIObject_release(self.box);self.box=nil;
self.UIFightBossBoxHUD:deleteSelf();self.UIFightBossBoxHUD=nil;
end


















local bars={1,2,3}

function UIFightBossBoxHUD:onLoaded(...)
self:bindComponents()
self.argsList={}
self.hudList={}
self.bars={
self.bar1,
self.bar2,
self.bar3,
}
end


function UIFightBossBoxHUD:__delete()
self:unbindComponents()
end




function UIFightBossBoxHUD:onShow(argtable,afterOnloaded)
self:freshView()
end


function UIFightBossBoxHUD:onHide()

end


function UIFightBossBoxHUD:freshView()
self.argsList=entityHUDCtr:getBossHudList()

for k,v in pairs(bars)do
local info=self.argsList[v]
if info then
self.winlua:SetChildActive(v,true)
local itemwidget=self.winlua:GetChildWidgetBase(v)

if not self.hudList[info]and itemwidget then
local hud=FightBossBoxHUD(info)
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

function UIFightBossBoxHUD:releaseAllHud()
for info,hud in pairs(self.hudList)do
hud:releaseHud()
end
self.hudList=nil
end

function UIFightBossBoxHUD:hideAllTxPanel()
for k,v in pairs(bars)do
local info=self.argsList[v]
if info then
self.winlua:SetChildActive(v,true)
local itemwidget=self.winlua:GetChildWidgetBase(v)
itemwidget:SetChildActive(20,false)
end
end
end


