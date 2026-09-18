







def_class("UIXM_XMDG_monsterWin",UIWindowBase)









function UIXM_XMDG_monsterWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.skipFight=UIToggleButton.get(self,2)
self.monSign=UIObject.get(self,3)
self.rewardBtn=UIButton.get(self,4)
self.costObj=UIButton.get(self,5)
self.battleBtn=UIButton.get(self,6)
self.descTxt=UIText.get(self,7)
self.closeBtn=UIButton.get(self,8)
self.menuGridPanel=UIObject.get(self,9)
self.cloudSp=UIObject.get(self,10)
self.monsterModel=UIObject.get(self,11)
self.titleTxt=UIText.get(self,12)
self.skipMask=UIButton.get(self,13)
self.costIcon=UIImage.get(self,14)
self.costDesc=UIText.get(self,15)
self.monProgressImg=UIObject.get(self,16)
self.monProgressTxt=UIText.get(self,17)
self.monProgressGreenImg=UIObject.get(self,18)
self.Checkmark=UIObject.get(self,19)
self.rewardPanel=UIObject.get(self,20)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.costObj:setButtonClick(function()self:onCostObj()end)

self.battleBtn:setButtonClick(function()self:onBattleBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.skipMask:setButtonClick(function()self:onSkipMask()end)



end


function UIXM_XMDG_monsterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skipFight);self.skipFight=nil;
_UIObject_release(self.monSign);self.monSign=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.battleBtn);self.battleBtn=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.cloudSp);self.cloudSp=nil;
_UIObject_release(self.monsterModel);self.monsterModel=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.skipMask);self.skipMask=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
_UIObject_release(self.monProgressImg);self.monProgressImg=nil;
_UIObject_release(self.monProgressTxt);self.monProgressTxt=nil;
_UIObject_release(self.monProgressGreenImg);self.monProgressGreenImg=nil;
_UIObject_release(self.Checkmark);self.Checkmark=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
end
















local _this=nil
local lvNameLookup={
'直面强敌','随机应变','击敌以弱'
}


function UIXM_XMDG_monsterWin:onLoaded(...)
_this=self
self:bindComponents()
self.skipNeedFC=1

end



function UIXM_XMDG_monsterWin:onSkipMask()
UIManager.info("需要在该难度下获胜过")
end


function UIXM_XMDG_monsterWin:__delete()
_this=nil
self:unbindComponents()
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','setMoneyRootCanves',false)
end


function UIXM_XMDG_monsterWin:onHide()

end




function UIXM_XMDG_monsterWin:onShow(argtable,afterOnloaded)
self.roomid=argtable.roomid
self.m_room=xianmengdigongModel:getRoom(self.roomid)
self.monstercfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,self.m_room.ysConfId)

self.curSelectIdx=xianmengdigongModel:getFightDifficulty()
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

self.isSkip=self:isCanSkipFight()and xianmengdigongModel:isSkipMonFight(self.curSelectIdx)
self.skipFight:setToggle(self.isSkip)
self.skipFight:setToggleChange(function(name,isOn)
self.isSkip=isOn
xianmengdigongModel:setSkipMonFightState(self.curSelectIdx,isOn)
end)
end
end

function UIXM_XMDG_monsterWin:refreshView()

self.titleTxt:setText('迷雾笼罩的房间')

self.descTxt:setText(self.monstercfg.desc)

self.monSign:setActive(self.monstercfg.gwtype~=MONSTER_TYPE.eXiaoGuai)

self.costIcon:setImageIcon(iconHelper.getIconName(eMoneyType.mtDiGongXingDongLi),false)
self:refreshXDL()

local gwzList=self.monstercfg.gwzList
local c=#gwzList
self.menuGridPanel:setChildLayoutGroupCreateItems(c)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local d=gwzList[i]

local name=lvNameLookup[i]
item:SetChildText(1,name)

local sign
if i==1 then
sign='<color=#f36666>[难]</color>'
elseif i==c then
sign='<color=#aae252>[易]</color>'
else
sign=''
end
item:SetChildText(3,sign)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)

self:refreshMenuItemSelect(item,i,i==self.curSelectIdx)
end

self:refreshModel()
self:refreshReward()
self:refreshProgress(true)

self.skipMask:setActive(not self:isCanSkipFight())
end

function UIXM_XMDG_monsterWin:isCanSkipFight()
return self.m_room:getFastFlag(self.curSelectIdx)
end

function UIXM_XMDG_monsterWin:refreshSkipFight()
local skipFight=self:isCanSkipFight()
self.isSkip=skipFight and xianmengdigongModel:isSkipMonFight(self.curSelectIdx)
self.skipFight:setToggle(self.isSkip)

