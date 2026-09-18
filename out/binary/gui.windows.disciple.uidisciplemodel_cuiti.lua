







function UIDiscipleModel:initCuiTiData()
local curTiFloorNameLookup={}
self.curTiFloorNameLookup=curTiFloorNameLookup
local curTiFloorSpineLookup={}
self.curTiFloorSpineLookup=curTiFloorSpineLookup
local cfgs=cfg_discipleqizhencuiticonfig()
for i,v in ipairs(cfgs)do
if v.floorname~=nil then
curTiFloorNameLookup[v.floor]={v.floorname,v.id}
curTiFloorSpineLookup[v.floor]={v.floorspine,v.flooreffect}
end
end
end

function UIDiscipleModel:clearCuiTiData()
self.curTiFloorNameLookup=nil
self.curTiFloorSpineLookup=nil
end

function UIDiscipleModel.checkCuiTiFull(ctlv)
local cfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,ctlv+1)
return cfg==nil
end

function UIDiscipleModel:getCuiTiFloor(ctlv)
local floor=cfgHelper.get2(cfg_discipleqizhencuiticonfig_get,ctlv,'floor')
local d=self.curTiFloorNameLookup[floor]
local jie=ctlv-d[2]
return floor,jie
end

function UIDiscipleModel:getCuiTiName(guid,typo)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getCuiTiNameEx(netData.qzctlv,typo)
end

function UIDiscipleModel:getCuiTiNameEx(ctlv,typo)
local floor,jie=UIDiscipleModel:getCuiTiFloor(ctlv)
local d=self.curTiFloorNameLookup[floor]
local str
if typo==1 then
str=d[1]
elseif typo==2 then
str=FMT.fmt('{0}{1}阶',d[1],jie)
elseif typo==3 then
str=FMT.fmt('{0}({1}阶)',d[1],jie)
end
return str,jie
end
function UIDiscipleModel:getCuiTiNameEx2(ctlv)
local floor,jie=UIDiscipleModel:getCuiTiFloor(ctlv)
local d=self.curTiFloorNameLookup[floor]
local str
if jie==0 then
str=FMT.fmt('{0}',d[1])
else
str=FMT.fmt('{0}({1}阶)',d[1],jie)
end
return str,jie
end

function UIDiscipleModel:getCuiTiFloorSpine(ctlv)
local floor=cfgHelper.get2(cfg_discipleqizhencuiticonfig_get,ctlv,'floor')
local d=self.curTiFloorSpineLookup[floor]
return d[1],d[2]
end

function UIDiscipleModel:getDZCuiTi2LianTianRate(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local qzctlv=netData.qzctlv
local qzcfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,qzctlv)
if qzcfg and qzcfg.percent then
return qzcfg.percent
end
return 0
end

function UIDiscipleModel:getDZCuiTiUpCost(guid,ctlv)
local netData=UIDiscipleModel:getDiscipleData(guid)
ctlv=ctlv or netData.qzctlv
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
local job=imageInfo.job
local cfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,ctlv)
local consume=cfg.consume
local temp=consume[job]or consume[0]
local goods
if temp==nil then
goods={}
else
goods=table.weakCopy(temp)
end
local exp=cfg.exp
local needExp=exp[job]or exp[0]
table.insert(goods,1,{-1,needExp})
return goods
end

