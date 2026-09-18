











local isneeddelet=false
local isneechange=false
local bjbuoyLookup={}

function xianjieController:onAppStart_RDPosPint()
xianjieModel:onAppStart_RDPosPint()

socketManager:register_receiver(35,66,self.recv_35_66)
socketManager:register_receiver(35,67,self.recv_35_67)
socketManager:register_receiver(35,68,self.recv_35_68)
socketManager:register_receiver(35,69,self.recv_35_69)

notifySystem:listenNotify(notifyConfig.enterXianJie,self.onEnterXianJie)
notifySystem:listenNotify(notifyConfig.leaveXianJie,self.onLeaveXianJie)
end

function xianjieController:onEnterState_RDPosPint(isReconnet)
xianjieModel:onEnterState_RDPosPint(isReconnet)
end

function xianjieController:onLeaveState_RDPosPint(isReconnet)
xianjieModel:onLeaveState_RDPosPint(isReconnet)
isneeddelet=false
isneechange=false
bjbuoyLookup={}
end

function xianjieController:onProtocolReq_RDPosPint(isReconnet)
xianjieModel:onProtocolReq_RDPosPint(isReconnet)
end



function xianjieController:send_35_66(icon,content,sceneidx,x,y,cbid)
socketManager:send_35_66(icon,content,sceneidx,x,y,cbid)
end

function xianjieController:send_35_67(guid,icon,content,sceneidx,x,y,cbid)
socketManager:send_35_67(guid,icon,content,sceneidx,x,y,cbid)
end

function xianjieController:send_35_68(guid)
socketManager:send_35_68(guid)
end


function xianjieController:initRDPosPint(len,arry)
xianjieModel:initRDPosPint(len,arry)
end

function xianjieController.recv_35_66(arry)
local ret=arry[1]
if ret==0 then
xianjieModel:newRDdata(arry[1],arry[2],arry[3],arry[4],arry[5],arry[6])
local win=UIManager:findActiveWindow('UIXianJieArenaAct_infoWin')
if win then
UIManager:closeWindow("UIXianJieArenaAct_infoWin")
end
local win2=UIManager:findActiveWindow('UIXianJieArenaAct_buffWin')
if win2 then
UIManager:closeWindow("UIXianJieArenaAct_buffWin")
end
elseif ret==1 then
UIManager.info('留言内容超限，标记失败')
elseif ret==2 then
UIManager.info('无仙盟，标记失败')
elseif ret==3 then
UIManager.info('权限不足，标记失败')
elseif ret==4 then
UIManager.info('标记总数超限，标记失败')
elseif ret==5 then
UIManager.info('非法坐标，标记失败')
elseif ret==6 then
UIManager.info('留言中包含敏感词，标记失败')
end
end

function xianjieController.recv_35_67(arry)
isneechange=true
xianjieModel:setDdata(arry[1],arry[2],arry[3],arry[4],arry[5],arry[6])
local win=UIManager:findActiveWindow('UIXianJieArenaAct_infoWin')
if win then
UIManager:closeWindow("UIXianJieArenaAct_infoWin")
end
local win2=UIManager:findActiveWindow('UIXianJieArenaAct_buffWin')
if win2 then
UIManager:closeWindow("UIXianJieArenaAct_buffWin")
end
end

function xianjieController.recv_35_68(guid)
isneeddelet=true
xianjieModel:deletRDdata(guid)
end


function xianjieController.recv_35_69(len,arry)
xianjieModel:freshRDdatalist(len,arry)

UIManager:invokeUIMethod('UIXianJieBJOneWin','severfresh')
if isneeddelet then
UIManager:invokeUIMethod('UIXianJieBJTwoWin','severfresh',1)
elseif isneechange then
UIManager:invokeUIMethod('UIXianJieBJTwoWin','severfresh',2)
else
UIManager:invokeUIMethod('UIXianJieBJTwoWin','severfresh',0)
end
isneeddelet=false
isneechange=false
end


function xianjieController.openBJwin(_posx,_posy,_sceneidx,_cbid)
if not _posx or not _posy or not _sceneidx or not _cbid then
logErr(FMT.fmt('传入的标记坐标错误,x={0},y={1},sceneidx={2},实体id={3}',_posx,_posy,_sceneidx,_cbid))
return
end


