



local _helper=CS.UIHelper
UIUpdateWindow=simple_class()
local CSGUIWindowLua_SetProgressBarAniWithTwoParams=CS.CSGUIWindowLua.SetProgressBarAniWithTwoParams;
local CSGUIWindowLua_SetProgressBarAniWithThreeParams=CS.CSGUIWindowLua.SetProgressBarAniWithThreeParams;
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString

local CSGUIWindowLua_SetChildText=CS.CSGUIWindowLua.SetChildText;
local CSGUIWindowLua_SetChildSpriteAnimationPrefabIndex=CS.CSGUIWindowLua.SetChildSpriteAnimationPrefabIndex;

local animationList={
9,
10,
11,
}


function UIUpdateWindow:isShowCleanBtn()
if(deviceHelper.isRunMiniGame and deviceHelper.isRunMiniGame())or(deviceHelper.isRunMGNative and deviceHelper.isRunMGNative())then

if not((deviceHelper.isRunHuaWeiMiniGame and deviceHelper.isRunHuaWeiMiniGame())
or(deviceHelper.isRunAlipayMiniGame and deviceHelper.isRunAlipayMiniGame()))then
return true
end
end
return false
end

local abname="updatesystem/ui/sprites_pak.ab"

function UIUpdateWindow:auto_bind()


local hideLoader=_AppConfig_GetBool("verifyHideLoader",false)
if hideLoader then
self:setUpdateGroupState(false)
end

local comstuomImageFrame=_AppConfig_GetString('updateComstuomImageFrame',nil)
if comstuomImageFrame then
self.winid:SetChildCSImageSprite(16,abname,comstuomImageFrame)
end


local comstuomImage=_AppConfig_GetString('updateComstuomImage',nil)
if comstuomImage then
self.winid:SetChildCSImageSprite(15,abname,comstuomImage)
end

local aindex=math.random(1,#animationList)
self:SetChildSpineAnimation(animationList[aindex])
local cameraObj=GameObject.Find('UICamera')
if cameraObj then
self.winid:SetChildShowEffect(12,10159,true)
end

local showCleanBtn=false
if self:isShowCleanBtn()then
showCleanBtn=true
end
self.winid:SetChildActive(14,showCleanBtn)

local PrivacyAgreementState=_AppConfig_GetBool("PrivacyAgreementState",false)

local callback=function(args)
self:set_CSGUIProgressBarAni(args[0],args[1],args[3])
self:set_CSGUIProgressBar2Ani(args[0],args[1],args[3])
self:set_DialogText(args[2])
if not PrivacyAgreementState then
self:set_DialogText3('本公司积极履行《网络游戏行业防沉迷自律公约》')
else
self:set_DialogText3("")
end
end
CS.ResourceHelper.SetLoadingProgressEvent(callback)
end




function UIUpdateWindow:set_DialogText(text)
CSGUIWindowLua_SetChildText(self.winid,0,text)
end




function UIUpdateWindow:set_DialogText3(text)
CSGUIWindowLua_SetChildText(self.winid,13,text)
end




function UIUpdateWindow:set_LogText(text)
CSGUIWindowLua_SetChildText(self.winid,3,text)
end




function UIUpdateWindow:set_LogText2(text)
CSGUIWindowLua_SetChildText(self.winid,2,text)
end





function UIUpdateWindow:set_CSGUIProgressBarAni(curval,maxval)
CSGUIWindowLua_SetProgressBarAniWithThreeParams(self.winid,1,curval,maxval,0.1)
end

function UIUpdateWindow:set_CSGUIProgressBar2Ani(curval,maxval)
CSGUIWindowLua_SetProgressBarAniWithThreeParams(self.winid,8,curval,maxval,0.1)
end

function UIUpdateWindow:set_CSGUIProgressBarAniTime(curval,maxval,time)
CSGUIWindowLua_SetProgressBarAniWithThreeParams(self.winid,1,curval,maxval,time)
end

function UIUpdateWindow:set_CSGUIProgressBar2AniTime(curval,maxval,time)
CSGUIWindowLua_SetProgressBarAniWithThreeParams(self.winid,8,curval,maxval,time)
end




function UIUpdateWindow:set_DialogText2(text)
CSGUIWindowLua_SetChildText(self.winid,4,text)
end




function UIUpdateWindow:set_ProgressValueTxt(text)
CSGUIWindowLua_SetChildText(self.winid,5,text)
end





function UIUpdateWindow:Set_SpriteAnimationPrefabIndex(spid,loop)
CSGUIWindowLua_SetChildSpriteAnimationPrefabIndex(self.winid,7,spid,loop)
end

function UIUpdateWindow:SetChildSpineAnimation(index)
self.winid:SetChildScale(index,Vector3(1,1,1))

end




function UIUpdateWindow:SetVisableDialogText2(isShow)

if self.DialogText2==nil then

self.DialogText2=CS.CSGUIWindowLua.GetCommonComponent(self.winid,4,'RectTransform').transform.parent;
end
self.DialogText2.gameObject:SetActive(isShow);
end


function UIUpdateWindow:__init(...)

end

function UIUpdateWindow:close()
self.winid:Close()
end


function UIUpdateWindow.ChangeBackgroundComponentToUISkinLoader(winLua)




end

local _CSUIManager=CS.UIManager
local _CreateWindow=_CSUIManager.CreateWindow
local _BindWindow=CS.BindWindow
local _UpdateScript_LoadGameObjectFromBundle=CS.ResourceHelper.UpdateScript_LoadGameObjectFromBundle
local _UpdateScript_CreateWindow=CS.ResourceHelper.UpdateScript_CreateWindow
local _helper=CS.UIHelper
local Onewinlua=nil
local Onewindow=nil


function UIUpdateWindow.CreateWindow(finishcallback)
local function onLoadFinish(prefab)
Onewinlua=_UpdateScript_CreateWindow(prefab,11,'updatesystem/ui/uiupdatewindow.ab')
Onewindow=UIUpdateWindow()
Onewindow.winid=Onewinlua
_BindWindow(Onewinlua,Onewindow)
Onewindow:auto_bind()
if finishcallback then
finishcallback(Onewindow)
end


if(deviceHelper.isRunWebGL()or(deviceHelper.isRunDouYinNative and deviceHelper.isRunDouYinNative()))and deviceHelper.getAPILevel()>=67 then
if CS.GameInterface.CloseScreenSlash then
CS.GameInterface.CloseScreenSlash()
end
end
end
_UpdateScript_LoadGameObjectFromBundle('updatesystem/ui/uiupdatewindow.ab','UIUpdateWindow',onLoadFinish)
end

function UIUpdateWindow.HideGameTips()
Onewinlua:GetPrefabTransform(0).gameObject:SetActive(false)
end

function UIUpdateWindow:setUpdateGroupState(flag)

self.winid:SetChildActive(6,flag)
end

function UIUpdateWindow:onCleanBtn()
if self:isShowCleanBtn()then
UIUpdateDialog.ShowDialogBox('提示','确定要清理缓存并重启游戏吗？',function()
_WXInterface.RmdirSync(CS.GamePath.writableAssetBundlePath,true)
_WXInterface.UnlinkSync(CS.GamePath.writablePath..'/version.json')
_WXInterface.RestartMiniProgram(nil,nil,nil)
end)
end
end