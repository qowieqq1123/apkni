







def_class("UIXianJie_JiJie_msgWin",UIWindowBase)









function UIXianJie_JiJie_msgWin:bindComponents()

self.arenaInfoItem=UIObject.get(self,0)
self.autoBtn=UIButton.get(self,1)
self.autoDesc=UIText.get(self,2)
self.autoMarkNotSelect=UIImage.get(self,3)
self.autoMarkSelect=UIImage.get(self,4)
self.bgModel=UIObject.get(self,5)
self.bottomState=UIObject.get(self,6)
self.bottomStateText=UIText.get(self,7)
self.chuZhengBtn=UIButton.get(self,8)
self.clickMask=UIButton.get(self,9)
self.closeBtn=UIButton.get(self,10)
self.endGoBtn=UIButton.get(self,11)
self.endGoDesc=UIText.get(self,12)
self.endGoMarkNotSelect=UIImage.get(self,13)
self.endGoMarkSelect=UIImage.get(self,14)
self.itemPanel=UIObject.get(self,15)
self.jobPanel=UIObject.get(self,16)
self.jobPanel2=UIObject.get(self,17)
self.joinBtn=UIButton.get(self,18)
self.kickSelfBtn=UIButton.get(self,19)
self.kickSelfBtnText=UIText.get(self,20)
self.lerpTime=UIText.get(self,21)
self.mogongInfoItem=UIObject.get(self,22)
self.mojunJiJieDesc=UIText.get(self,23)
self.monsterInfoItem=UIObject.get(self,24)
self.playerInfoItem=UIObject.get(self,25)
self.progressBar=UIProgress.get(self,26)
self.progressClickMask=UIButton.get(self,27)
self.root=UIObject.get(self,28)
self.ruleBtn=UIButton.get(self,29)
self.settingBtn=UIButton.get(self,30)
self.stateDesc=UIText.get(self,31)
self.targetWayTime=UIText.get(self,32)
self.teamFightValue=UIText.get(self,33)
self.teamInfoBtn=UIButton.get(self,34)
self.teamNum=UIText.get(self,35)
self.wayTimeText=UIText.get(self,36)
self.zhenfaPanel=UIObject.get(self,37)

self.autoBtn:setButtonClick(function()self:onAutoBtn()end)

self.chuZhengBtn:setButtonClick(function()self:onChuZhengBtn()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.endGoBtn:setButtonClick(function()self:onEndGoBtn()end)

self.joinBtn:setButtonClick(function()self:onJoinBtn()end)

self.kickSelfBtn:setButtonClick(function()self:onKickSelfBtn()end)

self.progressClickMask:setButtonClick(function()self:onProgressClickMask()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.settingBtn:setButtonClick(function()self:onSettingBtn()end)

self.teamInfoBtn:setButtonClick(function()self:onTeamInfoBtn()end)



end


function UIXianJie_JiJie_msgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arenaInfoItem);self.arenaInfoItem=nil;
_UIObject_release(self.autoBtn);self.autoBtn=nil;
_UIObject_release(self.autoDesc);self.autoDesc=nil;
_UIObject_release(self.autoMarkNotSelect);self.autoMarkNotSelect=nil;
_UIObject_release(self.autoMarkSelect);self.autoMarkSelect=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bottomState);self.bottomState=nil;
_UIObject_release(self.bottomStateText);self.bottomStateText=nil;
_UIObject_release(self.chuZhengBtn);self.chuZhengBtn=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.endGoBtn);self.endGoBtn=nil;
_UIObject_release(self.endGoDesc);self.endGoDesc=nil;
_UIObject_release(self.endGoMarkNotSelect);self.endGoMarkNotSelect=nil;
_UIObject_release(self.endGoMarkSelect);self.endGoMarkSelect=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.jobPanel);self.jobPanel=nil;
_UIObject_release(self.jobPanel2);self.jobPanel2=nil;
_UIObject_release(self.joinBtn);self.joinBtn=nil;
_UIObject_release(self.kickSelfBtn);self.kickSelfBtn=nil;
_UIObject_release(self.kickSelfBtnText);self.kickSelfBtnText=nil;
_UIObject_release(self.lerpTime);self.lerpTime=nil;
_UIObject_release(self.mogongInfoItem);self.mogongInfoItem=nil;
_UIObject_release(self.mojunJiJieDesc);self.mojunJiJieDesc=nil;
_UIObject_release(self.monsterInfoItem);self.monsterInfoItem=nil;
_UIObject_release(self.playerInfoItem);self.playerInfoItem=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressClickMask);self.progressClickMask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.settingBtn);self.settingBtn=nil;
_UIObject_release(self.stateDesc);self.stateDesc=nil;
_UIObject_release(self.targetWayTime);self.targetWayTime=nil;
_UIObject_release(self.teamFightValue);self.teamFightValue=nil;
_UIObject_release(self.teamInfoBtn);self.teamInfoBtn=nil;
_UIObject_release(self.teamNum);self.teamNum=nil;
_UIObject_release(self.wayTimeText);self.wayTimeText=nil;
_UIObject_release(self.zhenfaPanel);self.zhenfaPanel=nil;
end















local _this

local _monsterInfoItemCmpIndex={
iconColorImg=0,
iconImg=1,
iconTag=2,
tagNumTxt=3,
nameText=4,
fightValueText=5,
soldierNumText=6,
monsterModel=7,
typeIcon=8,
jieflag=9,
proRoot=10,
}
local _playerInfoItemCmpIndex={
head=0,
nameText=1,
zmFightValueText=2,
xmIcon=3,
signBgIcon=4,
signIcon=5,
signKuangIcon=6,
xmName=7,
xmBtn=8,
}

local _arenaInfoItemCmpIndex={
icon=0,
nameText=1,
guiShuText=2,
}

