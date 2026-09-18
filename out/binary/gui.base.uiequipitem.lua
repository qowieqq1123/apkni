UIEquip=simple_class()

local _prefabName='UIBaseEquipItem'

function UIEquip:__init(creater)

end
function UIEquip:setIcon(args)
args=args or{}
args.iconInfo=args.iconInfo or playerModel:getActorIconInfo()
args.scale=args.scale or 1
self:freshInfo(args)
end

function UIEquip:freshInfo(args)
if self.luaid then
local widget=self:getLuaObject(self.luaid)
widget:onShow(args)
else
self.luaid=self:createObject(_prefabName,self.__id,0,args)
end
end

function UIEquip:__delete()
if self.luaid then
self:recycleItemById(self.luaid)
end
self.luaid=nil
end