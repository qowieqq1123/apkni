







def_class("UIMysteryMoveTreasureHUD",UICloneObject)





UIMysteryMoveTreasureHUD.abName="ui/windows/mystery/uimysterymovetreasurehud.ab"

UIMysteryMoveTreasureHUD.assetName="UIMysteryMoveTreasureHUD"


function UIMysteryMoveTreasureHUD:bindComponents()

self.stepQiPao=UIObject.get(self,0)
self.biaoqingQiPao=UIObject.get(self,1)
self.stepText=UIText.get(self,2)
self.Image=UIImage.get(self,3)
self.biaoqing=UIImage.get(self,4)
self.motionRoot=UIObject.get(self,5)
self.Root=UIObject.get(self,6)
self.TopRoot=UIObject.get(self,7)

end


function UIMysteryMoveTreasureHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.stepQiPao);self.stepQiPao=nil;
_UIObject_release(self.biaoqingQiPao);self.biaoqingQiPao=nil;
_UIObject_release(self.stepText);self.stepText=nil;
_UIObject_release(self.Image);self.Image=nil;
_UIObject_release(self.biaoqing);self.biaoqing=nil;
_UIObject_release(self.motionRoot);self.motionRoot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.TopRoot);self.TopRoot=nil;
end









local globalab='ui/windows/mystery/sharedtextures/inmysterysprite.ab'


function UIMysteryMoveTreasureHUD:onLoaded(...)
self:bindComponents()

self.etIcon=
{
[eMysteryEntityType.ePlayer]='icon_bushutp_1',
[eMysteryEntityType.eMoveTreasure]='icon_bushutp_1',
[eMysteryEntityType.eBoomMonster]='icon_zhadantp_1',
}
end


function UIMysteryMoveTreasureHUD:__delete()
self:unbindComponents()
if self.timeid then
self:stopTimerByID(self.timeid)
self.timeid=nil
end
end




function UIMysteryMoveTreasureHUD:onShow(argtable,afterOnloaded)
self.etType=argtable.etType
self.guid=argtable.guid
if self.etType==eMysteryEntityType.ePlayer then
self.entity=mysteryPlayerModel:get_player()
self.entity.hud=self
else
self.entity=mysteryEntityController.invokeFuncByMysteryEntityType(self.etType,'bind_hud',self.guid,self)
end

if self.entity then
if self.etType~=eMysteryEntityType.ePlayer then
mysteryEntityController.invokeFuncByMysteryEntityType(self.etType,'refresh_hud',self.guid)
end


self:updateStep(self.entity.data.stepNum or 0)

self.updateTimer=self:setTimer(0.05,0,function()self.onUpdate(self)end)

if self.etIcon[self.etType]then
self.Image:setCSImageSprite(globalab,self.etIcon[self.etType])
end


end
if argtable.sortLayer then
local id=helper.getSortingLayerID(argtable.sortLayer)
self.TopRoot:setChildCanvas(id,argtable.sortOrder or 0)
else
local id=helper.getSortingLayerID("ITGround1")
self.TopRoot:setChildCanvas(id,100)
end
end


function UIMysteryMoveTreasureHUD:onHide()

end

function UIMysteryMoveTreasureHUD.onUpdate(win)
if win and win.guid then

local hudTopPos=mysteryEntityController.invokeFuncByMysteryEntityType(win.etType,'get_hud_position',win.guid,true)
local isVisible=true
local ent=win.entity
if ent.isVisible then
isVisible=true
else
isVisible=false
end

local entityPosList=mysteryRoomModel:get_pos_entityList(ent.roomId,ent.pos)
local level=0
if next(entityPosList)then

local minGuid=ent.guid
for i,v in pairs(entityPosList)do
if v.entityType==ent.entityType then
if v.guid<minGuid and v.data.stepNum~=ent.data.stepNum then
minGuid=v.guid
level=level+1
end
if v.isRunBehavior then
isVisible=false
end
end
end
end

win:refreshStepVisible(isVisible)

hudTopPos.y=hudTopPos.y+level*1
win:refreshTopPosition(hudTopPos)
end
end

function UIMysteryMoveTreasureHUD:refreshPosition(hudPos)
if self.Root then
self:setChildPosition(self.Root:getID(),hudPos)
end
end

function UIMysteryMoveTreasureHUD:refreshTopPosition(hudPos)
if self.TopRoot then
self:setChildPosition(self.TopRoot:getID(),hudPos)
end
end


function UIMysteryMoveTreasureHUD:refreshVisible(isVisible)
if self.Root then
self.Root:setActive(isVisible)
end
end

function UIMysteryMoveTreasureHUD:refreshStepVisible(isVisible)
self.stepQiPao:setActive(isVisible)
end

function UIMysteryMoveTreasureHUD:updateStep(step)
self.stepText:setText(FMT.fmt("x{0}",step))
end

function UIMysteryMoveTreasureHUD:showBiaoQing(iconID)
if self.timeid then
self:stopTimerByID(self.timeid)
self.timeid=nil
end
self.biaoqingQiPao:setActive(true)
local iconName=iconHelper.getEmotIcon(iconID)
self.widget:SetChildCSImageIcon(self.biaoqing:getID(),iconName,true)
self.timeid=self:setTimer(0.8,1,function()
if self~=nil then
self.biaoqingQiPao:setActive(false)
end
end)
end

function UIMysteryMoveTreasureHUD:recycleHUD()
mysteryMoveTreasureModel:bind_hud(self.guid,nil)
self:recycleSelf()
end


