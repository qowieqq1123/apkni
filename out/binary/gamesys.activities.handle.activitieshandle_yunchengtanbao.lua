







local _LuaHelper=CS.LuaHelper

activitiesHandle_yunchengtanbao=new_activitiesHandle('activitiesHandle_yunchengtanbao',activitiesHandle)









local showRewards
local battleRecv
local qiyudata




function activitiesHandle_yunchengtanbao:onEnterState()

notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.on_mystery_event_finish,self.onQiYuEventFinish)

end

function activitiesHandle_yunchengtanbao:onLeaveState()
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:removelistener(notifyConfig.on_mystery_event_finish,self.onQiYuEventFinish)

showRewards=nil
battleRecv=nil
qiyudata=nil
end










function activitiesHandle_yunchengtanbao:get_showRewards()
return showRewards
end







function activitiesHandle_yunchengtanbao.recv_249_95(args)

























local subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.current_grid=args[3]




data.map_id=args[4]
data.free_times=args[5]
data.finish_bit=args[6]


data.event_guid_id=args[7]
if true then
qiyudata={actID,subType,subid,data.event_guid_id}
end
data.free_sec=args[8]
data.effect_list={}
if args[9]>0 then
data.effect_list=args[10]
end
data.circle_num=args[11]
data.is_run=args[12]
data.specialPrize={}
data.normalPrize={}
data.money_buy_times=args[13]or 0
data.recharge_buy_times=args[14]or 0
data.mon_lv=args[15]
data.game_type=args[16]
data.game_id=args[17]
data.monster_bits=0

if data.event_guid_id then
local eventData=MysteryEventListModel:get_event_by_guid(SYSTEM_DEFINE.eCloudCityTreasure,data.event_guid_id)
if not eventData then
local json_str=jsonHelper.encode({6})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end
end

activitiesModel:setSubActInfoData(actID,subType,subid,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','handelRun')
UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','refreshQuanNun')
UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','refreshShaiZiNum')
end


function activitiesHandle_yunchengtanbao.recv_249_96(args1,args2,args3,args4,args5)






local subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure
local actID=args1
local subid=args2
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.yctbLiat={}
if args3>0 then
data.yctbLiat=args4
end
data.my_rank=args5


activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:showWindow('UIYCTB_RankWin',{act_id=actID,sub_act_type=subType,sub_act_id=subid})
end


function activitiesHandle_yunchengtanbao.recv_249_97(args)













local subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.map_id=args[3]
data.touzi_num=args[4]
data.current_grid=args[5]
data.free_times=args[6]
if args[7]==0 then
data.effect_list={}
end
if args[7]>0 then
data.effect_list=args[8]
end
data.finish_bit=args[9]
data.is_run=args[10]
data.oldcircle_num=data.circle_num
data.circle_num=args[11]


data.game_type=args[13]
data.game_id=args[14]

data.is_skip=args[16]


if data.isTouzi then
data.isTouzi=false
activitiesModel:setSubActInfoData(actID,subType,subid,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','shaizirotation',data.touzi_num)
else
activitiesModel:setSubActInfoData(actID,subType,subid,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
timeEventController.delayDo(0.2,function()

UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','handelRun')
UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','refreshQuanNun')
UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','refreshShaiZiNum')

if data.effect_list and#data.effect_list>0 then
local win=UIManager:findActiveWindow('UIYCTBTipsWin')
if win then
win:refreshinfo()
end
else
local win=UIManager:findActiveWindow('UIYCTBTipsWin')
if win then
win:closeSelf()
end
end
end)
end
end


function activitiesHandle_yunchengtanbao.recv_249_98(args1,args2)


local subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure
local actID=args1
local subid=args2
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end



end


function activitiesHandle_yunchengtanbao.recv_249_99(args1,args2,args3,args4)





local subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure
local actID=args1
local subid=args2
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

if args3>0 then
data.effect_list=args4
end



activitiesModel:setSubActInfoData(actID,subType,subid,data)

if data.effect_list and#data.effect_list>0 then
local win=UIManager:findActiveWindow('UIYCTBTipsWin')
if win then
win:refreshinfo()
end
else
local win=UIManager:findActiveWindow('UIYCTBTipsWin')
if win then
win:closeSelf()
end
end

UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','refreshDaojuList')
UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','refreshGameState')
end


function activitiesHandle_yunchengtanbao.recv_249_100(args1,args2,args3,args4,args5)






local subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure
local actID=args1
local subid=args2
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.current_grid=args3
data.event_guid_id=args4
local refresh_type=args5

activitiesModel:setSubActInfoData(actID,subType,subid,data)
if refresh_type and refresh_type==1 then
UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','MysteryEvent',data.event_guid_id)
end
end


function activitiesHandle_yunchengtanbao.recv_249_101(args1,args2,args3,args4)





local subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure
local actID=args1
local subid=args2
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.finish_bit=args3

data.is_run=args4

activitiesModel:setSubActInfoData(actID,subType,subid,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','reachTargetGridindex',data.current_grid+1)

end


function activitiesHandle_yunchengtanbao.recv_249_205(args1,args2,args3,args4)




local subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure
local actID=args1
local subid=args2
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
if args3 and args4 then
if args3==1 then
data.money_buy_times=data.money_buy_times+args4
elseif args3==2 then
data.recharge_buy_times=data.recharge_buy_times+args4
end
end
activitiesModel:setSubActInfoData(actID,subType,subid,data)

if args3 and args4 then
if args3==1 then
UIManager:invokeUIMethod('UIDialougeYCTBbuy','refreshInfo')
elseif args3==2 then
UIManager:invokeUIMethod('UIDialougeYCTBbuy','refreshZhigou')
end
end
UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','refreshShaiZiNum')
end


function activitiesHandle_yunchengtanbao.onQiYuEventFinish(sysId)

local activityData=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCloudCityTreasure)
if activityData then
if activityData[1]then
local actID=activityData[1].act_id
local subid=activityData[1].sub_act_id
if sysId==SYSTEM_DEFINE.eCloudCityTreasure then
if UIManager:isActive("UISubAct_yunchengtanbaoWin")then
local sub_actInfo=activitiesModel:getSubActInfo(actID,SUB_ACTIVITY_TYPE.eCloudCityTreasure,subid)
local autojump=sub_actInfo:isfrightAuto()

local temp=
{
act_id=actID,
sub_act_id=subid,
extraParams={autojump=autojump},
}
UIManager:invokeUIMethod("UISubAct_yunchengtanbaoWin","qiyujumprefresh",temp)
else
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure,subid=subid,extraParams={autojump=autojump}}},function()
jumpManager:clearJump()
end)
end
end
end
end
end


