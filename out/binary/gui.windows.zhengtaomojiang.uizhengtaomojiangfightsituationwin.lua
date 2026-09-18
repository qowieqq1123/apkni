







def_class("UIZhengTaoMoJiangFightSituationWin",UIWindowBase)









function UIZhengTaoMoJiangFightSituationWin:bindComponents()

self.background=UIButton.get(self,0)
self.buffEmpty=UIText.get(self,1)
self.buffList=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.dead=UIObject.get(self,4)
self.head=UIObject.get(self,5)
self.headBG=UIButton.get(self,6)
self.headEmpty=UIObject.get(self,7)
self.hpProgressBar=UIProgress.get(self,8)
self.item_1=UIButton.get(self,9)
self.item_2=UIButton.get(self,10)
self.item_3=UIButton.get(self,11)
self.item_4=UIButton.get(self,12)
self.jumpBtn=UIButton.get(self,13)
self.live=UIObject.get(self,14)
self.monsterModel=UIObject.get(self,15)
self.nameTx=UIText.get(self,16)
self.playerName=UIText.get(self,17)
self.root=UIObject.get(self,18)
self.serverName=UIText.get(self,19)
self.spine=UIObject.get(self,20)
self.stateEmpty=UIText.get(self,21)
self.stateList=UIObject.get(self,22)
self.stateName=UIText.get(self,23)
self.stateNameBg=UIImage.get(self,24)
self.xmBGIcon=UIButton.get(self,25)
self.xmEmpty=UIText.get(self,26)
self.xmIcon=UIImage.get(self,27)
self.xmKuangIcon=UIImage.get(self,28)
self.xmName=UIText.get(self,29)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.headBG:setButtonClick(function()self:onHeadBG()end)

self.item_1:setButtonClick(function()self:onItem_1()end)

self.item_2:setButtonClick(function()self:onItem_2()end)

self.item_3:setButtonClick(function()self:onItem_3()end)

self.item_4:setButtonClick(function()self:onItem_4()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.xmBGIcon:setButtonClick(function()self:onXmBGIcon()end)
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
}



end


function UIZhengTaoMoJiangFightSituationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.buffEmpty);self.buffEmpty=nil;
_UIObject_release(self.buffList);self.buffList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dead);self.dead=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headBG);self.headBG=nil;
_UIObject_release(self.headEmpty);self.headEmpty=nil;
_UIObject_release(self.hpProgressBar);self.hpProgressBar=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.item_4);self.item_4=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.live);self.live=nil;
_UIObject_release(self.monsterModel);self.monsterModel=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.serverName);self.serverName=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.stateEmpty);self.stateEmpty=nil;
_UIObject_release(self.stateList);self.stateList=nil;
_UIObject_release(self.stateName);self.stateName=nil;
_UIObject_release(self.stateNameBg);self.stateNameBg=nil;
_UIObject_release(self.xmBGIcon);self.xmBGIcon=nil;
_UIObject_release(self.xmEmpty);self.xmEmpty=nil;
_UIObject_release(self.xmIcon);self.xmIcon=nil;
_UIObject_release(self.xmKuangIcon);self.xmKuangIcon=nil;
_UIObject_release(self.xmName);self.xmName=nil;
self.item=nil;
end















local _this=nil
local _itemCmp={
root=-1,
model=0,
headKuang=1,
icon=2,
nameTx=3,
live=4,
killed=5,
selected=6,
xmBGIcon=7,
xmIcon=8,
xmKuangIcon=9,
}
local _abName="ui/windows/zhengtaomojiang/zhengtaomojiang_situation_atlas_pak.ab"



function UIZhengTaoMoJiangFightSituationWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addProNotify(39,11,self.on_39_11)

self.spine:setChildUIModelShowTarget(6283,1,defaultT,eAnimationID.enter,false,false,0,function()
self.root:setActive(true)
end)
end


function UIZhengTaoMoJiangFightSituationWin:__delete()
self:unbindComponents()
_this=nil
end




