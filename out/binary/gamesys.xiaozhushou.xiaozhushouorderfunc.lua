







xiaoZhuShouOrderFunc={}

function xiaoZhuShouOrderFunc.cxz_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.cszAutoReceive]==1 then

local time=cfgHelper.getdef1(cfg_worldtravelconfig,"recvtips")
local datas=chuanSongZhenModel:getDatas()
local worlds={}
for world,data in pairs(datas)do
local duration=chuanSongZhenModel:getMaxDuration(world)
if time<=duration then
table.insert(worlds,world)
end
end
local count=#worlds
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.2,
excutes=worlds,
stepFunc=function(data)
chuanSongZhenController:send_5_94(data,1)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="暂无奖励可领取",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_csz,args)
end
end

function xiaoZhuShouOrderFunc.hs_autoDailyChallenge(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.hsAutoDailyChallenge]==1 then
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_1
xiaoZhuShouModel:resetWaitReward(detailId)
xiaoZhuShouModel:addDetailData(detailId)
end
end

function xiaoZhuShouOrderFunc.hs_autoCleanupZhenLing(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.hsAutoCleanupZhenLing]==1 then
if not UIHuanJingControl:isZhenlingFuncOpen()then
local args={time=0.2,errCode=3}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_2,args)
return
end
local type=UIHuanJingControl:getTodayFirstOpenType()
local firstType=setupData[xzsDataKey.hsBetterCleanupType]
local openList=UIHuanJingControl:getZlOpenList()
local week=timeHelper.getWeakDateEx()
if openList[firstType]then
type=firstType
elseif openList[week]then
type=week
end
local banTypeLookup=setupData[xzsDataKey.hsBanCleanupType]
if banTypeLookup[type]==true then
local args={time=0.2,errCode=4,type=type}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_2,args)
return
end
local layer=UIHuanJingControl:getZLStMaxLayerByType(type)
if layer>0 then
local itemUseLeftCount,buyLeftCount=UIHuanJingControl:getClearLeftCount(type,layer)
local sdNum=itemUseLeftCount
local isBuyNum=setupData[xzsDataKey.hsAutoBuyCleanup]==1
if isBuyNum then
local buyMaxNum=setupData[xzsDataKey.hsAutoBuyCleanupNum]
local todayBuyCount=UIHuanJingControl:getsdcsDayBuy()or 0
local canBuyMaxNum=math.max(buyMaxNum-todayBuyCount,0)
local buyNum=math.min(buyLeftCount,canBuyMaxNum)

local condition=cfgHelper.get2(cfg_houshanzhenlingbaseconfig_get,1,'daySaoDang')
local itemId=condition[2][1][1]
local getCostAndGetNum=function(num)
local needNum=0
local getNum=0
for index=todayBuyCount+1,todayBuyCount+num do
local cost=condition[2][index]
needNum=needNum+cost[2]
getNum=getNum+cost[4]
end
return needNum,getNum
end
local needMoneyNum=getCostAndGetNum(buyNum)

local checkBuyNum=buyNum>0
local checkMoney=itemsModel.checkItemEnough(itemId,needMoneyNum)
if checkBuyNum and checkMoney then
local toatl_num=sdNum+buyNum
local func=function()
local args={sdNum=sdNum,buyNum=buyNum,cost={{itemId,needMoneyNum}},}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_2,args)
UIHuanJingControl:req_Quick_Challenge_zhenling(type,layer,toatl_num,1)
end
socketManager:addNotify(6,113,func,1)
UIHuanJingControl:req_buy_sdcs(buyNum)
else
if sdNum<=0 then
local args={time=0.2,errCode=2}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_2,args)
else
local buyErrType
if not checkBuyNum then
buyErrType=1
elseif not checkMoney then
buyErrType=2
end
local args={sdNum=sdNum,buyErrType=buyErrType}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_2,args)
UIHuanJingControl:req_Quick_Challenge_zhenling(type,layer,sdNum,1)
end
end
else
if sdNum<=0 then
local args={time=0.2,errCode=2}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_2,args)
else
local args={sdNum=sdNum}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_2,args)
UIHuanJingControl:req_Quick_Challenge_zhenling(type,layer,sdNum,1)
end
end
else
local args={time=0.2,errCode=1,type=type}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_2,args)
end
end
end

function xiaoZhuShouOrderFunc.mhl_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.mhlAutoReceive]==1 then
if UICatShopControl.currShopGUID then
local datas=UICatShopControl:getDatas()
local list={}
local count=0
local needItemDict={}
for k,v in pairs(datas)do
if not v.accept then
local check=true
if v.extra_id>0 then
local excfg=cfgHelper.get1(cfg_catsalesmanextraconfig_get,v.extra_id)
if not UICatShopControl:checkCatShopExtraCondition(excfg.condition)then
check=false
end
end
if check then
local data=UICatShopControl:getData(v.idx)
if data then
local need=needItemDict[data.item_id]or 0
need=need+data.item_num
if itemsModel.getCount(data.item_id)>=need then
table.insert(list,v.idx)
needItemDict[data.item_id]=need
else
count=count+1
end
else
count=count+1
end
end
end
end
local check=UICatShopControl:isReveive()
local len=#list
if len>0 or(count==0 and not check)then
UICatShopControl:reqOneKeyReceive(len,list,1)
else
if count>0 then
local str=FMT.fmt('与猫货郎的交易中有{0}个交易未完成',count)
local args={
showTips=true,
tips=str
}
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_mhl,str)
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_mhl,args)
else
xiaoZhuShouController:setIdleState()
end
end
else
local state=UICatShopControl:getCatShopState()
local args={
showTips=true,
tips=state==3 and'猫货郎已离开宗门'or'猫货郎尚未抵达宗门，无法完成交易'
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_mhl,args)
end
end
end

function xiaoZhuShouOrderFunc.ylc_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

local moneyData=UIAquariumControl:getSaiQianBoxMoneyData()
if moneyData and next(moneyData)then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)

UIAquariumControl:reqGetSaiQianReward(1)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="暂无奖励可领取",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ylc,args)
end

function xiaoZhuShouOrderFunc.ylc_autoActive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

local canActive,list=UIAquariumControl:checkBookCanActiveOrReceive()
if canActive then
table.insert(excutesList,list)
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
sub_effecttype2=3,
stepFunc=function(data)
local list=data
for _,v in ipairs(list)do
local bookId=v.bookId
local isUpStar=v.isUpStar
local isActiveReward=v.isActiveReward
local isMinWeight=v.isMinWeight
local isMaxWeight=v.isMaxWeight

if isUpStar then
UIAquariumControl:reqHBStarUp(bookId,1)
end
if isActiveReward then
UIAquariumControl:reqHBReward(bookId,4,1)
end
if isMinWeight then
UIAquariumControl:reqHBReward(bookId,1,1)
end
if isMaxWeight then
UIAquariumControl:reqHBReward(bookId,3,1)
end
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="无可激活的鱼类图鉴",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ylc_active,args)
end

