







def_class("UIDouFaTaiPlayBackWin",UIWindowBase)









function UIDouFaTaiPlayBackWin:bindComponents()

self.otherFlag=UIImage.get(self,0)
self.otherHeadIcon=UIObject.get(self,1)
self.otherName=UIText.get(self,2)
self.otherWinTimes=UIObject.get(self,3)
self.selfFlag=UIImage.get(self,4)
self.selfHeadIcon=UIObject.get(self,5)
self.selfName=UIText.get(self,6)
self.selfWinTimes=UIObject.get(self,7)



end


function UIDouFaTaiPlayBackWin:unbindComponents()
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



















function UIDouFaTaiPlayBackWin:onLoaded(...)
self:bindComponents()
end


function UIDouFaTaiPlayBackWin:__delete()
self:unbindComponents()
end




function UIDouFaTaiPlayBackWin:onShow(argtable,afterOnloaded)

local selfName=argtable[1]
selfName=playerModel:getOtherActorName(selfName)
local self_iconInfo=argtable[2]
playerController:setHeadIcon(self.widget,self.selfHeadIcon:getID(),{iconInfo=self_iconInfo,scale=0.8})
self.selfName:setText(selfName)


local otherName=argtable[3]
otherName=playerModel:getOtherActorName(otherName)
local other_iconInfo=argtable[4]
playerController:setHeadIcon(self.widget,self.otherHeadIcon:getID(),{iconInfo=other_iconInfo,scale=0.8})
self.otherName:setText(otherName)

local leftId=argtable.leftId
local rightId=argtable.rightId
local hideFlag=argtable.hideFlag
local actorId=playerModel:getActorID()
local isLeftSelf
local isRightSelf
if not hideFlag then
isLeftSelf=leftId~=nil and mathHelper.int64_to_number(leftId)==mathHelper.int64_to_number(actorId)
isRightSelf=rightId~=nil and mathHelper.int64_to_number(rightId)==mathHelper.int64_to_number(actorId)
if isLeftSelf or isRightSelf then
hideFlag=false
else
hideFlag=true
end
end
self.selfFlag:setActive(not hideFlag)
self.otherFlag:setActive(not hideFlag)
if not hideFlag then
local abname=globalABLookup.fightcommonicons
local selfFlagIcon=isLeftSelf and'image_dftwz_1'or'image_dftwz_2'
local otheFlagIcon=isRightSelf and'image_dftwz_1'or'image_dftwz_2'
self.selfFlag:setSprite(abname,selfFlagIcon)
self.otherFlag:setSprite(abname,otheFlagIcon)
end

local battle=argtable.battle
if battle then
local extra=battle:getSendExtraArgs()
if extra and extra.battleType then
self.battleType=extra.battleType
end
end
if argtable.showWinTimes then
self.showWinTimes=true
if battle then
local maxTimes=battle:getfightMaxTimes()
local leftWinTimes=battle:getfightLeftWinTimes()
local rightWinTimes=battle:getfightRightWinTimes()
self:refreshWinTimes(leftWinTimes,rightWinTimes,maxTimes)
end
end
end

function UIDouFaTaiPlayBackWin:refreshWinTimes(winLeft,winRight,fightMax)
if not self.showWinTimes then
return
end
local count=self.battleType==eBattleType.wengdingcangqiong and 5 or 2
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


function UIDouFaTaiPlayBackWin:onHide()

end



