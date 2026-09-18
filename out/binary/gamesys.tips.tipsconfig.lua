




tipsConfig={}



local _idx=0
local _getidx=function()
_idx=_idx+1
return _idx
end

TIPS_FORM_TYPE=
{
eNone=_getidx(),
eClearBtn=_getidx(),
eNoBtns=_getidx(),
eBagGrids=_getidx(),
eEquipWin=_getidx(),
eEquipListWin=_getidx(),
eFabaoWin=_getidx(),
eLink=_getidx(),
eWatchItem=_getidx(),
eGubaoWin=_getidx(),
eGubaoBag=_getidx(),
eWorldTour=_getidx(),
eDiscipleBag=_getidx(),
eGubaoCheck=_getidx(),
eLianqiGeBagItem=_getidx(),
eFabaoJilian=_getidx(),
eFabaoLianhua=_getidx(),
eFuluSelect=_getidx(),
eFuluMake=_getidx(),
eWatchRoleItem=_getidx(),
eLianqiGeItem=_getidx(),
eSkillFabaoItem=_getidx(),
eBaoXiangTipsItem=_getidx(),
eEquipFilter=_getidx(),
eAuctionSellItem=_getidx(),
eDaoBingBagGrids=_getidx(),
eDaoBingCollect=_getidx(),
eFaBaoMaterialSelect=_getidx(),
eXMDG_shop=_getidx(),
eFaBaoYuanPeiSelect=_getidx(),
eUpFabao=_getidx(),
eQuickUse=_getidx(),
eYuHuo=_getidx(),
eYuEr=_getidx(),
eMountBag=_getidx(),
eMountBook=_getidx(),
eBuildSuit=_getidx(),
eMMEquipCompose=_getidx(),
eMMEquipJinLian=_getidx(),
eMountEquip=_getidx(),
eLianqiGeFabaoPreview=_getidx(),
eXMFXZY=_getidx(),
eYFLZCombine=_getidx(),
eClothingBag=_getidx(),
eAuctionShowItem=_getidx(),
eYFLZCombineSelected=_getidx(),
eYFLZMain=_getidx(),
eMMCommonEquip=_getidx(),
eYFLTBag=_getidx(),
ePutFeiShengTaiMaterial=_getidx(),
eOffFeiShengTaiMaterial=_getidx(),
eXianBaoBag=_getidx(),
eXianBaoTujian=_getidx(),
eXianBaoMaterial=_getidx(),
eXianBaoUpStar=_getidx(),
eTianGongGeDianHua=_getidx(),
eBaGuaLuWin=_getidx(),
eGuBaoUpLvBag=_getidx(),
eXMKCBag=_getidx(),
eXMKCFPWin=_getidx(),
eEquipCompare=_getidx(),
eYunZhouWarehouse=_getidx(),
eYunZhouComponents=_getidx(),
eYunZhouComposeBag=_getidx(),
eGongFaRecycle=_getidx(),
eFaBaoRefineMaterialSelect=_getidx(),
eFaBaoRefineCompare=_getidx(),
eBagEquipMutipleSelect=_getidx(),
eFaBaoMaterial=_getidx(),
eJGJZMaterial=_getidx(),
ePutAutoBuildMaterial=_getidx(),
eOffAutoBuildMaterial=_getidx(),
eShareLingShou=_getidx(),
}


_idx=0
TIPS_USING_TYPE=
{
eNormal=_getidx(),
eGainWay=_getidx(),
}

_idx=0
TIPS_COLOR_TYPE=
{
eNomal=_getidx(),
eFabao=_getidx(),
eGubao=_getidx(),
eDaoBing=_getidx(),
eBenMingFabao=_getidx(),
eDaoBingMaterials=_getidx(),
eXianBao=_getidx(),
eYunZhou=_getidx(),
eVocEquip=_getidx(),
eVocEquipGBGM=_getidx(),
}


