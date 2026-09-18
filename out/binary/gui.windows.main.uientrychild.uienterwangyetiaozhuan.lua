







def_class("UIEnterWangYeTiaoZhuan",UICloneObject)





UIEnterWangYeTiaoZhuan.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterWangYeTiaoZhuan.assetName="UIEnterNomalItem"


function UIEnterWangYeTiaoZhuan:bindComponents()

self.icon=UIButton.get(self,0)
self.reddot=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.time=UIText.get(self,3)
self.timeBg=UIObject.get(self,4)
self.qipao=UIObject.get(self,5)
self.qipaoText=UIText.get(self,6)
self.model=UIObject.get(self,7)
self.clickBg=UIButton.get(self,8)
self.extendbg=UIObject.get(self,9)
self.lldhQiPao=UIObject.get(self,10)

self.icon:setButtonClick(function()self:onIcon()end)

self.clickBg:setButtonClick(function()self:onClickBg()end)

end


function UIEnterWangYeTiaoZhuan:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.qipaoText);self.qipaoText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.clickBg);self.clickBg=nil;
_UIObject_release(self.extendbg);self.extendbg=nil;
_UIObject_release(self.lldhQiPao);self.lldhQiPao=nil;
end







local iconname='button_wangyetiaozhuan'

function UIEnterWangYeTiaoZhuan:onLoaded(...)
self:bindComponents()
end

function UIEnterWangYeTiaoZhuan:__delete()
self:unbindComponents()
end

function UIEnterWangYeTiaoZhuan:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable and argtable.info or nil
if not info then
return
end
self.info=info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()

self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)

self.widget:SetChildActive(1,false)

self.widget:SetChildText(2,'')

self.widget:SetChildText(3,'')

self.widget:SetChildActive(4,false)

self:freshReddot()


self.widget:SetChildButtonClick(0,function()self:onClickEnter()end,true)

self.widget:SetChildButtonClick(self.clickBg:getID(),function()self:onClickEnter()end,true)

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end

function UIEnterWangYeTiaoZhuan:onClickEnter()
local webData=houtaiModel:getWangYeTiaoZhuanData()
local url=webData and webData.jump_url
if not url or url==""then
return
end
local logininfo=loginModel:getLoginSDKInfo()
if not logininfo then
platformSDK.printSDK("没有登录参数")
return
end
local info=platformHelper:getPlayerInfo()
url=url..FMT.fmt("?token={0}&role_id={1}&role_name={2}&server_id={3}&server_name={4}",logininfo.token,info.json_roleid,info.json_rolename,info.json_sid,info.json_sname)

pfwindowslController:OpenURL_By_UIWebViewWin(url)

houtaiActivityModel:setWebActivityRead()

self:freshReddot()
end

function UIEnterWangYeTiaoZhuan:onHide()

end



function UIEnterWangYeTiaoZhuan:freshReddot()
if not self.widget then return end
if not self.info then
self.widget:SetChildActive(1,false)
return
end

local getReddotFun=self.info.getReddotFun
local flag=false
if getReddotFun then
flag=getReddotFun()
end
self.widget:SetChildActive(1,flag)
end

function UIEnterWangYeTiaoZhuan:onIcon()

end

function UIEnterWangYeTiaoZhuan:onClickBg()

end