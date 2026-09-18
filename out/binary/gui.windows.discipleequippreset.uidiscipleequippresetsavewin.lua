







def_class("UIDiscipleEquipPresetSaveWin",UIWindowBase)









function UIDiscipleEquipPresetSaveWin:bindComponents()

self.inputDefaultTxt=UIText.get(self,0)
self.inputField=UIInputField.get(self,1)
self.newBtn=UIButton.get(self,2)
self.newBtnSelected=UIObject.get(self,3)
self.overwriteBtn=UIButton.get(self,4)
self.overwriteBtnSelected=UIObject.get(self,5)
self.presetDropdown=UIDropdownEx.get(self,6)
self.titleText=UIText.get(self,7)

self.newBtn:setButtonClick(function()self:onNewBtn()end)

self.overwriteBtn:setButtonClick(function()self:onOverwriteBtn()end)



end


function UIDiscipleEquipPresetSaveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.inputDefaultTxt);self.inputDefaultTxt=nil;
_UIObject_release(self.inputField);self.inputField=nil;
_UIObject_release(self.newBtn);self.newBtn=nil;
_UIObject_release(self.newBtnSelected);self.newBtnSelected=nil;
_UIObject_release(self.overwriteBtn);self.overwriteBtn=nil;
_UIObject_release(self.overwriteBtnSelected);self.overwriteBtnSelected=nil;
_UIObject_release(self.presetDropdown);self.presetDropdown=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end


















local pageType={
eNew=1,
eOverwrite=2,
}
local _this

function UIDiscipleEquipPresetSaveWin:onLoaded(...)
self:bindComponents()
_this=self
local gameVersion=pfwindowslController:getGameVersion()
self.lenLimit=UISettingModel:getcommonname_len()
self.is_Chinese=false
self.presetDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIDiscipleEquipPresetSaveWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleEquipPresetSaveWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable
local presetNum=discipleEquipPresetController:getDiscipleEquipPresetNum(self.disciple_guid)
local totalEquipPresetNum=discipleEquipPresetController:getTotalEquipPresetNum()
local disciplePresetMax,totalPresetMax=discipleEquipPresetController:getEquipPresetMaxNum()
self.pageType=pageType.eNew
if presetNum<=0 then
self.overwriteBtn:setChildImageExGray(true)
elseif presetNum>=disciplePresetMax or totalEquipPresetNum>=totalPresetMax then
self.pageType=pageType.eOverwrite
self.newBtn:setChildImageExGray(true)
end
self.inputField:setInputFieldValue(string.format("配装方案%s",mathHelper.numberToChinese(presetNum+1)))
self.inputField:setInputCharacterLimit(self.lenLimit[2])
self:refreshBtnPage()
self:setDropdowns()
end

function UIDiscipleEquipPresetSaveWin:refreshBtnPage()
if self.pageType==pageType.eNew then
self.inputField:setActive(true)
self.presetDropdown:setActive(false)
self.newBtnSelected:setActive(true)
self.overwriteBtnSelected:setActive(false)
else
self.inputField:setActive(false)
self.presetDropdown:setActive(true)
self.newBtnSelected:setActive(false)
self.overwriteBtnSelected:setActive(true)
end
end

function UIDiscipleEquipPresetSaveWin:onSureBtn()
if self.pageType==pageType.eNew then

AudioManager.playBtnClick()
local changeName=self.inputField:getInputFieldValue()
if changeName==nil or changeName==''then
UIManager.error('名称不能为空')
return
end
if discipleEquipPresetController:checkPresetNameExisted(self.disciple_guid,changeName)then
UIManager.error('已有同名的配装方案')
return
end
local isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
if isGuoFu then
if self.is_Chinese==true then
if not helper.string_is_ChineseS(changeName)then
UIManager.error('请输入中文名称')
return
end
end

if helper.check_spec_chars(changeName)then
UIManager.error('名称中含有特殊字符')
return
end
end
if not pfwindowslController.checkNameLenInvalid(changeName,self.lenLimit)then
return
end

local func=function(...)
if _this==nil then return end
_this:onCheckStringLegal(...)
end
chatProtocolControl.sendCheckLegalStr(changeName,func)
else
local show_data={
type='UIDialouge',
title='提示',
content="是否将弟子现在配装覆盖选中的配装方案？",
oktext='确定',
canceltext='取消',
okcallback=function()
discipleEquipPresetController:saveDiscipleEquipPreset(self.disciple_guid,self.presetIdx+1)
self:closeSelf()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
end

function UIDiscipleEquipPresetSaveWin:onCheckStringLegal(str,legalStr)
local func=function(str)
if legalStr~=str then
UIManager.error('名称中含有敏感字符')
return
end
discipleEquipPresetController:saveDiscipleEquipPreset(self.disciple_guid,nil,legalStr)
self:closeSelf()
end
platformSDK:reqMsgSecCheck(1,str,function(reContent)
if reContent==str then
func(reContent)
else
UIManager.error('名称中含有敏感字符')
end
end)
end


function UIDiscipleEquipPresetSaveWin:setDropdowns()
local presetDataList=discipleEquipPresetController:getDiscipleEquipPreset(self.disciple_guid)or{}
local suitDescList={}
for i,v in ipairs(presetDataList)do
table.insert(suitDescList,v.presetName)
end
self.presetDropdown:setOption(suitDescList)

self.presetIdx=0

self.presetDropdown:setValue(self.presetIdx)
end


function UIDiscipleEquipPresetSaveWin:onDropdownChange(idx)

if self.presetIdx~=idx then
self.presetIdx=idx
end
end


function UIDiscipleEquipPresetSaveWin:onNewBtn()
local presetNum=discipleEquipPresetController:getDiscipleEquipPresetNum(self.disciple_guid)
local totalEquipPresetNum=discipleEquipPresetController:getTotalEquipPresetNum()
local disciplePresetMax,totalPresetMax=discipleEquipPresetController:getEquipPresetMaxNum()
if presetNum>=disciplePresetMax then
UIManager.error("本弟子配装方案已达到上限")
return
end
if totalEquipPresetNum>=totalPresetMax then
UIManager.error("宗门总配装方案已达到上限")
return
end
self.pageType=pageType.eNew
self:refreshBtnPage()
end

function UIDiscipleEquipPresetSaveWin:onOverwriteBtn()
local presetNum=discipleEquipPresetController:getDiscipleEquipPresetNum(self.disciple_guid)
if presetNum<=0 then
UIManager.error("弟子暂未保存配装方案")
return
end
self.pageType=pageType.eOverwrite
self:refreshBtnPage()
end
