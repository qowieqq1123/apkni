

aiBodyLogicNode=simple_class(baseNode)

function aiBodyLogicNode:broke()
self:endAll()
self.moveState=0
end

function aiBodyLogicNode:endAll()
self:setSharedVar(ai_reset_body_logic,false)
self:endMove(true)
self:endSpeak(true)
self:resetOther()
end

function aiBodyLogicNode:resetOther()
local args=self:getArgs()

_MapManager.SetFadeToColor(args.stId,Color.New(1,1,1,1),0,nil)
end

function aiBodyLogicNode:update(interval)
local isReset=self:getSharedVar(ai_reset_body_logic)
if isReset then
self:endAll()
end
self:updateMove()
self:updateSpeak()

return nodeState.running
end

function aiBodyLogicNode:updateMove()
local stop=self:getSharedVar(ai_stop_move)
if stop then
self:setSharedVar(ai_stop_move,false)
self:endMove(true)
end

local moveArgs=self:getSharedVar(ai_move_cmd)
if moveArgs then
self:setSharedVar(ai_move_cmd,nil)
self.moveArgs=moveArgs

self.isMoving=true
local args=self:getArgs()
_MapManager.RunAnimator(args.stId,self.moveArgs.animId)
self.moveState=isometricMapSystem:moveToPosition(args.dzId,args.stId,self.moveArgs.pos,function(cbType)
self:endMove(false,cbType)
self.moveState=0
end,function(mtype,isEnd)
local check=mtype>1 and not isEnd
self:setSharedVar(ai_special_move,check)
if mtype>1 and isEnd then
local span_move=self:getSharedVar(ai_span_map)
if not span_move then
local waitBorke=self:getSharedVar(ai_wait_broke)
if waitBorke then
self:setSharedVar(ai_wait_broke,false)
_MapManager.StopMove(args.stId,true,true)
end
end
end
end,self.moveArgs.speed,self.moveArgs.cfgId,self.moveState,self.moveArgs.moveType)
end
end

function aiBodyLogicNode:endMove(bBreak,cbType)
if self.isMoving then
local args=self:getArgs()
if bBreak then
_MapManager.StopMove(args.stId,true)
end
_MapManager.RunAnimator(args.stId,eAnimationID.stand)
if self.moveArgs.callback then
self.moveArgs.callback(bBreak,cbType)
end
self.moveArgs=nil
self.isMoving=false
end
end

function aiBodyLogicNode:updateSpeak()
local stop=self:getSharedVar(ai_stop_speak)
if stop then
self:setSharedVar(ai_stop_speak,false)
self:endSpeak(true)
end

local speakArgs=self:getSharedVar(ai_speak_cmd)
if speakArgs then
self:endSpeak(true)

self:setSharedVar(ai_speak_cmd,nil)
self.speakArgs=speakArgs

self.isSpeaking=true
local args=self:getArgs()
local offset=_MapManager.GetObjectHeadOffset(args.stId)
hudControl:setHUDActiveByTarget(args.stId,false)
self.loadId=hudControl:addHUD(INSTANCE_TYPE.eDiscipleSpeak,args.stId,offset,true,true,function(id)
if self.loadId==id then
self.speakHUD=id
local widget=hudControl:getHUDWidget(self.speakHUD)
widget:SetChildText(0,chatEmotHelper.decodeEmot(self.speakArgs.content))
local skin=speakArgs.skin or 1
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(skin)
widget:SetChildCSImageSprite(1,abName,skinName)
if self.speakArgs.container then
hudControl:changeContainer(id,self.speakArgs.container)
end
else
hudControl:removeHUD(id)
end
end)

self.speakWaitingId=behaviorManager:addWaiting(self.speakArgs.duration,function()
self:endSpeak(false)
end,self:isUseUnscaledTime())
end






end

function aiBodyLogicNode:endSpeak(bBreak)
self.loadId=nil
if self.isSpeaking then
if self.speakWaitingId then
behaviorManager:removeWaiting(self.speakWaitingId)
self.speakWaitingId=nil
end
local args=self:getArgs()
if self.speakHUD then
hudControl:removeHUD(self.speakHUD)
hudControl:setHUDActiveByTarget(args.stId,true)
end
self.speakHUD=nil
if self.speakArgs.callback then
self.speakArgs.callback(bBreak)
end
self.speakArgs=nil
self.isSpeaking=false
end
end