








function xianjieModel:clearData_force()

end

function xianjieModel:onEnterState_force(isReconnet)

end

function xianjieModel:GetForceNum()
local cfg=cfg_xianjieforceconfig()
local num=0
for k,v in ipairs(cfg)do
num=num+1
end
return num
end

function xianjieModel:GetForceCfg(id)

return cfgHelper.get1(cfg_xianjieforceconfig_get,id)
end

function xianjieModel:getAllForceReddot()
return XianGongController.getReddot()or shouhundingController:getReddot()or xjFactionNPCModel:getReddot()
end


function xianjieModel:judeForceisOpen(id)
local cfg=xianjieModel:GetForceCfg(id)
local force_Pos=cfg.force_Pos
local islock=cfg.islock
if islock==1 then
local flag=xianjieModel:checkGridState(0,force_Pos[1],force_Pos[2],xjMapGridStateType.eCloudLock)

if flag and flag==1 then
return false
end
end
return true
end


function xianjieModel:JumptoForce(id,npcid,shownewbie,callback)
local cfg=xianjieModel:GetForceCfg(id)
local force_center=cfg.force_center


local func=function()
xianjieModel:showForcewin(id,npcid,shownewbie)
if callback then
callback()
end
end


xianjieController:jumpGrid2(xianjienSceneIndexType.eXianJie,force_center[1],force_center[2],func,nil,-10,false)
end


function xianjieModel:showForcewin(id,npcid,shownewbie)
local cfg=xianjieModel:GetForceCfg(id)
local flag=xianjieModel:judeForceisOpen(id)
if not flag then
if cfg.talktreeid then
worldStoryController:showStoryTree(cfg.talktreeid)
end
return
end

if id==1 then
UIFullXJForceControl:showYuJingMainWindow()
elseif id==2 then
UIFullXJForceControl:showXianGongMainWindow()
elseif id==3 then
UIFullXJForceControl:showPengLaiMainWindow()
elseif id==4 then
UIFullXJForceControl:showJiuYuanMainWindow()
end

UIFullXJForceControl:showWindow("UIXianJieForceWin",{Forceid=id,npcid=npcid,shownewbie=shownewbie})
end


function xianjieModel:closeForceResetCamera()
local height=xianjieController:getCameraPosition().y
height=height+10
xianjieController:resetCameraLookAt2(height,0)
end

function xianjieModel:checkClickPosisForce(sceneidx,gridX,gridZ)
if sceneidx==xianjienSceneIndexType.eXianJie then
local id=nil
local cfg=cfg_xianjieforceconfig()
for k,v in ipairs(cfg)do
local force_Pos=v.force_Pos
local force_size=v.force_size
if gridX>force_Pos[1]and gridX<force_size[1]+force_Pos[1]and gridZ>force_Pos[2]and gridZ<force_size[2]+force_Pos[2]then
id=v.id
break
end
end
if id then
xianjieModel:JumptoForce(id)
return true
end
end
return false
end

function xianjieModel:ClickPosisForce(gridX,gridZ)
local sceneidx=xianjieModel:getSceneIndex()
if sceneidx~=xianjienSceneIndexType.eXianJie then
return-1
end
local cfg=cfg_xianjieforceconfig()
for k,v in ipairs(cfg)do
local force_Pos=v.force_Pos
local force_size=v.force_size
if gridX>force_Pos[1]and gridX<force_size[1]+force_Pos[1]and gridZ>force_Pos[2]and gridZ<force_size[2]+force_Pos[2]then
return v.id
end
end
return-1
end




































































































































