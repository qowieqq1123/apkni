







def_class("UISpecialityTwoWin",UIWindowBase)









function UISpecialityTwoWin:bindComponents()

self.root=UIObject.get(self,0)
self.specialityIcon=UIImage.get(self,1)
self.specialityTypeTxt=UIText.get(self,2)
self.specialityInfo=UIText.get(self,3)
self.specialityDesc=UIText.get(self,4)
self.specialityName=UIText.get(self,5)
self.specialityNameEx=UIText.get(self,6)



end


function UISpecialityTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.specialityIcon);self.specialityIcon=nil;
_UIObject_release(self.specialityTypeTxt);self.specialityTypeTxt=nil;
_UIObject_release(self.specialityInfo);self.specialityInfo=nil;
_UIObject_release(self.specialityDesc);self.specialityDesc=nil;
_UIObject_release(self.specialityName);self.specialityName=nil;
_UIObject_release(self.specialityNameEx);self.specialityNameEx=nil;
end

















function UISpecialityTwoWin:onLoaded(...)
self:bindComponents()
end


function UISpecialityTwoWin:__delete()
self:unbindComponents()
end


function UISpecialityTwoWin:onHide()

end




function UISpecialityTwoWin:onShow(argtable,afterOnloaded)

local pos=argtable.pos
local config=argtable.config


local p
if pos==-1 then
self.root:setAnchors(0,1,0,1)
p={200,-259}
elseif pos==1 then
self.root:setAnchors(1,1,1,1)
p={-200,-259}
else
self.root:setAnchors(0.5,1,0.5,1)
p={0,-259}
end
self.root:setChildAnchoredPos(p[1],p[2])


if config then
local specialitytype=config.specialitytype or config.typo
self.specialityNameEx:setText(config.name)
self.specialityName:setText(config.name)
self.specialityDesc:setText(config.effects_desc or'')
self.specialityTypeTxt:setText(UIDiscipleModel.getSpecialtyTypeName(specialitytype,nil,true))

local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(config.framecolor)
self.specialityIcon:setSprite(abName,frameIcon)

local infoStr=zongmenControl:getSpecialityAddDesc(nil,config)
self.specialityInfo:setText(infoStr)
end
end
