






tipsBtnsFunc=simple_class(baseTipsBtnFunc)





function tipsBtnsFunc.useItem(btnType,itemid,itemguid,attach,tipsType,formType)


if not itemsLookup:checkUseItemCondition(itemid)then
return
end
local cfg=itemsConfig.getConfig(itemid)
local args=table.deepCopy(cfg.jump)
if args then
args.itemguid=itemguid
args.attach=attach
if formType and formType==TIPS_FORM_TYPE.eBagGrids then
args.needJumpBack=true
end
jumpManager:jump(args)
else
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
if cfg.funcparam and cfg.funcparam.num and item_funcparam_numIsUseCount_type[cfg.funcparam.type]then
num=cfg.funcparam.num
end

local call=function(ret)
if ret then
tipsManager.closeTips()
end
end

local endTime_Short=bagUseControl.getItemExpireTime(itemguid)
if cfg.funcparam.expire and endTime_Short>0 then
local contentStr=cfg.funcparam.expireStr or FMT.fmt("获得的限时道具将会跟{0}的时限保持一致",cfg.name)
local timeText="(剩余时间：{0})"
local showdata=
{
type='UIDialougeItemExpireTimeUpdate',
title='提示',
content=contentStr,
oktext='确定',
allowclickBG=true,
okcallback=function(...)

bagProtocolControl.req_use_item_by_itemguid(itemguid,num)
tipsManager.closeTips()
end,
showclosebtn=true,
endTime=endTime_Short,
timeText=timeText,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
bagUseControl.useSingleItem(itemid,num,call)
end
end
end


function tipsBtnsFunc.sellItem(btnType,itemid,itemguid,attach)
local func=function()

local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
bagProtocolControl.req_sell_item(itemguid,num)
tipsManager.closeTips()
end

if attach.sellDesc then
UIDialogManager.getConfirmDialog3(nil,attach.sellDesc,func)
else
func()
end
end


function tipsBtnsFunc.dressEquip(btnType,itemid,itemguid,attach)
local diziguid=attach.diziguid
if itemsConfig.isFabao(itemid)then
if not fabaoHelper.isCanDress(diziguid,itemid,itemguid,true)then return end
fabaoProtocolControl.reqDressFabao(diziguid,itemguid)
elseif itemsConfig.isEquip(itemid)then
if not equipsHelper.isCanDress(diziguid,itemid,itemguid,true)then return end
equipsProtocolControl.req_equip_dress(diziguid,itemguid)
elseif itemsConfig.isFubao(itemid)then




if UIFuLuFangModel.isCanDress(diziguid,itemid,true)then
UIFullFuLuFangControl:reqEquipFuBao(diziguid,itemguid,attach.pos)
end
elseif itemsConfig.isDaoBing(itemid)then
if not daobingHelper.isCanDress(diziguid,itemguid,true)then return end
daobingController.reqDress(diziguid,itemguid)
elseif itemsConfig.isMount(itemid)then
if not mountHelper.isCanDress(diziguid,itemid,true)then return end
mountController.reqDress(diziguid,itemguid)
elseif itemsConfig.isClothing(itemid)then
if not ClothingHelper.isCanDressEx(diziguid,itemguid,true)then return end
ClothingController.req_2_122(diziguid,itemguid)
elseif itemsConfig.isVocEquip(itemid)then
if not vocEquipHelper.isCanDressEx(diziguid,itemguid,true)then return end
vocEquipController.req_vocEquip_put_on(diziguid,itemguid)
end
end


function tipsBtnsFunc.replaceEquip(btnType,itemid,itemguid,attach)
local diziguid=attach.diziguid
local switchEquipTakeOffFunc=function(equipDzGuid,replaceEquipType,pos)
local switchidx=1
pos=pos or 1
UIDiscipleController:reqSwitchDataTakeOff(equipDzGuid,switchidx,replaceEquipType,pos)

end

if itemsConfig.isFabao(itemid)then
if not fabaoHelper.isCanDress(diziguid,itemid,itemguid,true)then return end
local equipedDiziguid=fabaoModel.getDiziguidByItemguid(itemguid)
local callback=function()
fabaoProtocolControl.reqTakeoffFabao(equipedDiziguid)
fabaoProtocolControl.reqDressFabao(diziguid,itemguid)
end
if equipedDiziguid then
if lundaodahuiModel:checkLockTips(equipedDiziguid)then
return
end
local switchidx=fabaoModel.getFabaoSwitchIdx(itemguid)or 0
local desc
if mathHelper.compareInt64(diziguid,equipedDiziguid)and switchidx>0 then
desc="该法宝已被该弟子的另一职业所装备，是否要替换？"
else
local discipleName=UIDiscipleModel:getDiscipleName(equipedDiziguid)
desc=FMT.fmt('该法宝已被<color=#ca631d>{0}</color>装备，是否要替换？',discipleName)
end

tipsBtnsFunc.dialog=UIDialogManager.getConfirmDialog(tipsBtnsFunc.dialog,'提示',desc)
tipsBtnsFunc.dialog.okcallback=function()
if switchidx==0 then
callback()
else
local replaceEquipType=3
switchEquipTakeOffFunc(equipedDiziguid,replaceEquipType,1)
fabaoProtocolControl.reqDressFabao(diziguid,itemguid)
end
end
tipsBtnsFunc.dialog:show()
else
callback()
end
elseif itemsConfig.isEquip(itemid)then
if not equipsHelper.isCanDress(diziguid,itemid,itemguid,true)then return end
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local selectEquipDiziguid=equipsModel.getDiziguidByItemguid(itemguid)
local callback=function()
equipsProtocolControl.req_equip_dress(diziguid,itemguid)
end


if diziguid and selectEquipDiziguid then
if lundaodahuiModel:checkLockTips(selectEquipDiziguid)then
return
end
local switchidx=equipsModel.getEquipSwitchIdx(itemguid)or 0
local desc
if mathHelper.compareInt64(diziguid,selectEquipDiziguid)and switchidx>0 then
desc="该装备已被该弟子的另一职业所装备，是否要替换？"
else
local discipleName=UIDiscipleModel:getDiscipleName(selectEquipDiziguid)
desc=FMT.fmt('该装备已被<color=#ca631d>{0}</color>装备，是否要替换？',discipleName)
end

tipsBtnsFunc.dialog=UIDialogManager.getConfirmDialog(tipsBtnsFunc.dialog,'提示',desc)
tipsBtnsFunc.dialog.okcallback=function()
if switchidx==0 then
equipsProtocolControl.req_equip_take_off(selectEquipDiziguid,equipType)
else
local replaceEquipType=1
switchEquipTakeOffFunc(selectEquipDiziguid,replaceEquipType,equipType)
end
callback()
end
tipsBtnsFunc.dialog:show()
return
else
loggerUtil.logErrFMT('此处无法脱下！道具id:{0} 装备弟子:{1}',itemid,tostring(diziguid))
end
callback()
elseif itemsConfig.isFubao(itemid)then




local selectEquipDiziguid=UIFuLuFangModel:getDzGuidByItemGuid(itemguid)
if lundaodahuiModel:checkLockTips(selectEquipDiziguid)then
return
end
local switchidx=UIFuLuFangModel:getSwitchidxByItemGuid(itemguid)or 0
local desc
if mathHelper.compareInt64(diziguid,selectEquipDiziguid)and switchidx>0 then
desc="该符宝已被该弟子的另一职业所装备，是否要替换？"
else
local discipleName=UIDiscipleModel:getDiscipleName(selectEquipDiziguid)
desc=FMT.fmt('该符宝已被<color=#ca631d>{0}</color>装备，是否要替换？',discipleName)
end

local replaceFuBaoDialogue
replaceFuBaoDialogue=UIDialogManager.getConfirmDialog(replaceFuBaoDialogue,'提示',desc)
replaceFuBaoDialogue.okcallback=function()
local isEquip,pos=UIFuLuFangModel:isEquipedOnDizi(selectEquipDiziguid,itemguid,switchidx)
if switchidx==0 then
UIFullFuLuFangControl:reqUnEquipFuBao(selectEquipDiziguid,pos)
else
local replaceEquipType=2
switchEquipTakeOffFunc(selectEquipDiziguid,replaceEquipType,pos)
end
UIFullFuLuFangControl:reqEquipFuBao(diziguid,itemguid,attach.pos)
end
replaceFuBaoDialogue:show()
elseif itemsConfig.isDaoBing(itemid)then
if not daobingHelper.isCanDress(diziguid,itemguid,true)then return end
local itemConfig=itemsConfig.getConfig(itemid)
local selectEquipDiziguid=daobingModel:getDiziguidByItemguid(itemguid)
local callback=function()
daobingController.reqDress(diziguid,itemguid)
end


if diziguid and selectEquipDiziguid then
if lundaodahuiModel:checkLockTips(selectEquipDiziguid)then
return
end

local switchidx=daobingModel:getEquipSwitchIdx(itemguid)or 0
local desc
if mathHelper.compareInt64(diziguid,selectEquipDiziguid)and switchidx>0 then
desc="该装备已被该弟子的另一职业所装备，是否要替换？"
else
local discipleName=UIDiscipleModel:getDiscipleName(selectEquipDiziguid)
desc=FMT.fmt('该装备已被<color=#ca631d>{0}</color>装备，是否要替换？',discipleName)
end
tipsBtnsFunc.dialog=UIDialogManager.getConfirmDialog(tipsBtnsFunc.dialog,'提示',desc)
tipsBtnsFunc.dialog.okcallback=function()
if switchidx==0 then
daobingController.reqTakeOff(selectEquipDiziguid)
else
local replaceEquipType=4
switchEquipTakeOffFunc(selectEquipDiziguid,replaceEquipType,1)
end
callback()
end
tipsBtnsFunc.dialog:show()
return
else
loggerUtil.logErrFMT('此处无法脱下！道具id:{0} 装备弟子:{1}',itemid,tostring(diziguid))
end
callback()
elseif itemsConfig.isMount(itemid)then
if not mountHelper.isCanDress(diziguid,itemid,true)then return end
local equip_dzguid=mountModel:getDzguidByItemguid(itemguid)
local callback=function()
mountController.reqDress(diziguid,itemguid)
end
local func=function()
mountController.reqTakeOff(equip_dzguid)
callback()
end
if diziguid and equip_dzguid and tostring(diziguid)~=equip_dzguid then
if lundaodahuiModel:checkLockTips(equip_dzguid)then
return
end
local discipleName=UIDiscipleModel:getDiscipleName(equip_dzguid)
local desc=FMT.fmt('该坐骑已被<color=#ca631d>{0}</color>装备，是否要替换？',discipleName)
tipsBtnsFunc.dialog=UIDialogManager.getConfirmDialog(tipsBtnsFunc.dialog,'提示',desc)
tipsBtnsFunc.dialog.okcallback=func
tipsBtnsFunc.dialog:show()
return
end
callback()
elseif itemsConfig.isClothing(itemid)then
if not ClothingHelper.isCanDress(diziguid,itemid,true)then return end
local itemConfig=itemsConfig.getConfig(itemid)
local selectEquipDiziguid=ClothingModel:getDiziguidByItemguid(itemguid)
local callback=function()
ClothingController.req_2_122(diziguid,itemguid)
end


if diziguid and selectEquipDiziguid then
if lundaodahuiModel:checkLockTips(selectEquipDiziguid)then
return
end

local switchidx=ClothingModel:getEquipSwitchIdx(itemguid)or 0
local desc
if mathHelper.compareInt64(diziguid,selectEquipDiziguid)and switchidx>0 then
desc="该时装已被该弟子的另一职业所装备，是否要替换？"
else
local discipleName=UIDiscipleModel:getDiscipleName(selectEquipDiziguid)
desc=FMT.fmt('该时装已被<color=#ca631d>{0}</color>装备，是否要替换？',discipleName)
end
tipsBtnsFunc.dialog=UIDialogManager.getConfirmDialog(tipsBtnsFunc.dialog,'提示',desc)
tipsBtnsFunc.dialog.okcallback=function()
if switchidx==0 then
ClothingController.req_2_123(selectEquipDiziguid)
else
local replaceEquipType=6
switchEquipTakeOffFunc(selectEquipDiziguid,replaceEquipType,1)
end
callback()
end
tipsBtnsFunc.dialog:show()
return
else
loggerUtil.logErrFMT('此处无法脱下！道具id:{0} 装备弟子:{1}',itemid,tostring(diziguid))
end
callback()
elseif itemsConfig.isVocEquip(itemid)then
if not vocEquipHelper.isCanDress(diziguid,itemid,true)then return end
local itemConfig=itemsConfig.getConfig(itemid)
local selectEquipDiziguid=vocEquipModel:getDiziguidByItemguid(itemguid)
local callback=function()
vocEquipController.req_vocEquip_put_on(diziguid,itemguid)
end


if diziguid and selectEquipDiziguid then
if lundaodahuiModel:checkLockTips(selectEquipDiziguid)then
return
end
local switchidx=vocEquipModel:getEquipSwitchIdx(itemguid)or 0
local desc
if mathHelper.compareInt64(diziguid,selectEquipDiziguid)and switchidx>0 then
desc="该职业装备已被该弟子的另一职业所装备，是否要替换？"
else
local discipleName=UIDiscipleModel:getDiscipleName(selectEquipDiziguid)
desc=FMT.fmt('该职业装备已被<color=#ca631d>{0}</color>装备，是否要替换？',discipleName)
end

tipsBtnsFunc.dialog=UIDialogManager.getConfirmDialog(tipsBtnsFunc.dialog,'提示',desc)
tipsBtnsFunc.dialog.okcallback=function()
if switchidx==0 then
vocEquipController.req_vocEquip_take_off(selectEquipDiziguid)
else
local replaceEquipType=7
switchEquipTakeOffFunc(selectEquipDiziguid,replaceEquipType,1)
end
callback()
end
tipsBtnsFunc.dialog:show()
return
else
loggerUtil.logErrFMT('此处无法脱下！道具id:{0} 装备弟子:{1}',itemid,tostring(diziguid))
end
callback()
end
end


function tipsBtnsFunc.jinglianEquip(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipJingLian,{itemguid=itemguid})
end


function tipsBtnsFunc.chongZhuEquip(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipChongZhu,{itemguid=itemguid})
end


function tipsBtnsFunc.openEquipGain(btnType,itemid,itemguid,attach)
if itemsConfig.isFubao(itemid)then
UIManager:showWindow('UIFuBaoGainWin',{diziguid=attach.diziguid,pos=attach.pos})
tipsManager.closeTips()
return
elseif itemsConfig.isYunZhouComponents(itemid)then
local callFunc=function()
UIManager:showWindow('UIYunZhouComponentsGainWin',{boat_id=attach.yzId,pos=attach.pos})
tipsManager.closeTips()
end
XianJunYanZhenModel:showXJYZUsedDialouge({boat_id=attach.yzId,callFunc=callFunc})
return
elseif itemsConfig.isVocEquip(itemid)then
UIManager:showWindow('UIVocEquipGainWin',{diziguid=attach.diziguid,})
tipsManager.closeTips()
return
end
local diziguid=attach.diziguid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
equipListManager.showTips({diziguid=diziguid,equipType=equipType,itemguid=itemguid})
end


function tipsBtnsFunc.openJilianWin(btnType,itemid,itemguid,attach)
tipsManager.closeTips()

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.fabaojilian,{itemguid=itemguid})
end


