






local _MODULENAME="DianFengLevelModel"


def_table(_MODULENAME)
DianFengLevelModel.name=_MODULENAME
DianFengLevelModel.data={}

DFhandleType=
{
build=1,
attr=2,
xianbao=3,
huobi=4
}
local point_build={}
local point_xianbao={}

local handle={

[DFhandleType.build]={
freshPointData=function(pointid)
if point_build then
local type=DFhandleType.build
local cfg=cfg_dianfengleveleffectconfig_get(pointid)
local buildid=cfg.specialid
local value=DianFengLevelModel:getDFPointValue(type,pointid,cfg)
point_build[buildid]=value
end
end,
getPointData=function()
return point_build
end,
resetPointData=function()
point_build={}
end,
},

[DFhandleType.xianbao]={
freshPointData=function(pointid)
if point_xianbao then
local type=DFhandleType.xianbao
local cfg=cfg_dianfengleveleffectconfig_get(pointid)
local effectid=cfg.specialid
local value=DianFengLevelModel:getDFPointValue(type,pointid,cfg)
point_xianbao[effectid]=value
end
end,
getPointData=function()
return point_xianbao
end,
resetPointData=function()
point_xianbao={}
end,
},

}
function DianFengLevelModel:getHandle(eType)
return handle[eType]
end


function DianFengLevelModel:onAppStart()

end


function DianFengLevelModel:onEnterState(isReconnect)

end


function DianFengLevelModel:onProtocolReq()

end


function DianFengLevelModel:onLeaveState(isReconnect)

self.data={}
end


function DianFengLevelModel:initdata(level,exp,resetCount,addPoint,len,pointList,playflag)
self.data.level=level or 1
self.data.exp=exp or 0
self.data.resetCount=resetCount or 0
self.data.addPoint=addPoint or 0
self.data.pointList={}
self.data.pointArry={}
if len>0 and pointList then
for k,v in pairs(pointList)do
self.data.pointList[v.param_1]=v.param_2
local cfg=cfg_dianfengleveleffectconfig_get(v.param_1)
if cfg then
if self.data.pointArry[cfg.effectType]then
table.insert(self.data.pointArry[cfg.effectType],v.param_1)
else
self.data.pointArry[cfg.effectType]={v.param_1}
end
end
end
end
self:initDFPointData(self.data.pointArry)
self.data.playflag=playflag
end


function DianFengLevelModel:setLevelUp(level,exp)
self.data.level=level
self.data.exp=exp
end


function DianFengLevelModel:setPointAdd(param_1,param_2)
if self.data.pointList then
self.data.pointList[param_1]=param_2
self.data.addPoint=self.data.addPoint+1
end
if self.data.pointArry then
local cfg=cfg_dianfengleveleffectconfig_get(param_1)
if self.data.pointArry[cfg.effectType]then
table.insert(self.data.pointArry[cfg.effectType],param_1)
else
self.data.pointArry[cfg.effectType]={param_1}
end
end
self:freshDFPointData(param_1)
end


function DianFengLevelModel:resetPoint(resetCount)
self.data.resetCount=resetCount
self.data.pointList={}
self.data.pointArry={}
self.data.addPoint=0
self:resetDFPointData()
end


function DianFengLevelModel:freshlevelexp(exp)
self.data.exp=exp
end


function DianFengLevelModel:getLevel()
return self.data.level or 1
end

function DianFengLevelModel:getExp()
if self.data.exp then
return tonumber(tostring(self.data.exp))
end
return 0
end

function DianFengLevelModel:getaddPointNum()
return self.data.addPoint or 0
end

function DianFengLevelModel:getresetNum()
return self.data.resetCount or 0
end

function DianFengLevelModel:getPointListByid(pointid)
if self.data.pointList then
return self.data.pointList[pointid]or 0
end
return 0
end

function DianFengLevelModel:getPointPointArryByid(effectType)
if self.data.pointArry then
return self.data.pointArry[effectType]
end
end

