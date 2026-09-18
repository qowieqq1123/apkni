xiaodaotongModel_update=gameState.addListener({})



function xiaodaotongModel_update:onAppStart(...)

end

function xiaodaotongModel_update:onEnterState()
self.initBuild=nil

self.buildings={}
self.buildingCnt={}
self.buildingCacheCnt={}

self.buildingReddot={}
self.buildingCacheReddot={}

self.buildDataDirty=nil
end

function xiaodaotongModel_update:onLeaveState()
self.initBuild=nil

self.buildings={}
self.buildingCnt={}
self.buildingCacheCnt={}


self.buildingReddot={}
self.buildingCacheReddot={}

self.buildDataDirty=nil

self:stopTimer()
end


XDT_TYPE=
{
eManufatureFinishNum=1,
eBuildFinishNum=2,
}

local _buildCntFunc=
{
[XDT_TYPE.eManufatureFinishNum]=
{
func=function(v)
if v.flag==0 then
local cfg=cfg_monijybuildconfig_get(v.build_id)
local cd
if cfg.win_type==sysWinType.eFangAn then
cd=buildingCDControl:getCD(buildingCDType.plan,v.un_build_id)
elseif cfg.id==SLG_SYSTEM_TYPE.eLianDanFang then
cd=buildingCDControl:getCD(buildingCDType.liandan,v.un_build_id)
elseif cfg.win_type==sysWinType.eShangPu then
cd=buildingCDControl:getCD(buildingCDType.shangpu,v.un_build_id)
end
return cd==0
end
return false
end,
refresh=function(old,new)

UIManager:callWindowFunc('UIWorldFuncStorageWin','refreshZaWuBu')
UIManager:callWindowFunc('UIWorldZaWuPuDialogueWin','refreshreddot')
UIManager:callWindowFunc('UIXianJieFuncStorageWin','refreshZaWuBu')
UIManager:callWindowFunc('UIXiaoDaoTongMainWin','refreshPageReddot')
end
},
[XDT_TYPE.eBuildFinishNum]=
{
func=function(v)
if xiaodaotongModel:checkBuild(v)then
local cd=buildingCDControl:getCD(buildingCDType.build,v.un_build_id)
return cd==0
end
return false
end,
refresh=function(old,new)

UIManager:callWindowFunc('UIWorldFuncStorageWin','refreshZaWuBu')
UIManager:callWindowFunc('UIWorldZaWuPuDialogueWin','refreshreddot')
UIManager:callWindowFunc('UIXianJieFuncStorageWin','refreshZaWuBu')
UIManager:callWindowFunc('UIXiaoDaoTongMainWin','refreshPageReddot')
end
}
}


local _buildReddotFunc=
{

}

function xiaodaotongModel_update.onFrameUpdate()
xiaodaotongModel_update:updateBuilds()
end

function xiaodaotongModel_update:startTimer()
if self.frameTimer==nil then
self.frameTimer=FrameTimer.New(self.onFrameUpdate,0,-1)
self.frameTimer:Start()
end
end

function xiaodaotongModel_update:stopTimer()
if self.frameTimer then
self.frameTimer:Stop()
end
self.frameTimer=nil
end


function xiaodaotongModel_update:onSwitchCurMountainId()
self:startTimer()
self.buildingCnt={}
xiaodaotongModel_update:refreshBuilds()
end

function xiaodaotongModel_update:setBuildDataDirty()
self.buildDataDirty=true
end

function xiaodaotongModel_update:refreshBuilds()
local datas=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
if#datas==0 then return end

if self.buildDataDirty~=false then
self.buildDataDirty=false
self.initBuild=true
table.clear(self.buildings)
for _,v in pairs(datas)do
self.buildings[#self.buildings+1]=v.un_build_id
end
self.buildIndex=0
self.buildCnt=#self.buildings
self.buildUpdateCnt=math.floor(self.buildCnt/30)
self.buildUpdateCnt=math.min(10,self.buildUpdateCnt)
end

self.buildIndex=0

for k,v in pairs(_buildCntFunc)do
local old=self.buildingCnt[k]or 0
local new=self.buildingCacheCnt[k]or 0
if new~=old then
self.buildingCnt[k]=new
if v.refresh then
v.refresh(old,new)
end
end
self.buildingCacheCnt[k]=0
end
for k,v in pairs(_buildReddotFunc)do
local old=self.buildingReddot[k]or false
local new=self.buildingCacheReddot[k]or false
if new~=old then
self.buildingReddot[k]=new
if v.refresh then
v.refresh(old,new)
end
end
self.buildingCacheReddot[k]=false
end
end

function xiaodaotongModel_update:updateBuilds()
if self.initBuild==nil then return end

local start=self.buildIndex+1
if start>self.buildCnt then
self:refreshBuilds()
return
end
local endIdx=math.min(self.buildCnt,start+self.buildUpdateCnt)
self.buildIndex=endIdx
for i=start,endIdx do
local un_build_id=self.buildings[i]
local data=zongmenModel:getBuildingData(un_build_id)
if data then

for k,v in ipairs(_buildCntFunc)do
local old=self.buildingCacheCnt[k]or 0
if v.func(data)then
self.buildingCacheCnt[k]=old+1
end
end

for k,v in pairs(_buildReddotFunc)do
if not self.buildingCacheReddot[k]and v.func(data)then
self.buildingCacheReddot[k]=true
end
end
end
end
end

function xiaodaotongModel_update:getBuildCnt(tickType)
return self.buildingCnt[tickType]or 0
end

function xiaodaotongModel_update:hasBuildCnt(tickType)
return xiaodaotongModel_update:getBuildCnt(tickType)>0
end

function xiaodaotongModel_update:hasBuildReddot(tickType)
return self.buildingReddot[tickType]or false
end