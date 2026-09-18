
local xianjie_RecordData
local tc_jieshuData
local tc_jieshuLimitData
local tc_jishaData
local tc_MJ_jieshuData_state
xianjie_RecordType=
{
eSpecial=1,
eXianyou=2,
eEnemy=3,
}
xianjie_RecordName=
{
[0]="全部",
[1]="特殊",
[2]="仙友",
[3]="敌人",
}
xianjie_Point_Share=
{
kongdi=1,
zongmen=2,
mowu=3,
caijidian=4,
lingmai=5,
dhcaijidian=6,
xianmeng=7,
miaoxingshanglv=8,
}

function xianjieController:onAppStart_exploration()

end

function xianjieController:onEnterState_exploration(isReconnet)
xianjie_RecordData={}
tc_jieshuData={}
tc_jieshuLimitData={}
tc_jishaData={}
tc_MJ_jieshuData_state={}
self:handleXJPointRecordData()
end

function xianjieController:onLeaveState_exploration(isReconnet)
xianjie_RecordData=nil
tc_jieshuData={}
tc_jieshuLimitData={}
tc_jishaData={}
tc_MJ_jieshuData_state={}
end


function xianjieController:cheakXianJieTaskbyTaskLine(tasklineid)
if not tasklineid then
return false
end
return 3000<=tasklineid and tasklineid<=5000
end


function xianjieController:cheakXianJieTaskbyTaskID(taskid)
if not taskid then
return false
end
local taskLine=cfgHelper.get2(cfg_taskconfig_get,taskid,"tasklineid")
if not taskLine then
return false
end
return 3000<=taskLine and taskLine<=5000
end




function xianjieController:allExplorationReddot()
local isreddot=false
return isreddot
end



function xianjieController:send_37_72(monster_type,stage,is_fairyland)
socketManager:send_37_72(monster_type,stage,is_fairyland)
end





function xianjieController:getXJPointRecordData()
return xianjie_RecordData
end

function xianjieController:setXJPointRecordData(data)
xianjie_RecordData=data
end
function xianjieController:handleXJPointRecordData()



local arr=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianjiePoints,'XJPointRecord',{})
self:setXJPointRecordData(arr)
end

function xianjieController:checkPointRecordKey(sceneType,gridX,gridZ)
if xianjie_RecordData then
for k,v in ipairs(xianjie_RecordData)do
if v[1]==sceneType and v[2]==gridX and v[3]==gridZ then
return v
end
end
end
return false
end

function xianjieController:addPointRecordData(sceneType,gridX,gridZ,name,specialtype,selftype,sharename,ishujian)
if not xianjie_RecordData then
xianjie_RecordData={}
end
local time=gameUtilityModel.getServerShortTime()
local temp=
{
[1]=sceneType,
[2]=gridX,
[3]=gridZ,
[4]=name,
[5]=specialtype,
[6]=time,
[7]=selftype,
[8]=sharename,
[9]=ishujian or false,
}
local oldlist=#xianjie_RecordData
table.insert(xianjie_RecordData,temp)
local newlist=#xianjie_RecordData

if newlist>oldlist then
UIManager.info("地点记录成功")

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianjiePoints,'XJPointRecord',xianjie_RecordData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianjiePoints)
end
end

function xianjieController:changePointRecordData(sceneType,gridX,gridZ,name,specialtype,selftype,sharename,ishujian,index)
if xianjie_RecordData and#xianjie_RecordData>0 then
local temp
for k,v in ipairs(xianjie_RecordData)do
if v[1]==sceneType and v[2]==gridX and v[3]==gridZ then
local time=gameUtilityModel.getServerShortTime()
temp=
{
[1]=sceneType,
[2]=gridX,
[3]=gridZ,
[4]=name,
[5]=specialtype,
[6]=time,
[7]=selftype,
[8]=sharename,
[9]=ishujian or false,
}
xianjie_RecordData[k]=temp
break
end
end

UIManager.info("记录信息修改成功")
UIManager:invokeUIMethod('UIXianJieRecAddWin','onCloseBtn')
UIManager:invokeUIMethod('UIXianJieRecordWin','onefreshxiugai',{index,temp})

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianjiePoints,'XJPointRecord',xianjie_RecordData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianjiePoints)
end
end

function xianjieController:deletePointRecordData(sceneType,gridX,gridZ,name,specialtype)
if xianjie_RecordData and#xianjie_RecordData>0 then
local isdelete=false
local temp
for k,v in ipairs(xianjie_RecordData)do
if v[1]==sceneType and v[2]==gridX and v[3]==gridZ then
temp=v
table.remove(xianjie_RecordData,k)
isdelete=true
break
end
end
if isdelete then

