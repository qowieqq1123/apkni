









local subActivityInfo_xiantuzhuli={name='xiantuzhuli'}

function subActivityInfo_xiantuzhuli:onInit()
self.rewards=self:getSubActConfig('rewards')
end

function subActivityInfo_xiantuzhuli:onStart()

end

function subActivityInfo_xiantuzhuli:onUpdate()

end

function subActivityInfo_xiantuzhuli:onDelete()

end

function subActivityInfo_xiantuzhuli:checkReddot()
if not self.data then

return false
end
for i,v in ipairs(self.rewards)do
if self:checkGiftReddot(i)then
return true
end
end
return false
end


function subActivityInfo_xiantuzhuli:checkGiftReddot(giftIndex)
return self:checkFreeReddot(giftIndex)or self:checkRewardReddot(giftIndex)
end


function subActivityInfo_xiantuzhuli:checkFreeReddot(giftIndex)
local freegiftList=self:getSubActConfig('freegiftList')
local giftid=freegiftList[giftIndex]
local data={self.act_id,self.sub_act_type,self.sub_act_id}
return FreeGiftController.GetFreeGift(giftid,data)
end


function subActivityInfo_xiantuzhuli:checkRewardReddot(giftIndex)
if not self:checkBuyState(giftIndex)then
return false
end
local curPack=self.rewards[giftIndex]
local zhuliList=curPack[4]
for i,v in ipairs(zhuliList)do
if self:checkRecvState(giftIndex,i)then
return true
end
end
return false
end

function subActivityInfo_xiantuzhuli:checkRecvState(giftIndex,index)
local curPack=self.rewards[giftIndex]
local zhuliList=curPack[4]
local curCount=self:getZhuLiCount(giftIndex)
local recvIndex=self:getRecvIndex(giftIndex)
local temp=zhuliList[index]
local num=temp[1]
local canReward=curCount>=num
local recvFlag=recvIndex>=index
if canReward and not recvFlag then
return true
end
return false
end



function subActivityInfo_xiantuzhuli:checkBuyState(giftIndex)
return self:getBuyCount(giftIndex)>0
end


function subActivityInfo_xiantuzhuli:checkAllBuyState()
for k,v in ipairs(self.data)do
if not self:checkBuyState(k)then
return false
end
end
return true
end


function subActivityInfo_xiantuzhuli:getGiftData(giftIndex)
local giftData=self.data[giftIndex]or{}
return giftData
end

function subActivityInfo_xiantuzhuli:getBuyCount(giftIndex)
local giftData=self:getGiftData(giftIndex)
return giftData.buyCount or 0
end

function subActivityInfo_xiantuzhuli:getRecvIndex(giftIndex)
local giftData=self:getGiftData(giftIndex)
return giftData.recvIndex or 0
end

function subActivityInfo_xiantuzhuli:getZhuLiCount(giftIndex)
local giftData=self:getGiftData(giftIndex)
return giftData.zhuLiCount or 0
end



function subActivityInfo_xiantuzhuli:checkNewDay()

end


function subActivityInfo_xiantuzhuli:startActTime()

end

return subActivityInfo_xiantuzhuli