TIPS_FUNC_TYPE=
{
eItem=1,
eGubao=2,
eChiSeJinDiWeapon=3,
eXianBao=4,
}


TIPS_MOVE_POS=
{
eDefault=0,
eRight=1,
eLeft=2,
eCenter=3,
eRightTwo=4,
eLeftTwo=5,
eRightThree=6,



getShowPos=function(self_,v)
if v==self_.eDefault or v==self_.eRight or v==self_.eCenter or v==self_.eRightTwo then
return-1
else
return 1
end
end
}


TIPS_BACK_TYPE=
{
eNone=0,
eNomal=1,
eBag=2,
eSelfBack=3,
}


USE_FULU_TIPS_SHOW_TYPE=
{
eBuffType=1,
eEffectType=2,
}

TIPS_MAX_OPEN_COUNT=3

local _tips_back_name=
{
[TIPS_BACK_TYPE.eNone]=nil,
[TIPS_BACK_TYPE.eNomal]='UIDialgueBackPanel',
[TIPS_BACK_TYPE.eBag]='UITipsBagBackPanel',
}
local _keyLook=nil

local _tipsABName='ui/windows/tips/sharedtextures/tipssprite.ab'
local _tipsYunZhouABName='ui/windows/xianyungang/yunzhoucomponents_atlas_pak.ab'

local _tipsNomalTitleBg=
{
[eQualityColor.eGreen]='frame_tytips_2',
[eQualityColor.eBlue]='frame_tytips_3',
[eQualityColor.ePurple]='frame_tytips_4',
[eQualityColor.eOrange]='frame_tytips_5',
[eQualityColor.eRed]='frame_tytips_6',

}

local _tipsFabaoTitleBg=
{
[eQualityColor.eGreen]='frame_fabaotips_5',
[eQualityColor.eBlue]='frame_fabaotips_1',
[eQualityColor.ePurple]='frame_fabaotips_2',
[eQualityColor.eOrange]='frame_fabaotips_3',
[eQualityColor.eRed]='frame_fabaotips_4',
}

local _tipsBemMingFabaoTitleBg=
{
[eQualityColor.eGreen]='image_benmingfabaoui_1',
[eQualityColor.eBlue]='image_benmingfabaoui_1',
[eQualityColor.ePurple]='image_benmingfabaoui_1',
[eQualityColor.eOrange]='image_benmingfabaoui_1',
[eQualityColor.eRed]='image_benmingfabaoui_1',
}

local _tipsGubaoTitleBg=
{
[eQualityColor.eGreen]='frame_gubaotips_1',
[eQualityColor.eBlue]='frame_gubaotips_1',
[eQualityColor.ePurple]='frame_gubaotips_2',
[eQualityColor.eOrange]='frame_gubaotips_3',
[eQualityColor.eRed]='frame_gubaotips_4',
[eQualityColor.ePink]='frame_gubaotips_5',
}

local _tipsDaoBingTitleBg=
{
[eQualityColor.ePurple]='frame_daobingtips_1',
[eQualityColor.eOrange]='frame_daobingtips_2',
[eQualityColor.eRed]='frame_daobingtips_3',
}

local _tipsYunZhouTitleBg=
{
[eQualityColor.eGreen]='frame_xygtips_1',
[eQualityColor.eBlue]='frame_xygtips_2',
[eQualityColor.ePurple]='frame_xygtips_3',
[eQualityColor.eOrange]='frame_xygtips_4',
[eQualityColor.eRed]='frame_xygtips_5',
}

local _tipsVocEquipTitleBg=
{
[eQualityColor.eGreen]='frame_gubaotips_6',
[eQualityColor.eBlue]='frame_gubaotips_6',
[eQualityColor.ePurple]='frame_gubaotips_6',
[eQualityColor.eOrange]='frame_gubaotips_6',
[eQualityColor.eRed]='frame_gubaotips_6',
}

