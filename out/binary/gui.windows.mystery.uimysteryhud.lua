







def_class("UIMysteryHUD",UICloneObject)





UIMysteryHUD.abName="ui/windows/mystery/uimysteryhud.ab"

UIMysteryHUD.assetName="UIMysteryHUD"


function UIMysteryHUD:bindComponents()

self.image=UIImage.get(self,0)
self.image2=UIImage.get(self,1)
self.CountRoot=UIObject.get(self,2)
self.Root=UIObject.get(self,3)
self.TopRoot=UIObject.get(self,4)
self.motionRoot=UIObject.get(self,5)
self.arrow=UIObject.get(self,6)
self.EntityCount=UIText.get(self,7)
self.qipao=UIObject.get(self,8)
self.topEffect=UIObject.get(self,9)

end


function UIMysteryHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.image);self.image=nil;
_UIObject_release(self.image2);self.image2=nil;
_UIObject_release(self.CountRoot);self.CountRoot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.TopRoot);self.TopRoot=nil;
_UIObject_release(self.motionRoot);self.motionRoot=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.EntityCount);self.EntityCount=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.topEffect);self.topEffect=nil;
end









local imageName=
{
appear={'ui/windows/mystery/sharedtextures/inmysterysprite.ab','icon_gwgantanhao'},
playerNotFound={'ui/windows/mystery/sharedtextures/inmysterysprite.ab','icon_gwwenhao'},
}


function UIMysteryHUD:onLoaded(...)

self:bindComponents()
self.removeCB=function(guid,roomId,pos,eType,id,isDestory)
if self.guid==guid then
if isDestory then
self:recycleSelf()
else
self:hide()
end
end
end
self.createEntityCB=function(guid,pos,entityType,entityId)
if self.guid==guid then
self:createEntity()
end
end
notifySystem:listenNotify(notifyConfig.on_mystery_remove_entity,self.removeCB)
notifySystem:listenNotify(notifyConfig.on_mystery_create_entity,self.createEntityCB)
end


function UIMysteryHUD:__delete()
notifySystem:removelistener(notifyConfig.on_mystery_remove_entity,self.removeCB)
notifySystem:removelistener(notifyConfig.on_mystery_create_entity,self.createEntityCB)

self.image:setScale(Vector3.New(0,0,0))
self.image2:setScale(Vector3.New(0,0,0))

self:unbindComponents()
self.guid=nil

if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end




function UIMysteryHUD:onShow(argtable,afterOnloaded)
self.guid=argtable.guid
self.entity=mysteryMonsterModel:bind_hud(self.guid,self)
mysteryMonsterModel:refresh_hud(self.guid)

if not self.entity then
self:recycleSelf()
return
end

if self.entity.data.huge or self.entity.data.dontShowAppear then
self.TopRoot:setActive(false)
end

local monsterCfg=mysteryMonsterModel:get_config(self.entity.id)
if monsterCfg then
if monsterCfg.monType==monType.Boss then

self.topEffect:setChildShowEffect(10059,true)

else

self.topEffect:setChildShowEffect(0,false)
end
end

self:monsterAppear()

self:refreshCount(0)

self.onUpdate(self)

if argtable.sortLayer then
local id=helper.getSortingLayerID(argtable.sortLayer)
self.TopRoot:setChildCanvas(id,argtable.sortOrder or 0)
end
end


function UIMysteryHUD:onHide()

end

function UIMysteryHUD.onUpdate(win)
if win and win.guid then
local hudTopPos=mysteryMonsterModel:get_hud_position(win.guid,true)
win:refreshPosition(hudTopPos)
win:refreshTopPosition(hudTopPos)
end
end




function UIMysteryHUD:refreshCount(count)
if not self.CountRoot and not self.EntityCount then
return
end
if count>1 then
self.EntityCount:setText(count)
self.CountRoot:setActive(true)
else
self.CountRoot:setActive(false)
end
end

function UIMysteryHUD:refreshPosition(hudPos)
if self.Root then
self:setChildPosition(self.Root:getID(),hudPos)
end
end

function UIMysteryHUD:refreshTopPosition(hudPos)
if self.TopRoot then
self:setChildPosition(self.TopRoot:getID(),hudPos)
end
end

