




tipsManager=gameState.addListener({})

local _btnsHandlers=nil
local _bodysHandler=nil
local _cacheArgstable=nil
local _argsHandler={}
local _exbodysHandler=nil
local _midExbodysHandler=nil
local _tipsBodysHandler
local _effectHandlers
local _closeHandler
local _exArgsHandler


function tipsManager:onAppStart()

_btnsHandlers=
{
[TIPS_TYPE.eCommonItem]=tipsBtnManager.handleItem,
[TIPS_TYPE.eCommonMetrial]=tipsBtnManager.handleMetrial,
[TIPS_TYPE.eCommonEquip]=tipsBtnManager.handleEquip,
[TIPS_TYPE.eCommonFabao]=tipsBtnManager.handleFabao,
[TIPS_TYPE.eCommonFubao]=tipsBtnManager.handleFubao,
[TIPS_TYPE.eCommonGubao]=tipsBtnManager.handleGubao,
[TIPS_TYPE.eCommonDaoBing]=tipsBtnManager.handleDaoBing,
[TIPS_TYPE.eCommonGubaoMetrial]=tipsBtnManager.handleGubaoMetrial,
[TIPS_TYPE.eBaoXiangTipsItem]=tipsBtnManager.handleItem,
[TIPS_TYPE.eCommonFaBaoYuanPei]=tipsBtnManager.handleFaBaoYuanPei,
[TIPS_TYPE.eCommonYuHuoItem]=tipsBtnManager.handleYuhuo,
[TIPS_TYPE.eCommonYuHuoItemSP]=tipsBtnManager.handleYuhuo,
[TIPS_TYPE.eCommonMountItem]=tipsBtnManager.handleMount,
[TIPS_TYPE.eBuildingSuitItem]=tipsBtnManager.handleBuildingSuitItem,
[TIPS_TYPE.eCommonWBXBDItem]=tipsBtnManager.handleWBXBDItem,
[TIPS_TYPE.eCommonWBXBDEquip]=tipsBtnManager.handleWBXBDEquip,
[TIPS_TYPE.eYuFuLingZhenItem]=tipsBtnManager.handleYFLingZhen,
[TIPS_TYPE.eCommonClothing]=tipsBtnManager.handleClothing,
[TIPS_TYPE.eCommonXianBao]=tipsBtnManager.handleXianBao,
[TIPS_TYPE.eYunZhouComponents]=tipsBtnManager.handleYunZhouComponents,
[TIPS_TYPE.eGiftPackTipsItem]=tipsBtnManager.handleGiftPack,
[TIPS_TYPE.eReuseItem]=tipsBtnManager.handleReuseItem,
[TIPS_TYPE.eCommonVocEquip]=tipsBtnManager.handleEquip,
[TIPS_TYPE.eTDLXMaterial]=tipsBtnManager.handleTDLXMetrial,
}

_bodysHandler=
{
[TIPS_FORM_TYPE.eWorldTour]=tipsBodyManager.FormHandle_WorldTour,
[TIPS_FORM_TYPE.eLianqiGeBagItem]=tipsBodyManager.handleLianqiGeBagItem,
[TIPS_FORM_TYPE.eLianqiGeItem]=tipsBodyManager.handleLianqiGeItem,
[TIPS_FORM_TYPE.eLianqiGeFabaoPreview]=tipsBodyManager.handleLianqiGeFabaoPreview,
[TIPS_FORM_TYPE.eGubaoCheck]=tipsBodyManager.handleGubaoItem,
[TIPS_FORM_TYPE.eGubaoWin]=tipsBodyManager.handleGubaoItem,
[TIPS_FORM_TYPE.eAuctionSellItem]=tipsBodyManager.handleAuctionSellItem,
[TIPS_FORM_TYPE.eYuHuo]=tipsBodyManager.handleYuHuoBody,
[TIPS_FORM_TYPE.ePutFeiShengTaiMaterial]=tipsBodyManager.handleLianqiGeBagItem,
[TIPS_FORM_TYPE.eOffFeiShengTaiMaterial]=tipsBodyManager.handleLianqiGeItem,
[TIPS_FORM_TYPE.ePutAutoBuildMaterial]=tipsBodyManager.handleLianqiGeBagItem,
[TIPS_FORM_TYPE.eOffAutoBuildMaterial]=tipsBodyManager.handleLianqiGeItem,
[TIPS_FORM_TYPE.eGuBaoUpLvBag]=tipsBodyManager.handleLianqiGeBagItem,
}
self.bodysHandler=_bodysHandler

