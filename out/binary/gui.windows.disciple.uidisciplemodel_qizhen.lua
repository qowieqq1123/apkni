







local qzJobGroupList

function UIDiscipleModel:initQiZhenGroup()
qzJobGroupList={}
local qzlookup={}
local cfgs=cfg_discipleqizhenconfig()
for itemid,cfg in pairs(cfgs)do
local ctlv=cfg.cuiti
for jobid,v in pairs(cfg.max)do
if qzlookup[jobid]==nil then
qzlookup[jobid]={}
end
if qzlookup[jobid][ctlv]==nil then
qzlookup[jobid][ctlv]={}
end
table.insert(qzlookup[jobid][ctlv],cfg)
end
end
for jobid,v in pairs(qzlookup)do
if qzJobGroupList[jobid]==nil then
qzJobGroupList[jobid]={}
end
for ctlv_,vv in pairs(v)do
local group={}
group.ctlv=ctlv_
local list={}
for i,cfg in ipairs(vv)do
list[i]=cfg
end
group.list=list
table.insert(qzJobGroupList[jobid],group)
end
if#qzJobGroupList[jobid]>1 then
table.sort(qzJobGroupList[jobid],function(a,b)
return a.ctlv<b.ctlv
end)
end
end
end

function UIDiscipleModel:clearQiZhenGroup()
qzJobGroupList=nil
end

function UIDiscipleModel:initDZQiZhenData(netData)
local qzItemlookup={}
local qzList=netData.qzList
if qzList then
local dels={}
for i,v in ipairs(qzList)do
local itemid=v.param_1
local cfg=cfgHelper.get1(cfg_discipleqizhenconfig_get,itemid)
if cfg~=nil then
qzItemlookup[itemid]=qzList[i]
else
table.insert(dels,i)
end
end

if#dels>0 then
for i=#dels,1,-1 do
table.remove(qzList,dels[i])
end
end
end
netData.qzItemlookup=qzItemlookup
end

function UIDiscipleModel:getDZQiZhenItemProgress(guid,itemid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDZQiZhenItemProgressEx(netData,itemid)
end

function UIDiscipleModel:getDZQiZhenItemProgressEx(netData,itemid)
local ctlv=netData.qzctlv
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
local jobid=imageInfo.job
local hasnum=bagModel.getItemCountById(itemid)
local usenum=UIDiscipleModel:getQiZhenCurUse(netData,itemid)
local maxlist=cfgHelper.get3(cfg_discipleqizhenconfig_get,itemid,'max',jobid)
local max_usenum,f_max_usenum,f_ctlv=UIDiscipleModel.getQiZhenMaxUse(maxlist,ctlv)
local isfull=usenum>=max_usenum
local isfull_f=usenum>=f_max_usenum
return usenum,max_usenum,hasnum,isfull,isfull_f,f_ctlv
end

function UIDiscipleModel:getQiZhenCurUse(netData,itemid)
local usenum=0
if netData then
if netData.qzItemlookup[itemid]then
return netData.qzItemlookup[itemid].param_2
end
end
return usenum
end

function UIDiscipleModel.getQiZhenMaxUse(maxlist,ctlv)
if maxlist then
local max_usenum
local f_max_usenum
local f_ctlv
local n=#maxlist
for i,v in ipairs(maxlist)do
if ctlv<=v[1]then
max_usenum=v[2]
f_ctlv=v[1]
if i<n then
f_max_usenum=maxlist[i+1][2]
else
f_max_usenum=max_usenum
end
break
end
end
if max_usenum==nil then
max_usenum=maxlist[n][2]
f_max_usenum=max_usenum
f_ctlv=maxlist[n][1]
end
return max_usenum,f_max_usenum,f_ctlv
end
return 0,0,0
end

function UIDiscipleModel:checkDZQiZhenOpen(isWarning)
local flag=systemModel.isOpen(SYSTEM_DEFINE.eQiZhen)
if not flag then
if isWarning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eQiZhen)
UIManager.error(tips)
end
end
return flag
end

