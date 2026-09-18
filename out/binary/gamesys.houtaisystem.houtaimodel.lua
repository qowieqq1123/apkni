






local _MODULENAME="houtaiModel"


def_table(_MODULENAME)
houtaiModel.name=_MODULENAME

local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;


function houtaiModel:onAppStart()
self.phpData={}
self.serverData={}
self.info={}
self.SheQuActTypeArr={}
end


function houtaiModel:onEnterState(isReconnect)
self.serverData={}
self.phpData2={}
self.info2={}
end


function houtaiModel:onProtocolReq()

end


function houtaiModel:onLeaveState(isReconnect)
self.serverData={}
self.phpData2={}
self.info2={}
end




local _freshServerDataFunc=
{
[HOUTAI_TYPE.eChatLimit]=function(htType)
local sdata=houtaiModel:getServerData(htType)
if sdata==nil then
houtaiModel:setData(htType,{})
return
end
local data={}
for channelIdStr,v in pairs(sdata)do
local channel=tonumber(channelIdStr)
local info={}
info.level=tonumber(v.level)
info.recharge=tonumber(v.recharge)
info.fightvalue=tonumber(v.fightvalue or 0)
data[channel]=info
end
houtaiModel:setData(htType,data)
end,
}

local _freshPHPDataFunc=
{






















































[HOUTAI_TYPE.eSheQuEnter]=function(htType)
local isOpen=houtaiModel:getPHPInfoStr(htType,'is_open')=='1'
local jumpURL=houtaiModel:getPHPInfoStr(htType,'url')
local openCommunity=houtaiModel:getPHPInfoStr(htType,'is_mini_program')=='1'
if jumpURL=="nil"then
jumpURL=nil
end
houtaiModel:setData(htType,{isOpen=isOpen,jumpURL=jumpURL,openCommunity=openCommunity})
end,
[HOUTAI_TYPE.eGongZhongHao]=function(htType)
local isOpen=houtaiModel:getPHPInfoStr(htType,'is_open')=='1'
houtaiModel:setData(htType,{isOpen=isOpen})
end,
[HOUTAI_TYPE.eLoginAgreement]=function(htType)
local data={}
data.content1=houtaiModel:getPHPInfoStr(htType,'content1')
data.content2=houtaiModel:getPHPInfoStr(htType,'content2')
houtaiModel:setData(htType,data)
end,
[HOUTAI_TYPE.eXianJieRebuildPreview]=function(htType)
local data={}
local cross_sids=houtaiModel:getPHPInfoStr(htType,'cross_sids')
local begin_time_str=houtaiModel:getPHPInfoStr(htType,'begin_time')
local end_time_str=houtaiModel:getPHPInfoStr(htType,'end_time')



if cross_sids~='nil'then
data.cross_sids=string.split(cross_sids,',')
end

if begin_time_str~='nil'then
data.begin_time=timeHelper.convertShortStamp(timeHelper.date2stamp(begin_time_str))
end
if end_time_str~='nil'then
data.end_time=timeHelper.convertShortStamp(timeHelper.date2stamp(end_time_str))
end

houtaiModel:setData(htType,data)
end,
[HOUTAI_TYPE.eZhangHaoZhuXiaoBtn]=function(htType)
local isOpen=houtaiModel:getPHPInfoStr(htType,'is_open')=='1'
houtaiModel:setData(htType,{isOpen=isOpen})
end,
[HOUTAI_TYPE.eCountdownServerWin]=function(htType)
local isOpen=houtaiModel:getPHPInfoStr(htType,'is_open')=='1'
local jumpURL=houtaiModel:getPHPInfoStr(htType,'url')
local cur_time=houtaiModel:getPHPInfoStr(htType,'cur_time')
local end_time=houtaiModel:getPHPInfoStr(htType,'end_time')
houtaiModel:setData(htType,{isOpen=isOpen,jumpURL=jumpURL,cur_time=tonumber(cur_time),end_time=tonumber(end_time)})
end,
[HOUTAI_TYPE.eWangYeTiaoZhuan]=function(htType)
local begin_time_str=houtaiModel:getPHPInfoStr(htType,'begin_time')
local end_time_str=houtaiModel:getPHPInfoStr(htType,'end_time')
local jump_url=houtaiModel:getPHPInfoStr(htType,'jump_url')
if begin_time_str=='nil'then begin_time_str=nil end
if end_time_str=='nil'then end_time_str=nil end
if jump_url=='nil'then jump_url=nil end

local data={}
data.jump_url=jump_url

data.begin_time_str=begin_time_str
data.end_time_str=end_time_str

if begin_time_str then
data.begin_time=timeHelper.date2stamp(begin_time_str)
end
if end_time_str then
data.end_time=timeHelper.date2stamp(end_time_str)
end






houtaiModel:setData(htType,data)
end
}

