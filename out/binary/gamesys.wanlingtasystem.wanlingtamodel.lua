






local _MODULENAME="wanLingTaModel"




def_table(_MODULENAME)
wanLingTaModel.name=_MODULENAME
wanLingTaModel.data={}


eWanLingTaShowcaseType=
{
eZMBW=1,
eTCDB=2,
eXYHL=3,
eTDLX=4,
eSBLQ=5,
}

eWanLingTaConditionType=
{
eItem=1,
eCheckBagItem=2,
eDisciple=3,
eDiscipleTianMing=4,
eGuBao=5,
eCheckBagDiscipleEquip=6,
}

eWanLingTaSpeRewardType=
{
eGuBao=1,
eDaoBing=2,
eDisciple=3,
eProduceUp=4,
eJunZhen=5,
eXianMo=6,
eDiscipleJingJie=7,
eDiscipleLianTi=8,
eLingXiuBase=9,
eLingZhenBase=10,
}

local TJ_ID_LIST=
{
[1]=1,
[2]=2,
[3]=3,
[4]=4,
[5]=5,
}
local TJ_ID_BASE_NUM=1000
local xumitatujianconfig={}


function wanLingTaModel:onAppStart()
self:initConfig()


self.conditionFunc=
{
[eWanLingTaConditionType.eItem]=function(costItemId,costNum)
for i,v in ipairs(costItemId)do
local have=itemsModel.getCount(v)
local neednum=costNum[i]
if have<neednum then
return false
end
end
return true
end,
[eWanLingTaConditionType.eCheckBagItem]=function(costItemId,costNum)
for i,v in ipairs(costItemId)do
local have=itemsModel.getCount(v)
local neednum=costNum[i]
if have<neednum then
return false
end
end
return true
end,
[eWanLingTaConditionType.eDisciple]=function(costItemId,costNum)
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(costItemId)
return dzData~=nil
end,
[eWanLingTaConditionType.eDiscipleTianMing]=function(costItemId,costNum)
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(costItemId)
if not dzData then
return false
end
local dzNowTmLv=dzData.tmlv or-1
return dzNowTmLv>=costNum
end,
[eWanLingTaConditionType.eGuBao]=function(costItemId,costNum)
return gubaoModel:checkActive(costItemId)
end,
[eWanLingTaConditionType.eCheckBagDiscipleEquip]=function(costItemId,costNum)
local equip=bagControl.invokeFuncByItemId(costItemId,'getItemByItemID',costItemId)
if equip then
return true
end

local all_equip=equipsModel.getAllEquipByItemID(costItemId)
for _,equip in ipairs(all_equip)do
local guid=equipsModel.getDiziguidByItemguid(equip.itemguid)
if guid then
return true
end
end
return false
end,
}
end


function wanLingTaModel:onEnterState()
self:initData()
end


function wanLingTaModel:onLeaveState()

self.data={}
end


function wanLingTaModel:onProtocolReq()
self:initLookup()
self:initConfigLength()
end

function wanLingTaModel:initData()
self.data.tuJianData={}
self.data.tuJianCollect={}
self.data.tuJianTotalCollect=0
self.data.talingLevel=0
self.data.talingExp=0
self.data.talingRewardLevel=0
self.shopItemList={}
self.data.sjList={}
self.data.dzInfoList={}
self.sblqLookup={}
self.tdlxLookup={}
self.zmbwLookup={}
self.speAttrDirtyFlag=false
self.baseAttrDirtyFlag=false
end


function wanLingTaModel:initLookup()
self.sblqLookup={}
local sblqConfig=cfg_xumitasblqconfig()
for i,v in pairs(sblqConfig)do
local tjData=self:getTuJianData(v.id)
if tjData.level<=0 then
self.sblqLookup[v.needItem]=v.id
end
end
self.tdlxLookup={}
local tdlxConfig=cfg_xumitatdlxconfig()
for i,v in pairs(tdlxConfig)do
local itemid=v.activeUp[1][1][1]
self.tdlxLookup[itemid]=v.id
end
self.zmbwLookup={}
local zmbwConfig=cfg_xumitazmbwconfig()
for i,v in pairs(zmbwConfig)do
local itemid=v.activeUp[1][1][1]
self.zmbwLookup[itemid]=v.id
end
end

