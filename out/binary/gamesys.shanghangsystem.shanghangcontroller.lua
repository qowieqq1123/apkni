






local _MODULENAME="shangHangController"

gameState.addListener(def_table(_MODULENAME))
shangHangController.name=_MODULENAME
shangHangController.data={}

function shangHangController:onAppStart()

shangHangModel:onAppStart()


socketManager:register_receiver(248,91,shangHangController.recv_248_91)
socketManager:register_receiver(248,101,shangHangController.recv_248_101)
socketManager:register_receiver(248,92,shangHangController.recv_248_92)
socketManager:register_receiver(248,93,shangHangController.recv_248_93)
socketManager:register_receiver(248,94,shangHangController.recv_248_94)
socketManager:register_receiver(248,95,shangHangController.recv_248_95)
socketManager:register_receiver(248,96,shangHangController.recv_248_96)
socketManager:register_receiver(248,97,shangHangController.recv_248_97)
socketManager:register_receiver(248,98,shangHangController.recv_248_98)
socketManager:register_receiver(248,99,shangHangController.recv_248_99)
socketManager:register_receiver(248,100,shangHangController.recv_248_100)
socketManager:register_receiver(248,102,shangHangController.recv_248_102)

















































end


function shangHangController:onEnterState(isReconnect)
shangHangModel:onEnterState()
notifySystem:listenNotify(notifyConfig.home_event,self.onHomeEvent)
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildingEvent)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.on_new_day)
end


function shangHangController:onProtocolReq()
shangHangModel:onProtocolReq()
end


function shangHangController:onLeaveState(isReconnect)
shangHangModel:onLeaveState(isReconnect)

self.data={}

end


function shangHangController:onLostConnection()

end


function shangHangController:onReConnection(isInitPro)
if isInitPro and mainControl:isInScene(eSceneType.eZongmen)then
if zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eShangHang)then
socketManager:send_248_91()
socketManager:send_248_92()
socketManager:send_248_93()
socketManager:send_248_100()
end
end
end

function shangHangController.onHomeEvent(etype)
if etype==homeEvent.eEnterHome then
if zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eShangHang)then
socketManager:send_248_91()
socketManager:send_248_92()
socketManager:send_248_93()
socketManager:send_248_100()
end
end
end

function shangHangController.onBuildingEvent(etype,sfId,ubdId,arg1,arg2,arg3)
if etype==buildingEvent.buildComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local buildType=cfg.build_type
if buildType==SLG_SYSTEM_TYPE.eShangHang then
socketManager:send_248_91()
socketManager:send_248_92()
socketManager:send_248_93()
end
end
end

function shangHangController.on_new_day()
shangHangModel:setLikeOrHateCnt(0)

local weekIdx=timeHelper.getWeakDateEx()
if weekIdx==1 then
shangHangModel:setGuPiaoData()
shangHangModel:setbuffList()
shangHangModel:setRecommendGuPiao()
shangHangModel:setActorGuPiaoData()
shangHangModel:setEventList()
shangHangModel:setItemEventList()
local startMoney=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"init_yq")
shangHangModel:setActorMoney(startMoney)
UIManager:callWindowFunc("UIShangHangMainWin","freshInfo")
UIManager:callWindowFunc("UIGuPiaoDetailWin","freshInfo")
UIManager:callWindowFunc("UIShangHangMainWin","freshEventInfo")

if zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eShangHang)then
shangHangController:get_gupiao_info()
end
end
end

function shangHangController:send_248_99()
local sendStamp=timeHelper.getServerShortTime()
if(shangHangController.stamp_248_99==nil)or shangHangController.stamp_248_99<sendStamp-30 then
socketManager:send_248_99()
return true
end
return false
end

function shangHangController:send_248_100()
local sendStamp=timeHelper.getServerShortTime()
if(shangHangController.stamp_248_100==nil)or shangHangController.stamp_248_100<sendStamp-30 then
socketManager:send_248_100()
return true
end
return false
end


function shangHangController:get_gupiao_info()
socketManager:send_248_91()
socketManager:send_248_92()
socketManager:send_248_93()
end










function shangHangController.recv_248_91(stock_len,stockList,buff_len,buffList,recommend_stock_id)
shangHangModel:setGuPiaoData(stockList)
shangHangModel:setbuffList(buffList)
shangHangModel:setRecommendGuPiao(recommend_stock_id)

UIManager:callWindowFunc("UIShangHangMainWin","freshInfo")

