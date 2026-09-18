










local xjData={}

function xjData:__init(dataType,data)
self.dataType=dataType
for k,v in pairs(data)do
self[k]=v
end
xpcall(function()
self:onInit()
end,function(err)
loggerUtil.logErrFMT('xjData onInit err!{0}',err)
end)
end


function xjData:getID()
return self.m_ID
end

function xjData:getDataType()
return self.dataType
end


function xjData:onInit()

end

function xjData:__delete()
self:onDelete()
end


function xjData:onDelete()

end





local xjEntityData={}

function xjEntityData:__init(dataType,data)
self.dataType=dataType
for k,v in pairs(data)do
self[k]=v
end
xpcall(function()
self:onInit()
end,function(err)
loggerUtil.logErrFMT('xjEntityData onInit err!{0}',err)
end)
if self.gridState~=nil then
xianjieModel:setGridState(self.sceneidx,self.gridX,self.gridZ,self.gridWidth,self.gridHeight,self.gridState,true)
end
end


function xjEntityData:onInitExtraData()
xianjieModel:initBuffData(self)
end


function xjEntityData:refreshEntityByExtraData(newData)
xianjieModel:handleBuffList_OnRefresh(self,newData)
xianjieModel:refreshEntityBuff(self,newData)
end

function xjEntityData:getWorldPos()

return xianjieController:worldGridPos2WorldPos4(self.gridX_c,self.gridZ_c,self.sceneidx)
end

function xjEntityData:getWorldPos_1()

return xianjieController:worldGridPos2WorldPos41(self.gridX_c,self.gridZ_c,self.sceneidx)
end


function xjEntityData:getCenterGridPos()
return self.gridX_c,self.gridZ_c,self.sceneidx
end


function xjEntityData:getCenterGridPosFloor()
return math.floor(self.gridX_c),math.floor(self.gridZ_c),self.sceneidx
end

function xjEntityData:getWorldSize()
return xianjieController:gridSize2WorldSize2(self.gridWidth,self.gridHeight)
end

function xjEntityData:getAtkSize()
return self:getWorldSize()
end

function xjEntityData:getTeamEnityKey()
return self:getBehaviorData('teamEntityKey')
end

function xjEntityData:checkInCurScene()
local sceneidx_=xianjieModel:getSceneIndex()
return self.sceneidx==sceneidx_
end

function xjEntityData:checkSameScene(sceneidx_)
return self.sceneidx==sceneidx_
end

function xjEntityData:getBaseWayTime(isIgnoreArea)
local gridX_c,gridZ_c,sceneidx=xianjieModel:getZongMenWorldGridCenterPos()
local movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,self.sceneidx,self.gridX_c,self.gridZ_c,nil,isIgnoreArea)
local speed=self.defaultSpeed
if speed==nil then

loggerUtil.logErrFMT("数据类型{0}没有设置默认速度, 请在数据onInit是赋值默认速度",self.dataType)

speed=xianjieModel:getCloudSearchSpeed()
end
return xianjieController:getMovePathWayTime(movePath,speed,isIgnoreArea)
end


function xjEntityData:checkMovePathCondition(isWarning,isPvP,isShowJumpTips)
if not isShowJumpTips then
isShowJumpTips=true
end

local gridX_c,gridZ_c,sceneidx,bornAreaID=xianjieModel:getZongMenWorldGridCenterPos()
local flag,g_list,errorParams=xianjieController:checkMovePath(bornAreaID,sceneidx,gridX_c,gridZ_c,self.sceneidx,self.gridX_c,self.gridZ_c,isWarning,isPvP)

if not flag then
if isWarning and isShowJumpTips then
local gateId=g_list and g_list[1]or nil
if gateId then
local content="是否前往最近的关口？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
return xianjieController:jumpMoJieGateByGateId(gateId)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
end
end

return flag,g_list,errorParams
end

function xjEntityData:getAreaID()
return xianjieModel:checkMapGridDataAreaID(self.sceneidx,self.gridX,self.gridZ)
end



function xjEntityData:createEntity(needRefreshAOI)

end

function xjEntityData:removeEntity(anim)
if self.ent_key then
if anim then
local ent=xianjieController:getEntity(self.ent_key)
if ent then
ent:playDeadAnim()
end
else
xianjieController:removeEntity(self.ent_key)
end
self.ent_key=nil
end
end