local _freshPHPDataFunc2=
{
[HOUTAI_TYPE_2.eSheQuAct]=function(htType)
local data={}
data.title=houtaiModel:getPHPInfoStr2(htType,'title')
data.content=houtaiModel:getPHPInfoStr2(htType,'content')
data.jumpURL=houtaiModel:getPHPInfoStr2(htType,'url')
data.openCommunity=houtaiModel:getPHPInfoStr2(htType,'is_mini_program')=='1'
local open_day=houtaiModel:getPHPInfo2(htType,'open_day')
open_day=tonumber(open_day)
if open_day<=0 then open_day=1 end
local show_day=houtaiModel:getPHPInfo2(htType,'show_day')
show_day=tonumber(show_day)
if show_day<=0 then show_day=1 end
local begin_time=houtaiModel:getPHPInfoStr2(htType,'begin_time')
if begin_time~=nil then
data.beginTime2=timeHelper.dataToTimeStam(begin_time)
end
local end_time=houtaiModel:getPHPInfoStr2(htType,'end_time')
if end_time~=nil then
data.endTime2=timeHelper.dataToTimeStam(end_time)
end
local o_y,o_m,o_d=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime())
local begin_time2=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)+(open_day-1)*86400
local end_time2=begin_time2+show_day*86400
data.beginTime=begin_time2
data.endTime=end_time2
data.bgName=houtaiModel:getPHPInfoStr2(htType,'background_image_url')
for key,v in pairs(data)do
if v=="nil"then
data[key]=nil
end
end
houtaiModel:setData2(htType,data)
houtaiModel:setSheQuActTypeArr(htType)
end,
}
_freshPHPDataFunc2[HOUTAI_TYPE_2.eSheQuAct2]=_freshPHPDataFunc2[HOUTAI_TYPE_2.eSheQuAct]
_freshPHPDataFunc2[HOUTAI_TYPE_2.eSheQuAct3]=_freshPHPDataFunc2[HOUTAI_TYPE_2.eSheQuAct]


local _freshServerFunc=
{
[HOUTAI_TYPE.eXianYuanJieYin]=function(htType,oldData)
local newSet=tostring(houtaiModel:getServerInfo(htType,'open'))~='0'

if oldData~=nil then
local oldSet=tostring(oldData.open)~='0'
if oldSet==newSet then
return
end
end
if newSet then
if oldData~=nil then
xianyuanShareController:reqXianYuanShareInit()
end
else
xianyuanShareModel:clearData()
if UIManager:isActive('UIXianYuanShareWin')then
UIFullWelfareController:closeUI(true,true)
end
end
end,
}

local _freshPHPFunc=
{
[HOUTAI_TYPE.eCopyRight]=function(htType,oldData)

end,

[HOUTAI_TYPE.eLoginGray]=function(htType,oldData)
loginControl:freshLoginGray()
end,

[HOUTAI_TYPE.eContent]=function(htType,oldData)

end,
[HOUTAI_TYPE.eLoginAgreement]=function(htType,oldData)
loginControl:reqProtocolContent()
end,
[HOUTAI_TYPE.eXianJieRebuildPreview]=function(htType,oldData)

end,
[HOUTAI_TYPE.eZhangHaoZhuXiaoBtn]=function(htType,oldData)
UIManager:callWindowFunc('UILogin','ShowDelBtn')
end,
[HOUTAI_TYPE.eCountdownServerWin]=function(htType,oldData)
CommonController.CountdownServerHandle()
end,
}

function houtaiModel:setServerData(jsonStr)
local json_table
local s,e=pcall(function()
json_table=jsonHelper.decode(jsonStr)
end)
if not s then
loggerUtil.logFMT('254_78解析失败！{0}',jsonStr)
self.serverData={}
return
end

