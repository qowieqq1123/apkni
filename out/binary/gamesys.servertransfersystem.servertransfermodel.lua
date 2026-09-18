






local _MODULENAME="ServerTransferModel"


def_table(_MODULENAME)
ServerTransferModel.name=_MODULENAME
ServerTransferModel.data={}
ServerTransferModel.detailsDatas={}
ServerTransferModel.yuzhuLookup={}
ServerTransferModel.guildDatas={}
ServerTransferModel.guildMemberDatas={}
ServerTransferModel.transferDatas={}
ServerTransferModel.transferShopDatas={}
ServerTransferModel.transferReviewLogDatas={}


function ServerTransferModel:onAppStart()

end


function ServerTransferModel:onEnterState(isReconnect)

end


function ServerTransferModel:onProtocolReq()

end


function ServerTransferModel:onLeaveState(isReconnect)

self.data={}
self.detailsDatas={}
self.yuzhuLookup={}
self.guildDatas={}
self.guildMemberDatas={}
self.transferDatas={}
self.transferShopDatas={}
self.transferReviewLogDatas={}
end


function ServerTransferModel:initDatas(data)
self.data=data
self.yuzhuLookup={}
if data.yuzhuList then
for _,v in ipairs(data.yuzhuList)do
local actorIdStr=tostring(v.actor_id)
self.yuzhuLookup[actorIdStr]=v


local cross_id=v.cross_id
loginModel:getCrossZoneName(cross_id)
end
end
end

function ServerTransferModel:getHistoryFight()
return self.data.history_fight or 0
end

function ServerTransferModel:getZongMenGrade()
return self.data.zm_pj_level or 0
end

function ServerTransferModel:getZongMenGradeName(level)
local lv=level or(self.data.zm_pj_level or 0)
local name=""
if lv>0 then
name=cfgHelper.get2(cfg_switchserverguildlevelcconfig_get,lv,"name")
end
return name
end

function ServerTransferModel:getZongMenGradeColor(level)
local lv=level or(self.data.zm_pj_level or 0)
local color=""
if lv>0 then
color=cfgHelper.get2(cfg_switchserverguildlevelcconfig_get,lv,"gradeColor")
end
return color
end

function ServerTransferModel:getZongMenGradeIcon(level)
local lv=level or(self.data.zm_pj_level or 0)
local icon=""
if lv>0 then
icon=cfgHelper.get2(cfg_switchserverguildlevelcconfig_get,lv,"gradeIcon")
end
return icon
end

function ServerTransferModel:getXianYuGrade()
return self.data.xianyu_pj_level or 0
end

function ServerTransferModel:getXianYuTransferZongMenNum(xianyu_pj_level)
xianyu_pj_level=xianyu_pj_level or self.data.xianyu_pj_level
if xianyu_pj_level>0 then
if self.transferDatas and self.transferDatas.act_cnt then
local act_cnt=self.transferDatas.act_cnt
local baseCfg=cfgHelper.get1(cfg_switchserverbasicconfig_get,1)
if act_cnt>0 and act_cnt<=baseCfg.act_cnt then
local can_enter_zm=baseCfg.ex_can_enter_zm[act_cnt]
return can_enter_zm
end
end
local can_enter_zm=cfgHelper.get2(cfg_switchserverlevelcconfig_get,xianyu_pj_level,"can_enter_zm")
return can_enter_zm
end
return defaultT
end

function ServerTransferModel:getXianYuGradeName(level)
local lv=level or(self.data.xianyu_pj_level or 0)
local name=""
if lv>0 then
name=cfgHelper.get2(cfg_switchserverlevelcconfig_get,lv,"name")
end
return name
end

function ServerTransferModel:getXianYuLeaderGuildId()
return self.data.max_fight_guild_id or 0
end

function ServerTransferModel:getXianYuLeaderGuildName()
return self.data.max_fight_guild_name or""
end

function ServerTransferModel:getXianYuLeaderGuildFight()
return self.data.max_fight_guild_fight or 0
end

function ServerTransferModel:getXianYuLeaderList()
return self.data.yuzhuList or defaultT
end

