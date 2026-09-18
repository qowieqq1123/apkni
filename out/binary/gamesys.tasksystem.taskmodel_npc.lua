







local npcAllcfg=nil

local forcetable={}
local selecttaskid=0
local accepttask=false
local finishtask=false
local SceneNPCtable={}
local notshowNPCtable={}
local duidietable={}
local inCloudNpctable={}
local yetfinishTask={}
local talktask={}
local weakGuideByAccept={}
local weakGuideByAccept2={}
local qiyuflag=false
local zhuizongtaskline=nil
NPCstage=
{
finish=1,
accept=2,
notfinish=3,
talking=4,
nottalking=5,
}

NPCtaskType=
{
zhuxian=1,
xianjie=2,
zhixian=3,
nothave=4,
}

NPCstageimage=
{

[1]={gantan='image_rwzt_gth3',wenhao='image_rwzt_wh3',qipao='image_rwzt_qp3'},

[2]={gantan='image_rwzt_gth2',wenhao='image_rwzt_wh2',qipao='image_rwzt_qp2'},

[3]={gantan='image_rwzt_gth1',wenhao='image_rwzt_wh1',qipao='image_rwzt_qp1'},

[4]={talksign='image_rwzt_dh1',},
}

xianjieTaskFlagType={
[2]=xianjieForceType.eYuJing,
[3]=xianjieForceType.eJiuYuan,
[4]=xianjieForceType.ePengLai,
[5]=xianjieForceType.eXianGong,
}

function taskModel:clearData_NPC()
taskModel:clearData_ExplorWinTask()
npcAllcfg=nil
forcetable={}
selecttaskid=0
accepttask=false
finishtask=false
SceneNPCtable={}
duidietable={}
notshowNPCtable={}
inCloudNpctable={}
yetfinishTask={}
talktask={}
weakGuideByAccept={}
weakGuideByAccept2={}
zhuizongtaskline=nil
qiyuflag=false
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
end

function taskModel:onEnterState_NPC()

taskModel:onEnterState_ExplorWinTask()
npcAllcfg=cfg_tasknpcconfig()
forcetable={}
local num=xianjieModel:GetForceNum()
for i=1,num do
forcetable[i]={}
end

selecttaskid=0
accepttask=false
finishtask=false
SceneNPCtable={}

duidietable={}
notshowNPCtable={}
inCloudNpctable={}
yetfinishTask={}
talktask={}
weakGuideByAccept={}
weakGuideByAccept2={}
zhuizongtaskline=nil
qiyuflag=false
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.onXianJieCloudUnlock,self.onXianJieCloudChange)
end

function taskModel:onProtocolReq_NPC()
taskModel:initData_NPC()
taskModel:InitNPCTalk()
end



function taskModel:initData_NPC()
for k,v in pairs(npcAllcfg)do
local npcid=v.id
local notshownpc=false
local incloud=false

if v.notshow~=1 then

if v.haveforce then
if not forcetable[v.haveforce]then
forcetable[v.haveforce]={}
end
local num=#forcetable[v.haveforce]+1
forcetable[v.haveforce][num]=v
end

if v.pos then
if not taskModel:judeNPC_InCloud(npcid,v.pos)then
local sceneindex=v.pos[1]
if not SceneNPCtable[sceneindex]then
SceneNPCtable[sceneindex]={}
end
if v.duidie_index then

if not duidietable[v.duidie_index]then
duidietable[v.duidie_index]={}
SceneNPCtable[sceneindex][npcid]=v
end
table.insert(duidietable[v.duidie_index],v.id)
else
SceneNPCtable[sceneindex][npcid]=v
end
else
incloud=true
end
end
elseif v.notshow==1 then
local flag=taskModel:CheckNPCShow(npcid)

if v.pos then
if taskModel:judeNPC_InCloud(npcid,v.pos)then
incloud=true
end
end
if flag then

if v.haveforce then
if not forcetable[v.haveforce]then
forcetable[v.haveforce]={}
end
local num=#forcetable[v.haveforce]+1
forcetable[v.haveforce][num]=v
end

if v.pos then
if not taskModel:judeNPC_InCloud(npcid,v.pos)then
local sceneindex=v.pos[1]
if not SceneNPCtable[sceneindex]then
SceneNPCtable[sceneindex]={}
end
if v.duidie_index then

if not duidietable[v.duidie_index]then
duidietable[v.duidie_index]={}
SceneNPCtable[sceneindex][npcid]=v
end
table.insert(duidietable[v.duidie_index],v.id)
else
SceneNPCtable[sceneindex][npcid]=v
end
end
end
else
notshownpc=true
end
end
if notshownpc then
notshowNPCtable[npcid]=v
end
if incloud then
taskModel:initInCloudNpc(v)
end
end
end


function taskModel.onXianJieCloudChange(cloudid)
taskModel:FindAllNpcInCloundBycloudid(cloudid)
end


function taskModel.onTaskChange(taskid,taskstate)
local taskcfg=taskModel:getTaskConfig(taskid)

if taskstate==taskModel.taskAcceptState then
taskModel:SetNewExplorationTask(taskid,taskcfg.tasklineid,taskstate)
end

if taskstate~=taskModel.taskAcceptState then
local explorflag=taskModel:GetisExplor_newtask(taskid)
if explorflag then
taskModel:SaveExplor_newtask(taskid,false)
end
end

if taskstate==taskModel.taskRewardState then

if taskcfg.weakGuideByCanReward then
for k,v in ipairs(taskcfg.weakGuideByCanReward)do
taskModel:tasknextStep(v)
end
end
end


if taskstate==taskModel.taskFinishState then

