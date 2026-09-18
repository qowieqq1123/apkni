







function UIDiscipleModel:initXianMoData()
self.xianXinFaStage=0
self.moXinFaStage=0
self.xinfaBranchData={}
self.xianmoDiscipleCache={}
self.xinFaBranchUpdateFlag=0
end

function UIDiscipleModel:clearXianMoData()
self.xianXinFaStage=nil
self.moXinFaStage=nil
self.xinfaBranchData=nil
self.xianmoDiscipleCache=nil
self.xinFaBranchUpdateFlag=nil
self.branchAttrs=nil
self.JJ_percent=nil
self.LT_percent=nil
self.xianDiscipleCount=nil
self.moDiscipleCount=nil
self.targetXinFaData=nil
end

function UIDiscipleModel:setXinFaBranchUpdateFlag(pos)
if pos<0 then
self.xinFaBranchUpdateFlag=0
else
bitHelper.set_1(self.xinFaBranchUpdateFlag,pos)
end
end

function UIDiscipleModel:getXinFaBranchUpdateFlag()
return self.xinFaBranchUpdateFlag
end

function UIDiscipleModel:initXianMoDiscipleCache()
self.xianmoDiscipleCache={}
local discipleNetData=UIDiscipleModel:getAllDiscipleData()
local dis_list={}
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
UIDiscipleModel:updateXianMoDiscipleCache(netData.discipleguid)
if netData and(netData.xianmo_voc==1 or netData.xianmo_voc==2)then
table.insert(dis_list,netData.discipleguid)
end
end
if#dis_list>0 then
UIDiscipleController:reqUpdateDiscipleXianMoAttr(#dis_list,dis_list)
end
end
end

function UIDiscipleModel:updateXianMoDiscipleCache(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData and(netData.xianmo_voc==1 or netData.xianmo_voc==2)then
local curDaoHeng=UIDiscipleModel:getDiscipleDaoHeng(guid)
local total_daoheng=UIDiscipleModel:getDiscipleXinFaTotalExp(guid)
if curDaoHeng<total_daoheng then
self.xianmoDiscipleCache[tostring(guid)]=curDaoHeng
else
self.xianmoDiscipleCache[tostring(guid)]=nil
end
else
self.xianmoDiscipleCache[tostring(guid)]=nil
end
end

function UIDiscipleModel:updateAllXianMoDiscipleAttr()
local dis_list={}
local remove_list={}
for guidStr,target in pairs(self.xianmoDiscipleCache or{})do
local guid=int64.new(guidStr)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local curDaoHeng=UIDiscipleModel:getDiscipleDaoHeng(guid)
if curDaoHeng>target then
table.insert(dis_list,guid)
end
else
table.insert(remove_list,guid)
end
end
if#dis_list>0 then
UIDiscipleController:reqUpdateDiscipleXianMoAttr(#dis_list,dis_list)
end
if#remove_list>0 then
for i,guid in ipairs(remove_list)do
self.xianmoDiscipleCache[tostring(guid)]=nil
end
end
for i,guid in ipairs(dis_list)do
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng)
UIDiscipleModel:updateXianMoDiscipleCache(guid)
end
end
end

function UIDiscipleModel:setXianMoDatas(stage1,stage2,xinfaBranch_len,xinfaBranchData)
self.xianXinFaStage=stage1
self.moXinFaStage=stage2
if xinfaBranch_len>0 then
for i,v in ipairs(xinfaBranchData)do
local id=v.param_1
local lv=v.param_2
self.xinfaBranchData[id]=lv
end
end
end

function UIDiscipleModel:setXinFaBranchLevel(id,level)
self.xinfaBranchData[id]=level
end

function UIDiscipleModel:getXinFaBranchLevel(id)
if self.xinfaBranchData and self.xinfaBranchData[id]then
return self.xinfaBranchData[id]
end
return 0
end

function UIDiscipleModel:getXianXinFaStage()
return self.xianXinFaStage
end
function UIDiscipleModel:setXianXinFaStage(stage)
self.xianXinFaStage=stage
end

function UIDiscipleModel:getMoXinFaStage()
return self.moXinFaStage
end
function UIDiscipleModel:setMoXinFaStage(stage)
self.moXinFaStage=stage
end

function UIDiscipleModel:isXinFaActive(type,stage)
local xinfaStage=0
if type==1 then
xinfaStage=self.xianXinFaStage
elseif type==2 then
xinfaStage=self.moXinFaStage
end
return xinfaStage>=stage
end

function UIDiscipleModel:isXinFaCanActive(type,stage)
if not systemModel.isOpen(SYSTEM_DEFINE.eXinFaXiuLian)then
return false
end
if UIDiscipleModel:isXinFaActive(type,stage)then
return false
end
local xinfaTypeCfg=cfgHelper.get1(cfg_disciplexinfaconfig_get,type)
if not xinfaTypeCfg then
return false
end
if stage>#xinfaTypeCfg then
return false
end
local active=xinfaTypeCfg[stage].active
for i,v in ipairs(active)do
if not itemsModel.checkItemEnough(v[1],v[2])then
return false
end
end
return true
end

function UIDiscipleModel:checkXinFaActiveReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eXinFaXiuLian)then
return false
end
if not self.xianXinFaStage or not self.moXinFaStage then
return false
end
if UIDiscipleModel:isXinFaCanActive(1,self.xianXinFaStage+1)then
return true
end
if UIDiscipleModel:isXinFaCanActive(2,self.moXinFaStage+1)then
return true
end
return false
end

function UIDiscipleModel:isXinFaBranchCanActive(id)
if not systemModel.isOpen(SYSTEM_DEFINE.eXinFaXiuLian)then
return false
end
local branchLv=UIDiscipleModel:getXinFaBranchLevel(id)
local cfg=cfgHelper.get1(cfg_disciplexinfabranchconfig_get,id)
if not cfg then
return false
end
if branchLv>#cfg.level_consume then
return false
end
local level_consume=cfg.level_consume[branchLv]
for i,v in ipairs(level_consume)do
if not itemsModel.checkItemEnough(v[1],v[2])then
return false
end
end
return true
end

function UIDiscipleModel:checkXinFaStageBranchActiveReddot(type,stage,index)
if not systemModel.isOpen(SYSTEM_DEFINE.eXinFaXiuLian)then
return false
end
local xinfaTypeCfg=cfgHelper.get1(cfg_disciplexinfaconfig_get,type)
if not xinfaTypeCfg then
return false
end
if stage>#xinfaTypeCfg then
return false
end
if not UIDiscipleModel:isXinFaActive(type,stage)then
return false
end
local branch_list=xinfaTypeCfg[stage].branch_list
if index then
local branchId=branch_list[index]
return UIDiscipleModel:isXinFaBranchCanActive(branchId)
else
for i,branchId in ipairs(branch_list)do
if UIDiscipleModel:isXinFaBranchCanActive(branchId)then
return true
end
end
end
return false
end

function UIDiscipleModel:checkXinFaBranchActiveReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eXinFaXiuLian)then
return false
end
if not self.xianXinFaStage or not self.moXinFaStage then
return false
end
for stage=1,self.xianXinFaStage do
if UIDiscipleModel:checkXinFaStageBranchActiveReddot(1,stage)then
return true
end
end
for stage=1,self.moXinFaStage do
if UIDiscipleModel:checkXinFaStageBranchActiveReddot(2,stage)then
return true
end
end
return false
end

