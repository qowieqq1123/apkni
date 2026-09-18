







local _MODULENAME="strengthenController"
gameState.addListener(def_table(_MODULENAME))
strengthenController.name=_MODULENAME

strengthenFunctionType={
eFightLose=1,
}

strengthenJumpType={
edz_jingjie=1,
edz_lianti=2,
edz_equip=3,
edz_fabao=4,
eGuBap=5,
edz_gongfa=6,
edz_tianming=7,
}

local strengthenJumpHandle={
[strengthenJumpType.edz_jingjie]=function(params)
local disciples=strengthenController.getDiscipleList(params)
local disguid=strengthenController.getDiscipleByJumpType(strengthenJumpType.edz_jingjie,disciples)
strengthenController.jumpDiscipleWin(disguid,disciples,FULL_TAB_TYPE.eDiscipleInfo)
end,
[strengthenJumpType.edz_lianti]=function(params)
local disciples=strengthenController.getDiscipleList(params)
local disguid=strengthenController.getDiscipleByJumpType(strengthenJumpType.edz_lianti,disciples)
strengthenController.jumpDiscipleWin(disguid,disciples,FULL_TAB_TYPE.eDiscipleInfo)
end,
[strengthenJumpType.edz_equip]=function(params)
local disciples=strengthenController.getDiscipleList(params)
local disguid=strengthenController.getDiscipleByJumpType(strengthenJumpType.edz_equip,disciples)
strengthenController.jumpDiscipleWin(disguid,disciples,FULL_TAB_TYPE.eDiscipleEquip)
end,
[strengthenJumpType.edz_fabao]=function(params)
local disciples=strengthenController.getDiscipleList(params)
local disguid=strengthenController.getDiscipleByJumpType(strengthenJumpType.edz_fabao,disciples)
strengthenController.jumpDiscipleWin(disguid,disciples,FULL_TAB_TYPE.eDiscipleEquip)
end,
[strengthenJumpType.edz_gongfa]=function(params)
local disciples=strengthenController.getDiscipleList(params)
local disguid=strengthenController.getDiscipleByJumpType(strengthenJumpType.edz_gongfa,disciples)
strengthenController.jumpDiscipleWin(disguid,disciples,FULL_TAB_TYPE.eDiscipleSkill)
end,
[strengthenJumpType.eGuBap]=function()
UIFullGuBaoControl:showWindowCollect()
end,
[strengthenJumpType.edz_tianming]=function(params)
local disciples=strengthenController.getDiscipleList(params)
local disguid=strengthenController.getDiscipleByJumpType(strengthenJumpType.edz_tianming,disciples)
if disguid==nil then
disciples=UIDiscipleModel:getDiscipleWinList()
disguid=strengthenController.getDiscipleByJumpType(strengthenJumpType.edz_tianming,disciples)
end
strengthenController.jumpDiscipleWin(disguid,disciples,FULL_TAB_TYPE.eDiscipleTianMing)
end,
}

function strengthenController:clearData()
self.strengthenByMysteryLeaveData=nil
end

function strengthenController:onAppStart()
end
function strengthenController:onEnterState()
notifySystem:listenNotify(notifyConfig.on_mystery_quit_finish,strengthenController.on_mystery_quit_finish)
end
function strengthenController:onLeaveState()
notifySystem:removelistener(notifyConfig.on_mystery_quit_finish,strengthenController.on_mystery_quit_finish)
strengthenController:clearData()
end
function strengthenController:onPlayerCreate(...)
end
function strengthenController:onLostConnection()
end

function strengthenController:getStrengthenJumpList(funcType,checkOpen)
local result={}
local list=cfgHelper.get(cfg_strengthenfunctionconfig_get,funcType,'jumplist')
if list and#list>0 then
for i,v in ipairs(list)do
local cfg=cfgHelper.get1(cfg_strengthenjumpconfig_get,v)
local add=true
if checkOpen then
if cfg.system~=nil and not systemModel.isOpen(cfg.system)then
add=false
end
if cfg.zmLevel~=nil then
local lv=zongmenModel:getLevel()or 0
if lv<cfg.zmLevel[1]or lv>cfg.zmLevel[2]then
add=false
end
end
end
if add then
table.insert(result,cfg)
end
end
end
return result
end

function strengthenController:doJump(jumpType,params)
local handle=strengthenJumpHandle[jumpType]
if handle~=nil then
handle(params)
else



end
end



