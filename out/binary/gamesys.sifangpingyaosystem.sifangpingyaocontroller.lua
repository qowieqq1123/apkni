






local _MODULENAME="SiFangPingYaoController"


gameState.addListener(def_table(_MODULENAME))



SiFangPingYaoController.name=_MODULENAME
SiFangPingYaoController.data={}


sfpyPointType=
{
xiaoguai=1,
jingyin=2,
shijian=3,
huifu=4,
juqing=5,
yaowang=6,
}

SiFangPingYaoController.sfpyWuYgid=4


function SiFangPingYaoController:onAppStart()
SiFangPingYaoModel:onAppStart()

socketManager:register_receiver(34,51,self.recv_34_51)
socketManager:register_receiver(34,52,self.recv_34_52)
socketManager:register_receiver(34,53,self.recv_34_53)
socketManager:register_receiver(34,54,self.recv_34_54)
socketManager:register_receiver(34,55,self.recv_34_55)
socketManager:register_receiver(34,56,self.recv_34_56)
socketManager:register_receiver(34,57,self.recv_34_57)
socketManager:register_receiver(34,58,self.recv_34_58)
socketManager:register_receiver(34,59,self.recv_34_59)
socketManager:register_receiver(34,60,self.recv_34_60)
socketManager:register_receiver(34,61,self.recv_34_61)
socketManager:register_receiver(34,62,self.recv_34_62)
socketManager:register_receiver(34,63,self.recv_34_63)
socketManager:register_receiver(34,64,self.recv_34_64)
socketManager:register_receiver(34,65,self.recv_34_65)
socketManager:register_receiver(34,66,self.recv_34_66)
socketManager:register_receiver(34,67,self.recv_34_67)
socketManager:register_receiver(34,68,self.recv_34_68)

end


function SiFangPingYaoController:onEnterState(isReconnect)
SiFangPingYaoModel:onEnterState()
notifySystem:listenNotify(notifyConfig.on_mystery_event_finish_s,self.onQiYuEventFinish)
end


function SiFangPingYaoController:onProtocolReq()
SiFangPingYaoModel:onProtocolReq()
end


function SiFangPingYaoController:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.on_mystery_event_finish_s,self.onQiYuEventFinish)
SiFangPingYaoModel:onLeaveState(isReconnect)

self.data={}
end


function SiFangPingYaoController:onLostConnection()

end


function SiFangPingYaoController:onReConnection(isInitPro)

end




function SiFangPingYaoController.send_34_52(len,list)
socketManager:send_34_52(len,list)
end


function SiFangPingYaoController.send_34_53(idx)
socketManager:send_34_53(idx)
end


function SiFangPingYaoController.send_34_54(exchange_flag,idx)

socketManager:send_34_54(exchange_flag,idx)
end


function SiFangPingYaoController.send_34_55(recover_type,disciple_guid)

socketManager:send_34_55(recover_type,disciple_guid)
SiFangPingYaoModel:setdizifhflag(1)
SiFangPingYaoModel:settwohuifu(nil)
end


function SiFangPingYaoController.send_34_58(ygid,recv_idx)
socketManager:send_34_58(ygid,recv_idx)
end


function SiFangPingYaoController.send_34_60(point_id)
socketManager:send_34_60(point_id)
end


function SiFangPingYaoController.send_34_61()
socketManager:send_34_61()
end


function SiFangPingYaoController.send_34_62(rechallenge)


socketManager:send_34_62(rechallenge)
end


function SiFangPingYaoController.send_34_63(leave_type)
socketManager:send_34_63(leave_type)
end


function SiFangPingYaoController.send_34_64(demons_id)
socketManager:send_34_64(demons_id)
end


function SiFangPingYaoController.send_34_65(point_id)
socketManager:send_34_65(point_id)
SiFangPingYaoModel:setdoingpointid(0)
end


function SiFangPingYaoController.send_34_66()
socketManager:send_34_66()
end


function SiFangPingYaoController.send_34_68(len,cjid)
socketManager:send_34_68(len,cjid)
end




