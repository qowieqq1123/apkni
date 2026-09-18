







local entityLookup={}
local entityLookup_update={}
local entityQuadtree=nil

function zhengzhanshanhaiModel:insertEntityQuadtree(ent)
if entityQuadtree==nil then
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
local w=baseCfg.w*baseCfg.gw+baseCfg.bw*2
local h=baseCfg.h*baseCfg.gh+baseCfg.bh*2
local h_w=w/2
local h_h=h/2
entityQuadtree=createQuadtree(-h_w,-h_h,h_w,h_h,5,500)
end
entityQuadtree:insertObj(ent)
end

function zhengzhanshanhaiModel:removeEntityQuadtree(ent)
if entityQuadtree then
local flag=entityQuadtree:removeObj(ent)

if not flag then
logErr(FMT.fmt('从平面四叉树中移除实体时,找不到,m_ojbID={0},l_x={1},l_y={2}',ent.m_ojbID,ent.l_x,ent.l_y))
end

end
end

function zhengzhanshanhaiModel:clearEntityQuadtree()
if entityQuadtree then
releaseQuadtree(entityQuadtree)
entityQuadtree=nil
end
end

function zhengzhanshanhaiModel:updataAllEntities()
if entityLookup_update~=nil then
for ojbID,ent in pairs(entityLookup_update)do
ent:onUpdate()
end
end
end


function zhengzhanshanhaiModel:removeAllEntitys()
if entityLookup~=nil and next(entityLookup)~=nil then
for ojbID,ent in pairs(entityLookup)do
release_zzshEntityInfo(ent)
end
entityLookup={}
entityLookup_update={}
zhengzhanshanhaiModel:clearEntityQuadtree()



clear_zzshObjLookup()
end
end


function zhengzhanshanhaiModel:removeAllEntitys2()
if entityLookup~=nil and next(entityLookup)~=nil then
local lp={}
for ojbID,ent in pairs(entityLookup)do
if not ent:containType(eZZSHEntityType.eZhuanShi)then
lp[ojbID]=ent
end
end
if next(lp)~=nil then
for ojbID,ent in pairs(lp)do
zhengzhanshanhaiModel:removeEntityQuadtree(ent)
release_zzshEntityInfo(ent)
entityLookup[ojbID]=nil
entityLookup_update[ojbID]=nil
end
end
lp=nil
end
end

function zhengzhanshanhaiModel:removeAllEntitys3(del)
if del==nil then return end
if entityLookup~=nil and next(entityLookup)~=nil then
local lp={}
for ojbID,ent in pairs(entityLookup)do
if del[ent.entityType]==true then
lp[ojbID]=ent
end
end
if next(lp)~=nil then
for ojbID,ent in pairs(lp)do
zhengzhanshanhaiModel:removeEntityQuadtree(ent)
release_zzshEntityInfo(ent)
entityLookup[ojbID]=nil
entityLookup_update[ojbID]=nil
end
end
lp=nil
end
end

function zhengzhanshanhaiModel:isValidEntity(ojbID)
if ojbID~=nil then
return entityLookup[ojbID]~=nil
end
return false
end

function zhengzhanshanhaiModel:getEntity(ojbID)
if ojbID==nil then return end
return entityLookup[ojbID]
end

function zhengzhanshanhaiModel:getNearEntity(lp)
local list={}
local result
local rectAOI
if entityQuadtree then
rectAOI=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','getNearlyAOI')
if rectAOI then
result={}
entityQuadtree:queryRange(result,rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4])
end
end
if result~=nil then
for ojbID,ent in pairs(result)do
if lp[ent.entityType]==true and ent:checkInAOI(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4])then
if ent.entityType==eZZSHEntityType.eLingDi then
local cfgID=ent.data.cfgID
local ldData=zhengzhanshanhaiModel:getLDData(cfgID)
if ldData then
table.insert(list,{cfgID,eZZSHEntityType.eLingDi})
end
elseif ent.entityType==eZZSHEntityType.ePvEXianMeng then
local guildid=ent.data.guid
local xmData=zhengzhanshanhaiModel:getXMData(guildid)
if xmData then
table.insert(list,{guildid,eZZSHEntityType.ePvEXianMeng})
end
end
end
end
end
return list
end

function zhengzhanshanhaiModel:getNearQingBaoEx(lp)
local list={}
local result
local rectAOI
if entityQuadtree then
rectAOI=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','getNearlyAOI')
if rectAOI then
result={}
entityQuadtree:queryRange(result,rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4])
end
end
if result~=nil then
for ojbID,ent in pairs(result)do
if(ent:containType(eZZSHEntityType.eMonster)or ent:containType(eZZSHEntityType.eResource))
and ent:checkInAOI(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4])then
local qbguid=ent.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(qbguid)
if qbData then
table.insert(list,qbguid)
end
end
end
end
return list
end