function wanLingTaModel:good2TDLX(itemid)
return self.tdlxLookup[itemid]
end

function wanLingTaModel:good2ZMBW(itemid)
return self.zmbwLookup[itemid]
end


function wanLingTaModel:initConfig()
self.configLength=0
self.configSubLength={}
self.collectConfig={}
self.xyhlLookup={}

local collectConfig=cfg_xumitasjjlconfig()
local xyhlConfig=cfg_xumitaxyhlconfig()

local typeConfig=cfg_xumitatujiantypeconfig()
for i,v in ipairs(typeConfig)do
local tj_config=require(string.format("data/config/%s",v.fileName))
xumitatujianconfig[i]=tj_config
end

for id,v in ipairs(collectConfig)do
local type=v.type
if not self.collectConfig[type]then
self.collectConfig[type]={}
end
table.insert(self.collectConfig[type],v)
end

for id,v in pairs(xyhlConfig)do
local dzId=v.needItem
self.xyhlLookup[dzId]=id
end
end


function wanLingTaModel:initConfigLength()
self.configLength=0
self.configSubLength={}
local typeConfig=cfg_xumitatujiantypeconfig()
for i,v in ipairs(typeConfig)do
local tj_config=require(string.format("data/config/%s",v.fileName))
if not self.configSubLength[i]then
self.configSubLength[i]=0
end
for tj_id,cfg in pairs(tj_config)do
if cfg.activeShow then
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(cfg.needItem)
if dzData then
self.configSubLength[i]=self.configSubLength[i]+1
end
else
self.configSubLength[i]=self.configSubLength[i]+1
end
end
self.configLength=self.configLength+self.configSubLength[i]
end
end


function wanLingTaModel:traverseActiveSbLQ()
if self.sblqLookup then
for itemid,tj_id in pairs(self.sblqLookup)do
local tjData=self:getTuJianData(tj_id)
if tjData.level<=0 then
local has_bag=false
local equip=bagControl.invokeFuncByItemId(itemid,'getItemByItemID',itemid)
if equip then
has_bag=true
wanLingTaController.send_43_3(tj_id,1,{{equip.itemguid,0}})
end

if not has_bag then
local all_equip=equipsModel.getAllEquipByItemID(itemid)
for _,equip in ipairs(all_equip)do
local guid=equipsModel.getDiziguidByItemguid(equip.itemguid)
if guid then
wanLingTaController.send_43_3(tj_id,1,{{guid,1}})
break
end
end
end
end
end
end
end


function wanLingTaModel:checkActiveSbLQ(itemid,itemguid)
if self.sblqLookup[itemid]then
local tj_id=self.sblqLookup[itemid]
local tjData=self:getTuJianData(tj_id)
if tjData.level<=0 then
wanLingTaController.send_43_3(tj_id,1,{{itemguid,0}})
else
self.sblqLookup[itemid]=nil
end
end
end


function wanLingTaModel:checkDiscipleSaveLevel(discipleguid,newlv)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if not netData then return end
local dzId=netData.id
local tj_id=self.xyhlLookup[dzId]
if tj_id then
local save_lv=wanLingTaModel:getDiscipleHighestLevel(dzId)
if newlv>save_lv then
wanLingTaController.send_43_6(discipleguid,tj_id)
end
end
end


function wanLingTaModel:checkDiscipleIsXYHL(dzId)
return self.xyhlLookup[dzId]~=nil
end


function wanLingTaModel:getTuJianCollectConfig(type)
return self.collectConfig[type]or defaultT
end


