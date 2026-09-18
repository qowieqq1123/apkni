







UIFullTotalTouZiActivityontrol=gameState.addListener(fullScreenUI.create())
local _fixlist={}
local _fixlookup={}
local _fixTemp={}
local _fixChange={}
local _autolist={}
local _autolookup={}
local _tempSortTag={}
local _tempTable={}
local _freshListTag=false
local _freshFixListTag=false
local _menulist={}
local _autoReddot={}
local _autoReddotTemp={}
local _autoReddotFresh=false
local _autoTotalReddot=false
local _autoChangeTemp={}
local _activityLookup={}

TZ_CATCH_TYPE=
{
eXianShu=getEnumIdx(),
eLoginReward=getEnumIdx(),
eQianJiGe=getEnumIdx(),
eXFWD=getEnumIdx(),
eWXSD=getEnumIdx(),
eMYZSTXZ=getEnumIdx(),
}


local _ii=0
local function _index2()
_ii=_ii+1
return _ii
end

TZ_MENU_TYPE=
{
eXianShu=getEnumIdx(),
eLoginReward=getEnumIdx(),
eQJXSRewards=getEnumIdx(),
eXFLDRewards=getEnumIdx(),
eWXSDRewards=getEnumIdx(),
eOpenAcitivity=getEnumIdx(),
eMingYuanZhuSha_Txz=getEnumIdx(),
}



















