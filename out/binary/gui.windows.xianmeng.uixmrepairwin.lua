







def_class("UIXMRepairWin",UIWindowBase)









function UIXMRepairWin:bindComponents()

self.background=UIObject.get(self,0)
self.openTips=UIText.get(self,1)
self.progressTx=UIText.get(self,2)
self.commitList=UIObject.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.commitBtnFive=UIButton.get(self,5)
self.progress=UIProgress.get(self,6)
self.todayTx=UIText.get(self,7)
self.collected=UIObject.get(self,8)
self.commitBtnOne=UIButton.get(self,9)
self.icon=UIObject.get(self,10)
self.closeBtn=UIButton.get(self,11)
self.costList_1=UIObject.get(self,12)
self.destext=UIText.get(self,13)
self.commitInfo=UIObject.get(self,14)
self.jumpInfo=UIObject.get(self,15)
self.collectInfo=UIObject.get(self,16)
self.costList_2=UIObject.get(self,17)
self.title=UIText.get(self,18)
self.leftPanel=UIObject.get(self,19)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)





self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.costList={
self.costList_1,
self.costList_2,
}



end


function UIXMRepairWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.openTips);self.openTips=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.commitList);self.commitList=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.commitBtnFive);self.commitBtnFive=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.todayTx);self.todayTx=nil;
_UIObject_release(self.collected);self.collected=nil;
_UIObject_release(self.commitBtnOne);self.commitBtnOne=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costList_1);self.costList_1=nil;
_UIObject_release(self.destext);self.destext=nil;
_UIObject_release(self.commitInfo);self.commitInfo=nil;
_UIObject_release(self.jumpInfo);self.jumpInfo=nil;
_UIObject_release(self.collectInfo);self.collectInfo=nil;
_UIObject_release(self.costList_2);self.costList_2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
self.costList=nil;
end
















local _this=nil




function UIXMRepairWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)
end


function UIXMRepairWin:__delete()
notifySystem:removelistener(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)
self:unbindComponents()
_this=nil
if self.showMoney then
self:hideWindow('UITopMoneyWin')
end
end




function UIXMRepairWin:onShow(argtable,afterOnloaded)
self.data=argtable

self:onOpenView()
end


function UIXMRepairWin:onHide()

end




function UIXMRepairWin:onCloseBtn()
self:closeSelf()
end


function UIXMRepairWin:onGotoBtn()
local sfId=zongmenModel:getMountainId()
local bdData=zongmenModel:findBuildingDataByType(sfId,SLG_SYSTEM_TYPE.eXianMengDaDian)
isometricMapSystem:openBuildingWin(bdData)
end

function UIXMRepairWin:onCommitBtnOne()
local result=self:onCommitBtn(1)
if not result then

AudioManager.playBtnClick()
end
end

function UIXMRepairWin:onCommitBtnFive()
local result=self:onCommitBtn(5)
if not result then

AudioManager.playBtnClick()
end
end


function UIXMRepairWin:onCommitBtn(cnt)
if not self.open or self.interval then return end
local gatherCfg=cfgHelper.get2(cfg_guildbuildgatherconfig_get,self.data.id,0)
local collectData=xianmengModel:getRepairCollect(self.data.pos_idx)
if collectData then
if collectData.daily+cnt>gatherCfg.daily then
UIManager.error(FMT.fmt("今日次数不足{0}次",cnt))
return false
end
if collectData.collect_num+cnt>gatherCfg.times then
UIManager.error("提交进度超过总量")
return false
end
end














for i,v in ipairs(gatherCfg.gather)do
if not moneyModel.checkEnoughMoney(v[1],v[2]*cnt)then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(v[1])))
gainControl:showGainWin(v[1])
return false
end
end


self.interval=true
xianmengController:reqXMRepairCollect(self.data.mapId,self.data.id,self.data.pos_idx,cnt)
self:delayDo(0.5,function()
self.interval=false
end)





return true
end

function UIXMRepairWin:onOpenView()
local id=self.data.id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
self.config=cfg
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)

self.title:setText(cfg.name)
self.destext:setText(levelCfg.build_desc)
local repairModel=cfg.sp_ui_model and cfg.sp_ui_model[0]or cfg.repair_model[1]
local scale=isometricMapSystem:getModelScale(repairModel,true)
self.icon:setChildUIModelShowTarget(repairModel,scale,nil,eAnimationID.stand)














local gatherCfg=cfgHelper.get2(cfg_guildbuildgatherconfig_get,id,0)
local gatherCost=gatherCfg.gather

local showMoney={}
for i,v in ipairs(gatherCost)do
table.insert(showMoney,{v[1]})
end
self.showMoney=#showMoney>0
if self.showMoney then
self:showWindow('UITopMoneyWin',showMoney)
else
self:hideWindow('UITopMoneyWin')
end

