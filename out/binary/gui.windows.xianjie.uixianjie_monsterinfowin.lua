







def_class("UIXianJie_monsterInfoWin",UIWindowBase)








function UIXianJie_monsterInfoWin:bindComponents()

self.commitBtn=UIButton.get(self,0)
self.commitBtnTxt=UIText.get(self,1)
self.costBg=UIObject.get(self,2)
self.costIcon=UIImage.get(self,3)
self.costNum=UIText.get(self,4)
self.costTimeItem=UIObject.get(self,5)
self.exBtns=UIObject.get(self,6)
self.findXg=UIObject.get(self,7)
self.lockBtn=UIButton.get(self,8)
self.lockPanel=UIObject.get(self,9)
self.lockTxt=UIText.get(self,10)
self.mask=UIButton.get(self,11)
self.mjslpanel=UIObject.get(self,12)
self.mjslskill=UIObject.get(self,13)
self.monsterInfo=UIObject.get(self,14)
self.monsterRewardDetailbtn=UIButton.get(self,15)
self.mzrewardbtn=UIButton.get(self,16)
self.noAttackTimeLeft=UIText.get(self,17)
self.noAttackTips=UIText.get(self,18)
self.posTxt=UIText.get(self,19)
self.progressbar=UIObject.get(self,20)
self.progressValue=UIObject.get(self,21)
self.progressValueTxt=UIText.get(self,22)
self.proroot=UIObject.get(self,23)
self.proTipbtn=UIButton.get(self,24)
self.proTitle=UIText.get(self,25)
self.recommendedItem=UIObject.get(self,26)
self.recommendjzItem=UIObject.get(self,27)
self.recordBtn=UIButton.get(self,28)
self.rewardPanel=UIObject.get(self,29)
self.rewardPanelBg1=UIObject.get(self,30)
self.rewardPanelBg2=UIObject.get(self,31)
self.rewardTips=UIText.get(self,32)
self.rewardView=UIObject.get(self,33)
self.root=UIObject.get(self,34)
self.ruleBtn=UIButton.get(self,35)
self.shareBtn=UIButton.get(self,36)
self.shdBtn=UIButton.get(self,37)
self.shdTx=UIText.get(self,38)
self.showRewardBtn=UIButton.get(self,39)
self.stateLayout=UIObject.get(self,40)
self.stateTimeTxt=UIText.get(self,41)
self.stateTxt=UIText.get(self,42)
self.teamItem=UIObject.get(self,43)
self.texingBtn=UIButton.get(self,44)
self.timeRemaining=UIObject.get(self,45)
self.TisBtn=UIButton.get(self,46)
self.troopsItem=UIObject.get(self,47)
self.unlockPanel=UIObject.get(self,48)
self.xjbjbtn=UIButton.get(self,49)
self.xmItem=UIObject.get(self,50)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.lockBtn:setButtonClick(function()self:onLockBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.monsterRewardDetailbtn:setButtonClick(function()self:onMonsterRewardDetailbtn()end)

self.mzrewardbtn:setButtonClick(function()self:onMzrewardbtn()end)

self.proTipbtn:setButtonClick(function()self:onProTipbtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.shdBtn:setButtonClick(function()self:onShdBtn()end)

self.showRewardBtn:setButtonClick(function()self:onShowRewardBtn()end)

self.texingBtn:setButtonClick(function()self:onTexingBtn()end)

self.TisBtn:setButtonClick(function()self:onTisBtn()end)

self.xjbjbtn:setButtonClick(function()self:onXjbjbtn()end)



end


function UIXianJie_monsterInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitBtnTxt);self.commitBtnTxt=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costTimeItem);self.costTimeItem=nil;
_UIObject_release(self.exBtns);self.exBtns=nil;
_UIObject_release(self.findXg);self.findXg=nil;
_UIObject_release(self.lockBtn);self.lockBtn=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.lockTxt);self.lockTxt=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.mjslpanel);self.mjslpanel=nil;
_UIObject_release(self.mjslskill);self.mjslskill=nil;
_UIObject_release(self.monsterInfo);self.monsterInfo=nil;
_UIObject_release(self.monsterRewardDetailbtn);self.monsterRewardDetailbtn=nil;
_UIObject_release(self.mzrewardbtn);self.mzrewardbtn=nil;
_UIObject_release(self.noAttackTimeLeft);self.noAttackTimeLeft=nil;
_UIObject_release(self.noAttackTips);self.noAttackTips=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.progressValueTxt);self.progressValueTxt=nil;
_UIObject_release(self.proroot);self.proroot=nil;
_UIObject_release(self.proTipbtn);self.proTipbtn=nil;
_UIObject_release(self.proTitle);self.proTitle=nil;
_UIObject_release(self.recommendedItem);self.recommendedItem=nil;
_UIObject_release(self.recommendjzItem);self.recommendjzItem=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardPanelBg1);self.rewardPanelBg1=nil;
_UIObject_release(self.rewardPanelBg2);self.rewardPanelBg2=nil;
_UIObject_release(self.rewardTips);self.rewardTips=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.shdBtn);self.shdBtn=nil;
_UIObject_release(self.shdTx);self.shdTx=nil;
_UIObject_release(self.showRewardBtn);self.showRewardBtn=nil;
_UIObject_release(self.stateLayout);self.stateLayout=nil;
_UIObject_release(self.stateTimeTxt);self.stateTimeTxt=nil;
_UIObject_release(self.stateTxt);self.stateTxt=nil;
_UIObject_release(self.teamItem);self.teamItem=nil;
_UIObject_release(self.texingBtn);self.texingBtn=nil;
_UIObject_release(self.timeRemaining);self.timeRemaining=nil;
_UIObject_release(self.TisBtn);self.TisBtn=nil;
_UIObject_release(self.troopsItem);self.troopsItem=nil;
_UIObject_release(self.unlockPanel);self.unlockPanel=nil;
_UIObject_release(self.xjbjbtn);self.xjbjbtn=nil;
_UIObject_release(self.xmItem);self.xmItem=nil;
end
















