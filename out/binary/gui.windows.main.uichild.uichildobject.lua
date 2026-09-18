





UIChildObject=simple_class()


function UIChildObject:onClose()

end

function UIChildObject:onEnable()

end

function UIChildObject:onHide()

end

function UIChildObject:onLoaded()

end

function UIChildObject:__init(widget,idx,config)
self:init(widget,idx,config)
end

function UIChildObject:init(widget,idx,config)
self.__widget=widget
self.widget=widget
self.__idx=idx
self.__config=config
end

function UIChildObject:getIndex()

return self.__idx
end

function UIChildObject:onRelease()
self.__widget=nil
self.__idx=nil
self:setActive(false)
if self.release then
self:release()
end
end

function UIChildObject:getChildTransform(index)
return self.__widget:GetChildGameObject(index).transform
end

function UIChildObject:getChildGameObject(index)
return self.__widget:GetChildGameObject(index)
end

function UIChildObject:setChildIcon(index,iconname,native)
self.__widget:SetChildIcon(index,iconname,native)
end

function UIChildObject:setText(index,txt)
self.__widget:SetChildText(index,txt)
end


function UIChildObject:setActive(active)
if self.__active~=active then
self.__active=active
self.__widget:SetSelfActive(active)
end
end

function UIChildObject:setChildSizeDelta(index,x,y)
self.__widget:SetChildSizeDelta(index,x,y)
end

function UIChildObject:getWidgetBase()
return self.__widget:GetChildSelfWidgetBase()
end

function UIChildObject:setChildCSImageSprite(index,abname,iconnname)
self.__widget:SetChildCSImageSprite(index,abname,iconnname)
end

function UIChildObject:setChildButtonClick(index,abname,iconnname)
self.__widget:SetChildButtonClick(index,abname,iconnname)
end

function UIChildObject:setChildActive(index,active)
self.__widget:SetChildActive(index,active)
end

function UIChildObject:setNewBieComponentId(index,name)
self.__widget:SetChildNewBieComponentId(index,name)
end

function UIChildObject:setChildWeakGuideComponentId(index,name)
self.__widget:SetChildWeakGuideComponentId(index,name)
end

function UIChildObject:setChildRotation(index,x,y,z)
self.__widget:SetChildRotation(index,x,y,z)
end

function UIChildObject:setChildDOPunchRotation(index,punch,duration,vibrato,elasticity,onComplete)
return self.__widget:SetChildDOPunchRotation(index,punch,duration,vibrato,elasticity,onComplete)
end

function UIChildObject:setChildDOPunchRotation(index,punch,duration,vibrato,elasticity,onComplete)
return self.__widget:SetChildDOPunchRotation(index,punch,duration,vibrato,elasticity,onComplete)
end

function UIChildObject:getSelfChildPosition()
return self.__widget:GetChildPosition(-1)
end

function UIChildObject:setChildCanvasGroupAlpha(index,alpha)
return self.__widget:SetChildCanvasGroupAlpha(index,alpha)
end


local UIObjectPool={}
local UIObjectPoolMaxCount=256
local table_remove=table.remove
local UIObject_new=UIChildObject.new
local UIObject_init=UIChildObject.__init
local UIObject_lookup={}


function UIChildObject.creat(widget,idx)

local top=table_remove(UIObjectPool)
if top then
UIObject_init(top,widget,idx)
UIObject_lookup[idx]=top
return top
end
top=UIObject_new(widget,idx)
UIObject_lookup[idx]=top
return top
end


function UIChildObject.release(o)
if o==nil then return end
local idx=o:getIndex()
UIObject_lookup[idx]=nil
o:onRelease()
if#UIObjectPool>UIObjectPoolMaxCount then
return
end
UIObjectPool[#UIObjectPool+1]=o
end


function UIChildObject.get(idx)

return UIObject_lookup[idx]
end