function xiaoZhuShouOrderFunc.gyg_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.gygAutoReceive]==1 then
if not adController:supportPlayAD()then
xiaoZhuShouController:setIdleState()
return
end
local curGiftConfig=rechargeModel:getSortXianGouLiBaoList(shopLibaoType.eGuangGao)
local itemid=cfg_advertconfig().const_def.itemid
local count=itemsModel.getCount(itemid)
local hasReward=false
for i,v in ipairs(curGiftConfig)do
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(v.id)
if v.maxcount>buyNum then
hasReward=true
break
end
end
if hasReward and count<=0 then
local args={
showTips=true,
tips='观影卷不足，无法领取奖励'
}
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_gyg,'观影卷不足，无法领取奖励')
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_gyg,args)
return
end
local list={}
for i,v in ipairs(curGiftConfig)do
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(v.id)
if count>0 then
local needCount=v.maxcount-buyNum
if needCount>0 then
for ii=1,needCount do
local ext=adController:getParam(v.id)
local id=v.adid
table.insert(list,{id,ext})
count=count-1
if count<=0 then
break
end
end
end
if count<=0 then
break
end
end
end
local len=#list
if len>0 then
rechargeController:reqGuanYinGeOnekeyBuy(len,list,1)
rechargeModel:setGuanYinGeOneKeyBuy(true)
else
local args={
showTips=true,
tips='奖励已全部领取'
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_gyg,args)
end
end
end

function xiaoZhuShouOrderFunc.xst_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.xstAutoReceive]==1 then
local isXJsystem=XianjieXuanShangController:changeXJXSsystm()
if UIXuanShangControl:hasTaskFinish()then
if isXJsystem then
XianjieXuanShangController:send_7_58(1)
else
UIXuanShangControl:reqReward(0,1)
end
else
if isXJsystem then
XianjieXuanShangController:againDispatch()
end
local args={
showTips=true,
tips='当前无已完成悬赏任务'
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xst,args)
end
end
end

function xiaoZhuShouOrderFunc.ss_dianzan(orderID)
xiaoZhuShouModel:clearWaitReward(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ss)
xiaoZhuShouModel:resetWaitReward(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ss)
local isExe=0
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local cnt=shangHangModel:getLikeOrHateCnt()
local gushen_data=shanmenModel:get_gushen_data()
local jiushen_data=shanmenModel:get_jiushen_data()
local flag1=gushen_data~=nil and next(gushen_data)~=nil and gushen_data.server~=0
local flag2=jiushen_data~=nil and next(jiushen_data)~=nil and jiushen_data.server~=0
local comment_cnt=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"comment_cnt")
if setupData[xzsDataKey.ssTop1]==1 then
if cnt<comment_cnt and(flag1 or flag2)then
local idx=2
for i=cnt+1,comment_cnt do
idx=idx==1 and 2 or 1
socketManager:send_248_101(idx,1,1)
end
isExe=bitHelper.set_1(isExe,0)
end
end
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.ssGetMoney]==1 then
local lingyu=shangHangModel:getActorMoneyToday()
if lingyu>0 then
socketManager:send_248_97(1)
isExe=bitHelper.set_1(isExe,1)
end
end
if isExe==0 then
local args={
orderID=orderID,
state=-1,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
if setupData[xzsDataKey.ssTop1]==1 and setupData[xzsDataKey.ssGetMoney]==1 then
args.error="无可领取佣金以及可点赞股神/韭神"
else
if setupData[xzsDataKey.ssTop1]==1 then
if not(gushen_data~=nil and next(gushen_data)~=nil and gushen_data.server~=0)then
args.error=" 无可点赞的股神/韭神"
else
if cnt>=comment_cnt then
args.error="无可点赞的次数"
end
end
end
if setupData[xzsDataKey.ssGetMoney]==1 then
args.title="商市：领取佣金"
args.error="无可领取佣金"
end
end
if args.error then
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ss,args)
else
xiaoZhuShouController:setIdleState()
end
end

end

function xiaoZhuShouOrderFunc.dft_autoFight(orderID,args)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_dft
args=args or{}
args.orderID=orderID
xiaoZhuShouModel:addDetailData(detailId,args)
end

function xiaoZhuShouOrderFunc.phb_upvote(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.phbUpvote]==1 then

local excuteList={}
local topData=lundaodahuiModel:getNewTop3Data()
if topData then
local jieShu=topData.jieShu or 1
local zan=lundaodahuiModel:getDzNum()
local topActor=nil
if topData.sjList then
for i,v in ipairs(topData.sjList)do
if v.pos==1 then
topActor=v
end
end
end
if topActor then
for i=1,zan do
table.insert(excuteList,{17,29,{jieShu,topActor.serverId,topActor.playerId,1}})
end
end
end

local isTruce=UIXianFaWenDaoControl:isInTruceTime()
if isTruce and UIXianFaWenDaoControl:checkPreviousTopData()then
local level=UIXianFaWenDaoControl:getLevel()
level=(level~=nil and level>0)and level or 1
local datas=UIXianFaWenDaoControl:getPreviousTopData(level)
if datas[1]then
local zan=UIXianFaWenDaoControl:getLastLikestimes()
for i=1,zan do
table.insert(excuteList,{17,59,{level,1,1}})
end
end
end

if WDCQController.checkSysOpen()and WDCQModel:haveRYBTopData()and WDCQController:checkRongYuBangEnter()then
local zan=WDCQController.getHonorDianZanNum()
for i=1,zan do
table.insert(excuteList,{38,7,{1}})
end
end

if not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eLingXuWenJian)and limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eLingXuWenJian)and lingxuwenjianModel:checkInit()then
local datas=lingxuwenjianModel:getLikeTopThree()
if datas[1]then
local cur=lingxuwenjianModel:getLikeTimes()
local max=lingxuwenjianModel:getMamLikeTimes()
local lerp=max-cur
for i=1,lerp do
table.insert(excuteList,{20,166,{1,1}})
end
end
end

local args=nil
if#excuteList>0 then
args={
orderID=orderID,
state=0,
excutes=excuteList,
interval=0.1,
stepFunc=function(data)
local sysId=data[1]
local subId=data[2]
local params=data[3]
socketManager[FMT.fmt("send_{0}_{1}",sysId,subId)](socketManager,unpack(params))
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可点赞排行榜",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_phb,args)
end
end

function xiaoZhuShouOrderFunc.sp_autoQiYuChallenge(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.spAutoQiYu]==1 then
local excutesList={}
local datas=UIShopModel:getAllShopData()
for k,v in pairs(datas)do
local bdData=zongmenModel:getBuildingData(v.un_build_id)
if UIShopModel:getEventState(bdData.un_build_id)and tostring(bdData.dizi_id)~='0'then
table.insert(excutesList,{bdData.un_build_id,1})
end
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
local bdData=zongmenModel:getBuildingData(data[1])
if emergenciesModel:isInRepairTime(bdData.un_build_id)then
return true,bdData.un_build_id,"正在修复中"
end
if jctjDuJieXianDanModel:isInRepairTime(bdData.un_build_id)then
return true,bdData.un_build_id,"正在修复中"
end
UIShopControl:reqHandleShopEvent(data[1],data[2])
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可领取的商铺奇遇",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_sp,args)
end
end

function xiaoZhuShouOrderFunc.sp_autoReceiveChallenge(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.spAutoReceive]==1 then
local excutesList={}
local datas=UIShopModel:getAllShopData()
for k,v in pairs(datas)do
local bdData=zongmenModel:getBuildingData(v.un_build_id)
local isReddot=UIShopControl:checkReddot(bdData)
local flag1=emergenciesModel:isInRepairTime(bdData.un_build_id)
local flag2=jctjDuJieXianDanModel:isInRepairTime(bdData.un_build_id)
if isReddot and not flag1 and not flag2 then
table.insert(excutesList,{0,1})
break
end
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
UIShopControl.Req_9_16(data[1],data[2])
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可领取的商铺商品",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_sp_2,args)
end
end

function xiaoZhuShouOrderFunc.sd_autoDayGiftFreeChallenge(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.sdAutoDayGiftFree]==1 then
local excutesList={}
local list=rechargeModel:getXianGouLiBaoConfig(shopLibaoType.eDay)
for i,v in pairs(list)do
local isFree=v.price~=nil and v.price[2]==0
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(v.id)
local isSellOut=buyNum>=v.maxcount
if isFree and not isSellOut then
table.insert(excutesList,{v.id,v.maxcount-buyNum,1})
end
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
rechargeController:reqXianGouLiBaoBuy(data[1],data[2],data[3])
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可领取的每日免费礼包",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_sd,args)
end
end

function xiaoZhuShouOrderFunc.wxt_autoCleanupChallenge(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.wxtAutoCleanup]==1 then
local excutesList={}
local ret,args=wuXingDianModel:isCanSaoDang()
if ret then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
socketManager:send_25_19(data[1])
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="今日已扫荡五行塔，不需要再次扫荡",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wxt,args)
end
end


