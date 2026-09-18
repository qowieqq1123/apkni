payControl=gameState.addListener({})

function payControl:onAppStart()

end



function payControl:onProtocolReq()

end

function payControl:initXianQuan()
local pfId
if not deviceHelper.isRunNoneOrEditor()then
pfId=gameInfo:getPfid()
else
pfId=CS.AppDataModel.AppConfig_GetInt("pfid",0)
end
if pfId>0 then
self:initXianQuanCfg(pfId)
else
self.skipXianQuanDict={}
self.activeXianQuanShop=false
self.skipAllXianQuanAmount=false
end
end

local OpenAmountType={
XIANYU=1,
}

function payControl:initXianQuanCfg(pfId)

self.skipXianQuanDict={}
self.skipAllXianQuanAmount=false
self.activeXianQuanShop=false


local cfg=cfgHelper.get1(cfg_xianquanbuyconfig_get,pfId)
if not cfg then

return
end


if cfg.skip_amount then

for _,amount in ipairs(cfg.skip_amount)do
self.skipXianQuanDict[amount]=true
end
self.skipAllXianQuanAmount=false
else

self.skipAllXianQuanAmount=true
end


if not cfg.open_amount then

self.activeXianQuanShop=true
else

local amountType=cfg.open_amount[1]
local requiredAmount=cfg.open_amount[2]

if amountType==OpenAmountType.XIANYU
and rechargeModel:getTotalRecharge()>=requiredAmount then
self.activeXianQuanShop=true
end
end


if verifyManager:isOpen()then
self.activeXianQuanShop=false
self.skipAllXianQuanAmount=false
end
end

function payControl:onEnterState(isReconnect)
if isReconnect then return end
self.subscriptionData={}
end

function payControl:onLeaveState(isReconnect)
if isReconnect then return end
self.subscriptionData={}
end



function payControl:testXianQuanShop(pfId)
self:initXianQuanCfg(pfId)
end

function payControl:isActiveXianQuanShop()
return self.activeXianQuanShop
end

function payControl:isNeedUseXianQuanShop(amount)
if not self.activeXianQuanShop then
return false
end
if self.skipAllXianQuanAmount then
return false
end
return not self.skipXianQuanDict[amount]
end







function payControl.reqPay(id,count,params,subscribe)
if reconnectState:isReconnect()then
UIManager.error('正在进行重连')
return
elseif not gameState.isEnter()or
not socketManager.connecting then
UIManager.error('已断开连接，请先登陆')
return
end
if not initProControl.isDone()then
UIManager.error('尚未初始化完成')
return
end

if params==''then params=nil end
if count==nil then count=1 end
if id==nil then

return
end
local cfg=cfg_rechargeconfig_get(id)
if cfg==nil then

return
end

shushuReportHelper.Report_byEventName(shushuReportEventName.zqzs_pay_trigger,{amount=cfg.rmb,payment_id=id})



local rechargeFun=function(...)
local platform=deviceHelper.getAppPlatform()
if platform==nil then
return








else









platformSDK:reqPay(id,count,params,subscribe)
end
end

local canVoucherPay=true

if cfg.recharge_type==34 then
canVoucherPay=false
end

local rechargeAmount=payControl:getRechargeAmountByCfg(cfg)
local needUseXianQuan=payControl:isNeedUseXianQuanShop(rechargeAmount)
local handlePay=function()

if payControl:onlyVoucherPayPF()then
UIManager.info('谪仙劵不足')
elseif needUseXianQuan then
UIFullRechargeController:showRechargeWindow({pageType=34})
else
rechargeFun()
end
end


local itemnum=rechargeAmount
local itemid,voucherCount=payControl.getVoucherId(itemnum)
if(canVoucherPay and voucherCount>=itemnum)or needUseXianQuan then
if not itemid and needUseXianQuan then
itemid=cfgHelper.getdef2(cfg_rechargeconfig,'fail',0)
voucherCount=bagModel.getItemCountById(itemid)
end

