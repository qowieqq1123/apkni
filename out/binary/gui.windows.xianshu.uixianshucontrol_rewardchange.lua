





local _rewardChangeList_Key='XianShuRewardChangeList'
function UIXianShuControl:readLocalRewardChangeList()
self.rewardChangeList={}
local temp=userActorSetting.get(_rewardChangeList_Key,{})

local xsID,xsStartStamp
for index,data in ipairs(temp)do
xsID=data[1]
xsStartStamp=data[2]
self.rewardChangeList[xsID]=xsStartStamp
end
end

function UIXianShuControl:writeLocalRewardChangeItem()
local xsID=self:getCurrentId()
local xsStartStamp=self:getStartTime()

self.rewardChangeList[xsID]=xsStartStamp

local temp={}

for _xsID,_xsStartStamp in pairs(self.rewardChangeList)do
temp[#temp+1]={_xsID,_xsStartStamp}
end

userActorSetting.set(_rewardChangeList_Key,temp)
userActorSetting.flush()
end

function UIXianShuControl:checkCurrentXsIDShowChangeRewardDialouge()

local rId=UIXianShuControl:getRechargeId()
if rId>0 then return false end

local xsID=self:getCurrentId()
local isShowRewardChangeDialouge=cfgHelper.get2(cfg_fairybookconfig_get,xsID,'isShowRewardChangeDialouge')
if isShowRewardChangeDialouge==nil or(not isShowRewardChangeDialouge)then return false end
if self.rewardChangeList[xsID]==nil then return true end

local xsStartStamp=self:getStartTime()

local logXsStartStamp=xsStartStamp
return xsStartStamp~=logXsStartStamp
end

function UIXianShuControl:resetLocalRewardChangeList()
userActorSetting.set(_rewardChangeList_Key,{})
userActorSetting.flush()
end
