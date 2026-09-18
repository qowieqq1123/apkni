







local pageWinList={
[1]="UICommonPageWin",
[2]="UICommonPageTwoWin",
[3]="UICommonPageThreeWin",
}

local orderDescLookup={
[GUILD_ORDER_TYPE.eAutoDuJie]=function(orderID,isActive,isColor)
local str=''
if isActive then
local setup,cfg=guildOrderModel:getSetupData(orderID)

local idx=setup.jjcengIndex
local jjceng=cfg.jjcengRange[idx]
str=FMT.fmt('{0}期及以下',UIDiscipleModel:getJJFloorName(jjceng))
if isColor then
str=toColorString(FONT_COLOR.eBlueColor,str)
end

end
local desc=cfgHelper.get2(cfg_guildorderconfig_get,orderID,'desc')
return FMT.fmt(desc,str)
end,
[GUILD_ORDER_TYPE.eQuicklyZhaoMu]=function(orderID,isActive,isColor)
local str=''
if isActive then
local setup,cfg=guildOrderModel:getSetupData(orderID)
local colorFlaglist=setup.colorFlaglist
local colorvalue={2,3,4,5}
local list={}
for k,v in ipairs(colorFlaglist)do
if v==1 then
list[#list+1]=colorvalue[k]
end
end

local c=#list
if c>0 then
for i=1,c do
local color=list[i]
local c_str=eQualityColorName[color]
if isColor then
c_str=toColorString(color,c_str)
end
if i<c then
str=FMT.fmt('{0}{1}、',str,c_str)
else
str=FMT.fmt('{0}{1}',str,c_str)
end
end
end

local desc=cfgHelper.get2(cfg_guildorderconfig_get,orderID,'desc')
return FMT.fmt(desc,str)
else
local newstr='引仙台可自动拒绝弟子'
return newstr
end
end,
}








local orderSetupConfig={
[GUILD_ORDER_TYPE.eAutoDuJie]={
init=function(self_,setup)
setup.isOpen=true
setup.jjcengIndex=1
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
cfg.jjcengRange={1,2,3,4,5}
local extraUnlock=cfgHelper.get2(cfg_guildorderconfig_get,GUILD_ORDER_TYPE.eAutoDuJie,'extraUnlock')
if extraUnlock then
local jjcengRange={}
for i,v in ipairs(extraUnlock)do
table.insert(jjcengRange,i)
end
cfg.jjcengRange=jjcengRange
end
self_.cfg=cfg
end
return self_.cfg
end,
refresh=function(self_,setup)
local flag=false
local cfg=self_:getCfg()
local rangeNum=#cfg.jjcengRange
if setup.jjcengIndex>rangeNum then
setup.jjcengIndex=rangeNum
flag=true
end
return flag
end,
active_autoAdd=true,
open_autoAddd=true,
setup_autoAdd=true,
},
[GUILD_ORDER_TYPE.eQuicklyZhaoMu]={
init=function(self_,setup)
setup.isOpen=false
setup.colorFlaglist={0,0,1,1}
setup.specialityPreviewFlaglist={1,1,1,1,1}
setup.specialityLoveList=UIDiscipleModel.getSpecialityLoveListByGuildOrder()
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}

cfg.colorList={eQualityColor.eBlue,eQualityColor.ePurple,eQualityColor.eOrange,eQualityColor.eRed}

local proskillList={4,3,2,1,5}
cfg.specialityPreviewlist=proskillList
self_.cfg=cfg
end
return self_.cfg
end,
refresh=function(self_,setup)
local flag=false
local cfg=self_:getCfg()
if not setup.colorFlaglist then


setup.colorFlaglist={0,0,1,1}
flag=true
elseif#setup.colorFlaglist==5 then

setup.colorFlaglist[5]=nil
flag=true
end
if not setup.specialityPreviewFlaglist then
setup.specialityPreviewFlaglist={1,1,1,1,1}
flag=true
end
local list,flag2=UIDiscipleModel.getSpecialityLoveListByGuildOrder(setup.specialityLoveList)
if flag2 then
setup.specialityLoveList=list
flag=true
end
return flag
end,
},
[GUILD_ORDER_TYPE.eAutoBuy]={
init=function(self_,setup)
setup.isOpen=true
setup.moneyFlag=0
setup.equipColorIndex=1
setup.jjDanYaoIndex=1
setup.ltDanYaoIndex=1
setup.clColorIndex=1
setup.elseFlag=0
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
cfg.moneyRange={eMoneyType.mtLingShi,eMoneyType.mtLingYu}

cfg.equipColorRange={-1,eQualityColor.eGreen,eQualityColor.eBlue,eQualityColor.ePurple}

cfg.jjDanYaoRange={-1,eQualityColor.eGreen,eQualityColor.eBlue,eQualityColor.ePurple}

cfg.ltDanYaoRange={-1,eQualityColor.eGreen,eQualityColor.eBlue,eQualityColor.ePurple}

cfg.clColorRange={-1,1,2,3,4,5}

cfg.elseRange={
{2,4,'加速仙符'},{8,2,'资源宝箱'},
{10,nil,'丹方'},{2,8,'招募令'},
{2,6,'装备精炼石'},
{2,7,'古宝升星石'},{7,4,'寿元丹'},
{2,5,'许愿币'},{7,6,'疗伤丹'},{2,13,'法宝天精石'},
{2,14,'灵植种子'},
}
self_.cfg=cfg
end
return self_.cfg
end,
refresh=function(self_,setup)
local flag=false
local cfg=self_:getCfg()
local num
num=#cfg.equipColorRange
if setup.equipColorIndex>num then
setup.equipColorIndex=num
flag=true
end
num=#cfg.jjDanYaoRange
if setup.jjDanYaoIndex>num then
setup.jjDanYaoIndex=num
flag=true
end
num=#cfg.ltDanYaoRange
if setup.ltDanYaoIndex>num then
setup.ltDanYaoIndex=num
flag=true
end
num=#cfg.ltDanYaoRange
if setup.clColorIndex>num then
setup.clColorIndex=num
flag=true
end
return flag
end,
},
[GUILD_ORDER_TYPE.eAutoCleaning]={
init=function(self_,setup)
setup.isOpen=true
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
self_.cfg=cfg
end
return self_.cfg
end,
active_autoAdd=true,
open_autoAddd=true,
},
[GUILD_ORDER_TYPE.eAutoTreat]={
init=function(self_,setup)
setup.isOpen=true
setup.useItemFlag=1
setup.dzSelectFlag=bitHelper.set_0(2^14-1,13-1)
setup.fightRankSelectIndex=1
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}

cfg.useItemList={

{11501,"紫品寿元丹"},
{11502,"橙品寿元丹"},
{11503,"红品寿元丹"},
}

cfg.dzSelectList={




{id=1,2,60,1,"弟子战力排行（<color=#7d3b17>宗门前{0}名</color>）",{selectRange={5,6,10,15}}},
{id=14,3,10,7,"斗法台、宗门大比、论道大会防守弟子"},

{id=2,1,53,2,"生产建筑弟子",{win_type=1,bdTypeList={[SLG_SYSTEM_TYPE.eLianDanFang]=true,[SLG_SYSTEM_TYPE.eYiFangLingTian]=true,[SLG_SYSTEM_TYPE.eJuTianYi]=true,[SLG_SYSTEM_TYPE.eJuTianYi]=true,[SLG_SYSTEM_TYPE.eZaoWuGe]=true}}},
{id=3,1,52,2,"商铺弟子",{win_type=4}},
{id=4,1,51,2,"坊市弟子",{bdType=SLG_SYSTEM_TYPE.eFangShi}},
{id=5,1,50,2,"仙栈弟子",{bdType=SLG_SYSTEM_TYPE.eXianZhan}},
{id=6,1,40,3,"悟道堂弟子"},
{id=7,1,30,4,"传送阵弟子"},
{id=8,1,24,5,"掌门",{postType=eZongMenPostType.eZhangMen}},
{id=9,1,23,5,"传功长老",{postType=eZongMenPostType.eChuanGong}},
{id=10,1,22,5,"接引长老",{postType=eZongMenPostType.eJieYin}},
{id=11,1,21,5,"戒律长老",{postType=eZongMenPostType.eJielu}},
{id=12,1,20,5,"镇狱长老",{postType=eZongMenPostType.eZhenYu},{1,SLG_SYSTEM_TYPE.eLaoYu}},
{id=13,1,0,6,"闲置弟子"},
}
self_.cfg=cfg
end
return self_.cfg
end,
active_autoAdd=true,
open_autoAddd=true,
},
[GUILD_ORDER_TYPE.eMysteryMoveAcc]={
init=function(self_,setup)
setup.isOpen=true
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
self_.cfg=cfg
end
return self_.cfg
end,
},

