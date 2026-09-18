local _rewardShowList={}
local _rewardShowIndex=0

function xianmengController:onAppStart_gongxunbang()
socketManager:register_receiver(20,35,xianmengController.do_protocol_20_35)
socketManager:register_receiver(20,36,xianmengController.do_protocol_20_36)
socketManager:register_receiver(20,38,xianmengController.do_protocol_20_38)
end

function xianmengController:onEnterState_gongxunbang()

end

function xianmengController:onLeaveState_gongxunbang(isReconnet)
_rewardShowList={}
_rewardShowIndex=0
end


function xianmengController.req_protocol_20_35()
socketManager:send_20_35()









end


function xianmengController.req_protocol_20_36(idx,is_assistant)
local cfgId=xianmengModel:getGXBRewardId()
local value=xianmengModel:getGXBValue()
local flag=xianmengModel:getGXBRewardFlag()
local config=cfgHelper.get1(cfg_guildweekscoreconfig_get,cfgId)
for i,v in ipairs(config.rewards)do
local num=v[1]
if not mathHelper.getBitValue(flag,i-1)and num<=value then
table.insert(_rewardShowList,i)
socketManager:send_20_36(i,is_assistant or 0)
end
end


end


function xianmengController.do_protocol_20_35(len,wsList,no)
xianmengModel:setGXRankList(wsList)

UIManager:invokeUIMethod("UIXianMengGXBRankWin","refreshView")
end


function xianmengController.do_protocol_20_36(idx,is_assistant)
xianmengModel:setGXBRewardFlag(idx)
UIManager:invokeUIMethod("UIXianMengGXBTaskWin","refreshTaskItem",idx)
UIManager:invokeUIMethod("UIMainXMTaskWin","freshGxInfo")
local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do
local bdDatas=zongmenModel:getBuildingDataByBdId(v.id,SLG_SYSTEM_TYPE.eXianXunBang)
for _,v1 in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v1.un_build_id)
end
end

_rewardShowIndex=table.findValue(_rewardShowList,idx)
if _rewardShowIndex==#_rewardShowList and not is_assistant then
xianmengController:showGXBRewardList()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eXianXunBangRewardChange)
end

function xianmengController.do_protocol_20_38(score)
xianmengModel:setGXBValue(score)

local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do
local bdDatas=zongmenModel:getBuildingDataByBdId(v.id,SLG_SYSTEM_TYPE.eXianXunBang)
for _,v1 in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v1.un_build_id)
end
end

UIManager:invokeUIMethod("UIXianMengGXBTaskWin","refreshRewardValue")
UIManager:invokeUIMethod("UIMainXMTaskWin","freshGXReddot")

reddotControl.on_change_catch_type(CATCH_TYPE.eXianMengWeekScoreChange)
end

function xianmengController:showGXBRewardList()
local cfgId=xianmengModel:getGXBRewardId()
local config=cfgHelper.get1(cfg_guildweekscoreconfig_get,cfgId)
local prizelist={}
for i,v in ipairs(_rewardShowList)do
local list=config.rewards[v][2]
for j,w in ipairs(list)do
table.insert(prizelist,{itemid=w[1],num=w[2]})
end
end
showPrizeControl.showWindow(prizelist)
_rewardShowList={}
_rewardShowIndex=0

















end