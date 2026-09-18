
UIFuLuFangModel={}

FUBAO_EFFECT_TYPE=
{

eBaseAttr=1,
eProfessionLevel=2,
eSixAttr=3,
eProfessionExp=4,
eBuildLevelUpMaterial=5,
eBuildLevelUpTime=6,
eGongFaExpSpeed=7,
eInjuryRecoverSpeed=8,
eLianTiSpeed=9,
eXiuWeiSpeed=10,
}

FULU_TAB_TYPE=
{
eFuBao=1,
eXianLu=2,
}

function UIFuLuFangModel:onEnterState(isReconnect)
if isReconnect then
return
end
self.data={
unlockYFData={},
unlockFLData={},
newUnlockData={{},{}}
}
self.fubaoDatas={}
self.fubaoLookup={}
self.diziLookup={}
self:setUnlockItemDict()
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.on_disciple_remove)
end

function UIFuLuFangModel:onLeaveState(isReconnect)
if isReconnect then
return
end
notifySystem:removelistener(notifyConfig.onDiscipleRemove,self.on_disciple_remove)
self.data=nil
self.fubaoDatas={}
self.fubaoLookup={}
self.diziLookup={}
self.fubaoFJCheck=nil
self.fubaoQuickCheck=nil
end

function UIFuLuFangModel.on_disciple_remove(type,guid)
UIFuLuFangModel:removeLookup(guid)
end




















function UIFuLuFangModel:setDatas(datas)
local produceData={}
if datas[1]>0 then
for i,v in ipairs(datas[2])do



produceData[v.un_build_id]=v
end
end
self.data.produceData=produceData
local yfData={}
if datas[3]>0 then
for i,v in ipairs(datas[4])do
yfData[v]=true
end
end
self.data.unlockYFData=yfData
local flData={}
if datas[5]>0 then
for i,v in ipairs(datas[6])do
flData[v.param_1]={id=v.param_1,level=v.param_2,flag=v.param_3}
end
end
self.data.unlockFLData=flData
end

function UIFuLuFangModel:getConfig(flType,id)
if flType==FULU_TAB_TYPE.eFuBao then
return cfgHelper.get1(cfg_yufufangconfig_get,id)
elseif flType==FULU_TAB_TYPE.eXianLu then
return cfgHelper.get1(cfg_fulufangconfig_get,id)
end
end

function UIFuLuFangModel:setNewUnlockData(flType,id)
self.data.newUnlockData[flType][id]=flType
end

function UIFuLuFangModel:haveNewUnlock(flType)
local data=self.data.newUnlockData[flType]
if data then
return next(data)~=nil
end
return false
end

function UIFuLuFangModel:clearNewUnlockData(flType)
local check=self:haveNewUnlock(flType)
if check then
self.data.newUnlockData[flType]={}
UIFullFuLuFangControl:refreshAllFuluBuildHud()
end
end

function UIFuLuFangModel:getANewUnlockData(flType)
local data=self.data.newUnlockData[flType]
if data then
local k,v=next(data)
if k then
return k,v
end
end
end

function UIFuLuFangModel:setUnlockItemDict()
local unlockItemDict={}
local cfgs=cfg_yufufangconfig()
for k,v in pairs(cfgs)do
if k~='const_def'then
if v.unlock and v.unlock[1]==2 then
local item=v.unlock[2][1]
unlockItemDict[item[1]]={flType=1,id=v.id,needId=item[1],needNum=item[2]}
end
end
end
cfgs=cfg_fulufangconfig()
for k,v in pairs(cfgs)do
if k~='const_def'then
if v.unlock and v.unlock[1]==2 then
local item=v.unlock[2][1]
unlockItemDict[item[1]]={flType=2,id=v.id,needId=item[1],needNum=item[2]}
end
end
end
self.unlockItemDict=unlockItemDict
end

function UIFuLuFangModel:getUnlockItemDict()
return self.unlockItemDict
end

