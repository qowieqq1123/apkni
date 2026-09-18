







def_class("UIMoJie_JiJie_teamListMonsterWin",UIWindowBase)









function UIMoJie_JiJie_teamListMonsterWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.fightPaixu=UIButton.get(self,2)
self.getRewardNumText=UIText.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.infoPaixu=UIButton.get(self,5)
self.itemPanel=UIObject.get(self,6)
self.itemScrollView=UIObject.get(self,7)
self.noSign=UIObject.get(self,8)
self.ruleBtn=UIButton.get(self,9)
self.ybdsetBtn=UIButton.get(self,10)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fightPaixu:setButtonClick(function()self:onFightPaixu()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.infoPaixu:setButtonClick(function()self:onInfoPaixu()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.ybdsetBtn:setButtonClick(function()self:onYbdsetBtn()end)



end


function UIMoJie_JiJie_teamListMonsterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.fightPaixu);self.fightPaixu=nil;
_UIObject_release(self.getRewardNumText);self.getRewardNumText=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.infoPaixu);self.infoPaixu=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.ybdsetBtn);self.ybdsetBtn=nil;
end
















local _this
local _teamItemCmpIndex={
bg=0,
iconColorImg=1,
iconImg=2,
iconTag=3,
tagNumTxt=4,
nameTxt=5,
notXm=6,
signBgIcon=7,
signIcon=8,
signKuangIcon=9,
xmName=10,
rewardBtn=11,
fight=12,
state=13,
time=14,
joinBtn=15,
joinSign=16,
missSign=17,
resProgressImg=18,
resProgressTxt=19,
findClick=20,
progressBar=21,
timeRoot=22,
hasXm=23,
monsterModel=24,
typeIcon=25,
jieflag=26,
monsterInfoPanel=27,
notDataPanel=28,
notDataTips=29,
proRoot=30,
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


local _noState={
[xjServerEnityType.eMoJieShangGuMoster]=true,
[xjServerEnityType.eMoJieZhenYan_Small]=true,
[xjServerEnityType.eMoJieZhenYan_Spe]=true,
[xjServerEnityType.eMoJieZhenYan_Big]=true,
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




function UIMoJie_JiJie_teamListMonsterWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMoJie_JiJie_teamListMonsterWin:__delete()
self:unbindComponents()
self:clearYbdTeamViewUpdateTimer()
end




function UIMoJie_JiJie_teamListMonsterWin:onShow(argtable,afterOnloaded)

xianjieController:reqMassTeamList()
local isOpenYBDPage=argtable and argtable.isOpenYBDPage
self.page=argtable and argtable.page
self.parentWin=argtable and argtable.parentWin
if isOpenYBDPage then
self:onYbdsetBtn(isOpenYBDPage)
UIManager:invokeUIMethod("UIXianJie_JiJie_teamListBgWin","changeExtraArgs",nil)
end



self:refreshView()
end


function UIMoJie_JiJie_teamListMonsterWin:onHide()
self:clearYbdTeamViewUpdateTimer()
end





function UIMoJie_JiJie_teamListMonsterWin:onClickMask()
end



function UIMoJie_JiJie_teamListMonsterWin:onCloseBtn()
UIManager:invokeUIMethod(self.parentWin,"onClickClose")
end



function UIMoJie_JiJie_teamListMonsterWin:onFightPaixu()
end



function UIMoJie_JiJie_teamListMonsterWin:onGotoBtn()
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启，无法跳转")
return false
end


local existedMoJun=(mainControl:isSceneType(eSceneType.eXianJie)and
xianjienSceneType:isMoJie(xianjieModel:getScenceType()))and
xianjieModel:isShowMoJunMenuGroup()
if existedMoJun then
xianjieController:jumpMoJieMoJun()
else

xianjieController:openWin('UIMoJieExplorationWin',{page=4,extra={selectid=1,selectCnt=1}})
end


self:onCloseBtn()
end



function UIMoJie_JiJie_teamListMonsterWin:onInfoPaixu()
end



function UIMoJie_JiJie_teamListMonsterWin:onRuleBtn()
local rules=cfgHelper.get2(cfg_devildombaseconfig_get,1,'monsterRuleDescLang')
local langId=rules and rules[1]or nil
if langId then
self:showWindow('UIRuleWin',{
title="规则",
mode=3,
name=rules[1],
showBlack=true
})
end
end



function UIMoJie_JiJie_teamListMonsterWin:onYbdsetBtn(pageIndex)

local parentPage=self.page
pageIndex=pageIndex or self.page
UIManager:showWindow("UIXianJie_JiJie_YBDSetBgWin",{
page=pageIndex,
extraArgs={
parentPage=parentPage
}
})
end

function UIMoJie_JiJie_teamListMonsterWin:refreshView()
self.ybdTeamList=xianjieModel:getJiJieSimpleDataListByJJType(xjJjJieBaseType.eMoJie)or{}

self:clearYbdTeamViewUpdateTimer()
local num=#self.ybdTeamList
local hasTeam=num>0
self.itemScrollView:setActive(hasTeam)
self.noSign:setActive(not hasTeam)
if hasTeam then

self:refreshYbdTeamList()


self:setYbdTeamViewUpdateTimer()
end

local isOpenYbdSys=xianjieModel:checkJiJieYBDSysIsOpen()
self.ybdsetBtn:setActive(isOpenYbdSys)
end

function UIMoJie_JiJie_teamListMonsterWin:refreshYbdTeamList()
local teamCount=#self.ybdTeamList
self.itemPanel:setChildLayoutGroupCreateItems(teamCount,function(index)
if _this==nil then
return
end

local item=_this.itemPanel:getChildLayoutGroupGridItem(index-1)
local teamData=_this.ybdTeamList[index]
local infoguid=teamData.guid
local monsterData=xianjieModel:getMonsterData(infoguid)

local sceneType=xianjieModel:getScenceType()
local isMoJieMass=teamData.isMoJieMass or false
local isInMoJie=xianjienSceneType:isMoJie(sceneType)or false
local isSameScene=isMoJieMass==isInMoJie

item:SetChildActive(-1,true)

if isSameScene then
if monsterData then
_this:setYbdTeamItemMonsterInfo_HasMonsterData(index,item,monsterData)
else
_this:setYbdTeamItemMonsterInfo_NonHasMonsterData(item,teamData)
end
else
item:SetChildActive(_teamItemCmpIndex.monsterInfoPanel,false)
item:SetChildActive(_teamItemCmpIndex.notDataPanel,true)
local typeStr=isMoJieMass and"魔界魔物 "or"仙界魔物 "
local tipsStr=FMT.fmt("{0}无法查看信息",typeStr)
item:SetChildText(_teamItemCmpIndex.notDataTips,tipsStr)
end


local teamFight=teamData.fight and mathHelper.int64_to_number(teamData.fight)or 0
item:SetChildText(_teamItemCmpIndex.fight,mathHelper.formatNumber5(teamFight,2))

_this:setMoJieJiJieState(index,item,teamData)


item:SetChildButtonClick(_teamItemCmpIndex.findClick,function()
if _this==nil then return end

_this:onYbdTeamInfoBtnClick(index)
end,true)
end)
end

function UIMoJie_JiJie_teamListMonsterWin:setYbdTeamItemMonsterInfo_HasMonsterData(index,item,monsterData)
item:SetChildActive(_teamItemCmpIndex.monsterInfoPanel,true)
item:SetChildActive(_teamItemCmpIndex.notDataPanel,false)

local cfg=monsterData:getCfg()

local bgIcon=FMT.fmt('image_gwtouxiangpjk_{0}',cfg.stage)
item:SetChildCSImageSprite(_teamItemCmpIndex.iconColorImg,globalABLookup.global,bgIcon)

local groupId=cfg.monster[1]
if monsterData.entitytype==xjServerEnityType.eMonsterHouse or
monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small or
monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Small or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Big or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe or
monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then
item:SetChildActive(_teamItemCmpIndex.typeIcon,true)
item:SetChildActive(_teamItemCmpIndex.jieflag,cfg.flag and(cfg.flag==2))

item:SetChildActive(_teamItemCmpIndex.iconColorImg,true)
item:SetChildUIModelRemoveTarget(_teamItemCmpIndex.monsterModel)
item:SetChildCSImageSprite(_teamItemCmpIndex.iconColorImg,globalABLookup.global,_colorKuang[monsterData.entitytype][cfg.flag or 0])
comHelper.setChildModelRawImage_monsterGroup(item,groupId,_teamItemCmpIndex.iconImg,0,eHeadCenterType.eHead)

local typeImg=_showType[monsterData.entitytype]
if typeImg then
item:SetChildCSImageSprite(_teamItemCmpIndex.typeIcon,typeImg[1],typeImg[2])
else
item:SetChildCSImageIcon(_teamItemCmpIndex.typeIcon,"",true)
end
else
item:SetChildActive(_teamItemCmpIndex.monsterModel,false)
item:SetChildActive(_teamItemCmpIndex.typeIcon,false)
item:SetChildActive(_teamItemCmpIndex.iconColorImg,true)
comHelper.setChildModelRawImage_monsterGroup(item,groupId,_teamItemCmpIndex.iconImg,0,eHeadCenterType.eHead)
end


local stageBGIcon=FMT.fmt('image_gwtouxiangdjk_{0}',cfg.stage)


local isMoZong=monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small or monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big
local isZhenYan=monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Small or monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Big or monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe

local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupId)

local nameStr=(isMoZong or isZhenYan)and groupcfg.name or FMT.fmt("{0}阶 {1}",tostring(cfg.stage),groupcfg.name)
if _noState[monsterData.entitytype]then
nameStr=groupcfg.name
end
item:SetChildText(_teamItemCmpIndex.nameTxt,nameStr)
if isMoZong or isZhenYan then
item:SetChildAnchoredPos(_teamItemCmpIndex.nameTxt,-58.5,22)
else
item:SetChildAnchoredPos(_teamItemCmpIndex.nameTxt,-58.5,0)
end


local boxStage=cfg.stage<=5 and cfg.stage or 5
local box_icon=cfgHelper.get2(cfg_zhengzhanshanhaiboxconfig_get,boxStage,'icon')
item:SetChildCSImageIcon(_teamItemCmpIndex.rewardBtn,box_icon,true)
item:SetChildButtonClick(_teamItemCmpIndex.rewardBtn,function()
if _this==nil then return end
_this:onItemBoxClick(index)
end)

if monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Big or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Small or
monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big then
item:SetChildActive(_teamItemCmpIndex.proRoot,true)
local proWidget=item:GetChildWidgetBase(_teamItemCmpIndex.proRoot)
local shield=monsterData.shield
local const_def=monsterData:getConstDefCfg()
local maxShield=const_def.shield[1]
local _shield=shield/maxShield*100
_shield=string.format("%.2f",_shield)
proWidget:SetChildText(1,FMT.fmt("{0}%",_shield))
else
item:SetChildActive(_teamItemCmpIndex.proRoot,false)
end
end

function UIMoJie_JiJie_teamListMonsterWin:setYbdTeamItemMonsterInfo_NonHasMonsterData(item,teamData)
local infoGuid=teamData.guid

local entityType=xianjieModel:getEntityTypeByGuid(infoGuid,teamData.sceneidx)
if entityType==xjServerEnityType.eClientBuild then

if xianjieModel:isMoJunBuild_int64(infoGuid)then

local mojunData=xianjieModel:getMoJunData()
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,mojunData.build_id)

