







def_class("UIXianJie_cloudUnlockMapInfoWin",UIWindowBase)









function UIXianJie_cloudUnlockMapInfoWin:bindComponents()

self.descTxt=UIText.get(self,0)
self.info1obj=UIObject.get(self,1)
self.info2obj=UIObject.get(self,2)
self.mask=UIButton.get(self,3)
self.root=UIObject.get(self,4)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXianJie_cloudUnlockMapInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.info1obj);self.info1obj=nil;
_UIObject_release(self.info2obj);self.info2obj=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this


function UIXianJie_cloudUnlockMapInfoWin:onLoaded(...)
_this=self
self:bindComponents()
self.info1Widget=self.info1obj:getWidgetBase()
self.info2Widget=self.info2obj:getWidgetBase()
end


function UIXianJie_cloudUnlockMapInfoWin:__delete()
_this=nil
self:unbindComponents()
xianjieController:selectBlocks({})
end


function UIXianJie_cloudUnlockMapInfoWin:onHide()

end




function UIXianJie_cloudUnlockMapInfoWin:onShow(argtable,afterOnloaded)
self.cloudid=argtable.cloudid
self:refreshInfo()
local list=xianjieModel:getCloudLockList2(self.cloudid)
xianjieController:selectBlocks(list)
end

function UIXianJie_cloudUnlockMapInfoWin:onShowArgRecv(argtable)
self.cloudid=argtable.cloudid
self:refreshInfo()
end

function UIXianJie_cloudUnlockMapInfoWin:updateTime()
local cloudData=xianjieModel:getCloudData(self.cloudid)
if cloudData then
self:refreshTime(cloudData)
else
if self.mytimer~=nil then
self:stopTimerByID(self.mytimer)
self.mytimer=nil
end
end
end

function UIXianJie_cloudUnlockMapInfoWin:refreshTime(cloudData)
local info2Widget=self.info2Widget
local unlockTime=cloudData:getUnlockTime()
local curTime=gameUtilityModel.getServerShortTime2()
local lerp=unlockTime-curTime
if lerp>0 then
lerp=math.ceil(lerp)
local desc=FMT.fmt('剩余：{0}',timeHelper.format_time_stamp3(lerp))
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
_this:updateTime()
end)
end
info2Widget:SetChildText(1,desc)
else
if self.mytimer~=nil then
self:stopTimerByID(self.mytimer)
self.mytimer=nil
end
self:refreshInfo(true)
end
end

function UIXianJie_cloudUnlockMapInfoWin:refreshInfo(isStopTime)
local cloudid=self.cloudid

local cfg=cfgHelper.get1(cfg_fairylandcloudconfig_get,cloudid)
self.descTxt:setText(cfg.desc)

local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then
if cloudData:hasMsg()then
local canUnlock=cloudData:canUnlock()
self.info1obj:setActive(true)
self.info2obj:setActive(false)
local info1Widget=self.info1Widget

info1Widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onSearchBtn()
end,true)
info1Widget:SetChildText(1,'前往')

info1Widget:SetChildText(2,'')

info1Widget:SetChildText(3,FMT.fmt('仙雾：{0}',cfg.name))

info1Widget:SetChildActive(4,false)

info1Widget:SetChildActive(5,true)
info1Widget:SetChildText(5,canUnlock and"此片区域已探查完毕"or"似乎还有事情并未完成......")
else
self.info1obj:setActive(false)
self.info2obj:setActive(true)
local info2Widget=self.info2Widget
local netData=cloudData:getDZData()

local dzitem=info2Widget:GetChildWidgetBase(0)
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzitem,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,dzitem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzitem:SetChildCSImageSprite(3,globalABLookup.global,jobicon)

if isStopTime then
self:setTimer(1,1,function()
_this:refreshTime(cloudData)
end)
else
self:refreshTime(cloudData)
end
end
else
self.info1obj:setActive(true)
self.info2obj:setActive(false)
local info1Widget=self.info1Widget
local canSearch=xianjieModel:checkCloudCanSearch(cloudid)
local isOpen,tipsStr=xianjieController:checkSeardCloudOpen(cloudid,false)

info1Widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onSearchBtn()
end,true)
local btn_str=canSearch and'派遣'or'寻找仙雾'
info1Widget:SetChildText(1,btn_str)

if canSearch and isOpen then
local cloudEntData=xianjieModel:getCloudEntityData(cloudid)
local wayTime=cloudEntData:getBaseWayTime()
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
info1Widget:SetChildText(2,FMT.fmt('前往：{0}',time_str))
else
info1Widget:SetChildText(2,'')
end

info1Widget:SetChildText(3,FMT.fmt('仙雾·{0}',cfg.name))

info1Widget:SetChildActive(4,not canSearch or not isOpen)
info1Widget:SetChildText(4,not isOpen and tipsStr or"请先探查宗门周边仙雾")

info1Widget:SetChildActive(5,false)
end
end

function UIXianJie_cloudUnlockMapInfoWin:onSearchBtn()
local cloudid=self.cloudid
local cloudData=xianjieModel:getCloudData(cloudid)
local lookAtHeight=xianjieController:getLampLookAtCameraheight(25,1)
if not cloudData then
local canSearch=xianjieModel:checkCloudCanSearch(cloudid)
if canSearch then
local isOpen=xianjieController:checkSeardCloudOpen(cloudid,true)
if not isOpen then
return
end
if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end

local cloudEntData=xianjieModel:getCloudEntityData(cloudid)
local cloudPos=cloudEntData:getWorldPos()
local func=function()
xianjieController:openSeardCloudSelectDZ(cloudid)
end
xianjieController:lookAtPositionChangeHeight(cloudPos,lookAtHeight,0.2,func,DG.Tweening.Ease.Linear)

UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','closeMapInfoWin')
UIFullCloudUnlockMapControl:closeUI(true,true)
else

local cloudEntData=xianjieModel:findNearlyCloudEntity()
if cloudEntData then
UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','closeMapInfoWin')
local cloudid_=cloudEntData.cloudid
UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','setSelect',cloudid_,true)
UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','handleClickCloud',cloudid_)
else
UIManager.error('附近没有可探寻的云雾')
end
end
else
if cloudData:hasMsg()then
local canUnlock=cloudData:canUnlock()
if canUnlock then
local cloudEntData=xianjieModel:getCloudEntityData(cloudid)
local cloudPos=cloudEntData:getWorldPos()
local _fun=function()

xianjieModel:CloudjumpqiyuZY(cloudEntData.cloudid,cloudData.idx+1,cloudEntData)
end
xianjieController:lookAtPositionChangeHeight(cloudPos,lookAtHeight,0.2,_fun,DG.Tweening.Ease.Linear)
else
xianjieController:jumpOpenCloudQiYu(cloudid)
end

UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','closeMapInfoWin')
UIFullCloudUnlockMapControl:closeUI(true,true)
end
end
end

function UIXianJie_cloudUnlockMapInfoWin:onMask()
UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','closeMapInfoWin')
end