local _tipsVocEquipGBGMTitleBg=
{
[eQualityColor.eGreen]='image_gubaogonming',
[eQualityColor.eBlue]='image_gubaogonming',
[eQualityColor.ePurple]='image_gubaogonming',
[eQualityColor.eOrange]='image_gubaogonming',
[eQualityColor.eRed]='image_gubaogonming',
}








TIPS_NODE_TYPE=
{

eTopNodeTop=0,
eTopNodeMiddle=1,
eTopNodeBottom=2,
eMiddleNodeTop=3,
eMiddleNodeMiddle=4,
eMiddleNodeBottom=5,
eBottomNodeTop=6,
eBottomNodeMiddle=7,
eBottomNodeBottom=8,
eNodeButtonGroup=9,
eNodeDetail=12,
}







function tipsConfig.getCombineBtns(itemid)
local btns_config={}
local tipsBtn=itemsConfig.getConfig(itemid).tipsBtn
if tipsBtn==nil then return btns_config end
local btn_config_excel=cfg_tipsbtnscombineconfig_get(tipsBtn)
if btn_config_excel then
for i,v in ipairs(btn_config_excel.buttons)do
table.insert(btns_config,v)
end
end
return btns_config
end

function tipsConfig.getNodeidx(nodename)
if _keyLook==nil then
_keyLook={}
for k,v in pairs(TIPS_NODE_TYPE)do
_keyLook[tostring(k)]=v
end
end
return _keyLook[tostring(nodename)]
end


function tipsConfig.getBodyConfig(tipsStyle)
local config=cfg_tipsconfig_get(tipsStyle)
return tipsConfig.getGroupConfig(config.groupid)
end


function tipsConfig.getBtnsConfig(tipsStyle)
local config=cfg_tipsconfig_get(tipsStyle)
return tipsConfig.getGroupConfig(config.btnid)
end


function tipsConfig.getScrollViewConfig(tipsStyle)
local config=cfg_tipsconfig_get(tipsStyle)
return tipsConfig.getGroupConfig(config.scrollviewid)
end

function tipsConfig.getExtNodeConfig(tipsStyle)
local config=cfg_tipsconfig_get(tipsStyle)
return config.extNode
end

function tipsConfig.getMidExtNodeConfig(tipsStyle)
local config=cfg_tipsconfig_get(tipsStyle)
return config.extMidNode
end

function tipsConfig.getGroupConfig(groupid)
if groupid==nil then return end
local tipsgroupconfig=cfg_tipsgroupconfig_get(groupid)
if tipsgroupconfig==nil then return end
local temp={}
for k,v in pairs(tipsgroupconfig)do
local nodeidx=tipsConfig.getNodeidx(k)
if nodeidx and v then
temp[nodeidx]=v
end
end
return temp
end


function tipsConfig.getTipsChildConfig(childType)
return cfg_tipscomponentconfig_get(childType)
end

function tipsConfig.callBtnsFunc(btnType,...)
local tipsbtnsconfig=cfg_tipsbtnsconfig_get(btnType)
local funcname=tipsbtnsconfig.funcname
return tipsBtnsFunc[funcname](btnType,...)
end

function tipsConfig.callBtnsFuncReddot(btnType,...)
local tipsbtnsconfig=cfg_tipsbtnsconfig_get(btnType)
local reddotFunc=tipsbtnsconfig.reddotFunc
if reddotFunc then
local func=tipsBtnsFunc[reddotFunc]
if func then
return func(btnType,...)
end
end
return false
end

function tipsConfig.callBtnsFuncGray(btnType,...)
local tipsbtnsconfig=cfg_tipsbtnsconfig_get(btnType)
local grayFunc=tipsbtnsconfig.grayFunc
if grayFunc then
local func=tipsBtnsFunc[grayFunc]
if func then
return func(btnType,...)
end
end
return false
end