_tipsBodysHandler=
{
[TIPS_TYPE.eYuFuLingZhenItem]=tipsBodyManager.handleLingZhen,
[TIPS_TYPE.eCommonItem]=tipsBodyManager.handleItem,
[TIPS_TYPE.eCommonGubao]=tipsBodyManager.handleGubaoFSItem,
[TIPS_TYPE.eCommonGubaoMetrial]=tipsBodyManager.handleGubaoFSItem,
[TIPS_TYPE.eCommonFabao]=tipsBodyManager.handleFaBao,
[TIPS_TYPE.eCommonClothing]=tipsBodyManager.handleeCommonClothing,
[TIPS_TYPE.eCommonXianBao]=tipsBodyManager.handleDFXianBao,
}


_exbodysHandler=
{
[TIPS_TYPE.eCommonItem]=tipsExBodyManager.handleItem,
[TIPS_TYPE.eCommonMetrial]=tipsExBodyManager.handleMetrial,
[TIPS_TYPE.eCommonGubaoMetrial]=tipsExBodyManager.handleGubaoMetrial,
[TIPS_TYPE.eCommonDaoBing]=tipsExBodyManager.handleDaoBing,
[TIPS_TYPE.eCommonMountItem]=tipsExBodyManager.handleMount,
[TIPS_TYPE.eCommonEquip]=tipsExBodyManager.handleEquip,
[TIPS_TYPE.eCommonXianBao]=tipsExBodyManager.handleXianBao,
[TIPS_TYPE.eCommonRandomEquipItem]=tipsExBodyManager.handleRandomEquipItem,
[TIPS_TYPE.eCommonGubao]=tipsExBodyManager.handleCommonGubao,
[TIPS_TYPE.eCommonXingChen]=tipsExBodyManager.handleCommonXingChen,
}


_midExbodysHandler=
{
[TIPS_TYPE.eCommonItem]=tipsMidExBodyManager.handleItem,
[TIPS_TYPE.eCommonEquip]=tipsMidExBodyManager.handleEquip,
[TIPS_TYPE.eCommonFabao]=tipsMidExBodyManager.handleFaBao,
}


_argsHandler=
{
[TIPS_TYPE.eCommonItem]=tipsManager.handleCommonItemArgs,
[TIPS_TYPE.eCommonMetrial]=tipsManager.handleMetrialArgs,
[TIPS_TYPE.eCommonGubaoMetrial]=tipsManager.handleGubaoMetrialArgs,
[TIPS_TYPE.eCommonFabao]=tipsManager.handleFabaoArgs,
[TIPS_TYPE.eYuFuLingZhenItem]=tipsManager.handleLingZhenArgs,
[TIPS_TYPE.eCommonFubao]=tipsManager.handleFuBaoArgs,
[TIPS_TYPE.eCommonVocEquip]=tipsManager.handleVocEquipArgs,
[TIPS_TYPE.eVocEquipGuBaoGongMing]=tipsManager.handleVocEquipGBGMArgs,
}

_effectHandlers=
{
[TIPS_TYPE.eCommonEquip]=tipsEffectManager.handleEquip,
}

_closeHandler=
{
[TIPS_TYPE.eCommonFubao]=tipsManager.handleCloseFuBao,
[TIPS_TYPE.eYuFuLingZhenItem]=tipsManager.handleCloseLingZhen,
}

_exArgsHandler={
[TIPS_TYPE.eCommonVocEquip]=tipsManager.handleVocEquipExArgs,
}
end

function tipsManager:onEnterState()
tipsManager.clearCache()
end

function tipsManager:onLeaveState()
tipsManager.clearCache()
end











function tipsManager.showTips(argstable,fresh)

tipsManager.handleItemArgs(argstable)
tipsManager.showTipsCom(argstable,fresh)
end


function tipsManager.showTipsGB(argstable,fresh)

tipsManager.handleGBArgs(argstable)

tipsManager.showTipsCom(argstable,fresh)
end


function tipsManager.showTipsXB(argstable,fresh)

tipsManager.handleXBArgs(argstable)

tipsManager.showTipsCom(argstable,fresh)
end

function tipsManager.showTipsCSJDWeapon(argstable,fresh)

