







def_class("UIXM_TYSC_VictoryWin",UIWindowBase)









function UIXM_TYSC_VictoryWin:bindComponents()

self.btnRoot=UIObject.get(self,0)
self.continueButton=UIButton.get(self,1)
self.continueDescText=UIText.get(self,2)
self.continueText=UIText.get(self,3)
self.desc2Txt=UIText.get(self,4)
self.desc3Txt=UIText.get(self,5)
self.descTxt=UIText.get(self,6)
self.OpenquickButton=UIButton.get(self,7)
self.quitButton=UIButton.get(self,8)
self.rewardPanel=UIObject.get(self,9)

self.continueButton:setButtonClick(function()self:onContinueButton()end)

self.OpenquickButton:setButtonClick(function()self:onOpenquickButton()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)



end


function UIXM_TYSC_VictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnRoot);self.btnRoot=nil;
_UIObject_release(self.continueButton);self.continueButton=nil;
_UIObject_release(self.continueDescText);self.continueDescText=nil;
_UIObject_release(self.continueText);self.continueText=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.desc3Txt);self.desc3Txt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.OpenquickButton);self.OpenquickButton=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
end
















local _this=nil

local getBtnCheck=
{

[1]=function(self)
return(xianmengController:canFightBoss_TYSC(self.slGuild)or xianmengController:canBuyBoss_TYSC(self.slGuild))
end,

[2]=function(self)

return(xianmengModel:getChallengeNum1_TYSC()>0 or xianmengModel:canBuyChallengeBuyNum1_TYSC())
end,
}

local getChallengeNum=
{

[1]=function(self)
return xianmengModel:getChallengeNum2_TYSC(self.slGuild)
end,

[2]=function(self)
return xianmengModel:getChallengeNum1_TYSC()
end,
}

local onContinueButton=
{

[1]=function(self)
local slGuild=self.slGuild
local continueData=self.continueData
if continueData~=nil then
local check1=xianmengController:canFightBoss_TYSC(slGuild,false)
local check2=false
if not check1 then
check2=xianmengController:canBuyBoss_TYSC(slGuild,true)
end
if check1 then

if self:checkContinueButton(true)then
local func=function()
if self and self.battleId then
fightController:closeBattle(self.battleId)
end
local args={isSkip=true}
fightModel:setSendExtraArgs(eBattleType.tianyuanshouchao,args)
xianmengController:setContinueData_TYSC(continueData)
fightLaunchController:sendFight(eBattleLaunch.tianyuanshouchao,continueData[1],continueData[2],continueData[3],continueData[4])
xianmengController:RecordTYSC_ChallengNum(1)
end
loadingControl.openCloud(func,10)
end

elseif check2 then
if self:checkContinueButton()then
local cb=function()
if self and self.battleId then
fightController:closeBattle(self.battleId)
end
xianmengController:setBuyFightData_TYSC(continueData)



end
xianmengController:showBuyBossDialouge_TYSC(slGuild,cb)
end
else
self:onBackBlock()
end
else
self:onBackBlock()
end
end,

[2]=function(self)
local continueData=self.continueData
if continueData~=nil then
local curNum=xianmengModel:getChallengeNum1_TYSC()
local check1=curNum>0

local check2=false
if not check1 then
check2=xianmengModel:canBuyChallengeBuyNum1_TYSC()
if not check2 then
UIManager.error('购买次数已用完')


end
end
if check1 then

if self:checkContinueButton(true)then
local func=function()

if self and self.battleId then
fightController:closeBattle(self.battleId)
end
xianmengController:finishFightOpen_TYSC()
local args={isSkip=true}
fightModel:setSendExtraArgs(eBattleType.tianyuanshouchao,args)
xianmengController:setContinueData_TYSC(continueData)
fightLaunchController:sendFight(eBattleLaunch.tianyuanshouchao,continueData[1],continueData[2],continueData[3],continueData[4])
xianmengController:RecordTYSC_ChallengNum(1)
end
loadingControl.openCloud(func,10)
end

elseif check2 then
if self:checkContinueButton()then
local cb=function()
if self and self.battleId then
fightController:closeBattle(self.battleId)
end
xianmengController:setBuyFightData_TYSC(continueData)



end
xianmengController:showBuyMonDialouge_TYSC(cb)
end
else
self:onBackBlock()
end
else
self:onBackBlock()
end
end,
}



function UIXM_TYSC_VictoryWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_TYSC_VictoryWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_TYSC_VictoryWin:onHide()

end




function UIXM_TYSC_VictoryWin:onShow(argtable,afterOnloaded)
self.mLockTime=nil
local data=argtable.data
self.parentWin=argtable.parentWin
local killNum=data.killNumSrc
local yaohun=data.yaohun
local tyJiFen=data.tyJiFen
local slGuild=data.slGuild
self.slGuild=slGuild
local rewards=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eTianYuanShouChao,'getRewardList')
self.battleId=argtable.battleId
local rewardlist={}
local desc1_str,desc2_str,desc3_str
local isBoss=false
if mathHelper.validInt64(slGuild)then
isBoss=true

