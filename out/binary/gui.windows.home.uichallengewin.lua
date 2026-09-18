







def_class("UIChallengeWin",UIWindowBase)









function UIChallengeWin:bindComponents()

self.level=UIText.get(self,0)
self.desc=UIText.get(self,1)
self.scrollview=UIObject.get(self,2)
self.challengeBtn=UIButton.get(self,3)
self.tips=UIText.get(self,4)
self.unlockText=UILinkImageText.get(self,5)
self.icon=UIObject.get(self,6)
self.mbg1=UIObject.get(self,7)
self.mbg2=UIObject.get(self,8)
self.title=UIText.get(self,9)
self.name=UIText.get(self,10)
self.rewardTitle=UIObject.get(self,11)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)



end


function UIChallengeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.mbg1);self.mbg1=nil;
_UIObject_release(self.mbg2);self.mbg2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.rewardTitle);self.rewardTitle=nil;
end
















local _this




function UIChallengeWin:onLoaded(...)
self:bindComponents()

_this=self

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
notifySystem:listenNotify(notifyConfig.onZongMenAreaUnLock,self.on_area_unlock)
end


function UIChallengeWin:__delete()
notifySystem:removelistener(notifyConfig.onZongMenAreaUnLock,self.on_area_unlock)

_this=nil

self:unbindComponents()
end

function UIChallengeWin.on_area_unlock(sfId,areaId)
local id=_MapManager.GetAreaIDByObject(_this.data.guid)
if areaId==id then
_this:refresh()
end
end




function UIChallengeWin:onShow(argtable,afterOnloaded)
self.data=argtable
self:refresh()
end

function UIChallengeWin:refresh()
if self.data.externalData then
local modelData=self.data.externalData.modelData
local rewards=self.data.externalData.rewards
self.icon:setChildUIModelShowTarget(modelData.model,modelData.scale,nil,eAnimationID.stand)
self.rewards:setChildLayoutGroupCreateItems(#rewards)
local items=self.rewards:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local data=rewards[i+1]



widgetHelper.setNormalRewardItem(item,0,data,true)
end
else
local id=self.data.id
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,id)
self.name:setText(cfg.name)
local descStr=cfg.desc
local scale=isometricMapSystem:getModelScale(cfg.model[1],true)
local modelParam=cfg.modeloffset or{0,0,1}
scale=scale*modelParam[3]
self.icon:setChildUIModelShowTarget(cfg.model[1],scale,cfg.model[2],eAnimationID.stand)
self.icon:setChildUIModelShowTargetOffset(modelParam[1],modelParam[2])

local uidiff=cfg.ui_diff
self.mbg1:setActive(not uidiff or uidiff.modelBG==1)
self.mbg2:setActive(uidiff and uidiff.modelBG==2)

local monTeamId=cfg.rewards_conf.monTeamId
local mcfg=cfgHelper.get1(cfg_monstergroup_get,monTeamId)
local level=mcfg.level
if mcfg.levelUp then
level=self.data.level or level
end
local n,p,pN=UIDiscipleModel:getJJNameX(level)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('境界：{0}{1}',n,pN)
else
jj_str=FMT.fmt('境界：{0}',n)
end
self.level:setText(jj_str)

if not descStr then
descStr=mcfg.desc
end
self.desc:setText(descStr)

local rewards
local drops=mcfg.drops
local actRewards=worldFightModel:getMonsterExtraDropActReward(monTeamId)
if drops then
rewards={}
for i,rwId in ipairs(drops)do
local temp=zongmenControl:getRewardConfigData(rwId,level)
rewards=table.concatTableX(rewards,temp)
end
end
if rewards==nil then
local rewardid=cfg.rewards_conf.rewardid
if rewardid then
local rwId
if type(rewardid)=='table'then
rwId=rewardid[self.data.areaId]
else
rwId=rewardid
end
rewards=zongmenControl:getRewardConfigData(rwId,level)
else
rewards={}
end
end

local maxLen=5
local actRewardCount=#actRewards
local len=math.min(#rewards+actRewardCount,maxLen)
local showNormalItemCount=len-actRewardCount
if showNormalItemCount<0 then
showNormalItemCount=0
end
self.rewardTitle:setActive(len>0)
self.scrollview:setChildScrollViewCreateGrids(len,len)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local data=rewards[i+1]
local isActReward=false
if i+1>showNormalItemCount then
data=actRewards and actRewards[i+1-showNormalItemCount]
isActReward=true
end
local item=grids[i]
local stage
if not moneyConfig.isMoney(data[1])then
local rcfg=itemsConfig.getConfig(data[1])
stage=rcfg.stage
end

local itemShowCount=data.showCount or data[2]
widgetHelper.setNormalRewardItem(item,0,{data[1],itemShowCount,shwoSmallSign=true,stage=stage,range=data.range,isShowGailv=data[2]==-1})
end
end

local isUnlock,isFind=isometricMapSystem:isInUnlockArea(self.data.guid)

if not isFind then
isUnlock=true
end
self.challengeBtn:setActive(isUnlock)
self.tips:setActive(not isUnlock)
self.unlockText:setActive(not isUnlock)
if not isUnlock then
local areaId=self.data.areaId
local acfg=cfgHelper.get1(cfg_monijyareaconfig_get,areaId)
self.tips:setText(FMT.fmt('解锁{0}后可挑战',acfg.name))
self.unlockText:setText(FMT.fmt(cfgHelper.getlang('repair_link_text'),areaId))
end
end


function UIChallengeWin:onHide()

end





function UIChallengeWin:onChallengeBtn()
if isometricMapSystem:checkMonsterAIRecord(self.data.guid)then
UIManager.error("宗门弟子正在前往降妖，请祖师稍等片刻")
elseif not isometricMapSystem:getSundries(self.data.guid)then
UIManager.error("宗门弟子已降妖")
else
if self.data.externalData then
if self.data.externalData.func then
self.data.externalData.func()
end
else
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,self.data.id)
local rewards_conf=cfg.rewards_conf
local mcfg=cfgHelper.get(cfg_monstergroup_get,rewards_conf.monTeamId)


local serverGuid=self.data.serverGuid
local editorTeam=rewards_conf.editorTeam==nil or rewards_conf.editorTeam==true
local setteamlist_nil=rewards_conf.setteamlist_nil==true
fightController.showPrepareWin(fightPreSelectModel.fightType.zongmenMonster,
{
enterTxt='宗门',
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=true,
monsterList=mcfg.monList,
groupId=rewards_conf.monTeamId,
editorTeam=editorTeam,
setteamlist_nil=setteamlist_nil,
enterCallBack=function(guidList,zfId)
local id=zongmenModel:getMountainId()



fightLaunchController:sendFight(eBattleLaunch.zongmenMonster,guidList,mcfg.mapId or 0,zfId,{id,serverGuid})

end
}
)
end
end
self:closeSelf()
end

function UIChallengeWin:onClickClose()
self:closeSelf()
end