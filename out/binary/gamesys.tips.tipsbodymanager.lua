









tipsBodyManager={}

function tipsBodyManager.addCommonBody(argstable,nodeIdx,componetType)

if not argstable.tipsBodysConfig[nodeIdx]then
argstable.tipsBodysConfig[nodeIdx]=componetType
else
logErr(FMT.fmt('{0}添加失败，{1}节点已被占用，请先删除或更换其他节点',componetType,nodeIdx))
end
end

function tipsBodyManager.deleteCommonBody(argstable,componetType)
for nodeIdx,v in pairs(argstable.tipsBodysConfig)do
if v==componetType then
argstable.tipsBodysConfig[nodeIdx]=nil
return nodeIdx
end
end
end

function tipsBodyManager.addScrollBody(argstable,nodeIdx,componetType)
if argstable.addScrollBody==nil then argstable.addScrollBody={}end
if not argstable.addScrollBody[nodeIdx]then
argstable.addScrollBody[nodeIdx]=componetType
else
logErr(FMT.fmt('{0}添加失败，{1}节点已被占用，请先删除或更换其他节点',componetType,nodeIdx))
end
end

function tipsBodyManager.deleteScrollBody(argstable,componetType)
if argstable.deleteScrollBody==nil then argstable.deleteScrollBody={}end
argstable.deleteScrollBody[componetType]=true
end

function tipsBodyManager.onlyCustomBtn(argstable)
local temp={}
for i,v in pairs(argstable.tipsBtnsConfig)do
temp[v]=i
end
for i=#argstable.btnsList,1,-1 do
if temp[argstable.btnsList[i]]then
table.remove(argstable.btnsList,i)
end
end
end

function tipsBodyManager.addSelectNumBody(argstable)
local attach=argstable.attach
if attach and attach.selectNumCmpArgs then
local selectNumCmpArgs=attach.selectNumCmpArgs
if selectNumCmpArgs.max>1 or selectNumCmpArgs.isOverZero or selectNumCmpArgs.mustShow then
local nodeIdx=attach.selectNumCmpArgs.nodeIdx or TIPS_NODE_TYPE.eBottomNodeBottom
tipsBodyManager.addCommonBody(argstable,nodeIdx,TIPS_SRC_TYPE.tipsChildItemNumSelect)
end
end
end


function tipsBodyManager.addShopCostBody(argstable)
local attach=argstable.attach
if attach and attach.shopCostArgs then
local shopCostArgs=attach.shopCostArgs
local nodeIdx=attach.shopCostArgs.nodeIdx or TIPS_NODE_TYPE.eBottomNodeBottom
tipsBodyManager.addCommonBody(argstable,nodeIdx,TIPS_SRC_TYPE.tipsChildShopCost)
end
end


function tipsBodyManager.addRewardRateBody(argstable)
local attach=argstable.attach
if attach and attach.rewardRateArgs then
local nodeIdx=attach.rewardRateArgs.nodeIdx or TIPS_NODE_TYPE.eBottomNodeBottom
tipsBodyManager.addCommonBody(argstable,nodeIdx,TIPS_SRC_TYPE.tipsChildMoneyRewardRate)
end
end

function tipsBodyManager.FormHandle_WorldTour(argstable)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeBottom,TIPS_SRC_TYPE.tipsChildAttachDesc)

end

function tipsBodyManager.FormHandle_DiscipleBag(argstable)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildSell)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeBottom,TIPS_SRC_TYPE.tipsChildAttachDesc)
tipsBodyManager.onlyCustomBtn(argstable)
end

function tipsBodyManager.handleLianqiGeBagItem(argstable)
local itemid=argstable.itemid
local attach=argstable.attach
if itemsConfig.isMaterials(itemid)then
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildMaterialUseFabao)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildDesc)
if attach and attach.isMain then
if attach.isMakeByEquip then
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoAttr)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeTop,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoLianhuaAttr)
else
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeMiddle,TIPS_SRC_TYPE.tipsChildScrollView)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eBottomNodeTop,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoLianhuaAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildFabaoShentong)
end
else
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoAttr)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeTop,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoLianhuaAttr)
end
elseif itemsConfig.isEquip(itemid)then
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildBaseAttr)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildRandomAttr)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildEquipSuit)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildEquipVoc)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildFabaoTitle)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildFabaoShentong)
end
end

