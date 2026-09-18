







def_class("UIXianJie_MJBoxInfoWin",UIWindowBase)









function UIXianJie_MJBoxInfoWin:bindComponents()

self.commitBtn=UIButton.get(self,0)
self.commitBtnTxt=UIText.get(self,1)
self.costBg=UIObject.get(self,2)
self.costIcon=UIImage.get(self,3)
self.costNum=UIText.get(self,4)
self.costTimeItem=UIObject.get(self,5)
self.findXg=UIObject.get(self,6)
self.lockBtn=UIButton.get(self,7)
self.lockPanel=UIObject.get(self,8)
self.lockTxt=UIText.get(self,9)
self.mask=UIButton.get(self,10)
self.monsterInfo=UIObject.get(self,11)
self.monsterRewardDetailbtn=UIButton.get(self,12)
self.posTxt=UIText.get(self,13)
self.recommendedItem=UIObject.get(self,14)
self.recommendjzItem=UIObject.get(self,15)
self.recordBtn=UIButton.get(self,16)
self.rewardPanel=UIObject.get(self,17)
self.rewardPanelBg1=UIObject.get(self,18)
self.rewardPanelBg2=UIObject.get(self,19)
self.rewardTips=UIText.get(self,20)
self.rewardView=UIObject.get(self,21)
self.root=UIObject.get(self,22)
self.ruleBtn=UIButton.get(self,23)
self.shareBtn=UIButton.get(self,24)
self.shdBtn=UIButton.get(self,25)
self.shdTx=UIText.get(self,26)
self.showRewardBtn=UIButton.get(self,27)
self.stateLayout=UIObject.get(self,28)
self.stateTimeTxt=UIText.get(self,29)
self.stateTxt=UIText.get(self,30)
self.teamItem=UIObject.get(self,31)
self.texingBtn=UIButton.get(self,32)
self.timeRemaining=UIObject.get(self,33)
self.troopsItem=UIObject.get(self,34)
self.unlockPanel=UIObject.get(self,35)
self.xjbjbtn=UIButton.get(self,36)
self.xmItem=UIObject.get(self,37)
self.TisBtn=UIButton.get(self,38)
self.mjbox_txt=UIText.get(self,39)
self.mjbox_ywc=UIButton.get(self,40)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.lockBtn:setButtonClick(function()self:onLockBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.monsterRewardDetailbtn:setButtonClick(function()self:onMonsterRewardDetailbtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.shdBtn:setButtonClick(function()self:onShdBtn()end)

self.showRewardBtn:setButtonClick(function()self:onShowRewardBtn()end)

self.texingBtn:setButtonClick(function()self:onTexingBtn()end)

self.xjbjbtn:setButtonClick(function()self:onXjbjbtn()end)

self.TisBtn:setButtonClick(function()self:onTisBtn()end)

self.mjbox_ywc:setButtonClick(function()self:onMjbox_ywc()end)
self.mjbox={
["txt"]=self.mjbox_txt,
["ywc"]=self.mjbox_ywc,
}



end


function UIXianJie_MJBoxInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitBtnTxt);self.commitBtnTxt=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costTimeItem);self.costTimeItem=nil;
_UIObject_release(self.findXg);self.findXg=nil;
_UIObject_release(self.lockBtn);self.lockBtn=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.lockTxt);self.lockTxt=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.monsterInfo);self.monsterInfo=nil;
_UIObject_release(self.monsterRewardDetailbtn);self.monsterRewardDetailbtn=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
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
_UIObject_release(self.troopsItem);self.troopsItem=nil;
_UIObject_release(self.unlockPanel);self.unlockPanel=nil;
_UIObject_release(self.xjbjbtn);self.xjbjbtn=nil;
_UIObject_release(self.xmItem);self.xmItem=nil;
_UIObject_release(self.TisBtn);self.TisBtn=nil;
_UIObject_release(self.mjbox_txt);self.mjbox_txt=nil;
_UIObject_release(self.mjbox_ywc);self.mjbox_ywc=nil;
self.mjbox=nil;
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
}
local _showModel={
[xjServerEnityType.eMonster]=false,
[xjServerEnityType.eBossMonster]=false,
[xjServerEnityType.eMonsterHouse]=false,
[xjServerEnityType.eMoJieMoZong_Small]=false,
[xjServerEnityType.eMoJieMoZong_Big]=false,
[xjServerEnityType.eMoJieMoster]=false,
[xjServerEnityType.eMoJieShangGuMoster]=false,
[xjServerEnityType.eMoJieBox]=false,
}
local _showType={
[xjServerEnityType.eBossMonster]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hujianguiwu_03"},
[xjServerEnityType.eMonsterHouse]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hujianguiwu_04"},
[xjServerEnityType.eMoJieMoZong_Small]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_mozontouxiang_1"},
[xjServerEnityType.eMoJieMoZong_Big]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_mozontouxiang_1"},
}
local _showFlag={
[1]=10,
[2]=12,
}

