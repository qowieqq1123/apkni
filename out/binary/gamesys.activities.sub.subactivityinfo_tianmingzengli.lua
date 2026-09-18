









local subActivityInfo_tianmingzengli={name='tianmingzengli'}

function subActivityInfo_tianmingzengli:onInit()

end

function subActivityInfo_tianmingzengli:onStart()

end

function subActivityInfo_tianmingzengli:onDelete()

end

function subActivityInfo_tianmingzengli:checkReddot()

if not self:reqTianMingZengLi_checkDailyRewardsIsGot()then

return true
end


local libaoCfgList=self:getSubActConfig('rewards')
for i=1,#libaoCfgList do
local libaoCfg=libaoCfgList[i]
local libaoId=i
local dzId=libaoCfg[1]
local targetTianmingLv=libaoCfg[2]

local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzId)
local dzNowTmLv=-1
if dzData then
dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)
end
local openLibao=dzNowTmLv>=targetTianmingLv or false
if openLibao and not self:reqTianMingZengLi_checkFreeLibaoIsGot(libaoId)then
return true
end
end

return false
end


function subActivityInfo_tianmingzengli:reqTianMingZengLi_getFreeLibao(libaoId)
local count=1
local json_str=jsonHelper.encode({1,libaoId,count})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_tianmingzengli:reqTianMingZengLi_buyLibao(libaoId,rechargeId,buyCount)
local info={libaoId,buyCount}
local params=payControl.getActivityPayParams(self.act_id,self.sub_act_type,self.sub_act_id,info)
payControl.reqPay(rechargeId,buyCount,params)
end


function subActivityInfo_tianmingzengli:reqTianMingZengLi_getDailyRewards()






local giftid=self:getSubActConfig('freeLibaoId')
local data={self.act_id,self.sub_act_type,self.sub_act_id}
local subType=self.sub_act_type
return FreeGiftController.SendFreeGift(giftid,data,function(result)
if result then

local win=UIManager:findActiveWindow('UISubAct_tianmingzengliWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end)
end


function subActivityInfo_tianmingzengli:reqTianMingZengLi_checkFreeLibaoIsGot(libaoId)
if self.data.libaoList[libaoId]and self.data.libaoList[libaoId].freeGotCount and self.data.libaoList[libaoId].freeGotCount>0 then
return true
end
return false
end


function subActivityInfo_tianmingzengli:reqTianMingZengLi_getLibaoBuyCount(libaoId)
local libaoCfgList=self:getSubActConfig('rewards')
local libaoCfg=libaoCfgList[libaoId]
if not libaoCfg then
logErr(FMT.fmt("活动id: {0}, 活动类型: {1}, 子活动id: {2}配置表中找不到礼包索引为{3}对应的配置，请检查配置是否正确",self.act_id,self.sub_act_type,self.sub_act_id,libaoId))
return 0
end


local isResetDaily=libaoCfg[7]==1
if self.data.libaoList[libaoId]then
if isResetDaily then

local lastBuyTime=self.data.libaoList[libaoId].lastBuyTime
local isTodayData=timeHelper.isTodayStamp(timeHelper.convertLongStamp(lastBuyTime))
if not isTodayData then

return 0
end
end

return self.data.libaoList[libaoId].buyCount or 0
end
return 0
end


function subActivityInfo_tianmingzengli:reqTianMingZengLi_checkDailyRewardsIsGot()










local giftid=self:getSubActConfig('freeLibaoId')
local data={self.act_id,self.sub_act_type,self.sub_act_id}
return not FreeGiftController.GetFreeGift(giftid,data)
end

return subActivityInfo_tianmingzengli