function ServerTransferModel:checkXianYuLeader(actorId)
if not actorId then
actorId=playerModel:getActorID()
end
local actorIdStr=tostring(actorId)
if self.yuzhuLookup[actorIdStr]then
return true
end
return false
end

function ServerTransferModel:setXianYuDetailsDatas(cross_id,data)
self.detailsDatas[cross_id]=data
end

function ServerTransferModel:getXianYuDetailsDatas(cross_id)
return self.detailsDatas[cross_id]
end

function ServerTransferModel:setXianYuDetailsNotice(cross_id,notice)
if not self.detailsDatas[cross_id]then
self.detailsDatas[cross_id]={}
end
self.detailsDatas[cross_id].xianyu_notice=notice
end

function ServerTransferModel:getXianYuDetailsNotice(cross_id)
if self.detailsDatas[cross_id]then
return self.detailsDatas[cross_id].xianyu_notice
end
end


function ServerTransferModel:setXianYuGuildDatas(guild_id,data)
local guildIdStr=tostring(guild_id)
self.guildDatas[guildIdStr]=data
end

function ServerTransferModel:getXianYuGuildDatas(guild_id)
local guildIdStr=tostring(guild_id)
return self.guildDatas[guildIdStr]
end


function ServerTransferModel:setXianYuGuildMemberDatas(guild_id,data)
local guildIdStr=tostring(guild_id)
self.guildMemberDatas[guildIdStr]=data
end

function ServerTransferModel:getXianYuGuildMemberDatas(guild_id)
local guildIdStr=tostring(guild_id)
return self.guildMemberDatas[guildIdStr]
end


function ServerTransferModel:setTransferDatas(data)
self.transferDatas=data
end

function ServerTransferModel:getTransferDatas()
return self.transferDatas
end


function ServerTransferModel:setTransferShopDatas(data)
self.transferShopDatas=data
end

function ServerTransferModel:getTransferShopDatas()
return self.transferShopDatas
end


function ServerTransferModel:setTransferCrossServerId(cross_id)
if not self.transferDatas then
self.transferDatas={}
end
self.transferDatas.switch_cid=cross_id
end

function ServerTransferModel:getTransferCrossServerId()
if self.transferDatas then
return self.transferDatas.switch_cid
end
end


function ServerTransferModel:getTransferCostMultiple()
if self.transferDatas then
return self.transferDatas.cost_mutil
end
end


function ServerTransferModel:getTransferServerTimeStamp()
if self.transferDatas then
return self.transferDatas.switch_times
end
end


function ServerTransferModel:setTransferRewardFlag(reward_flag)
if not self.transferDatas then
self.transferDatas={}
end
self.transferDatas.reward_flag=reward_flag
end


function ServerTransferModel:getTransferRewardFlag()
if self.transferDatas then
return self.transferDatas.reward_flag
end
end


function ServerTransferModel:setTransferResult(changeserverresult)
if not self.transferDatas then
self.transferDatas={}
end
self.transferDatas.changeserverresult=changeserverresult
end


function ServerTransferModel:getTransferResult()
if self.transferDatas then
return self.transferDatas.changeserverresult
end
end


function ServerTransferModel:getTransferDealTime()
if self.transferDatas then
return self.transferDatas.deal_time
end
end


function ServerTransferModel:setTransferReviewLogDatas(data)
self.transferReviewLogDatas=data
table.sort(self.transferReviewLogDatas,function(a,b)
return a.deal_sec<b.deal_sec
end)
end

function ServerTransferModel:addTransferReviewLogDatas(data)
table.insert(self.transferReviewLogDatas,data)
table.sort(self.transferReviewLogDatas,function(a,b)
return a.deal_sec<b.deal_sec
end)
end

function ServerTransferModel:getTransferReviewLogDatas()
return self.transferReviewLogDatas
end


function ServerTransferModel:handleTransferServerReview(actor_id,deal_type)
if self.transferDatas and self.transferDatas.applyList then
local applyList=self.transferDatas.applyList
for i,v in ipairs(applyList)do
if mathHelper.compareInt64(v.actor_id,actor_id)then
v.state=deal_type
break
end
end
end
end


