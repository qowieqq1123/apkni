






local _MODULENAME="YunZhouZhenTuModel"


def_table(_MODULENAME)
YunZhouZhenTuModel.name=_MODULENAME
YunZhouZhenTuModel.data={}
local filter={}
local temp={}

function YunZhouZhenTuModel:onAppStart()

end


function YunZhouZhenTuModel:onEnterState(isReconnect)
if self.data then
self.data.yzztList={}
end
end


function YunZhouZhenTuModel:onProtocolReq()

end


function YunZhouZhenTuModel:onLeaveState(isReconnect)

self.data={}
end


function YunZhouZhenTuModel:setYZZTData(len,yzztList)
self.data.yzztList={}
if len>0 and yzztList then
for k,v in ipairs(yzztList)do
self.data.yzztList[v.id]=v
end
end
end

function YunZhouZhenTuModel:setYZZTLevelUp(id,level)
if not self.data.yzztList then
self.data.yzztList={}
end
if not self.data.yzztList[id]then
self.data.yzztList[id]={}
end
self.data.yzztList[id].id=id
self.data.yzztList[id].level=level

end

function YunZhouZhenTuModel:getYZZTAllData()
return self.data.yzztList
end

function YunZhouZhenTuModel:getYZZTDataByID(id)
if self.data.yzztList then
return self.data.yzztList[id]
end
end


function YunZhouZhenTuModel:getYZZTAllReddot()
if not YunZhouZhenTuController:checkYunZhouZhenTuSystem()then
return false
end
for ztid=1,6 do
local singlereddot=self:getYZZTSingleReddot(ztid)
if singlereddot then
return true
end
end
return false
end

function YunZhouZhenTuModel:getYZZTSingleReddot(ztid)
local yzztData=self:getYZZTDataByID(ztid)
local ztcfg=cfg_yunzhouzhentuconfig_get(ztid)
local ZhenTuMaxlvl=ztcfg.ZhenTuMaxlvl
local level=0
if yzztData then
level=yzztData.level
end

if level<ZhenTuMaxlvl then
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
local reddot=self:checkUnlockNode(cfg.unlock)
if reddot then
reddot=self:checkStrengthen(cfg.useItems)
return reddot
else
return false
end
end
return false
end

function YunZhouZhenTuModel:checkStrengthen(cost)
if cost then
local state=true
for k,itemdata in pairs(cost)do
local itemid=itemdata[1]
local hasNum=itemsModel.getCount(itemid)
if moneyConfig.isMoney(itemid)then
hasNum=moneyModel.getMoney(itemid)
else
hasNum=bagModel.getItemCountById(itemid)
end
local neednum=itemdata[2]
state=state and hasNum>=neednum
if not state then
break
end
end
return state
else
return true
end
end

function YunZhouZhenTuModel:checkUnlockNode(unlock)
local lockStr=''
if unlock then
for k,lockdata in ipairs(unlock)do
if lockdata then
if lockdata[1]==1 then
local zmLevel=zongmenModel:getLevel()
lockStr=FMT.fmt('宗门达到{0}级解锁',lockdata[2])
if zmLevel<lockdata[2]then
return false,lockStr
end

elseif lockdata[1]==2 then
local pream1=lockdata[2]
local pream2=lockdata[3]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eFabaoJinglian]={ITEM_FILTER_COMPARE.eGreaterEquals,pream2}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabao
local num=0
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter,false,true)
for i,v in ipairs(baglist)do
num=num+1
end
if num<pream1 then
local equiplist=fabaoModel.getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do
num=num+1
end
end
lockStr=FMT.fmt('{0}件法宝的精炼等级\n达到{1}级解锁',pream1,pream2)
if num<pream1 then
return false,lockStr
end

elseif lockdata[1]==3 then
local pream1=lockdata[2]
local pream2=lockdata[3]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eVocEquip
local num=0
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eVocEquip,filter,false,true)
for i,v in ipairs(baglist)do
if v.itemData and v.itemData.enhancelv and v.itemData.enhancelv>=pream2 then
num=num+1
end
end
if num<pream1 then
local equiplist=vocEquipModel:getEquipByFilter(filter)
for i,v in ipairs(equiplist)do
if v.itemData and v.itemData.enhancelv>=pream2 then
num=num+1
end
end
end
lockStr=FMT.fmt('{0}件职业装备的强化等级\n达到{1}级解锁',pream1,pream2)
if num<pream1 then
return false,lockStr
end