tipsManager.handleChiSeJinDiCopyItemArgs(argstable)

tipsManager.showTipsCom(argstable,fresh)
end


function tipsManager.showTipsCom(argstable,fresh)

tipsManager.handleExArgs(argstable)

tipsExManager.showTips(argstable)

tipsManager.handleCommonArgs(argstable,fresh)

tipsManager.handleSpeicalArgs(argstable)

tipsManager.handleTipsEffect(argstable)

tipsManager.handleTipsBody(argstable)

tipsManager.handleTipsBtn(argstable)

tipsManager.handleTipsExBody(argstable)

tipsManager.handleTipsMidExBody(argstable)

tipsManager.showTipsWindow(argstable)
end



function tipsManager.handleItemArgs(argstable)
local isItemType=argstable.funType or TIPS_FUNC_TYPE.eItem
if isItemType==TIPS_FUNC_TYPE.eItem then
tipsManager.handleItemFunType(argstable)
tipsManager.handleItemModelArgs(argstable)
elseif isItemType==TIPS_FUNC_TYPE.eGubao then
argstable.formType=argstable.formType or TIPS_FORM_TYPE.eGubaoCheck
if argstable.tipsType==TIPS_TYPE.eCommonGubao then
argstable.cfgType=ITEM_CONFIG_TYPE.eGuBao
end
tipsManager.handleGuBaoModelArgs(argstable)
elseif isItemType==TIPS_FUNC_TYPE.eChiSeJinDiWeapon then
tipsManager.handleChiSeJinDiCopyItemArgs(argstable)
elseif isItemType==TIPS_FUNC_TYPE.eXianBao then
tipsManager.handleXBArgs(argstable)
end
end


function tipsManager.handleGBArgs(argstable)
if argstable.tipsType==TIPS_TYPE.eCommonGubao then
argstable.cfgType=ITEM_CONFIG_TYPE.eGuBao
end
tipsManager.handleGuBaoModelArgs(argstable)
end


function tipsManager.handleXBArgs(argstable)
if(not argstable.cfgType)and argstable.tipsType==TIPS_TYPE.eCommonXianBao then
argstable.cfgType=ITEM_CONFIG_TYPE.eXianBao
end
tipsManager.handleXianBaoModelArgs(argstable)
end

function tipsManager.handleChiSeJinDiCopyItemArgs(argstable)
local itemid=argstable.itemid
local attach=argstable.attach
local subType=attach.subType
local subId=attach.subId
local config=activitiesModel:getSubActivityConfig(subType,subId)
local serverCfg=config.treasure[itemid]
local color=serverCfg[6]
local clientCfg=config.treasureClient[itemid]
local relevantPram={relevantId=1,pram={icon=clientCfg[3],effectid=clientCfg[4]}}
local moveType=TIPS_MOVE_POS.eLeft
attach.color=color
argstable.colorType=TIPS_COLOR_TYPE.eGubao
argstable.tipsType=argstable.tipsType or TIPS_TYPE.eChiSeJinDiWeapon
argstable.formType=argstable.formType or TIPS_FORM_TYPE.eNone
argstable.showModel=true
argstable.modelArgs={
win='UITipsModelThreeWin',
args={relevantPram=relevantPram,moveType=moveType,attach=attach},
}
end


function tipsManager.handleCommonArgs(argstable,fresh)
if not fresh then
_cacheArgstable=table.deepCopy(argstable)
end
if argstable.formType==nil then argstable.formType=TIPS_FORM_TYPE.eNone end
if argstable.attach~=nil and argstable.attach~=''and argstable.attach~=""then
if type(argstable.attach)~='table'then
loggerUtil.logErrFMT('attach{0}必须是table',argstable.attach)
end
else
argstable.attach={}
end
end

function tipsManager.handleSpeicalArgs(argstable)
local formType=argstable.formType
local tipsType=argstable.tipsType


if _argsHandler[tipsType]then
_argsHandler[tipsType](argstable)
end
end

function tipsManager.handleExArgs(argstable)
local formType=argstable.formType
local tipsType=argstable.tipsType

if _exArgsHandler[tipsType]then
_exArgsHandler[tipsType](argstable)
end
end

function tipsManager:setArgs(argstable)
self.rcArgs=argstable
end

function tipsManager:getArgs()
return self.rcArgs
end


