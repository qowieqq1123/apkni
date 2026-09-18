






local _MODULENAME="ServerTransferController"

gameState.addListener(def_table(_MODULENAME))
ServerTransferController.name=_MODULENAME
ServerTransferController.data={}

local transferConditionsCfg={
{
desc='角色还在仙盟中',
check=function()
return xianmengModel:hasXM()
end,
jump=function()
UIFullXianMengPalaceControl:showWindowXMListInfo()
end,
},
{
desc='万宝商会有商品未下架',
check=function()
local nowSellList=auctionModel:getPersonAuctionSellListData()
return#nowSellList>0
end,
jump=function()
UIFullWanBaoShangHuiController:showWanBaoShangHuiSellWindow()
end,
},
{
desc='万宝商会已参与拍卖',
check=function()
return auctionModel:getSelfJoinAuction()
end,
jump=function()
UIFullWanBaoShangHuiController:showWanBaoShangHuiAuctionWindow()
end,
},
{
desc='仙界中有外出队列',
check=function()
local num=xianjieModel:getWaiPaiTeamNumEx()
return num>0
end,
jump=function()
xianjieController:jumpXianJie()
end,
},
{
desc='重建仙域未完成',
check=function()
local taskid=8410
return not taskModel:checkTaskFinish(taskid)
end,
jump=function()
UIFullSeasonControl:openSeasonWindow(0)
end,
},
{
desc='重建仙域奖励未领取',
check=function()
return seasonController:checkSeasonHandleCompleteButNotOver(0)
end,
jump=function()
UIFullSeasonControl:openSeasonWindow(0)
end,
},
{
desc='山海世界奖励未领取',
check=function()
return zhengzhanshanhaiModel:jude_haveReward()
end,
jump=function()
zhengzhanshanhaiController:OpenZhengZhanShanHaiMonsterLog()
end,
},
{
descFun=function(lerp)
return string.format('转服冷却中 %s',timeHelper.format_time_stamp11(lerp))
end,
check=function()
local time=ServerTransferModel:getTransferServerTimeStamp()or 0
if time>0 then
local cd=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"cd")or 0
local endTime=time+cd
local now=timeHelper.getServerShortTime()
local limitData={
endTime=endTime,
}
return now<endTime,limitData
end
return false
end,
},






{
desc='正在参与武选',
check=function()
local data=xianguanModel:getWuXuanPlayerData()
return data and data.job~=0
end,
},
{
desc='正在参与文选',
check=function()
local wxJob=xianguanModel:getWenXuanPlayerJob()
return wxJob and wxJob~=0
end,
},
{
desc='仙界奖励未领取',
check=function()
return xianjieModel:jude_haveReward()
end,
jump=function()
xianjieController:OpenZhengZhanShanHaiMonsterLog()
end,
},
}


function ServerTransferController:getServerTransferLimitInfo()
local temp={}
for i,v in ipairs(transferConditionsCfg)do
local isLimit,limitData=v.check()
if isLimit then
local data={
desc=v.desc,
descFun=v.descFun,
jump=v.jump,
limitData=limitData,
}
table.insert(temp,data)
end
end
return temp
end


function ServerTransferController:checkServerTransferLimit()
for i,v in ipairs(transferConditionsCfg)do
local isLimit=v.check()
if isLimit then
return true
end
end
return false
end


function ServerTransferController:getServerTransferTimeOpen()
local transfer_time_conf=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"time_conf")
local pfid=gameUtilityModel.getServerPlatform()
local nowTime=timeHelper.getServerShortTime()
local time_conf=transfer_time_conf[pfid]or defaultT
for i,v in ipairs(time_conf)do
local sTime=timeHelper.convertShortStamp(timeHelper.getDateStamp(v[1]))
local eTime=timeHelper.convertShortStamp(timeHelper.getDateStamp(v[2]))
if sTime<=nowTime and nowTime<=eTime then
return sTime,eTime
end
end
end


function ServerTransferController:checkServerTransferTimeOpen()
local transfer_time_conf=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"time_conf")
local pfid=gameUtilityModel.getServerPlatform()
local nowTime=timeHelper.getServerShortTime()
local time_conf=transfer_time_conf[pfid]or defaultT
for i,v in ipairs(time_conf)do
local sTime=timeHelper.convertShortStamp(timeHelper.getDateStamp(v[1]))
local eTime=timeHelper.convertShortStamp(timeHelper.getDateStamp(v[2]))
if sTime<=nowTime and nowTime<=eTime then
return true
end
end
return false
end


