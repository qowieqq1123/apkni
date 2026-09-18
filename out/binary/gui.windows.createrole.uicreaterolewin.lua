







def_class("UICreateRoleWin",UIWindowBase)









function UICreateRoleWin:bindComponents()

self.root=UIObject.get(self,0)
self.back=UIObject.get(self,1)
self.womenSelect=UIObject.get(self,2)
self.menSelect=UIObject.get(self,3)
self.NameField=UIInputField.get(self,4)
self.hwnameTips=UIText.get(self,5)



end


function UICreateRoleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.womenSelect);self.womenSelect=nil;
_UIObject_release(self.menSelect);self.menSelect=nil;
_UIObject_release(self.NameField);self.NameField=nil;
_UIObject_release(self.hwnameTips);self.hwnameTips=nil;
end

















function UICreateRoleWin:onLoaded(...)
self:bindComponents()
local config=cfgHelper.get1(cfg_systemsetconfig_get,1)
local gameVersion=pfwindowslController:getGameVersion()
self.lenLimit=config.name_len[gameVersion]or config.name_len[1]
self.NameField:setInputCharacterLimit(self.lenLimit[2])
self.sexID=UICreateRoleModel:getRandomSex()
local isHWFT=pfwindowslController:checkIsGameVersion_HWFT()
self.hwnameTips:setActive(isHWFT)
end


function UICreateRoleWin:__delete()
self:unbindComponents()
self.randomName=nil
self:killTween()
end




function UICreateRoleWin:onShow(argtable,afterOnloaded)
self.callback=argtable and argtable.callback or nil
self.nextBt=argtable and argtable.nextBt or nil
UICreateRoleController:requreRandomName(self.sexID)

self:updateSex()
self.tween=self.root:setChildCanvasGroupDOFade(1,0.5,function()
self:killTween()
end)
self.tween:SetDelay(0.6)
self.back:setChildUIModelShowTarget(2069,1,{},eAnimationID.common_window_enter,nil)
end


function UICreateRoleWin:OnEnable()

end


function UICreateRoleWin:OnDisable()

end

function UICreateRoleWin:killTween()
if self.tween then
self.tween:Kill(false)
self.tween=nil
end
end



function UICreateRoleWin:updateRandomName(str)
self.randomName=str
self.NameField:setInputFieldValue(str)
end


function UICreateRoleWin:updateSex()
self.menSelect:setActive(self.sexID==1)
self.womenSelect:setActive(self.sexID==0)

local str=self.NameField:getInputFieldValue()
if self.randomName==str then
UICreateRoleController:requreRandomName(self.sexID)
end
end



function UICreateRoleWin:onBackBtnClick()

logPoint.UploadLog(logPoint.logType.reqLoginGame_clickBack)
end

function UICreateRoleWin:onRandomNameBtnClick()
UICreateRoleController:requreRandomName(self.sexID)
end

function UICreateRoleWin:OnEvent(index)
if self.sexID==index then return end
self.sexID=index
self:updateSex()
end

function UICreateRoleWin:onCreateRoleBtnClick()



local name=self.NameField:getInputFieldValue()
if name==''or name==nil then
UIManager.info('角色名不能为空')
return
end
if not pfwindowslController.checkNameLenInvalid(name,self.lenLimit)then
return
end


local sexID=self.sexID




















platformSDK:reqMsgSecCheck(1,name,function(reContent)
if reContent==name then
UICreateRoleController:requireChangeDefaultRoleName(reContent,sexID)
else
UIManager.error('名称含敏感字符')
end
end)


end

function UICreateRoleWin:checkClose()
local nextBt=self.nextBt
local callback=self.callback
self:closeSelf()

if nextBt then
storyAIManager:startStoryBehavior(nextBt)
end

if callback then
callback()
end
end