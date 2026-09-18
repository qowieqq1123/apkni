







def_class("UIXianGuanTeQuanWin",UIWindowBase)









function UIXianGuanTeQuanWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.cdTime=UIText.get(self,1)
self.chatSettingBtn=UIButton.get(self,2)
self.chatSettingEffect=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.duration=UIText.get(self,5)
self.durationInfo=UIObject.get(self,6)
self.effectDesc=UIText.get(self,7)
self.effectInfo=UIObject.get(self,8)
self.exhaustionFlag=UIObject.get(self,9)
self.goBtn=UIButton.get(self,10)
self.icon=UIImage.get(self,11)
self.jobIcon=UIImage.get(self,12)
self.jobInfo=UIObject.get(self,13)
self.jobName=UIText.get(self,14)
self.lockTips=UIText.get(self,15)
self.residueTimes=UIText.get(self,16)
self.rightPart=UIObject.get(self,17)
self.Root=UIObject.get(self,18)
self.tqName=UIText.get(self,19)
self.tqScrollView=UIScrollView.get(self,20)
self.uiRoot=UIObject.get(self,21)
self.useBtn=UIButton.get(self,22)

self.chatSettingBtn:setButtonClick(function()self:onChatSettingBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.goBtn:setButtonClick(function()self:onGoBtn()end)

self.useBtn:setButtonClick(function()self:onUseBtn()end)



end


function UIXianGuanTeQuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.cdTime);self.cdTime=nil;
_UIObject_release(self.chatSettingBtn);self.chatSettingBtn=nil;
_UIObject_release(self.chatSettingEffect);self.chatSettingEffect=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.duration);self.duration=nil;
_UIObject_release(self.durationInfo);self.durationInfo=nil;
_UIObject_release(self.effectDesc);self.effectDesc=nil;
_UIObject_release(self.effectInfo);self.effectInfo=nil;
_UIObject_release(self.exhaustionFlag);self.exhaustionFlag=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.jobIcon);self.jobIcon=nil;
_UIObject_release(self.jobInfo);self.jobInfo=nil;
_UIObject_release(self.jobName);self.jobName=nil;
_UIObject_release(self.lockTips);self.lockTips=nil;
_UIObject_release(self.residueTimes);self.residueTimes=nil;
_UIObject_release(self.rightPart);self.rightPart=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.tqName);self.tqName=nil;
_UIObject_release(self.tqScrollView);self.tqScrollView=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.useBtn);self.useBtn=nil;
end
















local _this
local _ab=globalABLookup.xianguan
local _xgab="ui/icons/xianguantequan/xianguantequan_atlas_pak.ab"
local _scrollLimitNum=6




function UIXianGuanTeQuanWin:onLoaded(...)
self:bindComponents()

_this=self

local bindWidget=function(index,item)self:bindTqWidget(index,item)end
self.tqScrollView:bindScrollWidget(bindWidget)

self.selectIndex=1

self.oldTime=0

self.changeMenu=false

self:addNotify(notifyConfig.onTeQuanInfoChange,function()
if _this==nil then return end
_this:freshTeQuanOptionChangePart()
end)
end


function UIXianGuanTeQuanWin:__delete()
self:unbindComponents()

_this=nil
end




function UIXianGuanTeQuanWin:onShow(argtable,afterOnloaded)

self.selectIndex=(argtable and argtable.selectIndex)or self.selectIndex

self:refreshAll()

self.bgSpine:setChildUIModelShowTarget(5716,1,nil,eAnimationID.enter)
end


function UIXianGuanTeQuanWin:onHide()

end

function UIXianGuanTeQuanWin:refreshAll()
self.privilegeList=xianguanController.getSelfTotalVoluntaryPrivilegeList()


