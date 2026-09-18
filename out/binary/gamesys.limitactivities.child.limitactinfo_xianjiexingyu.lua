









local limitActInfo_xianjiexingyu={name='limitActInfo_xianjiexingyu'}


function limitActInfo_xianjiexingyu:onInit()

end


function limitActInfo_xianjiexingyu:onStart()

end


function limitActInfo_xianjiexingyu:onUpdate()

end


function limitActInfo_xianjiexingyu:onDelete()

end


function limitActInfo_xianjiexingyu:onFinish()

end


function limitActInfo_xianjiexingyu:checkReddot()
return false
end


function limitActInfo_xianjiexingyu:jump(extraParams)
if extraParams and extraParams.limitActListWin then
jumpManager:jump({id=JUMP_TYPE.eXJTanChaPage,args={page=6}})
return
end
local xingyuList=XingYuModel:getXingYuIdList()
if not xingyuList then
logErr("limitActInfo_xianjiexingyu jump 没有 xingyuList")
return
end
for i,xyId in ipairs(xingyuList)do
local hasTeam=XingYuController.checkHasTeam(xyId)
if hasTeam then
XingYuController.req_35_102(xyId)
return
end
end
local fun=function()
XingYuController:openXYListWin(true,xingyuList[1],{listIndex=1})
end
local sceneType=xianjienSceneType.eXianJie
if xianjieModel:checkSceneType(sceneType)then
fun()
return
end
xianjieController:jumpXianJie(sceneType,{},fun)
end

function limitActInfo_xianjiexingyu:checkHideInWin()
if not XingYuController.checkSysOpen()then
return true
end
if not xianjieController:checkXianJieSystemOpen()then
return true
end

return self.actcfg.hideInWin
end

function limitActInfo_xianjiexingyu:checkCondition(isWarning)
if not XingYuController.checkSysOpen()then
if isWarning then
UIManager.error("星域玩法未开启")
end
return false
end
local actcfg=self.actcfg


local xychapterid=actcfg.xychapterid
if xychapterid~=nil then
local isStart=seasonController:checkSeasonStageBegined(0,xychapterid)
if not isStart then
local tips_str=FMT.fmt('重建仙域开启第{0}章后可参与',xychapterid)
if isWarning then
UIManager.error(tips_str)
end
return false,tips_str
end
end

local kfDay=limitActivitiesModel.getDayConditionCfg(actcfg)
if kfDay~=nil then

local openday=timeHelper.getServerOpenDay()
if openday<kfDay then
local fmt_str=self:getDayConditionStrFMT()
local tips_str=FMT.fmt(fmt_str,kfDay-openday)
if isWarning then
UIManager.error(tips_str)
end
return false,tips_str
end
end

local zmLevel=limitActivitiesModel.getZMLevelConditionCfg(actcfg)
if zmLevel~=nil then

local lv=zongmenModel:getLevel()
if lv<zmLevel then
local tips_str=FMT.fmt('宗门达到{0}级可参与',zmLevel)
if isWarning then
UIManager.error(tips_str)
end
return false,tips_str
end
end

return true
end

return limitActInfo_xianjiexingyu