local old=table.deepCopy(self.serverData)
self.serverData=json_table


for k,func in pairs(_freshServerDataFunc)do
func(k)
end

for k,func in pairs(_freshServerFunc)do
func(k,old[k])
end
end

function houtaiModel:setPHPData(data)
local old=table.deepCopy(self.phpData)
self.phpData={}
for i,v in ipairs(data or{})do
local type=v.type
local json_table
local s,e=pcall(function()
json_table=jsonHelper.decode(v.content)
end)
self.phpData[type]=json_table
end



for k,func in pairs(_freshPHPDataFunc)do
func(k)
end

for k,func in pairs(_freshPHPFunc)do
func(k,old[k])
end

UIManager:callWindowFunc('UILogin','showBottomTips')
loginControl:freshLoginGray()
end

function houtaiModel:setPHPData2(data)
self.phpData2={}
self.SheQuActTypeArr={}
for i,v in ipairs(data or{})do
local typo=v.type
local json_table
local s,e=pcall(function()
json_table=jsonHelper.decode(v.content)
end)
self.phpData2[typo]=json_table
end


for k,_ in pairs(self.phpData2)do
local func=_freshPHPDataFunc2[k]
if func then
func(k)
end
end

if#self.SheQuActTypeArr>0 then
table.sort(self.SheQuActTypeArr,function(b1,b2)
local data1=houtaiModel:getSheQuActData(b1)
local data2=houtaiModel:getSheQuActData(b2)
local beginTime1=data1 and data1.beginTime or 0
local beginTime2=data2 and data2.beginTime or 0
return beginTime1<beginTime2
end)
end
end



function houtaiModel:freshServerData(htType)
local func=_freshServerDataFunc[htType]
if func then
func(htType)
end
end

function houtaiModel:freshPHPData(htType)
local func=_freshPHPDataFunc[htType]
if func then
func(htType)
end
end

function houtaiModel:freshPHPData2(htType)
local func=_freshPHPDataFunc2[htType]
if func then
func(htType)
end
end

function houtaiModel:setData(htType,data)
self.info[htType]=data
end

function houtaiModel:setData2(htType,data)
self.info2[htType]=data
end

function houtaiModel:setSheQuActTypeArr(htType)
table.insert(self.SheQuActTypeArr,htType)
end



function houtaiModel:getSheQuActTypeOnIndex(index)
return self.SheQuActTypeArr[index]
end




function houtaiModel:getServerData(htType)
return self.serverData[htType]
end

function houtaiModel:getServerInfo(htType,key)
local data=self.serverData[htType]or{}
return data[key]
end

function houtaiModel:getServerInfoStr(htType,key)
local ret=houtaiModel:getServerInfo(htType,key)
return tostring(ret)
end


function houtaiModel:supportAD()
local htType=HOUTAI_TYPE.ePlayAdvert
local open=houtaiModel:getServerInfoStr(htType,'open')
return open~='0'
end


function houtaiModel:getChatLimitInfo()
local htType=HOUTAI_TYPE.eChatLimit
if self.info[htType]==nil then
houtaiModel:freshServerData(htType)
end
return self.info[htType]
end


function houtaiModel:openXYJY()
local htType=HOUTAI_TYPE.eXianYuanJieYin
local open=houtaiModel:getServerInfo(htType,'open')
return tostring(open)~='0'
end






function houtaiModel:getPHPData(htType)
return self.phpData[htType]
end

function houtaiModel:getPHPData2(htType)
return self.phpData2[htType]
end

function houtaiModel:getPHPInfo(htType,key)
local data=self.phpData[htType]or{}
return data[key]
end

function houtaiModel:getPHPInfo2(htType,key)
local data=self.phpData2[htType]or{}
return data[key]
end

function houtaiModel:getPHPInfoStr(htType,key)
local ret=houtaiModel:getPHPInfo(htType,key)
return tostring(ret)
end

function houtaiModel:getPHPInfoStr2(htType,key)
local ret=houtaiModel:getPHPInfo2(htType,key)
return tostring(ret)
end


