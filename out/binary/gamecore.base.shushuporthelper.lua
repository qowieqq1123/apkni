





shushuReportHelper=gameState.addListener({})

local _httpJsonPostRequest=CS.ResourceHelper.HttpJsonPostRequest

local cjson=require'cjson'

function shushuReportHelper.encodeURI(s)
s=string.gsub(s,"([^%w%.%- ])",function(c)return string.format("%%%02X",string.byte(c))end)
return string.gsub(s," ","+")
end

local app_id="2bcdfd8c33784e6fb6a03488f99f24e8"
local url="https://ta-receiver.xingjiagames.com/sync_json"


shushuReportType=
{
user_setOnce="user_setOnce",
}

shushuReportEventName=
{
zqzs_device_active="zqzs_device_active",
zqzs_openid_register="zqzs_openid_register",
zqzs_openid_login="zqzs_openid_login",
zqzs_pay_trigger="zqzs_pay_trigger",
zqzs_pay_fail="zqzs_pay_fail",
}


function shushuReportHelper:onAppStart()
notifySystem:listenNotify(notifyConfig.initPro,self.onInitPro)
end



function shushuReportHelper.onInitPro()









end


function shushuReportHelper.Report_byType(Type)
































end


function shushuReportHelper.Report_byEventName(eventname,args)































end


function shushuReportHelper.enterGame()

end

function shushuReportHelper.ReportCB(content,err)
if err then
platformSDK.printSDK("reqmaskfontCB,cd,err,",content,err)
return
end
local s,data=xpcall(function()
cjson.decode(content)
end,function(err)
logErr(err)
end)
if data then
platformSDK.printSDK("reqmaskfontCB1,cd,",data.code)
end
end






function shushuReportHelper.Report_byEventName_sync_data(eventname,args)
local requestHeader={
"Content-Type",
"application/json;charset=utf-8",
}
local data=""
local body=string.format("appid=%s&data=%s",app_id,data)

local testurl="https://ta-receiver.xingjiagames.com/sync_data"
_httpJsonPostRequest(testurl,requestHeader,body,shushuReportHelper.ReportCB)
platformSDK.printSDK("Report_byEventNameb2,",eventname,body)
end