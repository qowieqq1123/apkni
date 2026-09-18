


function equipsModel:xmtestt(id)
local item,itemguid=bagControl.invokeFuncByItemId(id,'getItemByItemID',id)

end



function equipsModel.getNingLianStar(equip)
if equip.itemData==nil then return 0 end
return equip.itemData.ninglian_star or 0
end

function equipsModel:onNingLianByEquip(equip)
if equip.itemData.ninglian_star==nil then
equip.itemData.ninglian_star=0
end
equip.itemData.ninglian_star=equip.itemData.ninglian_star+1
equipsHelper.setEquipAttrsDirty(equip,true)
end

function equipsModel:onNingLianByDZ(dzguid,equipType)
local equip=equipsModel.getEquipByDizi(dzguid,equipType)
local itemguid=equip.itemguid
self:onNingLianByEquip(equip)
equipsModel.equips[tostring(itemguid)]=equip
equipsModel.onChangeAttrsOnJinglianEquip(dzguid,itemguid)
end

function equipsModel:onUnNingLianByEquip(equip)
equip.itemData.ninglian_star=0
equipsHelper.setEquipAttrsDirty(equip,true)
end

function equipsModel:onUnNingLianByDZ(dzguid,equipType)
local equip=equipsModel.getEquipByDizi(dzguid,equipType)
if equip==nil then return end
local itemguid=equip.itemguid
self:onUnNingLianByEquip(equip)
equipsModel.equips[tostring(itemguid)]=equip
equipsModel.onChangeAttrsOnJinglianEquip(dzguid,itemguid)
end


function equipsModel.getXMRandattrList(equip)
if equip and equip.itemData and equip.itemData.randattrList then
return equip.itemData.randattrList
end
end

function equipsModel:onFusionByEquip(equip,old_randattrList,jinglian_lvl,jinglian_exp)
if equip.itemData and old_randattrList then
equip.itemData.len=#(old_randattrList or{})
equip.itemData.randattrList=old_randattrList

equip.itemData.jinglianlv=jinglian_lvl
equip.itemData.jinglianexp=jinglian_exp
end
equipsHelper.setEquipAttrsDirty(equip,true)
end

function equipsModel:onFusionByDZ(dzguid,equipType,old_randattrList,jinglian_lvl,jinglian_exp)
local equip=equipsModel.getEquipByDizi(dzguid,equipType)
if equip==nil then return end
local itemguid=equip.itemguid
self:onFusionByEquip(equip,old_randattrList,jinglian_lvl,jinglian_exp)
equipsModel.equips[tostring(itemguid)]=equip
equipsModel.onChangeAttrsOnJinglianEquip(dzguid,itemguid)
end


function equipsHelper.isCanShowNingLian(itemguid,warn)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianMoEquip)then
if warn then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXianMoEquip)
UIManager.error(tips)
end
return false
end
local equip=equipsHelper.getEquip(itemguid)
if not equip then
return false
end
local itemConfig=itemsConfig.getConfig(equip.itemid)
if not itemConfig.type3 then
return false
end
return true
end


function equipsHelper.isCanShowRongHe(itemguid,warn)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianMoEquip)then
if warn then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXianMoEquip)
UIManager.error(tips)
end
return false
end
local equip=equipsHelper.getEquip(itemguid)
if not equip then
return false
end
local itemConfig=itemsConfig.getConfig(equip.itemid)
if not itemConfig.type3 then
return false
end
return true
end


function equipsHelper.isEquipXM(itemguid)
local xmtype=equipsHelper.getEquipXMType(itemguid)
if xmtype==EQUIP_XianMo_TYPES.eXian or xmtype==EQUIP_XianMo_TYPES.eMo then
return true
end
return false
end

function equipsHelper.isEquipXMbyItemid(itemid)
local xmtype=equipsHelper.getEquipXMTypebyItemid(itemid)
if xmtype==EQUIP_XianMo_TYPES.eXian or xmtype==EQUIP_XianMo_TYPES.eMo then
return true
end
return false
end


function equipsHelper.getEquipXMType(itemguid)
if itemguid==nil then return 0 end
local equip=equipsHelper.getEquip(itemguid)
if equip then
local itemConfig=itemsConfig.getConfig(equip.itemid)
if itemConfig and itemConfig.type3 then
return itemConfig.type3
end
end
return 0
end

function equipsHelper.getEquipXMTypebyItemid(itemid)
if itemid==nil then return 0 end
local itemConfig=itemsConfig.getConfig(itemid)
if itemsConfig.isEquip(itemid)and itemConfig and itemConfig.type3 then
return itemConfig.type3
end
return 0
end


function equipsModel.getEquipXMChuanChengCfg(itemid)
if itemid==nil then return nil end
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig and itemConfig.chuancheng then
return itemConfig.chuancheng
end
return nil
end


function equipsModel.getEquipXMNingLianCfg(itemid)
local chuancheng=equipsModel.getEquipXMChuanChengCfg(itemid)
if chuancheng and chuancheng.ninglian_conf then
return chuancheng.ninglian_conf
end
return nil
end