local _memberItemCmpIndex={
hasPanel=0,
emptyPanel=1,
addBtn=2,
initiatorFlag=3,
leaderFlag=4,
selfFlag=5,
head=6,
name=7,
dzPanel=8,
teamGrid=9,
soldierBgIcon=10,
soldierNameIcon=11,
soldierNumText=12,
playerInfoBtn=13,
arrivalTimeText=14,
dzFightValueText=15,
soldierFightValueText=16,
soldierCountText=17,
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
local _colorKuang={
[xjServerEnityType.eMonster]={
[0]="image_gwtouxiangpjk_2",
[1]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eBossMonster]={
[0]="image_gwtouxiangpjk_4",
[1]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMonsterHouse]={
[0]="image_gwtouxiangpjk_5",
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_5",
},
[xjServerEnityType.eMoJieMoZong_Small]={
[0]="image_gwtouxiangpjk_3",
[1]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieMoZong_Big]={
[0]="image_gwtouxiangpjk_3",
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
},
[xjServerEnityType.eMoJieZhenYan_Spe]={
[0]="image_gwtouxiangpjk_3",
[1]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieZhenYan_Big]={
[0]="image_gwtouxiangpjk_3",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
}
local xgAddPanelShowTime=5
local isgu_monster=
{
[xjServerEnityType.eMoJieShangGuMoster]=true,
}

local _noState={
[xjServerEnityType.eMoJieShangGuMoster]=true,
[xjServerEnityType.eMoJieZhenYan_Small]=true,
[xjServerEnityType.eMoJieZhenYan_Spe]=true,
[xjServerEnityType.eMoJieZhenYan_Big]=true,

}




function UIXianJie_JiJie_msgWin:onLoaded(...)
_this=self
self:bindComponents()
self:addProNotify(40,1,self.on_40_1)
self.jobWidget=self.jobPanel2:getChildWidgetBase()
end


function UIXianJie_JiJie_msgWin:__delete()
_this=nil
self:clearUpdateTimer()
self:clearJobTimer()
self:unbindComponents()
end




function UIXianJie_JiJie_msgWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(5725,1,{},eAnimationID.enter)
self:delayDo(0.8,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
self.actorId=argtable and argtable.actorId
self.guid=argtable and argtable.guid
local sceneidx=argtable and argtable.sceneidx
self.sceneidx=sceneidx
self.arrivalCount=0

xianjieController:reqMassDetail(self.actorId,self.guid,nil,sceneidx)

self:refresh()
end


function UIXianJie_JiJie_msgWin:onHide()
self:clearUpdateTimer()
self:clearJobTimer()
end

function UIXianJie_JiJie_msgWin:refresh(checkEnd)
self.msgData=xianjieModel:getJiJieTeamDetail(self.actorId,self.guid)
if(self.msgData and self.msgData.memberCount==0)or(not self.msgData and checkEnd)then

UIManager.error("该集结已结束")
xianjieModel:removeJiJieSimpleData(self.actorId,self.guid)

UIManager:invokeUIMethod("UIXianJie_JiJie_teamListMonsterWin","refresh",true)
UIManager:invokeUIMethod("UIXianJie_JiJie_teamListWarWin","refresh",true)
return self:onCloseBtn()
end

self:refreshTargetInfo()


self:refreshJiJieState(true)


self:refreshTeamState()


self:refreshTeamMemberList()


self:refreshBtnPanel(true)

self:refreshJobPanel()


self:setUpdateTimer()
end

function UIXianJie_JiJie_msgWin:onUpdate()

self:refreshJiJieState()


self:refreshTeamMemberList_update()


self:refreshBtnPanel()
end

function UIXianJie_JiJie_msgWin:refreshTargetInfo()
if not self.msgData then
return
end
local jjType=xianjieModel:getJiJieTypeByGuid(self.msgData.infoguid,self.sceneidx)
local isPVP=not jjType or jjType==xjJjJieBaseType.eWar
self.monsterInfoItem:setActive(not isPVP)
if isPVP then

local isShowPlayerInfo=false
self.playerInfoItem:setActive(isShowPlayerInfo)
if isShowPlayerInfo then
self:refreshTargetPlayerInfo()
else
local isShowArenaInfo=false
local isMoGong=false
local entityType=xianjieModel:getEntityTypeByGuid(self.msgData.infoguid,self.sceneidx)
if entityType==xjServerEnityType.eClientBuild then
local isArena=xianjieModel:checkClientBdIsArenaByGuid(self.msgData.infoguid)
isShowArenaInfo=isArena
local guidNum=mathHelper.int64_to_number(self.msgData.infoguid)
isMoGong=guidNum==xjClientBuildType.flcbMoGong1
end
self.arenaInfoItem:setActive(isShowArenaInfo and(not isMoGong))
if isShowArenaInfo and(not isMoGong)then
self:refreshTargetArenaInfo()
end
self.mogongInfoItem:setActive(isMoGong)
if isMoGong then
self:refreshTargetMoGongInfo()
end
end

else

self:refreshMonsterInfo()
self.playerInfoItem:setActive(false)
self.arenaInfoItem:setActive(false)
end
end

function UIXianJie_JiJie_msgWin:refreshMonsterInfo()
if not self.msgData then
return
end
local widget=self.monsterInfoItem:getWidgetBase()
local monsterData=xianjieModel:getMonsterData(self.msgData.infoguid)
if monsterData then
local cfg=monsterData:getCfg()

local bgIcon=FMT.fmt('image_gwtouxiangpjk_{0}',cfg.stage)
widget:SetChildCSImageSprite(_monsterInfoItemCmpIndex.iconColorImg,globalABLookup.global,bgIcon)

local groupid=cfg.monster[1]
if monsterData.entitytype==xjServerEnityType.eMonsterHouse or
monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small or
monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Small or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Big or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe or
monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then


widget:SetChildActive(_monsterInfoItemCmpIndex.typeIcon,true)
widget:SetChildActive(_monsterInfoItemCmpIndex.jieflag,cfg.flag and(cfg.flag==2))












widget:SetChildActive(_monsterInfoItemCmpIndex.iconColorImg,true)
widget:SetChildUIModelRemoveTarget(_monsterInfoItemCmpIndex.monsterModel)
widget:SetChildCSImageSprite(_monsterInfoItemCmpIndex.iconColorImg,globalABLookup.global,_colorKuang[monsterData.entitytype][cfg.flag or 0])
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,_monsterInfoItemCmpIndex.iconImg,0,eHeadCenterType.eHead)

local typeImg=_showType[monsterData.entitytype]
if typeImg then
widget:SetChildCSImageSprite(_monsterInfoItemCmpIndex.typeIcon,typeImg[1],typeImg[2])
else
widget:SetChildCSImageIcon(_monsterInfoItemCmpIndex.typeIcon,"",true)
end
else
widget:SetChildActive(_monsterInfoItemCmpIndex.monsterModel,false)
widget:SetChildActive(_monsterInfoItemCmpIndex.typeIcon,false)
widget:SetChildActive(_monsterInfoItemCmpIndex.iconColorImg,true)
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,_monsterInfoItemCmpIndex.iconImg,0,eHeadCenterType.eHead)
end

local stageBGIcon=FMT.fmt('image_gwtouxiangdjk_{0}',cfg.stage)


local isMoZong=monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small or monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big
local isZhenYan=monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Small or monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Big or monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe

local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)

local nameStr=isMoZong and groupcfg.name or FMT.fmt("{0}阶 {1}",tostring(cfg.stage),groupcfg.name)
if _noState[monsterData.entitytype]then
nameStr=groupcfg.name
end
widget:SetChildText(_monsterInfoItemCmpIndex.nameText,nameStr)

local recommendedStr=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"recommend",monsterData.entitytype,cfg.stage)
recommendedStr=mathHelper.formatNumber(recommendedStr)
widget:SetChildText(_monsterInfoItemCmpIndex.fightValueText,FMT.fmt("推荐实力：{0}",recommendedStr))
if isMoZong or isZhenYan then
widget:SetChildAnchoredPos(_monsterInfoItemCmpIndex.nameText,-60.5,33.8)
widget:SetChildAnchoredPos(_monsterInfoItemCmpIndex.fightValueText,-60.5,-1.19)
end
else
local infoguid=self.msgData.infoguid
local entityType=xianjieModel:getEntityTypeByGuid(infoguid,self.sceneidx)
if entityType==xjServerEnityType.eClientBuild then
if xianjieModel:isMoJunBuild_int64(infoguid)then
local mojunData=xianjieModel:getMoJunData()
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,mojunData.build_id)

local bgIcon='image_gwtouxiangpjk_5'
widget:SetChildCSImageSprite(_monsterInfoItemCmpIndex.iconColorImg,globalABLookup.global,bgIcon)

local groupid=mojunData.gwzid

