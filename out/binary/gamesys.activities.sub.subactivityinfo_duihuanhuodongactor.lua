









local subActivityInfo_duihuanhuodongActor={name='duihuanhuodongActor'}

function subActivityInfo_duihuanhuodongActor:onInit()
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

function subActivityInfo_duihuanhuodongActor:onStart()
self:listenNotify(notifyConfig.on_money_changed,function(...)
self:on_money_changed(...)
end)
self:listenNotify(notifyConfig.on_item_changed,function(...)
self:on_item_changed(...)
end)
end

function subActivityInfo_duihuanhuodongActor:on_money_changed(moneyType,lastVal,val)
if self.itemLookup then
local lp=self.itemLookup[moneyType]
local c=0
if lp then c=#lp end
if c>0 then
UIManager:invokeUIMethod('UISubAct_duihuanhuodong_win','rec_Item',lp)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end

function subActivityInfo_duihuanhuodongActor:on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if self.itemLookup then
local lp=self.itemLookup[itemid]
local c=0
if lp then c=#lp end
if c>0 then
UIManager:invokeUIMethod('UISubAct_duihuanhuodong_win','rec_Item',lp)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end

function subActivityInfo_duihuanhuodongActor:onUpdate()

end

function subActivityInfo_duihuanhuodongActor:onDelete()
self.itemLookup=nil
end

function subActivityInfo_duihuanhuodongActor:checkReddot()
local data=self.data
if data then
local goodLookup=data.goodLookup
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
local a,b,reddotflag=self:GetShowList()
if reddotflag then
return true
end
end
return false
end


function subActivityInfo_duihuanhuodongActor:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then
local change=false
local exchanges=self:getSubActConfig('exchange')
for idx,d in pairs(data.goodLookup)do
local exchange=exchanges[idx]
if exchange[4]>0 then
change=true
end
end
if change then
UIManager:invokeUIMethod('UISubAct_duihuanhuodong_win','rec_refresh')
end
end
end
end

function subActivityInfo_duihuanhuodongActor:getGoodBuyNum(idx)
local data=self.data
if data then
local d=data.goodLookup[idx]
if d then
local exchanges=self:getSubActConfig('exchange')
local exchange=exchanges[idx]
if d.param_3>0 and exchange[4]>0 then
local cur=gameUtilityModel.getServerLongTime()
local time=gameUtilityModel.serverShortTimeToLong(d.param_3)
if timeHelper.checkInSameDay(cur,time)then
return d.param_2
else
return 0
end
else
return d.param_2
end
else
return 0
end
end
return nil
end
function subActivityInfo_duihuanhuodongActor:judeisnewItem(recorddata,idx)
for k,v in ipairs(recorddata)do
if v[1]==idx then
return true
end
end
return false
end

function subActivityInfo_duihuanhuodongActor:GetShowList()
local _key=FMT.fmt('actid{0}_subtype{1}_subid{2}',self.act_id,self.sub_act_type,self.sub_act_id)
local recorddata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eDuiHuanHuoDong2,_key,{})
local exchange=self:getSubActConfig('exchange')
local shopGoodList={}
local zmlv=zongmenModel:getLevel()

local notshowgoodList={}

local newshowgoodList={}
local showreddot=false
for idx,cfg in ipairs(exchange)do
local zmlv_=cfg[6]
local openCondition=cfg[8]
if zmlv>=zmlv_ then
if openCondition then
local flag=true
for k,v in ipairs(openCondition)do
if v[1]==1 then

local model=activitiesModel:getSubActInfo(self.act_id,self.sub_act_type,self.sub_act_id)
local start_time_l=model.start_time_l
if timeHelper.getPassDay(start_time_l)<v[2]then

flag=false
end
elseif v[1]==2 then

if timeHelper.getServerOpenDay()<v[2]then
flag=false
end
elseif v[1]==3 then

if zongmenModel:getLevel()<v[2]then
flag=false
end
end
end
if flag then
local d={}
d.cfg=cfg
d.buyidx=idx
self:handelData(d)
local newflag=self:judeisnewItem(recorddata,idx)
if newflag then
showreddot=true
end
d.newflag=newflag
table.insert(shopGoodList,d)
else
table.insert(notshowgoodList,{idx})
end
else
local d={}
d.cfg=cfg
d.buyidx=idx
self:handelData(d)
table.insert(shopGoodList,d)
end
end
end

return shopGoodList,notshowgoodList,showreddot
end



function subActivityInfo_duihuanhuodongActor:handelData(data)
local buyidx=data.buyidx
local maxbuy=data.cfg[3]
local curbuy=self:getGoodBuyNum(buyidx)
local lerpbuy=maxbuy-curbuy
if lerpbuy<0 then lerpbuy=0 end
local canbuy=0
local weight=data.cfg[7]
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

return subActivityInfo_duihuanhuodongActor