function wanLingTaModel:getTuJianConfig(tj_id)
local idx=math.floor(tj_id/TJ_ID_BASE_NUM)+1
local real_id=TJ_ID_LIST[idx]
if not real_id then return end
local tj_config=xumitatujianconfig[real_id]
if not tj_config then return end
return tj_config[tj_id]
end


function wanLingTaModel:getTuJianTypeConfig(typeId)
return xumitatujianconfig[typeId]
end

function wanLingTaModel:getTuJianType(tj_id)
local idx=math.floor(tj_id/TJ_ID_BASE_NUM)+1
local type_id=TJ_ID_LIST[idx]
return type_id
end

function wanLingTaModel:setData(args)
if args.level then
local old=self.data.talingLevel
self.data.talingLevel=args.level
if old~=args.level then
notifySystem:postNotify(notifyConfig.onWanLingTaLevelRewardChange)
taskController.onWanLingTaLevelChange()
end
end
if args.exp then
self.data.talingExp=args.exp
end
if args.rewardLevel then
local old=self.data.talingRewardLevel
self.data.talingRewardLevel=args.rewardLevel
if old~=args.rewardLevel then
notifySystem:postNotify(notifyConfig.onWanLingTaLevelRewardChange)
end
end
if args.tjData then
local typeId
local typeIdList={}
for i,v in ipairs(args.tjData)do
typeId=self:getTuJianType(v.id)
if typeId then
self.data.tuJianData[typeId]=self.data.tuJianData[typeId]or{}
self.data.tuJianData[typeId][v.id]=v
typeIdList[typeId]=true
end
end
if next(typeIdList)then
for tid,v in pairs(typeIdList)do
self:setCollectCount(tid)
end
wanLingTaModel:setTotalCollect()
end
end
if args.sjList then
for i,sjId in ipairs(args.sjList)do
self.data.sjList[sjId]=1
end
end
if args.dzInfoList then
for i,v in ipairs(args.dzInfoList)do
local dzId=v.param_1
local lv=v.param_2
self.data.dzInfoList[dzId]=lv
end
end
end


function wanLingTaModel:setCollectCount(typeId)
if self.data.tuJianData[typeId]then
self.data.tuJianCollect[typeId]=0
for id,v in pairs(self.data.tuJianData[typeId])do
if v.level>0 then
self.data.tuJianCollect[typeId]=self.data.tuJianCollect[typeId]+1
end
end
end
end


function wanLingTaModel:setTotalCollect()
self.data.tuJianTotalCollect=0
for id,v in pairs(self.data.tuJianCollect)do
self.data.tuJianTotalCollect=self.data.tuJianTotalCollect+v
end
end


function wanLingTaModel:getCollectCount(typeId)
if typeId then
return self.data.tuJianCollect[typeId]or 0,self.configSubLength[typeId]or 0
else
return self.data.tuJianTotalCollect,self.configLength
end
end


function wanLingTaModel:getTaLingLevel()
return self.data.talingLevel or 0
end


function wanLingTaModel:getTaLingExp()

local exp=moneyModel.getMoney(eMoneyType.mtXmtExp)
return exp
end

function wanLingTaModel:getTaLingNeedExp(level)
level=level or(self:getTaLingLevel()+1)
local taLingConfig=cfgHelper.get1(cfg_xumitatllevelconfig_get,level)
if taLingConfig then
return taLingConfig.exp
end
return 0
end


function wanLingTaModel:getTaLingRewardLevel()
return self.data.talingRewardLevel or 0
end


function wanLingTaModel:getTuJianData(id)
local typeId=wanLingTaModel:getTuJianType(id)
if typeId then
self.data.tuJianData[typeId]=self.data.tuJianData[typeId]or{}
self.data.tuJianData[typeId][id]=self.data.tuJianData[typeId][id]or{id=id,level=0}
return self.data.tuJianData[typeId][id]
end
end

function wanLingTaModel:getTuJianTypeData(typeId,id)
self.data.tuJianData[typeId]=self.data.tuJianData[typeId]or{}
self.data.tuJianData[typeId][id]=self.data.tuJianData[typeId][id]or{id=id,level=0}
return self.data.tuJianData[typeId][id]
end

