







def_class("UIGuildOrderAcitveWin",UIWindowBase)









function UIGuildOrderAcitveWin:bindComponents()

self.orderIcon=UIImage.get(self,0)
self.orderName=UIText.get(self,1)
self.descTxt=UIText.get(self,2)
self.backEffect=UIObject.get(self,3)



end


function UIGuildOrderAcitveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.orderIcon);self.orderIcon=nil;
_UIObject_release(self.orderName);self.orderName=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.backEffect);self.backEffect=nil;
end
















local _this=nil


function UIGuildOrderAcitveWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIGuildOrderAcitveWin:__delete()
_this=nil
self.backEffect:setChildShowEffect(0,false)
self:unbindComponents()


end


function UIGuildOrderAcitveWin:onHide()

end




function UIGuildOrderAcitveWin:onShow(argtable,afterOnloaded)
self.backEffect:setChildShowEffect(10014,true)

AudioManager.playAudio(639)

self.orderID=argtable.orderID
self:refreshView()

self:showAnim()
end

function UIGuildOrderAcitveWin:refreshView()
local orderID=self.orderID
local ordercfg=cfgHelper.get1(cfg_guildorderconfig_get,orderID)

self.orderName:setText(ordercfg.name)

local iconname=guildOrderModel.getIconName(ordercfg.icon)
self.orderIcon:setSprite(globalABLookup.systemicons,iconname)

local isActive=guildOrderModel:checkOrderActive(orderID)
local desc_str=guildOrderModel:getOrderDesc(orderID,isActive,true)
self.descTxt:setText(desc_str)
end

function UIGuildOrderAcitveWin:showAnim()

local delay=0
local sub=0.3
self.orderIcon:setRotation(0,90,0)
self.orderName:setActive(false)
local func=function()
if _this==nil then return end
_this.orderName:setActive(true)
end
self.orderIcon:setChildDORotation(Vector3.zero,sub,DG.Tweening.RotateMode.Fast,func)
delay=delay+sub

local pos1=self.descTxt:getChildLocalPosition()
self.descTxt:setLocalPosY(-200)
self.descTxt:setActive(false)
sub=0.2
local func1=function()
self.descTxt:setActive(true)
self.descTxt:setChildDOLocalMoveY(pos1.y,sub,nil)
end
self:delayDo(delay,func1)
delay=delay+sub
end