







function xianmengController:onAppStart_kufangZHFP()
socketManager:register_receiver(20,140,xianmengController.do_protocol_20_140)
socketManager:register_receiver(20,141,xianmengController.do_protocol_20_141)
socketManager:register_receiver(20,142,xianmengController.do_protocol_20_142)
socketManager:register_receiver(34,48,xianmengController.do_protocol_34_48)
end

function xianmengController:onEnterState_kufangZHFP()
notifySystem:listenNotify(notifyConfig.onNewDay,xianmengController.onNewDay__kufangZHFP)
xianmengModel:initData_kufangZHFP()
end

function xianmengController:onLeaveState_kufangZHFP()
notifySystem:removelistener(notifyConfig.onNewDay,xianmengController.onNewDay__kufangZHFP)
xianmengModel:clearData_kufangZHFP()
end

function xianmengController:onProtocolReq_kufangZHFP(isReconnet)

end

function xianmengController.onNewDay__kufangZHFP()
if UIManager:findActiveWindow("UIXMKuCunWin")then
xianmengController:reqFPData()
end
end









function xianmengController:reqItemZH(id,cnt)
socketManager:send_20_140(id,cnt)
end





function xianmengController:reqFPItem(actor_id,len,list)
socketManager:send_20_141(actor_id,len,list)
end


function xianmengController:reqFPData()
socketManager:send_20_142()
end


function xianmengController:reqFSTFinshData()
socketManager:send_34_48()
end








function xianmengController.do_protocol_20_140(id,cnt)
UIManager.info("转化成功")
UIManager:invokeUIMethod("UIXMCK_ZH_FP_Win","refreshZH_Right")
end





function xianmengController.do_protocol_20_141(actor_id,len,list)
if len>0 then
UIManager.info("分配成功")
for i,v in ipairs(list)do
local itemid=v.param_1
local addCnt=v.param_2
local curCnt=xianmengModel:getkfZHFPData_FPCnt(itemid)
local newCnt=curCnt+addCnt
xianmengModel:setkfZHFPData_FPCnt(itemid,newCnt)
end
end
end

function xianmengController.do_protocol_20_142(len,list)
xianmengModel:setkfZHFPData_FPData(list)
if UIManager:findActiveWindow("UIXMKuCunWin")then
UIManager:invokeUIMethod("UIXMKuCunWin","onNewDay")
end
end





function xianmengController.do_protocol_34_48(guild_id,len,list)
xianmengModel:setkfZHFPData_FSTFData(list)
end



function xianmengController.getZHItemList()
local tempList={}
local cfg=cfg_guildconversionconfig()
for k,v in pairs(cfg)do
if v.hideFlag~=1 then
local temp={}
temp.itemId=v.id
temp.createCnt=v.create_item_cnt
temp.costList=v.cost
temp.g_level=v.g_level
temp.open_day=v.open_day
temp.maxWeekFPCnt=v.distribution_week_max
temp.op_type=v.op_type
local lockFlag,lockTip=xianmengController.checkItemLock(v)
temp.lockFlag=lockFlag
temp.lockTip=lockTip
temp.sortFlag=lockFlag and 1 or 2
table.insert(tempList,temp)
end
end
table.sort(tempList,function(a,b)
return a.sortFlag>b.sortFlag
end)
return tempList
end

function xianmengController.checkItemLock(zhItemCfg)
if zhItemCfg.g_level and zhItemCfg.g_level>(xianmengModel:getXMLevel()or 0)then
return true,FMT.fmt("仙盟{0}级可转化",zhItemCfg.g_level)
end
if zhItemCfg.open_day and zhItemCfg.open_day>timeHelper.getServerOpenDay()then
return true,FMT.fmt("{0}天后可转化",zhItemCfg.open_day-timeHelper.getServerOpenDay())
end
if zhItemCfg.conversion_condition then
local cdnList=zhItemCfg.conversion_condition
for i,v in ipairs(cdnList)do
local cdnType=v[1]
local cdnVal=v[2]
if cdnType==1 and cdnVal>zongmenModel:getLevel()then
return true,FMT.fmt("宗门等级{0}级可转化",cdnVal)
elseif cdnType==2 and not systemModel.isOpen(cdnVal)then
local name=systemConfig.getSystemName(cdnVal)
return true,FMT.fmt("开启{0}",name)
elseif cdnType==3 and not JiuChongTianJieEnterModel:checkTianJieStageFinish(2)then
return true,"开启九重天劫-筑仙台"
end
end
end
return false
end