function UIFuLuFangModel:getProduceData(ubdId)
if self.data.produceData then
return self.data.produceData[ubdId]
end
end

function UIFuLuFangModel:setProduceData(ubdId,data)
self.data.produceData[ubdId]=data
end

function UIFuLuFangModel:getOneKeyPrizeData()
if not self.data.produceData then
return nil
end
local sfId=mapIdType.zhufeng
local temp={}
for ubdId,pdata in pairs(self.data.produceData)do
local cddata=buildingCDControl:getCDData(buildingCDType.zhifu,ubdId)
local count=cddata.currStep-pdata.rec_cnt
if count>0 then
temp[#temp+1]={5,sfId,ubdId,count}
end
end
return temp
end

function UIFuLuFangModel:isYuFuUnlock(id)
if self.data.unlockYFData and self.data.unlockYFData[id]then
return true
end

local cfg=cfgHelper.get1(cfg_yufufangconfig_get,id)
if not cfg.unlock then
return true
end

local utype=cfg.unlock[1]
if utype==1 then
local zmLevel=zongmenModel:getLevel()
if zmLevel>=cfg.unlock[2]then
return true
end
end

if utype==2 then
local item=cfg.unlock[2][1]
local count=bagModel.getItemCountById(item[1])
if count>=item[2]then
return true
end
end

return false
end

function UIFuLuFangModel:getUnlockTips(cfg)
local utype=cfg.unlock[1]
if utype==1 then
return FMT.fmt('需宗门达到{0}级',cfg.unlock[2])
end
if utype==2 then
local item=cfg.unlock[2][1]
local name=itemsConfig.getColorName(item[1])
return FMT.fmt('需获取{0}解锁',name)
end
end

function UIFuLuFangModel:isFuLuUnlock(id)
local data=self:getFuLuData(id)
if data then
return true
end

local cfg=cfgHelper.get1(cfg_fulufangconfig_get,id)
if not cfg.unlock then
return true
end

local utype=cfg.unlock[1]
if utype==1 then
local zmLevel=zongmenModel:getLevel()
if zmLevel>=cfg.unlock[2]then
return true
end
end

return false
end










function UIFuLuFangModel:unlockFuLu(ftype,id)
if ftype==1 then
self.data.unlockYFData[id]=true
elseif ftype==2 then
self.data.unlockFLData[id]={id=id,level=0,flag=0}
end
end

function UIFuLuFangModel:setFuLuLevel(id,level)
local data=self.data.unlockFLData[id]
if data then
data.level=level
else
self.data.unlockFLData[id]={id=id,level=level,flag=0}
end
end






function UIFuLuFangModel:getFuLuData(id)
local data=self.data.unlockFLData[id]
return data
end

























function UIFuLuFangModel:getRating(id)

local data=self:getFuLuData(id)
if data then
return data.level
else
return 1
end
end














function UIFuLuFangModel:updateFuLuData(id,level,flag)
local data=self.data.unlockFLData[id]
if data then
data.level=level
data.flag=flag
else
self.data.unlockFLData[id]={id=id,level=level,flag=flag}
end
end

function UIFuLuFangModel:changeFuBaoFlag(id,grade)
local flData=self.data.flData
local fubaoData=flData.fubaoData
local data=fubaoData[id]
if data then
if grade==0 then
local config=cfgHelper.get1(cfg_fubaofangconfig_get,id)
local rateRewards=config.fubao_rewards
for k,v in pairs(rateRewards)do
if k<=data.level then
data.flag=mathHelper.setbit(data.flag,k-1)
end
end
else
data.flag=mathHelper.setbit(data.flag,grade-1)
end
end
end

function UIFuLuFangModel:checkRateRewardIsGot(id,grade)
local data=self:getFuLuData(id)
if data then
return mathHelper.getBitValue(data.flag,grade-1)
end
return false
end

function UIFuLuFangModel:initFuBaoDatas(diziArray)
self.fubaoDatas={}
self.fubaoLookup={}
self.diziLookup={}
for i,v in ipairs(diziArray)do
self:addFuBaoData(v)
equipsModel.setAllEquipedAttrsDirty(v.discipleguid)
UIDiscipleModel:setDiscipleAttrListDirtyX(v.discipleguid,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,false)
UIDiscipleModel:setDiscipleAttrListDirtyX(v.discipleguid,DISCIPLE_ATTRIBUTE_TYPE.eSkill,false)

equipsModel.onChangeAttrsOnJinglianEquipbyFulu(v.discipleguid,false)
end
end

function UIFuLuFangModel:removeLookup(dzguid)
local guidstr=tostring(dzguid)
for k,v in pairs(self.diziLookup)do
local guid=v.guid
if tostring(guid)==guidstr then
local itemkey=k
self.fubaoLookup[itemkey]=nil
self.diziLookup[itemkey]=nil
end
end
self.fubaoDatas[guidstr]=nil
end

function UIFuLuFangModel:addFuBaoData(dzData)
local diziguid=dzData.discipleguid
local diziguidStr=tostring(diziguid)
local equips=dzData.livingEquipList
if equips then
local switchidx=0
if self.fubaoDatas[diziguidStr]~=nil and self.fubaoDatas[diziguidStr][switchidx]~=nil then

return
end

local data={}
for i,v in ipairs(equips)do
local itemdata=v.prePartInfo
data[v.pos]=itemdata

self.fubaoLookup[tostring(itemdata.itemguid)]=itemdata

self.diziLookup[tostring(itemdata.itemguid)]={guid=diziguid,switchidx=switchidx}
if not self.fubaoDatas[diziguidStr]then
self.fubaoDatas[diziguidStr]={}
end
self.fubaoDatas[diziguidStr][switchidx]=data


if itemdata.itemData and itemdata.itemData.lzItem then
local zItem=itemdata.itemData.lzItem
local list={}
if zItem.len>0 then
for ii,vv in ipairs(zItem.kongList)do
if vv.itemId>0 then
list[vv.index]=vv

LingZhenChongZhuModel:saveChongZhuEquipByEquip(vv.itemGuid,vv.randAttrIdList2,vv.randAttrIdList3)

UIYuFuLingZhenControl:calcLingZhenEquipedNum(1)
local lv=UIYuFuLingZhenControl:getItemLevel(vv.itemId)
UIYuFuLingZhenControl:calcLingZhenEquipedLevelNum(lv,1)
end
end
end
end
end
end


if dzData.switchList and next(dzData.switchList)then
for switchidx,data in ipairs(dzData.switchList)do
local switchEquipList=data.livingEquipList
if switchEquipList then
if self.fubaoDatas[diziguidStr]~=nil and self.fubaoDatas[diziguidStr][switchidx]~=nil then

return
end

local data={}
for i,v in ipairs(switchEquipList)do
local itemdata=v.prePartInfo
data[v.pos]=itemdata

self.fubaoLookup[tostring(itemdata.itemguid)]=itemdata

self.diziLookup[tostring(itemdata.itemguid)]={guid=diziguid,switchidx=switchidx}
if not self.fubaoDatas[diziguidStr]then
self.fubaoDatas[diziguidStr]={}
end
self.fubaoDatas[diziguidStr][switchidx]=data
end
end
end
end
end

function UIFuLuFangModel:removeFuBaoData(diziguid)
local idStr=tostring(diziguid)
local data=self.fubaoDatas[idStr]
for k,v in pairs(data)do
self.fubaoLookup[tostring(v.itemguid)]=nil
self.diziLookup[tostring(v.itemguid)]=nil
end
self.fubaoDatas[idStr]=nil
end

function UIFuLuFangModel:changeFuBaoData(diziguid,pos,item,switchidx)
switchidx=switchidx or 0
local idStr=tostring(diziguid)
if not self.fubaoDatas[idStr]then
self.fubaoDatas[idStr]={}
end
local switchList=self.fubaoDatas[idStr]
if not switchList[switchidx]then
switchList[switchidx]={}
end
local data=switchList[switchidx]
if data[pos]then
local itemId=tostring(data[pos].itemguid)
self.fubaoLookup[itemId]=nil
self.diziLookup[itemId]=nil
end
if item then
self.fubaoLookup[tostring(item.itemguid)]=item

self.diziLookup[tostring(item.itemguid)]={guid=diziguid,switchidx=switchidx}
end
data[pos]=item
self.fubaoDatas[idStr][switchidx]=data
if switchidx==0 then

self:resetDZYuFuData(idStr,data)
end
end

function UIFuLuFangModel:switchFuBaoData(diziguid,switchidx)
switchidx=switchidx or 0
local idStr=tostring(diziguid)
if not self.fubaoDatas[idStr]then
self.fubaoDatas[idStr]={}
end

local useSwitchIdx=0
local originalEquipList=self.fubaoDatas[idStr][useSwitchIdx]
local switchEquipList=self.fubaoDatas[idStr][switchidx]or{}
self.fubaoDatas[idStr][useSwitchIdx]=switchEquipList
self.fubaoDatas[idStr][switchidx]=originalEquipList

for pos=1,2 do
local switchEquip=switchEquipList and switchEquipList[pos]or nil
local originalEquip=originalEquipList and originalEquipList[pos]or nil
if originalEquip and next(originalEquip)then
self.diziLookup[tostring(originalEquip.itemguid)]={guid=diziguid,switchidx=switchidx}

end
if switchEquip and next(switchEquip)then
self.diziLookup[tostring(switchEquip.itemguid)]={guid=diziguid,switchidx=useSwitchIdx}

end
end
local data=self.fubaoDatas[idStr][useSwitchIdx]
self:resetDZYuFuData(idStr,data)

equipsModel.setAllEquipedAttrsDirty(diziguid)
UIDiscipleModel:setDiscipleAttrListDirtyX(diziguid,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,true)
UIDiscipleModel:setSkillLvPlusLookupDirty(diziguid,false)
equipsModel.onChangeAttrsOnJinglianEquipbyFulu(diziguid,false)
end

function UIFuLuFangModel:isEquipedOnDizi(diziguid,itemguid,switchidx)
local datas=self:getFubaoDatas(diziguid,switchidx)
if datas then
local idStr=tostring(itemguid)
for k,v in pairs(datas)do
if tostring(v.itemguid)==idStr then
return true,k
end
end
end
return false
end

function UIFuLuFangModel:isEquipedOnAnyDizi(itemguid)






local dzId=self:getDzGuidByItemGuid(itemguid)
return dzId~=nil
end

function UIFuLuFangModel:isEquipedSameTypeOnDizi(diziguid,tarItemid,pos)
local tarConfig=itemsConfig.getConfig(tarItemid)
local tarType=tarConfig.type2
local check_pos=pos==1 and 2 or 1
local fbData=UIFuLuFangModel:getFubaoData(diziguid,check_pos)
local onType
if fbData then
local itemid=fbData.itemid
local config=itemsConfig.getConfig(itemid)
onType=config.type2
end
if onType==tarType then
return true
end
return false
end

function UIFuLuFangModel.isCanDress(diziguid,itemid,warning)
local itemConfig=itemsConfig.getConfig(itemid)
local conditions=itemConfig.wear_conditions
for i,v in ipairs(conditions)do
if v[1]==1 then
local jingJieLv=UIDiscipleModel:getDiscipleJJLevel(diziguid)
if v[2]>jingJieLv then
if warning then
UIManager.error('弟子境界等级不足')
end
return false
end
end
end
return true
end

function UIFuLuFangModel:getLockBtnType(itemguid)
local item=self:getItem(itemguid)
if item then
if item.itemflag==0 then
return TIPS_BTNS_TYPE.eLockEquip
else
return TIPS_BTNS_TYPE.eUnlockEquip
end
end
end

function UIFuLuFangModel:getItem(itemguid)
local data=bagModel.getItem(itemguid)or
auctionModel:getItem(itemguid)or
mailModel:getItem(itemguid)
if not data then
data=self.fubaoLookup[tostring(itemguid)]
end
return data
end

function UIFuLuFangModel:getDzGuidByItemGuid(itemguid)
if not self.diziLookup then return end
local data=self.diziLookup[tostring(itemguid)]
return data and data.guid or nil
end

function UIFuLuFangModel:getSwitchidxByItemGuid(itemguid)
if not self.diziLookup then return end
local data=self.diziLookup[tostring(itemguid)]
return data and data.switchidx or nil
end















function UIFuLuFangModel:getFubaoDatas(dzId,switchidx)
switchidx=switchidx or 0
local idStr=tostring(dzId)

if self.fubaoDatas[idStr]==nil then return end
if self.fubaoDatas[idStr][switchidx]==nil then return end
return self.fubaoDatas[idStr][switchidx]
end

function UIFuLuFangModel:getAllFubaoDatas()
return self.fubaoDatas
end

function UIFuLuFangModel:getAllFubaoLookDatas()
return self.fubaoLookup
end

function UIFuLuFangModel:getEquipPos(dzId,guid)
local data=self:getFubaoDatas(dzId)
if data then
local gstr=tostring(guid)
for k,v in pairs(data)do
if tostring(v.itemguid)==gstr then
return k
end
end
end
return 0
end

function UIFuLuFangModel:getFubaoData(dzId,pos)
local data=self:getFubaoDatas(dzId)
if data then
return data[pos]
end
end

function UIFuLuFangModel:setFubaoData(dzId,pos,equip)
local data=self:getFubaoDatas(dzId)
if data then
data[pos]=equip
end
end

function UIFuLuFangModel:resetDZYuFuData(dzId,datas)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
local list={}
for k,v in pairs(datas)do
table.insert(list,{pos=k,prePartInfo=v})
end
dzData.livingequiplistlen=#list
dzData.livingEquipList=list
end

function UIFuLuFangModel:equipFuBao(dzId,guid,pos)
local equip=fubaoBagModel:getItem(guid)
self:setFubaoData(dzId,pos,equip)
end

function UIFuLuFangModel:UnequipFuBao(dzId,pos)
self:setFubaoData(dzId,pos,nil)
end

function UIFuLuFangModel:getFuBaoEffect(dzId,eType,arg1)
local netData=UIDiscipleModel:getDiscipleData(dzId)
return UIFuLuFangModel:getFuBaoEffectByData(netData,eType,arg1)
end

function UIFuLuFangModel:getFuBaoEffectByData(netData,eType,arg1)
local count=0
if netData then
count=UIFuLuFangModel.getFuBaoEffectEx(netData,eType,arg1)
end
return count
end

function UIFuLuFangModel.getFuBaoEffectEx(netData,eType,arg1)
local count=0
local fblist=netData.livingEquipList
if fblist then
for i,v in ipairs(fblist)do















local itemData=v.prePartInfo.itemData
if itemData.random_attr_len>0 then
for ii,vv in ipairs(itemData.randomAttrList)do
local val=vv.param_2
if eType==FUBAO_EFFECT_TYPE.eProfessionExp or eType==FUBAO_EFFECT_TYPE.eGongFaExpSpeed then
val=val/100
end
if vv.param_3==eType then
if eType==FUBAO_EFFECT_TYPE.eProfessionLevel or
eType==FUBAO_EFFECT_TYPE.eSixAttr or
eType==FUBAO_EFFECT_TYPE.eProfessionExp then
if vv.param_1==arg1 then
count=count+val
end
else
count=count+val
end
end
end
end
end
end
return count
end

function UIFuLuFangModel:getFuBaoEffectList(itemId)
local list={}
local cfg=itemsConfig.getConfig(itemId)
for i,v in ipairs(cfg.effects)do
local eType=v.type
if eType==FUBAO_EFFECT_TYPE.eProfessionLevel or
eType==FUBAO_EFFECT_TYPE.eSixAttr or
eType==FUBAO_EFFECT_TYPE.eProfessionExp or
eType==FUBAO_EFFECT_TYPE.eGongFaExpSpeed then
local d=list[eType]or{}
local dv=d[v.param[1]]or 0
dv=dv+v.param[2]
d[v.param[1]]=dv
list[eType]=d
else
local d=list[eType]or 0
d=d+v.param
list[eType]=d
end
end
return list
end

function UIFuLuFangModel.getFuBaoAttrLookup(itemguid)
local fubao=equipsHelper.getEquip(itemguid)
local itemData=fubao.itemData
if itemData.fix_attr_len==nil or#itemData.fixAttrLst<=0 then
return{}
end

local list={}
if itemData.fix_attr_len>0 then
for k,v in pairs(itemData.fixAttrLst)do
local etype=FUBAO_EFFECT_TYPE.eBaseAttr
local stype=v.param_1
local value=v.param_2
if not list[etype]then
list[etype]={}
end
list[etype][stype]=value
end
end
return list
end

function UIFuLuFangModel.getFuBaoRandomAttrLookup(item)
local itemData=item.itemData or{}
if itemData.random_attr_len==nil or itemData.random_attr_len<=0 then
return{}
end

local list={}
if itemData.random_attr_len>0 then
for k,v in pairs(itemData.randomAttrList)do
local etype=v.param_3
local stype=v.param_1
local value=v.param_2
if not list[etype]then
list[etype]={}
end
list[etype][stype]=value
end
end
return list
end


function UIFuLuFangModel.getEquipByFilter(discipleguid,filter,useCache)
local temp
if useCache then
temp=UIFuLuFangModel:getCacheTempTable_FubaoEquip()
else
temp={}
end

local dzguidList={}
for i,v in pairs(UIFuLuFangModel.fubaoDatas)do
table.insert(dzguidList,i)
end

table.sort(dzguidList,function(a,b)
local dzFightValue1=UIDiscipleModel:getDiscipleFightValue(a)
local dzFightValue2=UIDiscipleModel:getDiscipleFightValue(b)
return dzFightValue1>dzFightValue2
end)

for i,dzguidStr in ipairs(dzguidList)do
if dzguidStr~=tostring(discipleguid)then
local switchList=UIFuLuFangModel.fubaoDatas[dzguidStr]
for switchidx,v in pairs(switchList)do
for j,v1 in pairs(v)do
if itemsFilterHelper.isFilter(filter,v1)then
temp[#temp+1]=v1
end
end
end
end
end
return temp
end


function UIFuLuFangModel.getAllFuBao(discipleguid,filter,checkDress,useCache,hasSort)

local fubaoList
if checkDress then
fubaoList=UIFuLuFangModel.getEquipByFilter(discipleguid,filter,useCache)
else
if useCache then
fubaoList=UIFuLuFangModel:getCacheTempTable_FubaoEquip()
else
fubaoList={}
end
end

local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eFubaoBag,filter)

if hasSort then
local typeArr={ITEM_FILTER_TYPE.eFubaoRandomSixAttr,
ITEM_FILTER_TYPE.eFubaoAttr,
ITEM_FILTER_TYPE.eFubaoRandomAttrGongFaExp,
ITEM_FILTER_TYPE.eFubaoRandomAttrProfessionExp}

table.sort(bagList,function(a,b)
local aConfig=itemsConfig.getConfig(a.itemid)
local bConfig=itemsConfig.getConfig(b.itemid)
if aConfig.stage~=bConfig.stage then
return aConfig.stage>bConfig.stage
elseif aConfig.color~=bConfig.color then
return aConfig.color>bConfig.color
end

local attrLookup1=UIFuLuFangModel.getFuBaoAttrLookup(a.itemguid)
local attrLookup2=UIFuLuFangModel.getFuBaoAttrLookup(b.itemguid)

local randomAttrLookup1=UIFuLuFangModel.getFuBaoRandomAttrLookup(a)
local randomAttrLookup2=UIFuLuFangModel.getFuBaoRandomAttrLookup(b)
for i,j in ipairs(typeArr)do
if filter[j]and filter[j][2]~=nil then
local stypelist=filter[j][2]
for _,v in ipairs(stypelist)do
local etype=v[1]
local stype=v[2]
if j==ITEM_FILTER_TYPE.eFubaoAttr then
local value1=attrLookup1[etype]and attrLookup1[etype][stype]or 0
local value2=attrLookup2[etype]and attrLookup2[etype][stype]or 0
if value1~=value2 then
return value1>value2
end
else
local value1=randomAttrLookup1[etype]and randomAttrLookup1[etype][stype]or 0
local value2=randomAttrLookup2[etype]and randomAttrLookup2[etype][stype]or 0
if value1~=value2 then
return value1>value2
end
end
end
end
end
end)
end

for i,v in ipairs(bagList)do
fubaoList[#fubaoList+1]=v
end
return fubaoList
end

function UIFuLuFangModel.getAllFuBaoToBagEmot()
local temp={}
for k,v in pairs(UIFuLuFangModel.fubaoLookup)do
local discipleguid=UIFuLuFangModel:getDzGuidByItemGuid(v.itemguid)
local isSelfDZ=UIDiscipleModel:isMyActorDZ(discipleguid)
if isSelfDZ then
temp[#temp+1]=v
end
end
return temp
end


function UIFuLuFangModel:getRateRewardList(config)
local rewards=config.fubao_rewards
local rateCfg=cfg_fubaoratingconfig()
local list={}
for i=1,#rateCfg do
if rewards[i]then
table.insert(list,{i,rewards[i]})
end
end
return list
end

function UIFuLuFangModel:checkHaveReward()
local cfgs=cfg_fulufangconfig()
for i,v in ipairs(cfgs)do
local redot=UIFuLuFangModel:checkFuLuRateReward(v.id)
if redot then
return true
end
end
return false
end
















function UIFuLuFangModel:checkFuLuRateReward(id)
local data=self:getFuLuData(id)
if data then
local config=cfgHelper.get1(cfg_fulufangconfig_get,id)
local list=self:getRateRewardList(config)
local minRate=list[1][1]
local checkFlag=mathHelper.getBitValue(data.flag,data.level-1)
if data.level>=minRate and not checkFlag then
return true
end
end
return false
end






















function UIFuLuFangModel:checkRateRewardGotAll(id)
local data=self:getFuLuData(id)
if data then
local config=cfgHelper.get1(cfg_fulufangconfig_get,id)
local list=self:getRateRewardList(config)
local have=false
for i,v in ipairs(list)do
local checkFlag=mathHelper.getBitValue(data.flag,v[1]-1)
if not checkFlag then
have=true
break
end
end
if not have then
return true
end
end
return false
end

function UIFuLuFangModel:recordReward(list)






self.data.rewardlist=list or{}
end

function UIFuLuFangModel:getRecordReward()
return self.data.rewardlist
end

function UIFuLuFangModel:clearRecordReward()
self.data.rewardlist={}
end


function UIFuLuFangModel:setFuBaoFenJieState(val)
self.fubaoFJCheck=val
end

function UIFuLuFangModel:getFuBaoFenJieState()
return self.fubaoFJCheck
end

function UIFuLuFangModel:setFuBaoQuickState(val)
self.fubaoQuickCheck=val
end

function UIFuLuFangModel:getFuBaoQuickState()
return self.fubaoQuickCheck
end

function UIFuLuFangModel:checkCanMakeAll()
local args=tempDataControl:getWinData('UIFuLuMixWin')
if not args then
return false
end
local bdData=zongmenModel:getBuildingData(args.ubdId)
local cfgs=cfg_yufufangconfig()
for k,v in pairs(cfgs)do
if k~='const_def'then
local isRed=UIFuLuFangModel:checkCanMakeItem(v,bdData)
if not v.lock_hide and isRed then
return true
end
end
end
return false
end

function UIFuLuFangModel:checkCanMakeItem(data,bdData)
local unlock=UIFuLuFangModel:isYuFuUnlock(data.id)
if not unlock then
return false
end
local costs=data.cost
local needLv=data.need_fl_lvl
local dzId=bdData.dizi_id
local buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local skill_id=buildCfg.pro_skill_id
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
if level<needLv then
return false
end
local percent=bdData.pcreatesubpercent or 0
if not UIFuLuFangModel:checkCanMake(costs,false,1,percent)then
return false
end
return true
end

function UIFuLuFangModel:checkCanMake(costs,errorMsg,count,percent)
local cnt=count or 1
for i,v in ipairs(costs)do
local itemId=v[1]
local price=v[2]
local itemConfig=itemsConfig.getConfig(itemId)
local have
if moneyConfig.isMoney(itemId)then
price=math.ceil(price*(1+percent/100))
have=moneyModel.getMoney(itemId)
else
have=bagModel.getItemCountById(itemId)
end
local itemCount=price*cnt
if have<itemCount then
if errorMsg then
UIManager.error(FMT.fmt('{0}不足',itemConfig.name))
gainControl:showGainWin(itemId)
end
return false
end
end
return true
end

function UIFuLuFangModel:getCanMakeNum(itemList,percent)
local clist={}
for i,v in ipairs(itemList)do
local id=v[1]
local count=v[2]
local have
if moneyConfig.isMoney(id)then
count=math.ceil(count*(1+percent*0.01))
have=moneyModel.getMoney(id)
else
have=bagModel.getItemCountById(id)
end
clist[i]=math.floor(have/count)
end
local min=clist[1]
for i,v in ipairs(clist)do
if v<min then
min=v
end
end
return min
end

function UIFuLuFangModel:getItemCountStr(itemid,needCount)
local have=self:getHaveItemCount(itemid)
local colorStr=have<needCount and'#E33021FF'or'#ffffffff'
local countStr=''
if moneyConfig.isMoney(itemid)then
countStr=FMT.fmt('<color={0}>{1}</color>',colorStr,mathHelper.formatBIGNumbereEx(needCount))
else
countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,mathHelper.formatBIGNumbereEx(have),mathHelper.formatBIGNumbereEx(needCount))
end
return countStr
end

function UIFuLuFangModel:getHaveItemCount(itemid)
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
return have
end

function UIFuLuFangModel:getMaxLianZhiCount(config,percent)
local costList=config.cost
local max
for i,v in ipairs(costList)do
local itemid=v[1]
local price=v[2]
if percent~=0 then
price=math.ceil(price*(1+percent/100))
end
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
local can=math.floor(have/price)
if max==nil then
max=can
else
max=math.min(can,max)
end
end
return max
end


function UIFuLuFangModel:checkDiscipleNeedEquipFubao(diziguid)
local isNeed=false

local hasNotEquipFubao=false
for pos=1,2 do
local fbData=UIFuLuFangModel:getFubaoData(diziguid,pos)
if not fbData then
hasNotEquipFubao=true
break
end
end

if hasNotEquipFubao then
local fubaoList=UIFuLuFangModel.getAllFuBao(diziguid,{},false,true)
isNeed=fubaoList and#fubaoList>0
end

return isNeed
end


function UIFuLuFangModel:getCacheTempTable_FubaoEquip()
if not self.cache_temp_fubaoEquip then
self.cache_temp_fubaoEquip={}
end

table.clear(self.cache_temp_fubaoEquip)
return self.cache_temp_fubaoEquip
end