function SiFangPingYaoController.recv_34_51(args)
SiFangPingYaoModel:initSFPYData(args)
end


function SiFangPingYaoController.recv_34_52(args1,args2)

if args1>0 then
SiFangPingYaoModel:setDZTeamList(args2)
local flag=SiFangPingYaoModel:getTeamChangeRecord()
if flag and flag[1]and flag[1]==2 then
if flag[2]then
SiFangPingYaoModel:settwofight(nil)
end
elseif flag and flag[1]and flag[1]==1 then
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","onShow")
else
local demons_id=SiFangPingYaoModel:getMapIdex()
SiFangPingYaoController.send_34_64(demons_id)
end
end




end


function SiFangPingYaoController.recv_34_53(idx)




local selectfzlist=SiFangPingYaoModel:getSeltFZ_list()
if selectfzlist and#selectfzlist>0 then
local fzdata=selectfzlist[idx]
local bagfzlist=SiFangPingYaoModel:getBagFZ_list()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
local parama=fzdata.param_1
local paramb=fzdata.param_2
local paramc=chapter_id
local paramd=fzdata.param_3
local temp=
{
param_1=parama,
param_2=paramb,
param_3=paramc,
param_4=paramd,
}
table.insert(bagfzlist,temp)

SiFangPingYaoModel:setBagFZ_list(bagfzlist)
SiFangPingYaoModel:setSeltFZ_list({})


if fzdata.param_1 then
local name=cfgHelper.getSSlawRule(fzdata.param_1,"name")
UIManager.info(FMT.fmt("获得法则{0}",name))
end


local choice_bits=SiFangPingYaoModel:getchoice_bits()
local bitflag=bitHelper.check_pos(choice_bits,0)

if bitflag then
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","changefaze")
end

local demons_id=SiFangPingYaoModel:getMapIdex()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","AnimaTwolines")
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","Animayunwu",demons_id,chapter_id)
end
end


function SiFangPingYaoController.recv_34_54(args1,args2,args3,args4,args5)
if args1==0 then

elseif args1==1 then
local bagfzlist=SiFangPingYaoModel:getBagFZ_list()

if bagfzlist and#bagfzlist>0 then
local fazeidx=args2
local new_fazeid=args3
local new_fazelvl=args4
local new_fazeNun=args5
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
local temp=
{
param_1=new_fazeid,
param_2=new_fazelvl,
param_3=chapter_id,
param_4=new_fazeNun,
}

if bagfzlist[fazeidx]then
bagfzlist[fazeidx]=temp
end
SiFangPingYaoModel:setBagFZ_list(bagfzlist)



UIManager:invokeUIMethod("UISFPYRuleViewWin","doAnima",new_fazeid,new_fazelvl,new_fazeNun)
end
end

SiFangPingYaoModel:setchoice_bits(0)

UIManager:invokeUIMethod("UISiFangPingYaoMainWin","onNextZJ")
end


function SiFangPingYaoController.recv_34_55(args1,args2,args3)
if args1<=0 then
return
end
local isRe_birth=false
local isRe_huifu=false
local ishuifu=false
if args3==1 then
ishuifu=true


end

local old_Teamlist=SiFangPingYaoModel:getDZTeamList()
local old_dzlist=SiFangPingYaoController:getzhanweilist(old_Teamlist)
local new_dzlist=SiFangPingYaoController:getzhanweilist(args2)

local fhtxt={}
for k,v in ipairs(new_dzlist)do
local guid=v.param_1
local newBlood=tonumber(tostring(v.param_2))
local old_data=old_dzlist[k]
local oldBlood=tonumber(tostring(old_data.param_2))
if newBlood~=oldBlood then
if(newBlood-oldBlood)~=0 then
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","bloodChange",k,newBlood-oldBlood,oldBlood<=0 and newBlood>0)
end

if oldBlood<=0 and newBlood>0 then
isRe_birth=true
local name=UIDiscipleModel:getDiscipleName(guid)or""