local _showPro={
[xjServerEnityType.eMoJieMoZong_Small]={proNmae="魔兵",showProTipBtn=true},
[xjServerEnityType.eMoJieMoZong_Big]={proNmae="魔兵",showProTipBtn=true},
}

local _showTipBtn={
[xjServerEnityType.eMoJieMoZong_Small]=true,
[xjServerEnityType.eMoJieMoZong_Big]=true,
}

local _newbieTrigger={
[xjServerEnityType.eBossMonster]=function(monsterData)
local check=xianjieModel:getMonsterSeasonCheck(monsterData.entitytype)
local unlock=seasonController:checkSeasonStageBegined(check[1],check[2])
local free=xianjieModel:checkXJHasYunZhou()

return unlock and free
end,
}
local _isMjBox=
{
[xjServerEnityType.eMoJieBox]=true,
}

function UIXianJie_MJBoxInfoWin:onLoaded(...)
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


function UIXianJie_MJBoxInfoWin:__delete()
_this=nil
self:unbindComponents()
xianjieController:closeWin2('UIXianJie_MJBoxInfoWin')
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if monsterData then
monsterData:selectEntity(false)
end
end


function UIXianJie_MJBoxInfoWin:onHide()

end



function UIXianJie_MJBoxInfoWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then
return
end
xianjieController:closeWin3()
end

function UIXianJie_MJBoxInfoWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then
return
end
xianjieController:closeWin3()
end

function UIXianJie_MJBoxInfoWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then
return
end
_this:onCloseClick()
end

function UIXianJie_MJBoxInfoWin.onXianJieMonsterChange(typo,infoguid)
if _this==nil or not _this.isVisible then
return
end
if typo==CHANGE_TYPE.eDelete then
if tostring(_this.infoguid)==tostring(infoguid)then
xianjieController:closeWin3()
end
end
if typo==CHANGE_TYPE.eChanged then
if tostring(_this.infoguid)==tostring(infoguid)then
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData.entitytype==xjServerEnityType.eMoJieBox then
_this:refreshInfo(monsterData)
end
end
end
end

function UIXianJie_MJBoxInfoWin.onNewDay5am()
if _this==nil or not _this.isVisible then
return
end
_this:refreshRewardTimes()
end

function UIXianJie_MJBoxInfoWin.on_35_63(infoguid)
if _this.infoguid==infoguid then
_this:refreshTeamInfo()
end
end
function UIXianJie_MJBoxInfoWin.on_35_198(infoguid)
if _this.infoguid==infoguid then
_this:refreshTeamInfo()
end
end

function UIXianJie_MJBoxInfoWin.on_35_10()
if _this==nil or not _this.isVisible then
return
end
_this:refreshRewardTimes()
end





function UIXianJie_MJBoxInfoWin:onShow(argtable,afterOnloaded)
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
self.texingBtn:setActive(false)
self.winlua:SetChildLocalPosX(self.ruleBtn:getID(),-173)
self.isMjBox=_isMjBox[monsterData.entitytype]
self:refreshInfo(monsterData)


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

function UIXianJie_MJBoxInfoWin:onShowArgRecv(argtable)
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

function UIXianJie_MJBoxInfoWin:updateTime()
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

function UIXianJie_MJBoxInfoWin:refreshView(infoguid)
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

end

function UIXianJie_MJBoxInfoWin:onLoadFinish()
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.3,func)
end


function UIXianJie_MJBoxInfoWin:refreshInfo(monsterData)
if monsterData==nil then
monsterData=xianjieModel:getMonsterData(self.infoguid)
end
if monsterData==nil then
return
end

local cfg=monsterData:getCfg()
self.sharecfg=cfg

local boxD=xianjieModel:getMJboxData()


local gridX_c,gridZ_c=monsterData:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c
self.mstentitytype=monsterData.entitytype


local monsterInfoWidget=self.monsterInfo:getWidgetBase()













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

local monsterTypeName=xianjieModel:getSgMonsterTypeName()
local nameStr=cfg.name or FMT.fmt('{0}宝箱',monsterTypeName)




monsterInfoWidget:SetChildText(1,nameStr)
end



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
self.recommendedItem:setActive(false)
self.recommendjzItem:setActive(false)
self.troopsItem:setActive(false)


local haveCost=false
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

