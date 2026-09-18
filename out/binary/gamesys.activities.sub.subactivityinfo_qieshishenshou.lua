









local subActivityInfo_qieshishenshou={name='qingdainqiandao'}

function subActivityInfo_qieshishenshou:onInit()
self.data={}
end

function subActivityInfo_qieshishenshou:onStart()

end

function subActivityInfo_qieshishenshou:onDelete()

end

function subActivityInfo_qieshishenshou:checkReddot()
local datas=self:getSubActConfig('dzlist')
for i,v in ipairs(datas)do
local isCanReceive=FreeGiftController.GetFreeGift(v.gift,{self.act_id,self.sub_act_type,self.sub_act_id})
if isCanReceive then
return true
end
end
return false
end

return subActivityInfo_qieshishenshou