function UIDiscipleModel:checkXinFaTypeReddot(type)
if not systemModel.isOpen(SYSTEM_DEFINE.eXinFaXiuLian)then
return false
end
if not self.xianXinFaStage or not self.moXinFaStage then
return false
end
local reddot=false
local reddotStage
local maxStage=type==1 and(self.xianXinFaStage+1)or(self.moXinFaStage+1)
for stage=1,maxStage do
if UIDiscipleModel:checkXinFaStageReddot(type,stage)then
reddot=true
reddotStage=stage
break
end
end
return reddot,reddotStage
end

function UIDiscipleModel:checkXinFaStageReddot(type,stage)
if not systemModel.isOpen(SYSTEM_DEFINE.eXinFaXiuLian)then
return false
end
if not self.xianXinFaStage or not self.moXinFaStage then
return false
end
if UIDiscipleModel:isXinFaCanActive(type,stage)then
return true
end
if UIDiscipleModel:checkXinFaStageBranchActiveReddot(type,stage)then
return true
end
return false
end

function UIDiscipleModel:getXinFaStage(type)
local xinfaStage=0
if type==1 then
xinfaStage=self.xianXinFaStage
elseif type==2 then
xinfaStage=self.moXinFaStage
end
return xinfaStage
end

function UIDiscipleModel:getDiscipleXinFaLevel(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
return netData.xinfa_level or 0
end
return 0
end

function UIDiscipleModel:getDiscipleDaoHengExtraExp(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
return netData.daoheng_exp or 0
end
return 0
end

function UIDiscipleModel:getDiscipleXinFaTimeStamp(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
return netData.xinfa_check_t or 0
end
return 0
end


function UIDiscipleModel:getDiscipleXianMoVoc(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
return netData.xianmo_voc or 0
end
return 0
end

function UIDiscipleModel:checkDiscipleXianMoVoc(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData and netData.xianmo_voc then
if netData.xianmo_voc==1 or netData.xianmo_voc==2 then
return true
end
end
return false
end

function UIDiscipleModel:getDiscipleXianMoHideDress(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return(netData and netData.hidexianmodress)and netData.hidexianmodress or 0
end

function UIDiscipleModel:getDiscipleXinFaTotalExp(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local curMaxDaoHeng=0
if netData then
local xinfa_level=netData.xinfa_level or 0
if xinfa_level<=0 then
return 0
end
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfa_level)
if xinfaLevelCfg and xinfaLevelCfg.daoheng_conf then
curMaxDaoHeng=xinfaLevelCfg.daoheng_conf[2]
end
end
return curMaxDaoHeng
end

function UIDiscipleModel:getDiscipleDaoHengTotalExp(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local xinfa_level=netData.xinfa_level or 0
if xinfa_level<=0 then
return 0,0
end
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfa_level)
local xm_voc=netData.xianmo_voc
local exp_rate=gubaoModel:getXianMo_DaoHangEXPSpeed(xm_voc)/100
local daoheng_level=netData.daoheng_level or 0
local xinfa_check_t=netData.xinfa_check_t or 0
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local min_daoheng,max_daoheng=unpack(xinfaLevelCfg.daoheng_conf)
local time_exp=(timeHelper.getServerShortTime()-xinfa_check_t)*baseCfg.xinfa_exp_incr
local level_exp=(daoheng_level-min_daoheng)*xinfaLevelCfg.exp
local total_exp=mathHelper.floor(time_exp*(1+exp_rate))+level_exp

local max_daoheng_exp=(max_daoheng-min_daoheng+1)*xinfaLevelCfg.exp
if total_exp>max_daoheng_exp then
total_exp=max_daoheng_exp
end
return total_exp,max_daoheng_exp
end
return 0,0
end

function UIDiscipleModel:getDiscipleXinFaStage(guid)
local xinfaStage=0
local xinFaLevel=UIDiscipleModel:getDiscipleXinFaLevel(guid)
if xinFaLevel>0 then
xinfaStage=cfgHelper.get2(cfg_discipledaohengconfig_get,xinFaLevel,'stage')
end
return xinfaStage
end

function UIDiscipleModel:getDiscipleDaoHeng(guid)
local total_daoheng=0
local remaining_exp=0
local max_exp=0
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local xinfa_level=UIDiscipleModel:getDiscipleXinFaLevel(guid)
if xinfa_level<=0 then
return total_daoheng,remaining_exp,max_exp
end
local total_exp=UIDiscipleModel:getDiscipleDaoHengTotalExp(guid)
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfa_level)
local exp=xinfaLevelCfg.exp
max_exp=exp
local daoheng_incr=mathHelper.floor(total_exp/exp)
total_daoheng=xinfaLevelCfg.daoheng_conf[1]+daoheng_incr
remaining_exp=total_exp%exp
if total_daoheng>xinfaLevelCfg.daoheng_conf[2]then
total_daoheng=xinfaLevelCfg.daoheng_conf[2]
remaining_exp=exp
end
end
return total_daoheng,remaining_exp,max_exp
end

function UIDiscipleModel:getXinFaStageDaoHeng(stage)
local cfg=cfgHelper.get2(cfg_disciplexinfaconfig_get,1,stage)
local fullXinFaLevel=cfg.full_level
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,fullXinFaLevel)
local total_daoheng=xinfaLevelCfg.daoheng_conf[2]
return total_daoheng
end

function UIDiscipleModel:getDiscipleDaoHengAttr(guid,wltAttr)
local attrs={}
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local daoHeng=UIDiscipleModel:getDiscipleDaoHeng(guid)
local xinfa_level=UIDiscipleModel:getDiscipleXinFaLevel(guid)
local xm_voc=netData.xianmo_voc
local voc=UIDiscipleModel:getDiscipleJob(guid)
if xinfa_level<=0 then
loggerUtil.logErrFMT("弟子仙魔心法等级为0 弟子guid:{0}",mathHelper.int64_to_number(guid))
return attrs
end
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfa_level)

local base_attr=xinfaLevelCfg.base_attr[voc]
if base_attr then
for i,v in ipairs(base_attr)do
local attrKey,attrVal=v[1],v[2]
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
else
if next(xinfaLevelCfg.base_attr)then
loggerUtil.logErrFMT("弟子仙魔道行基础属性缺少该职业配置 职业：{0}",voc)
end
end

local xinfa_attr=xinfaLevelCfg.xinfa_attr[voc]
if xinfa_attr then
for i,v in ipairs(xinfa_attr)do
local attrKey,attrVal=v[1],v[2]
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
else
if next(xinfaLevelCfg.xinfa_attr)then
loggerUtil.logErrFMT("弟子仙魔心法突破属性缺少该职业配置 职业：{0}",voc)
end
end

local daoheng_conf=xinfaLevelCfg.daoheng_conf
local extraDaoHeng=0
if daoHeng>=daoheng_conf[1]then
extraDaoHeng=daoHeng-daoheng_conf[1]+1
end
local daoheng_attr=xinfaLevelCfg.daoheng_attr[voc]
if daoheng_attr then
for i,v in ipairs(daoheng_attr)do
local attrKey,attrVal=v[1],v[2]
attrs[attrKey]=(attrs[attrKey]or 0)+(extraDaoHeng*attrVal)
end
else
if next(xinfaLevelCfg.daoheng_attr)then
loggerUtil.logErrFMT("弟子仙魔道行收益属性缺少该职业配置 职业：{0}",voc)
end
end

local daohengtree_rate=UIDiscipleModel:getDaoHengTreeAttrRate(guid)/10000

local gubao_rate=gubaoModel:getXianMo_DaoHangAttr(xm_voc)/100

for attrKey,attrVal in pairs(attrs)do
local wltRate=(wltAttr[attrKey]or 0)/100
attrs[attrKey]=mathHelper.floor(attrVal*((1+daohengtree_rate)*(1+wltRate)+gubao_rate))
end

local extraAttrs=UIDiscipleModel:getXinFaBranchDaoHengAttr(guid)
for attrKey,attrVal in pairs(extraAttrs)do
local wltRate=(wltAttr[attrKey]or 0)/100
attrs[attrKey]=(attrs[attrKey]or 0)+mathHelper.floor(attrVal*(1+wltRate))
end
end

return attrs
end

function UIDiscipleModel:getDaoHengTreeAttrRate(guid)
local rate=0
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local xinfa_level=UIDiscipleModel:getDiscipleXinFaLevel(guid)
if xinfa_level<=0 then
return rate
end
local xm_voc=netData.xianmo_voc
local voc=UIDiscipleModel:getDiscipleJob(guid)
local daoHeng=UIDiscipleModel:getDiscipleDaoHeng(guid)


local daohengtreeCfg=cfgHelper.get2(cfg_discipledaohengtreeconfig_get,xm_voc,voc)
if daohengtreeCfg then
local reward_list=daohengtreeCfg.reward_list
for i=#reward_list,1,-1 do
local reward=reward_list[i]
local need_xinfa_level=reward[1]
local need_daoheng=reward[2]
if xinfa_level>=need_xinfa_level and daoHeng>=need_daoheng then
for _,v in ipairs(reward[4]or{})do
if v[1]==2 then
local percent=v[2]
rate=rate+percent
end
end
break
end
end
end
end
return rate
end

function UIDiscipleModel:getXinFaBranchDaoHengAttr(guid)
local attrs={}

local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local xm_voc=netData.xianmo_voc
local voc=UIDiscipleModel:getDiscipleJob(guid)
local xinfa_level=UIDiscipleModel:getDiscipleXinFaLevel(guid)
local daoHeng=UIDiscipleModel:getDiscipleDaoHeng(guid)
local curStage=UIDiscipleModel:getDiscipleXinFaStage(guid)
for stage=1,curStage do
local rate={}
local cfg=cfgHelper.get2(cfg_disciplexinfaconfig_get,xm_voc,stage)
local branch_list=cfg.branch_list
for _,id in ipairs(branch_list)do
local level=UIDiscipleModel:getXinFaBranchLevel(id)
if level>0 then
local effectCfg=cfgHelper.get2(cfg_disciplexinfabranchconfig_get,id,'effect')
if effectCfg[level]then
local effectList=effectCfg[level]
for i,v in ipairs(effectList)do
local effectType=v[1]
if effectType==2 then
local attrKey,percent=v[2],v[3]
rate[attrKey]=(rate[attrKey]or 0)+percent
end
end
end
end
end
if next(rate)then
local isCurStage=stage==curStage
local level=isCurStage and xinfa_level or cfg.full_level
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,level)
local cur_daoheng=isCurStage and daoHeng or xinfaLevelCfg.daoheng_conf[2]
local total_daoheng=(cur_daoheng-xinfaLevelCfg.daoheng_conf[1]+1)
local temp={}

local daoheng_attr=xinfaLevelCfg.daoheng_attr[voc]
for i,v in ipairs(daoheng_attr)do
local attrKey,attrVal=v[1],v[2]
temp[attrKey]=(temp[attrKey]or 0)+(total_daoheng*attrVal)
end

local stage_attr=xinfaLevelCfg.stage_attr[voc]
for i,v in ipairs(stage_attr or{})do
local attrKey,attrVal=v[1],v[2]
temp[attrKey]=(temp[attrKey]or 0)+attrVal
end

for attrKey,attrVal in pairs(temp)do
local percent=rate[attrKey]or 0
temp[attrKey]=mathHelper.floor(attrVal*(percent/10000))
end

for attrKey,attrVal in pairs(temp)do
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
end
end
return attrs
end

function UIDiscipleModel:setXianMoAllDiscipleAttrListDirty(showFightTips)
local discipleNetData=UIDiscipleModel:getAllDiscipleData()
if discipleNetData then
if showFightTips==nil then
showFightTips=false
end
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
if netData.xianmo_voc==1 or netData.xianmo_voc==2 then
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng,showFightTips)
end
end
end
end

function UIDiscipleModel:getXinFaStageBranchAttr(type)
local flag=UIDiscipleModel:getXinFaBranchUpdateFlag()
if not self.branchAttrs or not bitHelper.check_pos(flag,0)then
UIDiscipleModel:setXinFaBranchUpdateFlag(0)
local curStage=UIDiscipleModel:getXinFaStage(type)
self.branchAttrs={}
for stage=1,curStage do
local cfg=cfgHelper.get2(cfg_disciplexinfaconfig_get,type,stage)
local branch_list=cfg.branch_list
for _,id in ipairs(branch_list)do
local level=UIDiscipleModel:getXinFaBranchLevel(id)
if level>0 then
local effectCfg=cfgHelper.get2(cfg_disciplexinfabranchconfig_get,id,'effect')
if effectCfg[level]then
local effectList=effectCfg[level]
for i,v in ipairs(effectList)do
local effectType=v[1]
if effectType==1 then
for _,vv in ipairs(v[2])do
local attrKey,attrVal=vv[1],vv[2]
self.branchAttrs[attrKey]=(self.branchAttrs[attrKey]or 0)+attrVal
end
end
end
end
end
end
end
end
return self.branchAttrs
end

function UIDiscipleModel:getXinFaStageBranchJJLTAttr(type)
local flag=UIDiscipleModel:getXinFaBranchUpdateFlag()
if not(self.JJ_percent and self.LT_percent)or not bitHelper.check_pos(flag,1)then
UIDiscipleModel:setXinFaBranchUpdateFlag(1)
self.JJ_percent=0
self.LT_percent=0
local curStage=UIDiscipleModel:getXinFaStage(type)
for stage=1,curStage do
local cfg=cfgHelper.get2(cfg_disciplexinfaconfig_get,type,stage)
local branch_list=cfg.branch_list
for _,id in ipairs(branch_list)do
local level=UIDiscipleModel:getXinFaBranchLevel(id)
if level>0 then
local effectCfg=cfgHelper.get2(cfg_disciplexinfabranchconfig_get,id,'effect')
if effectCfg[level]then
local effectList=effectCfg[level]
for i,v in ipairs(effectList)do
local effectType=v[1]
if effectType==3 then
local attrType,percent=v[2],v[3]
if attrType==1 then
self.JJ_percent=self.JJ_percent+percent
else
self.LT_percent=self.LT_percent+percent
end
end
end
end
end
end
end
end
return self.JJ_percent,self.LT_percent
end

function UIDiscipleModel:getXianMoDaoHengAttrsLookup(discipleguid)
local attrs={}
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData then
local xm_voc=netData.xianmo_voc
local xinfa_level=netData.xinfa_level
if(xm_voc~=1 and xm_voc~=2)or xinfa_level<=0 then
return attrs
end
local voc=UIDiscipleModel:getDiscipleJob(discipleguid)
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)