local flag=taskModel:GetisNewTask(taskcfg.tasklineid)
if flag then
taskModel:SavetaskModel_newtask(taskcfg.tasklineid,false)
end



if taskcfg.weakGuideByFinish then
for k,v in ipairs(taskcfg.weakGuideByFinish)do
taskModel:tasknextStep(v)
end
end
end

if taskcfg.tasktype==272 then
if taskstate==taskModel.taskDoingState then
local params=string.split(taskcfg.params[1],'_')
local NPCid=tonumber(params[1])
local treeid=tonumber(params[2])
if not talktask[NPCid]then
talktask[NPCid]={}
end
talktask[NPCid][#talktask[NPCid]+1]={treeid=treeid,taskid=taskid}
end
end
if taskcfg.tasktype==298 then
xianjieModel:haveShouMotask()
end

if taskcfg.tasklineid>=5001 and taskcfg.tasklineid<=5200 then
UIManager:invokeUIMethod('UIXianJieChengJiu','refreshWin')
UIManager:invokeUIMethod('UIXianJieExplorationTaskWin','refreshcj')
UIManager:invokeUIMethod('UIXianJieExplorationWin','refreshAllMenuItemSingleReddot',3)
end

if taskcfg.accept_npc then
local npccfg=taskModel:getTaskNPCConfig(taskcfg.accept_npc)
if npccfg.pos then
xianjieModel:refreshNPCData(taskcfg.accept_npc)
end
end
if taskcfg.finish_npc then
local npccfg=taskModel:getTaskNPCConfig(taskcfg.finish_npc)
if npccfg.pos then
xianjieModel:refreshNPCData(taskcfg.finish_npc)
end
end
local Forceid=0

if taskcfg.hideNPC_show then
for k,v in pairs(taskcfg.hideNPC_show)do
local npcid=k
local npccfg=taskModel:getTaskNPCConfig(npcid)

local npcidflag=taskModel:CheckNPCShow(npcid)

local flag=taskModel:checkInNotShow(npcid)
if npcidflag then
local flag=taskModel:checkInNotShow(npcid)
if flag then
if npccfg.pos then

if not taskModel:judeNPC_InCloud(npcid,npccfg.pos)then
taskModel:SetShowNPC(npccfg)
end
else
if not forcetable then
forcetable={}
end
if not forcetable[npccfg.haveforce]then
forcetable[npccfg.haveforce]={}
end
local num=#forcetable[npccfg.haveforce]+1

forcetable[npccfg.haveforce][num]=npccfg
Forceid=npccfg.haveforce
end
notshowNPCtable[npcid]=nil

end
else

if not flag then
if npccfg.pos then
taskModel:DeleteShowNPC(npccfg)
else
if forcetable[npccfg.haveforce]then
local index=0
for k,v in ipairs(forcetable[npccfg.haveforce])do
if v.id==npcid then
index=k
break
end
end
if index>0 then
table.remove(forcetable[npccfg.haveforce],index)
end
Forceid=npccfg.haveforce
end
end
notshowNPCtable[npcid]=npccfg

end
end
end
end
UIManager:invokeUIMethod('UIXianJieForceWin','onTaskChange',taskid,taskstate,Forceid)
end

function taskModel:tasknextStep(data)
if data[1]==1 then

weakGuideController:beginGuide(data[2])
elseif data[1]==2 then

UIManager:invokeUIMethod("UIYuJingMainWin",'onBtnClose')
UIManager:invokeUIMethod("UIXianGongMainWin",'onBtnClose')
UIManager:invokeUIMethod("UIPengLaiMainWin",'onBtnClose')
UIManager:invokeUIMethod("UIPengLaiMainWin",'onBtnClose')
end

end



function taskModel:FindAllNpcInCloundBycloudid(cloudid)
if inCloudNpctable[cloudid]and next(inCloudNpctable[cloudid])then
for k,v in pairs(inCloudNpctable[cloudid])do
local npccfg=v
local npcid=k
if not notshowNPCtable[npcid]then
taskModel:SetShowNPC(npccfg)
end
end
inCloudNpctable[cloudid]=nil
end
end

function taskModel:initInCloudNpc(npccfg)
local pos=npccfg.pos
if pos and taskModel:judeNPC_InCloud(npccfg.id,pos)then
local npccloudid=xianjieModel:caculationCloudID(pos[2],pos[3])
if not inCloudNpctable[npccloudid]then
inCloudNpctable[npccloudid]={}
end
inCloudNpctable[npccloudid][npccfg.id]=npccfg
end
end


function taskModel:JudeNPCIsInCloud(NPCID)
local npccfg=taskModel:getTaskNPCConfig(NPCID)
local pos=npccfg.pos
if pos and taskModel:judeNPC_InCloud(NPCID,pos)then
return true
end
return false
end



function taskModel:SetShowNPC(npccfg)
local npcid=npccfg.id
if npccfg.duidie_index then

if not duidietable[npccfg.duidie_index]then
duidietable[npccfg.duidie_index]={}
if not SceneNPCtable[npccfg.pos[1]]then
SceneNPCtable[npccfg.pos[1]]={}
end
SceneNPCtable[npccfg.pos[1]][npcid]=npccfg

local sceneidx=xianjieModel:getSceneIndex()
if sceneidx then
local sceneidx_=taskModel:judeIsInScence(sceneidx)

if npccfg.pos[1]==sceneidx_ then
xianjieModel:addNPCData(npccfg,false)
end
end
end
table.insert(duidietable[npccfg.duidie_index],npccfg.id)
else
if not SceneNPCtable[npccfg.pos[1]]then
SceneNPCtable[npccfg.pos[1]]={}
end
SceneNPCtable[npccfg.pos[1]][npcid]=npccfg

local sceneidx=xianjieModel:getSceneIndex()
if sceneidx then
local sceneidx_=taskModel:judeIsInScence(sceneidx)

if npccfg.pos[1]==sceneidx_ then
xianjieModel:addNPCData(npccfg,false)
end
end
end
end

function taskModel:DeleteShowNPC(npccfg)
local npcid=npccfg.id

local sceneidx=xianjieModel:getSceneIndex()
if sceneidx then
local sceneidx_=taskModel:judeIsInScence(sceneidx)

if npccfg.pos[1]==sceneidx_ then
if npccfg.duidie_index then

for k1,v1 in ipairs(duidietable[npccfg.duidie_index])do
if v1==npccfg.id then
table.remove(duidietable[npccfg.duidie_index],k1)
break
end
end
if#duidietable<=0 then
xianjieModel:removeNPCData(npcid)
end
else
xianjieModel:removeNPCData(npcid)
end
end
if not SceneNPCtable then
SceneNPCtable={}
end
local index=npccfg.pos[1]
if not index then
return
end
if not SceneNPCtable[index]then
SceneNPCtable[index]={}
end
SceneNPCtable[index][npcid]=nil
end
end


function taskModel:judeIsInScence(sceneidx)
if sceneidx then
local sceneidx_
if xianjienSceneIndexType:isXianYu(sceneidx)then
sceneidx_=200
else
sceneidx_=sceneidx
end
return sceneidx_
end
return nil
end

function taskModel:checkInNotShow(npcid)
if not notshowNPCtable[npcid]then
return false
end
return true
end


function taskModel:judeNPC_InCloud(npcid,pos)
local pos=pos
if not pos then
local npccfg=taskModel:getTaskNPCConfig(npcid)
pos=npccfg.pos
end
local flag=xianjieModel:checkGridState(pos[1],pos[2],pos[3],xjMapGridStateType.eCloudLock)
return flag and flag==1
end




function taskModel:CheckNPCShow(NPCid)
local taskList=taskModel:getTaskList()
for i,v in ipairs(taskList)do
local fit=false

local systemZM_ID=systemZongMenModel:getTaskBelong(v.taskid)
local systemZM_Info=systemZM_ID~=nil and systemZongMenModel:findInfoDataById(systemZM_ID)or nil
if systemZM_ID==nil or(systemZM_Info~=nil and systemZM_Info.relation_num~=systemZongMenRelationType.eDiDui)then
if v.cfg.hideNPC_show and v.cfg.hideNPC_show[NPCid]then
local taskstate=taskModel:getTaskState_transfromstate(v)
local table=v.cfg.hideNPC_show[NPCid]
if table[taskstate]and table[taskstate]==1 then
return true
end
end
end
end
return false
end


function taskModel:GetNPCStage(npcid)
local taskdata=taskModel:GetHighLvTask(npcid)
local npcstage=""
local flag,tasktype=taskModel:JudeHaveTalktaskByNpcId(npcid)
if flag then
return NPCstageimage[tasktype].wenhao,tasktype
end
if next(taskdata)then
local taskstate=taskModel:getTaskState_transfromstate(taskdata)
local cfg=taskdata.cfg
local taskline=cfg.tasklineid
local tasktype=0
local needgray=false
if taskline==1 then
tasktype=1
elseif taskModel:isXianJieTask(taskline)and cfg.xianjietype==1 then
tasktype=2
else
tasktype=3
end

if taskstate==taskModel.taskRewardState then
npcstage="image_rwzt_bx1"
elseif taskstate==taskModel.taskDoingState then
npcstage=NPCstageimage[tasktype].wenhao
needgray=true
elseif taskstate==taskModel.taskAcceptState then
npcstage=NPCstageimage[tasktype].gantan
end
return npcstage,tasktype,needgray
else
local tasktype=4
npcstage=NPCstageimage[tasktype].talksign
return npcstage,tasktype
end
end

function taskModel:InitNPCTalk()
local taskList=taskModel:getTaskList()
for i,v in ipairs(taskList)do
local fit=false
local systemZM_ID=systemZongMenModel:getTaskBelong(v.taskid)
local systemZM_Info=systemZM_ID~=nil and systemZongMenModel:findInfoDataById(systemZM_ID)or nil
if systemZM_ID==nil or(systemZM_Info~=nil and systemZM_Info.relation_num~=systemZongMenRelationType.eDiDui)then
if v.cfg.tasktype==272 then
local taskstate=taskModel:getTaskState_transfromstate(v)
if taskstate==taskModel.taskDoingState then
local params=string.split(v.cfg.params[1],'_')
local NPCid=tonumber(params[1])
local treeid=tonumber(params[2])
if not talktask[NPCid]then
talktask[NPCid]={}
end
talktask[NPCid][#talktask[NPCid]+1]={treeid=treeid,taskid=v.cfg.id}
end
end
end
end
return false
end




function taskModel:FindSelectIndex(npcid)
local selectlist={}

local Canfinish=taskModel:GetCanfinishByNPCid(npcid)


local CanAccept,Doingtasktable,notcan=taskModel:GetTaskidbyNPCid(npcid)
for k,v in ipairs(Canfinish)do
table.insert(selectlist,v.taskid)
end
for k,v in ipairs(CanAccept)do
table.insert(selectlist,v.taskid)
end
for k,v in ipairs(Doingtasktable)do
table.insert(selectlist,v.taskid)
end
for k,v in ipairs(notcan)do
table.insert(selectlist,v.taskid)
end
return selectlist
end


function taskModel:GetTaskidbyNPCid(NPCid)

local tasklist=cfgHelper.get2(cfg_tasknpcconfig_get,NPCid,'taskid')
if not tasklist or not next(tasklist)then
return{},{},{}
end

local tasktable={}
local Doingtasktable={}
local notcantable={}
local ishaveZhuiZong=nil
local iszhuxian=nil
local isxiyou=nil
for k,v in ipairs(tasklist)do
local taskid=v
local taskdata=taskModel:getTask(taskid)
if taskdata~=nil then
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)

local sort=0
local cfg=taskModel:getTaskConfig(taskid)
local type=taskModel:GettaskType(taskid)
local tasklineid=cfg.tasklineid
local iszhuizong=taskModel:isZhuiZongTask(tasklineid)
if iszhuizong then
ishaveZhuiZong=iszhuizong
end
if tasklineid==1 then
iszhuxian=true
end
if cfg.xianjietype and cfg.xianjietype==1 then
isxiyou=true
end
if type==1 then
sort=sort+1000
elseif type==2 then
sort=sort+100
elseif type==3 then
sort=sort+10
end
if taskModel:judeNotAcceptTask(taskid)then
if taskModel:fitAcceptCondition(taskid)then
table.insert(tasktable,{taskid=taskid,sort=sort,tasklineid=tasklineid,type=type,iszhuizong=iszhuizong})
elseif taskModel:fitShowConditon(taskid)then

table.insert(notcantable,{taskid=taskid,sort=sort,tasklineid=tasklineid,type=type,iszhuizong=iszhuizong})
end

elseif t_taskstate==taskModel.taskDoingState then

table.insert(Doingtasktable,{taskid=taskid,sort=sort,tasklineid=tasklineid,type=type,iszhuizong=iszhuizong})
elseif t_taskstate==taskModel.taskRewardState then

local finish_npc=taskdata.cfg.finish_npc
if finish_npc and finish_npc~=NPCid then

table.insert(Doingtasktable,{taskid=taskid,sort=sort,tasklineid=tasklineid,type=type,iszhuizong=iszhuizong})
end
end
end
end
table.sort(tasktable,function(a,b)
if a.sort==b.sort then
return a.tasklineid>b.tasklineid
else
return a.sort>b.sort
end
end)
table.sort(Doingtasktable,function(a,b)
if a.sort==b.sort then
return a.tasklineid>b.tasklineid
else
return a.sort>b.sort
end
end)

return tasktable,Doingtasktable,notcantable,ishaveZhuiZong,iszhuxian,isxiyou
end


function taskModel:GetNPCdatabyForceid(Forceid)
if not forcetable[Forceid]then
forcetable[Forceid]={}
end
return forcetable[Forceid]
end



function taskModel:GetHighTaskbyForceid(Forceid)
local list={}
local havetaskflag=nil

if not forcetable[Forceid]then
return{},nil
end
for k,v in ipairs(forcetable[Forceid])do
local hightask=taskModel:GetHighLvTask(v.id)
if next(hightask)then
havetaskflag=true
end
table.insert(list,{hightask,v})
end

table.sort(list,function(a,b)
if not next(a[1])then
return false
elseif not next(b[1])then
return true
end
if a[1].npcSort==b[1].npcSort then
if a[1].taskstate==b[1].taskstate then
return a[1].taskline>b[1].taskline
else
if a[1].taskstate==taskModel.taskRewardState then
return true
end
if b[1].taskstate==taskModel.taskRewardState then
return false
end
end
return false
else
return a[1].npcSort>b[1].npcSort
end
end)
return list,havetaskflag
end

function taskModel:GetHighLvByduidieIndex(index)
local list={}
local havetaskflag=nil
if not duidietable[index]then
return{},nil
end
for k,v in ipairs(duidietable[index])do
local npcid=v
local hightask=taskModel:GetHighLvTask(npcid)
local npccfg=taskModel:getTaskNPCConfig(npcid)
if next(hightask)then
havetaskflag=true
end
table.insert(list,{hightask,npccfg})
end

table.sort(list,function(a,b)
if not next(a[1])then
return false
elseif not next(b[1])then
return true
end
if a[1].npcSort==b[1].npcSort then
if a[1].taskstate==b[1].taskstate then
return a[1].taskline>b[1].taskline
else
if a[1].taskstate==taskModel.taskRewardState then
return true
end
if b[1].taskstate==taskModel.taskRewardState then
return false
end
end
return false
else
return a[1].npcSort>b[1].npcSort
end
end)
return list,havetaskflag
end


function taskModel:GetHighLvTask(npcid)
local alllist=taskModel:GetAlltaskByNPC(npcid)
if next(alllist)then
return alllist[1]
end
return{}
end


function taskModel:GetAlltaskByNPC(npcid)
local taskList=taskModel:getTaskList()
local list={}
for i,v in ipairs(taskList)do
local fit=false

local systemZM_ID=systemZongMenModel:getTaskBelong(v.taskid)
local systemZM_Info=systemZM_ID~=nil and systemZongMenModel:findInfoDataById(systemZM_ID)or nil
if systemZM_ID==nil or(systemZM_Info~=nil and systemZM_Info.relation_num~=systemZongMenRelationType.eDiDui)then
local taskstate=taskModel:getTaskState_transfromstate(v)
local cfg=v.cfg
if cfg.accept_npc==npcid or cfg.finish_npc==npcid then
if taskstate==taskModel.taskRewardState and cfg.finish_npc==npcid then
fit=true
elseif taskstate==taskModel.taskAcceptState and cfg.accept_npc==npcid then
fit=true
elseif taskstate==taskModel.taskDoingState then
fit=true
end

v.npcSort=0
local tasklineid=cfg.tasklineid
local iszhuizong=taskModel:isZhuiZongTask(tasklineid)
if iszhuizong then
v.npcSort=10000
elseif tasklineid==1 then
v.npcSort=1000
elseif cfg.xianjietype and cfg.xianjietype==1 then
v.npcSort=100
end
v.taskstate=taskstate
end

if cfg.tasktype==272 then
if taskstate==taskModel.taskDoingState then
local params=string.split(cfg.params[1],'_')
local NPCid=tonumber(params[1])
if NPCid==npcid then
fit=true
v.npcSort=1000000










end
end
end

end

if fit then
table_insert(list,v)
end
end
table.sort(list,function(a,b)
if a.npcSort==b.npcSort then
if a.taskstate==b.taskstate then
return a.taskline>b.taskline
else
if a.taskstate==taskModel.taskRewardState then
return true
end
if b.taskstate==taskModel.taskRewardState then
return false
end
end
return false
else
return a.npcSort>b.npcSort
end
end)
return list
end



function taskModel:GetNPCdatabySceneindex(sceneindex)
if not SceneNPCtable[sceneindex]then
SceneNPCtable[sceneindex]={}
end
return SceneNPCtable[sceneindex]
end





function taskModel:GetCanfinishByNPCid(npcid)
local canfinishlist=taskModel:GetCanFinishTask()
local canfinishtable={}
local ishavezhuizong=nil
local iszhuxian=nil
local isxiyou=nil
for k,v in ipairs(canfinishlist)do
local taskid=v
local cfg=taskModel:getTaskConfig(taskid)
local type=taskModel:GettaskType(v)
local sort=0
local tasklineid=cfg.tasklineid
local iszhuizong=taskModel:isZhuiZongTask(tasklineid)
if iszhuizong then
ishavezhuizong=iszhuizong
end
if tasklineid==1 then
iszhuxian=true
end
if cfg.xianjietype and cfg.xianjietype==1 then
isxiyou=true
end
if type==1 then
sort=sort+1000
elseif type==2 then
sort=sort+100
elseif type==3 then
sort=sort+10
end
local finish_npc=cfg.finish_npc
if finish_npc and npcid==finish_npc then
table.insert(canfinishtable,{taskid=taskid,sort=sort,tasklineid=tasklineid,type=type,iszhuizong=iszhuizong})
end
end
table.sort(canfinishtable,function(a,b)
if a.sort==b.sort then
return a.tasklineid>b.tasklineid
else
return a.sort>b.sort
end
end)

return canfinishtable,ishavezhuizong
end



function taskModel:judeCanFinishTask(taskid)
local taskdata=taskModel:getTask(taskid)
if taskdata~=nil then
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
if t_taskstate==taskModel.taskRewardState then
return true
end
end
return false
end


function taskModel:isHaveFinishNPCTask(taskid)
local cfg=taskModel:getTaskConfig(taskid)
local finish_npc=cfg.finish_npc

return finish_npc and finish_npc~=0
end



function taskModel:judeNotAcceptTask(taskid)
local taskdata=taskModel:getTask(taskid)
if taskdata~=nil then
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
if t_taskstate~=taskModel.taskAcceptState then



return false
end
return true
end
end



function taskModel:getTaskNPCConfig(NPCid)
return cfgHelper.get1(cfg_tasknpcconfig_get,NPCid)
end


function taskModel:SetReceiveTask(index)
selecttaskid=index
end

function taskModel:GetReceiveTask()
if not selecttaskid then
selecttaskid=0
end
return selecttaskid
end


function taskModel:SetAcceptFlag(flag)
accepttask=flag
end

function taskModel:GetAcceptFlag()
return accepttask
end

function taskModel:SetFinishFlag(flag)
finishtask=flag
end

function taskModel:GetFinishFlag()
return finishtask
end


function taskModel:newtaskweakGuide(taskid)
if taskid then
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.weakGuideByAccept then
weakGuideByAccept={taskcfg.weakGuideByAccept,taskid}
elseif taskcfg.weakGuideByAccept2 then
if taskcfg.weakGuideByAccept2[1]==1 then
taskModel:SetnewtaskweakGuide2(taskid,true)
end
end
else
weakGuideByAccept={}
end
end


function taskModel:GetnewtaskweakGuide()
return weakGuideByAccept
end

function taskModel:GetnewtaskweakGuide2()
return weakGuideByAccept2
end

function taskModel:SetnewtaskweakGuide2(taskid,flag)
local taskcfg=taskModel:getTaskConfig(taskid)
if flag then
weakGuideByAccept2[taskid]=taskcfg.weakGuideByAccept2[2]
if taskcfg.weakGuideByAccept2[1]==1 then
UIManager:invokeUIMethod('UIXianJieForceWin','playGuide',taskid)
end

else
weakGuideByAccept2[taskid]=nil
end

end


function taskModel:judeNeedTrace(taskid,taskline)
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.needTrace==1 then
taskModel:SaveZhuizong(taskline)
end
end


function taskModel:SavetaskModel_newtask(taskline,flag,taskid)
if taskid then
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.showInMenu==false then
return
end
end
local datatable=taskModel:loadtaskModel_newtask()
local tasklinestring=tostring(taskline)
if flag then
datatable[tasklinestring]=true
else
datatable[tasklinestring]=nil
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eTask,'taskModel_newtask2',datatable)
userActorArraySetting.flushDelay(ACTOR_SETTING_TYPE.eTask)
reddotControl.on_task_changed()
end



