







def_class("UIXianJieExtra_ZTMJunTipsWin",UIWindowBase)









function UIXianJieExtra_ZTMJunTipsWin:bindComponents()

self.gridContent=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.ScrollView=UIObject.get(self,2)



end


function UIXianJieExtra_ZTMJunTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gridContent);self.gridContent=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end
















local _this
local _abname="ui/windows/mojiemojun/mojiemojun_atlas_pak.ab"




function UIXianJieExtra_ZTMJunTipsWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onXianJieMoJunAddEffect,self.onXianJieMoJunAddEffect)
end


function UIXianJieExtra_ZTMJunTipsWin:__delete()
self:unbindComponents()
self:clearTimer()
_this=nil
end

function UIXianJieExtra_ZTMJunTipsWin.onXianJieMoJunAddEffect()
_this:refreshEffect()
end




function UIXianJieExtra_ZTMJunTipsWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable and argtable.parentWin

self:refresh()
self:refreshEffect()
end


function UIXianJieExtra_ZTMJunTipsWin:onHide()

end

function UIXianJieExtra_ZTMJunTipsWin:refreshEffect()
local nowTime=timeHelper.getServerShortTime()
self.info=xianjieModel:getMoJunSeasonStages()
local seasonType=self.info[1]
local stageIndex=self.info[2]
self.effList=xianjieModel:getMoJunEffectList(seasonType,stageIndex)
self.fenshenData={}
local fenshenList=xianjieModel:getMoJunFenShenEffectDatas()
for i=1,#fenshenList do
local fsdata=fenshenList[i]
self.fenshenData[fsdata.idx]=fsdata
table.insert(self.effList,fsdata.idx)

end
local effLen=#self.effList
if effLen>0 then
table.sort(self.effList,function(a,b)
local data1
if a<0 then
data1=_this.fenshenData[a]
else
data1=xianjieModel:getMoJunEffectRange(seasonType,stageIndex,a)
end

local data2
if b<0 then
data2=_this.fenshenData[b]
else
data2=xianjieModel:getMoJunEffectRange(seasonType,stageIndex,b)
end
return data1.startTime>data2.startTime
end)
end
self.ScrollView:setActive(effLen>0)
if effLen>0 then
self.gridContent:setChildLayoutGroupCreateItems(effLen,function(index)
local widget=self.gridContent:getChildLayoutGroupGridItem(index-1)
local effIdx=self.effList[index]
local data
if effIdx<0 then
data=self.fenshenData[effIdx]
else
data=xianjieModel:getMoJunEffectRange(seasonType,stageIndex,effIdx)
end
local cfg=cfg_seasonmojuneffectconfig_get(data.confid)

local lerp=data.endTime-nowTime
widget:SetChildActive(-1,lerp>=0)
if lerp>=0 then

local bgImg=cfg.addType==1 and"image_ztmj_04"or"image_ztmj_03"
local typeImg=cfg.addType==1 and"image_ztmj_08"or"image_ztmj_07"
widget:SetChildCSImageSprite(0,_abname,bgImg)
widget:SetChildCSImageSprite(1,_abname,cfg.icon)
widget:SetChildCSImageSprite(4,_abname,typeImg)
widget:SetChildText(2,cfg.name)
widget:SetChildText(3,timeHelper.format_time_stamp3(lerp))
widget:SetChildButtonClick(0,function()
local pos=xianjieController:getCameraPosition()
local cameraY=pos.y
if effIdx<0 then
local zmData=xianjieModel:getMyZongMenData()
local lookAtPos=zmData:getWorldPos()
xianjieController:lookAtPosition(lookAtPos,cameraY,0.3,nil,DG.Tweening.Ease.InQuart)
local winParams={
seasonType=seasonType,
stageIndex=stageIndex,
confid=data.confid,
}
UIManager:showWindow("UIMoJieMoJunAreaEffectTipsWin",winParams)
else
local lookAtPos=data:getWorldPos()
xianjieController:lookAtPosition(lookAtPos,cameraY,0.3,nil,DG.Tweening.Ease.InQuart)
local winParams={
seasonType=seasonType,
stageIndex=stageIndex,
confid=data.confid,
areaId=data.areaId,
idx=effIdx,
}
UIManager:showWindow("UIMoJieMoJunAreaEffectTipsWin",winParams)
end
end)
end
end)
if effLen<=2 then
self.root:setChildSizeDelta(241,88*effLen+10)
else
self.root:setChildSizeDelta(241,230)
end
else
self:onCloseBtn()
end
end

function UIXianJieExtra_ZTMJunTipsWin:refresh()
local mojunData=xianjieModel:getMoJunData()

if mojunData.timeType==2 then
self.timeType=mojunData.timeType
self.endTime=mojunData.endTime

self:setRemainingTimeTimer()
else
self:clearTimer()
end
end



function UIXianJieExtra_ZTMJunTipsWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=timeHelper.getServerShortTime()
local lerp=self.endTime-nowTime
if lerp>0 then
if self.effList~=nil and next(self.effList)~=nil then
local hasRefresh=false
for i=1,#self.effList do
local effIdx=self.effList[i]
if effIdx~=nil then
local widget=self.gridContent:getChildLayoutGroupGridItem(i-1)
local data
if effIdx<0 then
data=self.fenshenData[effIdx]
else
data=xianjieModel:getMoJunEffectRange(self.info[1],self.info[2],self.effList[i])
end

if data and data.endTime~=nil then
local lerp2=data.endTime-nowTime
widget:SetChildActive(-1,lerp2>=0)
if lerp2>=0 then
widget:SetChildText(3,timeHelper.format_time_stamp3(lerp2))
end
else
hasRefresh=true
end
else
hasRefresh=true
end
end
if hasRefresh then
self:refreshEffect()
end
end
else
self:clearTimer()
self:onCloseBtn()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UIXianJieExtra_ZTMJunTipsWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end



function UIXianJieExtra_ZTMJunTipsWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end