UIManager.info("地点记录已删除")
UIManager:invokeUIMethod('UIXianJieRecAddWin','onCloseBtn')
UIManager:invokeUIMethod('UIXianJieRecordWin','onefreshupdata',temp)

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianjiePoints,'XJPointRecord',xianjie_RecordData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianjiePoints)
end
end
end

function xianjieController:deleteManeyPointRecordData(list)
if xianjie_RecordData and#xianjie_RecordData>0 then
local newlist={}
for k,v in ipairs(xianjie_RecordData)do
local key=FMT.fmt("{0}_{1}_{2}",v[1],v[2],v[3])
local ishave=false
for i,j in pairs(list)do
if key==i then
ishave=true
break
end
end
if not ishave then
newlist[#newlist+1]=v
end
end
if newlist then
xianjie_RecordData=newlist

UIManager.info("地点记录已删除")
UIManager:invokeUIMethod('UIXianJieRecordWin','allfreshupdata')

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianjiePoints,'XJPointRecord',xianjie_RecordData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianjiePoints)
end
end
end


function xianjieController:getShareStr(data)
local contentStr
local params
if data.shareType<=6 then
contentStr=cfgHelper.getlang(FMT.fmt("xianjie_share_pos{0}",data.shareType))
elseif data.shareType==xianjie_Point_Share.miaoxingshanglv then
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local isSelfTeamFlag=data.isSelfTeamFlag
if isSelfTeamFlag==1 then
contentStr=baseCfg.shareSelfStr[1]
else
contentStr=baseCfg.shareStr[1]
end
local shipId=data.shipId
local shipCfg=shipId and cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)or nil
local shipName=shipCfg and shipCfg.name or"未知仙舟"
local actorIdStr=data.actorIdStr
params={data.shipGuidStr,shipName,actorIdStr}
end

local name_str=data.shareName
local sname=""









local sceneidx=xianjieModel:getSceneIndex(data.scenceType)
sname=xianjieController:getCrossServerNamebySCidx(sceneidx)

sname=toColorString(2,sname)
name_str=toColorString(2,name_str)
if contentStr~=nil then

local str
if params then
str=FMT.fmt(contentStr,name_str,data.x,data.y,sname,sceneidx,unpack(params))
else
str=FMT.fmt(contentStr,name_str,data.x,data.y,sname,sceneidx)
end
return str
else
return data.shareName
end
end

function xianjieController:getShareLTStr(data)
if not initProControl.isDoneLargeKFXJ()then
loggerUtil.logErrFMT("大跨服未初始化完成，获取分享超链接文本失败：{0}",serializeHelper.serialize(data))
return"【仙界分享加载中】"
end

local contentStr
local params
if data.shareType<=6 then
contentStr=cfgHelper.getlang(FMT.fmt("xianjie_share_pos{0}",data.shareType))
elseif data.shareType==xianjie_Point_Share.miaoxingshanglv then
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local isSelfTeamFlag=data.isSelfTeamFlag
if isSelfTeamFlag==1 then
contentStr=baseCfg.shareSelfStr[2]
else
contentStr=baseCfg.shareStr[2]
end
local shipId=data.shipId
local shipCfg=shipId and cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)or nil
local shipName=shipCfg and shipCfg.name or"未知仙舟"
local actorIdStr=data.actorIdStr
params={data.shipGuidStr,shipName,actorIdStr}
end

local _scenceType=xianjieModel:sceneIndex2SceneType(data.scenceType)
local name_str=data.shareName
local sname=""









local sceneidx=data.scenceType
sname=xianjieController:getCrossServerNamebySCidx(sceneidx)

sname=toColorString(2,sname)
name_str=toColorString(2,name_str)
if contentStr~=nil then

local str
if params then
str=FMT.fmt(contentStr,name_str,data.x,data.y,sname,sceneidx,unpack(params))
else
str=FMT.fmt(contentStr,name_str,data.x,data.y,sname,sceneidx)
end
return str
else
return data.shareName
end
end

function xianjieController:getCrossServerNamebySCidx(sceneIndex)
local sceneType=xianjieModel:sceneIndex2SceneType(sceneIndex)
local name=sceneType and cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,'name')or'未知仙域'

local cross_sid=xianjieModel:getXianYuCrossServerId(sceneIndex)
return cross_sid and loginModel:getCrossZoneName(cross_sid)or name
end


function xianjieController:getCrossServerNamebySeverId(severId)
return loginModel:getZoneName(severId,"未知仙域")
end


function xianjieController:testtttname(sceneIndex)
local a=xianjieController:getCrossServerNamebySCidx(sceneIndex)
UIManager.info(a)
end