local hurt=data.hurt/100
local hpPercent=data.hp/100
desc1_str=FMT.fmt('本次伤害：<color=#7d3b17>{0}%</color>',hurt)
desc2_str=FMT.fmt('剩余血量：<color=#7d3b17>{0}%</color>',hpPercent)
else
desc1_str=FMT.fmt('击杀数：<color=#7d3b17>{0}</color>',killNum)
desc2_str=FMT.fmt('妖魂：<color=#7d3b17>{0}</color>',yaohun)
desc3_str=FMT.fmt('天渊积分：<color=#7d3b17>{0}</color>',tyJiFen)
end
if#rewards>0 then
for i,v in ipairs(rewards)do
local itemConfig=itemsConfig.getConfig(v.itemid)
table.insert(rewardlist,{v.itemid,v.num,itemConfig.color,v.itemguid})
end
end
self.monType=isBoss and 1 or 2
local num=#rewardlist
if num>1 then
table.sort(rewardlist,function(a,b)
return a[3]>b[3]
end)
end

self.descTxt:setActive(desc1_str~=nil)
if desc1_str~=nil then
self.descTxt:setText(desc1_str)
end
self.desc2Txt:setActive(desc2_str~=nil)
if desc2_str~=nil then
self.desc2Txt:setText(desc2_str)
end
self.desc3Txt:setActive(desc3_str~=nil)
if desc3_str~=nil then
self.desc3Txt:setText(desc3_str)
end

self.rewardPanel:setChildLayoutGroupCreateItems(num)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
local reward=rewardlist[i]
local itemid=reward[1]
local itemNum=reward[2]
local itemguid=reward[4]
local itemcount,showCountBG
if itemNum>1 then
itemcount=tostring(itemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,itemguid=itemguid,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
local suitIcon=equipsHelper.getSuitIconByArgs(itemguid,itemid)
local subItem=item:GetChildWidgetBase(0)
if subItem then
subItem:SetChildIcon(10,suitIcon,false)
end

end

UIManager:invokeUIMethod(self.parentWin,'setCloudClose')


local check=getBtnCheck[self.monType](self)

self.btnRoot:setActive(check)
if check then
UIManager:invokeUIMethod(self.parentWin,'hideCloseTips')
local curNum=getChallengeNum[self.monType](self)
local continueDesc=FMT.fmt('剩余挑战次数：<color=#7D3B17>{0}</color>',curNum)
self.continueDescText:setText(continueDesc)

self.continueData=xianmengController:getContinueData_TYSC()
xianmengController:setContinueData_TYSC(nil)

local stamp=xianmengModel:getChallengeStamp()
local now=timeHelper.getServerShortTime()
local rt=5-(now-stamp)
if stamp>0 and rt<5 then
self.continueText:setText(FMT.fmt("再次挑战({0})",5-(now-stamp)))
self:setTimer(1,6-(now-stamp),function()
local n=timeHelper.getServerShortTime()
if 5-(n-stamp)>0 then
self.continueText:setText(FMT.fmt("再次挑战({0})",5-(n-stamp)))
else
self.continueText:setText("再次挑战")
end
end)
else
self.continueText:setText("再次挑战")
end
end
local num=xianmengController:loadTYSC_ChallengNum()
local quick_neednum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'quick_neednum')
local quick_needLV=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'quick_needLV')

self.OpenquickButton:setActive(num>=quick_neednum or zongmenModel:getLevel()>=quick_needLV)

end

function UIXM_TYSC_VictoryWin:setLockTime(time)
self.mLockTime=Time.realtimeSinceStartup+time
UIManager:invokeUIMethod(self.parentWin,'setLockTime',time)
end

function UIXM_TYSC_VictoryWin:checkLockTime()
if self.mLockTime and Time.realtimeSinceStartup<self.mLockTime then
return false
end
return true
end

function UIXM_TYSC_VictoryWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_TYSC_VictoryWin:onBackBlock()
UIManager:invokeUIMethod(self.parentWin,'onCloseTips')
end

function UIXM_TYSC_VictoryWin:onQuitButton()
self:onBackBlock()
end

function UIXM_TYSC_VictoryWin:onContinueButton()
onContinueButton[self.monType](self)
end

function UIXM_TYSC_VictoryWin:checkContinueButton(freshTime)
local now=timeHelper.getServerShortTime()
local stamp=xianmengModel:getChallengeStamp()
if now-stamp<5 then
UIManager.error(FMT.fmt("{0}秒后可再次挑战",5-(now-stamp)))
return false
end
if freshTime then
xianmengModel:setChallengeStamp(now)
end
return true
end

function UIXM_TYSC_VictoryWin:onOpenquickButton()
xianmengModel:SetNeedOpenquickWin(true)
self:onQuitButton()

end
