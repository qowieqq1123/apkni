












function xianjieController:onAppStart_lingshou(isReconnet)

socketManager:register_receiver(47,1,xianjieController.recv_protocol_47_1)
socketManager:register_receiver(47,2,xianjieController.recv_protocol_47_2)
socketManager:register_receiver(47,3,xianjieController.recv_protocol_47_3)
socketManager:register_receiver(47,4,xianjieController.recv_protocol_47_4)
socketManager:register_receiver(47,5,xianjieController.recv_protocol_47_5)

end

function xianjieController:onEnterState_lingshou(isReconnet)
xianjieModel:onEnterState_lingshou()

notifySystem:listenNotify(notifyConfig.onXianJieLingShouDataChange,xianjieController.onXianJieLingShouDataChange)
notifySystem:listenNotify(notifyConfig.onXianJieLingShouGroupDataChange,xianjieController.onXianJieLingShouGroupDataChange)
end

function xianjieController:onLeaveState_lingshou(isReconnet)
xianjieModel:clearAllXJLingShouDatas()
xianjieModel:clearAllXJLingShouGroupDatas()
xianjieModel:onLeaveState_lingshou()

notifySystem:removelistener(notifyConfig.onXianJieLingShouDataChange,xianjieController.onXianJieLingShouDataChange)
notifySystem:removelistener(notifyConfig.onXianJieLingShouGroupDataChange,xianjieController.onXianJieLingShouGroupDataChange)
end



function xianjieController:onNormalUpdate_lingshou()
xpcall(function()
self:onUpdate_lingshou()
end,function(err)logErr(err)end)

xpcall(function()
self:onUpdate_lingshouGroup()
end,function(err)logErr(err)end)
end

function xianjieController:onUpdate_lingshou()
local list

local datas=self:getLingShouData_exExpire()
if datas==nil or next(datas)==nil then return end
local curTime=timeHelper.getServerShortTime()
for infoGuidStr,lsData in pairs(datas)do
if lsData and curTime>=lsData.expiresec then
lsData.isExpire=true

list=list or{}
table.insert(list,lsData)
end
end

if list and next(list)then
for index,lsData in ipairs(list)do
xianjieModel:changeLingshouSave(lsData)
end
end
end

function xianjieController:onUpdate_lingshouGroup()
local list

local datas=xianjieModel:getXJLingShouGroupDatas()
if datas==nil or next(datas)==nil then return end
local curTime=timeHelper.getServerShortTime()
for infoGuidStr,lsData in pairs(datas)do
if lsData and curTime>=lsData.expiresec then
lsData.isExpire=true

list=list or{}
table.insert(list,lsData)
end
end

if list and next(list)then
for index,lsData in ipairs(list)do
lsData.isExpire=true
xianjieModel:changeLingshouGroupSave(lsData)
end
end
end



function xianjieController.onXianJieLingShouDataChange(ctype,infoGuid)
if ctype==CHANGE_TYPE.eAdd then
xianjieController.listenNewLingShouData(xjServerEnityType.eLingShou,infoGuid)
end
end

function xianjieController.onXianJieLingShouGroupDataChange(ctype,infoGuid)
if ctype==CHANGE_TYPE.eAdd then
xianjieController.listenNewLingShouData(xjServerEnityType.eLingShouGroup,infoGuid)
end
end

function xianjieController.listenNewLingShouData(entityType,infoGuid)
if UIManager:isActive("UIXianJieLingShouSummonWin")then
UIManager:invokeUIMethod("UIXianJieLingShouSummonWin","play",{entityType=entityType,infoGuid=infoGuid})
else
UIManager:showWindow("UIXianJieLingShouSummonWin",{entityType=entityType,infoGuid=infoGuid,isPlay=true})
end
end


function xianjieController.recv_protocol_47_1(args)
xianjieModel:setInitData_LingShou(args)
end

function xianjieController.recv_protocol_47_2(itemID,randCount,state)
if state==1 then
UIManager:closeWindow("UIXianJieLingShouSummonWin")
return
end

xianjieModel:changeItemRand(itemID,randCount)
end

function xianjieController.recv_protocol_47_3(lsShareGuid)
xianjieModel:changeShareLSGuid(lsShareGuid)

end

function xianjieController.recv_protocol_47_4(lsJoinRwCount,lsKillRwCount)
xianjieModel:changeLingShouRewardCount(lsJoinRwCount,lsKillRwCount)

end

function xianjieController.recv_protocol_47_5(lsgGuid,joinCount)
xianjieModel:changeLingShouGroupRewardCount(lsgGuid,joinCount)

end


function xianjieController:reqXianJieLingShouInitData()
socketManager:send_47_1()
end

function xianjieController:reqRandLingShouPosition(itemID)

local posList1={}
posList1=self:checkGetCanBuildPosList(xjServerEnityType.eLingShou,10,posList1)

local posList2={}
posList2=self:checkGetCanBuildPosList(xjServerEnityType.eLingShouGroup,3,posList2)

socketManager:send_47_2(itemID,#posList1,posList1,#posList2,posList2)
end

function xianjieController:reqLingShouShare(lingshouGuid)
socketManager:send_47_3(lingshouGuid)
end




function xianjieController:getLingShouData(infoGuid)
return xianjieModel:getXJLingShouData(infoGuid)or xianjieModel:getXJLingShouGroupData(infoGuid)
end


function xianjieController:getLingShouData_exExpire(infoGuid)
return xianjieModel:getXJLingShouData_exExpire(infoGuid)or xianjieModel:getXJLingShouGroupData_exExpire(infoGuid)
end


function xianjieController:getFindCostItemGuarantee(itemID)
local useItemCount=xianjieModel:getItemRandCount(itemID)
local bdCount=cfgHelper.get(cfg_xianjielingshoulibconfig_get,itemID,'lsbdNum')
return bdCount-useItemCount
end



function xianjieController:checkGetCanBuildPosList(entitytype,needFindCount,list,radius,lookup)
list=list or{}
radius=radius or 1
lookup=lookup or{}


local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,entitytype,'size')
local gridWidth=size[1]
local gridHeight=size[2]

local sceneidx=xianjieModel:getSceneIndex()
local pos=xianjieController:getCameraLookAtPlanePos()
local cx,cz=xianjieController:worldPos2WorldGridPos(pos.x,pos.z)

local isPass=true
for x=cx-radius,cx+radius do
for z=cz-radius,cz+radius do
if lookup[x]==nil then
isPass=true
for x1=x,x+gridWidth-1 do
for z1=z,z+gridHeight-1 do
if xianjieModel:checkGridState2(sceneidx,x1,z1)then
isPass=false
break
end
end
if not isPass then
break
end
end
if isPass then
table.insert(list,{x,z})
if#list>=needFindCount then
return list
end
end
lookup[x]=z
end
end
end

if radius>15 then return list end
return self:checkGetCanBuildPosList(entitytype,needFindCount,list,radius+1,lookup)
end