function tipsManager.showTipsWindow(argstable)
local formType=argstable.formType
local tipsType=argstable.tipsType
local itemid=argstable.itemid
local showDisciple=false
local showLingShouItem=false
local itemCfg=nil
if itemid and tipsType==TIPS_TYPE.eCommonItem then
itemCfg=itemsConfig.getConfig(itemid,argstable.cfgType)
local funcparam=itemCfg and itemCfg.funcparam or nil
if funcparam and funcparam.type==item_funtion_type.disciple and funcparam.isSpecial then
showDisciple=true
elseif funcparam and funcparam.type==50 then

showLingShouItem=true
end
end





tipsManager:setArgs(argstable)

if showLingShouItem then
UIManager:showWindow('UILingShouItemTipsWin',{itemId=itemid})
elseif showDisciple and formType~=TIPS_FORM_TYPE.eBagGrids then

UIRecruitControl:showItemDiscipleInfoByItemId2(itemid)
elseif tipsType==TIPS_TYPE.eBaoXiangTipsItem or tipsType==TIPS_TYPE.eGiftPackTipsItem or tipsType==TIPS_TYPE.eReuseItem then

local attach=argstable.attach or{}
local openTipsCount=attach.openTipsCount and attach.openTipsCount+1 or 1
if openTipsCount<TIPS_MAX_OPEN_COUNT then
if formType==TIPS_FORM_TYPE.eBaoXiangTipsItem then

UIManager.PreloadCtor("UITipsWin")
UIManager:showWindow('UIBaoXiangTipsTwoWin',argstable)
else
UIManager.PreloadCtor("UITipsWin")
UIManager:showWindow('UIBaoXiangTipsWin',argstable)
end
UIManager:closeWindow('UITipsWin')
else

UIManager:showWindow('UITipsWin',argstable)
end
elseif tipsType==TIPS_TYPE.eTQCatInfo then
local itemCfg=itemsConfig.getConfig(itemid)
local funcparam=itemCfg and itemCfg.funcparam or nil
if funcparam and funcparam.type==32 then
wanBaoXunBaoDuiController:showTQCatInfoWin(funcparam)
end
elseif itemCfg and itemCfg.type1==2 and itemCfg.type2==14 then

local args={itemId=itemid,attach=argstable.attach,formType=argstable.formType}
UIManager:showWindow("UIYFLTTipsWin",args)
else
if formType~=TIPS_FORM_TYPE.eBaoXiangTipsItem then
UIManager:closeWindow('UIBaoXiangTipsWin')
UIManager:closeWindow('UIBaoXiangTipsTwoWin')
elseif tipsType~=TIPS_TYPE.eBaoXiangTipsItem then

local attach=argstable.attach or{}
local openTipsCount=attach.openTipsCount and attach.openTipsCount+1 or 1
if openTipsCount==2 then
UIManager:closeWindow('UIBaoXiangTipsTwoWin')
end
end
UIManager:showWindow('UITipsWin',argstable)
end
end


function tipsManager.closeTips()
UIManager:closeWindow('UITipsWin')
UIManager:closeWindow('UIBaoXiangTipsWin')
UIManager:closeWindow('UIBaoXiangTipsTwoWin')
UIManager:closeWindow('UITipsExWin')
UIManager:closeWindow('UIFabaoYuanPeiMetrialWin')
UIManager:closeWindow('UIFabaoMaterialTipsDescWin')

local argstable=tipsManager:getArgs()
if argstable then
tipsManager:setArgs()
local tipsType=argstable.tipsType
if _closeHandler[tipsType]then
_closeHandler[tipsType](argstable)
end
end
end




