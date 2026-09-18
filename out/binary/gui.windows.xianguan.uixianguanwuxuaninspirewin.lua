







def_class("UIXianGuanWuXuanInspireWin",UIWindowBase)









function UIXianGuanWuXuanInspireWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.commitBtn=UIButton.get(self,2)
self.costIcon=UIImage.get(self,3)
self.costNum=UIText.get(self,4)
self.costRoot=UIObject.get(self,5)
self.effectStr=UIText.get(self,6)
self.emptyList=UIObject.get(self,7)
self.limitTx=UIText.get(self,8)
self.numStr=UIText.get(self,9)
self.overBg=UIObject.get(self,10)
self.playerBG=UIButton.get(self,11)
self.playerCount=UIText.get(self,12)
self.playerHead=UIObject.get(self,13)
self.playerHeadIcon=UIImage.get(self,14)
self.playerList=UIObject.get(self,15)
self.playerName=UIText.get(self,16)
self.serverName=UIText.get(self,17)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.playerBG:setButtonClick(function()self:onPlayerBG()end)



end


function UIXianGuanWuXuanInspireWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.effectStr);self.effectStr=nil;
_UIObject_release(self.emptyList);self.emptyList=nil;
_UIObject_release(self.limitTx);self.limitTx=nil;
_UIObject_release(self.numStr);self.numStr=nil;
_UIObject_release(self.overBg);self.overBg=nil;
_UIObject_release(self.playerBG);self.playerBG=nil;
_UIObject_release(self.playerCount);self.playerCount=nil;
_UIObject_release(self.playerHead);self.playerHead=nil;
_UIObject_release(self.playerHeadIcon);self.playerHeadIcon=nil;
_UIObject_release(self.playerList);self.playerList=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.serverName);self.serverName=nil;
end















local _this=nil



function UIXianGuanWuXuanInspireWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(40,30,self.on_40_30)
self:addNotify(notifyConfig.onXianGuanJingXuanSegmentChange,self.onXianGuanJingXuanSegmentChange)

local cost=cfgHelper.get3(cfg_officerelectionbasic2config_get,1,"inspire_consume",1)
self.costIcon:setImageIcon(iconHelper.getIconName(cost[1]),false)
self.costNum:setText(mathHelper.formatNumber(cost[2]))
self.winlua:ForceLayoutRect(self.costNum:getID())
self.winlua:ForceLayoutRect(self.costRoot:getID())
end


function UIXianGuanWuXuanInspireWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGuanWuXuanInspireWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.job=argtable.job
self.playerIdx=argtable.playerIdx
self:refreshView()
end


function UIXianGuanWuXuanInspireWin:onHide()

end




function UIXianGuanWuXuanInspireWin:onCommitBtn()

local inspired_job,inspire_actor=xianguanModel:getWuXuanPlayerInspire()
if inspire_actor==0 and inspired_job==0 then
local cost=cfgHelper.get3(cfg_officerelectionbasic2config_get,1,"inspire_consume",1)
local func=function()
UIDialogManager.getCommonDialog(nil,"每位祖师每次武选只有一次鼓舞机会\n是否确定？",function()
xianguanController:send_40_28(self.job,self.playerIdx)
end)
end
if cost then
moneySystem:useMoney(cost[1],cost[2],func,WARNING_TYPE.eWarning)
else
func()
end
end
end


function UIXianGuanWuXuanInspireWin:onPlayerBG()
UIFullXJForceControl:showWuXuanTeamWin(self.job,self.playerIdx)
end

function UIXianGuanWuXuanInspireWin:onBackground()
self:onCloseBtn()
end

function UIXianGuanWuXuanInspireWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIXianGuanWuXuanInspireWin:refreshView()
self.data=xianguanModel:getWuXuanRegisterSingleData(self.job,self.playerIdx)
if self.data==nil then
loggerUtil.logErrFMT("没有对应记录参选玩家数据:{0},{1}",self.job,self.playerIdx)
return
end

playerController:setHeadIcon(self.winlua,self.playerHead:getID(),{iconInfo=self.data.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
self.serverName:setText(loginModel:getServerName(self.data.server_id))
self.playerName:setText(self.data.name)

local actorCnt=self.data.inspired_num
self.playerCount:setText(FMT.fmt("已有<color=#549327>{0}</color>人进行了鼓舞",actorCnt))
self.playerList:setChildLayoutGroupCreateItems(actorCnt,function(index)
local item=self.playerList:getChildLayoutGroupGridItem(index-1)
local actorData=self.data.inspired_data[index]
local serverName=loginModel:getServerName(actorData.param_1)
item:SetChildText(0,FMT.fmt("<size=20><color=#7d3b17>[{0}]</color></size>{1}进行了鼓舞",serverName,actorData.param_2))
end)
self.emptyList:setActive(actorCnt<=0)

local inspire_conf=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"inspire_conf")
local fzCfg=cfgHelper.getSSlawRule(inspire_conf[1])
local desc=fzCfg.desc
local descparm=fzCfg.descparm
if descparm then
if actorCnt>0 then
desc=string.format(desc,unpack(descparm[actorCnt]))
else
local params={}
for i=1,#descparm[1]do
table.insert(params,0)
end
desc=string.format(desc,unpack(params))
end
end
self.effectStr:setText(desc)

desc=FMT.fmt("已叠加{0}层",actorCnt)
if actorCnt>=inspire_conf[2]then
desc=FMT.fmt("{0}(已达上限)",desc)
end
self.numStr:setText(desc)

local inspired_job,inspire_actor=xianguanModel:getWuXuanPlayerInspire()
local segment=xianguanModel:getWuXuanActivitySegment()
local show=inspired_job==0 and inspire_actor==0
self.commitBtn:setActive(show and segment==XianGuanWuXuanSegment.eReady)
self.overBg:setActive(not show)
if not show then
local desc=inspired_job==self.job and inspire_actor==self.playerIdx and"已鼓舞该祖师"or"已鼓舞其他祖师"
self.limitTx:setText(desc)
end
end

function UIXianGuanWuXuanInspireWin.on_40_30(job)
if _this.job==job then
_this:refreshView()
end
end

function UIXianGuanWuXuanInspireWin.onXianGuanJingXuanSegmentChange(campaignType,oldSeg)
if campaignType==XianGuanCampaignType.eWuXuan then
local nowSeg=xianguanModel:getWuXuanActivitySegment()
if nowSeg==XianGuanWuXuanSegment.eReady or oldSeg==XianGuanWuXuanSegment.eReady then
_this:refreshView()
elseif nowSeg==XianGuanWuXuanSegment.eNone then
_this:onCloseBtn()
end
end
end