function tipsBtnsFunc.openLianhuaWin(btnType,itemid,itemguid,attach)
tipsManager.closeTips()

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.fabaolianhua,{itemguid=itemguid})

end

function tipsBtnsFunc.activeGubao(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
local gbid=itemid
gubaoController:doActive(gbid)
end

function tipsBtnsFunc.activeGubao2(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
local gbid=gubaoLookup:good2GuBao(itemid)
gubaoController:doActive(gbid)
end

function tipsBtnsFunc.lianhuaGubao(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
local gbid=itemid

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.gubaolianhua,{gbid=gbid})
end

function tipsBtnsFunc.upstarGubao(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
local gbid=itemid

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.gubaoupstar,{gbid=gbid})
end

function tipsBtnsFunc.awakeGubao(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
local gbid=itemid

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.gubaoawake,{gbid=gbid})
end


function tipsBtnsFunc.openHeChengLianhua(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
jumpManager:jump({id=202,args={itemid=itemid}})
end


function tipsBtnsFunc.giveDiscipleReward(btnType,itemid,itemguid,attach)
local discipleGuid=attach.disciple_guid

if UIDiscipleModel:getDiscipleBagCount(discipleGuid)>=cfgHelper.get2(cfg_globalconfig_get,1,'disciplebagnum')then
return UIManager.error("弟子储物袋无法收纳过多物品")
end

UIDiscipleController:requireGiveDiscipleReward(discipleGuid,{itemid})
tipsManager.closeTips()
end


function tipsBtnsFunc.takeDiscipleReward(btnType,itemid,itemguid,attach)

local can=systemModel.isOpen(SYSTEM_DEFINE.eTaskDiscipleReward)
if can==false then
return UIManager.error(systemModel.getOpenTips(SYSTEM_DEFINE.eTaskDiscipleReward))
end

local discipleGuid=attach.disciple_guid
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.loyal_conf then
local takeValue=itemCfg.loyal_conf[2]or 0

local nowLoyalty=UIDiscipleModel:getDiscipleLoyalty(discipleGuid)
if nowLoyalty<takeValue then
return UIManager.error('该名弟子忠诚度过低，无法进行收缴')
end
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eAutoTakeDiscipleReward)
if not check then

















local content=FMT.fmt("收缴此样物品将会降低弟子{0}点忠诚度，是否继续缴纳？",takeValue)
local okcallback=function()
UIDiscipleController:requireTaskDiscipleReward(discipleGuid,itemid)
tipsManager.closeTips()
end
UIDialogManager.getConfirmDialog3(nil,content,okcallback,REPEAT_TYPE.eAutoTakeDiscipleReward)
return
end

UIDiscipleController:requireTaskDiscipleReward(discipleGuid,itemid)
else
logErr(FMT.fmt("物品[{0}]不能被收缴",itemid))
end
tipsManager.closeTips()
end

function tipsBtnsFunc.lockEquip(btnType,itemid,itemguid,attach)
if itemsConfig.isFubao(itemid)then
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(itemguid)
if dzId then
UIFullFuLuFangControl:reqLockFuBao(itemguid,dzId)
else
UIFullFuLuFangControl:reqLockFuBao(itemguid,int64.zero)
end
elseif itemsConfig.isYunZhouComponents(itemid)then
bagProtocolControl.req_change_bag_item_lockflag(itemguid,false)
tipsManager.closeTips()
end
end

function tipsBtnsFunc.unlockEquip(btnType,itemid,itemguid,attach)
if itemsConfig.isFubao(itemid)then
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(itemguid)
if dzId then
UIFullFuLuFangControl:reqLockFuBao(itemguid,dzId)
else
UIFullFuLuFangControl:reqLockFuBao(itemguid,int64.zero)
end
elseif itemsConfig.isYunZhouComponents(itemid)then
bagProtocolControl.req_change_bag_item_lockflag(itemguid,true)
tipsManager.closeTips()
end
end


function tipsBtnsFunc.putFabaoMaterial(btnType,itemid,itemguid,attach)
local index=attach.index
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
local win=UIManager:findActiveWindow('UIFabaoBatchCreateWin')
if win then
win:putItem(index,itemid,itemguid,num)
else
UIManager:callWindowFunc('UIFabaoWin','putItem',index,itemid,itemguid,num)
end
end


function tipsBtnsFunc.dressFuBaoInBag(btnType,itemid,itemguid,attach)
UIFullDiscipleSelectControl:showDiscipleSelectWindow()
end


function tipsBtnsFunc.ePutLianhuaFabaoMaterial(btnType,itemid,itemguid,attach)
local index=attach.index
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
UIManager:callWindowFunc('UIFabaoLianhuaWin','putItem',index,itemid,itemguid,num)
tipsManager.closeTips()
end


function tipsBtnsFunc.ePutJilianFabaoMaterial(btnType,itemid,itemguid,attach)
local index=attach.index
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
UIManager:callWindowFunc('UIFabaoJilianWin','putItem',index,itemid,itemguid,num)
tipsManager.closeTips()
end


function tipsBtnsFunc.openSelectBox(btnType,itemid,itemguid,attach)
local cfg=itemsHelper:get_item_config(itemid)

if cfg then
local funcparam=table.weakCopy(cfg.funcparam)
funcparam.itemguid=itemguid
local selectNum=funcparam.num or 1
local useCount
if selectNum<=1 then

local itemCount=itemBagModel:getItemCountByItemID(itemid)
useCount=itemCount or 1
else

useCount=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
end
local data={funcparam=funcparam,useCount=useCount}
UIManager:showWindow("UIBoxSelectWin",data)
tipsManager.closeTips()
end
end


function tipsBtnsFunc.selectRecruitDisciple(btnType,itemid,itemguid,attach)
local cfg=itemsHelper:get_item_config(itemid)
local useCount=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
if cfg then
local funcparam=table.weakCopy(cfg.funcparam)
funcparam.itemguid=itemguid
funcparam.itemid=itemid
local data={funcparam=funcparam,useCount=useCount}
UIManager:showWindow("UIItemSelectRecruitDiscipleWin",data)
tipsManager.closeTips()
end
end


function tipsBtnsFunc.commonUseItem(btnType,itemid,itemguid,attach)
if attach.tipsCommonUseItemCB then
attach.tipsCommonUseItemCB(attach)
end
tipsManager.closeTips()
end


function tipsBtnsFunc.boxSelect(boxGuid,useCount,selectListLen,selectList)
if not boxGuid then
logErr('找不到宝箱的guid')
return
end

local itemData=bagModel.getItem(boxGuid)
local itemid=itemData.itemid
local cfg=itemsHelper:get_item_config(itemid)
local endTime_Short=bagUseControl.getItemExpireTime(boxGuid)
if cfg.funcparam.expire and endTime_Short>0 then
local isExpireTips=false
for k,v in ipairs(selectList)do
local itemCfg=itemsHelper:get_item_config(cfg.funcparam.itemList[v[1]][1])
if itemCfg.expire then
isExpireTips=true
break
end
end
if isExpireTips then
local contentStr=cfg.funcparam.expireStr or FMT.fmt("获得的限时道具将会跟{0}的时限保持一致",cfg.name)
local timeText="(剩余时间：{0})"
local showdata=
{
type='UIDialougeItemExpireTimeUpdate',
title='提示',
content=contentStr,
oktext='确定',
allowclickBG=true,
okcallback=function(...)
bagProtocolControl.req_1_17(boxGuid,useCount,selectListLen,selectList)
tipsManager.closeTips()
end,
showclosebtn=true,
endTime=endTime_Short,
timeText=timeText,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
bagProtocolControl.req_1_17(boxGuid,useCount,selectListLen,selectList)
tipsManager.closeTips()
end
else
bagProtocolControl.req_1_17(boxGuid,useCount,selectListLen,selectList)
tipsManager.closeTips()
end
end


function tipsBtnsFunc.takeOffEquip(btnType,itemid,itemguid,attach)
if itemsConfig.isFabao(itemid)then
local diziguid=fabaoModel.getDiziguidByItemguid(itemguid)
fabaoProtocolControl.reqTakeoffFabao(diziguid)
elseif itemsConfig.isEquip(itemid)then
local diziguid=equipsModel.getDiziguidByItemguid(itemguid)
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
equipsProtocolControl.req_equip_take_off(diziguid,equipType)
elseif itemsConfig.isFubao(itemid)then
local diziguid=UIFuLuFangModel:getDzGuidByItemGuid(itemguid)
local isEquip,pos=UIFuLuFangModel:isEquipedOnDizi(diziguid,itemguid)
UIFullFuLuFangControl:reqUnEquipFuBao(diziguid,pos)
elseif itemsConfig.isDaoBing(itemid)then
local diziguid=daobingModel:getDiziguidByItemguid(itemguid)
daobingController.reqTakeOff(diziguid)
elseif itemsConfig.isMount(itemid)then
local diziguid=mountModel:getDzguidByItemguid(itemguid)
mountController.reqTakeOff(diziguid)
elseif itemsConfig.isClothing(itemid)then
local diziguid=ClothingModel:getDiziguidByItemguid(itemguid)
ClothingController.req_2_123(diziguid)
elseif itemsConfig.isYunZhouComponents(itemid)then
local boat_id=attach.yzId
local itemConfig=itemsConfig.getConfig(itemid)
local pos=itemConfig.type1

local callFunc=function()
XianYunGangController.reqYunZhouComponentsTakeOff(boat_id,pos)
tipsManager.closeTips()
end
XianJunYanZhenModel:showXJYZUsedDialouge({boat_id=boat_id,callFunc=callFunc})
return
elseif itemsConfig.isVocEquip(itemid)then
local diziguid=vocEquipModel:getDiziguidByItemguid(itemguid)
vocEquipController.req_vocEquip_take_off(diziguid)
end
tipsManager.closeTips()
end


function tipsBtnsFunc.takeOffFabaoMaterial(btnType,itemid,itemguid,attach)
local index=attach.index
local win=UIManager:findActiveWindow('UIFabaoBatchCreateWin')
if win then
local planIndex=attach.planIndex
win:takeOffByTips(planIndex,index,itemid)
else
UIManager:callWindowFunc('UIFabaoWin','takeOffByTips',index,itemid,itemguid)
tipsManager.closeTips()
end
end

function tipsBtnsFunc.takeOffYUHuo(btnType,itemid,itemguid,attach)
local count=1
if attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum then
count=attach.selectNumCmpArgs.selectNum
end
UIManager:callWindowFunc('UIAquariumBagWin','moveItemToSell',attach.index,count)
tipsManager.closeTips()
end

function tipsBtnsFunc.getBackYuHuo(btnType,itemid,itemguid,attach)
local count=1
if attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum then
count=attach.selectNumCmpArgs.selectNum
end
UIManager:callWindowFunc('UIAquariumBagWin','moveSellToBag',attach.index,count)
tipsManager.closeTips()
end

function tipsBtnsFunc.yuhuoBuy(btnType,itemid,itemguid,attach)
local count=1
if attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum then
count=attach.selectNumCmpArgs.selectNum
end
UIManager:callWindowFunc('UIAquariumShopWin','handleBuy',attach.index,count)
tipsManager.closeTips()
end

function tipsBtnsFunc.lingZhenCombine(btnType,itemid,itemguid,attach)
attach=attach or{}
local yfguid=attach.yfguid
local kongIndex=attach.kongIndex
UIManager:callWindowFunc('UIYFLZCombineWin','putInItem',itemguid,yfguid,kongIndex)
tipsManager.closeTips()
end

function tipsBtnsFunc.yuFuZhenTu(btnType,itemid,itemguid,attach)
UIYuFuLingZhenControl:showMainWin({itemId=itemid,itemGuid=itemguid})
tipsManager.closeTips()
end


function tipsBtnsFunc.yuer(btnType,itemid,itemguid,attach)


local win=UIManager:findActiveWindow('YYHYGainWin')
if win then
YiYuHuiYouModel:setXianLuId(itemid)
UIManager:callWindowFunc('YYHYSelectWin','refreshFBYuErSlot')

UIManager:callWindowFunc('YYHYGainWin','onCloseClick')
else

UIManager.error('以渔会友活动尚未开启，敬请期待')
end
tipsManager.closeTips()
end


function tipsBtnsFunc.yuerxiexia(btnType,itemid,itemguid,attach)
local win=UIManager:findActiveWindow('YYHYGainWin')
if win then
YiYuHuiYouModel:setXianLuId(0)
UIManager:callWindowFunc('YYHYSelectWin','refreshFBYuErSlot')
UIManager:callWindowFunc('YYHYGainWin','onCloseClick')
else
UIManager.error('以渔会友活动尚未开启，敬请期待')
end
tipsManager.closeTips()
end


function tipsBtnsFunc.fenJieFuBao(btnType,itemid,itemguid,attach)
jumpManager:jump({id=2302})
end


function tipsBtnsFunc.GetWay(btnType,itemid,itemguid,attach,tipsType,formType)
if tipsType==TIPS_TYPE.eCommonGubao and formType~=TIPS_FORM_TYPE.eGubaoCheck then
local gbid=itemid
gainControl:showCommonGainWin_gubao(gbid)
elseif tipsType==TIPS_TYPE.eCommonXianBao then
local xbItemId=attach.xbItemId
gainControl:showCommonGainWin_item(xbItemId)
else
gainControl:showCommonGainWin_item(itemid)
end
tipsManager.closeTips()
end


function tipsBtnsFunc.askforNPC(btnType,itemid,itemguid,attach,tipsType,formType)
local askforNPCData=attach.askforNPCData
local otherData={}
otherData.interacttype=NPC_INTERACT_TYPE.eAskfor
otherData.guid=askforNPCData[2]
npcController:askforNPC(askforNPCData[1],otherData)
tipsManager.closeTips()
end


function tipsBtnsFunc.stealNPC(btnType,itemid,itemguid,attach,tipsType,formType)
local stealNPCData=attach.stealNPCData
local otherData={}
otherData.interacttype=NPC_INTERACT_TYPE.eSteal
otherData.guid=stealNPCData[2]
npcController:stealNPC(stealNPCData[1],otherData)
tipsManager.closeTips()
end


function tipsBtnsFunc.buy(btnType,itemid,itemguid,attach,tipsType,formType)
local buycallBack=attach.buycallBack
if buycallBack then
buycallBack()
end
tipsManager.closeTips()
end


function tipsBtnsFunc.personAuctionSellItem(btnType,itemid,itemguid,attach,tipsType,formType)

local item=bagModel.getItem(itemguid)
local isLock=bagHelper.isLock(item)
if isLock then
UIManager.error("道具已锁定，无法寄售")
return
end
if itemsConfig.isFubao(itemid)then
local data=UIYuFuLingZhenControl:getLingZhenData(itemguid)
if data and data.zhentuId~=0 then
UIManager.error("激活阵图与镶嵌灵阵的玉符无法寄售")
return
end
end

local isInCd=bagUseControl.isItemInAuctionSellCd(itemguid)
if isInCd then
UIManager.error("寄售锁定期内，无法寄售")
return
end


local price=attach.auctionSellPrice
if not price or price==0 then
UIManager.error("未输入此物品的寄售价格")
return
end


if not auctionController:checkEnoughPaySellCost(price,true)then
return tipsManager.closeTips()
end


if auctionModel:checkPersonAuctionSellMax()then
UIManager.error("您寄售的商品数量已达上限")
return
end





local anonymousMark=attach.isAnonymous and 1 or 0
local auctionPwd=nil
auctionController:reqPersonAuctionGrounding(itemguid,1,price,auctionPwd,anonymousMark)

tipsManager.closeTips()
end


function tipsBtnsFunc.personAuctionReSellItem(btnType,itemid,itemguid,attach,tipsType,formType)

local isInCd=bagUseControl.isItemInAuctionSellCd(itemguid)
if isInCd then
UIManager.error("寄售锁定期内，无法寄售")
return
end
if itemsConfig.isFubao(itemid)then
local data=UIYuFuLingZhenControl:getLingZhenData(itemguid)
if data and data.zhentuId~=0 then
UIManager.error("激活阵图与镶嵌灵阵的玉符无法寄售")
return
end
end

local price=attach.auctionSellPrice
if not price or price==0 then
UIManager.error("未输入此物品的寄售价格")
return
end


if not auctionController:checkEnoughPaySellCost(price,true)then
return tipsManager.closeTips()
end


if auctionModel:checkPersonAuctionSellMax(true)then
UIManager.error("您寄售的商品数量已达上限")
return
end





local anonymousMark=attach.isAnonymous and 1 or 0
local auctionPwd=nil
local auctionSeries=attach.auctionSeries
auctionController:reqPersonAuctionGroundingAgain(auctionSeries,price,auctionPwd,anonymousMark)

tipsManager.closeTips()
end


function tipsBtnsFunc.jinglianDaoBing(btnType,itemid,itemguid,attach)
UIManager:showWindow('UIDaoBingUpWin',{tabType=SEC_FULL_TAB_TYPE.daobingjinglian,itemguid=itemguid})
tipsManager.closeTips()
end


function tipsBtnsFunc.upStarDaoBing(btnType,itemid,itemguid,attach)
UIManager:showWindow('UIDaoBingUpWin',{tabType=SEC_FULL_TAB_TYPE.daobingstar,itemguid=itemguid})
tipsManager.closeTips()
end


function tipsBtnsFunc.putFaBao(btnType,itemid,itemguid,attach)
local index=attach.index
UIManager:callWindowFunc('UIBenMingFabaoWin','onPutItem',itemguid,itemid,index)
UIManager:closeWindow('UICommonPageWin')
end


function tipsBtnsFunc.XMDG_Exchange(btnType,itemid,itemguid,attach)
if not xianmengdigongController:checkXMDGIsActive(true)then

return tipsManager.closeTips()
end

local args=attach.selectNumCmpArgs
local val=args.selectNum or 1
if val<=0 then
return
end

local moneyData=args.moneyData
local moneyType=moneyData.moneyType
local price=moneyData.cost*val
moneySystem:useMoney(moneyType,price,function()

xianmengdigongController:reqShopBuyGoods(itemid,val)
tipsManager.closeTips()
end,WARNING_TYPE.eWarning)
end

function tipsBtnsFunc.putFaBaoYuanPei(btnType,itemid,itemguid,attach)
local needlevel=itemsConfig.getConfig(itemid).level or 1
local curlevel=zongmenModel:getLevel()
if needlevel>curlevel then
UIManager.error('使用等级不足')
return
end
local index=attach.index
UIManager:callWindowFunc('UIBenMingFabaoWin','onPutYuanPei',itemguid,itemid)
UIManager:closeWindow('UICommonPageWin')
end

function tipsBtnsFunc.eUpFabao(btnType,itemid,itemguid,attach)
local isBenMingFabao=fabaoConfig.isBenMingFabao(itemid)
local showjl=fabaoHelper.isCanShowJilian(itemguid)
local tabType=isBenMingFabao and SEC_FULL_TAB_TYPE.fabaoBenMingInfo or
showjl and SEC_FULL_TAB_TYPE.fabaojilian or
SEC_FULL_TAB_TYPE.fabaolianhua
oneTabScreenController:openTabUI(tabType,{itemguid=itemguid})
tipsManager.closeTips()
end

function tipsBtnsFunc.daobingCombine(btnType,itemid,itemguid,attach)
local has=itemsModel.getCount(itemid)
local need=daobingConfig.getCombineCnt(itemid)
local cnt=math.floor(has/need)
if cnt<1 then
local name=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}不足，无法合成',name))
else
daobingController.reqCombine(itemid,cnt)
tipsManager.closeTips()
end
end

function tipsBtnsFunc.jumpXTCJWindow(btnType,itemid,itemguid,attach)
local lookup=cfgHelper.get1(cfg_lookupxiantuachieveconfig_get,itemid)
local subTab=lookup and lookup[1]or nil
jumpManager:jump({id=JUMP_TYPE.eXianTuChengJiu,args={tab=eXianTuChengJiuTabType.XianTuChengJiu,subTab=subTab}})
end


function tipsBtnsFunc.putWBXBDCompose(btnType,itemid,itemguid,attach)
local index=attach.index
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
UIManager:callWindowFunc('UIWanBaoXunBaoDui_EquipWin','putComposeItem',index,itemid,itemguid,num)
tipsManager.closeTips()
end


function tipsBtnsFunc.putWBXBDJingLian(btnType,itemid,itemguid,attach)
local index=attach.index
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
UIManager:callWindowFunc('UIWanBaoXunBaoDui_SelectItemsWin','putItem',index,itemid,itemguid,num)
tipsManager.closeTips()
end

function tipsBtnsFunc.jumpBuildSuitWin(btnType,itemid,itemguid,attach)
local bdId=zongmenBuildingSuitModel:findPartBuildingByItem(itemid)
local suit=nil
if bdId then
suit=zongmenBuildingSuitModel:findSuitIdByPartBuildID(bdId)
end
jumpManager:jump({id=JUMP_TYPE.eBuildSuit,args={suit=suit}})
end

function tipsBtnsFunc.changeEquip(btnType,itemid,itemguid,attach)
local diziguid=attach.diziguid
if itemsConfig.isMount(itemid)then
if not mountHelper.isCanDress(diziguid,itemid,true)then return end
local equip_dzguid=mountModel:getDzguidByItemguid(itemguid)
local func=function()
mountController.reqExchange(equip_dzguid,diziguid)
end
local discipleName=UIDiscipleModel:getDiscipleName(equip_dzguid)
local desc=FMT.fmt('该坐骑已被<color=#ca631d>{0}</color>装备，是否要互换？',discipleName)
tipsBtnsFunc.dialog=UIDialogManager.getConfirmDialog(tipsBtnsFunc.dialog,'提示',desc)
tipsBtnsFunc.dialog.okcallback=func
tipsBtnsFunc.dialog:show()
end
tipsManager.closeTips()
end


function tipsBtnsFunc.reqXMFXZY(btnType,itemid,itemguid,attach)
local config=cfgHelper.get1(cfg_guildaskforconfig_get,itemid)
if config and xianmengModel:checkConditions_fenxiangziyuan(config.condition,true)then
local cur=xianmengModel:getSeekTimes_fenxiangziyuan()
local max=cfgHelper.get2(cfg_guildbaseconfig_get,1,"askfor")
if cur then
if cur<max then
if xianmengModel:findOwnerDataSameTypeData_fenxiangziyuan(itemid)then
UIManager.error(FMT.fmt("本周已求助{0}，下周可再次求助",config.aftypeName))
else
UIManager:showWindow("UIXMFXZYSeekWin",{itemid=itemid})
tipsManager.closeTips()
end
else
local owners=xianmengModel:getShareOwnerSort_fenxiangziyuan()
if#owners>0 then
UIManager.error("发布求助数已达上限")
else
UIManager.error("本周求助次数已达上限")
end
end
end
end
end


function tipsBtnsFunc.openYuanPeiLianZhi(btnType,itemid,itemguid,attach)
jumpManager:jump({id=JUMP_TYPE.eBuilding,
args={type=SLG_SYSTEM_TYPE.eLianQiGe,
tabType=FULL_TAB_TYPE.eCreateBenMingFabao}},
nil,JUMP_BACK.eNoBack)
tipsManager.closeTips()
end


function tipsBtnsFunc.selectHuDaoFu(btnType,itemid,itemguid,attach)
local func=nil
if attach then
func=attach.hudaofuSelectFunc
end
if func then
func()
end
tipsManager.closeTips()
end

function tipsBtnsFunc.upStarClothing(btnType,itemid,itemguid,attach)
UIManager:showWindow('UIDiscipleShiZhuangStarWin',{tabType=SEC_FULL_TAB_TYPE.discipleClothingStarUp,itemguid=itemguid})
tipsManager.closeTips()
end

function tipsBtnsFunc.clothingOpen(btnType,itemid,itemguid,attach)
if not systemModel.isOpen(SYSTEM_DEFINE.eClothing)then
local str=systemModel.getOpenTips(SYSTEM_DEFINE.eClothing)
UIManager.info(str)
return
end
local diziguid
if itemguid then
diziguid=ClothingModel:getDiziguidByItemguid(itemguid)
end
if not diziguid then
diziguid=ClothingHelper.findDizi(itemid,true)
end
if diziguid then
oneTabScreenController:openUI(SEC_FULL_TYPE.discipleClothing,{guid=diziguid,sortType=eDiscipleSortType.eClothing,checkClothing=true})
end
tipsManager.closeTips()
end

function tipsBtnsFunc.mountOpen(btnType,itemid,itemguid,attach)
if not systemModel.isOpen(SYSTEM_DEFINE.eMount)then
local str=systemModel.getOpenTips(SYSTEM_DEFINE.eMount)
UIManager.info(str)
return
end
local diziguid=mountHelper.findDizi(true)
if diziguid then
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.dzMount,{guid=diziguid})
end
tipsManager.closeTips()
end


function tipsBtnsFunc.equipDianHua(btnType,itemid,itemguid,attach)
local sfId=mapIdType.zhufeng
local bdId=SLG_SYSTEM_TYPE.eBingGongFang
local datas=zongmenModel:getBuildingDataByBdId(sfId,bdId)
if#datas==0 then
local name=cfgHelper.get2(cfg_monijybuildconfig_get,bdId,'name')
UIManager.error(FMT.fmt('请先建造{0}',name))
return
end
local entityId=datas[1].entityId

local dzguid=equipsModel.getDiziguidByItemguid(itemguid)
if dzguid then
local args={}
args.disciple_guid=dzguid
local func=function(args_)
local guid=args_.disciple_guid
return UIFullDiscipleMainControl:myShowWindow({dis_guid=guid},FULL_TAB_TYPE.eDiscipleEquip)
end
fullScreenUI.setNextActiveUICallback(func,args)
end
UIFullBingGongChangControl:showDianHuaWindow({entityId=entityId,itemguid=itemguid})
tipsManager.closeTips()
end


function tipsBtnsFunc.equipResetDianHua(btnType,itemid,itemguid,attach)
local func=function()
equipsProtocolControl.req_equip_2_139(itemguid)
tipsManager.closeTips()
end
local desc='还原当前点化装备，将返还全部点化材料，\n是否还原？'
tipsBtnsFunc.dialog=UIDialogManager.getConfirmDialog(tipsBtnsFunc.dialog,'提示',desc)
tipsBtnsFunc.dialog.okcallback=func
tipsBtnsFunc.dialog:show()
end


function tipsBtnsFunc.auctionGuanZhu(btnType,itemid,itemguid,attach,tipsType,formType)
local serverType=attach.serverType
local auctionType=attach.auctionType
local auctionSeries=attach.auctionSeries
auctionModel:setAuctionItemGuanZhuState(serverType,auctionType,auctionSeries,true)

auctionModel:saveAuctionItemGuanZhuStateList_WBSH()

UIManager:callWindowFunc('UIWanBaoShangHui_auctionWin','refreshAuctionItemList_notReset')
tipsManager.closeTips()
end


function tipsBtnsFunc.auctionGuanZhuCancel(btnType,itemid,itemguid,attach,tipsType,formType)
local serverType=attach.serverType
local auctionType=attach.auctionType
local auctionSeries=attach.auctionSeries
auctionModel:setAuctionItemGuanZhuState(serverType,auctionType,auctionSeries,nil)

auctionModel:saveAuctionItemGuanZhuStateList_WBSH()

UIManager:callWindowFunc('UIWanBaoShangHui_auctionWin','refreshAuctionItemList_notReset')
tipsManager.closeTips()
end


function tipsBtnsFunc.takeOffZhenTuMaterial(btnType,itemid,itemguid,attach)
local index=attach.index
UIManager:callWindowFunc('UIYFLZCombineWin','takeOffByTips',itemid,itemguid)
tipsManager.closeTips()
end


function tipsBtnsFunc.chongZhuLZ(btnType,itemid,itemguid,attach)
attach=attach or{}
local yfguid=attach.yfguid
local kongIndex=attach.kongIndex
UIManager:showWindow("UILingzhenChongZhuWin",{itemguid=itemguid,yfguid=yfguid,kongIndex=kongIndex})
tipsManager.closeTips()
UIManager:closeWindow("UIYFLZSelectWin")
end

function tipsBtnsFunc.fenJieFenJie(btnType,itemid,itemguid,attach)
local mdata=lingzhenBagModel:getItem(itemguid)
local isEquiped=false
if not mdata then
isEquiped=true
end
if isEquiped then
UIManager.error("装备中无法分解")
return
end

if UIYuFuLingZhenControl:getItemLock(itemguid)then
UIManager.error("解锁状态下才能分解灵阵")
return
end

local callback=function()
UIYuFuLingZhenControl.req_2_109({itemguid})
tipsManager.closeTips()
end

local config=itemsConfig.getConfig(itemid)
local fenjieItems=config.fenjieItems
if not fenjieItems then return end
local str=FMT.fmt("(返还{0}个{1})",fenjieItems[1][2],itemsConfig.getItemName(fenjieItems[1][1]))

local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content='是否分解此灵阵？\n'..str,
okcb=callback,
})
dialog:show()

