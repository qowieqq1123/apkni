







local _MODULENAME="discipleEquipPresetController"
gameState.addListener(def_table(_MODULENAME))
discipleEquipPresetController.name=_MODULENAME
local disciplePresetMax=5
local totalPresetMax=100
local _guidArray
local _arrayIndexPool
local _totalPresetNum
local _presetNameLookup
local _spDzGuidIdxStrLookup
eEquipPresetType={
eEquipWeapon=1,
eEquipClothes=2,
eEquipCrown=3,
eEquipShoes=4,
eFaBao=5,
eDaoBing=6,
eYuFu1=7,
eYuFu2=8,
eMount=9,
eDress=10,
eVocEquip=11,
eGongFa1=12,
eGongFa2=13,
}
local ePresetGuidArrayIndex={
eEquipWeaponHigh=1,
eEquipWeaponLow=2,
eEquipClothesHigh=3,
eEquipClothesLow=4,
eEquipCrownHigh=5,
eEquipCrownLow=6,
eEquipShoesHigh=7,
eEquipShoesLow=8,
eFaBaoHigh=9,
eFaBaoLow=10,
eDaoBingHigh=11,
eDaoBingLow=12,
eYuFu1High=13,
eYuFu1Low=14,
eYuFu2High=15,
eYuFu2Low=16,
eMountHigh=17,
eMountLow=18,
eDressHigh=19,
eDressLow=20,
eVocEquipHigh=21,
eVocEquipLow=22,
eGongFa1=23,
eGongFa2=24,
}


local function getGuidFunc_CommonEquip(discipleguid,equipType)
local equip=equipsHelper.getEquipByDizi(discipleguid,equipType)
if not equip then
return
end
local itemguid=equip.itemguid
return mathHelper.splitToInt32(itemguid)
end


local function checkSameFunc_CommonEquip(discipleguid,equipType,compareGuid)
local equip=equipsHelper.getEquipByDizi(discipleguid,equipType)
if not equip then
return compareGuid==nil
end
local itemguid=equip.itemguid
return mathHelper.compareInt64(itemguid,compareGuid)
end


local function checkBanFunc_CommonEquip(discipleguid,itemguid)
local equip=bagModel.getItem(itemguid)or equipsModel.getEquip(itemguid)
if not equip then
return false
end
local itemid=equip.itemid
return equipsHelper.isCanDress(discipleguid,itemid)
end


local function checkExistFunc_CommonEquip(discipleguid,itemguid)
local equip=bagModel.getItem(itemguid)or equipsModel.getEquip(itemguid)
if not equip then
return false
end
return true
end


local function getEquipedAttrFunc_CommonEquip(discipleguid,equipType)
local equip=equipsHelper.getEquipByDizi(discipleguid,equipType)
if not equip then
return
end
local itemguid=equip.itemguid
return equipsHelper.getEquipAttrsLookupByItemguid(itemguid,true)
end


local function getPresetAttrFunc_CommonEquip(itemguid)
local equip=bagModel.getItem(itemguid)or equipsModel.getEquip(itemguid)
if not equip then
return
end
return equipsHelper.getEquipAttrsLookupByItemguid(itemguid,false)
end


local function checkOtherUseFunc_CommonEquip(discipleguid,itemguid)
local diziguid=equipsModel.getDiziguidByItemguid(itemguid)
if not diziguid then
return
end
if not mathHelper.compareInt64(diziguid,discipleguid)then
local switchIdx=equipsModel.getEquipSwitchIdx(itemguid)
return diziguid,switchIdx
end
end


local function getGuidFunc_YuFu(discipleguid,pos)
local equip=UIFuLuFangModel:getFubaoData(discipleguid,pos)
if not equip then
return
end
local itemguid=equip.itemguid
return mathHelper.splitToInt32(itemguid)
end


local function checkSameFunc_YuFu(discipleguid,pos,compareGuid)
local equip=UIFuLuFangModel:getFubaoData(discipleguid,pos)
if not equip then
return compareGuid==nil
end
local itemguid=equip.itemguid
return mathHelper.compareInt64(itemguid,compareGuid)
end


local function checkBanFunc_YuFu(discipleguid,itemguid)
local equip=bagModel.getItem(itemguid)or UIFuLuFangModel:getItem(itemguid)
if not equip then
return false
end
local itemid=equip.itemid
return UIFuLuFangModel.isCanDress(discipleguid,itemid)
end


local function checkExistFunc_YuFu(discipleguid,itemguid)
local equip=bagModel.getItem(itemguid)or UIFuLuFangModel:getItem(itemguid)
if not equip then
return false
end
return true
end


local function getEquipedAttrFunc_YuFu(discipleguid,pos)
local equip=UIFuLuFangModel:getFubaoData(discipleguid,pos)
if not equip then
return
end
local itemguid=equip.itemguid
local effectLookup=UIFuLuFangModel.getFuBaoAttrLookup(itemguid)
return effectLookup[FUBAO_EFFECT_TYPE.eBaseAttr]
end


local function getPresetAttrFunc_YuFu(itemguid)
local equip=bagModel.getItem(itemguid)or UIFuLuFangModel:getItem(itemguid)
if not equip then
return
end
local effectLookup=UIFuLuFangModel.getFuBaoAttrLookup(itemguid)
return effectLookup[FUBAO_EFFECT_TYPE.eBaseAttr]
end


local function checkOtherUseFunc_YuFu(discipleguid,itemguid)
local diziguid=UIFuLuFangModel:getDzGuidByItemGuid(itemguid)
if not diziguid then
return
end
if not mathHelper.compareInt64(diziguid,discipleguid)then
local switchIdx=UIFuLuFangModel:getSwitchidxByItemGuid(itemguid)
return diziguid,switchIdx
end
end


local function getGuidFunc_GongFa(discipleguid,pos)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
local usingGFList=UIDiscipleModel:getDiscipleUsingGFList(netData)
if not usingGFList then
return
end
local gfID=usingGFList[pos]
return gfID
end


local function checkSameFunc_GongFa(discipleguid,pos,compareGuid)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
local usingGFList=UIDiscipleModel:getDiscipleUsingGFList(netData)
if not usingGFList then
return compareGuid==nil
end
local gfID=usingGFList[pos]
return gfID==compareGuid or(gfID==0 and compareGuid==nil)
end