function UIDiscipleModel:checkDZCuiTiReddot(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local ctlv=netData.qzctlv
local isfull=UIDiscipleModel.checkCuiTiFull(ctlv)
if not isfull then
local ltlv=netData.liantilv
local ltlv_=cfgHelper.get2(cfg_discipleqizhencuiticonfig_get,ctlv,'lianti')
if ltlv_~=nil then
if ltlv<ltlv_ then
return false,-2
end
end

local costs=UIDiscipleModel:getDZCuiTiUpCost(guid)
local goodid
local needItemCount
for i,v in ipairs(costs)do
local itemID=v[1]
local needNum=v[2]
local hasNum
if itemID==-1 then
hasNum=netData.qzctexp
else
hasNum=itemsModel.getCount(itemID)
end
if hasNum<needNum then
goodid=itemID
needItemCount=needNum
break
end
end
if goodid==nil then
return true
else
return false,goodid,needItemCount
end
end
return false
end


function UIDiscipleModel:checkDZCuiTiReddotEx(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local ctlv=netData.qzctlv
local isfull=UIDiscipleModel.checkCuiTiFull(ctlv)
if not isfull then
local ltlv=netData.liantilv
local ltlv_=cfgHelper.get2(cfg_discipleqizhencuiticonfig_get,ctlv,'lianti')
if ltlv_~=nil then
if ltlv<ltlv_ then
return false
end
end

local costs=UIDiscipleModel:getDZCuiTiUpCost(guid)
for i,v in ipairs(costs)do
if v[1]==-1 then
if netData.qzctexp>=v[2]then
return true
end
end
end
end
return false
end

function UIDiscipleModel.getDZCuiTiAttrChange(oldctlv,ctlv,lookup2,rate2)
local qzcfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,ctlv)
local o_qzcfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,oldctlv)
local lookup={}
local attrTypes={eAttributeType.eATK,eAttributeType.eDEF,eAttributeType.eHP}
for i,v in ipairs(attrTypes)do
lookup[v]={v,lookup2[v]or 0}
end
lookup[-1]={-1}
lookup[-1][4]=o_qzcfg.percent or 0
lookup[-1][2]=lookup[-1][4]+(rate2 or 0)
if o_qzcfg.attr~=nil then
for i,v in ipairs(o_qzcfg.attr)do
local d=lookup[v[1]]
if d~=nil then
d[4]=v[2]
d[2]=d[2]+v[2]
end
end
end
if qzcfg and qzcfg.attr~=nil then
if qzcfg.attr~=nil then
for i,v in ipairs(qzcfg.attr)do
local d=lookup[v[1]]
if d~=nil then
d[3]=v[2]-d[4]
end
end
end
lookup[-1][3]=(qzcfg.percent or 0)-lookup[-1][4]
end
local attrlist={}
for i,v in ipairs(attrTypes)do
attrlist[#attrlist+1]=lookup[v]
end
attrlist[4]=lookup[-1]
return attrlist
end

function UIDiscipleModel.getDZCuiTiAttrChangeEx(oldctlv,ctlv,lookup2,rate2)
local qzcfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,ctlv)
local o_qzcfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,oldctlv)
local lookup={}
local attrTypes={eAttributeType.eATK,eAttributeType.eDEF,eAttributeType.eHP}
for i,v in ipairs(attrTypes)do
lookup[v]={v,lookup2[v]or 0}
end
lookup[-1]={-1}
lookup[-1][4]=o_qzcfg.percent or 0
lookup[-1][2]=lookup[-1][4]+(rate2 or 0)
if o_qzcfg.attr~=nil then
for i,v in ipairs(o_qzcfg.attr)do
local d=lookup[v[1]]
if d~=nil then
d[4]=d[2]
d[2]=d[2]+v[2]
end
end
end
if qzcfg and qzcfg.attr~=nil then
if qzcfg.attr~=nil then
for i,v in ipairs(qzcfg.attr)do
local d=lookup[v[1]]
if d~=nil then
d[3]=d[4]+v[2]
end
end
end
lookup[-1][3]=(qzcfg.percent or 0)+(rate2 or 0)
end
local attrlist={}
for i,v in ipairs(attrTypes)do
attrlist[#attrlist+1]=lookup[v]
end
attrlist[#attrlist+1]=lookup[-1]
return attrlist
end

function UIDiscipleModel:getCuiTiCostGoods(guid,lookup)
lookup=lookup or{}
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local qzctlv=netData.qzctlv
if qzctlv>1 then
for ctlv=1,qzctlv-1 do
local costs=UIDiscipleModel:getDZCuiTiUpCost(guid,ctlv)
if costs then
for i,data in ipairs(costs)do
local itemid=data[1]
local itemnum=data[2]
if itemid~=-1 then
lookup[itemid]=lookup[itemid]or 0
lookup[itemid]=lookup[itemid]+itemnum
end
end
end
end
end
end
return lookup
end



function UIDiscipleModel:geteatitem(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData.qzlistlen<=0 then
return
end
return netData.qzList
end


function UIDiscipleModel:showQZBtn(guid)
local isshow=UIDiscipleModel:geteatitem(guid)

if not isshow then
return false
else
return true
end
end

function UIDiscipleModel:resetcost(ctlv,job)
local reset=cfgHelper.get2(cfg_discipleqizhencuiticonfig_get,ctlv,'reset')
local temp=reset[job]or reset[0]
return temp
end

function UIDiscipleModel:resetnum()
local const_def=cfg_discipleqizhencuiticonfig().const_def
local reset=const_def.reset
local usenum=gameUtilityModel:getData_counter(30)
return usenum,reset
end