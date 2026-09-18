







def_class("UIXianJieLingShouSummonWin",UIWindowBase)









function UIXianJieLingShouSummonWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.Root=UIObject.get(self,2)
self.uiRoot=UIObject.get(self,3)



end


function UIXianJieLingShouSummonWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIXianJieLingShouSummonWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieLingShouSummonWin:__delete()
self:unbindComponents()
end




function UIXianJieLingShouSummonWin:onShow(argtable,afterOnloaded)
if argtable and argtable.isPlay then
self:play(argtable)
end
end


function UIXianJieLingShouSummonWin:onHide()

end

function UIXianJieLingShouSummonWin:play(argtable)
local entityType=argtable.entityType
local infoGuid=argtable.infoGuid

local lsData=xianjieController:getLingShouData(infoGuid)

local cfg=lsData:getCfg()
local effectID=cfgHelper.get(cfg_xianjielingshoubaseconfig_get,1,'summonLingshouShow',entityType,cfg.color)or 10814
self.effect:setChildShowEffect(effectID,true)

self:delayDo(3,function()
local openFunc=function()
lsData:createEntity(true)
self:closeSelf()
end

local sceneIdx=lsData.sceneidx
xianjieController:jumpGrid(sceneIdx,lsData.gridX_c,lsData.gridZ_c,openFunc,true,nil)
end)
end



