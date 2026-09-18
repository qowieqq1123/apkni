







def_class("UIDiscipleSignTipsWin",UIWindowBase)









function UIDiscipleSignTipsWin:bindComponents()

self.arrow=UIObject.get(self,0)
self.background=UIButton.get(self,1)
self.cd=UIText.get(self,2)
self.desc=UIText.get(self,3)
self.icon=UIImage.get(self,4)
self.name=UIText.get(self,5)
self.root=UIObject.get(self,6)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIDiscipleSignTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.cd);self.cd=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.root);self.root=nil;
end















local _this=nil



function UIDiscipleSignTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleSignTipsWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTick()
end




function UIDiscipleSignTipsWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.signName=argtable.name
self.signIcon=argtable.icon
self.signDesc=argtable.desc
self.endTime=argtable.endTime

self:locateComponet(self.root,argtable.rootPos)
self:locateComponet(self.arrow,argtable.arrowPos)

self:refreshView()
end


function UIDiscipleSignTipsWin:onHide()

end




function UIDiscipleSignTipsWin:onBackground()
if self.closeFunc then
self.closeFunc()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIDiscipleSignTipsWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIDiscipleSignTipsWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIDiscipleSignTipsWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local deltaTime=self.endTime-nowTime
if deltaTime>=0 then
local str=FMT.fmt("{0}后将自动消除",timeHelper.format_time_stamp3(deltaTime,true))
self.cd:setText(str)
else
self.cd:setText("即将消除")
self:stopCDTick()
end
end

function UIDiscipleSignTipsWin:refreshView()
self.name:setText(self.signName)
self.desc:setText(self.signDesc)
self.icon:setSprite(self.signIcon[1],self.signIcon[2])

self:startCDTick()
self:updateCDTick()
end

function UIDiscipleSignTipsWin:locateComponet(cmp,args)
cmp:setActive(args~=nil)
if args then
if args.anchorsMin and args.anchorsMax then
self.winlua:SetChildAnchors(cmp:getID(),args.anchorsMin,args.anchorsMax)
end
if args.pivot then
self.winlua:SetChildPivot(cmp:getID(),args.pivot)
end
if args.rotation then
self.winlua:SetChildRotation(cmp:getID(),args.rotation.x,args.rotation.y,args.rotation.z)
end
if args.anchoredPos then
self.winlua:SetChildAnchoredPos(cmp:getID(),args.anchoredPos.x,args.anchoredPos.y)
end
end
end