function UIDiscipleModel:getQiZhenGroupList(jobid,ctlv,isex)
local result={}
local maxGroupIndex=0
if qzJobGroupList[jobid]then
for idx,g in ipairs(qzJobGroupList[jobid])do
if ctlv>=g.ctlv then
maxGroupIndex=idx
local group={}
group.ctlv=g.ctlv
local list={}
for i,cfg in ipairs(g.list)do
list[i]={cfg=cfg}
end
group.list=list
table.insert(result,group)
else

if idx==1 then
break
end
end
end
end
if isex and maxGroupIndex>0 then

maxGroupIndex=maxGroupIndex+1
local g=qzJobGroupList[jobid][maxGroupIndex]
if g then
local group={}
group.ctlv=g.ctlv
local list={}
for i,cfg in ipairs(g.list)do
list[i]={cfg=cfg}
end
group.list=list
table.insert(result,group)
end
end
return result
end

function UIDiscipleModel:getDZQiZhan2LianTianRate(guid)
local rate=0
local netData=UIDiscipleModel:getDiscipleData(guid)
local qzList=netData.qzList
if qzList~=nil then
for i,v in ipairs(qzList)do
local itemid=v.param_1
local itemnum=v.param_2
local cfg=cfgHelper.get1(cfg_discipleqizhenconfig_get,itemid)
if cfg and cfg.percent then
rate=rate+cfg.percent*itemnum
end
end
end
return rate
end

function UIDiscipleModel:getDZQiZhenGroupList(netData)
local ctlv=netData.qzctlv
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
local jobid=imageInfo.job
local qzGroupList=UIDiscipleModel:getQiZhenGroupList(jobid,ctlv)
return qzGroupList
end

function UIDiscipleModel:checkDZQiZhenSystemReddot(guid)
local isOpen=UIDiscipleModel:checkDZQiZhenOpen()
return isOpen and UIDiscipleModel:checkDZQiZhenReddot(guid)or UIDiscipleModel:checkDZCuiTiReddot(guid)
end

function UIDiscipleModel:checkDZQiZhenReddot(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local qzGroupList=UIDiscipleModel:getDZQiZhenGroupList(netData)
if#qzGroupList>0 then
for i,group in ipairs(qzGroupList)do
if UIDiscipleModel:checkDZQiZhenGroupReddotEx(netData,i)then
return true,i
end
end
end
return false
end

function UIDiscipleModel:checkDZQiZhenGroupReddot(guid,groupIndex)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:checkDZQiZhenGroupReddotEx(netData,groupIndex)
end

function UIDiscipleModel:checkDZQiZhenGroupReddotEx(netData,groupIndex)
local qzGroupList=UIDiscipleModel:getDZQiZhenGroupList(netData)
local g=qzGroupList[groupIndex]
if g then
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
local ltlv=netData.liantilv
local jobid=imageInfo.job
local ctlv=netData.qzctlv
if ctlv>=g.ctlv then
local list=g.list
for i,data in ipairs(list)do
local cfg=data.cfg
local fix_lv=true
if cfg.lianti then
fix_lv=ltlv>=cfg.lianti
end
if fix_lv then
local itemid=cfg.id
local hasnum=bagModel.getItemCountById(itemid)
if hasnum>0 then
local usenum=UIDiscipleModel:getQiZhenCurUse(netData,itemid)
local maxlist=cfg.max[jobid]
local max_usenum=UIDiscipleModel.getQiZhenMaxUse(maxlist,ctlv)
if usenum<max_usenum then
return true
end
end
end
end
end
end
return false
end




















function UIDiscipleModel:getQiZhenCostGoods(guid,lookup)
lookup=lookup or{}
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local qzList=netData.qzList
if qzList~=nil then
for i,v in ipairs(qzList)do
local itemid=v.param_1
local itemnum=v.param_2
lookup[itemid]=lookup[itemid]or 0
lookup[itemid]=lookup[itemid]+itemnum
end
end
end
return lookup
end