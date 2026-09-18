








function UIDiscipleModel:clearDaoYanData()
self.daoyanDiscipleList=nil
end

function UIDiscipleModel:setDiscipelDaoYanInit()
local disciplelist=UIDiscipleModel:getDaoYanDZList()
for i,v in ipairs(disciplelist)do
local netdata=v.netData.net
if UIDiscipleModel:checkOpenDaoYan(netdata)then
UIDiscipleController:reqDaoYanUnlock(netdata.discipleguid)
end
end
end

function UIDiscipleModel:checkOpenDaoYan(netData,isWarning)
isWarning=isWarning or false

if not UIDiscipleModel:checkShowDaoYan(netData,isWarning)then
return false
end

local daoyanUnlock=UIDiscipleModel:getDaoYanUnlockEx(netData)

if daoyanUnlock==1 then
return true
end

local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local tm_limit=cfgHelper.getdef(cfg_discipledaoyanconfig,"open_tianming_limit")

if tmlv<tm_limit then
if isWarning==true then
local errStr=FMT.fmt('弟子的天命达到{0}解锁',UIDiscipleModel.getTianMingLevelDesc(tm_limit))
UIManager.error(errStr)
end
return false
end

local jjlv=UIDiscipleModel:getDiscipleJJLevelEx(netData)
local jj_limit=cfgHelper.getdef(cfg_discipledaoyanconfig,"open_jingjie_limit")
if jjlv<jj_limit then
if isWarning==true then
local targetName=UIDiscipleModel:getJJNameEx(jj_limit)
local targetLevelName=FMT.cfmt(FONT_COLOR.eOrangeColor,targetName)
local errStr=FMT.fmt("弟子境界达到{0}后解锁",targetLevelName)
UIManager.error(errStr)
end
return false
end

return true
end

function UIDiscipleModel:checkShowDaoYan(netData,isWarning)

if not UIDiscipleModel:isDaoYanDZ(netData.discipleguid)then
if isWarning then
UIManager.error("该弟子未开启天命觉醒系统")
end
return false
end


if not systemModel.isOpen(SYSTEM_DEFINE.eTianMingJueXing)then
if isWarning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eTianMingJueXing)
UIManager.error(tips)
end
return false
end

return true
end

function UIDiscipleModel:checkReLockDaoYan(netData)
local daoyanUnlock=UIDiscipleModel:getDaoYanUnlockEx(netData)
local daoyanLevel=UIDiscipleModel:getDaoYanLevelEx(netData)

return daoyanUnlock==0 and daoyanLevel>0
end