function taskModel:loadtaskModel_newtask()
local datatable=userActorArraySetting.get(ACTOR_SETTING_TYPE.eTask,'taskModel_newtask2',false)
return datatable or{}
end


function taskModel:GetisNewTask(taskline)
local datatable=taskModel:loadtaskModel_newtask()
local tasklinestring=tostring(taskline)
return datatable[tasklinestring]
end


function taskModel:GetHaveNewTask()
local datatable=taskModel:loadtaskModel_newtask()
local zhuxian
local xianjie
local zhixian
for k,v in pairs(datatable)do
if v then
local tasklineid=tonumber(k)
if tasklineid==1 then
zhuxian=true
elseif taskModel:isXianJieTask(tasklineid)then
xianjie=true
else
zhixian=true
end
end
end
return zhuxian,xianjie,zhixian
end


function taskModel:clearNoneTaskLineNewFlag()
local datatable=taskModel:loadtaskModel_newtask()
local needResetData=false
local filterline=taskModel:filterCurTaskLine()
for k,v in pairs(datatable)do
if v then
local tasklineid=tonumber(k)
local taskData=filterline and filterline[tasklineid]
if not taskData then

datatable[k]=nil
needResetData=true
end
end
end

if needResetData then
userActorArraySetting.set(ACTOR_SETTING_TYPE.eTask,'taskModel_newtask2',datatable)
userActorArraySetting.flushDelay(ACTOR_SETTING_TYPE.eTask)
reddotControl.on_task_changed()
end
end


