tipsMidExBodyManager={}


function tipsMidExBodyManager.addCommonBody(argstable,componetType)

local exMidBodysConfig=argstable.exMidBodysConfig







exMidBodysConfig[#exMidBodysConfig+1]=componetType





end

function tipsMidExBodyManager.deleteCommonBody(argstable,componetType)
local exMidBodysConfig=argstable.exMidBodysConfig
for i,v in ipairs(exMidBodysConfig)do
if v==componetType then
table.remove(exMidBodysConfig,i)
break
end
end
end

function tipsMidExBodyManager.handleCommonBody(argstable)

end

function tipsMidExBodyManager.handleItem(argstable)
local formType=argstable.formType
end

function tipsMidExBodyManager.handleEquip(argstable)
local itemguid=argstable.itemguid

local item=itemsModel.getItem(itemguid)
local itemid=item and item.itemid or argstable.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local itemflag=item and item.itemflag
local isBind=itemflag and mathHelper.getBitValue(itemflag,0)or false

local formType=argstable.formType



local itemguid=argstable.itemguid
if itemsConfig.isEquip(itemid)and(itemguid and not equipsModel.isEquipedOnAnyDizi(itemguid))then
if formType==TIPS_FORM_TYPE.eBagGrids or formType==TIPS_FORM_TYPE.eEquipFilter then
tipsMidExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildRongLianBtn)
end
end
end

function tipsMidExBodyManager.handleFaBao(argstable)
local formType=argstable.formType

if formType==TIPS_FORM_TYPE.eFaBaoRefineCompare then
tipsMidExBodyManager.addCommonBody(argstable,TIPS_SRC_TYPE.tipsChildExBMFBCompareButton)
end
end
