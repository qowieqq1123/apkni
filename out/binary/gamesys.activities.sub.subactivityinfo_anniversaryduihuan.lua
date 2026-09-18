









local subActivityInfo_anniversaryduihuan={name='subActivityInfo_anniversaryduihuan'}

function subActivityInfo_anniversaryduihuan:onInit()
local itemLookup={}
local exchange=self:getSubActConfig('exchange')
for idx,v in ipairs(exchange)do
local costs=v[1]
for i2,v2 in ipairs(costs)do
local itemid=v2[1]
if itemLookup[itemid]==nil then
itemLookup[itemid]={}
end
table.insert(itemLookup[itemid],idx)
end
end
self.itemLookup=itemLookup
end

function subActivityInfo_anniversaryduihuan:onStart()
self:listenNotify(notifyConfig.on_money_changed,function(...)
self:on_money_changed(...)
end)
self:listenNotify(notifyConfig.on_item_list_changed,function(...)
self:on_item_list_changed(...)
end)
self:listenNotify(notifyConfig.onXianMengChange,function(...)
self:onXianMengChange(...)
end)
end

function subActivityInfo_anniversaryduihuan:on_money_changed(moneyType,lastVal,val)
if self.itemLookup then
local lp=self.itemLookup[moneyType]
local c=0
if lp then c=#lp end
if c>0 then
UIManager:invokeUIMethod('UISubAct_AnniversaryDuiHuanWin','rec_Item',lp)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end

function subActivityInfo_anniversaryduihuan:on_item_list_changed(argsTable)
if self.itemLookup then
for i,v in ipairs(argsTable)do
local changeType=v[1]
local itemid=v[3]
local lastcount=v[4]
local count=v[5]

local lp=self.itemLookup[itemid]
local c=0
if lp then c=#lp end
if c>0 then
UIManager:invokeUIMethod('UISubAct_AnniversaryDuiHuanWin','rec_Item',lp)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end
end

function subActivityInfo_anniversaryduihuan:onUpdate()

end

function subActivityInfo_anniversaryduihuan:onDelete()
self.itemLookup=nil
end

function subActivityInfo_anniversaryduihuan:checkReddot()
local data=self.data
if data then
local exchange=self:getSubActConfig('exchange')
for i,v in ipairs(exchange)do
local maxbuy=v[3]
local curbuy=self:getGoodBuyNum(i)
local fix=curbuy<maxbuy
if fix then
local costs=v[1]
for i2,v2 in ipairs(costs)do
local itemid=v2[1]
local itemnum=v2[2]
local hasnum
if moneyConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagModel.getNotExpireItemCountById(itemid)
end
if hasnum<itemnum then
fix=false
break
end
end
end
if fix then
return true
end
end
end
return false
end

function subActivityInfo_anniversaryduihuan:getIconFrame(icon)
local abname="ui/windows/activities/sub_anniversaryduihuan/anniversaryduihuan_atlas_pak.ab"
local winParams=self:getSubActConfig('winParams')
if not winParams then
return abname,icon
end
if winParams.abname then
abname=winParams.abname
end
if winParams.iconTypeStr then
icon=FMT.fmt("{0}_{1}",icon,winParams.iconTypeStr)
end
return abname,icon
end

function subActivityInfo_anniversaryduihuan:getZZIconFrame()
local winParams=self:getSubActConfig('winParams')
if not winParams or not winParams.zzImg or not winParams.abname then
return false
end
return true,winParams.abname,winParams.zzImg[1],winParams.zzImg[2],winParams.zzImg[3]
end

function subActivityInfo_anniversaryduihuan:getDiIconFrame()
local winParams=self:getSubActConfig('winParams')
if not winParams or not winParams.diIcon or not winParams.abname then
return false
end
return true,winParams.abname,winParams.diIcon
end

function subActivityInfo_anniversaryduihuan:getGoodBuyNum(idx)
local data=self.data
if data and data.goodLookup then
local d=data.goodLookup[idx]
if d then
return d.param_2
else
return 0
end
end
return 0
end


