







local entityLookup={}
local entityLookup_update={}
local entityQuadtree=nil
xianjieController.click2DEntityCoolTime=0.5
xianjieController.entity2DAutoScaleMin=0.8

local map2DCfg={

xjgw=10,
xjgh=10,
xjbw=500,
xjbh=500,
xygw=12,
xygh=12,
xybw=500,
xybh=500,
}


































function xianjieController:check2DMapModel()
return xianjieController.is2DMapModel==true
end

function xianjieController:set2DMapModel(flag)
xianjieController.is2DMapModel=flag
end

function xianjieController:init2DMapCfg()
local sceneidx=xianjieModel:getSceneIndex()
local mapSize=xianjieModel:getMapSize(sceneidx)
map2DCfg.w=mapSize[1]
map2DCfg.h=mapSize[2]
local isXJ=sceneidx==xianjienSceneIndexType.eXianJie
map2DCfg.bw=isXJ and map2DCfg.xjbw or map2DCfg.xybw
map2DCfg.bh=isXJ and map2DCfg.xjbh or map2DCfg.xybh
map2DCfg.gw=isXJ and map2DCfg.xjgw or map2DCfg.xygw
map2DCfg.gh=isXJ and map2DCfg.xjgh or map2DCfg.xygh

end

function xianjieController:get2DMapCfg()
return map2DCfg
end

function xianjieController:insert2DEntityQuadtree(ent)
if entityQuadtree==nil then
local baseCfg=xianjieController:get2DMapCfg()

local w=baseCfg.w*baseCfg.gw+baseCfg.bw*2
local h=baseCfg.h*baseCfg.gh+baseCfg.bh*2
local h_w=w/2
local h_h=h/2
entityQuadtree=createQuadtree(-h_w,-h_h,h_w,h_h,3,500)
end
entityQuadtree:insertObj(ent)
end

function xianjieController:remove2DEntityQuadtree(ent)
if entityQuadtree then
local flag=entityQuadtree:removeObj(ent)

if not flag then
logErr(FMT.fmt('从平面四叉树中移除实体时,找不到,m_ojbID={0},l_x={1},l_y={2}',ent.m_ojbID,ent.l_x,ent.l_y))
end

end
end

function xianjieController:clear2DEntityQuadtree()
if entityQuadtree then
releaseQuadtree(entityQuadtree)
entityQuadtree=nil
end
end

function xianjieController:updataAll2DEntities()
if entityLookup_update~=nil then
for key,ent in pairs(entityLookup_update)do
ent:onUpdate()
end
end
end


function xianjieController:removeAll2DEntitys()
if entityLookup~=nil and next(entityLookup)~=nil then
for key,ent in pairs(entityLookup)do
release_xj2DEntity(ent)
end
entityLookup={}
entityLookup_update={}
xianjieController:clear2DEntityQuadtree()



clear_xj2DEntityObjLookup()
end
end

function xianjieController:get2DEntity(key)
if key==nil then return end
return entityLookup[key]
end

function xianjieController:invoke2DEntityFunc(key,funcName,...)
if key==nil then return end
local ent=xianjieController:get2DEntity(key)
if ent then
local f=ent[funcName]
if f~=nil then
return f(ent,...)
end
end
end

function xianjieController:add2DEntity(entityType,iconType,sceneEntityKey,parent,rectAOI)
local key=sceneEntityKey
local ent=new_xj2DEntity(entityType,iconType,sceneEntityKey,parent)
assert(entityLookup[key]==nil)
entityLookup[key]=ent
if ent.onUpdate then
entityLookup_update[key]=ent
end
xianjieController:insert2DEntityQuadtree(ent)
if rectAOI then
ent:refreshAOI(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],rectAOI[5])
end
return key
end

function xianjieController:add2DEntity2(sceneEntity,parent,rectAOI)
local entityType=sceneEntity.entityType
local entity2dcfg=cfgHelper.get2(cfg_xianjieentityconfig_get,entityType,'entity2d')
if entity2dcfg then
local sceneEntityKey=sceneEntity:getKey()
local iconType=sceneEntity:getEntityChildType()
return xianjieController:add2DEntity(entityType,iconType,sceneEntityKey,parent,rectAOI)
end
end

function xianjieController:refresh2DEnity(ent,rectAOI)
xianjieController:remove2DEntityQuadtree(ent)
local flag=ent:onRefresh()
if not flag and rectAOI then
ent:refreshAOI(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],rectAOI[5])
end
xianjieController:insert2DEntityQuadtree(ent)
end

function xianjieController:remove2DEntity(key)
if key==nil then return end
local ent=xianjieController:get2DEntity(key)
if ent then

entityLookup[key]=nil
entityLookup_update[key]=nil
xianjieController:remove2DEntityQuadtree(ent)
release_xj2DEntity(ent)
end
end