local function checkBanFunc_GongFa(discipleguid,pos,itemguid)
local discipleGFNetData=UIDiscipleModel:getDiscipleGFData(discipleguid,itemguid)
if not discipleGFNetData then
return false
end
local jjlv=UIDiscipleModel:getDiscipleJJLevel(discipleguid)
local unlock=UIDiscipleModel.checkGFPosUnLock(pos,jjlv)
return unlock
end


local function checkExistFunc_GongFa(discipleguid,itemguid)
local discipleGFNetData=UIDiscipleModel:getDiscipleGFData(discipleguid,itemguid)
if not discipleGFNetData then
return false
end
return true
end

local equipPresetCfg={
[eEquipPresetType.eEquipWeapon]={
arrayIdxSplit={
ePresetGuidArrayIndex.eEquipWeaponHigh,
ePresetGuidArrayIndex.eEquipWeaponLow,
},
getGuid=function(discipleguid)
return getGuidFunc_CommonEquip(discipleguid,EQUIP_TYPE.eWeapon)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_CommonEquip(discipleguid,EQUIP_TYPE.eWeapon,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
return checkBanFunc_CommonEquip(discipleguid,presetGuid)
end,
checkExist=function(discipleguid,presetGuid)
return checkExistFunc_CommonEquip(discipleguid,presetGuid)
end,
getEquipedAttr=function(discipleguid)
return getEquipedAttrFunc_CommonEquip(discipleguid,EQUIP_TYPE.eWeapon)
end,
getPresetAttr=function(presetGuid)
return getPresetAttrFunc_CommonEquip(presetGuid)
end,
checkOtherUse=function(discipleguid,presetGuid)
return checkOtherUseFunc_CommonEquip(discipleguid,presetGuid)
end,
enablePreset=function(discipleguid,presetGuid)
equipsProtocolControl.req_equip_dress(discipleguid,presetGuid)
end,
takeOff=function(discipleguid,presetGuid,switchIdx)
if switchIdx and switchIdx>0 then
local replaceEquipType=1
local pos=EQUIP_TYPE.eWeapon
UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchIdx,replaceEquipType,pos)
else
equipsProtocolControl.req_equip_take_off(discipleguid,EQUIP_TYPE.eWeapon)
end
end,
},
[eEquipPresetType.eEquipClothes]={
arrayIdxSplit={
ePresetGuidArrayIndex.eEquipClothesHigh,
ePresetGuidArrayIndex.eEquipClothesLow,
},
getGuid=function(discipleguid)
return getGuidFunc_CommonEquip(discipleguid,EQUIP_TYPE.eClothes)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_CommonEquip(discipleguid,EQUIP_TYPE.eClothes,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
return checkBanFunc_CommonEquip(discipleguid,presetGuid)
end,
checkExist=function(discipleguid,presetGuid)
return checkExistFunc_CommonEquip(discipleguid,presetGuid)
end,
getEquipedAttr=function(discipleguid)
return getEquipedAttrFunc_CommonEquip(discipleguid,EQUIP_TYPE.eClothes)
end,
getPresetAttr=function(presetGuid)
return getPresetAttrFunc_CommonEquip(presetGuid)
end,
checkOtherUse=function(discipleguid,presetGuid)
return checkOtherUseFunc_CommonEquip(discipleguid,presetGuid)
end,
enablePreset=function(discipleguid,presetGuid)
equipsProtocolControl.req_equip_dress(discipleguid,presetGuid)
end,
takeOff=function(discipleguid,presetGuid,switchIdx)
if switchIdx and switchIdx>0 then
local replaceEquipType=1
local pos=EQUIP_TYPE.eClothes
UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchIdx,replaceEquipType,pos)
else
equipsProtocolControl.req_equip_take_off(discipleguid,EQUIP_TYPE.eClothes)
end
end,
},
[eEquipPresetType.eEquipCrown]={
arrayIdxSplit={
ePresetGuidArrayIndex.eEquipCrownHigh,
ePresetGuidArrayIndex.eEquipCrownLow,
},
getGuid=function(discipleguid)
return getGuidFunc_CommonEquip(discipleguid,EQUIP_TYPE.eCap)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_CommonEquip(discipleguid,EQUIP_TYPE.eCap,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
return checkBanFunc_CommonEquip(discipleguid,presetGuid)
end,
checkExist=function(discipleguid,presetGuid)
return checkExistFunc_CommonEquip(discipleguid,presetGuid)
end,
getEquipedAttr=function(discipleguid)
return getEquipedAttrFunc_CommonEquip(discipleguid,EQUIP_TYPE.eCap)
end,
getPresetAttr=function(presetGuid)
return getPresetAttrFunc_CommonEquip(presetGuid)
end,
checkOtherUse=function(discipleguid,presetGuid)
return checkOtherUseFunc_CommonEquip(discipleguid,presetGuid)
end,
enablePreset=function(discipleguid,presetGuid)
equipsProtocolControl.req_equip_dress(discipleguid,presetGuid)
end,
takeOff=function(discipleguid,presetGuid,switchIdx)
if switchIdx and switchIdx>0 then
local replaceEquipType=1
local pos=EQUIP_TYPE.eCap
UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchIdx,replaceEquipType,pos)
else
equipsProtocolControl.req_equip_take_off(discipleguid,EQUIP_TYPE.eCap)
end
end,
},
[eEquipPresetType.eEquipShoes]={
arrayIdxSplit={
ePresetGuidArrayIndex.eEquipShoesHigh,
ePresetGuidArrayIndex.eEquipShoesLow,
},
getGuid=function(discipleguid)
return getGuidFunc_CommonEquip(discipleguid,EQUIP_TYPE.eShoot)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_CommonEquip(discipleguid,EQUIP_TYPE.eShoot,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
return checkBanFunc_CommonEquip(discipleguid,presetGuid)
end,
checkExist=function(discipleguid,presetGuid)
return checkExistFunc_CommonEquip(discipleguid,presetGuid)
end,
getEquipedAttr=function(discipleguid)
return getEquipedAttrFunc_CommonEquip(discipleguid,EQUIP_TYPE.eShoot)
end,
getPresetAttr=function(presetGuid)
return getPresetAttrFunc_CommonEquip(presetGuid)
end,
checkOtherUse=function(discipleguid,presetGuid)
return checkOtherUseFunc_CommonEquip(discipleguid,presetGuid)
end,
enablePreset=function(discipleguid,presetGuid)
equipsProtocolControl.req_equip_dress(discipleguid,presetGuid)
end,
takeOff=function(discipleguid,presetGuid,switchIdx)
if switchIdx and switchIdx>0 then
local replaceEquipType=1
local pos=EQUIP_TYPE.eShoot
UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchIdx,replaceEquipType,pos)
else
equipsProtocolControl.req_equip_take_off(discipleguid,EQUIP_TYPE.eShoot)
end
end,
},
[eEquipPresetType.eFaBao]={
arrayIdxSplit={
ePresetGuidArrayIndex.eFaBaoHigh,
ePresetGuidArrayIndex.eFaBaoLow,
},
getGuid=function(discipleguid)
return getGuidFunc_CommonEquip(discipleguid,EQUIP_TYPE.eFabao)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_CommonEquip(discipleguid,EQUIP_TYPE.eFabao,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
local equip=bagModel.getItem(presetGuid)or fabaoHelper.getFabao(presetGuid)
if not equip then
return false
end
local itemid=equip.itemid
return fabaoHelper.isCanDress(discipleguid,itemid,presetGuid)
end,
checkExist=function(discipleguid,presetGuid)
local equip=bagModel.getItem(presetGuid)or fabaoHelper.getFabao(presetGuid)
if not equip then
return false
end
return true
end,
getEquipedAttr=function(discipleguid)
return fabaoModel.getFabaoAttrsLookup(discipleguid)
end,
getPresetAttr=function(presetGuid)
local equip=bagModel.getItem(presetGuid)or fabaoHelper.getFabao(presetGuid)
if not equip then
return
end
return fabaoHelper.getFabaoAttrsLookupByItemguid(presetGuid,false)
end,
checkOtherUse=function(discipleguid,presetGuid)
local diziguid=fabaoModel.getDiziguidByItemguid(presetGuid)
if not diziguid then
return
end
if not mathHelper.compareInt64(diziguid,discipleguid)then
local switchIdx=fabaoModel.getFabaoSwitchIdx(presetGuid)
return diziguid,switchIdx
end
end,
enablePreset=function(discipleguid,presetGuid)
socketManager:send_2_51(discipleguid,presetGuid)
end,
takeOff=function(discipleguid,presetGuid,switchIdx)
if switchIdx and switchIdx>0 then
local replaceEquipType=3
local pos=1
UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchIdx,replaceEquipType,pos)
else
fabaoProtocolControl.reqTakeoffFabao(discipleguid)
end
end,
},
[eEquipPresetType.eDaoBing]={
arrayIdxSplit={
ePresetGuidArrayIndex.eDaoBingHigh,
ePresetGuidArrayIndex.eDaoBingLow,
},
getGuid=function(discipleguid)
return getGuidFunc_CommonEquip(discipleguid,EQUIP_TYPE.eDaoBing)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_CommonEquip(discipleguid,EQUIP_TYPE.eDaoBing,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
local equip=bagModel.getItem(presetGuid)or daobingModel:getEquip(presetGuid)
if not equip then
return false
end
return daobingHelper.isCanDress(discipleguid,presetGuid)
end,
checkExist=function(discipleguid,presetGuid)
local equip=bagModel.getItem(presetGuid)or daobingModel:getEquip(presetGuid)
if not equip then
return false
end
return true
end,
getEquipedAttr=function(discipleguid)
return daobingModel:getDaoBingAttrsLookup(discipleguid)
end,
getPresetAttr=function(presetGuid)
local equip=bagModel.getItem(presetGuid)or daobingModel:getEquip(presetGuid)
if not equip then
return
end
return daobingHelper.getEquipAttrsLookupByItemguid(presetGuid,false)
end,
checkOtherUse=function(discipleguid,presetGuid)
local diziguid=daobingModel:getDiziguidByItemguid(presetGuid)
if not diziguid then
return
end
if not mathHelper.compareInt64(diziguid,discipleguid)then
local switchIdx=daobingModel:getEquipSwitchIdx(presetGuid)
return diziguid,switchIdx
end
end,
enablePreset=function(discipleguid,presetGuid)
daobingController.reqDress(discipleguid,presetGuid)
end,
takeOff=function(discipleguid,presetGuid,switchIdx)
if switchIdx and switchIdx>0 then
local replaceEquipType=4
local pos=1
UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchIdx,replaceEquipType,pos)
else
daobingController.reqTakeOff(discipleguid)
end
end,
},
[eEquipPresetType.eYuFu1]={
arrayIdxSplit={
ePresetGuidArrayIndex.eYuFu1High,
ePresetGuidArrayIndex.eYuFu1Low,
},
getGuid=function(discipleguid)
return getGuidFunc_YuFu(discipleguid,1)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_YuFu(discipleguid,1,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
return checkBanFunc_YuFu(discipleguid,presetGuid)
end,
checkExist=function(discipleguid,presetGuid)
return checkExistFunc_YuFu(discipleguid,presetGuid)
end,
getEquipedAttr=function(discipleguid)
return getEquipedAttrFunc_YuFu(discipleguid,1)
end,
getPresetAttr=function(presetGuid)
return getPresetAttrFunc_YuFu(presetGuid)
end,
checkOtherUse=function(discipleguid,presetGuid)
return checkOtherUseFunc_YuFu(discipleguid,presetGuid)
end,
enablePreset=function(discipleguid,presetGuid)
UIFullFuLuFangControl:reqEquipFuBao(discipleguid,presetGuid,1)
end,
takeOff=function(discipleguid,presetGuid,switchIdx)
if presetGuid then
if switchIdx and switchIdx>0 then
local isEquip,pos=UIFuLuFangModel:isEquipedOnDizi(discipleguid,presetGuid,switchIdx)
if isEquip then
local replaceEquipType=2
UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchIdx,replaceEquipType,pos)
end
else
local pos=UIFuLuFangModel:getEquipPos(discipleguid,presetGuid)
if pos>0 then
UIFullFuLuFangControl:reqUnEquipFuBao(discipleguid,pos)
end
end
else
UIFullFuLuFangControl:reqUnEquipFuBao(discipleguid,1)
end
end,
},
[eEquipPresetType.eYuFu2]={
arrayIdxSplit={
ePresetGuidArrayIndex.eYuFu2High,
ePresetGuidArrayIndex.eYuFu2Low,
},
getGuid=function(discipleguid)
return getGuidFunc_YuFu(discipleguid,2)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_YuFu(discipleguid,2,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
return checkBanFunc_YuFu(discipleguid,presetGuid)
end,
checkExist=function(discipleguid,presetGuid)
return checkExistFunc_YuFu(discipleguid,presetGuid)
end,
getEquipedAttr=function(discipleguid)
return getEquipedAttrFunc_YuFu(discipleguid,2)
end,
getPresetAttr=function(presetGuid)
return getPresetAttrFunc_YuFu(presetGuid)
end,
checkOtherUse=function(discipleguid,presetGuid)
return checkOtherUseFunc_YuFu(discipleguid,presetGuid)
end,
enablePreset=function(discipleguid,presetGuid)
UIFullFuLuFangControl:reqEquipFuBao(discipleguid,presetGuid,2)
end,
takeOff=function(discipleguid,presetGuid,switchIdx)
if presetGuid then
if switchIdx and switchIdx>0 then
local isEquip,pos=UIFuLuFangModel:isEquipedOnDizi(discipleguid,presetGuid,switchIdx)
if isEquip then
local replaceEquipType=2
UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchIdx,replaceEquipType,pos)
end
else
local pos=UIFuLuFangModel:getEquipPos(discipleguid,presetGuid)
if pos>0 then
UIFullFuLuFangControl:reqUnEquipFuBao(discipleguid,pos)
end
end
else
UIFullFuLuFangControl:reqUnEquipFuBao(discipleguid,2)
end
end,
},
[eEquipPresetType.eMount]={
arrayIdxSplit={
ePresetGuidArrayIndex.eMountHigh,
ePresetGuidArrayIndex.eMountLow,
},
getGuid=function(discipleguid)
return getGuidFunc_CommonEquip(discipleguid,EQUIP_TYPE.eMount)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_CommonEquip(discipleguid,EQUIP_TYPE.eMount,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
local equip=bagModel.getItem(presetGuid)or mountModel:getMount(presetGuid)
if not equip then
return false
end
local itemid=equip.itemid
return mountHelper.isCanDress(discipleguid,itemid)
end,
checkExist=function(discipleguid,presetGuid)
local equip=bagModel.getItem(presetGuid)or mountModel:getMount(presetGuid)
if not equip then
return false
end
return true
end,
getEquipedAttr=function(discipleguid)
return mountModel:getAttrsLookup(discipleguid)
end,
getPresetAttr=function(presetGuid)
local equip=bagModel.getItem(presetGuid)or mountModel:getMount(presetGuid)
if not equip then
return
end
local itemid=equip.itemid
return mountHelper.getAttrsLookupByItemguid(itemid)
end,
checkOtherUse=function(discipleguid,presetGuid)
local diziguid=mountModel:getDzguidByItemguid(presetGuid)
if not diziguid then
return
end
if not mathHelper.compareInt64(diziguid,discipleguid)then
return diziguid
end
end,
enablePreset=function(discipleguid,presetGuid)
mountController.reqDress(discipleguid,presetGuid)
end,
takeOff=function(discipleguid)
mountController.reqTakeOff(discipleguid)
end,
},
[eEquipPresetType.eDress]={
arrayIdxSplit={
ePresetGuidArrayIndex.eDressHigh,
ePresetGuidArrayIndex.eDressLow,
},
getGuid=function(discipleguid)
return getGuidFunc_CommonEquip(discipleguid,EQUIP_TYPE.eShiZhuang)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_CommonEquip(discipleguid,EQUIP_TYPE.eShiZhuang,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
local equip=bagModel.getItem(presetGuid)or ClothingModel:getEquip(presetGuid)
if not equip then
return false
end
local itemid=equip.itemid
return ClothingHelper.isCanDress(discipleguid,itemid)
end,
checkExist=function(discipleguid,presetGuid)
local equip=bagModel.getItem(presetGuid)or ClothingModel:getEquip(presetGuid)
if not equip then
return false
end
return true
end,
getEquipedAttr=function(discipleguid)
return ClothingModel:getClothingAttrsLookup(discipleguid)
end,
getPresetAttr=function(presetGuid)
local equip=bagModel.getItem(presetGuid)or ClothingModel:getEquip(presetGuid)
if not equip then
return
end
return ClothingHelper.getEquipAttrsLookupByItemguid(presetGuid,false)
end,
checkOtherUse=function(discipleguid,presetGuid)
local diziguid=ClothingModel:getDiziguidByItemguid(presetGuid)
if not diziguid then
return
end
if not mathHelper.compareInt64(diziguid,discipleguid)then
local switchIdx=ClothingModel:getEquipSwitchIdx(presetGuid)
return diziguid,switchIdx
end
end,
enablePreset=function(discipleguid,presetGuid)
ClothingController.req_2_122(discipleguid,presetGuid)
end,
takeOff=function(discipleguid,presetGuid,switchIdx)
if switchIdx and switchIdx>0 then
local replaceEquipType=6
local pos=1
UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchIdx,replaceEquipType,pos)
else
ClothingController.req_2_123(discipleguid)
end
end,
},
[eEquipPresetType.eVocEquip]={
arrayIdxSplit={
ePresetGuidArrayIndex.eVocEquipHigh,
ePresetGuidArrayIndex.eVocEquipLow,
},
getGuid=function(discipleguid)
return getGuidFunc_CommonEquip(discipleguid,EQUIP_TYPE.eVocEquip)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_CommonEquip(discipleguid,EQUIP_TYPE.eVocEquip,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
local equip=bagModel.getItem(presetGuid)or vocEquipModel:getEquip(presetGuid)
if not equip then
return false
end
local itemid=equip.itemid
return vocEquipHelper.isCanDress(discipleguid,itemid)
end,
checkExist=function(discipleguid,presetGuid)
local equip=bagModel.getItem(presetGuid)or vocEquipModel:getEquip(presetGuid)
if not equip then
return false
end
return true
end,
getEquipedAttr=function(discipleguid)
return vocEquipModel:getVocEquipAttrsLookup(discipleguid)
end,
getPresetAttr=function(presetGuid)
local equip=bagModel.getItem(presetGuid)or vocEquipModel:getEquip(presetGuid)
if not equip then
return
end
return vocEquipHelper.getVocEquipAllAttrsLookupByItemguid(presetGuid)
end,
checkOtherUse=function(discipleguid,presetGuid)
local diziguid=vocEquipModel:getDiziguidByItemguid(presetGuid)
if not diziguid then
return
end
if not mathHelper.compareInt64(diziguid,discipleguid)then
local switchIdx=vocEquipModel:getEquipSwitchIdx(presetGuid)
return diziguid,switchIdx
end
end,
enablePreset=function(discipleguid,presetGuid)
vocEquipController.req_vocEquip_put_on(discipleguid,presetGuid)
end,
takeOff=function(discipleguid,presetGuid,switchIdx)
if switchIdx and switchIdx>0 then
local replaceEquipType=7
local pos=1
UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchIdx,replaceEquipType,pos)
else
vocEquipController.req_vocEquip_take_off(discipleguid)
end
end,
},
[eEquipPresetType.eGongFa1]={
arrayIdx=ePresetGuidArrayIndex.eGongFa1,
getGuid=function(discipleguid)
return getGuidFunc_GongFa(discipleguid,1)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_GongFa(discipleguid,1,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
return checkBanFunc_GongFa(discipleguid,1,presetGuid)
end,
checkExist=function(discipleguid,presetGuid)
return checkExistFunc_GongFa(discipleguid,presetGuid)
end,
enablePreset=function(discipleguid,presetGuid)
UIDiscipleController:requireDiscipleSetupGF(discipleguid,1,presetGuid)
end,
takeOff=function(discipleguid)
UIDiscipleController:requireDiscipleSetupGF(discipleguid,1,0)
end,
},
[eEquipPresetType.eGongFa2]={
arrayIdx=ePresetGuidArrayIndex.eGongFa2,
getGuid=function(discipleguid)
return getGuidFunc_GongFa(discipleguid,2)
end,
checkSame=function(discipleguid,presetGuid)
return checkSameFunc_GongFa(discipleguid,2,presetGuid)
end,
checkBan=function(discipleguid,presetGuid)
return checkBanFunc_GongFa(discipleguid,2,presetGuid)
end,
checkExist=function(discipleguid,presetGuid)
return checkExistFunc_GongFa(discipleguid,presetGuid)
end,
enablePreset=function(discipleguid,presetGuid)
UIDiscipleController:requireDiscipleSetupGF(discipleguid,2,presetGuid)
end,
takeOff=function(discipleguid)
UIDiscipleController:requireDiscipleSetupGF(discipleguid,2,0)
end,
},
}









function discipleEquipPresetController:onAppStart()
end

function discipleEquipPresetController:onEnterState(isReconnect)
if isReconnect then
return
end
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.on_disciple_remove)
end

function discipleEquipPresetController:onLeaveState(isReconnect)
if isReconnect then
return
end
notifySystem:removelistener(notifyConfig.onDiscipleRemove,self.on_disciple_remove)
_guidArray=nil
_arrayIndexPool=nil
_totalPresetNum=nil
_presetNameLookup=nil
_spDzGuidIdxStrLookup=nil
end

function discipleEquipPresetController:onProtocolReq(isReconnect)
self:initEquipPresetJsonData()
self:initEquipPresetMaxNum()
end


function discipleEquipPresetController.on_disciple_remove(type,discipleguid)
local discipleguidStr=tostring(discipleguid)
local jsonData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eEquipPreset)or{}
local isChangeJson=false
local removeFunc=function(idxStr)
if _presetNameLookup and _presetNameLookup[idxStr]then
_presetNameLookup[idxStr]=nil
end
if jsonData[idxStr]then
isChangeJson=true
local presetDataList=jsonData[idxStr]
for _,presetData in ipairs(presetDataList)do
local arrayIndex=presetData.arrayIndex
for _,idx in pairs(arrayIndex)do
discipleEquipPresetController:recyclePresetGuidArrayIndex(idx)
end
end
_totalPresetNum=_totalPresetNum-#presetDataList
jsonData[idxStr]=nil
end
end

