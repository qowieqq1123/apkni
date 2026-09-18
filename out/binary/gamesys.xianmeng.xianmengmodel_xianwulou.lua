







local xwlData

function xianmengModel:clearData_xianwulou()
xwlData=nil
end

function xianmengModel:initData_xianwulou()
xwlData={}
end

function xianmengModel:checkXWLInit()
if xwlData~=nil then
return xwlData.data~=nil and not xianmengModel:checkXWLInitOutTime()
end
end

function xianmengModel:checkXWLInitOutTime()
if xwlData==nil or xwlData.data==nil then return true,nil end
local initTime=xwlData.data.initTime
local y,m,d=timeHelper.getDateNumber(initTime)
local t=timeHelper.timeServer(y,m,d,5,0,0)
local cur=gameUtilityModel.getServerLongTime()
local w=timeHelper.getWeakDateEx3(initTime)
local t2
if w==1 and initTime<=t then
t2=t
else

local lerp_d=8-w
t2=t+lerp_d*86400
end
return cur>=t2,t2
end

function xianmengModel:initXWLData(data)
if xwlData==nil then
xwlData={}
end
xwlData.data=data
end

function xianmengModel:initXWLNotes(list)
xwlData.notes=list
end

function xianmengModel:getXWLNotes()
return xwlData.notes
end

function xianmengModel:getXWLData()
if xwlData~=nil then
return xwlData.data
end
end

function xianmengModel:getMaxLun()
local xmlv=xianmengModel:getXMLevel()
local maxlun=cfgHelper.get2(cfg_xianwuloutasknumconfig_get,xmlv,'taskNum')
return maxlun
end

function xianmengModel:checkXWLHasTask()
if xianmengModel:hasXM()then
if xwlData~=nil then
local data=xwlData.data
local maxlun=xianmengModel:getMaxLun()
local curlun=data.lunshuId
if curlun<=maxlun then
local maxexp=cfgHelper.get2(cfg_xianwuloutasklunshuconfig_get,curlun,'progressBarMax')
local curexp=data.jinduVal
local check=true
if curlun==maxlun then
if curexp>=maxexp then
check=false
end
end
if check then
return true,data.taskId
end
end
end
end
return false,nil
end

function xianmengModel:checkXWLHasReward()
if xianmengModel:hasXM()then
if xwlData~=nil then
local data=xwlData.data
if data then
return data.lunshuId2>0
end
end
end
return false
end

function xianmengModel:getXWLRewardCount()
if xianmengModel:hasXM()then
local data=xwlData~=nil and xwlData.data or nil
if data~=nil then
local rlun=data.lunshuId2
if rlun>0 then
local curlun=data.lunshuId
local maxexp=cfgHelper.get2(cfg_xianwuloutasklunshuconfig_get,curlun,'progressBarMax')
local curexp=data.jinduVal
local pos
if curexp>=maxexp then
pos=math.max(rlun,curlun)
else
pos=math.max(rlun,curlun-1)
end
return 1+pos-rlun
end
end
end
return 0
end

function xianmengModel:getXWL_tjNum()
local num=0
if xianmengModel:hasXM()then
if xwlData~=nil then
local data=xwlData.data
if data then
local cur=gameUtilityModel.getServerLongTime()
local o_y,o_m,o_d=timeHelper.getDateNumber(cur)
local t=timeHelper.timeServer(o_y,o_m,o_d,5,0,0)
if cur>=t and data.tjNumTime<t then
data.tjNumTime=t
data.tjNum=xianmengModel:getXWL_tjNumMax()
end
num=data.tjNum
end
end
end
return num
end

function xianmengModel:getXWL_tjNumMax()
return cfgHelper.get2(cfg_xianwuloubaseconfig_get,1,'dayTiJiaoNum')
end

function xianmengModel:getTJGoods()
local data=xianmengModel:getXWLData()
if data then
local hasTask=xianmengModel:checkXWLHasTask()
if hasTask then
return data.tjList
else
return data.tjList2
end
end
end