local bgIcon='image_gwtouxiangpjk_5'
item:SetChildCSImageSprite(_teamItemCmpIndex.iconColorImg,globalABLookup.global,bgIcon)

local groupId=mojunData.gwzid

item:SetChildActive(_teamItemCmpIndex.typeIcon,true)
local _ab="ui/windows/xianjie/xianjiemain_atlas_pak.ab"
local _iconName="image_mojieui_wz1"
item:SetChildCSImageSprite(_teamItemCmpIndex.typeIcon,_ab,_iconName)

item:SetChildText(_teamItemCmpIndex.nameTxt,cfg.name)

item:SetChildActive(_teamItemCmpIndex.monsterModel,false)
item:SetChildActive(_teamItemCmpIndex.iconColorImg,true)
comHelper.setChildModelRawImage_monsterGroup(item,groupId,_teamItemCmpIndex.iconImg,0,eHeadCenterType.eHead)

local box_icon=cfgHelper.get2(cfg_zhengzhanshanhaiboxconfig_get,5,'icon')
item:SetChildCSImageIcon(_teamItemCmpIndex.rewardBtn,box_icon,true)
item:SetChildButtonClick(_teamItemCmpIndex.rewardBtn,function()
if _this==nil then return end
local mojunData=xianjieModel:getMoJunData()
if not mojunData then
return
end
local winParams={
parentWin=_this,
seasonType=mojunData.seasonType,
stageIndex=mojunData.stageIndex,
build_id=mojunData.build_id,
}
_this:showWindow("UIMoJieMoJunRewardWin",winParams)
end)
end
end
end

