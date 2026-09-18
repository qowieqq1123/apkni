







xianjieController.data_mjForce={}

MJForceState=
{
firstchoose=1,
changeforce=2,
nochoose=3,
}
MJTaskResetType=
{
NewDay=1,
NewDay5am=2,
NewWeek=3,
NewWeek5am=4,
}
MJForceType=
{
eJiuYuan=1,
ePengLai=2,
eYuJing=3,
}
local ShiLiBuffCheck={60007,60008,60009,60010}
local ShiLiBuffCheck2=
{
[60007]=true,
[60008]=true,
[60009]=true,
[60010]=true,
}


local DebuffShiLiCheck=
{
[MJForceType.eJiuYuan]=false,
[MJForceType.ePengLai]=false,
[MJForceType.eYuJing]=true,
}

MJForceColor=
{
[MJForceType.eJiuYuan]='',
[MJForceType.ePengLai]='',
[MJForceType.eYuJing]='',
}

function xianjieController:onAppStart_ForceMoJie()

socketManager:register_receiver(35,221,xianjieController.recv_protocol_35_221)
socketManager:register_receiver(35,222,xianjieController.recv_protocol_35_222)
socketManager:register_receiver(35,223,xianjieController.recv_protocol_35_223)
socketManager:register_receiver(35,224,xianjieController.recv_protocol_35_224)
socketManager:register_receiver(35,225,xianjieController.recv_protocol_35_225)
socketManager:register_receiver(35,226,xianjieController.recv_protocol_35_226)
socketManager:register_receiver(35,227,xianjieController.recv_protocol_35_227)

end

function xianjieController:onEnterState_ForceMoJie(isReconnet)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDayMJSL)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5amMJSL)
notifySystem:listenNotify(notifyConfig.onNewWeek,self.onNewWeekMJSL)
notifySystem:listenNotify(notifyConfig.onNewWeek5am,self.onNewWeek5amMJSL)
xianjieController:initShiLiBuffs()
end

function xianjieController:onLeaveState_ForceMoJie(isReconnet)
if not isReconnet then
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDayMJSL)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5amMJSL)
notifySystem:removelistener(notifyConfig.onNewWeek,self.onNewWeekMJSL)
notifySystem:removelistener(notifyConfig.onNewWeek5am,self.onNewWeek5amMJSL)
end
self.data_mjForce={}
end

function xianjieController:onProtocolReqKF_ForceMoJie(isReconnet)

end

function xianjieController:onEnterMap_ForceMoJie(ischange,enterParam)

end

function xianjieController:onLeaveMap_ForceMoJie(ischange)

end



function xianjieController:send_35_221()
socketManager:send_35_221()
end

function xianjieController:send_35_222(force,change)
socketManager:send_35_222(force,change)
end

function xianjieController:send_35_223()
socketManager:send_35_223()
end

function xianjieController:send_35_224(actorid)
socketManager:send_35_224(actorid)
end

function xianjieController:send_35_226(len,list)
socketManager:send_35_226(len,list)
end



function xianjieController.recv_protocol_35_221(arry)
xianjieController:setMoJieForceData(arry[1],arry[2],arry[3],arry[4],arry[5],arry[6],arry[7],arry[8],arry[9])
end

function xianjieController.recv_protocol_35_222(force,changetimes,chapteridx)
local oldforce=xianjieController:getForce()
xianjieController:setMoJieForceChoose(force,changetimes,chapteridx)
if oldforce and oldforce>0 then
UIManager.info('切换成功')
else
UIManager.info('选择成功')
xianjieController:OpenMoJieShiLiWinByForce()
UIManager:invokeUIMethod("UIMoJieForceMainWin","onCloseClick")
end
UIManager:invokeUIMethod("UIMoJieForceMainWin","serverfresh")
UIManager:invokeUIMethod("UIXianGongMainWin","freshMJSLSkil")
UIManager:invokeUIMethod("UIXianJieMainWin","severfreshmjpanel")
end

function xianjieController.recv_protocol_35_223(skilllv)
xianjieController:setMoJieForceSkillUp(skilllv)
UIManager:invokeUIMethod("UIMoJieForceSkillWin","serverfresh")
UIManager:invokeUIMethod("UIJiuYuanMainMJWin","freshMJSLSkilldesc")
UIManager:invokeUIMethod("UIPengLaiMainMJWin","freshMJSLSkilldesc")
UIManager:invokeUIMethod("UIYuJingMainMJWin","freshMJSLSkilldesc")
end