self.skipMask:setActive(not skipFight)
end


function UIXM_XMDG_monsterWin:refreshXDL()
local num_str
local need=self.monstercfg.zxli
local has=xianmengdigongModel:getXDL()
if has>=need then
num_str=tostring(need)
else
num_str=FMT.fmt('<color=#c82c2c>{0}</color>',need)
end
self.costDesc:setText(num_str)
end

function UIXM_XMDG_monsterWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildActive(2,flag)
local icon
local icon2
if flag then
icon='frame_tytipskuang_2'
icon2='image_tyduoxiangdian'
else
icon='frame_tytipskuang'
icon2='image_tipsty_2'
end
item:SetChildCSImageSprite(0,globalABLookup.global,icon)
item:SetChildCSImageSprite(4,globalABLookup.global,icon2)
end

function UIXM_XMDG_monsterWin:onMenuItemClick(idx)
if self.curSelectIdx==idx then return end
self:refreshMenuItemSelect(nil,self.curSelectIdx,false)
self:refreshMenuItemSelect(nil,idx,true)
self.curSelectIdx=idx
xianmengdigongModel:setFightDifficulty(self.curSelectIdx)
self:refreshModel()
self:refreshReward()
self:refreshProgress(true)

self:refreshSkipFight()
end

function UIXM_XMDG_monsterWin:refreshReward()
local gwzList=self.monstercfg.gwzList
local d=gwzList[self.curSelectIdx]
local rewards={}
local zmlv=zongmenModel:getLevel()
for i,v in ipairs(d[3])do
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

function UIXM_XMDG_monsterWin:refreshProgress(anim)
local gwzList=self.monstercfg.gwzList
local d=gwzList[self.curSelectIdx]
local addexp=d[2]
local max=self.m_room.maxJinDu
local cur=self.m_room.unlockJinDu
local cur_=cur+addexp
local rate=cur/max
local rate_=cur_/max
if rate>1 then rate=1 end
if rate_>1 then rate_=1 end
if anim then
helper.playProgressAnim(self.monProgressImg,rate,0,nil,nil,nil,1)
else
self.monProgressImg:setChildIconFillAmount(rate)
end
local showgreen=addexp>0
self.monProgressGreenImg:setActive(showgreen)
if showgreen then
if anim then
helper.playProgressAnim(self.monProgressGreenImg,rate_,0,nil,nil,nil,1)
else
self.monProgressGreenImg:setChildIconFillAmount(rate_)
end
end
local str
if addexp>0 then
str=FMT.fmt('{0}<color=#fd8950>+{1}</color>/{2}',cur,addexp,max)
else
str=FMT.fmt('{0}/{1}',cur,max)
end
self.monProgressTxt:setText(str)
end

function UIXM_XMDG_monsterWin:refreshModel()
local gwzList=self.monstercfg.gwzList
local d=gwzList[1]
local groupid=d[1]




local modelParams=comHelper.getMonsterGroupModelParams(groupid)
local size=self.monstercfg.ui_scale or 1
self.monsterModel:setChildUIModelShowTarget(modelParams.body,size,modelParams.componets,eAnimationID.stand)
local offset=self.monstercfg.ui_offset or{0,0}
self.monsterModel:setChildUIModelShowTargetOffset(offset[1],offset[2])
self.monsterModel:setChildUIModelShowFlipX(true)
end

function UIXM_XMDG_monsterWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_XMDG_monsterWin:onBattleBtn()
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

local gwzList=self.monstercfg.gwzList
local d=gwzList[1]
if self.isSkip then
xianmengdigongController:send_20_135(self.m_room.base.x,self.m_room.base.y,self.curSelectIdx)
else
xianmengdigongController:doReqFight(self.m_room,self.curSelectIdx,d[1])
UIManager:closeWindow('UIXM_XMDG_monsterWin')
end

end

function UIXM_XMDG_monsterWin:onRewardBtn()
local unlockReward=cfgHelper.get2(cfg_guilddigongroomconfig_get,self.m_room.roomConfId,'unlockReward')
local desc='以下物品在房间解锁后进入贡献商店'
self:showWindow('UIXM_XMDG_rewardShowWin',{rewardid=unlockReward,posx=93,posy=-13,desc=desc})
end

function UIXM_XMDG_monsterWin:onCostObj()

end

function UIXM_XMDG_monsterWin:rec_roomProgress(roomid,isUnlock)
if self.roomid==roomid then
if not isUnlock then
self:refreshProgress(true)
else
xianmengdigongController.showRoomUnlockTips()
self:closeSelf()
end
end
end

function UIXM_XMDG_monsterWin:onCloseBtn()
self:closeSelf()
end