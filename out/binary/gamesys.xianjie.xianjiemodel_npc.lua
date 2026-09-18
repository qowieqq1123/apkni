







function xianjieModel:clearData_NPC()
local lp=self.allNPCDatas
if lp then
for npcid,npcData in pairs(lp)do
xianjieController:removeXJClass(npcData)
end
self.allNPCDatas=nil
end
end

function xianjieModel:initAllNPCDatas()
xianjieModel:clearData_NPC()
local allNPCDatas={}
self.allNPCDatas=allNPCDatas
local sceneidx=xianjieModel:getSceneIndex()
local sceneidx_
if xianjienSceneIndexType:isXianYu(sceneidx)then
sceneidx_=200
else
sceneidx_=sceneidx
end
local cfgs=taskModel:GetNPCdatabySceneindex(sceneidx_)
for npcid,npccfg in pairs(cfgs)do
xianjieModel:addNPCData(npccfg,true)
end
end

function xianjieModel:addNPCData(npccfg,isInit)
local allNPCDatas=self.allNPCDatas
if allNPCDatas==nil then return end
if allNPCDatas[npccfg.id]then



return
end
local d={}
d.npcid=npccfg.id
local pos=npccfg.pos
if pos[1]==200 then
local m_sceneidx=xianjieModel:getXianYuSceneIndex()
d.sceneidx=m_sceneidx
else
d.sceneidx=pos[1]
end
d.gridX=pos[2]
d.gridZ=pos[3]
local size=npccfg.size
d.gridWidth=size[1]
d.gridHeight=size[2]
local npcData=xianjieController:createXJClass(xjDataType.eNPC,d)
allNPCDatas[npcData.npcid]=npcData
if not isInit then
npcData:createEntity(true)
end
end

function xianjieModel:removeNPCData(npcid)
local allNPCDatas=self.allNPCDatas
if allNPCDatas==nil then return end
local npcData=allNPCDatas[npcid]
if npcData==nil then



return
end
xianjieController:removeXJClass(npcData)
allNPCDatas[npcid]=nil
end

function xianjieModel:refreshNPCData(npcid)
local allNPCDatas=self.allNPCDatas
if allNPCDatas==nil then return end
local npcData=allNPCDatas[npcid]
if npcData==nil then
return
end
npcData:refreshEntity()
end

function xianjieModel:getNPCData(npcid)
if self.allNPCDatas then
return self.allNPCDatas[npcid]
end
end

function xianjieModel:createAllNPCEnities(needRefreshAOI)
xianjieModel:initAllNPCDatas()
local lp=self.allNPCDatas
if lp then
for npcid,npcData in pairs(lp)do
npcData:createEntity(needRefreshAOI)
end
end
end

function xianjieModel:removeAllNPCEnities()
local lp=self.allNPCDatas
if lp then
for npcid,npcData in pairs(lp)do
npcData:removeEntity()
end
end
end


function xianjieModel:visitNPC(npcid,shownewbie)
local npccfg=cfgHelper.get1(cfg_tasknpcconfig_get,npcid)
if not npccfg then
return false
end
local pos=npccfg.pos
if pos then

local sceneidx=pos[1]
if sceneidx==200 then
if xianjieController:checkInPlotScene2()then
return false
end
sceneidx=xianjieModel:getXianYuSceneIndex()
end
local size=npccfg.size
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(pos[2],pos[3],size[1],size[2])
local func2=function()

if npccfg.weakGuide then
weakGuideController:beginGuide(npccfg.weakGuide)
end

end
local func=function()
local lookpos=xianjieController:worldGridPos2WorldPos4(gridX_c,gridZ_c,sceneidx)
local scenenpcY=xianjieModel:getNpcCameraY()

xianjieController:lookAtPositionChangeHeight(lookpos,scenenpcY,0,func2,nil,nil)
end
fullScreenUI.closeActiveUI()

xianjieController:jumpGrid(sceneidx,gridX_c,gridZ_c,func)
return true
else



local cfg=taskModel:getTaskNPCConfig(npcid)
local haveforce=cfg.haveforce
if haveforce then
xianjieModel:JumptoForce(haveforce,npcid,shownewbie)
return true
end
end
return false
end

function xianjieModel:getNpcCameraY()
local cfg=cfgHelper.get1(cfg_tasknpcbaseconfig_get,1)
if webGLHelper:isWebGLOptimization()then
return cfg.scenenpcY_MiniGame or cfg.scenenpcY
end
return cfg.scenenpcY
end
