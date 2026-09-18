UIHead=simple_class(UIGameobjectClone)

local _prefabName='UIBaseHeadItem'


function UIHead:setIcon(args)
args=args or{}
args.iconInfo=args.iconInfo or playerModel:getActorIconInfo()
args.scale=args.scale or 1
self:freshInfo(args)
end

function UIHead:freshInfo(args)
if self.luaid then
local widget=self:getLuaObject(self.luaid)
widget:onShow(args)
else
self.luaid=self:createObject(_prefabName,self.__id,0,args)
end
end

function UIHead:__delete()
if self.luaid then
self:recycleItemById(self.luaid)
end
self.luaid=nil
end