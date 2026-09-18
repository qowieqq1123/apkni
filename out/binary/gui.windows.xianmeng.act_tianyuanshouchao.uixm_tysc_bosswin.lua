







def_class("UIXM_TYSC_bossWin",UIWindowBase)









function UIXM_TYSC_bossWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.bossModel=UIObject.get(self,1)
self.bloodProgress=UIObject.get(self,2)
self.bloodProgressText=UIText.get(self,3)
self.nameTxt=UIText.get(self,4)
self.bossRewardBtn=UIButton.get(self,5)
self.descTxt=UIText.get(self,6)
self.challengeNumTxt=UIText.get(self,7)
self.challengeAddBtn=UIButton.get(self,8)
self.challengeBtn=UIButton.get(self,9)
self.challengeRewardPanel=UIObject.get(self,10)
self.sellRewardPanel=UIObject.get(self,11)
self.rewardReddot=UIObject.get(self,12)

self.bossRewardBtn:setButtonClick(function()self:onBossRewardBtn()end)

self.challengeAddBtn:setButtonClick(function()self:onChallengeAddBtn()end)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)



end


function UIXM_TYSC_bossWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.bossModel);self.bossModel=nil;
_UIObject_release(self.bloodProgress);self.bloodProgress=nil;
_UIObject_release(self.bloodProgressText);self.bloodProgressText=nil;
_UIObject_release(self.nameTxt);self.nameTxt=nil;
_UIObject_release(self.bossRewardBtn);self.bossRewardBtn=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.challengeNumTxt);self.challengeNumTxt=nil;
_UIObject_release(self.challengeAddBtn);self.challengeAddBtn=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.challengeRewardPanel);self.challengeRewardPanel=nil;
_UIObject_release(self.sellRewardPanel);self.sellRewardPanel=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
end
















local _this=nil


function UIXM_TYSC_bossWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_TYSC_bossWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_TYSC_bossWin:onHide()

end




function UIXM_TYSC_bossWin:onShow(argtable,afterOnloaded)
self.monster_guid=argtable.guid
self.monster_data=xianmengModel:getBossDataByGuid_TYSC(self.monster_guid)

self:refreshInfo()
self:refreshRewardReddot()
end

function UIXM_TYSC_bossWin:refreshInfo()
local level=xianmengModel:getLevel_TYSC()
local bosscfg=cfgHelper.get1(cfg_skyshouchaoshoulingconfig_get,self.monster_data.confId)

local title_str=xianmengModel:getLevelName3_TYSC(level)
self.titleTxt:setText(title_str)

local groupcfg=cfgHelper.get1(cfg_monstergroup_get,bosscfg.gwzId)
self.nameTxt:setText(groupcfg.name)

local modelParams=comHelper.getMonsterGroupModelParams(bosscfg.gwzId)
local size=bosscfg.ui_scale or 1
self.bossModel:setChildUIModelShowTarget(modelParams.body,size,modelParams.componets,eAnimationID.stand)

self:refreshBlood()

local desc_str=FMT.fmt('仙盟增加天渊积分：<color=#171311>{0}</color>',bosscfg.jiFen)
self.descTxt:setText(desc_str)

local reward1=bosscfg.reward1

local challengeRewards=zongmenControl:getRewardConfigData(reward1,zongmenModel:getLevel())or{}

