







def_class("majiangPoint",UICloneObject)





majiangPoint.abName="ui/windows/fight/majiangpoint.ab"

majiangPoint.assetName="majiangPoint"


function majiangPoint:bindComponents()

self.majiangRoot=UIObject.get(self,0)

end


function majiangPoint:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.majiangRoot);self.majiangRoot=nil;
end









function majiangPoint:onLoaded(...)
self:bindComponents()
end


function majiangPoint:__delete()
self:unbindComponents()
end




function majiangPoint:onShow(argtable,afterOnloaded)
self.parent=argtable.parent
self.ent=self.parent.ent

self.config=cfg_skillhsconfig()

self:refreshHuaSe()
end


function majiangPoint:onHide()

end

function majiangPoint:refreshHuaSe()
if not self.ent then
self.ent=self.parent.ent
end
if self.ent then
local huaseList=self.ent:getHuaSeList()
local num=#huaseList
self.majiangRoot:setChildLayoutGroupCreateItems(num)
local grids=self.majiangRoot:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local huase=huaseList[i]
local config=cfgHelper.get(cfg_skillhsconfig_get,huase)
local icon=fightModel:getHuaSeIcon(config.icon)
grid:SetChildIcon(0,icon,true)
end
end
end


