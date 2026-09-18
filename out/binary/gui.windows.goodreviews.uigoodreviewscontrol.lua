

UIGoodReviewsControl=gameState.addListener({})

local _httpGetRequest=CS.ResourceHelper.HttpGetRequest

function UIGoodReviewsControl:onAppStart()

end

function UIGoodReviewsControl:onEnterState(isReconnect)
if isReconnect then
return
end

self.data={}

notifySystem:listenNotify(notifyConfig.onDiscipleNewID,self.on_new_disciple)
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.on_level_change)
end

function UIGoodReviewsControl:onLeaveState(isReconnect)
if isReconnect then
return
end

self.data=nil

notifySystem:removelistener(notifyConfig.onDiscipleNewID,self.on_new_disciple)
notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.on_level_change)
end

function UIGoodReviewsControl.on_new_disciple(guid,id)
UIGoodReviewsControl:checkOnNewDiscipleAdd(guid,id)
end

function UIGoodReviewsControl.on_level_change(level,exp)
UIGoodReviewsControl:checkOnLevelChange(level,exp)
end



function UIGoodReviewsControl:clearAllRecord()
local rdata={}
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.REVIEW_DATA,#rdata,rdata)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.REVIEW_DATA_RED_DZ,#rdata,rdata)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.REVIEW_DATA_SPECIAL_DZ,#rdata,rdata)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.REVIEW_DATA_LEVEL,#rdata,rdata)
serverSaveController:send_254_38()
end

function UIGoodReviewsControl.initReviewData(len,arr)
local datas=arr or{}
UIGoodReviewsControl:setBaseData(datas[1],datas[2])
end

function UIGoodReviewsControl:setBaseData(count,nexttime)
self.data.reviewCount=count or 0
self.data.nextReviewTime=nexttime or 0
end

function UIGoodReviewsControl:getReviewCount()
return self.data.reviewCount
end

function UIGoodReviewsControl:setReviewCount(count)
self.data.reviewCount=count
end

function UIGoodReviewsControl:getNextReviewTime()
return self.data.nextReviewTime
end

function UIGoodReviewsControl:setNextReviewTime(time)
self.data.nextReviewTime=time
end

function UIGoodReviewsControl.initReviewDataRedDZCount(len,arr)
local redDZData={}
if len>0 then
for i,v in ipairs(arr)do
redDZData[v]=true
end
end
UIGoodReviewsControl:setRedDZData(redDZData)
end

function UIGoodReviewsControl:setRedDZData(data)
self.data.redDZData=data
end

function UIGoodReviewsControl:checkRedDZData(count)
return self.data.redDZData[count]==true
end

function UIGoodReviewsControl:recordRedDZData(count)
self.data.redDZData[count]=true
end

function UIGoodReviewsControl.initReviewDataSpecialDZCount(len,arr)
local specialDZData={}
if len>0 then
for i,v in ipairs(arr)do
specialDZData[v]=true
end
end
UIGoodReviewsControl:setSpecialDZData(specialDZData)
end

function UIGoodReviewsControl:setSpecialDZData(data)
self.data.specialDZData=data
end

function UIGoodReviewsControl:checkSpecialDZData(id)
return self.data.specialDZData[id]==true
end

function UIGoodReviewsControl:recordSpecialDZData(id)
self.data.specialDZData[id]=true
end

function UIGoodReviewsControl.initReviewDataZMLevel(len,arr)
local levelData={}
if len>0 then
for i,v in ipairs(arr)do
levelData[v]=true
end
end
UIGoodReviewsControl:setLevelData(levelData)
end

function UIGoodReviewsControl:setLevelData(data)
self.data.levelData=data
end

function UIGoodReviewsControl:checkLevelData(level)
return self.data.levelData[level]==true
end

function UIGoodReviewsControl:recordLevelData(level)
self.data.levelData[level]=true
end



function UIGoodReviewsControl:isOpen()
if deviceHelper.isRunEditor()then
return true
end
return houtaiModel:isOpenReview()
end

function UIGoodReviewsControl:showReviewsWin(args)
msgWinControl:addMsgWin(msgWinType.eReviews,args,nil,true)
end

function UIGoodReviewsControl:checkPrecondition()
if not self:isOpen()then
return false
end

local cfg=cfgHelper.get1(cfg_pinglunyindaoconfig_get,1)

if deviceHelper.isRunAndroid()then
if not cfg.android then
return false
end
elseif deviceHelper.isRunIOS()then
if not cfg.ios then
return false
end
elseif webGLHelper:isRunWebGLOnly()then
if not cfg.h5 then
return false
end
elseif webGLHelper:isRunWeiXin()then
if not cfg.weixin then
return false
end
elseif webGLHelper:isRunMeiTuan()then
if not cfg.meituan then
return false
end
elseif webGLHelper:isRunDouYin()then
if not cfg.douyin then
return false
end
else
if not deviceHelper.isRunEditor()then
return false
end
end