local str=FMT.fmt("<color=#7D3B17>{0}</color>已重新加入战斗",name)
fhtxt[#fhtxt+1]=str
end

if oldBlood>0 and newBlood>oldBlood then
isRe_huifu=true
end
end
end
SiFangPingYaoModel:setdizifhtxt(fhtxt)

if ishuifu then
if isRe_birth then
UIManager.info(FMT.fmt("复活成功"))
end
if isRe_huifu then
UIManager.info(FMT.fmt("回复成功"))
end
end

SiFangPingYaoModel:setfuhuodzguid(nil)
SiFangPingYaoModel:setDZTeamList(args2)
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","initTeamList")
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","refreshSingledizi")
end


function SiFangPingYaoController.recv_34_56(value)
SiFangPingYaoModel:setbossanger(value)

end


function SiFangPingYaoController.recv_34_57(args1,args2,args3,args4)
local mapid=SiFangPingYaoModel:getMapIdex()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
if mapid==args1 and chapter_id==args2 then
if args3>0 then
local pointlist=SiFangPingYaoModel:getPointList()
for k,v in ipairs(args4)do
local point_id=v.point_id
pointlist[point_id]=v
end

SiFangPingYaoModel:setcomplPointList(pointlist)


end
end
end


function SiFangPingYaoController.recv_34_58(demons_id,recv_id)
if demons_id and recv_id then
local ygrewarddata=SiFangPingYaoModel:getYGrewarData()
if ygrewarddata then
ygrewarddata[demons_id]={param_1=demons_id,param_2=recv_id}
end
SiFangPingYaoModel:setYGcomplerewarData(ygrewarddata)
UIManager:invokeUIMethod("UISFPYRewardWintwo","recv_paihangbang")
UIManager:invokeUIMethod("UISiFangPingYaoMapWin","refreshjlreddot")
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","refreshjlreddot")
end
end


function SiFangPingYaoController.recv_34_59(args1,args2,args3)
local mapid=SiFangPingYaoModel:getMapIdex()
local zhangjieid=SiFangPingYaoModel:getZhangjieIdex()
if mapid==args1 and zhangjieid==args2 then
local point_list=SiFangPingYaoModel:getPointFinishList()
point_list[#point_list+1]=args3
SiFangPingYaoModel:setPointFinishList(point_list)

local alljindu=SiFangPingYaoModel:getYGJingDuData()

local thisygjd_data=alljindu[mapid]
if thisygjd_data then
local allzjjd=SiFangPingYaoController:getzjAllJindu(mapid,zhangjieid)
local maxjd=thisygjd_data.param_3
local newjd=SiFangPingYaoController:getzjnewjindu()

if maxjd<newjd then
if maxjd<allzjjd then
local temp={[1]={param_1=mapid,param_2=zhangjieid,param_3=maxjd+1,}}
SiFangPingYaoModel:setYGJingDuData(temp)
end
end
else
local temp={[1]={param_1=mapid,param_2=zhangjieid,param_3=1,}}
SiFangPingYaoModel:setYGJingDuData(temp)
end

SiFangPingYaoModel:setdoingpointid(0)

SiFangPingYaoModel:setfinishlinepoid(args3)


if mapid==SiFangPingYaoController.sfpyWuYgid then
local allpointlist=SiFangPingYaoController:getzjJinduStrut(args1,args2)
local point_list2=SiFangPingYaoModel:getPointFinishList()
if#point_list2<#allpointlist then
local layout=0
for k,v in ipairs(allpointlist)do
for i,j in ipairs(v)do
if j==args3 then
layout=k
break
end
end
end
local num=#allpointlist-layout
local temp={}
if args2<3 then
temp={layout,1}
else
if args2==3 and num==1 then
temp={layout,2}
else
temp={layout,1}
end
end
SiFangPingYaoModel:setwuyaoguo(temp)
end
end
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","onShowArgRecv")
end

taskController.eSFPYtgNumChange()
end


function SiFangPingYaoController.recv_34_60(point_id)
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","HandlePointFun",point_id)
end


function SiFangPingYaoController.recv_34_61(args1,args2)
if args1>=0 and args2 then
local bagfzlist=SiFangPingYaoModel:getBagFZ_list()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
for k,v in ipairs(args2)do
local temp=
{
param_1=v.param_1,
param_2=v.param_2,
param_3=chapter_id,
param_4=v.param_3,
}
bagfzlist[#bagfzlist+1]=temp

end
SiFangPingYaoModel:setBagFZ_list(bagfzlist)
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","onShowArgRecv")
end
end


function SiFangPingYaoController.recv_34_62(args1,args2,args3,args4,args5)
if args1==1 then

SiFangPingYaoModel:setbossanger(0)
SiFangPingYaoModel:setinitrecord(0)
SiFangPingYaoModel:setSLrecord(0)
elseif args1==2 then


local recordnew=SiFangPingYaoModel:getSLrecord()

SiFangPingYaoModel:setbossanger(recordnew)
end
SiFangPingYaoModel:setchoice_bits(0)
SiFangPingYaoModel:resetTiaoZhan()
SiFangPingYaoModel:setZhangjieIdex(args2)

local thischapter_id=args2
local list={}
local allfz_list=SiFangPingYaoModel:getBagFZ_list()
for k,v in ipairs(allfz_list)do
if v.param_3>=thischapter_id then
else
table.insert(list,v)
end
end
SiFangPingYaoModel:setBagFZ_list(list)

if args3>0 and args4 then
SiFangPingYaoModel:setPointList(args4)
end
SiFangPingYaoModel:setmap_idx(args5)



local demons_id=SiFangPingYaoModel:getMapIdex()
SiFangPingYaoModel:setmaincheli(demons_id)
SiFangPingYaoController.send_34_63(1)

end


function SiFangPingYaoController.recv_34_63(leave_type,boss_affinity,chapter_id)
if leave_type==2 then
SiFangPingYaoModel:setSLrecord(0)
SiFangPingYaoModel:setinitrecord(0)
SiFangPingYaoModel:setbossanger(0)
SiFangPingYaoModel:resetCheLi()
return

end
SiFangPingYaoModel:setSLrecord(0)
SiFangPingYaoModel:setinitrecord(0)
SiFangPingYaoModel:setbossanger(0)
SiFangPingYaoModel:resetCheLi()

local mapcheli=SiFangPingYaoModel:getmapcheli()
local maincheli=SiFangPingYaoModel:getmaincheli()
UIManager:closeWindow("UISFPYresetWin")
UIManager:closeWindow("UISFPYreFightWin")

if mapcheli then
SiFangPingYaoController:showbuzhenwin(mapcheli)
SiFangPingYaoModel:setmapcheli(nil)
elseif maincheli then
SiFangPingYaoController:showbuzhenwin(maincheli)
SiFangPingYaoModel:setmaincheli(nil)
else
local startCallback=function()
UIManager:closeWindow("UISFPYresetWin")
UIManager:closeWindow("UISFPYreFightWin")
UIFullSiFangPingYaoControl:showSiFangPingYaoMapWinNoCloud({ischeli=true})
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end
end


function SiFangPingYaoController.recv_34_64(args1)
SiFangPingYaoModel:goinSFPYData(args1[1],args1[2],args1[3],args1[4],args1[5],args1[6],args1[7],args1[8])
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","onShow")
end


function SiFangPingYaoController.recv_34_65(point_id)
SiFangPingYaoModel:setdoingpointid(point_id)
local qiyuflag=SiFangPingYaoModel:getQiyuRecord()
if qiyuflag then
SiFangPingYaoModel:setpointid(point_id)
SiFangPingYaoController.send_34_60(point_id)
else
SiFangPingYaoModel:setpointid(point_id)
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","HandlePointFun",point_id)
end
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","isstoppoint")
end


function SiFangPingYaoController.recv_34_66(chapter_id,value,len,arry,mapidx)
SiFangPingYaoModel:setZhangjieIdex(chapter_id)

local leastvalue=SiFangPingYaoModel:getSLrecord()
local initnewvalue=SiFangPingYaoModel:getinitrecord()
local num=value+leastvalue
if num>100 then
num=100
end
if num<-100 then
num=-100
end
SiFangPingYaoModel:setSLrecord(num)




SiFangPingYaoModel:resetNewZhangJie()
if len>0 then
SiFangPingYaoModel:setPointList(arry)
SiFangPingYaoModel:setmap_idx(mapidx)

UIManager:invokeUIMethod("UISiFangPingYaoMainWin","reshauxinspine")
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","onRefreshInfo")
end
end


function SiFangPingYaoController.recv_34_67(len,arry)
local achieve_list=SiFangPingYaoModel:getachievelist()
if len>0 and arry then
for k,v in ipairs(arry)do
local temp=
{
param_1=v,
param_2=1,
}
table.insert(achieve_list,temp)
end

SiFangPingYaoModel:setachievelist(achieve_list)
end
end


function SiFangPingYaoController.recv_34_68(len,arry)
local achieve_list=SiFangPingYaoModel:getachievelist()
if len>0 and arry then
for k,v in ipairs(arry)do
for i,j in ipairs(achieve_list)do
if j.param_1==v then
j.param_2=2
end
end
end

SiFangPingYaoModel:getachievelist(achieve_list)
UIManager:invokeUIMethod("UISFPYRewardWintwo","recv_reward")
UIManager:invokeUIMethod("UISiFangPingYaoMapWin","refreshjlreddot")
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","refreshjlreddot")
end
end




function SiFangPingYaoController:getzjJinduStrut(demons_id,chapter_id)
local map_id=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id].map_id
local mapcfg=cfg_foursideskilldemonsmapconfig_get(map_id)
local map_idx=SiFangPingYaoModel:getmap_idx()
local allpointlist={}
if map_idx>0 then
local mapdata=mapcfg.routes[map_idx][1]

local rout=mapdata[1]
for k,v in ipairs(rout)do
local list={v}
allpointlist[#allpointlist+1]=list
end
for i=1,3 do
local rout2=mapdata[i+1]or{}
for k,v in ipairs(rout2)do
local data=allpointlist[k]
if data[#data]~=v then
data[#data+1]=v
allpointlist[k]=data
end
end
end
end
return allpointlist
end


function SiFangPingYaoController:getzhanweilist(teamlist)
local dzlist={}
for k,v in ipairs(teamlist)do
if tonumber(tostring(v.param_1))~=0 then
dzlist[#dzlist+1]=v
end
end
return dzlist
end


function SiFangPingYaoController:getPointJiaoHuData(point_id)
local allpointlist=SiFangPingYaoModel:getPointList()
local demons_id=SiFangPingYaoModel:getMapIdex()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
local point_cfg=cfg_foursideskilldemonspointconfig_get(demons_id)[chapter_id][point_id]



local point_data=allpointlist[point_id]
if not point_data and point_id==1000 then
local ywzjcfg=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id]
local boss_id=ywzjcfg.bossid
if boss_id then

point_data={point_id=point_id,point_type=sfpyPointType.yaowang,point_value=boss_id}
end
end


if not point_data and point_id~=1000 and point_cfg then
local fix_rands=point_cfg.fix_rands
local special_plots=point_cfg.special_plots
if fix_rands then
local type=fix_rands[1]
point_data={point_id=point_id,point_type=type,point_value=0}
end

local isjuqingdizi=SiFangPingYaoController:checkshangzhendz()
if special_plots then
if isjuqingdizi then
point_data={point_id=point_id,point_type=sfpyPointType.juqing,point_value=0}
end
end
end


if point_data and point_data.point_type==sfpyPointType.huifu then
local hfpointid=point_data.point_id
local cfgdata=cfg_foursideskilldemonspointconfig_get(demons_id)[chapter_id][hfpointid]
if cfgdata and cfgdata.fix_rands then
if cfgdata.fix_rands[1]==sfpyPointType.huifu then
local value=cfgdata.fix_rands[2]
point_data.point_value=value
end
else
local ywzjcfg=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id]
local value=ywzjcfg.recover_hp
if value then
point_data.point_value=value
end
end

end

if not point_data then
logErr(FMT.fmt("生成的节点{0},没有后端下发数据,也找不到对应配置，妖国{1}，章节{2}，需检查生成的随机点",point_id,demons_id,chapter_id))
end


return point_data
end


function SiFangPingYaoController:getguidteamList()
local teamList={}
local list=SiFangPingYaoModel:getDZTeamList()
for k,v in ipairs(list)do
if tonumber(tostring(v.param_1))~=0 then
table.insert(teamList,v.param_1)
end
end
return teamList
end


function SiFangPingYaoController:getFSZteamList()
local teamList={}
local list=SiFangPingYaoModel:getDZTeamList()
if list then
for k,v in ipairs(list)do
if tonumber(tostring(v.param_1))~=0 then
table.insert(teamList,v.param_1)
else
table.insert(teamList,int64.new('0'))
end
end
end
return teamList
end

function SiFangPingYaoController:getlivedzteamList()
local liveList={}
local list=SiFangPingYaoModel:getDZTeamList()
for k,v in ipairs(list)do
if tonumber(tostring(v.param_1))~=0 then
local blood=tonumber(tostring(v.param_2))
if blood>0 then
table.insert(liveList,v.param_1)
end
end
end
return liveList
end

function SiFangPingYaoController:getdeaddzteamList()
local deadList={}
local list=SiFangPingYaoModel:getDZTeamList()
for k,v in ipairs(list)do
if tonumber(tostring(v.param_1))~=0 then
local blood=tonumber(tostring(v.param_2))
if blood<=0 then
table.insert(deadList,v.param_1)
end
end
end
return deadList
end



function SiFangPingYaoController:getDeadteamList()
local deadlist={}
local list=SiFangPingYaoModel:getDZTeamList()

for k,v in ipairs(list)do
if tonumber(tostring(v.param_1))~=0 then
local blood=tonumber(tostring(v.param_2))
if blood<=0 then
table.insert(deadlist,v)
end
end
end
return deadlist
end


function SiFangPingYaoController:checkshangzhendz()
local list=SiFangPingYaoModel:getDZTeamList()
local demons_id=SiFangPingYaoModel:getMapIdex()
local isjq=false
local specialdziddata=cfg_foursideskilldemonsconfig_get(demons_id).specialdzid
local specialdzid=specialdziddata[1]
for k,v in ipairs(list)do
if tonumber(tostring(v.param_1))~=0 then
local netData=UIDiscipleModel:getDiscipleData(v.param_1)
local diziid=netData.id
if specialdzid==diziid then
isjq=true
break
end
end
end

return isjq
end


function SiFangPingYaoController:getzjAllJindu(demons_id,chapter_id)
local map_id=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id].map_id
local mapcfg=cfg_foursideskilldemonsmapconfig_get(map_id)
local mapdata=mapcfg.routes
local Singlerout=mapdata[1][1][1]
local lenght=0
for k,v in pairs(Singlerout)do
lenght=lenght+1
end
return lenght*3
end


function SiFangPingYaoController:getzjdangqianJindu(ygid)
local all_yg_jd=SiFangPingYaoModel:getYGJingDuData()
local lenght=0
if all_yg_jd and all_yg_jd[ygid]then
if all_yg_jd[ygid].param_3 then
lenght=all_yg_jd[ygid].param_3
end
end

return lenght
end


function SiFangPingYaoController:getzjdqallJindu(ygid)
local all_yg_jd=SiFangPingYaoModel:getYGJingDuData()
local lenght=0
if all_yg_jd and all_yg_jd[ygid]then
lenght=all_yg_jd[ygid].param_3
end

return lenght
end


function SiFangPingYaoController:getzjdangqianJindu2(demons_id,chapter_id)
local map_id=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id].map_id
local mapcfg=cfg_foursideskilldemonsmapconfig_get(map_id)
local mapdata=mapcfg.routes
local Singlerout=mapdata[1][1][1]
local lenght=0
for k,v in pairs(Singlerout)do
lenght=lenght+1
end
return lenght
end


function SiFangPingYaoController:getzjnewjindu()
local demons_id=SiFangPingYaoModel:getMapIdex()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
local Singlerout=SiFangPingYaoController:getzjdangqianJindu2(demons_id,chapter_id)
local num=chapter_id-1
Singlerout=Singlerout*num
local pointendlist=SiFangPingYaoModel:getPointFinishList()
local lenght=0
for k,v in pairs(pointendlist)do
lenght=lenght+1
end
local alljd=lenght+Singlerout

return alljd
end



function SiFangPingYaoController:getzjNowxiabiao(ygid)
local ygreward_data=SiFangPingYaoModel:getYGrewarData()
local flag=0
if ygreward_data and ygreward_data[ygid]then
flag=ygreward_data[ygid].param_2
end

return flag
end



function SiFangPingYaoController.onQiYuEventFinish(guid,endData,sysId)

if sysId==SYSTEM_DEFINE.eJiuChongTianJie1 then
SiFangPingYaoModel:setpointid(0)
SiFangPingYaoModel:setQiyuRecord(false)

SiFangPingYaoModel:setqyfazedata(nil)
end
end


function SiFangPingYaoController.onQiYuEventBlack(guid,endData,sysId)

if sysId==SYSTEM_DEFINE.eJiuChongTianJie1 then
SiFangPingYaoModel:setpointid(0)
SiFangPingYaoModel:setQiyuRecord(false)

end
end


function SiFangPingYaoController:tgreddot(ygid)

local ygcfg=cfg_foursideskilldemonsconfig()
local jifenReward=ygcfg[ygid].demons_rewards
local recvaimid=SiFangPingYaoController:getzjNowxiabiao(ygid)
local jindu=SiFangPingYaoController:getzjdangqianJindu(ygid)
local isreddot=false
for i,v in ipairs(jifenReward)do
local fix=jindu>=v[1]
local flag=recvaimid>=i
if fix and not flag then
isreddot=true
break
end
end

return isreddot
end

function SiFangPingYaoController:tgallreddot()
local ygcfg=cfg_foursideskilldemonsconfig()
local isreddot=false
for i=1,#ygcfg do
isreddot=self:tgreddot(i)

if isreddot then
break
end
end
return isreddot
end

function SiFangPingYaoController:cjreddot(ygid)
local ygcfg=cfg_foursideskilldemonsconfig()
local jifenReward=ygcfg[ygid].achieve_list
local achieve_list=SiFangPingYaoModel:getachievelist()
local isreddot=false
if achieve_list and#achieve_list>0 then
for i,v in ipairs(jifenReward)do
local cjflag=0
for k,j in ipairs(achieve_list)do
if j.param_1==v then
cjflag=j.param_2
break
end
end
local fix=cjflag==1
local flag=cjflag==2
if fix and not flag then
isreddot=true
break
end
end

end
return isreddot
end

function SiFangPingYaoController:cjallreddot()
local ygcfg=cfg_foursideskilldemonsconfig()
local isreddot=false
for i=1,#ygcfg do
isreddot=self:cjreddot(i)

if isreddot then
break
end
end
return isreddot
end


function SiFangPingYaoController:getallgctjreddot()
local reddot1=false
local reddot2=false
local ret=systemModel.isOpen(SYSTEM_DEFINE.eSiFangPingYao1)
if ret then

reddot2=SiFangPingYaoController:cjallreddot()
end
return reddot1 or reddot2
end

function SiFangPingYaoController:getallgctjjindu()
local num=0
local ret=systemModel.isOpen(SYSTEM_DEFINE.eSiFangPingYao1)
if ret then
local allygjd=SiFangPingYaoModel:getYGJingDuData()
if allygjd and#allygjd>0 then
for k,v in ipairs(allygjd)do
local demons_id=v.param_1
local chapter_id=v.param_2
local Allrout=SiFangPingYaoController:getzjAllJindu(demons_id,chapter_id)

if v.param_3>=Allrout then
num=num+1
end
end
end
end
return num,5
end


function SiFangPingYaoController:checkOpen(sysId)
if sysId then
return systemModel.isOpen(sysId)
end
end

function SiFangPingYaoController:getColdDay(sysId)
if sysId then
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(sysId,true)

if not isCan then
local typo=errArgs[1]
local val=errArgs[2]
local val2=errArgs[3]
if typo==SYSTEM_OPEN_TYPE.eSysOpenDay then
local openSec=systemModel.getSystemOpenTime(val)
if not openSec then
loggerUtil.logErrFMT("系统配置有误，条件配置了已开过的系统,没有生成开启时间")
return 0
end
local zerotime=timeHelper.getTodayZeroStamp()
return(math.floor(openSec/86400)+val2)-(math.floor(zerotime/86400))
end
end
end
return 0
end

function SiFangPingYaoController:getOpenTips(sysid)
if sysid then
if systemConfig.isShield(sysid)then return''end
if systemModel.isOpen(sysid,false)then return''end
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(sysid)
if not isCan then
local typo=errArgs[1]
local val=errArgs[2]
local val2=errArgs[3]

if typo==SYSTEM_OPEN_TYPE.eSysOpenDay then
if not systemModel.isOpen(val)then
return FMT.fmt("{0}尚未开启",systemConfig.getSystemName(val))
end
local openSec=systemModel.getSystemOpenTime(val)
if not openSec then
return'系统尚未开启'
end
local zerotime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())
return FMT.fmt('{0}天后开启',(math.floor(openSec/86400)+val2-1)-(math.floor(zerotime/86400)))
end
end
end
end


function SiFangPingYaoController.checkDZTopSortFunc(guid)
local demons_id=SiFangPingYaoModel:getdizisortygid()
local isjq=false
local specialdziddata=cfg_foursideskilldemonsconfig_get(demons_id).specialdzid
local specialdzid=specialdziddata[1]
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local diziid=netData.id
if specialdzid==diziid then
isjq=true
end
end

return isjq
end


function SiFangPingYaoController:showbuzhenwin(ygid)

SiFangPingYaoModel:setdizisortygid(ygid)
local mapconfig=cfg_foursideskilldemonsconfig_get(ygid)
local mapname=mapconfig.name
local ygmapid=mapconfig.ygmapid or 818002
local selectDiscipleCallBack=function(guidList,zhenfaId)
local func=function()
UIManager:closeWindow('UISiFangPingYaoExtraWin')
local tlist={}
for i,v in ipairs(guidList)do
table.insert(tlist,v[2])
end
SiFangPingYaoModel:setMapIdex(ygid)
SiFangPingYaoModel:setTeamChangeRecord(nil)
SiFangPingYaoController.send_34_52(#tlist,tlist)
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud()
fightController:closeSelectStage(false)
end
loadingControl.openCloud(func,2)
end
local CancelCallBack=function()
UIManager:closeWindow('UISiFangPingYaoExtraWin')
UIFullSiFangPingYaoControl:showSiFangPingYaoMapWinNoCloud()
end

local winArgs=
{
enterTxt=mapname,
mapId=ygmapid,
closeByCloud=true,
sfpy_enter=true,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
showZhenFa=false,
checkDZTopSortFunc=SiFangPingYaoController.checkDZTopSortFunc,
cancelCallBack=CancelCallBack,
enterCallBack=selectDiscipleCallBack,
}

fightController.showPrepareWin(fightPreSelectModel.fightType.sifangpingyao,winArgs,function(...)
UIFullFightPrepareControl:showWindow("UISiFangPingYaoExtraWin",{demons_id=ygid})
end)
end