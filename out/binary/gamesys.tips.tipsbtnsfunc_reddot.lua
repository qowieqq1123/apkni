








function tipsBtnsFunc.activeGubaoReddot(btnType,itemid,itemguid,attach)

return true
end


function tipsBtnsFunc.lianhuaGubaoReddot(btnType,itemid,itemguid,attach)
local gbid=itemid
return gubaoModel:checkCanLianHua(gbid)
end


function tipsBtnsFunc.upstarGubaoReddot(btnType,itemid,itemguid,attach)
local gbid=itemid
return gubaoModel:checkCanUpStar(gbid)
end


function tipsBtnsFunc.awakeGubaoReddot(btnType,itemid,itemguid,attach)
local gbid=itemid
return gubaoModel:checkCanAwake(gbid)
end


function tipsBtnsFunc.checkUpFabo(btnType,itemid,itemguid,attach)
local reddot=false
if fabaoConfig.isBenMingFabao(itemid)then
reddot=benMingFaBaoHelper.canlxUp(itemguid)
end
if not reddot then
reddot=fabaoHelper.checkFabaoIsCanJiLian(itemguid)
end
return reddot
end


function tipsBtnsFunc.changeEquipReddot(btnType,itemid,itemguid,attach)
local diziguid=attach.diziguid
local equipType=equipsConfig.getEquipType(itemid)
if not diziguid or not equipType then
return false
end

local reddot=equipsReddotHelper.getBetterReddotByDZ(diziguid,equipType)
if itemsConfig.isDaoBing(itemid)then
if not systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)then
reddot=false
end

end

return reddot
end


function tipsBtnsFunc.jinglianEquipReddot(btnType,itemid,itemguid,attach)
return equipsHelper.checkEquipIsCanJingLian(itemguid)and(not equipsModel:isEquipChongzhu(itemguid))
end


function tipsBtnsFunc.chongzhuequipReddot(btnType,itemid,itemguid,attach)
return equipsModel:isEquipChongzhu(itemguid)
end


function tipsBtnsFunc.duandaequipReddot(btnType,itemid,itemguid,attach)
return equipsHelper.checkEquipIsCanJingLian(itemguid)or equipsModel.isReddotEquipNingLian(itemguid)
end


function tipsBtnsFunc.jinglianDaoBingReddot(btnType,itemid,itemguid,attach)
return daobingHelper.isCanJinglian(itemguid)
end


function tipsBtnsFunc.upStarDaoBingReddot(btnType,itemid,itemguid,attach)
return daobingHelper.isCanStar(itemguid,true)
end


function tipsBtnsFunc.XianBaoActive_Reddot(btnType,itemid,itemguid,attach)
return xianbaoModel:checkCanActive(itemid)
end


function tipsBtnsFunc.XianBaoUpStar_Reddot(btnType,itemid,itemguid,attach)
return xianbaoModel:checkUpStar(itemid)
end


function tipsBtnsFunc.XianBao_ZTP_CuiSHu_Reddot(btnType,itemid,itemguid,attach)
return xianbaoModel:checkXBEffectReddot(XianBaoEffectType.ZTP)
end

function tipsBtnsFunc.checkUpXianZhiXianBaoLevelReddot(btnType,itemid,itemguid,attach)
local state,lostInfo=xianzhiModel:checkCanUpXianBaoLevel()
return state
end

function tipsBtnsFunc.yunZhouComponentsStrengthenReddot(btnType,itemid,itemguid,attach)
if attach.yzId and attach.pos then
local item=XianYunGangModel:getYunZhouComponentsPosData(attach.yzId,attach.pos)
return yunZhouEquipsConfig.checkEquipIsCanJingLian(item)
end
return false
end


function tipsBtnsFunc.XianBao_DianFeng_shengji_Reddot(btnType,itemid,itemguid,attach)
return DianFengLevelController:checkShengJiReddot()
end

function tipsBtnsFunc.XianBao_DianFeng_dianhua_Reddot(btnType,itemid,itemguid,attach)
return DianFengLevelController:checkDianHuaReddot()
end


function tipsBtnsFunc.zhuanHuanLZ_Reddot(btnType,itemid,itemguid,attach)
return UIYuFuLingZhenControl:checkZhuanHuanLZReddot()
end


function tipsBtnsFunc.ZhiYeEquipZH_Reddot(btnType,itemid,itemguid,attach)
return vocEquipController:checkVocEquipZhuanHuanReddot()
end