function equipsModel.getNingLianMaxStar(itemid)
local ninglian_conf=equipsModel.getEquipXMNingLianCfg(itemid)
if ninglian_conf then
return#ninglian_conf
end
return 0
end


function equipsModel.getEquipXMJobList(itemid)
local chuancheng=equipsModel.getEquipXMChuanChengCfg(itemid)
if chuancheng and chuancheng.pos_conf then
return chuancheng.pos_conf or nil
end
return nil
end


function equipsModel.getEquipXMNingLianData(itemid,ninglianStar)
local ninglian_conf=equipsModel.getEquipXMNingLianCfg(itemid)
if ninglian_conf and ninglian_conf[ninglianStar]then
return ninglian_conf[ninglianStar].cost,ninglian_conf[ninglianStar].effect_id,ninglian_conf[ninglianStar].percent
end
return nil
end


function equipsModel.getEquipXMNingLianZY(itemid,ninglianStar)
local ninglian_conf=equipsModel.getEquipXMNingLianCfg(itemid)
local percent=0
if ninglian_conf then
for i=1,ninglianStar do
if ninglian_conf[i]and ninglian_conf[i].percent then
percent=percent+ninglian_conf[i].percent
end
end
end
return percent
end


function equipsModel.getChuanChengCfg(effect_id)
if effect_id==nil then return nil end
local cfg=cfg_discipleequipxmccconfig_get(effect_id)
return cfg
end


function equipsModel.getEquipXMRHNeedCost(itemid)
if itemid==nil then return nil end
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig and itemConfig.ronghe_cost then
return itemConfig.ronghe_cost
end
return nil
end


function equipsModel.getEquipXMRHConditon(itemid)
if itemid==nil then return nil end
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig and itemConfig.ronghe_cond then
return itemConfig.ronghe_cond
end
return nil
end


function equipsModel.getEquipXMFenJie(itemid)
if itemid==nil then return nil end
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig and itemConfig.fenjie_rand_reward then
return itemConfig.fenjie_rand_reward
end
return nil
end


function equipsModel.getEquipType2(itemid)
if itemid==nil then return-1 end
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig and itemConfig.type2 then
return itemConfig.type2 or 0
end
return-1
end


function equipsModel.returnNingLianItems(itemguid,jilianItems)
if itemguid==nil then return nil end
local equip=equipsHelper.getEquip(itemguid)
if equip then
local ninglian_star=equipsModel.getNingLianStar(equip)
if ninglian_star>0 then
local ninglian_conf=equipsModel.getEquipXMNingLianCfg(equip.itemid)
if ninglian_conf then
for k=1,ninglian_star do
local cost=ninglian_conf[k].cost
jilianItems=table.concatTableXX(jilianItems,cost)
end
end
end
end
return jilianItems
end


function equipsModel.isReddotEquipNingLian(itemguid)
if itemguid==nil then return false end
local reddot=false
local equip=equipsHelper.getEquip(itemguid)
if equip then
local ninglian_star=equipsModel.getNingLianStar(equip)
local maxstar=equipsModel.getNingLianMaxStar(equip.itemid)
if ninglian_star<maxstar then
local uplvl=ninglian_star+1
local cost,effect_id,percent=equipsModel.getEquipXMNingLianData(equip.itemid,uplvl)
if cost then
for k,v in ipairs(cost)do
local itemid=v[1]
local itemnum=v[2]
local havecount=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end
if havecount<itemnum then
reddot=false
break
else
reddot=true
end
end
end
end
end
return reddot
end


function equipsModel.isXMCanDress(diziguid,itemid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(diziguid)
local jobid=imageInfo.job
local joblist=equipsModel.getEquipXMJobList(itemid)
if joblist and joblist[jobid]==1 then
return true
else
return false
end
end


function equipsModel.getChuangChenIdList(itemid)
local list={}
local ninglian_conf=equipsModel.getEquipXMNingLianCfg(itemid)
if ninglian_conf then
for k,v in ipairs(ninglian_conf)do
if v.effect_id and v.effect_id~=0 then
table.insert(list,{v.effect_id,k})
end
end
end
return list
end


function equipsModel.freshBagWindow(funcname,...)
UIManager:callWindowFunc('UIBagWin',funcname,...)
end

function equipsModel.freshWindow(funcname,...)
UIManager:callWindowFunc('UIEquipWin',funcname,...)
end


function equipsModel.getAllEquipNingLianMaxStar(itemid)
local maxlv=0
local pos
local guid
local all_equip=equipsModel.getAllEquipByItemID(itemid)
for _,equip in ipairs(all_equip)do
local lv=equipsModel.getNingLianStar(equip)or 0
if lv>maxlv then
maxlv=lv
pos=1
guid=equipsModel.getDiziguidByItemguid(equip.itemguid)
end
end
local all_bag=bagControl.invokeFuncByItemId(itemid,'getAllItemByItemID',itemid)
for _,equip in ipairs(all_bag)do
local lv=equipsModel.getNingLianStar(equip)or 0
if lv>maxlv then
maxlv=lv
pos=0
guid=equip.itemguid
end
end
return maxlv,pos,guid
end
