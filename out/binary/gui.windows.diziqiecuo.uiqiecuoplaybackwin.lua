







def_class("UIQieCuoPlayBackWin",UIWindowBase)









function UIQieCuoPlayBackWin:bindComponents()

self.otherFlag=UIImage.get(self,0)
self.otherHeadIcon=UIObject.get(self,1)
self.otherName=UIText.get(self,2)
self.otherWinTimes=UIObject.get(self,3)
self.selfFlag=UIImage.get(self,4)
self.selfHeadIcon=UIObject.get(self,5)
self.selfName=UIText.get(self,6)
self.selfWinTimes=UIObject.get(self,7)



end


function UIQieCuoPlayBackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.otherFlag);self.otherFlag=nil;
_UIObject_release(self.otherHeadIcon);self.otherHeadIcon=nil;
_UIObject_release(self.otherName);self.otherName=nil;
_UIObject_release(self.otherWinTimes);self.otherWinTimes=nil;
_UIObject_release(self.selfFlag);self.selfFlag=nil;
_UIObject_release(self.selfHeadIcon);self.selfHeadIcon=nil;
_UIObject_release(self.selfName);self.selfName=nil;
_UIObject_release(self.selfWinTimes);self.selfWinTimes=nil;
end



















function UIQieCuoPlayBackWin:onLoaded(...)
self:bindComponents()
end


function UIQieCuoPlayBackWin:__delete()
self:unbindComponents()
end




function UIQieCuoPlayBackWin:onShow(argtable,afterOnloaded)

local selfName=argtable[1]
local self_iconInfo=argtable[2]
playerController:setHeadIcon(self.widget,self.selfHeadIcon:getID(),{iconInfo=self_iconInfo,scale=0.8})
self.selfName:setText(selfName)


local otherName=argtable[3]
local other_iconInfo=argtable[4]
playerController:setHeadIcon(self.widget,self.otherHeadIcon:getID(),{iconInfo=other_iconInfo,scale=0.8})
self.otherName:setText(otherName)

end

function UIQieCuoPlayBackWin:refreshWinTimes(winLeft,winRight,fightMax)
if not self.showWinTimes then
return
end
local count=2
self.selfWinTimes:setChildLayoutGroupCreateItems(count)
local grids=self.selfWinTimes:getChildLayoutGroupGridList()
for i=1,count do
local item=grids[i-1]
item:SetChildActive(0,i<=winLeft)
end
self.otherWinTimes:setChildLayoutGroupCreateItems(count)
local grids=self.otherWinTimes:getChildLayoutGroupGridList()
for i=1,count do
local item=grids[i-1]
item:SetChildActive(0,i<=winRight)
end
end


function UIQieCuoPlayBackWin:onHide()

end