[GUILD_ORDER_TYPE.eZongMenGenTi]={
init=function(self_,setup)
setup.isOpen=false
setup.daystate={1,0,0,0}
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
self_.cfg=cfg
end
return self_.cfg
end,
},

[GUILD_ORDER_TYPE.eMysteryAuto]={
init=function(self_,setup)
setup.isOpen=true
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
self_.cfg=cfg
end
return self_.cfg
end,
},
[GUILD_ORDER_TYPE.eAutoFightMonster]={
init=function(self_,setup)
setup.isOpen=true
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
self_.cfg=cfg
end
return self_.cfg
end,
active_autoAdd=true,
open_autoAddd=true,
},
[GUILD_ORDER_TYPE.eAutoShengChan]={
init=function(self_,setup)
setup.isOpen=true
setup.scFlaglist={0,0,0,0,0,0}
setup.scbuildList={2,3,4,7,8,9}
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
local buildList={2,3,4,7,8,9}
cfg.buildList=buildList
self_.cfg=cfg
end
return self_.cfg
end,
active_autoAdd=true,
open_autoAddd=true,
},
[GUILD_ORDER_TYPE.eAutoAttendClass]={
init=function(self_,setup)
setup.isOpen=false
setup.selectId=1
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
self_.cfg=cfg
end
return self_.cfg
end,
checkOpenWin=function()
local bdData=UISchoolModel:getSchoolBDData()
if not bdData then
local name=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eXueShiShuYuan,'name')
UIManager.error(FMT.fmt('请先建造{0}',name))
return false
end
return true
end,
active_autoAdd=true,
open_autoAddd=true,
},
[GUILD_ORDER_TYPE.eAutoFireFighting]={
init=function(self_,setup)
setup.isOpen=true
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
self_.cfg=cfg
end
return self_.cfg
end,
},
[GUILD_ORDER_TYPE.eAutoCaoLing]={
init=function(self_,setup)
setup.isOpen=true
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}
self_.cfg=cfg
end
return self_.cfg
end,
},
[GUILD_ORDER_TYPE.eAutoBaiShan]={
init=function(self_,setup)
setup.isOpen=false
setup.colorFlaglist={0,0,1,1}
setup.specialityPreviewFlaglist={1,1,1,1,1}
setup.specialityLoveList=UIDiscipleModel.getSpecialityLoveListByGuildOrder()
end,
getCfg=function(self_)
if self_.cfg==nil then
local cfg={}

cfg.colorList={eQualityColor.eBlue,eQualityColor.ePurple,eQualityColor.eOrange,eQualityColor.eRed}

local proskillList={4,3,2,1,5}
cfg.specialityPreviewlist=proskillList
self_.cfg=cfg
end
return self_.cfg
end,
refresh=function(self_,setup)
local flag=false
if not setup.colorFlaglist then


setup.colorFlaglist={0,0,1,1}
flag=true
elseif#setup.colorFlaglist==5 then

setup.colorFlaglist[5]=nil
flag=true
end
if not setup.specialityPreviewFlaglist then
setup.specialityPreviewFlaglist={1,1,1,1,1}
flag=true
end
local list,flag2=UIDiscipleModel.getSpecialityLoveListByGuildOrder(setup.specialityLoveList)
if flag2 then
setup.specialityLoveList=list
flag=true
end
return flag
end,
},
}

