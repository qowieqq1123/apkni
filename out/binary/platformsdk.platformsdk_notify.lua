platformSDK_notify=gameState.addListener({})
local platformNotifyClass
platformNotifyType=
{

eChuanSongZhenYouLi='setChuanSongZhenYouLiNotifyTime',
eZMLingPai='setZMLingPaiNotifyTime',
eTianYuanShouChao='setTianYuanShouChaoNotifyTime',
}

platformNotifyUpdateType=
{
eInit=0,
eUpdate=1,
eChanged=2,
}


local _platformType=
{
['platformSDK_Android_XingJia']=
{
['ViVo']=true,
},
['platformSDK_iOS_XJ']=
{
['GuanBaoiOS']=true,
},
['platformSDK_Android_HWFT']=
{
['Efun']=true,
},
['platformSDK_iOS_EFun']=
{
['Efun']=true,
},
['platformSDK_iOS_EFun_Eu']=
{
['Efun']=true,
},
['platformSDK_iOS_EFun_US']=
{
['Efun']=true,
},
}









function platformSDK_notify:onAppStart()
notifySystem:listenNotify(notifyConfig.onTravelChange,self.onTravelChange)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChange)
notifySystem:listenNotify(notifyConfig.onTravelReward,self.onTravelChange)
end

function platformSDK_notify:onProtocolReq(isReconnect)


platformSDK_notify:notifyTianYuanShouChao(platformNotifyUpdateType.eInit)
end

function platformSDK_notify:onEnterState()
timeEventController.addNormalTimerHandler(1,'platformSDK_notify',self)
end

function platformSDK_notify:onLeaveState()
timeEventController.removeNormalTimerHandler(1,'platformSDK_notify')
end

function platformSDK_notify:onNormalUpdate()
platformSDK_notify:notifyTianYuanShouChao(platformNotifyUpdateType.eUpdate)
end

function platformSDK_notify:requireNotifyClass(platform_name)
local pfid=loginModel:getPfid()
local className=cfgHelper.get3(cfg_pfcommonconfig_get,1,'notify',pfid)
if className==nil then return end
if _platformType[platform_name]==nil or _platformType[platform_name][className]==nil then return end
platformNotifyClass=require(string.format('lua.platformSDK.%s_%s',platform_name,className))
end

function platformSDK_notify:notify(notifyType,updateType,args)
if platformNotifyClass==nil then return end

updateType=updateType or platformNotifyUpdateType.eChanged





platformSDK:invoke(notifyType,updateType,args)
end



function platformSDK_notify:notifyChuanSongZhenYouLi(updateType)
platformSDK_notify:notify(platformNotifyType.eChuanSongZhenYouLi,updateType)
end

function platformSDK_notify:notifyZMLingPai(updateType)
platformSDK_notify:notify(platformNotifyType.eZMLingPai,updateType)
end

function platformSDK_notify:notifyTianYuanShouChao(updateType)
platformSDK_notify:notify(platformNotifyType.eTianYuanShouChao,updateType)
end

function platformSDK_notify.onTravelChange()
platformSDK_notify:notifyChuanSongZhenYouLi()
end

function platformSDK_notify.onMoneyChange(moneyType,lastVal,val)
if moneyType==eMoneyType.mtLingPai and lastVal>=10 and val<10 then
platformSDK_notify:notifyZMLingPai()
end
end