function ServerTransferController:checkServerTransferConditionOpen()
local transfer_open_conf=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"open_conf")
for i,v in ipairs(transfer_open_conf)do
local type=v[1]
if type==1 then
local historySeason=xianjieModel:getMoJieHistorySeason()or defaultT
local has=false
for i,seasonId in ipairs(historySeason)do
if seasonId==0 then
has=true
break
end
end
if not has then
return false
end
elseif type==2 then
local lv=v[2]
local zmLv=zongmenModel:getLevel()or 0
if zmLv<lv then
return false
end
end
end
return true
end


function ServerTransferController:checkServerTransferEnter(needRemove)
local isHasEnterGuidOriginal=self.enterServerTransferGuid~=nil
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eSwitchServer)and self:checkServerTransferConditionOpen()and self:checkServerTransferTimeOpen()
local isShowEnter=false
if isOpen then
self.enterServerTransferGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eServerTransfer,getReddotFun=function()
return ServerTransferModel:checkTransferServerShopReddot()or ServerTransferModel:checkTransferServerReviewReddot()
end})
isShowEnter=true
if isHasEnterGuidOriginal then

self:refreshServerTransferEnterReddot()
end
end
if needRemove and not isShowEnter then
self:removeServerTransferEnter()
end
end


function ServerTransferController:removeServerTransferEnter()
if self.enterServerTransferGuid then

enterManager:freshFunc('onClose',ENTER_TYPE.eServerTransfer)
local ret=enterManager:removeEnter(self.enterServerTransferGuid)
self.enterServerTransferGuid=nil
if ret then

UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end
end


function ServerTransferController:refreshServerTransferEnterReddot()
enterManager:freshFunc('freshReddot',ENTER_TYPE.eServerTransfer)
end


function ServerTransferController:onAppStart()

ServerTransferModel:onAppStart()


socketManager:register_receiver(35,161,ServerTransferController.recv_35_161)
socketManager:register_receiver(35,162,ServerTransferController.recv_35_162)
socketManager:register_receiver(35,163,ServerTransferController.recv_35_163)
socketManager:register_receiver(35,164,ServerTransferController.recv_35_164)
socketManager:register_receiver(35,165,ServerTransferController.recv_35_165)

socketManager:register_receiver(254,97,ServerTransferController.recv_254_97)
socketManager:register_receiver(254,98,ServerTransferController.recv_254_98)
socketManager:register_receiver(254,99,ServerTransferController.recv_254_99)
socketManager:register_receiver(254,100,ServerTransferController.recv_254_100)
socketManager:register_receiver(254,133,ServerTransferController.recv_254_133)
socketManager:register_receiver(254,134,ServerTransferController.recv_254_134)

end


function ServerTransferController:onEnterState(isReconnect)
ServerTransferModel:onEnterState()
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.on_level_change)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)


notifySystem:listenNotify(notifyConfig.onEnterHomeFinish,self.onEnterHomeFinish)
notifySystem:listenNotify(notifyConfig.onFreeGiftInit,self.onFreeGiftInit)

self.enterServerTransferGuid=nil
end


function ServerTransferController:onProtocolReq()
ServerTransferModel:onProtocolReq()
self:checkServerTransferEnter()
ServerTransferController:send_254_100()
ServerTransferController:send_254_133()
end


function ServerTransferController:onLeaveState(isReconnect)
ServerTransferModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.on_level_change)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)


notifySystem:removelistener(notifyConfig.onEnterHomeFinish,self.onEnterHomeFinish)
notifySystem:removelistener(notifyConfig.onFreeGiftInit,self.onFreeGiftInit)


self.data={}
self.enterServerTransferGuid=nil
end


function ServerTransferController:onLostConnection()

end


function ServerTransferController:onReConnection(isInitPro)

end

function ServerTransferController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eSwitchServer then
ServerTransferController:checkServerTransferEnter()
end
end

function ServerTransferController.on_level_change(level,exp)
if not ServerTransferController.enterServerTransferGuid then
ServerTransferController:checkServerTransferEnter()
end
end

function ServerTransferController.onNewDay()
ServerTransferController:checkServerTransferEnter(true)
end

function ServerTransferController.onSeasonChange()
if not ServerTransferController.enterServerTransferGuid then
ServerTransferController:checkServerTransferEnter()
end
end

function ServerTransferController.onSeasonStageDataChange()
if not ServerTransferController.enterServerTransferGuid then
ServerTransferController:checkServerTransferEnter()
end
end


function ServerTransferController.onEnterHomeFinish()






end


function ServerTransferController.onFreeGiftInit()
ServerTransferController:refreshServerTransferEnterReddot()
end