end

function tipsBtnsFunc.dressLZ(btnType,itemid,itemguid,attach)
jumpManager:jump({id=1300})
tipsManager.closeTips()
end

function tipsBtnsFunc.lockLZ(btnType,itemid,itemguid,attach)
attach=attach or{}
local yfguid=attach.yfguid
local kongIndex=attach.kongIndex
UIYuFuLingZhenControl.req_2_107(yfguid,itemguid,kongIndex,1)
tipsManager.closeTips()
end

function tipsBtnsFunc.unlockLZ(btnType,itemid,itemguid,attach)
attach=attach or{}
local yfguid=attach.yfguid
local kongIndex=attach.kongIndex
UIYuFuLingZhenControl.req_2_107(yfguid,itemguid,kongIndex,0)
tipsManager.closeTips()
end

function tipsBtnsFunc.heChengLZ(btnType,itemid,itemguid,attach)
attach=attach or{}
local yfguid=attach.yfguid
local kongIndex=attach.kongIndex
UIManager:showWindow("UIYFLZCombineWin",{putInItem={itemguid,yfguid,kongIndex}})
tipsManager.closeTips()
end

function tipsBtnsFunc.takeOffZhenTuMaterial2(btnType,itemid,itemguid,attach)
attach=attach or{}
local yfguid=attach.yfguid or int64.zero
local kongIndex=attach.kongIndex
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(yfguid)
if dzId then
UIYuFuLingZhenControl:reqLZXieXia(dzId,yfguid,1,{kongIndex})
end
tipsManager.closeTips()
end


