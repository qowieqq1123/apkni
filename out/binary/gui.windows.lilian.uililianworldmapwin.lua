







def_class("UILiLianWorldMapWin",UIWindowBase)









function UILiLianWorldMapWin:bindComponents()

self.map=UIObject.get(self,0)
self.headBg=UIObject.get(self,1)
self.head=UIObject.get(self,2)



end


function UILiLianWorldMapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.map);self.map=nil;
_UIObject_release(self.headBg);self.headBg=nil;
_UIObject_release(self.head);self.head=nil;
end
















local _pathType=DG.Tweening.PathType




function UILiLianWorldMapWin:onLoaded(...)
self:bindComponents()
end


function UILiLianWorldMapWin:__delete()
self:unbindComponents()

self:clearTweener()

if self.callback then
self.callback()
end
end




function UILiLianWorldMapWin:onShow(argtable,afterOnloaded)


self.currId=argtable.currId
self.nextId=argtable.nextId
self.callback=argtable.callback

self.map:setChildCanvasGroupAlpha(0)
self.map:setChildCanvasGroupDOFade(1,0.5,function()
UILiLianControl:reqFinishChapter(self.currId)
self:moveTo(self.nextId,function()
self:delayDo(1,function()
self:leave()
end)
end)
end)




playerController:setHeadIcon(self.winlua,self.head:getID(),{scale=HEAD_SCALE_TYPE.e60x60})

self.winlua:SetChildLoadUIMapDataById(self.map:getID(),1,-1,nil,nil)

local tran=self.map:getCommonComponent('Transform')
local ht=self.headBg:getCommonComponent('Transform')
ht:SetParent(nil)
ht:SetParent(tran)

local pos=self.winlua:GetChildUIMapNodeLPositionById(self.map:getID(),self.currId)

self.headBg:setChildAnchoredPosition3D(Vector3.New(pos.x,pos.y,0))
end


function UILiLianWorldMapWin:onHide()

end

function UILiLianWorldMapWin:clearTweener()
if self.moveTweener then
self.moveTweener:Kill()
self.moveTweener=nil
end
end

function UILiLianWorldMapWin:moveTo(id,callback)
local path=self.winlua:GetChildUIMapPathDataToNode(self.map:getID(),self.currId,id)
local target=self.headBg:getCommonComponent('Transform')
local length=self.winlua:GetChildUIMapPathLengthByData(self.map:getID(),self.currId,path,30)
local time=length/100
self:clearTweener()
self.moveTweener=_DOTweenProxy.DoLocalPath(target,path,time,_pathType.CubicBezier)
self.moveTweener:SetEase(_Ease.Linear)
self.moveTweener:OnComplete(function()
callback()
end)
end

function UILiLianWorldMapWin:leave()
local time=0.5
self.map:setChildDOScale(1.25,time,nil)
self.map:setChildCanvasGroupDOFade(0,time,function()
self:onCloseClick()
end)
end




function UILiLianWorldMapWin:onCloseClick()
self:closeSelf()
end