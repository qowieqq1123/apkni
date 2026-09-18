






local _MODULENAME="shangHangModel"


def_table(_MODULENAME)
shangHangModel.name=_MODULENAME
shangHangModel.data={}

function shangHangModel:onAppStart()

end


function shangHangModel:onEnterState(isReconnect)
self.data.guPiaoList={}
self.data.actorGuPiaoList={}
self.data.danMu={}
end


function shangHangModel:onProtocolReq()

end


function shangHangModel:onLeaveState(isReconnect)

self.data={}
self.data.guPiaoList={}
self.data.actorGuPiaoList={}

self.data.danMu={}
end

function shangHangModel.getYuQuanIcon()
return cfgHelper.get(cfg_shanghangbaseconfig_get,1,"yqIcon")
end

function shangHangModel.getYuQuanIconStr(size)
return chatEmotHelper.getIconEmotMesg(shangHangModel.getYuQuanIcon(),size or 32)
end

function shangHangModel.getGuPiaoIcon(gupiaoId)
return FMT.fmt("icon_gupiao_{0}",cfgHelper.get(cfg_shanghangstockconfig_get,gupiaoId,"icon"))
end

function shangHangModel:isWeekClose()
local weekIdx=timeHelper.getWeakDateEx()
local closeDay=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"final_eve_week")

return closeDay+1==weekIdx or(closeDay==6 and weekIdx==0)
end

function shangHangModel.getCloseDay()
return cfgHelper.get(cfg_shanghangbaseconfig_get,1,"final_eve_week")
end


function shangHangModel:getMonBeginTime(short)
if shangHangModel:isWeekClose()then
return 0
end
local mon_begin_time=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"mon_begin_time")
if short then
return timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp()+mon_begin_time[1]*3600+mon_begin_time[2]*60+mon_begin_time[3])
else
return timeHelper.getTodayZeroStamp()+mon_begin_time[1]*3600+mon_begin_time[2]*60+mon_begin_time[3]
end
end


function shangHangModel:getMonEndTime(short)
if shangHangModel:isWeekClose()then
return 0
end
local mon_end_time=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"mon_end_time")

if short then
return timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp()+mon_end_time[1]*3600+mon_end_time[2]*60+mon_end_time[3])
else
return timeHelper.getTodayZeroStamp()+mon_end_time[1]*3600+mon_end_time[2]*60+mon_end_time[3]
end
end


function shangHangModel:getEveBeginTime(short)
if shangHangModel:isWeekClose()then
return 0
end
local eve_begin_time=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"eve_begin_time")
if short then
return timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp()+eve_begin_time[1]*3600+eve_begin_time[2]*60+eve_begin_time[3])
else
return timeHelper.getTodayZeroStamp()+eve_begin_time[1]*3600+eve_begin_time[2]*60+eve_begin_time[3]
end
end


function shangHangModel:getEveEndTime(short)
if shangHangModel:isWeekClose()then
return 0
end
local eve_end_time=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"eve_end_time")
if short then
return timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp()+eve_end_time[1]*3600+eve_end_time[2]*60+eve_end_time[3])
else
return timeHelper.getTodayZeroStamp()+eve_end_time[1]*3600+eve_end_time[2]*60+eve_end_time[3]
end
end

function shangHangModel:getResultTime(short)
local closeDay=shangHangModel.getCloseDay()
local weekIdx=timeHelper.getWeakDateEx()
local dayStamp=(closeDay-weekIdx)*86400
local week_reward_time=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"eve_end_time")
if short then
return timeHelper.convertShortStamp(dayStamp+timeHelper.getTodayZeroStamp()+week_reward_time[1]*3600+week_reward_time[2]*60+week_reward_time[3])
else
return dayStamp+timeHelper.getTodayZeroStamp()+week_reward_time[1]*3600+week_reward_time[2]*60+week_reward_time[3]
end
end

function shangHangModel:isOpenTime(now)
return(now>=shangHangModel:getMonBeginTime()and now<shangHangModel:getMonEndTime())or(now>=shangHangModel:getEveBeginTime()and now<shangHangModel:getEveEndTime())
end

function shangHangModel:getNextChangeTime(short,now,checkEnd)
now=now or timeHelper.getServerLongTime()
if not shangHangModel:isOpenTime(now)then
return 0
end
local zero=timeHelper.getTodayZeroStamp()
local change_time=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"stock_price_change_time")
local changeStamp
for i,v in ipairs(change_time)do
changeStamp=zero+v[1]*3600+v[2]*60+v[3]
if changeStamp>now then
return short and timeHelper.convertShortStamp(changeStamp)or changeStamp
end
end

local endTime=shangHangModel:getMonEndTime()
if now<endTime then
if checkEnd then
return short and timeHelper.convertShortStamp(endTime)or endTime,1
else
return short and timeHelper.convertShortStamp(endTime)or endTime
end
end

endTime=shangHangModel:getEveEndTime()
if now<endTime then
if checkEnd then
return short and timeHelper.convertShortStamp(endTime)or endTime,2
else
return short and timeHelper.convertShortStamp(endTime)or endTime
end
end