function tipsBtnsFunc.refineWBXBDEquip(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
local catguid=attach and attach.catguid
UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiDZWindow({guid=itemguid,catguid=catguid})
end


function tipsBtnsFunc.disboardWBXDBEquip(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
if attach.catguid~=nil then
wanBaoXunBaoDuiController:reqRemoveEquipment(attach.catguid,1,itemguid)
else
logErr("wbxbd equip lose equip catguid")
end
end


function tipsBtnsFunc.OffFeiShengTaiMaterial(btnType,itemid,itemguid,attach)
local index=attach.index
UIManager:callWindowFunc('UISectionRepair_flyupward','takeOffByTips',index,itemid,itemguid)
tipsManager.closeTips()
end

function tipsBtnsFunc.PutFeiShengTaiMaterial(btnType,itemid,itemguid,attach)
local index=attach.index
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
UIManager:callWindowFunc('UISectionRepair_flyupward','putItem',index,itemid,itemguid,num)
end


function tipsBtnsFunc.OffAutoBuildMaterial(btnType,itemid,itemguid,attach)
local index=attach.index
UIManager:callWindowFunc('UIAutoBuildingLvlupWin','takeOffByTips',index,itemid,itemguid)
tipsManager.closeTips()
end

function tipsBtnsFunc.PutAutoBuildMaterial(btnType,itemid,itemguid,attach)
local index=attach.index
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
UIManager:callWindowFunc('UIAutoBuildingLvlupWin','putItem',index,itemid,itemguid,num)
end


function tipsBtnsFunc.XianBaoActive(btnType,itemid,itemguid,attach)
local flag,costitemId=xianbaoModel:checkCanActive(itemid)
if flag then
local costitem,costguid=bagControl.invokeFuncByItemId(costitemId,'getItemByItemID',costitemId)

xianbaoController.req_16_32(itemid,costguid)
tipsManager.closeTips()
else
UIManager.info("道具不足")
end
end


function tipsBtnsFunc.XianBaoUpStar(btnType,itemid,itemguid,attach)

UIManager:showWindow("UIXianBaoUpStarWin",{xbid=itemid})
tipsManager.closeTips()
end


function tipsBtnsFunc.XianBao_ZTP_CuiSHu(btnType,itemid,itemguid,attach)
if YiFangLingTianModel:GetISOpen()then
YiFangLingTianModel:JumpToCuiShu()
if xianbaoModel:checkXBEffectReddot(XianBaoEffectType.ZTP)then
UIManager.info("灵液已满，再不用来催熟灵植就浪费了")
end
else
UIManager.info("一方灵田未开启")
end
tipsManager.closeTips()
end


function tipsBtnsFunc.resetDiscipleFD(btnType,itemid,itemguid,attach)
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig.item then
UIManager.info("羽化升星的时装无法重置星级")
return
end



UIManager:showWindow("UIDiscipleFashionClothResetWin",{itemguid=itemguid,itemid=itemid,cb=function()
tipsManager.closeTips()
end})
end


function tipsBtnsFunc.equipDiaHua_Put(btnType,itemid,itemguid,attach)
if attach and attach.selectCB then
attach.selectCB(itemguid)
else
logErr("attch 装备点化 缺少选择 回调")
end
tipsManager.closeTips()
end


function tipsBtnsFunc.GuBaoUpLvInput(btnType,itemid,itemguid,attach)
local index=attach.index
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
UIManager:callWindowFunc('UIGuBaoLianHuaSelectWin','putItem',index,itemid,itemguid,num)
tipsManager.closeTips()
end


function tipsBtnsFunc.XMKFFPInput(btnType,itemid,itemguid,attach)
UIManager:callWindowFunc('UIXMCK_ZH_FP_Win','putItem',itemid,attach)
tipsManager.closeTips()
end


function tipsBtnsFunc.BagEquipRL(btnType,itemid,itemguid,attach)
local equip=bagModel.getItem(itemguid)
if equip and bagHelper.isLock(equip)then
UIManager.error('物品已锁定，无法熔炼')
return
end


local itemConfig=itemsConfig.getConfig(equip.itemid)
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(equip.itemid)
local isninglian=false
if isxmEquip>0 then
local ninglian_star=equipsModel.getNingLianStar(equip)
if ninglian_star>0 then
isninglian=true
end
end

local callback=function()
tipsManager.closeTips()
local item=itemsModel.getItem(itemguid)
local rlitems=equipsHelper.returnRonglianItems(item)










UIFullBaGuaLuControl:setRongLianGUID({itemguid},rlitems,false,true,true)

end
local str='是否确认熔炼选中的装备?'
if isxmEquip>0 then
local fenjie_rand_reward=equipsModel.getEquipXMFenJie(equip.itemid)
local _itemConfig=itemsConfig.getConfig(fenjie_rand_reward[3])
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
str=FMT.fmt("选中的装备为稀有的<color=#c82c2c>仙魔装备</color>\n分解会有概率获得{0}~{1}个<color=#c82c2c>【{2}】</color>\n是否确认熔炼？",fenjie_rand_reward[1],fenjie_rand_reward[2],_itemConfig.name)
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
str=FMT.fmt("选中的装备为稀有的<color=#c82c2c>仙魔装备</color>\n分解会有概率获得{0}~{1}个<color=#c82c2c>【{2}】</color>\n是否确认熔炼？",fenjie_rand_reward[1],fenjie_rand_reward[2],_itemConfig.name)
end
end
local showdata=
{
type='UIDialougeRongLian',
title='提示',
content=str,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
allowclickBG=true,
itemInfoList={equip},
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end


function tipsBtnsFunc.upXianZhiXianBaoLevel(btnType,itemid,itemguid,attach)
if systemModel.isOpen(SYSTEM_DEFINE.eXianZhi)then
UIFullXianTuChengJiuControl:showWindow_XianZhi({isOpenXianBaoPanel=true})
end
end


function tipsBtnsFunc.yunZhouComponentsCompose(btnType,itemid,itemguid,attach)
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eYunZhouComponentsCompose,{itemid=itemid,itemguid=itemguid,boat_id=attach.yzId,pos=attach.pos})
tipsManager.closeTips()
end


function tipsBtnsFunc.yunZhouComponentsStrengthen(btnType,itemid,itemguid,attach)
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eYunZhouComponentsStrengthen,{itemid=itemid,itemguid=itemguid,boat_id=attach.yzId,pos=attach.pos})
tipsManager.closeTips()
end


function tipsBtnsFunc.putAnyItem(btnType,itemid,itemguid,attach)
local index=attach.index
local formType=attach.formType
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
if formType==TIPS_FORM_TYPE.eYunZhouComposeBag then
UIManager:callWindowFunc('UIYunZhouComponentsStrengthenWin','putItem',itemguid,num)
tipsManager.closeTips()
elseif formType==TIPS_FORM_TYPE.eGubaoCheck then
UIManager:callWindowFunc('UISubAct_tianxuyishiGuBaoSelectWin','setSelectNum',itemguid,num,index,itemid)
tipsManager.closeTips()
elseif formType==TIPS_FORM_TYPE.eFaBaoMaterial then
UIManager:callWindowFunc('UISubAct_tianxuyishiFaBaoMaterialSelectWin','setSelectNum',itemguid,num,index,itemid)
tipsManager.closeTips()
elseif formType==TIPS_FORM_TYPE.eJGJZMaterial then
UIManager:callWindowFunc('UISubAct_tianxuyishiiJGJZSelectWin','setSelectNum',itemguid,num,index,itemid)
tipsManager.closeTips()
end
end


function tipsBtnsFunc.quickHeChengLZ(btnType,itemid,itemguid,attach)
attach=attach or{}
local yfguid=attach.yfguid
local kongIndex=attach.kongIndex
UIYuFuLingZhenControl.req_2_108(yfguid,kongIndex,true)
tipsManager.closeTips()
end


function tipsBtnsFunc.reuseItem(btnType,itemid,itemguid,attach)
local index=attach.index
local formType=attach.formType
bagProtocolControl.reqReuseItem(itemguid)
tipsManager.closeTips()
end


function tipsBtnsFunc.xianmoDuanDa(btnType,itemid,itemguid,attach)
tipsManager.closeTips()

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipJingLian,{itemguid=itemguid})
end


