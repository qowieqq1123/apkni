tipsBtnManager={}



function tipsBtnManager.insertBtn(argstable,list)
if argstable.btnsList==nil then argstable.btnsList={}end
local btnsList=argstable.btnsList
for _,v in ipairs(list)do
local exist=false
for _,vv in ipairs(btnsList)do
if v==vv then
exist=true
break
end
end
if not exist then
btnsList[#btnsList+1]=v
end
end
end

function tipsBtnManager.sortBtn(argstable,btnType,number)
if number==nil or argstable.btnsList==nil then return end
local btnsList=argstable.btnsList
local index=nil
local len=#btnsList
for i,v in ipairs(btnsList)do
if v==btnType then
index=i
break
end
end
if index and number<=len and number>=1 and index~=number then
table.remove(btnsList,index)
table.insert(btnsList,number,btnType)
end
end

function tipsBtnManager.removeBtn(argstable,btnType)
if argstable.btnsList==nil or#argstable.btnsList==0 then return end
local btnsList=argstable.btnsList
for i,v in ipairs(btnsList)do
if v==btnType then
table.remove(btnsList,i)
break
end
end
end

function tipsBtnManager.clearBtn(argstable)
argstable.btnsList=nil
end

function tipsBtnManager.handleItem(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local diziguid=argstable.attach.diziguid
local itemConfig=itemsConfig.getConfig(itemid)

if formType~=TIPS_FORM_TYPE.eXMDG_shop and
gainControl.hasAnyShow(itemConfig.produce)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
tipsBtnManager.sortBtn(argstable,TIPS_BTNS_TYPE.eGetWay,1)
end

if formType==TIPS_FORM_TYPE.eLink or
formType==TIPS_FORM_TYPE.eClearBtn or
formType==TIPS_FORM_TYPE.eBaoXiangTipsItem then
tipsBtnManager.clearBtn(argstable)
elseif formType==TIPS_FORM_TYPE.eFabaoJilian then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutJilianFabaoMaterial})
elseif formType==TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
local auctionSeries=argstable.auctionSeries
if auctionSeries then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionReSellItem})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionSellItem})
end
elseif formType==TIPS_FORM_TYPE.eXMDG_shop then

local selectNumCmpArgs=argstable.attach.selectNumCmpArgs
if selectNumCmpArgs and selectNumCmpArgs.max then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMDG_Exchange})
end
elseif formType==TIPS_FORM_TYPE.eAuctionShowItem then
local auctionSeries=argstable.attach.auctionSeries
local isGuanZhu=auctionModel:getAuctionItemGuanZhuState(auctionSeries)~=nil
if isGuanZhu then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhuCancel})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhu})
end
elseif formType==TIPS_FORM_TYPE.eGuBaoUpLvBag then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGuBaoUpLvInput})
end

if formType~=TIPS_FORM_TYPE.eBagGrids then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
end

if formType==TIPS_FORM_TYPE.eQuickUse then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eGetWay)
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUseItem})
end

if itemConfig.dealPrice==nil then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
end

if bagUseControl.isItemExpire(itemguid)then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
if itemConfig.dealPrice~=nil and formType~=TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eSellItem})
end
end

if itemConfig.funcparam and itemConfig.funcparam.type==item_funtion_type.selectbox then

if formType==TIPS_FORM_TYPE.eBagGrids or formType==TIPS_FORM_TYPE.eQuickUse then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eOpenSelectBox})
end
if bagUseControl.isItemExpire(itemguid)then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eOpenSelectBox)
if itemConfig.dealPrice~=nil and formType~=TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eSellItem})
end
end
end

if itemConfig.funcparam and itemConfig.funcparam.type==item_funtion_type.selectDisciple then

if formType==TIPS_FORM_TYPE.eBagGrids or formType==TIPS_FORM_TYPE.eQuickUse then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eSelectRecruitDisciple})
end
end

if itemConfig.funcparam and itemConfig.funcparam.type==item_funtion_type.huDaoFu then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
end

if itemConfig.type1==2 and itemConfig.type2==10 then
if xianmengModel:hasXM()then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
end
elseif itemConfig.type1==13 and formType==TIPS_FORM_TYPE.eBagGrids and systemModel.isOpen(SYSTEM_DEFINE.eGongFaRecycle)then
local gfID=gongfaLookup:checkGongfaPiece(itemid)
if gfID and UIGongFaModel:checkFullStudy(gfID)then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eRecycleGongFa})
end
end


