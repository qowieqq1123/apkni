







def_class("UIXM_ZZSH_monsterInfoWin",UIWindowBase)









function UIXM_ZZSH_monsterInfoWin:bindComponents()

self.attackNum=UIText.get(self,0)
self.attackNumObj=UIObject.get(self,1)
self.attackShowBtn=UIButton.get(self,2)
self.autoBtn=UIButton.get(self,3)
self.autoDesc=UIText.get(self,4)
self.autoMark=UIImage.get(self,5)
self.commitBtn=UIButton.get(self,6)
self.commitBtnTxt=UIText.get(self,7)
self.costDesc=UIText.get(self,8)
self.costIcon=UIImage.get(self,9)
self.costObj=UIButton.get(self,10)
self.frameAnim=UIObject.get(self,11)
self.lockPanel=UIObject.get(self,12)
self.lockTxt=UIText.get(self,13)
self.mask=UIObject.get(self,14)
self.monster2Info=UIObject.get(self,15)
self.monsterInfo=UIObject.get(self,16)
self.rewardPanel=UIObject.get(self,17)
self.root=UIObject.get(self,18)
self.ruleBtn=UIButton.get(self,19)
self.ruleSelect=UIObject.get(self,20)
self.showRewardBtn=UIButton.get(self,21)
self.stateTimeTxt=UIText.get(self,22)
self.stateTxt=UIText.get(self,23)
self.unlockPanel=UIObject.get(self,24)
self.yicanyu=UIObject.get(self,25)
self.zhaojiBtn=UIButton.get(self,26)

self.attackShowBtn:setButtonClick(function()self:onAttackShowBtn()end)

self.autoBtn:setButtonClick(function()self:onAutoBtn()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.costObj:setButtonClick(function()self:onCostObj()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.showRewardBtn:setButtonClick(function()self:onShowRewardBtn()end)

self.zhaojiBtn:setButtonClick(function()self:onZhaojiBtn()end)



end


function UIXM_ZZSH_monsterInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attackNum);self.attackNum=nil;
_UIObject_release(self.attackNumObj);self.attackNumObj=nil;
_UIObject_release(self.attackShowBtn);self.attackShowBtn=nil;
_UIObject_release(self.autoBtn);self.autoBtn=nil;
_UIObject_release(self.autoDesc);self.autoDesc=nil;
_UIObject_release(self.autoMark);self.autoMark=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitBtnTxt);self.commitBtnTxt=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.frameAnim);self.frameAnim=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.lockTxt);self.lockTxt=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.monster2Info);self.monster2Info=nil;
_UIObject_release(self.monsterInfo);self.monsterInfo=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.ruleSelect);self.ruleSelect=nil;
_UIObject_release(self.showRewardBtn);self.showRewardBtn=nil;
_UIObject_release(self.stateTimeTxt);self.stateTimeTxt=nil;
_UIObject_release(self.stateTxt);self.stateTxt=nil;
_UIObject_release(self.unlockPanel);self.unlockPanel=nil;
_UIObject_release(self.yicanyu);self.yicanyu=nil;
_UIObject_release(self.zhaojiBtn);self.zhaojiBtn=nil;
end
















local _this


function UIXM_ZZSH_monsterInfoWin:onLoaded(...)
_this=self
self:bindComponents()
local pos=self:getChildCanvas(-1)
UIManager:invokeUIMethod('UIXM_ZZSH_PvEMainWin','setMoneyRootCanves',true,pos[1],pos[2]+1)
end


function UIXM_ZZSH_monsterInfoWin:__delete()
_this=nil
self:unbindComponents()

local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
if qbData and self.isBoss then
qbData:invokeObjFunc('activeTitle',false)
end
if UIManager:isActive('UIXM_ZZSH_monsterAllTeamWin')then
UIManager:closeWindow('UIXM_ZZSH_monsterAllTeamWin')
end
if self.mapView then
if self:checkWin()then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','setMapView',self.mapView)
end
end
UIManager:invokeUIMethod('UIXM_ZZSH_PvEMainWin','setMoneyRootCanves',false)
end


function UIXM_ZZSH_monsterInfoWin:onHide()
if self.ZSTime then
self.ZSTime=nil
end
end

function UIXM_ZZSH_monsterInfoWin:getMapView()
local view=UIManager:invokeUIMethod('UIXM_ZZSH_selfPVETeamWin','getMapView')
if view==nil then
view=UIManager:invokeUIMethod('UIXM_ZZSH_monsterSelectWin','getMapView')
end
if view==nil then
view=UIManager:invokeUIMethod('UIXM_ZZSH_resourceSelectWin','getMapView')
end
return view
end