if _spDzGuidIdxStrLookup[discipleguidStr]then
local idxStrList=_spDzGuidIdxStrLookup[discipleguidStr]
for dzIdStr,idxStr in pairs(idxStrList)do
removeFunc(idxStr)
end
_spDzGuidIdxStrLookup[discipleguidStr]=nil
else
local idxStr=discipleguidStr
removeFunc(idxStr)
end

if isChangeJson then
serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eEquipPreset,jsonData)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.EquipPresetArrayIndexPool,#_arrayIndexPool,_arrayIndexPool)
end
end

function discipleEquipPresetController.initEquipPresetGuidData(len,arr)
_guidArray=arr or{}
end

function discipleEquipPresetController.initEquipPresetArrayIndexPool(len,arr)
_arrayIndexPool=arr or{}
end


function discipleEquipPresetController:initEquipPresetMaxNum()
local presetLimitNum=cfg_globalconfig_get(1).presetLimitNum
disciplePresetMax=presetLimitNum[1]
totalPresetMax=presetLimitNum[2]
end

function discipleEquipPresetController:initEquipPresetJsonData()
_totalPresetNum=0
_presetNameLookup={}
_spDzGuidIdxStrLookup={}
local jsonData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eEquipPreset)or defaultT

for idxStr,presetDataList in pairs(jsonData)do
local idxParam=string.split(idxStr,'_')
local discipleguidStr=idxParam[1]
local dzIdStr=idxParam[2]
if dzIdStr then
if not _spDzGuidIdxStrLookup[discipleguidStr]then
_spDzGuidIdxStrLookup[discipleguidStr]={}
end
local list=_spDzGuidIdxStrLookup[discipleguidStr]
list[dzIdStr]=idxStr
end
_presetNameLookup[idxStr]={}
_totalPresetNum=_totalPresetNum+#presetDataList
for _,presetData in ipairs(presetDataList)do
local name=presetData.presetName
_presetNameLookup[idxStr][name]=true
end
end
end