function wanLingTaModel:getTuJianGroupConfig(typeId)
return cfg_xumitatujiantypeconfig_get(typeId)
end


function wanLingTaModel:checkCollectTargetReceived(sjId)
return self.data.sjList[sjId]==1
end


function wanLingTaModel:getDiscipleHighestLevel(dzId)
return self.data.dzInfoList[dzId]or 0
end


function wanLingTaModel:checkTuJianReddot(id)
local data=wanLingTaModel:getTuJianData(id)
local conf=wanLingTaModel:getTuJianConfig(id)
if not conf then
return false
end
local typeId=wanLingTaModel:getTuJianType(id)
local level=data.level
local activeUp=conf.activeUp
local maxLevel=activeUp and#activeUp or 1
if level>=maxLevel then
return false
end
local isActive=level==0
local nextLevel=level+1
local costNum,costItemId
if typeId==eWanLingTaShowcaseType.eSBLQ then
costNum=1
costItemId=conf.needItem
elseif typeId==eWanLingTaShowcaseType.eXYHL then
costNum=activeUp[nextLevel]
costItemId=conf.needItem
else
local itemList=activeUp[nextLevel]
costItemId={}
costNum={}
for i,v in ipairs(itemList)do
local itemid=v[1]
local itemnum=v[2]
table.insert(costItemId,itemid)
table.insert(costNum,itemnum)
end
end

local typeCfg=wanLingTaModel:getTuJianGroupConfig(typeId)
local cndType=isActive and typeCfg.activeType or typeCfg.upType
return wanLingTaModel:checkCondition(cndType,costItemId,costNum)
end

function wanLingTaModel:checkCondition(cndType,costItemId,costNum)
local func=self.conditionFunc[cndType]
if func then
return func(costItemId,costNum)
end
return false
end


function wanLingTaModel:checkAllTypeTuJianReddot()
for _,v in pairs(eWanLingTaShowcaseType)do
if self:checkTypeTuJianReddot(v)then
return true
end
end
return false
end


function wanLingTaModel:checkTypeTuJianReddot(typeId)
local isSBLQ=typeId==eWanLingTaShowcaseType.eSBLQ
local typeCfg=wanLingTaModel:getTuJianTypeConfig(typeId)
for _,v in pairs(typeCfg)do
if self:checkTuJianReddot(v.id)then
return true
end
end
return false
end


function wanLingTaModel:checkSBLQFirstReddot(id)
local typeId=wanLingTaModel:getTuJianType(id)
if typeId~=eWanLingTaShowcaseType.eSBLQ then
return false
end
local tj_data=wanLingTaModel:getTuJianData(id)
if tj_data.level<=0 then
return false
end
local record=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWanLingTa,'SBLQReddot',{})
local key=tostring(id)
if record[key]then
return false
end
return true
end


function wanLingTaModel:recordSBLQFirstReddot(id)
if wanLingTaModel:checkSBLQFirstReddot(id)then
local record=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWanLingTa,'SBLQReddot',{})
local key=tostring(id)
record[key]=true
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWanLingTa,'SBLQReddot',record)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWanLingTa)
notifySystem:postNotify(notifyConfig.onWanLingTaTuJianChange,id,1)
wanLingTaController:refreshBuildingStatusHUD()
end
end


function wanLingTaModel:checkTaLingLevelRewardReddot()
local cfgs=cfg_xumitatllevelconfig()
local taLingLevel=wanLingTaModel:getTaLingLevel()
local rewardLevel=wanLingTaModel:getTaLingRewardLevel()
local exp=wanLingTaModel:getTaLingExp()
local needExp=wanLingTaModel:getTaLingNeedExp()
if taLingLevel<#cfgs and exp>=needExp then
return true
end
if rewardLevel>=taLingLevel then
return false
end
for lv=rewardLevel+1,taLingLevel do
local cfg=cfgs[lv]
if cfg.items then
return true
end
end
return false
end


