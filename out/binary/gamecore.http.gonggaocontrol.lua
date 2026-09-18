gonggaoControl={}


function gonggaoControl.requestGonggao(callback,version)
local url=gameInfo:getGongGaoURL()
if url==nil or url==''then
httpManager.Log('公告url为空')
if callback then
callback(false)
end
return
end

local httpCallBack=function(isSuccess,message,json_table)
if isSuccess then
gonggaoModel.setData(json_table,version)
httpManager.Log(string.format('公告解析成功!%s:',message))
if callback then
callback(true,json_table)
end
else
httpManager.Log(string.format('公告解析失败!%s:',message))
if callback then
callback(false)
end
end
end
local urlStr=FMT.fmt('{0}?chid={1}',url,loginModel:getChannelID())
httpManager.Log(FMT.fmt('请求公告数据！url:{0}',urlStr))
httpManager.getRequest(urlStr,httpCallBack)
end


function gonggaoControl.requestVersion(callback)

if deviceHelper.isRunNoneOrEditor()then

local curVersion=gonggaoModel.getVersion(1662452779)
local serverVersionInfo=gonggaoLocalModel.getCfg()
local serverVersion=serverVersionInfo.noticenum or 0

if curVersion==serverVersion and gonggaoModel.checkDataVersion(serverVersion)then
if callback then
callback(true)
end
else

gonggaoModel.setInfo(serverVersionInfo)
local cfg=gonggaoLocalModel.getContentCfg()
gonggaoModel.setData(cfg,serverVersion)
if callback then
callback(true)
end
end

return
end
local url=gameInfo:getGongGaoTypeURL()
if url==nil or url==''then
httpManager.Log('公告类型url为空')
if callback then
callback(false)
end
return
end

local cb=function(flag,msg,json_table)
if flag then
local curVersion=gonggaoModel.getVersion(tonumber(json_table.timestamp))
local serverVersion=json_table.noticenum
httpManager.Log('公告类型数版本：',msg,curVersion,serverVersion)
gonggaoModel.setInfo(json_table)

if curVersion==serverVersion and gonggaoModel.checkDataVersion(serverVersion)then
if callback then
callback(true)
end
else
gonggaoControl.requestGonggao(callback,serverVersion)
end

elseif flag==false then
httpManager.Log('公告类型数据解析错误：',msg)
else
httpManager.Log('公告类型数据请求出错：',msg)
end
end

local urlStr=FMT.fmt('{0}?chid={1}',url,loginModel:getChannelID())
httpManager.Log(FMT.fmt('请求公告类型数据！url:{0}',urlStr))
httpManager.getRequest(urlStr,cb)
end
