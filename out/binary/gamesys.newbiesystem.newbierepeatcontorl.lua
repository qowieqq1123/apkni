newbieRepeatContorl=gameState.addListener({})


local _curNewbie=nil
local _repeatNextLookupCfg={}
local _minRepeatId=nil
local _repeatListCfg={}

function newbieRepeatContorl:onAppStart()
end

function newbieRepeatContorl:onEnterState()
_curNewbie=nil
_minRepeatId=nil
_repeatNextLookupCfg={}
_repeatListCfg={}
end

function newbieRepeatContorl:onLeaveState()
_curNewbie=nil
_minRepeatId=nil
_repeatNextLookupCfg={}
_repeatListCfg={}
newbieRepeatContorl:stopTimer()
end

function newbieRepeatContorl:onLostConnection()
_curNewbie=nil
_minRepeatId=nil
_repeatNextLookupCfg={}
_repeatListCfg={}
newbieRepeatContorl:stopTimer()
end

function newbieRepeatContorl:onProtocolReq()
newbieRepeatContorl:initRepeayCfg()
newbieRepeatContorl:startTimer()
end


function newbieRepeatContorl.createFangShe()

if not taskModel:hasFirstInZongMenPlot()then return false end
if not storyAIManager:isPlayFirstStoryPlayState()then return false end
local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eDuoRen,mapIdType.zhufeng)

return num<=0
end

function newbieRepeatContorl.confirmCreateFangShe(newbieId)


if not taskModel:hasFirstInZongMenPlot()then return false end
local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eDuoRen,mapIdType.zhufeng)

if num~=1 then return false end
local datas=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eDuoRen)
return zongmenModel:getBDFlagType(datas[1].flag)==bdFlagType.build
end


function newbieRepeatContorl.lingTianXiuFu()
if not taskModel:hasTask(10)then return false end

local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eYaoPu,mapIdType.zhufeng)
if num>0 then return false end

return true
end

function newbieRepeatContorl.confirmLingTianXiuFu(newbieId)
if not taskModel:hasTask(10)then return false end
local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eYaoPu,mapIdType.zhufeng)
if num~=1 then return false end

local datas=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eYaoPu)
return zongmenModel:getBDFlagType(datas[1].flag)==bdFlagType.build
end

function newbieRepeatContorl.lingTianAnPaiDiZi(newbieId)
if not taskModel:hasTask(10)then return false end
local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eYaoPu,mapIdType.zhufeng)
if num~=1 then return false end
local datas=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eYaoPu)
local data=datas[1]
if tonumber(tostring(data.dizi_id))>0 then return false end
if data.plant_id>0 then return false end
return zongmenModel:getBDFlagType(data.flag)==bdFlagType.normal
end

function newbieRepeatContorl.lingTianShengChan(newbieId)
if not taskModel:hasTask(10)then return false end

local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eYaoPu,mapIdType.zhufeng)
if num~=1 then return false end

local datas=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eYaoPu)
local data=datas[1]
if tonumber(tostring(data.dizi_id))==0 then return false end
if data.plant_id>0 then return false end
if zongmenModel:getBDFlagType(data.flag)~=bdFlagType.normal then return false end
return true
end

function newbieRepeatContorl.lingTianJiaSu(newbieId)
if not taskModel:hasTask(10)then return false end

local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eYaoPu,mapIdType.zhufeng)
if num~=1 then return false end

local datas=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eYaoPu)
local data=datas[1]
if tonumber(tostring(data.dizi_id))==0 then return false end
if data.plant_id==0 then return false end
if zongmenModel:getBDFlagType(data.flag)~=bdFlagType.normal then return false end
return not buildingCDControl:isCanReceive(buildingCDType.plan,data.un_build_id)
end

function newbieRepeatContorl.lingTianPrize(newbieId)
if not taskModel:hasTask(10)then return false end

local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eYaoPu,mapIdType.zhufeng)
if num~=1 then return false end

local datas=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eYaoPu)
local data=datas[1]
if tonumber(tostring(data.dizi_id))==0 then return false end
if data.plant_id==0 then return false end
if zongmenModel:getBDFlagType(data.flag)~=bdFlagType.normal then return false end
return buildingCDControl:isCanReceive(buildingCDType.plan,data.un_build_id)
end


function newbieRepeatContorl.lianDanFangXiuFu(newbieId)
if not taskModel:hasTask(20)then return false end
local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eLianDanFang,mapIdType.zhufeng)
if num~=0 then return false end
return true
end

