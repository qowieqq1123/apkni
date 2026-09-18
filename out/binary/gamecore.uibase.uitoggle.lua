










local _helper=CS.UIHelper
UIToggle=simple_class()
function UIToggle:__init(group,winLua,index)

self.toggleGroup=group
self.winlua=winLua
self.gameObject=self.winlua.gameObject
self.index=index
self.isOn=false
self.redPointActiveState=false

local text=self.winlua:GetChildText(1)
self.selectText=string.format('<color=#FFFFFF>%s</color>',text)
self.unSelectText=string.format('<color=#918773>%s</color>',text)

self:InitUI()
end

function UIToggle:__delete()
self.toggleGroup=nil
self.winlua=nil
self.gameObject=nil
self.index=nil
self.isOn=nil
self.selectText=nil
self.unSelectText=nil
self.redPointActiveState=nil
end

function UIToggle:Destory()
self:deleteSelf()
end


function UIToggle:IsOn(isOn)
if isOn~=self.isOn then
self.isOn=isOn
if self.isOn then
self:DoSelectAction()
else
self:DoUnSelectAction()
end
end
end

function UIToggle:DoSelectAction()
self.winlua:SetChildActive(0,false)
self.winlua:SetChildText(1,self.selectText)


self.winlua:SetChildActive(2,true)

end

function UIToggle:DoUnSelectAction()
self.winlua:SetChildActive(0,true)
self.winlua:SetChildText(1,self.unSelectText)


self.winlua:SetChildActive(2,false)

end


function UIToggle:SetRedPointActiveState(state)
if self.redPointActiveState~=state then
self.winlua:SetChildActive(3,state)
self.redPointActiveState=state
end
end





function UIToggle:InitUI()
self:InitTouch()
end

function UIToggle:InitTouch()
local touch=ComponentHelper.GetComponent(self.gameObject,CS.TouchEvent)
touch.OnClickListen=objectHelper.packFunc(self,self.OnTouch)
end

function UIToggle:OnTouch()
self.toggleGroup:SelectToggle(self)
end