function ServerTransferModel:checkTransferServerReviewReddot()
if self.transferDatas and self.transferDatas.applyList then
local applyList=self.transferDatas.applyList
for i,v in ipairs(applyList)do
if v.state==-1 then
return true
end
end
end
return false
end


function ServerTransferModel:checkXianYuReviewPermission(cross_id)
if not cross_id then
cross_id=loginModel:getCrossServerId()
else
if loginModel:getCrossServerId()~=cross_id then
return false
end
end

local actorIdStr=playerModel:getActorIDStr()
if self.yuzhuLookup[actorIdStr]and self.yuzhuLookup[actorIdStr].cross_id==cross_id then
return true
end

local zmGrade=ServerTransferModel:getZongMenGrade()
if zmGrade==zongMenGradeEnum.eZhiZun then
return true
end

local max_fight_guild_id=ServerTransferModel:getXianYuLeaderGuildId()
local myXMGuid=xianmengModel:myXMGuildID()
if xianmengModel:compareTwoGuildID(max_fight_guild_id,myXMGuid)then
local myActorid=playerModel:getActorID()
if xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptChangeNotice)then
return true
end
end
return false
end


function ServerTransferModel:getTransferServerReddot()
if self.transferDatas and self.transferDatas.applyList then
return true
end
return false
end


function ServerTransferModel:checkTransferServerState()
if self.transferDatas and self.transferDatas.switch_cid then
return self.transferDatas.switch_cid>0
end
end


function ServerTransferModel:getTransferServerHistroyList()
if self.transferDatas then
return self.transferDatas.histroy_list
end
end


function ServerTransferModel:setTransferServerFirstLogin()
if not self.transferDatas or not self.transferDatas.switch_times then
return
end

local switch_times=self.transferDatas.switch_times
if switch_times<=0 then
return
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eServerTransfer,'transferServerFirstStamp',switch_times)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eServerTransfer)
end


function ServerTransferModel:checkTransferServerFirstLogin()
if not self.transferDatas or not self.transferDatas.switch_times then
return false
end

local switch_times=self.transferDatas.switch_times
if switch_times<=0 then
return false
end
local record=userActorArraySetting.get(ACTOR_SETTING_TYPE.eServerTransfer,'transferServerFirstStamp',nil)
return record~=switch_times
end


function ServerTransferModel:checkTransferServerHistroyShow()
local actOpen=ServerTransferController:checkServerTransferTimeOpen()
if actOpen then
return false
end
if not self.transferDatas or not self.transferDatas.histroy_list or#self.transferDatas.histroy_list<=0 then
return false
end

local record=userActorArraySetting.get(ACTOR_SETTING_TYPE.eServerTransfer,'transferServerHistroyStamp',nil)
if record then
local curr_act_open_time=self.transferDatas.histroy_list[1].switch_server_time
if record==curr_act_open_time then
return false
end
end

return true
end


function ServerTransferModel:checkTransferServerRewardShow()
if self.transferDatas and self.transferDatas.reward_flag==0 then
return true
end
return false
end


function ServerTransferModel:checkTransferServerFreezeAuction()
local freezeDays=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"wanbaoshanghui_days")
local last_transfer_time=ServerTransferModel:getTransferServerTimeStamp()or 0
if last_transfer_time>0 then
local nowTime=timeHelper.getServerShortTime()
local endTime=last_transfer_time+freezeDays*86400
local left=endTime-nowTime
return left>0,left
end
return false
end


function ServerTransferModel:receiveTransferServerShopFreeGift()
local giftid=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"freeGiftId")
FreeGiftController.SendFreeGift(giftid,nil,function(result)
if result then

UIManager:invokeUIMethod("UIServerTransferShopWin","refreshFreeGiftReddot")
UIManager:invokeUIMethod("UIServerTransferXianYuMainWin","refreshShopBtnReddot")
ServerTransferController:refreshServerTransferEnterReddot()
end
end)
end


function ServerTransferModel:checkTransferServerShopReddot()
local giftid=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"freeGiftId")
local canReceive=FreeGiftModel:IsCanGetGift(giftid,FreeGiftType.serverTransfer)
return canReceive
end