local attrList=xm_voc==1 and baseCfg.attr1 or baseCfg.attr2
attrList=attrList[voc]or{}
for i,v in ipairs(attrList)do
local attrKey,attrVal=v[1],v[2]
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end

local stageBranchAttrList=UIDiscipleModel:getXinFaStageBranchAttr(xm_voc)
for attrKey,attrVal in pairs(stageBranchAttrList)do
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end

local daohengtreeCfg=cfgHelper.get2(cfg_discipledaohengtreeconfig_get,xm_voc,voc)
if daohengtreeCfg then
local reward_list=daohengtreeCfg.reward_list
local daoHeng=UIDiscipleModel:getDiscipleDaoHeng(discipleguid)
for i=#reward_list,1,-1 do
local reward=reward_list[i]
local need_xinfa_level=reward[1]
local need_daoheng=reward[2]
if xinfa_level>=need_xinfa_level and daoHeng>=need_daoheng then
for _,attrReward in ipairs(reward[3]or{})do
local attrKey,attrVal=attrReward[1],attrReward[2]
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
break
end
end
end

local wltAttr=wanLingTaModel:getWanLingTaXianMoSpeAttrsLookup(xm_voc)
for attrKey,attrVal in pairs(attrs)do
local wltRate=(wltAttr[attrKey]or 0)/100
attrs[attrKey]=mathHelper.floor(attrVal*(1+wltRate))
end

