







def_class("UIHuiGuiBangDingWin",UIWindowBase)









function UIHuiGuiBangDingWin:bindComponents()

self.inputCodePanel=UIObject.get(self,0)
self.codeInputField=UIInputField.get(self,1)
self.bindingBtn=UIButton.get(self,2)
self.bindingFlag=UIObject.get(self,3)
self.bindingRewards=UIObject.get(self,4)
self.tipsText=UIText.get(self,5)
self.freeRewardBtn=UIButton.get(self,6)
self.inputText=UIText.get(self,7)
self.bgModel=UIObject.get(self,8)
self.Placeholder=UIText.get(self,9)

self.bindingBtn:setButtonClick(function()self:onBindingBtn()end)

self.freeRewardBtn:setButtonClick(function()self:onFreeRewardBtn()end)



end


function UIHuiGuiBangDingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.inputCodePanel);self.inputCodePanel=nil;
_UIObject_release(self.codeInputField);self.codeInputField=nil;
_UIObject_release(self.bindingBtn);self.bindingBtn=nil;
_UIObject_release(self.bindingFlag);self.bindingFlag=nil;
_UIObject_release(self.bindingRewards);self.bindingRewards=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.freeRewardBtn);self.freeRewardBtn=nil;
_UIObject_release(self.inputText);self.inputText=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
end


















function UIHuiGuiBangDingWin:onLoaded(...)
self:bindComponents()
self.codeInputField:setChildInputFieldChange(true,function(...)self:onInputFieldChange(...)end)
end


function UIHuiGuiBangDingWin:__delete()
self:unbindComponents()
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
end
self.leftTimer=nil
end




function UIHuiGuiBangDingWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5346,1,{},eAnimationID.stand)
end
self:onShowArgRecv()
end


function UIHuiGuiBangDingWin:onHide()

end

function UIHuiGuiBangDingWin:onShowArgRecv()
if not self.leftTimer then
self.leftTimer=self:setTimer(10,0,function()self:refreshLeftTime()end)
end
self:refreshLeftTime()
self:refreshInputCodePanel()
self:refreshFreeReward()
end

function UIHuiGuiBangDingWin:refreshLeftTime()
local zhm_const_def=cfg_zhaohuimaconfig().const_def
local sTime,eTime=zhm_const_def.opentime[1],zhm_const_def.opentime[2]
local eTimeStamp=timeHelper.getDateStamp(eTime)
local nowTime=timeHelper.getServerLongTime()
local leftTime=timeHelper.format_time_stamp15(eTimeStamp-nowTime)
self.tipsText:setText(FMT.fmt("活动剩余时间：{0}",leftTime))
end


function UIHuiGuiBangDingWin:refreshFreeReward()

local isCanGet=welfareModel:checkHuiGuiBangDingFreeRewardCanGet()
self.freeRewardBtn:setActive(isCanGet)
end

function UIHuiGuiBangDingWin:refreshInputCodePanel()

local nowBindingCode=welfareModel:getBindReturnCode()
self.isBinding=nowBindingCode~=nil and not mathHelper.compareInt64(nowBindingCode,int64.new('0'))







local zhm_const_def=cfg_zhaohuimaconfig().const_def
if self.isBinding then

local nowBindingCodeStr=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(nowBindingCode),INVITATION_CODE_MIN_POS_COUNT,zhm_const_def.turnStr)
self.codeInputField:setInputFieldValue(nowBindingCodeStr)
end

local inputField=self.codeInputField:getCommonComponent('InputField')
inputField.interactable=not self.isBinding

self.bindingBtn:setActive(not self.isBinding)
self.bindingFlag:setActive(self.isBinding)


local bind_reward=zhm_const_def.bind_reward
local openDay=timeHelper.getServerOpenDay()
local idx=table.getValueUpIdx(bind_reward,openDay)
local rewards=bind_reward[idx][2]
self.bindingRewards:setChildLayoutGroupCreateItems(#rewards)
local grids=self.bindingRewards:getChildLayoutGroupGridList()
for i=1,#rewards do
local widget=grids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


local isGot=self.isBinding
local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


widget:SetChildActive(1,isGot)
end
end

function UIHuiGuiBangDingWin:onBindingBtn()
local codeStr=self.codeInputField:getInputFieldValue()
if not codeStr or codeStr==""then
return UIManager.error("请先输入回归码")
end
local zhm_const_def=cfg_zhaohuimaconfig().const_def
local codeNum=mathHelper.convert35SystemToDecimal(codeStr,zhm_const_def.turnStr)
local codeNum_int_64=mathHelper.number_to_int64(codeNum)

welfareController:reqReturnCodeBind(codeNum_int_64)
end

function UIHuiGuiBangDingWin:onCopyBtn()
if not self.myInvitationCodeStr then
return
end
if deviceHelper.isRunIOS()then
if api_Available_SetSystemCopyBuffer()then
CS.GameInterface.SetSystemCopyBuffer(self.myInvitationCodeStr)
end
else
local result=platformHelper.copyTextToClipboard(self.myInvitationCodeStr)
if result then
UIManager.info("复制成功")
else
UIManager.error("复制失败")
end
end
end

function UIHuiGuiBangDingWin:onFreeRewardBtn()

welfareController:reqGetHuiGuiBangDingFreeReward()
end

function UIHuiGuiBangDingWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIHuiGuiBangDingWin:onInputFieldChange(str)
if self:isAlphanumeric(str)then
local upperStr=string.upper(str)
self.codeInputField:setInputFieldValue(upperStr)
else
self.codeInputField:setInputFieldValue("")
end
end

function UIHuiGuiBangDingWin:onClickInput()
self.Placeholder:setActive(false)
end


function UIHuiGuiBangDingWin:onExitInput()
local str=self.codeInputField:getInputFieldValue()
if not str or str==''then
self.Placeholder:setActive(true)
end
end

function UIHuiGuiBangDingWin:isAlphanumeric(str)
return not string.match(str,"[^%w]")
end