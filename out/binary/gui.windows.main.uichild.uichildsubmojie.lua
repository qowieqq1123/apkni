




UIChildSubMoJie=simple_class(UIChildObject)

local defaultIcon='button_zjmmojieweikaiqi'
local _this
local _children={
icon=0,
click=1,
iconNewbie=2,
clickNewbie=3,
lock=4,
lockTime=5,
lockScene=6,
}

function UIChildSubMoJie:onLoaded()

end

function UIChildSubMoJie:onShow(isInit)
if isInit then
_this=self
end

socketManager:addNotify(35,150,self.on_35_150)

local abname=mainConfig.getBundleName()
local iconname=defaultIcon
self:setChildCSImageSprite(_children.icon,abname,iconname)
self:setChildButtonClick(_children.click,function()
self:OnButtonClick()
end)

self:setChildActive(_children.clickNewbie,false)

self:refreshState()
end

function UIChildSubMoJie:OnButtonClick()
local seasonType=0
if not seasonController:checkSeasonHandleComplete(seasonType)then
local seasonName=seasonModel:getHandleConfig(seasonType,'name')
UIManager.error(FMT.fmt("未完成{0}，无法进入魔界",seasonName))
return
end

local enterData=xianjieModel:getMoJieEnterData()
local nowTime=timeHelper.getServerShortTime()
if enterData==nil or nowTime>=enterData.eTime then
UIManager.info("魔界已关闭")
UIManager:invokeUIMethod("UIMainSubEnterPanelWin","onMask")
return
end

if nowTime<enterData.sTime then
local leastTime=enterData.sTime-timeHelper.getServerShortTime()
UIManager.info(FMT.fmt("{0}后开放",timeHelper.format_time_stamp4(leastTime)))
return
end





local cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
local sceneType=xianjieModel:sceneIndex2SceneType(cfg.sceneidx)
xianjieController:jumpXianJie(sceneType,{triggerMojieSeasonStageBehavier=true})

UIManager:invokeUIMethod("UIMainSubEnterPanelWin","onMask")
end

function UIChildSubMoJie:release()
_this=nil
self:stopCDTick()
socketManager:removeNotify(35,150,self.on_35_150)
end

function UIChildSubMoJie:refreshState()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local nowTime=timeHelper.getServerShortTime()
if nowTime>=enterData.eTime then
self:setChildActive(_children.lock,true)
self:setText(_children.lockTime,"")
self:setText(_children.lockScene,"魔界已关闭")
self:stopCDTick()
elseif nowTime>=enterData.sTime then
self:setChildActive(_children.lock,false)
self:startCDTick(function()
local leastTime=enterData.eTime-timeHelper.getServerShortTime()
if leastTime<=0 then
self:refreshState()
end
end)
else
self:setChildActive(_children.lock,true)
local leastTime=enterData.sTime-timeHelper.getServerShortTime()
local timeStr=FMT.fmt("{0}后",timeHelper.format_time_stamp12(leastTime))
self:setText(_children.lockTime,timeStr)
local sceneType=cfgHelper.get2(cfg_devildomseasonconfig_get,enterData.sId,"sceneidx")
local sceneName=cfgHelper.get2(cfg_fairylandsceneidxconfig_get,sceneType,"name")
local sceneStr=FMT.fmt("<color=#f1ce78>{0}</color>开放",sceneName)
self:setText(_children.lockScene,sceneStr)
self:startCDTick(function()
local leastTime=enterData.sTime-timeHelper.getServerShortTime()
local timeStr=FMT.fmt("{0}后",timeHelper.format_time_stamp12(leastTime))
self:setText(_children.lockTime,timeStr)
if leastTime<=0 then
self:refreshState()
end
end)
end
return
end
self:setChildActive(_children.lock,true)
self:setText(_children.lockTime,"")
self:setText(_children.lockScene,"魔界已关闭")
self:stopCDTick()
end

function UIChildSubMoJie:startCDTick(onTick)
self:stopCDTick()
self.cdTick=timer.new()
self.cdTick:start(1,onTick)
end

function UIChildSubMoJie:stopCDTick()
if self.cdTick then
self.cdTick:cancel()
self.cdTick=nil
end
end

function UIChildSubMoJie.on_35_150()
_this:refreshState()
end