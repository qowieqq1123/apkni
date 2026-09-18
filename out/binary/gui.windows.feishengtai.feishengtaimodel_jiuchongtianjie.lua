








local basedata={}

function FeiShengTaiModel:clearData_jiuchongtianjie()
basedata={}
end

function FeiShengTaiModel:initData_jiuchongtianjie()
basedata={}
basedata.reddotflag=false
basedata.flag=0
basedata.oldpeoplenum=0

basedata.FeiSheng_jiuchongtianjietb={}
basedata.XianMengHelp={}
end
function FeiShengTaiModel:recordReddotflag()
basedata.reddotflag=FeiShengTaiModel:GetFSTreddot()

end

function FeiShengTaiModel:GetFeiShengflag()

return basedata.flag
end

function FeiShengTaiModel:SetFeiShengflag(lvflag,num)

basedata.flag=lvflag
basedata.oldpeoplenum=num
end

function FeiShengTaiModel:GetFeiSheng()
return basedata.FeiSheng_jiuchongtianjietb
end

function FeiShengTaiModel:SetFeiSheng(data)
if data then
basedata.FeiSheng_jiuchongtianjietb=data
end
end


function FeiShengTaiModel:GetFeiShengPeople()
if basedata.FeiSheng_jiuchongtianjietb and next(basedata.FeiSheng_jiuchongtianjietb)then
if basedata.FeiSheng_jiuchongtianjietb.super_actor_cnt then
return basedata.FeiSheng_jiuchongtianjietb.super_actor_cnt
end
end
return 0
end


function FeiShengTaiModel:SetFeiShengTaiRepair()
if not next(basedata.FeiSheng_jiuchongtianjietb)then
return
end
local newflag,timeReduce2=FeiShengTaiModel:jisuanReduceTime()
if basedata.FeiSheng_jiuchongtianjietb.un_build_id~=0 then
local itemReduce,timeReduce=FeiShengTaiModel:judeReducedata(basedata.FeiSheng_jiuchongtianjietb.super_actor_cnt)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,81)
local rlevel

local data=zongmenModel:getBuildingData(basedata.FeiSheng_jiuchongtianjietb.un_build_id)
if data then
if data.flag<10 then
return
elseif data.flag>20 then
return
else
rlevel=data.flag-10
end

local cddata=buildingCDControl:getCDData(buildingCDType.build,basedata.FeiSheng_jiuchongtianjietb.un_build_id)
if not cddata or cddata.complete then
return
end

local lvflag=FeiShengTaiModel:GetFeiShengflag()

if rlevel==lvflag and not newflag then
return
end
if newflag then
timeReduce=timeReduce-timeReduce2
end
local reduce_times=cfg.repair_time[rlevel]*timeReduce/100
zongmenModel:setUpgradeSpeedupTime(1,basedata.FeiSheng_jiuchongtianjietb.un_build_id,reduce_times)
buildingCDControl:setSpeedUp(basedata.FeiSheng_jiuchongtianjietb.un_build_id,speedUpType.eUpgradeBuilding)
local args={ignorePlayAudio=true}
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.speedUpComplete,1,basedata.FeiSheng_jiuchongtianjietb.un_build_id,args)
FeiShengTaiModel:SetFeiShengflag(rlevel,basedata.FeiSheng_jiuchongtianjietb.super_actor_cnt)
end

end
end

function FeiShengTaiModel:SetNowLvl()
if basedata.FeiSheng_jiuchongtianjietb then
basedata.FeiSheng_jiuchongtianjietb.send_help_cnt=1
end

end

function FeiShengTaiModel:Setyetid(yetid)
if basedata.FeiSheng_jiuchongtianjietb then
basedata.FeiSheng_jiuchongtianjietb.yetid=yetid
end

end


function FeiShengTaiModel:Getyetid()
if basedata.FeiSheng_jiuchongtianjietb then
return basedata.FeiSheng_jiuchongtianjietb.yetid
end
return 0
end