function tipsBodyManager.handleLianqiGeItem(argstable)
local itemid=argstable.itemid
local attach=argstable.attach
if itemsConfig.isMaterials(itemid)then
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildMaterialUseFabao)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildDesc)
if attach and attach.isMain then
if attach.isMakeByEquip then
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoAttr)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeTop,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoLianhuaAttr)
else
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeMiddle,TIPS_SRC_TYPE.tipsChildScrollView)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eBottomNodeTop,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoLianhuaAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildFabaoShentong)
end
else
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoAttr)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeTop,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoLianhuaAttr)
end
elseif itemsConfig.isEquip(itemid)then
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildBaseAttr)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildRandomAttr)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildEquipSuit)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildEquipVoc)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildFabaoTitle)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildFabaoShentong)
end
end

function tipsBodyManager.handleLianqiGeFabaoPreview(argstable)
local itemid=argstable.itemid
local attach=argstable.attach
if itemsConfig.isMaterials(itemid)then
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildMaterialUseFabao)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildDesc)

tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeMiddle,TIPS_SRC_TYPE.tipsChildScrollView)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eBottomNodeTop,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoLianhuaAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildFabaoShentong)
elseif itemsConfig.isEquip(itemid)then
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildBaseAttr)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildRandomAttr)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildEquipSuit)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildEquipVoc)

tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeMiddle,TIPS_SRC_TYPE.tipsChildScrollView)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eBottomNodeTop,TIPS_SRC_TYPE.tipsChildConfigRandomFabaoLianhuaAttr)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildFabaoShentong)
end
end

function tipsBodyManager.handleGubaoItem(argstable)
if argstable.tipsType==TIPS_TYPE.eCommonGubao then
local gbid=argstable.itemid
if gubaoModel:isSpecial(gbid)then
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeTop,TIPS_SRC_TYPE.tipsChildGuBaoSpe)
end










end
end
function tipsBodyManager.handleGubaoFSItem(argstable)
if argstable.tipsType==TIPS_TYPE.eCommonGubao then
local gbid=argstable.itemid


if gbid>=360 or gbid<=379 then
local attr=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'fly_attr')
if attr then
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeBottom,TIPS_SRC_TYPE.tipsChildGuBaoFSAttr)
end
end
end

if argstable.tipsType==TIPS_TYPE.eCommonGubaoMetrial then
if itemsConfig.isGubao(argstable.itemid)then
local gbid=gubaoLookup:good2GuBao(argstable.itemid)
if gbid>=360 or gbid<=379 then
local attr=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'fly_attr')
if attr then
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeBottom,TIPS_SRC_TYPE.tipsChildGuBaoFSAttr)
end
end
end
end
end

function tipsBodyManager.handleAuctionSellItem(argstable)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeBottom,TIPS_SRC_TYPE.tipsChildAuctionSell)
end

function tipsBodyManager.handleCommonBody(argstable)
tipsBodyManager.addSelectNumBody(argstable)
tipsBodyManager.addShopCostBody(argstable)
tipsBodyManager.addRewardRateBody(argstable)
end

function tipsBodyManager.handleYuHuoBody(argstable)
local itemid=argstable.itemid
local guid=argstable.itemguid
local itemCfg=itemsConfig.getConfig(itemid)
if UIAquariumControl:isFishType(itemCfg.type1)then
local item=UIAquariumControl:getItemByGuid(guid)
local isSPFish=UIAquariumControl:isOrnamentalFish(item)
if not isSPFish then
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildYuHuoAttr)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildYuHuoFeature)
end
else
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildYuHuoAttr)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildYuHuoFeature)
end
end

function tipsBodyManager.handleLingZhen(argstable)
local itemCfg=itemsConfig.getConfig(argstable.itemid)
if itemCfg.type1==6 then

tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeTop,TIPS_SRC_TYPE.tipsChildLingZhenLevelAttr)



end
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeBottom,TIPS_SRC_TYPE.tipsChildDesc)
end

function tipsBodyManager.handleFuBao(argstable)

end