self.lockTxt:setText("")
self.unlockPanel:setActive(true)
self.lockPanel:setActive(false)


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


local btnStr="采集"
self.commitBtnTxt:setText(btnStr)

self:refreshRewardTimes(monsterData)
local cfg=monsterData:getCfg()
local isShowMonsterDetailBtn=false
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


self:setGuiShu(monsterData)

self:refreshCaiJiNum()

self:refreshCaiJiDoing()
end

function UIXianJie_MJBoxInfoWin:refreshCaiJiNum()
















end

function UIXianJie_MJBoxInfoWin:refreshCaiJiDoing()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local cancaiji=xianjieController:can_MjJieDuanSan_BXcaiji()
local yicaiji=xianjieController:is_MjJieDuanSan_BXcaijied(self.infoguid)












local WaiPaiTeam=xianjieController:get_WaiPaiTeamData()
local iswaipai=WaiPaiTeam[self.infoguid]



if yicaiji then
self.commitBtn:setActive(false)
self.mjbox_ywc:setActive(true)
self.stateTxt:setActive(false)
self.stateTimeTxt:setActive(false)
else

self.mjbox_ywc:setActive(false)
self.stateTxt:setActive(true)
self.stateTimeTxt:setActive(true)
end

if iswaipai then
self.commitBtn:setActive(false)
end

if not cancaiji then
self.commitBtn:setActive(false)
end
end

function UIXianJie_MJBoxInfoWin:setGuiShu(monsterData)
local xmId=monsterData.owner_guild_id
local xmName_str=monsterData.guildname or''
if xmId then
local xmData=xianjieModel:getXianMengData(xmId)
local hasXM=xmData~=nil
local xmWidget=self.xmItem:getWidgetBase()
self.xmItem:setActive(hasXM)
xmWidget:SetChildActive(1,hasXM)
xmWidget:SetChildActive(4,hasXM)
if hasXM then

local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

xmWidget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

xmWidget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

xmWidget:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))


local guildid=xmData.guildid
xmWidget:SetChildButtonClick(4,function()

end,true)
else
xmName_str='无'
end
xmWidget:SetChildText(0,xmName_str)
end
end

function UIXianJie_MJBoxInfoWin:refreshRewardTimes(monsterData)
if monsterData==nil then
monsterData=xianjieModel:getMonsterData(self.infoguid)
end

if monsterData==nil then
return
end
local rewardTipsStr="可能掉落"
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
local color=least>0 and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
rewardTipsStr=FMT.fmt("{0}(剩余<color={2}>{1}</color>/{3}次)",rewardTipsStr,least,FONT_COLOR_VAL[color],rewardTimeConf[1]+rewardTimeConf[2])
end

if entityType==xjServerEnityType.eMoJieMoZong_Big or entityType==xjServerEnityType.eMoJieMoZong_Small then
rewardTipsStr="宗门仓库"
end


self.rewardTips:setText(rewardTipsStr)
end

function UIXianJie_MJBoxInfoWin:refreshLife(widget,monsterData)
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

function UIXianJie_MJBoxInfoWin:refreshTeamInfo()
local widget=self.teamItem:getWidgetBase()
local teamInfos=xianjieModel:readMonsterTeamInfo(self.infoguid)
local teamCnt=teamInfos and#teamInfos.data or 0
local haveTeam=teamCnt>0
local str=haveTeam and FMT.fmt("前往中（<color=#ca631d>{0}</color>）",teamCnt)or"无"
widget:SetChildActive(1,haveTeam)
widget:SetChildText(0,str)
widget:SetChildActive(-1,haveTeam)
end

function UIXianJie_MJBoxInfoWin:refreshStateDesc()
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
if showBtn then
local yicaiji=xianjieController:is_MjJieDuanSan_BXcaijied(self.infoguid)
if yicaiji then
self.commitBtn:setActive(false)
end
end

self.stateLayout:setActive(hasWaiPai)
if hasWaiPai then
if desc=='战斗中'then
desc='采集中'
end
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

function UIXianJie_MJBoxInfoWin:refreshTimeRemaining()
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
local str=string.format("%s<color=#7d3b17>后消失</color>",time_str)
timeRemainingWidget:SetChildText(0,str)
end

function UIXianJie_MJBoxInfoWin:onLockBtn()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local check=xianjieModel:getMonsterSeasonCheck(monsterData.entitytype)
if check[1]==0 then
jumpManager:jump({id=JUMP_TYPE.eChongJianXianYu,args={chapter_idx=check[2]}})
end
end

function UIXianJie_MJBoxInfoWin:onClickTeamBtn()
local args={
parentWin=self,
infoguid=self.infoguid
}
self:showWindow("UIXianJie_monsterTeamWin",args)
end