function FeiShengTaiModel:judeReducedata(peoplenum)
local server_reduce_conf=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'server_reduce_conf')
for k,v in ipairs(server_reduce_conf)do
if peoplenum>=v[1]and peoplenum<=v[2]then


return v[3],v[4]
end
end
return 0,0
end

function FeiShengTaiModel:SetXianMengHelpData(len,data,help_rewardlen,rewardlist)











basedata.XianMengHelp={}
basedata.XianMengHelp.len=len
if len>0 then
basedata.XianMengHelp.data=data
FeiShengTaiModel:PaiXu_XMHelpData()
end
basedata.XianMengHelp.help_rewardlen=help_rewardlen and help_rewardlen or 0
if help_rewardlen>0 then
basedata.XianMengHelp.rewardlist=rewardlist
end
end





function FeiShengTaiModel:PaiXu_XMHelpData()
local myid=playerModel:getActorID()


table.sort(basedata.XianMengHelp.data,function(a,b)
if b.actor_id==myid then
return false
end
if a.actor_id==myid then
return true
end
local basiccfg=cfgHelper.get1(cfg_feishengjctjbasicconfig_get,1)


local max_reduce_conf=basiccfg.max_reduce_conf
local amaxnum=max_reduce_conf[a.lvl]
local bmaxnum=max_reduce_conf[b.lvl]
local amaxflag=a.help_cnt>=amaxnum
local bmaxflag=b.help_cnt>=bmaxnum
if amaxflag and not bmaxflag then
return false
elseif not amaxflag and bmaxflag then
return true
end
if a.self_help_cnt~=b.self_help_cnt then
return a.self_help_cnt<b.self_help_cnt
end
return a.id<b.id
end)
end


function FeiShengTaiModel:GetXMHelpData()
if not basedata.XianMengHelp.len then
basedata.XianMengHelp.len=0
end
if not basedata.XianMengHelp.help_rewardlen then
basedata.XianMengHelp.help_rewardlen=0
end



return basedata.XianMengHelp
end


function FeiShengTaiModel:GetXMItemNum(itemid)
if basedata.XianMengHelp and basedata.XianMengHelp.help_rewardlen and basedata.XianMengHelp.help_rewardlen>0 then
for k,v in ipairs(basedata.XianMengHelp.rewardlist)do
if v.param_1==itemid then
return v.param_2
end
end
end
return 0
end


function FeiShengTaiModel:GetDuJieUP()
if basedata.FeiSheng_jiuchongtianjietb and basedata.FeiSheng_jiuchongtianjietb.un_build_id then
local builddata=zongmenModel:getBuildingData(basedata.FeiSheng_jiuchongtianjietb.un_build_id)
if builddata then

if builddata.flag>11 then
return 0
end
local lv=builddata.level
local cfg=cfgHelper.get1(cfg_feishengjctjlevelconfig_get,lv)
local dujie_up=cfg.dujie_up
return dujie_up
end

end
return 0
end


function FeiShengTaiModel:JudeHaveHelp()
if basedata.XianMengHelp.len>0 then
local basiccfg=cfgHelper.get1(cfg_feishengjctjbasicconfig_get,1)

local max_reduce_conf=basiccfg.max_reduce_conf
for k,v in ipairs(basedata.XianMengHelp.data)do

if v.self_help_cnt==0 and playerModel:getActorID()~=v.actor_id then
local max=max_reduce_conf[v.lvl]
if v.help_cnt<max then
return true
end
end
end
end
return false
end


function FeiShengTaiModel:JudeHaveReward()
local basiccfg=cfgHelper.get1(cfg_feishengjctjbasicconfig_get,1)
local show_help_rewards=basiccfg.show_help_rewards
local max_help_rewards=basiccfg.max_help_rewards
local maxRewardNum=max_help_rewards[show_help_rewards]
if not maxRewardNum then
logErr("检查飞升台道具奖励配置")
return false
end

local yetnum=FeiShengTaiModel:GetXMItemNum(show_help_rewards)
if basedata.XianMengHelp and basedata.XianMengHelp.len and basedata.XianMengHelp.len>0 then
for k,v in ipairs(basedata.XianMengHelp.data)do
if v.self_help_cnt==0 and playerModel:getActorID()~=v.actor_id then
return true
end
end
end
return false
end


