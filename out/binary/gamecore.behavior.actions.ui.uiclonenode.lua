UICloneNode=simple_class(baseNode)

function UICloneNode:reset()
self._base.reset(self)
end

function UICloneNode:update(interval)
local widget=self:getData('widget')
local wIndex=self:getData('target')
local parentIndex=self:getData('parent')
local keeppos=self:getData('keeppos')
local pos=self:getData('pos')
local objKey=self:getData('objTransform')
local replacewidget=self:getData('replacewidget')
local playEffect=self:getData('playEffect')
local clone=widget:CloneChildTransform(wIndex,parentIndex,keeppos,playEffect)
self:setSharedVar(objKey,clone)
if replacewidget then
local _widget=CS.UIHelper.GetCSGUIWidgetBase(clone.gameObject)
self:setSharedVar('widget',_widget)
end
return nodeState.success
end


function UICloneNode:skip()
return self:update()
end