UIManager:callWindowFunc("UIGuPiaoDetailWin","freshInfo")

end




function shangHangController.recv_248_101(op_type,op_type2)
local likeCnt=shangHangModel:getLikeOrHateCnt()
shangHangModel:setLikeOrHateCnt(likeCnt+1)

if op_type==1 then
shanmenModel:add_gushen_like(op_type2)
elseif op_type==2 then
shanmenModel:add_jiushen_like(op_type2)
end

UIManager:callWindowFunc("UIGuPiaoRongYuWin","freshCount")

UIManager:callWindowFunc("UIShangHangLeftWin","refreshRongyuRed")
end













function shangHangController.recv_248_92(argtable)
shangHangModel:setActorGuPiaoData(argtable[2])

shangHangModel:setCanGetMoneyToday(argtable[3])
shangHangModel:setActorMoney(argtable[11])

shangHangModel:setLikeOrHateCnt(argtable[9])

shangHangModel:setInvestId(argtable[4])
shangHangModel:setInvestBeginTime(argtable[5])
shangHangModel:setInvestBuy(argtable[6])
shangHangModel:setInvestRewardFlag(argtable[7])
shangHangModel:setInvestRewardExFlag(argtable[8])

shangHangModel:setTotalInCome(argtable[12])
shangHangModel:setYesterdayTotalMoney(argtable[14])
shangHangModel:setYesterday_total_yq_diff(argtable[13])

UIManager:callWindowFunc("UIShangHangMainWin","freshInfo")

UIManager:callWindowFunc("UIShangHangMuBiaoWin","refresh")

UIManager:callWindowFunc("UIGuPiaoDetailWin","freshInfo")
end




function shangHangController.recv_248_93(event_len,eventList,itemEvent_len,itemEventList)
shangHangModel:setEventList(eventList)
shangHangModel:setItemEventList(itemEventList)
UIManager:callWindowFunc("UIShangHangMainWin","freshEventInfo")

UIManager:callWindowFunc("UIGuPiaoDetailWin","freshInfo")
end






function shangHangController.recv_248_94(len,buyList)
shangHangModel:clearDanMu()
if len>0 then
for i,v in ipairs(buyList)do
shangHangModel:addDanMu(v)
end
end

UIManager:callWindowFunc("UIShangHangMainWin","showSaveDanMu")
end




function shangHangController.recv_248_95(stock_id,stock_cnt)
local data=shangHangModel:getActorGuPiaoData(stock_id)or{}
local buy_price=data.buy_price or 0
local newCnt=stock_cnt+(data.stock_cnt or 0)
local gupiao=shangHangModel:getGuPiaoDatById(stock_id)
local price=gupiao.price
buy_price=buy_price+price*stock_cnt
shangHangModel:setActorGuPiaoDatById(stock_id,{stock_cnt=newCnt,buy_price=buy_price})

shangHangModel:setActorMoney(shangHangModel:getActorMoney()-price*stock_cnt)

UIManager:callWindowFunc("UIShangHangMainWin","freshInfo")



UIManager:callWindowFunc("UIShangHangMainWin","showDanMu",{id=stock_id,name=playerModel:getActorName(),num=stock_cnt})


socketManager:send_248_92()

UIManager.info(FMT.fmt("买进\"{0}\"{1}股",cfgHelper.get(cfg_shanghangstockconfig_get,stock_id,"name"),stock_cnt))

shangHangController.dealCD=timeHelper.getServerShortTime()
end




function shangHangController.recv_248_96(stock_id,stock_cnt)
local cfg=cfgHelper.get(cfg_shanghangstockconfig_get,stock_id)
local sell_stock_cost_rate=cfg.sell_stock_cost_rate
local gupiao=shangHangModel:getGuPiaoDatById(stock_id)
local price=gupiao.price

local data=shangHangModel:getActorGuPiaoData(stock_id)or{}
local buy_price=data.buy_price or 0
local newCnt=data.stock_cnt-stock_cnt
local sellPrice=price*stock_cnt
buy_price=buy_price-sellPrice
shangHangModel:setActorGuPiaoDatById(stock_id,{stock_cnt=newCnt,buy_price=buy_price})
shangHangModel:setActorMoney(mathHelper.floor(shangHangModel:getActorMoney()-sellPrice-sellPrice*sell_stock_cost_rate/10000))

UIManager:callWindowFunc("UIShangHangMainWin","freshInfo")


