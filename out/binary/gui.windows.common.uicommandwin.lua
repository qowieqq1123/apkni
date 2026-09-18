







def_class("UICommandWin",UIWindowBase)









function UICommandWin:bindComponents()

self.btn1=UIButton.get(self,0)
self.btnCall=UIButton.get(self,1)
self.btnClose=UIButton.get(self,2)
self.btnsRoot=UIObject.get(self,3)
self.btnTouch=UIButton.get(self,4)
self.Checkmark1=UIObject.get(self,5)
self.Checkmark2=UIObject.get(self,6)
self.Checkmark3=UIObject.get(self,7)
self.Checkmark4=UIObject.get(self,8)
self.Checkmark5=UIObject.get(self,9)
self.Checkmark6=UIObject.get(self,10)
self.Checkmark7=UIObject.get(self,11)
self.Checkmark8=UIObject.get(self,12)
self.Checkmark9=UIObject.get(self,13)
self.InputField1=UIInputField.get(self,14)
self.InputField2=UIInputField.get(self,15)
self.root=UIObject.get(self,16)
self.Toggle1=UIToggleButton.get(self,17)
self.Toggle2=UIToggleButton.get(self,18)
self.Toggle3=UIToggleButton.get(self,19)
self.Toggle4=UIToggleButton.get(self,20)
self.Toggle5=UIToggleButton.get(self,21)
self.Toggle6=UIToggleButton.get(self,22)
self.Toggle7=UIToggleButton.get(self,23)
self.Toggle8=UIToggleButton.get(self,24)
self.Toggle9=UIToggleButton.get(self,25)
self.toggleRoot=UIObject.get(self,26)
self.touchClose=UIObject.get(self,27)
self.touchOpen=UIObject.get(self,28)
self.txtBtn1=UIText.get(self,29)

self.btn1:setButtonClick(function()self:onBtn1()end)

self.btnCall:setButtonClick(function()self:onBtnCall()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnTouch:setButtonClick(function()self:onBtnTouch()end)



end


function UICommandWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btn1);self.btn1=nil;
_UIObject_release(self.btnCall);self.btnCall=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnsRoot);self.btnsRoot=nil;
_UIObject_release(self.btnTouch);self.btnTouch=nil;
_UIObject_release(self.Checkmark1);self.Checkmark1=nil;
_UIObject_release(self.Checkmark2);self.Checkmark2=nil;
_UIObject_release(self.Checkmark3);self.Checkmark3=nil;
_UIObject_release(self.Checkmark4);self.Checkmark4=nil;
_UIObject_release(self.Checkmark5);self.Checkmark5=nil;
_UIObject_release(self.Checkmark6);self.Checkmark6=nil;
_UIObject_release(self.Checkmark7);self.Checkmark7=nil;
_UIObject_release(self.Checkmark8);self.Checkmark8=nil;
_UIObject_release(self.Checkmark9);self.Checkmark9=nil;
_UIObject_release(self.InputField1);self.InputField1=nil;
_UIObject_release(self.InputField2);self.InputField2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.Toggle1);self.Toggle1=nil;
_UIObject_release(self.Toggle2);self.Toggle2=nil;
_UIObject_release(self.Toggle3);self.Toggle3=nil;
_UIObject_release(self.Toggle4);self.Toggle4=nil;
_UIObject_release(self.Toggle5);self.Toggle5=nil;
_UIObject_release(self.Toggle6);self.Toggle6=nil;
_UIObject_release(self.Toggle7);self.Toggle7=nil;
_UIObject_release(self.Toggle8);self.Toggle8=nil;
_UIObject_release(self.Toggle9);self.Toggle9=nil;
_UIObject_release(self.toggleRoot);self.toggleRoot=nil;
_UIObject_release(self.touchClose);self.touchClose=nil;
_UIObject_release(self.touchOpen);self.touchOpen=nil;
_UIObject_release(self.txtBtn1);self.txtBtn1=nil;
end

















local _toggleType=
{
eVersion=1,
eCall=2,
eConfig=3,
eLogin=4,
eAPI=5,
eClearVersion=6,
eRequireFile=7,
eSetPFId=8,
eClearConfig=9,
}


function UICommandWin:onLoaded(...)
self:bindComponents()
self.visUI=true
self.open=true
self.toggleType=_toggleType.eCall

for _,v in pairs(_toggleType)do
local str=FMT.fmt('Toggle{0}',v)
self.winlua:SetChildToggleChange(self[str]:getID(),function()
self:onToggle(v)
end)
end
self.toggleRoot:setActive(false)
self.btnsRoot:setActive(false)
self:freshToggle()
self:freshStatus()
self.txtBtn1:setText(self.visUI and'隐藏UI'or'显示UI')
self.SceneUIContain=GameObject.Find('SceneUIContain')
self.BottomUIContain=GameObject.Find('BottomUIContain')
self.WindowUIContain=GameObject.Find('WindowUIContain')
self.DialogUIContain=GameObject.Find('DialogUIContain')
self.ModelTipOnUITopContain=GameObject.Find('ModelTipOnUITopContain')
self.SystemTipContain=GameObject.Find('SystemTipContain')
end

function UICommandWin:__delete()
self:unbindComponents()
end

function UICommandWin:onShow(argtable,afterOnloaded)

end

function UICommandWin:onHide()

end
local _GetResourceVersion=CS.AppDataModel.GetResourceVersion
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool


function UICommandWin:freshToggle()
for _,v in pairs(_toggleType)do
local str=FMT.fmt('Checkmark{0}',v)
local isToggle=self.toggleType==v
self[str]:setActive(isToggle)
end
end

function UICommandWin:onToggle(i)

if self.toggleType==i then return end
self.toggleType=i
self:freshToggle()
self.InputField2:setActive(self.toggleType==_toggleType.eLogin)
end

function UICommandWin:freshStatus()
self.root:setActive(self.open)

self.touchOpen:setActive(not self.open)
self.touchClose:setActive(self.open)
end



function UICommandWin:onBtnTouch()
self.open=not self.open
self:freshStatus()
end


function UICommandWin:onBtn1()
self.visUI=not self.visUI
mainControl:setMainWin(self.visUI)
self.txtBtn1:setText(self.visUI and'隐藏UI'or'显示UI')

self.BottomUIContain:SetActive(self.visUI)
self.WindowUIContain:SetActive(self.visUI)
self.DialogUIContain:SetActive(self.visUI)
self.ModelTipOnUITopContain:SetActive(self.visUI)
self.SystemTipContain:SetActive(self.visUI)
end

function UICommandWin:onBtnCall()
local inputStr=self.InputField1:getInputFieldValue()
if self.toggleType==_toggleType.eCall then
if inputStr==nil or inputStr==''then
UIManager.error('请输入内容')
return
elseif inputStr=='open'then
self.toggleRoot:setActive(true)
self.btnsRoot:setActive(true)
self.InputField1:setInputFieldValue('')
elseif inputStr=='func'then
self.toggleRoot:setActive(true)
elseif inputStr=='btn'then
self.btnsRoot:setActive(true)
else








end
elseif self.toggleType==_toggleType.eVersion then
if inputStr==nil or inputStr==''then
UIManager.error('请输入内容')
return
end
local target=tonumber(inputStr)
if target~=nil then
local version=_GetResourceVersion()
if target>version then
injectAppConfig.verifyAppConfigVersion(target)
else
UIManager.error('输入的版本比当前版本低')
end
end
elseif self.toggleType==_toggleType.eConfig then
local cfgVersion=0
if inputStr and inputStr~=''then
local version=tonumber(inputStr)
if version then
cfgVersion=version
end
end
injectAppConfig.createLogAppConfig(false,cfgVersion)
elseif self.toggleType==_toggleType.eLogin then
local inputStr2=self.InputField2:getInputFieldValue()
self:gmlogin(inputStr,inputStr2)
elseif self.toggleType==_toggleType.eAPI then
if inputStr==nil or inputStr==''then
UIManager.error('请输入内容')
return
end
appUtils.setAPILevel(tonumber(inputStr))
elseif self.toggleType==_toggleType.eClearVersion then
injectAppConfig.clearAppConfigTestURL()
elseif self.toggleType==_toggleType.eRequireFile then
local filename=FMT.fmt("{0}/inject.lua",CS.GamePath.writablePath)
local file,err=loadfile(filename)
if file then
local success,result=pcall(file)
if not success then
UIManager.error(FMT.fmt('执行错误：{0}',result))
end
end
elseif self.toggleType==_toggleType.eSetPFId then
injectAppConfig.verifyGameId(tonumber(inputStr))
elseif self.toggleType==_toggleType.eClearConfig then
UIManager.info('已关闭打印功能')
injectAppConfig.createEmptyConfig()
else
UIManager.error('请选择指令类型')
end
end

function UICommandWin:checkClose()
if not self.open then
self:closeSelf()
end
end

function UICommandWin:gmlogin(account,password)
if account==nil or account==''then
UIManager.error('账号不能为空')
return
end
if password==nil or password==''then
UIManager.error('密码不能为空')
return
end
if deviceHelper.isRunNoneOrEditor()then
UIManager.error('该状态无gm登录')
return
end


if not UIManager:findActiveWindow('UILogin')then
UIManager.error('请先退出到登录界面')
return
end

local function httpCallBack(message,err)
platformSDK.printSDK('请求php登录返回数据:',message,err)
if err==""or not err then


local json_table={}
if type(message)=='table'then
json_table=message
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)

if not s then
UIManager.info('请求登录失败')
return
end
end

if(webGLHelper:isRunWebGL()or webGLHelper:checkNetProtocolType(1))and not verifyManager:isOpen()then
local wss_host=json_table.wss_host
local wss_port=json_table.wss_port
if wss_host and wss_host~=''and wss_port and wss_port~=''then
json_table.srvaddr=wss_host
json_table.srvport=wss_port
else

end
end


local ip=json_table.srvaddr
local serverPort=json_table.srvport
local isNew=json_table.isnew
local srvtime=tonumber(json_table.srvtime)or-1


loginModel:setLoginInfo(json_table)


platformSDK.printSDK('开始连接服务器 ip=%s,serverPort=%s',tostring(ip),tostring(serverPort))
loginControl:connect_server(ip,tonumber(serverPort))
else


UIManager.info("请求登录失败")
end
end




local param=FMT.fmt('?account={0}&pwd={1}',account,password)

local url=gameInfo:getGMLoginURL()
local urlStr=url..param

_httpGetRequest(urlStr,httpCallBack)

platformSDK.printSDK(string.format('请求php登录:%s',urlStr))
end

function UICommandWin:onBtnClose()
self:closeSelf()
end
