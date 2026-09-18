local _tabReddot={
[eXianTuChengJiuTabType.ZongMenXianTu]=function()
return xiantuchengjiuModel:getZMXTReddot()
end,
[eXianTuChengJiuTabType.XianTuChengJiu]=function()
return xiantuchengjiuModel:getXTCJReddot()
end,
[eXianTuChengJiuTabType.FeiShengDaoTu]=function()
return xiantuchengjiuModel:getFSDTReddot()
end,
}

function xiantuchengjiuModel:getTaskReddot(eType,eKey1,eKey2)
local data=self:getTaskData(eType,eKey1,eKey2)
if data then
return self:getTaskReddotEx(data)
end
return false
end

function xiantuchengjiuModel:getTaskReddotEx(data)
local progress=self:getTaskProgressShowEx(data)
local index=data.flag+1
local aim=data.aims[index]
if aim then
return progress>=aim
end
return false
end

function xiantuchengjiuModel:getZMXTReddot()
local cfg=cfg_sectxiantuconfig()
for i,v in pairs(cfg)do
if self:getZMXTReddot_Single(i)then
return true
end
if xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.ZongMenXianTu,i)and not xiantuchengjiuModel:getAnimationRecord(i)then
return true
end
end
return false
end

function xiantuchengjiuModel:getZMXTReddot_Single(key)
local eType=eXianTuChengJiuTabType.ZongMenXianTu
local cfg=xiantuchengjiuModel:getTaskConfig(eType,key)
local complete=true
for index,info in pairs(cfg)do
local over=self:isTaskOver(eType,key,index)
complete=complete and over
if not over and xiantuchengjiuModel:getTaskReddot(eType,key,index)then
return true
end
end
if complete then
local times=xiantuchengjiuModel:getZMXTTimes(key)or 0
if times<1 then
return true
end
end
return false
end

function xiantuchengjiuModel:getZMXTSpecialFlag()
local config=cfg_sectxiantuconfig()
local eType=eXianTuChengJiuTabType.ZongMenXianTu
for eKey1,cfg in pairsBySortKey(config)do
local taskCfg1=xiantuchengjiuModel:getTaskConfig(eType,eKey1)
local complete=true
for eKey2,taskCfg2 in pairs(taskCfg1)do
local over=self:isTaskOver(eType,eKey1,eKey2)
if not over then
local reddot=xiantuchengjiuModel:getTaskReddot(eType,eKey1,eKey2)
return reddot,eKey1,eKey2
end
complete=complete and over
end

if complete then
local times=xiantuchengjiuModel:getZMXTTimes(eKey1)or 0
if times<1 then
return true,eKey1
end
end

if xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.ZongMenXianTu,eKey1)and not xiantuchengjiuModel:getAnimationRecord(eKey1)then
return true,eKey1
end
end
end

function xiantuchengjiuModel:getXTCJReddot()
local cfg=cfg_xiantuachieveconfig()
for i,v in pairs(cfg)do
if self:getXTCJReddot_Single(i)then
return true
end
end
return false
end

function xiantuchengjiuModel:getXTCJReddot_GuBao(key)
local gbId=cfgHelper.get2(cfg_xiantuachieveconfig_get,key,"gubao")
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbId)
local gbData=gubaoModel:getDataByID(gbId)
if gbData then
local curLv=gbData.gubaoskilllv
local tarLv=curLv
if tarLv<#gbCfg.level then
local cost=gbCfg.level[curLv]
if cost then
for i,v in ipairs(cost)do
local need=v[2]
local have=itemsModel.getCount(v[1])
if have<need then
return false
end
end
return true
end
end
end
return false
end

function xiantuchengjiuModel:getXTCJReddot_Single(key)
local eType=eXianTuChengJiuTabType.XianTuChengJiu
local cfg=xiantuchengjiuModel:getTaskConfig(eType,key)
for index,info in pairs(cfg)do
if not self:isTaskOver(eType,key,index)and self:checkTaskOpen(eType,key,index)and xiantuchengjiuModel:getTaskReddot(eType,key,index)then
return true
end
end

return self:getXTCJReddot_GuBao(key)
end

function xiantuchengjiuModel:getFSDTReddot()
local eType=eXianTuChengJiuTabType.FeiShengDaoTu
local current=self:getFSDTCurrent()
if current>0 then
local cfg=xiantuchengjiuModel:getTaskConfig(eType,current)
for i,v in pairs(cfg)do
if self:getTaskReddot(eType,current,i)then
return true
end
end
end
return false
end

function xiantuchengjiuModel:getTabReddot(eType)
return _tabReddot[eType]()
end