





bagConfig={}












BAG_TYPE=
{
eItemBag=1,
eMaterialsBag=2,
eEquipBag=3,
eFabaoBag=4,
eFubaoBag=5,
eGubaoBag=6,
eDaoBingBag=7,
eYuHuo=8,
eMaoMaoBag=9,
eMountBag=10,
eLingZhen=11,
eClothing=12,
eShopHuoCang=13,
eXianBao=14,
eXingChen=15,
eYunZhou=16,
eVocEquip=17,
}

BAG_TYPE_NAME=
{
[BAG_TYPE.eItemBag]="道具",
[BAG_TYPE.eMaterialsBag]="材料",
[BAG_TYPE.eEquipBag]="装备",
[BAG_TYPE.eFabaoBag]="法宝",
[BAG_TYPE.eFubaoBag]="符宝",
[BAG_TYPE.eGubaoBag]="古宝",
[BAG_TYPE.eDaoBingBag]="道兵",
[BAG_TYPE.eYuHuo]="鱼获",
[BAG_TYPE.eMaoMaoBag]="猫猫",
[BAG_TYPE.eMountBag]="坐骑",
[BAG_TYPE.eLingZhen]="灵阵",
[BAG_TYPE.eClothing]="时装",
[BAG_TYPE.eShopHuoCang]="货仓",
[BAG_TYPE.eXianBao]="仙宝",
[BAG_TYPE.eXingChen]="星辰",
[BAG_TYPE.eYunZhou]="云舟",
[BAG_TYPE.eVocEquip]="职装",
}

SHOW_BAG_TYPE=
{
eItemBag=1,
eMaterialsBag=2,
eEquipBag=3,
eFabaoBag=4,
eFubaoBag=5,
eRareBag=6,

isIncluded=function(showBagType,bagType)
for _,v in ipairs(BAG_TYPE_IN_SHOW_BAG_TYPE[showBagType])do
if bagType==v then
return true
end
end
return false
end,

getBagTypeList=function(showBagType)
return BAG_TYPE_IN_SHOW_BAG_TYPE[showBagType]
end,

getShowBagType=function(bagType)
return BAG_TYPE_TO_SHOW_BAG_TYPE[bagType]
end
}

BAG_TYPE_IN_SHOW_BAG_TYPE=
{
[SHOW_BAG_TYPE.eItemBag]={BAG_TYPE.eItemBag},
[SHOW_BAG_TYPE.eMaterialsBag]={BAG_TYPE.eMaterialsBag},
[SHOW_BAG_TYPE.eEquipBag]={BAG_TYPE.eEquipBag},
[SHOW_BAG_TYPE.eFabaoBag]={BAG_TYPE.eFabaoBag},
[SHOW_BAG_TYPE.eFubaoBag]={BAG_TYPE.eFubaoBag,BAG_TYPE.eLingZhen},
[SHOW_BAG_TYPE.eRareBag]={BAG_TYPE.eDaoBingBag,BAG_TYPE.eClothing,BAG_TYPE.eMountBag,BAG_TYPE.eVocEquip},
}


BAG_TYPE_LIST={
BAG_TYPE.eItemBag,BAG_TYPE.eMaterialsBag,BAG_TYPE.eEquipBag,
BAG_TYPE.eFabaoBag,BAG_TYPE.eFubaoBag,BAG_TYPE.eGubaoBag
}


local _bagMaxNum={
[BAG_TYPE.eItemBag]=1500,
[BAG_TYPE.eMaterialsBag]=500,
[BAG_TYPE.eEquipBag]=1500,
[BAG_TYPE.eFabaoBag]=500,
[BAG_TYPE.eFubaoBag]=500,
[BAG_TYPE.eGubaoBag]=500,
[BAG_TYPE.eDaoBingBag]=500,
[BAG_TYPE.eYuHuo]=200,
[BAG_TYPE.eMaoMaoBag]=200,
[BAG_TYPE.eMountBag]=200,
[BAG_TYPE.eLingZhen]=200,
[BAG_TYPE.eClothing]=200,
[BAG_TYPE.eXingChen]=2000,
[BAG_TYPE.eVocEquip]=500,
}


function bagConfig.getBagMaxNum(bagType)
return _bagMaxNum[bagType]
end

function bagConfig.getShowBagMaxNum(showBagType)
local num=0
for _,v in ipairs(BAG_TYPE_IN_SHOW_BAG_TYPE[showBagType])do
num=num+_bagMaxNum[v]
end
return num
end


BAG_TYPE_TO_SHOW_BAG_TYPE={}
for k,v in pairs(BAG_TYPE_IN_SHOW_BAG_TYPE)do
for _,bt in ipairs(v)do
BAG_TYPE_TO_SHOW_BAG_TYPE[bt]=k
end
end