local daohengAttrList=UIDiscipleModel:getDiscipleDaoHengAttr(discipleguid,wltAttr)
for attrKey,attrVal in pairs(daohengAttrList)do
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end

return attrs
end


function UIDiscipleModel:getDiscipleXianMoTransferConsume(discipleguid)
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local voc=UIDiscipleModel:getDiscipleJob(discipleguid)
local voc_consume=baseCfg.voc_consume[voc]
if not voc_consume then
logErr(string.format("仙魔转职没有职业id：%d 的配置",voc))
return
end
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
local xianmoVal=WenXinGuanModel:getDzXMZByguid(discipleguid)
local xmz_discount=baseCfg.xmz_discount[xianmoVal]
local xianTransferConsume,moTransferConsume=unpack(voc_consume)
local xianMoneyType,xianMoneyCount=unpack(xianTransferConsume)
local moMoneyType,moMoneyCount=unpack(moTransferConsume)
if xmz_discount then
local x_discount,m_discount=unpack(xmz_discount)
xianMoneyCount=mathHelper.floor(xianMoneyCount*(x_discount/100))
moMoneyCount=mathHelper.floor(moMoneyCount*(m_discount/100))
end
return{{xianMoneyType,xianMoneyCount},{moMoneyType,moMoneyCount}}
end


