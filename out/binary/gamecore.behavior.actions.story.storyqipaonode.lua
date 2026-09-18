








storyQiPaoNode=simple_class(baseNode)

function storyQiPaoNode:broke()
self.sLoadId=nil
UIManager:closeWindow('UIJuQingDongHuaPassWin2')
end

function storyQiPaoNode:update(interval)
local npcid=self:getData('npcid')
local duration=self:getData('duration')or 0
local isClickSkip=self:getData('isClickSkip')

local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
self:setSpeakContent(guid)
if duration~=0 then
if not self.isSpeaking then
self.isSpeaking=true
self.endSpeakTime=os.time()+duration
end

if self.isSpeaking then
if os.time()>=self.endSpeakTime then
self.isSpeaking=false
self:shutUp(guid)
return nodeState.success
else
return nodeState.running
end
end
else
if isClickSkip==1 and not self.isClick then
return nodeState.running
else
return nodeState.success
end
end
end
return nodeState.failure
end

function storyQiPaoNode:reset()
storyQiPaoNode._base.reset(self)
local npcid=self:getData('npcid')
if npcid then
local guid=storyAIManager:getStoryBTBlackBoard(npcid)
self:shutUp(guid)
self.isSpeaking=false
end
end

function storyQiPaoNode:setSpeakContent(guid)
local icon=self:getData('icon')
local cusOffset=self:getData('offset')
local scale=self:getData('scale')
local duration=self:getData('duration')or 0
local isClickSkip=self:getData('isClickSkip')
local hudId=self:getSharedVar(FMT.fmt('hudIdQiPao_{0}',guid))
if guid and hudId==nil and not self.isClick then
local offset=_MapManager.GetObjectHeadOffset(guid)
if cusOffset then
offset.x=offset.x+cusOffset[1]or 0
offset.y=offset.y+cusOffset[2]or 0
end
self.sLoadId=hudControl:addHUD(INSTANCE_TYPE.eDiscipleQiPao,guid,offset,true,true,function(id)
if self.sLoadId==id then
hudId=id
local widget=hudControl:getHUDWidget(hudId)
local abName,skinName=discipleStateManager:getQiPaoSkinInfoById()
widget:SetChildCSImageSprite(0,abName,"image_qipaokuang_2")
widget:SetChildCSImageSprite(1,abName,skinName)

self:setSharedVar(FMT.fmt('hudIdQiPao_{0}',guid),hudId)
hudControl:changeContainer(hudId,1)
if scale then
widget:SetChildScale(-1,Vector3.one*scale)
end
if duration==0 and isClickSkip==1 then
if self.tweener==nil then
widget:SetChildRotation(1,0,0,0)
self.tweener=widget:SetChildDOPunchRotation(1,Vector3(0,0,5),2,2,1)
self.tweener:SetEase(_Ease.Linear)
self.tweener:SetLoops(-1,_LoopType.Restart)
end
timeEventController.delayDo(1,function()

local uiScreenPos=widget:GetChildUIScreenPos(0,true)
local w=widget:GetChildSizeDeltaX(0)
local h=widget:GetChildSizeDeltaY(0)
local args={
pos=uiScreenPos,
w=w,
h=h,
clickFunc=function()
self:shutUp(guid)
self.isClick=true
end
}
UIManager:showWindow('UIJuQingDongHuaPassWin2',args)
end)
end
else
hudControl:removeHUD(id)
end
end)
end
end

function storyQiPaoNode:shutUp(guid)
self.sLoadId=nil
if guid then
local hudId=self:getSharedVar(FMT.fmt('hudIdQiPao_{0}',guid))
if hudId then
hudControl:removeHUD(hudId)
self:setSharedVar(FMT.fmt('hudIdQiPao_{0}',guid))
end
end
end

function storyQiPaoNode:skip()
local npcid=self:getData('npcid')
local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
self:shutUp(guid)
end
return nodeState.success
end