function FeiShengTaiModel:ShowHelpReddot()
local member_reduce_conf=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'member_reduce_conf')
local needlv=member_reduce_conf[2]
local zmlv=zongmenModel:getLevel()
if needlv<zmlv then
if FeiShengTaiModel:JudeHaveReward()and FeiShengTaiModel:JudeHaveHelp()then
return true
end
end

return false
end

function FeiShengTaiModel:jisuanReduceTime()
local server_reduce_conf=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'server_reduce_conf')
local newpeoplenum=basedata.FeiSheng_jiuchongtianjietb.super_actor_cnt
for k,v in ipairs(server_reduce_conf)do
if basedata.oldpeoplenum>=v[1]and basedata.oldpeoplenum<=v[2]then
if newpeoplenum>v[2]then
return true,v[4]
end
end
end
return nil
end


function FeiShengTaiModel:judelinggen(guid)
local desclist=UIDiscipleModel:getDiscipleSpecialityConfig(guid,false)
local dataNum=#desclist
local linggentable={}
if dataNum>0 then
for i=1,dataNum do
local cfg=desclist[i]
local name=cfg.name
local framecolor=cfg.framecolor
local typo=cfg.typo
local srid=cfg.srid
if typo==1 then
linggentable[srid]=true
end
end
end
return linggentable
end


function FeiShengTaiModel:jumptoFST(closeCallback)
local callBack=function()
zongmenControl:jumpBuildingWin({type=SLG_SYSTEM_TYPE.eFeiShengTai2,isOpenRepairWin=true})
end


if not mainControl:isSceneType(eSceneType.eZongmen)or not zongmenControl:isMountid(mapIdType.zhufeng)then
local func=function()
UIManager:closeWindow('UIDiscipleJingJieWin')
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.zhufeng},nil,callBack)
end

local show_data={
type='UIDialouge',
title='提示',
content='是否返回宗门场景安排弟子渡劫突破？',
oktext='确定',
okcallback=func,
canceltext='取 消',
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
callBack()
end
end


function FeiShengTaiModel:GetFSTRepair()
local repair_cost=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eFeiShengTai2,'repair_cost')
if not basedata.FeiSheng_jiuchongtianjietb.un_build_id or basedata.FeiSheng_jiuchongtianjietb.un_build_id==0 then
return 0,#repair_cost
end
local data=zongmenModel:getBuildingData(basedata.FeiSheng_jiuchongtianjietb.un_build_id)
local rlevel=0
if data then
if data.flag<10 then
return#repair_cost,#repair_cost
elseif data.flag>20 then
rlevel=data.flag-20
else

rlevel=data.flag-10-1
end
return rlevel,#repair_cost
else
return 0,#repair_cost
end
end

function FeiShengTaiModel:GetFSTreddot()
local flag=FeiShengTaiModel:GetRewardreddot()
return flag
end


function FeiShengTaiModel:GetRewardreddot()
local yetid=FeiShengTaiModel:Getyetid()

local now,max=FeiShengTaiModel:GetFSTRepair()
if not yetid or not now or not max then
return
end
if yetid<now then
return true,true
elseif yetid>=now and now==max then
return false,false
end
return false,true
end

function FeiShengTaiModel:refreshFSTHUD()
if basedata.FeiSheng_jiuchongtianjietb.un_build_id and basedata.FeiSheng_jiuchongtianjietb.un_build_id~=0 then
hudControl:refreshBuildingStatusHUD(basedata.FeiSheng_jiuchongtianjietb.un_build_id)
else
local notrepairid=FeiShengTaiModel:get_NotRepair_unbuildid()
hudControl:refreshBuildingStatusHUD(notrepairid)
end
end

function FeiShengTaiModel:OpenFeiShenTaiWin()

local bdDatas=zongmenModel:getAllBuildingData(1)
local builddata={}
for k,v in pairs(bdDatas)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg.build_type==81 then
if v.flag>10 then
UIFullJiuChongTianJieControl:closeUI()
FeiShengTaiController.openFeiShengTaiRepairWin({2,v})