function tipsBodyManager.handleItem(argstable)
local itemid=argstable.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local funcparam=itemCfg.funcparam
if funcparam then
if funcparam.type==item_funtion_type.jj_xiuweidan or funcparam.type==item_funtion_type.lt_jingyandan or funcparam.type==item_funtion_type.tezhiAdd then
local extra=funcparam.extra
if extra then
local temp={}
for i,v in ipairs(extra)do
for k,v2 in pairs(v[2])do
if k==5 and v2[1]==10000 then
for i2,v3 in ipairs(v2[2])do
local d={}
d.speType=v3[1]
d.speIDList=v3[2]
table.insert(temp,d)
end
end
end
end
if#temp>0 then
local attach=argstable.attach
if attach==nil then
attach={}
argstable.attach=attach
end
attach.speRandomShowList=temp
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildDesc)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eTopNodeMiddle,TIPS_SRC_TYPE.tipsChildScrollView1)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeMiddle,TIPS_SRC_TYPE.tipsChildDesc)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeBottom,TIPS_SRC_TYPE.tipsChildSpecialityRandomShow)
end
end
end
end

local formType=argstable.formType
if formType==TIPS_FORM_TYPE.eBagGrids then

local cfg=UISettingConfig.getSelfCfgBySex(itemid)
if cfg then
local typo=cfg[2]
local id=cfg[1].id
local isActive=UISettingModel:isUnlockHead(typo,id)
if isActive and not UISettingModel:isCanOverlay(typo,id)and not playerImageModel:isDurationImage(itemCfg)then
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildSellWithTips)
argstable.attach.sellDesc=typo==KUANGE_TYPE.head and'头像已激活，已无法继续使用'or
typo==KUANGE_TYPE.headKuang and'头像框已激活，已无法继续使用'or
typo==KUANGE_TYPE.chatKuang and'气泡框已激活，已无法继续使用'
end
elseif playerImageModel:isActiveAnyImage(itemCfg)and not playerImageModel:isDurationImage(itemCfg)then
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildSellWithTips)
argstable.attach.sellDesc='形象已激活，已无法继续使用'
end
elseif formType==TIPS_FORM_TYPE.eXMKCBag then
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeBottom,TIPS_SRC_TYPE.tipsChildXMKCItemFPDesc)
elseif formType==TIPS_FORM_TYPE.eXMKCFPWin then
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildXMKCItemFPDesc)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeBottom,TIPS_SRC_TYPE.tipsChildXMKCItemSlider)
end

if formType==TIPS_FORM_TYPE.eBagGrids and itemCfg.type1==13 and systemModel.isOpen(SYSTEM_DEFINE.eGongFaRecycle)then
local gfID=gongfaLookup:checkGongfaPiece(itemid)
if gfID and UIGongFaModel:checkFullStudy(gfID)then
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildRecycle)
tipsBodyManager.deleteCommonBody(argstable,TIPS_SRC_TYPE.tipsChildGongFaCollect)
end
end


if formType==TIPS_FORM_TYPE.eBagGrids and itemCfg.type1==9 and(funcparam and funcparam.maxcnt and funcparam.maxcnt>1)then
local count=itemsModel.getCount(itemid)
if count>1 then
local selectNumCmpArgs={}
selectNumCmpArgs.numFormat="使用：<color=#f1ce78>{0}/{1}</color>"
argstable.attach.selectNumCmpArgs=selectNumCmpArgs
selectNumCmpArgs.min=1
selectNumCmpArgs.max=Mathf.Min(count,funcparam.maxcnt)
tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eBottomNodeMiddle,TIPS_SRC_TYPE.tipsChildItemNumSelect)
end
end
end

function tipsBodyManager.handleFaBao(argstable)
if argstable and argstable.removeBodyList then
for index,type in ipairs(argstable.removeBodyList)do
tipsBodyManager.deleteScrollBody(argstable,type)
end
end
end

function tipsBodyManager.handleeCommonClothing(argstable)
if argstable.formType==TIPS_FORM_TYPE.eWatchRoleItem then
tipsBodyManager.deleteScrollBody(argstable,TIPS_SRC_TYPE.tipsChildCollectClothing)
end
end


function tipsBodyManager.handleDFXianBao(argstable)
if argstable.tipsType==TIPS_TYPE.eCommonXianBao then
local xbid=argstable.itemid
local dfxb=xianbaoModel:CheckDianfengXianbao(xbid)
if dfxb then
tipsBodyManager.deleteScrollBody(argstable,TIPS_SRC_TYPE.tipsChildXianBaoEffect)
tipsBodyManager.deleteScrollBody(argstable,TIPS_SRC_TYPE.tipsChildXianBaoLevel)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eMiddleNodeTop,TIPS_SRC_TYPE.tipsChildDFXianBaoEffect)
end
end
end
