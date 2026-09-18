function worldExperienceController:refreshAllUnit()
worldExperienceController:showAllUnit()
worldExperienceController:hideAllUnit()
end



function worldExperienceController:showAllUnit()
local cWorld=worldExperienceModel:getCurrentWorld()
local cBlock=worldExperienceModel:getCurrentBlock()
local cState=worldExperienceModel:getCurrentState()
local points=worldExperienceModel:getAllPoint()
local cnt=#points
local stand=cState==eExperiencePonitState.Init and cnt-1 or cnt
for i=1,cnt do

local dept=points[i]
if i<stand then
self:showClosePointUnit(dept)
elseif i>stand then
self:showOpenPointUnit(dept)
else
if stand==cnt then
self:showFightPointUnit(dept)
else
self:showClosePointUnit(dept)
end
end

if i<cnt then
local dest=points[i+1]
self:showPathSegmentUnit(dept,dest,i<=stand)
end
end

local standPoint=points[stand]

self:showDiscipleUnit(cWorld,cBlock,standPoint)

local followers=worldExperienceModel:getAllFollower()
for i,v in ipairs(followers)do
self:showFollowerUnit(i,v,standPoint)
end
end





function worldExperienceController:showDiscipleUnit(cWorld,cBlock,stand)


local targetKey=worldExperienceModel:convertTaskTargetKey(cWorld,cBlock)
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)
local discipleGuid=nil
if taskKey then
local task=worldTaskModel:getTask(taskKey)
discipleGuid=task.disciples[1]
end
local unitKey=worldExperienceModel:getDiscipleKey()
local lodCfg=cfgHelper.get2(cfg_worldglobalconfig_get,"experienceUnitLOD","value")
local lod=mathHelper.convertArrayToVector(lodCfg)
local mSetting=nil
if discipleGuid then
local discipleParam=UIDiscipleModel:getDiscipleHeadModelInfo(discipleGuid)
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,discipleParam.body)
local height=bodyCfg.size and bodyCfg.size[2]or 0
local scale=bodyCfg.worldScales and bodyCfg.worldScales[2]or 0.4
mSetting=CS.WorldEntitySetting.New(lod,height*scale,nil,discipleParam.body,discipleParam.componets,"Entity",scale,Vector3.zero)
if api_Available_SetWorldEntityUseSmall()then
mSetting:SetWorldEntityUseSmall(false)
end
end

local standCfg=cfgHelper.get1(cfg_experienceconfig_get,stand)
local position=worldPositionConfig:getPosition_CurrentWorld(standCfg.disciplinePos)
local flipX=standCfg.disciplinePos[1]>standCfg.pos[1]
local luaData={eWorldUnitTpye.EXPERIENCE,0}

worldController:pushUnit(unitKey,position,luaData,mSetting,nil,nil,false)
worldController:setUnitFlipX(unitKey,flipX)
worldController:setModelShadow(unitKey,true)
end





function worldExperienceController:showFollowerUnit(index,npcId,stand)

local npcCfg=cfgHelper.get1(cfg_npcimageconfig_get,npcId)
local npcData=npcModel:getImageInfoOutSide(npcId)
local standCfg=cfgHelper.get1(cfg_experienceconfig_get,stand)
local unitKey=worldExperienceModel:getFollowerKey(index)
local lodCfg=cfgHelper.get2(cfg_worldglobalconfig_get,"experienceUnitLOD","value")
local lod=mathHelper.convertArrayToVector(lodCfg)
local body=npcData.body
local componets=npcData.componets
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,body)
local height=bodyCfg.size and bodyCfg.size[2]or 0
local scale=bodyCfg.worldScales and bodyCfg.worldScales[2]or 0.4
local mSetting=CS.WorldEntitySetting.New(lod,height*scale,nil,body,componets,"Entity",scale,Vector3.zero)
if api_Available_SetWorldEntityUseSmall()then
mSetting:SetWorldEntityUseSmall(false)
end
local pos=standCfg.followPos[index]
local position=worldPositionConfig:getPosition_CurrentWorld(pos)
local flipX=pos[1]>standCfg.pos[1]
local luaData={worldModel.UNITTYPE.EXPERIENCE,-index}

worldController:pushUnit(unitKey,position,luaData,mSetting,nil,nil,false)
worldController:setUnitFlipX(unitKey,flipX)
worldController:setModelShadow(unitKey,true)
end