function houtaiModel:showCopyRightInfo()
local htType=HOUTAI_TYPE.eCopyRight
return houtaiModel:getPHPInfoStr(htType,'copyright_is_open')~='0'
end


function houtaiModel:isLoginGray()
local htType=HOUTAI_TYPE.eLoginGray
return houtaiModel:getPHPInfoStr(htType,'background_gray')=='1'
end


function houtaiModel:isOpenReview()
local htType=HOUTAI_TYPE.eReview
return houtaiModel:getPHPInfoStr(htType,'remark_is_open')=='1'
end


function houtaiModel:isOpenVIPCustomServer()
return true
end


function houtaiModel:getSheQuActData(htType)
if self.info2[htType]==nil then
houtaiModel:freshPHPData2(htType)
end
return self.info2[htType]
end


function houtaiModel:getSheQuEnterData()
local htType=HOUTAI_TYPE.eSheQuEnter
if self.info[htType]==nil then
houtaiModel:freshPHPData(htType)
end
return self.info[htType]
end


function houtaiModel:getWangYeTiaoZhuanData()
local htType=HOUTAI_TYPE.eWangYeTiaoZhuan
if self.info[htType]==nil then
houtaiModel:freshPHPData(htType)
end
return self.info[htType]
end

function houtaiModel:getGongZhongHaoData()
local htType=HOUTAI_TYPE.eGongZhongHao
if self.info[htType]==nil then
houtaiModel:freshPHPData(htType)
end
return self.info[htType]
end

function houtaiModel:getLoginAgreementData()
local htType=HOUTAI_TYPE.eLoginAgreement
if self.info[htType]==nil then
houtaiModel:freshPHPData(htType)
end
return self.info[htType]
end

function houtaiModel:getXianJieReBuildPreviewData()
local htType=HOUTAI_TYPE.eXianJieRebuildPreview
if self.info[htType]==nil then
houtaiModel:freshPHPData(htType)
end
return self.info[htType]
end

function houtaiModel:getZhanghaozhuxiaoData()
local htType=HOUTAI_TYPE.eZhangHaoZhuXiaoBtn
if self.info[htType]==nil then
houtaiModel:freshPHPData(htType)
end
return self.info[htType]
end


function houtaiModel:getCountdownServerData()
local htType=HOUTAI_TYPE.eCountdownServerWin
if self.info[htType]==nil then
houtaiModel:freshPHPData(htType)
end
return self.info[htType]
end



function houtaiModel:isOpenYaoQingMa()
local htType=HOUTAI_TYPE.eYaoQingMa
return houtaiModel:getPHPInfoStr(htType,'is_open')=='1'
end


function houtaiModel:isOpenGongLue()
local htType=HOUTAI_TYPE.eSheQuEnter
return houtaiModel:getPHPInfoStr(htType,'strategy_switch')=='1'
end



function houtaiModel:isOpenMiniGame()
local htType=HOUTAI_TYPE.eMiniGame
return houtaiModel:getPHPInfoStr(htType,'is_open')=='1'
end



function houtaiModel:checkForbidenTime(htType)
local open=houtaiModel:getPHPInfoStr(htType,'is_open')=='1'
if not open then
return false
end

local curServerTime=timeHelper.getServerLongTime()
local strBeginTime=houtaiModel:getPHPInfoStr(htType,'begin_time')
local strEndTime=houtaiModel:getPHPInfoStr(htType,'end_time')
if strBeginTime=="nil"or strEndTime=="nil"then
return false
end
local beginStamp=timeHelper.date2stamp(strBeginTime)
local endStamp=timeHelper.date2stamp(strEndTime)

local ret=beginStamp<curServerTime and curServerTime<endStamp
return ret
end


function houtaiModel:isOpenWangYeTiaoZhuan()
local data=houtaiModel:getWangYeTiaoZhuanData()or{}
if not data.jump_url or data.jump_url==""then
return false
end
local now=timeHelper.getServerLongTime()






if data.begin_time and now<data.begin_time then
return false
end
if data.end_time and now>data.end_time then
return false
end

return true
end


function houtaiModel:isNoChatting()
return houtaiModel:checkForbidenTime(HOUTAI_TYPE.eNoChatting)
end


local _customDisableShareType={
[8101]=true,
[8247]=true,
[8092]=true,
[8093]=true,
}



