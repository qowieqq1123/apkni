









local subActivityInfo_hunyuandanhui={name='hunyuandanhui'}


function subActivityInfo_hunyuandanhui:onInit()
local itemTypeLookup={}
local item_conf=self:getSubActConfig('item_conf')
for itemId,v in pairs(item_conf)do
itemTypeLookup[v[2]]=itemId
end
self.itemTypeLookup=itemTypeLookup
end

function subActivityInfo_hunyuandanhui:onStart()

end

function subActivityInfo_hunyuandanhui:onUpdate()

end

function subActivityInfo_hunyuandanhui:onDelete()

end

function subActivityInfo_hunyuandanhui:checkUnlock(isWarning)
if self:api_Available()then
return true
else
if isWarning then
local showdata=
{
type='UIDialouge',
title='提示',
content="亲爱的祖师,为了确保您在【混元丹会】活动中的正常体验,请前往对应平台更新至最新客户端版本,如您仍遇到问题,请联系客服",
oktext='确定',
allowclickBG=true,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end
return false
end
end

function subActivityInfo_hunyuandanhui:getSubRankAct()
local actInfo=activitiesModel:getActInfo(self.act_id)
return actInfo:getSubList_subType(SUB_ACTIVITY_TYPE.eRankActCross)
end

function subActivityInfo_hunyuandanhui:checkReddot()
local data=self.data
if data then
if self:getChengJiuReddot()then
return true
end
if not self:checkFreeRewardsIsGot()then
return true
end
end
return false
end

function subActivityInfo_hunyuandanhui:getChengJiuReddot()
local data=self.data
if data then
if data.hasChengJiuChangell or data.chengjiuRed==nil then
data.hasChengJiuChangell=false
data.chengjiuRed=false
for i,v in pairs(data.taskList)do
if v.param_3==1 then
data.chengjiuRed=true
break
end
end
end
end
return data.chengjiuRed
end

function subActivityInfo_hunyuandanhui:checkFreeRewardsIsGot()
local data=self.data
if data then
return data.free_flag==1
end
return false
end

function subActivityInfo_hunyuandanhui:getItemIdByType(type)
return self.itemTypeLookup[type]
end

function subActivityInfo_hunyuandanhui:getItemCanUse(itemId)
local data=self.data
if data and itemId then
local maxUseNum=self:getItemMaxUseNum(itemId)or 0
local useItem=data.itemList[itemId]or 0
return maxUseNum==-1 or maxUseNum-useItem>0
end
return 0
end

function subActivityInfo_hunyuandanhui:getCurDanYaoId()
local data=self.data
if data then
return data.cur_id,data.next_id
end
return 0,0
end

function subActivityInfo_hunyuandanhui:getItemCanUseNum(itemId)
local data=self.data
if data and itemId then
local maxUseNum=self:getItemMaxUseNum(itemId)or 0
local useItem=data.itemList[itemId]or 0
local have=0
if moneyConfig.isMoney(itemId)then
have=moneyModel.getMoney(itemId)
else
have=bagModel.getItemCountById(itemId)
end
local canUseNum=maxUseNum==-1 and have or math.min(maxUseNum-useItem,have)

return canUseNum,useItem>=maxUseNum
end
return 0
end

function subActivityInfo_hunyuandanhui:getItemBuyCost(itemId)
local item_conf=self:getSubActConfig('item_conf')
if not item_conf[itemId]then
return nil
end
return item_conf[itemId][1]
end

function subActivityInfo_hunyuandanhui:getItemMaxUseNum(itemId)
local item_conf=self:getSubActConfig('item_conf')
if not item_conf[itemId]then
return 0
end
return item_conf[itemId][3]
end

function subActivityInfo_hunyuandanhui:getItemParam(itemId)
local item_conf=self:getSubActConfig('item_conf')
if not item_conf[itemId]then
return 0
end
return item_conf[itemId][4]
end

function subActivityInfo_hunyuandanhui:getHYDHSrc(type)
local icon=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,type,'icon')
return icon and FMT.fmt("image_hydh_zz{0}",icon)or"";
end

function subActivityInfo_hunyuandanhui:api_Available()
return deviceHelper.getAPILevel()>=434
end

return subActivityInfo_hunyuandanhui