function activitiesHandle_yunchengtanbao.onQiYuEventBlack(sysId)

local activityData=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCloudCityTreasure)
if activityData then
if activityData[1]then
local actID=activityData[1].act_id
local subid=activityData[1].sub_act_id
if sysId==SYSTEM_DEFINE.eCloudCityTreasure then
if UIManager:isActive("UISubAct_yunchengtanbaoWin")then
local sub_actInfo=activitiesModel:getSubActInfo(actID,SUB_ACTIVITY_TYPE.eCloudCityTreasure,subid)
local autojump=sub_actInfo:isfrightAuto()
local temp=
{
act_id=actID,
sub_act_id=subid,
extraParams={autojump=autojump},
}
UIManager:invokeUIMethod("UISubAct_yunchengtanbaoWin","qiyujumprefresh",temp)
else
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure,subid=subid,extraParams={autojump=autojump}}},function()
jumpManager:clearJump()
end)
end
end
end
end
end



function activitiesHandle_yunchengtanbao.onShowPrize(prizeType,prizelist,effectData)


if prizeType==ePrizeType.eYunChengTanBaoNurmal then


local activityData=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCloudCityTreasure)
if activityData then
if activityData[1]then
local actID=activityData[1].act_id
local subid=activityData[1].sub_act_id
local data=activitiesModel:getSubActInfoData(actID,SUB_ACTIVITY_TYPE.eCloudCityTreasure,subid)
if data==nil then return end
data.normalPrize={}
data.normalPrize=prizelist
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eCloudCityTreasure)
end
end
end


if prizeType==ePrizeType.eYunChengTanBaoSpecial then


local activityData=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCloudCityTreasure)
if activityData then
if activityData[1]then
local actID=activityData[1].act_id
local subid=activityData[1].sub_act_id
local data=activitiesModel:getSubActInfoData(actID,SUB_ACTIVITY_TYPE.eCloudCityTreasure,subid)

if data==nil then return end
data.specialPrize={}
data.specialPrize=prizelist
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eCloudCityTreasure)
end
end
end


if prizeType==ePrizeType.eYunChengTanBaoFight then

local activityData=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCloudCityTreasure)
if activityData then
if activityData[1]then
local actID=activityData[1].act_id
local subid=activityData[1].sub_act_id

showRewards=prizelist
local log=battleRecv[2]
local result=battleRecv[1]


notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.yunchengtanbao,result,log,{showRewards,subid,actID})
end
end
end


if prizeType==ePrizeType.eYunChengTanBaoGame then


local activityData=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCloudCityTreasure)
if activityData then
if activityData[1]then
UIManager:invokeUIMethod('UISubAct_yunchengtanbaoWin','OpeanGamePrizeWin',prizelist)
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eCloudCityTreasure)
end
end

end

function activitiesHandle_yunchengtanbao:onBattleResult(result,log,data)
battleRecv={result,log,data}

end


function activitiesHandle_yunchengtanbao:isSaiZiNum(actID,subType,subid)
local havenum=false
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local free_times=mydata.free_times
local cfg_free_times=cfg_cloudcitytreasureactconfig_get(subid).free_times
if cfg_free_times>free_times then
havenum=true
elseif cfg_free_times<=free_times then
local costid=cfg_cloudcitytreasureactconfig_get(subid).costs[1]
local num=bagControl.invokeFuncByItemId(costid,'getItemCountByItemID',costid)
if num and num>0 then
havenum=true
else
havenum=false
end
end

return havenum
end


function activitiesHandle_yunchengtanbao:getBuyNum(actID,subType,subid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then
return mydata.money_buy_times,mydata.recharge_buy_times
end
return 0,0
end

function activitiesHandle_yunchengtanbao.sendBuy(selectCnt,actID,subType,subid)
local json_str=jsonHelper.encode({5,selectCnt})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end