local count=self:getReviewCount()
if count>=cfg.count then
return false
end

local nextTime=self:getNextReviewTime()
local currTime=gameUtilityModel.getServerShortTime()
if nextTime>currTime then
return false
end

return true
end

function UIGoodReviewsControl:checkOnNewDiscipleAdd(guid,id)
if not self:checkPrecondition()then
return
end

local cfg=cfgHelper.get1(cfg_pinglunyindaoconfig_get,1)
local check=false
local sdata
local redCount
local rtype=0
for i,v in ipairs(cfg.condition)do
local ctype=v[1]
if ctype==2 then
if not self:checkSpecialDZData(v[2])then
if id==v[2]then
check=true
sdata={v[1],v[2]}
rtype=ctype
break
end
end
elseif ctype==1 then
if not self:checkRedDZData(v[2])then
if not redCount then
redCount=UIDiscipleModel:getDiscipleColorCount(eQualityColor.eRed)
end
if redCount==v[2]then
check=true
sdata={v[1],v[2]}
rtype=ctype
break
end
end
end
end

if check then
local args={rtype=rtype,cfgId=cfg.id,data=sdata}
self:showReviewsWin(args)
end
end

function UIGoodReviewsControl:checkOnLevelChange(level,exp)
if not self:checkPrecondition()then
return
end

local cfg=cfgHelper.get1(cfg_pinglunyindaoconfig_get,1)
local check=false
local sdata
local rtype=0
for i,v in ipairs(cfg.condition)do
local ctype=v[1]
if ctype==3 then
if not self:checkLevelData(v[2])then
if level==v[2]then
check=true
sdata={v[1],v[2]}
rtype=ctype
break
end
end
end
end

if check then
local args={rtype=rtype,cfgId=cfg.id,data=sdata}
self:showReviewsWin(args)
end
end

function UIGoodReviewsControl:TestReviewsWin(rtype,id,cnd)
local cfg=cfgHelper.get1(cfg_pinglunyindaoconfig_get,id)
local args={rtype=rtype,cfgId=id,data=cfg.condition[cnd]}
self:showReviewsWin(args)
end

function UIGoodReviewsControl:tuSendData(dict)
local list={}
for k,v in pairs(dict)do
table.insert(list,k)
end
return list
end

function UIGoodReviewsControl:recordAndSaveData(data)
local bdata={}
bdata[1]=self.data.reviewCount
bdata[2]=self.data.nextReviewTime
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.REVIEW_DATA,#bdata,bdata)

local ctype=data[1]
if ctype==1 then
self:recordRedDZData(data[2])
local rdata=self:tuSendData(self.data.redDZData)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.REVIEW_DATA_RED_DZ,#rdata,rdata)
elseif ctype==2 then
self:recordSpecialDZData(data[2])
local rdata=self:tuSendData(self.data.specialDZData)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.REVIEW_DATA_SPECIAL_DZ,#rdata,rdata)
elseif ctype==3 then
self:recordLevelData(data[2])
local rdata=self:tuSendData(self.data.levelData)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.REVIEW_DATA_LEVEL,#rdata,rdata)
end
end

function UIGoodReviewsControl:setNextReviewsTime(day)
local currTime=gameUtilityModel.getServerShortTime()
local nextTime=math.floor(currTime/86400)*86400+day*86400
UIGoodReviewsControl:setNextReviewTime(nextTime)
end

function UIGoodReviewsControl:addReviewsCount()
self:setReviewCount(self:getReviewCount()+1)
end

function UIGoodReviewsControl:jumpToReview()
platformSDK:reqReviews()
end

function UIGoodReviewsControl:getUpLoadInfo(type,close_remark,is_satisfied)
local info=loginModel.phpLoginInfo or{}
local temp={
pfid=gameInfo:getPfid()or 0,
sid=info.srvid or 0,
channel=gameInfo:getChannelID()or 0,
type=type,
close_remark=close_remark,
is_satisfied=is_satisfied,
timestamp=gameUtilityModel.getServerLongTime(),
}

local data=""
for k,v in pairs(temp)do
data=FMT.fmt("{0}&{1}={2}",data,k,v)
end
return data
end

function UIGoodReviewsControl:uploadReview(type,close_remark,is_satisfied)
if deviceHelper.isRunEditor()then
return
end

local logUrl
local counter="counter=remark"
if deviceHelper.isRunNoneOrEditor()then
logUrl="http://10.10.1.25/report"
else
logUrl=logPoint.GetUploadURL()
end
local data=self:getUpLoadInfo(type,close_remark,is_satisfied)
local url=FMT.fmt("{0}?{1}{2}",logUrl,counter,data)
loggerUtil.log(FMT.fmt("review log:{0}",url))
_httpGetRequest(url,function(content,err)
if err==""or err==nil then
if content~='1'then
loggerUtil.log('评价上报错误',content)
end
else
loggerUtil.log('评价上报请求错误',err)
end
end)
end