local _this
local _colorKuang={
[xjServerEnityType.eMonster]={
[0]="image_gwtouxiangpjk_2",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eBossMonster]={
[0]="image_gwtouxiangpjk_4",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMonsterHouse]={
[0]="image_gwtouxiangpjk_5",
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_5",
},

[xjServerEnityType.eMoJieMoZong_Small]={
[0]="image_gwtouxiangpjk_3",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieMoZong_Big]={
[0]="image_gwtouxiangpjk_3",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJingZhenJi_Normal]={
[0]="image_gwtouxiangpjk_5",
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_5",
},
[xjServerEnityType.eMoJieMoJunYaoMo]={
[0]="image_gwtouxiangpjk_5",
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_5",
},
[xjServerEnityType.eMoJieMoster]={
[0]="image_gwtouxiangpjk_2",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieShangGuMoster]={
[0]="image_gwtouxiangpjk_3",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieZhenYan_Small]={
[0]="image_gwtouxiangpjk_3",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieZhenYan_Big]={
[0]="image_gwtouxiangpjk_3",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieZhenYan_Spe]={
[0]="image_gwtouxiangpjk_3",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
}
local _showModel={
[xjServerEnityType.eMonster]=false,
[xjServerEnityType.eBossMonster]=false,
[xjServerEnityType.eMonsterHouse]=false,
[xjServerEnityType.eMoJieMoZong_Small]=false,
[xjServerEnityType.eMoJieMoZong_Big]=false,
[xjServerEnityType.eMoJieMoster]=false,
[xjServerEnityType.eMoJieShangGuMoster]=false,
[xjServerEnityType.eMoJieZhenYan_Small]=false,
[xjServerEnityType.eMoJieZhenYan_Big]=false,
[xjServerEnityType.eMoJieZhenYan_Spe]=false,
}
local _showType={
[xjServerEnityType.eBossMonster]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hujianguiwu_03"},
[xjServerEnityType.eMonsterHouse]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hujianguiwu_04"},
[xjServerEnityType.eMoJieMoZong_Small]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_mozontouxiang_1"},
[xjServerEnityType.eMoJieMoZong_Big]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_mozontouxiang_1"},
[xjServerEnityType.eMoJieZhenYan_Small]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_zhenyan_1"},
[xjServerEnityType.eMoJieZhenYan_Big]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_zhenyan_1"},
[xjServerEnityType.eMoJieZhenYan_Spe]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_zhenyan_1"},
}
local _showFlag={
[1]=10,
[2]=12,
}

local _showPro={
[xjServerEnityType.eMoJieMoZong_Small]={proNmae="魔兵",showProTipBtn=true},
[xjServerEnityType.eMoJieMoZong_Big]={proNmae="魔兵",showProTipBtn=true},
[xjServerEnityType.eMoJieZhenYan_Small]={proNmae="魔兵",showProTipBtn=true},
[xjServerEnityType.eMoJieZhenYan_Big]={proNmae="魔兵",showProTipBtn=true},
[xjServerEnityType.eMoJieZhenYan_Spe]={proNmae="魔兵",showProTipBtn=true},
}

local _showTipBtn={
[xjServerEnityType.eMoJieMoZong_Small]=true,
[xjServerEnityType.eMoJieMoZong_Big]=true,
[xjServerEnityType.eMoJieZhenYan_Small]=true,
[xjServerEnityType.eMoJieZhenYan_Big]=true,
[xjServerEnityType.eMoJieZhenYan_Spe]=true,
}

local _newbieTrigger={
[xjServerEnityType.eBossMonster]=function(monsterData)
local check=xianjieModel:getMonsterSeasonCheck(monsterData.entitytype)
local unlock=seasonController:checkSeasonStageBegined(check[1],check[2])
local free=xianjieModel:checkXJHasYunZhou()

return unlock and free
end,
}

local _noState={
[xjServerEnityType.eMoJieShangGuMoster]=true
}

local forceBuffshow={
[xjServerEnityType.eMoJieMoZong_Small]=true,
[xjServerEnityType.eMoJieMoZong_Big]=true,
[xjServerEnityType.eMoJieMoJunYaoMo]=true,
[xjServerEnityType.eMoJieMoJunFenShen]=true,
[xjServerEnityType.eMoJieMoster]=true,
[xjServerEnityType.eMoJieShangGuMoster]=true,
[xjServerEnityType.eMoJieZhenYan_Small]=true,
[xjServerEnityType.eMoJieZhenYan_Big]=true,
[xjServerEnityType.eMoJieZhenYan_Spe]=true,
}
local slskillidx=
{
skillbtn=0,
icon=1,
name=2,
djsbg=3,
djs=4
}
local _btnName={
[xjServerEnityType.eMoJieMoZong_Small]="进攻",
[xjServerEnityType.eMoJieMoZong_Big]="进攻",
[xjServerEnityType.eMoJieZhenYan_Small]="进攻",
[xjServerEnityType.eMoJieZhenYan_Big]="集结",
[xjServerEnityType.eMoJieZhenYan_Spe]="进攻",
[xjServerEnityType.eMonsterHouse]="进攻",
}


function UIXianJie_monsterInfoWin:onLoaded(...)
self:bindComponents()
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.onXianJieMonsterChange,self.onXianJieMonsterChange)
self:addNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.on_system_open,self.on_system_open)
self:addProNotify(35,63,self.on_35_63)
self:addProNotify(35,198,self.on_35_198)
self:addProNotify(35,10,self.on_35_10)
local widget=self.teamItem:getWidgetBase()
widget:SetChildButtonClick(1,function()
self:onClickTeamBtn()
end)
end


function UIXianJie_monsterInfoWin:__delete()
_this=nil
self:stopNoAttackTimeLeft()
self:unbindComponents()
xianjieController:closeWin2('UIXianJie_monsterInfoWin')
self:stopSelfTimerMJSL()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if monsterData then
monsterData:selectEntity(false)
end
end


function UIXianJie_monsterInfoWin:onHide()

end



function UIXianJie_monsterInfoWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then
return
end
xianjieController:closeWin3()
end

function UIXianJie_monsterInfoWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then
return
end
xianjieController:closeWin3()
end

function UIXianJie_monsterInfoWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then
return
end
_this:onCloseClick()
end

function UIXianJie_monsterInfoWin.onXianJieMonsterChange(typo,infoguid)
if _this==nil or not _this.isVisible then
return
end
if typo==CHANGE_TYPE.eDelete then
if tostring(_this.infoguid)==tostring(infoguid)then
xianjieController:closeWin3()
end
end
end

function UIXianJie_monsterInfoWin.onNewDay5am()
if _this==nil or not _this.isVisible then
return
end
_this:refreshRewardTimes()
end

function UIXianJie_monsterInfoWin.on_35_63(infoguid)
if _this.infoguid==infoguid then
_this:refreshTeamInfo()
end
end
function UIXianJie_monsterInfoWin.on_35_198(infoguid)
if _this.infoguid==infoguid then
_this:refreshTeamInfo()
end
end

function UIXianJie_monsterInfoWin.on_35_10()
if _this==nil or not _this.isVisible then
return
end
_this:refreshRewardTimes()
end





function UIXianJie_monsterInfoWin:onShow(argtable,afterOnloaded)
self.infoguid=argtable.infoguid

if self.mytimer==nil then
_this:updateTime()
self.mytimer=self:setTimer(1,0,function()
_this:updateTime()
end)
end
local monsterData=xianjieModel:getMonsterData(self.infoguid)

if monsterData==nil then
self:closeSelf()
return
else
self:refreshInfo(monsterData)

local trigger=_newbieTrigger[monsterData.entitytype]
if trigger and trigger(monsterData)then
local key=FMT.fmt("FirstXianJieMonsterInfoOpen_{0}",monsterData.entitytype)
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME[key])
end
local _sceneidx=monsterData.sceneidx
if not xianjieModel:checkMonsterTeamInfoCacheValid(self.infoguid)then
if xianjienSceneIndexType:isMoJie(_sceneidx)then
xianjieController:reqMoJieMonsterTeamInfo(self.infoguid)
else
xianjieController:reqMonsterTeamInfo(self.infoguid)
end
end
end
if afterOnloaded then
if monsterData then
monsterData:selectEntity(true)
end
end


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

self:refreshShdBtn()
end

function UIXianJie_monsterInfoWin:onShowArgRecv(argtable)
local oldGuid=self.infoguid
if oldGuid and oldGuid~=argtable.infoguid then
local monsterData=xianjieModel:getMonsterData(oldGuid)
if monsterData then
monsterData:selectEntity(false)
end
monsterData=xianjieModel:getMonsterData(argtable.infoguid)
if monsterData then
monsterData:selectEntity(true)
end
end
self:refreshView(argtable.infoguid)
end

function UIXianJie_monsterInfoWin:updateTime()
if self.isActiveTimer then
self:refreshStateDesc()
end
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if not monsterData then
return
elseif monsterData.expiresec~=0 then
self:refreshTimeRemaining()
end
end

function UIXianJie_monsterInfoWin:refreshView(infoguid)
if mathHelper.compareInt64(self.infoguid,infoguid)then
return
end
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if monsterData==nil then
self:closeSelf()
return
end

self.infoguid=infoguid
self:refreshInfo()
self:refreshShdBtn()
end

function UIXianJie_monsterInfoWin:onLoadFinish()
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.3,func)
end

function UIXianJie_monsterInfoWin:refreshInfo(monsterData)
if monsterData==nil then
monsterData=xianjieModel:getMonsterData(self.infoguid)
end
if monsterData==nil then
return
end
local cfg=monsterData:getCfg()
self.sharecfg=cfg


local gridX_c,gridZ_c=monsterData:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c
self.mstentitytype=monsterData.entitytype
local isZhenJi=monsterData.entitytype==xjServerEnityType.eMoJingZhenJi_Normal


