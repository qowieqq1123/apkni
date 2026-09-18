







def_class("UIEmergenciesMonsterWin",UIWindowBase)









function UIEmergenciesMonsterWin:bindComponents()

self.monster=UIObject.get(self,0)
self.level=UIText.get(self,1)
self.desc=UIText.get(self,2)
self.rewardScrollview=UIObject.get(self,3)
self.challengeBtn=UIButton.get(self,4)
self.name=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseClick()end)



end


function UIEmergenciesMonsterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.monster);self.monster=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.rewardScrollview);self.rewardScrollview=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end



















function UIEmergenciesMonsterWin:onLoaded(...)
self:bindComponents()

self.rewardScrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIEmergenciesMonsterWin:__delete()
self:unbindComponents()
end




function UIEmergenciesMonsterWin:onShow(argtable,afterOnloaded)
self.mId=argtable[1]
self.stId=argtable[2]

local cfg=cfgHelper.get1(cfg_monstergroup_get,self.mId)

local level=cfg.level
if cfg.levelUp then
level=emergenciesModel:getMonsterLevel()or level
end
local n,p,pN=UIDiscipleModel:getJJNameX(level)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('境界：{0}{1}',n,pN)
else
jj_str=FMT.fmt('境界：{0}',n)
end
self.level:setText(jj_str)

local model=cfg.model[1]
local scale=isometricMapSystem:getModelScale(model,true)
local modelParam=cfgHelper.get2(cfg_dbbodyconfig_get,model,'scales2')
modelParam=modelParam and modelParam[1]or{1,0,0}
scale=scale*modelParam[1]
self.monster:setChildUIModelShowTarget(model,scale,nil,eAnimationID.stand)
self.monster:setChildUIModelShowTargetOffset(modelParam[2],modelParam[3])
self.name:setText(cfg.name)
self.desc:setText(cfg.desc)


local rewards={}
local drops=cfg.drops
if drops then
for i,rwId in ipairs(drops)do
local temp=zongmenControl:getRewardConfigData(rwId,level)
rewards=table.concatTableX(rewards,temp)
end
end
local actRewards=worldFightModel:getMonsterExtraDropActReward(self.mId)
local normalRewardCount=#rewards
local actRewardCount=#actRewards
self.rewardScrollview:setActive(true)
self.rewardScrollview:setChildScrollViewCreateGrids(normalRewardCount+actRewardCount,0)
local grids=self.rewardScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
local isActReward=false
if i>normalRewardCount then
data=actRewards[i-normalRewardCount]
isActReward=true
end
local stage
if not moneyConfig.isMoney(data[1])then
local rcfg=itemsConfig.getConfig(data[1])
stage=rcfg.stage
end
local itemShowCount=data.showCount or data[2]
widgetHelper.setNormalRewardItem(item,0,{data[1],itemShowCount,stage=stage,range=data.range,isShowGailv=data[2]==-1})
end
end


function UIEmergenciesMonsterWin:onHide()

end




function UIEmergenciesMonsterWin:onChallengeBtn()
if isometricMapSystem:checkMonsterAIRecord(self.stId)then
UIManager.error("宗门弟子正在前往降妖，请祖师稍等片刻")
elseif not emergenciesControl:getEventMonsterData(self.stId)then
UIManager.error("宗门弟子已降妖")
else
local mId=self.mId
local stId=self.stId
local mcfg=cfgHelper.get(cfg_monstergroup_get,mId)
fightController.showPrepareWin(fightPreSelectModel.fightType.monsterInvade,
{
enterTxt='宗门',
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
isHomeBattle=true,
monsterList=mcfg.monList,
groupId=mId,
enterCallBack=function(guidList,zfId)
fightLaunchController:sendFight(eBattleLaunch.monsterInvade,guidList,mcfg.mapId or 0,zfId,{mId,stId})
end})
end
self:onCloseClick()
end

function UIEmergenciesMonsterWin:onCloseClick()
self:closeSelf()
end