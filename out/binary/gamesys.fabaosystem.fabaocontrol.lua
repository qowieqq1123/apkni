





fabaoControl=gameState.addListener({})


function fabaoControl:onAppStart()

notifySystem:listenNotify(notifyConfig.home_event,self.onEnterHome)
notifySystem:listenNotify(notifyConfig.home_event,self.onEnterHome)
end

function fabaoControl:onEnterState()
timeEventController.addSlowTimerHandler('fabaoControl',self)
fabaoModel:loadFabaoJiLianFilterIdx()

local reddotKeyList=benMingFaBaoSheetReddot.getKeyList()
for i,v in pairs(reddotKeyList)do
local itemguid=v.itemguid
local key=v.key

local func=function(...)
reddotControl.onBenMingFabaoReddotChange(itemguid)
end
fabaoControl.yunYangReddotFuncs[i]=key
reddotClassManager.register_event(key,func)
end
end

function fabaoControl:onLeaveState()
timeEventController.removeSlowTimerHandler('fabaoControl')
self.isProtocolReq=false
if fabaoControl.yunYangReddotFuncs then
for k,v in pairs(fabaoControl.yunYangReddotFuncs)do
reddotClassManager.unregister_event(k,v)
end
fabaoControl.yunYangReddotFuncs=nil
end
end

function fabaoControl:onProtocolReq()
fabaoModel:initBagData()
self.isProtocolReq=true
end

function fabaoControl:onSlowUpdate()
if not self.isProtocolReq then return end
fabaoModel:update()
end





function fabaoControl.freshLianzhiWindow(funcname,...)
UIManager:callWindowFunc('UIFabaoWin',funcname,...)
end

function fabaoControl.freshJilianWindow(funcname,...)
UIManager:callWindowFunc('UIFabaoJilianWin',funcname,...)
end

function fabaoControl.freshLianhuaWindow(funcname,...)
UIManager:callWindowFunc('UIFabaoLianhuaWin',funcname,...)
end

function fabaoControl.freshBuildingHUD(sfId,ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
if not bdData then return end
if not fabaoModel.isCanPrize(ubdId)then
buildingCDControl:addCDData(buildingCDType.lianqi,bdData)
else
buildingCDControl:removeCDData(buildingCDType.lianqi,ubdId)
end
hudControl:refreshBuildingStatusHUD(ubdId)
end