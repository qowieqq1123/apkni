











UIShowSpeakNode=simple_class(baseNode)

function UIShowSpeakNode:reset()
UIShowSpeakNode._base.reset(self)
end

function UIShowSpeakNode:broke()
self:removeUI()
end

function UIShowSpeakNode:removeUI()
if self.loadId then
_InstantiateManager.RemoveInstance(self.loadId)
self.loadId=nil
end
if self.hudId then
_InstantiateManager.RemoveInstance(self.hudId)
self.hudId=nil
end
end

function UIShowSpeakNode:update(interval)

local destoryLast=self:getData('destorylast')
local lastHudId=self:getSharedVar('uiSpeakHudId')
if destoryLast and lastHudId then
self:setSharedVar('uiSpeakHudId',nil)
_InstantiateManager.RemoveInstance(lastHudId)
end
local widget=self:getData('widget')
local wIndex=self:getData('target')
local content=self:getData('content')

if not content then
return nodeState.failure
end

local skin=self:getData('skin')or 1
local offset=self:getData('offset')or{0,0}
local fanzhuan=self:getData('fanzhuan')
local parent=widget:GetCommonComponent(wIndex,'Transform')
self.loadId=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleSpeak,parent,function(id)
if self.loadId==id then
self.loadId=nil
self.hudId=id
self:setSharedVar('uiSpeakHudId',id)
local hudWidget=_InstantiateManager.GetComponent(self.hudId,'CSGUIWidgetBase')
local offsetVal=Vector2.New(offset[1],offset[2])
hudWidget:SetChildAnchoredPosition(2,offsetVal)


local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(skin)
hudWidget:SetChildCSImageSprite(1,abName,skinName)
if fanzhuan then

hudWidget:SetChildScale(1,Vector3(1,1,1))
end
else
hudControl:removeHUD(id)
end
end)

return nodeState.success
end

function UIShowSpeakNode:skip()
self:broke()
return nodeState.success
end