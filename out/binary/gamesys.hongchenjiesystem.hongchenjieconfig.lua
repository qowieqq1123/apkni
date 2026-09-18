





HongChenJieRefreshIdentityState={
normal=0,
restart=1,
refresh=2,
}

HongChenJieDiscipleAttrTypeEnum={
ZiZhi=1,
GenGu=2,
CongHui=3,
QianLi=4,
MeiLi=5,
JiYuan=6,
ShouYuan=7,
XianYuan=8,
}

HongChenJieDiscipleAttrNameList={
[HongChenJieDiscipleAttrTypeEnum.ZiZhi]='资质',
[HongChenJieDiscipleAttrTypeEnum.GenGu]='根骨',
[HongChenJieDiscipleAttrTypeEnum.CongHui]='聪慧',
[HongChenJieDiscipleAttrTypeEnum.QianLi]='潜力',
[HongChenJieDiscipleAttrTypeEnum.MeiLi]='魅力',
[HongChenJieDiscipleAttrTypeEnum.JiYuan]='机缘',
[HongChenJieDiscipleAttrTypeEnum.ShouYuan]='寿元',
[HongChenJieDiscipleAttrTypeEnum.XianYuan]='仙缘',
}

HongChenJieDiscipleAttrNameToArtWordName={
[HongChenJieDiscipleAttrTypeEnum.ZiZhi]='a',
[HongChenJieDiscipleAttrTypeEnum.GenGu]='b',
[HongChenJieDiscipleAttrTypeEnum.CongHui]='c',
[HongChenJieDiscipleAttrTypeEnum.QianLi]='d',
[HongChenJieDiscipleAttrTypeEnum.MeiLi]='e',
[HongChenJieDiscipleAttrTypeEnum.JiYuan]='f',
[HongChenJieDiscipleAttrTypeEnum.ShouYuan]='g',
[HongChenJieDiscipleAttrTypeEnum.XianYuan]='h',
}

HONGCHENJIE_EVENT_TYPE={
Base=1,
Result=2,
SmallDisicion=3,
BigDisicion=4,
}

HONGCHENJIE_COM_TYPE={
Base=1,
Result=2,
Disicion=3,
}

HONGCHENJIE_COM_TYPE_NAME={
[HONGCHENJIE_COM_TYPE.Base]='HCJ_EventItem_Base',
[HONGCHENJIE_COM_TYPE.Result]='HCJ_EventItem_Result',
[HONGCHENJIE_COM_TYPE.Disicion]='HCJ_EventItem_Decision',

}

HONGCHENJIE_Event_Effect_TYPE={
AddJingJie=1,
AddAttribute=2,
ReduceAttribute=3,
ChangeTag=4,
NextEvent=5,
ReducePercentAttribute=6,
GameEnd=7,
ChangeName=9,
}

local jzRes={
[HONGCHENJIE_EVENT_TYPE.SmallDisicion]='frame_hongchenjie_sj3',
[HONGCHENJIE_EVENT_TYPE.BigDisicion]='frame_hongchenjie_sj4'
}

local kuangRes={
[HONGCHENJIE_EVENT_TYPE.SmallDisicion]='frame_hongchenjie_sj4-2',
[HONGCHENJIE_EVENT_TYPE.BigDisicion]='frame_hongchenjie_sj5'
}

local systemNotifyEnum={
eJCTJ=1,
}

local systemNotifyList={
[systemNotifyEnum.eJCTJ]={
notifyFunc=function(id)
notifySystem:postNotify(notifyConfig.onJctjProgressChange)
end
}
}

local rankingConditionType={
eLiLianCount=3,
eEventTriggerCount=4,
eIdentityLiLianCount=5,
}

hongChenJieConfig={}

function hongChenJieConfig.getBaseInfo(id,name)
return cfgHelper.get2(cfg_hongchenjiebaseconfig_get,id,name)
end

local descParamType={
gameName=1,
gameSex=2,
playerZMName=3,
llDiscipleJJ=4,
}

function hongChenJieConfig.analysisDescParam(id,params)
local info=hongChenJieModel:getGameHandle(id)
local tparams={}
for k,data in ipairs(params)do
local type=data[1]
if type==descParamType.gameName then
local name=info:getIdentityName()
table.insert(tparams,name)
elseif type==descParamType.gameSex then
local sex=info:getSex()
table.insert(tparams,sex)
elseif type==descParamType.playerZMName then
local zmName=UISettingModel:getZMName()
table.insert(tparams,zmName)
elseif type==descParamType.llDiscipleJJ then
local level=info:getJingJie()
local jjName=info:getJingJieName(level)
table.insert(tparams,jjName)
end
end
return tparams
end

function hongChenJieConfig.getEventTxt(id,eventCfg)
local text=eventCfg.text
if eventCfg.text_params~=nil then
local param=hongChenJieConfig.analysisDescParam(id,eventCfg.text_params)
text=FMT.fmt(text,unpack(param))
end
return text
end

function hongChenJieConfig.getDecisionJZAndKuangResName(type)
return jzRes[type],kuangRes[type]
end

function hongChenJieConfig.getPostNotifyProgress(id)
local notifyType=hongChenJieConfig.getBaseInfo(id,'notifyType')
if systemNotifyList[notifyType]then
return systemNotifyList[notifyType]
end
end

function hongChenJieConfig.getEventAttrChangeBgIconName(type,val)
if type==HongChenJieDiscipleAttrTypeEnum.XianYuan then
return'image_hongchenjie_30'
else
if val>0 then
return'image_hongchenjie_28'
else
return'image_hongchenjie_29'
end
end
end

function hongChenJieConfig.getRankingTipSuffix(rankData)
local suffix=""
if rankData.cfg.condition then
local condition=rankData.cfg.condition
local type=condition[1]
local count=rankData.count

if rankingConditionType.eLiLianCount==type then
local totalVal=condition[2]
suffix=FMT.fmt("({0}/{1})",count,totalVal)






end
end

return suffix
end