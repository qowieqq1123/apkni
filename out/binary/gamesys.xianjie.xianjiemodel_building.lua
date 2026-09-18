











xianjie_building_attr=
{
[SLG_SYSTEM_TYPE.eYuLingZhai]=
{
ruleName="yulingzhai_rule_%d",
getTotalAttrList=function(self)
local cfg=cfg_yulingzhaiconfig()
local yandaotaiSpeed=yandaotaiModel:getAddrateDatasByEffectId(3)or{0,0}
local exSpeed=YuLingZhaiModel:getExtraSpeedAdd()
local lv=YuLingZhaiModel:getBuildingLv2()
local v=cfg[lv]
local speedAdd=(1+v.init_speed/100+exSpeed)
local maxSoldier=YuLingZhaiModel:getSoldierMaxEx(lv)
local list={

{name="伤兵容量",val=maxSoldier},
{name="治疗速度",val=math.floor(v.recover_speed[2]*speedAdd)},
}
return list
end,
getAttrList=function(self)
local list={}
local cfg=cfg_yulingzhaiconfig()

for i,v in pairs(cfg)do
if v.id then
local speedAdd=1+v.init_speed/100
local lv=v.id
local maxSoldier=YuLingZhaiModel:getSoldierMaxEx(lv)
local addVal_maxSoldier=maxSoldier-v.recover_max
list[v.id]={{id=1,name="伤兵容量",val=v.recover_max,addVal=addVal_maxSoldier},{id=2,name="治疗速度",val=math.floor(v.recover_speed[2]*speedAdd),}}
end
end
return list
end,

getDetailList=function(self,level)
local attrList=self:getAttrList()
local limit=attrList[level][1].val
local list={}
table.insert(list,{name="伤兵容量-建筑上限",val=limit,})

local yandaotaiSpeed=yandaotaiModel:getAddrateDatasByEffectId(3)
if yandaotaiSpeed and next(yandaotaiSpeed)then
table.insert(list,{name="伤兵容量-科技加成",val=yandaotaiSpeed[1],})
if yandaotaiSpeed[2]then
table.insert(list,{name="治疗速度-科技加成",val=FMT.fmt("{0}%",yandaotaiSpeed[2]),})
end
end
return list
end
},
[SLG_SYSTEM_TYPE.eYunJiaYing]=
{
ruleName="yunjiaying_rule_%d",
getAttrList=function(self)
local list={}
local cfg=cfg_yunjiayingconfig()
for i,v in pairs(cfg)do
if v.id then
local maxLevelIdx=yunjiayingModel:getTrainMaxBreakLevel(v.id)
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,maxLevelIdx)
local maxLevelName=FMT.fmt("{0}修士",levelCfg.name)
local addTrainCount=0
local ydtParam=yandaotaiModel:getAddrateDatasByEffectId(4)
if ydtParam and ydtParam[1]then
addTrainCount=addTrainCount+ydtParam[1]
end
list[v.id]={
{id=1,name="建筑容量",val=v.max,},
{id=2,name="训练上限",val=v.train,addVal=addTrainCount},
{id=3,name="修士等级",val=maxLevelName}
}

local addRate=yunjiayingModel:getTrainAddRate()






if addRate>0 then
list[v.id][4]={id=4,name="训练速度",val=FMT.fmt("+{0}%",addRate),isOnlyDetailShow=true}
end
end
end
return list
end,
getDetailList=function(self,level)
local attrList=self:getAttrList()
local max=attrList[level][1].val
local list={}
table.insert(list,{name="建筑容量-建筑上限",val=max,})
local train=attrList[level][2].val
local addTrainCount=attrList[level][2].addVal or 0
if addTrainCount<=0 then
table.insert(list,{name="训练上限-建筑上限",val=train+addTrainCount,})
else
table.insert(list,{name="训练上限-建筑上限",val=train,})
table.insert(list,{name="训练上限-科技加成",val=addTrainCount,})
end

if attrList[level][4]and attrList[level][4].val then
local addRate=attrList[level][4].val
table.insert(list,{name="训练速度-科技加成",val=addRate,})
end
return list
end,
getIsOnlyShowAdd=function(self)
return true
end
},
[SLG_SYSTEM_TYPE.eTaiXuCang]=
{
ruleName="taixucang_rule_%d",
getAttrList=function(self)
local list={}
local cfg=cfg_taixucangconfig()
for i,v in pairs(cfg)do
if v.id then
local k,val=next(v.protect)
local addN=TaiXuCangModel:getProtectAdd(k)
local addVal=math.floor(val*addN/100)
list[v.id]={{id=1,name="保护容量",val=val,addVal=addVal,money=k}}
end
end
return list
end,
getDetailList=function(self,level)
local attrList=self:getAttrList()
local data=attrList[level][1]
local limit=data.val
local addVal=data.addVal
if addVal then
limit=limit+addVal
end
local list={}
table.insert(list,{name="保护容量-建筑上限",val=limit,})
return list
end
},
[SLG_SYSTEM_TYPE.eJuTianYi]=
{
ruleName="jutianyi_rule_%d",
getTotalAttrList=function(self)
local add1=JuTianYiModel:getIncreaseAddition(1)
local add2=JuTianYiModel:getIncreaseAddition(2)
local list={
{name="仙气收集效率",val=add1,flag=1},
{name="魔气收集效率",val=add2,flag=1},
}
return list
end,
getAttrList=function(self)
local list={}
local cfg=cfg_jutianyiconfig()
for id,v in ipairs(cfg)do
list[id]={{id=1,name="基础产量",val=string.format("%d/每分钟",v.init_produce)}}
end
return list
end,
getDetailList=function(self,level)
local add1,lv_addition1,pro_skill_add1,zmState_add1,sp_add1,gubao_add1,ydt_add1,scene_add1=JuTianYiModel:getIncreaseAddition(1)
local add2,lv_addition2,pro_skill_add2,zmState_add2,sp_add2,gubao_add2,ydt_add2,scene_add2=JuTianYiModel:getIncreaseAddition(2)
local list={
{name="基础效率",val=lv_addition1,flag=1},
}
if pro_skill_add1>0 then
table.insert(list,{name="阵法加成",val=pro_skill_add1,flag=1})
end
if sp_add1>0 then
table.insert(list,{name="特质加成",val=sp_add1,flag=1})
end
if zmState_add1>0 then
table.insert(list,{name="仙堡加成",val=zmState_add1,flag=1})
end
if gubao_add1>0 then
table.insert(list,{name="古宝加成-仙气",val=gubao_add1,flag=1})
end
if gubao_add2>0 then
table.insert(list,{name="古宝加成-魔气",val=gubao_add2,flag=1})
end
if ydt_add1>0 then
table.insert(list,{name="衍道台加成",val=ydt_add1,flag=1})
end
if scene_add1>0 then
table.insert(list,{name="场景加成",val=scene_add1,flag=1})
end
return list
end
},
[SLG_SYSTEM_TYPE.eYingXianGe]=
{
ruleName="yingxiange_rule_%d",
getTotalAttrList=function(self)
local reduce_time,cooperation_num,assist_num,maxLimit=YingXianGeModel:getIncreaseAddition()
local list={
{name="盟友帮助时间",val=FMT.fmt("{0}秒",reduce_time)},
{name="盟友帮助次数",val=cooperation_num},
{name="援军队伍数量",val=assist_num},
{name="被治疗总次数",val=maxLimit},
}
return list
end,
getAttrList=function(self)
local list={}
local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local cfg=cfg_yingxiangeconfig()
for id,v in ipairs(cfg)do
local maxCooperationCfgNum=v.ex_cooperation_num+baseCfg[6][2]
local maxCooperationNum=YingXianGeModel:getSingleMaxCooperationCountEx(maxCooperationCfgNum)
local maxCooperationAddNum=maxCooperationNum-maxCooperationCfgNum

local huZhuType=7
local maxYLZCooperationCfgNum=v.cooperation_conf[huZhuType]
local maxYLZCooperationNum=YingXianGeModel:getMaxCooperationTypeNumEx(huZhuType,maxYLZCooperationCfgNum)
local maxYLZCooperationAddNum=maxYLZCooperationNum-maxYLZCooperationCfgNum
list[id]={
{id=2,name="盟友帮助时间",val=FMT.fmt("{0}秒",v.ex_reduce_time+baseCfg[6][1])},
{id=1,name="盟友帮助次数",val=maxCooperationCfgNum,addVal=maxCooperationAddNum},
{id=3,name="援军队伍数量",val=v.yxg_assist_num},
{id=4,name="被治疗总次数",val=maxYLZCooperationCfgNum,addVal=maxYLZCooperationAddNum},
}
end
return list
end,
getDetailList=function(self,level)
local list={}
return list
end,
getIsOnlyShowAdd=function(self)
return true
end
},
[SLG_SYSTEM_TYPE.eLunHuiDian]=
{
ruleName="lunhuidian_rule_%d",
getAttrList=function(self)
local list={}
local cfg=cfg_lunhuidianconfig_get(1)
local moneyCfg=cfg_moneyconfig_get(eMoneyType.mtLunHuiDian)
list[1]={
{id=1,name="魂魄上限",val=cfg.soul_limit,},
{id=2,name="轮回点上限",val=moneyCfg.autoincr[5]}
}

return list
end,

getDetailList=function(self,level)
local attrList=self:getAttrList()
local soul_limit=attrList[level][1].val
local list={}
table.insert(list,{name="建筑容量-魂魄上限",val=soul_limit,})
local money_limit=attrList[level][2].val
table.insert(list,{name="建筑容量-轮回点上限",val=money_limit,})
return list
end
},
[SLG_SYSTEM_TYPE.eTianShuDian]=
{
ruleName="tianshudian_rule_%d",
getAttrList=function(self)
local list={}
local cfg=cfg_tianshudianconfig()
local xl_money_id=cfgHelper.getdef(cfg_tianshudianconfig,'xl_money_id')
for index,lvCfg in ipairs(cfg)do
list[lvCfg.id]={
{id=1,name="仙令存储上限",val=lvCfg.auto_max_cnt[eMoneyType.mtXianLing],icon=xl_money_id},
{id=2,name="集结修士上限",val=lvCfg.jjxs_max_cnt},
{id=3,name="弟子携带修士上限",val=lvCfg.czxs_max_cnt}
}
end

return list
end,

getDetailList=function(self,level)
local list={}
return list
end,
},
[SLG_SYSTEM_TYPE.eYanDaoTai]=
{
ruleName="yandaotai_rule_%d",
getAttrList=function(self)
local list={}
local cfg=cfg_technologybaseconfig()
for i,v in pairs(cfg)do
if v.id then
local val=v.uplimit
list[v.id]={{id=1,name="科技等级上限",val=val,}}
end
end
return list
end,
getDetailList=function(self,level)

end
},
}

function xianjieModel:getXianJieBuildingAttr(buildingType)
return xianjie_building_attr[buildingType]
end

function xianjieModel:getBuildingAttrVal(val,flag)
if flag then
if flag==1 then
return FMT.fmt("{0}%",val)
elseif flag==2 then
return FMT.fmt("{0}%",val*100)
elseif flag==3 then
return FMT.fmt("{0}%",val/100)
end
else
return val
end
end