function xiaoZhuShouOrderFunc.bls_autoUseFreeNum(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.blsAutoUseFree]==1 then

local excutesList={}
local freenum=baoLingShuModel:get_baolingshu_free_num()
local free=freenum>0
if free then
local configId=baoLingShuModel:getConfId()
table.insert(excutesList,{configId,freenum})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
baoLingShuController:req_qifu(data[1],data[2],0,true,true)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有免费许愿次数",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_bls,args)
end
end


function xiaoZhuShouOrderFunc.ly_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.lyAutoReceive]==1 then
local reqList={}
local list=UIPrisonModel:getStateData()
for lfId,data in ipairs(list)do
if data.swstate==2 then
table.insert(reqList,lfId)
end
end

local count=#reqList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=reqList,
stepFunc=function(lfId)
UIPrisonControl:reqFinishInterrogate(lfId,1)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可领取的审问奖励",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ly,args)
end
end


function xiaoZhuShouOrderFunc.ly_autoHandIn(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.lyAutoReceive]==1 then
local reqList={}
local list=UIPrisonModel:getAllPrisonData()
for lfId,data in pairs(list)do
if data and data.lytype==ePrisonRoomType.eMonster and data.swNum>=1 and not mathHelper.compareInt64(data.fuluGuid,Int64_0)then
table.insert(reqList,lfId)
end
end

local count=#reqList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=reqList,
stepFunc=function(lfId)
UIPrisonControl:reqHandInCaptive(lfId,1)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可以上交九幽的魔物",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ly_jy,args)
end
end


function xiaoZhuShouOrderFunc.fs_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.fsAutoBuy]==1 then

fairModel:ClearRecordItem()

fairModel:SetBeginXiaoZhuShouNum(0)
fairModel:SetAllxiaozhushouNum(0)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_fs

if not guildOrderModel:checkOrderActive(GUILD_ORDER_TYPE.eAutoBuy)then
local showtext=FMT.fmt("坊市自动购买法令未激活，无法完成购买")
xiaoZhuShouModel:addDetailData(detailId,{time=0.3,showtext=showtext})

return
end

if not guildOrderModel:isOrderSetupOpenEx(GUILD_ORDER_TYPE.eAutoBuy)then
local showtext=FMT.fmt("未开启自动购买法令，无法自动购买")
xiaoZhuShouModel:addDetailData(detailId,{time=0.3,showtext=showtext,num=0})

return
end
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local num=0
local freenum=fairModel:get_free_flush_count()
local isBuyUseAD=setupData[xzsDataKey.fsAutoUseGYQ]==1
local isBuyUseLY=setupData[xzsDataKey.fsAutoUseLY]==1
local isBuyUseLYnum=setupData[xzsDataKey.fsAutoUseLYnum]or 1

local yetAdnum=fairModel:Get_Ad_flush_count()
local maxAdnum=fairModel.get_booth_ad_flush_times_limit()


local yetlynum=fairModel:enough_pay_flush_count()
local lymaxnum=fairModel.get_booth_pay_flush_times_limit()

num=freenum

if isBuyUseAD and fairModel:has_Ad_flush_count()then
num=num+maxAdnum-yetAdnum
end

if((not fairModel:has_Ad_flush_count())or isBuyUseAD)and isBuyUseLY then
local lynum=math.max(0,(isBuyUseLYnum-yetlynum))

num=num+lynum
end

if num<=0 then
local showtext=FMT.fmt("剩余刷新次数不足")
xiaoZhuShouModel:addDetailData(detailId,{time=0.3,showtext=showtext,num=0})
return
end
xiaoZhuShouModel:addDetailData(detailId,{num=num})




end
end

