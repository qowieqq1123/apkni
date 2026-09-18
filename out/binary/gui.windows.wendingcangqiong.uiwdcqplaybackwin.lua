







def_class("UIWDCQPlayBackWin",UIWindowBase)









function UIWDCQPlayBackWin:bindComponents()

self.otherbg=UIObject.get(self,0)
self.otherContent=UIObject.get(self,1)
self.otherFlag=UIImage.get(self,2)
self.otherHeadIcon=UIObject.get(self,3)
self.otherLoseHead=UIObject.get(self,4)
self.otherName=UIText.get(self,5)
self.otherWinFlag_1=UIObject.get(self,6)
self.otherWinFlag_2=UIObject.get(self,7)
self.otherWinFlag_3=UIObject.get(self,8)
self.otherWinFlag_4=UIObject.get(self,9)
self.otherWinFlag_5=UIObject.get(self,10)
self.otherWinFlag_6=UIObject.get(self,11)
self.otherWinTimes=UIObject.get(self,12)
self.selfbg=UIObject.get(self,13)
self.selfFlag=UIImage.get(self,14)
self.selfHeadIcon=UIObject.get(self,15)
self.selfLoseHead=UIObject.get(self,16)
self.selfName=UIText.get(self,17)
self.selfwinContent=UIObject.get(self,18)
self.selfWinFlag_1=UIObject.get(self,19)
self.selfWinFlag_2=UIObject.get(self,20)
self.selfWinFlag_3=UIObject.get(self,21)
self.selfWinFlag_4=UIObject.get(self,22)
self.selfWinFlag_5=UIObject.get(self,23)
self.selfWinFlag_6=UIObject.get(self,24)
self.selfWinTimes=UIObject.get(self,25)
self.otherWinFlag={
self.otherWinFlag_1,
self.otherWinFlag_2,
self.otherWinFlag_3,
self.otherWinFlag_4,
self.otherWinFlag_5,
self.otherWinFlag_6,
}
self.selfWinFlag={
self.selfWinFlag_1,
self.selfWinFlag_2,
self.selfWinFlag_3,
self.selfWinFlag_4,
self.selfWinFlag_5,
self.selfWinFlag_6,
}



end


function UIWDCQPlayBackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.otherbg);self.otherbg=nil;
_UIObject_release(self.otherContent);self.otherContent=nil;
_UIObject_release(self.otherFlag);self.otherFlag=nil;
_UIObject_release(self.otherHeadIcon);self.otherHeadIcon=nil;
_UIObject_release(self.otherLoseHead);self.otherLoseHead=nil;
_UIObject_release(self.otherName);self.otherName=nil;
_UIObject_release(self.otherWinFlag_1);self.otherWinFlag_1=nil;
_UIObject_release(self.otherWinFlag_2);self.otherWinFlag_2=nil;
_UIObject_release(self.otherWinFlag_3);self.otherWinFlag_3=nil;
_UIObject_release(self.otherWinFlag_4);self.otherWinFlag_4=nil;
_UIObject_release(self.otherWinFlag_5);self.otherWinFlag_5=nil;
_UIObject_release(self.otherWinFlag_6);self.otherWinFlag_6=nil;
_UIObject_release(self.otherWinTimes);self.otherWinTimes=nil;
_UIObject_release(self.selfbg);self.selfbg=nil;
_UIObject_release(self.selfFlag);self.selfFlag=nil;
_UIObject_release(self.selfHeadIcon);self.selfHeadIcon=nil;
_UIObject_release(self.selfLoseHead);self.selfLoseHead=nil;
_UIObject_release(self.selfName);self.selfName=nil;
_UIObject_release(self.selfwinContent);self.selfwinContent=nil;
_UIObject_release(self.selfWinFlag_1);self.selfWinFlag_1=nil;
_UIObject_release(self.selfWinFlag_2);self.selfWinFlag_2=nil;
_UIObject_release(self.selfWinFlag_3);self.selfWinFlag_3=nil;
_UIObject_release(self.selfWinFlag_4);self.selfWinFlag_4=nil;
_UIObject_release(self.selfWinFlag_5);self.selfWinFlag_5=nil;
_UIObject_release(self.selfWinFlag_6);self.selfWinFlag_6=nil;
_UIObject_release(self.selfWinTimes);self.selfWinTimes=nil;
self.otherWinFlag=nil;
self.selfWinFlag=nil;
end



















