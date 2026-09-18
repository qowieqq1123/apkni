













UIRoleSpeakNode=simple_class(baseNode)

function UIRoleSpeakNode:reset()
UIRoleSpeakNode._base.reset(self)
self.isSpeaking=false
end

function UIRoleSpeakNode:broke()
self:removeUI()
end

function UIRoleSpeakNode:removeUI()
if self.loadId then
_InstantiateManager.RemoveInstance(self.loadId)
self.loadId=nil
end
if self.hudId then
_InstantiateManager.RemoveInstance(self.hudId)
self.hudId=nil
end
end

function UIRoleSpeakNode:update(interval)
if self.isSpeaking then
if os.time()>=self.endTime then
self:removeUI()
return nodeState.success
end
return nodeState.running
else
local destoryLast=self:getData('destorylast')
local lastHudId=self:getSharedVar('uiSpeakHudId')
if destoryLast and lastHudId then
self:setSharedVar('uiSpeakHudId',nil)
_InstantiateManager.RemoveInstance(lastHudId)
end
end

local widget=self:getData('widget')
local wIndex=self:getData('target')

local duration=self:getData('duration')or math.random(self:getData('minDuration'),self:getData('maxDuration'))
local content=self:getData('content')
self.endTime=os.time()+duration
self.isSpeaking=true
if not content then
return nodeState.running
end
local skin=self:getData('skin')or 1
local offset=self:getData('offset')or{0,0}

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
else
hudControl:removeHUD(id)
end
end)

return nodeState.running
end

function UIRoleSpeakNode:skip()
self:broke()
return nodeState.success
end