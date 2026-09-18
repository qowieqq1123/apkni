







def_class("UIShareImageFrameWin",UIWindowBase)









function UIShareImageFrameWin:bindComponents()

self.changeBgBtn=UIButton.get(self,0)
self.creator=UIGameobjectClone.new(self,1)
self.DdBtn=UIButton.get(self,2)
self.douyinBtn=UIButton.get(self,3)
self.FBBtn=UIButton.get(self,4)
self.jrttBtn=UIButton.get(self,5)
self.LineBtn=UIButton.get(self,6)
self.mask=UIButton.get(self,7)
self.pyqBtn=UIButton.get(self,8)
self.qqBtn=UIButton.get(self,9)
self.saveButton=UIButton.get(self,10)
self.shareRoot=UIObject.get(self,11)
self.showInfoToggle=UIToggleButton.get(self,12)
self.uiRoot=UIObject.get(self,13)
self.weiboBtn=UIButton.get(self,14)
self.weixinBtn=UIButton.get(self,15)

self.changeBgBtn:setButtonClick(function()self:onChangeBgBtn()end)

self.DdBtn:setButtonClick(function()self:onDdBtn()end)

self.douyinBtn:setButtonClick(function()self:onDouyinBtn()end)

self.FBBtn:setButtonClick(function()self:onFBBtn()end)

self.jrttBtn:setButtonClick(function()self:onJrttBtn()end)

self.LineBtn:setButtonClick(function()self:onLineBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.pyqBtn:setButtonClick(function()self:onPyqBtn()end)

self.qqBtn:setButtonClick(function()self:onQqBtn()end)

self.saveButton:setButtonClick(function()self:onSaveButton()end)

self.weiboBtn:setButtonClick(function()self:onWeiboBtn()end)

self.weixinBtn:setButtonClick(function()self:onWeixinBtn()end)



end


function UIShareImageFrameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.changeBgBtn);self.changeBgBtn=nil;
self.creator:deleteSelf();self.creator=nil;
_UIObject_release(self.DdBtn);self.DdBtn=nil;
_UIObject_release(self.douyinBtn);self.douyinBtn=nil;
_UIObject_release(self.FBBtn);self.FBBtn=nil;
_UIObject_release(self.jrttBtn);self.jrttBtn=nil;
_UIObject_release(self.LineBtn);self.LineBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.pyqBtn);self.pyqBtn=nil;
_UIObject_release(self.qqBtn);self.qqBtn=nil;
_UIObject_release(self.saveButton);self.saveButton=nil;
_UIObject_release(self.shareRoot);self.shareRoot=nil;
_UIObject_release(self.showInfoToggle);self.showInfoToggle=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.weiboBtn);self.weiboBtn=nil;
_UIObject_release(self.weixinBtn);self.weixinBtn=nil;
end















local _this=nil



function UIShareImageFrameWin:onLoaded(...)
self:bindComponents()
_this=self
self.isToggle=userActorSetting.get('showShareImagePlayerInfo',true)

self.showInfoToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self.creator:setCreatAction(function()self:onPartCreate()end)
end


function UIShareImageFrameWin:__delete()
self:unbindComponents()
_this=nil
end




function UIShareImageFrameWin:onShow(argtable,afterOnloaded)
self.shareCallback=argtable.share
self.closeCallback=argtable.close
self.extraName=argtable.extra
self.extraParam=argtable.param
self.cfgId=argtable.cfgId
self.isShareCloseWin=argtable.isShareCloseWin
if self.cfgId then
self.config=cfgHelper.get(cfg_shareimagebaseconfig_get,self.cfgId)
end

self.extraParam.closeCallback_frame=function()self:onMask()end
self.isInit=false

if self.extraName then
self.extraId=self.creator:createObject(self.extraName,self.uiRoot:getID(),0,self.extraParam)
else
self.isInit=true
end

self:refreshFunctionButton()
self:refreshShareBtn()
end


function UIShareImageFrameWin:onHide()

end




function UIShareImageFrameWin:onMask()
if self.closeCallback then
self.closeCallback()
else
self:closeSelf()
end
end


function UIShareImageFrameWin:onSaveButton()
local callback=function(fileName)

UIManager.info("保存成功")
end
self:takePhoto(callback)
end


function UIShareImageFrameWin:onJrttBtn()
UIManager.info("敬请期待")
end


function UIShareImageFrameWin:onPyqBtn()
self:doShare("WECHAT_MOMENTS","WX")
end


function UIShareImageFrameWin:onQqBtn()
UIManager.info("敬请期待")
end


function UIShareImageFrameWin:onWeiboBtn()
UIManager.info("敬请期待")
end


function UIShareImageFrameWin:onWeixinBtn()
self:doShare("PERSONAL","WX")
end

function UIShareImageFrameWin:onChangeBgBtn()
self:changeBg()
end

function UIShareImageFrameWin:doShare(shareType,platform)
local isShowErrTips,tipsStr=shareImageModel:checkOpenShareImageShowErrTips()
if isShowErrTips then

return UIManager.info(tipsStr)
end

local callback=function(fileName)
pcall(function()
platformSDK:reqShareImage(fileName,shareType,platform)
end)

if self.shareCallback then
self.shareCallback()
end

if self.isShareCloseWin==nil or self.isShareCloseWin then
self:closeSelf()
end
end
self:takePhoto(callback)
end