local monsterInfoWidget=self.monsterInfo:getWidgetBase()
local groupid=cfg.monster[1]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
if not _showModel[monsterData.entitytype]then

monsterInfoWidget:SetChildActive(6,true)
monsterInfoWidget:SetChildUIModelRemoveTarget(0)
monsterInfoWidget:SetChildCSImageSprite(6,globalABLookup.global,_colorKuang[monsterData.entitytype][cfg.flag or 0])
comHelper.setChildModelRawImage_monsterGroup(monsterInfoWidget,groupid,7,0,eHeadCenterType.eHead)


else
monsterInfoWidget:SetChildActive(6,false)


local uiModelParam=cfg.uiModelParam or{}
local size=uiModelParam.size or groupcfg.model[2]*0.4
monsterInfoWidget:SetChildUIModelShowTarget(0,cfg.modelSet.model,size,cfg.modelSet.components,eAnimationID.stand,false,false,0)

local offset=uiModelParam.offset or{0,0}
monsterInfoWidget:SetChildUIModelShowTargetOffset(0,offset[1],offset[2])
local isFlip=uiModelParam.isFlip and uiModelParam.isFlip==1 or false
monsterInfoWidget:SetChildUIModelShowFlipX(0,isFlip)



end
for i,v in pairs(_showFlag)do
monsterInfoWidget:SetChildActive(v,i==cfg.flag)
end

local typeImg=_showType[monsterData.entitytype]
if typeImg then
monsterInfoWidget:SetChildCSImageSprite(11,typeImg[1],typeImg[2])
else
monsterInfoWidget:SetChildCSImageIcon(11,"",true)
end
local showProCfg=_showPro[monsterData.entitytype]
if showProCfg then
monsterInfoWidget:SetChildActive(1,false)
monsterInfoWidget:SetChildActive(13,true)
monsterInfoWidget:SetChildText(15,showProCfg.proNmae)
if showProCfg.showProTipBtn then
monsterInfoWidget:SetChildActive(16,true)
monsterInfoWidget:SetChildButtonClick(16,function()
self:proTipBtnClick(monsterData)
end)
else
monsterInfoWidget:SetChildActive(16,false)
end
self:refreshProValue()
else
monsterInfoWidget:SetChildActive(1,true)
monsterInfoWidget:SetChildActive(13,false)

local stage=cfg.stage or 1

local hideStage
if monsterData then
if monsterData.entitytype==xjServerEnityType.eMoJieMoJunYaoMo then
hideStage=true
end
end
local nameStr=hideStage and groupcfg.name or FMT.fmt("{0}阶 {1}",stage,groupcfg.name)
if _noState[monsterData.entitytype]then
nameStr=groupcfg.name
end



monsterInfoWidget:SetChildText(1,nameStr)
end

monsterInfoWidget:SetChildActive(19,isZhenJi)
if isZhenJi then
monsterInfoWidget:SetChildCSImageSprite(19,globalABLookup.global,FMT.fmt("icon_yuansu_{0}",cfg.wxType or 1))
end
monsterInfoWidget:SetChildActive(20,monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe)



local monsterSceneIdx=monsterData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(monsterSceneIdx)then

self.costTimeItem:setActive(false)
else
self.costTimeItem:setActive(true)
local costTimeWidget=self.costTimeItem:getWidgetBase()
local wayTime=monsterData:getBaseWayTime()
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
costTimeWidget:SetChildText(0,time_str)
end

self.rewardPanelBg1:setActive(monsterData.entitytype~=xjServerEnityType.eMonsterHouse)
self.rewardPanelBg2:setActive(monsterData.entitytype==xjServerEnityType.eMonsterHouse)





























self:refreshTeamInfo()




local recommendedWidget=self.recommendedItem:getChildWidgetBase()
local recommendedStr=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"recommend",monsterData.entitytype,cfg.stage)
if recommendedStr==nil then
logErr("仙界配置- 基础配置 recommend 缺少配置",monsterData.entitytype,cfg.stage)
end
recommendedStr=mathHelper.formatNumber(recommendedStr)
recommendedWidget:SetChildText(0,recommendedStr)

local recommendjzStr
local recommendjz=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"recommendJZ")
if recommendjz then
local ent_recommendjz=recommendjz[monsterData.entitytype]or{}
recommendjzStr=ent_recommendjz[cfg.stage]
end
self.recommendjzItem:setActive(recommendjzStr~=nil)
if recommendjzStr then
local recommendjzWidget=self.recommendjzItem:getChildWidgetBase()
recommendjzWidget:SetChildText(0,recommendjzStr)
end

self.troopsItem:setActive(false)
























local haveCost=cfg.consume~=nil and#cfg.consume>0
self.costBg:setActive(haveCost)
if haveCost then
local itemId=cfg.consume[1][1]
local itemNum=cfg.consume[1][2]
local haveNum=itemsModel.getCount(itemId)
local numColor=haveNum>=itemNum and"549327"or"c82c2c"
self.costIcon:setImageIcon(iconHelper.getIconName(itemId),false)
self.costNum:setText(FMT.fmt("消耗：<color=#{1}>{0}</color>",mathHelper.formatNumber(itemNum),numColor))

self.winlua:ForceLayoutRect(self.costBg:getID())
end


local dropCfg=cfgHelper.get1(cfg_awardconfig_get,cfg.drop)
local rewards=dropCfg.showItems or{}

if cfg.ex_drop then
local csid=xianjieModel:getMoJieEnterConfig('csid')
local ex_drop=cfg.ex_drop[csid]
local ex_dropCfg=cfgHelper.get1(cfg_awardconfig_get,ex_drop[2])
local ex_dropItems=ex_dropCfg.showItems or{}
local ispass=false
local csid=xianjieController:getMoJieSaiJiWanFaID()
if ex_drop[1]==0 then
ispass=true
elseif csid and seasonController:checkSeasonStageBegined(csid,ex_drop[1])then
ispass=true
end
if ispass then
local rewards2=table.weakCopy(ex_dropItems)
local old_rewards=dropCfg.showItems or{}
for k,v in ipairs(old_rewards)do
table.insert(rewards2,v)
end
rewards=rewards2
end
end
local rnum=#rewards
self.rewardPanel:setChildLayoutGroupCreateItems(rnum)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
local itemData=rewards[i]
local itemid=itemData[1]
local itemnum=itemData[2]
local percent=itemData[4]
local isxmkf=itemData.isxmkf or false
local itemcount,showCountBG
local isShowPercent=percent~=nil
local range
if percent then
showCountBG=false
itemcount=""
else
range=itemData.range
if itemnum>1 or itemData.range~=nil then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
end

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false,range=range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then
return
end
_this:onClickItem(...)
end)

local showSign=itemnum<=0 and itemData.range==nil and percent==nil
rwItem:SetChildActive(1,showSign)
rwItem:SetChildActive(2,isShowPercent)
if isShowPercent then
rwItem:SetChildText(3,FMT.fmt("{0}%",percent))
end
rwItem:SetChildActive(4,isxmkf)

end
self.rewardView:setChildScrollRectEnable(rnum>=5)

local check=xianjieModel:getMonsterSeasonCheck(monsterData.entitytype)
local unlock=check and seasonController:checkSeasonStageBegined(check[1],check[2])or true
if check then
local seasonName=seasonModel:getHandleConfig(check[1],'name')
local chapter_idx=mathHelper.numberToChinese(check[2])
local chapterName=seasonModel:getStageConfigEx(check[1],check[2],"name")
local lockStr=FMT.fmt("【{0}-第{1}章·{2}】解锁征讨",seasonName,chapter_idx,chapterName)
self.lockTxt:setText(lockStr)
else
self.lockTxt:setText("")
end




local marchguid
self.isActiveTimer=nil
local wpData=xianjieModel:getWaiPaiByQBEntityData2(xjWaiPiaBaseType.eMarckTeam,self.infoguid)
if wpData then
marchguid=wpData.guid
self.isActiveTimer=true
else
local teamData=xianjieModel:getSelfJiJieTeamDataByInfoguid(self.infoguid)
if teamData then
local teamHandleId=teamData.teamHandleId
local teamHandle_=xianjieController:getXJTeamHandle(teamHandleId)
local state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjJiJieTeamStateType.eNone then
self.isActiveTimer=true
end
end
end
self.marchguid=marchguid
self:refreshStateDesc()