function ServerTransferController:send_35_162(cross_id)
socketManager:send_35_162(cross_id)
end




function ServerTransferController:send_35_163(cross_id,guild_id)
socketManager:send_35_163(cross_id,guild_id)
end




function ServerTransferController:send_35_164(cross_id,guild_id)
socketManager:send_35_164(cross_id,guild_id)
end



function ServerTransferController:send_35_165(xianyu_notice)
socketManager:send_35_165(xianyu_notice)
end



function ServerTransferController:send_254_97(cross_id)
socketManager:send_254_97(cross_id)
end




function ServerTransferController:send_254_98(actor_id,deal_type)
socketManager:send_254_98(actor_id,deal_type)
end


function ServerTransferController:send_254_99()
socketManager:send_254_99()
end


function ServerTransferController:send_254_100(isOpen)
if isOpen then
self.mark_254_100=true
end
socketManager:send_254_100()
end


function ServerTransferController:send_254_133()
socketManager:send_254_133()
end



function ServerTransferController:send_254_134(cross_id)
socketManager:send_254_134(cross_id)
end










function ServerTransferController.recv_35_161(argtable)
local history_fight=argtable[1]
local zm_pj_level=argtable[2]
local xianyu_pj_level=argtable[3]
local max_fight_guild_id=argtable[4]
local max_fight_guild_name=argtable[5]
local max_fight_guild_fight=argtable[6]
local yuzhu_list_len=argtable[7]
local yuzhuList=argtable[8]
local data={
history_fight=history_fight,
zm_pj_level=zm_pj_level,
xianyu_pj_level=xianyu_pj_level,
max_fight_guild_id=max_fight_guild_id,
max_fight_guild_name=max_fight_guild_name,
max_fight_guild_fight=max_fight_guild_fight,
yuzhuList=yuzhuList,
}
ServerTransferModel:initDatas(data)
end



















function ServerTransferController.recv_35_162(argtable)
local cross_id=argtable[1]
local xianyu_pj_level=argtable[2]
local xianyu_notice=argtable[3]
local yz_actor_id=argtable[4]
local yz_pj_level=argtable[5]
local yz_fight=argtable[6]
local yz_name=argtable[7]
local yz_iconInfo=argtable[8]
local guild_id=argtable[9]
local guild_icon=argtable[10]
local guild_name=argtable[11]
local guild_fight=argtable[12]
local curr_xianyu_level=argtable[13]
local curr_xianyu_zm_list_len=argtable[14]
local zmCntList=argtable[15]
local cnt_list_len=argtable[16]
local canCntList=argtable[17]
local data={
xianyu_pj_level=xianyu_pj_level,
xianyu_notice=xianyu_notice,
yz_actor_id=yz_actor_id,
yz_pj_level=yz_pj_level,
yz_fight=yz_fight,
yz_name=yz_name,
yz_iconInfo=yz_iconInfo,
guild_id=guild_id,
guild_icon=guild_icon,
guild_name=guild_name,
guild_fight=guild_fight,
curr_xianyu_level=curr_xianyu_level,
zmCntList=zmCntList,
canCntList=canCntList,
}
ServerTransferModel:setXianYuDetailsDatas(cross_id,data)
UIManager:showWindow("UIServerTransferXianYuDetailWin",cross_id)
end










function ServerTransferController.recv_35_163(argtable)
local cross_id=argtable[1]
local guild_id=argtable[2]
local guild_name=argtable[3]
local guild_icon=argtable[4]
local guild_level=argtable[5]
local member_cnt=argtable[6]
local guild_fight=argtable[7]
local guild_notice=argtable[8]
local leader_name=argtable[9]
local data={
cross_id=cross_id,
guild_name=guild_name,
guild_icon=guild_icon,
guild_level=guild_level,
member_cnt=member_cnt,
guild_fight=guild_fight,
guild_notice=guild_notice,
leader_name=leader_name,
}
ServerTransferModel:setXianYuGuildDatas(guild_id,data)
UIManager:showWindow("UIServerTransferXianMengInfoWin",{cross_id=cross_id,guildid=guild_id})
end






function ServerTransferController.recv_35_164(cross_id,guild_id,len,list)
ServerTransferModel:setXianYuGuildMemberDatas(guild_id,list or{})
UIManager:showWindow("UIServerTransferXianMengMemberWin",{cross_id=cross_id,guildid=guild_id})
end