function subActivityInfo_anniversaryduihuan:GetShowList()
local exchange=self:getSubActConfig('exchange')
local shopGoodList={}
for idx,cfg in ipairs(exchange)do
local d={}
d.cfg=cfg
d.buyidx=idx
self:handelData(d,#exchange)
table.insert(shopGoodList,d)
end

return shopGoodList
end


function subActivityInfo_anniversaryduihuan:handelData(data,len)
local buyidx=data.buyidx
local maxbuy=data.cfg[3]
local curbuy=self:getGoodBuyNum(buyidx)
local lerpbuy=maxbuy-curbuy
if lerpbuy<0 then lerpbuy=0 end
local canbuy=0
local weight=len-data.buyidx
local state=0
local state_=0
local notfix
if lerpbuy>0 then
state_=1
local costs=data.cfg[1]
local lp={}
for i,v in ipairs(costs)do
local itemid=v[1]
local itemnum=v[2]
local hasnum
if moneyConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagModel.getNotExpireItemCountById(itemid)
end
lp[i]={itemnum,hasnum}
if hasnum<itemnum then
if notfix==nil then
notfix={itemid,itemnum-hasnum}
end
end
end
if notfix==nil then
state=2
else
state=1
end
if notfix==nil then
local min
for i,v in ipairs(lp)do
local m=math.floor(v[2]/v[1])
if min==nil or m<min then
min=m
end
end
if min~=nil then
canbuy=min
end
end
end
weight=weight+state_*1000

data.lerpbuy=lerpbuy
if canbuy>lerpbuy then
canbuy=lerpbuy
end
data.canbuy=canbuy
data.state=state
data.state_=state_
data.notfix=notfix
data.weight=weight
end


function subActivityInfo_anniversaryduihuan:GetShareList()
local data=self.data
if data.hasShareChange then
data.hasShareChange=false
local selfShareList={}
local shareList={}
if data then
local shareLookup=data.shareLookup or{}
for share_id,shareInfo in pairs(shareLookup)do
if shareInfo then
local shareData=table.weakCopy(shareInfo)
local maxNum=self:GetLeftShareTimes(shareData)
local isCanDuiHuan=maxNum>0
local weight=shareData.share_id or 0
if playerModel:checkActorId(shareData.actor_id)then
weight=weight+data.share_list_len*10
table.insert(selfShareList,shareData)
elseif isCanDuiHuan then
weight=weight+data.share_list_len*100
end
shareData.weight=weight
table.insert(shareList,shareData)
end
end
end
if#selfShareList>1 then
table.sort(selfShareList,function(a,b)
return a.weight>b.weight
end)
end
if#shareList>1 then
table.sort(shareList,function(a,b)
return a.weight>b.weight
end)
end
data.selfShareList=selfShareList
data.shareList=shareList
end
return data.selfShareList or{},data.shareList or{}
end

function subActivityInfo_anniversaryduihuan:GetRankList()
local data=self.data

if not data or not data.rank or#data.rank==0 or not data.last_rank_sec then
self:reqGetRankList()
return false
end
local rank_sec=self:getSubActConfig('rank_sec')
local cur_sec=gameUtilityModel.getServerShortTime()
if cur_sec>data.last_rank_sec+rank_sec then
self:reqGetRankList()
return false
end
return true,data.rank or{}
end

function subActivityInfo_anniversaryduihuan:GetRankReward(rank)
local data=self.data
if not data then
return{}
end
local rank_conf=self:getSubActConfig('rank_conf')
if not data.rankRewardLookup then
local rankRewardLookup={}
for i,v in ipairs(rank_conf)do
if v[1]==v[2]then
rankRewardLookup[v[1]]=i
else
for index=v[1],v[2]do
rankRewardLookup[index]=i
end
end
end
data.rankRewardLookup=rankRewardLookup
end
local cfg=rank_conf[data.rankRewardLookup[rank]]
if not cfg then
return{}
end
return cfg[3]
end

function subActivityInfo_anniversaryduihuan:GetMyRank()
local data=self.data
return data and data.m_rank or 0
end

function subActivityInfo_anniversaryduihuan:GetMyScore()
local data=self.data
return data and data.m_score or 0
end

function subActivityInfo_anniversaryduihuan:GetMyLeftShareMaxTimes()
local data=self.data
if not data then
return 0
end
local hasDay=self:getEndLeftDayTime()
local daily_share_num=self:getSubActConfig('daily_share_num')
local share_times=data.share_times or 0
return daily_share_num*hasDay-share_times
end

function subActivityInfo_anniversaryduihuan:GetMyLeftShareTimes()
local data=self.data
if not data then
return 0
end
local daily_share_num=self:getSubActConfig('daily_share_num')
local share_times=data.share_times or 0
return daily_share_num-share_times
end

function subActivityInfo_anniversaryduihuan:GetLeftShareTimes(shareInfo)
local data=self.data
if not data then
return 0
end
local have=bagModel.getNotExpireItemCountById(shareInfo.item_id_2)
local daily_share_num=self:getSubActConfig('daily_share_num')
local share_times=data.share_times or 0

if daily_share_num-share_times<=0 then
return 0,"兑换次数不足"
end

if have<=0 then
local itemName=itemsConfig.getItemName(shareInfo.item_id_2)
return 0,FMT.fmt("<color=#efb150>[{0}]</color>数量不足",itemName)
end

if daily_share_num-shareInfo.can_share_num<=0 then
return 0,"发起者兑换次数不足"
end

return math.min(have,daily_share_num-share_times,daily_share_num-shareInfo.can_share_num)
end

function subActivityInfo_anniversaryduihuan:reqGetxchange(index,num)
local json_str=jsonHelper.encode({1,index,num})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_anniversaryduihuan:reqAddSelfShare(item_id_1,item_id_2,num)
local json_str=jsonHelper.encode({2,item_id_1,item_id_2,num})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_anniversaryduihuan:reqGetOtherShare(actor_id,share_id,num)
local json_str=jsonHelper.encode({3,tostring(actor_id),share_id,num})
self.data.share_times=self.data.share_times+num
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_anniversaryduihuan:reqDelShare(share_id)
local json_str=jsonHelper.encode({4,share_id})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_anniversaryduihuan:reqGetRankList()
local json_str=jsonHelper.encode({5})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_anniversaryduihuan:onXianMengChange(flag)
if flag then
activitiesController:sendProtocol(actSendType.eComonReqInfo,self.act_id,self.sub_act_type,self.sub_act_id)
end
end

return subActivityInfo_anniversaryduihuan