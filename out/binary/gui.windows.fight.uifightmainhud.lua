







def_class("UIFightMainHUD",UIWindowBase)









function UIFightMainHUD:bindComponents()

self.creator=UIGameobjectClone.new(self,0)
self.hud=UIObject.get(self,1)
self.flow=UIHUDFlow.get(self,2)
self.effectPos=UIObject.get(self,3)


self.sprite_image_zdxietiao_1=0
self.sprite_image_zdxietiao_2=1

end


function UIFightMainHUD:unbindComponents()
local _UIObject_release=UIObject.release
self.creator:deleteSelf();self.creator=nil;
_UIObject_release(self.hud);self.hud=nil;
_UIObject_release(self.flow);self.flow=nil;
_UIObject_release(self.effectPos);self.effectPos=nil;
end



















function UIFightMainHUD:onLoaded(...)
self.pool={}
self:bindComponents()
end


function UIFightMainHUD:__delete()
entityHUDCtr:setMainHUD(nil)
self.creator:recycleAll()
self:unbindComponents()
end




function UIFightMainHUD:onShow(args,afterOnloaded)
entityHUDCtr:setMainHUD(self)
end

function UIFightMainHUD:createHUD(entHUD)
local luaID=self.creator:createObject(entHUD:getHUDName(),self.hud:getID(),0,{entHUD=entHUD,parent=self,show=true})
self.pool[entHUD.id]=luaID
end

function UIFightMainHUD:removeHUD(entHUD)
local restoreID=self.pool[entHUD.id]
if restoreID~=nil then
self.creator:recycleItemById(restoreID)
self.pool[entHUD.id]=nil
end
end

function UIFightMainHUD:getUIPos()
return self.effectPos:getChildPosition()
end



function UIFightMainHUD:onHide()

end


function UIFightMainHUD:closeSubWin(win)
self.creator:recycleItem(win)
end