function taskModel:GetNewTaskReddot()
local a,b,c=taskModel:GetHaveNewTask()
if a or b or c then
return true
end
return false
end


function taskModel:isZhuiZongTask(taskline)
local data=taskModel:GetZhuizong()
if not data or not next(data)then
return false
end
return data[1]==taskline
end


function taskModel:isRareTask(taskid)
if taskid then
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.xianjietype and taskcfg.xianjietype>0 then
return true,taskcfg.xianjietype
end
end
return false
end


function taskModel:SaveZhuizong(taskline)
zhuizongtaskline={taskline}
userActorSetting.set("task_Zhuizongdata",{taskline})
userActorSetting.flush(0.5)
end


function taskModel:GetZhuizong()
if not zhuizongtaskline then
zhuizongtaskline=userActorSetting.get("task_Zhuizongdata",{})
end
return zhuizongtaskline or{}
end



function taskModel:SavetaskNPC_data(taskid,npcid,accept,finish)
local datatable=taskModel:loadtaskNPC_data()
local taskidstring=tostring(taskid)
if not datatable[taskidstring]then
datatable[taskidstring]={taskid,npcid,accept,finish}
end
userActorSetting.set("taskNPC_data",datatable)
userActorSetting.flush()
end


function taskModel:loadtaskNPC_data()
local datatable=userActorSetting.get("taskNPC_data",nil)
return datatable or{}
end