function zhengzhanshanhaiModel:invokeFunc(ojbID,funcName,...)
if ojbID==nil then return end
local ent=zhengzhanshanhaiModel:getEntity(ojbID)
if ent then
local f=ent[funcName]
if f~=nil then
return f(ent,...)
end
end
end

function zhengzhanshanhaiModel:invokeFunc2(entityType,funcName,...)
if entityLookup~=nil then
for ojbID,ent in pairs(entityLookup)do
if ent:containType(entityType)and ent:checkWidget()then
local f=ent[funcName]
if f~=nil then
f(ent,...)
end
end
end
end
end

function zhengzhanshanhaiModel:invokeFunc3(funcName,...)
if entityLookup~=nil then
for ojbID,ent in pairs(entityLookup)do
if ent:checkWidget()then
local f=ent[funcName]
if f~=nil then
f(ent,...)
end
end
end
end
end

function zhengzhanshanhaiModel:addEntity(entityType,data,parent,rectAOI)
local ent=new_zzshEntityInfo(entityType,data,parent)
local ojbID=ent.m_ojbID
assert(entityLookup[ojbID]==nil)
entityLookup[ojbID]=ent
if ent.onUpdate then
entityLookup_update[ojbID]=ent
end
zhengzhanshanhaiModel:insertEntityQuadtree(ent)
if rectAOI then
ent:refreshAOI(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],rectAOI[5])
end
return ojbID
end

function zhengzhanshanhaiModel:refreshEnity(ent,rectAOI)
zhengzhanshanhaiModel:removeEntityQuadtree(ent)
local flag=ent:onRefresh()
if not flag and rectAOI then
ent:refreshAOI(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],rectAOI[5])
end
zhengzhanshanhaiModel:insertEntityQuadtree(ent)
end

function zhengzhanshanhaiModel:delEntityNow(ojbID)
if ojbID==nil then return end
local ent=zhengzhanshanhaiModel:getEntity(ojbID)
if ent then
zhengzhanshanhaiModel:removeEntityQuadtree(ent)
release_zzshEntityInfo(ent)
entityLookup[ojbID]=nil
entityLookup_update[ojbID]=nil
end
end

function zhengzhanshanhaiModel:refreshAOI(x1,y1,x2,y2,mapScale,rectAOI_old)
local result
if entityQuadtree then
result={}
if rectAOI_old then
entityQuadtree:queryRange(result,rectAOI_old[1],rectAOI_old[2],rectAOI_old[3],rectAOI_old[4])
end
entityQuadtree:queryRange(result,x1,y1,x2,y2)
end
if result then
for ojbID,ent in pairs(result)do
ent:refreshAOI(x1,y1,x2,y2,mapScale)
end
end
end

function zhengzhanshanhaiModel:refreshAOIScale(x1,y1,x2,y2,mapScale)
local result
if entityQuadtree then
result={}
entityQuadtree:queryRange(result,x1,y1,x2,y2)
end
if result then
for ojbID,ent in pairs(result)do
ent:refreshMapScale(mapScale)
end
end
end

function zhengzhanshanhaiModel:localPos2gridPos(r_x,r_y)
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
local h_w=baseCfg.w*baseCfg.gw/2
local h_h=baseCfg.h*baseCfg.gh/2

local x=r_x+h_w
local y=r_y+h_h

x=math.floor(x/baseCfg.gw)
y=math.floor(y/baseCfg.gh)
return x,y
end

function zhengzhanshanhaiModel:gridPos2localPos(r_x,r_y)
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
local h_w=baseCfg.w*baseCfg.gw/2
local h_h=baseCfg.h*baseCfg.gh/2

local x=baseCfg.gw/2+r_x*baseCfg.gw
local y=baseCfg.gh/2+r_y*baseCfg.gh

x=x-h_w
y=y-h_h
return x,y
end

function zhengzhanshanhaiModel:checkGridPosInMap(g_x,g_y)
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
if g_x>=0 and g_x<baseCfg.w and g_y>=0 and g_y<baseCfg.h then
return true
end
return false
end

function zhengzhanshanhaiModel:checkGridPosInInRadius(g_x,g_y,rectAOI)
local result
if entityQuadtree then
result={}
entityQuadtree:queryRange(result,rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4])
end
if result then
for ojbID,ent in pairs(result)do
if ent:checkInCircle(g_x,g_y)then
return true,ent.entityType
end
end
end
return false
end
