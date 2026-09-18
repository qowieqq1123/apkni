







def_class("UIXianJieArenaAct_buffWin",UIWindowBase)









function UIXianJieArenaAct_buffWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.buffDescGroup=UIObject.get(self,2)
self.bgModel=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.arenaModel=UIObject.get(self,5)
self.arenaName=UIText.get(self,6)
self.xianyuName=UIText.get(self,7)
self.ruleBtn=UIButton.get(self,8)
self.timeText=UIText.get(self,9)
self.xjbjbtn=UIButton.get(self,10)
self.maxNumText=UIText.get(self,11)
self.xyRankRewardBtn=UIButton.get(self,12)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.xjbjbtn:setButtonClick(function()self:onXjbjbtn()end)

self.xyRankRewardBtn:setButtonClick(function()self:onXyRankRewardBtn()end)



end


function UIXianJieArenaAct_buffWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.buffDescGroup);self.buffDescGroup=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.arenaModel);self.arenaModel=nil;
_UIObject_release(self.arenaName);self.arenaName=nil;
_UIObject_release(self.xianyuName);self.xianyuName=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.xjbjbtn);self.xjbjbtn=nil;
_UIObject_release(self.maxNumText);self.maxNumText=nil;
_UIObject_release(self.xyRankRewardBtn);self.xyRankRewardBtn=nil;
end



















function UIXianJieArenaAct_buffWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieArenaAct_buffWin:__delete()
self:clearTimer()
self:unbindComponents()
end




function UIXianJieArenaAct_buffWin:onShow(argtable,afterOnloaded)
self.arenaId=argtable and argtable.arenaId
if not self.arenaId then
return self:onCloseClick()
end

if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5814,1,{},eAnimationID.stand)
end


xianJieArenaActController:reqGetXJArenaActData_arenaInfo(self.arenaId)

self:refresh(true)


if systemModel.isOpen(SYSTEM_DEFINE.eXianJieBiaoJi)then
self.xjbjbtn:setActive(false)
local actorid=playerModel:getActorID()
local pos=xianmengModel:getXMMemberPost(actorid)
if pos then
if pos==GUILD_POST_TYPE.gpAllyLeader or pos==GUILD_POST_TYPE.gpViceLeader then
self.xjbjbtn:setActive(true)
end
end
else
self.xjbjbtn:setActive(false)
end
end


function UIXianJieArenaAct_buffWin:onHide()
self:clearTimer()

end

function UIXianJieArenaAct_buffWin:refresh(isInit)

self:refreshMiddlePanel()


self:refreshRightPanel(isInit)


self:setStartTimeTimer()
end

function UIXianJieArenaAct_buffWin:refreshMiddlePanel()
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


local arenaData=xianJieArenaActModel:getArenaBuildData(self.arenaId)or{}
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
local xyNameStr
local hasOccupy=occupySceneIdx and occupySceneIdx~=0 or false
self.maxNumText:setActive(hasOccupy)
if hasOccupy then

xyNameStr=xianjieController:getCrossServerNamebySCidx(occupySceneIdx)

local cross_sid=loginModel:getCrossServerId()
local isSelfXianYu=occupyServerId==cross_sid
if isSelfXianYu then
xyNameStr=FMT.cfmt(FONT_COLOR.eGreenColor,xyNameStr)
else
xyNameStr=FMT.cfmt(FONT_COLOR.eRedColor,xyNameStr)
end

local maxOccupyCount_cfg=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"occupyMax")
local maxOccupyCount=pfwindowsModel:getVersionAndPfCfg_severPf(maxOccupyCount_cfg)
if maxOccupyCount<8 then
local nowOccupyCount=xianJieArenaActModel:getArenaBuildServerOccupyCount(cross_sid)
if nowOccupyCount>maxOccupyCount then
nowOccupyCount=maxOccupyCount
end

self.maxNumText:setText(FMT.fmt("占领演武台：{0}/{1}",nowOccupyCount,maxOccupyCount))
else

self.maxNumText:setActive(false)
end

else
xyNameStr="无"
end
self.xianyuName:setText(FMT.fmt("归属：{0}",xyNameStr))
end
end

function UIXianJieArenaAct_buffWin:refreshRightPanel(isInit)

local buffDescList_cfg=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"buffDescList")or{}
local buffDescList=pfwindowsModel:getVersionAndPfCfg_severPf(buffDescList_cfg)

local count=#buffDescList
self.buffDescGroup:setChildLayoutGroupCreateItems(count,function(index)
local widget=self.buffDescGroup:getChildLayoutGroupGridItem(index-1)
local buffDesc=buffDescList[index]or""
widget:SetChildText(-1,buffDesc)
end)
end

function UIXianJieArenaAct_buffWin:setStartTimeTimer()
self:clearTimer()
local func=function()
local actId=LIMIT_ACT_TYPE.eLeiTaiYanWu
local lerp=limitActivitiesModel:getActStartLeftTime(actId)or 0
if lerp>0 then

local timeStr=FMT.cfmt1(FONT_COLOR.eGreenColor,timeHelper.format_time_stamp16(lerp))
self.timeText:setText(FMT.fmt("（活动开启倒计时：{0}）",timeStr))
else
self.timeText:setText("活动已开启")
UIManager.error("活动已开启")
self:clearTimer()
return self:onCloseClick()
end
end
func()
self.timer=self:setTimer(1,0,func)
end

function UIXianJieArenaAct_buffWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UIXianJieArenaAct_buffWin:onClickMask()
self:onCloseClick()
end



function UIXianJieArenaAct_buffWin:onCloseBtn()
self:onCloseClick()
end

function UIXianJieArenaAct_buffWin:onCloseClick(atOnce)
xianjieController:closeWin('UIXianJieArenaAct_buffWin',atOnce)
end

function UIXianJieArenaAct_buffWin:onRuleBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eLeiTaiYanWu,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end

function UIXianJieArenaAct_buffWin:onXjbjbtn()
local _posx=self.sharex
local _posy=self.sharez
local _sceneidx=xianjieModel:getSceneIndex()
local cbid=xianjieController.getZuoBiaoType(7)
xianjieController.openBJwin(_posx,_posy,_sceneidx,cbid)
end

function UIXianJieArenaAct_buffWin:onXyRankRewardBtn()
self:showWindow("UIXianJieArenaAct_xyRankRewardWin")
end