function UIDiscipleModel:getDaoYanLevel(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDaoYanLevelEx(netData)
end

function UIDiscipleModel:getDaoYanLevelEx(netData)
return netData.daoyan_lv or 0
end

function UIDiscipleModel:getDaoYanUnlock(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDaoYanUnlockEx(netData)
end

function UIDiscipleModel:getDaoYanUnlockEx(netData)
return netData.daoyan_unlock or 0
end

function UIDiscipleModel.getDaoYanLevelFloor(dylv)
local chong=0
if dylv>0 then
chong=math.ceil(dylv/3)
elseif dylv==0 then
chong=1
end
local jie=UIDiscipleModel.getDaoYanLevelJie(dylv,chong)
return chong,jie
end

function UIDiscipleModel.getDaoYanLevelJie(dylv,chong)
local jie=0
if dylv>0 then
if dylv>=chong*3 then
jie=3
elseif dylv<=(chong-1)*3 then
jie=0
else
jie=(dylv-(chong-1)*3)%3
if jie==0 then
jie=3
end
end
elseif dylv==0 then
jie=0
end
return jie
end

function UIDiscipleModel.getDaoYanLevelDesc(dylv,typo)
local num1,num2=UIDiscipleModel.getDaoYanLevelFloor(dylv)
local levelNames=cfgHelper.getdef(cfg_discipledaoyanconfig,"levelNames")or{}
if typo==1 then
if dylv>0 then
return FMT.fmt('觉醒{0}重{1}阶',mathHelper.numberToChinese(num1),mathHelper.numberToChinese(num2))
else
return levelNames[0]and FMT.fmt('觉醒{0}',levelNames[0])or'觉醒一重'
end
elseif typo==2 then
if dylv>0 then
if levelNames[dylv]~=nil then
return FMT.fmt('天命觉醒：{0}',levelNames[dylv])
else
return FMT.fmt('天命觉醒：{0}重{1}阶',mathHelper.numberToChinese(num1),mathHelper.numberToChinese(num2))
end
else
return levelNames[0]and FMT.fmt('天命觉醒：{0}',levelNames[0])or'天命觉醒：一重'
end
else
if dylv>0 then
if levelNames[dylv]~=nil then
return levelNames[dylv]
else
return FMT.fmt('{0}重{1}阶',mathHelper.numberToChinese(num1),mathHelper.numberToChinese(num2))
end
else
return levelNames[0]or'一重'
end
end
end

function UIDiscipleModel:getUpDaoYanCosts(netData)
local dylv=UIDiscipleModel:getDaoYanLevelEx(netData)
local dzID=UIDiscipleModel:getDiscipleIDEx(netData)
return UIDiscipleModel:getUpDaoYanCostEx(dzID,dylv+1)
end

function UIDiscipleModel:getUpDaoYanCostEx(dzID,dylv)
if dylv==0 then
return nil
end
local attr=cfgHelper.get2(cfg_discipledaoyanconfig_get,dzID,"attr")
if not attr[dylv]then
return nil
end
return attr[dylv][2]
end


function UIDiscipleModel:getDaoYanDZList()
if self.daoyanDiscipleList~=nil then
return self.daoyanDiscipleList
end

local list_yes={}
local list_no={}
local discipleNetData=UIDiscipleModel:getAllDiscipleDataX()
if discipleNetData~=nil then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
if UIDiscipleModel:isDaoYanDZ(netData.discipleguid)then
if UIDiscipleModel:checkOpenDaoYan(netData)then
list_yes[#list_yes+1]=v
else
list_no[#list_no+1]=v
end
end
end
end

local list=list_yes
for index,v in ipairs(list_no)do
list[#list+1]=v
end

self.daoyanDiscipleList=list

return list
end


function UIDiscipleModel:addDaoYanDZ(data)
if not self.daoyanDiscipleList then
self.daoyanDiscipleList={}
end
local netData=data.netData.net
if UIDiscipleModel:isDaoYanDZ(netData.discipleguid)then
table.insert(self.daoyanDiscipleList,data)
end
end


function UIDiscipleModel:isDaoYanDZ(guid)
local dzid=UIDiscipleModel:getDiscipleID(guid)
local list=cfgHelper.get1(cfg_discipledaoyanconfig_get,dzid)
return list~=nil
end


function UIDiscipleModel:getDaoYanMaxLevel(guid)
local dzid=UIDiscipleModel:getDiscipleID(guid)
local attr=cfgHelper.get2(cfg_discipledaoyanconfig_get,dzid,"attr")
return#attr
end


function UIDiscipleModel:getDaoYanSkillByGuid(guid,idx)
local dzid=UIDiscipleModel:getDiscipleID(guid)
local list=cfgHelper.get2(cfg_discipledaoyanconfig_get,dzid,"skill")
if list==nil then return nil end
if not idx then
return list
end
return list[idx]
end


function UIDiscipleModel:getDaoYanAttrByGuid(guid,dylv)
if dylv==0 then
return defaultT
end
local dzid=UIDiscipleModel:getDiscipleID(guid)
local attr=cfgHelper.get2(cfg_discipledaoyanconfig_get,dzid,"attr")
if not attr[dylv]then
return defaultT
end
return attr[dylv][1]
end

function UIDiscipleModel:getIsFirstEnterDaoYan()
return userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'FirstEnterDaoYan',0)==0
end

function UIDiscipleModel:saveFirstEnterDaoYan()
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,'FirstEnterDaoYan',1,0)
end

function UIDiscipleModel:getIsFirstOpenDaoYanWin()
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'FirstOpenDaoYanWin',0)==0
return flag and NEWBIE_LUA_FUNC_TYPE["DiZiDaoYanFirstOpenFunc"]~=nil
end

function UIDiscipleModel:saveFirstOpenDaoYanWin()
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,'FirstOpenDaoYanWin',1,0)
end

function UIDiscipleModel:getIsCanShowUnlockDaoYanTips(guid)
local dzid=UIDiscipleModel:getDiscipleID(guid)
return not userActorSetting.get(FMT.fmt("ShowUnlockDaoYanTips_{0}",dzid),nil)
end

function UIDiscipleModel:saveShowUnlockDaoYanTips(guid)
local dzid=UIDiscipleModel:getDiscipleID(guid)
userActorSetting.set(FMT.fmt("ShowUnlockDaoYanTips_{0}",dzid),true)
userActorSetting.flush()
end


function UIDiscipleModel:getDiscipleDaoYanSkillBgEffectId(idx)
local arr={20685,20686,20687}
return arr[idx]
end

function UIDiscipleModel:getDiscipleDaoYanjieEffectId(idx)
local arr={20682,20683,20684}
return arr[idx]
end

function UIDiscipleModel:getDiscipleDaoYanDZJYEffectId(idx)
local arr={20695,20696,20697}
local arr2={20689,20690,20691}
return arr[idx],arr2[idx]
end



function UIDiscipleModel:getDiscipleDaoYanReddot(guid)
return UIDiscipleModel:getDiscipleDaoYanUpLevelReddot(guid)or
UIDiscipleModel:getDiscipleDaoYanUnLockReddot(guid)or
UIDiscipleModel:getDiscipleFirstOpenDaoYanWinReddot(guid)
end


function UIDiscipleModel:getDiscipleDaoYanUpLevelReddot(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if not netData then
return false
end

local isOpen=UIDiscipleModel:checkOpenDaoYan(netData)
if not isOpen then
return false
end

local costs=UIDiscipleModel:getUpDaoYanCosts(netData)
if not costs then
return false
end
for i,v in ipairs(costs)do
local itemid=v[1]
local needNum=v[2]

local hasNum=0
if itemsConfig.isMoney(itemid)then
hasNum=moneyModel.getMoney(itemid)
else
hasNum=bagModel.getItemCountById(itemid)
end
if hasNum<needNum then
return false,itemid,needNum
end
end

return true
end


function UIDiscipleModel:getDiscipleDaoYanUnLockReddot(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if not netData then
return false
end

local isOpen=UIDiscipleModel:checkOpenDaoYan(netData)
if not isOpen then
return false
end


local isCanShow=UIDiscipleModel:getIsCanShowUnlockDaoYanTips(guid)
if not isCanShow then
return false
end


local dylv=UIDiscipleModel:getDaoYanLevelEx(netData)
if dylv>0 then
return false
end

return true
end


function UIDiscipleModel:getDiscipleFirstOpenDaoYanWinReddot(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if not netData then
return false
end

local isOpen=UIDiscipleModel:checkOpenDaoYan(netData)
if not isOpen then
return false
end

return UIDiscipleModel:getIsFirstOpenDaoYanWin()
end

function UIDiscipleModel.getDaoYanFloorIcon(floor)
local iconName=cfgHelper.get2(cfg_discipledaoyanstageconfig_get,floor,'icon')
local abName=globalABLookup.diciplecolorframe
return abName,iconName
end