function xiaoZhuShouOrderFunc.cjg_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.cjgAutoStudy]==1 then
local gflist={}
local costlp={}
if UIGongFaController:checkInit()then
local allGFList=gongfaLookup:getAllGongFaList()
for i,v in ipairs(allGFList)do
local gfID=v.id
if UIGongFaModel:isGongFaActive(gfID)and UIGongFaModel:isPageAllActive(gfID)then
local mxlv=UIGongFaModel:getStudyMaxLevel(gfID)
local lv=UIGongFaModel:getStudyLevel(gfID)
if mxlv~=0 and lv<mxlv then
for j=lv,mxlv-1 do
local flag,GLtable,result,costIdx=UIGongFaModel:checkStudyCanUp2(gfID,false,false,costlp,j)
if flag and result then
table.insert(gflist,{gfID,costIdx})
end
end
end
end
end
end
local args=nil
if#gflist>0 then
args={
orderID=orderID,
state=0,
gflist=gflist,
costlp=costlp.part,
stepFunc=function(gfID)
local flag,GLtable=UIGongFaModel:checkStudyCanUp(gfID,false,false)
if not flag then
return
end
local gllist_={}

for k,v in pairs(GLtable)do
if v[3]>0 then
if v[3]>v[2]then
v[3]=v[2]
end
if k and v[1]then
gllist_[#gllist_+1]={liandongZY.gongfa,k,v[1],v[3]}
end

end
end
if#gllist_>0 then
liandonController:send_254_96(#gllist_,gllist_)
end
UIGongFaController:reqGongFaStudy(gfID,0,1)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可研习功法",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_cjg,args)
end
end


function xiaoZhuShouOrderFunc.yyhy_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.yyhyAutoReceive]==1 then
local list={}
local jifenReward=cfg_yiyuhuiyoubaseconfig_get(1).week_rewards
local score=YiYuHuiYouModel:getWeek_reward_val()or 0
local prizetag=YiYuHuiYouModel:getWeek_reward_flag()or 0
local indexs=YiYuHuiYouModel:getRankList_YYHY_idxs()
local lqmaxid=0
for i,v in ipairs(jifenReward)do
local fix=score>=v[1]
local flag=mathHelper.getBitValue(prizetag,i-1)
local state=flag==true and 0 or 1
if flag~=true then
if indexs>=i then
state=0
flag=true
end
end
local weight=state*100000+(100000-v[1])
table.insert(list,{v,fix,flag,weight,i})
end
table.sort(list,function(a,b)
return a[4]>b[4]
end)
for k,v in ipairs(list)do
local fix=v[2]
local flag=v[3]
local i=v[5]
if fix and not flag and lqmaxid<i then
lqmaxid=i
end
end
if lqmaxid~=0 then
YiYuHuiYouController.send_248_61(lqmaxid,1)
else
local args={flag=1}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_yyhy,args)
end
end
end

function xiaoZhuShouOrderFunc.xianzhan_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local check=setupData[xzsDataKey.xianzhanAutoReceive1]==1 or setupData[xzsDataKey.xianzhanAutoReceive2]==1
if check then
local args=nil
local error=nil
local bdData=xianzhanController:getXianZhanBuild()
local has=bdData~=nil
local reqlist={}
if has then
if setupData[xzsDataKey.xianzhanAutoReceive1]==1 then
local ybRoomIDs=xianzhanModel:getYingBinRoomIDs()
if#ybRoomIDs>0 then
table.insert(reqlist,1)
end
end
if setupData[xzsDataKey.xianzhanAutoReceive2]==1 then
if xianzhanModel:checkTuiFangReward()then
table.insert(reqlist,2)
end
end
if#reqlist<=0 then
error='暂无访客可招待'
end
else
error='仙栈暂未开放'
end
if error==nil then
args={
orderID=orderID,
state=0,
reqlist=reqlist,
stepFunc=function(typo)
if typo==1 then
local ybRoomIDs=xianzhanModel:getYingBinRoomIDs()
if#ybRoomIDs>0 then
xianzhanController:req_yingbin(ybRoomIDs,1)
end
else
xianzhanController:req_xianzhan_reward(1)
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error=error,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xianzhan,args)
end
end

function xiaoZhuShouOrderFunc.xwl_receiveReward(orderID)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_xwl
xiaoZhuShouModel:clearWaitReward(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xwl)
xiaoZhuShouModel:resetWaitReward(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xwl)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local check=setupData[xzsDataKey.xwlAutoReceive]==1 or setupData[xzsDataKey.xwlAutoReward]==1
if check then
local has=xianmengModel:hasXM()and xianmengController:getXianWuLouBuild()~=nil
local args=nil
local error=nil
if has then
if xianmengModel:checkXWLInit()then
local hasTask=xianmengModel:checkXWLHasTask()
local data=xianmengModel:getXWLData()
local curlun=data.lunshuId
local maxexp=cfgHelper.get2(cfg_xianwuloutasklunshuconfig_get,curlun,'progressBarMax')
local curexp=data.jinduVal
if hasTask and curexp>=maxexp then
error='捐献进度已满'
else
local num=xianmengModel:getXWL_tjNum()
if num<=0 then
error='捐献次数已用完'
end
end
else
error='仙务楼等待更新'
end
else
error='仙务楼暂未开放'
end
if error==nil then
args={
orderID=orderID,
state=0,
stepFunc=function(typo,tjId,cnt)
if typo==1 then
xianmengController:reqXWLSubmit(tjId,cnt,1)
elseif typo==2 then
xianmengController:reqXWLSubmit2(tjId,cnt,1)
elseif typo==3 then
xianmengController:reqXWLReward(tjId,1)
end
return true
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error=error,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(detailId,args)
end
end

function xiaoZhuShouOrderFunc.xwl_receiveReward2(orderID)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_xwl_2
xiaoZhuShouModel:clearWaitReward(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xwl)
xiaoZhuShouModel:resetWaitReward(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xwl)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local check=setupData[xzsDataKey.xwlAutoReward]==1
if check then
local has=xianmengModel:hasXM()and xianmengController:getXianWuLouBuild()~=nil
local args=nil
local error=nil
if has then
if xianmengModel:checkXWLInit()then
local rcnt=xianmengModel:getXWLRewardCount()
if rcnt<=0 then
error='暂无宝箱奖励可领取'
end
else
error='仙务楼等待更新'
end
else
error='仙务楼暂未开放'
end
if error==nil then
args={
orderID=orderID,
state=0,
stepFunc=function(typo,tjId,cnt)
if typo==3 then
xianmengController:reqXWLReward(tjId,1)
end
return true
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error=error,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(detailId,args)
end
end

function xiaoZhuShouOrderFunc.xwl_receiveGongXunReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.xwlGongXunRewardAutoReceive]~=1 then
return
end

local isInXm=xianmengModel:hasXM()
if not isInXm then
return
end

local hasRewards=xianmengModel:getGXBRewardReddot()
local executeList={}
if hasRewards then
table.insert(executeList,{1})
end
local args=nil
if hasRewards then
args={
orderID=orderID,
state=0,
excutes=executeList,
stepFunc=function(data)
xianmengController.req_protocol_20_36(nil,1)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="暂无功勋宝箱可领取",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end

xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xwl_3,args)
end


function xiaoZhuShouOrderFunc:getwdSatet()
if not wudaotangModel:hasPlan()then
return 1
end
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eWuDaoTang)then

return false
end
local data=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eWuDaoTang)
local entityID=data[1].entityId
local bdData=zongmenModel:findBuildingByEntityId(entityID)
local buildLv=bdData.level
if wudaotangModel:checkHasReward(buildLv)then
return 3
end
return 2
end

function xiaoZhuShouOrderFunc.wdt_receiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.wdtAutofinish]==1 then
local wdState=xiaoZhuShouOrderFunc:getwdSatet()
if wdState and wdState==3 then
wudaotangController:reqReward(1)
else
local age=
{
flag=1
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wdt_1,age)
end
end
end

function xiaoZhuShouOrderFunc.wdt_autoWDStart(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.wdtAutostart]==1 then
local wdState=xiaoZhuShouOrderFunc:getwdSatet()
if wdState and wdState==1 then
local planid=setupData[xzsDataKey.wdtAutoshijian]
if planid==0 then
planid=1
end
local dizi1=setupData[xzsDataKey.wdtAutodizi1]
local dizi2=setupData[xzsDataKey.wdtAutodizi2]
local dizi3=setupData[xzsDataKey.wdtAutodizi3]
local xzsdz={dizi1,dizi2,dizi3}
local selectdzlist={}
for k,v in ipairs(xzsdz)do
local dzguid=int64.new(v)
local netdata=UIDiscipleModel:getDiscipleData(dzguid)
if netdata then
table.insert(selectdzlist,netdata.discipleguid)
end
end
if#selectdzlist>0 and planid then
local age={}
age.curlist=selectdzlist
age.flag=1
age.planid=planid
local attr6=wudaotangModel:getPointNeedAttr6(planid)
local attr6Type=attr6[1]
local needAttr6Value=attr6[2]
for k,v in ipairs(selectdzlist)do
local attr6Value=UIDiscipleModel:getDiscipleBaseAttr(v,attr6Type)
local checkFlag,cantStateType=UIDiscipleModel:checkDZStateToDoSomething(v,eCheckDiscipleStateOpType.eWuDao,false)
local checkAttr6=attr6Value>=needAttr6Value
if(not checkFlag)or(not checkAttr6)then
local state_str="有弟子不能悟道"
if not checkFlag then
if not DISCIPLE_STATE_TYPE:isClientState(cantStateType)then
state_str=FMT.fmt("预设的弟子<color=#7d3b17>{0}</color>{1}，不能悟道",UIDiscipleModel:getDiscipleName(v),DISCIPLE_STATE_TYPE:getName(cantStateType))
else
state_str=FMT.fmt("预设的弟子<color=#7d3b17>{0}</color>{1}，不能悟道",UIDiscipleModel:getDiscipleName(v),UIDiscipleModel:checkDZClientStateDesc(cantStateType)or'')
end
elseif not checkAttr6 then
state_str=FMT.fmt("预设的弟子<color=#7d3b17>{0}</color>{1}不足，不能悟道",UIDiscipleModel:getDiscipleName(v),UIDiscipleModel:getDiscipleBaseAttrName(attr6Type))
end
age.flag=2
age.str=state_str
break
end
end