local _menuConfig=
{
[TZ_MENU_TYPE.eXianShu]=
{
fix=true,
catch=TZ_CATCH_TYPE.eXianShu,
checkOpen=function()
return UIXianShuControl:isActivityOpen()
end,
lockTips=function()
return'仙书尚未开启'
end,
reddotType=REDDIT_SUB_TYPE.sXianShu,
viewNames={['UITouZiXianShuWin']={}},
showRawBg=true,
name='仙书',
iconFunc=function(data)
return"ui/windows/welfare/welfare_icon_atlas_pak.ab","icon_fulimeiriqiandao_2"
end,
selectIconFunc=function(data)
return"ui/windows/welfare/welfare_icon_atlas_pak.ab","icon_fulimeiriqiandao_1"
end,
sortfunc=function(id)
return 1
end,
timeFun=function(id,data,curTime)
local left=UIXianShuControl:getRemainingTime()
return left
end,
reddotFunc=function()
return UIXianShuControl:checkReddot()
end,
},
[TZ_MENU_TYPE.eLoginReward]=
{
fix=true,
catch=TZ_CATCH_TYPE.eLoginReward,
checkOpen=function()
return WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eLoginReward]()
end,
lockTips=function()
return'登陆好礼尚未开启'
end,
reddotType=REDDIT_SUB_TYPE.sLoginReward,
viewNames={['UILoginRewardWin']={}},
name='登陆好礼',
iconFunc=function(data)
return"ui/windows/welfare/welfare_loginreward_atlas_pak.ab","icon_dengluhaoli_2"
end,
selectIconFunc=function(data)
return"ui/windows/welfare/welfare_loginreward_atlas_pak.ab","icon_dengluhaoli_1"
end,
sortfunc=function()
return 2
end,
timeFun=function(id,data,curTime)
local open,left=welfareModel:checkInLoginRewarTime()
return left
end,
reddotFunc=function()
return welfareModel:checkLoginRewardReddot()
end,
},
[TZ_MENU_TYPE.eQJXSRewards]=
{
fix=true,
catch=TZ_CATCH_TYPE.eQianJiGe,
checkOpen=function()
return UIFullTotalTouZiActivityontrol:checkWindowQJXSOpen()
end,
lockTips=function()
return'上级密函尚未开启'
end,
reddotType=REDDIT_SUB_TYPE.sXianDiTouZi,
viewNames={['UITouZiQianJiGeSGXDRewardsWin']={}},
name='上级密函',
iconFunc=function(data)
return"ui/windows/totaltouziactivity/totaltouzi_atlas_pak.ab","image_shangjimihan_02"
end,
selectIconFunc=function(data)
return"ui/windows/totaltouziactivity/totaltouzi_atlas_pak.ab","image_shangjimihan_01"
end,
sortfunc=function()
return 3
end,
timeFun=function(id,data,curTime)
local endTime=mysteryWeekActivityModel:getXDTouZiMhTimeout()
local left
if endTime then

left=endTime-curTime
end
return left
end,
reddotFunc=function()
return mysteryWeekActivityModel:checkXuanShangReddot()or false
end,
},
[TZ_MENU_TYPE.eXFLDRewards]=
{
fix=true,
catch=TZ_CATCH_TYPE.eXFWD,
checkOpen=function()
return UIFullTotalTouZiActivityontrol:checkWindowXFLDOpen()
end,
lockTips=function()
return'仙法问道尚未开启'
end,
reddotType=REDDIT_SUB_TYPE.sLunDaoRewards,
viewNames={['UITouZiXFWDSessionRewardWin']={}},
name='仙法问道',
iconFunc=function(data)
return"ui/windows/totaltouziactivity/tzzh_xfwd_atals_pak.ab","icon_xianfalundao_02"
end,
selectIconFunc=function(data)
return"ui/windows/totaltouziactivity/tzzh_xfwd_atals_pak.ab","icon_xianfalundao_01"
end,
sortfunc=function()
return 4
end,
timeFun=function(id,data,curTime)
local isTruce=UIXianFaWenDaoControl:isInTruceTime()
local endTime
if not isTruce then
endTime=UIXianFaWenDaoControl:getSessionEndTime()
end
local left
if endTime then
left=endTime-curTime
end
return left
end,
reddotFunc=function()
return UIXianFaWenDaoControl:checkInvestReddot()
end,
},
[TZ_MENU_TYPE.eWXSDRewards]=
{
fix=true,
catch=TZ_CATCH_TYPE.eWXSD,
checkOpen=function()
return UIFullTotalTouZiActivityontrol:checkWindowWXSDOpen()
end,
lockTips=function()
return'圣殿尚未开启'
end,
reddotType=REDDIT_SUB_TYPE.sWuXingShengDianRewards,
viewNames={['UITouZiWuXingDianRewardsWin']={}},
name='五行圣殿',
iconFunc=function(data)
return"ui/windows/welfare/welfare_loginreward_atlas_pak.ab","icon_dengluhaoli_2"
end,
selectIconFunc=function(data)
return"ui/windows/welfare/welfare_loginreward_atlas_pak.ab","icon_dengluhaoli_1"
end,
sortfunc=function()
return 5
end,
timeFun=function(id,data,curTime)
local jie,endTime=wuXingDianModel:getCurJie()
local left
if endTime then
left=timeHelper.convertShortStamp(endTime)-curTime
end
return left
end,
reddotFunc=function()
local wxdId=wuXingDianConfig.getSDType()
return wuXingDianModel:hasAnyPrize(wxdId)
end,
},
[TZ_MENU_TYPE.eOpenAcitivity]=
{
reddotFunc=function(data)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
return activitiesModel:checkSubActReddot(actID,subType,subID)
end,
getParams=function(args)
if args==nil then return end
local data=args.baseTable
local cfg_args=args.addTable
local extraTable=args.extraTable
local params=table.deepCopy(data)
if cfg_args then
table.deepCopy(cfg_args,params,false)
end
params.extraParams=extraTable
return params
end,
viewNamesfunc=function(data)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
return activitiesModel:getSubPanelLookup(actID,subType,subID)
end,
namefunc=function(data)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
local sub_actcfg=activitiesModel:getSubActivityConfig(subType,subID)
return sub_actcfg.sub_name
end,
iconFunc=function(data)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
local tabIcons=cfgHelper.get2(cfg_subactivitytypeconfig_get,subType,'tabIcons')
if tabIcons then
return globalABLookup.activieSprites,tabIcons[2]
end
end,
selectIconFunc=function(data)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
local tabIcons=cfgHelper.get2(cfg_subactivitytypeconfig_get,subType,'tabIcons')
if tabIcons then
return globalABLookup.activieSprites,tabIcons[1]
end
end,
sortfunc=function(data)
return 6
end,
lockfunc=function(data)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
return not activitiesModel:checkSubActUnlock(actID,subType,subID)
end,



timeFun=function(id,data)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
return activitiesModel:getSubActEndLeftTime(actID,subType,subID)
end,
},
[TZ_MENU_TYPE.eMingYuanZhuSha_Txz]=
{
fix=true,
catch=TZ_CATCH_TYPE.eMYZSTXZ,
checkOpen=function()
return UIFullTotalTouZiActivityontrol:checkWindowMYZSTxzOpen()
end,
lockTips=function()
return'冥渊诛煞未开启'
end,
reddotType=REDDIT_SUB_TYPE.sMYZSTXZ,
viewNames={['UITouZiMYZS_TXZRewardsWin']={}},
name='冥渊诛煞',
iconFunc=function(data)
return"ui/windows/mingyuanzhusha/mingyuanzhusha_txz_atlas_pak.ab","icon__mingyzs_2"
end,
selectIconFunc=function(data)
return"ui/windows/mingyuanzhusha/mingyuanzhusha_txz_atlas_pak.ab","icon__mingyzs_1"
end,
sortfunc=function()
return 7
end,
timeFun=function(id,data)
return myzsModel:getTxzLeftTime()
end,
reddotFunc=function()
return myzsModel:getTxzReddot()
end,
},
}


