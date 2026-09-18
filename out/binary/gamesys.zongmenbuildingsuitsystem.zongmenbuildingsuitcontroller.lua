






local _MODULENAME="zongmenBuildingSuitController"




gameState.addListener(def_table(_MODULENAME))
zongmenBuildingSuitController.name=_MODULENAME




function zongmenBuildingSuitController:onAppStart()

zongmenBuildingSuitModel:onAppStart()

socketManager:register_receiver(3,50,self.recv_3_50)
socketManager:register_receiver(3,51,self.recv_3_51)
socketManager:register_receiver(3,54,self.recv_3_54)
end


function zongmenBuildingSuitController:onEnterState(isReconnect)
zongmenBuildingSuitModel:onEnterState()
end


function zongmenBuildingSuitController:onProtocolReq()
zongmenBuildingSuitModel:onProtocolReq()
end


function zongmenBuildingSuitController:onLeaveState(isReconnect)
zongmenBuildingSuitModel:onLeaveState(isReconnect)


end


function zongmenBuildingSuitController:onLostConnection()

end


function zongmenBuildingSuitController:onReConnection(isInitPro)

end


function zongmenBuildingSuitController:send_3_50()
socketManager:send_3_50()
end


function zongmenBuildingSuitController:send_3_51(suit)
socketManager:send_3_51(suit)
end


function zongmenBuildingSuitController:send_3_54(suit)
socketManager:send_3_54(suit)
end

function zongmenBuildingSuitController:reqBuildSuit(sfId,ox,oy,bdId,orientation)
local direct=orientation==0
local buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
local suitId=zongmenBuildingSuitModel:findSuitIdByBuilding(bdId)
local suitCfg=cfgHelper.get1(cfg_buildsuitconfig_get,suitId)
local list={}












for i,v in ipairs(suitCfg.needbuild)do
local pBdId=v[1]
local pNum=v[2]
local tNum,iNum,sNum,bNum=zongmenBuildingSuitModel:getPartCount(suitId,i)
if pNum>tNum then

return
end
local data={}
for i=1,pNum do
if i<=iNum then
table.insert(data,1)
elseif i<=iNum+sNum then
table.insert(data,2)
else
table.insert(data,3)
end
end
list[pBdId]=data

























end

local bSends={}
local pSends={}
local mSends={}
local rSends={}
for partId,data in pairs(list)do
local offsets=suitCfg.offset[partId]
local buildList=zongmenModel:getBuildingDataByBdId(sfId,partId)
local storageList=zongmenModel:findStorageDatasByID(partId)
local mIdx=1
local sIdx=1
for index,offset in ipairs(offsets)do
local o=offset[3]or 0
if not direct then
o=bit.bxor(o,1)
end
local x=direct and offset[1]or offset[2]
local y=direct and offset[2]or offset[1]
x=x+ox
y=y+oy
local handle=data[index]
if handle==nil then
loggerUtil.logErrFMT("检查建筑套装部件，数量配置 与 偏移配置的数量 是否一致: 套装id-{0}, 部件id-{1}",suitId,partId)
return
end
if handle==1 then
table.insert(bSends,{sfId,partId,x,y,o,1,0,int64.zero})
elseif handle==2 then
local partBd=storageList[sIdx]
table.insert(pSends,{sfId,partBd.un_build_id,x,y,o,1})
sIdx=sIdx+1
else
local partBd=buildList[mIdx]
table.insert(mSends,{sfId,partBd.un_build_id,x,y,o})
mIdx=mIdx+1
end
end
end
if suitCfg.road then
for roadId,datas in pairs(suitCfg.road)do
for i,v in ipairs(datas)do
local x=direct and v[1]or v[2]
local y=direct and v[2]or v[1]
table.insert(rSends,{ox+x,oy+y,roadId,v[3]})









end
end
end




















local sends={}
if#bSends>0 then
table.insert(sends,{1,#bSends,bSends})
end
if#pSends>0 then
table.insert(sends,{4,#pSends,pSends})
end
if#mSends>0 then
table.insert(sends,{2,#mSends,mSends})
end
if#rSends>0 then
table.insert(sends,{3,1,{{sfId,#rSends,rSends}}})
end
socketManager:send_3_24(#sends,sends)

UIManager.info("仙居建造成功")
end


function zongmenBuildingSuitController.recv_3_50(len,array)
zongmenBuildingSuitModel:setActives(array)

UIManager:invokeUIMethod("UIBuildingSuitWin","refreshLeftList")
UIManager:invokeUIMethod("UILayoutWin","refreshBuildSuitReddot")
end


function zongmenBuildingSuitController.recv_3_51(suit)
zongmenBuildingSuitModel:setActive(suit)

UIManager:invokeUIMethod("UIBuildingSuitWin","afterActive",suit)
UIManager:invokeUIMethod("UILayoutWin","refreshBuildSuitReddot")

reddotControl.onBuildSuitActive(suit)
end

function zongmenBuildingSuitController.recv_3_54(suit)
zongmenBuildingSuitModel:setReward(suit)

UIManager:invokeUIMethod("UIBuildingSuitWin","afterReward",suit)
UIManager:invokeUIMethod("UILayoutWin","refreshBuildSuitReddot")

reddotControl.onBuildSuitReward(suit)
end



