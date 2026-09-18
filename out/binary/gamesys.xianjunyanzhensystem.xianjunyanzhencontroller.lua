






local _MODULENAME="XianJunYanZhenController"

gameState.addListener(def_table(_MODULENAME))
XianJunYanZhenController.name=_MODULENAME
XianJunYanZhenController.data={}

function XianJunYanZhenController:onAppStart()
XianJunYanZhenModel:onAppStart()

socketManager:register_receiver(42,1,self.recv_42_1)
socketManager:register_receiver(42,2,self.recv_42_2)
socketManager:register_receiver(42,3,self.recv_42_3)
socketManager:register_receiver(42,4,self.recv_42_4)
end


function XianJunYanZhenController:onEnterState(isReconnect)
XianJunYanZhenModel:onEnterState()

notifySystem:listenNotify(notifyConfig.onDiscipleRemove,XianJunYanZhenController.onDiscipleRemove)
end


function XianJunYanZhenController:onProtocolReq()
XianJunYanZhenModel:onProtocolReq()
end


function XianJunYanZhenController:onLeaveState(isReconnect)
XianJunYanZhenModel:onLeaveState(isReconnect)
XianJunYanZhenModel:clearData_yunzhouTeam()

notifySystem:removelistener(notifyConfig.onDiscipleRemove,XianYunGangController.onDiscipleRemove)


self.data={}
end


function XianJunYanZhenController:onLostConnection()

end


function XianJunYanZhenController:onReConnection(isInitPro)

end

function XianJunYanZhenController.onDiscipleRemove(reason,discipleGuid)
XianJunYanZhenModel:removeXJYZYunZhouDz(discipleGuid)
XianJunYanZhenModel:removeXJYZYunZhouTeamDz(discipleGuid)
end




function XianJunYanZhenController:send_42_1()
socketManager:send_42_1()
end


function XianJunYanZhenController:send_42_2(gx_id)
socketManager:send_42_2(gx_id)
end


function XianJunYanZhenController:send_42_3(gx_id)
socketManager:send_42_3(gx_id)
end


function XianJunYanZhenController:send_42_4()
socketManager:send_42_4()
end



function XianJunYanZhenController.recv_42_1(args)











local total_star=args[1]
local total_star_rw_idx=args[2]
local gx_len=args[3]
local gxList=args[4]
local used_len=args[5]
local usedList=args[6]
local log_len=args[7]
local logList=args[8]
local log_fight_id_len=args[9]
local fightIdList=args[10]
local can_use_xiushi_list_len=args[11]
local canUseXSList=args[12]
local gx_star_list_len=args[13]
local gxStarList=args[14]

XianJunYanZhenModel:setCanUseXSList(can_use_xiushi_list_len,canUseXSList)
XianJunYanZhenModel:setXJYWData(total_star,total_star_rw_idx,gx_len,gxList,used_len,usedList,log_len,logList,log_fight_id_len,fightIdList,gx_star_list_len,gxStarList)
XianJunYanZhenModel:initAllYunZhouTeamData()

UIManager:invokeUIMethod("UIXianJunYanZhenStarRewardsWin","refreshMain")
taskModel:disposeClientCheckTaskTypeEvent(clientCheckTaskTypeEventType.eXianJunYanZhenLayer)
end


function XianJunYanZhenController.recv_42_2(gx_id)
XianJunYanZhenModel:setResetGxData(gx_id)

UIManager:invokeUIMethod("UIXianJunYanZhenWin","refreshResetRecv")
end


function XianJunYanZhenController.recv_42_3(gx_id,ret)
XianJunYanZhenModel:setGxRetData(gx_id,ret)
if ret==0 then
UIManager:invokeUIMethod("UIXianJunYanZhenWin","refreshCanTzRecv")
else
UIManager.info("拥有的修士数量不足")
end
end


function XianJunYanZhenController.recv_42_4(total_star_rw_idx)
XianJunYanZhenModel:setTotalStarRwIdx(total_star_rw_idx)

UIManager:invokeUIMethod("UIXianJunYanZhenWin","refreshStarRewardReddot")
UIManager:invokeUIMethod("UIXianJunYanZhenStarRewardsWin","freshInfo")
end


function XianJunYanZhenController.recv_play_fight(result,log,args)
local fightType=args.fightType
local gx_id=args.gx_id
local mon_groub_idx=args.mon_groub_idx
local boat_len=args.boat_len
local boatList=args.boatList
local xiushi_len=args.xiushi_len
local xiushiList=args.xiushiList
local damage_xiushi_len=args.damage_xiushi_len
local damageXsList=args.damageXsList
local damage_rate=args.damage_rate
local damageRateList=args.damageRateList
local star=args.star or 0
local fight_log_id_len=args.fight_log_id_len
local fightIdList=args.fightIdList
local can_use_xiushi_list_len=args.can_use_xiushi_list_len
local canUseXSList=args.canUseXSList
local unlock_star_list_len=args.unlock_star_list_len
local unlockStarList=args.unlockStarList

local maxStar=XianJunYanZhenModel:getGxMaxStar(gx_id)
local oldStarList=XianJunYanZhenModel:getGxStarList(gx_id)

local starList={}
if star>0 then
for i=1,unlock_star_list_len do
starList[unlockStarList[i]]=true
end
end

XianJunYanZhenModel:setLogData(gx_id,mon_groub_idx,xiushi_len,xiushiList,damage_xiushi_len,damageXsList,damage_rate,damageRateList or{},fight_log_id_len,fightIdList,result)
if result==fightResultType.Victory or boat_len>1 then
XianJunYanZhenModel:setUsedData(mon_groub_idx,boat_len,boatList,xiushi_len,xiushiList)
end
XianJunYanZhenModel:setCanUseXSList(can_use_xiushi_list_len,canUseXSList)
XianJunYanZhenModel:setGxData(gx_id,star,starList)

if maxStar==0 and star>0 and gx_id<XianJunYanZhenModel:getGxLen()then
XianJunYanZhenModel:setOpenGx(gx_id+1)
end

local data={
gx_id=gx_id,
mon_groub_idx=mon_groub_idx,
isFrist=maxStar==0 and star>0,
oldStarList=oldStarList
}
UIManager:invokeUIMethod("UIXianJunYanZhenWin","playFight",data)

if star>0 then
taskModel:disposeClientCheckTaskTypeEvent(clientCheckTaskTypeEventType.eXianJunYanZhenLayer)
end
end