local btnStr=_btnName[monsterData.entitytype]or"征讨"

if monsterData.entitytype==xjServerEnityType.eMonsterHouse and cfg.flag and cfg.flag==2 then
local entityType=monsterData.entitytype
entityType=bit.lshift(cfg.flag,8)+entityType
local rewardTimeConf=xianjieModel:getMonsterInfoCfg(entityType)
local maxTimes=rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(monsterData.entitytype,cfg.flag)
local least=maxTimes-curTimes
if least<=0 then
btnStr=string.format("<color=#c82c2c>集结</color>")
end
end
self.commitBtnTxt:setText(btnStr)

self:refreshRewardTimes(monsterData)
local cfg=monsterData:getCfg()
local isShowMonsterDetailBtn=monsterData.entitytype==xjServerEnityType.eMonster
or monsterData.entitytype==xjServerEnityType.eBossMonster
or monsterData.entitytype==xjServerEnityType.eMonsterHouse


if monsterData.entitytype==xjServerEnityType.eMonsterHouse and cfg.flag and cfg.flag==2 then
if not xianguanHelper.checkTeQuanPlatformLimit(XIANGUAN_PRIVILEGE_ENUM.eXunYouWanJie)then
isShowMonsterDetailBtn=false
end
end
self.monsterRewardDetailbtn:setActive(isShowMonsterDetailBtn)

if monsterData.actorid and tostring(monsterData.actorid)~='0'then
local zmdata=xianjieModel:getZongMenData(monsterData.actorid)
local actorname=zmdata.actorname
local serverid=zmdata.serverid
self.findXg:setActive(true)
local findXgWidget=self.findXg:getChildWidgetBase()
findXgWidget:SetChildText(0,actorname)
findXgWidget:SetChildButtonClick(1,function()
local attach={}
if serverid~=playerModel:getActorServerID()then
attach={serverid=serverid}
end
otherPlayerController:openOtherPlayerInfoWin(monsterData.actorid,nil,nil,attach)
end)
else
self.findXg:setActive(false)
end

self.timeRemaining:setActive(monsterData.expiresec~=0)
self.TisBtn:setActive(_showTipBtn[monsterData.entitytype]==true)

self:freshMoJiePnael(monsterData)
self:freshMoJieSkillPnael(monsterData)
self:freshTSZMGuiShu()

self:freshMzrewardPanel()

local isNoAttack=false
if monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe then
local constDef=monsterData:getConstDefCfg()
local forbid_attack_time=constDef.forbid_attack_time or 0
local cTime=timeHelper.getServerShortTime()
local sTime=monsterData.forbid_atk_sec
local left=forbid_attack_time-(cTime-sTime)
isNoAttack=left>0
end
self.noAttackTips:setActive(isNoAttack)
self:refreshNoAttackTimeLeft(monsterData)

self.unlockPanel:setActive(unlock and not isNoAttack)
self.lockPanel:setActive(not unlock)
end

function UIXianJie_monsterInfoWin:refreshRewardTimes(monsterData)
if monsterData==nil then
monsterData=xianjieModel:getMonsterData(self.infoguid)
end

if monsterData==nil then
return
end
local rewardTipsStr="征讨奖励"
local entityType=monsterData.entitytype

local cfg=monsterData:getCfg()
if cfg.flag and cfg.flag==2 then
entityType=bit.lshift(cfg.flag,8)+entityType
end
local rewardTimeConf=xianjieModel:getMonsterInfoCfg(entityType)
if rewardTimeConf then
local maxTimes=rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(monsterData.entitytype,cfg.flag)
local least=maxTimes-curTimes
self.sgleast=least
local color=least>0 and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
rewardTipsStr=FMT.fmt("{0}(剩余<color={2}>{1}</color>/{3}次)",rewardTipsStr,least,FONT_COLOR_VAL[color],rewardTimeConf[1]+rewardTimeConf[2])
end

if entityType==xjServerEnityType.eMoJieMoZong_Big or entityType==xjServerEnityType.eMoJieMoZong_Small or entityType==xjServerEnityType.eMoJieZhenYan_Small or entityType==xjServerEnityType.eMoJieZhenYan_Big or entityType==xjServerEnityType.eMoJieZhenYan_Spe then
rewardTipsStr="宗门仓库"
end


self.rewardTips:setText(rewardTipsStr)
end

function UIXianJie_monsterInfoWin:refreshLife(widget,monsterData)
if widget==nil then
widget=self.monsterInfo:getWidgetBase()
end
if monsterData==nil then
monsterData=xianjieModel:getMonsterData(self.infoguid)
end
local hp=monsterData.hp
widget:SetChildIconFillAmount(10,hp/10000)
local rate_str=FMT.fmt('{0}%',hp/100)
widget:SetChildText(11,rate_str)
end

function UIXianJie_monsterInfoWin:refreshTeamInfo()
local widget=self.teamItem:getWidgetBase()
local teamInfos=xianjieModel:readMonsterTeamInfo(self.infoguid)
local teamCnt=teamInfos and#teamInfos.data or 0
local haveTeam=teamCnt>0
local str=haveTeam and FMT.fmt("前往中（<color=#ca631d>{0}</color>）",teamCnt)or"无"
widget:SetChildActive(1,haveTeam)
widget:SetChildText(0,str)
end

function UIXianJie_monsterInfoWin:refreshStateDesc()
local teamHandle
local state,timeData,lerp
local desc
if self.marchguid then
local teamData=xianjieModel:getMarchTeamData(self.marchguid)
if teamData then
local teamHandle_=teamData:getTeamHandle()
state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjMarchTeamStateType.eNone then
teamHandle=teamHandle_
desc=xjMarchTeamStateType:getDesc(state)or''
end
end
if teamHandle==nil then
self.marchguid=nil
end
else
local teamData=xianjieModel:getSelfJiJieTeamDataByInfoguid(self.infoguid)
if teamData then
local teamHandleId=teamData.teamHandleId
local teamHandle_=xianjieController:getXJTeamHandle(teamHandleId)
state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjJiJieTeamStateType.eNone then
teamHandle=teamHandle_
desc=xjJiJieTeamStateType:getDesc(state)or''
end
end
end

local hasWaiPai=teamHandle~=nil

local showBtn=not hasWaiPai
self.commitBtn:setActive(showBtn)

self.stateLayout:setActive(hasWaiPai)
if hasWaiPai then
self.stateTxt:setText(desc)
local time_str
if lerp>0 then
time_str=timeHelper.format_time_stamp3(lerp)
else
time_str='--'
end
self.stateTimeTxt:setText(time_str)
else
self.isActiveTimer=nil
end
end

function UIXianJie_monsterInfoWin:refreshTimeRemaining()
if not _this then
return
end
local monsterData=xianjieModel:getMonsterData(_this.infoguid)
local timeRemainingWidget=_this.timeRemaining:getChildWidgetBase()
_this.timeRemaining:setActive(monsterData.expiresec~=0)

local nowtime=timeHelper.getServerShortTime()
local lerp=monsterData.expiresec-nowtime
local time_str

if lerp>0 then
time_str=timeHelper.format_time_stamp3(lerp)
else
time_str='--'
end
timeRemainingWidget:SetChildText(0,time_str)
end

function UIXianJie_monsterInfoWin:onLockBtn()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local check=xianjieModel:getMonsterSeasonCheck(monsterData.entitytype)
if check[1]==0 then
jumpManager:jump({id=JUMP_TYPE.eChongJianXianYu,args={chapter_idx=check[2]}})
end
end

function UIXianJie_monsterInfoWin:onClickTeamBtn()
local args={
parentWin=self,
infoguid=self.infoguid
}
self:showWindow("UIXianJie_monsterTeamWin",args)
end