function UIMoJie_JiJie_teamListMonsterWin:setMoJieJiJieState(index,item,teamData)
local nowTime=timeHelper.getServerShortTime()
local chuZhenTime=teamData.sec or 0
local stateStr=''
local timeStr="--:--:--"
local isStarted=false
local isShowTime=false
if chuZhenTime==0 then
stateStr="<color=#549327>出击中</color>"
isStarted=true
elseif nowTime>=chuZhenTime then
stateStr="<color=#ca631d>准备出击</color>"
else
stateStr="<color=#ca631d>集结中</color>"
timeStr=timeHelper.format_time_stamp(chuZhenTime-nowTime)
isShowTime=true
end
item:SetChildText(_teamItemCmpIndex.state,stateStr)
item:SetChildText(_teamItemCmpIndex.time,timeStr)
item:SetChildActive(_teamItemCmpIndex.timeRoot,isShowTime)
item:SetChildActive(_teamItemCmpIndex.progressBar,not isStarted)
if not isStarted then
local percent=teamData.now/teamData.max*100
item:SetChildProgressValue(_teamItemCmpIndex.progressBar,percent,100)
item:SetChildProgressText(_teamItemCmpIndex.progressBar,FMT.fmt("{0}/{1}",teamData.now,teamData.max))
end