if formType==TIPS_FORM_TYPE.eYuEr then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eGetWay)

local selectyuerid=YiYuHuiYouModel:getXianLuId()
if selectyuerid==itemid then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eYuErXieXia})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eYuEr})
end
end


if formType==TIPS_FORM_TYPE.ePutAutoBuildMaterial then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutAutoBuildMaterial})
elseif formType==TIPS_FORM_TYPE.eOffAutoBuildMaterial then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eOffAutoBuildMaterial})
end

if formType==TIPS_FORM_TYPE.eXMFXZY then
tipsBtnManager.clearBtn(argstable)
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMFXZYReq})
end

if formType==TIPS_FORM_TYPE.eXMKCBag then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
end
if formType==TIPS_FORM_TYPE.eXMKCFPWin then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMKFFPInput})
end


local cfg=UISettingConfig.getSelfCfgBySex(itemid)
if cfg then
local typo=cfg[2]
local id=cfg[1].id
local isActive=UISettingModel:isUnlockHead(typo,id)
if KUANGE_TYPE.zongmen==typo and typo and id then
local ZMZBunlock,activeType=UISettingModel:checkSettingIdUnlock_Type(typo,id)
isActive=ZMZBunlock
end

if isActive and not UISettingModel:isCanOverlay(typo,id)and not playerImageModel:isDurationImage(itemConfig)then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
if itemConfig.dealPrice and formType~=TIPS_FORM_TYPE.eAuctionSellItem then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eSellItem})
else
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
end
else
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
if KUANGE_TYPE.zongmen==typo and typo and id then
local ZMZBunlock,activeType=UISettingModel:checkSettingIdUnlock_Type(typo,id)
if not ZMZBunlock then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUseItem})
end
end
end

elseif playerImageModel:isActiveAnyImage(itemConfig)and not playerImageModel:isDurationImage(itemConfig)then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
if itemConfig.dealPrice and formType~=TIPS_FORM_TYPE.eAuctionSellItem then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eSellItem})
argstable.attach.sellDesc='是否确定出售本物品？'
end
end
end

function tipsBtnManager.handleMetrial(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local diziguid=argstable.attach.diziguid
local itemConfig=itemsConfig.getConfig(itemid)
if formType==TIPS_FORM_TYPE.eLianqiGeBagItem then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutFabaoMaterial})
elseif formType==TIPS_FORM_TYPE.eLianqiGeItem then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffFabaoMaterial})
elseif formType==TIPS_FORM_TYPE.eFabaoLianhua then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutLianhuaFabaoMaterial})
elseif formType==TIPS_FORM_TYPE.eFabaoJilian then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutJilianFabaoMaterial})
elseif formType==TIPS_FORM_TYPE.eClearBtn then
tipsBtnManager.clearBtn(argstable)
elseif formType==TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
local auctionSeries=argstable.auctionSeries
if auctionSeries then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionReSellItem})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionSellItem})
end
elseif formType==TIPS_FORM_TYPE.eXMDG_shop then

local selectNumCmpArgs=argstable.attach.selectNumCmpArgs
if selectNumCmpArgs and selectNumCmpArgs.max then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMDG_Exchange})
end
elseif formType==TIPS_FORM_TYPE.eAuctionShowItem then
local auctionSeries=argstable.attach.auctionSeries
local isGuanZhu=auctionModel:getAuctionItemGuanZhuState(auctionSeries)~=nil
if isGuanZhu then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhuCancel})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhu})
end
elseif formType==TIPS_FORM_TYPE.ePutFeiShengTaiMaterial then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutFeiShengTaiMaterial})
elseif formType==TIPS_FORM_TYPE.eOffFeiShengTaiMaterial then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eOffFeiShengTaiMaterial})
elseif formType==TIPS_FORM_TYPE.ePutAutoBuildMaterial then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutAutoBuildMaterial})
elseif formType==TIPS_FORM_TYPE.eOffAutoBuildMaterial then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eOffAutoBuildMaterial})
elseif formType==TIPS_FORM_TYPE.eGuBaoUpLvBag then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGuBaoUpLvInput})
end

if formType~=TIPS_FORM_TYPE.eXMDG_shop and
gainControl.hasAnyShow(itemConfig.produce)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
tipsBtnManager.sortBtn(argstable,TIPS_BTNS_TYPE.eGetWay,1)
end

if formType==TIPS_FORM_TYPE.eXMFXZY then
tipsBtnManager.clearBtn(argstable)
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMFXZYReq})
end
end


