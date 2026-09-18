







def_class("UIXM_XMDG_bossWin",UIWindowBase)









function UIXM_XMDG_bossWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.skipFight=UIToggleButton.get(self,2)
self.buffTips=UIButton.get(self,3)
self.rankBtn=UIButton.get(self,4)
self.rankRoot=UIObject.get(self,5)
self.rewardBtn=UIButton.get(self,6)
self.skipMask=UIButton.get(self,7)
self.battleBtn=UIButton.get(self,8)
self.costObj=UIButton.get(self,9)
self.damage=UIText.get(self,10)
self.titleTxt=UIText.get(self,11)
self.descTxt=UIText.get(self,12)
self.closeBtn=UIButton.get(self,13)
self.monsterModel=UIObject.get(self,14)
self.cloudSp=UIObject.get(self,15)
self.buffBtn=UIButton.get(self,16)
self.rankReddot=UIObject.get(self,17)
self.noTipsTxt=UIText.get(self,18)
self.rankGridPanel=UIObject.get(self,19)
self.costDesc=UIText.get(self,20)
self.costIcon=UIImage.get(self,21)
self.buffIcon=UIImage.get(self,22)
self.buffNameTxt=UIText.get(self,23)
self.buffDescTxt=UIText.get(self,24)
self.monProgressTxt=UIText.get(self,25)
self.monProgressImg=UIObject.get(self,26)
self.rewardPanel=UIObject.get(self,27)

self.buffTips:setButtonClick(function()self:onBuffTips()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.skipMask:setButtonClick(function()self:onSkipMask()end)

self.battleBtn:setButtonClick(function()self:onBattleBtn()end)

self.costObj:setButtonClick(function()self:onCostObj()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.buffBtn:setButtonClick(function()self:onBuffBtn()end)



end


function UIXM_XMDG_bossWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skipFight);self.skipFight=nil;
_UIObject_release(self.buffTips);self.buffTips=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rankRoot);self.rankRoot=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.skipMask);self.skipMask=nil;
_UIObject_release(self.battleBtn);self.battleBtn=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.damage);self.damage=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.monsterModel);self.monsterModel=nil;
_UIObject_release(self.cloudSp);self.cloudSp=nil;
_UIObject_release(self.buffBtn);self.buffBtn=nil;
_UIObject_release(self.rankReddot);self.rankReddot=nil;
_UIObject_release(self.noTipsTxt);self.noTipsTxt=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.buffIcon);self.buffIcon=nil;
_UIObject_release(self.buffNameTxt);self.buffNameTxt=nil;
_UIObject_release(self.buffDescTxt);self.buffDescTxt=nil;
_UIObject_release(self.monProgressTxt);self.monProgressTxt=nil;
_UIObject_release(self.monProgressImg);self.monProgressImg=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
end
















local _this=nil


function UIXM_XMDG_bossWin:onLoaded(...)
_this=self
self:bindComponents()
self.skipNeedFC=1

end

function UIXM_XMDG_bossWin:onSkipMask()

UIManager.info("需要至少挑战过一次")
end



function UIXM_XMDG_bossWin:__delete()
_this=nil
self:unbindComponents()
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','setMoneyRootCanves',false)
end


function UIXM_XMDG_bossWin:onHide()

end




function UIXM_XMDG_bossWin:onShow(argtable,afterOnloaded)
self.roomid=argtable.roomid
self.m_room=xianmengdigongModel:getRoom(self.roomid)
self.monstercfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,self.m_room.ysConfId)

self:refreshView()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4118,1,{},2044,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.15,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)

local pos=self:getChildCanvas(-1)
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','setMoneyRootCanves',true,pos[1],pos[2]+1)
self.cloudSp:setChildUIModelShowTarget(4106,1,{},0,false,false,0,nil)

self.isSkip=self:isCanSkipFight()and xianmengdigongModel:isSkipFight()

self.skipFight:setToggle(self.isSkip)
self.skipFight:setToggleChange(function(name,isOn)
self.isSkip=isOn
xianmengdigongModel:setSkipFightState(isOn)
end)
end

local needRefresh=xianmengdigongModel:checkBossRankList(self.roomid)
if needRefresh then
self.rankRoot:setActive(false)
xianmengdigongController:send_20_132(self.roomid)
else
self:refreshRank()
end
self:refreshRankBtn()
end

function UIXM_XMDG_bossWin:isCanSkipFight()
return self.m_room:getBossMaxHurt()>0
end



function UIXM_XMDG_bossWin:refreshRank()
self.rankRoot:setActive(true)
local list=xianmengdigongModel:getBossRankList(self.roomid)
local n=list~=nil and#list or 0
n=math.min(3,n)
local isshow=n>0
self.rankGridPanel:setActive(isshow)
self.noTipsTxt:setActive(not isshow)
if isshow then
self.rankGridPanel:setChildLayoutGroupCreateItems(n)
local grids=self.rankGridPanel:getChildLayoutGroupGridList()
for i=1,n do
local item=grids[i-1]
local data=list[i]

item:SetChildText(0,data.rank)

item:SetChildText(1,data.name)

item:SetChildText(2,FMT.fmt('{0}%',data.hurt/100))
end
end
end

function UIXM_XMDG_bossWin:refreshRankBtn()
local isReddot=self.m_room:hasRankReward()
self.rankReddot:setActive(isReddot)
end

function UIXM_XMDG_bossWin:refreshView()




self.titleTxt:setText('迷雾笼罩的房间')

self.descTxt:setText(self.monstercfg.desc)