function xianjieController.recv_protocol_35_224(actorid,marchguid,lastsec)
xianjieController:setMoJieForceLastsec(lastsec)
UIManager:invokeUIMethod("UIXianJie_selfZmInfoWin","serverMoJiSkill")
UIManager:invokeUIMethod("UIXianJie_otherZmInfoWin","serverMoJiSkill")
end

function xianjieController.recv_protocol_35_225(len,list)
xianjieController:freshMoJieForceTask(len,list)
UIManager:invokeUIMethod("UIMoJieForceTaskWin","severfresh")
end

function xianjieController.recv_protocol_35_226(len,list)
xianjieController:setMoJieForceReward(len,list)
UIManager:invokeUIMethod("UIMoJieForceTaskWin","severfresh")
UIManager.info("领取成功")
UIManager:invokeUIMethod("UIJiuYuanMainMJWin","freshMJSLTaskReddot")
UIManager:invokeUIMethod("UIPengLaiMainMJWin","freshMJSLTaskReddot")
UIManager:invokeUIMethod("UIYuJingMainMJWin","freshMJSLTaskReddot")
end


function xianjieController.recv_protocol_35_227(moneylistlen,moneyList)
xianjieController:freshForceMoneyList(moneylistlen,moneyList)
end


function xianjieController:setMoJieForceData(force,skilllv,lastsec,changetimes,chapteridx,len,tasklist,moneylistlen,moneyList)
self.data_mjForce.force=force or 0
if skilllv and skilllv==0 then
skilllv=1
end
self.data_mjForce.skilllv=skilllv or 1
self.data_mjForce.lastsec=lastsec
self.data_mjForce.changetimes=changetimes or-1
self.data_mjForce.chapteridx=chapteridx or 0
self.data_mjForce.tasklist={}
self.data_mjForce.moneyList={}
if len and len>0 and tasklist then
for k,v in ipairs(tasklist)do
if v.param_2 then
v.param_2=mathHelper.int64_to_number(v.param_2)or 0
end
self.data_mjForce.tasklist[v.param_1]=v
end
end


if moneylistlen and moneylistlen>0 and moneyList then
self.data_mjForce.moneyList=moneyList
end


end

function xianjieController:setMoJieForceChoose(force,changetimes,chapteridx)
self.data_mjForce.force=force
self.data_mjForce.changetimes=changetimes
self.data_mjForce.chapteridx=chapteridx
end

function xianjieController:setMoJieForceSkillUp(skilllv)
self.data_mjForce.skilllv=skilllv
end

function xianjieController:setMoJieForceLastsec(lastsec)
self.data_mjForce.lastsec=lastsec
end

function xianjieController:freshMoJieForceTask(len,list)
if len>0 and list then
for k,v in ipairs(list)do
if v.param_2 then
v.param_2=mathHelper.int64_to_number(v.param_2)or 0
end
if self.data_mjForce.tasklist and self.data_mjForce.tasklist[v.param_1]then
self.data_mjForce.tasklist[v.param_1].param_2=v.param_2
else
v.param_3=0
self.data_mjForce.tasklist[v.param_1]=v
end
end
end
end

function xianjieController:setMoJieForceReward(len,list)
if self.data_mjForce.tasklist then
if len and len>0 and list then
for k,param_1 in ipairs(list)do
if self.data_mjForce.tasklist[param_1]then
self.data_mjForce.tasklist[param_1].param_3=1
end
end
end
end
end

function xianjieController:freshForceMoneyList(moneylistlen,moneyList)
if self.data_mjForce.moneyList and moneylistlen>0 then
self.data_mjForce.moneyList=moneyList
end
end



function xianjieController:getForce()
return self.data_mjForce.force or 0
end

function xianjieController:getForceChapteridx()
return self.data_mjForce.chapteridx or 0
end

function xianjieController:getForceChangetimes()
return self.data_mjForce.changetimes or-1
end

function xianjieController:getForceSkilllv()
return self.data_mjForce.skilllv or 1
end

function xianjieController:getForceLastsec()
return self.data_mjForce.lastsec or 0
end

function xianjieController:getForceTasklistc()
return self.data_mjForce.tasklist
end


function xianjieController:getForceTaskCfg(taskid,Taskidx)
local taskcfg=cfg_devildomforcetaskconfig_get(Taskidx)[taskid]
return taskcfg
end

function xianjieController:getForceSkillCfg(forceid,Skillidx)
local skillcfg=cfg_devildomforceskillconfig_get(Skillidx)[forceid]
return skillcfg
end

function xianjieController:getForceCfg()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
if cfg and cfg.force then
return cfg.force[1],cfg.force[2]
end
end
end