function discipleEquipPresetController:changePresetNameExisted(discipleguid,name,isAdd)
local discipleguidStr=tostring(discipleguid)
local idxStr=discipleguidStr
local isSPdz=UIDiscipleModel:isSPDiscipleEx(discipleguid)
if isSPdz then
local dzId=UIDiscipleModel:getDiscipleID(discipleguid)
idxStr=string.format("%s_%s",discipleguidStr,dzId)
end
if isAdd then
if not _presetNameLookup[idxStr]then
_presetNameLookup[idxStr]={}
end
_presetNameLookup[idxStr][name]=true
else
if _presetNameLookup[idxStr]then
_presetNameLookup[idxStr][name]=nil
end
end
end


function discipleEquipPresetController:getDiscipleEquipPresetNum(discipleguid)
local discipleguidStr=tostring(discipleguid)
local idxStr=discipleguidStr
local isSPdz=UIDiscipleModel:isSPDiscipleEx(discipleguid)
if isSPdz then
local dzId=UIDiscipleModel:getDiscipleID(discipleguid)
idxStr=string.format("%s_%s",discipleguidStr,dzId)
end
local jsonData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eEquipPreset)or defaultT
local presetDataList=jsonData[idxStr]or defaultT
return#presetDataList
end

function discipleEquipPresetController:getTotalEquipPresetNum()
return _totalPresetNum
end

