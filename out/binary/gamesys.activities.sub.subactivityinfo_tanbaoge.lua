









local subActivityInfo_tanbaoge={name='tanbaoge'}

function subActivityInfo_tanbaoge:onInit()
self:listenNotify(notifyConfig.onNewDay,function(...)
self:on_new_day(...)
end)
end

function subActivityInfo_tanbaoge:onStart()

end

function subActivityInfo_tanbaoge:onDelete()

end

function subActivityInfo_tanbaoge:checkReddot()
local reddot=false
if not self.data then

return reddot
end

local maxFreeNum=self:getSubActConfig('freeNum')


if not self.data.freeNum or self.data.freeNum<maxFreeNum then
return true
end


local hopeVal=self.data.hopeVal and self.data.hopeVal/100 or 0
if hopeVal>=100 then
return true
end


local costItemId=self:getSubActConfig('useItem')[1]
local hasItemCount=itemsModel.getCount(costItemId)or 0
if hasItemCount>=10 then
return true
end




return reddot
end


function subActivityInfo_tanbaoge:checkRankRewardReddot()
if not self.data.rankRewardInfoList then

return false
end

if self.data.rankRewardReddot then
return true
end


local count=#self.data.rankRewardInfoList
for i=count,1,-1 do

local info=self.data.rankRewardInfoList[i]
if info.rwFlag==0 then

return true
end
end

return false
end


function subActivityInfo_tanbaoge:getSelectRewardItemIdByFloorNum(floorNum)
if not self.data then

return nil
end

if self.data.nowSelectItemId and self.data.nowSelectItemFloor and floorNum==self.data.nowSelectItemFloor then
return self.data.nowSelectItemId
end

return nil
end


function subActivityInfo_tanbaoge:getSelectRewardItemData()
if not self.data then

return nil
end

return self.data.selectItemCountList
end


function subActivityInfo_tanbaoge:reqTanBaoGeDraw_free()
local json_str=jsonHelper.encode({1,1,1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_tanbaoge:reqTanBaoGeDraw_once()
local json_str=jsonHelper.encode({1,1,0})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_tanbaoge:reqTanBaoGeDraw_tenTimes()
local json_str=jsonHelper.encode({1,10,0})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_tanbaoge:reqTanBaoGeGetFirstClearReward(floor)
local json_str=jsonHelper.encode({4,floor})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_tanbaoge:reqTanBaoGeWish()
local json_str=jsonHelper.encode({5})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_tanbaoge:reqTanBaoGe_TLBH_jumpToNextGoldFloor()
local json_str=jsonHelper.encode({6,0})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_tanbaoge:reqTanBaoGe_TLBH_cancelJumpToNextGoldFloor()
local json_str=jsonHelper.encode({6,1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_tanbaoge:reqTanBaoGeGetFirstClearInfo()
local json_str=jsonHelper.encode({7})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_tanbaoge:reqTanBaoGeSetSelectRewardItemId(floor,itemId)
local json_str=jsonHelper.encode({8,floor,itemId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_tanbaoge:initRankRewardConfigList_sort()
local data=self:getData()or{}

local rankRewardCfg_lookup=self:getSubActConfig('mbReward')
data.rankRewardCfg={}
for k,v in pairs(rankRewardCfg_lookup)do
local listItem={clearFloor=k,rewards=v}
table.insert(data.rankRewardCfg,listItem)
end
table.sort(data.rankRewardCfg,function(a,b)return a.clearFloor<b.clearFloor end)

data.isInitConfig=true

self:setData(data)
end

function subActivityInfo_tanbaoge:on_new_day(...)
if not self.data then

return
end

self.data.freeNum=0

local subType=SUB_ACTIVITY_TYPE.eTanBaoGe
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

local win=UIManager:findActiveWindow('UISubAct_tanbaogeWin')
if win then
win:refreshBtnPanel()
end
end

return subActivityInfo_tanbaoge