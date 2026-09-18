





local xgTeQuanInfo={}


function xgTeQuanInfo:__init(type,info)
self.updateEventList={}
self.removeEventList={}
self:init(info)

self:onInit()
self:onListenNotify()
end

function xgTeQuanInfo:__delete()
self:stopUpdate()
self:onRemoveNotify()
self:onDelete()

self.data=nil
end

function xgTeQuanInfo:init(info)
self.data=info
self.baseData={
xgid=self.data.xgid,
tqid=self.data.tqid,
tqtype=self.data.tqtype,
}
self.data.isActiveTeQuan=xianguanConfig.checkIsActiveTeQuan(self.data.tqid)

self:checkUpdateList()
end

function xgTeQuanInfo:updateInfo(info)
self:init(info)

self:onInit()
end

function xgTeQuanInfo:update()
if next(self.updateEventList)then
for key,data in pairs(self.updateEventList)do
if data.func(self)then
self.removeEventList[#self.removeEventList+1]=key
end
end

if#self.removeEventList>0 then
for index,key in ipairs(self.removeEventList)do
self.updateEventList[key]=nil
end

table.clear(self.removeEventList)
self:checkFreshUpdate()
end
end
end



function xgTeQuanInfo:onInit()

end


function xgTeQuanInfo:onDelete()

end


function xgTeQuanInfo:onListenNotify()

end


function xgTeQuanInfo:onRemoveNotify()

end

function xgTeQuanInfo:onCheckUpdateList()

end







function xgTeQuanInfo:getConfig(...)
return cfgHelper.get(cfg_xianguanprivilegeconfig_get,self.data.tqid,...)
end


function xgTeQuanInfo:getBaseInfo()
return self.baseData
end


function xgTeQuanInfo:getCd()
return self.data.cd or 0
end

function xgTeQuanInfo:getTimes()
return self.data.times or 0
end

function xgTeQuanInfo:getLeftTimes()
local maxTimes=self:getMaxTimes()
return math.max(0,maxTimes-self:getTimes())
end

function xgTeQuanInfo:getMaxTimes()
if self.maxTimes==nil then
self.maxTimes=xianguanConfig.getTeQuanCfg(self.data.tqid,'times')or-1
end
if self.maxTimes==-1 then return 0 end
return self.maxTimes
end



function xgTeQuanInfo:onClickUseBtn(callback)
local useJumpArgs=self:getConfig("useJump")
if useJumpArgs then

self:jumpUseWinEx(useJumpArgs,callback)
else

self:use()
end
end
function xgTeQuanInfo:jumpUseWin(callback)
local useJumpArgs=self:getConfig("useJump")
if useJumpArgs then
local args=table.weakCopy(useJumpArgs.args)or{}
args.baseData=self.baseData
jumpManager:jump({id=useJumpArgs.id,args=args},callback)
end
end

function xgTeQuanInfo:jumpUseWinEx(useJumpArgs,callback)
if self:checkUseCondition()then
local args=table.weakCopy(useJumpArgs.args)or{}
args.baseData=self.baseData
jumpManager:jump({id=useJumpArgs.id,args=args},callback)


UIManager:closeWindow("UIXianGuanTeQuanWin")
end
end



function xgTeQuanInfo:use(args)
args=args or{}
if self:checkUseCondition(args)then
xianguanController.sendUsePrivilege(self.data.xgid,self.data.tqid,args.exInfoJsonStr)
return true
end
return false
end



function xgTeQuanInfo:checkUseCondition(args)
local isCanuse=xianguanHelper.checkTeQuanUseCondition(self.data.xgid,self.data.tqid,true)
return isCanuse
end



function xgTeQuanInfo:resetData()
self:resetUseCount()
self:resetUseCD()
end


function xgTeQuanInfo:resetUseCount()
self.data.times=0
end


function xgTeQuanInfo:resetUseCD()
local clear=self:getConfig("clear")
if clear then
self.data.cd=0
end
end


function xgTeQuanInfo:checkInCd()
local curTime=timeHelper.getServerShortTime()
local cd=self.data.cd

return cd>curTime
end

function xgTeQuanInfo:getCdLeft()
local curTime=timeHelper.getServerShortTime()
return self.data.cd-curTime
end


function xgTeQuanInfo:checkUseTimes()
local times=xianguanConfig.getTeQuanCfg(self.data.tqid,'times')or 0
local usedTimes=self.data.times
return usedTimes>=times
end


function xgTeQuanInfo:checkInWait()
return false
end


function xgTeQuanInfo:getWaitDesc()
return""
end


function xgTeQuanInfo:getState()
local _,stateId=xianguanHelper.checkTeQuanUseCondition(self.data.xgid,self.data.tqid,false)
return stateId
end

function xgTeQuanInfo:checkUpdateList()
self:checkTimesUpdate()

self:onCheckUpdateList()
end

function xgTeQuanInfo:checkTimesUpdate()
if self:checkInCd()then
self:addUpdateEvent("updateCd",self.checkUpdateTimes)
end
end

function xgTeQuanInfo:checkUpdateTimes()
if not self:checkInCd()then
notifySystem:postNotify(notifyConfig.onTeQuanInfoChange,self.data)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGuanTeQuan)
end
end


function xgTeQuanInfo:startUpdate()
if self:checkUpdate()then
xianguanController:pushUpdateTqObj(self)
end
end

function xgTeQuanInfo:stopUpdate()
xianguanController:removeUpdateTqObj(self)
end


function xgTeQuanInfo:checkUpdate()
return true
end

function xgTeQuanInfo:addUpdateEvent(key,func)
self.updateEventList[key]={key=key,func=func}
end

function xgTeQuanInfo:checkFreshUpdate()
if next(self.updateEventList)then
self:startUpdate()
else
self:stopUpdate()
end
end


local fileLookup={}









function new_xgTeQuanInfo(type,gameInfo)

local newT={}
local mT={
__index=xgTeQuanInfo,
}
setmetatable(newT,mT)

local luaname=cfgHelper.get2(cfg_xianguanprivilegegroupconfig_get,type,'luaName')
if luaname then
local child=fileLookup[type]
local filename=FMT.fmt('lua.gamesys.xianguanSystem.xianguanTeQuan.{0}',luaname)
if child==nil then
child=require(filename)
fileLookup[type]=child
end
if child==nil then



end
if child then
for k,v in pairs(child)do
newT[k]=v
end
end
end
newT:__init(type,gameInfo)

return newT
end

function remove_xgTeQuanInfo(obj)
obj:__delete()
end