function wanLingTaModel:checkAllTypeCollectTargetReddot()
for _,v in pairs(eWanLingTaShowcaseType)do
if self:checkTypeCollectTargetReddot(v)then
return true
end
end
return false
end


function wanLingTaModel:checkTypeCollectTargetReddot(typeId)
local collectCfgs=self:getTuJianCollectConfig(typeId)
for _,v in ipairs(collectCfgs)do
if self:checkCollectTargetReddot(v.id)then
return true
end
end
return false
end


function wanLingTaModel:checkCollectTargetReddot(sjId)
if wanLingTaModel:checkCollectTargetReceived(sjId)then
return false
end
local cfg=cfg_xumitasjjlconfig_get(sjId)
local param=cfg.param
local collectType=param[1]
if collectType==1 then
for _,tjId in ipairs(param[2])do
local tj_data=wanLingTaModel:getTuJianData(tjId)
if tj_data.level<=0 then
return false
end
end
return true
elseif collectType==2 then
local lv=0
for _,tjId in ipairs(param[2])do
local tj_data=wanLingTaModel:getTuJianData(tjId)
lv=lv+tj_data.level
end
return lv>=param[3]
elseif collectType==3 then
local type=param[2]
local num=0
if self.data.tuJianData[type]then
for id,v in pairs(self.data.tuJianData[type])do
if v.level>0 then
local cfg=self:getTuJianConfig(id)or defaultT
if cfg.type2==param[3]then
num=num+1
end
end
end
end
return num>=param[4]
elseif collectType==4 then
local itemid=param[2]
local ninglian_level=param[3]
local all_equip=equipsModel.getAllEquipByItemID(itemid)
for _,equip in ipairs(all_equip)do
local lv=equipsModel.getNingLianStar(equip)or 0
if lv>=ninglian_level then
return true
end
end
local all_bag=bagControl.invokeFuncByItemId(itemid,'getAllItemByItemID',itemid)
for _,equip in ipairs(all_bag)do
local lv=equipsModel.getNingLianStar(equip)or 0
if lv>=ninglian_level then
return true
end
end
return false
elseif collectType==5 then
local itemidList=param[2]
local ninglian_level=param[3]
local total_lv=0
for i,itemid in ipairs(itemidList)do
local maxlv=0
local all_equip=equipsModel.getAllEquipByItemID(itemid)
for _,equip in ipairs(all_equip)do
local lv=equipsModel.getNingLianStar(equip)or 0
maxlv=math.max(maxlv,lv)
end
if total_lv+maxlv>=ninglian_level then
return true
end
local all_bag=bagControl.invokeFuncByItemId(itemid,'getAllItemByItemID',itemid)
for _,equip in ipairs(all_bag)do
local lv=equipsModel.getNingLianStar(equip)or 0
maxlv=math.max(maxlv,lv)
end
total_lv=total_lv+maxlv
if total_lv>=ninglian_level then
return true
end
end
return false
elseif collectType==6 then
for _,tjId in ipairs(param[2])do
local tj_data=wanLingTaModel:getTuJianData(tjId)
if tj_data.level<param[3]then
return false
end
end
return true
elseif collectType==7 then
local itemidList=param[2]
local ninglian_level=param[3]
for i,itemid in ipairs(itemidList)do
local maxlv=0
local all_equip=equipsModel.getAllEquipByItemID(itemid)
for _,equip in ipairs(all_equip)do
local lv=equipsModel.getNingLianStar(equip)or 0
maxlv=math.max(maxlv,lv)
end
if maxlv<ninglian_level then
local all_bag=bagControl.invokeFuncByItemId(itemid,'getAllItemByItemID',itemid)
for _,equip in ipairs(all_bag)do
local lv=equipsModel.getNingLianStar(equip)or 0
maxlv=math.max(maxlv,lv)
end
if maxlv<ninglian_level then
return false
end
end
end
return true
end
return false
end

