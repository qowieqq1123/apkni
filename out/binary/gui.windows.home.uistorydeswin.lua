







def_class("UIStoryDesWin",UIWindowBase)









function UIStoryDesWin:bindComponents()

self.bg=UIObject.get(self,0)
self.content=UIText.get(self,1)
self.tips=UIText.get(self,2)



end


function UIStoryDesWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.tips);self.tips=nil;
end



















function UIStoryDesWin:onLoaded(...)
self:bindComponents()

self.allowClose=false

self.bg:setChildCanvasGroupAlpha(0)
self.content:setText('')
self.tips:setActive(false)
end


function UIStoryDesWin:__delete()
self:unbindComponents()
if self.bt and self.ckey then
self.bt:setSharedVar(self.ckey,true)
end
end




function UIStoryDesWin:onShow(argtable,afterOnloaded)
local stime=argtable.stime or 1
self.ctime=argtable.ctime or 0.5
self.bt=argtable.bt
self.bg:setChildCanvasGroupDOFade(1,stime,nil)
end


function UIStoryDesWin:onHide()

end

function UIStoryDesWin:onLostConnection()
self:pauseAllTimers()






self.bt=nil
end

function UIStoryDesWin:showContent(content,stime,wtime,htime)
self.content:setChildCanvasGroupAlpha(0)
self.content:setText(content)
self.content:setChildCanvasGroupDOFade(1,stime,nil)
local tweener=self.content:setChildCanvasGroupDOFade(0,htime,nil)
tweener:SetDelay(stime+wtime)
end

function UIStoryDesWin:allowCloseWin(ckey)
self.ckey=ckey
self.tips:setActive(true)
self.allowClose=true
end




function UIStoryDesWin:onCLoseClick()
if self.allowClose and not self.isClose then
self.isClose=true
self.bg:setChildCanvasGroupDOFade(0.5,self.ctime,function()
self:closeSelf()
end)
end
end