local czId=id
local iconname=iconHelper.getIconName(itemid)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,40)
local contentStr=FMT.fmt(cfgHelper.getlang('ui_voucher_tips'),iconStr,itemnum)
local cancelName="前往付费"
if needUseXianQuan then
cancelName="购买仙券"
end
if payControl:onlyVoucherPayPF()then
rechargeFun=nil
cancelName="取消"
end
local args={
desc=contentStr,
itemid=itemid,
itemnum=voucherCount,
needNum=itemnum,
showCancel=true,
cancelName=cancelName,
commitName="确定",
cancelCB=handlePay,

commitCB=function()

local pram=jsonHelper.encode({czId,params})
bagProtocolControl.req_1_21(itemid,itemnum,pram)
return
end,
}
UIManager:showWindow('UICommonUseItemDialougeWithIconWin',args)
else
handlePay()
end
end


function payControl.reqPayNoVoucher(id,count,params,subscribe)
if reconnectState:isReconnect()then
UIManager.error('正在进行重连')
return
elseif not gameState.isEnter()or
not socketManager.connecting then
UIManager.error('已断开连接，请先登陆')
return
end
if not initProControl.isDone()then
UIManager.error('尚未初始化完成')
return
end

if params==''then params=nil end
if count==nil then count=1 end
if id==nil then

return
end
local cfg=cfg_rechargeconfig_get(id)
if cfg==nil then

return
end

shushuReportHelper.Report_byEventName(shushuReportEventName.zqzs_pay_trigger,{amount=cfg.rmb,payment_id=id})


local rechargeFun=function(...)
local platform=deviceHelper.getAppPlatform()
if platform==nil then
return








else









platformSDK:reqPay(id,count,params,subscribe)
end
end

local canVoucherPay=true

if cfg.recharge_type==34 then
canVoucherPay=false
end

local rechargeAmount=payControl:getRechargeAmountByCfg(cfg)
local needUseXianQuan=payControl:isNeedUseXianQuanShop(rechargeAmount)
local handlePay=function()

if payControl:onlyVoucherPayPF()then
UIManager.info('谪仙劵不足')
elseif needUseXianQuan then
UIFullRechargeController:showRechargeWindow({pageType=34})
else
rechargeFun()
end
end


handlePay()
end

function payControl.getActivityPayParams(actid,subType,subid,data)
local base=FMT.fmt('{0}-{1}-{2}',actid,subType,subid)
local n=#(data or{})
local val=base
if n>0 then
for i,v in ipairs(data)do
val=FMT.fmt('{0}-{1}',val,v)
end
end
return val
end

function payControl.getVoucherId(num)
local voucherItemList=itemsLookup:get_function_items(19)
if voucherItemList then
table.sort(voucherItemList,function(a,b)
return a.funcparam.gm>b.funcparam.gm
end)
end
for k,itemdata in pairs(voucherItemList)do
local hasNum=bagModel.getItemCountById(itemdata.id)
if hasNum>=num then
return itemdata.id,hasNum
end
end
return nil,0
end



function payControl:setSubscriptionStatus(id,status)
local old=self.subscriptionData[id]or false
if old==status then return end
self.subscriptionData[id]=status
notifySystem:postNotify(notifyConfig.subscriptionStatus,id,status)
end


function payControl:getSubscriptionStatus(id)
return self.subscriptionData[id]or false
end


local onlyVoucherPayPFList=
{

}

function payControl:onlyVoucherPayPF()
local platform_name=deviceHelper.getAppPlatform()
if onlyVoucherPayPFList[platform_name]then
return true;
else
return false;
end
end


function payControl:getRechargeAmount(rechargeId)
local amount=0
local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,rechargeId)
if rechargeCfg then
amount=payControl:getRechargeAmountByCfg(rechargeCfg)
end
return amount
end


function payControl:getRechargeAmountByCfg(rechargeCfg)
local amount=0
local itemCfg=rechargeCfg.item
local defaultVersionId=pfwindowslController.sdkPFVersion.game_jianti
local versionId=pfwindowslController:getGameVersion()
if itemCfg[versionId]then
amount=itemCfg[versionId]
else

amount=itemCfg[defaultVersionId]
end
return amount
end


function payControl:getRechargeAmountDefault(rechargeId)
local amount=0
local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,rechargeId)
if not rechargeCfg then
return 0
end
local itemCfg=rechargeCfg.item or{}
local defaultVersionId=pfwindowslController.sdkPFVersion.game_jianti
amount=itemCfg[defaultVersionId]or 0
return amount
end