self.costIcon:setImageIcon(iconHelper.getIconName(eMoneyType.mtDiGongXingDongLi),false)
self:refreshXDL()

local buffId=self.m_room.buffId
local buffLv=self.m_room.buffLv
local bIcon=mysteryEnvironmentEffectModel.getRuleIcon(buffId)
local bStr=mysteryEnvironmentEffectModel.getRuleDesc(buffId,buffLv)
local ruleCfg=mysteryEnvironmentEffectModel.getConfigById(buffId)
self.buffDescTxt:setText(bStr)
self.buffIcon:setImageIcon(bIcon,true)
self.buffNameTxt:setText(ruleCfg.name)

self:refreshModel()
self:refreshReward()
self:refreshProgress(true)

self.skipMask:setActive(not self:isCanSkipFight())

self.damage:setText(FMT.fmt("单次最高伤害：{0}%",(self.m_room:getBossMaxHurt())/100))
end

function UIXM_XMDG_bossWin:refreshXDL()
local num_str=FMT.fmt('{0}/{1}')
local need=self.monstercfg.zxli
local has=xianmengdigongModel:getXDL()
if has>=need then
num_str=tostring(need)
else
num_str=FMT.fmt('<color=#c82c2c>{0}</color>',need)
end
self.costDesc:setText(num_str)
end

function UIXM_XMDG_bossWin:refreshReward()
local boss=self.monstercfg.boss
local rewards={}
local zmlv=zongmenModel:getLevel()
for i,v in ipairs(boss[2])do
local list=zongmenControl:getRewardConfigData(v,zmlv)
if list~=nil and#list>0 then
for i2,v2 in ipairs(list)do
local cfg=itemsConfig.getConfig(v2[1])
table.insert(rewards,{v2[1],v2[2],cfg.color})
end
end
end
if self.monstercfg.itemList then
for i,v in ipairs(self.monstercfg.itemList)do
local cfg=itemsConfig.getConfig(v[1])
table.insert(rewards,{v[1],v[2],cfg.color})
end
end
local c=#rewards
if c>1 then
table.sort(rewards,function(a,b)
return a[3]>b[3]
end)
end
self.rewardPanel:setChildLayoutGroupCreateItems(c)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
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

local showSign=itemnum<0
item:SetChildActive(1,showSign)
end
end

function UIXM_XMDG_bossWin:refreshProgress(anim)
local max=self.m_room.maxJinDu
local cur=self.m_room.unlockJinDu
local rate=cur/max
if rate>1 then rate=1 end
if anim then
helper.playProgressAnim(self.monProgressImg,rate,0,nil,nil,nil,0.2)
else
self.monProgressImg:setChildIconFillAmount(rate)
end
local str=FMT.fmt('{0}%',cur/100)
self.monProgressTxt:setText(str)
end

function UIXM_XMDG_bossWin:refreshModel()
local boss=self.monstercfg.boss
local modelParams=comHelper.getMonsterGroupModelParams(boss[1])
local size=self.monstercfg.ui_scale or 1
self.monsterModel:setChildUIModelShowTarget(modelParams.body,size,modelParams.componets,eAnimationID.stand)
local offset=self.monstercfg.ui_offset or{0,0}
self.monsterModel:setChildUIModelShowTargetOffset(offset[1],offset[2])

end

function UIXM_XMDG_bossWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_XMDG_bossWin:onBattleBtn()
if self.m_room:checkunLock()then
xianmengdigongController.showRoomUnlockTips()
return
end
if xianmengdigongModel:checkPassFlag(true)then
return
end
local need=self.monstercfg.zxli
local has=xianmengdigongModel:getXDL()
if has<need then
xianmengdigongController.xdlTips()
gainControl:showGainWin(eMoneyType.mtDiGongXingDongLi)
return
end

local boss=self.monstercfg.boss

if self.isSkip then
xianmengdigongController:send_20_135(self.m_room.base.x,self.m_room.base.y,0)
else
xianmengdigongController:doReqFight(self.m_room,0,boss[1])
UIManager:closeWindow('UIXM_XMDG_bossWin')
end

end

function UIXM_XMDG_bossWin:onRewardBtn()
local unlockReward=cfgHelper.get2(cfg_guilddigongroomconfig_get,self.m_room.roomConfId,'unlockReward')
local desc='以下物品在房间解锁后进入贡献商店'
self:showWindow('UIXM_XMDG_rewardShowWin',{rewardid=unlockReward,posx=93,posy=-13,desc=desc})
end

function UIXM_XMDG_bossWin:onBuffBtn()
local flag=self.showBuffTips==true
flag=not flag
self.showBuffTips=flag
self.buffTips:setActive(flag)
end

function UIXM_XMDG_bossWin:onBuffTips()
self:onBuffBtn()
end

function UIXM_XMDG_bossWin:onCostObj()

end

function UIXM_XMDG_bossWin:rec_roomProgress(roomid,isUnlock)
if self.roomid==roomid then
if not isUnlock then
self:refreshProgress(true)
else
xianmengdigongController.showRoomUnlockTips()
self:closeSelf()
end
end
end

function UIXM_XMDG_bossWin:rec_rank()
self:refreshRank()
end

function UIXM_XMDG_bossWin:rec_rankReward()
self:refreshRankBtn()
end

function UIXM_XMDG_bossWin:onCloseBtn()
self:closeSelf()
end

function UIXM_XMDG_bossWin:onRankBtn()
self:showWindow("UIXM_XMDG_bossRankWin",{roomid=self.roomid})
end