UIManager:callWindowFunc("UIShangHangMainWin","showDanMu",{id=stock_id,name=playerModel:getActorName(),num=-stock_cnt})


socketManager:send_248_92()

UIManager.info(FMT.fmt("卖出\"{0}\"{1}股",cfgHelper.get(cfg_shanghangstockconfig_get,stock_id,"name"),stock_cnt))

shangHangController.dealCD=timeHelper.getServerLongTime()
end


function shangHangController.recv_248_97()
shangHangModel:setCanGetMoneyToday(0)
UIManager:callWindowFunc("UIShangHangMainWin","freshDailyBtn")
end


function shangHangController.recv_248_98(flag1,flag2)

shangHangModel.data.investRewardFlag=flag1
shangHangModel.data.investRewardExFlag=flag2
UIManager:callWindowFunc("UIShangHangMuBiaoWin","refresh")
end





function shangHangController.recv_248_99(rank_len,rankList,myself_rank_idx)
shangHangModel:setRankList(rankList)

if rank_len>0 then
local myid=playerModel:getActorID()
for i,v in ipairs(rankList)do
v.rank_idx=i






if v.actor_id==myid then
myself_rank_idx=v.rank_idx
end
end
end

shangHangModel:setMyRank(myself_rank_idx)

UIManager:callWindowFunc("UIShangHangRankWin","freshInfo")

UIManager:callWindowFunc("UIGuPiaoCloseResultWin","freshInfo")

UIManager:callWindowFunc("UIGuPiaoWeekResultWin","refreshRank")
UIManager:callWindowFunc("UIGuPiaoYongJinWin","refreshRank")
end














function shangHangController.recv_248_100(argtable)
shanmenModel:init_gushen_data(argtable[8],argtable[7],argtable[9],argtable[10],argtable[11],argtable[12],argtable[14])
shanmenModel:init_jiushen_data(argtable[2],argtable[1],argtable[3],argtable[4],argtable[5],argtable[6],argtable[13])

UIManager:callWindowFunc("UIGuPiaoRongYuWin","freshInfo")
UIManager:callWindowFunc("UIShangHangLeftWin","refreshRongyuRed")
end

function shangHangController.recv_248_102(ret)
if ret==0 then
UIManager.error("已有相同卦签生效中，无法重复使用")
return
end
UIManager.info("卦签传闻将在下一价格波动周期生成")
shangHangController:get_gupiao_info()
UIManager:callWindowFunc("UIGuPiaoItemEventWin","refresh")
UIManager:callWindowFunc("UIShangHangLeftWin","refreshItemButton")

end



function shangHangController.send_save_leave_time(timeStamp)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.SHANGHANG_LEAVE_TIME,1,{timeStamp})
end

function shangHangController.load_leave_time(len,arr)
if len>0 then
shangHangModel:setServerLeaveTime(arr[1])
else
shangHangModel:setServerLeaveTime()
end
end



function shangHangController.saveLeaveData()
local now=timeHelper.getServerLongTime()
if not shangHangModel:isOpenTime(now)then
return
end
local actorData=shangHangModel:getActorGuPiaoDataList()
if actorData then
local list={}
for id,v in pairs(actorData)do
local price=shangHangModel:getGuPiaoPrice(v.stock_id)
local yingli=shangHangModel.calcYingLi(v.buy_price,v.stock_cnt,price)
v.yingli=yingli
list[tostring(id)]=v
end


local now=timeHelper.getServerShortTime()
shangHangModel:saveLastActorData(now,list)
shangHangController.send_save_leave_time(now)
end
end

function shangHangController:loadLeaveData()
local leaveData=shangHangModel:getLastActorData()
if not leaveData or(next(leaveData)==nil)then
return
end
UIManager:showWindow("UIGuPiaoZhangDieWin")
end

function shangHangController.getShowTime()
local nextTime,checkEnd=shangHangModel:getNextChangeTime(true,nil,true)
local endMonTime=shangHangModel:getMonEndTime(true)
local endEveTime=shangHangModel:getEveEndTime(true)
if shangHangModel:isWeekClose()then
local closeDay=shangHangModel.getCloseDay()+1
return FMT.fmt("{0}休市中",timeHelper.format_week_chinese(closeDay==7 and 0 or closeDay))
end
local now=timeHelper.getServerShortTime()