function tipsBtnsFunc.recycleGongFa(btnType,itemid,itemguid,attach)
local num=attach.selectNumCmpArgs and attach.selectNumCmpArgs.selectNum or 1
local gfID=gongfaLookup:checkGongfaPiece(itemid)
if gfID then
UIGongFaController:reqGongFaRecycle(gfID,itemid,num)
end
tipsManager.closeTips()
end


function tipsBtnsFunc.pushRefineBenMingFaBao(btnType,itemid,itemguid,attach)
























UIManager:invokeUIMethod("UIBenMingAgainRefineWin","pushBenMingFaBao",itemguid)
UIManager:invokeUIMethod("UICommonPageWin","onBtnClose")
tipsManager.closeTips()
end


function tipsBtnsFunc.putRefineMaterialFaBao(btnType,itemid,itemguid,attach)
local index=attach.index
UIManager:invokeUIMethod("UIBenMingAgainRefineWin","pushMaterialFaBao",index,itemguid)
UIManager:invokeUIMethod("UICommonPageWin","onBtnClose")

tipsManager.closeTips()
end


function tipsBtnsFunc.vocEquipStrengthen(btnType,itemid,itemguid,attach)
tipsManager.closeTips()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eVocEquipStrengthen,{itemguid=itemguid})
end


