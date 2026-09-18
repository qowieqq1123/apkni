







def_class("UINewbieDragModelWin",UIWindowBase)









function UINewbieDragModelWin:bindComponents()

self.talkroot=UIObject.get(self,0)
self.mark=UIObject.get(self,1)
self.model=UIObject.get(self,2)
self.animroot=UIObject.get(self,3)
self.arrow=UIObject.get(self,4)
self.finger=UIImage.get(self,5)
self.biaoqing=UIImage.get(self,6)
self.talktext=UILinkImageText.get(self,7)



end


function UINewbieDragModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.talkroot);self.talkroot=nil;
_UIObject_release(self.mark);self.mark=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.animroot);self.animroot=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.finger);self.finger=nil;
_UIObject_release(self.biaoqing);self.biaoqing=nil;
_UIObject_release(self.talktext);self.talktext=nil;
end



















local _this=nil

local PosIndex=
{
[1]={id=1,pos=Vector3.New(-166,105,0),scale=0.6},
[2]={id=2,pos=Vector3.New(-202,-12,0),scale=0.6},
[3]={id=3,pos=Vector3.New(-321,47,4.4),scale=0.7},
[4]={id=4,pos=Vector3.New(-322,44,0),scale=0.7},
[5]={id=5,pos=Vector3.New(-367.6,-117,0),scale=0.88},

}



function UINewbieDragModelWin:onLoaded(...)
self:bindComponents()
_this=self
self.winlua:SetChildUIDragEvent(self.mark:getID(),0,self.beginDragCallback,self.endDragCallback,self.dragCallback)
end


function UINewbieDragModelWin:__delete()
self:unbindComponents()
if self.entity then
if self.entity then
self.entity:setColor(Color.New(1,1,1,1))
end
end
_this=nil
end




function UINewbieDragModelWin:onShow(argtable,afterOnloaded)
local actionConfig=argtable.conf
self.entityInfo=argtable.info
if self.entityInfo then
local screenPos
local curPosInfo=self.entityInfo.curPosIndex
local targetPosInfo=self.entityInfo.targetPosIndex
if self.entityInfo.entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eFightPrepare then
if self.entityInfo.entity then
self.entity=self.entityInfo.entity
if self.entity then
self.entity:setColor(Color.New(0,0,0,0))
end
local baseInfo=self.entityInfo.entity.baseInfo
local model=baseInfo.model
local posInfo=fightModel:getPosInfoByTypo(stagePosType.TwoThree,curPosInfo)
local pos=posInfo.pos
screenPos=fightManager.getScreenPos(pos)
self.model:setChildUIModelShowTarget(model.body,model.scale,model.componets,entityStateID.stand)
end


if curPosInfo then
self.screenPos1=screenPos~=nil and screenPos or PosIndex[curPosInfo].pos
self.winlua:SetChildUIModelShowFlipX(self.model:getID(),curPosInfo<=5)
self.model:setChildUIScreenPos(self.screenPos1+Vector3.New(0,15,0))
local scale=PosIndex[curPosInfo].scale
self.model:setScale(Vector3(scale,scale,1))
end
if targetPosInfo then
self.screenPos2=PosIndex[targetPosInfo].pos
end
end
end

if actionConfig.txt then
self.talkroot:setActive(true)
self.talktext:setText(actionConfig.txt)
self.talktext:setActive(true)
if actionConfig.txtPos then
self.talkroot:setChildAnchoredPosition(Vector2.New(actionConfig.txtPos[1],actionConfig.txtPos[2]))
end
end
end


function UINewbieDragModelWin:onHide()

end

function UINewbieDragModelWin.beginDragCallback(index,position)
local rect={50,50}
if _this.screenPos1 and(_this.screenPos1.x-rect[1]<position.x or _this.screenPos1.x+rect[1]>position.x
or _this.screenPos1.y-rect[1]<position.y or _this.screenPos1.y+rect[1]>position.y)then
_this.drag=true
_this.talkroot:setActive(false)
end
end

function UINewbieDragModelWin.dragCallback(index,position)
if _this.drag then
_this.model:setChildAnchoredPosition(position)
end
end

function UINewbieDragModelWin.endDragCallback(index,position)
_this.drag=false
if _this.screenPos2 then
_this.model:setActive(false)
_this.entity:show()
_this.animroot:setActive(false)
end

newbieControl.onRayHitEntity(_this.entityInfo.guid)
end