function UIZhengTaoMoJiangFightSituationWin:onShow(argtable,afterOnloaded)
self.stage=seasonModel:findFirstDoingStage(seasonStageType.eMJHD)
self:refreshMonsters()
self:refreshPanel()
end


function UIZhengTaoMoJiangFightSituationWin:onHide()

end




function UIZhengTaoMoJiangFightSituationWin:onBackground()
self:onCloseBtn()
end


function UIZhengTaoMoJiangFightSituationWin:onCloseBtn()
self:closeSelf()
end


function UIZhengTaoMoJiangFightSituationWin:onHeadBG()
local build_id=self.dataList[self.selectIndex].id
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
local mojiangData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
if mojiangData and mojiangData.bestPlayer and mathHelper.validInt64(mojiangData.bestPlayer.actorId)then
otherPlayerController:openOtherPlayerInfoWin(mojiangData.bestPlayer.actorId,nil,nil,{serverid=mojiangData.bestPlayer.actorServer,isXianJie=true})
end
end

function UIZhengTaoMoJiangFightSituationWin:onXmBGIcon()
local build_id=self.dataList[self.selectIndex].id
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
local mojiangData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
if mojiangData and mojiangData.bestGuild and mathHelper.validInt64(mojiangData.bestGuild.guildId)and mojiangData.bestGuild.guildIcon>0 and mojiangData.bestGuild.guildName~=""then
local _xmData=xianjieModel:getXianMengData(mojiangData.bestGuild.guildId)
if _xmData then
local isOther=xianjienSceneIndexType:isOhterXianYu(_xmData.ownersceneidx)
if not isOther then
local wincfg=UIManager.get_window_config(self.__name)
xianmengController:openXMDetailInfoWin(mojiangData.bestGuild.guildId,wincfg.canvas+1)
else
UIManager.error('不同仙域的仙盟，无法探知其信息')
end
return
end
end
UIManager.info("不可知的神秘仙盟")
end

function UIZhengTaoMoJiangFightSituationWin:onItem_1()
self:onClickMonster(1)
end

function UIZhengTaoMoJiangFightSituationWin:onItem_2()
self:onClickMonster(2)
end

function UIZhengTaoMoJiangFightSituationWin:onItem_3()
self:onClickMonster(3)
end

function UIZhengTaoMoJiangFightSituationWin:onItem_4()
self:onClickMonster(4)
end


function UIZhengTaoMoJiangFightSituationWin:onJumpBtn()
local build_id=self.dataList[self.selectIndex].id
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
xianjieController:openMoJiangWin(seasonType,stageIndex,build_id)
self:onCloseBtn()
end

function UIZhengTaoMoJiangFightSituationWin:refreshMonsters()
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
self.dataList=xianjieModel:getMoJiangSortList(seasonType,stageIndex)
local defaultIndex=nil
for i,v in ipairs(self.dataList)do
local build_id=v.id
local entityData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
if entityData.killTime<=0 then
defaultIndex=i
break
end
end
self.selectIndex=self.selectIndex and self.selectIndex<=#self.dataList and self.selectIndex or defaultIndex or 1
for i,v in ipairs(self.item)do
self:refreshMonster(i)
end
end

function UIZhengTaoMoJiangFightSituationWin:refreshMonster(index)
local widget=self.item[index]:getWidgetBase()
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
local build_id=self.dataList[index].id
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
local mojiangData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
local monster_id=mojiangData.monster_id

local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monster_id)
local isDead=mojiangData.killTime>0
local body,componets,scale,flip=mojiangData:getModelData()
widget:SetChildUIModelShowTarget(_itemCmp.model,body,0.5,componets or defaultT,isDead and eAnimationID.stand2 or eAnimationID.stand,false,false,0)
widget:SetChildUIModelShowFlipX(_itemCmp.model,flip)
widget:SetChildCSImageSprite(_itemCmp.headKuang,globalABLookup.global,monTypeBg[monsterCfg.monType])
comHelper.setChildModelRawImage_monsterGroup(widget,monster_id,_itemCmp.icon,eAnimationID.stand)
widget:SetChildActive(_itemCmp.headKuang,not isDead)
widget:SetChildActive(_itemCmp.live,not isDead)
widget:SetChildActive(_itemCmp.xmBGIcon,isDead)
widget:SetChildActive(_itemCmp.killed,isDead)
widget:SetChildActive(_itemCmp.selected,self.selectIndex==index)
local nameStr=isDead and(mojiangData.bestGuild and mojiangData.bestGuild.guildName and mojiangData.bestGuild.guildName~=""and mojiangData.bestGuild.guildName or"神秘仙盟")or buildCfg.name
widget:SetChildText(_itemCmp.nameTx,nameStr)