function UIXM_ZZSH_monsterInfoWin:onShow(argtable,afterOnloaded)
self.qbGuid=argtable.qbGuid
self.mapView=argtable.view
local view=self:getMapView()
if view then
self.mapView.scale=view.scale
view.g_x=self.mapView.g_x
view.g_y=self.mapView.g_y
view.isChange=true
end
self.autoCheck=false
self:refreshMask()
self:refreshInfo()
local cb=function()
self:onLoadFinish()
end
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameAnim:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,cb)
else
self.root:setChildCanvasGroupAlpha(0)
self.frameAnim:setChildModelAnimationState(eAnimationID.bd_stand)
cb()
end

if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshState()
self:refreshBossLeaveTime()
end)
end
end

function UIXM_ZZSH_monsterInfoWin:containQBGuid(guid)
return self.qbGuid==guid
end

function UIXM_ZZSH_monsterInfoWin:refreshView(guid)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then
return
end
self.qbGuid=guid
if self.mapView then
self.mapView.g_x=qbData.x
self.mapView.g_y=qbData.y
end
self:refreshInfo()
UIManager:invokeUIMethod('UIXM_ZZSH_monsterAllTeamWin','refreshView',guid)
end

function UIXM_ZZSH_monsterInfoWin:clearMapView()
self.mapView=nil
end

function UIXM_ZZSH_monsterInfoWin:onLoadFinish()
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.3,func)
end

function UIXM_ZZSH_monsterInfoWin:checkWin()
return not UIManager:isActive('UIXM_ZZSH_selfPVETeamWin')and
not UIManager:isActive('UIXM_ZZSH_monsterSelectWin')and
not UIManager:isActive('UIXM_ZZSH_resourceSelectWin')
end

function UIXM_ZZSH_monsterInfoWin:refreshMask()
local showMask=self:checkWin()
self.mask:setActive(showMask)
end

function UIXM_ZZSH_monsterInfoWin:refreshInfo()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local detail=qbData:getDetail()
local teamInfo=qbData:getTeamInfo()
local cfg=qbData:getCfg()
local isBoss=cfg.stage>=5
self.isBoss=isBoss
local hasTeam=teamInfo~=nil

if self.isBoss then
qbData:invokeObjFunc('activeTitle',true)
end

local num=qbData:getAllTeamNum()
local showAttactNum=num>0
self.attackNumObj:setActive(showAttactNum)
if showAttactNum then
self.attackNum:setText(tostring(num))
end

self.monsterInfo:setActive(not isBoss)
self.monster2Info:setActive(isBoss)

local skillParam=cfg.showSkillParam
local isShowSkill=skillParam~=nil and next(skillParam)~=nil


if not isBoss then
local widget=self.monsterInfo:getWidgetBase()

local bgIcon=FMT.fmt('image_gwtouxiangpjk_{0}',cfg.stage)
widget:SetChildCSImageSprite(0,globalABLookup.global,bgIcon)

local groupid=cfg.monster[1]
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,1,0,eHeadCenterType.eHead)

local stageBGIcon=FMT.fmt('image_gwtouxiangdjk_{0}',cfg.stage)
widget:SetChildCSImageSprite(2,globalABLookup.global,stageBGIcon)
widget:SetChildText(3,tostring(cfg.stage))

local costTime=zhengzhanshanhaiModel:getQingBaoWayTime(qbData)
local time_str=timeHelper.format_time_stamp3(costTime)
widget:SetChildText(4,time_str)

local nameStr=qbData:getName()



widget:SetChildText(5,nameStr)

