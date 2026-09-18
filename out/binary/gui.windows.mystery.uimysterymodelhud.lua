







def_class("UIMysteryModelHUD",UICloneObject)





UIMysteryModelHUD.abName="ui/windows/mystery/uimysterymodelhud.ab"

UIMysteryModelHUD.assetName="UIMysteryModelHUD"


function UIMysteryModelHUD:bindComponents()

self.moveRoot=UIObject.get(self,0)
self.Root=UIObject.get(self,1)
self.Model=UIObject.get(self,2)
self.Effect=UIObject.get(self,3)
self.Imgae=UIImage.get(self,4)

end


function UIMysteryModelHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.moveRoot);self.moveRoot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.Model);self.Model=nil;
_UIObject_release(self.Effect);self.Effect=nil;
_UIObject_release(self.Imgae);self.Imgae=nil;
end









local _HexMapManager=CS.HexagonMapManagerInterface




function UIMysteryModelHUD:onLoaded(...)
self:bindComponents()
notifySystem:listenNotify(notifyConfig.on_mystery_remove_entity,function(...)self:removeEntityCb(...)end)
end


function UIMysteryModelHUD:__delete()
self.Effect:setLocalPos(0,0,0)
self.Root:setScale(Vector3.one)
self.Model:setScale(Vector3.zero)
self.Effect:setScale(Vector3.one)
self.Effect:setChildShowEffect(0,false)
self.Model:setChildUIModelRemoveTarget()
self.Imgae:setActive(false)
self:unbindComponents()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end

if self.entity then
self.entity=nil
end
if self.imageTweener then
self.imageTweener:Kill()
end
notifySystem:removelistener(notifyConfig.on_mystery_remove_entity,function(...)self:removeEntityCb(...)end)
end




function UIMysteryModelHUD:onShow(argtable,afterOnloaded)
if argtable then
if self.Root then
self.Root:setChildCanvasGroupAlpha(1)
if argtable.pos then
local hudPos=_HexMapManager.GetCellCenterWorld(argtable.pos,argtable.layer,false)
self:setChildPosition(self.Root:getID(),hudPos)
end
if argtable.sortLayer then
local id=helper.getSortingLayerID(argtable.sortLayer)
self.Root:setChildCanvas(id,argtable.sortOrder or 0)
else
local id=helper.getSortingLayerID("ITGround1")
self.Root:setChildCanvas(id,100)
end
end
if argtable.modelArgs then
local scale=argtable.modelArgs.scale
local cfg=cfgHelper.get1(cfg_dbbodyconfig_get,argtable.modelArgs.body)
if not scale then
scale=cfg.scales and(cfg.scales[1]~=1 and cfg.scales[1]or cfg.scales[2])or 1
end
self.Model:setScale(Vector3.one)
self.Model:setChildUIModelShowTarget(argtable.modelArgs.body,scale,argtable.modelArgs.componnets or{},argtable.modelArgs.animationID or eAnimationID.stand)
end

if argtable.effectArgs then

self.Effect:setChildShowEffect(argtable.effectArgs.effectId,true)

if argtable.effectArgs.endPos then
self.Effect:setLocalPos(0,0,0)
local hudPos=_HexMapManager.GetCellCenterWorld(argtable.effectArgs.endPos,argtable.layer,false)
self.Effect:setChildDOMove(hudPos,argtable.effectArgs.duration or 1,nil)
end
if argtable.effectArgs.scale then
local scale=argtable.effectArgs.scale
self.Effect:setScale(Vector3.New(scale,scale,scale))
end
end

if argtable.destoryTime then
timeEventController.delayDo(argtable.destoryTime,function()
self:recycleSelf()
end)
end

if argtable.icon then
self.Imgae:setActive(true)
self.Imgae:setChildIcon(argtable.icon,true)
self.imageTweener=self.Imgae:setChildDOLocalMoveY(-10.5,0.8,nil)
self.imageTweener:SetLoops(-1,_LoopType.Yoyo)
end

if argtable.attachEntity then
self.entity=argtable.attachEntity
self:bindEntity()
end

if argtable.scale then
local scale=argtable.scale
self.Root:setScale(Vector3.New(scale,scale,1))
end


end
end

function UIMysteryModelHUD:bindEntity()

if mysteryEntityBase:isStaticType(self.entity.entityType)then
local entity=self.entity
local hudPos=mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'get_hud_position',entity.guid)
self:refreshPosition(hudPos)
else
self.updateTimer=self:setTimer(0.02,0,function()self.onUpdate(self)end)
end
end

function UIMysteryModelHUD.onUpdate(win)
if win and win.entity then
local entity=win.entity
local hudPos=mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'get_hud_position',entity.guid)
win:refreshPosition(hudPos)
end
end

function UIMysteryModelHUD:refreshPosition(hudPos)
if self.Root then
self:setChildPosition(self.Root:getID(),hudPos)
end
end

function UIMysteryModelHUD:removeEntityCb(guid,roomId,pos,eType,id,isDestory)
if self.entity and self.entity.guid==guid then
if isDestory then
self.Root:setChildCanvasGroupDOFade(0,0.5,function()
self:recycleSelf()
end)
end
end
end


function UIMysteryModelHUD:onHide()

end