function tipsConfig.getTitleAsset(itemid,color)
if not color then
local itemConfig=itemsConfig.getConfig(itemid)
color=itemConfig.color
end
local assetnames=''
local abName=_tipsABName
if itemsConfig.isFabao(itemid)then
if fabaoConfig.isBenMingFabao(itemid)then
assetnames=_tipsBemMingFabaoTitleBg
else
assetnames=_tipsFabaoTitleBg
end
elseif itemsConfig.isGubao(itemid)then
assetnames=_tipsGubaoTitleBg
elseif itemsConfig.isDaoBing(itemid)then
assetnames=_tipsDaoBingTitleBg
elseif itemsConfig.isDaoBingMaterials(itemid)then
assetnames=_tipsDaoBingTitleBg
elseif itemsConfig.isYunZhouComponents(itemid)then
abName=_tipsYunZhouABName
assetnames=_tipsYunZhouTitleBg
else
assetnames=_tipsNomalTitleBg
end
if color==nil then return end
return abName,assetnames[color]
end

function tipsConfig.getTipsAssetNameByType(colorType,color)
if colorType==TIPS_COLOR_TYPE.eNomal then
return tipsConfig.getTipsAssetName(color)
elseif colorType==TIPS_COLOR_TYPE.eFabao then
return tipsConfig.getFabaoBgAssetName(color)
elseif colorType==TIPS_COLOR_TYPE.eBenMingFabao then
return tipsConfig.getBenMingFabaoBgAssetName(color)
elseif colorType==TIPS_COLOR_TYPE.eGubao then
return tipsConfig.getGubaoBgAssetName(color)
elseif colorType==TIPS_COLOR_TYPE.eDaoBing then
return tipsConfig.getDaoBingBgAssetName(color)
elseif colorType==TIPS_COLOR_TYPE.eDaoBingMaterials then
return tipsConfig.getDaoBingBgAssetName(color)
elseif colorType==TIPS_COLOR_TYPE.eXianBao then
return tipsConfig.getXianBaoAssetName(color)
elseif colorType==TIPS_COLOR_TYPE.eYunZhou then
return tipsConfig.getYunZhouTipsAssetName(color)
elseif colorType==TIPS_COLOR_TYPE.eYunZhou then
return tipsConfig.getYunZhouTipsAssetName(color)
elseif colorType==TIPS_COLOR_TYPE.eVocEquip then
return tipsConfig.getVocEquipTipsAssetName(color)
elseif colorType==TIPS_COLOR_TYPE.eVocEquipGBGM then
return tipsConfig.getVocEquipGBGMTipsAssetName(color)
end
end

function tipsConfig.getTipsAssetName(color)
return _tipsABName,_tipsNomalTitleBg[color]
end

function tipsConfig.getFabaoBgAssetName(color)
return _tipsABName,_tipsFabaoTitleBg[color]
end

function tipsConfig.getBenMingFabaoBgAssetName(color)
return _tipsABName,_tipsBemMingFabaoTitleBg[color]
end

function tipsConfig.getGubaoBgAssetName(color)
return _tipsABName,_tipsGubaoTitleBg[color]
end

function tipsConfig.getDaoBingBgAssetName(color)
return _tipsABName,_tipsDaoBingTitleBg[color]
end

function tipsConfig.getVocEquipTipsAssetName(color)
return _tipsABName,_tipsVocEquipTitleBg[color]
end

function tipsConfig.getVocEquipGBGMTipsAssetName(color)
return _tipsABName,_tipsVocEquipGBGMTitleBg[color]
end


function tipsConfig.getXianBaoAssetName(color)
return globalABLookup.xianbaomainicons,"frame_xianbaotips_1"
end

function tipsConfig.getYunZhouTipsAssetName(color)
return _tipsYunZhouABName,_tipsYunZhouTitleBg[color]
end

function tipsConfig.getTipsBackWinName(tipsBackType)
return _tips_back_name[tipsBackType]
end