function ServerTransferController.recv_35_165(xianyu_notice,ret)
if ret==0 then
UIManager.info('公告修改成功')
local cross_id=loginModel:getCrossServerId()
ServerTransferModel:setXianYuDetailsNotice(cross_id,xianyu_notice)
UIManager:invokeUIMethod("UIServerTransferXianYuDetailWin","refreshNotice",xianyu_notice)
UIManager:invokeUIMethod("UIServerTransferReviewWin","refreshNotice")
elseif ret==1 then
UIManager.error('公告含有敏感字符串')
end
end




function ServerTransferController.recv_254_97(cross_id,ret)
if ret==0 then
UIManager.info('已成功申请')
ServerTransferModel:setTransferCrossServerId(cross_id)
UIManager:invokeUIMethod("UIServerTransferXianYuDetailWin","refreshTransferState")
UIManager:invokeUIMethod("UIServerTransferXianYuMainWin","refreshApplyBtn")
elseif ret==6 then
UIManager.info('目标仙域可拥有角色已达到上限，无法跃迁')
end
end





function ServerTransferController.recv_254_98(actor_id,deal_type,dealLog)
if deal_type==0 then
UIManager.info('已拒绝申请')
elseif deal_type==1 then
UIManager.info('已接受申请')
elseif deal_type==2 then
UIManager.info('该申请已不存在')
elseif deal_type==3 then
UIManager.info('该申请已被处理')
end
ServerTransferModel:handleTransferServerReview(actor_id,deal_type)
ServerTransferModel:addTransferReviewLogDatas(dealLog)
UIManager:invokeUIMethod("UIServerTransferReviewWin","refreshMemberList")
UIManager:invokeUIMethod("UIServerTransferXianYuMainWin","refreshReviewBtnReddot")
ServerTransferController:refreshServerTransferEnterReddot()
end


function ServerTransferController.recv_254_99()
ServerTransferModel:setTransferRewardFlag(1)
UIManager:invokeUIMethod('UIFuncStorageWin','refreshServerTransferRewardBtn')
UIManager:invokeUIMethod('UIServerTransferRewardWin','refreshRewardBtnState')
end


















function ServerTransferController.recv_254_100(argtable)
local switch_times=argtable[1]
local cost_mutil=argtable[2]
local switch_cid=argtable[3]
local reward_flag=argtable[4]
local changeserverresult=argtable[5]
local deal_time=argtable[6]
local apply_len=argtable[7]
local applyList=argtable[8]
local can_switch_len=argtable[9]
local canSwitchList=argtable[10]
local xianyu_notice=argtable[11]
local histroy_list_len=argtable[12]
local histroy_list=argtable[13]
local deal_history_list_len=argtable[14]
local deal_history_list=argtable[15]
local act_cnt=argtable[16]

local canSwitchLookup={}
if canSwitchList then
for i,v in ipairs(canSwitchList)do
local grade=v.param_1
local num=v.param_2
canSwitchLookup[grade]=num
end
end
local data={
switch_times=switch_times,
cost_mutil=cost_mutil,
switch_cid=switch_cid,
applyList=applyList,
canSwitchList=canSwitchLookup,
histroy_list=histroy_list,
reward_flag=reward_flag,
changeserverresult=changeserverresult,
deal_time=deal_time,
act_cnt=act_cnt,
}
ServerTransferModel:setTransferDatas(data)

if deal_history_list_len>0 then
ServerTransferModel:setTransferReviewLogDatas(deal_history_list)
end

local cross_id=loginModel:getCrossServerId()
ServerTransferModel:setXianYuDetailsNotice(cross_id,xianyu_notice)
if ServerTransferController.mark_254_100 then
ServerTransferController.mark_254_100=false
UIManager:showWindow("UIServerTransferReviewWin")
end
UIManager:invokeUIMethod("UIServerTransferXianYuMainWin","refreshApplyBtn")
UIManager:invokeUIMethod("UIServerTransferXianYuMainWin","refreshReviewBtnReddot")
ServerTransferController:refreshServerTransferEnterReddot()
end




function ServerTransferController.recv_254_133(len,buyList)
ServerTransferModel:setTransferShopDatas(buyList)
UIManager:invokeUIMethod("UIServerTransferShopWin","onShow")
end




function ServerTransferController.recv_254_134(cross_id,ret)
if ret==0 then
ServerTransferModel:setTransferCrossServerId(0)
UIManager.info("已取消跃迁申请，跃迁消耗已通过邮件返还")
end
UIManager:invokeUIMethod("UIServerTransferXianYuDetailWin","refreshTransferState")
UIManager:invokeUIMethod("UIServerTransferXianYuMainWin","refreshApplyBtn")
end