function worldExperienceController:showClosePointUnit(point)
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
local cfg=pointCfg.close
if cfg and#cfg>0 then
local hudId=pointCfg.hudId and pointCfg.hudId[1]
local modelId=cfg[1]
local flipX=cfg[2]
local position=worldPositionConfig:getPosition_CurrentWorld(pointCfg.pos)
local unitKey=worldExperienceModel:getPointKey(point)
local luaData={eWorldUnitTpye.EXPERIENCE,point}
local mSetting=worldModel:getModelSettings(modelId,eWorldUnitTpye.EXPERIENCE)
local hudSettings=worldModel:getHUDSetting(hudId)
worldController:pushUnit(unitKey,position,luaData,mSetting,hudSettings,nil,true)
if flipX~=nil then
worldController:setUnitFlipX(unitKey,flipX)
worldController:setModelShadow(unitKey,true)
end
end
end



function worldExperienceController:showOpenPointUnit(point)
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
local cfg=pointCfg.open
if cfg and#cfg>0 then
local hudId=pointCfg.hudId and pointCfg.hudId[1]
local modelId=cfg[1]
local animation=cfg[2]
local flipX=cfg[3]or false
local position=worldPositionConfig:getPosition_CurrentWorld(pointCfg.pos)
local unitKey=worldExperienceModel:getPointKey(point)
local luaData={eWorldUnitTpye.EXPERIENCE,point}
local mSetting=worldModel:getModelSettings(modelId,eWorldUnitTpye.EXPERIENCE)
local hudSettings=worldModel:getHUDSetting(hudId)
worldController:pushUnit(unitKey,position,luaData,mSetting,hudSettings,nil,true)
worldController:setAnimation(unitKey,animation)
worldController:setUnitFlipX(unitKey,flipX)
worldController:setModelShadow(unitKey,true)
end
end



function worldExperienceController:showFightPointUnit(point)
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
local cfg=pointCfg.fight or pointCfg.open
if cfg and#cfg>0 then
local modelId=cfg[1]
local animation=cfg[2]
local flipX=cfg[3]or false
local hudId=pointCfg.hudId and pointCfg.hudId[1]
local position=worldPositionConfig:getPosition_CurrentWorld(pointCfg.pos)
local unitKey=worldExperienceModel:getPointKey(point)
local luaData={eWorldUnitTpye.EXPERIENCE,point}
local mSetting=worldModel:getModelSettings(modelId,eWorldUnitTpye.EXPERIENCE)
local hudSettings=worldModel:getHUDSetting(hudId)
worldController:pushUnit(unitKey,position,luaData,mSetting,hudSettings,nil,true)
worldController:setAnimation(unitKey,animation)
worldController:setUnitFlipX(unitKey,flipX)
worldController:setModelShadow(unitKey,true)
end
end

function worldExperienceController:changeFollowUnitModel(index,npcId)
local unitKey=worldExperienceModel:getFollowerKey(index)
local npcCfg=cfgHelper.get1(cfg_npcimageconfig_get,npcId)
local npcData=npcModel:getImageInfoOutSide(npcId)
local lodCfg=cfgHelper.get2(cfg_worldglobalconfig_get,"experienceUnitLOD","value")
local lod=mathHelper.convertArrayToVector(lodCfg)
local body=npcData.body
local componets=npcData.componets
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,body)
local height=bodyCfg.size and bodyCfg.size[2]or 0
local scale=bodyCfg.worldScales and bodyCfg.worldScales[2]or 0.4
local mSetting=CS.WorldEntitySetting.New(lod,height*scale,nil,body,componets,"Entity",scale,Vector3.zero)
if api_Available_SetWorldEntityUseSmall()then
mSetting:SetWorldEntityUseSmall(false)
end
worldController:changeUnitModel(unitKey,mSetting)
end



function worldExperienceController:changeToFightUnit(point)
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
local cfg=pointCfg.fight
if cfg and#cfg>0 then
local temp=pointCfg.open
if temp and#temp>0 then
local modelId=cfg[1]
local animation=cfg[2]
local flipX=cfg[3]or false
local unitKey=worldExperienceModel:getPointKey(point)
local mSetting=worldModel:getModelSettings(modelId,eWorldUnitTpye.EXPERIENCE)
worldController:changeUnitModel(unitKey,mSetting)
worldController:setAnimation(unitKey,animation)
worldController:setUnitFlipX(unitKey,flipX)
worldController:setModelShadow(unitKey,true)
else
self:showFightPointUnit(point)
end
end
end