function UIXianJie_monsterInfoWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXianJie_monsterInfoWin:onCloseClick(atOnce)
xianjieController:closeWin('UIXianJie_monsterInfoWin',atOnce)
end

function UIXianJie_monsterInfoWin:onCommitBtn()

local flag=xianjieModel:checkTriggerSeasonStageBehaivour()
if flag then
_this:onCloseClick()
return
end
local infoguid=self.infoguid
local monsterData=xianjieModel:getMonsterData(infoguid)
local check=xianjieModel:getMonsterSeasonCheck(monsterData.entitytype)
if check and not seasonController:checkSeasonStageBegined(check[1],check[2])then
local seasonName=seasonModel:getHandleConfig(check[1],"name")
local stageName=seasonModel:getStageConfigEx(check[1],check[2],"name")
return UIManager.error(FMT.fmt("{0}·{1}开放后开启",seasonName,stageName))
end


local monsterSceneIdx=monsterData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(monsterSceneIdx)then

return UIManager.error("无法前往其他仙域")
end

local flag,g_list,errorParams=monsterData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法进攻本阵内的魔物"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法进攻阵外的魔物"
else

errStr="处于本阵内无法进攻其他本阵内的魔物"
end
UIManager.error(errStr)
end
return
end

if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end

local cfg=monsterData:getCfg()

local isWarringXianXuTimes=false


if monsterData.entitytype==xjServerEnityType.eMonsterHouse then
local entityType=monsterData.entitytype
if cfg.flag then
entityType=bit.lshift(cfg.flag,8)+entityType
end
local rewardTimeConf=xianjieModel:getMonsterInfoCfg(entityType)
local maxTimes=rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(monsterData.entitytype,cfg.flag)
local least=maxTimes-curTimes
if least<=0 and cfg.flag and cfg.flag==2 then
UIManager.error("征讨奖励剩余次数已用完")
return
elseif least==1 then
local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
for k,v in ipairs(teamHandleList)do

if v.teamData and v.teamData.infoguid then
local teamEntityType=xianjieModel:getEntityTypeByGuid(v.teamData.infoguid,v.teamData.sceneidx)

if teamEntityType==xjServerEnityType.eMonsterHouse then
local teamMonsterData=xianjieModel:getMonsterData(v.teamData.infoguid)
local teamMonsterCfg=teamMonsterData:getCfg()
if(teamMonsterCfg.flag and teamMonsterCfg.flag==2 and cfg.flag==2)or(cfg.flag~=2 and teamMonsterCfg.flag~=2)then
isWarringXianXuTimes=true
break
end
end
end
end
end
end




if cfg.flag==1 then
if not zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eLaoYu,true)then
return
elseif not systemModel.isOpen(SYSTEM_DEFINE.eXianJieXianYu)then
local str=systemModel.getOpenTips(SYSTEM_DEFINE.eXianJieXianYu)
UIManager.error(str)
return
elseif not UIPrisonModel:getMoYuLockState()then
UIDialogManager.getCommonDialog(nil,"魔狱未建造，无法发起征讨\n是否前往建造",function()
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eLaoYu,args={weakGuide=4100}}})
end)
return
elseif not UIPrisonModel:existEmptyRoom(ePrisonRoomType.eMonster)then
UIManager.error("魔狱牢房已满，无法发起征讨")
return
elseif xianjieModel:checkFuncRewardRecvMonsterLog(item_funtion_type.eMoWuDrop,0)then
UIDialogManager.getCommonDialog(nil,"魔物奖励未领取，无法发起征讨\n是否前往领取",function()
xianjieController:OpenXianjieMonsterLog(nil,4101)
end)
return
end
end
if xjEntityShowAttackRange[monsterData.entitytype]==1 then
local zmData=xianjieModel:getZongMenData(playerModel:getActorID())
local x1=zmData.gridX
local y1=zmData.gridZ
local x2=x1+zmData.gridWidth
local y2=y1+zmData.gridHeight
local gridX_c=monsterData.gridX_c
local gridZ_c=monsterData.gridZ_c
local wrange=cfg.range+monsterData.gridWidth/2
local hrange=cfg.range+monsterData.gridHeight/2
local x1_=gridX_c-wrange
local y1_=gridZ_c-hrange
local x2_=gridX_c+wrange
local y2_=gridZ_c+hrange

if not mathHelper.rectCrashRect(x1,y1,x2,y2,x1_,y1_,x2_,y2_)then





UIManager.error("需要进入其攻击范围才可发起进攻")

return
end
end
if monsterData.entitytype==xjServerEnityType.eMoJieMoJunYaoMo then
if not xianjieModel:getMyCanTzMoJun()then
local content="宗门堡垒需处于魔宫挑战区域才能发起征讨，是否前往挑战区域？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
xianjieController:jumpMoJieMoJun(true)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return
end
end

local monsterGroupId=cfg.monster[1]
local monsterList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local monsterFight=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"recommend",monsterData.entitytype,cfg.stage)

local orderType=xjMonsterFightOrderMapping[monsterData.entitytype]or xjOrderType.eAttack
local isJiJie=orderType==xjOrderType.eJiJieInitiate

local isChuZheng,isCanChuZheng,tipsChuZheng=xianjieModel:checkXJIsChuZhengEx(orderType,false)
local wayTime=monsterData:getBaseWayTime()
if not isChuZheng then

local costList=cfg.consume
moneySystem:useMoneys(cfg.consume,function()


local winArgs={
enterCallBack=function(selectList,zfId,mapId)
local dzlist={}
for i,v in ipairs(selectList)do
table.insert(dzlist,v[2])
end

local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)

xianjieController:reqOrder(guid,orderType,dzlist,nil,nil,nil,nil,g_list)
UIManager:closeWindow('UIXianGuan_fightExtraWin')
fightController:closeSelectStage()
UIFullFightPrepareControl:closeActiveUI()

end,
enterTxt="仙界",
cancelCallBack=function()
UIManager:closeWindow('UIXianGuan_fightExtraWin')
fightController:closeSelectStage()
xianjieController:openMonsterInfoWin(infoguid)
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
isCheckXJOccupyType=true,
statePriorityCheck=false,
showZhenFa=false,





xjWayTime=wayTime,
costList=costList,
targetFight=monsterFight,
}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
xianjieModel:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end
winArgs.dzInfoFuncList=dzInfoFuncList
winArgs.checkDZSortFunc=xianjieModel.checkDZSortFunc
fightController.showPrepareWin(fightPreSelectModel.fightType.xianjieMonster,winArgs,function()
UIManager:showWindow('UIXianGuan_fightExtraWin')
end)
end,WARNING_TYPE.eWarning)

elseif isChuZheng then
if isCanChuZheng>0 then
if zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eXianYunGang,false)then

UIManager.error(tipsChuZheng)
else

local buildname=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eXianYunGang,"name")
local str=FMT.fmt("{0}未建造，无法发起征讨\n是否前往建造？",buildname)
UIDialogManager.getCommonDialog(nil,str,function()
jumpManager:jump({id=JUMP_TYPE.eUnlockRepairBuild2,args={buildType=SLG_SYSTEM_TYPE.eXianYunGang,mapid=mapIdType.fort,weakGuide=4110}})
end)
end
return
end

local extraCost=cfg.consume

if isJiJie then

local isCanJiJie,err=xianjieModel:checkCanJiJie()
if not isCanJiJie then
return UIManager.error(err)
end


local _func=function()
local minSoldierNum=1
local confirmCb=function(timeSecond)

local func=function(selectDzList,selectMoneyList,boatId)
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=orderType
local data=xianjieModel:getJiJieLocalData()or{}
local isAutoGoFlag=data.lastSelectAutoFlag or 1
local isEndGoFlag=data.lastSelectEndGoFlag or 0
local params={timeSecond,isAutoGoFlag,isEndGoFlag}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,pstr,boatId,nil,g_list)
end

