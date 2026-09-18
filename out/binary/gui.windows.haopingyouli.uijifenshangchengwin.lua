







def_class("UIJiFenShangChengWin",UIWindowBase)









function UIJiFenShangChengWin:bindComponents()

self.btnJump=UIButton.get(self,0)
self.btnReceive=UIButton.get(self,1)
self.rewardContent=UIObject.get(self,2)
self.root=UIObject.get(self,3)

self.btnJump:setButtonClick(function()self:onBtnJump()end)

self.btnReceive:setButtonClick(function()self:onBtnReceive()end)



end


function UIJiFenShangChengWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnJump);self.btnJump=nil;
_UIObject_release(self.btnReceive);self.btnReceive=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.root);self.root=nil;
end
















local gameCodeRoot=
{
[pfwindowslController.sdkPFVersion.game_fanti_GA]="twzqzs",
[pfwindowslController.sdkPFVersion.game_oumei]="euzqzs",
}

local activityCode=
{
[pfwindowslController.sdkPFVersion.game_fanti_GA]="twzqzsGameIntegral",
[pfwindowslController.sdkPFVersion.game_oumei]="euzqzsGameIntegral",
}

local URL=
{
[pfwindowslController.sdkPFVersion.game_fanti_GA]="https://www.movergames.com/login-redirect.html?redirectUrl={0}{1}",
[pfwindowslController.sdkPFVersion.game_oumei]="https://m.efunsea.com/login-redirect.html?redirectUrl={0}{1}",
}

local subUrl

local redirectUrl="/pfActivity/gameIntegral?gameCode={0}&activityCode={1}"





function UIJiFenShangChengWin:onLoaded(...)
self:bindComponents()
subUrl=pfwindowslController.getJFSC_subLoginUrl()
end


function UIJiFenShangChengWin:__delete()
self:unbindComponents()
end




function UIJiFenShangChengWin:onShow(argtable,afterOnloaded)

end


function UIJiFenShangChengWin:onHide()

end





function UIJiFenShangChengWin:onBtnJump()
local data=pfwindowsModel:getSdkLoginData()
if not data.userId then
UIManager.info("帳號尚未登入")
return
end
local GameVersion=pfwindowslController:getGameVersion()

local curGameCodeRoot=gameCodeRoot[GameVersion]
local curActivityCode=activityCode[GameVersion]
local suburl=FMT.fmt(redirectUrl,curGameCodeRoot,curActivityCode)


local curURL=URL[GameVersion]
local LoginParam=pfwindowslController.getLoginParam()
if not LoginParam then
return
end
local rURL=FMT.fmt(curURL,string.encodeURI_R(suburl),LoginParam)
platformSDK.printSDK("UIJiFenShangChengWin",rURL)
pfwindowslController:OpenURL_By_UIWebViewWin(rURL)
end



function UIJiFenShangChengWin:onBtnReceive()
end

