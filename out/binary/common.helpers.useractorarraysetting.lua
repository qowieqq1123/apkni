
userActorArraySetting={}
local configArray={}
local userPathArray={}
local delayFlushTimer=nil
local delayFlushTypo={}
local delayTimer=nil
ACTOR_SETTING_TYPE=
{
eEvent=1,
eWorldPosition=2,
eAuction=3,
eZongmenRandomObject=4,
eDZNote=5,
eMulTeam=6,
eSundrise=7,
eLianDanDaHui=8,
eJiuCengYaoLou=9,
ePlayerImage=10,
eZongMenDaBi=11,
eFilterSetting=12,
eXianFaWenDao=13,
eCangBaoTu=14,
eXianMengDiGong=15,
eMail=16,
eResMystery=17,
eGetItem=18,
eTongTianXianShi=19,
eWeakData=20,
eYueLongChi=21,
eFabao=22,
eXiaoDaoTong=23,
eFaceAdvert=24,
eLunDaoDaHui=25,
eLingXuWenJian=26,
eLianDan=27,
eBaoLingShu=28,
eZongMenDesign=29,
eGoodReviews=30,
eWBJSActChange=31,

eXianShiChouKa=32,
eActPreview=33,
eDiZiCreateImage=34,
eMyZongMenLayout=35,
eTaskNum=36,
eActFaBaoMiLu=37,
eChat=38,
eSLMBAct=39,
eActXianGuYiJi=40,
eActXMTQ=41,
eXianJieQiYuan=42,
eZhengZhanShanHai=43,
eDongtianfudi=44,
ePushThreeGift=45,
eLZPZGameData=46,
eShangHangData=47,
eTestTagData=48,
eActivitiesPlot=49,
eZzshPvpBalance=50,
ePushSelectItem=51,
eSystemZongMenFightRecord=52,
eActSkipAnimation=53,
ePlatformNotify=54,
eWXGameCircle=55,
eSiFangPingYao=56,
eJiuChongTianJie=57,
eChiSeJinDi=58,
eActivityCalendar=59,
eSelectLiBao=60,
eExChangeShop2=61,
eZhenYaoShiLian=62,
elingZhenPengZhuang=63,
eRolelingZhenPengZhuang=64,

ePrivateChat=65,
eDuiHuanHuoDong=66,
eWenDingCangQiong=67,
eZhongQiuDengMi=68,

eTask=70,
eXiWeiSai=71,
eXJYunZhouTeam=72,
eXianjiePoints=73,
eUIAquariumSellFilterWin=74,
eXJFilter=75,
eXianTuChengJiu=76,
eOneTimeReddot=77,
eWorldBigBoss=78,
eAutoClassResult=79,

eWenXinGuan=69,
eWenXinGuanTran=80,

eXJJiJieLocal=81,
eTianShuDaZhen=82,
eActEnterOnce=83,

eSeasonSystem=84,
eXianJieFuMo=85,
eDownLoadFileProgress=86,
eXianGuanJingXuan=87,

eSettingTypeExperience=88,

eXunYouWanJie=89,
eGetXMEquip=90,
eXianShiYaoWu=91,
eGetyzEquip=92,

eXMUnionGroup=93,
eXianYuanXunFang=94,
eXingYu=95,

eXianYunBaoGe=96,
eXJYZYunZhouTeam=97,
eXJYZPlot=98,

eWanLingTa=99,
eMoJiang=100,
eLingShan=101,
eMoJun=102,
eZMAttack=103,
eMJYGPlay=104,
eJYZFStageChange=105,
eMoJie=106,
eActivityReddotShow=107,
eServerTransfer=108,
eZhenTai=109,
eXianMengHongBaoAct=110,
}

function userActorArraySetting.init(username)
local appKey=string.gsub(username,'[\\/:*?\"<>|]','_')
for _,v in pairs(ACTOR_SETTING_TYPE)do
local userpath=FMT.fmt('actor_{0}_{1}.json',appKey,v)
userPathArray[v]=userpath
local e,s=pcall(function()configArray[v]=jsonHelper.readFile(userpath,{})end)
if not e then
configArray[v]={}
end
end

delayFlushTypo={}
end

function userActorArraySetting.leaveGame()

userActorArraySetting.doDelayFlush()
end

function userActorArraySetting.getBase(typo,defaultValue)
local config=configArray[typo]
if config==nil then
config=defaultValue
configArray[typo]=config
end
return config
end

function userActorArraySetting.setBase(typo,value)
if type(value)~='table'then return end
configArray[typo]=value or{}
end

function userActorArraySetting.get(typo,key,defaultValue)
local config=configArray[typo]or{}
local v=config[key]
if v==nil then
return defaultValue
end
return v
end

function userActorArraySetting.set(typo,key,value)
if configArray[typo]==nil then configArray[typo]={}end
local config=configArray[typo]
config[key]=value
end


function userActorArraySetting.flushVal(typo,key,value,defaultValue)
if configArray[typo]==nil then configArray[typo]={}end
local config=configArray[typo]
local lastVal=config[key]
if lastVal==nil then
lastVal=defaultValue
end
if lastVal~=value then
config[key]=value
userActorArraySetting.flush(typo)
end
end

function userActorArraySetting.remove(typo,key)
if configArray[typo]==nil then return end
local config=configArray[typo]
if config then
config[key]=nil
end
end



function userActorArraySetting.flush(typo,onlgSetDirty)
if configArray[typo]==nil then return end

if onlgSetDirty then

delayFlushTypo[typo]=true
if delayFlushTimer==nil then
delayFlushTimer=FrameTimer.New(userActorArraySetting.doDelayFlush,1,0)
delayFlushTimer:Start()
end
return
end

local config=configArray[typo]
local userpath=userPathArray[typo]

jsonHelper.writeFile(userpath,config)
end

function userActorArraySetting.flushDelay(typo)
if configArray[typo]==nil then return end

delayFlushTypo[typo]=true
if delayTimer==nil then
delayTimer=timer.new()
delayTimer:start(0.1,userActorArraySetting.doDelayFlush)
return
end
end

function userActorArraySetting.doDelayFlush()
if delayFlushTimer or delayTimer then
if delayTimer then
delayTimer:cancel()
end
delayTimer=nil

if delayFlushTimer then
delayFlushTimer:Stop()
end
delayFlushTimer=nil
for typo,v in pairs(delayFlushTypo)do
local config=configArray[typo]
local userpath=userPathArray[typo]

jsonHelper.writeFile(userpath,config)
end
delayFlushTypo={}
end
end

function userActorArraySetting.clear(typo)
configArray[typo]={}
end