local image=mojiangData.bestGuild and mojiangData.bestGuild.guildIcon>0 and xianmengModel.splitGuildIcon(mojiangData.bestGuild.guildIcon)or xianmengModel.getDefualtGuildIamge()
local abname=globalABLookup.xianmengicons
widget:SetChildCSImageSprite(_itemCmp.xmIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
widget:SetChildCSImageSprite(_itemCmp.xmBGIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
widget:SetChildCSImageSprite(_itemCmp.xmKuangIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end

function UIZhengTaoMoJiangFightSituationWin:onClickMonster(index)
if self.selectIndex~=index then
if self.selectIndex then
local widget=self.item[self.selectIndex]:getWidgetBase()
widget:SetChildActive(_itemCmp.selected,false)
end

self.selectIndex=index

local widget=self.item[self.selectIndex]:getWidgetBase()
widget:SetChildActive(_itemCmp.selected,true)

self:refreshPanel()
end
end

function UIZhengTaoMoJiangFightSituationWin:refreshPanel()
local build_id=self.dataList[self.selectIndex].id
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
local mojiangData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
local isDead=mojiangData.killTime>0

self.live:setActive(not isDead)
self.dead:setActive(isDead)
if isDead then
self.xmEmpty:setActive(false)
self.xmName:setText(mojiangData.bestGuild and mojiangData.bestGuild.guildName~=""and mojiangData.bestGuild.guildName or"神秘仙盟")
local image=mojiangData.bestGuild and mojiangData.bestGuild.guildIcon>0 and xianmengModel.splitGuildIcon(mojiangData.bestGuild.guildIcon)or xianmengModel:getDefualtGuildIamge()
local abname=globalABLookup.xianmengicons
self.xmIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
self.xmBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
self.xmKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

if mojiangData.bestPlayer and mathHelper.validInt64(mojiangData.bestPlayer.actorId)then
self.headEmpty:setActive(false)
self.head:setActive(true)
playerController:setHeadIcon(self.winlua,self.head:getID(),{iconInfo=mojiangData.bestPlayer.iconInfo})
self.playerName:setText(mojiangData.bestPlayer.actorName)
self.serverName:setText(loginModel:getServerName(mojiangData.bestPlayer.actorServer))
else
self.headEmpty:setActive(true)
self.head:setActive(false)
playerController:setHeadIcon(self.winlua,self.head:getID(),nil)
self.playerName:setText("")
self.serverName:setText("")
end

local stageCfg=self.stage:getConfig("mojiang",build_id)
local multi=#stageCfg.buff>1
self.buffList:setChildLayoutGroupCreateItems(#stageCfg.buff,function(index)
local item=self.buffList:getChildLayoutGroupGridItem(index-1)
local buffData=stageCfg.buff[index]
local str=""
if buffData[1]==1 then
str=homeBuffModel:getBuffDescByStateId(buffData[2])
elseif buffData[1]==2 then
str=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffData[2],"desc2")
end
local obj=item:GetChildGameObject(1)
local width=item:GetChildSizeDeltaX(1)
str=comHelper.getCheckLayoutStr(obj,width,str)
if index==1 then
local find=string.find(str,'\n')
multi=multi or find~=nil
end
item:SetChildText(0,str)
item:SetChildTextAlignment(0,multi and 3 or 4)
item:ForceLayoutRect(0)
end)
self.winlua:ForceLayoutRect(self.buffList:getID())
self.buffEmpty:setActive(#stageCfg.buff<=0)
self:stopStateTick()
else
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
self.nameTx:setText(buildCfg.name)
local modelParams=comHelper.getMonsterGroupModelParams(mojiangData.monster_id)
local scales2=comHelper.getModelScales2Config(modelParams.body,31)or defaultT
self.monsterModel:setChildUIModelShowTarget(modelParams.body,scales2[1]or 1,modelParams.componets,modelParams.anim,false,false,0)
self.monsterModel:setChildUIModelShowTargetOffset(scales2[2]or 0,scales2[3]or 0)
self.hpProgressBar:setProgressValue(mojiangData.hp,10000)
self.hpProgressBar:setChildProgressText(FMT.fmt("{0}%",mojiangData.hp/100))

self:refreshStateInfo()
end
end

function UIZhengTaoMoJiangFightSituationWin:refreshStateInfo()
local build_id=self.dataList[self.selectIndex].id
local nowTime=timeHelper.getServerShortTime()
local stageCfg=self.stage:getConfig("mojiang",build_id)
local stateCfg=stageCfg.stage
local deltaTime=nowTime-self.stage.beginTime
local stateCnt=#stateCfg
local state=stateCnt
for i,v in ipairs(stateCfg)do
if deltaTime<=v[1]then
state=i
break
end
end
local stateInfo=stateCfg[state]
local stateName=stateInfo[5]
self.stateName:setText(stateName)

local fazeList=stateInfo[2]
self.stateList:setChildLayoutGroupCreateItems(#fazeList,function(index)
local item=self.stateList:getChildLayoutGroupGridItem(index-1)
local fzData=fazeList[index]
local fzId=fzData[1]
local fzLv=fzData[2]
local fazeCfg=cfgHelper.getSSlawRule(fzId)
local descparm=fazeCfg.descparm
local str=descparm and string.format(fazeCfg.desc,unpack(descparm[fzLv]))or fazeCfg.desc
local obj=item:GetChildGameObject(1)
local width=item:GetChildSizeDeltaX(1)
str=comHelper.getCheckLayoutStr(obj,width,str)
item:SetChildText(0,str)
item:ForceLayoutRect(0)
end)
self.winlua:ForceLayoutRect(self.stateList:getID())
self.stateEmpty:setActive(#fazeList<=0)
self.stateNameBg:setSprite(_abName,stateInfo[6])
if state<stateCnt then
local stateTime=self.stage.beginTime+stateInfo[1]
self:startStateTick(stateTime)
else
self:stopStateTick()
end
end

function UIZhengTaoMoJiangFightSituationWin:startStateTick(stateTime)
self:stopStateTick()
local nowTime=timeHelper.getServerShortTime()
self.stateTick=self:delayDo(stateTime-nowTime,function()
self:refreshStateInfo()
end)
end

function UIZhengTaoMoJiangFightSituationWin:stopStateTick()
if self.stateTick then
self:stopTimerByID(self.stateTick)
self.stateTick=nil
end
end

function UIZhengTaoMoJiangFightSituationWin.on_39_11(seasonType,stageIndex,build_id,hp)
local _seasonType=_this.stage.handle.id
local _stageIndex=_this.stage.index
if _seasonType==seasonType and _stageIndex==stageIndex then
local _build_id=_this.dataList[_this.selectIndex].id
if _build_id==build_id then
local mojiangData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
local hp=mojiangData.hp
_this.hpProgressBar:setProgressValue(hp,10000)
_this.hpProgressBar:setChildProgressText(FMT.fmt("{0}%",hp/100))
end
end
end

function UIZhengTaoMoJiangFightSituationWin.onSeasonChange()
_this.stage=seasonModel:findFirstDoingStage(seasonStageType.eMJHD)
if _this.stage then
_this:refreshMonsters()
_this:refreshPanel()
else
_this:onCloseBtn()
end
end

function UIZhengTaoMoJiangFightSituationWin.onSeasonStageChange(seasonType,stageIndex)
local _seasonType=_this.stage.handle.id
local _stageIndex=_this.stage.index
if _seasonType==seasonType and _stageIndex==stageIndex then
for i,v in ipairs(_this.item)do
_this:refreshMonster(i)
end
_this:refreshPanel()
end
end