local maxSoldierNum=tianShuDianController:getJiJieXiuShiMaxCount(monsterData.entitytype)
return UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,
extraCost=extraCost,
wayTime=wayTime,
jiJieTime=timeSecond,
orderType=orderType,
minSoldierNum=minSoldierNum,
maxSoldierNum=maxSoldierNum,
confirmBtnStr="发起集结",
targetFight=monsterFight,
})
end
local isXianXu=monsterData.entitytype==xjServerEnityType.eMonsterHouse
self:showWindow("UIXianJie_JiJie_initiateWin",{confirmCb=confirmCb,extraCost=extraCost,orderType=orderType,isXianXu=isXianXu})
end

local rewardTimeConf=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"info",1,monsterData.entitytype)
if rewardTimeConf and not(monsterData.entitytype==xjServerEnityType.eMonsterHouse and cfg.flag and cfg.flag==2)then
local maxTimes=rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(monsterData.entitytype)
local least=maxTimes-curTimes
if least<=0 then
local args={
content="征讨奖励次数为<color=#c82c2c>0</color>，无法获得奖励\n是否继续发起集结？",
oktext="集结",
okcb=_func
}
local _dialog=UIDialogManager.getConfirmDialogEx(nil,args)
_dialog:show()
return
end
end

if isWarringXianXuTimes then
local str=(cfg.flag and cfg.flag==2)and"预备队正在前往界游仙墟，剩余奖励次数不足，重复出发可能会无法获得奖励，是否继续参与？"or
"预备队正在前往仙墟，剩余奖励次数不足，重复出发可能会无法获得奖励，是否继续参与？"
UIDialogManager.getCommonDialog(nil,str,_func)
return
end

_func()
else

local func=function(selectDzList,selectMoneyList,boatId)
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=orderType
local params=''
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,params,boatId,nil,g_list)
end


local sg_rewardTimeConf=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"info",1,monsterData.entitytype)
if sg_rewardTimeConf and monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then
local maxTimes=sg_rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(monsterData.entitytype)
local least=maxTimes-curTimes
if least<=0 then
local sgflag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMoJieSGTips)
if not sgflag then
local _func=function()
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,extraCost=extraCost,wayTime=wayTime,orderType=orderType,targetFight=monsterFight})
end
local showdata=
{
type='UIDialouge',
title='提示',
content="征讨奖励次数为<color=#c82c2c>0</color>，无法获得奖励\n是否继续发起征讨？",
oktext='确认',
canceltext='取消',
choosetext='今日不再提示',
allowclickBG=false,
okcallback=_func,
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMoJieSGTips,flag)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
return
end
end
end
local commonFunc=function()
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,extraCost=extraCost,wayTime=wayTime,orderType=orderType,targetFight=monsterFight})
end
if monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small or
monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big then
if tianshudazhenModel:isOpeningFHZ()or tianshudazhenModel:isOpeningTianShuShenDun()then
local str="进攻魔界宗门会取消护山大阵，是否确认？"
UIDialogManager.getCommonDialog(nil,str,commonFunc)
else
commonFunc()
end
else
commonFunc()
end
end
end
end

function UIXianJie_monsterInfoWin:onTexingBtn()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local monsterCfg=monsterData:getCfg()
local winParams={
parentWin=self,
fazes=monsterCfg.faze or{},
}
self:showWindow("UIXianJie_monsterFaZeWin",winParams)
end

function UIXianJie_monsterInfoWin:onRuleBtn()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local monsterCfg=monsterData:getCfg()
local screenPos=self.ruleBtn:getChildUIScreenPos(false)
screenPos.x=screenPos.x-50
local rules
if monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then

local seasonHandle=seasonModel:getHandleByType(eSeasonType.eMJMB)
local seasonId=seasonHandle and seasonHandle.id or-1
local rulesCfgList=cfgHelper.get(cfg_devildombaseconfig_get,1,'sgMonsterTypeRule')
if not rulesCfgList[seasonId]then
seasonId=-1
end
local flag=monsterCfg.flag or 0
rules=rulesCfgList[seasonId][flag]
else
rules=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,'monsterRule',monsterData.entitytype,monsterCfg.flag or 0)
end

if rules then
local winParams={
parentWin=self,
lang=rules[1],
num=rules[2],
screenPos=screenPos,
}
self:showWindow("UIXianJie_monsterRuleWin",winParams)
end
end

function UIXianJie_monsterInfoWin:onShowRewardBtn()

local monsterData=xianjieModel:getMonsterData(self.infoguid)
local cfg=monsterData:getCfg()
if monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then
local create_drop=cfg.create_drop[1]
local drop=cfg.drop
local kill_drop=cfg.kill_reward_id

local args={
parentWin=self,
drop={create_drop,drop,kill_drop},
entityType=monsterData.entitytype,
sgleast=self.sgleast,
}
self:showWindow("UIXianJie_SGMonsterDropWin",args)
else
local csid=xianjieModel:getMoJieEnterConfig('csid')

local args={
parentWin=self,
drop={cfg.drop,cfg.box},
entityType=monsterData.entitytype
}
if cfg.ex_drop then
args.ex_drop=cfg.ex_drop[csid]
end

self:showWindow("UIXianJie_MonsterDropWin",args)
end
end

function UIXianJie_monsterInfoWin:onRecordBtn()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local hideStage
if monsterData then
if xjMonsterInfoHideStage[monsterData.entitytype]and xjMonsterInfoHideStage[monsterData.entitytype]==1 then
hideStage=true
end
end

local groupid=self.sharecfg.monster[1]
local stage=self.sharecfg.stage or 1
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local nameStr=hideStage and groupcfg.name or FMT.fmt("{0}阶{1}",stage,groupcfg.name)
local temp={
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.mowu,
nameStr=nameStr,
sharename=nameStr,
ishujian=true,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end

function UIXianJie_monsterInfoWin:onShareBtn()

local monsterData=xianjieModel:getMonsterData(self.infoguid)
local hideStage
if monsterData then
if xjMonsterInfoHideStage[monsterData.entitytype]and xjMonsterInfoHideStage[monsterData.entitytype]==1 then
hideStage=true
end
end


local groupid=self.sharecfg.monster[1]
local stage=self.sharecfg.stage or 1
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local nameStr=hideStage and groupcfg.name or FMT.fmt("{0}阶{1}",stage,groupcfg.name)
if _noState[monsterData.entitytype]then
nameStr=groupcfg.name
end
local _sceneType=xianjieModel:getScenceType()
local data={
x=self.sharex,
y=self.sharez,
icon1="icon_sjgdbiaoshi_1",
msgName=nameStr,
shareType=xianjie_Point_Share.mowu,
scenceType=_sceneType,
name=nameStr,
shareName=nameStr,
}
local str=xianjieController:getShareStr(data)
str=chatLinkHelper.clearLink(str)
local sceneidx=xianjieModel:getSceneIndex(_sceneType)
local jsonStr=jsonHelper.encode({data.shareType,data.shareName,sceneidx,data.x,data.y})
local args={
channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.eXianmeng},
counterType=gameCounterType.eXianjiePointShareNum,
regexType=CHAT_REGEX_TYPE.csFairyLand,
descStr=str,
jsonStr=jsonStr,
title='坐标分享',
shareName=data.msgName,
sharePosStr=FMT.fmt('X <color=#171311>{0},</color> Y <color=#171311>{1}</color>',data.x,data.y)
}
UIManager:showWindow("UICommonShareTwoWin",args)
end

function UIXianJie_monsterInfoWin:onMask()
xianjieController:closeWin('UIXianJie_monsterInfoWin')
end

function UIXianJie_monsterInfoWin:onMonsterRewardDetailbtn()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local cfg=monsterData:getCfg()
UIManager:showWindow("UIXianJie_monsterRewardDetailWin",{type=monsterData.entitytype,cfg=cfg})
end

function UIXianJie_monsterInfoWin:onXjbjbtn()
local _posx=self.sharex
local _posy=self.sharez
local _sceneidx=xianjieModel:getSceneIndex()
local cbid=xianjieController.getZuoBiaoType(1)