function strengthenController.getDiscipleList(params)
if params~=nil and params.disciples~=nil then
return params.disciples
end
return UIDiscipleModel:getDiscipleWinList()
end

function strengthenController.getDiscipleByJumpType(jumpType,disciples)
if jumpType==strengthenJumpType.edz_jingjie then
local dis_guid=nil
local jj_max=-1
local dis_guid_jj=nil
for i,v in ipairs(disciples)do
local netData=v.netData.net
local guid=netData.discipleguid
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
if jjlv>jj_max then
jj_max=jjlv
dis_guid_jj=guid
end
if UIDiscipleModel:checkJJReddot(guid)then
dis_guid=guid
break
end
end
if dis_guid~=nil then
return dis_guid
else
return dis_guid_jj
end
elseif jumpType==strengthenJumpType.edz_lianti then
local dis_guid=nil
local lt_max=-1
local dis_guid_lt=nil
for i,v in ipairs(disciples)do
local netData=v.netData.net
local guid=netData.discipleguid
local ltlv=UIDiscipleModel:getDiscipleLTLevel(guid)
if ltlv>lt_max then
lt_max=ltlv
dis_guid_lt=guid
end
if UIDiscipleModel:checkLTReddot(guid)then
dis_guid=guid
break
end
end
if dis_guid~=nil then
return dis_guid
else
return dis_guid_lt
end
elseif jumpType==strengthenJumpType.edz_equip then
local dis_guid=nil
local jj_max=0
local dis_guid_jj=nil
for i,v in ipairs(disciples)do
local netData=v.netData.net
local guid=netData.discipleguid
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
if jjlv>jj_max then
jj_max=jjlv
dis_guid_jj=guid
end
if equipsReddotHelper.checkDZAllEquipReddot(guid)then
dis_guid=guid
break
end
end
if dis_guid~=nil then
return dis_guid
else
return dis_guid_jj
end
elseif jumpType==strengthenJumpType.edz_fabao then
local dis_guid=nil
local jj_max=0
local dis_guid_jj=nil
for i,v in ipairs(disciples)do
local netData=v.netData.net
local guid=netData.discipleguid
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
if jjlv>jj_max then
jj_max=jjlv
dis_guid_jj=guid
end
if equipsReddotHelper.checkDZAFaBaoReddot(guid)then
dis_guid=guid
break
end
end
if dis_guid~=nil then
return dis_guid
else
return dis_guid_jj
end
elseif jumpType==strengthenJumpType.edz_gongfa then
local wlist={}
for i,v in ipairs(disciples)do
local netData=v.netData.net
local guid=netData.discipleguid
local w=0
for i=1,2 do
if UIDiscipleModel:getDiscipleSlotGFData(netData,i)==nil then
w=w+10
end
if UIDiscipleModel:checkDiscipleGFSlotCanUp(netData,i)then
w=w+1
end
end
w=w*1000
w=w+UIDiscipleModel:getDiscipleJJLevel(guid)
wlist[i]={w,guid}
end
if#wlist>1 then
table.sort(wlist,function(a,b)
return a[1]>b[1]
end)
end
local d=wlist[1]
if d~=nil then
return d[2]
end
elseif jumpType==strengthenJumpType.edz_tianming then
local dis_guid_reddot=nil
local tm_max=-1
local dis_guid_max=nil
for i,v in ipairs(disciples)do
local netData=v.netData.net
local guid=netData.discipleguid
local tmLv=UIDiscipleModel:getTianMingLevelEx(netData)
if tmLv>tm_max then
tm_max=tmLv
dis_guid_max=guid
end
if UIDiscipleModel:getDiscipleTianMingReddot(guid)then
dis_guid_reddot=guid
break
end
end
return dis_guid_reddot or dis_guid_max
end
return nil
end

function strengthenController.jumpDiscipleWin(disguid,dislist,tabType)
UIFullDiscipleMainControl:myShowWindow({dis_guid=disguid,disciplelist=dislist},tabType)
end




function strengthenController.on_mystery_quit_finish(fbid,finishType)
local data=strengthenController.strengthenByMysteryLeaveData
if data~=nil then
if fbid==data.fbid then
data.func()
end
strengthenController.strengthenByMysteryLeaveData=nil
end
end

function strengthenController:setMysteryLeaveFunc(fbid,jumpType,params)
local data={}
data.fbid=fbid
data.func=function()
strengthenController:doJump(jumpType,params)
end
strengthenController.strengthenByMysteryLeaveData=data
end