function taskModel:loadtaskNPC_acceptByTaskid(taskid)
local datatable=taskModel:loadtaskNPC_data()
local taskidstring=tostring(taskid)
if not datatable[taskidstring]then
return false
end
if datatable[taskidstring][3]then
return true
end
return false
end


function taskModel:loadtaskNPC_finishByTaskid(taskid)
local datatable=taskModel:loadtaskNPC_data()
local taskidstring=tostring(taskid)
if not datatable[taskidstring]then
return false
end
if datatable[taskidstring][3]then
return true
end
return false
end


function taskModel:judeFinishItem(taskid)
local cfg=taskModel:getTaskConfig(taskid)

local taskItem=cfg.taskItem
if not taskItem then
return true
end
for k,v in ipairs(taskItem)do
local neednum=v[2]
local hasCount=itemsModel.getCount(v[1])
if neednum>hasCount then
return false
end
end
return true
end


function taskModel:judeTaskHaveItem(taskid)
local cfg=taskModel:getTaskConfig(taskid)

local taskItem=cfg.taskItem
if taskItem then
return true
end
return false
end


function taskModel:isXianJieTask(taskline)
return xianjieController:cheakXianJieTaskbyTaskLine(taskline)
end


function taskModel:GettaskType(taskid)
local cfg=taskModel:getTaskConfig(taskid)
local taskline=cfg.tasklineid
if taskline==1 then
return 1
elseif taskModel:isXianJieTask(taskline)then
if cfg.xianjietype then
return 2
else
return 3
end
else
return 4
end
end




