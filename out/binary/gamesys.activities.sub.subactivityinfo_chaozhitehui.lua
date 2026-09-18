









local subActivityInfo_chaozhitehui={name='chaozhitehui'}

function subActivityInfo_chaozhitehui:onInit()
self.flushKey=FMT.fmt('actid{0}_subtype{1}_subid{2}_selectList',self.act_id,self.sub_act_type,self.sub_act_id)
local buyCfg=self:getSubActConfig('buyCfg')
self.maxRechargeIndex=#buyCfg
self.maxBuyCnt=buyCfg[#buyCfg][2]
end

function subActivityInfo_chaozhitehui:onStart()

end

function subActivityInfo_chaozhitehui:onUpdate()

end

function subActivityInfo_chaozhitehui:onDelete()

end

function subActivityInfo_chaozhitehui:checkReddot()
if not self.data then

return false
end


return false

end



function subActivityInfo_chaozhitehui:checkNewDay()

end


function subActivityInfo_chaozhitehui:startActTime()

end

function subActivityInfo_chaozhitehui:getSelectIndex(rechargeIndex,itemListIndex)
local selectList=userActorSetting.get(self.flushKey,{})
local strRechargeIndex=tostring(rechargeIndex)
if selectList[strRechargeIndex]then
local strItemListIndex=tostring(itemListIndex)
return selectList[strRechargeIndex][strItemListIndex]or 0
end
return 0
end

function subActivityInfo_chaozhitehui:setSelectIndex(rechargeIndex,itemListIndex,index)
local selectList=userActorSetting.get(self.flushKey,{})
local strRechargeIndex=tostring(rechargeIndex)
if not selectList[strRechargeIndex]then
selectList[strRechargeIndex]={}
end
local strItemListIndex=tostring(itemListIndex)
selectList[strRechargeIndex][strItemListIndex]=index
userActorSetting.flushVal(self.flushKey,selectList)
end

function subActivityInfo_chaozhitehui:getRechargeIndex()

return self.data.rechargeIndex or 0
end

function subActivityInfo_chaozhitehui:getBuyCnt()
return self.data.buyCnt or 0
end

function subActivityInfo_chaozhitehui:checkOtherCondition()
if not self.data then

return false
end
if self.data.rechargeIndex<self.maxRechargeIndex then
return true
end
if self.data.rechargeIndex>self.maxRechargeIndex then
return false
end
return self.data.buyCnt<self.maxBuyCnt
end






return subActivityInfo_chaozhitehui