function tipsBtnManager.handleEquip(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local diziguid=argstable.attach.diziguid

local isVocEquip=itemsConfig.isVocEquip(itemid)

if formType==TIPS_FORM_TYPE.eEquipListWin then
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
if itemguid==nil then return end

if isVocEquip then
if vocEquipModel:isEquipedOnDizi(diziguid,itemguid)then
tipsBtnManager.clearBtn(argstable)
else
if vocEquipHelper.canEquipByVoc(itemid,voc)then
if vocEquipModel:isEquipedOnAnyDizi(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eReplaceEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressEquip})
end
end
end
else
if equipsModel.isEquipedOnDizi(diziguid,itemguid)then
tipsBtnManager.clearBtn(argstable)
else
if equipsHelper.canEquipWeaponByVoc(itemid,voc)then
if equipsModel.isEquipedOnAnyDizi(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eReplaceEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressEquip})
end
end
end
end
elseif formType==TIPS_FORM_TYPE.eEquipFilter then
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
if itemguid==nil then return end

local isxmEquip=equipsHelper.isEquipXM(itemguid)
if isxmEquip then
if equipsHelper.isCanShowNingLian(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXianMoDuanDa,})
end
elseif isVocEquip then
if vocEquipHelper.isCanShowStrengthen(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eVocEquipStrengthen,})
end
else
if equipsHelper.isCanShowJinglian(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eJinglianEquip,})
end
if equipsHelper.isCanChongZhu(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eChongZhu,})

equipsProtocolControl.req_equip_2_91_ex(itemguid)
end
end

if isVocEquip then
if not vocEquipModel:isEquipedOnDizi(diziguid,itemguid)then
if vocEquipHelper.canEquipByVoc(itemid,voc)then
if vocEquipModel:isEquipedOnAnyDizi(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eReplaceEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressEquip})
end
end
end
else
if not equipsModel.isEquipedOnDizi(diziguid,itemguid)then
if equipsHelper.canEquipWeaponByVoc(itemid,voc)then
if equipsModel.isEquipedOnAnyDizi(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eReplaceEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressEquip})
end
end
end
end
elseif formType==TIPS_FORM_TYPE.eEquipWin then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eShowGain,})

local isxmEquip=equipsHelper.isEquipXM(itemguid)
if isxmEquip then
if equipsHelper.isCanShowNingLian(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXianMoDuanDa,})
end
elseif isVocEquip then
if vocEquipHelper.isCanShowStrengthen(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eVocEquipStrengthen,})
end
if vocEquipController:checkVocEquipZHSystem()then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eZhiYeEquipZH})
end
else
if equipsHelper.isCanShowJinglian(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eJinglianEquip,})
end
if equipsHelper.isCanChongZhu(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eChongZhu,})
if not argstable.attach then
argstable.attach={}
end
argstable.attach.reddotType=REDDIT_SUB_TYPE.sChongZhu
local sub_type=discipleEquipSheetReddot.sub_type.eChongZhu
discipleEquipSheetReddot:getSubTypeReddotId(sub_type,itemguid)

equipsProtocolControl.req_equip_2_91_ex(itemguid)
end
end
if equipsHelper.isCanDianHua(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eEquipDianHua,})
end
if equipsHelper.isCanResetDianHua(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eEquipResetDianHua,})
end
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
elseif formType==TIPS_FORM_TYPE.eClearBtn or formType==TIPS_FORM_TYPE.eWatchRoleItem or
formType==TIPS_FORM_TYPE.eLink then
tipsBtnManager.clearBtn(argstable)
elseif formType==TIPS_FORM_TYPE.eBagGrids then
tipsBtnManager.clearBtn(argstable)

local isxmEquip=equipsHelper.isEquipXM(itemguid)
if isxmEquip then
if equipsHelper.isCanShowNingLian(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXianMoDuanDa,})
end
elseif isVocEquip then
if vocEquipHelper.isCanShowStrengthen(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eVocEquipStrengthen,})
end
if vocEquipController:checkVocEquipZHSystem()then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eZhiYeEquipZH})
end
else
if equipsHelper.isCanShowJinglian(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eJinglianEquip,})
end
if equipsHelper.isCanChongZhu(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eChongZhu,})
if not argstable.attach then
argstable.attach={}
end
argstable.attach.reddotType=REDDIT_SUB_TYPE.sChongZhu
local sub_type=discipleEquipSheetReddot.sub_type.eChongZhu
discipleEquipSheetReddot:getSubTypeReddotId(sub_type,itemguid)

