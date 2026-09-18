




iconHelper={}
local sformat=string.format


iconHelper.cRed='#ff0000ff'
iconHelper.cNormal='#fffffff'
iconHelper.cWarn='#ff0000ff'
iconHelper.cError='#ffff00ff'

iconHelper.globalSpriteBundle1='ui/sharedtextures/uiglobalspriteatlas_1.ab'
iconHelper.globalSpriteBundle2='ui/sharedtextures/uiglobalspriteatlas_2.ab'

local _iconFunc={
[ITEM_MAIN_TYPE.eMoney]=function(icon)
return iconHelper.getMoneyIconName(icon)
end,

[ITEM_MAIN_TYPE.eItem]=function(icon)
return iconHelper.getItemIconName(icon)
end,

[ITEM_MAIN_TYPE.eEquip]=function(icon)
return iconHelper.getEquipIconName(icon)
end,

[ITEM_MAIN_TYPE.eMaterials]=function(icon)
return iconHelper.getMaterialIconName(icon)
end,

[ITEM_MAIN_TYPE.eFabao]=function(icon)
return iconHelper.getFabaoIconName(icon)
end,

[ITEM_MAIN_TYPE.eFubao]=function(icon)
return iconHelper.getFubaoIconName(icon)
end,

[ITEM_MAIN_TYPE.eGubao]=function(icon)
return iconHelper.getGuBaoIconName(icon)
end,

[ITEM_MAIN_TYPE.eRongYu]=function(icon)
return iconHelper.getRongYuIconName(icon)
end,

[ITEM_MAIN_TYPE.eDaoBing]=function(icon)
return iconHelper.getItemIconName(icon)
end,

[ITEM_MAIN_TYPE.eFabaoYuanPei]=function(icon)
return iconHelper.getItemIconName(icon)
end,

[ITEM_MAIN_TYPE.eDaoBingMaterials]=function(icon)
return iconHelper.getItemIconName(icon)
end,

[ITEM_MAIN_TYPE.eYuHuo]=function(icon)
return iconHelper.getItemIconName(icon)
end,
[ITEM_MAIN_TYPE.eMaoMao]=function(icon)
return iconHelper.getItemIconName(icon)
end,
[ITEM_MAIN_TYPE.eMount]=function(icon)
return iconHelper.getItemIconName(icon)
end,
[ITEM_MAIN_TYPE.eYFLingZhen]=function(icon)
return iconHelper.getItemIconName(icon)
end,
[ITEM_MAIN_TYPE.eClothing]=function(icon)
return iconHelper.getItemIconName(icon)
end,
[ITEM_MAIN_TYPE.eXingChen]=function(icon)
return iconHelper.getItemIconName(icon)
end,
[ITEM_MAIN_TYPE.eYunZhouComponents]=function(icon)
return iconHelper.getItemIconName(icon)
end,
[ITEM_MAIN_TYPE.eVocEquip]=function(icon)
return iconHelper.getItemIconName(icon)
end,
[ITEM_MAIN_TYPE.eLingShou]=function(icon)
return iconHelper.getItemIconName(icon)
end,
}


function iconHelper.getIconName(itemid)
local mainType=itemsConfig.getMainType(itemid)
if _iconFunc[mainType]then
local config=itemsConfig.getConfig(itemid)

if config==nil then
logErr(FMT.fmt('没有找到itemid={0}的配置',itemid))
return
elseif config.icon==nil then
logErr(FMT.fmt('没有找到itemid={0}的icon配置',itemid))
return
end

return _iconFunc[mainType](config.icon)
else
logErr(FMT.fmt('没有找到itemid={0}的图标名称的方法',itemid))
end
end

function iconHelper.getIconInfo(id)
local cfg=cfg_spritepathconfig_get(id)
return cfg.bundlename,cfg.assetname
end

function iconHelper.getMoneyIconName(icon)
if icon==eMoneyType.mtXianYu and verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_yuenan()and deviceHelper.isRunIOS()then
return"icon_money_ios_3"
end
return sformat('icon_money_%d',icon)
end

function iconHelper.getBatchMoneyIconName(icon)
return sformat('icon_money_%d_b',icon)
end

function iconHelper.getItemIconName(icon)
return sformat('icon_item_%d',icon)
end

function iconHelper.getEquipIconName(icon)
return sformat('icon_item_%d',icon)
end

function iconHelper.getMaterialIconName(icon)
return sformat('icon_item_%d',icon)
end

function iconHelper.getFabaoIconName(icon)
return sformat('icon_item_%d',icon)
end

function iconHelper.getFubaoIconName(icon)
return sformat('icon_item_%d',icon)
end

function iconHelper.getGuBaoIconName(icon)
return sformat('icon_item_%d',icon)
end

function iconHelper.getRongYuIconName(icon)
return sformat('icon_item_%d',icon)
end


function iconHelper.getSmallMoneyIconName(icon)
return sformat('icon_money_s_%d',icon)
end

function iconHelper.getGainWayIcon(icon)
return sformat('icon_gainway_%d',icon)
end

