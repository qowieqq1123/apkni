







def_class("UIMoGongZhengDuoAct_buffWin",UIWindowBase)









function UIMoGongZhengDuoAct_buffWin:bindComponents()

self.arenaModel=UIObject.get(self,0)
self.arenaName=UIText.get(self,1)
self.bgModel=UIObject.get(self,2)
self.buffDescGroup=UIObject.get(self,3)
self.clickMask=UIButton.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.nextTimeText=UIText.get(self,6)
self.rankBtn=UIButton.get(self,7)
self.root=UIObject.get(self,8)
self.ruleBtn=UIButton.get(self,9)
self.xianyuName=UIText.get(self,10)
self.xjbjbtn=UIButton.get(self,11)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.xjbjbtn:setButtonClick(function()self:onXjbjbtn()end)



end


function UIMoGongZhengDuoAct_buffWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arenaModel);self.arenaModel=nil;
_UIObject_release(self.arenaName);self.arenaName=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.buffDescGroup);self.buffDescGroup=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.nextTimeText);self.nextTimeText=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.xianyuName);self.xianyuName=nil;
_UIObject_release(self.xjbjbtn);self.xjbjbtn=nil;
end



















function UIMoGongZhengDuoAct_buffWin:onLoaded(...)
self:bindComponents()
end


function UIMoGongZhengDuoAct_buffWin:__delete()
self:unbindComponents()
end




function UIMoGongZhengDuoAct_buffWin:onShow(argtable,afterOnloaded)
self.arenaId=argtable and argtable.arenaId
self.arenaId=self.arenaId or xjClientBuildType.flcbMoGong1


if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5814,1,{},eAnimationID.stand)
end


moGongZhengDuoActController:reqGetMoGongActData_arenaInfo(self.arenaId)

self:refresh(true)


end


function UIMoGongZhengDuoAct_buffWin:onHide()
self:clearTimer()
end

function UIMoGongZhengDuoAct_buffWin:refresh(isInit)

self:refreshMiddlePanel()


self:refreshRightPanel(isInit)



end

function UIMoGongZhengDuoAct_buffWin:refreshMiddlePanel()
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.arenaId)
if cfg then

local param=cfg.clientParam
local modelId=param.model
local scale=0.7
local offset={0,30}
self.arenaModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand)
self.arenaModel:setChildUIModelShowTargetOffset(offset[1]or 0,offset[2]or 0)


local nameStr=cfg.name or"未知擂台"
self.arenaName:setText(nameStr)
self.sharex=cfg.x
self.sharez=cfg.y


local arenaData=moGongZhengDuoActModel:getArenaBuildData(self.arenaId)

local xyNameStr
local hasOccupy=arenaData and arenaData.xmGuidStr~="0"or nil
if hasOccupy then
local xmGuid=xianmengModel:myXMGuildID()
local isSelf=xianmengModel:compareTwoGuildID(xmGuid,arenaData.xmGuid)
if isSelf then
xyNameStr=FMT.cfmt(FONT_COLOR.eGreenColor,arenaData.xmName)
else
xyNameStr=FMT.cfmt(FONT_COLOR.eRedColor,arenaData.xmName)
end
else
xyNameStr="无"
end
self.xianyuName:setText(FMT.fmt("归属：{0}",xyNameStr))
end
end

function UIMoGongZhengDuoAct_buffWin:refreshRightPanel(isInit)

local buffDescList=cfgHelper.get(cfg_mogongzhengduobaseconfig_get,1,"buffDescList")or{}

local count=#buffDescList
self.buffDescGroup:setChildLayoutGroupCreateItems(count,function(index)
local widget=self.buffDescGroup:getChildLayoutGroupGridItem(index-1)
local buffDesc=buffDescList[index]or""
widget:SetChildText(-1,buffDesc)
end)
end

function UIMoGongZhengDuoAct_buffWin:setStartTimeTimer()
self:clearTimer()
local func=function()
local actId=LIMIT_ACT_TYPE.eMoGongZhengDuo
local actInfo=limitActivitiesModel:getActInfo(actId)
local timeTxt=""
if actInfo then
local serverLongTime=timeHelper.getServerLongTime()
local startTime_l=actInfo.start_time_l
local endTime_l=actInfo.end_time_l
if startTime_l>serverLongTime then
local lerp=startTime_l-serverLongTime
local timeStr=FMT.cfmt1(FONT_COLOR.eGreenColor,timeHelper.format_time_stamp16(lerp))
timeTxt=FMT.fmt("（活动开启倒计时：{0}）",timeStr)
elseif serverLongTime>=startTime_l and serverLongTime<endTime_l then
local lerp=endTime_l-serverLongTime
local timeStr=FMT.cfmt1(FONT_COLOR.eGreenColor,timeHelper.format_time_stamp16(lerp))
timeTxt=FMT.fmt("（活动结束倒计时：{0}）",timeStr)
elseif serverLongTime>=endTime_l then
local nextStartTime_l=actInfo.n_start_time_l
local lerp=nextStartTime_l-serverLongTime
local timeStr=FMT.cfmt1(FONT_COLOR.eGreenColor,timeHelper.format_time_stamp16(lerp))
timeTxt=FMT.fmt("（下次活动开启：{0}）",timeStr)
end
else
self.timeText:setText("活动已开启")
UIManager.error("活动已开启")
self:clearTimer()
return self:onCloseClick()
end

self.timeText:setText(timeTxt)
end
func()
self.timer=self:setTimer(1,0,func)
end

function UIMoGongZhengDuoAct_buffWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UIMoGongZhengDuoAct_buffWin:onClickMask()
self:onCloseClick()
end



function UIMoGongZhengDuoAct_buffWin:onCloseBtn()
self:onCloseClick()
end

function UIMoGongZhengDuoAct_buffWin:onCloseClick(atOnce)
xianjieController:closeWin('UIMoGongZhengDuoAct_buffWin',atOnce)
end



function UIMoGongZhengDuoAct_buffWin:onRuleBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eLeiTaiYanWu,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end



function UIMoGongZhengDuoAct_buffWin:onXjbjbtn()
self:showWindow("UIMoGongZhengDuoAct_PreviewRewardWin")
end

function UIMoGongZhengDuoAct_buffWin:onRankBtn()
msgWinControl:addMsgWin(msgWinType.eMGZDRankBg,{page=1})
end