function xjEntityData:refreshEntity()
if self.ent_key==nil then
self:createEntity(true)
else
local ent=xianjieController:getEntity(self.ent_key)
if ent then
if self:checkInCurScene()then
if ent.refreshInfo then
ent:refreshInfo()
end
else
self:removeEntity()
end
end
end
end

function xjEntityData:getEntityKey()
return self.ent_key
end

function xjEntityData:getMyEntity()
if self.ent_key==nil then return end
return xianjieController:getEntity(self.ent_key)
end

function xjEntityData:selectEntity(isSelect)
if self.ent_key then
xianjieController:invokeEntityFunc(self.ent_key,'onSelect',nil,isSelect)
end
end


function xjEntityData:checkInRange(data_,range)
local gridWidth=self.gridWidth
local gridHeight=self.gridHeight
local sceneidx=self.sceneidx
local gridX=self.gridX
local gridZ=self.gridZ
local leftX=gridX-range
local rightX=gridX+gridWidth+range
local bottomZ=gridZ-range
local topZ=gridZ+gridHeight+range

return data_.sceneidx==sceneidx and
data_.gridX_c>=leftX and
data_.gridX_c<=rightX and
data_.gridZ_c>=bottomZ and
data_.gridZ_c<=topZ
end




function xjEntityData:initBehaviorData()

end

function xjEntityData:getBehaviorData(k)
if self.behaviorData then
return self.behaviorData[k]
end
end

function xjEntityData:setBehaviorData(k,v)
if self.behaviorData then
self.behaviorData[k]=v
end
end


function xjEntityData:clearBehavior(tree)
if self.behaviorID~=nil then
if tree:compareKey(self.behaviorID)then
self.behaviorID=nil
end
end
end


function xjEntityData:clearBehaviorEx()
if self.behaviorID then
xjBehaviorManager:removeTree(self.behaviorID)
self.behaviorID=nil
end
if self.behaviorData then

local entKey=self.behaviorData['teamEntityKey']
if entKey then
xianjieController:removeEntity(entKey)
end
self.behaviorData=nil
end
end


function xjEntityData:checkHideEntity()
return false
end




function xjEntityData:initTeamHandle()

end

function xjEntityData:clearTeamHandle()
if self.teamHandleID~=nil then
xianjieController:removeXJTeamHandle(self.teamHandleID)
self.teamHandleID=nil
end
end

function xjEntityData:getTeamHandleID()
return self.teamHandleID
end

function xjEntityData:getTeamHandle()
if self.teamHandleID~=nil then
return xianjieController:getXJTeamHandle(self.teamHandleID)
end
end


function xjEntityData:clearData()
self:removeEntity()
self:clearBehaviorEx()
self:clearTeamHandle()
end

function xjEntityData:__delete()
if self.gridState~=nil then
xianjieModel:setGridState(self.sceneidx,self.gridX,self.gridZ,self.gridWidth,self.gridHeight,self.gridState,false)
end
self:clearData()
self:onDelete()
end



local objID=0
local get_objID=function()
objID=objID+1
return objID
end
local num=50
local pool={}
local fileLookup={}
local objLookup={}

function check_xjClassLookup()
if next(objLookup)then








return false
end
return true
end

function clear_xjClassLookup()
check_xjClassLookup()
objLookup={}
end

function get_xjClass(mID)
return objLookup[mID]
end

function new_xjClass(dataType,data)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={




__index=xjData,
}
setmetatable(newT,mT)







end
local cfg=xjDataConfig[dataType]
if cfg then
local child=fileLookup[dataType]
if child==nil then
local filename=FMT.fmt('lua.gamesys.xianjie.data.{0}',cfg[2])
child=require(filename)
if child==nil then



return
else
fileLookup[dataType]=child
end
end
if cfg[1]>1 then
for k,v in pairs(xjEntityData)do
newT[k]=v
end
end
for k,v in pairs(child)do
newT[k]=v
end
else



end
local m_ID=get_objID()

newT.m_ID=m_ID
objLookup[m_ID]=newT
newT:__init(dataType,data)
return newT
end

function release_xjClass(obj)
if obj==nil then return end
local m_ID=obj.m_ID
if m_ID==nil then return end
obj:__delete()
objLookup[m_ID]=nil
local temp={}

for k,v in pairs(obj)do
temp[k]=true
end
for k,v in pairs(temp)do
obj[k]=nil
end
if#pool>=num then
return
end
table.insert(pool,obj)
end
