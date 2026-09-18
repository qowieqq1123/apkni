







def_class("UIShanMenDaZhen_buffTipsWin",UIWindowBase)









function UIShanMenDaZhen_buffTipsWin:bindComponents()

self.root=UIObject.get(self,0)
self.buffName=UIText.get(self,1)
self.buffDesc=UIText.get(self,2)
self.clickMask=UIButton.get(self,3)

self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UIShanMenDaZhen_buffTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.buffName);self.buffName=nil;
_UIObject_release(self.buffDesc);self.buffDesc=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
end



















function UIShanMenDaZhen_buffTipsWin:onLoaded(...)
self:bindComponents()
end


function UIShanMenDaZhen_buffTipsWin:__delete()
self:unbindComponents()
end




function UIShanMenDaZhen_buffTipsWin:onShow(argtable,afterOnloaded)
self.id=argtable.id
self.level=argtable.level
local pos=argtable and argtable.pos or{0,0}
if pos then
local pos_x=pos[1]or 0
local pos_y=pos[2]or 0
local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local halfItemWidth=400/2
local halfWidth=UnityEngine.Screen.width/scaleFactor.x/2
if pos_x-halfItemWidth<-halfWidth then
pos_x=-halfWidth+halfItemWidth
end
if pos_x+halfItemWidth>halfWidth then
pos_x=halfWidth-halfItemWidth
end

self.root:setChildAnchoredPos(pos_x,pos_y)
end


local cfg=cfgHelper.get1(cfg_guildstateconfig_get,self.id)
local skillName=cfg.name
local txt=''
local effects=cfg.effects
for i,v in ipairs(effects)do
local effectid=effects[i]
local desc=homeBuffModel:getBuffDesc(effectid)
desc=string.replaceSpace(desc)
txt=txt~=''and FMT.fmt('{0}\n{1}',txt,desc)or desc
end
local skillDescStr=txt
local skillLevelStr=FMT.fmt("{0}级",self.level)
self.buffName:setText(FMT.fmt("{0} [{1}]",skillName,skillLevelStr))
self.buffDesc:setText(skillDescStr)
end


function UIShanMenDaZhen_buffTipsWin:onHide()

end



function UIShanMenDaZhen_buffTipsWin:onClickMask()
self:closeSelf()
end