local data=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eWuDaoTang)
local entityID=data[1].entityId
local bdData=zongmenModel:findBuildingByEntityId(entityID)
local buildLv=bdData.level
local cost=wudaotangModel:getCost(planid,buildLv)
age.cost=cost
if not moneyModel.checkEnoughMoney(cost[1],cost[2])then
local str=FMT.fmt('<color=#7d3b17>{0}</color>不足，无法悟道',moneyModel.getMoneyName(cost[1]))
age.flag=3
age.str=str
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wdt_2,str)
end



if age.flag==1 then
wudaotangController:reqStart(planid,#selectdzlist,selectdzlist,1)
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wdt_2,age)
else
local age=
{
flag=6
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wdt_2,age)
end

else
local age=
{
flag=4
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wdt_2,age)
end

end
end

function xiaoZhuShouOrderFunc.wdt_Aweakdizi(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.wdtAutoAweak]==1 then
local age={}
local wdState=xiaoZhuShouOrderFunc:getwdSatet()
if wdState and wdState==2 then
local guidlist={}
local curManNum=wudaotangModel:getManCount()
if curManNum>0 then
for i=1,curManNum do
local data=wudaotangModel:getDisDataByIndex(i)
if data then
if UIDiscipleModel:checkDiscipleState2(data.guid,DISCIPLE_STATE_TYPE.eWuDaoRuMo)then
table.insert(guidlist,data.guid)
end
end
end
end
if#guidlist>0 then
age.flag=2
wudaotangController:reqAweakDizi(guidlist)
else
age.flag=1
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wdt_3,age)
else
age.flag=1
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wdt_3,age)
end
end
end




function xiaoZhuShouOrderFunc.wbxbd_autoReceiveReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.xbdAutoReceive]==1 then
local _,idsList=wanBaoXunBaoDuiModel:getChanelListByState({WBXBD_Channel_STATE.finish,WBXBD_Channel_STATE.early_return})


local args
if#idsList>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=idsList,
stepFunc=function(id)
wanBaoXunBaoDuiController:reqFinishReturn({id},1)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wbxbd_1,args)
setupData[xzsDataKey.xbdTriggerReceive]=true
else
xiaoZhuShouController:setIdleState()








end

end
end

function xiaoZhuShouOrderFunc.wbxbd_autoDispatchAdventure(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.xbdAutoDispatch]==1 then
local autoDispatchList={}
local isAutoRestoreCat=setupData[xzsDataKey.xbdAutoRestoreCatTili]==1
local isNotHasCat=false
local isNotHasMoney=false
local isNotMapPoint=false


local channelList=wanBaoXunBaoDuiModel:getChanelListByState({WBXBD_Channel_STATE.idle,WBXBD_Channel_STATE.preparing})

if#channelList>0 then
setupData[xzsDataKey.xbdTriggerDispatch]=true

local xbdResourcesPriority=setupData[xzsDataKey.xbdResourcesPriority]

local adPointList=wanBaoXunBaoDuiModel:getAdvPoints()
local selectAdPointIdx=1

if#adPointList==0 then
local args={
orderID=orderID,
state=-1,
error="暂无可派遣任务",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wbxbd_2,args)
return
end


local const_def=wanBaoXunBaoDuiModel:getConstDef()
local monetType=const_def.add_tili_need[1]
local rate=const_def.add_tili_need[2]
local totalMoney=itemsModel.getCount(monetType)


local sortAdPointList={}
for index,pointData in ipairs(adPointList)do
local channelId
for _,channelData in ipairs(channelList)do
if channelData.task_Id==pointData.id then
channelId=channelData.channel_Id
break
end
end
if channelId==nil then
local cfg=cfgHelper.get1(cfg_catmapconfig_get,pointData.id)
local priorityWidget=0
for _,reward in ipairs(cfg.rewards)do
local itemId=reward[1]
local idx=table.findValue(xbdResourcesPriority,itemId)
if idx then
local weiget=(3-idx)*1000
if weiget>priorityWidget then
priorityWidget=weiget
end
end
end