widget:SetChildActive(_monsterInfoItemCmpIndex.typeIcon,true)
local _ab="ui/windows/xianjie/xianjiemain_atlas_pak.ab"
local _iconname="image_mojieui_wz1"
widget:SetChildCSImageSprite(_monsterInfoItemCmpIndex.typeIcon,_ab,_iconname)

widget:SetChildText(_monsterInfoItemCmpIndex.nameText,cfg.name)

widget:SetChildText(_monsterInfoItemCmpIndex.fightValueText,"")
widget:SetChildActive(_monsterInfoItemCmpIndex.monsterModel,false)
widget:SetChildActive(_monsterInfoItemCmpIndex.iconColorImg,true)
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,_monsterInfoItemCmpIndex.iconImg,0,eHeadCenterType.eHead)
end
end
end


widget:SetChildActive(_monsterInfoItemCmpIndex.soldierNumText,false)

local entitytype=monsterData and monsterData.entitytype or nil

if entitytype==xjServerEnityType.eMoJieMoZong_Small or
entitytype==xjServerEnityType.eMoJieZhenYan_Big or
entitytype==xjServerEnityType.eMoJieZhenYan_Spe or
entitytype==xjServerEnityType.eMoJieZhenYan_Small or
entitytype==xjServerEnityType.eMoJieMoZong_Big then
widget:SetChildActive(_monsterInfoItemCmpIndex.proRoot,true)
local proWidget=widget:GetChildWidgetBase(_monsterInfoItemCmpIndex.proRoot)
local shield=monsterData.shield
local const_def=monsterData:getConstDefCfg()
local maxShield=const_def.shield[1]
local _shield=shield/maxShield*100
_shield=string.format("%.2f",_shield)
proWidget:SetChildText(2,FMT.fmt("{0}%",_shield))
proWidget:SetChildUIProgressbar(0,shield,maxShield,false)
else
widget:SetChildActive(_monsterInfoItemCmpIndex.proRoot,false)
end
end

function UIXianJie_JiJie_msgWin:refreshTargetPlayerInfo()
if not self.msgData then
return
end
local zmData=xianjieModel:getZongMenData(self.msgData.infoguid)
local widget=self.playerInfoItem:getWidgetBase()

local iconInfo=zmData.iconInfo
playerController:setHeadIcon(widget,_playerInfoItemCmpIndex.head,{iconInfo=iconInfo,scale=0.82,enableFadeCompatible=true})


local nameStr=zmData.actorname
widget:SetChildText(_playerInfoItemCmpIndex.nameText,nameStr)


local fight=mathHelper.int64_to_number(zmData.fightvalue)
widget:SetChildText(_playerInfoItemCmpIndex.zmFightValueText,mathHelper.formatNumber3(fight))


local xmGuid=zmData.guildid
local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
widget:SetChildActive(_playerInfoItemCmpIndex.xmIcon,hasXM)
widget:SetChildActive(_playerInfoItemCmpIndex.xmBtn,hasXM)
local xmName_str
local xmData
if hasXM then

xmData=xianjieModel:getXianMengData(xmGuid)
end
if xmData then
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(_playerInfoItemCmpIndex.signIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(_playerInfoItemCmpIndex.signBgIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(_playerInfoItemCmpIndex.signKuangIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))


local guildid=xmData.guildid
local wincfg=UIManager.get_window_config("UIXianJie_JiJie_msgWin")
local canvasIdx=wincfg.canvas
widget:SetChildButtonClick(_playerInfoItemCmpIndex.xmBtn,function()

local isOther=xianjienSceneIndexType:isOhterXianYu(zmData.ownersceneidx)
if not isOther then
xianmengController:openXMDetailInfoWin(guildid)
else
UIManager.error('不同仙域的仙盟，无法探知其信息')
end
end,true)
else
xmName_str='无'
if hasXM then
self.xmGuid=xmGuid
xianmengController:reqXMDetailData(xmGuid)
end
end
end

function UIXianJie_JiJie_msgWin:refreshTargetArenaInfo()
if not self.msgData then
return
end
local widget=self.arenaInfoItem:getWidgetBase()


local arenaId=mathHelper.int64_to_number(self.msgData.infoguid)
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local nameStr=cfg and cfg.name or"未知擂台"
widget:SetChildText(_arenaInfoItemCmpIndex.nameText,nameStr)


local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
local occupyServerId=arenaData.occupyServerId
local sceneIdx=arenaData.sceneidx
local xyNameStr
local hasOccupy=sceneIdx and sceneIdx~=0 or nil
if hasOccupy then
xyNameStr=xianjieController:getCrossServerNamebySCidx(sceneIdx)
else
xyNameStr="无"
end
widget:SetChildText(_arenaInfoItemCmpIndex.guiShuText,FMT.fmt("归属仙域：{0}",xyNameStr))
end

function UIXianJie_JiJie_msgWin:refreshTargetMoGongInfo()
if not self.msgData then
return
end
local widget=self.mogongInfoItem:getWidgetBase()

local arenaId=mathHelper.int64_to_number(self.msgData.infoguid)
local arenaData=moGongZhengDuoActModel:getArenaBuildData(arenaId)or defaultT
local xmNameStr=mathHelper.validInt64(arenaData.xmGuid)and arenaData.xmName or"无"
widget:SetChildText(_arenaInfoItemCmpIndex.guiShuText,FMT.fmt("归属仙盟：{0}",xmNameStr))
end

function UIXianJie_JiJie_msgWin:refreshJiJieState(isInit)
if not self.msgData then
return
end
local stateStr=''
local chuZhengSec=self.msgData.sec
local nowTime=timeHelper.getServerShortTime()
local timeStr="--:--:--"
if chuZhengSec==0 then
stateStr="<color=#549327>出击中</color>"

local initiatorIndex=self:getMassInitiatorIndex(isInit)
local memberData=self.msgData.memberList[initiatorIndex]
local marchguid=memberData.marchguid
if marchguid and marchguid~=0 then
local teamData=xianjieModel:getMarchTeamData(marchguid)
if teamData then
local teamHandle=teamData:getTeamHandle()
local state,timeData,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local lerpTime=math.ceil(lerp)
timeStr=timeHelper.format_time_stamp(lerpTime)
end
end
end
elseif nowTime>=chuZhengSec then
stateStr="<color=#ca631d>准备出击</color>"
else
stateStr="<color=#ca631d>集结中</color>"
local remainingTime=chuZhengSec-nowTime
timeStr=timeHelper.format_time_stamp(remainingTime)
end


self.stateDesc:setText(stateStr)

self.lerpTime:setText(timeStr)


local wayTimeStr="--:--:--"
local zmData=xianjieModel:getZongMenData(self.msgData.initiatorActorId)
if zmData then
local gridX_c_1=zmData.gridX_c
local gridZ_c_1=zmData.gridZ_c
local sceneidx_1=zmData.sceneidx
local sceneidx_2,gridX_c_2,gridZ_c_2

local entityType=xianjieModel:getEntityTypeByGuid(self.msgData.infoguid,self.sceneIdx)
local jjType=xianjieModel:getJiJieTypeByGuid(self.msgData.infoguid,self.sceneIdx)
if jjType==xjJjJieBaseType.eMonster then
local monsterData=xianjieModel:getMonsterData(self.msgData.infoguid)
if monsterData then
sceneidx_2=monsterData.sceneidx
gridX_c_2=monsterData.gridX_c
gridZ_c_2=monsterData.gridZ_c
elseif entityType==xjServerEnityType.eClientBuild and xianjieModel:isMoJunBuild_int64(self.msgData.infoguid)then
local mojunEntityData=xianjieModel:getMoJunEntityData()
if mojunEntityData then
sceneidx_2=mojunEntityData.sceneidx
gridX_c_2=mojunEntityData.gridX_c
gridZ_c_2=mojunEntityData.gridZ_c
end
end
else
if entityType==xjServerEnityType.eClientBuild then

local isArena=xianjieModel:checkClientBdIsArenaByGuid(self.msgData.infoguid)
if isArena then
local arenaId=mathHelper.int64_to_number(self.msgData.infoguid)
local arenaData=xianjieModel:getArenaDataByArenaId(arenaId)
if arenaData then
sceneidx_2=arenaData.sceneidx
gridX_c_2=arenaData.gridX_c
gridZ_c_2=arenaData.gridZ_c
end
elseif xianjieModel:isMoJunBuild_int64(self.msgData.infoguid)then
local mojunEntityData=xianjieModel:getMoJunEntityData()
if mojunEntityData then
sceneidx_2=mojunEntityData.sceneidx
gridX_c_2=mojunEntityData.gridX_c
gridZ_c_2=mojunEntityData.gridZ_c
end
end
end
end

if sceneidx_2 and gridX_c_2 and gridZ_c_2 then
local speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eJiJieChuZheng,1)
local wayTime=xianjieModel:getPoint2PointNeedTime(sceneidx_1,gridX_c_1,gridZ_c_1,sceneidx_2,gridX_c_2,gridZ_c_2,speed)
wayTime=math.ceil(wayTime)
wayTimeStr=timeHelper.format_time_stamp(wayTime)
end
end
self.targetWayTime:setText(wayTimeStr)

local massCfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'mass')
local maxMemberCount=massCfg[2]
local nowMemberCount=self.msgData.memberCount
self.teamNum:setText(FMT.fmt("{0}/{1}",nowMemberCount,maxMemberCount))
end

function UIXianJie_JiJie_msgWin:refreshTeamState()
if not self.msgData then
return
end

local teamFightValue=0
if self.msgData then
local dzFightList={}
local soldierList={}
local jzAttrList={}
local memberList=self.msgData.memberList
for _,memberData in ipairs(memberList)do
local isLeader=memberData.isleader==1
if isLeader then

local dzlist=memberData.discipleList or{}
for i,netData in ipairs(dzlist)do
local has=netData~=nil and netData.flag>0
if has then
local dzGuidStr=tostring(netData.discipleguid)
local fightValue_int64=netData.fightvalue
local fightValue=mathHelper.int64_to_number(fightValue_int64)
dzFightList[dzGuidStr]=fightValue
end
end
end


local moneyList=memberData.moneyList
for _,money in ipairs(moneyList)do
local moneyType=money.param_1
local count=money.param_2
local soldierId=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
if soldierList[soldierId]then
soldierList[soldierId]=soldierList[soldierId]+count
else
soldierList[soldierId]=count
end
end

local bonusList=memberData.bonusList
if bonusList and#bonusList>0 then
for i=1,#bonusList do
local attr=bonusList[i]
if jzAttrList[attr.param_1]then
jzAttrList[attr.param_1]=jzAttrList[attr.param_1]+attr.param_2
else
jzAttrList[attr.param_1]=attr.param_2
end
end
end
end

teamFightValue=xianjieModel:getXJYZTeamFightValue(dzFightList,soldierList,jzAttrList)
end
self.teamFightValue:setText(FMT.fmt("队伍实力：{0}",mathHelper.formatNumber3(teamFightValue)))




local allSoldierCount=0
local maxSoldierCount=self.msgData.maxSoldierCount
local memberList=self.msgData.memberList
if memberList and next(memberList)then
for _,v in ipairs(memberList)do
local moneyList=v.moneyList
if moneyList and next(moneyList)then
for _,money in ipairs(moneyList)do
local count=money.param_2
allSoldierCount=allSoldierCount+count
end
end
end
end
local percent=allSoldierCount/maxSoldierCount*100
if percent>100 then
percent=100
end
self.progressBar:setProgressValue(percent,100)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",mathHelper.formatNumber4(allSoldierCount,1),mathHelper.formatNumber4(maxSoldierCount,1)))
end

function UIXianJie_JiJie_msgWin:refreshTeamMemberList()
if not self.msgData then
return
end
local isSG_monster=false
local jjType=xianjieModel:getJiJieTypeByGuid(self.msgData.infoguid,self.sceneIdx)
if jjType==xjJjJieBaseType.eMonster then
local monsterData=xianjieModel:getMonsterData(self.msgData.infoguid)
if monsterData and isgu_monster[monsterData.entitytype]then
isSG_monster=true
end
end
local chuZhengSec=self.msgData.sec
local isChuZheng=chuZhengSec==0
local isSelfInitiator=playerModel:checkActorId(self.msgData.initiatorActorId)
local sortList=self:getSortMemberList(true)
local massCfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'mass')
local maxMemberCount=massCfg[2]
local createCount
local isInMoGong=xianjieController:checkInMoGongZhengDuo()
if isSelfInitiator and not isChuZheng and not isSG_monster and not isInMoGong then
createCount=#sortList+1
else
createCount=#sortList
end