function UIDiscipleModel:setDiscipleXianMoBackImage(item,compIdx,netData)
if not item then
return
end
local xm_voc=netData and(netData.xianmo_voc or 0)or 0
if xm_voc==1 then
item:SetChildCSImageSprite(compIdx,'ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab','image_xmdj_3')
elseif xm_voc==2 then
item:SetChildCSImageSprite(compIdx,'ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab','image_xmdj_4')
end
item:SetChildActive(compIdx,xm_voc==1 or xm_voc==2)
end


function UIDiscipleModel:setDiscipleXianMoHeadImage(item,compIdx,netData)
if not item then
return
end
local xm_voc=netData and(netData.xianmo_voc or 0)or 0
if xm_voc==1 then
item:SetChildCSImageSprite(compIdx,'ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab','image_xmdj_1')
elseif xm_voc==2 then
item:SetChildCSImageSprite(compIdx,'ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab','image_xmdj_2')
end
item:SetChildActive(compIdx,xm_voc==1 or xm_voc==2)
end


function UIDiscipleModel:getXianMoJJRate(guid)
local rate=0
if UIDiscipleModel:checkDiscipleXianMoVoc(guid)then
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(guid)
local jingjie_attr_add=cfgHelper.get2(cfg_disciplevocconfig_get,1,'jingjie_attr_add')
local JJ_percent=UIDiscipleModel:getXinFaStageBranchJJLTAttr(xm_voc)
rate=rate+(jingjie_attr_add/100.0)+(JJ_percent/10000.0)
end
return rate
end