if systemModel.isOpen(SYSTEM_DEFINE.eXianJieBiaoJi)then
local flag=2
local actorid=playerModel:getActorID()
local pos=xianmengModel:getXMMemberPost(actorid)
if pos then
if pos==GUILD_POST_TYPE.gpAllyLeader or pos==GUILD_POST_TYPE.gpViceLeader then
flag=1
end
end
if flag==1 then
UIManager:showWindow('UIXianJieBJOneWin',{posx=_posx,posy=_posy,sceneidx=_sceneidx,cbid=_cbid})
elseif flag==2 then
local bjdata=xianjieModel:getRDdataByPos(_posx,_posy,_sceneidx)
if bjdata then
UIManager:showWindow('UIXianJieBJThreeWin',{posx=_posx,posy=_posy,sceneidx=_sceneidx,cbid=_cbid})
else
logErr(FMT.fmt('后端没有下发标记坐标,x={0},y={1},sceneidx={2}',_posx,_posy,_sceneidx))
end
end
else
UIManager.info('系统暂未开启')
end
end



function xianjieController.getZuoBiaoType(flag)
if flag==1 then
return xjClientBuildType.flcbBJ1
elseif flag==2 then
return xjClientBuildType.flcbBJ2
elseif flag==3 then
return xjClientBuildType.flcbBJ3
elseif flag==5 then
return xjClientBuildType.flcbBJ5
elseif flag==6 then
return xjClientBuildType.flcbBJ6
elseif flag==7 then
return xjClientBuildType.flcbBJ7
else
return xjClientBuildType.flcbBJ1
end





end







function xianjieController.onEnterXianJie(sceneType)



xianjieController:createAllZuobiao(true)
end

function xianjieController.onLeaveXianJie(sceneType)
if sceneType==xianjienSceneType.eXianJie then

end
end


function xianjieController:createAllZuobiao(isInitMap)
local allbjdata=xianjieModel:getRDdata()
local num=0
if allbjdata and next(allbjdata)then
for k,v in pairs(allbjdata)do
if v.icon>0 then
xianjieModel:createZBData(v.x,v.y,v.sceneidx,v.content,v.icon,v.cbid)
num=num+1
end
end
end
if num>0 then
xianjieModel:createAllZBEntities(isInitMap)
end
end

function xianjieController:clearZBClass()
xianjieModel:clearData_allZB()
end


function xianjieController:CreateOnlyZuobiao(list)
for k,flGuildFlag in ipairs(list)do
local x=flGuildFlag.x
local y=flGuildFlag.y
local sceneidx=flGuildFlag.sceneidx
local content=flGuildFlag.content
local icon=flGuildFlag.icon
local cbid=flGuildFlag.cbid
if x and y and sceneidx then
xianjieModel:createZBData(x,y,sceneidx,content,icon,cbid)
end
end
for k,flGuildFlag in ipairs(list)do
local x=flGuildFlag.x
local y=flGuildFlag.y
local sceneidx=flGuildFlag.sceneidx
if x and y and sceneidx then
local key=xianjieModel.getPosKey(x,y,sceneidx)
xianjieModel:createSingleZBEntities(key,true)
self:addBiaoJiBuoy(key,x,y,sceneidx,flGuildFlag.cbid,flGuildFlag.icon)
end
end
end


function xianjieController:DeletOnlyZuobiao(list)
for k,flGuildFlag in ipairs(list)do
local x=flGuildFlag.x
local y=flGuildFlag.y
local sceneidx=flGuildFlag.sceneidx
local key=xianjieModel.getPosKey(x,y,sceneidx)
xianjieModel:clearData_zb_bykeyId(key)
self:removeBiaoJiBuoy(key)
end
end



function xianjieController:initAllBiaoJiBuoy()
self:clearAllBiaoJiBuoy()
local allZBDatas=xianjieModel:getZBDataList()
if allZBDatas and next(allZBDatas)then
for key,data in pairs(allZBDatas)do
self:addBiaoJiBuoy(data.BJkeyId,data.BJkeys[1],data.BJkeys[2],data.BJkeys[3],data.BJcbId,data.BJiconId)
end
end
end

function xianjieController:removeBiaoJiBuoy(key)
if key and bjbuoyLookup[key]then
xianjieController:removeBuoy(bjbuoyLookup[key])
end
end

function xianjieController:addBiaoJiBuoy(_keyId,_bj_x,_bj_y,_bj_sceneidx,_bj_cbid,_bj_iconid)
if xianjieModel:checkSceneIndex(_bj_sceneidx)and bjbuoyLookup[_keyId]==nil then
local data=
{
keyId=_keyId,
bj_x=_bj_x,
bj_y=_bj_y,
bj_sceneidx=_bj_sceneidx,
bj_cbid=_bj_cbid,
bj_iconid=_bj_iconid,
}
bjbuoyLookup[_keyId]=xianjieController:addBuoy(xjBuoyType.eXJBiaoJi,data)
end
end

function xianjieController:clearAllBiaoJiBuoy()
bjbuoyLookup={}
end