local c=#challengeRewards
self.challengeRewardPanel:setChildLayoutGroupCreateItems(c)
local grids=self.challengeRewardPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local itemid=challengeRewards[i][1]
local itemnum=challengeRewards[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<=0
item:SetChildActive(1,showSign)
end

local sellRewards=zongmenModel:getLevelReward(bosscfg.reward4)
local c2=#sellRewards
self.sellRewardPanel:setChildLayoutGroupCreateItems(c2)
local grids2=self.sellRewardPanel:getChildLayoutGroupGridList()
for i=1,c2 do
local item=grids2[i-1]
local itemid=sellRewards[i][1]
local itemnum=sellRewards[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<=0
item:SetChildActive(1,showSign)
end

self:refreshChallengeNum()
end

function UIXM_TYSC_bossWin:refreshBlood()
local rate=self.monster_data.hp/10000
if rate>1 then
rate=1
elseif rate<0 then
rate=0
end
self.bloodProgress:setChildIconFillAmount(rate)
local hpPercent=self.monster_data.hp/100
self.bloodProgressText:setText(FMT.fmt('{0}%',hpPercent))
end

function UIXM_TYSC_bossWin:refreshChallengeNum()
local num=xianmengModel:getChallengeNum2_TYSC(self.monster_guid)
local num_str=FMT.fmt('剩余挑战次数：{0}',num)
self.challengeNumTxt:setText(num_str)
end

function UIXM_TYSC_bossWin:onChallengeAddBtn()
self:onChallengeAdd(true)
end

function UIXM_TYSC_bossWin:onChallengeAdd(isWarning)
local slGuild=self.monster_guid
local shoulingNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shoulingNum')
local maxBuyNum=shoulingNum[2]
local curBuyNum=xianmengModel:getChallengeBuyNum2_TYSC(slGuild)
local lerpBuyNum=maxBuyNum-curBuyNum
if lerpBuyNum<=0 then
if isWarning then
UIManager.error('购买次数已用完')
end
return
end

local costItemID=shoulingNum[3]
local costNumList=shoulingNum[4]
local getCostNum=function(num)
local costItemNum=0
for curBuyLevel=curBuyNum+1,curBuyNum+num do
local n=costNumList[curBuyLevel]
if n==nil then
n=costNumList[#costNumList]
end
costItemNum=costItemNum+n
end
return costItemNum
end

local refresh=function(num)
local itemNum=getCostNum(num)
local have=itemsModel.getCount(costItemID)
local colorStr=have>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costItemID)
local costStr=FMT.fmt("quad-icon={2}-quad <color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
local contentStr=FMT.fmt('是否花费{0}购买首领挑战次数？',costStr)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=lerpBuyNum,
tips=FMT.fmt("（剩余购买次数：{0}）",lerpBuyNum),
oktext='购买',
canceltext='取消',
okcallback=function(num)
if _this==nil then return end
if not xianmengController:canFightBoss2_TYSC(slGuild,true)then
_this:closeSelf()
return
end
local itemNum=getCostNum(num)
local func=function()
xianmengController:setBuyFightData_TYSC(nil)
xianmengController:send_248_15(slGuild,num)
end
moneySystem:useMoney(costItemID,itemNum,func,WARNING_TYPE.eWarning)
end,
moneytypes={{costItemID},},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return true
end

function UIXM_TYSC_bossWin:onChallengeBtn()
if not xianmengController:canFightBoss2_TYSC(self.monster_guid,true)then
return
end
local bosscfg=cfgHelper.get1(cfg_skyshouchaoshoulingconfig_get,self.monster_data.confId)
local monster=xianmengModel:getMonsterByGuid_TYSC(MONSTER_TYPE.eShouLing,self.monster_guid)
local m_id=monster.m_id


local curNum=xianmengModel:getChallengeNum2_TYSC(self.monster_guid)
if curNum<=0 then
if self:onChallengeAdd()then
return
end
end
local bosscfg=cfgHelper.get1(cfg_skyshouchaoshoulingconfig_get,self.monster_data.confId)
local monster=xianmengModel:getMonsterByGuid_TYSC(MONSTER_TYPE.eShouLing,self.monster_guid)
local m_id=monster.m_id
xianmengController:doBossFight_TYSC(MONSTER_TYPE.eShouLing,bosscfg.gwzId,m_id,bosscfg.jiFen)
end

function UIXM_TYSC_bossWin:refreshRewardReddot()
local flag=xianmengModel:checkBossLookFlag(self.monster_guid)
self.rewardReddot:setActive(not flag)
end

function UIXM_TYSC_bossWin:onBossRewardBtn()
local bosscfg=cfgHelper.get1(cfg_skyshouchaoshoulingconfig_get,self.monster_data.confId)
local rewards=zongmenModel:getLevelReward(bosscfg.reward2)
local args={
title='击败奖励',
desc1='击败首领后盟员可获得以下奖励',
desc2=nil,
rewards=rewards,
rewardTitle=-1,
showCancel=false,
cancelName=nil,
commitName=nil,
cancelCB=nil,
commitCB=function()

end,
}
UIManager:showWindow('UIDialougeRewardWin',args)
xianmengModel:setBossLookFlag(self.monster_guid)
self:refreshRewardReddot()
end

function UIXM_TYSC_bossWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end



function UIXM_TYSC_bossWin:recv_buy()
self:refreshChallengeNum()
end

function UIXM_TYSC_bossWin:recv_blood_change(guid)
if not mathHelper.compareInt64(guid,self.monster_guid)then return end
self:refreshBlood()
end

function UIXM_TYSC_bossWin:recv_boss_dead(guid)
if not mathHelper.compareInt64(guid,self.monster_guid)then return end
UIManager.error('首领已剿灭')
self:closeSelf()
end