if self.mstentitytype==xjServerEnityType.eMonsterHouse or
self.mstentitytype==xjServerEnityType.eMoJieMoZong_Big or
self.mstentitytype==xjServerEnityType.eMoJieZhenYan_Big or
self.mstentitytype==xjServerEnityType.eMoJieShangGuMoster then
cbid=xianjieController.getZuoBiaoType(5)

elseif self.mstentitytype==xjServerEnityType.eBossMonster or
self.mstentitytype==xjServerEnityType.eMoJieZhenYan_Small or
self.mstentitytype==xjServerEnityType.eMoJieZhenYan_Spe or
self.mstentitytype==xjServerEnityType.eMoJieMoZong_Small then
cbid=xianjieController.getZuoBiaoType(3)
elseif self.mstentitytype==xjServerEnityType.eMonster then

if self.sharecfg then
if self.sharecfg.flag==1 or self.sharecfg.flag==2 then
cbid=xianjieController.getZuoBiaoType(6)
else
cbid=xianjieController.getZuoBiaoType(1)
end
else
cbid=xianjieController.getZuoBiaoType(1)
end
elseif self.mstentitytype==xjServerEnityType.eMoJieMoster then
cbid=xianjieController.getZuoBiaoType(1)
end

xianjieController.openBJwin(_posx,_posy,_sceneidx,cbid)
end

function UIXianJie_monsterInfoWin:onShdBtn()
jumpManager:jump({id=JUMP_TYPE.eShouHunDing})
end

function UIXianJie_monsterInfoWin:refreshShdBtn()
local show=shouhundingController:isOpen()
if show then
local monsterData=xianjieModel:getMonsterData(self.infoguid)
show=shouhundingModel:checkEntityData(monsterData)
end
self.shdBtn:setActive(show)
if show then
self:refreshShdTx()
end
end

function UIXianJie_monsterInfoWin:refreshShdTx()
local cur=shouhundingModel:getDataValue()
local max=shouhundingModel:getDataMax()
local precent=math.min(cur,max)/max*100
precent=math.min(precent,100)
precent=precent>1 and math.floor(precent)or math.ceil(precent)
self.shdTx:setText(FMT.fmt("{0}%",precent))
end

function UIXianJie_monsterInfoWin.on_money_changed(mType)
if shouhundingModel:isDataType(mType)then
_this:refreshShdTx()
end
end

function UIXianJie_monsterInfoWin.on_system_open(sysId)
if shouhundingModel:isSysID(sysId)then
_this:refreshShdBtn()
end
end

function UIXianJie_monsterInfoWin:proTipBtnClick(monsterData)
local entitytype=monsterData.entitytype
if entitytype==xjServerEnityType.eMoJieMoZong_Small or
entitytype==xjServerEnityType.eMoJieZhenYan_Small or
entitytype==xjServerEnityType.eMoJieZhenYan_Big or
entitytype==xjServerEnityType.eMoJieZhenYan_Spe or
entitytype==xjServerEnityType.eMoJieMoZong_Big then
local soldierList=monsterData.soldierList
local cfg=monsterData:getCfg()


local jzInfo=cfg.jz
if jzInfo then
local maxLookup={}
for i,v in ipairs(jzInfo)do
maxLookup[v[1]]=v[2]
end
self:showWindow("UIMoZong_moBingInfoWin",{soldierList=soldierList,maxLookup=maxLookup})
end

end
end

function UIXianJie_monsterInfoWin:getProValue(monsterData)
local cur,max=0,0
local entitytype=monsterData.entitytype
if entitytype==xjServerEnityType.eMoJieMoZong_Small or
entitytype==xjServerEnityType.eMoJieZhenYan_Spe or
entitytype==xjServerEnityType.eMoJieZhenYan_Small or
entitytype==xjServerEnityType.eMoJieZhenYan_Big or
entitytype==xjServerEnityType.eMoJieMoZong_Big then
local soldierList=monsterData.soldierList
local cfg=monsterData:getCfg()


local jzInfo=cfg.jz
if jzInfo then
for i,v in ipairs(jzInfo)do
max=max+v[2]
end
end
if soldierList then
for i,v in ipairs(soldierList)do
cur=cur+v.param_2
end
end
end
return cur,max
end

function UIXianJie_monsterInfoWin:refreshProValue()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local showProCfg=_showPro[monsterData.entitytype]
if showProCfg then
local monsterInfoWidget=self.monsterInfo:getWidgetBase()
local cur,max=self:getProValue(monsterData)
monsterInfoWidget:SetChildUIProgressbar(14,cur,max,false)
monsterInfoWidget:SetChildText(18,FMT.fmt("{0}/{1}",mathHelper.formatNumber(cur),mathHelper.formatNumber(max)))
end
end

function UIXianJie_monsterInfoWin:onTisBtn()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if monsterData then
local entitytype=monsterData.entitytype
if entitytype==xjServerEnityType.eMoJieMoZong_Small or
entitytype==xjServerEnityType.eMoJieMoZong_Big then
local d={}
d.showType=2

d.posItem=self.TisBtn
d.name="monsterInfoWin_mozongtip_%s"

self:showWindow('UIConditionTipsFour',d)
end

if entitytype==xjServerEnityType.eMoJieZhenYan_Big or
entitytype==xjServerEnityType.eMoJieZhenYan_Spe or
entitytype==xjServerEnityType.eMoJieZhenYan_Small then
local d={}
d.showType=2

d.posItem=self.TisBtn
d.name="monsterInfoWin_zhenyantip_%s"

self:showWindow('UIConditionTipsFour',d)
end
end
end



function UIXianJie_monsterInfoWin:freshMoJiePnael()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local isbuffshow=forceBuffshow[monsterData.entitytype]
local isMJtime=xianjieController:CheckMoJieSaiJieActityeTime()
if isMJtime and isbuffshow then
self:freshMoJiBuffnum(monsterData)
local widget=self.mjslpanel:getWidgetBase()
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMoJiBuffClick(widget,monsterData)
end)
else
self.mjslpanel:setActive(false)
end
end

function UIXianJie_monsterInfoWin:freshMoJiBuffnum()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local buffTemp={}
local buffNum=0

if monsterData and monsterData.bufflistlen and monsterData.bufflistlen>0 then
local buffList_lookup=monsterData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end

local widget=self.mjslpanel:getWidgetBase()
widget:SetChildText(1,buffNum)
if buffTemp and next(buffTemp)then
self.mjslpanel:setActive(true)
else
self.mjslpanel:setActive(false)
end
end

function UIXianJie_monsterInfoWin:onMoJiBuffClick(_posWidget)
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local buffTemp={}
local buffNum=0
if monsterData and monsterData.bufflistlen and monsterData.bufflistlen>0 then
local buffList_lookup=monsterData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end
local widget=_this.mjslpanel:getWidgetBase()
widget:SetChildText(1,buffNum)


if buffTemp and next(buffTemp)then
self:showWindow('UIMoJieShiLiBuffTips',{posWidget=_posWidget,posWidgetIndex=0,pos={x=-265,y=65},bufflsit=buffTemp})
else
UIManager.info('暂无获得的魔界势力状态')
end
end

function UIXianJie_monsterInfoWin:freshMoJieShiLiItem()
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
if isopen then
local forceid=0
if forceid>0 then
self.slItem:setActive(true)
local cfg=cfg_devildomforceconfig_get(forceid)
self.slNameText:setText(cfg.name)
else
self.slItem:setActive(false)
end
end
end



function UIXianJie_monsterInfoWin:freshMoJieSkillPnael(monsterData)
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
local isbuffshow=forceBuffshow[monsterData.entitytype]
if isopen and isbuffshow then
if monsterData==nil then return end
self.exBtns:setLocalPosY(-200)
local forceid=xianjieController:getForce()
if forceid>0 and xianjieController:getShiLiDebuffCheck(forceid)then
local Skillidx,Taskidx=xianjieController:getForceCfg()
if Skillidx==nil then
self.mjslskill:setActive(false)
logErr(FMT.fmt('获取势力配置为nil,查看魔界赛季配置表的force字段'))
return
end
self.mjslskill:setActive(true)
self.skillcfg=xianjieController:getForceSkillCfg(forceid,Skillidx)
local skillcfg=self.skillcfg