local temp={}
for index,tqData in ipairs(self.privilegeList)do
if tqData[1]~=XIANGUAN_PRIVILEGE_ENUM.eTqType_19 then
temp[#temp+1]=tqData
end
end

self.privilegeList=temp

local tqLen=#self.privilegeList

local isShow=tqLen>1
self.tqScrollView:setActive(isShow)



if isShow then
self.tqScrollView:freshGridsNum(tqLen,tqLen,1)
end

self:freshTeQuanOptionPanel()
end

function UIXianGuanTeQuanWin:bindTqWidget(index,item)

local tqId=self.privilegeList[index][1]
local tqCfg=cfgHelper.get(cfg_xianguanprivilegeconfig_get,tqId)


local isSelect=index==self.selectIndex


local strlist=string.toTable(tqCfg.name)
table.insert(strlist,3,'\n')
local neme=table.concat(strlist,"")
item:SetChildText(1,neme)

local clickFunc=function(name,isOn)
if _this==nil then return end

_this.changeMenu=true
_this.selectIndex=index
_this:freshTeQuanOptionPanel()
end
item:SetChildToggle(-1,isSelect)
item:SetChildToggleChange(-1,clickFunc)


end

function UIXianGuanTeQuanWin:freshTeQuanOptionPanel()
local tqId=self.privilegeList[self.selectIndex][1]
local jobId=self.privilegeList[self.selectIndex][2]
local tqCfg=cfgHelper.get(cfg_xianguanprivilegeconfig_get,tqId)

local jobCfg=xianguanConfig.getJobConfig(nil,jobId)

local tqIconName=xianguanConfig.getTeQuanIconName(tqCfg.icon)

self.icon:setCSImageSprite(_xgab,tqIconName)

self.tqName:setText(tqCfg.name)

local jobIconName=xianguanConfig.getJobIconName(jobCfg.jobIcon)
self.jobIcon:setCSImageSprite(_ab,jobIconName)

self.jobName:setText(jobCfg.name)

local effectDurationStr=xianguanConfig.getTeQuanEffectDurationStr(tqId)
self.duration:setText(effectDurationStr)

local effectDesc=tqCfg.descEx
self.effectDesc:setText(effectDesc)

self:freshTeQuanOptionChangePart()
end

function UIXianGuanTeQuanWin:freshTeQuanOptionChangePart()
local tqId=self.privilegeList[self.selectIndex][1]
local jobId=self.privilegeList[self.selectIndex][2]

local state=xianguanModel:callTeQuanObjFunc(jobId,tqId,"getState")
local maxUseNum=xianguanConfig.getTeQuanCfg(tqId,"times")

local isInCD=xianguanModel:callTeQuanObjFunc(jobId,tqId,'checkInCd')
local noUseTimes=xianguanModel:callTeQuanObjFunc(jobId,tqId,'checkUseTimes')

local isShowUseTimes=state==XianGuanUseConditionEnum.eNormal and maxUseNum~=nil
local isShowCD=isInCD or noUseTimes
local isShowUseBtn=state==XianGuanUseConditionEnum.eNormal or state==XianGuanUseConditionEnum.eUseCD
local isShowGoBtn=state==XianGuanUseConditionEnum.eWait

local isLock=state>0

self.residueTimes:setActive(isShowUseTimes)
self.cdTime:setActive(isShowCD)
self.useBtn:setActive(isShowUseBtn)
self.exhaustionFlag:setActive(state==XianGuanUseConditionEnum.eUseTimes)
self.lockTips:setActive(isLock)
self.goBtn:setActive(isShowGoBtn)

self.useBtn:setGray(isShowCD)

if isShowUseTimes then
local usedTimes=xianguanModel:callTeQuanObjFunc(jobId,tqId,"getTimes")or 0

local residueTimes=maxUseNum-usedTimes

local isCanUse=residueTimes>0

local color=isCanUse and"#549327"or"#c82c2c"
local timesStr=FMT.fmt("剩余次数：{0}",toColorStringX(color,FMT.fmt("{0}/{1}",residueTimes,maxUseNum)))
self.residueTimes:setText(timesStr)
end

if isShowCD then
local timeState
if noUseTimes then
timeState=XianGuanUseConditionEnum.eUseTimes
elseif isInCD then
timeState=XianGuanUseConditionEnum.eUseCD
end
self:startCDTimer(timeState)
end

if isLock then
local lockTips=xianguanHelper.getConditionWarningDesc(state,jobId,tqId)
self.lockTips:setText(lockTips)
end

self.changeMenu=false
end


function UIXianGuanTeQuanWin:startCDTimer(state)
local tqId=self.privilegeList[self.selectIndex][1]
local jobId=self.privilegeList[self.selectIndex][2]

if(not self.changeMenu)and timeHelper.getServerShortTime()-self.oldTime<1 then
loggerUtil.logErrFMT("进入死循环，请检查特权状态是否正确. 状态,特权：{0},{1}",state,tqId)
return
end

self:stopCDTimer()

local cd,curTime,callback,dval

dval=0
curTime=timeHelper.getServerShortTime()

if state==XianGuanUseConditionEnum.eUseCD then
cd=xianguanModel:callTeQuanObjFunc(jobId,tqId,"getCd")

callback=function()
curTime=timeHelper.getServerShortTime()
dval=cd-curTime

if dval>0 then
_this.cdTime:setText(string.format("<color=#f36666>%s</color>后可使用",timeHelper.format_time_stamp4(dval)))
else
_this:stopCDTimer()
_this:freshTeQuanOptionChangePart()
end
end
elseif state==XianGuanUseConditionEnum.eUseTimes then
cd=xianguanConfig.getResetCD(tqId)+curTime

callback=function()
curTime=timeHelper.getServerShortTime()
dval=cd-curTime

if dval>0 then
_this.cdTime:setText(string.format("<color=#f36666>%s</color>后重置次数",timeHelper.format_time_stamp4(dval)))
else
_this:stopCDTimer()
_this:freshTeQuanOptionChangePart()
end
end
end

self.cdTimer=self:setTimer(0.01,0,callback)
callback()

self.oldTime=timeHelper.getServerShortTime()
end

function UIXianGuanTeQuanWin:stopCDTimer()
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end





function UIXianGuanTeQuanWin:onChatSettingBtn()
self.chatSettingEffect:setChildShowEffect(22639,true)

self:delayDo(0.4,function()
self:showWindow('UIChatMesgFilterWin')
end)
end



function UIXianGuanTeQuanWin:onUseBtn()
local tqInfo=self.privilegeList[self.selectIndex]

local isCanUse,stateId=xianguanHelper.checkTeQuanUseCondition(tqInfo[2],tqInfo[1],true)

if isCanUse then
local callback=function()
if UIManager:isActive("UIXianGuanTeQuanWin")then
UIManager:closeWindow("UIXianGuanTeQuanWin")
end
end
xianguanModel:callTeQuanObjFunc(tqInfo[2],tqInfo[1],'onClickUseBtn',callback)
end
end

function UIXianGuanTeQuanWin:onCloseBtn()
self:closeSelf()
end

function UIXianGuanTeQuanWin:onBack()
self:onCloseBtn()
end

function UIXianGuanTeQuanWin:onGoBtn()
local tqInfo=self.privilegeList[self.selectIndex]

local callback=function()
if UIManager:isActive("UIXianGuanTeQuanWin")then
UIManager:closeWindow("UIXianGuanTeQuanWin")
end
end
xianguanModel:callTeQuanObjFunc(tqInfo[2],tqInfo[1],'jumpUseWin',callback)
end