local isJoined=teamData.on==1
item:SetChildActive(_teamItemCmpIndex.joinBtn,not isJoined and not isStarted)
item:SetChildActive(_teamItemCmpIndex.joinSign,isJoined)
item:SetChildActive(_teamItemCmpIndex.missSign,not isJoined and isStarted)
item:SetChildButtonClick(_teamItemCmpIndex.joinBtn,function()
if _this==nil then return end
_this:onYbdTeamItemJoinClick(index)
end,true)
end

function UIMoJie_JiJie_teamListMonsterWin:setYbdTeamViewUpdateTimer()
self:clearYbdTeamViewUpdateTimer()
if self.updateTimer==nil then
self.updateTimer=self:setTimer(1,0,function()
if not _this then
return
end
self:refreshTeamList_update()
end)
end
end

function UIMoJie_JiJie_teamListMonsterWin:refreshTeamList_update()
local grids=self.itemPanel:getChildLayoutGroupGridList()
for index=1,grids.Count do
local item=grids[index-1]
local teamData=self.ybdTeamList[index]

self:setMoJieJiJieState(index,item,teamData)
end
end

function UIMoJie_JiJie_teamListMonsterWin:clearYbdTeamViewUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIMoJie_JiJie_teamListMonsterWin:onYbdTeamInfoBtnClick(index)
local teamData=self.ybdTeamList[index]
local massguid=teamData.massguid
local actorId=teamData.actorid
local sceneidx=teamData.sceneidx
local func=function()
UIManager:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=massguid,sceneidx=sceneidx})
end