function guildOrderModel:checkOpenWin(otype)
local data=orderSetupConfig[otype]
if data then
if data.checkOpenWin then
local ret=data.checkOpenWin()
return ret
else
return true
end
else
logErr('不存在法令配置数据，id=',otype)
return false
end
end

function guildOrderModel:initSetupConfig()
for orderID,v in pairs(orderSetupConfig)do
v.orderID=orderID
v.isRefreh=false
end
end

function guildOrderModel:getOrderDesc(orderID,isActive,isColor)
local func=orderDescLookup[orderID]
if func then
return func(orderID,isActive,isColor)
else
local desc=cfgHelper.get2(cfg_guildorderconfig_get,orderID,'desc')
return desc
end
end


function guildOrderModel:isOrderSetupOpen(orderID)
local setup=guildOrderModel:getSetupData(orderID)
return setup.isOpen
end


function guildOrderModel:isOrderSetupOpenEx(orderID)
return guildOrderModel:checkOrderActive(orderID)and guildOrderModel:isOrderSetupOpen(orderID)
end

function guildOrderModel:getSetupData(orderID)
local key=tostring(orderID)

local list=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eFaLing)
if not list then
list=userActorSetting.get('guildOrderSetup',{})
end

local setup=list[key]

local isflush=false
local cfg=orderSetupConfig[orderID]
if setup==nil then
setup={}
cfg:init(setup)
list[key]=setup



serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eFaLing,list)
else

if not cfg.isRefreh then
if cfg.refresh then
local flag=cfg:refresh(setup)
if flag then

serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eFaLing,list)
end
end
cfg.isRefreh=true
end
end
return setup,cfg:getCfg()
end

function guildOrderModel:flushSetupData(orderID)

local list=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eFaLing)
if not list then
list=userActorSetting.get('guildOrderSetup',{})
end
serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eFaLing,list)
UIManager:invokeUIMethod('UIGuildOrderWin','onOrderSetupChange',orderID)
end

function guildOrderModel:changeSetupOpen(orderID,isOpen)
if isOpen then
local cfg=orderSetupConfig[orderID]
if cfg.open_autoAddd then
guildOrderController:addAI(orderID)
end
else
guildOrderController:removeAI(orderID)
end
end

function guildOrderModel:changeSetupData(orderID)
local cfg=orderSetupConfig[orderID]
if cfg.setup_autoAdd then
guildOrderController:addAI(orderID)
end
end

function guildOrderModel:activeSetup(orderID)
local cfg=orderSetupConfig[orderID]
if cfg.open_autoAddd then
guildOrderController:checkAddAI(orderID)
end
end

function guildOrderModel:openSetupWin(orderID,args)
if not guildOrderModel:checkOpenWin(orderID)then
return
end
local ordercfg=cfgHelper.get1(cfg_guildorderconfig_get,orderID)
local setupWin=ordercfg.setupWin
if setupWin==nil then return end

local winname=setupWin[1]
local titleName=setupWin[2]
local pageType=setupWin[3]or 1
local pageWinName=pageWinList[pageType]
args=args or{}
args.titleName=titleName
args.extraWin=winname
args.extraParams=args.extraParams or{}
UIManager:showWindow(pageWinName,args)
end


function guildOrderModel:test_clearLocalSetupData(orderID)
local list=userActorSetting.get('guildOrderSetup',{})
local key=tostring(orderID)
list[key]=nil
userActorSetting.set('guildOrderSetup',list)
userActorSetting.flush()
end