function xianjieController:refresh2DMapAOI(x1,y1,x2,y2,mapScale,rectAOI_old)
local result
if entityQuadtree then
result={}
if rectAOI_old then
entityQuadtree:queryRange(result,rectAOI_old[1],rectAOI_old[2],rectAOI_old[3],rectAOI_old[4])
end
entityQuadtree:queryRange(result,x1,y1,x2,y2)
end
if result then
for key,ent in pairs(result)do
ent:refreshAOI(x1,y1,x2,y2,mapScale)
end
end
end

function xianjieController:refresh2DMapAOIScale(x1,y1,x2,y2,mapScale)
local result
if entityQuadtree then
result={}
entityQuadtree:queryRange(result,x1,y1,x2,y2)
end
if result then
for key,ent in pairs(result)do
ent:refreshMapScale(mapScale)
end
end
end


function xianjieController:localPos2gridPos_2DEnity(r_x,r_y)
local baseCfg=xianjieController:get2DMapCfg()
local h_w=baseCfg.w*baseCfg.gw/2
local h_h=baseCfg.h*baseCfg.gh/2

local x=r_x+h_w
local y=r_y+h_h

x=math.floor(x/baseCfg.gw)
y=math.floor(y/baseCfg.gh)
return x,y
end

function xianjieController:gridPos2localPos_2DEnity(r_x,r_y)
local baseCfg=xianjieController:get2DMapCfg()
local h_w=baseCfg.w*baseCfg.gw/2
local h_h=baseCfg.h*baseCfg.gh/2

local x=r_x*baseCfg.gw
local y=r_y*baseCfg.gh

x=x-h_w
y=y-h_h
return x,y
end

function xianjieController:check2DEnityGridPosInMap(g_x,g_y)
local baseCfg=xianjieController:get2DMapCfg()
if g_x>=0 and g_x<baseCfg.w and g_y>=0 and g_y<baseCfg.h then
return true
end
return false
end

function xianjieController:check2DEnityGridPosInInRadius(g_x,g_y,rectAOI)
local result
if entityQuadtree then
result={}
entityQuadtree:queryRange(result,rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4])
end
if result then
for key,ent in pairs(result)do
if ent:checkInCircle(g_x,g_y)then
return true,ent.entityType
end
end
end
return false
end


function xianjieController:getFilterEntity2DCfg(init)

local typeconfig=cfg_fairylandentityicontypeconfig()
if not self.lookupicontypeconfig2 or init then
self.lookUpkeyList={}
self.lookupicontypeconfig2={}
local cfg=cfg_fairylandentityicontypeconfig2()
for k,v in pairs(cfg)do
local show=self:checkFilterShowCdn(v.showCdn)
if show then
local typeCfg=typeconfig[v.type]
local key1=typeCfg.type1
local cfgEx=cfg_fairylandentitybigicontypeconfig_get(key1)
if not self.lookupicontypeconfig2[key1]then
self.lookupicontypeconfig2[key1]={}
local teamp1={}
teamp1.type1=key1
teamp1.list1={}
teamp1.sort=cfgEx.sort or key1
table.insert(self.lookUpkeyList,teamp1)
end
local key2=typeCfg.type2
if not self.lookupicontypeconfig2[key1][key2]then
self.lookupicontypeconfig2[key1][key2]={}
self.lookupicontypeconfig2[key1][key2].type2Id=v.type

for i,v in ipairs(self.lookUpkeyList)do
if v.type1==key1 then
local teamp2={}
teamp2.type2=key2
teamp2.list2={}
table.insert(v.list1,teamp2)
break
end
end
end
local key3=v.type3
if not self.lookupicontypeconfig2[key1][key2][key3]then
self.lookupicontypeconfig2[key1][key2][key3]={}
end
self.lookupicontypeconfig2[key1][key2][key3].id=v.id
local breakFlag=false
for i,v in ipairs(self.lookUpkeyList)do
if v.type1==key1 then
for i2,vv in ipairs(v.list1)do
if vv.type2==key2 then
table.insert(vv.list2,key3)
breakFlag=true
break
end
end
end
if breakFlag then
break
end
end
end
end
table.sort(self.lookUpkeyList,function(a,b)
return tonumber(a.type1)<tonumber(b.type1)
end)
for i,v in ipairs(self.lookUpkeyList)do
table.sort(v.list1,function(a,b)
return tonumber(a.type2)<tonumber(b.type2)
end)
end
for i,v in ipairs(self.lookUpkeyList)do
for i,vv in ipairs(v.list1)do
table.sort(vv.list2,function(a,b)
return a<b
end)
end
end
table.sort(self.lookUpkeyList,function(a,b)
return a.sort<b.sort
end)
end
return self.lookupicontypeconfig2,self.lookUpkeyList
end

function xianjieController:getFilterEntity2DRecord(init)
return xianjieModel:getFilterHUD2Record()


























end

