







def_class("UIMysteryArrowHUD",UICloneObject)





UIMysteryArrowHUD.abName="ui/windows/mystery/uimysteryarrowhud.ab"

UIMysteryArrowHUD.assetName="UIMysteryArrowHUD"


function UIMysteryArrowHUD:bindComponents()

self.Root=UIObject.get(self,0)
self.arrow=UIObject.get(self,1)

end


function UIMysteryArrowHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.arrow);self.arrow=nil;
end








local arrowMoveOffsetPos={
[mysteryPosHelper.ArrowType.Left]=Vector3(0,0,0),
[mysteryPosHelper.ArrowType.Right]=Vector3(0,0,0),
[mysteryPosHelper.ArrowType.LeftTop]=Vector3(0,0,0),
[mysteryPosHelper.ArrowType.RightTop]=Vector3(0,0,0),
[mysteryPosHelper.ArrowType.LeftBottom]=Vector3(0,0,0),
[mysteryPosHelper.ArrowType.RightBottom]=Vector3(0,0,0),
}
local arrowMovePosFlip={
[mysteryPosHelper.ArrowType.Left]=Vector3(75,0,0),
[mysteryPosHelper.ArrowType.Right]=Vector3(-75,0,0),
[mysteryPosHelper.ArrowType.LeftTop]=Vector3(75,-75,0),
[mysteryPosHelper.ArrowType.RightTop]=Vector3(-75,-75,0),
[mysteryPosHelper.ArrowType.LeftBottom]=Vector3(75,75,0),
[mysteryPosHelper.ArrowType.RightBottom]=Vector3(-75,75,0),
}
local arrowRatate={
[mysteryPosHelper.ArrowType.Left]=Vector3(0,0,-90),
[mysteryPosHelper.ArrowType.Right]=Vector3(0,0,90),
[mysteryPosHelper.ArrowType.LeftTop]=Vector3(0,0,-135),
[mysteryPosHelper.ArrowType.RightTop]=Vector3(0,0,135),
[mysteryPosHelper.ArrowType.LeftBottom]=Vector3(0,0,-45),
[mysteryPosHelper.ArrowType.RightBottom]=Vector3(0,0,45),
}
local arrowMovePos={
[mysteryPosHelper.ArrowType.Right]=Vector3(75,0,0),
[mysteryPosHelper.ArrowType.Left]=Vector3(-75,0,0),
[mysteryPosHelper.ArrowType.RightBottom]=Vector3(75,-75,0),
[mysteryPosHelper.ArrowType.LeftBottom]=Vector3(-75,-75,0),
[mysteryPosHelper.ArrowType.RightTop]=Vector3(75,75,0),
[mysteryPosHelper.ArrowType.LeftTop]=Vector3(-75,75,0),
}
local arrowRatateFlip={
[mysteryPosHelper.ArrowType.Right]=Vector3(0,0,-90),
[mysteryPosHelper.ArrowType.Left]=Vector3(0,0,90),
[mysteryPosHelper.ArrowType.RightBottom]=Vector3(0,0,-135),
[mysteryPosHelper.ArrowType.LeftBottom]=Vector3(0,0,135),
[mysteryPosHelper.ArrowType.RightTop]=Vector3(0,0,-45),
[mysteryPosHelper.ArrowType.LeftTop]=Vector3(0,0,45),
}


function UIMysteryArrowHUD:onLoaded(...)
self:bindComponents()
self.tween={}
end


function UIMysteryArrowHUD:__delete()
self:unbindComponents()
if self.tween[1]then
self.tween[1]:Kill()
end
if self.tween[2]then
self.tween[2]:Kill()
end
end




function UIMysteryArrowHUD:onShow(argtable,afterOnloaded)

local arrow=argtable.arrow
local flip=argtable.flip
local rotate=flip and arrowRatateFlip[arrow]or arrowRatate[arrow]
local move=flip and arrowMovePosFlip[arrow]or arrowMovePos[arrow]
self.arrow:setRotation(rotate.x,rotate.y,rotate.z)
local hudPos=_HexMapManager.GetCellCenterWorld(argtable.pos,argtable.layer,false)
self:setChildPosition(self.Root:getID(),hudPos+arrowMoveOffsetPos[arrow])

if self.tween[1]then
self.tween[1]:Kill()
end
if self.tween[2]then
self.tween[2]:Kill()
end

self.arrow:setLocalPos(0,0,0)

local sequence=Lua.SequenceProxy.New()
local tween1=self.arrow:setChildDOLocalMove(move,0.75)
sequence:Join(tween1)
self.arrow:setChildCanvasGroupAlpha(0)
local sequenceAlpha=Lua.SequenceProxy.New()
local tween2=self.arrow:setChildCanvasGroupDOFade(1,0.25)
sequenceAlpha:Append(tween2)
sequenceAlpha:AppendInterval(0.2)
local tween3=self.arrow:setChildCanvasGroupDOFade(0,0.25)
sequenceAlpha:Append(tween3)
sequence:Join(sequenceAlpha)
sequence:AppendInterval(0.4)
sequence:SetLoops(-1,_LoopType.Restart)
self.tween[1]=sequence
end


function UIMysteryArrowHUD:onHide()
if self.tween[1]then
self.tween[1]:Kill()
end
if self.tween[2]then
self.tween[2]:Kill()
end
end