function UIXianJie_MJBoxInfoWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXianJie_MJBoxInfoWin:onCloseClick(atOnce)
xianjieController:closeWin('UIXianJie_MJBoxInfoWin',atOnce)
end

function UIXianJie_MJBoxInfoWin:onCommitBtn()
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime
local infoguid=self.infoguid
local monsterData=xianjieModel:getMonsterData(infoguid)
local check=xianjieModel:getMonsterSeasonCheck(monsterData.entitytype)
if check and not seasonController:checkSeasonStageBegined(check[1],check[2])then
local seasonName=seasonModel:getHandleConfig(check[1],"name")
local stageName=seasonModel:getStageConfigEx(check[1],check[2],"name")
return UIManager.error(FMT.fmt("{0}·{1}开放后开启",seasonName,stageName))
end

local cancaiji=xianjieController:can_MjJieDuanSan_BXcaiji()
local monsterBoxName=xianjieModel:getSgMonsterTypeName(3)
if not cancaiji then
return UIManager.error(FMT.fmt("{0}采集已达上限",monsterBoxName))
end


local owner_guild_id=monsterData.owner_guild_id
if owner_guild_id then
local xmGuid=xianmengModel:myXMGuildID()
local isSelf=xianmengModel:compareTwoGuildID(xmGuid,owner_guild_id)
if not isSelf then
return UIManager.error(FMT.fmt("不可采集，非本仙盟{0}",monsterBoxName))
end
end


local monsterSceneIdx=monsterData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(monsterSceneIdx)then

return UIManager.error("无法前往其他仙域")
end


if monsterData.isExpire then
UIManager.error(FMT.fmt("{0}持续时间已过期，无法采集",monsterBoxName))
return
end


local flag,g_list=monsterData:checkMovePathCondition(true)
if not flag then
return
end

if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end
local cfg=monsterData:getCfg()

local orderType=xjOrderType.eMoJieBoxCaiJi

local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local dzlist={}

xianjieController:reqOrder(guid,orderType,dzlist,nil,nil,nil,nil,g_list)
self:closeSelf()
end

function UIXianJie_MJBoxInfoWin:onMjbox_ywc()
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime
local infoguid=self.infoguid
local monsterData=xianjieModel:getMonsterData(infoguid)

local yicaiji=xianjieController:is_MjJieDuanSan_BXcaijied(self.infoguid)
if yicaiji then
return UIManager.info("已采集")
end
local monsterBoxName=xianjieModel:getSgMonsterTypeName(3)
local cancaiji=xianjieController:can_MjJieDuanSan_BXcaiji()
if not cancaiji then
return UIManager.info(FMT.fmt("{0}采集已达上限",monsterBoxName))
end

local owner_guild_id=monsterData.owner_guild_id
if owner_guild_id then
local xmGuid=xianmengModel:myXMGuildID()
local isSelf=xianmengModel:compareTwoGuildID(xmGuid,owner_guild_id)
if not isSelf then
return UIManager.error(FMT.fmt("不可采集，非本仙盟{0}",monsterBoxName))
end
end

if monsterData.isExpire then
UIManager.error(FMT.fmt("{0}持续时间已过期，无法采集",monsterBoxName))
return
end
end

function UIXianJie_MJBoxInfoWin:onTexingBtn()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local monsterCfg=monsterData:getCfg()
local winParams={
parentWin=self,
fazes=monsterCfg.faze or{},
}
self:showWindow("UIXianJie_monsterFaZeWin",winParams)
end

function UIXianJie_MJBoxInfoWin:onRuleBtn()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local monsterCfg=monsterData:getCfg()
local screenPos=self.ruleBtn:getChildUIScreenPos(false)
screenPos.x=screenPos.x-50
local rules=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,'monsterRule',monsterData.entitytype,monsterCfg.flag or 0)
local winParams={
parentWin=self,
lang=rules[1],
num=rules[2],
screenPos=screenPos,
}
self:showWindow("UIXianJie_monsterRuleWin",winParams)
end

function UIXianJie_MJBoxInfoWin:onShowRewardBtn()

local monsterData=xianjieModel:getMonsterData(self.infoguid)
local cfg=monsterData:getCfg()
local args={
parentWin=self,
drop={cfg.drop,cfg.box},
entityType=monsterData.entitytype
}
self:showWindow("UIXianJie_MonsterDropWin",args)
end