function xianjieController:checkFilterEntity2DRecord(xjicontype)
if xjicontype==nil then return true end
local cfg=cfg_fairylandentityicontypeconfig2_get(xjicontype)
if cfg==nil then return true end
local typeconfig=cfg_fairylandentityicontypeconfig()
local typeCfg=typeconfig[cfg.type]
local type1=typeCfg.type1
local type2=typeCfg.type2
local type3=cfg.type3
local filterRecord=xianjieController:getFilterEntity2DRecord()

if filterRecord[type1]==nil then return true end
if filterRecord[type1][type2]==nil then return true end
return filterRecord[type1][type2][type3]
end

function xianjieController:changeFilterEntity2D(type1,type2,type3)
type2=type2 or"1"
type3=type3 or"1"
local lp=xianjieController:getFilterEntity2DCfg()
local d=lp[type1][type2][type3]
local id=d.id


local list
local rectAOI
if entityQuadtree then
rectAOI=UIManager:invokeUIMethod('UIXianJie_mapWin','getRectAOI')
if rectAOI then
list={}
entityQuadtree:queryRange(list,rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4])
end
end
if list~=nil then
for key,ent in pairs(list)do
if ent.xjicontype==id then
ent:refreshAOI(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],rectAOI[5])
end
end
end
end

function xianjieController:changeFilterEntity2DEx(type1,type2,type3)
local lp=xianjieController:getFilterEntity2DCfg()

local idLookup={}
local t1=lp[type1]
for _type2,v in pairs(t1)do
if type2 then
if _type2==type2 then
for _type3,vv in pairs(v)do
if type(vv)=="table"then
if type3 then
if _type3==type3 then
idLookup[vv.id]=true
end
else
idLookup[vv.id]=true
end
end
end
end
else
for _type3,vv in pairs(v)do
if type(vv)=="table"then
if type3 then
if _type3==type3 then
idLookup[vv.id]=true
end
else
idLookup[vv.id]=true
end
end
end
end
end


local list
local rectAOI
if entityQuadtree then
rectAOI=UIManager:invokeUIMethod('UIXianJie_mapWin','getRectAOI')
if rectAOI then
list={}
entityQuadtree:queryRange(list,rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4])
end
end
if list~=nil then
for key,ent in pairs(list)do
if idLookup[ent.xjicontype]then
ent:refreshAOI(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],rectAOI[5])
end
end
end
end

function xianjieController:createXjIcon(abname,iconname,extra,parentWidget,index)
if iconname then
if abname==nil then
parentWidget:SetChildCSImageIcon(index,iconname,true)
else
parentWidget:SetChildCSImageSprite(index,abname,iconname)
end
else
parentWidget:SetChildCSImageIcon(index,'',false)
end
local scale=1
if extra and extra.scale then
scale=extra.scale
end
parentWidget:SetChildScale(index,Vector3.New(scale,scale,scale))

local typo=extra and extra[1]
if typo then
local instanceID=extra[2]
local parentTrans=parentWidget:GetCommonComponent(index,'Transform')
return _InstantiateManager.AddInstance(instanceID,parentTrans,function(id)
local widget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
xianjieController:fillExtraItem(typo,extra,widget,abname)
end)
end
end

function xianjieController:removeXjIcon(guid)
_InstantiateManager.RemoveInstance(guid)
end

local _extraIconfunc=
{
[1]=function(...)
xianjieController:fillExtraItem_1(...)
end
}

function xianjieController:fillExtraItem(typo,extra,widget,abname)
if _extraIconfunc[typo]then
_extraIconfunc[typo](extra,widget,abname)
end
end

function xianjieController:fillExtraItem_1(extra,widget,abname)
local iconname=extra[3]
if abname==nil then
widget:SetChildCSImageIcon(0,iconname,true)
else
widget:SetChildCSImageSprite(0,abname,iconname)
end
widget:SetChildText(2,extra[4])
end

function xianjieController:checkFilterShowCdn(showCdn)
if not showCdn then
return true
end
local type=showCdn[1]
local args=showCdn[2]
if type==1 then
local mtype=args[1]
local limtLevel=args[2]
local min,curMaxlevel=xianjieController:getMonsterMaxlevel(mtype)
if curMaxlevel<limtLevel then
return false
end
elseif type==2 then
return false
elseif type==3 then
return XingYuController.checkSysOpen()
elseif type==4 then
local stage=seasonModel:findStage(args)
return stage~=nil and seasonController:checkSeasonStageBegined(stage.handle.id,stage.index)
elseif type==5 then
for seasonType,seasonHandle in pairs(seasonModel.data)do
if args[seasonType]~=nil and args[seasonType]<=xianjieController:getSeaonCurFogId(seasonType)then
return true
end
end
return false
end
return true
end

function xianjieController:refreshFilterlookup()
xianjieController:getFilterEntity2DCfg(true)

xianjieModel:getFilterHUD2Record(true)
UIManager:invokeUIMethod("UIXianJie_filteEntity2DWin","refreshCurWin")
UIManager:invokeUIMethod("UIXianJie_filteHUD2Win","refreshCurWin")
end