function UIShareImageFrameWin:onPartCreate()
self.isInit=true
self:refreshChangeBgBtn(self.isHideChangeBtn)
end

function UIShareImageFrameWin:takePhoto(callback)
if not self.isInit then
UIManager.error("点击过快 请稍后再试")
return
end

self.creator:callChildFunc(self.extraId,"takePhoto",callback)
end

function UIShareImageFrameWin:changeBg()
if not self.isInit then
UIManager.error("点击过快 请稍后再试")
return
end
self:clearChangeTimer()
local callback=function()
if not _this then return end
_this.changeTimer=_this:delayDo(0.3,function()
_this.isInit=true
end)
end
self.isInit=false
self.creator:callChildFunc(self.extraId,"changeBg",callback)
end

function UIShareImageFrameWin:clearChangeTimer()
if self.changeTimer then
self:stopTimerByID(self.changeTimer)
self.changeTimer=nil
end
end

function UIShareImageFrameWin:refreshFunctionButton()
local apiValib=api_Available_CroppingTexture()

local isShowShareBtn=shareImageModel:isOpenShareImage()
self.shareRoot:setActive(apiValib and isShowShareBtn)

self.saveButton:setActive(false)

self:freshToggle(self.isToggle,true)
end

function UIShareImageFrameWin:refreshChangeBgBtn(isHide)
local isShowChangeBtn=self.config and self.config.isShowChangeBtn or false
if isShowChangeBtn and isHide then
self.isHideChangeBtn=isHide
isShowChangeBtn=false
end
self.changeBgBtn:setActive(isShowChangeBtn)
end

function UIShareImageFrameWin:refreshShareBtn()
local hideBtnList_lookup={}
local hideBtnCfg=cfgHelper.getdef1(cfg_shareimagebaseconfig,'hideShareBtn')
if hideBtnCfg and next(hideBtnCfg)then
for _,v in ipairs(hideBtnCfg)do
hideBtnList_lookup[v]=true
end
end
local GameVersion_jianti=pfwindowslController:checkIsGameVersion_guofu()

local isShowWeXin=true
if hideBtnList_lookup[1]or(not GameVersion_jianti)then
isShowWeXin=false
end
self.weixinBtn:setActive(isShowWeXin)


local isShowWeBo=true
if hideBtnList_lookup[2]or(not GameVersion_jianti)then
isShowWeBo=false
end
self.weiboBtn:setActive(isShowWeBo)
local isShowdouyin=false
if webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()then
isShowdouyin=true
end
self.douyinBtn:setActive(isShowdouyin)

local isShowQQ=true
if hideBtnList_lookup[3]or(not GameVersion_jianti)then
isShowQQ=false
end
self.qqBtn:setActive(isShowQQ)


local isShowPYQ=true

local pfid=loginModel:getPfid()or 0
local cur_api_level=deviceHelper.getAPILevel()
local isHide=false
if deviceHelper.isRunIOS()and cur_api_level<45 then
isHide=true
end

if webGLHelper:isRunWebGL()then
isHide=true
end
if isHide or hideBtnList_lookup[4]or(not GameVersion_jianti)then
isShowPYQ=false
end
self.pyqBtn:setActive(isShowPYQ)


local isShowJRTT=true
if hideBtnList_lookup[5]or(not GameVersion_jianti)then
isShowJRTT=false
end
self.jrttBtn:setActive(isShowJRTT)


local LineShare=pfwindowslController:checkPFWinState_ByCfg(pfwindowslController.winType.LineShare)
local FBShare=pfwindowslController:checkPFWinState_ByCfg(pfwindowslController.winType.FBShare)
local DdShare=pfwindowslController:checkPFWinState_ByCfg(pfwindowslController.winType.DdShare)
self.LineBtn:setActive(LineShare)
self.FBBtn:setActive(FBShare)
self.DdBtn:setActive(DdShare)
end

function UIShareImageFrameWin:freshToggle(isToggle,isInit)
local isOpen=shareImageModel:isOpenShareImage()
local isShowToggle=self.config and self.config.isShowInfoToggle or false
local isShow=isOpen and isToggle
if isInit then
self.creator:callChildFunc(self.extraId,"initPlayerInfoShow",isShow)
else
self.creator:callChildFunc(self.extraId,"changePlayerInfoShow",isShow)
end
self.showInfoToggle:setToggle(isToggle)
self.showInfoToggle:setActive(isOpen and isShowToggle)
end

function UIShareImageFrameWin:onToggleChanged(name,isToggle,data)
if self.isToggle==isToggle then return end
self.isToggle=isToggle
userActorSetting.flushVal('showShareImagePlayerInfo',isToggle)

self:freshToggle(isToggle)
end

function UIShareImageFrameWin:refreshInvitationCode()
self.creator:callChildFunc(self.extraId,"refreshInvitationCode")
end


function UIShareImageFrameWin:onLineBtn()
self:doShare("PERSONAL","line")
end


function UIShareImageFrameWin:onFBBtn()
self:doShare("PERSONAL","fb")
end


function UIShareImageFrameWin:onDdBtn()
self:doShare("PERSONAL","Discord")
end


function UIShareImageFrameWin:onDouyinBtn()
self:doShare("PERSONAL","douyin")
end