function iconHelper.getSkillIcon(icon)
return sformat('icon_skill_%d',icon)
end

function iconHelper.getGongFaIcon(icon)
return sformat('icon_skill_%d',icon)
end

function iconHelper.getBuffIcon(icon)
return sformat('icon_buff_%d',icon)
end

function iconHelper.getResDispelBuffIcon(icon)
return sformat('icon_res_buff_%d',icon)
end

function iconHelper.getCounterAtkIcon(CounterAtkID,num)
if CounterAtkID then
local counterConfig=cfgHelper.get1(cfg_skillljconfig_get,CounterAtkID)
if counterConfig then
return sformat(counterConfig.icon,num)
end
end
return sformat('icon_xulibuff_%d',num)
end

function iconHelper.getEmotIcon(icon)
return sformat('icon_biaoqing_%d',icon)
end

function iconHelper.getBigEmotIcon(icon)
return sformat('icon_teshubq_%d',icon)
end

function iconHelper.getDefineEmotIcon(icon)
return sformat('icon_zidingyi_%d',icon)
end

function iconHelper.getHeadIcon(icon)
return sformat('icon_head_%d',icon)
end

function iconHelper.getHeadKuangIcon(icon)
return sformat('icon_touxiangkuang_%d',icon)
end

function iconHelper.getHeadBGIcon(icon)
return sformat('image_txdk_%d',icon)
end

function iconHelper.getChatKuangIcon(icon)
return sformat('icon_chatbg_%d',icon)
end

function iconHelper.getzmStateIcon(icon)
return sformat('icon_zmzt_%d',icon)
end

function iconHelper.getRuleQualityIcon(icon)
return sformat('icon_faze_quality_%d',icon)
end

function iconHelper.getRuleQualityIcon2(icon)
return sformat('image_qjxianshangpzui_%d',icon)
end

function iconHelper.getRuleQualityIcon3(icon)
return sformat('image_qjxianshangpzuix_%d',icon)
end

function iconHelper.getEventIcon(icon)
return sformat('icon_mjsjtp_%d',icon)
end

function iconHelper.getPlayerSexIcon(icon)
return sformat('icon_xingbie_%d',icon)
end

function iconHelper.getEventChahuaIcon(icon)
return sformat('image_shijian_%d',icon)
end

function iconHelper.getChongZhiIcon(icon)
return sformat('icon_chongzhi_%d',icon)
end

function iconHelper.getUnlockIcon(icon)
return sformat('icon_unlock_%d',icon)
end

function iconHelper.getDouFaTaiIcon(icon)
return sformat('icon_dft_duanwei_%d',icon)
end

function iconHelper.getPlayerImageIcon(icon)
return iconHelper.getItemIconName(icon)
end

function iconHelper.getDaobingNameIcon(icon)
return sformat('image_daobingwz_%d',icon)
end

function iconHelper.getItemBgIcon(icon)
return sformat('icon_item_bg_%d',icon)
end

function iconHelper.getDaobingBigIcon(icon)
return sformat('icon_daobing_%d',icon)
end

function iconHelper.getDaobingBigBgIcon(icon)
return sformat('icon_daobing_bg_%d',icon)
end

function iconHelper.getFaBaoTypeIcon(icon)
return iconHelper.getItemIconName(icon)

end

function iconHelper.getFaBaoTypeSmallIcon(icon)
return sformat('icon_daojusl_%04d',icon)
end

function iconHelper.getLimitActivityPreviewIcon(icon)
return sformat('icon_xmhuodongygt_%d',icon)
end

function iconHelper.getSuitIcon(icon)
return sformat('icon_suit_%d',icon)
end

function iconHelper.getBuildNameIcon(icon)
return sformat('button_jzbujumz_%02d',icon)
end


function iconHelper.setChildIcon(widget,index,id,native)
local cfg=cfg_spritepathconfig_get(id)
local abname=cfg.bundlename
local assetname=cfg.assetname
if abname then
widget:SetChildCSImageSprite(index,abname,assetname)
else
widget:SetChildCSImageIcon(index,assetname,native or false)
end
end

function iconHelper.setChildIcon_1(widget,index,id,sizeX,sizeY,offsetX,offsetY)
local cfg=cfg_spritepathconfig_get(id)
local abname=cfg.bundlename
local assetname=cfg.assetname
if abname and assetname then
widget:SetChildCSImageSprite(index,abname,assetname)
end
if sizeX and sizeY then
widget:SetChildSizeDelta(index,sizeX,sizeY)
end
widget:SetChildLocalPos(index,offsetX or 0,offsetY or 0,0)
end

function iconHelper.setChildIcon_2(widget,index,iconInfo)
if iconInfo and iconInfo[1]then
local assetInfo=iconInfo[1]
local abname=assetInfo[1]
local assetname=assetInfo[2]
local size=iconInfo[2]
if abname then
widget:SetChildCSImageSprite(index,abname,assetname)
else
widget:SetChildCSImageIcon(index,assetname,size==nil)
end
if size then
widget:SetChildSizeDelta(index,size[1],size[2])
end
else
widget:SetChildIcon(index,'',false)
end
end