function UIFullTotalTouZiActivityontrol:onAppStart()
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onActivityReddotChange,self.onActivityReddotChange)
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.onZongMengLevelChange)


local args={
fullType=FULL_TYPE.eTotalTouZiActivity,
}
self:initUI(args)
end

function UIFullTotalTouZiActivityontrol:onEnterState(isReconnect)
if isReconnect then return end
_fixlist={}
_fixlookup={}
_fixTemp={}
_autolist={}
_autolookup={}
_freshListTag=false
_freshFixListTag=false
_menulist={}
_autoReddot={}
_autoReddotFresh=false
_autoTotalReddot=false
_autoChangeTemp={}
timeEventController.addNormalTimerHandler(1,'UIFullTotalTouZiActivityontrol',self)
self.enterguid=nil
end

function UIFullTotalTouZiActivityontrol:onLeaveState(isReconnect)
if isReconnect then return end
_fixlist={}
_fixlookup={}
_fixTemp={}
_autolist={}
_autolookup={}
_freshListTag=false
_freshFixListTag=false
_menulist={}
_autoReddot={}
_autoReddotFresh=false
_autoTotalReddot=false
self.enterguid=nil
_autoChangeTemp={}
timeEventController.removeNormalTimerHandler(1,'UIFullTotalTouZiActivityontrol')

notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.onZongMengLevelChange)
end

function UIFullTotalTouZiActivityontrol:onProtocolReq()
self:initFixMenu()
self:initMenulist()
end

function UIFullTotalTouZiActivityontrol:onNormalUpdate(delay)
self:freshFixListByTag()
self:freshAllListByTag()
self:freshAutoReddotAndPost()
end

function UIFullTotalTouZiActivityontrol:showMenuWindow(argstable,warn)

if verifyManager:isHideBusinessActivity()then
return false
end
local list=self:getMenulist()
argstable=argstable or{}
local menuType=argstable.menuType
local id=argstable.id
local subIndex,subInfo=self:getMenuIndex(list,menuType,id)
if subIndex==nil and menuType then
if warn then
local tips=_menuConfig[menuType].lockTips(subInfo and subInfo.data or nil)
UIManager.error(tips)
end
return false
end
argstable.subIndex=subIndex or(self:getReddotMenuIndex(list)or 1)
local args={
showBg=false,
viewNames={'UICommonLeftMenuWin'},
viewArgs={['UICommonLeftMenuWin']=argstable},
}
return self:showUI(args)
end

