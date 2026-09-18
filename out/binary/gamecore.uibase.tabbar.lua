









Tabbar=simple_class()
function Tabbar:__init(callFunc,clickMode,doAction)
self.curObj=nil
self.moreClick=clickMode
self.callback=callFunc
self.objData={}
self.doAction=doAction or false
end


function Tabbar:ClickCallBack(obj)
if not self.moreClick and obj==self.curObj then
return
end

if self.callback then
self.callback(obj,self.objData[obj])
end
self.curObj=obj
end


function Tabbar:AddBtn(gameObject,data)
if gameObject then
self.objData[gameObject]=data
local touch=ComponentHelper.AddComponent(gameObject,CS.TouchEvent)
touch.OnClickListen=objectHelper.packFunc(self,self.ClickCallBack)

if self.doAction then
touch.doAction=true
end
end
end


function Tabbar:FocusOn(obj)
self:ClickCallBack(obj)
end