local widget=self.mjslskill:getWidgetBase()
widget:SetChildText(slskillidx.name,skillcfg.name)
local iconName=iconHelper.getSkillIcon(skillcfg.skillicon)
widget:SetChildCSImageIcon(slskillidx.icon,iconName,false)
widget:SetChildButtonClick(slskillidx.skillbtn,function()
if _this==nil then return end
_this:onUseMoJiSkillbtn(monsterData)
end)
self:CheckUseMoJiSkillTime()
else
self.mjslskill:setActive(false)
end
else
self.mjslskill:setActive(false)
end
end

function UIXianJie_monsterInfoWin:onUseMoJiSkillbtn(monsterData)
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)then
local flag,g_list,errorParams=monsterData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法对本阵内的魔物使用"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法对阵外的魔物使用"
else

errStr="处于本阵内无法对其他本阵内的魔物使用"
end
UIManager.error(errStr)
end
return
end

local lastsec=xianjieController:getForceLastsec()
local curTime=timeHelper.getServerShortTime()
local skilldata=self.skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local skill_data=skilldata[lvl]
local skill_time=skill_data[2]
local endTime=lastsec+skill_time
if endTime>curTime then
UIManager.info('技能冷却中')
return
end
local actorid=int64.new(tostring(self.infoguid))

local _fun=function()
xianjieController:useMoJieShiLiSkill(actorid)
xianjieController:closeWin('UIXianJie_monsterInfoWin')
end
local UseSkilldesc=self.skillcfg.UseSkilldesc
local skillname=self.skillcfg.name
local parem1=UseSkilldesc[1]
local parem2=UseSkilldesc[2][lvl]
local strdesc=''
xpcall(function()
strdesc=FMT.fmt(parem1,unpack(parem2))
end,function(err)
logErr(FMT.fmt('魔界势力技能参数报错，配置字段UseSkilldesc,技能名字：{0},技能等级：{1}',skillname,lvl))
end)
local str=FMT.fmt("是否使用<color=#ca631d>【{0}】</color>技能\n\n{1}",skillname,strdesc)
xianjieController:showUseSkillWin(_fun,str)
else
UIManager.info('势力技能只能在魔界使用')
end
end

function UIXianJie_monsterInfoWin:serverMoJiSkill()
if _this==nil then return end
_this:CheckUseMoJiSkillTime()
end

function UIXianJie_monsterInfoWin:CheckUseMoJiSkillTime()
local widget=self.mjslskill:getWidgetBase()
local lastsec=xianjieController:getForceLastsec()
local curTime=timeHelper.getServerShortTime()
local skilldata=self.skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local skill_data=skilldata[lvl]
local skill_time=skill_data[2]
local endTime=lastsec+skill_time
if endTime>curTime then

widget:SetChildActive(slskillidx.djsbg,true)
widget:SetChildGray(slskillidx.icon,true)
self:stopSelfTimerMJSL()
local timeStr=timeHelper.format_time_stamp(endTime-curTime,true)
widget:SetChildText(slskillidx.djs,timeStr)
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
timeStr=timeHelper.format_time_stamp(showTime,true)
widget:SetChildText(slskillidx.djs,timeStr)
if dtTime<=0 then
self:stopSelfTimerMJSL()
widget:SetChildActive(slskillidx.djsbg,false)
widget:SetChildGray(slskillidx.icon,false)
end
end
self.timermjsl=self:setTimer(1,0,func)
else
widget:SetChildActive(slskillidx.djsbg,false)
widget:SetChildGray(slskillidx.icon,false)
end
end
function UIXianJie_monsterInfoWin:stopSelfTimerMJSL()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end


function UIXianJie_monsterInfoWin:freshTSZMGuiShu()
local infoguid=self.infoguid
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then

self.xmItem:setActive(true)
local xmWidget=self.xmItem:getWidgetBase()
xmWidget:SetChildActive(4,false)
local owner_server_id=monsterData.owner_server_id
local owner_actor_name=monsterData.owner_actor_name
local serverName=loginModel:getServerName(owner_server_id)
local str=FMT.fmt('[{0}]{1}',serverName,owner_actor_name)
xmWidget:SetChildText(0,str)
else
self.xmItem:setActive(false)
end
end


function UIXianJie_monsterInfoWin:freshMzrewardPanel()
self.mzrewardbtn:setActive(false)
local infoguid=self.infoguid
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small or
monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big then

local cfg=monsterData:getCfg()
if cfg.kill then
self.mzrewardbtn:setActive(true)
end
elseif monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then
local cfg=monsterData:getCfg()
if cfg.kill_reward_id then
self.mzrewardbtn:setActive(true)
end
elseif monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe
or monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Small
or monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Big then
local cfg=monsterData:getCfg()
if cfg.kill then
self.mzrewardbtn:setActive(true)
end
end
end

function UIXianJie_monsterInfoWin:onMzrewardbtn()
local infoguid=self.infoguid
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small or
monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big then

local cfg=monsterData:getCfg()
if cfg.kill then
local dropCfg=cfgHelper.get1(cfg_awardconfig_get,cfg.kill)
local rewards=dropCfg.showItems or{}
local temp=
{
title='对魔宗造成最后一击伤害的祖师可获得',
rewardlist=rewards,


posItem=self.mzrewardbtn,
pos={x=-297,y=58},
}
self:showWindow('UIMoJieRewardsTips',temp)
end
elseif monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then
local cfg=monsterData:getCfg()
if cfg.kill_reward_id then
local dropCfg=cfgHelper.get1(cfg_awardconfig_get,cfg.kill_reward_id)
local rewards=dropCfg.showItems or{}
local monsterTypeName=xianjieModel:getSgMonsterTypeName()
local temp=
{
title=FMT.fmt('对{0}造成最后一击的祖师可获得',monsterTypeName),
rewardlist=rewards,
posItem=self.mzrewardbtn,
pos={x=-297,y=58},
}
self:showWindow('UIMoJieRewardsTips',temp)
end
elseif monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe
or monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Small
or monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Big then
local cfg=monsterData:getCfg()
if cfg.kill then
local dropCfg=cfgHelper.get1(cfg_awardconfig_get,cfg.kill)
local rewards=dropCfg.showItems or{}
local temp=
{
title='击败阵眼的祖师所属仙盟的全员可获得',
rewardlist=rewards,
posItem=self.mzrewardbtn,
pos={x=-297,y=58},
}
self:showWindow('UIMoJieRewardsTips',temp)
end
end
end

function UIXianJie_monsterInfoWin:stopNoAttackTimeLeft()
if self.noAttackLeftTimer then
self:stopTimerByID(self.noAttackLeftTimer)
self.noAttackLeftTimer=nil
end
end

function UIXianJie_monsterInfoWin:refreshNoAttackTimeLeft(monsterData)
self:stopNoAttackTimeLeft()

if monsterData.entitytype~=xjServerEnityType.eMoJieZhenYan_Spe then
return
end

local constDef=monsterData:getConstDefCfg()
local forbid_attack_time=constDef.forbid_attack_time or 0
local cTime=timeHelper.getServerShortTime()
local sTime=monsterData.forbid_atk_sec
local left=forbid_attack_time-(cTime-sTime)

if left<0 then return end

local callback=function()
cTime=timeHelper.getServerShortTime()
left=forbid_attack_time-(cTime-sTime)
if left>=0 then
local leftStr=FMT.fmt("倒计时<color='#549327'>{0}</color>",timeHelper.format_time_stamp4(left))
_this.noAttackTimeLeft:setText(leftStr)
else
_this:refreshInfo(monsterData)
end
end

self.noAttackLeftTimer=self:setTimer(1,0,callback)
callback()
end