return 0
end


function shangHangModel:getLastChangeTime(now,short)

if not shangHangModel:isOpenTime(now)then
return 0
end
local zero=timeHelper.getTodayZeroStamp()
local change_time=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"stock_price_change_time")
local changeStamp

local s
local num=#change_time
for i=1,num do
s=change_time[num-i+1]
changeStamp=zero+s[1]*3600+s[2]*60+s[3]

if changeStamp<now then
return short and timeHelper.convertShortStamp(changeStamp)or changeStamp
end
end

local endTime=shangHangModel:getEveBeginTime()
if now>endTime then
return short and timeHelper.convertShortStamp(endTime)or endTime
end

local endTime=shangHangModel:getMonBeginTime()
if now>endTime then
return short and timeHelper.convertShortStamp(endTime)or endTime
end


return 0
end

function shangHangModel:isInMonClose()
local long=timeHelper.getServerLongTime()
local monTime=shangHangModel:getMonEndTime()
local eveTime=shangHangModel:getEveBeginTime()
return long>monTime+5 and long<eveTime
end

function shangHangModel:isInEveClose()
local long=timeHelper.getServerLongTime()
local eveTime=shangHangModel:getEveEndTime()
local monTime=shangHangModel:getMonBeginTime()

if eveTime==0 then
return false
end

local weekIdx=timeHelper.getWeakDateEx()
local closeDay=shangHangModel.getCloseDay()
if closeDay==7 then closeDay=0 end
if weekIdx==closeDay then
local resultTime=shangHangModel:getResultTime()
return long>eveTime and long<resultTime
else
return long>eveTime+5 and long<monTime+86400
end
end

function shangHangModel:isInResultClose()
local long=timeHelper.getServerLongTime()
local resultTime=shangHangModel:getResultTime()
return long>=resultTime and long<resultTime+86400
end

function shangHangModel.calcZhangDie(day_price,price)
if day_price==0 then return 0 end
return math.floor((price-day_price)*100/day_price*100)/100
end


function shangHangModel.calcYingLi(buy_price,stock_cnt,price)
if buy_price==0 then return 0 end
return math.floor((stock_cnt*price-buy_price)/buy_price*10000)/100
end





function shangHangModel:setGuPiaoData(guPiaoList)
self.data.guPiaoList={}
if guPiaoList then
for i,v in ipairs(guPiaoList)do
if v.changeList then
local changeTime={}
for ii,vv in ipairs(v.changeList)do
if type(vv)=='number'then
v.changeList[ii]={vv,self.calcZhangDie(v.day_price,vv)}
else
v.changeList[ii]={vv.param_1,self.calcZhangDie(v.day_price,vv.param_1)}
changeTime[ii]=vv.param_2
end
end
v.changeTime=changeTime
end
self.data.guPiaoList[v.stock_id]=v
end
end
end

function shangHangModel:getGuPiaoData()
return self.data.guPiaoList or{}
end

function shangHangModel:getGuPiaoDatById(id)
return shangHangModel:getGuPiaoData()[id]
end

function shangHangModel:getGuPiaoPrice(id)
local data=shangHangModel:getGuPiaoData()[id]
return data and data.price or 0
end

function shangHangModel:getGuPiaochangeList(id)
local data=shangHangModel:getGuPiaoData()[id]
if data.changeList then return data.changeList end
end


function shangHangModel:setbuffList(buffList)
self.data.buffList=buffList
end

function shangHangModel:getbuffList()
return self.data.buffList or{}
end


function shangHangModel:setRecommendGuPiao(stock_id)
self.data.recommend_stock_id=stock_id
end

function shangHangModel:getRecommendGuPiao()
return self.data.recommend_stock_id
end

function shangHangModel:setRankList(rankList)
self.data.rankList=rankList
end

function shangHangModel:getRankList()
return self.data.rankList
end

function shangHangModel:getUpDownTop()
local list=shangHangModel:getGuPiaoData()
local topUp=-1
local topUpid
local topDown=1
local topDownid
for id,v in pairs(list)do
if v.changeList then

local cur=shangHangModel.calcZhangDie(v.day_price,v.price)
if cur>topUp then
topUp=cur
topUpid=id
end
if cur<topDown then
topDown=cur
topDownid=id
end
end
end
return topUpid,topDownid
end





function shangHangModel:setActorGuPiaoData(actorStockList)
self.data.actorGuPiaoList={}
if actorStockList then
for i,v in ipairs(actorStockList)do
self.data.actorGuPiaoList[v.stock_id]=v
end
end
end

function shangHangModel:getActorGuPiaoDataList()
return self.data.actorGuPiaoList or{}
end

function shangHangModel:setActorGuPiaoDatById(id,changeList)
self.data.actorGuPiaoList[id]=self.data.actorGuPiaoList[id]or{}
for k,v in pairs(changeList)do
self.data.actorGuPiaoList[id][k]=v
end
end

function shangHangModel:getActorGuPiaoData(stock_id)
return self.data.actorGuPiaoList[stock_id]
end


function shangHangModel:setActorMoney(get_yq)
self.data.get_yq=get_yq
end