equipsProtocolControl.req_equip_2_91_ex(itemguid)
end
end
if equipsHelper.isCanDianHua(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eEquipDianHua,})
end
if equipsHelper.isCanResetDianHua(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eEquipResetDianHua,})
end
elseif formType==TIPS_FORM_TYPE.eLianqiGeBagItem then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutFabaoMaterial})
elseif formType==TIPS_FORM_TYPE.eLianqiGeItem then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffFabaoMaterial})
elseif formType==TIPS_FORM_TYPE.eFabaoLianhua then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutLianhuaFabaoMaterial})
elseif formType==TIPS_FORM_TYPE.eFabaoJilian then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutJilianFabaoMaterial})
elseif formType==TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
local auctionSeries=argstable.auctionSeries
if auctionSeries then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionReSellItem})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionSellItem})
end
elseif formType==TIPS_FORM_TYPE.eXMDG_shop then

local selectNumCmpArgs=argstable.attach.selectNumCmpArgs
if selectNumCmpArgs and selectNumCmpArgs.max then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMDG_Exchange})
end
elseif formType==TIPS_FORM_TYPE.eAuctionShowItem then
local auctionSeries=argstable.attach.auctionSeries
local isGuanZhu=auctionModel:getAuctionItemGuanZhuState(auctionSeries)~=nil
if isGuanZhu then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhuCancel})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhu})
end
elseif formType==TIPS_FORM_TYPE.eTianGongGeDianHua then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eEquipDH_Put})
elseif formType==TIPS_FORM_TYPE.eBagEquipMutipleSelect then
tipsBtnManager.clearBtn(argstable)
if argstable.attach.isSelect then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eBagEquipMutipleNotSelect})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eBagEquipMutipleSelect})
end
end
end


function tipsBtnManager.handleFabao(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local diziguid=argstable.attach.diziguid
local showJl=fabaoHelper.isCanShowJilian(itemguid)
local showLh=fabaoHelper.isCanShowLianhuaBtn(itemguid)
if formType==TIPS_FORM_TYPE.eEquipListWin then
if itemguid then
if fabaoModel.isEquipedOnDizi(diziguid,itemguid)then
tipsBtnManager.clearBtn(argstable)
else
if fabaoModel.isEquipedOnAnyDizi(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eReplaceEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressEquip,})
end
end
end
elseif formType==TIPS_FORM_TYPE.eEquipWin then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eShowGain,})
if showJl or showLh then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUpFabao,})
end

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
elseif formType==TIPS_FORM_TYPE.eClearBtn or formType==TIPS_FORM_TYPE.eWatchRoleItem or
formType==TIPS_FORM_TYPE.eLink then
tipsBtnManager.clearBtn(argstable)
elseif formType==TIPS_FORM_TYPE.eBagGrids then
if showJl or showLh then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUpFabao,})
end
elseif formType==TIPS_FORM_TYPE.eFabaoJilian then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutJilianFabaoMaterial})
elseif formType==TIPS_FORM_TYPE.eSkillFabaoItem then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eShowGain,})
if showJl or showLh then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUpFabao,})
end
elseif formType==TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
local auctionSeries=argstable.auctionSeries
if auctionSeries then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionReSellItem})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionSellItem})
end
elseif formType==TIPS_FORM_TYPE.eFaBaoMaterialSelect then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutFabao})
elseif formType==TIPS_FORM_TYPE.eFaBaoRefineMaterialSelect then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutRefineMaterialFaBao})
elseif formType==TIPS_FORM_TYPE.eXMDG_shop then

local selectNumCmpArgs=argstable.attach.selectNumCmpArgs
if selectNumCmpArgs and selectNumCmpArgs.max then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMDG_Exchange})
end
end
if formType==TIPS_FORM_TYPE.eAuctionShowItem then
local auctionSeries=argstable.attach.auctionSeries
local isGuanZhu=auctionModel:getAuctionItemGuanZhuState(auctionSeries)~=nil
if isGuanZhu then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhuCancel})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhu})
end
end
end