function UIDiscipleModel:getXianMoLTRate(guid)
local rate=0
if UIDiscipleModel:checkDiscipleXianMoVoc(guid)then
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(guid)
local _,LT_percent=UIDiscipleModel:getXinFaStageBranchJJLTAttr(xm_voc)
rate=rate+(LT_percent/10000.0)
end
return rate
end


function UIDiscipleModel:getXianMoJJLTRateAttrs(guid)
local total_attr={}
local JJ_rate=UIDiscipleModel:getXianMoJJRate(guid)
local LT_rate=UIDiscipleModel:getXianMoLTRate(guid)
local baseJJAttrs=UIDiscipleModel:calculationDiscipleJJAttrLookupEx(guid,false)
local baseLTAttrs=UIDiscipleModel:calculationDiscipleLTAttrLookupEx(guid,false)
for attrKey,attrVal in pairs(baseJJAttrs)do
total_attr[attrKey]=(total_attr[attrKey]or 0)+(attrVal*JJ_rate)
end
for attrKey,attrVal in pairs(baseLTAttrs)do
total_attr[attrKey]=(total_attr[attrKey]or 0)+(attrVal*LT_rate)
end
return total_attr
end



function UIDiscipleModel:getDiscipleResetDaoHengGain(guid)
local itemList={}
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local xm_voc=netData.xianmo_voc
local xinfa_level=UIDiscipleModel:getDiscipleXinFaLevel(guid)
if xinfa_level<=0 then
return itemList
end
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfa_level)
local reset=xinfaLevelCfg.reset[xm_voc]
for itemid,num in pairs(reset)do
table.insert(itemList,{itemid,num})
end
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local cur_exp=UIDiscipleModel:getDiscipleDaoHengTotalExp(guid)
local extra_exp=UIDiscipleModel:getDiscipleDaoHengExtraExp(guid)
local total_exp=xinfaLevelCfg.total_exp+cur_exp+extra_exp
total_exp=total_exp*baseCfg.reset_conf[2]
local reset_back=baseCfg.reset_back[xm_voc]
for i,v in ipairs(reset_back)do
local exp_unit,itemid=v[1],v[2]
if total_exp>=exp_unit then
local num=mathHelper.floor(total_exp/exp_unit)
table.insert(itemList,{itemid,num})
total_exp=total_exp%exp_unit
end
end
end
return itemList
end


