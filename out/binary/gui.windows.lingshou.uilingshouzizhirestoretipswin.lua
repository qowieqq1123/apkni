







def_class("UILingShouZiZhiRestoreTipsWin",UIWindowBase)









function UILingShouZiZhiRestoreTipsWin:bindComponents()

self.restoretip=UIText.get(self,0)
self.root=UIObject.get(self,1)
self.tip=UIText.get(self,2)
self.title=UIText.get(self,3)



end


function UILingShouZiZhiRestoreTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.restoretip);self.restoretip=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this




function UILingShouZiZhiRestoreTipsWin:onLoaded(...)
self:bindComponents()

_this=self

self:addNotify(notifyConfig.onLingShouZiZhiRestore,function()
if _this==nil then return end
_this:closeSelf()
end)
end


function UILingShouZiZhiRestoreTipsWin:__delete()
_this:stopRestoreTimer()
_this=nil
self:unbindComponents()
end




function UILingShouZiZhiRestoreTipsWin:onShow(argtable,afterOnloaded)

self.lsGuid=argtable.lsGuid

local reduceVal=lingshouModel:getReduceZiZhiValByLsGuid(self.lsGuid)
local reduceTip=FMT.fmt("资质-{0}，无法在传功阁里成为传功灵兽",reduceVal)
self.tip:setText(reduceTip)


self:restoreTimer()

local item=argtable.item
local move_pos=argtable.node

if argtable.pivot then
self.root:setChildPivot(argtable.pivot)
end

if item then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.1,function()
if _this==nil then return end
_this.root:setChildCanvasGroupAlpha(1)
_this:showPosition(item,move_pos)
end)
else
self.root:setChildCanvasGroupAlpha(1)
end
end


function UILingShouZiZhiRestoreTipsWin:onHide()

end

function UILingShouZiZhiRestoreTipsWin:stopRestoreTimer()
if self.restoreTimer then
self:stopTimerByID(self.restoreTimer)
self.restoreTimer=nil
end
end

function UILingShouZiZhiRestoreTipsWin:restoreTimer()
local restoreTime=lingshouModel:getLingShouZiZhiTimeByLsGuid(self.lsGuid)
local curTime=timeHelper.getServerShortTime()
local left=restoreTime-curTime


local fmt="{0}后将自动恢复至初始值"
local func=function()
curTime=timeHelper.getServerShortTime()
left=restoreTime-curTime

local restoreTip=FMT.fmt(fmt,timeHelper.format_time_stamp3(left))
_this.restoretip:setText(restoreTip)

if left<0 then
_this:closeSelf()
end
end

self.restoreTimer=self:setTimer(1,0,func)
func()
end


function UILingShouZiZhiRestoreTipsWin:showPosition(item,move_pos)

local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.root:getTransform()
local selfSize=selfTrans.sizeDelta
local selfPivot=selfTrans.pivot

local offsetX=0
local offsetY=0
move_pos=move_pos or'bottom'

if move_pos=='bottom'then
offsetY=-itemSize.y*itemPivot.y
offsetX=-(itemPivot.x-0.5)*itemSize.x
elseif move_pos=='top'then
offsetY=-(itemPivot.y-1)*itemSize.y
offsetX=-(itemPivot.x-0.5)*itemSize.x
elseif move_pos=='left'then
offsetY=-(itemPivot.y-0.5)*itemSize.y
offsetX=-itemPivot.x*itemSize.x

offsetX=offsetX-selfSize.x/2
offsetY=offsetY+selfSize.y/2
elseif move_pos=='right'then
offsetY=-(itemPivot.y-0.5)*itemSize.y
offsetX=-(itemPivot.x-1)*itemSize.x

offsetX=offsetX+selfSize.x/2
offsetY=offsetY+selfSize.y/2
end
local rootPosX=screenPoint.x+offsetX
local rootPosY=screenPoint.y+offsetY


local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local itemWidth=selfSize.x
local itemHeight=selfSize.y
local halfWidth=UnityEngine.Screen.width/scaleFactor.x/2
local halfHeight=UnityEngine.Screen.height/scaleFactor.y/2

if rootPosX-itemWidth*(selfPivot.x)<-halfWidth then
rootPosX=-halfWidth+itemWidth*(selfPivot.x)
end

if rootPosX+itemWidth*(1-selfPivot.x)>halfWidth then
rootPosX=halfWidth-itemWidth*(1-selfPivot.x)
end

if rootPosY-itemHeight*(selfPivot.y)<-halfHeight then
rootPosY=-halfHeight+itemHeight*(selfPivot.y)
end

if rootPosY+itemHeight*(1-selfPivot.y)>halfHeight then
rootPosY=halfHeight-itemHeight*(1-selfPivot.y)
end

self.winlua:SetChildLocalPosition(self.root:getID(),Vector3(rootPosX,rootPosY,0))
end


