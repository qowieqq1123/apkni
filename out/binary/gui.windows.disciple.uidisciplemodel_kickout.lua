








discipleRemoveReason={
eKickout=1,
eGamePlot=2,
}
Speciality_item_bigtype=
{
danyao=7,
zhuanyebiji=12
}

function UIDiscipleModel:getKickoutRewards(dis_list)
local list={}
local lookup={}
if dis_list then
for i,guid in ipairs(dis_list)do
UIDiscipleModel:getKickoutRewardsEx(lookup,guid)
end
end
for k,v in pairs(lookup)do
local itemConfig=itemsConfig.getConfig(k)
table.insert(list,{k,v,itemConfig.color})
end
if#list>0 then
table.sort(list,function(a,b)
return a[3]>b[3]
end)
end
return list
end

function UIDiscipleModel:getKickoutRewardsEx(lookup,guid)
local cfg=cfgHelper.get1(cfg_disciplekickoutconfig_get,1)


local point=0
local gflist=UIDiscipleModel:getDiscipleAllGFData(guid)
if#gflist>0 then
for i,v in ipairs(gflist)do
local gfID=v.param_1
local gfLv=v.param_2
point=point+UIGongFaModel:getForgetPoint(gfID,gfLv)
end
end
if point>0 then
local moneyType=eMoneyType.mtChuanDao
lookup[moneyType]=lookup[moneyType]or 0
lookup[moneyType]=lookup[moneyType]+point
end

for i,v in ipairs(cfg.proskill)do
local jobType=i
local lv=UIDiscipleModel:getDiscipleJobLevel(guid,jobType)
for i2,v2 in ipairs(v)do
if lv>=v2[1]and lv<=v2[2]then
for i3,v3 in ipairs(v2[3])do
local itemid=v3[1]
local itemnum=v3[2]
lookup[itemid]=lookup[itemid]or 0
lookup[itemid]=lookup[itemid]+itemnum
end
break
end
end
end

local ltlv=UIDiscipleModel:getDiscipleLTLevel(guid)
for i,v in ipairs(cfg.lianti)do
if ltlv>=v[1]and ltlv<=v[2]then
for i2,v2 in ipairs(v[3])do
local itemid=v2[1]
local itemnum=v2[2]
lookup[itemid]=lookup[itemid]or 0
lookup[itemid]=lookup[itemid]+itemnum
end
break
end
end

UIDiscipleModel:getUpTianMingCostItem(guid,lookup)

UIDiscipleModel:getQiZhenCostGoods(guid,lookup)

UIDiscipleModel:getCuiTiCostGoods(guid,lookup)


UIDiscipleModel:getDiscipleGiveUpReward(guid,lookup)


local netData=UIDiscipleModel:getDiscipleData(guid)
local len=UIDiscipleModel:getDiscipleSpecialityLen(netData,DISCIPLE_SPECIALITY_TYPE.eXX)
if len>0 then
local temp=lookup
for k,v in pairs(temp)do
local bigtype=itemsConfig.getMainType(k)
if bigtype==ITEM_MAIN_TYPE.eItem then
local itemConfig=itemsConfig.getConfig(k)
if itemConfig.type1==Speciality_item_bigtype.danyao or itemConfig.type1==Speciality_item_bigtype.zhuanyebiji then
if lookup[k]then
lookup[k]=nil
end
end
elseif bigtype==ITEM_MAIN_TYPE.eMoney then
if moneyConfig.isMoney(k)and k==eMoneyType.mtChuanDao then
if lookup[k]then
lookup[k]=nil
end
end
end
end
return lookup
end
end

function UIDiscipleModel:getDiscipleGiveUpReward(guid,lookup)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local color=UIDiscipleModel:getDiscipleBaseAttrSum2Color2(netData)
local giveUpRW=cfgHelper.get2(cfg_globalconfig_get,1,'giveup')
local rw=giveUpRW[color]
if rw then
for i,v in ipairs(rw)do
lookup[v[1]]=(lookup[v[1]]or 0)+v[2]
end
end
end
end

function UIDiscipleModel:setDZChuangGongReward(tips,guid)
local equip=fabaoModel.getFabaoByDizi(guid)
if equip then
if not fabaoHelper.isCanDress(guid,equip.itemid,equip.itemguid,false)then
table.insert(tips,FMT.fmt('法宝<{0}>已收归库房',fabaoHelper.getFabaoName(equip)))
end
end
local tmLevel=UIDiscipleModel:getTianMingLevel(guid)
if tmLevel>0 then
local datas=UIDiscipleModel:getUpTianMingCostItem(guid)
for k,v in pairs(datas)do
table.insert(tips,FMT.fmt('{0}*{1}已收归库房',itemsConfig.getItemName(k),v))
end
end
local qzlookup=UIDiscipleModel:getQiZhenCostGoods(guid)
for k,v in pairs(qzlookup)do
table.insert(tips,FMT.fmt('奇珍{0}*{1}已收归库房',itemsConfig.getItemName(k),v))
end
local ctlookup=UIDiscipleModel:getCuiTiCostGoods(guid)
for k,v in pairs(ctlookup)do
table.insert(tips,FMT.fmt('{0}*{1}已收归库房',itemsConfig.getItemName(k),v))
end
end


function UIDiscipleModel:checkCanKickOutDzAndTips(guid,isWarning,htype)
htype=htype or 1
local hasOrder=UIDiscipleModel:checkDZHasOrder(guid)
if hasOrder then
if isWarning then
UIManager.error("关注的弟子不可被驱逐")
end
return
end

local isInLS=UILSZDControl:isDiZiInLingShan(tostring(guid))
if isInLS then
if isWarning then
if htype==2 then
UIManager.error("弟子入驻灵山中无法坐化")
else
UIManager.error("弟子入驻灵山中不可被驱逐")
end
end
return
end

if UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)then
return UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eZuoHua,isWarning)
end
return UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eKickout,isWarning)
end

function UIDiscipleModel:getCantKickOutDZDesc(cantStatetype)
if cantStatetype==nil then return end
if not DISCIPLE_STATE_TYPE:isClientState(cantStatetype)then
return DISCIPLE_STATE_TYPE:getName(cantStatetype)
else
local desc=UIDiscipleModel:checkDZClientStateDesc(cantStatetype)
if desc==nil then
desc='不能逐出'
end
return desc
end
end