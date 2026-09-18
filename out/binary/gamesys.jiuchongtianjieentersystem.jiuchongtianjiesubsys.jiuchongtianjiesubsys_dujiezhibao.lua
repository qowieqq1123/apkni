













jiuChongTianJieSubSys_dujiezhibao=jiuChongTianJieSubSysBase.new({sysType=JIUCHONGTIANJIE_SUB_SYS_TYPE.eDuJieZhiBao})

jiuChongTianJieSubSys_dujiezhibao.progressType=eJiuChongTianJieSysType.eNumber

jiuChongTianJieSubSys_dujiezhibao.showProgessNum=0



function jiuChongTianJieSubSys_dujiezhibao:checkFinish()
return false
end

function jiuChongTianJieSubSys_dujiezhibao:getProgress()
local now=DuJieZhiBaoController:getAllBuildJinDu()
return now,10
end

function jiuChongTianJieSubSys_dujiezhibao:getReddot(isEnter)
return DuJieZhiBaoController:getDJZBAllReddot()
end

function jiuChongTianJieSubSys_dujiezhibao:jump()
UIFullJiuChongTianJieControl:closeUI()
DuJieZhiBaoController:JCTJjumpBuild()
end

function jiuChongTianJieSubSys_dujiezhibao:getBuffList()
local list={}
local peoplenum=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local jdduce=0
local sjduce=0
local server_reduce_conf=cfgHelper.get2(cfg_dujietreasuresbasicconfig_get,1,'server_reduce_conf')
for k,v in ipairs(server_reduce_conf)do
if peoplenum>=v[1]and peoplenum<=v[2]then
jdduce=v[3]
sjduce=v[4]
end
end
if jdduce>0 then
local desc=FMT.fmt("炼化进度减少{0}%",jdduce)
table.insert(list,desc)
end
if sjduce>0 then
local desc2=FMT.fmt("修复耗时减少{0}%",sjduce)
table.insert(list,desc2)
end
return list
end