if createCount>maxMemberCount then
createCount=maxMemberCount
end
self.itemPanel:setChildLayoutGroupCreateItems(createCount,function(i)
local widget=self.itemPanel:getChildLayoutGroupGridItem(i-1)
local data=sortList[i]
if data then
widget:SetChildActive(_memberItemCmpIndex.hasPanel,true)
widget:SetChildActive(_memberItemCmpIndex.emptyPanel,false)
local actorId=data.data.actorid
local playZmData
local isSelf=playerModel:checkActorId(actorId)
if isSelf then
playZmData=xianjieModel:getMyZongMenData()
else
playZmData=xianjieModel:getZongMenData(actorId)
end

local iconInfo=playZmData.iconInfo
playerController:setHeadIcon(widget,_memberItemCmpIndex.head,{iconInfo=iconInfo,scale=0.62,enableFadeCompatible=true})


local nameStr=playZmData.actorname
widget:SetChildText(_memberItemCmpIndex.name,nameStr)


local isLeader=data.data.isleader==1
local isInitiator=mathHelper.compareInt64(self.msgData.initiatorActorId,actorId)
widget:SetChildActive(_memberItemCmpIndex.leaderFlag,isLeader)
widget:SetChildActive(_memberItemCmpIndex.initiatorFlag,isInitiator)
widget:SetChildActive(_memberItemCmpIndex.selfFlag,isSelf)

widget:SetChildActive(_memberItemCmpIndex.dzPanel,isLeader)
widget:SetChildActive(_memberItemCmpIndex.arrivalTimeText,not isLeader)


local arrivalStateStr="已抵达"
local arrivalCountdownStr
local marchguid=data.data.marchguid
if not isChuZheng and marchguid and marchguid~=0 then

local teamData=xianjieModel:getMarchTeamData(marchguid)
if teamData and teamData.marchtype==xjServerMarchType.eJiJieJoin then
local teamHandle=teamData:getTeamHandle()
local state,timeData,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local lerpTime=math.ceil(lerp)
local timeStr=timeHelper.format_time_stamp(lerpTime)
arrivalStateStr=FMT.fmt("集结中：{0}",timeStr)
arrivalCountdownStr=arrivalStateStr
end
end
else


end

if isLeader then

local dzlist=data.data.discipleList or{}
local dznum=#dzlist
widget:SetChildLayoutGroupCreateItems(_memberItemCmpIndex.teamGrid,dznum,function(index)
local dzItem=widget:GetChildLayoutGroupGridItem(_memberItemCmpIndex.teamGrid,index-1)
local netData=dzlist[index]
local has=netData~=nil and netData.flag>0






dzItem:SetChildActive(-1,has)
local dzHeadItemWidget=dzItem:GetChildWidgetBase(0)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzHeadItemWidget,0,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,dzHeadItemWidget,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzItem:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

UIDiscipleModel:setDiscipleXianMoHeadImage(dzHeadItemWidget,8,netData)
end
end)
else
widget:SetChildText(_memberItemCmpIndex.arrivalTimeText,arrivalStateStr)
end


if isLeader and arrivalCountdownStr then
widget:SetChildText(_memberItemCmpIndex.dzFightValueText,arrivalCountdownStr)
else
local dzlist=data.data.discipleList or{}
local dzFightValue=0
for i,netData in ipairs(dzlist)do
local has=netData~=nil and netData.flag>0
if has then
local fightValue_int64=netData.fightvalue
local fightValue=mathHelper.int64_to_number(fightValue_int64)
dzFightValue=dzFightValue+fightValue
end
end
widget:SetChildText(_memberItemCmpIndex.dzFightValueText,FMT.fmt("随队弟子战力：{0}",mathHelper.formatNumber3(dzFightValue)))
end


local allSoldierCount=0
local moneyList=data.data.moneyList
local maxSoldierLevel
if moneyList and next(moneyList)then
for i,money in ipairs(moneyList)do
local moneyType=money.param_1
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
if not maxSoldierLevel or soldierLevel>maxSoldierLevel then
maxSoldierLevel=soldierLevel
end
local count=money.param_2
allSoldierCount=allSoldierCount+count
end
end
widget:SetChildText(_memberItemCmpIndex.soldierNumText,mathHelper.formatNumber4(allSoldierCount,1))
if maxSoldierLevel then
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,maxSoldierLevel)
local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(_memberItemCmpIndex.soldierBgIcon,iconAb,bgIconName)

local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(_memberItemCmpIndex.soldierNameIcon,iconAb,levelIconName)
end


widget:SetChildButtonClick(_memberItemCmpIndex.playerInfoBtn,function()
if not _this then return end
local originalIndex=data.idx
return _this:onPlayerInfoBtnClick(originalIndex)
end,true)

else
widget:SetChildActive(_memberItemCmpIndex.hasPanel,false)
widget:SetChildActive(_memberItemCmpIndex.emptyPanel,true)

widget:SetChildButtonClick(_memberItemCmpIndex.addBtn,function()
if not _this then return end
return _this:onAddBtnClick()
end,true)
end
end)
end

function UIXianJie_JiJie_msgWin:refreshTeamMemberList_update()
if not self.msgData then
return
end

local sortList=self:getSortMemberList(true)
local grids=self.itemPanel:getChildLayoutGroupGridList()
local chuZhengSec=self.msgData.sec
local arrivalCount=0
local nowMemberCount=self.msgData.memberCount
for i=1,grids.Count do
local widget=grids[i-1]
local data=sortList[i]
if data then
widget:SetChildActive(_memberItemCmpIndex.hasPanel,true)
widget:SetChildActive(_memberItemCmpIndex.emptyPanel,false)

local isLeader=data.data.isleader==1

local arrivalStateStr="已抵达"
local arrivalCountdownStr
local marchguid=data.data.marchguid
if chuZhengSec~=0 and marchguid and marchguid~=0 then

local teamData=xianjieModel:getMarchTeamData(marchguid)
if teamData and teamData.marchtype==xjServerMarchType.eJiJieJoin then
local teamHandle=teamData:getTeamHandle()
local state,timeData,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local lerpTime=math.ceil(lerp)
local timeStr=timeHelper.format_time_stamp(lerpTime)
arrivalStateStr=FMT.fmt("集结中：{0}",timeStr)
arrivalCountdownStr=arrivalStateStr
elseif not lerp then
arrivalStateStr="集结中"
else

arrivalCount=arrivalCount+1
end
elseif marchguid then

arrivalCount=arrivalCount+1
end
else


arrivalCount=arrivalCount+1
end
if not isLeader then
widget:SetChildText(_memberItemCmpIndex.arrivalTimeText,arrivalStateStr)
else

if arrivalCountdownStr then
widget:SetChildText(_memberItemCmpIndex.dzFightValueText,arrivalCountdownStr)
else
local dzlist=data.data.discipleList or{}
local dzFightValue=0
for i,netData in ipairs(dzlist)do
local has=netData~=nil and netData.flag>0
if has then
local fightValue_int64=netData.fightvalue
local fightValue=mathHelper.int64_to_number(fightValue_int64)
dzFightValue=dzFightValue+fightValue
end
end
widget:SetChildText(_memberItemCmpIndex.dzFightValueText,FMT.fmt("随队弟子战力：{0}",mathHelper.formatNumber3(dzFightValue)))
end
end
end
end

local originalArrivalCount=self.arrivalCount
self.arrivalCount=arrivalCount
if arrivalCount~=originalArrivalCount then
if arrivalCount>=nowMemberCount and originalArrivalCount<nowMemberCount then
self:refreshBtnPanel()
end
end
end

function UIXianJie_JiJie_msgWin:getSortMemberList(isReset)
if not isReset and self.sortMemberList then
return self.sortMemberList
end

local sortList={}
local memberList=self.msgData.memberList or{}
for i,v in ipairs(memberList)do
local isLeader=v.isleader==1
local originalIndex=i
local weight=originalIndex
if isLeader then
weight=weight-1000
end
sortList[#sortList+1]={
data=v,
idx=originalIndex,
weight=weight,
}
end

table.sort(sortList,function(a,b)
return a.weight<b.weight
end)

self.sortMemberList=sortList
return self.sortMemberList
end

function UIXianJie_JiJie_msgWin:refreshBtnPanel(isInit)
if not self.msgData then
return
end
local myActorId=playerModel:getActorID()
local selfIndex=self:getMassSelfIndex(isInit)
local isJoined=selfIndex~=nil
local chuZhengSec=self.msgData.sec
local isChuZheng=chuZhengSec==0
local nowTime=timeHelper.getServerShortTime()
local isWaitChuZheng=nowTime>=chuZhengSec
local isInitiator=mathHelper.compareInt64(self.msgData.initiatorActorId,myActorId)
local isMoJun=false
local infoguid=self.msgData.infoguid
local monsterData=xianjieModel:getMonsterData(infoguid)
if not monsterData then
if xianjieModel:isMoJunBuild_int64(infoguid)then
isMoJun=true
end
end