function UIMysteryHUD:doRootFade(active,duration,cb)
if self.motionRoot then
self.motionRoot:setChildCanvasGroupAlpha(active and 0 or 1)
self.motionRoot:setChildCanvasGroupDOFade(active and 1 or 0,duration,cb)
end
end

function UIMysteryHUD:doMoveYMotionRoot(y,dur)
if self.motionRoot then
self.motionRoot:setChildDOLocalMoveY(y,dur,function()
self.motionRoot:setLocalPos(0,0,0)
end)
end
end

function UIMysteryHUD:refreshVisible(isVisible)
if self.Root then
self.Root:setActive(isVisible)
end






local visible=isVisible


if self.guid then
local roomID=mysteryRoomModel:get_cur_roomID()
local monster=mysteryMonsterModel:get_entity(self.guid)
local notFog=mysteryFogModel:get_fog_data(roomID,monster.pos.x,monster.pos.y)
if(not self.entity.data.huge)and(not self.entity.data.dontShowAppear)then
self.TopRoot:setActive(isVisible and notFog)
visible=isVisible and notFog
end
end

if visible then
self.updateTimer=self:setTimer(0.02,0,function()self.onUpdate(self)end)
else
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
end
end
end

function UIMysteryHUD:hide()
self.CountRoot:setActive(false)
end

function UIMysteryHUD:entityAppear()
if self.timeid then
self:stopTimerByID(self.timeid)
self.timeid=nil
end
if self.entity then

if self.entity.data.dontShowAppear then
return
end


local monsterAICfg=mysteryMonsterModel:get_entity_ai_config(self.entity.guid)
if monsterAICfg.alert_range==0 then
return
end

self.entity.showHUD=true
end
if not self.image then
return
end
if not self.image2 then
return
end
self.image2:setChildDOScale(0,0.3,function()
if self.widget and self.image then
self.image:setActive(true)
self.image:setChildDOScale(1,0.3)
end
self.timeid=self:setTimer(1,1,function()
if self~=nil and self.image~=nil then
self.image:setChildDOScale(0,0.3,function()
if self.entity then
self.entity.showHUD=false
end
end)
end
end)
end)

end

function UIMysteryHUD:monsterAppear()
local entity=mysteryMonsterModel:get_entity(self.guid)
if entity then
if entity.data.dontShowAppear then
return
end


local player=mysteryPlayerModel:get_player()
if player then
local playerPos=mysteryPlayerModel:get_player_pos()

local monsterAICfg=mysteryMonsterModel:get_entity_ai_config(entity.guid)

local isInAlertRange=mysteryPosHelper.is_in_check_range(entity.data.sim_pos,playerPos,monsterAICfg.alert_range,entity.roomId,player.roomId)

local hasHide=mysterySkillModel:has_sim_hide_steps()

if isInAlertRange and not hasHide then
self:entityAppear()
entity.appearHUD=true
end
end
end
end

function UIMysteryHUD:setRightward(isRightward)
if self.motionRoot then
if isRightward then
self.motionRoot:setLocalPosX(50)
else
self.motionRoot:setLocalPosX(-50)
end
end
end

function UIMysteryHUD:entityPlayerNotFound()
if mysteryTriggerPointModel:haveGrass(mysteryPlayerModel:get_player_pos())then
return
end
if self.timeid then
self:stopTimerByID(self.timeid)
self.timeid=nil
end
if self.entity then
if self.entity.data.dontShowAppear then
return
end

local monsterAICfg=mysteryMonsterModel:get_entity_ai_config(self.entity.guid)
if monsterAICfg.alert_range==0 then
return
end
end
self.entity.showHUD=true
if not self.image then
return
end
if not self.image2 then
return
end
self.image:setChildDOScale(0,0.3,function()
if self.widget and self.image2 then
self.image2:setActive(true)
self.image2:setChildDOScale(1,0.3)
end
self.timeid=self:setTimer(1,1,function()
if self~=nil and self.image2~=nil then
self.image2:setChildDOScale(0,0.3,function()
if self.entity then
self.entity.showHUD=false
end
end)
end
end)
end)
end

function UIMysteryHUD:createEntity(guid,pos,entityType)
if self and guid==self.guid and entityType==eMysteryEntityType.eMonster then
self:entityAppear()
end
end