function UIFullTotalTouZiActivityontrol:jumpWindow(menuType,id,warn)
id=id or 1
return self:showMenuWindow({menuType=menuType,id=id},warn)
end

function UIFullTotalTouZiActivityontrol:addOperActivity(tabType,data)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
local id=self:getOperActivityId(actID,subType,subID)
_activityLookup[actID]=true
return self:addAutoMenu(TZ_MENU_TYPE.eOpenAcitivity,id,tabType,data)
end

function UIFullTotalTouZiActivityontrol:removeOperActivity(data)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
local id=self:getOperActivityId(actID,subType,subID)
_activityLookup[actID]=nil
return self:removeAutoMenu(TZ_MENU_TYPE.eOpenAcitivity,id)
end

function UIFullTotalTouZiActivityontrol:checkJumpOperActivity(data)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
local id=self:getOperActivityId(actID,subType,subID)
local menuType=TZ_MENU_TYPE.eOpenAcitivity
if _activityLookup[actID]==nil then return false end
return true
end

function UIFullTotalTouZiActivityontrol:jumpOperActivity(data,warn)
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
local id=self:getOperActivityId(actID,subType,subID)
local menuType=TZ_MENU_TYPE.eOpenAcitivity
return self:jumpWindow(menuType,id,warn)
end

function UIFullTotalTouZiActivityontrol:getOperActivityId(actID,subType,subID)

return actID*10000+subType+subID*0.0001
end


