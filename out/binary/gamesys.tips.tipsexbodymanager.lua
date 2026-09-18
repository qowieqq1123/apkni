tipsExBodyManager={}


function tipsExBodyManager.addCommonBody(argstable,componetType)

local exBodysConfig=argstable.exBodysConfig







exBodysConfig[#exBodysConfig+1]=componetType





end

function tipsExBodyManager.deleteCommonBody(argstable,componetType)

local exBodysConfig=argstable.exBodysConfig
for i,v in ipairs(exBodysConfig)do
if v==componetType then
table.remove(exBodysConfig,i)
break
end
end
end

function tipsExBodyManager.handleCommonBody(argstable)

end

function tipsExBodyManager.handleDaoBing(argstable)
local formType=argstable.formType
local itemid=argstable.itemid

if formType==TIPS_FORM_TYPE.eDaoBingCollect then
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildDaoBingToggle)
end
end


function tipsExBodyManager.handleMount(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
local dzguid=argstable.attach.diziguid
if not mountModel:isEquipedOnDZ(dzguid,itemguid)and
mountModel:isEquipedOnAnyDZ(itemguid)then
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildMountOwner)
end
end

function tipsExBodyManager.handleItem(argstable)
local formType=argstable.formType
if formType==TIPS_FORM_TYPE.eXMFXZY then
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildXMFXZYCondition)
end

local itemid=argstable.itemid
if itemid then
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig.type1 and itemConfig.type1==13 then

local gfid=gongfaLookup:checkGongfaPiece(itemid)
if gfid then
local glid=liandonModel:CheckGongFa_Guanlian(gfid)
if glid then
argstable.guanlian_id=glid
argstable.GFid=gfid
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildGuanLianBtn)
end
end
end
end


end

function tipsExBodyManager.handleMetrial(argstable)
local formType=argstable.formType
if formType==TIPS_FORM_TYPE.eXMFXZY then
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildXMFXZYCondition)
end
end

function tipsExBodyManager.handleGubaoMetrial(argstable)
local formType=argstable.formType
local itemid=argstable.itemid

if formType==TIPS_FORM_TYPE.eXMFXZY then
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildXMFXZYCondition)
end
local gbid=gubaoLookup:good2GuBao(itemid)
if gbid then
local glid=liandonModel:CheckGB_Guanlian(gbid)
if glid then
argstable.guanlian_id=glid
argstable.gbid=gbid
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildGuanLianBtn)
end
end

end

function tipsExBodyManager.handleEquip(argstable)
local itemguid=argstable.itemguid

local item=itemsModel.getItem(itemguid)
local itemid=item and item.itemid or argstable.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local itemflag=item and item.itemflag
local isBind=itemflag and mathHelper.getBitValue(itemflag,0)or false
if isBind or itemConfig.showNotAuction then
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildNotJinShou)
end
end

function tipsExBodyManager.handleRandomEquipItem(argstable)
local itemid=argstable.itemid
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.showNotAuction then
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildNotJinShou)
end
end

function tipsExBodyManager.handleXianBao(argstable)
local xbId=argstable.itemid
local formType=argstable.formType
local glid=liandonModel:CheckXB_Guanlian(xbId)

local type=argstable.xbtype or XianBaoTypeEnum.eXianBao

if type==XianBaoTypeEnum.eXianBao then
if glid then

argstable.guanlian_id=glid
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildGuanLianBtn)
else


if not xianbaoModel:checkCanUpStar(xbId)then
return
end
local isAdd=false
if formType==TIPS_FORM_TYPE.eXianBaoTujian or formType==TIPS_FORM_TYPE.eXianBaoUpStar then
if not xianbaoModel:checkActive(xbId)then
isAdd=true
end
elseif formType==TIPS_FORM_TYPE.eXianBaoMaterial or formType==TIPS_FORM_TYPE.eXianBaoBag then
isAdd=true
end
if isAdd then
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildXianBaoToggle)
end
end
elseif type==XianBaoTypeEnum.eGuBao then
end
end

function tipsExBodyManager.handleCommonGubao(argstable)
local GBid=argstable.itemid
local formType=argstable.formType
local glid=liandonModel:CheckGB_Guanlian(GBid)
if glid then
argstable.guanlian_id=glid
tipsExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildGuanLianBtn)
end
end

function tipsExBodyManager.handleCommonXingChen(argstable)


tipsBodyManager.addCommonBody(argstable,TIPS_NODE_TYPE.eMiddleNodeBottom,TIPS_SRC_TYPE.tipsChildXingChenRareEffect)

end
