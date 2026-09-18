




UIFullLianDanFangControl=gameState.addListener(fullScreenUI.create())

function UIFullLianDanFangControl:onAppStart()
local function _showDanYaoWindow(...)self:showProductionWindow(...)end
local function _showDuJieXianDanWindow(...)self:showDuJieXianDanWindow(...)end

local function _initSendDanYaoPro(...)self:initSendDanYaoPro(...)end

local function _checkOpen2(...)return self:checkOpen2(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eDanYao,callback=_showDanYaoWindow,sendCallback=_initSendDanYaoPro,reddotType=REDDIT_SUB_TYPE.sDanFang,},
{tabType=FULL_TAB_TYPE.eDuJieXianDan,callback=_showDuJieXianDanWindow,checkOpen=_checkOpen2,reddotType=REDDIT_SUB_TYPE.sDuJieXianDan,},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eLiandan,
attachName={'entityId'}
}
self:initUI(args)
end


function UIFullLianDanFangControl:showProductionWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eDanYao
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDanYaoWin'},
viewArgs={['UIDanYaoWin']=argstable},
entityId=argstable.entityId,
}

self:showUI(args)
return true
end

function UIFullLianDanFangControl:showDuJieXianDanWindow(argstable)
argstable=argstable or{}

if argstable and argstable.entityId then
local bdData=zongmenModel:findBuildingByEntityId(argstable.entityId)
if bdData then
local ubdId=bdData.un_build_id
if jctjDuJieXianDanModel:isInRepairTime(ubdId)then
local currtime=gameUtilityModel.getServerShortTime()
local endtime=jctjDuJieXianDanModel:getRepairTime(ubdId)
UIManager.info(FMT.fmt('丹炉被天劫损毁，正在修复中（{0})',timeHelper.format_time_stamp(endtime-currtime,true)))
return false
end
end
end

local lianZhiEnt=jctjDuJieXianDanModel:getLianZhiBuild()
if lianZhiEnt then
local bdData=zongmenModel:getBuildingData(lianZhiEnt)
if bdData then
local ubdId=bdData.un_build_id
if jctjDuJieXianDanModel:isInRepairTime(ubdId)then
local currtime=gameUtilityModel.getServerShortTime()
local endtime=jctjDuJieXianDanModel:getRepairTime(ubdId)
UIManager.info(FMT.fmt('丹炉被天劫损毁，正在修复中（{0})',timeHelper.format_time_stamp(endtime-currtime,true)))
return false
end
end
end


local tabType=FULL_TAB_TYPE.eDuJieXianDan
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDuJieXianDanWin'},
viewArgs={['UIDuJieXianDanWin']=argstable},
entityId=argstable.entityId,
}
self:showUI(args)
return true
end

function UIFullLianDanFangControl:showDuJieXianDan()

local args={}
local lianZhiEnt=jctjDuJieXianDanModel:getLianZhiBuild()
if lianZhiEnt then
local bdData=zongmenModel:getBuildingData(lianZhiEnt)
if bdData and bdData.entityId then
args.entityId=bdData.entityId
end
end
if args.entityId==nil then
local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eLianDanFang,true,true,true,true)
if bdList==nil or#bdList<=0 then return false end
local td
for i,v in ipairs(bdList)do
local flag=UIDanYaoModel:getLianDanFlag(v.un_build_id)
if not flag then
td=v
break
end
end
if not td then
td=bdList[1]
end
args.entityId=td.entityId
end

if args.entityId==nil then
return false
end

local bdData=zongmenModel:findBuildingByEntityId(args.entityId)
if bdData then
local ubdId=bdData.un_build_id
if jctjDuJieXianDanModel:isInRepairTime(ubdId)then
local currtime=gameUtilityModel.getServerShortTime()
local endtime=jctjDuJieXianDanModel:getRepairTime(ubdId)
UIManager.info(FMT.fmt('丹炉被天劫损毁，正在修复中（{0})',timeHelper.format_time_stamp(endtime-currtime,true)))
return false
end
end

return UIFullLianDanFangControl:showDuJieXianDanWindow(args)
end

function UIFullLianDanFangControl:checkOpen2(attach)
local lianZhiEnt=jctjDuJieXianDanModel:getLianZhiBuild()
if lianZhiEnt and lianZhiEnt~=0 then
local bdData=zongmenModel:getBuildingData(lianZhiEnt)
if not bdData then
return false
end
end
return jctjDuJieXianDanModel:getLianZhiEndFlag()~=1 and systemModel.isOpen(SYSTEM_DEFINE.eDuJieXianDan)
end

function UIFullLianDanFangControl:initSendProductionPro()

end

function UIFullLianDanFangControl:initSendDanYaoPro()

end