function UIDiscipleModel:getDiscipleReverseXianMoGain(guid)
local itemList={}
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local xinfa_level=UIDiscipleModel:getDiscipleXinFaLevel(guid)
if xinfa_level<=0 then
return{}
end
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local xm_voc=netData.xianmo_voc
local new_xm_voc=xm_voc==1 and 2 or 1
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfa_level)
local xinfaStage=xinfaLevelCfg.stage
local new_xinfaStage=UIDiscipleModel:getXinFaStage(new_xm_voc)
if new_xinfaStage>=xinfaStage then
return{}
end
local new_xinfaCfg=cfgHelper.get2(cfg_disciplexinfaconfig_get,new_xm_voc,new_xinfaStage)
local new_xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,new_xinfaCfg.full_level)

local reset=xinfaLevelCfg.reset[xm_voc]
local new_reset=new_xinfaLevelCfg.reset[xm_voc]
for itemid,num in pairs(reset)do
local diff_num=num-(new_reset[itemid]or 0)
table.insert(itemList,{itemid,diff_num})
end

local cur_exp=UIDiscipleModel:getDiscipleDaoHengTotalExp(guid)
local extra_exp=UIDiscipleModel:getDiscipleDaoHengExtraExp(guid)
local total_exp=(xinfaLevelCfg.total_exp-new_xinfaLevelCfg.total_exp)+cur_exp+extra_exp
local reset_back=baseCfg.reset_back[xm_voc]
for i,v in ipairs(reset_back)do
local exp_unit,itemid=v[1],v[2]
if total_exp>=exp_unit then
local num=mathHelper.floor(total_exp/exp_unit)
table.insert(itemList,{itemid,num})
total_exp=total_exp%exp_unit
end
end
end
return itemList
end


function UIDiscipleModel:getXinFaStageDaoHengAttr(voc,type,stage)
local attrs={}
local full_level=cfgHelper.get3(cfg_disciplexinfaconfig_get,type,stage,'full_level')
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,full_level)
local total_daoheng=xinfaLevelCfg.daoheng_conf[2]-xinfaLevelCfg.daoheng_conf[1]+1

local daoheng_attr=xinfaLevelCfg.daoheng_attr[voc]
for i,v in ipairs(daoheng_attr)do
local attrKey,attrVal=v[1],v[2]
attrs[attrKey]=(attrs[attrKey]or 0)+(total_daoheng*attrVal)
end

local stage_attr=xinfaLevelCfg.stage_attr[voc]
for i,v in ipairs(stage_attr or{})do
local attrKey,attrVal=v[1],v[2]
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
return attrs
end



function UIDiscipleModel:getDiscipleXianMoSkillList(discipleguid)
local skills={}
if not UIDiscipleModel:checkDiscipleXianMoVoc(discipleguid)then
return skills
end
local voc=UIDiscipleModel:getDiscipleJob(discipleguid)
local type=UIDiscipleModel:getDiscipleXianMoVoc(discipleguid)
local cfg=cfgHelper.get2(cfg_discipledaohengtreeconfig_get,type,voc)
local daoHeng=UIDiscipleModel:getDiscipleDaoHeng(discipleguid)
local skillCfg=cfg.client_skill_preview
for i,v in ipairs(skillCfg)do
local skillid,daoHengCfg=v[1],v[2]

local level=0
local unlockDaoHeng=daoHengCfg[1]
for lv,target in ipairs(daoHengCfg)do
if daoHeng>target then
level=lv
end
end
table.insert(skills,{skillid,level,unlockDaoHeng})
end
return skills
end

function UIDiscipleModel:initXianMoDiscipleCount()
self.xianDiscipleCount=0
self.moDiscipleCount=0
local discipleNetData=UIDiscipleModel:getAllDiscipleData()
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
if netData.xianmo_voc==1 then
self.xianDiscipleCount=self.xianDiscipleCount+1
elseif netData.xianmo_voc==2 then
self.moDiscipleCount=self.moDiscipleCount+1
end
end
end
taskController.onXianMoDiscipleNumChange()
notifySystem:postNotify(notifyConfig.onDiscipleXianMoCountChange,self.xianDiscipleCount,self.moDiscipleCount)
end

function UIDiscipleModel:changeXianMoDiscipleCount(xianCount,moCount)
if self.xianDiscipleCount and self.moDiscipleCount then
self.xianDiscipleCount=self.xianDiscipleCount+xianCount
self.moDiscipleCount=self.moDiscipleCount+moCount
end
taskController.onXianMoDiscipleNumChange()
notifySystem:postNotify(notifyConfig.onDiscipleXianMoCountChange,xianCount,moCount)
end