function discipleEquipPresetController:getEquipPresetMaxNum()
return disciplePresetMax,totalPresetMax
end

function discipleEquipPresetController:checkPresetNameExisted(discipleguid,name)
local discipleguidStr=tostring(discipleguid)
local idxStr=discipleguidStr
local isSPdz=UIDiscipleModel:isSPDiscipleEx(discipleguid)
if isSPdz then
local dzId=UIDiscipleModel:getDiscipleID(discipleguid)
idxStr=string.format("%s_%s",discipleguidStr,dzId)
end
if _presetNameLookup and _presetNameLookup[idxStr]then
return _presetNameLookup[idxStr][name]==true
end
return false
end


function discipleEquipPresetController:getDiscipleEquipPreset(discipleguid)
local discipleguidStr=tostring(discipleguid)
local idxStr=discipleguidStr
local isSPdz=UIDiscipleModel:isSPDiscipleEx(discipleguid)
if isSPdz then
local dzId=UIDiscipleModel:getDiscipleID(discipleguid)
idxStr=string.format("%s_%s",discipleguidStr,dzId)
end

local jsonData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eEquipPreset)
if not jsonData then
return
end
return jsonData[idxStr]
end









function discipleEquipPresetController:savePresetGuidArray(guid,saveIdx)
if not _arrayIndexPool or not _guidArray then
return
end
if not saveIdx or type(saveIdx)=="userdata"or saveIdx<=0 or saveIdx>#_guidArray then
saveIdx=#_guidArray+1
if _arrayIndexPool and#_arrayIndexPool>0 then
saveIdx=table.remove(_arrayIndexPool)
end
end
_guidArray[saveIdx]=guid
return saveIdx
end