function tipsBtnManager.handleFubao(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local diziguid=argstable.attach.diziguid
if formType==TIPS_FORM_TYPE.eEquipListWin then
if itemguid then
if UIFuLuFangModel:isEquipedOnDizi(diziguid,itemguid)then
tipsBtnManager.clearBtn(argstable)
else
if UIFuLuFangModel:isEquipedOnAnyDizi(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eReplaceEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressEquip,})
end
end
end
elseif formType==TIPS_FORM_TYPE.eEquipWin then
if UIYuFuLingZhenControl:isSysOpen()and UIFuLuFangModel:isEquipedOnAnyDizi(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eYuFuZhenTu})
end
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eShowGain})






if UIFuLuFangModel:isEquipedOnAnyDizi(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
end
elseif formType==TIPS_FORM_TYPE.eBagGrids then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressFuBaoInBag,TIPS_BTNS_TYPE.eFenJieFuBao})
elseif formType==TIPS_FORM_TYPE.eLink or formType==TIPS_FORM_TYPE.eWatchRoleItem or
formType==TIPS_FORM_TYPE.eClearBtn then
tipsBtnManager.clearBtn(argstable)
elseif formType==TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
local auctionSeries=argstable.auctionSeries
if auctionSeries then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionReSellItem})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionSellItem})
end
elseif formType==TIPS_FORM_TYPE.eXMDG_shop then

local selectNumCmpArgs=argstable.attach.selectNumCmpArgs
if selectNumCmpArgs and selectNumCmpArgs.max then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMDG_Exchange})
end
elseif formType==TIPS_FORM_TYPE.eAuctionShowItem then
local auctionSeries=argstable.attach.auctionSeries
local isGuanZhu=auctionModel:getAuctionItemGuanZhuState(auctionSeries)~=nil
if isGuanZhu then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhuCancel})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhu})
end
end
end

function tipsBtnManager.handleYuhuo(argstable)
local formType=argstable.formType


local attach=argstable.attach
if formType==TIPS_FORM_TYPE.eYuHuo then
if attach.isSell then
if attach.state==1 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffYuHuo})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetBackYuHuo})
end
elseif attach.isBuy then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eYuHouBuy})
end
end
end

function tipsBtnManager.handleYFLingZhen(argstable)
local formType=argstable.formType
local itemid=argstable.itemid
local config=itemsConfig.getConfig(itemid)
if formType==TIPS_FORM_TYPE.eYFLZCombine then

if systemModel.isOpen(SYSTEM_DEFINE.eLingZhenConvert)then
local convertCfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"convert")
local lv_limit=convertCfg[2]
if config.type1<6 and config.level>=lv_limit then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eZhuanHuanLZ})
end
end
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eLingZhenCombine})
if config.type1==6 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eChongZhuLZ})
if config.level>1 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eFenJieLZ})
end
end

elseif formType==TIPS_FORM_TYPE.eYFLZCombineSelected then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffZhenTuMaterial})
if config.type1==6 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eChongZhuLZ})
if config.level>1 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eFenJieLZ})
end
tipsBtnManager.handleYFLingZhen2(argstable)
end

elseif formType==TIPS_FORM_TYPE.eBagGrids then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressLZ,TIPS_BTNS_TYPE.eHeChengLZ})

if systemModel.isOpen(SYSTEM_DEFINE.eLingZhenConvert)then
local convertCfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"convert")
local lv_limit=convertCfg[2]
if config.type1<6 and config.level>=lv_limit then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eZhuanHuanLZ})
end
end
if config.type1==6 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eChongZhuLZ})
if config.level>1 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eFenJieLZ})
end
tipsBtnManager.handleYFLingZhen2(argstable)
end
if config.produce then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
end

elseif formType==TIPS_FORM_TYPE.eYFLZMain then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffZhenTuMaterial2})

if systemModel.isOpen(SYSTEM_DEFINE.eLingZhenConvert)then
local convertCfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"convert")
local lv_limit=convertCfg[2]
if config.type1<6 and config.level>=lv_limit then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eZhuanHuanLZ})
end
end
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eQuickHeChengLZ})
if config.type1==6 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eChongZhuLZ})
if config.level>1 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eFenJieLZ})
end
end
end
end

function tipsBtnManager.handleYFLingZhen2(argstable)
local itemguid=argstable.itemguid
local attach=argstable.attach or{}
local yfguid=attach.yfguid
local kongIndex=attach.kongIndex
if UIYuFuLingZhenControl:getItemLock(itemguid,yfguid,kongIndex)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUnlockLZ})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eLockLZ})
end
end


function tipsBtnManager.handleGubao(argstable)
local formType=argstable.formType
local gbid=argstable.itemid

tipsBtnManager.clearBtn(argstable)