function shangHangModel:getActorMoney()
return self.data.get_yq or 0
end

function shangHangModel:setCanGetMoneyToday(get_yq)
self.data.get_today_yq=get_yq
end

function shangHangModel:getActorMoneyToday()
return self.data.get_today_yq or 0
end

function shangHangModel:setYesterdayTotalMoney(yesterday_total_yq)
self.data.get_yesterday_yq=yesterday_total_yq
end

function shangHangModel:getYesterdayTotalMoney()
return self.data.get_yesterday_yq or 0
end

function shangHangModel:setYesterday_total_yq_diff(yq)
self.data.yesterday_total_yq_diff=yq
end

function shangHangModel:getYesterday_total_yq_diff()
return self.data.yesterday_total_yq_diff or 0
end



function shangHangModel:setLikeOrHateCnt(cnt)
self.data.likeOrhateCnt=cnt
end

function shangHangModel:getLikeOrHateCnt()
return self.data.likeOrhateCnt or 0
end

function shangHangModel:checkLikeOrHateReddot()
local cnt=shangHangModel:getLikeOrHateCnt()
local gushen_data=shanmenModel:get_gushen_data()
local jiushen_data=shanmenModel:get_jiushen_data()
local flag1=gushen_data~=nil and next(gushen_data)~=nil and gushen_data.server~=0
local flag2=jiushen_data~=nil and next(jiushen_data)~=nil and jiushen_data.server~=0
local comment_cnt=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"comment_cnt")

local isBuy=false
local data=shangHangModel:getGuPiaoData()
for i,v in pairs(data)do
local acotrData=shangHangModel:getActorGuPiaoData(v.stock_id)
local cnt=acotrData~=nil and acotrData.stock_cnt or 0
if cnt>0 then
isBuy=true
break
end
end
return not isBuy and cnt<comment_cnt and(flag1 or flag2)
end



function shangHangModel:saveLastActorData(saveStamp,actorData)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eShangHangData,"leaveTime",saveStamp)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eShangHangData,"actorData",actorData)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eShangHangData)
end

function shangHangModel:getLastActorData()
local serverLeaveTime=self:getServerLeaveTime()
local clientLeaveTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eShangHangData,"leaveTime",nil)


if clientLeaveTime~=serverLeaveTime then return end
if clientLeaveTime==nil then return end

if shangHangModel:isWeekClose()then
return
end
local now=timeHelper.getServerLongTime()
if not shangHangModel:isOpenTime(now)then
return
end

local todayMon=shangHangModel:getMonBeginTime(true)
if todayMon==0 then return end
if not timeHelper.isOneDayShort(todayMon,clientLeaveTime)then return end

local showZhangDiePanel=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"showZhangDiePanel")
local now=timeHelper.getServerShortTime()
if clientLeaveTime>now-showZhangDiePanel then
return
end

return userActorArraySetting.get(ACTOR_SETTING_TYPE.eShangHangData,"actorData",nil)
end

function shangHangModel:setServerLeaveTime(time)
self.data.serverLeaveTime=time
end

function shangHangModel:getServerLeaveTime()
return self.data.serverLeaveTime
end

function shangHangModel:getZiChanZongZhi()
local val=self:getActorMoney()
local price
for id,v in pairs(self:getActorGuPiaoDataList())do
price=self:getGuPiaoPrice(id)
val=price*v.stock_cnt+val
end
return val
end


function shangHangModel:setMyRank(myRank)
self.data.myRank=myRank
end

function shangHangModel:getMyRank()
return self.data.myRank or 0
end


function shangHangModel:addDanMu(buyData)
local now=timeHelper.getServerShortTime()
table.insert(self.data.danMu,{id=buyData.param_2,num=buyData.param_1,name=buyData.param_3,addTime=now})
end


function shangHangModel:getDanMuList()
return self.data.danMu
end

function shangHangModel:delDanMu(index)
table.remove(self.data.danMu,index)
end

function shangHangModel:clearDanMu()
self.data.danMu={}
end



function shanmenModel:init_gushen_data(sid,name,yq,like,hate,icon,actorId)
self.data.gushen={server=sid,name=name,yuquan=yq,like=like,hate=hate,icon=icon,actorId=actorId}
end

function shanmenModel:init_jiushen_data(sid,name,yq,like,hate,icon,actorId)
self.data.jiushen={server=sid,name=name,yuquan=yq,like=like,hate=hate,icon=icon,actorId=actorId}
end

function shanmenModel:add_gushen_like(optype)
if self.data.gushen then
if optype==1 then
self.data.gushen.like=self.data.gushen.like+1
else
self.data.gushen.hate=self.data.gushen.hate+1
end
end
end

function shanmenModel:add_jiushen_like(optype)
if self.data.jiushen then
if optype==1 then
self.data.jiushen.like=self.data.jiushen.like+1
else
self.data.jiushen.hate=self.data.jiushen.hate+1
end
end
end

function shanmenModel:get_gushen_data()
return self.data.gushen
end

function shanmenModel:get_jiushen_data()
return self.data.jiushen
end