priorityWidget=priorityWidget+cfg.color*10000+cfg.id
sortAdPointList[#sortAdPointList+1]={id=index,widget=priorityWidget,data=pointData}
end
end

table.sort(sortAdPointList,function(a,b)
return a.widget>b.widget
end)



local isNeedRestore_detail=false
local costCount_detail=0
for index,channelData in ipairs(channelList)do
local result=true
local taskId=channelData.task_Id or-1
if taskId==-1 then
local pointData=sortAdPointList[selectAdPointIdx]
if pointData then
taskId=pointData.data.id
selectAdPointIdx=selectAdPointIdx+1
else
isNotMapPoint=true
end
end
if taskId>-1 then
local catList,isNeedRestore=wanBaoXunBaoDuiController:getDispatchCat_XZS(channelData,taskId)
local cost=0
local restoreList={}
if#catList>0 then
local pList={}
if channelData.channel_state==WBXBD_Channel_STATE.idle then
pList[1]=WBXBD_XZS_Process.ReceiveTask
end
if isAutoRestoreCat then
if isNeedRestore then
local catData,maxTili,needNum,least
for index,catGuid in ipairs(catList)do
catData=wanBaoXunBaoDuiModel:getCatData(catGuid)
maxTili=wanBaoXunBaoDuiModel:caculationMaxTili(catData)
least=maxTili-catData.tili
needNum=rate*least

if totalMoney>=needNum then
totalMoney=totalMoney-needNum
cost=cost+needNum
restoreList[#restoreList+1]={catGuid,least}
else
result=false
isNotHasMoney=true
break
end
end
pList[#pList+1]=WBXBD_XZS_Process.RestoreTili
end
else
if isNeedRestore then
result=false
isNotHasMoney=true
end
end
pList[#pList+1]=WBXBD_XZS_Process.DispatchGo


if result then
local autoDispatchData={
plist=pList,
processIdx=1,
catList=catList,
taskId=taskId,
id=channelData.channel_Id,
cost=cost,
restoreList=restoreList,
}
autoDispatchList[#autoDispatchList+1]=autoDispatchData

costCount_detail=costCount_detail+cost
isNeedRestore_detail=isNeedRestore_detail or isNeedRestore
end
else
isNotHasCat=true

break
end
else

break
end
end

local args=nil

local channelLen=#channelList
local autoListLen=#autoDispatchList
if autoListLen>0 then
local result
if channelLen==autoListLen then
result=FMT.fmt("已派遣{0}支队伍出发探险",autoListLen)
else
if isNotHasMoney then
if isAutoRestoreCat then
result=FMT.fmt("已派遣{0}支队伍出发探险,由于猫币不足，无法派遣剩余队伍",autoListLen)
else
result=FMT.fmt("已派遣{0}支队伍出发探险,由于猫猫体力不足，无法派遣剩余队伍",autoListLen)
end
elseif isNotHasCat then
result=FMT.fmt("已派遣{0}支队伍出发探险,由于没有空闲的猫猫，无法派遣剩余队伍",autoListLen)
elseif isNotMapPoint then
result=FMT.fmt("已派遣{0}支队伍出发探险,由于没有探险任务，无法派遣剩余队伍",autoListLen)
end
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wbxbd_2,result)
end
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=autoDispatchList,
stepFunc=function(data)
wanBaoXunBaoDuiController:startDoProcess(data)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
result=result,
isNeedRestore=isNeedRestore_detail,
costCount=costCount_detail,
monetType=monetType,
}
else
local error
if isNotHasMoney then
if isAutoRestoreCat then
error="鱼币不足，无法补充猫猫体力"
else
error="猫猫体力不足，无法自动派遣"
end
elseif isNotHasCat then
error="没有空闲的猫猫，无法派遣队伍"
elseif isNotMapPoint then
error="没有探险任务，无法派遣队伍"
else
error="猫猫体力不足，无法自动派遣"
end
args={
orderID=orderID,
state=-1,
error=error,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
wanBaoXunBaoDuiController:failExecute()
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wbxbd_2,error)
end

xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wbxbd_2,args)
else
xiaoZhuShouController:setIdleState()










end
end
end


function xiaoZhuShouOrderFunc.wbxbd_autoIdle(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local isOnDispatch=setupData[xzsDataKey.xbdAutoDispatch]==1
local isOnReceive=setupData[xzsDataKey.xbdAutoReceive]==1

local channelList=wanBaoXunBaoDuiModel:getChanelListByState({WBXBD_Channel_STATE.finish,WBXBD_Channel_STATE.early_return})
local noReceiveChannel=#channelList==0

local channelList=wanBaoXunBaoDuiModel:getChanelListByState({WBXBD_Channel_STATE.idle,WBXBD_Channel_STATE.preparing})
local noDispatchChannel=#channelList==0

if((isOnReceive and noReceiveChannel and(not setupData[xzsDataKey.xbdTriggerReceive]))and(isOnDispatch and noDispatchChannel and(not setupData[xzsDataKey.xbdTriggerDispatch])))then
local args={
orderID=orderID,
state=-1,
error="寻宝队正在游历中，不需要处理",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wbxbd_3,args)
return
end

if(isOnReceive and noReceiveChannel)and(not setupData[xzsDataKey.xbdTriggerReceive])then
local args={
orderID=orderID,
state=-1,
error="没有可领取的奖励，不需要处理",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wbxbd_3,args)
return
end

if(isOnDispatch and noDispatchChannel)and(not setupData[xzsDataKey.xbdTriggerDispatch])then
local args={
orderID=orderID,
state=-1,
error="寻宝队正在游历中，不需要处理",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wbxbd_3,args)
return
end

xiaoZhuShouController:setIdleState()
end

function xiaoZhuShouOrderFunc.wbxbd_CheckSetUp(win)
local setupData=xiaoZhuShouModel:getSetupData(XIAOZHUSHU_ENUM.xzs_Mmtxd)
local xbdTempResourcesPriority=setupData[xzsDataKey.xbdTempResourcesPriority]

if#xbdTempResourcesPriority>=3 then
setupData[xzsDataKey.xbdResourcesPriority]=table.weakCopy(setupData[xzsDataKey.xbdTempResourcesPriority])
win:saveSetup()
else
local show_data={
type='UIDialouge',
title='提示',
content="优先采集顺序未完成选择，是否恢复至默认状态并退出设置？",
oktext='确定',
okcallback=function()
win:saveSetup()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
end



function xiaoZhuShouOrderFunc.mrqd_autoSingIn(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.mrqdAutoGetAllReward]==1 then
local excutesList={}

if welfareModel:checkDailySignInReddot_hasSignInReward()then
table.insert(excutesList,{1})
end


if welfareModel:checkDailySignInReddot_hasLeiJiReward()then
table.insert(excutesList,{2})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

welfareController:reqDailySignInGetReward(true)
elseif sendType==2 then

welfareController:reqDailySignInGetLeiJiReward(true)
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可领取的签到奖励",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_mrqd,args)
end
end



function xiaoZhuShouOrderFunc.mrth_autoGetFreeReward(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.mrthAutoGetFree]==1 then
local excutesList={}

local isGotFreeReward=rechargeModel:checkDailyTeHuiSingleDayGotByIndex(1)
if not isGotFreeReward then
table.insert(excutesList,{1})
end
local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
sub_effecttype2=1,
excutes=excutesList,
stepFunc=function(data)

rechargeController:reqGetDailyTeHuiSingleDayRewardByIndex(1,1)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
sub_effecttype2=1,
error="没有可领取的奖励",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_mrth_1,args)
end
end


function xiaoZhuShouOrderFunc.mrth_autoBuyOneKeyLiBao(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.mrthAutoBuyAll]==1 then
local excutesList={}
local countTextStr
local errorStr
local itemnum
local itemid,voucherCount
local isCanBuy=false

local checkNum=1
local _,checkVoucherCount=payControl.getVoucherId(checkNum)
if not checkVoucherCount or checkVoucherCount<=0 then

xiaoZhuShouController:setIdleState()
return
end


local isBoughtAnyLibao=rechargeController:checkDailyTeHuiSingleDayBoughtAnyLibao()
if not isBoughtAnyLibao then
local baseCfg=cfgHelper.get1(cfg_daydiscountsnewbasicconfig_get,1)
local rechargeId=baseCfg.recharge_id[pfwindowslController:getGameVersion()]or baseCfg.recharge_id[1]
local rechargeCfg=cfg_rechargeconfig_get(rechargeId)

local isEnough=false
local needItemCount
local itemName
local rechargeAmount=payControl:getRechargeAmountByCfg(rechargeCfg)
if rechargeAmount then
itemnum=rechargeAmount
itemid,voucherCount=payControl.getVoucherId(itemnum)
if itemid then
isEnough=voucherCount>=itemnum
needItemCount=itemnum
itemName=itemsModel.getName(itemid)
end
end

if isEnough then
table.insert(excutesList,{1,rechargeId})
countTextStr=FMT.fmt("消耗了{0}{1}获得以下奖励",needItemCount,itemName)
isCanBuy=true
else
errorStr="代金券不足，未购买每日特惠"
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_mrth_2,errorStr)
end
else
errorStr="当前无法一键全购"
end


local isGotExReward=rechargeModel:checkDailyTeHuiSingleDayGotExReward()
if not isGotExReward then
local nowBoughtCount=rechargeModel:getDailyTeHuiSingleDayBuyCount()
local baseCfg=cfgHelper.get1(cfg_daydiscountsnewbasicconfig_get,1)
local acc_reward=baseCfg.acc_reward[pfwindowslController:getGameVersion()]or baseCfg.acc_reward[1]
local targetDayCount=acc_reward[1]
local isCanGet=nowBoughtCount>=targetDayCount
local isNeedGet=nowBoughtCount==targetDayCount-1 and isCanBuy
if isNeedGet or isCanGet then
table.insert(excutesList,{2})
errorStr=nil
end
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
countStr=countTextStr,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then
local rechargeId=data[2]
local param='1'

local pram=jsonHelper.encode({rechargeId,param})
bagProtocolControl.req_1_21(itemid,itemnum,pram)
elseif sendType==2 then

rechargeController:reqGetDailyTeHuiSingleDayRewardByIndex(0,1)
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error=errorStr,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_mrth_2,args)
end
end

function xiaoZhuShouOrderFunc.zzshYBDAutoSaveMoney(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.zzshYBDAutoSaveMoney]==1 then
local data=zhengzhanshanhaiModel:getybd_ybdmoney()or 0
local moneyName=itemsConfig.getItemName(eMoneyType.mtXuKongLing)
local reason
if not xianmengModel:hasXM()then
reason="未加入仙盟"
elseif not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
reason=FMT.fmt("{0}尚未开启",limitActivitiesModel:getActConfig(LIMIT_ACT_TYPE.eZhengZhanShanHai,"name"))
elseif not zhengzhanshanhaiModel:checkJoin()then
reason="仙盟未报名活动"
else
local state=zhengzhanshanhaiModel:getLunState()
if state==eZZSH_State.eIdle then
reason="等待下轮活动开启"
else
local saveValue=setupData[xzsDataKey.zzshYBDAutoSaveMoneyNum]
local limitValue=zhengzhanshanhaiController:getZZSHCfg_YBD(1,'ybdnums',2)
local targetValue=saveValue or limitValue
local haveNum=itemsModel.getCount(eMoneyType.mtXuKongLing)
if data<targetValue and haveNum>0 then
local args={
orderID=orderID,
notify=notifyConfig.onZZSHYBDMoneyChange,
overStr="储存操作超时",
time=0.2,
onStart=function(win)
win.oldValue=nil
win.newValue=nil
local maxNum=data+haveNum
local value=math.min(maxNum,targetValue)
zhengzhanshanhaiController:send_20_247(value)
xiaoZhuShouModel:flushSetupData()
end,
onNotify=function(win,ybdmoney,old,season)
if season==1 and ybdmoney>old then
win.oldValue=old
win.newValue=ybdmoney
return true
end
return false
end,
onCheck=function(win)
if win.oldValue and win.newValue then
local deltaValue=win.newValue-win.oldValue
return FMT.fmt("消耗{0}{1}补充至山海世界预备队，当前预备队已存储{2}{1}",deltaValue,moneyName,win.newValue)
end
end,
onComplete=function(win,overTime)
xiaoZhuShouController:setIdleState()
if not overTime then
local openFlag=zhengzhanshanhaiModel:getybd_openflag()
if not openFlag then
UIManager.info("山海世界预备队未开启")
return
end
local selflist=zhengzhanshanhaiModel:getybd_guildlist()
if selflist==nil or next(selflist)==nil then
UIManager.info("山海世界预备队未设置队伍")
return
end
end
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_zzsh_ybd,args)
else
local args={
orderID=orderID,
error=FMT.fmt("消耗{0}{1}补充至山海世界预备队，当前预备队已存储{2}{1}",0,moneyName,data),
onComplete=function()
xiaoZhuShouController:setIdleState()

local openFlag=zhengzhanshanhaiModel:getybd_openflag()
if not openFlag then
UIManager.info("山海世界预备队未开启")
return
end
local selflist=zhengzhanshanhaiModel:getybd_guildlist()
if selflist==nil or next(selflist)==nil then
UIManager.info("山海世界预备队未设置队伍")
return
end
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_zzsh_ybd,args)
end
return
end
end
local args={
orderID=orderID,
error=FMT.fmt("存储{0}至山海世界预备队操作失败({1})",moneyName,reason),
onComplete=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_zzsh_ybd,args)
end
end

function xiaoZhuShouOrderFunc.xjYBDAutoSaveMoney(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.xjYBDAutoSaveMoney]==1 then
local data=xianjieModel:getJiJieYBDData()
local moneyName=itemsConfig.getItemName(eMoneyType.mtXianLing)
local moneyNum=data and data.moneyNum or 0
if not seasonController:checkSeasonStageBegined(0,6)then
local seasonName=seasonModel:getHandleConfig(0,"name")
local stageName=seasonModel:getStageConfigEx(0,6,"name")
local args={
orderID=orderID,
error=FMT.fmt("存储{0}至仙界预备队操作失败(尚未开启{1}·{2})",moneyName,seasonName,stageName),
onComplete=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xj_ybd,args)
elseif not xianmengModel:hasXM()then
local args={
orderID=orderID,
error=FMT.fmt("存储{0}至仙界预备队操作失败(未加入仙盟)",moneyName),
onComplete=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xj_ybd,args)
else
local saveValue=setupData[xzsDataKey.xjYBDAutoSaveMoneyNum]
local limitNum=cfgHelper.get3(cfg_fairylandbaseconfig_get,1,'ybdMoneyParam',2)
local targetValue=saveValue or limitNum
local haveNum=itemsModel.getCount(eMoneyType.mtXianLing)
if moneyNum<targetValue and haveNum>0 then
local args={
orderID=orderID,
notify=notifyConfig.onXianJieYBDMoneyChange,
overStr="储存操作超时",
time=0.2,
onStart=function(win)
win.oldValue=nil
win.newValue=nil
local maxNum=moneyNum+haveNum
local value=math.min(maxNum,targetValue)
xianjieController:reqMassYBDMoneyAndSoldierSave(value)
xiaoZhuShouModel:flushSetupData()
end,
onNotify=function(win,num,old,season)
if season==1 and num>old then
win.oldValue=old
win.newValue=num
return true
end
return false
end,
onCheck=function(win)
if win.oldValue and win.newValue then
local deltaValue=win.newValue-win.oldValue
return FMT.fmt("消耗{0}{1}补充至仙界预备队，当前预备队已存储{2}{1}",deltaValue,moneyName,win.newValue)
end
end,
onComplete=function(win,overTime)
xiaoZhuShouController:setIdleState()

if not overTime then
local ybdData=xianjieModel:getJiJieYBDData()
local openFlag=ybdData and ybdData.openFlag or 0
local isOpen_PVE=bitHelper.check_pos(openFlag,0)
if not isOpen_PVE then
UIManager.info("仙界魔物预备队未开启")
return
end
local ybdTeamData=xianjieModel:getJiJieYBDData_teamDataByYBDType(1)
local hasYzData=ybdTeamData and ybdTeamData.yzId~=nil or false
if not hasYzData then
UIManager.info("仙界魔物预备队未设置队伍")
return
end
end
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xj_ybd,args)
else
local args={
orderID=orderID,
error=FMT.fmt("消耗{0}{1}补充至仙界预备队，当前预备队已存储{2}{1}",0,moneyName,data.moneyNum),
onComplete=function()
xiaoZhuShouController:setIdleState()

local ybdData=xianjieModel:getJiJieYBDData()
local openFlag=ybdData and ybdData.openFlag or 0
local isOpen_PVE=bitHelper.check_pos(openFlag,0)
if not isOpen_PVE then
UIManager.info("仙界魔物预备队未开启")
return
end
local ybdTeamData=xianjieModel:getJiJieYBDData_teamDataByYBDType(1)
local hasYzData=ybdTeamData and ybdTeamData.yzId~=nil or false
if not hasYzData then
UIManager.info("仙界魔物预备队未设置队伍")
return
end
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xj_ybd,args)
end
end
end
end

function xiaoZhuShouOrderFunc.showXzsShouYiZonglan(orderID)
local prizeList=xiaoZhuShouController:getPrizeList()
if not prizeList then

return
end

local moneyList={}
local itmeList={}
for i,itemData in ipairs(prizeList)do
local itemId=itemData.itemid
local itemNum=itemData.num
local itemGuid=itemData.itemguid
if itemsConfig.isMoney(itemId)then
table.insert(moneyList,itemData)
else
table.insert(itmeList,itemData)
end
end

if#moneyList>0 or#itmeList>0 then
table.sort(itmeList,function(a,b)
local aColor=itemsConfig.getItemColor(a.itemid)
local bColor=itemsConfig.getItemColor(b.itemid)
return aColor>bColor
end)
local args={endFlag=true,moneyList=moneyList,itmeList=itmeList}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_syzl,args)
end
end