if formType~=TIPS_FORM_TYPE.eGubaoCheck then
local isActive=gubaoModel:checkActive(gbid)
if not isActive then
if gubaoModel:checkCanActive(gbid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eActiveFabao,})
else
local itemid=gubaoLookup:gubao2GoodActive(gbid)
local itemConfig=itemsConfig.getConfig(itemid)
if gainControl.hasAnyShow(itemConfig.produce)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})

end
end
else
local isSpe=gubaoModel:isSpecial(gbid)
if not isSpe then
local fulllianhua=gubaoModel:checkFullLianHuaEx(gbid)
if not fulllianhua then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eLianHuaFabao,})
end
local fullupstar=gubaoModel:checkFullUpStar(gbid)
if not fullupstar then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUpStarFabao,})
else
if gubaoModel:checkOpenAwake(gbid)then
local isAwake=gubaoModel:checkAwake(gbid)
if not isAwake then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAwakeFabao,})
end
end
end
end
local lookup=cfgHelper.get1(cfg_lookupxiantuachieveconfig_get,gbid)
if lookup then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXTCJGuBao,})
end
end
elseif formType==TIPS_FORM_TYPE.eLink or
formType==TIPS_FORM_TYPE.eClearBtn then

end
end


function tipsBtnManager.handleGubaoMetrial(argstable)
local formType=argstable.formType
local itemid=argstable.itemid
local gbid=gubaoLookup:good2GuBao(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
if formType==TIPS_FORM_TYPE.eGubaoBag then
local isActive=gubaoModel:checkActive(gbid)
if not isActive then
if gubaoModel:checkCanActive(gbid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eActiveFabao2,})
else
if not gubaoModel:checkActive(gbid)and gubaoLookup:checkEnoughPieceGoodWithChangePiece(gbid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eActiveFabao2,})
end
end
end
elseif formType==TIPS_FORM_TYPE.eLink or
formType==TIPS_FORM_TYPE.eClearBtn then
tipsBtnManager.clearBtn(argstable)
end

if gainControl.hasAnyShow(itemConfig.produce)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
tipsBtnManager.sortBtn(argstable,TIPS_BTNS_TYPE.eGetWay,1)
end

if formType==TIPS_FORM_TYPE.eXMFXZY then
tipsBtnManager.clearBtn(argstable)
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMFXZYReq})
end
end


function tipsBtnManager.handleDaoBing(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local diziguid=argstable.attach.diziguid
if formType==TIPS_FORM_TYPE.eEquipListWin or formType==TIPS_FORM_TYPE.eEquipFilter then
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
if itemguid==nil then return end
if daobingModel:isEquipedOnDizi(diziguid,itemguid)then
tipsBtnManager.clearBtn(argstable)
else
if daobingModel:isEquipedOnAnyDizi(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eReplaceEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressEquip})
end
end
elseif formType==TIPS_FORM_TYPE.eEquipWin then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eShowGain,})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eJinglianDaoBing})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUpStarDaoBing})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
elseif formType==TIPS_FORM_TYPE.eClearBtn or formType==TIPS_FORM_TYPE.eWatchRoleItem or
formType==TIPS_FORM_TYPE.eLink then
tipsBtnManager.clearBtn(argstable)
elseif formType==TIPS_FORM_TYPE.eDaoBingCollect then
if gainControl.hasAnyShow(itemConfig.produce)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay,})
end
elseif formType==TIPS_FORM_TYPE.eDaoBingBagGrids or formType==TIPS_FORM_TYPE.eBagGrids then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eJinglianDaoBing})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUpStarDaoBing})
elseif formType==TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
local auctionSeries=argstable.auctionSeries
if auctionSeries then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionReSellItem})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionSellItem})
end
elseif formType==TIPS_FORM_TYPE.eXMDG_shop then

local selectNumCmpArgs=argstable.attach.selectNumCmpArgs
if selectNumCmpArgs and selectNumCmpArgs.max then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMDG_Exchange})
end
elseif formType==TIPS_FORM_TYPE.eAuctionShowItem then
local auctionSeries=argstable.attach.auctionSeries
local isGuanZhu=auctionModel:getAuctionItemGuanZhuState(auctionSeries)~=nil
if isGuanZhu then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhuCancel})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhu})
end
end
end

