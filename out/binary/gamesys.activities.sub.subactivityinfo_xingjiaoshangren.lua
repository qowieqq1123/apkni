









local subActivityInfo_xingjiaoshangren={name='xingjiaoshangren'}

function subActivityInfo_xingjiaoshangren:onInit()
self._onHomeEvent=function(...)
self:onHomeEvent(...)
end
self._sortItemList=function(a,b)
local stateA=self.data.itemState[a]or 0
local stateB=self.data.itemState[b]or 0
if stateA~=stateB then
return stateA<stateB
else
return a<b
end
end
end

function subActivityInfo_xingjiaoshangren:onStart()
self:listenNotify(notifyConfig.home_event,self._onHomeEvent)
end

function subActivityInfo_xingjiaoshangren:onUpdate()

end

function subActivityInfo_xingjiaoshangren:onDelete()
self:deleteEntity()
end

function subActivityInfo_xingjiaoshangren:checkReddot()
if self:hasData()then
return self:getFree()
end
return false
end

function subActivityInfo_xingjiaoshangren:onHomeEvent(etype)
if etype==homeEvent.eEnterHome then
self:createEntity()
elseif etype==homeEvent.eLeaveHome then
self:deleteEntity()
end
end

function subActivityInfo_xingjiaoshangren:initData(itemList)
local hasData=self:hasData()
local exchange=self:getSubActConfig("exchange")

if not hasData then
self.data={}
self.data.itemList={}
self.data.itemData={}
self.data.itemState={}
for itemId,info in pairs(exchange)do
table.insert(self.data.itemList,itemId)
end
else
table.clear(self.data.itemData)
table.clear(self.data.itemState)
end

if itemList then
for i,v in ipairs(itemList)do
self.data.itemData[v.param_1]=v.param_2

local finish=v.param_2>=exchange[v.param_1][1]
self.data.itemState[v.param_1]=finish and 1 or 0
end
end
self.data.itemSortDirty=true

self:createEntity()
end

function subActivityInfo_xingjiaoshangren:getFree()
local giftId=self:getSubActConfig("giftId")
local data={self.act_id,self.sub_act_type,self.sub_act_id}
return FreeGiftController.GetFreeGift(giftId,data)
end

function subActivityInfo_xingjiaoshangren:setItemCount(itemId,itemCnt)
if self:hasData()then
self.data.itemData[itemId]=itemCnt

local oState=self.data.itemState[itemId]
local exchange=self:getSubActConfig("exchange")
local nState=itemCnt>=exchange[itemId][1]and 1 or 0
if oState~=nState then

self.data.itemState[itemId]=nState
self.data.itemSortDirty=true
end
end
end

function subActivityInfo_xingjiaoshangren:getItemList()
if self.data.itemSortDirty then
self.data.itemSortDirty=false

if#self.data.itemList>1 then
table.sort(self.data.itemList,self._sortItemList)
end
end
return self.data.itemList
end

function subActivityInfo_xingjiaoshangren:getItemSortDirty()
return self.data.itemSortDirty
end

function subActivityInfo_xingjiaoshangren:getItemData()
return self.data.itemData
end

function subActivityInfo_xingjiaoshangren:getItemCount(itemId)
local list=self.data.itemData
return list[itemId]or 0
end

function subActivityInfo_xingjiaoshangren:checkFinish()
if self:hasData()then
local exchange=self:getSubActConfig("exchange")
for index,itemId in ipairs(self.data.itemList)do
local max=exchange[itemId][1]
local count=self:getItemCount(itemId)
if count<max then
return false
end
end
return true
end
return false
end

function subActivityInfo_xingjiaoshangren:randomPos()
local temp=self:getSubActConfig("posLib")
local list={}
for i,v in ipairs(temp)do
local cell=_MapManager.ToVector3Int(v[1],v[2],0)
local area=_MapManager.GetAreaID(mapIdType.zhufeng,cell)
if _MapManager.IsAreaUnlock(mapIdType.zhufeng,area)then
table.insert(list,cell)
end
end
return list[math.random(1,#list)]
end

function subActivityInfo_xingjiaoshangren:createEntity()
if self:checkDoing()and self:checkOpen()and mainControl:isSceneType(eSceneType.eZongmen)and isometricMapSystem:IsInHome()and self:hasData()then
local entityData=self:getEntityData()
if entityData==nil then
local modelCfg=self:getSubActConfig("model")
local body=modelCfg[1]
local slots=modelCfg[2]
local scale=modelCfg[3]
local pos=self:randomPos()
local guid=isometricMapSystem:createRoleEntity(objectType.eXingJiaoShangRen,mapIdType.zhufeng,0,body,slots,SortingLayers.ITBuilding,scale,pos)
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_range_move',{stId=guid},true,{})
local offset=_MapManager.GetObjectHeadOffset(guid)
local hud=hudControl:addHUD(INSTANCE_TYPE.eDiscipleState,guid,offset,true,true,function(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,'icon_xinjiaoshang_1')
widget:SetChildButtonClick(1,function()
self:onClickEntity()
end)
widget:SetChildActive(1,not self:checkFinish())
end)
self.data.entityData={guid=guid,hud=hud,bt=bt}
else
self:refreshEntityHUD()
end
end
end

function subActivityInfo_xingjiaoshangren:getEntityData()
local data=self:getData()
if data then
return data.entityData
end
end

function subActivityInfo_xingjiaoshangren:deleteEntity()
local entityData=self:getEntityData()
if entityData then
if entityData.bt then
behaviorManager:removeBehaviorTree(entityData.bt)
end
if entityData.hud then
hudControl:removeHUD(entityData.hud)
end
_MapManager.RemoveTilemapObject(entityData.guid)
self.data.entityData=nil
end
end

function subActivityInfo_xingjiaoshangren:refreshEntityHUD()
local entityData=self:getEntityData()
if entityData and entityData.hud then
local widget=hudControl:getHUDWidget(entityData.hud)
widget:SetChildActive(1,not self:checkFinish())
end
end

function subActivityInfo_xingjiaoshangren:onClickEntity()
UIManager:showWindow("UIXingJiaoShangRenExchangeWin",{info=self})
end

return subActivityInfo_xingjiaoshangren
