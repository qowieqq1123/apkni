local _upload=CS.ResourceHelper.HttpGetRequest





function loginControl:reportLogin(createInfo)
if pfwindowslController:checkIsGameVersion_HWFT()then
if not createInfo.name or createInfo.name==''then
createInfo.name="無"
end
elseif pfwindowslController:checkIsGameVersion_oumei()then
if not createInfo.name or createInfo.name==''or tostring(createInfo.name)==tostring(createInfo.id)then
createInfo.name='Master'
end
else
if not createInfo.name or createInfo.name==''then return end
end
local info=platformHelper.convertCreateInfo(createInfo)
platformSDK:reqReport(sdkReportEnum.eLoginReport,info)
end


function loginControl:reportEnterServer(createInfo)
local info=platformHelper.convertCreateInfo(createInfo)
platformSDK:reqReport(sdkReportEnum.eEnterServerReport,info)
end


function loginControl:reportCreateRole(createInfo)
local info=platformHelper.convertCreateInfo(createInfo)
platformSDK:reqReport(sdkReportEnum.eCreateRoleReport,info)
end


function loginControl:reportUpLevel()
platformSDK:reqReport(sdkReportEnum.eLevelUpReport)
end


function loginControl:tutorialFinish()
platformSDK:reqReport(sdkReportEnum.eTutorialFinish)
end


function loginControl:reportLogout()
platformSDK:reqReport(sdkReportEnum.eLogoutReport)
end


function loginControl:reportEnterMainScene()
platformSDK:reqReport(sdkReportEnum.eEnterMainSceneReport)
end


function loginControl:reportOpenServerList()
local info=platformHelper.convertCreateInfo()
platformSDK:reqReport(sdkReportEnum.eOpenServerListReport,info)
end


function loginControl:reportExitGame()
platformSDK:reqReport(sdkReportEnum.eExitGameReport)
end


function loginControl:report_use_info_eregister()
platformSDK:reqReport(sdkReportEnum.eregister)
end



function loginControl.upServerloadLog(logType,value,extra,data)

end


function loginControl.overrideUploadLogFunction()
logPoint.UploadLog=function(logType,exts)

if platformLogPoint then
platformLogPoint.otherPFLogPoint(logType)
end

local isCreateRole=logType==logPoint.logType.createRole_clickCreatRole
local needPoint=logType=='cs_fl'or logType=='css_fl'or isCreateRole

local hasRole=logPoint.hasRole()
if hasRole and not needPoint then
logPoint.printPoint(string.format('打点 %s ！已有角色不上报！',tostring(logType)))
return
end

if deviceHelper.isRunNoneOrEditor()then
logPoint.printPoint(string.format('打点 %s ！NoneOrEditor不上报！',tostring(logType)))
return
end

local logStr=logPoint.GetLogStr(logType,exts)
if logStr==''then
logPoint.printPoint(string.format('打点 %s ！logStr == null不上报！',tostring(logType)))
return
end

local lpURL=logPoint.GetUploadURL()
if lpURL==''then
logPoint.printPoint(string.format('打点 %s ！没有打点地址不上报！',tostring(logType)))
return
end

local url=string.format("%s?%s",lpURL,logStr)
logPoint.printPoint('打点上报:'..url)
_upload(url,function(content,err)
logPoint.printPoint(string.format('打点结果：%s',tostring(content)))
end)
end
end
