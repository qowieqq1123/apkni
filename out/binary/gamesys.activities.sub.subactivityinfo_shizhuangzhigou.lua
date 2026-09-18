









local subActivityInfo_shizhuangzhigou={name='shizhuangzhigou'}

function subActivityInfo_shizhuangzhigou:onInit()

end

function subActivityInfo_shizhuangzhigou:onStart()
self:listenNotify(notifyConfig.on_item_list_changed,function(...)
self:on_item_changed(...)
end)
self:listenNotify(notifyConfig.onDiscipleCreate,function(...)
self:onDiscipleCreate(...)
end)
self:listenNotify(notifyConfig.onDressEquipUpStar,function(...)
self:onDressEquipUpStar()
end)
end

function subActivityInfo_shizhuangzhigou:onUpdate()

end

function subActivityInfo_shizhuangzhigou:onDelete()

end

function subActivityInfo_shizhuangzhigou:checkReddot()
local mydata=activitiesModel:getSubActInfoData(self.act_id,SUB_ACTIVITY_TYPE.ebuyact9,self.sub_act_id)
if mydata then
local gift_cnt=mydata.gift_cnt or 0
return gift_cnt<=0
end
end


function subActivityInfo_shizhuangzhigou:checkOtherCondition(isWarning)
local suit_conf=self:getSubActConfig("suit_conf")




for pageIndex,v in ipairs(suit_conf)do
if self:checkShowPage(pageIndex)then
return true
end
end
return false
end


function subActivityInfo_shizhuangzhigou:checkShowPage(pageIndex)
local checkItems=self:getSubActConfig("checkItems")
if not checkItems then
logErr("时装直购 没有配置 checkItems 不知道判断哪些时装是否激活满星",self.act_id,SUB_ACTIVITY_TYPE.ebuyact9,self.sub_act_id)
else
if checkItems[pageIndex]then
local clothItemid,upStarItemid=unpack(checkItems[pageIndex])
local isActive,isFullStar=ClothingHelper.checkClothAcitveAndFullStar(clothItemid,upStarItemid)
if isActive and isFullStar then
return false
end
else
logErr("时装直购 checkItems 缺少对应页签配置 ",self.act_id,SUB_ACTIVITY_TYPE.ebuyact9,self.sub_act_id,pageIndex)
end
end

local checkDisciples=self:getSubActConfig("checkDisciples")
if not checkDisciples then
logErr("时装直购 没有配置 checkDisciples 不知道判断哪些弟子是否拥有",self.act_id,SUB_ACTIVITY_TYPE.ebuyact9,self.sub_act_id)
else
if checkDisciples[pageIndex]then
local discipleid=checkDisciples[pageIndex]
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(discipleid)
return dzData~=nil
else
logErr("时装直购 checkDisciples 缺少对应页签配置 ",self.act_id,SUB_ACTIVITY_TYPE.ebuyact9,self.sub_act_id,pageIndex)
end
end

return true
end

function subActivityInfo_shizhuangzhigou:on_item_changed(argslist,lookup_guidStr,lookup_itemid,lookup_bag,lookup_change)





local checkItems=self:getSubActConfig("checkItems")
if not checkItems then
return
end
local refresh=false
for pageIndex,v in ipairs(checkItems)do
local clothItemid,upStarItemid=unpack(v)
if lookup_itemid[clothItemid]or lookup_itemid[upStarItemid]then


refresh=true
break
end
end
if refresh then

local args={}
args.hideRefreshSubList=true
self:refreshCondition(args)
end
end

function subActivityInfo_shizhuangzhigou:onDiscipleCreate(dis_guid)
local checkDisciples=self:getSubActConfig("checkDisciples")
if not checkDisciples then
return
end
local dzId=UIDiscipleModel:getDiscipleID(dis_guid)
local refresh=false
for _,discipleid in ipairs(checkDisciples)do
if dzId==discipleid then
refresh=true
break
end
end
if refresh then

local args={}
args.hideRefreshSubList=true
self:refreshCondition(args)
end
end

function subActivityInfo_shizhuangzhigou:onDressEquipUpStar()

local args={}
args.hideRefreshSubList=true
self:refreshCondition(args)
end


return subActivityInfo_shizhuangzhigou