function xianjieController:isHaveForce()
if self:getForce()~=0 then
return true
end
return false
end

function xianjieController:isHaveChapteridx()
if self:getForceChapteridx()~=0 then
return true
end
return false
end

function xianjieController:ForceState()
if self:getForce()==0 then
return MJForceState.firstchoose
else
local Chapteridx=self:getForceChapteridx()
local chapteridx=xianjieController:getMoJieSaiJiChapteridx()

if chapteridx and Chapteridx~=chapteridx then
return MJForceState.changeforce
end
end
return MJForceState.nochoose
end


function xianjieController:getForceMoneyList()
return self.data_mjForce.moneyList
end


function xianjieController:getMJSLTaskReddot()
local Skillidx,Taskidx=xianjieController:getForceCfg()
local tasklist=xianjieController:getForceTasklistc()
local chapteridx=xianjieController:getMoJieSaiJiChapteridx()
for i,data in pairs(tasklist)do
local taskid=data.param_1
if taskid then
local cfg=self:getForceTaskCfg(taskid,Taskidx)
if xianjieController:checkMJSLTaskCondition(cfg,chapteridx)then
local sever_aim=data.param_2 or 0
local sever_gotflag=data.param_3 or 0
if cfg and sever_aim>=cfg.aim and sever_gotflag==0 then
return true
end
end
end
end
return false
end

function xianjieController:getMJSLSkillUpReddot()
local forceid=xianjieController:getForce()
local Skillidx,Taskidx=xianjieController:getForceCfg()
if forceid==nil or Skillidx==nil then
return false
end
local skillcfg=xianjieController:getForceSkillCfg(forceid,Skillidx)
local skilldata=skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local l_skill_data=skilldata[lvl]
local r_skill_data=skilldata[lvl+1]
local cost
if l_skill_data then
cost=l_skill_data[1]
end
if cost and r_skill_data then
for k,v in ipairs(cost)do
local costdata=v
local itemid=costdata[1]
local itemnum=costdata[2]
local bagnum=0
if moneyConfig.isMoney(itemid)then
bagnum=moneyModel.getMoney(itemid)
else
bagnum=bagModel.getItemCountById(itemid)
end
if bagnum<itemnum then
return false
end
end


local exCondition=l_skill_data[4]
if exCondition and exCondition[1]then
local MoneyType=exCondition[1][2]
local Moneycost=exCondition[1][3]
if MoneyType and Moneycost then
local hasCount=0
local MoneyList=xianjieController:getForceMoneyList()
if MoneyList then
for k,v in ipairs(MoneyList)do
if v.param_1 and v.param_1==MoneyType then
hasCount=v.param_2 and mathHelper.int64_to_number(v.param_2)or 0
end
end
end
if hasCount<Moneycost then
return false
end
end
end

return true
end
return false
end

function xianjieController:getMJSLForceReddot()
local state=xianjieController:ForceState()
if state==MJForceState.firstchoose then
return true
elseif state==MJForceState.changeforce then

local Chapteridx=userActorSetting.get('changeMJSLForceReddot',0)
local chapteridx=xianjieController:getMoJieSaiJiChapteridx()
if chapteridx and Chapteridx==chapteridx then
return false
end
return true
else
return false
end
return false
end

function xianjieController:getMJSLALLReddot()
return self:getMJSLTaskReddot()or self:getMJSLSkillUpReddot()or self:getMJSLForceReddot()
end



function xianjieController:initShiLiBuffs()
local cfgs=cfg_devildomforceconfig()
self.data_mjForce.showbuff={}
for k,cfg in ipairs(cfgs)do
local showbuff=cfg.showbuff
if showbuff then
for i,buffid in ipairs(showbuff)do
self.data_mjForce.showbuff[buffid]=true
end
end
end
end


function xianjieController:getShiLiBuffCheck()
return ShiLiBuffCheck
end
function xianjieController:getShiLiBuffChecktwo()
return self.data_mjForce.showbuff or{}
end

function xianjieController:getShiLiDebuffCheck(forceid)
return DebuffShiLiCheck[forceid]
end

function xianjieController:handleFaZeDieJia(_buffList_lookup)
local buffTemp={}
local buffTemp3={}
local buffNum=0
local buffList_lookup=_buffList_lookup or{}
local showbuff=xianjieController:getShiLiBuffChecktwo()