function tipsBtnManager.handleFaBaoYuanPei(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
if formType==TIPS_FORM_TYPE.eFaBaoYuanPeiSelect then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutFabaoYuanPei})
elseif formType==TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
local auctionSeries=argstable.auctionSeries
if auctionSeries then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionReSellItem})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionSellItem})
end
elseif formType==TIPS_FORM_TYPE.eBagGrids then
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eBenMingFaBao)
if isOpen then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eYuanPeiLianZhi})
end
elseif formType==TIPS_FORM_TYPE.eAuctionShowItem then
local auctionSeries=argstable.attach.auctionSeries
local isGuanZhu=auctionModel:getAuctionItemGuanZhuState(auctionSeries)~=nil
if isGuanZhu then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhuCancel})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhu})
end
end
end

function tipsBtnManager.handleMount(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local dzguid=argstable.attach.diziguid
if formType==TIPS_FORM_TYPE.eMountBag then
if mountModel:isEquipedOnDZ(dzguid,itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
elseif mountModel:isEquipedOnAnyDZ(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eHuHuan})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressEquip,})
end
elseif formType==TIPS_FORM_TYPE.eMountBook then
tipsBtnManager.clearBtn(argstable)
elseif formType==TIPS_FORM_TYPE.eEquipWin or
formType==TIPS_FORM_TYPE.eMountEquip then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eShowGain,})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
elseif formType==TIPS_FORM_TYPE.eEquipListWin then
if mountModel:isEquipedOnDZ(dzguid,itemguid)then
tipsBtnManager.clearBtn(argstable)
else
if mountHelper.isCanDress(dzguid,itemid)then
if mountModel:isEquipedOnAnyDZ(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eHuHuan})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressEquip,})
end
end
end
elseif formType==TIPS_FORM_TYPE.eBagGrids then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eMountOpen})
end
end

function tipsBtnManager.handleBuildingSuitItem(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local diziguid=argstable.attach.diziguid
local itemConfig=itemsConfig.getConfig(itemid)

if formType~=TIPS_FORM_TYPE.eXMDG_shop and
gainControl.hasAnyShow(itemConfig.produce)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
tipsBtnManager.sortBtn(argstable,TIPS_BTNS_TYPE.eGetWay,1)
end

if formType==TIPS_FORM_TYPE.eLink or
formType==TIPS_FORM_TYPE.eClearBtn or
formType==TIPS_FORM_TYPE.eBaoXiangTipsItem then
tipsBtnManager.clearBtn(argstable)
elseif formType==TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
local auctionSeries=argstable.auctionSeries
if auctionSeries then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionReSellItem})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionSellItem})
end
elseif formType==TIPS_FORM_TYPE.eXMDG_shop then

local selectNumCmpArgs=argstable.attach.selectNumCmpArgs
if selectNumCmpArgs and selectNumCmpArgs.max then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXMDG_Exchange})
end
elseif formType==TIPS_FORM_TYPE.eAuctionShowItem then
local auctionSeries=argstable.attach.auctionSeries
local isGuanZhu=auctionModel:getAuctionItemGuanZhuState(auctionSeries)~=nil
if isGuanZhu then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhuCancel})
else

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eAuctionGuanZhu})
end
end

if formType~=TIPS_FORM_TYPE.eBagGrids then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eBuildSuit})
tipsBtnManager.sortBtn(argstable,TIPS_BTNS_TYPE.eBuildSuit,2)
end

if formType==TIPS_FORM_TYPE.eQuickUse then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eGetWay)
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUseItem})
end

if itemConfig.dealPrice==nil then
tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eSellItem)
end

if bagUseControl.isItemExpire(itemguid)then

tipsBtnManager.removeBtn(argstable,TIPS_BTNS_TYPE.eUseItem)
if itemConfig.dealPrice~=nil and formType~=TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eSellItem})
end
end
end

function tipsBtnManager.handleWBXBDItem(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid

if formType==TIPS_FORM_TYPE.eMMEquipCompose then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eWBXBDComposePut})
end

if formType==TIPS_FORM_TYPE.eMMEquipJinLian then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eWBXBDJingLianPut})
end

if formType==TIPS_FORM_TYPE.eLink or
formType==TIPS_FORM_TYPE.eClearBtn then
tipsBtnManager.clearBtn(argstable)
end
end

function tipsBtnManager.handleWBXBDEquip(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local attach=argstable.attach













if formType==TIPS_FORM_TYPE.eMMCommonEquip then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eWBXBDEuipRefine})
if attach.catguid~=nil then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eWBXBDEuipDisboard})
end
end