if now>endEveTime then
local openMonTime=shangHangModel:getMonBeginTime(true)
local weekIdx=timeHelper.getWeakDateEx()
local closeDay=shangHangModel.getCloseDay()
if closeDay==7 then closeDay=0 end
if weekIdx==closeDay then
return FMT.fmt("{0}休市中",timeHelper.format_week_chinese(closeDay))
end
return FMT.fmt("距离早市开市:\n<color=#ca631d>{0}</color>",timeHelper.format_time_stamp3(openMonTime+86400-now))
end

local openMonTime=shangHangModel:getMonBeginTime(true)
if now<openMonTime then
return FMT.fmt("距离早市开市:\n<color=#ca631d>{0}</color>",timeHelper.format_time_stamp3(openMonTime-now))
end

local openEveTime=shangHangModel:getEveBeginTime(true)
if now<openEveTime and now>endMonTime then
return FMT.fmt("距离晚市开市:\n<color=#ca631d>{0}</color>",timeHelper.format_time_stamp3(openEveTime-now))
end
if endMonTime<nextTime and now<endMonTime then
return FMT.fmt("距离早市收市:\n<color=#ca631d>{0}</color>",timeHelper.format_time_stamp3(endMonTime-now))
end
if checkEnd==2 and now<endEveTime and now>endMonTime then
return FMT.fmt("距离晚市收市:\n<color=#ca631d>{0}</color>",timeHelper.format_time_stamp3(endEveTime-now))
end
return FMT.fmt("下次价格波动:\n<color=#ca631d>{0}</color>",timeHelper.format_time_stamp3(nextTime-now))
end

function shangHangController:showBuyDialog(id)
local yuquan=shangHangModel:getActorMoney()
local gupiaoData=shangHangModel:getGuPiaoDatById(id)
if not gupiaoData then
return
end
local price=gupiaoData.price
local max=math.floor(yuquan/price)
if max==0 then
UIManager.error("玉券不足")
return
end






local cfg=cfgHelper.get(cfg_shanghangstockconfig_get,id)
local iconStr=shangHangModel.getYuQuanIconStr(32)

local refresh1=function(num)
return FMT.fmt('{0}股',num)
end
local refresh2=function(num)
return FMT.fmt('{0}/股',price)
end
local refresh3=function(num)
return num*price
end

local show_data={
title='买进',
refreshcallback1=refresh1,
refreshcallback2=refresh2,
refreshcallback3=refresh3,
max=max,
icon=shangHangModel.getGuPiaoIcon(gupiaoData.stock_id),
name=cfg.name,
oktext='购买',
canceltext='取消',
okcallback=function(num)
if shangHangController.isPassShangHangBuyCheck then
socketManager:send_248_95(id,num)
return
end
local now=timeHelper.getServerLongTime()
if not shangHangModel:isOpenTime(now)then
UIManager.error("休市中无法交易")
return
end
local nextTime=shangHangModel:getNextChangeTime()
if nextTime-now<=60 then
UIManager.error("即将价格变动，无法交易")
return
end
local cd=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"per_deal_cd")

if shangHangController.dealCD and shangHangController.dealCD+cd>now then
UIManager.error("交易繁忙")
return
end
socketManager:send_248_95(id,num)
end,
text11="买进数量：",
text22=FMT.fmt("每股价格：{0}",iconStr),
text33=FMT.fmt("买进总价：{0}",iconStr),
}
UIManager:showWindow("UIGuPiaoBuyCountWin",show_data)
end

function shangHangController:showSellDialog(id)
local gupiaoData=shangHangModel:getGuPiaoDatById(id)
if not gupiaoData then
return
end

local actorData=shangHangModel:getActorGuPiaoData(id)or{}

local stock_cnt=actorData.stock_cnt or 0
local buy_price=actorData.buy_price or 0
local price=gupiaoData.price
local max=stock_cnt

if max==0 then
UIManager.error("持有股不足")
return
end





local cfg=cfgHelper.get(cfg_shanghangstockconfig_get,id)
local iconStr=shangHangModel.getYuQuanIconStr(32)
local sell_stock_cost_rate=cfg.sell_stock_cost_rate










local refresh1=function(num)
return FMT.fmt('{0}股',num)
end
local refresh3=function(num)
return FMT.fmt('{0}%',sell_stock_cost_rate/100)
end
local refresh4=function(num)



local cost=num*price-buy_price/stock_cnt*num-sell_stock_cost_rate*price*num/10000
local zdColor=cost>=0 and FONT_COLOR_VAL[FONT_COLOR.eRedColor]or FONT_COLOR_VAL[FONT_COLOR.eGreenColor]
return FMT.fmt('<color={1}>{0}</color>',math.floor(cost),zdColor)
end
local refresh5=function(num)