self.settingBtn:setActive(isInitiator and not isChuZheng)
self.chuZhengBtn:setActive(isInitiator and not isChuZheng and not isMoJun)
self.kickSelfBtn:setActive(isJoined and not isChuZheng)
self.joinBtn:setActive(not isJoined and not isChuZheng)
self.wayTimeText:setActive(not isJoined and not isChuZheng)
self.bottomState:setActive(isJoined and not isInitiator and not isChuZheng)
local hasSetting=isInitiator and not isChuZheng
self.mojunJiJieDesc:setActive(isMoJun)
self.mojunJiJieDesc:setLocalPosX(hasSetting and 15 or-180)
local kickSelfStr
if isInitiator then

local isAuto=self.msgData.autoGo==1
self.autoMarkSelect:setActive(isAuto)
self.autoMarkNotSelect:setActive(not isAuto)


local isEndGo=self.msgData.endGo==1
self.endGoMarkSelect:setActive(isEndGo)
self.endGoMarkNotSelect:setActive(not isEndGo)

kickSelfStr="解散队伍"

if not isChuZheng then

local isCanChuZheng=self:checkIsCanChuZheng()
local isGary=not isCanChuZheng
self.chuZhengBtn:setChildImageExGray(isGary)
end

else
kickSelfStr="退出集结"
if isJoined then

local str="等待队长出征"
local memberData=self.msgData.memberList[selfIndex]
local marchguid=memberData.marchguid
if not isChuZheng and marchguid and marchguid~=0 then
local teamData=xianjieModel:getMarchTeamData(marchguid)
if teamData and teamData.marchtype==xjServerMarchType.eJiJieJoin then
local teamHandle=teamData:getTeamHandle()
local state,timeData,lerp=teamHandle:getTeamState()
if lerp>0 then
local lerpTime=math.ceil(lerp)
local timeStr=timeHelper.format_time_stamp(lerpTime)
str=FMT.fmt("前往集结中\n{0}",timeStr)
end
end
end

self.bottomStateText:setText(str)
else

local zmData=xianjieModel:getZongMenData(self.msgData.initiatorActorId)
if zmData then
local gridX=zmData.gridX_c
local gridZ=zmData.gridZ_c
local sceneidx=zmData.sceneidx
local speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eJiJieJoin,1)
local wayTime=xianjieModel:getZongMenToPosWayTime(sceneidx,gridX,gridZ,speed,nil,nil,nil)
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp(wayTime)
self.wayTimeText:setText(FMT.fmt("集结路程：{0}",time_str))
end
end
end

self.kickSelfBtnText:setText(kickSelfStr)
end

function UIXianJie_JiJie_msgWin:getMassSelfIndex(isReset)
if not self.msgData then
return
end

if not isReset and self.selfIdx then
return self.selfIdx
end

self.selfIdx=nil
local memberList=self.msgData.memberList or{}
for i,v in ipairs(memberList)do
local actorId=v.actorid
if playerModel:checkActorId(actorId)then
self.selfIdx=i
break
end
end
return self.selfIdx
end

function UIXianJie_JiJie_msgWin:getMassInitiatorIndex(isReset)
if not self.msgData then
return
end

if not isReset and self.initiatorIdx then
return self.initiatorIdx
end

local memberList=self.msgData.memberList or{}
for i,v in ipairs(memberList)do
local actorId=v.actorid
if mathHelper.compareInt64(self.msgData.initiatorActorId,actorId)then
self.initiatorIdx=i
break
end
end
return self.initiatorIdx
end

function UIXianJie_JiJie_msgWin:getMassLeaderIndex()
if not self.msgData then
return
end
local memberList=self.msgData.memberList or{}
for i,v in ipairs(memberList)do
if v.isleader==1 then
return i
end
end
end

function UIXianJie_JiJie_msgWin:setUpdateTimer()
self:clearUpdateTimer()
self.updateTimer=self:setTimer(1,0,function()self:onUpdate()end)

self:onUpdate()
end

function UIXianJie_JiJie_msgWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIXianJie_JiJie_msgWin:rec_detail(guildid)
if mathHelper.compareInt64(guildid,self.xmGuid)then
self:refreshTargetPlayerInfo()
end
end

function UIXianJie_JiJie_msgWin:checkIsCanChuZheng()
local massCfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'mass')
local maxMemberCount=massCfg[2]
local minMemberCount=massCfg[1]
local nowMemberCount=self.msgData.memberCount
local arrivalCount=self.arrivalCount
local errStr="未完成集结，无法出征"
if nowMemberCount<minMemberCount then
return false,errStr
end

if arrivalCount<nowMemberCount then
errStr="队员未全部抵达，无法出征"
return false,errStr
end

local maxSoldierCount=self.msgData.maxSoldierCount
local memberList=self.msgData.memberList
local allSoldierCount=0
if memberList and next(memberList)then
for _,v in ipairs(memberList)do
local moneyList=v.moneyList
if moneyList and next(moneyList)then
for _,money in ipairs(moneyList)do
local count=money.param_2
allSoldierCount=allSoldierCount+count
end
end
end
end
if allSoldierCount<maxSoldierCount then
return false,errStr
end

return true
end




function UIXianJie_JiJie_msgWin:onClickMask()
self:onCloseBtn()
end



function UIXianJie_JiJie_msgWin:onCloseBtn()
self:closeSelf()
end



function UIXianJie_JiJie_msgWin:onTeamInfoBtn()
if not self.msgData then
return
end
local massActorId=self.actorId
local massGuid=self.guid
local infoGuid=self.msgData.infoguid
local showMemberIndex=self:getMassLeaderIndex()
self:showWindow("UIXianJie_JiJie_teamInfoWin",{
isTeamInfo=true,
massActorId=massActorId,
massGuid=massGuid,
showMemberIndex=showMemberIndex,
infoGuid=infoGuid,
})
end



function UIXianJie_JiJie_msgWin:onAutoBtn()
if not self.msgData then
return
end
local chuZhengSec=self.msgData.sec
if chuZhengSec==0 then

return
else
local nowTime=timeHelper.getServerShortTime()
local remainingTime=chuZhengSec-nowTime
if remainingTime<=0 then

return UIManager.error("队员正在前往集结，无法取消勾选")
end
end

local isAuto=self.msgData.autoGo==1

local infoguid=self.msgData.infoguid
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieChangeAuto
local actorId=self.actorId
local auto=isAuto and 0 or 1
local endGoFlag=self.msgData.endGo or 1
local params={auto,endGoFlag}
local pstr=jsonHelper.encode(params)
xianjieModel:setJiJieLocalData_lastSelectAutoFlag(auto)
xianjieModel:saveJiJieLocalData()
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr)
end



function UIXianJie_JiJie_msgWin:onChuZhengBtn()
if not self.msgData then
return
end

local isCanChuZheng,err=self:checkIsCanChuZheng()
if not isCanChuZheng then
return UIManager.error(err)
end

local infoguid=self.msgData.infoguid
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieChuZheng
local params=""
xianjieController:reqOrder(guid,ordertype,nil,nil,params)
end



function UIXianJie_JiJie_msgWin:onKickSelfBtn()
if not self.msgData then
return
end

local infoguid=self.msgData.infoguid
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieKickOut
local actorId=self.actorId
local myActorId=playerModel:getActorID()
local params={tostring(actorId),tostring(myActorId)}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr)
end



function UIXianJie_JiJie_msgWin:onJoinBtn()
if not self.msgData then
return
end
local infoguid=self.msgData.infoguid
local massGuid=self.guid
local actorId=self.actorId
local chuZhengSec=self.msgData.sec
local zmData=xianjieModel:getZongMenData(actorId)
local zmSceneIdx=zmData.sceneidx
local targetSceneIdx=self.sceneIdx