function wanLingTaModel:initShopItemList()
self.shopItemList={}
self.shopAllItemList=funcShopModel:get_sort_list(eFuncShopType.eWanLingBaoKu)
for i,v in ipairs(self.shopAllItemList or{})do
local cfg=v.cfg
local baoKu=cfg.level
if not self.shopItemList[baoKu]then
self.shopItemList[baoKu]={}
end
table.insert(self.shopItemList[baoKu],cfg)
end
end

function wanLingTaModel:getShopBaoKuItemList(baoKu)
return self.shopItemList[baoKu]or{}
end


function wanLingTaModel:checkWanLingBaoKuNewLevelReddot(recordNewLv)
local recoedLevel=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWanLingTa,'baoKuLevel',0)
local const_def=cfgHelper.getdef(cfg_xumitashopconfig)
local baoKuCfg=const_def.baoKuCfg
local taLingLevel=wanLingTaModel:getTaLingLevel()
if recordNewLv then
local nowLevel=recoedLevel
for idx=nowLevel+1,#baoKuCfg do
local cfg=baoKuCfg[idx]
local unLockLevel=cfg.cdn
if taLingLevel>=unLockLevel then
nowLevel=idx
else
break
end
end
if nowLevel>recoedLevel then
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWanLingTa,'baoKuLevel',nowLevel)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWanLingTa)
return true
end
else
local nextLevel=recoedLevel+1
local cfg=baoKuCfg[nextLevel]
if cfg then
local unLockLevel=cfg.cdn
return taLingLevel>=unLockLevel
else
return false
end
end
return false
end


function wanLingTaModel:getWanLingTaTypeAttrsLookup(type)
local attrs={}
local addrate_xmt
if type==eWanLingTaShowcaseType.eTDLX then
addrate_xmt=wanLingTaModel:getWanLingTaLingXiuBaseSpeAttrsLookup()
else
addrate_xmt={}
end
if self.data.tuJianData[type]then
for id,v in pairs(self.data.tuJianData[type])do
if v.level>0 then
local cfg=self:getTuJianConfig(id)or defaultT
local prop=cfg.prop
if prop and prop[v.level]then
local attr=prop[v.level]
for attrKey,attrVal in pairs(attr)do
local ex_rate=1
local xmtAdd=(addrate_xmt[attrKey]or 0)/100
ex_rate=ex_rate+xmtAdd

attrs[attrKey]=(attrs[attrKey]or 0)+attrVal*ex_rate
end
else


end
end
end


for attrKey,attrVal in pairs(attrs)do
attrs[attrKey]=math.floor((attrs[attrKey]or 0)+0.00001)
end
end
return attrs
end

function wanLingTaModel:getWanLingTaCollectAttrsLookup()
local attrs={}
for id,_ in pairs(self.data.sjList)do
local cfg=cfg_xumitasjjlconfig_get(id)
local propRewards=cfg.propRewards
if propRewards then
for attrKey,attrVal in pairs(propRewards)do
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
end
return attrs
end

function wanLingTaModel:getWanLingTaAttrsLookup()
if self.baseAttrsList and not self.baseAttrDirtyFlag then
return self.baseAttrsList
end
local baseAttrsList={}
for i,v in pairs(eWanLingTaShowcaseType)do
local typeAttrs=wanLingTaModel:getWanLingTaTypeAttrsLookup(v)
for attrKey,attrVal in pairs(typeAttrs)do
baseAttrsList[attrKey]=(baseAttrsList[attrKey]or 0)+attrVal
end
end
local collect_baseAttrs=wanLingTaModel:getWanLingTaCollectAttrsLookup()
baseAttrsList=attrListHelper.concatLookup(baseAttrsList,collect_baseAttrs)
self.baseAttrsList=baseAttrsList
self.baseAttrDirtyFlag=false
return baseAttrsList
end
function wanLingTaModel:setWanLingTaBaseAttrsDirtyFlag()
self.baseAttrDirtyFlag=true
end