function UIXianJie_MJBoxInfoWin:onRecordBtn()
local monsterTypeName=xianjieModel:getSgMonsterTypeName()
local nameStr=FMT.fmt("{0}宝箱",monsterTypeName)
local temp={
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.caijidian,
nameStr=nameStr,
sharename=nameStr,
ishujian=true,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end

function UIXianJie_MJBoxInfoWin:onShareBtn()

local monsterTypeName=xianjieModel:getSgMonsterTypeName()
local nameStr=FMT.fmt("{0}宝箱",monsterTypeName)
local _sceneType=xianjieModel:getScenceType()
local data={
x=self.sharex,
y=self.sharez,
icon1="icon_sjgdbiaoshi_1",
msgName=nameStr,
shareType=xianjie_Point_Share.caijidian,
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

function UIXianJie_MJBoxInfoWin:onMask()
xianjieController:closeWin('UIXianJie_MJBoxInfoWin')
end

function UIXianJie_MJBoxInfoWin:onMonsterRewardDetailbtn()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local cfg=monsterData:getCfg()
UIManager:showWindow("UIXianJie_monsterRewardDetailWin",{type=monsterData.entitytype,cfg=cfg})
end

function UIXianJie_MJBoxInfoWin:onXjbjbtn()
local _posx=self.sharex
local _posy=self.sharez
local _sceneidx=xianjieModel:getSceneIndex()
local cbid=xianjieController.getZuoBiaoType(1)

if self.mstentitytype==xjServerEnityType.eMonsterHouse or
self.mstentitytype==xjServerEnityType.eMoJieMoZong_Big or
self.mstentitytype==xjServerEnityType.eMoJieShangGuMoster then
cbid=xianjieController.getZuoBiaoType(5)

elseif self.mstentitytype==xjServerEnityType.eBossMonster or
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
elseif self.mstentitytype==xjServerEnityType.eMoJieMoster or self.mstentitytype==xjServerEnityType.eMoJieBox then
cbid=xianjieController.getZuoBiaoType(1)
end
xianjieController.openBJwin(_posx,_posy,_sceneidx,cbid)
end

function UIXianJie_MJBoxInfoWin:onShdBtn()
jumpManager:jump({id=JUMP_TYPE.eShouHunDing})
end

function UIXianJie_MJBoxInfoWin:refreshShdBtn()
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

function UIXianJie_MJBoxInfoWin:refreshShdTx()
local cur=shouhundingModel:getDataValue()
local max=shouhundingModel:getDataMax()
local precent=math.min(cur,max)/max*100
precent=math.min(precent,100)
precent=precent>1 and math.floor(precent)or math.ceil(precent)
self.shdTx:setText(FMT.fmt("{0}%",precent))
end

function UIXianJie_MJBoxInfoWin.on_money_changed(mType)
if shouhundingModel:isDataType(mType)then
_this:refreshShdTx()
end
end

function UIXianJie_MJBoxInfoWin.on_system_open(sysId)
if shouhundingModel:isSysID(sysId)then
_this:refreshShdBtn()
end
end

function UIXianJie_MJBoxInfoWin:proTipBtnClick(monsterData)
local entitytype=monsterData.entitytype
if entitytype==xjServerEnityType.eMoJieMoZong_Small or
entitytype==xjServerEnityType.eMoJieMoZong_Big then
local soldierList=monsterData.soldierList
local cfg=monsterData:getCfg()
local monsterGroupId=cfg.monster[1]
local jzInfo=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"jzInfo")
if jzInfo then
local maxLookup={}
for i,v in ipairs(jzInfo)do
maxLookup[v[1]]=v[2]
end
self:showWindow("UIMoZong_moBingInfoWin",{soldierList=soldierList,maxLookup=maxLookup})
end

end
end

function UIXianJie_MJBoxInfoWin:getProValue(monsterData)
local cur,max=0,0
local entitytype=monsterData.entitytype
if entitytype==xjServerEnityType.eMoJieMoZong_Small or
entitytype==xjServerEnityType.eMoJieMoZong_Big then
local soldierList=monsterData.soldierList
local cfg=monsterData:getCfg()
local monsterGroupId=cfg.monster[1]
local jzInfo=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"jzInfo")
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

function UIXianJie_MJBoxInfoWin:refreshProValue()
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local showProCfg=_showPro[monsterData.entitytype]
if showProCfg then
local monsterInfoWidget=self.monsterInfo:getWidgetBase()
local cur,max=self:getProValue(monsterData)
monsterInfoWidget:SetChildUIProgressbar(14,cur,max,false)
monsterInfoWidget:SetChildText(18,FMT.fmt("{0}/{1}",mathHelper.formatNumber(cur),mathHelper.formatNumber(max)))
end
end

function UIXianJie_MJBoxInfoWin:onTisBtn()
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
end


end
