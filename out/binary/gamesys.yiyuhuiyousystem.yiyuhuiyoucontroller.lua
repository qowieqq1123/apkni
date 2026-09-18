






local _MODULENAME="YiYuHuiYouController"

gameState.addListener(def_table(_MODULENAME))
YiYuHuiYouController.name=_MODULENAME
YiYuHuiYouController.data={}



YYHYWaterObjectType=
{
normal_fish=1,
ice_item=2,
storm_item=3,
baoxiang_item=4,
normal_item=5,
power_item=6,
zhangyu_bx_item=7,

}


YYHYWaterObjectBaseType=
{
item=1,
fish=2,
}


YYHYLayoutType=
{
first=1,
second=2,
third=3,
}


YYHYWaterObjectState=
{
player_bitted=1,
ai_bitted=2,
swimming=3,
still=4,
player_disapper=5,
ai_disapper=6,
hailongjuan_disapper=7,

}


YYHYYuJuState=
{
yugan=1,
yugou=2,
yuxian=3,
}


YYHYGameState=
{
preparation=1,
execute=2,
over=3,
}


















function YiYuHuiYouController:onAppStart()

YiYuHuiYouModel:onAppStart()


socketManager:register_receiver(248,51,self.recv_248_51)
socketManager:register_receiver(248,52,self.recv_248_52)
socketManager:register_receiver(248,53,self.recv_248_53)
socketManager:register_receiver(248,54,self.recv_248_54)
socketManager:register_receiver(248,55,self.recv_248_55)
socketManager:register_receiver(248,56,self.recv_248_56)
socketManager:register_receiver(248,57,self.recv_248_57)
socketManager:register_receiver(248,58,self.recv_248_58)
socketManager:register_receiver(248,59,self.recv_248_59)
socketManager:register_receiver(248,60,self.recv_248_60)
socketManager:register_receiver(248,61,self.recv_248_61)
socketManager:register_receiver(248,62,self.recv_248_62)
socketManager:register_receiver(248,63,self.recv_248_63)

notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickEntity)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataInited,self.onWorldBlockDataInited)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:listenNotify(notifyConfig.onWorldPositionReRandom,self.onWorldPositionReRandom)

worldController:registerSceneState(1,1,function()
self:onWorldEnter(worldModel.world)
end)

end


function YiYuHuiYouController:onEnterState(isReconnect)
YiYuHuiYouController.send_248_51()
YiYuHuiYouModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end


function YiYuHuiYouController:onProtocolReq()

end


function YiYuHuiYouController:onLeaveState(isReconnect)
YiYuHuiYouModel:onLeaveState(isReconnect)

self.data={}

notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
end


function YiYuHuiYouController:onLostConnection()

end


function YiYuHuiYouController:onReConnection(isInitPro)

end



function YiYuHuiYouController.send_248_51()
socketManager:send_248_51()
end


function YiYuHuiYouController.send_248_52(cnt)
socketManager:send_248_52(cnt)
end


function YiYuHuiYouController.send_248_53(npc_id,dz_guid,xian_lu_id,num)
socketManager:send_248_53(npc_id,dz_guid,xian_lu_id,num)
end


function YiYuHuiYouController.send_248_54(npc_id)
socketManager:send_248_54(npc_id)
end


function YiYuHuiYouController.send_248_55()
socketManager:send_248_55()
end


function YiYuHuiYouController.send_248_57(len,arry,npc_id,list_len,list)
socketManager:send_248_57(len,arry,npc_id,list_len,list)
end


function YiYuHuiYouController.send_248_58(args)
YiYuHuiYouController.args_248_58=args
socketManager:send_248_58()
end


function YiYuHuiYouController.send_248_59(type)
socketManager:send_248_59(type)
end


function YiYuHuiYouController.send_248_60(len,arry)

end


function YiYuHuiYouController.send_248_61(idx,flag)
if not flag then flag=0 end
socketManager:send_248_61(idx,flag)
end


function YiYuHuiYouController.send_248_62()
socketManager:send_248_62()
end


function YiYuHuiYouController.send_248_63()
socketManager:send_248_63()
end




function YiYuHuiYouController.recv_248_51(args)

if worldController:isInWorld()then
YiYuHuiYouController:deleteWorldEntity(worldModel.world)
end

YiYuHuiYouModel:initSeverData(args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15])

reddotControl.on_change_catch_type(CATCH_TYPE.eYiYuHuiYouShengJiChange)
funcShopController.send_23_1(5)

if worldController:isInWorld()then
YiYuHuiYouController:onWorldEnter(worldModel.world)
end

UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eYiYuHuiYou)
end


function YiYuHuiYouController.recv_248_52(cnt)
YiYuHuiYouModel:setBuy_enter_cnt(cnt)
UIManager:invokeUIMethod('UIYYHYWin','refreshtiaozhanNum')
UIManager.info('购买挑战次数成功')
end


