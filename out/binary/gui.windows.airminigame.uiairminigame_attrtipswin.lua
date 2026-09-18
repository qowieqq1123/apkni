







def_class("UIAirMiniGame_attrTipsWin",UIWindowBase)









function UIAirMiniGame_attrTipsWin:bindComponents()

self.mask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.attrName=UIText.get(self,2)
self.attrDesc=UIText.get(self,3)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIAirMiniGame_attrTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.attrName);self.attrName=nil;
_UIObject_release(self.attrDesc);self.attrDesc=nil;
end



















function UIAirMiniGame_attrTipsWin:onLoaded(...)
self:bindComponents()
end


function UIAirMiniGame_attrTipsWin:__delete()
self:unbindComponents()
end




function UIAirMiniGame_attrTipsWin:onShow(argtable,afterOnloaded)
local attrId=argtable and argtable.attrId
local pos=argtable and argtable.pos or{0,0}
if pos then
local pos_x=pos[1]or 0
local pos_y=pos[2]or 0
local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local halfItemWidth=334/2
local halfWidth=UnityEngine.Screen.width/scaleFactor.x/2
if pos_x-halfItemWidth<-halfWidth then
pos_x=-halfWidth+halfItemWidth
end
if pos_x+halfItemWidth>halfWidth then
pos_x=halfWidth-halfItemWidth
end

self.root:setChildAnchoredPos(pos_x,pos_y)
end

local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrName=attrCfg.attrname
self.attrName:setText(FMT.fmt("【{0}】",attrName))
local attrDesc=attrCfg.desc
if attrDesc then

if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
attrDesc=string.gsub(attrDesc," ","\194\160")
end
self.attrDesc:setText(attrDesc)
end
end


function UIAirMiniGame_attrTipsWin:onHide()

end





function UIAirMiniGame_attrTipsWin:onMask()
self:closeSelf()
end