function newbieRepeatContorl.lianDanFangPrize(newbieId)
if not taskModel:hasTask(20)then return false end
local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eLianDanFang,mapIdType.zhufeng)
if num~=1 then return false end

local taskInfo=taskModel:getTaskInfo(20)
if taskInfo==nil then return false end

return taskInfo.taskstate==taskModel.taskRewardState
end

function newbieRepeatContorl.lianDanFangAnPaiDiZi(newbieId)
if not taskModel:hasTask(21)then return false end
local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eLianDanFang,mapIdType.zhufeng)
if num~=1 then return false end
local datas=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eLianDanFang)
local data=datas[1]
if tonumber(tostring(data.dizi_id))>0 then return false end
if data.plant_id>0 then return false end
return zongmenModel:getBDFlagType(data.flag)==bdFlagType.normal
end

function newbieRepeatContorl.lianDanFangShengChan(newbieId)
if not taskModel:hasTask(21)then return false end
local num=zongmenModel:getBuildNumEx(SLG_SYSTEM_TYPE.eLianDanFang,mapIdType.zhufeng)
if num~=1 then return false end
local datas=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eLianDanFang)
local data=datas[1]
if tonumber(tostring(data.dizi_id))<=0 then return false end
local dydata=UIDanYaoModel:get_danYaodata(data.un_build_id)
if dydata.dfId~=0 then return false end
return zongmenModel:getBDFlagType(data.flag)==bdFlagType.normal
end

function newbieRepeatContorl:initRepeayCfg()
local temp={}
local temp2Lookup={}
local minId=nil
for k,v in pairs(cfg_newbieconfig())do
if v.repeatFunc then
temp[#temp+1]={k,v}
end
end
table.sort(temp,function(a,b)
return a[1]<b[1]
end)

for i,v in ipairs(temp)do
if minId==nil or v[1]<minId then minId=v[1]end
local next=temp[i+1]
if next and next[2].repeatFunc then
temp2Lookup[v[1]]=next[1]
end
_repeatListCfg[#_repeatListCfg+1]=v[1]
end
_repeatNextLookupCfg=temp2Lookup
if minId==temp[1][1]then
_minRepeatId=minId
end
end


function newbieRepeatContorl:initCheckNewbie()
local newbieId=newbieModel.getFinishMainNewbie()
if newbieId==nil or newbieId==0 then
if _minRepeatId then
newbieRepeatContorl:setNewbie(_minRepeatId)

newbieRepeatContorl:setNextRepeatNewbie(newbieId)
end
else

newbieRepeatContorl:setNewbie(newbieId)

newbieRepeatContorl:setNextRepeatNewbie(newbieId)
end
end

function newbieRepeatContorl:setNextRepeatNewbie(newbieId)
if not newbieModel.isFinish(newbieId)then return end
local nextNewbieid=_repeatNextLookupCfg[newbieId]
if nextNewbieid==nil then

for _,v in ipairs(_repeatListCfg)do
if v>newbieId then
nextNewbieid=v
break
end
end
end
newbieRepeatContorl:setNewbie(nextNewbieid)
end

function newbieRepeatContorl:setNewbie(newbieId)
if newbieId==nil then return end
if _curNewbie==newbieId then return end

local cfg=newbieConfig.getNewbieConfig(newbieId)
if cfg==nil or cfg.repeatFunc==nil then return end
local funcStr=cfg.repeatFunc
if self[funcStr]and not self[funcStr](newbieId)then return end
local old=_curNewbie
_curNewbie=newbieId





end

function newbieRepeatContorl:startTimer()
newbieRepeatContorl:stopTimer()
local func=function()
xpcall(function()
self:update()
end,function(err)
logErr(err)
end)
end
self.updateTimer=timer.New()
self.updateTimer:start(1,func)
end

function newbieRepeatContorl:stopTimer()
if self.updateTimer then
self.updateTimer:cancel()
end
self.updateTimer=nil
end

function newbieRepeatContorl:update()
if newbieControl.hasCache()then return end
if not initProControl.isDone()then return end
if not newbieControl.canStart()then return end
if not buildingCDControl.initAllCD[mapIdType.zhufeng]then return end

newbieRepeatContorl:initCheckNewbie()

if _curNewbie then
newbieControl.tryStartByNewbieId(_curNewbie,true)
end

newbieRepeatContorl:stopTimer()
end