function taskModel:GetZhuiZongTaskType()
local data=taskModel:GetZhuizong()
if not data or not next(data)then
return false
end
local taskline=data[1]
if taskline==1 then
return 1
elseif taskModel:isXianJieTask(taskline)then
return 2
else
return 3
end
end


function taskModel:GettaskTypeSign(type)
local abName="ui/windows/xiangong/xiangong_atlas_pak.ab"
if type==1 then
return'icon_zhuyao_2',abName
elseif type==2 then
return'image_xi_2',abName
elseif type==5 then
return'icon_zhui_1',abName
end
end




function taskModel:SetSelectlist(npcdata)
local npcid=npcdata.id
local selectbefore=npcdata.selectbefore
local index=math.random(1,#selectbefore)
local isFullOpen=true
local npccfg=taskModel:getTaskNPCConfig(npcid)
if npccfg.haveforce then
isFullOpen=false
UIManager:invokeUIMethod("UIXianJieForceWin","onCloselist")
end


local talkNpc_doing=function()

if talktask[npcid]and#talktask[npcid]>0 then
taskModel:recordFinishTask(talktask[npcid][1].taskid,true,npcid)
end
end
if talktask[npcid]and#talktask[npcid]>0 then
local treeid=talktask[npcid][1].treeid
local tasklist={isFullOpen=isFullOpen}
worldStoryController:showStoryTree(treeid,talkNpc_doing,nil,nil,tasklist)
return
end




local selectlist=taskModel:FindSelectIndex(npcid)
local selecttable={}
local signtable={}
for k,v in ipairs(selectlist)do
local taskid=v
local cfg=taskModel:getTaskConfig(taskid)
local name=cfg.name

local type=taskModel:GettaskType(taskid)
local tasklineid=cfg.tasklineid
local iszhuizong=taskModel:isZhuiZongTask(tasklineid)

table.insert(selecttable,name)
table.insert(signtable,iszhuizong and 5 or type)
end


if npcdata.talkday_treeid and(#selectlist>1 or#selectlist==0)then
table.insert(selecttable,"闲聊")
end

local callback=function(idx,selectindex)
local callback_Accept=function()

local task_id=taskModel:GetReceiveTask()
local flag=taskModel:GetAcceptFlag()
if flag and task_id and task_id~=0 then
taskController:reqAcceptTask(task_id)
else

taskModel:SavetaskNPC_data(task_id,npcid,true)
end
taskModel:SetAcceptFlag(false)
taskModel:SetReceiveTask(0)
end
local callback_finish=function()

local task_id=taskModel:GetReceiveTask()
if task_id and task_id~=0 then
if taskModel:judeCanFinishTask(task_id)then
local cfg=taskModel:getTaskConfig(task_id)
local finishsecond_treeid=cfg.finishsecond_treeid
if not finishsecond_treeid then

taskController:doGetTaskReward(task_id)

else
if taskModel:GetFinishFlag()then
taskController:doGetTaskReward(task_id)
else

taskModel:SavetaskNPC_data(task_id,npcid,nil,true)
end
end
end
taskModel:SetAcceptFlag(false)
taskModel:SetFinishFlag(false)
taskModel:SetReceiveTask(0)
end
end


if selectlist and selectlist[selectindex]then
local taskid=selectlist[selectindex]
if taskid then
local cfg=taskModel:getTaskConfig(taskid)
local taskdata=taskModel:getTask(taskid)

local taskItem=taskdata.cfg.taskItem
local tasklist={taskItem=taskItem,isFullOpen=isFullOpen}
taskModel:SetReceiveTask(taskid)
if taskdata~=nil then
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
if t_taskstate==taskModel.taskAcceptState then
local tasklist={taskItem=taskItem,isaccepttask=true,isFullOpen=isFullOpen}

if taskModel:fitAcceptCondition(taskid)then
local yetrecord=taskModel:loadtaskNPC_acceptByTaskid(taskid)
if not yetrecord then

local accept_treeid=cfg.accept_treeid





worldStoryController:showStoryTree(accept_treeid,callback_Accept,nil,nil,tasklist)
else

local acceptsecond_treeid=cfg.acceptsecond_treeid





worldStoryController:showStoryTree(acceptsecond_treeid,callback_Accept,nil,nil,tasklist)
end
else
local notcan_treeid=cfg.notcan_treeid
if notcan_treeid then
worldStoryController:showStoryTree(notcan_treeid,callback_Accept,nil,nil,tasklist)
end
end

elseif t_taskstate==taskModel.taskDoingState then

if taskModel:judeTaskHaveItem(taskid)then

local finish_npc=taskdata.cfg.finish_npc
if finish_npc and finish_npc==npcid then


local yetrecord=taskModel:loadtaskNPC_finishByTaskid(taskid)
local tasklist={taskItem=taskItem,finishselect=true,isfinishtask=true,isFullOpen=isFullOpen}
if not yetrecord then

local finish_treeid=cfg.finish_treeid





worldStoryController:showStoryTree(finish_treeid,callback_finish,nil,nil,tasklist)
else

local finishsecond_treeid=cfg.finishsecond_treeid





worldStoryController:showStoryTree(finishsecond_treeid,callback_finish,nil,nil,tasklist)
end
return
end
end

if taskdata.cfg.tasktype==310 then
qiyuflag=true
taskModel:dealMysteryEvent(npccfg.haveforce,taskdata.cfg.params[1],taskid)
return
end


local doing_treeid=cfg.doing_treeid





worldStoryController:showStoryTree(doing_treeid,nil,nil,nil,tasklist)
elseif t_taskstate==taskModel.taskRewardState then


local finish_npc=taskdata.cfg.finish_npc
if finish_npc and finish_npc~=npcid then
local tasklist={taskItem=taskItem,isaccepttask=true,isFullOpen=isFullOpen}

local doing_treeid=cfg.doing_treeid





worldStoryController:showStoryTree(doing_treeid,nil,nil,nil,tasklist)
else


local yetrecord=taskModel:loadtaskNPC_finishByTaskid(taskid)
local tasklist={taskItem=taskItem,finishselect=true,isfinishtask=true,isFullOpen=isFullOpen}
if not yetrecord then

local finish_treeid=cfg.finish_treeid





worldStoryController:showStoryTree(finish_treeid,callback_finish,nil,nil,tasklist)
else

local finishsecond_treeid=cfg.finishsecond_treeid





worldStoryController:showStoryTree(finishsecond_treeid,callback_finish,nil,nil,tasklist)
end
end
end
end
end
elseif selecttable and selecttable[selectindex]then

local talkday_treeid=npcdata.talkday_treeid
local randindex=math.random(1,#talkday_treeid)
local tasklist={isFullOpen=isFullOpen}
worldStoryController:showStoryTree(talkday_treeid[randindex],nil,nil,nil,tasklist)
end
end

if#selectlist>1 then
local params={}
params.blackAlpha=1
local groupid=cfgHelper.get1(cfg_storydialoguegroupconfig_get,selectbefore[index])
params.showblack=groupid.blackBack
params.dialoguelist=groupid.dialoguelist
if#selecttable>0 then

params.selectlist={#params.dialoguelist,selecttable,signtable}
end
params.selecttaskid=0
params.callback=callback
UIFullStoryBoardControl:showPlotBoardWindow(params,isFullOpen)
else

callback(nil,1)
end
end


function taskModel:getXJFactionByTaskFlag(flag)
return xianjieTaskFlagType[flag]
end


function taskModel:GetShowTaskList()
local alltasklist=taskModel:getTaskList_show()
local linemaintable={}
local xianjietable={}
local zhixiantable={}
local xianjieshilitable={}
local alltasktable={}
local showtasktable={}
for k,v in ipairs(alltasklist)do
if v.taskline==taskModel.lineMain then
table.insert(linemaintable,v)
elseif v.cfg.xianjietype and self:getXJFactionByTaskFlag(v.cfg.xianjietype)then
table.insert(xianjieshilitable,v)
elseif taskModel:isXianJieTask(v.taskline)then
table.insert(xianjietable,v)
else
table.insert(zhixiantable,v)
end
end
alltasktable[1]={data=linemaintable,name="主线",flag=1,}
alltasktable[2]={data=xianjietable,name="仙界",flag=2,}
alltasktable[3]={data=zhixiantable,name="支线",flag=3,}
alltasktable[4]={data=xianjieshilitable,name="势力",flag=4,}
if next(linemaintable)then
table.insert(showtasktable,alltasktable[1])
end
if next(xianjietable)then
table.insert(showtasktable,alltasktable[2])
table.sort(alltasktable[2],function(a,b)
return a.taskid<b.taskid
end)
end
if next(zhixiantable)then
table.sort(alltasktable[3],function(a,b)
return a.taskid<b.taskid
end)
table.insert(showtasktable,alltasktable[3])
end
if next(xianjieshilitable)then
table.sort(alltasktable[4],function(a,b)
return a.taskid<b.taskid
end)
table.insert(showtasktable,alltasktable[4])
end
return showtasktable
end




function taskModel:GetTaskjuqing(taskid)
local cfg=taskModel:getTaskConfig(taskid)
local xianjieZhangjie=cfg.xianjieZhangjie
if xianjieZhangjie then
UIManager:showWindow("UItaskjuqingWin",{data=xianjieZhangjie})
end
end

function taskModel:GetXianJieType(taskid)
local cfg=taskModel:getTaskConfig(taskid)
local xianjietype2=cfg.xianjietype2
return xianjietype2
end

function taskModel:GetXianJietaskColor(taskid)
local cfg=taskModel:getTaskConfig(taskid)
local xianjieTaskColor=cfg.xianjieTaskColor
return xianjieTaskColor
end


function taskModel:JudeNPCForceNotOpen(accept_npc)
local npccfg=taskModel:getTaskNPCConfig(accept_npc)
local haveforce=npccfg.haveforce
if haveforce then
return not xianjieModel:judeForceisOpen(haveforce)
end
return false
end



function taskModel:recordFinishTask(taskid,flag,npcid)
if not yetfinishTask then
yetfinishTask={}
end
yetfinishTask[taskid]=flag
if flag then

notifySystem:postNotify(notifyConfig.onChangeTaskNpcTalk)
if npcid then
if talktask[npcid]and#talktask[npcid]>0 then
for k,v in ipairs(talktask[npcid])do
if v.taskid==taskid then
table.remove(talktask[npcid],k)
break
end
end
end
end
end
end

function taskModel:GetFinishTask(taskid)
return yetfinishTask[taskid]
end


function taskModel:Gettalktask_NPCByTask(taskid)
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.tasktype==272 then
local taskdata=taskModel:getTask(taskid)
if taskdata~=nil then
local taskstate=taskModel:getTaskState_transfromstate(taskdata)
if taskstate==taskModel.taskDoingState then
local params=string.split(taskcfg.params[1],'_')
local NPCid=tonumber(params[1])
return NPCid
end
end
end
return nil
end


function taskModel:JudeHaveTalktaskByNpcId(npcid)

if not talktask[npcid]or#talktask[npcid]<=0 then
return false
end
local taskid=talktask[npcid][1].taskid
local taskType=taskModel:GettaskType(taskid)
if taskType==4 then

taskType=3
end
return true,taskType
end



function taskModel:CheckShouMo()
local taskList=taskModel:getTaskList()
for i,v in ipairs(taskList)do
local fit=false

local systemZM_ID=systemZongMenModel:getTaskBelong(v.taskid)
local systemZM_Info=systemZM_ID~=nil and systemZongMenModel:findInfoDataById(systemZM_ID)or nil
if systemZM_ID==nil or(systemZM_Info~=nil and systemZM_Info.relation_num~=systemZongMenRelationType.eDiDui)then
if v.cfg.tasktype==298 then
local taskstate=taskModel:getTaskState_transfromstate(v)
if taskstate==taskModel.taskDoingState then
return true
end
end
end
end
return false
end


function taskModel:dealMysteryEvent(forceid,eventid,taskid)

local param={MysteryEventSendType.eXianJieForce,taskid}
local eventid=eventid
local resumeCB=function()
if forceid then
xianjieModel:showForcewin(forceid)
end
end
MysteryEventSystem.event_start(SYSTEM_DEFINE.eXianJieShiLiQiYuEvent,eventid,{},param,true,resumeCB)

end

function taskModel:SetQiYuFlag(flag)

qiyuflag=flag
end

function taskModel:GetQiYuFlag()

return qiyuflag
end