function tipsManager.setTipsAttachTableArgs(attach,keyTable,val)
if keyTable==nil then
logErr('setTipsAttach传参错误!')
return
end
local len=#keyTable
local info=attach
for i=1,len-1 do
local key=keyTable[i]
if info[key]==nil then info[key]={}end
info=info[key]
end
info[keyTable[#keyTable]]=val
end


function tipsManager.setAttachArgs(attach,key,val)
attach[key]=val
_cacheArgstable.attach=attach
end


function tipsManager.freshTipsWithAttach(attach,key,val)
tipsManager.setAttachArgs(attach,key,val)
tipsManager.freshTips()
end


function tipsManager.freshTips()
tipsManager.showTips(table.deepCopy(_cacheArgstable),true)
end

function tipsManager.clearCache()
_cacheArgstable=nil
end

function tipsManager.handleFabaoArgs(argstable)
local itemid=argstable.itemid
if fabaoConfig.isBenMingFabao(itemid)then
argstable.colorType=TIPS_COLOR_TYPE.eFabao
end
end

function tipsManager.handleLingZhenArgs(argstable)
local color=UIYuFuLingZhenControl:getItemColorById(argstable.itemid,argstable.itemguid,argstable.attach.level)
argstable.attach.color=color
end

function tipsManager.handleFuBaoArgs(argstable)
local formType=argstable.formType
if UIYuFuLingZhenControl:isSysOpen()and formType~=TIPS_FORM_TYPE.eEquipListWin and UIFuLuFangModel:isEquipedOnAnyDizi(argstable.itemguid)then
local data=UIYuFuLingZhenControl:getLingZhenData(argstable.itemguid)

if data and data.zhentuId>0 then
argstable.move=TIPS_MOVE_POS.eRight
UIManager:showWindow('UIYFLZTips',{itemId=argstable.itemid,itemGuid=argstable.itemguid})
end
end
end

function tipsManager.handleCommonItemArgs(argstable)
local formType=argstable.formType
if formType==TIPS_FORM_TYPE.eXMFXZY then
local attach=argstable.attach
if not attach then
attach={}
end
local itemId=argstable.itemid
local config=cfgHelper.get1(cfg_guildaskforconfig_get,itemId)
attach.nameAttach=FMT.fmt("（求助数:{0}）",config.num*config.max)
argstable.attach=attach
end
end

function tipsManager.handleMetrialArgs(argstable)
local formType=argstable.formType
if formType==TIPS_FORM_TYPE.eXMFXZY then
local attach=argstable.attach
if not attach then
attach={}
end
local itemId=argstable.itemid
local config=cfgHelper.get1(cfg_guildaskforconfig_get,itemId)
attach.nameAttach=FMT.fmt("（求助数:{0}）",config.num*config.max)
argstable.attach=attach
end
end

function tipsManager.handleGubaoMetrialArgs(argstable)
local formType=argstable.formType
if formType==TIPS_FORM_TYPE.eXMFXZY then
local attach=argstable.attach
if not attach then
attach={}
end
local itemId=argstable.itemid
local config=cfgHelper.get1(cfg_guildaskforconfig_get,itemId)
attach.nameAttach=FMT.fmt("（求助数：{0}）",config.num*config.max)
argstable.attach=attach
end
end

function tipsManager.handleVocEquipArgs(argstable)


argstable.colorType=TIPS_COLOR_TYPE.eVocEquip
argstable.bgSpine={6125,1,eAnimationID.stand}
end

function tipsManager.handleVocEquipGBGMArgs(argstable)
argstable.colorType=TIPS_COLOR_TYPE.eVocEquipGBGM
argstable.bgSpine=nil
argstable.exWinMove=TIPS_MOVE_POS.eLeft
end


function tipsManager.handleVocEquipExArgs(argstable)
local formType=argstable.formType
if formType==TIPS_FORM_TYPE.eWatchRoleItem then
argstable.isHideTipsEx=true
end
end



function tipsManager.handleTipsType(argstable)
local tipsType=argstable.tipsType
local itemid=argstable.itemid
local itemguid=argstable.itemguid
local itemData=argstable.itemData
if itemid then
if itemsConfig.isEquip(itemid)then
if(not itemData or not next(itemData))and
(itemguid==nil or equipsHelper.getEquip(itemguid)==nil or tonumber(tostring(itemguid))<0)then
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.fix then
tipsType=TIPS_TYPE.eCommonRandomEquipItem
elseif itemCfg.recommend then
tipsType=TIPS_TYPE.eCommonEquipItem
end
end
elseif itemsConfig.isFabao(itemid)then
if(not itemData or not next(itemData))and(itemguid==nil or tonumber(tostring(itemguid))<0)and fabaoConfig.isRandomFabao(itemid)then
tipsType=TIPS_TYPE.eRandomFabaoItem
end
end
end
argstable.tipsType=tipsType
return tipsType
end

function tipsManager.handleTipsEffect(argstable)
local formType=argstable.formType
local tipsType=argstable.tipsType

local handle=_effectHandlers[tipsType]
if handle then
handle(argstable)
end
end

function tipsManager.handleTipsBody(argstable)
local formType=argstable.formType
local tipsType=argstable.tipsType

argstable.tipsBodysConfig=tipsConfig.getBodyConfig(tipsType)

if tipsManager.checkXianMoEquip(argstable.itemid,tipsType)then
if tipsType==TIPS_TYPE.eCommonEquip then
argstable.tipsBodysConfig=tipsConfig.getGroupConfig(44)
tipsManager.XianMoEquipHandle(argstable)
elseif tipsType==TIPS_TYPE.eCommonRandomEquipItem then
argstable.tipsBodysConfig=tipsConfig.getGroupConfig(44)
tipsManager.XianMoEquipHandlebiaoxiang(argstable)
end
end

tipsBodyManager.handleCommonBody(argstable)

local fromHandle=_bodysHandler[formType]
if fromHandle then
fromHandle(argstable)
end

local handle=_tipsBodysHandler[tipsType]
if handle then
handle(argstable)
end
end

function tipsManager.handleTipsExBody(argstable)
local formType=argstable.formType
local tipsType=argstable.tipsType

local extNode=tipsConfig.getExtNodeConfig(tipsType)
argstable.exBodysConfig={extNode}

tipsExBodyManager.handleCommonBody(argstable)

local handle=_exbodysHandler[tipsType]
if handle then
handle(argstable)
end
end

function tipsManager.handleTipsMidExBody(argstable)
local formType=argstable.formType
local tipsType=argstable.tipsType

local extNode=tipsConfig.getMidExtNodeConfig(tipsType)
argstable.exMidBodysConfig={extNode}

tipsMidExBodyManager.handleCommonBody(argstable)

local handle=_midExbodysHandler[tipsType]
if handle then
handle(argstable)
end
end

function tipsManager.handleTipsBtn(argstable)
local formType=argstable.formType
local tipsType=argstable.tipsType
local attach=argstable.attach

argstable.tipsBtnsConfig=tipsConfig.getBtnsConfig(tipsType)


if _btnsHandlers[tipsType]then
_btnsHandlers[tipsType](argstable)
end


if formType==TIPS_FORM_TYPE.eNone or formType==TIPS_FORM_TYPE.eNoBtns or formType==TIPS_FORM_TYPE.eBaoXiangTipsItem then
tipsBtnManager.clearBtn(argstable)
end


if attach and attach.insertBtnList then
tipsBtnManager.insertBtn(argstable,attach.insertBtnList)
end
end

function tipsManager.handleItemFunType(argstable)
if argstable.itemguid==nil and argstable.itemid==nil then
logErr('tips传入参数错误，itemid和itemguid不能同时为空')
return
end

local itemguid=argstable.itemguid
local itemid=argstable.itemid
if itemguid and itemid==nil then
local item=itemsModel.getItem(itemguid)
itemid=item.itemid
argstable.itemid=itemid
end



argstable.usingType=argstable.usingType or TIPS_USING_TYPE.eNormal

local tipsType=argstable.tipsType
if tipsType==nil then
if argstable.usingType==TIPS_USING_TYPE.eGainWay then
tipsType=itemsConfig.getConfig(itemid).gainWaySid
if tipsType==nil then
loggerUtil.logErrFMT('{0}没有配置tips类型:gainWaySid',itemid)
return
end
argstable.tipsType=tipsType
else
tipsType=itemsConfig.getConfig(itemid).tipsid

if tipsType==nil then
loggerUtil.logErrFMT('{0}没有配置tips类型:tipsid',itemid)
return
end
argstable.tipsType=tipsType


local btnsList=tipsConfig.getCombineBtns(itemid)
local btns=argstable.btnsList
argstable.btnsList=table.concatTable(btns,btnsList)
end
end

tipsType=tipsManager.handleTipsType(argstable)
argstable.tipsType=tipsType
end

function tipsManager.checkItemModel(itemid)
local cfg=itemsConfig.getConfig(itemid)
if cfg==nil then return false end

local model=cfg.model
if itemsConfig.isDaoBingMaterials(itemid)then
return true
elseif itemsConfig.isClothing(itemid)then
return true
elseif cfg.model~=nil then
return true
elseif cfg.relevantPram and cfg.type1==18 then
if cfg.relevantPram.pram and cfg.relevantPram.pram.isShowModel then
return true
end
else
if cfg.relevantPram then
return true
end
end
return false
end

function tipsManager.handleItemModelArgs(argstable)

local showModel=argstable.showModel
if showModel==false then
argstable.modelArgs=nil
return
end



local itemid=argstable.itemid
local itemguid=argstable.itemguid

local cfg=itemsConfig.getConfig(itemid)
if cfg.funcparam and cfg.funcparam.type==item_funtion_type.playerimage then
showModel=true
end

if showModel==nil and not tipsManager.checkItemModel(itemid)then
argstable.showModel=false
argstable.modelArgs=nil
return
end

argstable.move=argstable.move or TIPS_MOVE_POS.eDefault
argstable.backType=argstable.backType or TIPS_BACK_TYPE.eNomal

local args=argstable.modelArgs

argstable.modelArgs=nil
local modelArgs=nil


local model=cfg.model
if itemsConfig.isDaoBingMaterials(itemid)then
local dbitemid=daobingConfig.getCombineDaoBing(itemid)
model=itemsConfig.getConfig(dbitemid).model
elseif itemsConfig.isClothing(itemid)then
if itemguid then
local diziguid=ClothingModel:getDiziguidByItemguid(itemguid)
model=ClothingConfig.getModelArgs(itemid,nil,argstable.attach~=nil and diziguid)
else
if itemguid then
local star=ClothingModel:getStarLv(itemguid)
model=ClothingConfig.getModelArgs(itemid,star)
else
model=ClothingConfig.getModelArgs(itemid)
end

end
end

if argstable.attach==nil then argstable.attach={}end
local attach=argstable.attach

if model then
argstable.move=TIPS_MOVE_POS.eRight
modelArgs={}
if itemsConfig.isDaoBing(itemid)or itemsConfig.isDaoBingMaterials(itemid)then
modelArgs.win='UITipsDaoBingModelWin'
modelArgs.args={args=args,attach=attach,itemid=itemid,itemguid=itemguid}
elseif itemsConfig.isClothing(itemid)then
modelArgs.win='UITipsShiZhuangModelWin'
modelArgs.args={args=args,attach=attach,model=model,itemid=itemid,itemguid=itemguid,diziguid=attach.diziguid}
else
modelArgs.win='UITipsModelWin'
modelArgs.args={args=args,attach=attach,model=model,itemid=itemid}
end
elseif cfg.funcparam and cfg.funcparam.type==item_funtion_type.playerimage and
cfg.type1==18 then
modelArgs={}
modelArgs.win='UIZuShiTipsModelWin'
modelArgs.args={itemid=itemid}
elseif cfg.relevantPram and cfg.type1==18 then
local moveType
local move=argstable.move
if move and move==TIPS_MOVE_POS.eLeft then
moveType=TIPS_MOVE_POS.eRight
else
moveType=TIPS_MOVE_POS.eLeft
end
modelArgs={}
modelArgs.win='UITipsModelTwoWin'
modelArgs.args={itemId=itemid,attach=attach,moveType=moveType,args=args}
else
local relevantPram=cfg.relevantPram
if relevantPram then
local moveType
local move=argstable.move
if move and move==TIPS_MOVE_POS.eLeft then
moveType=TIPS_MOVE_POS.eRight
else
moveType=TIPS_MOVE_POS.eLeft
end
local modelType=relevantPram.relevantId
if modelType==1 then
modelArgs={}
modelArgs.win='UITipsModelThreeWin'
modelArgs.args={relevantPram=relevantPram,moveType=moveType,args=args,attach=attach,itemid=itemid}
else



end
end
end

local showModel=modelArgs~=nil
argstable.showModel=showModel
argstable.modelArgs=modelArgs
end

function tipsManager.handleCloseFuBao(argstable)
UIManager:closeWindow('UIYFLZTips')
end

function tipsManager.handleCloseLingZhen(argstable)

end



function tipsManager.checkGuBaoModel(itemid,cfgType)
local cfg,cfg2=itemsConfig.getConfig(itemid,cfgType)
if cfg==nil then return false end
if cfg.model~=nil then
return true
elseif cfg.relevantPram and cfg.type1==18 then
if cfg.relevantPram.pram and cfg.relevantPram.pram.isShowModel then
return true
end
else
local relevantPram=cfg.relevantPram
if relevantPram==nil and cfg2~=nil then
relevantPram=cfg2.relevantPram
end
if relevantPram then
return true
end
end
return false
end


function tipsManager.checkXianBaoModel(itemid,cfgType)
if cfgType==ITEM_CONFIG_TYPE.eXianBao then
local cfg=itemsConfig.getConfig(itemid,cfgType)
if cfg==nil then return false end
if cfg.model~=nil then
return true
end
elseif cfgType==ITEM_CONFIG_TYPE.eGuBao then
return tipsManager.checkGuBaoModel(itemid,cfgType)
end
return false
end


function tipsManager.handleGuBaoModelArgs(argstable)

local showModel=argstable.showModel
if showModel==false then
argstable.modelArgs=nil
return
end


local cfgType=argstable.cfgType
local itemid=argstable.itemid
if showModel==nil and not tipsManager.checkGuBaoModel(itemid,cfgType)then
argstable.showModel=false
argstable.modelArgs=nil
return
end

argstable.move=TIPS_MOVE_POS.eDefault
argstable.backType=TIPS_BACK_TYPE.eNomal

if argstable.attach==nil then argstable.attach={}end
local attach=argstable.attach

local args=argstable.modelArgs
argstable.modelArgs=nil
local modelArgs=nil

local cfg,cfg2=itemsConfig.getConfig(itemid,cfgType)
local relevantPram=cfg.relevantPram
if relevantPram==nil and cfg2~=nil then
relevantPram=cfg2.relevantPram
end
if relevantPram then
local moveType
local move=argstable.move
if move and move==TIPS_MOVE_POS.eLeft then
moveType=TIPS_MOVE_POS.eRight
else
moveType=TIPS_MOVE_POS.eLeft
end
local modelType=relevantPram.relevantId
if modelType==1 then
modelArgs={}
modelArgs.win='UITipsModelThreeWin'
modelArgs.args={relevantPram=relevantPram,
moveType=moveType,
args=args,
attach=attach,
itemid=itemid,
itemConfigType=ITEM_CONFIG_TYPE.eGuBao}
else



end
end

local showModel=modelArgs~=nil
argstable.showModel=showModel
argstable.modelArgs=modelArgs
end

function tipsManager.handleXianBaoModelArgs(argstable)

local showModel=argstable.showModel
if showModel==false then
argstable.modelArgs=nil
return
end


local cfgType=argstable.cfgType
local itemid=argstable.itemid
if showModel==nil and not tipsManager.checkXianBaoModel(itemid,cfgType)then
argstable.showModel=false
argstable.modelArgs=nil
return
end

argstable.move=TIPS_MOVE_POS.eDefault
argstable.backType=TIPS_BACK_TYPE.eNomal

if argstable.attach==nil then argstable.attach={}end
local attach=argstable.attach

local args=argstable.modelArgs
argstable.modelArgs=nil
local xbtype=argstable.xbtype or XianBaoTypeEnum.eXianBao
local modelArgs=xianbaoConfig.getTypeFuncResult(xbtype,'getTipsModelArgs',argstable)
local showModel=modelArgs~=nil
argstable.showModel=showModel
argstable.modelArgs=modelArgs
end


function tipsManager.checkXianMoEquip(itemid,tipsType)
if tipsType==TIPS_TYPE.eCommonEquip or tipsType==TIPS_TYPE.eCommonRandomEquipItem then
if itemid and itemsConfig.isEquip(itemid)then
local isxmEquip=equipsHelper.isEquipXMbyItemid(itemid)
if isxmEquip then
return true
end
end
end
return false
end
function tipsManager.XianMoEquipHandle(argstable)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeTop,TIPS_SRC_TYPE.tipsChildBaseAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeMiddle,TIPS_SRC_TYPE.tipsChildRandomAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeBottom,TIPS_SRC_TYPE.tipsChildEquipSuit)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eMiddleNodeTop,TIPS_SRC_TYPE.tipsChildEquipXianMo)

end

function tipsManager.XianMoEquipHandlebiaoxiang(argstable)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeTop,TIPS_SRC_TYPE.tipsChildBaseAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeMiddle,TIPS_SRC_TYPE.tipsChildEquipFixRandomAttr)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eTopNodeBottom,TIPS_SRC_TYPE.tipsChildEquipFixSuit)
tipsBodyManager.addScrollBody(argstable,TIPS_NODE_TYPE.eMiddleNodeTop,TIPS_SRC_TYPE.tipsChildEquipXianMo)
end
