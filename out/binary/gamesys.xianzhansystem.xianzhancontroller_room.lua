







xianzhanController.rebuildTime=3
xianzhanController.roomCnt=4

local roomPos={
[1]={-21.37,3.7},
[2]={-9.2,9.77},
[3]={10.3,9.77},
[4]={22.51,3.7},
}



function xianzhanController:checkRoomInit()
return xianzhanController.roomModelLookup~=nil
end

function xianzhanController:createAllRoomModel()
xianzhanController:removeAllRoomModel()
xianzhanController:clearAllRoomBuildEffect()
xianzhanController:clearAllRoomBuildFinishEffect()

xianzhanController.roomSelectEffectLookup={}
xianzhanController.roomModelLookup={}
xianzhanController.roomBuildEffectLookup={}
xianzhanController.roomBuildFinishEffectLookup={}

local roomsData=xianzhanModel:getRoomsData()
for k,v in pairs(roomsData)do
xianzhanController:refreshRoomModel(v.roomId)
end
end

function xianzhanController:removeAllRoomModel()
local lp1=xianzhanController.roomSelectEffectLookup
if lp1~=nil then
for roomId,guid in pairs(lp1)do
_stopEffect(guid)
end
xianzhanController.roomSelectEffectLookup=nil
end
local lp2=xianzhanController.roomModelLookup
if lp2~=nil then
for roomId,guid in pairs(lp2)do
_InstantiateManager.RemoveInstance(guid)
end
xianzhanController.roomModelLookup=nil
end
end

function xianzhanController:refreshAllRoomModel()
if xianzhanController.isInXianZhan==nil then return end
xianzhanController:removeAllRoomModel()
xianzhanController:createAllRoomModel()
end

function xianzhanController:refreshRoomModel(roomId)
xianzhanController:removeRoomModel(roomId)

local lp=xianzhanController.roomModelLookup

local data=xianzhanModel:getRoomDataByRoomId(roomId)
local lock=data.unlockStatus==0
local pos=roomPos[roomId]
local scaleX=1
if roomId==3 or roomId==4 then
scaleX=-1
end
local index=0
local order
if roomId==1 or roomId==4 then
order=-1
else
order=-105
end
local modelid
if lock then
modelid=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'lockroommodelid')
else
modelid=cfgHelper.get2(cfg_xianzhanzhuangxiuconfig_get,data.zhuangxiuTypeId,'modelid')
end
local guid
local parent=_MapManager.GetPartComponent(mapIdType.xianzhan,index,'Transform')
guid=_InstantiateManager.AddInstance(modelid,parent,function(id)
if not xianzhanController:checkRoomInit()then return end
local widget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
if widget then
widget:SetChildLocalPosition(-1,Vector3(pos[1],pos[2],0))
widget:SetChildScale(0,Vector3(scaleX,1,1))
widget:SetChildUISetChildSortingGroupOrder(-1,order,-1)

xianzhanController:refreshRoomSelect(widget,roomId)
end
end)
lp[roomId]=guid
end

function xianzhanController:refreshRoomSelect(widget,roomId)
if not xianzhanController:checkRoomInit()then return end

if widget==nil then
local lp=xianzhanController.roomModelLookup
local roomguid=lp[roomId]
if roomguid then
widget=_InstantiateManager.GetComponent(roomguid,'CSGUIWidgetBase')
end
end
if widget~=nil then
local data=xianzhanModel:getRoomDataByRoomId(roomId)
local lock=data.unlockStatus==0

local isReBuilding=xianzhanModel:isBuildingModel()
local roomType=data.zhuangxiuTypeId
local rebuildRoomType=xianzhanModel:getRebbuildRoomType()
local showKuang=not lock and isReBuilding==true and not xianzhanController:isInBuilding(roomId)
local showselect=showKuang and rebuildRoomType~=nil and rebuildRoomType~=roomType and data.customerId<=0
local lp2=xianzhanController.roomSelectEffectLookup
local effectguid=lp2[roomId]
if showselect then
if effectguid==nil then
local parent=widget:GetCommonComponent(1,'Transform')
lp2[roomId]=_MapManager.PlayEffectByParent(parent,10118)
end
else
if effectguid~=nil then
_stopEffect(effectguid)
lp2[roomId]=nil
end
end
end
end

function xianzhanController:refreshAllRoomSelect()
local roomsData=xianzhanModel:getRoomsData()
for k,v in pairs(roomsData)do
local roomId=v.roomId
xianzhanController:refreshRoomSelect(nil,roomId)
end
end

function xianzhanController:clearRoomSelectEffect(roomId)
local lp=xianzhanController.roomSelectEffectLookup
if lp~=nil then
local guid=lp[roomId]
if guid~=nil then
_stopEffect(guid)
lp[roomId]=nil
end
end
end