for i,v in ipairs(self.costList)do
v:setChildLayoutGroupCreateItems(#gatherCost,function(index)
local costItem=v:getChildLayoutGroupGridItem(index-1)
local costData=gatherCost[index]
local costId=costData[1]
local costNum=costData[2]
local countStr=costNum>1 and mathHelper.formatNumber(costNum)or''
local showCountBG=costNum>1
local conf={itemid=costId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
costItem:SetBaseItemClickEvent(0,function(...)itemsComponentHelper.onItemClick(...)end)
costItem:SetChildPropData(0,prop)
end)
end
local gatherReward=gatherCfg.reward
local gatherProgress=gatherCfg.progress
self.commitList:setChildLayoutGroupCreateItems(#gatherReward+1,function(index)
local commitItem=self.commitList:getChildLayoutGroupGridItem(index-1)
if index<=#gatherReward then
local rewardData=gatherReward[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
commitItem:SetChildIcon(0,iconHelper.getIconName(rewardId),true)
commitItem:SetChildText(1,FMT.fmt("{0}：",moneyModel.getMoneyName(rewardId)))
commitItem:SetChildText(2,FMT.fmt("+{0}/次",rewardNum))
else

commitItem:SetChildText(1,"修复进度：")
commitItem:SetChildText(2,FMT.fmt("+{0}/次",gatherProgress))
end
end)

self.limitLv=zongmenControl:getMinNeedLevel(self.config,self.data.mapId)
local xmLv=xianmengModel:getXMLevel()
xmLv=xmLv or-1
self.open=self.limitLv<=xmLv
self:refreshInfo(gatherCfg)
end

function UIXMRepairWin:refreshInfo(cfg)
local gatherCfg=cfg or cfgHelper.get2(cfg_guildbuildgatherconfig_get,self.data.id,0)
self.jumpInfo:setActive(not self.open)
self.collectInfo:setActive(self.open)
if self.open then
local collectData=xianmengModel:getRepairCollect(self.data.pos_idx)

local cur=collectData and collectData.collect_num or 0
local max=gatherCfg.times
local finish=cur>=max
self.commitBtnOne:setActive(not finish)
self.commitBtnFive:setActive(not finish)
self.collected:setActive(finish)
cur=cur*gatherCfg.progress
max=max*gatherCfg.progress
local str=FMT.fmt("{0}/{1}",cur,max)
self.progress:setProgressValue(cur,max)
self.progress:setChildProgressText(str)


cur=collectData and collectData.daily or 0
max=gatherCfg.daily
if cur>=max then
cur=FMT.cfmt(FONT_COLOR.eRedColor,cur)
end
str=FMT.fmt("次数：{0}/{1}",cur,max)
self.todayTx:setText(str)
else

local str=FMT.fmt("仙盟等级达<color=#c82c2c>{0}级</color>解锁",self.limitLv)
self.openTips:setText(str)
end
end

function UIXMRepairWin:afterCollect(pos_idx,isSelf)
if self.open then
local gatherCfg=cfgHelper.get2(cfg_guildbuildgatherconfig_get,self.data.id,0)
local collectData=xianmengModel:getRepairCollect(self.data.pos_idx)

local cur=collectData and collectData.collect_num or 0
local max=gatherCfg.times
local finish=cur>=max
self.commitBtnOne:setActive(not finish)
self.commitBtnFive:setActive(not finish)
self.collected:setActive(finish)
cur=cur*gatherCfg.progress
max=max*gatherCfg.progress
local str=FMT.fmt("{0}/{1}",cur,max)
self.progress:setProgressValue(cur,max)
self.progress:setChildProgressText(str)

if cur>=max then
self:delayDo(1,function()
self:closeSelf()
end)
end

if isSelf then
cur=collectData and collectData.daily or 0
max=gatherCfg.daily
if cur>=max then
cur=FMT.cfmt(FONT_COLOR.eRedColor,cur)
end
str=FMT.fmt("次数：{0}/{1}",cur,max)
self.todayTx:setText(str)
end
end
end

function UIXMRepairWin:refreshCommitNum()
if self.open then
local gatherCfg=cfgHelper.get2(cfg_guildbuildgatherconfig_get,self.data.id,0)
local collectData=xianmengModel:getRepairCollect(self.data.pos_idx)
local cur=collectData and collectData.daily or 0
local max=gatherCfg.daily
if cur>=max then
cur=FMT.cfmt(FONT_COLOR.eRedColor,cur)
end
local str=FMT.fmt("次数：{0}/{1}",cur,max)
self.todayTx:setText(str)
end
end

function UIXMRepairWin.onXianMengLevelChange(oldlv,guildlevel,oldexp,guildexp)
if oldlv==guildlevel then return end
local xmLv=xianmengModel:getXMLevel()
xmLv=xmLv or-1
local open=_this.limitLv<=xmLv

if open~=_this.open then
_this.open=open
_this:refreshInfo()
end
end