local teamSceneIdx=teamData.sceneidx or false
local teamLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(teamSceneIdx)
local nowSceneIdx=xianjieModel:getSceneIndex()
local nowLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(nowSceneIdx)
local isSameScene=teamLogicSceneType==nowLogicSceneType
if not isSameScene then
local content="该队伍不在当前场景 是否跳转至对应场景？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
local sceneType=xianjieModel:sceneIndex2SceneType(teamSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
return func()
end)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return
end

func()
end

function UIMoJie_JiJie_teamListMonsterWin:onYbdTeamItemJoinClick(index)
local teamData=self.ybdTeamList[index]


local teamSceneIdx=teamData.sceneidx or false
local teamLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(teamSceneIdx)
local nowSceneIdx=xianjieModel:getSceneIndex()
local nowLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(nowSceneIdx)
local isSameScene=teamLogicSceneType==nowLogicSceneType
if not isSameScene then
local content="该队伍不在当前场景 是否跳转至对应场景？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
local sceneType=xianjieModel:sceneIndex2SceneType(teamSceneIdx)
return xianjieController:jumpXianJie(sceneType)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return
end

local massguid=teamData.massguid
local actorId=teamData.actorid
local infoguid=teamData.guid
local sceneidx=teamData.sceneidx
local monsterData=xianjieModel:getMonsterData(infoguid)

if not monsterData then

if xianjieModel:isMoJunBuild_int64(infoguid)then
local teamDirtyFlag=xianjieModel:getJiJieDirtyData(actorId,massguid,infoguid,sceneidx)
if not teamDirtyFlag then

UIManager.error("集结不存在")
return xianjieController:reqMassTeamList()
end




local zmData=xianjieModel:getZongMenData(actorId)
local zmSceneIdx=zmData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(zmSceneIdx)then

return UIManager.error("无法加入其他仙域的集结")
end


UIManager:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=massguid,sceneidx=sceneidx})
end
return
end

local isWarringXianXuTimes=false
local cfg=monsterData:getCfg()

if monsterData.entitytype==xjServerEnityType.eMonsterHouse then


local entityType=monsterData.entitytype
if cfg.flag and cfg.flag==2 then
entityType=bit.lshift(cfg.flag,8)+entityType
end

local rewardTimeConf=xianjieModel:getMonsterInfoCfg(entityType)
local maxTimes=rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(monsterData.entitytype,cfg.flag)
local least=maxTimes-curTimes



if least<=0 then
if cfg.flag and cfg.flag==2 then
UIManager.error("本周界游仙墟的征讨次数已用完")
return
end
elseif least==1 then








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
end
end


local teamDirtyFlag=xianjieModel:getJiJieDirtyData(actorId,massguid,infoguid,sceneidx)
if not teamDirtyFlag then



UIManager.error("集结不存在")
return xianjieController:reqMassTeamList()
end

local zmData=xianjieModel:getZongMenData(actorId)
local zmSceneIdx=zmData.sceneidx

if xianjienSceneIndexType:isOhterXianYu(zmSceneIdx)then

return UIManager.error("无法加入其他仙域的集结")
end


if isWarringXianXuTimes then


local str=(cfg.flag and cfg.flag==2)
and"预备队正在前往界游仙墟，剩余奖励次数不足，重复出发可能会无法获得奖励，是否继续参与？"
or"预备队正在前往仙墟，剩余奖励次数不足，重复出发可能会无法获得奖励，是否继续参与？"
UIDialogManager.getCommonDialog(nil,str,function()

UIManager:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=massguid,sceneidx=sceneidx})
end)
else

UIManager:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=massguid,sceneidx=sceneidx})
end

end

function UIMoJie_JiJie_teamListMonsterWin:onItemBoxClick(idx)
local teamData=self.ybdTeamList[idx]
local infoguid=teamData.guid
local monsterData=xianjieModel:getMonsterData(infoguid)
local cfg=monsterData:getCfg()
local args={
parentWin=self,
drop={cfg.drop,cfg.box},
}
self:showWindow("UIXianJie_MonsterDropWin",args)
end