function xianzhanController:removeRoomModel(roomId)
xianzhanController:clearRoomSelectEffect(roomId)
local lp=xianzhanController.roomModelLookup
if lp~=nil then
local guid=lp[roomId]
if guid~=nil then
_InstantiateManager.RemoveInstance(guid)
lp[roomId]=nil
end
end
end

function xianzhanController:showRoomBuildEffect(roomId,func)
if not xianzhanController:checkRoomInit()then return end

xianzhanController:clearRoomSelectEffect(roomId)
xianzhanController:clearRoomBuildEffect(roomId)
xianzhanController:clearRoomBuildFinishEffect(roomId)

local lp=xianzhanController.roomBuildEffectLookup

local scale=1.1
local order
if roomId==1 or roomId==4 then
order=-100
else
order=-200
end
local roomguid=xianzhanController.roomModelLookup[roomId]
local widget=_InstantiateManager.GetComponent(roomguid,'CSGUIWidgetBase')
local parent=widget:GetCommonComponent(1,'Transform')
local enity=CS.EntityManager.Instance:AddUIEntity(parent,580032,nil,SortingLayers.Defult,order,scale)
enity.transform.localPosition=Vector3(0,-2,0)
local guid=enity.GUID
if roomId==3 or roomId==4 then
enity:SetFlipX(true)
end
enity:RunAnimator(eAnimationID.stand)
xianzhanModel:setRebuilding(roomId,true)
local dTimer=timeEventController.delayDo(xianzhanController.rebuildTime,function()
xianzhanController:roomBuildEffectFinish(roomId,func)
end)
local data={guid=guid,dTimer=dTimer}
lp[roomId]=data


AudioManager.playAudio(433)

UIManager:invokeUIMethod('UIXianZhanMapWin','refreshRoomHudSelect',nil,roomId)
UIManager:invokeUIMethod('UIXianZhanMapWin','refreshRoomBuildHud',nil,roomId,true)
end

function xianzhanController:roomBuildEffectFinish(roomId,func)
if not xianzhanController:checkRoomInit()then return end
xianzhanController:clearRoomBuildEffect(roomId)
xianzhanModel:setRebuilding(roomId,nil)

UIManager:invokeUIMethod('UIXianZhanMapWin','refreshRoomBuildHud',nil,roomId,false)

local str='房间已打扫干净'
local isReBuilding=xianzhanModel:isBuildingModel()
if isReBuilding then
str='房间已改建完毕'
end
UIManager.info(str)

AudioManager.playAudio(434)
if func then
func()
end

xianzhanController:clearRoomBuildFinishEffect(roomId)
local lp=xianzhanController.roomBuildFinishEffectLookup
local hudPos=cfgHelper.get2(cfg_xianzhanroomconfig_get,roomId,'hudPos')
local pos=Vector3(hudPos[1],hudPos[2],0)
pos=_MapManager.GetCellCenterWorld(mapIdType.xianzhan,_HexMapManager.Vector3ToVector3Int(pos),mapLayer.Data)
local effectid=_MapManager.PlayEffectByPos(pos,10124)
local dTimer=timeEventController.delayDo(1,function()
xianzhanController:clearRoomBuildFinishEffect(roomId)
end)
lp[roomId]={guid=effectid,dTimer=dTimer}
end

function xianzhanController:isInBuilding(roomId)
if xianzhanController:checkRoomInit()then
local lp=xianzhanController.roomBuildEffectLookup
return lp[roomId]~=nil
end
return false
end

function xianzhanController:clearRoomBuildEffect(roomId)
local lp=xianzhanController.roomBuildEffectLookup
if lp then
local data=lp[roomId]
if data~=nil then
CS.EntityManager.Instance:RemoveEntity(data.guid)
if data.dTimer then
data.dTimer:cancel()
data.dTimer=nil
end
lp[roomId]=nil
end
end
end

function xianzhanController:clearAllRoomBuildEffect()
local lp=xianzhanController.roomBuildEffectLookup
if lp then
for roomId,data in pairs(lp)do
CS.EntityManager.Instance:RemoveEntity(data.guid)
if data.dTimer then
data.dTimer:cancel()
data.dTimer=nil
end
end
xianzhanController.roomBuildEffectLookup=nil
end
end

function xianzhanController:clearRoomBuildFinishEffect(roomId)
local lp=xianzhanController.roomBuildFinishEffectLookup
if lp then
local data=lp[roomId]
if data~=nil then
_stopEffect(data.guid)
if data.dTimer then
data.dTimer:cancel()
data.dTimer=nil
end
lp[roomId]=nil
end
end
end

function xianzhanController:clearAllRoomBuildFinishEffect()
local lp=xianzhanController.roomBuildFinishEffectLookup
if lp then
for roomId,data in pairs(lp)do
_stopEffect(data.guid)
if data.dTimer then
data.dTimer:cancel()
data.dTimer=nil
end
end
xianzhanController.roomBuildFinishEffectLookup=nil
end
end

