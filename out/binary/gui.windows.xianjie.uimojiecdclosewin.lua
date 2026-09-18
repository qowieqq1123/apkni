







def_class("UIMoJieCDCloseWin",UIWindowBase)









function UIMoJieCDCloseWin:bindComponents()

self.background=UIButton.get(self,0)
self.cdTx=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.disciple=UIObject.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.monster=UIObject.get(self,5)
self.picture=UIImage.get(self,6)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIMoJieCDCloseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.disciple);self.disciple=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.monster);self.monster=nil;
_UIObject_release(self.picture);self.picture=nil;
end















local _this



function UIMoJieCDCloseWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMoJieCDCloseWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieCDCloseWin:onShow(argtable,afterOnloaded)
local enterData=xianjieModel:getMoJieEnterData()
local nowTime=timeHelper.getServerShortTime()
if enterData then
local config=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
self.seasonType=config.csid
local info=config.endWinArgs
local monsterInfo=info.monster
self.monster:setChildUIModelShowTarget(monsterInfo[1],monsterInfo[3],monsterInfo[2],eAnimationID.stand,false,false,0)
self.monster:setChildUIModelShowFlipX(monsterInfo[4]==1)
local netData=UIDiscipleModel:findSrcTypeDisciple(discipleSrcType.ePlot1)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(netData.discipleguid,false,1)
self.disciple:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,eAnimationID.stand,false,false,0)
local pictureInfo=info.picture
self.picture:setSprite(pictureInfo[1],pictureInfo[2])

self.cdTime=enterData.eTime
local leastTime=self.cdTime-nowTime
if leastTime>0 then
self.cdTx:setText(FMT.fmt("魔界结束倒计时：{0}",timeHelper.format_time_stamp3(leastTime)))
self:startCDTick()
xianjieModel:saveFinishPreview()
return
end
end
self:onCloseBtn()
end


function UIMoJieCDCloseWin:onHide()

end




function UIMoJieCDCloseWin:onBackground()
self:onCloseBtn()
end


function UIMoJieCDCloseWin:onCloseBtn()
self:closeSelf()
end

function UIMoJieCDCloseWin:onGotoBtn()
UIFullSeasonControl:openSeasonWindow(self.seasonType)
end

function UIMoJieCDCloseWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIMoJieCDCloseWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIMoJieCDCloseWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.cdTime-nowTime
self.cdTx:setText(FMT.fmt("魔界结束倒计时：{0}",timeHelper.format_time_stamp3(leastTime)))

if leastTime<0 then
self:onCloseBtn()
end
end