function houtaiModel:isOpenShareImage()
local cur_api_level=deviceHelper.getAPILevel()
local customDisable=false
if cur_api_level<41 then
local pfid=loginModel:getPfid()
customDisable=_customDisableShareType[pfid]or false
end
local htType=HOUTAI_TYPE.eShareImage
return houtaiModel:getPHPInfoStr(htType,'is_open')=='1',customDisable
end




function houtaiModel:isForbidenChangeName(tip)
local ret=houtaiModel:checkForbidenTime(HOUTAI_TYPE.eNoRenaming)
if ret and tip~=nil then
UIManager.info(tip)
end
return ret
end


function houtaiModel:getContentInfo()
local htType=HOUTAI_TYPE.eContent
local data={}
data.content1=houtaiModel:getPHPInfoStr(htType,'content1')
data.content2=houtaiModel:getPHPInfoStr(htType,'content2')
data.content3=houtaiModel:getPHPInfoStr(htType,'content3')
for key,v in pairs(data)do
if v=="nil"then
data[key]=nil
end
end
return data
end


function houtaiModel:getSetButtonInfo()
local htType=HOUTAI_TYPE.eSetbutton
local data={}
data.button_content=houtaiModel:getPHPInfoStr(htType,'button_content')
data.jumpURL=houtaiModel:getPHPInfoStr(htType,'url')
for key,v in pairs(data)do
if v=="nil"then
data[key]=nil
end
end
return data
end


function houtaiModel:getDYClientTransferOpen()
local htType=HOUTAI_TYPE_2.eSheQuAct4
return houtaiModel:getPHPInfoStr2(htType,'is_open')=='1'
end



function houtaiModel:tishen_LoginAgreementData()
if webGLHelper:is_MiniGame()then
houtaiModel:reqProtocolContent_TiShen()
end
end


function houtaiModel:reqProtocolContent_TiShen()
local isVerify=verifyManager:isOpen()
if isVerify then
local userProtocolUrl=verifyData:getUserProtocolRUL()
local proviteProtocolUrl=verifyData:getProviteProtocolURL()

if userProtocolUrl and userProtocolUrl~='nil'then
_httpGetRequest(userProtocolUrl,function(content,err)

loggerUtil.log(FMT.fmt("loginControl reqProtocolContent userProtocolUrl",content,tostring(err)))
if err==""or err==nil then
content=content or""
local data={name="用户协议"}
loginControl.userProtocolContent=data
data.list=string.split(content,"\n")
else
logWarn(FMT.fmt("request userProtocol content ,php return message is error,content :: {0},error:{1},url:{2}",content,err,userProtocolUrl))
end
end)
end

if proviteProtocolUrl and proviteProtocolUrl~='nil'then
_httpGetRequest(proviteProtocolUrl,function(content,err)

loggerUtil.log(FMT.fmt("loginControl reqProtocolContent proviteProtocolUrl:{0} {1}",content,tostring(err)))
if err==""or err==nil then
content=content or""
local data={name="隐私协议"}
loginControl.proviteProtocolContent=data
data.list=string.split(content,"\n")
else
logWarn(FMT.fmt("request proviteProtocol content ,php return message is error,content :: {0},error:{1},url:{2}",content,err,proviteProtocolUrl))
end
end)
end
end
end

function houtaiModel:debugSetWebActivitySample()
local htType=HOUTAI_TYPE.eWangYeTiaoZhuan

local sample={
type=htType,
content=jsonHelper.encode({
begin_time="2025-12-1 10:16:00",
end_time="2025-12-30 17:17:00",
jump_url="https://tutien.vsgame.vn/act/index.html",
}),
}
self:setPHPData({sample})
local data=self:getWangYeTiaoZhuanData()
if data then
loggerUtil.logFMT(
'[WebAct] debug sample data jump_url={0} begin_time={1} end_time={2}',
tostring(data.jump_url),
tostring(data.begin_time),
tostring(data.end_time)
)
else
loggerUtil.logFMT('[WebAct] debug sample data is nil')
end
end



function houtaiModel:isNotOpenLiandon()
local htType=HOUTAI_TYPE.eliandonFlag
return houtaiModel:getPHPInfoStr(htType,'is_open')=='0'
end
