







mysteryTreasureModel=mysteryEntityBase.new(eMysteryEntityType.eTreasure,{})

mysteryTreasureModel.entityType=eMysteryEntityType.eTreasure


mysteryTreasureModel.hideList={}


mysteryTreasureModel.recordItemList={}


mysteryTreasureModel.existTimer={}
mysteryTreasureModel.treasure_queue=queue.New()


mysteryTreasureModel.boxType=
{
box=0,
rule=1,
}

function mysteryTreasureModel:get_config(id)
local config=cfg_baoboxconfig_get(id)
return config
end

function mysteryTreasureModel.get_treasure_config(id)
local config=cfg_baoboxconfig_get(id)
return config
end

function mysteryTreasureModel.get_rule_treasure_config(id)
local config=cfg_sslawrulelibraryconfig_get(id)
return config
end

function mysteryTreasureModel.is_treasure_rare(id)
local config=mysteryTreasureModel:get_config(id)
if config then
return config.rare==1
end
return false
end



function mysteryTreasureModel:init_data()
self.hideList={}
self.existTimer={}
self.cornerCount=0
self.showWindow=nil
self.finCB=nil
self.treasure_queue:clear()
self:loadRecordItemList()
end

function mysteryTreasureModel:get_entity_by_pos(pos,roomId,boxType)
if not self.entityList then
return
end
boxType=boxType or self.boxType.box
roomId=roomId or mysteryRoomModel:get_cur_roomID()
for guid,v in pairs(self.entityList)do
if v.data.boxType==boxType and mysteryPosHelper.is_same_pos(v.pos,pos,v.roomId,roomId)then
return v
end
end
end




























function mysteryTreasureModel:initItemList(list)
local newFlag={}
if self.recordItemList then
for i,v in ipairs(self.recordItemList)do
local key=v[3]~=nil and v[3]or v[1]
newFlag[key]=not v[4]
end
end
self.recordItemList={}
self.cornerCount=0
for i,v in ipairs(list)do

local guidStr=tostring(v.itemGuid)
local key=guidStr~='0'and v.itemGuid or v.itemId
local guid=guidStr~='0'and guidStr or nil
local old=newFlag[key]
table.insert(self.recordItemList,1,{v.itemId,v.itemNum,guid,not old})
self.cornerCount=self.cornerCount+1
end

mysteryTreasureModel:saveRecordItemList()
end

function mysteryTreasureModel:recordItem(itemId,num,itemguid)
table.insert(self.recordItemList,1,{itemId,num,itemguid~=nil and tostring(itemguid)or nil,true})
self.cornerCount=self.cornerCount+1
end

function mysteryTreasureModel:getRecordItemList()
return self.recordItemList or{}
end

function mysteryTreasureModel:loadRecordItemList()
self.recordItemList={}
local fbId=MysteryModel:get_cur_fbid()
if fbId then
local datas=userActorSetting.get('mysteryRecordItem'..fbId,{})
self.recordItemList=datas
end
end

function mysteryTreasureModel:setOld()
local list=self:getRecordItemList()
for i,v in ipairs(list)do
v[4]=nil
end
self.recordItemList=list
self:saveRecordItemList()
end

function mysteryTreasureModel:saveRecordItemList()
local fbId=MysteryModel:get_cur_fbid()
if fbId then
userActorSetting.flushVal('mysteryRecordItem'..fbId,self.recordItemList)

UIManager:invokeUIMethod("UIMysteryWin","showRecordPanel",self.recordItemList)
end
end

function mysteryTreasureModel:clearRecordItemList(fbId)
self.recordItemList={}
userActorSetting.flushVal('mysteryRecordItem'..fbId,{})
end

function mysteryTreasureModel:initCornerCount()
self.cornerCount=0
end

function mysteryTreasureModel:getCornerCount()
return self.cornerCount or 0
end