function UIWDCQPlayBackWin:onLoaded(...)
self:bindComponents()
self.selfWinIndex=0
self.otherWinIndex=0
end


function UIWDCQPlayBackWin:__delete()
self:unbindComponents()
self.selfWinIndex=0
self.otherWinIndex=0
self.curTeamIndex=nil
end




function UIWDCQPlayBackWin:onShow(argtable,afterOnloaded)
self.showWinTimes=argtable.showWinTimes


self.logIdList=argtable.logIdList or{}
local selfName=argtable[1]
local self_iconInfo=argtable[2]
local isSelfLose=selfName==''
if not isSelfLose then
playerController:setHeadIcon(self.widget,self.selfHeadIcon:getID(),{iconInfo=self_iconInfo,scale=0.8})
end
self.selfHeadIcon:setActive(not isSelfLose)
self.selfLoseHead:setActive(isSelfLose)
self.selfName:setText(playerModel:getOtherActorName(selfName))


local otherName=argtable[3]
local other_iconInfo=argtable[4]
local isOtherLose=otherName==''
if not isOtherLose then
playerController:setHeadIcon(self.widget,self.otherHeadIcon:getID(),{iconInfo=other_iconInfo,scale=0.8})
end
self.otherHeadIcon:setActive(not isOtherLose)
self.otherLoseHead:setActive(isOtherLose)
self.otherName:setText(playerModel:getOtherActorName(otherName))

self.leftId=argtable.leftId
self.rightId=argtable.rightId
local hideFlag=argtable.hideFlag
local actorId=playerModel:getActorID()
local isLeftSelf
local isRightSelf
if not hideFlag then
isLeftSelf=self.leftId~=nil and mathHelper.int64_to_number(self.leftId)==mathHelper.int64_to_number(actorId)
isRightSelf=self.rightId~=nil and mathHelper.int64_to_number(self.rightId)==mathHelper.int64_to_number(actorId)
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








if self.showWinTimes then
self.selfbg:setActive(true)
self.otherbg:setActive(true)
self.selfwinContent:setActive(true)
self.otherContent:setActive(true)
else
self.selfbg:setActive(false)
self.otherbg:setActive(false)
self.selfwinContent:setActive(false)
self.otherContent:setActive(false)
end
end

function UIWDCQPlayBackWin:refreshWinTimes(fightIndex,result)
if not self.showWinTimes then
return
end
local logId=self.logIdList[fightIndex]
if not logId then

end
local info=WDCQController:getFightLogIdLookupInfo(logId)
if info then
local teamIndex=info.teamIndex
local fightIndex=info.fightIndex
local win_actor_id=info.win_actor_id
local winIndex=fightIndex
if self.curTeamIndex~=teamIndex then
self.curTeamIndex=teamIndex
self.selfWinIndex=0
self.otherWinIndex=0
end
if mathHelper.compareInt64(win_actor_id,self.leftId)then
self.selfWinIndex=self.selfWinIndex+1
winIndex=(self.curTeamIndex-1)*2+self.selfWinIndex
self.selfWinFlag[winIndex]:setActive(true)
else
self.otherWinIndex=self.otherWinIndex+1
winIndex=(self.curTeamIndex-1)*2+self.otherWinIndex
self.otherWinFlag[winIndex]:setActive(true)
end
else

end
end


function UIWDCQPlayBackWin:onHide()

end