if formType==TIPS_FORM_TYPE.eLink or
formType==TIPS_FORM_TYPE.eClearBtn then
tipsBtnManager.clearBtn(argstable)
end
end


function tipsBtnManager.handleClothing(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local diziguid=argstable.attach.diziguid

if formType==TIPS_FORM_TYPE.eEquipListWin or formType==TIPS_FORM_TYPE.eEquipFilter then
if itemguid==nil then return end
if ClothingModel:isEquipedOnDizi(diziguid,itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
else
if ClothingModel:isEquipedOnAnyDizi(itemguid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eReplaceEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDressEquip})
end
end
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUpStarClothing})


if ClothingModel:getStarLv(itemguid)>=1 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eDisciple_FD_Reset})
tipsBtnManager.sortBtn(argstable,TIPS_BTNS_TYPE.eDisciple_FD_Reset,2)
end
elseif formType==TIPS_FORM_TYPE.eEquipWin then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eShowGain,})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUpStarClothing})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
elseif formType==TIPS_FORM_TYPE.eClearBtn or formType==TIPS_FORM_TYPE.eWatchRoleItem or
formType==TIPS_FORM_TYPE.eLink then
tipsBtnManager.clearBtn(argstable)
elseif formType==TIPS_FORM_TYPE.eClothingBag or formType==TIPS_FORM_TYPE.eBagGrids then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eClothingOpen})
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUpStarClothing})
end
end


function tipsBtnManager.handleXianBao(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local cfgType=argstable.cfgType
local itemConfig=itemsConfig.getConfig(itemid,cfgType)
if formType==TIPS_FORM_TYPE.eXianBaoMaterial then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
elseif formType==TIPS_FORM_TYPE.eXianBaoBag then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
if not xianbaoModel:checkActive(itemid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXianBaoActive})
return
end
elseif formType==TIPS_FORM_TYPE.eXianBaoTujian then
if cfgType==ITEM_CONFIG_TYPE.eXianBao then
if not xianbaoModel:checkActive(itemid)then
if xianbaoModel:checkCanActive(itemid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXianBaoActive})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
end
return
end
if xianbaoModel:checkCanUpStar(itemid)then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eXianBaoUpStar})
end
if itemConfig.tipsBtnId then
tipsBtnManager.insertBtn(argstable,{itemConfig.tipsBtnId})
end
if itemConfig.tipsBtnIdlist then
tipsBtnManager.insertBtn(argstable,{itemConfig.tipsBtnIdlist[1]})
tipsBtnManager.insertBtn(argstable,{itemConfig.tipsBtnIdlist[2]})
end

elseif cfgType==ITEM_CONFIG_TYPE.eGuBao then

end
elseif formType==TIPS_FORM_TYPE.eXianBaoUpStar then
if itemConfig.tipsBtnId then
tipsBtnManager.insertBtn(argstable,{itemConfig.tipsBtnId})
end
end
end

function tipsBtnManager.handleYunZhouComponents(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local attach=argstable.attach

if formType==TIPS_FORM_TYPE.eClearBtn or formType==TIPS_FORM_TYPE.eWatchRoleItem then
tipsBtnManager.clearBtn(argstable)
return
end

local item=bagModel.getItem(itemguid)
local isLock=bagHelper.isLock(item)
if formType==TIPS_FORM_TYPE.eYunZhouWarehouse then
if isLock then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUnlockEquip})
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eLockEquip})
end
end

if formType==TIPS_FORM_TYPE.eYunZhouComponents then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eShowGain})
end

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eYunZhouComponentsCompose,TIPS_BTNS_TYPE.eYunZhouComponentsStrengthen})

if formType==TIPS_FORM_TYPE.eYunZhouComponents then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eTakeOffEquip})
end
end

function tipsBtnManager.handleGiftPack(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local attach=argstable.attach
local itemConfig=itemsConfig.getConfig(itemid)

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})

if bagUseControl.isItemExpire(itemguid)then

if itemConfig.dealPrice~=nil and formType~=TIPS_FORM_TYPE.eAuctionSellItem then

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eSellItem})
end
else
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eUseItem})
end
end

function tipsBtnManager.handleReuseItem(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local attach=argstable.attach

local cdTime=bagUseControl.getItemCDTime(itemguid)
if cdTime<=0 then
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eReuseItem})
end
end

function tipsBtnManager.handleTDLXMetrial(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local attach=argstable.attach

tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.eGetWay})
tipsBtnManager.sortBtn(argstable,TIPS_BTNS_TYPE.eGetWay,1)
end