elseif lockdata[1]==4 then
local pream1=lockdata[2]
local pream2=lockdata[3]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eFabaoLingXingLv]={ITEM_FILTER_COMPARE.eGreaterEquals,pream2}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabao
local num=0
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter,false,true)
for i,v in ipairs(baglist)do
num=num+1
end
if num<pream1 then
local equiplist=fabaoModel.getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do
num=num+1
end
end
lockStr=FMT.fmt('{0}件法宝的蕴养等级\n达到{1}级解锁',pream1,pream2)
if num<pream1 then
return false,lockStr
end

elseif lockdata[1]==5 then
local pream1=lockdata[2]
local pream2=lockdata[3]
local num=0
local disciples=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(disciples)do
if v.netData.net.qzctlv and v.netData.net.qzctlv>=pream2 then
num=num+1
end
end
local floorname,jie=UIDiscipleModel:getCuiTiNameEx2(pream2)
lockStr=FMT.fmt('{0}名弟子的炼体淬体\n达到{1}解锁',pream1,floorname)
if num<pream1 then
return false,lockStr
end

elseif lockdata[1]==6 then
local pream1=lockdata[2]
local pream2=lockdata[3]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFubao
local num=0
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFubaoBag,filter,false,true)
for i,v in ipairs(baglist)do
local lzData=UIYuFuLingZhenControl:getLingZhenData(v.itemguid)
if lzData then
local level=UIYuFuLingZhenControl:countTotalLevel(lzData)
if level>=pream2 then
num=num+1
end
end
end
if num<pream1 then

local fblist=UIFuLuFangModel:getAllFubaoLookDatas()
if fblist then
for i,v in pairs(fblist)do
local lzData=UIYuFuLingZhenControl:getLingZhenData(v.itemguid)
if lzData then
local level=UIYuFuLingZhenControl:countTotalLevel(lzData)
if level>=pream2 then
num=num+1
end
end
end
end
end
lockStr=FMT.fmt('{0}个玉符的灵阵总等级\n达到{1}级解锁',pream1,pream2)
if num<pream1 then
return false,lockStr
end

elseif lockdata[1]==7 then
local pream1=lockdata[2]
local pream2=lockdata[3]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eStarLv]={ITEM_FILTER_COMPARE.eGreaterEquals,pream2}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eDaoBing
local num=0
table.clear(temp)
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eDaoBingBag,filter,false,true)
for i,v in ipairs(baglist)do
num=num+1
end
if num<pream1 then
local equiplist=daobingModel:getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do
num=num+1
end
end
lockStr=FMT.fmt('{0}件道兵的星级达到{1}星',pream1,pream2)
if num<pream1 then
return false,lockStr
end
end
end
end
else
return true
end
return true,lockStr
end

function YunZhouZhenTuModel:getYZZTAllSkillData()
local skillList={}
for ztid=1,6 do
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
if yzztData then
local level=yzztData.level
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
local effectLevel=cfg.effectLevel
if effectLevel>0 then
table.insert(skillList,{id=ztid,effectLevel=effectLevel})
end
end
end
return skillList
end

function YunZhouZhenTuModel:getYZZTAllAttr()
local attrLookup={}
for ztid=1,6 do
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local isActive=false
local level=0
local effectLevel=0
if yzztData then
isActive=true
level=yzztData.level
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
effectLevel=cfg.effectLevel
end
if isActive then
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
local jzattr=cfg.jzattr

for i,v in ipairs(jzattr)do
local value=isActive and v[2]or 0
if attrLookup[v[1]]then
attrLookup[v[1]]=attrLookup[v[1]]+value
else
attrLookup[v[1]]=value
end
end
end
end
return attrLookup
end

function YunZhouZhenTuModel:getYZZTAttrAddList()
if not YunZhouZhenTuController:checkYunZhouZhenTuSystem()then
return nil
end
local lookupList={}
for ztid=1,6 do
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local isActive=false
local level=0
local effectLevel=0
if yzztData then
isActive=true
level=yzztData.level
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
effectLevel=cfg.effectLevel
end
if isActive then
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
local attrList=cfg.jzattr
for i,v in ipairs(attrList)do
local attrId=v[1]
local attrCfgVal=v[2]

if lookupList[attrId]then
lookupList[attrId]=lookupList[attrId]+attrCfgVal
else
lookupList[attrId]=attrCfgVal
end
end
end
end
if lookupList and next(lookupList)then
return lookupList
else
return nil
end
end
function YunZhouZhenTuModel.setYZZTDiscipleAttrListDirty(gfID,showFightTips)
local all_dis=UIDiscipleModel:getAllDiscipleData()
if all_dis then
for k,v in pairs(all_dis)do
local guid=v.netData.net.discipleguid
UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eGongFa,showFightTips)
end
end
end


function YunZhouZhenTuModel:getYZZTJunZhenAttr(dizilist)
local attrLookup={}
if not YunZhouZhenTuController:checkYunZhouZhenTuSystem()then
return attrLookup
end