local spe_list={}
for k,v in ipairs(buffList_lookup)do
if showbuff[v.buffid]then
local buffId=v.buffid
local buffInfo=v
local buffCfg=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffId)
local conflict=buffCfg.conflict
local stamp=timeHelper.getServerShortTime()
local sec=buffInfo.endsec
if conflict then
if sec==0 or sec>stamp then
local fazes=buffCfg.fazes
if fazes then
local type=math.floor(conflict/100)
if spe_list[type]then
table.insert(spe_list[type],{buffInfo,conflict,#fazes})
else
spe_list[type]={}
table.insert(spe_list[type],{buffInfo,conflict,#fazes})
end
end
end
else
if sec==0 or sec>stamp then
if buffTemp[buffId]then
local oldsec=buffTemp[buffId].endsec
local oldnum=buffTemp[buffId].num
if sec>oldsec then
buffTemp[buffId].endsec=sec
buffTemp[buffId].num=oldnum+1
end
else
local temp={endsec=sec,buffid=buffId,num=1}
buffTemp[buffId]=temp
buffNum=buffNum+1
end
end
end
end
end
if buffTemp and next(buffTemp)then
for k,v in pairs(buffTemp)do
table.insert(buffTemp3,v)
end
end


for k,List in pairs(spe_list)do
if List then
if#List>1 then
table.sort(List,function(a,b)
return a[2]>b[2]
end)
end
local maxlenght=List[1][3]
local idx=1
for i,buffInfo in ipairs(List)do

if buffInfo and idx<=maxlenght then
local sec=buffInfo[1].endsec
local buffId=buffInfo[1].buffid
local temp={endsec=sec,buffid=buffId,num=1}
table.insert(buffTemp3,temp)
buffNum=buffNum+1
idx=idx+1
end
end
end
end
return buffTemp3,buffNum
end



function xianjieController.onNewDayMJSL()

end
function xianjieController.onNewDay5amMJSL()
xianjieController:handleTaskKuaTian(MJTaskResetType.NewDay5am)
end
function xianjieController.onNewWeekMJSL()

end
function xianjieController.onNewWeek5amMJSL()

end

function xianjieController:handleTaskKuaTian(type)
if self.data_mjForce.tasklist then
local isChange=false
local Skillidx,Taskidx=self:getForceCfg()
for k,v in pairs(self.data_mjForce.tasklist)do
local cfg=self:getForceTaskCfg(v.param_1,Taskidx)
if cfg.reset and cfg.reset==type then
self.data_mjForce.tasklist[v.param_1]=nil
isChange=true
end
end

if isChange then
UIManager:invokeUIMethod("UIMoJieForceTaskWin","severfresh")
UIManager.info('任务已更新')
end
end
end


function xianjieController:checkMJSLTaskCondition(cfg,chapteridx)
if cfg==nil then return false end
if cfg.disabled then
return false
end
if cfg.chapter then
if chapteridx~=cfg.chapter then
return false
end
end
return true
end



function xianjieController:OpenMoJieShiLiWin(args)
UIManager:showWindow('UIMoJieForceMainWin',args)
end

function xianjieController:OpenMoJieShiLiSkillWin(args)
UIManager:showWindow('UIMoJieForceSkillWin',args)
end

function xianjieController:OpenMoJieShiLiTaskWin(args)
UIManager:showWindow('UIMoJieForceTaskWin',args)
end

function xianjieController:OpenMoJieShiLiWinByForce(args)
if xianjieController:isMoJiShiLiShow()then
local forceid=xianjieController:getForce()
if forceid>0 then
if forceid==MJForceType.eJiuYuan then
UIFullXJMJForceControl:showUIJiuYuanMainMJWindow(args)
elseif forceid==MJForceType.ePengLai then
UIFullXJMJForceControl:showUIPengLaiMainMJWindow(args)
elseif forceid==MJForceType.eYuJing then
UIFullXJMJForceControl:showUIYuJingMainMJWindow(args)
end
else

xianjieController:OpenMoJieShiLiWin()
end
else
UIManager.info('魔界势力已屏蔽')
end
end






function xianjieController:CheckMoJieShiLiSkillZongMenBtn()

local curSceneidx=xianjieModel:getSceneIndex()
local isInMoJie=xianjienSceneIndexType:isMoJie(curSceneidx)
local isMJtime=xianjieController:CheckMoJieSaiJieActityeTime()

if isInMoJie and isMJtime then
return true
end
return false
end

function xianjieController:useMoJieShiLiSkill(actorid)
xianjieController:send_35_224(actorid)
end

function xianjieController:showUseSkillWin(_fun,str)
if str then
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog3=UIDialogManager.newDialog(showdata)
comfirmDialog3:show()
else
_fun()
end
end