local cost=num*price-buy_price/stock_cnt*num-sell_stock_cost_rate*price*num/10000
local zdColor=cost>=0 and FONT_COLOR_VAL[FONT_COLOR.eRedColor]or FONT_COLOR_VAL[FONT_COLOR.eGreenColor]
return FMT.fmt('<color={1}>{0}</color>',math.floor(num*price-sell_stock_cost_rate*price*num/10000),zdColor)
end

local show_data={
title='卖出',
refreshcallback1=refresh1,
refreshcallback3=refresh3,
refreshcallback4=refresh4,
refreshcallback5=refresh5,
max=max,
icon=shangHangModel.getGuPiaoIcon(gupiaoData.stock_id),
name=cfg.name,
oktext='卖出',
canceltext='取消',
okcallback=function(num)
if shangHangController.isPassShangHangBuyCheck then
socketManager:send_248_96(id,num)
return
end

local now=timeHelper.getServerLongTime()

if not shangHangModel:isOpenTime(now)then
UIManager.error("休市中无法交易")
return
end

local nextTime=shangHangModel:getNextChangeTime()
if nextTime-now<=60 then
UIManager.error("即将价格变动，无法交易")
return
end
local cd=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"per_deal_cd")

if shangHangController.dealCD and shangHangController.dealCD+cd>now then
UIManager.error("交易繁忙")
return
end
socketManager:send_248_96(id,num)
end,
text11="卖出数量：",
text22=FMT.fmt("每股价格：{0} {1}/股",iconStr,price),
text33="手续费率：",
text44=FMT.fmt("利润:		  "),
text55=FMT.fmt("卖出总价：{0}",iconStr),
speIcon=true
}
UIManager:showWindow("UIGuPiaoBuyCountWin",show_data)
end

function shangHangController.showTransformMoney(moneyRoot,offsetPos)
local num=shangHangModel:getZiChanZongZhi()
local week_reward_conf=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"week_reward_conf")
local mula=math.floor(num*(num/(num+week_reward_conf[1])*week_reward_conf[2])+week_reward_conf[3])
local iconStr=chatEmotHelper.getIconEmotMesg(iconHelper.getIconName(week_reward_conf[4]),25)
local limit=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"money_rewards_limit")
if mula>limit[2]then
mula=limit[2]
end

local cond_str=FMT.fmt("<color=#b7b7b7>预计本周结算时可转化为{1}<color=#aae252>{0}</color></color>",mula,iconStr)
UIManager:showWindow('UIConditionTipsTwo',{showType=eArrowDirectionType.eTopLeft,
descTable={FMT.fmt("<color=#b7b7b7>总资产：</color>{0}",mathHelper.formatNumber5(num,2)),cond_str},
posItem=moneyRoot,
pos=offsetPos})
end



function shangHangController.showCloseResultWin(rootWin)
if newbieControl.isInNewbie()then
return
end
local shownResultClose=shangHangModel:isInResultClose()
if shangHangModel:isInMonClose()then

local showMonEndTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eShangHangData,"monEndTime",0)
local now=timeHelper.getServerShortTime()
if showMonEndTime<now-3*3600 then
rootWin:showWindow("UIGuPiaoCloseResultWin",{closeType=1})
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eShangHangData,"monEndTime",now)
end
elseif shangHangModel:isInEveClose()then
local showEveEndTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eShangHangData,"eveEndTime",0)
local now=timeHelper.getServerShortTime()
if showEveEndTime<now-11*3600 then
if not shownResultClose then
rootWin:showWindow("UIGuPiaoCloseResultWin",{closeType=2})
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eShangHangData,"eveEndTime",now)
end
end

end
if shownResultClose then
local canShow=true
if next(shangHangModel:getActorGuPiaoDataList())==nil then
canShow=false
end
if newbieControl.isInNewbie()then
canShow=false
end
if canShow then
local showResultTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eShangHangData,"resultTime",0)
local now=timeHelper.getServerShortTime()
if showResultTime<now-11*3600 then
rootWin:showWindow("UIGuPiaoWeekResultWin")
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eShangHangData,"resultTime",now)
end
end
end

end

function PassShangHangBuyCheck()
if deviceHelper.isRunEditor()then
if strict_if_strict then
strict_if_strict(false)
end
shangHangController.isPassShangHangBuyCheck=true
if strict_if_strict then
strict_if_strict(true)
end
end
end