function wanLingTaModel:getWanLingTaTDLXSpeAttrsLookup()
local speAttrs={}
local tjType=eWanLingTaShowcaseType.eTDLX
if self.data.tuJianData[tjType]then
for id,v in pairs(self.data.tuJianData[tjType])do
if v.level>0 then
local cfg=self:getTuJianConfig(id)or defaultT
local speRewards=cfg.speRewards
if speRewards and speRewards[v.level]then
local speAttr=speRewards[v.level]
local speType,attrKey,attrValue,jobId=unpack(speAttr)
speAttrs[speType]=speAttrs[speType]or{}
if type(attrKey)=='table'then
for idx,key in ipairs(attrKey)do
local val=attrValue[idx]or 0
table.insert(speAttrs[speType],{key,val,jobId or 0})
end
else
table.insert(speAttrs[speType],{attrKey,attrValue,jobId or 0})
end
else

end
end
end
end
return speAttrs
end

function wanLingTaModel:getWanLingTaCollectSpeAttrsLookup()
local speAttrs={}
for id,_ in pairs(self.data.sjList)do
local cfg=cfg_xumitasjjlconfig_get(id)
local speRewards=cfg.speRewards
if speRewards then
local speAttr=speRewards
if next(speAttr)then
local speType,attrKey,attrValue,jobId=unpack(speAttr)
speAttrs[speType]=speAttrs[speType]or{}
if type(attrKey)=='table'then
for idx,key in ipairs(attrKey)do
local val=attrValue[idx]or 0
table.insert(speAttrs[speType],{key,val,jobId or 0})
end
else
table.insert(speAttrs[speType],{attrKey,attrValue,jobId or 0})
end
end
end
end
return speAttrs
end
local function concatLookupTable(temp,lookup)
if lookup then
for i,v in pairs(lookup)do
if not temp[i]then
temp[i]=v
else
for _,vv in ipairs(v)do
table.insert(temp[i],vv)
end
end
end
end
end

function wanLingTaModel:setWanLingTaSpeAttrsDirtyFlag()
self.speAttrDirtyFlag=true
wanLingTaModel:setWanLingTaJunZhenSpeAttrsDirty()
end

function wanLingTaModel:setWanLingTaJunZhenSpeAttrsDirty()
local attach=
{
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
eAttributeType.eJZ_CNT,
eAttributeType.eJZ_CNT_VALUE,
}
for i,v in ipairs(attach)do
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aWanLingTa,v)
end
end

function wanLingTaModel:getWanLingTaSpeAttrsLookup()
if self.speAttrsList and not self.speAttrDirtyFlag then
return self.speAttrsList
end
local speAttrsList={}
local tdlx_speAttrs=wanLingTaModel:getWanLingTaTDLXSpeAttrsLookup()
concatLookupTable(speAttrsList,tdlx_speAttrs)
local collect_speAttrs=wanLingTaModel:getWanLingTaCollectSpeAttrsLookup()
concatLookupTable(speAttrsList,collect_speAttrs)
self.speAttrsList=speAttrsList
self.speAttrDirtyFlag=false
return speAttrsList
end

function wanLingTaModel:getWanLingTaGuBaoSpeAttrsLookup()
local speAttrs=wanLingTaModel:getWanLingTaSpeAttrsLookup()
local attrs={}
local type=eWanLingTaSpeRewardType.eGuBao
if speAttrs and speAttrs[type]then
for i,v in ipairs(speAttrs[type])do
local attrKey,attrVal=unpack(v)
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
return attrs
end

function wanLingTaModel:getWanLingTaDaoBingSpeAttrsLookup()
local speAttrs=wanLingTaModel:getWanLingTaSpeAttrsLookup()
local attrs={}
local type=eWanLingTaSpeRewardType.eDaoBing
if speAttrs and speAttrs[type]then
for i,v in ipairs(speAttrs[type])do
local attrKey,attrVal=unpack(v)
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
return attrs
end

