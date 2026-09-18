









local subActivityInfo_wuxingbutian={name='subActivityInfo_wuxingbutian'}

function subActivityInfo_wuxingbutian:onInit()
local cfg=self:getSubActConfig()
local groupid=cfg.groupid
local cfgs=cfgHelper.get1(cfg_bubbleshooterlevelconfig_get,groupid)
self.groupid=groupid
self.maxLevel=#cfgs
local goodlist={}
local specExchange=cfg.specExchange
local changeMoneyLookup={}
for color,moneytype in pairs(cfg.shootCost)do
if color==0 then
self.ballMoneyType=moneytype
else
local cost=specExchange[moneytype]
table.insert(goodlist,{color,moneytype,{cost[1],cost[2]}})
end
changeMoneyLookup[moneytype]=true
end
self.changeMoneyLookup=changeMoneyLookup
table.sort(goodlist,function(a,b)
return a[1]<b[1]
end)
self.goodlist=goodlist
self.gameid=self.act_id..'_'..self.sub_act_type..'_'..self.sub_act_id
end

function subActivityInfo_wuxingbutian:onStart()

end

function subActivityInfo_wuxingbutian:onUpdate()

end

function subActivityInfo_wuxingbutian:onDelete()

end

function subActivityInfo_wuxingbutian:checkReddot()
return self:checkFixReward()
end

function subActivityInfo_wuxingbutian:getLevel()
return self.data.passLevel
end

function subActivityInfo_wuxingbutian:getNextLevel()
local lv=self:getLevel()
if lv<self.maxLevel then
lv=lv+1
end
return lv
end

function subActivityInfo_wuxingbutian:getLevelAndGroup()
return self.groupid,self:getNextLevel()
end

function subActivityInfo_wuxingbutian:getBallNum()
return moneyModel.getMoney(self.ballMoneyType)
end

function subActivityInfo_wuxingbutian:getBallMoneyType()
return self.ballMoneyType
end

function subActivityInfo_wuxingbutian:getFixReward()
local data=self.data
local target=self:getSubActConfig('target')
local total=data.totalScore or 0
local flag=data.rewardFlag or 0
local list={}
local c=0
for i,v in ipairs(target)do
local fix=total>=v[1]
if fix==true then
local f=mathHelper.getBitValue(flag,i-1)
if not f then
table.insert(list,i)
c=c+1
end
end
end
if c>0 then
return list
end
end

function subActivityInfo_wuxingbutian:checkFixRewardIndex(index)
local data=self.data
local target=self:getSubActConfig('target')
local total=data.totalScore or 0
local flag=data.rewardFlag or 0
local fix=total>=target[index][1]
if fix==true then
local f=mathHelper.getBitValue(flag,index-1)
if not f then
return true
end
end
return false
end

function subActivityInfo_wuxingbutian:checkFixReward()
local data=self.data
local target=self:getSubActConfig('target')
local total=data.totalScore or 0
local flag=data.rewardFlag or 0
for i,v in ipairs(target)do
local fix=total>=v[1]
if fix==true then
local f=mathHelper.getBitValue(flag,i-1)
if not f then
return true
end
end
end
return false
end

function subActivityInfo_wuxingbutian:checkDailyReward()








local data=self.data
local freeTime=data.freeTime or 0
if freeTime<=0 then
return true
end
local isCanGet=timeHelper.isOutFiveStamp2(timeHelper.convertLongStamp(freeTime))

return isCanGet
end

function subActivityInfo_wuxingbutian:getSubRankAct()
local actInfo=activitiesModel:getActInfo(self.act_id)
return actInfo:getSubList_subType(SUB_ACTIVITY_TYPE.eRankActCross)
end

function subActivityInfo_wuxingbutian:getGoodList()
return self.goodlist
end

function subActivityInfo_wuxingbutian:getChangeMoneyLookup()
return self.changeMoneyLookup
end

return subActivityInfo_wuxingbutian