return
else
UIFullFeiShengTaiControl:showFullFeiShengTaiWindow({bdDatas=v})
return
end
end
end

local _data=isometricMapSystem:getRepairDataByID(1,81)
UIFullJiuChongTianJieControl:closeUI()
FeiShengTaiController.openFeiShengTaiRepairWin({1,_data})

return
end

function FeiShengTaiModel:judeYetFeiSheng()
if JiuChongTianJieEnterModel:isJiuChongTianJieComplete()then
return true
end
return false
end


function FeiShengTaiModel:judeCanRepairFST()
if not systemModel.isOpen(SYSTEM_DEFINE.eFeiShengTai)then

return false
else
local rlevel=1
if not basedata.FeiSheng_jiuchongtianjietb or not basedata.FeiSheng_jiuchongtianjietb.un_build_id or basedata.FeiSheng_jiuchongtianjietb.un_build_id==0 then
rlevel=1
else
local data=zongmenModel:getBuildingData(basedata.FeiSheng_jiuchongtianjietb.un_build_id)
if not FeiShengTaiController.isEnterHome then
return false
end
local cddata=buildingCDControl:getCDData(buildingCDType.build,basedata.FeiSheng_jiuchongtianjietb.un_build_id,true)
if cddata then

return false
end
if data then
if data.flag and data.flag<10 then

return false
end
if data.flag>20 then

rlevel=data.flag-19
elseif data.flag>10 then
rlevel=data.flag-10
else
rlevel=data.flag
end
end
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,81)
local costs=cfg.repair_cost[rlevel]
local flag=FeiShengTaiModel:checkCost(costs)
return flag
end

end

function FeiShengTaiModel:checkCost(costs)
if not systemModel.isOpen(SYSTEM_DEFINE.eFeiShengTai)then
return false
end
for i,v in ipairs(costs)do
local id=v[1]
local need=v[2]
if moneyConfig.isMoney(id)then
local have=moneyModel.getMoney(id)
if have<need then
return false,id
end
else
local have=bagModel.getItemCountById(id)
if have<need then
return false,id
end
end
end
local guildlvl_limit=cfgHelper.get2(cfg_monijybuildconfig_get,81,'guildlvl_limit')
local minlv=guildlvl_limit[1][1]
local maxlv=guildlvl_limit[1][2]
if playerModel:getActorLevel()<minlv or playerModel:getActorLevel()>maxlv then
return false
end
return true
end


function FeiShengTaiModel:get_NotRepair_unbuildid()
local buildId=81
local data=isometricMapSystem:getUnlockRepairDataByID(1,buildId)

if not data then

local mapCfg=cfgHelper.get1(cfg_monijysfconfig_get,1)
local posList=mapCfg.repair_build_list and mapCfg.repair_build_list[SLG_SYSTEM_TYPE.eFeiShengTai2]
if not posList then
logErr("主峰内未找到可修复的飞升台 请检查山峰配置表repair_build_list字段中是否已配置飞升台")
return
end
local mapId=mapIdType.zhufeng
for _,posIndex in ipairs(posList)do
isometricMapSystem:createRepairBuilding(mapId,buildId,posIndex)
end
end
return data.bdData.un_build_id
end


function FeiShengTaiModel:getCanHelpCount()

local canHelpCount=0

if basedata==nil or basedata.XianMengHelp==nil or basedata.XianMengHelp.len==nil then return 0 end

if basedata.XianMengHelp.len>0 then
local basiccfg=cfgHelper.get1(cfg_feishengjctjbasicconfig_get,1)

local max_reduce_conf=basiccfg.max_reduce_conf
for k,v in ipairs(basedata.XianMengHelp.data)do

if v.self_help_cnt==0 and playerModel:getActorID()~=v.actor_id then
local max=max_reduce_conf[v.lvl]
if v.help_cnt<max then
canHelpCount=canHelpCount+1
end
end
end
end

return canHelpCount
end