function xiaoZhuShouOrderFunc.tysc_autoChallengeYS(orderID)
xianmengController:tyscAutoFight(orderID,1)
end

function xiaoZhuShouOrderFunc.tysc_autoChallengeSL(orderID)
xianmengController:tyscAutoFight(orderID,2)
end

function xiaoZhuShouOrderFunc.tysc_autoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if xianmengModel:checkRankReddot_TYSC()then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

xianmengController:send_248_16(1)
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可领取的奖励",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_tysc_receive,args)
end

function xiaoZhuShouOrderFunc.xfwd_autoChallenge(orderID)
UIXianFaWenDaoControl:xfwdAutoFight(orderID)
end

function xiaoZhuShouOrderFunc.tycy_autoChallenge(orderID)
worldLeaderController:tycyAutoFight(orderID)
end

function xiaoZhuShouOrderFunc.tycy_autoReceive(orderID)
xiaoZhuShouController:setIdleState()
end

function xiaoZhuShouOrderFunc.twxm_autoChallenge(orderID)
XianJieFuMoController:twxmAutoFight(orderID)
end

function xiaoZhuShouOrderFunc.twxm_autoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if XianJieFuMoController:checkTargetReddot()then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

local infos=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"target_reward")
local recvIndex=XianJieFuMoModel:getRecvIdx()
local curdamage=XianJieFuMoModel:getTotaldamage()
local idx=1
for i,v in ipairs(infos)do
if recvIndex<i and curdamage>=v[1]then
idx=i
end
end
XianJieFuMoController.req_248_104(idx,1)
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可领取的奖励",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_twxm_receive,args)
end