function YiYuHuiYouController.recv_248_53(npc_id,dz_guid,xian_lu_id,cnt)
YiYuHuiYouModel:setXianLuId(xian_lu_id)
YiYuHuiYouModel:setDiZiId(dz_guid)
YiYuHuiYouModel:setNPCId(npc_id)
if cnt>0 then
YiYuHuiYouModel:addEnter_cnt(cnt)
else
YiYuHuiYouModel:addEnter_cnt(1)
end
YiYuHuiYouModel:sethebingCnt(cnt)
YiYuHuiYouModel:addfishcs()
end


function YiYuHuiYouController.recv_248_54(npc_id,len,arry)
YiYuHuiYouModel:initWaterObjectData(npc_id,len,arry)
UIManager:invokeUIMethod('UIYYHYWin','YYHYStartGame')
YiYuHuiYouController:setGameDoingState(YYHYGameState.execute)
end


function YiYuHuiYouController.recv_248_55(npc_guid,begin_times,add_times,len,arry,fish_len,fish_arry,xian_lu_id,dz_guid,npc_fish_len,npc_fish_arry)

end


function YiYuHuiYouController.recv_248_56(ret,score)

UIManager:invokeUIMethod('UIYYHYWin','YYHYEndGame')
YiYuHuiYouModel:handelYYHYScoreAdd(score or 0)
YiYuHuiYouModel:setlYYHYRankMaxScore(score or 0)

reddotControl.on_change_catch_type(CATCH_TYPE.eYiYuHuiYouShengJiChange)
YiYuHuiYouController:setGameDoingState(YYHYGameState.over)

timeEventController.delayDo(1.8,function()
local win=UIManager:findActiveWindow('UIYYHYWin')
if win then
UIManager:showWindow("UIYYHYJieShuanWin",{ret,score})
end
end)
timeEventController.delayDo(2.1,function()

local win=UIManager:findActiveWindow('UIYYHYWin')
if win then
local list=YiYuHuiYouModel:isDaFengShouData()
if#list>0 then
UIManager:showWindow("UIYYHYdafengshouWin",{list})
end
end
end)
end


function YiYuHuiYouController.recv_248_57(args)
YiYuHuiYouModel:setCatchWaterObjectSuccse(args[1],args[2],args[3],args[4],args[5],args[6],args[7])
end


function YiYuHuiYouController.recv_248_58(len,arry,self_idx)
YiYuHuiYouModel:setmemberRankList_YYHY(arry or{})
YiYuHuiYouModel:setself_idx(self_idx)

local args=YiYuHuiYouController.args_248_58
YiYuHuiYouController.args_248_58=nil
UIManager:showWindow("UIYYHY_RankWin",args)
end


function YiYuHuiYouController.recv_248_59(type)
YiYuHuiYouModel:setYujuLevel(type)
UIManager:invokeUIMethod('YYHYyuzhigeShopWin','refreshYuJuShengji',type)
UIManager:invokeUIMethod('YYHYyuzhigeShopWin','texiaobofang')
UIManager:invokeUIMethod('UIYYHYWin','refreshdiziyuju')
UIManager:invokeUIMethod('UIYYHYWin','refreshshopreddot')
reddotControl.on_change_catch_type(CATCH_TYPE.eYiYuHuiYouShengJiChange)

AudioManager.playAudio(586)
end


function YiYuHuiYouController.recv_248_60(len,arry)
YiYuHuiYouModel:refreshWaterObject(len,arry)
end


function YiYuHuiYouController.recv_248_61(idx)
YiYuHuiYouModel:setRankList_YYHY_idxs(idx)
UIManager:invokeUIMethod('UIYYHY_RankWin','recv_reward')
UIManager:invokeUIMethod('UIYYHYWin','refreshrankreddot')
end


function YiYuHuiYouController.recv_248_62(ret,score)













end


function YiYuHuiYouController.recv_248_63()
userActorSetting.set('YiYuHuiYouGame_first',true)
userActorSetting.flush()
end




function YiYuHuiYouController:jumpyuzhigeshop()
jumpManager:jump({id=JUMP_TYPE.eYueLongChiShop,args={page=1}})
end


function YiYuHuiYouController:tiaozhanNumReddot()
local cfg=cfg_yiyuhuiyoubaseconfig_get(1).buy_enter_cnt
local tz_buynum=YiYuHuiYouModel:getEnter_cnt()or 0
local tz_peizi_num=#cfg
if(tz_peizi_num-tz_buynum)>0 then
return true
else
return false
end
end


function YiYuHuiYouController:tiaozhanNumReddot2()
local battlenum=YiYuHuiYouModel:getEnter_cnt()or 0
local tiaozhanmax=cfgHelper.get2(cfg_yiyuhuiyoubaseconfig_get,1,'enter_cnt')
local battlenum_ed=YiYuHuiYouModel:getBuy_enter_cnt()or 0
local battlemax=tiaozhanmax+battlenum_ed
return battlenum<battlemax
end


function YiYuHuiYouController:addThrowOutAndSliderTipsEx(args)
local win=UIManager:findActiveWindow('UIYYHYThrowOutAndSlideWin')
if win then
win:addMessage(args)
else
UIManager:showWindow('UIYYHYThrowOutAndSlideWin',args)
end
end