function worldExperienceController:changeToCloseUnit(point)
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
local unitKey=worldExperienceModel:getPointKey(point)
local cfg=pointCfg.close
if cfg and#cfg>0 then
local temp=pointCfg.fight or pointCfg.open
if temp and#temp>0 then
local modelId=cfg[1]
local flipX=cfg[2]
local mSetting=worldModel:getModelSettings(modelId,eWorldUnitTpye.EXPERIENCE)
worldController:changeUnitModel(unitKey,mSetting)
worldController:setAnimation(unitKey,0)
worldController:setUnitFlipX(unitKey,flipX or false)
worldController:setModelShadow(unitKey,true)
else
self:showClosePointUnit(point)
end
else
worldController:popUnit(unitKey)
end
end





function worldExperienceController:showPathSegmentUnit(dept,dest,pass)
local pathCfg=cfgHelper.get2(cfg_experiencepathconfig_get,dept,dest)
local modelCfg=cfgHelper.get2(cfg_worldglobalconfig_get,"experiencePathModel","value")
local modelId=pass and modelCfg[1]or modelCfg[2]
local mSetting=worldModel:getModelSettings(modelId,eWorldUnitTpye.EXPERIENCE)
for i,v in ipairs(pathCfg.points)do
local unitKey=worldExperienceModel:getPathKey(dept,dest,i)
local luaData={eWorldUnitTpye.EXPERIENCE,nil,dept,dest,i}
local position=worldPositionConfig:getPosition_CurrentWorld(v[1])
local offset=v[2]and mathHelper.convertArrayToVector(v[2])or Vector3.zero
position=position+offset
worldController:pushUnit(unitKey,position,luaData,mSetting,nil,nil,false)
end
end



function worldExperienceController:hideAllUnit()
local points=worldExperienceModel:getAllPoint()
local cnt=#points
for i=1,cnt do

local dept=points[i]
self:hidePointUnit(dept)
if i<cnt then

local dest=points[i+1]
self:hidePathSegmentUnit(dept,dest)
end
end

self:hideDiscipleUnit()

local followers=worldExperienceModel:getAllFollower()
for i,v in ipairs(followers)do
self:hideFollowerUnit(i)
end
end


function worldExperienceController:hideDiscipleUnit()

local unitKey=worldExperienceModel:getDiscipleKey()
worldController:popUnit(unitKey)
end



function worldExperienceController:hideFollowerUnit(index)
local unitKey=worldExperienceModel:getFollowerKey(index)
worldController:popUnit(unitKey)
end



function worldExperienceController:hidePointUnit(point)
local unitKey=worldExperienceModel:getPointKey(point)
worldController:popUnit(unitKey)
end




function worldExperienceController:hidePathSegmentUnit(dept,dest)
local pathCfg=cfgHelper.get2(cfg_experiencepathconfig_get,dept,dest)
for i,v in ipairs(pathCfg.points)do
local unitKey=worldExperienceModel:getPathKey(dept,dest,i)
worldController:popUnit(unitKey)
end
end

function worldExperienceController:refreshDisclpleUnit(discipleGuid)
local key=worldExperienceModel:getDiscipleKey()
local check=worldController:haveUnit(key)

if check and discipleGuid then
local stand=worldExperienceModel:getStandPoint()
local lodCfg=cfgHelper.get2(cfg_worldglobalconfig_get,"experienceUnitLOD","value")
local lod=mathHelper.convertArrayToVector(lodCfg)
local discipleParam=UIDiscipleModel:getDiscipleHeadModelInfo(discipleGuid)
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,discipleParam.body)
local height=bodyCfg.size and bodyCfg.size[2]or 0
local scale=bodyCfg.worldScales and bodyCfg.worldScales[2]or 0.4
local mSetting=CS.WorldEntitySetting.New(lod,height*scale,nil,discipleParam.body,discipleParam.componets,"Entity",scale,Vector3.zero)
if api_Available_SetWorldEntityUseSmall()then
mSetting:SetWorldEntityUseSmall(false)
end
local standCfg=cfgHelper.get1(cfg_experienceconfig_get,stand)
worldController:changeUnitModel(key,mSetting)
worldController:setUnitFlipX(key,standCfg.disciplinePos[1]>standCfg.pos[1])
worldController:setModelShadow(key,true)
end
end

function worldExperienceController:refreshFollowUnitList(startIndex)
local followers=worldExperienceModel:getAllFollower()
local count=#followers

for i=startIndex,count do
local npcId=followers[i]
local key=worldExperienceModel:getFollowerKey(i)
if worldController:haveUnit(key)then

self:changeFollowUnitModel(i,npcId)
else

local point=worldExperienceModel:getCurrentPoint()
self:showFollowerUnit(i,npcId,point)
end
end
for i=count+1,startIndex do
local key=worldExperienceModel:getFollowerKey(i)
if worldController:haveUnit(key)then

self:hideFollowerUnit(i)
end
end
end