function discipleEquipPresetController:recyclePresetGuidArrayIndex(saveIdx)
if not _arrayIndexPool or not _guidArray then
return
end
if not saveIdx or type(saveIdx)=="userdata"or saveIdx<=0 or saveIdx>#_guidArray then
return
end
table.insert(_arrayIndexPool,saveIdx)
end








function discipleEquipPresetController:saveDiscipleEquipPreset(discipleguid,presetIdx,presetName)
if not _arrayIndexPool or not _guidArray then
return
end
local jsonData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eEquipPreset)or{}
local discipleguidStr=tostring(discipleguid)
local idxStr=discipleguidStr
local isSPdz=UIDiscipleModel:isSPDiscipleEx(discipleguid)
if isSPdz then
local dzId=UIDiscipleModel:getDiscipleID(discipleguid)
idxStr=string.format("%s_%s",discipleguidStr,dzId)

if not _spDzGuidIdxStrLookup[discipleguidStr]then
_spDzGuidIdxStrLookup[discipleguidStr]={}
end
local list=_spDzGuidIdxStrLookup[discipleguidStr]
local dzIdStr=tostring(dzId)
list[dzIdStr]=idxStr
end
if not jsonData[idxStr]then
jsonData[idxStr]={}
end
local presetDataList=jsonData[idxStr]
local isNew=false
if presetIdx then
if presetIdx<1 or presetIdx>disciplePresetMax then
return
end
local presetData=presetDataList[presetIdx]
if not presetData then
return
end
local arrayIndex=presetData.arrayIndex
for _,presetType in pairs(eEquipPresetType)do
local cfg=equipPresetCfg[presetType]or defaultT
if cfg.arrayIdxSplit then
local guidHigh32,guidLow32=cfg.getGuid(discipleguid)
local splitHighIndex,splitLowIndex=unpack(cfg.arrayIdxSplit)
local oldHighIdx=arrayIndex[splitHighIndex]
local oldLowIdx=arrayIndex[splitLowIndex]
if guidHigh32 and guidLow32 then
local highIdx=self:savePresetGuidArray(guidHigh32,oldHighIdx)
local lowIdx=self:savePresetGuidArray(guidLow32,oldLowIdx)
arrayIndex[splitHighIndex]=highIdx
arrayIndex[splitLowIndex]=lowIdx
else
self:recyclePresetGuidArrayIndex(oldHighIdx)
self:recyclePresetGuidArrayIndex(oldLowIdx)
arrayIndex[splitHighIndex]=0
arrayIndex[splitLowIndex]=0
end
elseif cfg.arrayIdx then
local guid=cfg.getGuid(discipleguid)
local oldIdx=arrayIndex[cfg.arrayIdx]
if guid then
local idx=self:savePresetGuidArray(guid,oldIdx)
arrayIndex[cfg.arrayIdx]=idx
else
self:recyclePresetGuidArrayIndex(oldIdx)
arrayIndex[cfg.arrayIdx]=0
end
end
end
presetData.arrayIndex=arrayIndex
else
if not presetName then
return
end
if#presetDataList>=disciplePresetMax then
return
end
if not _totalPresetNum or _totalPresetNum>=totalPresetMax then
return
end
if self:checkPresetNameExisted(presetName)then
return
end
presetIdx=#presetDataList+1
local arrayIndex={}
for _,presetType in pairs(eEquipPresetType)do
local cfg=equipPresetCfg[presetType]or defaultT
if cfg.arrayIdxSplit then
local guidHigh32,guidLow32=cfg.getGuid(discipleguid)
local splitHighIndex,splitLowIndex=unpack(cfg.arrayIdxSplit)
if guidHigh32 and guidLow32 then
local highIdx=self:savePresetGuidArray(guidHigh32)
local lowIdx=self:savePresetGuidArray(guidLow32)
arrayIndex[splitHighIndex]=highIdx
arrayIndex[splitLowIndex]=lowIdx
else
arrayIndex[splitHighIndex]=0
arrayIndex[splitLowIndex]=0
end
elseif cfg.arrayIdx then
local guid=cfg.getGuid(discipleguid)
if guid then
local idx=self:savePresetGuidArray(guid)
arrayIndex[cfg.arrayIdx]=idx
else
arrayIndex[cfg.arrayIdx]=0
end
end
end
presetDataList[presetIdx]={
presetName=presetName,
arrayIndex=arrayIndex,
}
self:changePresetNameExisted(discipleguid,presetName,true)
_totalPresetNum=_totalPresetNum+1
isNew=true
end

serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eEquipPreset,jsonData)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.EquipPreset,#_guidArray,_guidArray)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.EquipPresetArrayIndexPool,#_arrayIndexPool,_arrayIndexPool)
UIManager:invokeUIMethod("UIDiscipleMainWin","refreshPresetNum")
UIManager:invokeUIMethod("UIDiscipleEquipPresetWin","refreshDisciplePreset")
UIManager.info("保存配装方案成功")
if isNew and not newbieModel.isFinish(NEWBIE_LUA_FUNC_TYPE.EquipPresetSaveFunc)then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.EquipPresetSaveFunc)
end
end







function discipleEquipPresetController:removeDiscipleEquipPreset(discipleguid,presetIdx)
if not _arrayIndexPool or not _guidArray then
return
end
local jsonData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eEquipPreset)or{}
local discipleguidStr=tostring(discipleguid)
local idxStr=discipleguidStr
local isSPdz=UIDiscipleModel:isSPDiscipleEx(discipleguid)
if isSPdz then
local dzId=UIDiscipleModel:getDiscipleID(discipleguid)
idxStr=string.format("%s_%s",discipleguidStr,dzId)
end
if not jsonData[idxStr]then
return
end
local presetDataList=jsonData[idxStr]
if presetIdx<1 or presetIdx>disciplePresetMax then
return
end
local presetData=presetDataList[presetIdx]
if not presetData then
return
end
local arrayIndex=presetData.arrayIndex
for _,idx in pairs(arrayIndex)do
self:recyclePresetGuidArrayIndex(idx)
end
local presetName=presetData.presetName
self:changePresetNameExisted(discipleguid,presetName)
_totalPresetNum=_totalPresetNum-1
table.remove(presetDataList,presetIdx)
serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eEquipPreset,jsonData)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.EquipPresetArrayIndexPool,#_arrayIndexPool,_arrayIndexPool)
UIManager:invokeUIMethod("UIDiscipleMainWin","refreshPresetNum")
UIManager:invokeUIMethod("UIDiscipleEquipPresetWin","refreshDisciplePreset")
end








function discipleEquipPresetController:renameDiscipleEquipPreset(discipleguid,presetIdx,presetName)
if not _arrayIndexPool or not _guidArray then
return
end
if self:checkPresetNameExisted(discipleguid,presetName)then
return
end
local jsonData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eEquipPreset)or{}
local discipleguidStr=tostring(discipleguid)
local idxStr=discipleguidStr
local isSPdz=UIDiscipleModel:isSPDiscipleEx(discipleguid)
if isSPdz then
local dzId=UIDiscipleModel:getDiscipleID(discipleguid)
idxStr=string.format("%s_%s",discipleguidStr,dzId)
end
if not jsonData[idxStr]then
return
end
local presetDataList=jsonData[idxStr]
if presetIdx<1 or presetIdx>disciplePresetMax then
return
end
local presetData=presetDataList[presetIdx]
if not presetData then
return
end
local oldPresetName=presetData.presetName
self:changePresetNameExisted(discipleguid,oldPresetName)
presetData.presetName=presetName
self:changePresetNameExisted(discipleguid,presetName,true)

serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eEquipPreset,jsonData)
UIManager:invokeUIMethod("UIDiscipleEquipPresetWin","renameDisciplePresetCallback",discipleguid,presetIdx,presetName)
end










function discipleEquipPresetController:getDiscipleEquipPresetGuid(discipleguid,presetIdx,presetType)
if not _guidArray then
return
end
local jsonData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eEquipPreset)or defaultT
local discipleguidStr=tostring(discipleguid)
local idxStr=discipleguidStr
local isSPdz=UIDiscipleModel:isSPDiscipleEx(discipleguid)
if isSPdz then
local dzId=UIDiscipleModel:getDiscipleID(discipleguid)
idxStr=string.format("%s_%s",discipleguidStr,dzId)
end
local presetDataList=jsonData[idxStr]
if not presetDataList then
return
end
local presetData=presetDataList[presetIdx]
if not presetData then
return
end
local cfg=equipPresetCfg[presetType]
if not cfg then
return
end
local guidArrayIndex=presetData.arrayIndex
if cfg.arrayIdxSplit then
local splitHighIndex,splitLowIndex=unpack(cfg.arrayIdxSplit)
local highIdx=guidArrayIndex[splitHighIndex]
if not highIdx or type(highIdx)=="userdata"or highIdx<=0 then
return
end
local lowIdx=guidArrayIndex[splitLowIndex]
if not lowIdx or type(lowIdx)=="userdata"or lowIdx<=0 then
return
end
local guidHigh32=_guidArray[highIdx]
local guidLow32=_guidArray[lowIdx]
return mathHelper.concatToInt64(guidHigh32,guidLow32)
elseif cfg.arrayIdx then
local idx=guidArrayIndex[cfg.arrayIdx]
if not idx or type(idx)=="userdata"or idx<=0 then
return
end
return _guidArray[idx]
end
end








function discipleEquipPresetController:checkDiscipleEquipPresetSame(discipleguid,presetIdx,presetType)
if presetType then
local cfg=equipPresetCfg[presetType]
if not cfg then
return false
end
local presetGuid=self:getDiscipleEquipPresetGuid(discipleguid,presetIdx,presetType)
if cfg.checkSame then
return cfg.checkSame(discipleguid,presetGuid)
end
else
for _,presetType in pairs(eEquipPresetType)do
local cfg=equipPresetCfg[presetType]
local presetGuid=self:getDiscipleEquipPresetGuid(discipleguid,presetIdx,presetType)
if cfg and cfg.checkSame then
if not cfg.checkSame(discipleguid,presetGuid)then
return false
end
end
end
return true
end
end








function discipleEquipPresetController:checkDiscipleEquipPresetBan(discipleguid,presetIdx,presetType)
local cfg=equipPresetCfg[presetType]
if not cfg then
return true
end
local presetGuid=self:getDiscipleEquipPresetGuid(discipleguid,presetIdx,presetType)
if cfg.checkBan and presetGuid~=0 and mathHelper.validInt64(presetGuid)then
return cfg.checkBan(discipleguid,presetGuid)
end
return true
end








function discipleEquipPresetController:checkDiscipleEquipPresetExist(discipleguid,presetIdx,presetType)
local cfg=equipPresetCfg[presetType]
if not cfg then
return true
end
local presetGuid=self:getDiscipleEquipPresetGuid(discipleguid,presetIdx,presetType)
if cfg.checkExist and presetGuid~=0 and mathHelper.validInt64(presetGuid)then
return cfg.checkExist(discipleguid,presetGuid)
end
return true
end