function xiaoZhuShouOrderFunc.xianbang_autoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if xianjiexianbangModel:getTaskRewardReddot()then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

xianjiexianbangController:send_37_82(1)
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="无可领取的仙榜任务奖励",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xianbang,args)
end

function xiaoZhuShouOrderFunc.taixucang_autoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if TaiXuCangModel:getNum()>0 then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

TaiXuCangController:send_6_142(1)
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="无可领取的仙宫军备",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_taixucang,args)
end

function xiaoZhuShouOrderFunc.littleworld_autoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if LittleWorldModel:canGetReward()then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

LittleWorldController.req_37_68(1)
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="无资源奖励可领取",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_littleworld,args)
end


function xiaoZhuShouOrderFunc.yflt_autoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if YiFangLingTianModel:HasHarvestPlant()then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

YiFangLingTianModel:HarvestMaturePlant(1)
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="无成熟的灵植可采摘",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_yflt,args)
end

function xiaoZhuShouOrderFunc.zmfy_autoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

local show=systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)and systemZongMenModel:haveSGReward()
if show then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

systemZongMenController:quickReqRewardVassal(1)
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="无宗门附庸奖励可领取",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_zmfy,args)
end

function xiaoZhuShouOrderFunc.tdmj_autoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if activitiesHandle_gongfagain:autoReceiveFreeGift(true)then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
sub_effecttype2=SUB_ACTIVITY_TYPE.eTianDaoMiJi,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

activitiesHandle_gongfagain:autoReceiveFreeGift()
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可领取的奖励",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_tdmj,args)
end

function xiaoZhuShouOrderFunc.xslb_autoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if activitiesHandle_xianshilibao:autoReceiveFreeGift(true)then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
sub_effecttype2=SUB_ACTIVITY_TYPE.eXianShiLiBao,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

activitiesHandle_xianshilibao:autoReceiveFreeGift()
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可领取的奖励",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xslb,args)
end

function xiaoZhuShouOrderFunc.xsqd_autoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if activitiesHandle_xianshiqiandao:autoReceiveFreeGift(true)then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
sub_effecttype2=SUB_ACTIVITY_TYPE.eXianShiQianDao,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

activitiesHandle_xianshiqiandao:autoReceiveFreeGift()
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可领取的奖励",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xsqd,args)
end

function xiaoZhuShouOrderFunc.xyxf_autoLottery(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if activitiesHandle_xianshichouka:autoReceiveFreeLottery(true)then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
sub_effecttype2=SUB_ACTIVITY_TYPE.eXianShiChouKa,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

activitiesHandle_xianshichouka:autoReceiveFreeLottery()
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可免费抽取的次数",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xyxf,args)
end

function xiaoZhuShouOrderFunc.dtfd_autoLottery(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if activitiesHandle_dongtianfudi:autoReceiveFreeLottery(true)then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
sub_effecttype2=SUB_ACTIVITY_TYPE.eDongTianFuDi,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

activitiesHandle_dongtianfudi:autoReceiveFreeLottery()
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可免费抽取的次数",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_dtfd,args)
end

function xiaoZhuShouOrderFunc.xgyj_autoLottery(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if activitiesHandle_xianguyiji:autoReceiveFreeLottery(true)then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
sub_effecttype2=SUB_ACTIVITY_TYPE.eXianGuYiJi,
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then

activitiesHandle_xianguyiji:autoReceiveFreeLottery()
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="没有可免费抽取的次数",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xgyj,args)
end

function xiaoZhuShouOrderFunc.ylc_autoSell(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local excutesList={}

if UIAquariumControl:autoSellFish(true)then
table.insert(excutesList,{1})
end

local count=#excutesList
local args=nil
if count>0 then
args={
orderID=orderID,
state=0,
interval=0.5,
sub_effecttype2=XIAOZHUSHUDETAIL_ENUM.xzs_sub_ylc_sell,
tipsStr="出售鱼种：",
excutes=excutesList,
stepFunc=function(data)
local sendType=data[1]
if sendType==1 then
UIAquariumControl:autoSellFish()
end
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="无可出售的鱼种",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ylc_sell,args)
end

function xiaoZhuShouOrderFunc.dft_chongBangRewardAutoReceive(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if setupData[xzsDataKey.dftChongBangRewardAutoReceive]~=1 then
return
end

local executeList={}

local hasRewards=douFaTaiModel:checkRewardReddot()
if hasRewards then
table.insert(executeList,{1})
end


local args=nil
if hasRewards then
args={
orderID=orderID,
state=0,
interval=0.5,
excutes=executeList,
stepFunc=function(data)

douFaTaiController:req_rank_reward(1)
end,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
else
args={
orderID=orderID,
state=-1,
error="暂无冲榜奖励可领取",
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
end

xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_dft_receive,args)
end
