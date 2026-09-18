













jiuChongTianJieSubSys_dujiexiandan=jiuChongTianJieSubSysBase.new({sysType=JIUCHONGTIANJIE_SUB_SYS_TYPE.eDuJieXianDan})


function jiuChongTianJieSubSys_dujiexiandan:checkFinish()
return jctjDuJieXianDanModel:getLianZhiEndFlag()==1
end

function jiuChongTianJieSubSys_dujiexiandan:getProgress()
if jctjDuJieXianDanModel:getLianZhiEndFlag()==1 then
return 100,100
end

local jd=jctjDuJieXianDanModel:getLianZhiJieDuan()
if not jctjDuJieXianDanModel:isLianDanFinish()then
jd=jd-1
end
if jd==#cfg_dujiexiandanniliandanwenconfig()and jctjDuJieXianDanModel:getLianZhiEndFlag()~=1 then
jd=jd-1
end
local config=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jd)
if config then
return config.jindu*100,100
else
return 0,100
end
end

function jiuChongTianJieSubSys_dujiexiandan:getReddot(isEnter)
return jctjDuJieXianDanController:checkReddot()and jctjDuJieXianDanModel:getLianZhiEndFlag()~=1
end

function jiuChongTianJieSubSys_dujiexiandan:jump()
if jctjDuJieXianDanModel:getLianZhiEndFlag()==1 then
UIManager.error("渡劫仙丹已炼制完成")
return false
end
local lianZhiEnt=jctjDuJieXianDanModel:getLianZhiBuild()
if lianZhiEnt and lianZhiEnt~=0 then
local bdData=zongmenModel:getBuildingData(lianZhiEnt)
if not bdData then
UIManager.error("炼丹坊已收纳")
return false
end
end
UIFullJiuChongTianJieControl:closeUI()
return UIFullLianDanFangControl:showDuJieXianDan()
end

function jiuChongTianJieSubSys_dujiexiandan:getBuffList()
local list={}
local buff=jctjDuJieXianDanModel:checkXQCYBuff()
if buff then
local descT=cfgHelper.get(cfg_dujiexiandanbaseconfig_get,1,"xqcydesc")
table.insert(list,FMT.fmt(descT[1],buff*100))
end

local peoplenum=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local sjduce=0
local server_reduce_conf=cfgHelper.get2(cfg_dujiexiandanbaseconfig_get,1,'server_reduce_conf')or{}
for k,v in ipairs(server_reduce_conf)do
if peoplenum>=v[1]and peoplenum<=v[2]then
sjduce=v[3]
end
end
if sjduce>0 then
local desc2=FMT.fmt("炼制耗时减少{0}%",sjduce)
table.insert(list,desc2)
end

return list
end