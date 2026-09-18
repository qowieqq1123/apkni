







def_class("UISheQuActWin",UIWindowBase)









function UISheQuActWin:bindComponents()

self.bgImage=UIImage.get(self,0)
self.contentText=UIText.get(self,1)
self.jumpBtn=UIButton.get(self,2)
self.bgRawImage=UIRawImage.get(self,3)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UISheQuActWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImage);self.bgImage=nil;
_UIObject_release(self.contentText);self.contentText=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.bgRawImage);self.bgRawImage=nil;
end



















function UISheQuActWin:onLoaded(...)
self:bindComponents()
end


function UISheQuActWin:__delete()
self:unbindComponents()
end




function UISheQuActWin:onShow(argtable,afterOnloaded)
self:onShowArgRecv(argtable)
end

function UISheQuActWin:onShowArgRecv(argtable)
local htTypeName=FMT.fmt('weekSheQuAct_{0}',argtable[1])
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eWeek,htTypeName)
if not flag then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eWeek,htTypeName,true)
reddotControl.on_change_catch_type(CATCH_TYPE.eSheQuAct)
end

self.actData=houtaiModel:getSheQuActData(argtable[1])
local contentStr=self.actData.content or''
self.contentText:setText(contentStr)

local imageName=self.actData.bgName
if imageName then
if api_Available_ChildRawImageLoader()then

self.bgImage:setActive(false)
self.bgRawImage:setActive(true)
local cdnUrl
if deviceHelper.isRunNoneOrEditor()then

cdnUrl="http://10.10.4.101:88/pic/"
platformSDK.printSDK('获取外部图片链接:',cdnUrl)
self.widget:ChildRawImageLoader(self.bgRawImage:getID(),3,cdnUrl,imageName,true)
else

local rootUrl=shequModel:getCdnRootURL()
local url=FMT.fmt("{0}pic/",rootUrl)
platformSDK.printSDK('获取外部图片链接:',url)
self.widget:ChildRawImageLoader(self.bgRawImage:getID(),3,url,imageName,true)
end
else

self.bgImage:setActive(true)
self.bgRawImage:setActive(false)

local abName=FMT.fmt("ui/windows/shequ/sharedtextures/{0}.ab",imageName)
self.bgImage:setSprite(abName,imageName)
end
end
end


function UISheQuActWin:onHide()

end





function UISheQuActWin:onJumpBtn()
local jumpURL=self.actData.jumpURL
local openCommunity=self.actData.openCommunity


if not openCommunity or deviceHelper.getAPILevel()<400 then
pfwindowslController:OpenURL_By_UIWebViewWin(jumpURL)
else
platformSDK:reqOpenCommunity(10002)
end


end