function UIDiscipleModel:removeCheckXianMoDisciple(discipleguid)
if self.xianDiscipleCount and self.moDiscipleCount then
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData then
if netData.xianmo_voc==1 then
UIDiscipleModel:changeXianMoDiscipleCount(-1,0)
elseif netData.xianmo_voc==2 then
UIDiscipleModel:changeXianMoDiscipleCount(0,-1)
end
end
end
end


function UIDiscipleModel:getXianMoDiscipleCount()
if not self.xianDiscipleCount or not self.moDiscipleCount then
UIDiscipleModel:initXianMoDiscipleCount()
end
return self.xianDiscipleCount,self.moDiscipleCount
end


function UIDiscipleModel:checkDiscipleXianMoTransferReddot(discipleguid)

local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if not netData then
return false
end

if not systemModel.isOpen(SYSTEM_DEFINE.eXianMoVoc)then
return false
end

if UIDiscipleModel:checkDiscipleXianMoVoc(discipleguid)then
return false
end

if not WenXinGuanModel:checkDzWXGState(discipleguid)then
return false
end

local voc_consume=UIDiscipleModel:getDiscipleXianMoTransferConsume(discipleguid)or{}
for i,v in ipairs(voc_consume)do
local moneyType,moneyCount=v[1],v[2]
local have=itemsModel.getCount(moneyType)
if have<moneyCount then
return false
end
end


local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(discipleguid)
if jjlv<baseCfg.voc_level then
return false
end
return true
end


function UIDiscipleModel:checkDiscipleXianMoXinFaReddot(discipleguid)

if not UIDiscipleModel:checkDiscipleXianMoVoc(discipleguid)then
return false
end

local cur=UIDiscipleModel:getDiscipleDaoHeng(discipleguid)
local max=UIDiscipleModel:getDiscipleXinFaTotalExp(discipleguid)
if cur<max then
return false
end

local daoheng_exp,daoheng_max_exp=UIDiscipleModel:getDiscipleDaoHengTotalExp(discipleguid)
if daoheng_exp<daoheng_max_exp then
return false
end

local xinfaLevel=UIDiscipleModel:getDiscipleXinFaLevel(discipleguid)
local max_xinfaLevel=#cfg_discipledaohengconfig()
if xinfaLevel<=0 or xinfaLevel>=max_xinfaLevel then
return false
end

local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfaLevel)
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(discipleguid)
local consume=xinfaLevelCfg.consume[xm_voc]
for i,v in ipairs(consume)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
return false
end
end

local xinfaStage=UIDiscipleModel:getDiscipleXinFaStage(discipleguid)
local nextXinFaStage=cfgHelper.get2(cfg_discipledaohengconfig_get,xinfaLevel+1,'stage')
if nextXinFaStage~=xinfaStage then
local active=UIDiscipleModel:isXinFaActive(xm_voc,xinfaStage+1)
if not active then
return false
end
end
return true
end

function UIDiscipleModel:findClosestXinFaLvDZ()

local selectFunc=function(data)
local lv=UIDiscipleModel:getDiscipleXinFaLevel(data.discipleguid)
return lv>0
end

local sortFunc=function(dzA,dzB)
local dzALv=UIDiscipleModel:getDiscipleXinFaLevel(dzA.discipleguid)
local dzBLv=UIDiscipleModel:getDiscipleXinFaLevel(dzB.discipleguid)
return dzALv>dzBLv
end
local discList=UIDiscipleModel:getSortList(selectFunc,sortFunc)

if#discList>0 then
return discList[1].discipleguid
end
end

function UIDiscipleModel:setTargetXinFaData(type,stage,discipleguid)
self.targetXinFaData={type,stage,discipleguid}
end

function UIDiscipleModel:clearTargetXinFaData()
self.targetXinFaData=nil
end

function UIDiscipleModel:checkTargetXinFa(type,stage)
if self.targetXinFaData then
local targetType,targetStage,discipleguid=unpack(self.targetXinFaData)
if type==targetType and stage==targetStage then
local func=function()
UIFullDiscipleMainControl:showWindowInfo({dis_guid=discipleguid})
UIManager:showWindow('UIDiscipleJingJieWin',{guid=discipleguid})
UIManager:showWindow("UIXianMoZhuanZhi_mainWin",discipleguid)
end
fullScreenUI.setNextActiveUICallback(func)
self.targetXinFaData=nil
end
end
end


function UIDiscipleModel:setXianMoResetCount(count)
self.xmResetCount=count
end

function UIDiscipleModel:getXianMoResetCount()
return self.xmResetCount or 0
end

function UIDiscipleModel:getXianMoResetCost()
local count=UIDiscipleModel:getXianMoResetCount()
local reset_conf=cfgHelper.get2(cfg_disciplevocconfig_get,1,'reset_conf')
local resetCost=reset_conf[1]
local resetMax=#resetCost
local realCount=count+1
realCount=Mathf.Min(realCount,resetMax)
return resetCost[realCount]
end