if xianjienSceneIndexType:isOhterXianYu(zmSceneIdx)then

return UIManager.error("无法加入其他仙域的集结")
end


if chuZhengSec==0 then

return UIManager.error("太迟了，集结已结束")
else

local nowTime=timeHelper.getServerShortTime()
local remainingTime=chuZhengSec-nowTime
if remainingTime<=0 then

return UIManager.error("集结已结束，无法加入")
end
end

local minSoldierNum=1
local orderType=xjOrderType.eJiJieJoin
local isChuZheng,isCanChuZheng=xianjieModel:checkXJIsChuZheng(orderType,true)
if not isChuZheng or not isCanChuZheng then
local orderCfg=xianjieModel:getOrderConfig(orderType)
local needYzType=orderCfg[1]
if needYzType==1 then
UIManager.error("当前没有可用云舟")
end

return
end

local extraCost
local jjType=xianjieModel:getJiJieTypeByGuid(infoguid,targetSceneIdx)
local isPVE=not jjType or jjType==xjJjJieBaseType.eMonster
if isPVE then

local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData then
local cfg=monsterData:getCfg()
extraCost=cfg.consume
end
else

extraCost={}
end


local massCfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'mass')
local maxMemberCount=massCfg[2]
local nowMemberCount=self.msgData.memberCount
local deltaMemberCount=maxMemberCount-nowMemberCount
if deltaMemberCount<=0 then
return UIManager.error("当前队员已满，无法加入")
end


local allSoldierCount=0
local maxSoldierCount=self.msgData.maxSoldierCount
local memberList=self.msgData.memberList
if memberList and next(memberList)then
for _,v in ipairs(memberList)do
local moneyList=v.moneyList
if moneyList and next(moneyList)then
for _,money in ipairs(moneyList)do
local count=money.param_2
allSoldierCount=allSoldierCount+count
end
end
end
end

local deltaSoldierCount=maxSoldierCount-allSoldierCount
if deltaSoldierCount<=0 then
return UIManager.error("当前兵力已满，无法加入")
end

local speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eJiJieJoin,1)
local wayTime=xianjieModel:getZongMenToPosWayTime(zmSceneIdx,zmData.gridX_c,zmData.gridZ_c,speed,nil,nil,nil)


local ret,gateList,errorParams=zmData:checkMovePathCondition(true)
if not ret then

if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法参与本阵内发起的集结"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法参与阵外发起的集结"
else

errStr="处于本阵内无法参与其他本阵内发起的集结"
end
UIManager.error(errStr)
end
return
end


local func=function(selectDzList,selectMoneyList,boatId,sendArgs)
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=orderType
local params={tostring(actorId)}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,pstr,boatId,sendArgs,gateList)
end

local confirmCheckFunc=function()
local errType
if chuZhengSec==0 then

UIManager.error("太迟了，集结已结束")
errType=1
return false,errType
end


local nowTime=timeHelper.getServerShortTime()
local remainingTime=chuZhengSec-nowTime
if remainingTime>=wayTime then

return true
elseif remainingTime<=0 then

UIManager.error("集结已结束，无法加入")
errType=1
return false,errType
end








































errType=2













local param={}
return false,errType,param
end

local actorTeam={}
for i,v in ipairs(self.msgData.memberList)do
table.insert(actorTeam,v.actorid)
end
local func1=function()
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,
extraCost=extraCost,
wayTime=wayTime,
orderType=orderType,
minSoldierNum=minSoldierNum,
maxSoldierNum=deltaSoldierCount,
confirmCheckFunc=confirmCheckFunc,
actorTeam=actorTeam,
})
end

if not isPVE and(not xianjieController:checkInMoGongZhengDuo())then
local desc='参与战争将退出护山大阵，是否继续参与？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func1)
else
local isXianXu=false
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData then
isXianXu=monsterData.entitytype==xjServerEnityType.eMonsterHouse
end

if isXianXu then
local entityType=xjServerEnityType.eMonsterHouse
local remainingNum=0
local cfg=monsterData:getCfg()
local entityType_=entityType
if cfg.flag and cfg.flag==2 then
entityType_=bit.lshift(cfg.flag,8)+entityType
end
local rewardTimeConf=xianjieModel:getMonsterInfoCfg(entityType_)
if rewardTimeConf then
local maxTimes=rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(entityType,cfg.flag)
remainingNum=maxTimes-curTimes
end

if remainingNum<=0 then
if cfg.flag and cfg.flag==2 then

UIManager.error("本周界游仙墟的征讨次数已用完")
return
else
local desc='本日征讨奖励次数为0，本次集结将无法获取奖励，是否继续参与？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func1)
end
elseif remainingNum==1 then
local isWarringXianXuTimes=false
local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
for k,v in ipairs(teamHandleList)do
if v.teamData.infoguid then
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
if isWarringXianXuTimes then
local str=(cfg.flag and cfg.flag==2)and"预备队正在前往界游仙墟，剩余奖励次数不足，重复出发可能会无法获得奖励，是否继续参与？"or
"预备队正在前往仙墟，剩余奖励次数不足，重复出发可能会无法获得奖励，是否继续参与？"
UIDialogManager.getCommonDialog(nil,str,func1)
else
func1()
end
else
func1()
end
else
func1()
end
end
end

function UIXianJie_JiJie_msgWin:onPlayerInfoBtnClick(memberIndex)
local massActorId=self.actorId
local massGuid=self.guid
local infoGuid=self.msgData.infoguid
self:showWindow("UIXianJie_JiJie_teamInfoWin",{
isTeamInfo=false,
massActorId=massActorId,
massGuid=massGuid,
showMemberIndex=memberIndex,
infoGuid=infoGuid,
})
end

function UIXianJie_JiJie_msgWin:onMassDetailDataChangeRecv(actorId,guid,sceneidx)
if mathHelper.compareInt64(actorId,self.actorId)and mathHelper.compareInt64(guid,self.guid)then

xianjieController:reqMassDetail(actorId,guid,nil,sceneidx)
end
end

function UIXianJie_JiJie_msgWin:onAddBtnClick()
if not self.msgData then
return
end
local chuZhengSec=self.msgData.sec
if chuZhengSec==0 then

return UIManager.error("集结已结束，无法加入更多队员")
else
local nowTime=timeHelper.getServerShortTime()
local remainingTime=chuZhengSec-nowTime
if remainingTime<=0 then

return UIManager.error("集结已结束，无法加入更多队员")
end
end

local stage=0
local jjType=xianjieModel:getJiJieTypeByGuid(self.msgData.infoguid,self.sceneidx)
local isPVE=not jjType or jjType==xjJjJieBaseType.eMonster
if isPVE then
local monsterData=xianjieModel:getMonsterData(self.msgData.infoguid)
if monsterData then
local cfg=monsterData:getCfg()
stage=cfg.stage
end
end

local infoGuid=self.msgData.infoguid

self:showWindow("UIXianJie_JiJie_YBDListWin",{massActorId=self.actorId,massGuid=self.guid,isPVE=isPVE,infoGuid=infoGuid})
end

function UIXianJie_JiJie_msgWin:onProgressClickMask()
local pos=self.progressClickMask:getChildScreenPointToLocalPointRectangle()
pos.x=pos.x
pos.y=pos.y+10