function discipleEquipPresetController:getDisciplePresetAttrLookup(discipleguid,presetIdx)
local temp={}
for _,presetType in pairs(eEquipPresetType)do
local cfg=equipPresetCfg[presetType]
local presetGuid=self:getDiscipleEquipPresetGuid(discipleguid,presetIdx,presetType)
if cfg and cfg.getPresetAttr and presetGuid then
local attrLookup=cfg.getPresetAttr(presetGuid)or{}
temp=attrListHelper.concatLookup(temp,attrLookup)
end
end
return temp
end






function discipleEquipPresetController:getDiscipleEquipedAttrLookup(discipleguid)
local temp={}
for _,presetType in pairs(eEquipPresetType)do
local cfg=equipPresetCfg[presetType]
if cfg and cfg.getEquipedAttr then
local attrLookup=cfg.getEquipedAttr(discipleguid)or{}
temp=attrListHelper.concatLookup(temp,attrLookup)
end
end
return temp
end








function discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(discipleguid,presetIdx,presetType)
local cfg=equipPresetCfg[presetType]
if not cfg then
return false
end
local presetGuid=self:getDiscipleEquipPresetGuid(discipleguid,presetIdx,presetType)
if cfg.checkOtherUse and presetGuid then
local otherDiziguid=cfg.checkOtherUse(discipleguid,presetGuid)
return mathHelper.validInt64(otherDiziguid)
end
return false
end









function discipleEquipPresetController:getDiscipleEquipPresetOtherUse(discipleguid,presetIdx)
local temp={}
for _,presetType in pairs(eEquipPresetType)do
local cfg=equipPresetCfg[presetType]
local presetGuid=self:getDiscipleEquipPresetGuid(discipleguid,presetIdx,presetType)
if cfg and cfg.checkOtherUse and presetGuid then
local otherDiziguid,switchIdx=cfg.checkOtherUse(discipleguid,presetGuid)
if mathHelper.validInt64(otherDiziguid)then
table.insert(temp,{otherDiziguid,presetGuid,switchIdx})
end
end
end
return temp
end








function discipleEquipPresetController:enableDiscipleEquipPreset(discipleguid,presetIdx,isReplace)

local isLDLock=UIDiscipleModel:checkDZClientState(discipleguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
for _,presetType in pairs(eEquipPresetType)do
local cfg=equipPresetCfg[presetType]
local presetGuid=self:getDiscipleEquipPresetGuid(discipleguid,presetIdx,presetType)
if not mathHelper.validInt64(presetGuid)or presetGuid==0 then
cfg.takeOff(discipleguid)
end
if cfg.enablePreset and presetGuid then
if not cfg.checkBan or cfg.checkBan(discipleguid,presetGuid)then
if cfg.checkOtherUse then
local otherDiziguid,switchIdx=cfg.checkOtherUse(discipleguid,presetGuid)
if mathHelper.validInt64(otherDiziguid)then
if isReplace then
cfg.takeOff(otherDiziguid,presetGuid,switchIdx)
cfg.enablePreset(discipleguid,presetGuid)
end
else
cfg.enablePreset(discipleguid,presetGuid)
end
else
cfg.enablePreset(discipleguid,presetGuid)
end
end
end
end
timeEventController.delayDo(1,function()
UIManager:invokeUIMethod("UIDiscipleEquipPresetWin","refreshDisciplePreset")
UIManager:invokeUIMethod("UIDiscipleEquipPresetDetailWin","refreshDisciplePreset")
end)
UIManager:closeWindow("UIDiscipleEquipPresetEnableTipsWin")
UIManager.info("配装启用成功")
end






function discipleEquipPresetController:checkDiscipleEquipPresetAnyone(discipleguid)
for _,presetType in pairs(eEquipPresetType)do
local cfg=equipPresetCfg[presetType]or defaultT
if cfg.arrayIdxSplit then
local guidHigh32,guidLow32=cfg.getGuid(discipleguid)
if guidHigh32 and guidLow32 then
local guid=mathHelper.concatToInt64(guidHigh32,guidLow32)
if mathHelper.validInt64(guid)and guid~=0 then
return true
end
end
elseif cfg.arrayIdx then
local guid=cfg.getGuid(discipleguid)
if guid and guid~=0 then
return true
end
end
end
return false
end








function discipleEquipPresetController:setDiscipleEquipPresetEmpty(discipleguid,presetIdx,presetType)
if not _arrayIndexPool or not _guidArray then
return
end
local jsonData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eEquipPreset)or{}
local discipleguidStr=tostring(discipleguid)
local idxStr=discipleguidStr
local isSPdz=UIDiscipleModel:isSPDiscipleEx(discipleguid)
if isSPdz then
local dzId=UIDiscipleModel:getDiscipleID(discipleguid)
idxStr=string.format("%s_%s",discipleguidStr,dzId)
end
if not jsonData[idxStr]then
return
end
local presetDataList=jsonData[idxStr]
if presetIdx<1 or presetIdx>disciplePresetMax then
return
end
local presetData=presetDataList[presetIdx]
if not presetData then
return
end

local arrayIndex=presetData.arrayIndex

local cfg=equipPresetCfg[presetType]or defaultT
if cfg.arrayIdxSplit then
local splitHighIndex,splitLowIndex=unpack(cfg.arrayIdxSplit)
local oldHighIdx=arrayIndex[splitHighIndex]
local oldLowIdx=arrayIndex[splitLowIndex]
self:recyclePresetGuidArrayIndex(oldHighIdx)
self:recyclePresetGuidArrayIndex(oldLowIdx)
arrayIndex[splitHighIndex]=0
arrayIndex[splitLowIndex]=0
elseif cfg.arrayIdx then
local oldIdx=arrayIndex[cfg.arrayIdx]
self:recyclePresetGuidArrayIndex(oldIdx)
arrayIndex[cfg.arrayIdx]=0
end

presetData.arrayIndex=arrayIndex

serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eEquipPreset,jsonData)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.EquipPresetArrayIndexPool,#_arrayIndexPool,_arrayIndexPool)
UIManager:invokeUIMethod("UIDiscipleEquipPresetWin","refreshDisciplePresetByIdx",presetIdx)
UIManager:invokeUIMethod("UIDiscipleEquipPresetDetailWin","refreshDisciplePreset")
end
