widget:SetChildActive(14,false)
local xmData,ZSflag=qbData:getXM()
if ZSflag==1 then
local lerp=self:judetime()
if lerp>0 then
widget:SetChildActive(14,true)
self:setZhuanShuTimer(widget,lerp)
end
end
local hasXM=xmData~=nil
widget:SetChildActive(6,hasXM)
local xmName_str
if hasXM then
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(7,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(6,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(8,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
xmName_str='无'
end
widget:SetChildText(9,xmName_str)

local percent
if detail then
percent=detail.percent
else
percent=10000
end
widget:SetChildIconFillAmount(10,percent/10000)
local rate_str=FMT.fmt('{0}%',percent/100)
widget:SetChildText(11,rate_str)

widget:SetChildActive(12,isShowSkill)
if isShowSkill then
widget:SetChildButtonClick(13,function()
if _this==nil then return end
_this:onSkillBtnClick(skillParam)
end)
end
else
local widget=self.monster2Info:getWidgetBase()

widget:SetChildCSImageSprite(0,globalABLookup.zzshbossicons,cfg.bossIcon)

local nameStr=qbData:getName()




widget:SetChildText(1,nameStr)

local percent
if detail then
percent=detail.percent
else
percent=10000
end
local rate_str=FMT.fmt('{0}%',percent/100)
if percent<=1 then
rate_str="垂死"
percent=0
end
widget:SetChildIconFillAmount(2,percent/10000)
widget:SetChildText(3,rate_str)

widget:SetChildButtonClick(4,function()
if _this==nil then return end
_this:onRankBtnClick()
end)

widget:SetChildActive(5,isShowSkill)
if isShowSkill then
widget:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onSkillBtnClick(skillParam)
end)
end

self:refreshBossLeaveTime(widget)
end


local rewards=zhengzhanshanhaiModel:getRewardShow(cfg)
local rnum=#rewards
self.rewardPanel:setChildLayoutGroupCreateItems(rnum)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
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
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<=0
rwItem:SetChildActive(1,showSign)
end

local isunlock,locklv=zhengzhanshanhaiModel:checkMonsterBattleState(cfg.stage,false)
local join=zhengzhanshanhaiModel:checkPvEJoin(self.qbGuid)
self.unlockPanel:setActive(isunlock and join)
self.yicanyu:setActive(isunlock and not join)
self.lockPanel:setActive(not isunlock)
if isunlock then

local showAutoBtn=not hasTeam
self.autoBtn:setActive(showAutoBtn)
if showAutoBtn then
local maxNum,fixNum=zhengzhanshanhaiModel:getMaxMonsterTeamNum()
self.autoDesc:setText(FMT.fmt('集结{0}支队伍自动出击',fixNum))
self:refreshAutoMark()
end

local showCost=not hasTeam
self.costObj:setActive(showCost)
if showCost then
self.costIcon:setImageIcon(moneyModel.getIconNameEx(eMoneyType.mtXuKongLing),false)
local need=zhengzhanshanhaiModel:getXuKongLingNeed(qbData.infotype)
local num_str=tostring(need)
self.costDesc:setText(num_str)
end

self:refreshState()

local commit_str
if hasTeam then
if teamInfo.sec>0 then
commit_str='查看队伍'
else

local isIn=zhengzhanshanhaiModel:checkInMyWaiPai(self.qbGuid)
if isIn then
commit_str='查看集结'
else
commit_str='参与集结'
end
end
else
commit_str='发起集结'
end
self.commitBtnTxt:setText(commit_str)

local showZhaoJi=false
if hasTeam then
if teamInfo.sec<0 then
showZhaoJi=true
end
end
self.zhaojiBtn:setActive(showZhaoJi)
else
local lock_str=FMT.fmt('仙盟谋略“山海巡狩”{0}级',locklv)
self.lockTxt:setText(lock_str)
end
end

function UIXM_ZZSH_monsterInfoWin:refreshState()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
if qbData==nil then return end
local teamInfo=qbData:getTeamInfo()
local hasTeam=teamInfo~=nil

local showState=hasTeam
self.stateTxt:setActive(showState)
if showState then
local state,time=zhengzhanshanhaiModel:getPvETeamState(zhengzhanshanhaiModel.qbType.eMonster,teamInfo.sec)
self.stateTxt:setText(state)
local time_str
if time>0 then
time_str=timeHelper.format_time_stamp3(time)
else
time_str='--'
end
self.stateTimeTxt:setText(time_str)
end
end

function UIXM_ZZSH_monsterInfoWin:refreshBossLeaveTime(widget)
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
if qbData==nil then return end
local cfg=qbData:getCfg()
if widget==nil then
widget=self.monster2Info:getWidgetBase()
end

local remove=zhengzhanshanhaiController:getZZSHCfg('remove')
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,remove,0,0)
local cur=gameUtilityModel.getServerLongTime()
if cur>t1 then
local w=timeHelper.getWeakDateEx2(cur)
if w==5 then
t1=t1+(24-remove)*3600
else
t1=t1+86400
end
end
local lerp=t1-cur
local time_str=FMT.fmt('{0}后离开',timeHelper.format_time_stamp(lerp))
widget:SetChildText(6,time_str)
end

function UIXM_ZZSH_monsterInfoWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_ZZSH_monsterInfoWin:onClickMask()
self:onCloseClick()
end

function UIXM_ZZSH_monsterInfoWin:onCloseClick()
self:closeSelf()
end

function UIXM_ZZSH_monsterInfoWin:onRuleBtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='act_zzsh_monster_rule_%d'
d.closeCB=function()
if _this==nil then return end
_this:refreshRuleSelect(false)
end
UIManager:showWindow('UIRuleWin',d)
self:refreshRuleSelect(true)
end

function UIXM_ZZSH_monsterInfoWin:refreshRuleSelect(flag)
self.ruleSelect:setActive(flag)
end

function UIXM_ZZSH_monsterInfoWin:onRankBtnClick()
self:showWindow('UIXM_ZZSH_BossHurtRankWin',{qbGuid=self.qbGuid})
end

function UIXM_ZZSH_monsterInfoWin:onSkillBtnClick(skillParam)
self:showWindow('UITeXingTipsListWin',{skillParamList=skillParam,pos={440,0}})
end

function UIXM_ZZSH_monsterInfoWin:onZhaojiBtn()
local qbGuid=self.qbGuid
local qbData=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData==nil then
UIManager.info('该异兽已被消灭')
return
end
local teamInfo=qbData:getTeamInfo()
local hasTeam=teamInfo~=nil
if hasTeam then
if not zhengzhanshanhaiModel:checkZhaoJiCoolDown(true)then
return
end
zhengzhanshanhaiController:reqMonsterZhaoJi(self.qbGuid)
end
end

function UIXM_ZZSH_monsterInfoWin:onShowRewardBtn()
zhengzhanshanhaiController:showMonsterReward(self.qbGuid)
end

function UIXM_ZZSH_monsterInfoWin:onAttackShowBtn()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local detail=qbData:getDetail()
if detail then
UIManager:showWindow('UIXM_ZZSH_monsterAllTeamWin',{qbGuid=self.qbGuid})
end
end

function UIXM_ZZSH_monsterInfoWin:onCommitBtn()
local qbGuid=self.qbGuid
local qbData=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData==nil then
UIManager.info('该异兽已被消灭')
return
end
local teamInfo=qbData:getTeamInfo()
local hasTeam=teamInfo~=nil
if hasTeam then

zhengzhanshanhaiModel:checkQingBaoDetail_xm(qbGuid)
else
if not qbData:checkXM(true)then
return
end
if not zhengzhanshanhaiModel:checkPvEJoin(qbGuid,true)then
return
end

local cfg=qbData:getCfg()
if not zhengzhanshanhaiModel:checkMonsterBattleState(cfg.stage,true)then
return
end

if not zhengzhanshanhaiModel:checkMyPvEWaiPaiNum(true)then
return
end

if not zhengzhanshanhaiModel:checkXuKongLingCost(qbData.infotype,true)then
return
end

local mapId=zhengzhanshanhaiModel:getMapID(2)
local monsterGroupId=cfg.monster[1]
local mass=zhengzhanshanhaiController:getZZSHCfg('mass')
local setoutnum=self.autoCheck and mass[1]or 0
local monsterList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local winArgs=
{
enterCallBack=function(selectList,zfId,mapId)
if zhengzhanshanhaiModel:checkJoin()then
local qbData_=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData_~=nil then
local dzlist={}
for i,v in ipairs(selectList)do
table.insert(dzlist,v[2])
end

zhengzhanshanhaiController:reqMonsterJiJie(qbGuid,setoutnum,dzlist)
else
UIManager.error('该异兽已被消灭')
end
end
fightController:closeSelectStage()
zhengzhanshanhaiController:finishFightOpen({showCloud=false,jumpQB=qbGuid,not_showlogtips=true})
end,
enterTxt="山海世界",
cancelCallBack=function()
fightController:closeSelectStage()
zhengzhanshanhaiController:finishFightOpen({showCloud=false,jumpQB=qbGuid,not_showlogtips=true})
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,
sureBodyid=5280,
mapId=mapId,
setteamlist_nil=true,


}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
zhengzhanshanhaiController:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end
winArgs.dzInfoFuncList=dzInfoFuncList
winArgs.checkDZSortFunc=zhengzhanshanhaiModel.checkDZSortFunc
zhengzhanshanhaiController:setFigthReady(true)
fightController.showPrepareWin(fightPreSelectModel.fightType.zzshPvEMonster,winArgs)
end
end

function UIXM_ZZSH_monsterInfoWin:onCostObj()
gainControl:showGainWin(eMoneyType.mtXuKongLing)
end

function UIXM_ZZSH_monsterInfoWin:onAutoBtn()
self.autoCheck=not self.autoCheck
self:refreshAutoMark()
end

function UIXM_ZZSH_monsterInfoWin:refreshAutoMark()
local icon=self.autoCheck and'image_dygou_2'or'image_dygou_1'
self.autoMark:setSprite(globalABLookup.global,icon)
end


function UIXM_ZZSH_monsterInfoWin:setZhuanShuTimer(widget,lerp)
local func
func=function()
local lerp=self:judetime()
if lerp>0 then
local time_str=FMT.fmt('{0}后离开',timeHelper.format_time_stamp(lerp))
widget:SetChildText(14,time_str)
else
self.ZSTime=nil
end
end

func()
self.ZSTime=self:setTimer(1,0,func)
end

function UIXM_ZZSH_monsterInfoWin:judetime()
local remove=zhengzhanshanhaiController:getZZSHCfg('remove')
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,remove,0,0)
local cur=gameUtilityModel.getServerLongTime()
if cur>t1 then
local w=timeHelper.getWeakDateEx2(cur)
if w==5 then
t1=t1+(24-remove)*3600
else
t1=t1+86400
end
end
local lerp=t1-cur
return lerp
end