local desc="集结足够修士即可发起出征，可集结的修士上限受队长的天枢殿等级影响"
UIManager:showWindow('UIConditionTipsOne',{showType=2,str=desc,pos=pos})
end

function UIXianJie_JiJie_msgWin:onEndGoBtn()
if not self.msgData then
return
end
local chuZhengSec=self.msgData.sec
if chuZhengSec==0 then

return
else
local nowTime=timeHelper.getServerShortTime()
local remainingTime=chuZhengSec-nowTime
if remainingTime<=0 then

return UIManager.error("队员正在前往集结，无法取消勾选")
end
end

local isEndGo=self.msgData.endGo==1

local infoguid=self.msgData.infoguid
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieChangeAuto
local actorId=self.actorId
local endGoFlag=isEndGo and 0 or 1
local autoFlag=self.msgData.autoGo or 1
local params={autoFlag,endGoFlag}
local pstr=jsonHelper.encode(params)

local func1=function()
xianjieModel:setJiJieLocalData_lastSelectEndGoFlag(endGoFlag)
xianjieModel:saveJiJieLocalData()
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr)
end
if isEndGo then

return func1()
else

local desc='勾选到点自动出征后，在集结时间结束后未集结到足够的修士也会出征，是否勾选？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func1,REPEAT_TYPE.eXianJieJiJieEndGo)
end

end

function UIXianJie_JiJie_msgWin:refreshJobPanel()
self.privilegeArgs=nil

local jijieXianGuanList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"jijieXianGuan")
if jijieXianGuanList then
local memberActorIdStrLookup={}
if self.msgData and self.msgData.memberCount>0 then
for i,v in ipairs(self.msgData.memberList)do
local actorIdStr=tostring(v.actorid)
memberActorIdStrLookup[actorIdStr]=v.isleader
end
end

self.showJobArgsList={}
for _,v in ipairs(jijieXianGuanList)do
local jobType=v[1]
local privilegeId=v[2]
local isShowAttr=v[3]and v[3]==1 or false
local isMsgShow=v[5]
if isMsgShow and isMsgShow>0 then
local jobInfoList=xianguanModel:getJobInfoListByJobType(jobType)
local jobIdList={}
local actorNameList={}
local jobArgs
for _,jobInfo in ipairs(jobInfoList)do
local actorId=jobInfo.actorid
local jobId=jobInfo.jobId
if actorId then
local actorName=jobInfo.actorname
local actorIdStr=tostring(jobInfo.actorid)

local isHasTq=xianguanConfig.checkJobCfgHasTeQuan(jobId,privilegeId)
if isHasTq and memberActorIdStrLookup[actorIdStr]~=nil then

if xianguanHelper.checkTeQuanPlatformLimit(privilegeId)and xianguanHelper.checkSpecialUseCondition(jobId,privilegeId,false)then
if memberActorIdStrLookup[actorIdStr]==1 or isMsgShow==1 then
if not jobArgs then
jobArgs={}
end
jobIdList[#jobIdList+1]=jobId
actorNameList[#actorNameList+1]=actorName
jobArgs={
jobIdList=jobIdList,
privilegeId=privilegeId,
actorNameList=actorNameList,
isShowAttr=isShowAttr,
}
end
end
end
end
end
if jobArgs then
self.showJobArgsList[#self.showJobArgsList+1]=jobArgs
end
end
end

if next(self.showJobArgsList)then
return self:showJobPanel(true)
end
end
self:showJobPanel(false)








local flag=self:checkXMposChange()
if flag then
self.zhenfaPanel:setActive(true)
self:showJobPanel(false)
else
self.zhenfaPanel:setActive(false)
end
end

function UIXianJie_JiJie_msgWin:showJobPanel(show)
self.jobWidget:SetChildActive(-1,show)
if show then
self.jobWidget:SetChildLayoutGroupCreateItems(0,#self.showJobArgsList,function(index)
local item=self.jobWidget:GetChildLayoutGroupGridItem(0,index-1)
local privilegeId=self.showJobArgsList[index].privilegeId
local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,privilegeId)
local jobIconName=xianguanConfig.getTeQuanIconName(privilegeCfg.icon)
item:SetChildCSImageIcon(-1,jobIconName,true)
item:SetChildButtonClick(-1,function()
self:onClickPrivilegeIcon()
end)
end)
end



































end
























function UIXianJie_JiJie_msgWin:onClickPrivilegeIcon()
if self.privilegeArgs==nil then
local datas={}
for i,v in ipairs(self.showJobArgsList)do
local config=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,v.privilegeId)
local descs=nil
if v.isShowAttr then
descs=config.attrDesc or{}
else
descs={config.descEx}
end
local data={
icon=xianguanConfig.getTeQuanIconName(config.icon),
name=config.name,
actor=FMT.fmt("【{0}】{1}",cfgHelper.get2(cfg_xianguanconfig_get,v.jobIdList[1],'name'),v.actorNameList[1]),
descs=descs,
}
table.insert(datas,data)
end
self.privilegeArgs={
parentWin=self,
datas=datas,
background=XianGuanCampaignType.eWuXuan,
}
end
self:showWindow("UIXianGuanPrivilegeListTipsWin",self.privilegeArgs)
end

function UIXianJie_JiJie_msgWin.on_40_1()
_this:refreshJobPanel()
end

function UIXianJie_JiJie_msgWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eJiJieMsgRule
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end

function UIXianJie_JiJie_msgWin:onSettingBtn()

local actorId=self.actorId
local guid=self.guid
self:showWindow('UIXianJie_JiJie_msgSettingWin',{actorId=actorId,guid=guid})
end

function UIXianJie_JiJie_msgWin:clearJobTimer()
if self.jobTimer then
self:stopTimerByID(self.jobTimer)
self.jobTimer=nil
end
end


function UIXianJie_JiJie_msgWin:checkXMposChange()
local mojunData=xianjieModel:getMoJunData()
if mojunData and mojunData.timeType==2 then
local MJZJID=xianjieModel:getMoJunZhangJieID()
if MJZJID==MoJunZhangJieID.two then
local effList=xianjieModel:getMoJunEffectList(mojunData.seasonType,mojunData.stageIndex)
if effList and effList[1]then

local effIdx=effList[1]
local data=xianjieModel:getMoJunEffectRange(mojunData.seasonType,mojunData.stageIndex,effIdx)
if data then
local confid=data.confid or 0
if confid>0 then
local cfg=cfg_seasonmojuneffectconfig_get(confid)
local effectType=cfg.effectType
if effectType==ZhenFaeffectType.guaXiang then
local effectIndex=0
local str=data.twodata.ex_jsonStr
if str and str~=""then
local decode=jsonHelper.decode(str)
effectIndex=decode[1]
end
local guildid=xianmengModel:getMyXMGuildID()
local xmlist=xianmengModel:getSearchXMMemberList(guildid)
if xmlist and next(xmlist)then
for k,actorData in pairs(xmlist)do
local zmData=xianjieModel:getZongMenData(actorData.actorid)
if zmData then
local gridX=zmData.gridX
local gridZ=zmData.gridZ
if xianjieModel:checkZFGridLimit(effectIndex,gridX,gridZ)then
return true
end
end
end
end
end
end
end
end
end
end
return false
end