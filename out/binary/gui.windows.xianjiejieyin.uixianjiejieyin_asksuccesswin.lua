







def_class("UIXianJieJieYin_AskSuccessWin",UIWindowBase)









function UIXianJieJieYin_AskSuccessWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.desc=UIText.get(self,2)
self.head=UIObject.get(self,3)
self.loseHead=UIObject.get(self,4)
self.name=UIText.get(self,5)
self.picture=UIObject.get(self,6)
self.Root=UIObject.get(self,7)
self.startBtn=UIButton.get(self,8)
self.uiRoot=UIObject.get(self,9)
self.zome=UIText.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)



end


function UIXianJieJieYin_AskSuccessWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.loseHead);self.loseHead=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.zome);self.zome=nil;
end



















function UIXianJieJieYin_AskSuccessWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieJieYin_AskSuccessWin:__delete()
self:unbindComponents()
end




function UIXianJieJieYin_AskSuccessWin:onShow(argtable,afterOnloaded)
if afterOnloaded then

self.bgSpine:setChildUIModelShowTarget(6065,1,{},eAnimationID.enter)

self.uiRoot:setChildCanvasGroupAlpha(0)
self:delayDo(0.4,function()
self.uiRoot:setChildCanvasGroupDOFade(1,0.4)
end)
end
local guidActorInfo=jiuchongtianjieGuideModel:getGuideActorInfo()
local isLose=mathHelper.validInt64(guidActorInfo.actorid)and guidActorInfo.actorname==''

local actorName=playerModel:getOtherActorName(guidActorInfo.actorname)
local serverName=loginModel:getServerName(guidActorInfo.serverid)


self.name:setText(actorName)


self.zome:setText(serverName)

if not isLose then
playerController:setHeadIcon(self.winlua,self.head:getID(),{iconInfo=guidActorInfo.iconinfo,scale=0.65})
end
self.head:setActive(not isLose)
self.loseHead:setActive(isLose)
end


function UIXianJieJieYin_AskSuccessWin:onHide()

end





function UIXianJieJieYin_AskSuccessWin:onCloseBtn()
self:closeSelf()
end



function UIXianJieJieYin_AskSuccessWin:onStartBtn()






UIFullCommonControl:showCommonWindow("UIXianJieJieYin_ProgressWin",{isFull=true},nil,1,false,nil,nil)
end