function UIFullTotalTouZiActivityontrol:addAutoMenu(menuType,id,tabType,data)
id=id or 1
if _autolookup[menuType]and _autolookup[menuType][id]then return false end
local cfg=_menuConfig[menuType]
if cfg.reddotFunc==nil then
loggerUtil.debugErrFMT('类型{0}没有找到reddotFunc',menuType)
return false
end
if cfg.viewNamesfunc==nil then
loggerUtil.debugErrFMT('类型{0}没有找到viewNamesfunc',menuType)
return false
end
if cfg.namefunc==nil then
loggerUtil.debugErrFMT('类型{0}没有找到namefunc',menuType)
return false
end
if cfg.iconFunc==nil then
loggerUtil.debugErrFMT('类型{0}没有找到iconFunc',menuType)
return false
end
local t={}
t.cfg=cfg
t.menuType=menuType
t.id=id
t.data=data
t.tabType=tabType
_autolist[#_autolist+1]=t
if _autolookup[menuType]==nil then _autolookup[menuType]={}end
_autolookup[menuType][id]=t
_freshListTag=true
return true
end

function UIFullTotalTouZiActivityontrol:removeAutoMenu(menuType,id)
id=id or 1
if _autolookup[menuType]==nil or _autolookup[menuType][id]==nil then return false end
local t=_autolookup[menuType][id]
_autolookup[menuType][id]=nil
for i,v in ipairs(_autolist)do
if v.menuType==menuType and v.id==id then
table.remove(_autolist,i)
_freshListTag=true
return true
end
end
end

function UIFullTotalTouZiActivityontrol:sortMenu(list)
table.sort(list,function(a,b)
if a.menuType==b.menuType then
return a.id<b.id
end
return a.menuType<b.menuType
end)
end

function UIFullTotalTouZiActivityontrol:initFixMenu()
_freshFixListTag=false
table.clear(_fixChange)
table.clear(_fixlist)
table.clear(_fixlookup)
for menuType,v in pairs(_menuConfig)do
if v.fix then
if v.catch then
local catch=v.catch
if _fixChange[catch]==nil then _fixChange[catch]={}end
local fixTable=_fixChange[catch]
fixTable[#fixTable+1]=menuType
end
if v.checkOpen()then
local t={}
t.cfg=v
t.menuType=menuType
t.id=1
_fixlist[#_fixlist+1]=t
_fixlookup[menuType]=t
end
end
end
end

function UIFullTotalTouZiActivityontrol:freshFixListByTag()
if not _freshFixListTag then return end

_freshFixListTag=false
table.clear(_fixlist)
table.clear(_fixlookup)
for menuType,v in pairs(_menuConfig)do
if v.fix and v.checkOpen()then
local t={}
t.cfg=v
t.menuType=menuType
t.id=1
_fixlist[#_fixlist+1]=t
_fixlookup[menuType]=t
end
end
end

function UIFullTotalTouZiActivityontrol:onChanged(changeType)
local flag=false
local menuTypeList=_fixChange[changeType]
if menuTypeList and#menuTypeList>0 then
for _,menuType in ipairs(menuTypeList)do
local open=_menuConfig[menuType].checkOpen()
if _fixlookup[menuType]and not open then
flag=true
break
elseif _fixlookup[menuType]==nil and open then
flag=true
break
end
end
end
if not _freshListTag then
_freshListTag=flag
end
if not _freshFixListTag then
_freshFixListTag=flag
end
end

function UIFullTotalTouZiActivityontrol:initMenulist()
table.clear(_menulist)
for i,v in ipairs(_fixlist)do
_menulist[#_menulist+1]=v
end
for i,v in ipairs(_autolist)do
_menulist[#_menulist+1]=v
end
self:sortMenu(_menulist)

self:freshEnter()
end

function UIFullTotalTouZiActivityontrol:freshAllListByTag()
if _freshListTag then
_freshListTag=false
table.clear(_menulist)
for i,v in ipairs(_fixlist)do
_menulist[#_menulist+1]=v
end
for i,v in ipairs(_autolist)do
_menulist[#_menulist+1]=v
end
self:sortMenu(_menulist)

self:freshEnter()
end
end

function UIFullTotalTouZiActivityontrol:getMenulist()
self:freshAllListByTag()
return _menulist
end

function UIFullTotalTouZiActivityontrol:getMenuIndex(list,menuType,id)
if menuType==nil then return end
id=id or 1
for i,v in ipairs(list)do
if menuType==v.menuType and id==v.id then
return i,v
end
end
end

function UIFullTotalTouZiActivityontrol:getReddotMenuIndex(list)
for i,v in ipairs(list)do
if v.cfg.reddotFunc and v.cfg.reddotFunc(v.data)then
return i
end
end
end

function UIFullTotalTouZiActivityontrol:freshWin()
UIManager:callWindowFunc('UICommonLeftMenuWin','onChangeTab')
end


function UIFullTotalTouZiActivityontrol:checkWindowXFLDOpen()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianFaWenDao)then return false end
local ret=UIXianFaWenDaoControl:checkUnlock()
return ret
end

function UIFullTotalTouZiActivityontrol:checkWindowQJXSOpen()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eMiJingDangerMap)
if ret==false then return end


return true
end

function UIFullTotalTouZiActivityontrol:checkWindowWXSDOpen()
if not systemModel.isOpen(SYSTEM_DEFINE.eWuXingDian)then return false end
return wuXingDianModel:isOpenSDByData()
end

function UIFullTotalTouZiActivityontrol:checkWindowMYZSTxzOpen()
if not myzsModel:checkOpen()then return false end
if not myzsModel:getInitFinishFlag()then return false end
return myzsModel:checkOpenTxz()
end

function UIFullTotalTouZiActivityontrol.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eMiJingDangerMap then
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eQianJiGe)
elseif sysid==SYSTEM_DEFINE.eXianFaWenDao then
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eXFWD)
elseif sysid==SYSTEM_DEFINE.eWuXingDian then
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eWXSD)
elseif sysid==SYSTEM_DEFINE.eLoginGift then
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eLoginReward)
elseif sysid==SYSTEM_DEFINE.eMingYuanZhuSha then
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eMYZSTXZ)
end
end

function UIFullTotalTouZiActivityontrol.on_building_event(etype,sfId,ubdId,build_id)
if etype==buildingEvent.buildComplete then
if build_id==SLG_SYSTEM_TYPE.eQianJiGe then

elseif build_id==SLG_SYSTEM_TYPE.eDouFaTai then
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eXFWD)
end
end
end