function tipsBtnsFunc.bagEquipMutipleSelect(btnType,itemid,itemguid,attach)
local index=attach.index
local itemInfo=attach.itemInfo
UIManager:invokeUIMethod("UIBagWin","onTipsSelectMutiple",index,itemInfo)
end

function tipsBtnsFunc.bagEquipMutipleNotSelect(btnType,itemid,itemguid,attach)
local index=attach.index
local itemInfo=attach.itemInfo
UIManager:invokeUIMethod("UIBagWin","onTipsNotSelectMutiple",index,itemInfo)
end


function tipsBtnsFunc.XianBao_DianFeng_shengji(btnType,itemid,itemguid,attach)
DianFengLevelController:showDFWin({flag=1})
tipsManager.closeTips()
end

function tipsBtnsFunc.XianBao_DianFeng_dianhua(btnType,itemid,itemguid,attach)
DianFengLevelController:showDFWin({flag=2})
tipsManager.closeTips()
end


function tipsBtnsFunc.zhuanHuanLZ(btnType,itemid,itemguid,attach)
attach=attach or{}
local yfguid=attach.yfguid
local kongIndex=attach.kongIndex

local zhuanHuanLZ_Reddot=userActorSetting.get('zhuanHuanLZ',false)
if not zhuanHuanLZ_Reddot then
userActorSetting.set('zhuanHuanLZ',true)
userActorSetting.flush()
end
UIManager:invokeUIMethod("UIYuFuLingZhenWin","refresh")
UIManager:showWindow("UILingzhenZhuanHuanWin",{itemguid=itemguid,yfguid=yfguid,kongIndex=kongIndex})
tipsManager.closeTips()
end


function tipsBtnsFunc.ZhiYeEquipZH(btnType,itemid,itemguid,attach)
if vocEquipController:checkVocEquipZHSystem()then
local equip=bagModel.getItem(itemguid)
if not equip then
equip=equipsHelper.getEquip(itemguid)
end
if equip and bagHelper.isLock(equip)then
UIManager.error('装备已锁定，无法转换')
return
end
local Reddot=userActorSetting.get('VocEquipZHReddot',false)
if not Reddot then
userActorSetting.set('VocEquipZHReddot',true)
userActorSetting.flush()

equipsControl.freshWindow('freshEquips')
end
vocEquipController:vocEquipZhuanHuanOpen(itemguid,itemid)
tipsManager.closeTips()
else
UIManager.info('系统暂未开放')
end
end
