









local guildOrderAI_autoBuy={name='autoCleaning'}


function guildOrderAI_autoBuy:onInit()

end


function guildOrderAI_autoBuy:onDelete()

end


function guildOrderAI_autoBuy:onUpdate()
if xianjieController:isPauseUpdateInXianJie()then return end
local orderID=self.orderID
local setup,cfg=guildOrderModel:getSetupData(orderID)
if not setup.isOpen then
return guildOrderAIState.eClosed
end

local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eFangShi)
local bdData=bdDatas[1]
local config=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local dzId=bdData.dizi_id
local haveDz=tostring(dzId)~='0'
local dizi_zhekou=nil
if haveDz then
local bd_tybe_cfg=cfg_monijybuildconfig_get(config.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local pro_skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local effectStr=discipleSelectController.getEffectDesc_fs(pro_skill_cfg,level)
local addEffect
if pro_skill_cfg.fangshi_discount then
addEffect=pro_skill_cfg.fangshi_discount[level]
end
if addEffect and addEffect>0 then
dizi_zhekou=addEffect
end
end
end
dizi_zhekou=dizi_zhekou or 0

local fairData=fairModel:get_fair_data(eFairType.eBooth)
local goodsList=fairData.goodsList
local fairCfg=fairModel.get_booth_config(fairData.cfg_key_1,fairData.cfg_key_2)

local moneyFlag=setup.moneyFlag
local moneyRange=cfg.moneyRange
local moneyLookup={}
for idx,good in ipairs(goodsList)do
local check=false

local libIndex=good.param_1
local isBuy=good.param_2==1
local libType=good.param_3
local item_lib=libType==1 and fairCfg.randomItem_lib or fairCfg.story_randomItem_lib
local shopItemId=libIndex
local libItem=cfgHelper.get(cfg_fangshishopitemconfig_get,shopItemId,"Item_conf")
if libItem~=nil then
local itemid=libItem[1]
local itemCount=libItem[2]
local moneyType=libItem[3]
local moneyValue=libItem[4]
local distance=(100-libItem[5])
local israre=libItem[6]
local candistance=libItem[7]
local needValue

if candistance~=0 and dizi_zhekou~=0 then

needValue=math.floor((moneyValue*(distance-dizi_zhekou)/100)+0.5)
else
needValue=math.floor(moneyValue*(distance/100)+0.5)
end


for i,moneyType_ in ipairs(moneyRange)do
if bitHelper.check_pos(moneyFlag,i-1)then
if moneyType_==moneyType then
check=true
break
end
end
end

if check then
local itemConfig=itemsConfig.getConfig(itemid)

if itemsConfig.isEquip(itemid)then

local equipColorIndex=setup.equipColorIndex
local color_=cfg.equipColorRange[equipColorIndex]
if color_<0 then
check=false
else
if itemConfig.color<color_ then
check=false
end
end
elseif itemsConfig.isMaterials(itemid)then

local clColorIndex=setup.clColorIndex
local stage_=cfg.clColorRange[clColorIndex]
if stage_<0 then
check=false
else
if itemConfig.stage<stage_ then
check=false
end
end
elseif itemsConfig.isItem(itemid)then

if itemConfig.type1==7 and itemConfig.type2==1 then

local jjDanYaoIndex=setup.jjDanYaoIndex
local color_=cfg.jjDanYaoRange[jjDanYaoIndex]
if color_<0 then
check=false
else
if itemConfig.color<color_ then
check=false
end
end
elseif itemConfig.type1==7 and itemConfig.type2==3 then

local ltDanYaoIndex=setup.ltDanYaoIndex
local color_=cfg.ltDanYaoRange[ltDanYaoIndex]
if color_<0 then
check=false
else
if itemConfig.color<color_ then
check=false
end
end
else

local elseFlag=setup.elseFlag
local elseRange=cfg.elseRange
local f
for i,v in ipairs(elseRange)do
if itemConfig.type1==v[1]and itemConfig.type2==v[2]then
f=true
if not bitHelper.check_pos(elseFlag,i-1)then
check=false
end
break
end
end
if not f then
check=false
end
end
else
check=false
end
end
if check then
local hasnum=moneyLookup[moneyType]
if hasnum==nil then
hasnum=moneyModel.getMoney(moneyType)
end
if hasnum>=needValue then
moneyLookup[moneyType]=hasnum-needValue
fairController:req_buy(eFairType.eBooth,idx)
end
end
end
end
fairModel:SetReqBuyFlag(false)
return guildOrderAIState.eComplete
end

return guildOrderAI_autoBuy