function UIFullTotalTouZiActivityontrol.onActivityReddotChange(actid)
if _activityLookup[actid]==nil then return end
UIFullTotalTouZiActivityontrol:onAutoReddotChange()
end

function UIFullTotalTouZiActivityontrol.onZongMengLevelChange()
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eMYZSTXZ)
end



function UIFullTotalTouZiActivityontrol:freshEnter()

if verifyManager:isHideBusinessActivity()then
return false
end
local list=self:getMenulist()
if#list<=0 then
if self.enterguid then
enterManager:removeEnter(self.enterguid)
self.enterguid=nil
end
elseif#list>0 then
if self.enterguid==nil then
self.enterguid=enterManager:freshEnter({enterIconType=ENTER_ICON_TYPE.eNomal,
enterType=ENTER_TYPE.eTotalTouZiActivity})
end
end
end

function UIFullTotalTouZiActivityontrol:getTotalReddot()
self:freshAutoReddot()
local fixReddot=reddotClassManager.get_reddot(REDDIT_TYPE.eTotalTouZiActivity)
return fixReddot or _autoTotalReddot
end

function UIFullTotalTouZiActivityontrol:freshAutoReddotAndPost()
if _autoReddotFresh then
_autoReddotFresh=false
table.clear(_autoReddotTemp)
for k,v in pairs(_autoReddot)do
_autoReddotTemp[k]=v
end
table.clear(_autoReddot)
table.clear(_autoChangeTemp)
local total_reddot=false

for i,v in ipairs(_autolist)do
local menuType=v.menuType
local id=v.id
local old=_autoReddotTemp[menuType]and _autoReddotTemp[menuType][id]or false
local reddot=v.cfg.reddotFunc(v.data)or false

if _autoReddot[menuType]==nil then _autoReddot[menuType]={}end
_autoReddot[menuType][id]=reddot

total_reddot=total_reddot or reddot
if old~=reddot then
_autoChangeTemp[#_autoChangeTemp+1]={menuType,id}
end
end
if#_autoChangeTemp>0 then
notifySystem:postNotify(notifyConfig.onTouZiAutoReddotChange,_autoChangeTemp)
end
if total_reddot~=_autoTotalReddot then
_autoTotalReddot=total_reddot
notifySystem:postNotify(notifyConfig.onTouZiAutoTotalReddotChange)
end
end
end

function UIFullTotalTouZiActivityontrol:freshAutoReddot()
if _autoReddotFresh then
_autoReddotFresh=false
table.clear(_autoReddotTemp)
for k,v in pairs(_autoReddot)do
_autoReddotTemp[k]=v
end
table.clear(_autoReddot)
local total_reddot=false

for i,v in ipairs(_autolist)do
local menuType=v.menuType
local id=v.id
local old=_autoReddotTemp[menuType]and _autoReddotTemp[menuType][id]or false
local reddot=v.cfg.reddotFunc(v.data)or false

if _autoReddot[menuType]==nil then _autoReddot[menuType]={}end
_autoReddot[menuType][id]=reddot

total_reddot=total_reddot or reddot
end
end
end

function UIFullTotalTouZiActivityontrol:onAutoReddotChange()
_autoReddotFresh=true
end

function UIFullTotalTouZiActivityontrol:getMinLeftTime()
local minLeftTime
local list=self:getMenulist()
if#list>0 then
local nowTime=timeHelper.getServerShortTime()
local menuType,id,timeFun,flag
for i,v in ipairs(list)do
menuType=v.menuType
id=v.id
timeFun=_menuConfig[menuType].timeFun
flag=false
if _menuConfig[menuType].fix then
if _menuConfig[menuType].checkOpen()then
flag=true
end
else
flag=true
end
if flag and timeFun then
local leftTime=timeFun(v.id,v.data,nowTime)
if leftTime and leftTime>0 then
if minLeftTime then
if minLeftTime>leftTime then
minLeftTime=leftTime
end
else
minLeftTime=leftTime
end
end
end
end
end
return minLeftTime
end