function wanLingTaModel:getWanLingTaDiscipleSpeAttrsLookup(guid)
local job=UIDiscipleModel:getDiscipleJob(guid)
local speAttrs=wanLingTaModel:getWanLingTaSpeAttrsLookup()
local attrs={}
local type=eWanLingTaSpeRewardType.eDisciple
if speAttrs and speAttrs[type]then
for i,v in ipairs(speAttrs[type])do
local attrKey,attrVal,jobId=unpack(v)
if jobId==job or jobId==0 then
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
end
return attrs
end

function wanLingTaModel:getWanLingTaProduceUpPercent(buildid)
local speAttrs=wanLingTaModel:getWanLingTaSpeAttrsLookup()
local percent=0
local type=eWanLingTaSpeRewardType.eProduceUp
if speAttrs and speAttrs[type]then
for i,v in ipairs(speAttrs[type])do
local key,val=unpack(v)
if key==0 or key==buildid then
percent=percent+val
end
end
end
return percent
end

function wanLingTaModel:getWanLingTaJunZhenSpeAttrsLookup()
local speAttrs=wanLingTaModel:getWanLingTaSpeAttrsLookup()
local attrs={}
local type=eWanLingTaSpeRewardType.eJunZhen
if speAttrs and speAttrs[type]then
for i,v in ipairs(speAttrs[type])do
local attrKey,attrVal=unpack(v)
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
return attrs
end

function wanLingTaModel:getWanLingTaXianMoSpeAttrsLookup(xm_voc)
local speAttrs=wanLingTaModel:getWanLingTaSpeAttrsLookup()
local attrs={}
local type=eWanLingTaSpeRewardType.eXianMo
if speAttrs and speAttrs[type]then
for i,v in ipairs(speAttrs[type])do
local attrKey,attrVal,jobId=unpack(v)
if jobId==xm_voc then
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
end
return attrs
end


function wanLingTaModel:getWanLingTaDiscipleJingJieSpeAttrsLookup(guid)
local job=UIDiscipleModel:getDiscipleJob(guid)
local speAttrs=wanLingTaModel:getWanLingTaSpeAttrsLookup()
local attrs={}
local type=eWanLingTaSpeRewardType.eDiscipleJingJie
if speAttrs and speAttrs[type]then
for i,v in ipairs(speAttrs[type])do
local attrKey,attrVal,jobId=unpack(v)
if jobId==job or jobId==0 then
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
end
return attrs
end


function wanLingTaModel:getWanLingTaDiscipleLianTiSpeAttrsLookup(job)

local speAttrs=wanLingTaModel:getWanLingTaSpeAttrsLookup()
local attrs={}
local type=eWanLingTaSpeRewardType.eDiscipleLianTi
if speAttrs and speAttrs[type]then
for i,v in ipairs(speAttrs[type])do
local attrKey,attrVal,jobId=unpack(v)
if jobId==job or jobId==0 then
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
end
return attrs
end


function wanLingTaModel:getWanLingTaLingXiuBaseSpeAttrsLookup()
local speAttrs=wanLingTaModel:getWanLingTaSpeAttrsLookup()
local attrs={}
local type=eWanLingTaSpeRewardType.eLingXiuBase
if speAttrs and speAttrs[type]then
for i,v in ipairs(speAttrs[type])do
local attrKey,attrVal=unpack(v)
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
return attrs
end


function wanLingTaModel:getWanLingTaLingZhenBaseSpeAttrsLookup()
local speAttrs=wanLingTaModel:getWanLingTaSpeAttrsLookup()
local attrs={}
local type=eWanLingTaSpeRewardType.eLingZhenBase
if speAttrs and speAttrs[type]then
for i,v in ipairs(speAttrs[type])do
local attrKey,attrVal=unpack(v)
attrs[attrKey]=(attrs[attrKey]or 0)+attrVal
end
end
return attrs
end