attrLookup[351]=0
attrLookup[352]=0
attrLookup[353]=0
for k,dzData in ipairs(dizilist)do
if dzData.flag and dzData.flag~=0 then
local fabao_lvl=0
local vocEquip_lvl=0
local fabaoyy_lvl=0
local cuiti_lvl=0
local yufu_lvl1=0
local yufu_lvl2=0
local daobing_lvl=0
local discipleguid=dzData.discipleguid
local equip=fabaoModel.getFabaoByDizi(discipleguid)


if equip then
local jinglianlv=equip.itemData and equip.itemData.jilianlv or 0
fabao_lvl=fabao_lvl+jinglianlv
end


local vocEquiplv=vocEquipModel.getVocEquipStrengthenLevelByDizi(discipleguid)or 0
vocEquip_lvl=vocEquip_lvl+vocEquiplv


if equip then
local itemguid=equip.itemguid
local lxlv=fabaoModel.getLingXingLv(itemguid)or 0
fabaoyy_lvl=fabaoyy_lvl+lxlv
end


local cuitilvl=dzData.qzctlv or 0
cuiti_lvl=cuiti_lvl+cuitilvl


local fbData1=UIFuLuFangModel:getFubaoData(discipleguid,1)
if fbData1 then
local lzData=UIYuFuLingZhenControl:getLingZhenData(fbData1.itemguid)
if lzData then
local yflevel=UIYuFuLingZhenControl:countTotalLevel(lzData)
yufu_lvl1=yufu_lvl1+yflevel
end
end
local fbData2=UIFuLuFangModel:getFubaoData(discipleguid,2)
if fbData2 then
local lzData=UIYuFuLingZhenControl:getLingZhenData(fbData2.itemguid)
if lzData then
local yflevel=UIYuFuLingZhenControl:countTotalLevel(lzData)
yufu_lvl2=yufu_lvl2+yflevel
end
end


local daobinglv=daobingModel:getStarByDizi(discipleguid)or 0
daobing_lvl=daobing_lvl+daobinglv

for ztid=1,6 do
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local isActive=false
local level=0
local effectLevel=0
if yzztData then
isActive=true
level=yzztData.level
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
effectLevel=cfg.effectLevel
end
local yzcfg=cfg_yunzhouzhentuconfig_get(ztid)
if isActive and effectLevel>0 then


local specialEffect=yzcfg.specialEffect
local effect=specialEffect[effectLevel]
local type=effect[1]
local initlvl=effect[2][1]
local arrdata=effect[2][2][1]
local fslvl=effect[2][3]
local arrdata2=effect[2][4][1]
if not attrLookup[arrdata[1]]then
attrLookup[arrdata[1]]=0
end

local alllvl=0
if type==1 then
alllvl=fabao_lvl
elseif type==2 then
alllvl=vocEquip_lvl
elseif type==3 then
alllvl=fabaoyy_lvl
elseif type==4 then
alllvl=cuiti_lvl
elseif type==5 then
if yufu_lvl1>0 then
local cha=yufu_lvl1-initlvl
if cha>0 then
attrLookup[arrdata[1]]=attrLookup[arrdata[1]]+arrdata[2]
if(cha/fslvl)>0 then
local cha2=math.floor(cha/fslvl)*arrdata2[2]
attrLookup[arrdata[1]]=attrLookup[arrdata[1]]+cha2
end
elseif cha==0 then
attrLookup[arrdata[1]]=attrLookup[arrdata[1]]+arrdata[2]
end
end
if yufu_lvl2>0 then
local cha=yufu_lvl2-initlvl
if cha>0 then
attrLookup[arrdata[1]]=attrLookup[arrdata[1]]+arrdata[2]
if(cha/fslvl)>0 then
local cha2=math.floor(cha/fslvl)*arrdata2[2]
attrLookup[arrdata[1]]=attrLookup[arrdata[1]]+cha2
end
elseif cha==0 then
attrLookup[arrdata[1]]=attrLookup[arrdata[1]]+arrdata[2]
end
end
elseif type==6 then
alllvl=daobing_lvl
end

if alllvl>0 and type~=5 then
local cha=alllvl-initlvl
if cha>0 then
attrLookup[arrdata[1]]=attrLookup[arrdata[1]]+arrdata[2]
if(cha/fslvl)>0 then
local cha2=math.floor(cha/fslvl)*arrdata2[2]
attrLookup[arrdata[1]]=attrLookup[arrdata[1]]+cha2
end
elseif cha==0 then
attrLookup[arrdata[1]]=attrLookup[arrdata[1]]+arrdata[2]
end
end
end


end
end
end

return attrLookup
end

































































































































