function DianFengLevelModel:getDianFengXianBaoID()
return cfg_dianfenglevelbaseconfig_get(1).dfxbid
end

function DianFengLevelModel:checkDianFengLvlMax()
local dflevel=self:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel+1)
return not cfglvl and true or false
end

function DianFengLevelModel:freshXBTJWin()
local xianbao_id=DianFengLevelModel:getDianFengXianBaoID()
UIManager:callWindowFunc('UIXianBaoTuJianWin','freshXbItem',xianbao_id)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianBao)
end

function DianFengLevelModel:testttt()
UIManager:showWindow("UIXianTuChengJiuGuBaoLevelUpWin",{id=1,oldlv=1,newlv=2,})
UIManager:showWindow("UIDianFengZhiBaoLvlUpWin",{id=3,oldlv=1,newlv=2,})
end





















function DianFengLevelModel:calculationAttrLookup(lookup,dflevel)
if lookup==nil then return end
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)

local baseAttr=cfglvl.attrs
if baseAttr and next(baseAttr)then
for i,v in ipairs(baseAttr)do
lookup[v[1]]=lookup[v[1]]or 0
lookup[v[1]]=lookup[v[1]]+v[2]
end
end
end

function DianFengLevelModel:getDianFengXianBaoAttrList(lookupList,GBaddval,xbId)
if not GBaddval then GBaddval=0 end
local dflevel=self:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local baseAttr=cfglvl.attrs
if baseAttr and next(baseAttr)then
for i,v in ipairs(baseAttr)do
local attrId=v[1]
local attrCfgVal=v[2]
lookupList[attrId]=(lookupList[attrId]or 0)+attrCfgVal
if not attrListHelper.isMod(attrId)then
lookupList[attrId]=math.floor(lookupList[attrId]*(1+GBaddval/100))
end
end
end
return lookupList
end


function DianFengLevelModel:getDFPointValue(flag,pointid,cfg)
if cfg==nil then return 0 end
local allvalue=0
local effect=cfg.effect
local pointnum=self:getPointListByid(pointid)

if flag==DFhandleType.build or flag==DFhandleType.xianbao then
for k,v in ipairs(effect)do
local min=v[1]
local max=v[2]
if max<=pointnum then
for i=min,max do
allvalue=allvalue+v[3]
end
else
for i=min,pointnum do
allvalue=allvalue+v[3]
end
end
end
return allvalue
end
end

function DianFengLevelModel:initDFPointData(Arry)
for k,eType in pairs(DFhandleType)do
local pointdata=Arry[eType]
local handel=self:getHandle(eType)
if pointdata and handel and handel.freshPointData then
for k,pointid in ipairs(pointdata)do
handel.freshPointData(pointid)
end
end
end
end

function DianFengLevelModel:freshDFPointData(pointid)
local cfg=cfg_dianfengleveleffectconfig_get(pointid)
local eType=cfg.effectType
local handel=self:getHandle(eType)
if handel and handel.freshPointData then
handel.freshPointData(pointid)
end
end

function DianFengLevelModel:resetDFPointData()
for k,eType in pairs(DFhandleType)do
local handel=self:getHandle(eType)
if handel and handel.resetPointData then
handel.resetPointData()
end
end
end


function DianFengLevelModel:getDFProduceUpPercent(buildid)
local eType=DFhandleType.build
local handel=self:getHandle(eType)
if handel and handel.getPointData then
local pdata=handel.getPointData()
if pdata[buildid]then
return mathHelper.floor(pdata[buildid]/100)
end
end
return 0
end






function DianFengLevelModel:getDFXianBaoBuildPercent(effectType)
local eType=DFhandleType.xianbao
local handel=self:getHandle(eType)
if handel and handel.getPointData then
local pdata=handel.getPointData()
return pdata[effectType]or 0
end
return 0
end


function DianFengLevelModel:testttt()

end