function YiYuHuiYouController:addThrowOutAndSliderTipsEx_ai(args)
local win=UIManager:findActiveWindow('UIYYHYThrowOutAndSlideWinAI')
if win then
win:addMessage(args)
else
UIManager:showWindow('UIYYHYThrowOutAndSlideWinAI',args)
end
end


function YiYuHuiYouController.onShowPrize(prizeType,rewards,effectData)
if prizeType==ePrizeType.eYiYuHuiYou then

if rewards and#rewards>0 then
for k,v in ipairs(rewards)do
YiYuHuiYouModel:setlYYHYDiaoLuo(v)
end
end
end
end


function YiYuHuiYouController:yyhyRankReddot()
local list={}
local level=1
local jifenReward
if level>0 then
jifenReward=cfg_yiyuhuiyoubaseconfig_get(1).week_rewards
local score=YiYuHuiYouModel:getWeek_reward_val()or 0
local prizetag=YiYuHuiYouModel:getWeek_reward_flag()or 0
local indexs=YiYuHuiYouModel:getRankList_YYHY_idxs()or 0
for i,v in ipairs(jifenReward)do
local fix=score>=v[1]
local flag=mathHelper.getBitValue(prizetag,i-1)
local state=flag==true and 0 or 1
if flag~=true then
if indexs>=i then
state=0
flag=true
end
end
local weight=state*100000+(100000-v[1])
table.insert(list,{v,fix,flag,weight})
end
end
for k,v in ipairs(list)do
local data=v
local fix=data[2]
local flag=data[3]
if fix and not flag then
return true
end
end
return false
end


function YiYuHuiYouController:yyhyShopShengjiReddot()
local level=YiYuHuiYouModel:getYgLevel()
if not level then

YiYuHuiYouController.send_248_51()
end
for i=1,3 do
if YiYuHuiYouController:yyhyShopShengjiyujuReddot(i)then
return true
end
end
return false
end


function YiYuHuiYouController:yyhyShopShengjiyujuReddot(index)
local yuju_index=index or 1
local level=1
if yuju_index==1 then
level=YiYuHuiYouModel:getYgLevel()
elseif yuju_index==2 then
level=YiYuHuiYouModel:getYwLevel()
elseif yuju_index==3 then
level=YiYuHuiYouModel:getYxLevel()
end


local cfg=cfg_yiyuhuiyouyujuconfig_get(yuju_index)[level]
if cfg then
local up_level=cfg.up_level
if up_level and cfg.up_cost then
local up_cost=cfg.up_cost[1]
local enough=moneyModel.checkEnoughMoney(up_cost[1],up_cost[2])

local up_cost2=cfg.up_cost[2]
local enough2=moneyModel.checkEnoughMoney(up_cost2[1],up_cost2[2])

if up_level then
local yuhuolist=YiYuHuiYouModel:getPinZhiFishlist()
if enough and enough2 then
if yuhuolist[up_level[1]]>=up_level[2]then
return true
end
end
end
end
end
return false
end


function YiYuHuiYouController:testmanager(id)


local t=YiYuHuiYouController:checkActivityByTuJianID(id)

end


function YiYuHuiYouController:checkActivityByTuJianID(id)
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eYiYuHuiYou)then
local npclist=YiYuHuiYouModel:getNPCIdlist()
if npclist and#npclist>0 then
for k,v in ipairs(npclist)do
local tujianlist=cfg_yiyuhuiyounpcconfig_get(v.npcid).tujianlist
if tujianlist then
for i,j in ipairs(tujianlist)do
if id and id==j then
return true
end
end
end
end
end
end
return false
end


function YiYuHuiYouController:getYuJuAllLevel()
local ygan=YiYuHuiYouModel:getYgLevel()or 1
local yg=YiYuHuiYouModel:getYwLevel()or 1
local yx=YiYuHuiYouModel:getYxLevel()or 1
return(ygan+yg+yx)
end

function YiYuHuiYouController:setGameDoingState(state)
YiYuHuiYouController.data.gamestate=state
end
function YiYuHuiYouController:getGameDoingState()
return YiYuHuiYouController.data.gamestate or YYHYGameState.over
end


function YiYuHuiYouController:checkYYHYActivityIcontiaozhan()
local cfg=cfg_yiyuhuiyoubaseconfig_get(1).buy_enter_cnt
local tz_buynum=YiYuHuiYouModel:getBuy_enter_cnt()or 0
local tz_peizi_num=#cfg
if(tz_peizi_num-tz_buynum)>0 then
return true
else
return false
end
end


function YiYuHuiYouController:checkYYHYActivityIcon()












local battlenum=YiYuHuiYouModel:getEnter_cnt()or 0
local tiaozhanmax=cfg_yiyuhuiyoubaseconfig_get(1).enter_cnt or 0
local battlenum_ed=YiYuHuiYouModel:getBuy_enter_cnt()or 0
if battlenum and battlenum_ed then
local battlemax=tiaozhanmax+battlenum_ed
if battlemax>battlenum then
return true
end
end


local hasRewards=YiYuHuiYouController:yyhyRankReddot()
if hasRewards then
return true
end

return false
end

