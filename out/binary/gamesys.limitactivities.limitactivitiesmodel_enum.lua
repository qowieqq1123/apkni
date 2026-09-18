











limitActInfoConfig={
[LIMIT_ACT_TYPE.eTianYuanShouChao]='limitActInfo_tianyuanshouchao',
[LIMIT_ACT_TYPE.eShiJieShouLing]='limitActInfo_worldleader',
[LIMIT_ACT_TYPE.eLunDaoDaHui]='limitActInfo_lundaodahui',
[LIMIT_ACT_TYPE.eWenDouLeiTai]='limitActInfo_poetryarena',
[LIMIT_ACT_TYPE.eXianMengDiGong]='limitActInfo_xianmengdigong',
[LIMIT_ACT_TYPE.eShangGuXianDi]='limitActInfo_shangguxiandi',
[LIMIT_ACT_TYPE.eXianFaWenDao]='limitActInfo_xianfawendao',
[LIMIT_ACT_TYPE.eYiYuHuiYou]='limitActInfo_yiyuhuiyou',
[LIMIT_ACT_TYPE.eLingXuWenJian]='limitActInfo_lingxuwenjian',
[LIMIT_ACT_TYPE.eLingZhenPengZhuang]='limitActInfo_lingzhenpengzhuang',
[LIMIT_ACT_TYPE.eZhengZhanShanHai]='limitActInfo_zhengzhanshanhai',
[LIMIT_ACT_TYPE.eShangHang]='limitActInfo_shanghang',
[LIMIT_ACT_TYPE.eChiSeJinDi]='limitActInfo_chisejindi',
[LIMIT_ACT_TYPE.eWenDingCangQiong]='limitActInfo_wendingcangqiong',
[LIMIT_ACT_TYPE.eXianJieFuMo]='limitActInfo_xianjiefumo',
[LIMIT_ACT_TYPE.eLeiTaiYanWu]='limitActInfo_leitaiyanwu',
[LIMIT_ACT_TYPE.eTongJiMoWu]='limitActInfo_tongjimowu',
[LIMIT_ACT_TYPE.eXianGuanWuXuan]='limitActInfo_xianguanwuxuan',
[LIMIT_ACT_TYPE.eXianGuanWenXuan]='limitActInfo_xianguanwenxuan',
[LIMIT_ACT_TYPE.eXianJieXingYu]='limitActInfo_xianjiexingyu',
[LIMIT_ACT_TYPE.eXianGuanWenXuan_BW]='limitActInfo_xianguanwenxuan_bw',
[LIMIT_ACT_TYPE.eXianGuanWuXuan_BW]='limitActInfo_xianguanwuxuan_bw',
[LIMIT_ACT_TYPE.eXianJie_RebuildPreview]='limitActInfo_xianjierebuildpreview',
[LIMIT_ACT_TYPE.eMoJieSaiJi]='limitActInfo_mojiesaiji',
[LIMIT_ACT_TYPE.eMoGongZhengDuo]='limitActInfo_mogongzhengduo',
[LIMIT_ACT_TYPE.eMoJiang]='limitActInfo_zhengtaomojiang',
[LIMIT_ACT_TYPE.eMoJieMoJun]='limitActInfo_mojiemojun',
[LIMIT_ACT_TYPE.eMiaoXingShangLv]='limitActInfo_miaoxingshanglv',
[LIMIT_ACT_TYPE.eMoJieShop]='limitActInfo_mojieshop',
}




local xianmengActLookup={
[LIMIT_ACT_TYPE.eTianYuanShouChao]={
jumpCheck=true,
leaveSort=1,
},
[LIMIT_ACT_TYPE.eXianMengDiGong]={
jumpCheck=true,
leaveSort=2,
},
[LIMIT_ACT_TYPE.eLingXuWenJian]={
leaveSort=1,
},
[LIMIT_ACT_TYPE.eZhengZhanShanHai]={
jumpCheck=true,
leaveSort=1,
},
}

local leaveXMActTips={
[LIMIT_ACT_TYPE.eTianYuanShouChao]=function()
return'仙盟活动期间退盟后无法获得活动奖励，是否确定退出？'
end,
[LIMIT_ACT_TYPE.eXianMengDiGong]=function()
local s='仙盟活动期间退盟后无法获得活动奖励'
local cur=moneyModel.getMoney(eMoneyType.mtDiGongContribute)
if cur>0 then
local gxConvert=cfgHelper.get2(cfg_guilddigongbaseconfig_get,1,'gxConvert')
local name1=moneyModel.getMoneyName(eMoneyType.mtDiGongContribute)
local num=math.ceil(cur*gxConvert)
local rate=1/gxConvert
local name2=moneyModel.getMoneyName(eMoneyType.mtGongXuan)
s=FMT.fmt('{0}\n（<color=#4d9939>{1}{2}</color>会{3}:1转化成<color=#4d9939>{4}{5}</color>）',s,cur,name1,rate,num,name2)
else
local xdlname=itemsConfig.getItemName(eMoneyType.mtDiGongXingDongLi)
s=FMT.fmt('{0}\n（仙盟地宫活动{1}会清空）',s,xdlname)
end
return s
end,
}


local doingPreviewConfig={
[LIMIT_ACT_TYPE.eTianYuanShouChao]=mainTipsType.eLimitAct_TYSC,
[LIMIT_ACT_TYPE.eShiJieShouLing]=mainTipsType.eLimitAct_SJSL,
[LIMIT_ACT_TYPE.eWenDingCangQiong]=mainTipsType.eLimitAct_WDCQ,
}

function limitActivitiesModel:isXMAct(actID)
return xianmengActLookup[actID]~=nil
end


function limitActivitiesModel:isXMActJumpCheck(actID)
local d=xianmengActLookup[actID]
if d then
return d.jumpCheck==true
end
return false
end


function limitActivitiesModel:checkHasXMActDoing()
for actID,v in pairs(xianmengActLookup)do
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
if actInfo:checkOpen()and actInfo:checkDoing()then
return true,actID
end
end
end
return false
end

function limitActivitiesModel:checkHasXMActDoing_tips()
local actID
local leaveSort
for actID_,v in pairs(xianmengActLookup)do
if leaveXMActTips[actID_]~=nil then
local actInfo=limitActivitiesModel:getActInfo(actID_)
if actInfo then
if actInfo:checkOpen()and actInfo:checkDoing()then
if actID==nil or leaveSort<v.leaveSort then
actID=actID_
leaveSort=v.leaveSort
end
end
end
end
end
if actID then
return true,actID
end
return false
end

function limitActivitiesModel:getLeaveXMActTips(actID)
local func=leaveXMActTips[actID]
if func then
return func()
end
return nil
end

function limitActivitiesModel:checkIsDoingPreview(actID)
return doingPreviewConfig[actID]
end