function xianjieController:setMoJiejieshuData(len,arry)
if not tc_MJ_jieshuData_state then
tc_MJ_jieshuData_state={}
end
if len>0 and arry then
for k,v in pairs(arry)do
tc_MJ_jieshuData_state[v.param_1]=v.param_2
end
else
logErr("魔界--协议35-151下发 魔界阶段state 为空或0")
end
end
function xianjieController:getMoJiejieshuData(Mtype)
if tc_MJ_jieshuData_state then
return tc_MJ_jieshuData_state[Mtype]
end
end

function xianjieController:getMoJieMonsterMaxlevel(Mtype,flag)
local mjieshu=xianjieController:getMoJiejieshuData(Mtype)
if mjieshu and mjieshu>0 then
local cfg=cfg_fairylandrefreshstageconfig_get(Mtype)[mjieshu]
local maxlevel=cfg.MJmaxlevel
if maxlevel and maxlevel[flag]then
return 1,maxlevel[flag]
end
end
return 1,15
end


function xianjieController:setjieshuData(len,arry)
if not tc_jieshuData then
tc_jieshuData={}
end

if len>0 and arry then
for k,v in pairs(arry)do
tc_jieshuData[v.param_1]=v.param_2
end
else
logErr("仙界--协议35-2下发 参数6 阶段列表长度为0")
end

self:initJieShuLimitData()
end

function xianjieController:initJieShuLimitData()
if not tc_jieshuLimitData then
tc_jieshuLimitData={}
end

local zmMaxLevel=zongmenModel:getZongMenLimitLv()

for type,jieshu in pairs(tc_jieshuData)do
local cfg=cfgHelper.get(cfg_fairylandrefreshstageconfig_get,type)
for index,ccfg in ipairs(cfg)do
if ccfg.zmMaxLv then
if zmMaxLevel>=ccfg.zmMaxLv[1]then
tc_jieshuLimitData[type]=ccfg.sid
else
break
end
else
tc_jieshuLimitData[type]=ccfg.sid
end
end
end
end

function xianjieController:checkJieShuMax(Mtype,jieShu)
if tc_jieshuLimitData[Mtype]then
return jieShu>=tc_jieshuLimitData[Mtype]
end
return false
end

function xianjieController:getJieShuMax(Mtype)
if tc_jieshuLimitData[Mtype]then
return tc_jieshuLimitData[Mtype]
end
return 0
end


function xianjieController:getjieshuData(Mtype)
if tc_jieshuData then
if tc_jieshuLimitData[Mtype]then
return Mathf.Min(tc_jieshuData[Mtype],tc_jieshuLimitData[Mtype])
else
return tc_jieshuLimitData[Mtype]
end
end
end

function xianjieController:getjieshuAllData()
return tc_jieshuData
end


function xianjieController:changejieshuData(len,arry)
if tc_jieshuData then
if len>0 and arry then
for k,v in pairs(arry)do
v.param_3=tc_jieshuData[v.param_1]
tc_jieshuData[v.param_1]=v.param_2
end
end
end
end

function xianjieController:getMonsterMaxlevel(Mtype)
local mjieshu=xianjieController:getjieshuData(Mtype)
if mjieshu then
local cfg=cfg_fairylandrefreshstageconfig_get(Mtype)[mjieshu]
local maxlevel=cfg.maxlevel
if maxlevel then
return 1,maxlevel
end
end
return 1,5
end


function xianjieController:setJiShaData(len,arry)
if tc_jishaData then
if len>0 and arry then
for k,v in pairs(arry)do
if tc_jishaData[v.param_1]then
tc_jishaData[v.param_1][v.param_2]=v
else
tc_jishaData[v.param_1]={}
tc_jishaData[v.param_1][v.param_2]=v
end
end
end
end
end

function xianjieController:checkjieshudata()
if tc_jieshuData and next(tc_jieshuData)then
return true
end
return false
end

function xianjieController:getJiShaData(Mtype,jieduan)
if tc_jishaData then
if tc_jishaData[Mtype]then
return tc_jishaData[Mtype][jieduan]
end
end
return false
end

function xianjieController:getJiShaDatajsnum(Mtype,jieduan)
local data=xianjieController:getJiShaData(Mtype,jieduan)
if data then
return data.param_3 or 0
end
return 0
end

function xianjieController:getJiShaDatacdg(Mtype)
local mjieshu=xianjieController:getjieshuData(Mtype)
if mjieshu then
local cfg=cfg_fairylandrefreshstageconfig_get(Mtype)[mjieshu]
return cfg
else
local cfg=cfg_fairylandrefreshstageconfig_get(3)[1]
return cfg
end
end


function xianjieController:testprintjsdata()
if tc_jieshuData then

else

end
end

function xianjieController:testprintjssdata()
if tc_jishaData then

else

end
end


function xianjieController:checkExplorationWinPageOpen(page)
if page==6 then
return XingYuController.checkSysOpen(),"星域暂未开启"
end
return true
end


