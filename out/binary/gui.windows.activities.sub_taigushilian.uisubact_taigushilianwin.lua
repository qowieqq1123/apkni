







def_class("UISubAct_taigushilianWin",UIWindowBase)









function UISubAct_taigushilianWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.sloganImg1=UIImage.get(self,1)
self.bossname=UIText.get(self,2)
self.packScrollerView=UIObject.get(self,3)
self.leftBtn=UIButton.get(self,4)
self.rightBtn=UIButton.get(self,5)
self.pointScrollerView=UIObject.get(self,6)
self.pointContent=UIObject.get(self,7)
self.leftReddot=UIObject.get(self,8)
self.rightReddot=UIObject.get(self,9)
self.left=UIObject.get(self,10)
self.right=UIObject.get(self,11)
self.pointProgressBar=UIObject.get(self,12)
self.pointProgressValue=UIObject.get(self,13)
self.timeimg=UIObject.get(self,14)
self.bosstime=UIText.get(self,15)
self.time=UIText.get(self,16)
self.taskScroller=UIObject.get(self,17)
self.ranktag=UIObject.get(self,18)
self.myrank=UIText.get(self,19)
self.mydamage=UIText.get(self,20)
self.damageicon=UIImage.get(self,21)
self.bxbtn=UIButton.get(self,22)
self.bxreddot=UIObject.get(self,23)
self.bximg=UIImage.get(self,24)
self.zybtn=UIButton.get(self,25)
self.rulebtn=UIButton.get(self,26)
self.tiaozhanbtn=UIButton.get(self,27)
self.bossjijietxt=UIText.get(self,28)
self.progressbar=UIProgress.get(self,39)
self.itemone=UIObject.get(self,40)
self.itemtwo=UIObject.get(self,41)
self.ajlpanel=UIObject.get(self,42)
self.bjlpanel=UIObject.get(self,43)
self.cjlpanel=UIObject.get(self,44)
self.ajltxt=UIText.get(self,45)
self.bjltxt=UIText.get(self,46)
self.bxtxt=UIText.get(self,47)
self.bxtxt2=UIText.get(self,48)
self.bxtxt3=UIText.get(self,49)
self.jlimg=UIImage.get(self,50)
self.jlimg2=UIImage.get(self,51)
self.rankbtn=UIButton.get(self,52)
self.spinebg=UIObject.get(self,53)
self.jieusantips=UIText.get(self,54)
self.damageiconbg=UIButton.get(self,55)
self.timebgs=UIObject.get(self,56)
self.fbreddot=UIObject.get(self,57)
self.pjbtn=UIButton.get(self,58)
self.bjbtnreddot=UIObject.get(self,59)
self.bjbtnimg=UIObject.get(self,60)
self.cuitibtn=UIButton.get(self,61)
self.lgbtn=UIButton.get(self,62)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UISubAct_taigushilianWin")end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.bxbtn:setButtonClick(function()self:onBxbtn()end)

self.zybtn:setButtonClick(function()self:onZybtn()end)

self.rulebtn:setButtonClick(function()self:onRulebtn()end)

self.tiaozhanbtn:setButtonClick(function()self:onTiaozhanbtn()end)

self.rankbtn:setButtonClick(function()self:onRankbtn()end)

self.damageiconbg:setButtonClick(function()self:onDamageiconbg()end)

self.pjbtn:setButtonClick(function()self:onPjbtn()end)

self.cuitibtn:setButtonClick(function()self:onCuitibtn()end)

self.lgbtn:setButtonClick(function()self:onLgbtn()end)



end


function UISubAct_taigushilianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.sloganImg1);self.sloganImg1=nil;
_UIObject_release(self.bossname);self.bossname=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.pointScrollerView);self.pointScrollerView=nil;
_UIObject_release(self.pointContent);self.pointContent=nil;
_UIObject_release(self.leftReddot);self.leftReddot=nil;
_UIObject_release(self.rightReddot);self.rightReddot=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.pointProgressBar);self.pointProgressBar=nil;
_UIObject_release(self.pointProgressValue);self.pointProgressValue=nil;
_UIObject_release(self.timeimg);self.timeimg=nil;
_UIObject_release(self.bosstime);self.bosstime=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.ranktag);self.ranktag=nil;
_UIObject_release(self.myrank);self.myrank=nil;
_UIObject_release(self.mydamage);self.mydamage=nil;
_UIObject_release(self.damageicon);self.damageicon=nil;
_UIObject_release(self.bxbtn);self.bxbtn=nil;
_UIObject_release(self.bxreddot);self.bxreddot=nil;
_UIObject_release(self.bximg);self.bximg=nil;
_UIObject_release(self.zybtn);self.zybtn=nil;
_UIObject_release(self.rulebtn);self.rulebtn=nil;
_UIObject_release(self.tiaozhanbtn);self.tiaozhanbtn=nil;
_UIObject_release(self.bossjijietxt);self.bossjijietxt=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.itemone);self.itemone=nil;
_UIObject_release(self.itemtwo);self.itemtwo=nil;
_UIObject_release(self.ajlpanel);self.ajlpanel=nil;
_UIObject_release(self.bjlpanel);self.bjlpanel=nil;
_UIObject_release(self.cjlpanel);self.cjlpanel=nil;
_UIObject_release(self.ajltxt);self.ajltxt=nil;
_UIObject_release(self.bjltxt);self.bjltxt=nil;
_UIObject_release(self.bxtxt);self.bxtxt=nil;
_UIObject_release(self.bxtxt2);self.bxtxt2=nil;
_UIObject_release(self.bxtxt3);self.bxtxt3=nil;
_UIObject_release(self.jlimg);self.jlimg=nil;
_UIObject_release(self.jlimg2);self.jlimg2=nil;
_UIObject_release(self.rankbtn);self.rankbtn=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.jieusantips);self.jieusantips=nil;
_UIObject_release(self.damageiconbg);self.damageiconbg=nil;
_UIObject_release(self.timebgs);self.timebgs=nil;
_UIObject_release(self.fbreddot);self.fbreddot=nil;
_UIObject_release(self.pjbtn);self.pjbtn=nil;
_UIObject_release(self.bjbtnreddot);self.bjbtnreddot=nil;
_UIObject_release(self.bjbtnimg);self.bjbtnimg=nil;
_UIObject_release(self.cuitibtn);self.cuitibtn=nil;
_UIObject_release(self.lgbtn);self.lgbtn=nil;
end

















local _this
local boss_index=
{
root=0,
npcmodel=1,
rootimg=2,
}
local rankindex=
{
paiming=10,
paimingimg=11,
name=12,
shanghai=13,
sp_txt=14,
sp_icon=15,
paimingitxt=16,
}
local rankstate=
{
unopen=0,
open=1,
finish=2,
}
local abname='ui/windows/activities/sub_taigushilian/taigushilian_atlas_pak.ab'
local arrynum=
{
[1]='一',
[2]='二',
[3]='三',
[4]='四',
[5]='五',
}
local rankts=
{
[1]='伤害达评级',
[2]='伤害达评级',
[3]='伤害达评级',
}
local tefighttype=8




function UISubAct_taigushilianWin:onLoaded(...)
_this=self
self:bindComponents()

self.pageCount=0
self.pageLength=1
self.pageIndex=0
self.isDrag=false
self.targetHor=0
self.smooting=10
self.shoulingIdx=1
self.lastslIdx=1

self.pointTargetHor=0
self.pointSmooting=6
self.isAutoMovePoint=false
self.startAutoMoveDV=0.001

self.isFastJump=false
self.itemsarry={self.itemone,self.itemtwo}

self.winlua:SetChildUIDragEvent(self.packScrollerView:getID(),0,self.beginDragCallback,self.endDragCallback,nil)

self.updateTimer=self:setTimer(0.02,0,self.onScrollChanged)
end


function UISubAct_taigushilianWin:__delete()
self:endAllReddotPunchRotation()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
end
if _this.refreshTimeId then
_this:stopTimerByID(_this.refreshTimeId)
_this.refreshTimeId=nil
end
if _this.refreshTimeId2 then
_this:stopTimerByID(_this.refreshTimeId2)
_this.refreshTimeId2=nil
end
self.isopentiaozhan=false
self.isopenzenyi=false
self.isopenjianli=false
self:unbindComponents()
local win=UIManager:findActiveWindow('UISubAct_tgslRankWin')
if win then
UIManager:closeWindow("UISubAct_tgslRankWin")
end
_this=nil
end




function UISubAct_taigushilianWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eTaiGuShiLian
self.subid=argtable.sub_act_id
if argtable.extraParams then
self.jumpbossid=argtable.extraParams.jumpbossid
self.isopentiaozhan=argtable.extraParams.isopentiaozhan
self.isopenzenyi=argtable.extraParams.isopenzenyi
self.isopenjianli=argtable.extraParams.isopenjianli
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.startday=self.info.start_day_idx
self.start_time=self.info.start_time
self.end_time=self.info.end_time


self.isShowMoney=self.config.isShowMoney
self.fmTweenerList={}
self.taskScroller:setActive(true)

if self.info then
local leftTime=self.info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("活动剩余时间：{0}",UISubAct_taigushilianWin.format_time_stamp2(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("活动剩余时间：{0}",UISubAct_taigushilianWin.format_time_stamp2(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end

end)
else
self.time:setText("活动已结束")
self.isOver=true
end

self.cfg_all=cfg_taigushilianconfig_get(self.subid)
self.spinebg:setChildUIModelShowTarget(4937,1,nil,eAnimationID.stand)
_this.ranktag:setActive(false)
self:initandJumpShow(self.jumpbossid)


local list=activitiesHandle_taiguBoss:checkbossOpen(_this.actid,_this.subType,_this.subid)
self.lastbossid=#list or 5
self.nowbossID=1
self.endbossID=0
for k,v in ipairs(list)do
if v==rankstate.open then
self.nowbossID=k
end
if v==rankstate.finish then
self.endbossID=k
end
end



if self.isopentiaozhan then
self:onTiaozhanbtn()
end

if self.isopenzenyi then
self:onZybtn()
end

if self.isopenlc then
self:onLgbtn()
end

if self.isopenjianli then
self:onDamageiconbg()
end

self:checkzengyi()


local flag=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsljiesuan',_this.actid,_this.subid,_this.start_time),false)
if flag then

if flag~=_this.endbossID then
self:JieSuanWinOpen(_this.endbossID)
end
end

local flag2=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgslopen',_this.actid,_this.subid,_this.start_time),false)
if flag2 then

if flag2~=_this.nowbossID then
flag2=_this.nowbossID
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgslopen',_this.actid,_this.subid,_this.start_time),flag2)
end
end

local flag3=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldaojishi',_this.actid,_this.subid,_this.start_time),false)
if flag3 then

if flag3>0 and flag3==_this.nowbossID then
flag3=-flag3
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldaojishi',_this.actid,_this.subid,_this.start_time),flag3)
end
end

local flag4=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldjtwo',_this.actid,_this.subid,_this.start_time),false)

if flag4~=0 then
if flag4==_this.nowbossID then
notifySystem:postNotify(notifyConfig.onSubActivityFlagChange,self.actid,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.subid)
else
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldjtwo',_this.actid,_this.subid,_this.start_time),0)
notifySystem:postNotify(notifyConfig.onSubActivityFlagChange,self.actid,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.subid)
end
if _this.nowbossID==1 and _this.endbossID==5 then
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldjtwo',_this.actid,_this.subid,_this.start_time),0)
notifySystem:postNotify(notifyConfig.onSubActivityFlagChange,self.actid,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.subid)
end
end


activitiesModel:callRefreshActEnter(self.actid,self.subType,self.subid,"onUIEnterBigActivityIconChange",self.actid)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)

self:refreshAllTime()
end

local _format=string.format
local _floor=math.floor
function UISubAct_taigushilianWin.format_time_stamp2(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>0 then
return _format('%s天%s时%s分',DD,HH,mm)
else
if HH>0 then
return _format('%s时%s分',HH,mm)
else
if mm>0 then
return _format('%s分%s秒',mm,SS)
else
return _format('%s秒',SS)
end
end
end
end
function UISubAct_taigushilianWin.format_time_stampbyboss(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>0 then
return _format('%s天',DD)
else
if HH>0 then
return _format('%s小时',HH)
else
if mm>0 then
return _format('%s分',mm)
else
return _format('%s秒',SS)
end
end
end
end


function UISubAct_taigushilianWin:onHide()
self.taskScroller:setActive(false)
self.isopentiaozhan=false
self.isopenzenyi=false
self.isopenjianli=false
self:endAllReddotPunchRotation()
end


function UISubAct_taigushilianWin:ComebackXiangqing()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_tgslEnterWin',{_this.actid,_this.subType,_this.subid,bossid})
end


function UISubAct_taigushilianWin:refreshAllTime()
if _this.refreshTimeId2 then
_this:stopTimerByID(_this.refreshTimeId2)
_this.refreshTimeId2=nil
end
_this.refreshTimeFunc2=function()
local cfg_bossData=cfg_taigushilianconfig_get(_this.subid).boss
local boss_config_single=cfg_bossData[_this.nowbossID]
local nowstamp=timeHelper.getServerShortTime()

local bossend=boss_config_single[3]+_this.start_time


if _this.endbossID==#cfg_bossData then
_this.timebgs:setActive(true)
end


if nowstamp>=bossend then

local list=activitiesHandle_taiguBoss:checkbossOpen(_this.actid,_this.subType,_this.subid)
for k,v in ipairs(list)do
if v==1 then
_this.nowbossID=k
end
if v==2 then
_this.endbossID=k
end
end

UISubAct_taigushilianWin:JieSuanWinOpen(_this.endbossID)


if _this.endbossID==#cfg_bossData then
UISubAct_taigushilianWin:JieSuanWinOpen(_this.endbossID)
if _this.refreshTimeId2 then
_this:stopTimerByID(_this.refreshTimeId2)
_this.refreshTimeId2=nil
end
return
end

UISubAct_taigushilianWin:initandJumpShow(_this.nowbossID)
end
end
_this.refreshTimeFunc2()
_this.refreshTimeId2=_this:setTimer(1,0,_this.refreshTimeFunc2)
end


function UISubAct_taigushilianWin:JieSuanWinOpen(bossid)
local flag=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsljiesuan',_this.actid,_this.subid,_this.start_time),false)
if flag then

if flag~=bossid then
local flag=bossid
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgsljiesuan',_this.actid,_this.subid,_this.start_time),flag)

local json_str=jsonHelper.encode({1,bossid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,json_str)

_this:delayDo(1,function()
if _this==nil then return end
UIManager:showWindow('UISubAct_tgslResultWin',{_this.actid,_this.subType,_this.subid,bossid})
end)
end
end
end


function UISubAct_taigushilianWin:initandJumpShow(jumpbossid)
UISubAct_taigushilianWin:refreshScrollerView()
local bossid=jumpbossid
if bossid then
if not _this.showList[bossid]then
bossid=#_this.showList
end
else
bossid=#_this.showList
end
_this.pageIndex=bossid-1
_this.targetHor=_this.pageLength*_this.pageIndex
_this.shoulingIdx=bossid
_this.lastslIdx=_this.shoulingIdx
_this.packScrollerView:setChildScrollViewSelectItem(_this.pageIndex,false,false,false)
local grids=_this.packScrollerView:getChildScrollViewItemWidgets()
local item=grids[_this.shoulingIdx-1]
item:SetChildCanvasGroupAlpha(boss_index.rootimg,1)
_this:refreshBossName()
_this:refreshResidueTime()
local json_str=jsonHelper.encode({1,bossid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,json_str)
_this:refreshBossDamage(_this.actid,_this.subType,_this.subid)

_this:checkArrowBtn()
_this:refreshReddot()
end


function UISubAct_taigushilianWin:refreshReddot()
local flag=activitiesHandle_taiguBoss:checkreddotBossAll(_this.actid,_this.subType,_this.subid)
_this.bxreddot:setActive(flag)
end


function UISubAct_taigushilianWin:getbosslist(bossid)
local bossState=activitiesHandle_taiguBoss:checkbossOpen(_this.actid,_this.subType,_this.subid)
return bossState[bossid]
end


function UISubAct_taigushilianWin:GetShouLingList()
local boss_config=_this.config.boss
local list={}
local statelist=activitiesHandle_taiguBoss:checkbossOpen(_this.actid,_this.subType,_this.subid)

for k,v in ipairs(boss_config)do
if statelist[k]==rankstate.finish or statelist[k]==rankstate.open then
table.insert(list,v)
end
end
return list
end


function UISubAct_taigushilianWin:refreshScrollerView()
_this.showList=UISubAct_taigushilianWin:GetShouLingList()
_this.pageCount=#_this.showList

_this.pageLength=1/((_this.pageCount-1)==1 and 1 or(_this.pageCount-1))
_this.packScrollerView:setChildScrollViewCreateGrids(_this.pageCount,_this.pageCount)
local grids=_this.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local boss_config_single=_this.showList[i]
if boss_config_single then
local mosterid=boss_config_single[1][1][1][1]
local modelParams=comHelper.getMonsterGroupModelParams(mosterid)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,13)
item:SetChildUIModelShowTarget(boss_index.npcmodel,modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
item:SetChildUIModelShowTargetOffset(boss_index.npcmodel,scaleParam[2],scaleParam[3])
item:SetChildCanvasGroupAlpha(boss_index.rootimg,0.5)
end
end
end
end


function UISubAct_taigushilianWin:initFirstShowPage()
local firstShowIndex=1
local firstCanGetIndex=nil

firstCanGetIndex=1
firstShowIndex=firstCanGetIndex and firstCanGetIndex or 1
self.pageIndex=firstShowIndex-1
self.targetHor=self.pageLength*self.pageIndex
self.shoulingIdx=firstCanGetIndex
self.packScrollerView:setChildScrollViewSelectItem(self.pageIndex,false,false,false)

self:refreshBossName()
self:refreshResidueTime()
self:refreshRank(_this.actid,_this.subType,_this.subid)
end


function UISubAct_taigushilianWin:refreshBossName()
local guankaIdx=1

local len=activitiesHandle_taiguBoss:getBossTongGuangIdx(_this.actid,_this.subType,_this.subid,_this.shoulingIdx)
if len>0 then
local damagevalue=activitiesHandle_taiguBoss:getBossJieDuanDamageValue(_this.actid,_this.subType,_this.subid,_this.shoulingIdx,len)
if damagevalue<0 then
guankaIdx=len+1
else
guankaIdx=len
end
end

local boss_config_single=_this.showList[_this.shoulingIdx]

local mostergroupid=boss_config_single[1][guankaIdx][1][1]
local bossmonlv=boss_config_single[1][guankaIdx][2]
local mosterGroupcfg=cfgHelper.get(cfg_monstergroup_get,mostergroupid)
local mosterId=mosterGroupcfg.monList[4]
local mcfg=cfgHelper.get1(cfg_monsterconfig_get,mosterId)
_this.bossname:setText(mcfg.name)

local level=mcfg.level
local severmonlv=activitiesHandle_taiguBoss:getMonlv(_this.actid,_this.subType,_this.subid)
if severmonlv and severmonlv>0 and bossmonlv then
level=severmonlv+bossmonlv
end

local n,p,pN=UIDiscipleModel:getJJNameX(level)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('境界：{0}{1}',n,pN)
else
jj_str=FMT.fmt('境界：{0}',n)
end
_this.bossjijietxt:setText(jj_str)

local red=activitiesHandle_taiguBoss:checkIsNewBoss(_this.actid,_this.subType,_this.subid,_this.shoulingIdx)
self.fbreddot:setActive(red)
self:checkzengyi()
self:isShowPingjibtn()
end


function UISubAct_taigushilianWin:refreshResidueTime()
if _this.refreshTimeId then
_this:stopTimerByID(_this.refreshTimeId)
_this.refreshTimeId=nil
end
_this.refreshTimeFunc=function()
_this.jieusantips:setActive(false)
local boss_config_single=_this.showList[_this.shoulingIdx]
local nowstamp=timeHelper.getServerShortTime()
local bossstart=boss_config_single[2]+_this.start_time
local bossend=boss_config_single[3]+_this.start_time
if nowstamp>=bossend then
_this.bosstime:setText('已结算')
_this.ranktag:setActive(true)
_this.jieusantips:setActive(true)

if _this.refreshTimeId then
_this:stopTimerByID(_this.refreshTimeId)
_this.refreshTimeId=nil
end
end
if nowstamp>=bossstart and nowstamp<bossend then
local str=FMT.fmt("{0}后结算",UISubAct_taigushilianWin.format_time_stampbyboss((bossend-nowstamp)))
_this.bosstime:setText(str)
end
end
_this.refreshTimeFunc()
_this.refreshTimeId=_this:setTimer(1,0,_this.refreshTimeFunc)
end


function UISubAct_taigushilianWin:refreshBossRank(actID,subType,subid,bossid)

if bossid==_this.shoulingIdx and _this.actid==actID and _this.subType==subType and _this.subid==subid then
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local rankList=mydata.Ranklist
local dataNum=10
if dataNum<=0 then
_this.taskScroller:setActive(false)
else
_this.taskScroller:setActive(true)
_this.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count


for i=1,count do
local item=grids[i-1]
if item then
if rankList[i]then
local zwflag=rankList[i].flag
if not zwflag then
item:SetChildActive(rankindex.sp_txt,false)
item:SetChildText(rankindex.sp_txt,"")
local name=rankList[i].actorname
local shanghai=rankList[i].totaldamage
item:SetChildText(rankindex.name,name)
local rank=i
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(rankindex.paimingimg,showRankIcon)
item:SetChildActive(rankindex.paiming,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(rankindex.paimingimg,globalABLookup.rankList,rankIcon)
rank_str=FMT.fmt('<color=#161412>{0}</color>',tostring(rank))
item:SetChildText(rankindex.paimingitxt,rank_str)
else
item:SetChildText(rankindex.paiming,rank_str)
end
local num=0
if shanghai and type(shanghai)~="number"then
num=mathHelper.int64_to_number(shanghai)
end
num=mathHelper.formatNumber(num)
item:SetChildText(rankindex.shanghai,tostring(num))
else
local rank=i
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(rankindex.paimingimg,showRankIcon)
item:SetChildActive(rankindex.paiming,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(rankindex.paimingimg,globalABLookup.rankList,rankIcon)
rank_str=FMT.fmt('<color=#161412>{0}</color>',tostring(rank))
item:SetChildText(rankindex.paimingitxt,rank_str)
else
item:SetChildText(rankindex.paiming,rank_str)
end
local zwidx=rankList[i].idx
if rankts[zwidx]then

item:SetChildText(rankindex.paiming,"")
item:SetChildText(rankindex.name,"")
item:SetChildText(rankindex.shanghai,"")
item:SetChildActive(rankindex.sp_txt,true)
item:SetChildText(rankindex.sp_txt,rankts[zwidx])


local normalidx=0
local iconidx=0









local monlv=mydata.monlv
local damagelevel=cfg_taigushilianconfig_get(subid).damagelevel
local tempArry={}
for k,v in ipairs(damagelevel)do
if monlv<=v[1]then
tempArry=v[2]
end
end
if#tempArry>0 then
for k,v in ipairs(tempArry[bossid])do
if zwflag>=v[1]then
normalidx=k
iconidx=v[2]
end
end
end

item:SetChildActive(rankindex.sp_icon,normalidx>0)
if normalidx>0 then
local strsp=FMT.fmt('image_shilianzhandou_dj{0}',iconidx)
item:SetChildCSImageSprite(rankindex.sp_icon,abname,strsp)
end
end
end
else

local name="虚位以待"

item:SetChildText(rankindex.name,name)
local rank=i
if rank==1 or rank==2 or rank==3 then
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(rankindex.paimingimg,showRankIcon)
item:SetChildActive(rankindex.paiming,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(rankindex.paimingimg,globalABLookup.rankList,rankIcon)
rank_str=FMT.fmt('<color=#161412>{0}</color>',tostring(rank))
item:SetChildText(rankindex.paimingitxt,rank_str)
else
item:SetChildText(rankindex.paiming,rank_str)
end

else
item:SetChildActive(rankindex.paimingimg,false)
item:SetChildActive(rankindex.paiming,true)
item:SetChildText(rankindex.paiming,rank)
end
item:SetChildText(rankindex.shanghai,"")
end
end
end
end


local myrank
for k,v in ipairs(rankList)do
if v and v.actorid and playerModel:checkActorId(v.actorid)then

myrank=k
break
end
end
if myrank then
local ranktxt=FMT.fmt('我的排名：<color=#f1ce78>{0}</color>',myrank)
_this.myrank:setText(ranktxt)
else
_this.myrank:setText('我的排名：<color=#f1ce78>未上榜</color>')
end

local all_damage=activitiesHandle_taiguBoss:getDamageRole(actID,subType,subid,bossid)
local all_damage_str=FMT.fmt('我的伤害：<color=#f1ce78>{0}</color>',mathHelper.formatNumber(all_damage))
_this.mydamage:setText(all_damage_str or'')
end
end


function UISubAct_taigushilianWin:refreshBossDamage(actID,subType,subid)
if _this.actid==actID and _this.subType==subType and _this.subid==subid then
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]


local all_damage=activitiesHandle_taiguBoss:getDamageRole(actID,subType,subid,bossid)
local all_damage_str=FMT.fmt('我的伤害：<color=#f1ce78>{0}</color>',mathHelper.formatNumber(all_damage))
_this.mydamage:setText(all_damage_str or'')

local idx=activitiesHandle_taiguBoss:getBossJieDuanDamegeIdx(actID,subType,subid,bossid)
local damagelist=activitiesHandle_taiguBoss:getBossJieDuanDamegelist(actID,subType,subid,bossid)
local tgIdx=activitiesHandle_taiguBoss:getBossTongGuangIdx(actID,subType,subid,bossid)
if tgIdx>0 then
local damagevalue=activitiesHandle_taiguBoss:getBossJieDuanDamageValue(actID,subType,subid,bossid,tgIdx)
if damagevalue>=0 then
tgIdx=tgIdx-1
end
end
local isJieShuan=UISubAct_taigushilianWin:getbosslist(bossid)

local normalidx,iconidx=activitiesHandle_taiguBoss:getBossNormalIdx(actID,subType,subid,bossid)
local initimg=cfg_taigushilianconfig_get(subid).initImg
local initiconidx=initimg[bossid]
if normalidx>0 then
_this.damageiconbg:setActive(true)
local iconName=FMT.fmt('image_shilianzhandou_dj{0}',iconidx)
_this.winlua:SetChildCSImageSprite(_this.damageicon:getID(),abname,iconName)
else
if initiconidx and all_damage>0 then
_this.damageiconbg:setActive(true)
local iconName2=FMT.fmt('image_shilianzhandou_dj{0}',initiconidx)
_this.winlua:SetChildCSImageSprite(_this.damageicon:getID(),abname,iconName2)
else
_this.damageiconbg:setActive(false)
end
end


_this.ajlpanel:setActive(false)
_this.bjlpanel:setActive(false)
_this.cjlpanel:setActive(false)
if tgIdx<3 then

_this.ajlpanel:setActive(false)
_this.bjlpanel:setActive(true)
_this.cjlpanel:setActive(false)

local str=FMT.fmt('通关{0}阶难度可获得',arrynum[tgIdx+1])
_this.bjltxt:setText(str)
local mostergroupid=boss_config_single[1][tgIdx+1][1][1]
local mosterlevel=boss_config_single[1][tgIdx+1][2]

local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,mostergroupid)
local rewards={}
if monsterCfg.drops and monsterCfg.drops[1]then
rewards=worldFightModel:getMonsterShowAwardsEx2({monsterCfg.drops[1]},mosterlevel)

end

for i=1,2 do
local item=_this.itemsarry[i]:getChildWidgetBase()
local data=rewards[i]
if data then
item:SetChildActive(-1,true)
local showCountBG=data[2]>1
local countStr=data[2]>1 and data[2]or""
local conf={itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=false,showStage=true,range=data.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
else
item:SetChildActive(-1,false)
end
end
else
if isJieShuan~=rankstate.finish then

local rankdata=boss_config_single[6][1]
local reward=rankdata[2]
_this.ajlpanel:setActive(true)
_this.bjlpanel:setActive(false)
_this.cjlpanel:setActive(false)
for i=1,2 do
local item=_this.itemsarry[i]:getChildWidgetBase()
local data=reward[i]
if data then
item:SetChildActive(-1,true)
local showCountBG=data[2]>1
local countStr=data[2]>1 and data[2]or""
local conf={itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=true,showStage=true,range=data.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
else
item:SetChildActive(-1,false)
end
end
else

local severBosslist=mydata.severBosslist
local recvaimid=0
if severBosslist and severBosslist[bossid]then
recvaimid=severBosslist[bossid].recvaimid or 0
end
local maxidx=#damagelist
if idx==maxidx and maxidx==recvaimid then


_this.bjlpanel:setActive(false)

_this.ajlpanel:setActive(true)
_this.cjlpanel:setActive(false)
local rankdata=boss_config_single[6][1]
local reward=rankdata[2]
for i=1,2 do
local item=_this.itemsarry[i]:getChildWidgetBase()
local data=reward[i]
if data then
item:SetChildActive(-1,true)
local showCountBG=data[2]>1
local countStr=data[2]>1 and data[2]or""
local conf={itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=true,showStage=true,range=data.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
else
item:SetChildActive(-1,false)
end
end
end
if idx<maxidx and idx==recvaimid then

_this.ajlpanel:setActive(false)
_this.bjlpanel:setActive(false)
_this.cjlpanel:setActive(true)

local nextdamage=damagelist[idx+1][1]
local chae=nextdamage-all_damage
local num=mathHelper.formatNumber(chae)
local str=FMT.fmt('伤害值再增加：{0}',num)
_this.bxtxt:setActive(true)
_this.bxtxt:setText(str)
_this.bxtxt2:setActive(true)
_this.bxtxt3:setActive(false)
local iconName=FMT.fmt('image_shilianzhandou_dj{0}',damagelist[idx+1][3])
_this.winlua:SetChildCSImageSprite(_this.jlimg:getID(),abname,iconName)


_this.winlua:SetChildProgressValue(_this.progressbar:getID(),all_damage,nextdamage)
_this.winlua:SetChildProgressText(_this.progressbar:getID(),FMT.fmt('{0}/{1}',mathHelper.formatNumber(all_damage),mathHelper.formatNumber(nextdamage)))

local reward=damagelist[idx+1][2]
for i=1,2 do
local item=_this.itemsarry[i]:getChildWidgetBase()
local data=reward[i]
if data then
item:SetChildActive(-1,true)
local showCountBG=data[2]>1
local countStr=data[2]>1 and data[2]or""
local conf={itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=false,range=data.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
else
item:SetChildActive(-1,false)
end
end
end
if idx>recvaimid then

local thisdamage=damagelist[idx][1]
_this.bxtxt3:setActive(true)
_this.bxtxt2:setActive(false)
local iconName=FMT.fmt('image_shilianzhandou_dj{0}',damagelist[idx][3])
_this.winlua:SetChildCSImageSprite(_this.jlimg2:getID(),abname,iconName)

_this.winlua:SetChildProgressValue(_this.progressbar:getID(),thisdamage,thisdamage)
_this.winlua:SetChildProgressText(_this.progressbar:getID(),FMT.fmt('{0}/{1}',mathHelper.formatNumber(thisdamage),mathHelper.formatNumber(thisdamage)))
_this.ajlpanel:setActive(false)
_this.bjlpanel:setActive(false)
_this.cjlpanel:setActive(true)
local reward=damagelist[idx][2]
for i=1,2 do
local item=_this.itemsarry[i]:getChildWidgetBase()
local data=reward[i]
if data then
item:SetChildActive(-1,true)
local showCountBG=data[2]>1
local countStr=data[2]>1 and data[2]or""
local conf={itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=false,range=data.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
else
item:SetChildActive(-1,false)
end
end
end
end
end
end
end


function UISubAct_taigushilianWin:checkArrowBtn()

self.left:setActive(self.pageIndex>0)

self.right:setActive(self.pageIndex<self.pageCount-1)
local nowIndex=self.pageIndex+1
local leftIsReddot=false
local rightIsReddot=false

for i=1,nowIndex-1 do
if _this.showList[i]then


local reddot2=activitiesHandle_taiguBoss:checkIsLastDayBossSingle(_this.actid,_this.subType,_this.subid,i)

if reddot2 then
leftIsReddot=true
break
end
end
end

for i=nowIndex+1,self.pageCount do
if _this.showList[i]then
local reddot2=activitiesHandle_taiguBoss:checkIsLastDayBossSingle(_this.actid,_this.subType,_this.subid,i)
if reddot2 then
rightIsReddot=true
break
end
end
end
self.leftReddot:setActive(leftIsReddot)
self.rightReddot:setActive(rightIsReddot)
self.leftReddotIndex=self:doPunchRotation(self.widget,self.leftReddot:getID(),self.leftReddotIndex,leftIsReddot)
self.rightReddotIndex=self:doPunchRotation(self.widget,self.rightReddot:getID(),self.rightReddotIndex,rightIsReddot)
end


function UISubAct_taigushilianWin:onLeftBtn()
if self.pageIndex-1>=0 then
self.pageIndex=self.pageIndex-1
self.targetHor=self.pageLength*self.pageIndex
self.shoulingIdx=self.pageIndex+1
end
_this.ranktag:setActive(false)
_this.jieusantips:setActive(false)
self:checkArrowBtn()
self:refreshBossName()
self:refreshResidueTime()

self:refreshBossDamage(_this.actid,_this.subType,_this.subid)
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
local json_str=jsonHelper.encode({1,bossid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,json_str)
end


function UISubAct_taigushilianWin:onRightBtn()
if self.pageIndex+1<self.pageCount then
self.pageIndex=self.pageIndex+1
self.targetHor=self.pageLength*self.pageIndex
self.shoulingIdx=self.pageIndex+1
end
_this.ranktag:setActive(false)
_this.jieusantips:setActive(false)
self:checkArrowBtn()
self:refreshBossName()
self:refreshResidueTime()

self:refreshBossDamage(_this.actid,_this.subType,_this.subid)
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
local json_str=jsonHelper.encode({1,bossid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,json_str)
end


function UISubAct_taigushilianWin:setShowItemInfo(itemWidget,showItemConfig,zbgConfig)
local showItemType=showItemConfig[1]
local showItemPram=showItemConfig[2]
local name="未知名称"
local typeIconName=""
local desc=""
local effectDesc=""
local abName="ui/windows/recharge/zhenbaoge_atlas_pak.ab"

itemWidget:SetChildActive(cmp_index.icon,showItemType==showModelType.eGubao)
itemWidget:SetChildActive(cmp_index.buildingModel,showItemType==showModelType.eBuilding)
itemWidget:SetChildActive(cmp_index.playerImageChangeMask,showItemType==showModelType.ePlayerimagechange)
if showItemType==showModelType.eGubao then

local gubaoItemId=showItemPram
local gbId=gubaoLookup:good2GuBao(gubaoItemId)
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbId)


itemWidget:SetChildCSImageIcon(cmp_index.icon,gubaoModel:getGuBaoBigIconName(gbCfg.icon),false)


name=gbCfg.name
typeIconName="image_zbgjlbiaoji_1"


desc=gbCfg.story

local skilllv=1
effectDesc=gubaoModel:getSkillDesc(gbId,skilllv)

elseif showItemType==showModelType.eBuilding then

local bdId=showItemPram.bdid
local size=showItemPram.size or 1
local offset=showItemPram.offset or{0,0}
local animId=showItemPram.anim or eAnimationID.bd_stand
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
if bdcfg then



local model=bdcfg.model[1]
itemWidget:SetChildUIModelShowTarget(cmp_index.buildingModel,model,size,nil,animId)
itemWidget:SetChildUIModelShowTargetOffset(cmp_index.buildingModel,offset[1],offset[2])


name=bdcfg.name
typeIconName="image_zbgjlbiaoji_2"


desc=bdcfg.desc

local level=1
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdId,level)
local buff=levelCfg.effects
if buff then
for k,v in pairs(buff[1].param)do
local bcfg=cfgHelper.get1(cfg_monijybuildconfig_get,k)
effectDesc=FMT.fmt('{0}{1}产量+{2}% ',effectDesc,bcfg.name,v)
end
else

effectDesc=levelCfg.effects_desc
end
else
logErr(FMT.fmt("找不到建筑id:{0} 对应的建筑配置",bdId))
return
end
elseif showItemType==showModelType.ePlayerimagechange then
local sex=playerModel:getActorSex()
local modelParam=showItemConfig[3]and showItemConfig[3][sex]or{}
local playerImageList=playerImageController.getSuitImageList(showItemPram)

local offsetx=modelParam.offsetx or 0
local offsety=modelParam.offsety or 0
local scale=modelParam.scale or 1
local ani=eAnimationID.idle



local widget=itemWidget:GetChildWidgetBase(cmp_index.playerImageChangeModel)
comHelper.setChildPlayerImage(widget,-1,playerImageList,sex,scale,ani,offsetx,offsety,playerController:supportDynamic())

typeIconName="image_zbgjlbiaoji_3"
name=zbgConfig and zbgConfig.modelname or""
desc=zbgConfig and zbgConfig.desc or""
effectDesc=zbgConfig and zbgConfig.effectdesc or""
else
logErr(FMT.fmt("找不到展示类型: {0} 请检查配置是否正确",showItemType))
return
end


itemWidget:SetChildText(cmp_index.name,name)

itemWidget:SetChildCSImageSprite(cmp_index.rewardType,abName,typeIconName)

itemWidget:SetChildText(cmp_index.desc,desc)
itemWidget:SetChildText(cmp_index.effectDesc,effectDesc)
end

function UISubAct_taigushilianWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 or itemId==0 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,showModel=true,})
end

function UISubAct_taigushilianWin:onClickGetBtn(id)

end

function UISubAct_taigushilianWin:onClickPagePoint(index)
if self.pageIndex==index-1 then
return
end


self.pageIndex=index-1
self.targetHor=self.pageLength*self.pageIndex

self:checkArrowBtn()


end



function UISubAct_taigushilianWin:onTiaozhanbtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_tgslEnterWin',{_this.actid,_this.subType,_this.subid,bossid})
end


function UISubAct_taigushilianWin:onZybtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_tgslZenYiWin',{_this.actid,_this.subType,_this.subid,bossid,1})
end

function UISubAct_taigushilianWin:onLgbtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_tgslZenYiLCWin',{_this.actid,_this.subType,_this.subid,bossid,1})
end

function UISubAct_taigushilianWin:onCuitibtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_tgslZenYiLCWin',{_this.actid,_this.subType,_this.subid,bossid,1})
end


function UISubAct_taigushilianWin:onRankbtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_tgslRankWin',{_this.actid,_this.subType,_this.subid,1,bossid})
end


function UISubAct_taigushilianWin:onBxbtn()
local flag=activitiesHandle_taiguBoss:checkreddotBossAll(_this.actid,_this.subType,_this.subid)
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
if flag then
UIManager:showWindow('UISubAct_tgslRankWin',{_this.actid,_this.subType,_this.subid,2,bossid})
else
UIManager:showWindow('UISubAct_tgslRankWin',{_this.actid,_this.subType,_this.subid,1,bossid})
end
end


function UISubAct_taigushilianWin:onRulebtn()
local langId=cfgHelper.get(cfg_taigushilianconfig_get,_this.subid,"ruleLangId")or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
UIManager:showWindow('UIRuleWin',d)
end


function UISubAct_taigushilianWin:onDamageiconbg()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_tgslRankWin',{_this.actid,_this.subType,_this.subid,2,bossid})
end







function UISubAct_taigushilianWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UISubAct_taigushilianWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end


function UISubAct_taigushilianWin.beginDragCallback()
_this.isDrag=true
end

function UISubAct_taigushilianWin.endDragCallback()
_this.isDrag=false
local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true)
local index=0
local offset=Mathf.Abs(-posX)
for i=1,_this.pageCount do
local temp=Mathf.Abs(_this.pageLength*i-posX)
if(temp<offset)then
index=i
offset=temp
end
end
_this.pageIndex=index

_this.targetHor=_this.pageLength*_this.pageIndex
_this:checkArrowBtn()

if _this.shoulingIdx==_this.pageIndex+1 then
return
else
_this.lastslIdx=_this.pageIndex
_this.shoulingIdx=_this.pageIndex+1
if#_this.showList<_this.shoulingIdx then
_this.shoulingIdx=_this.pageIndex
_this.targetHor=_this.pageLength*(_this.pageIndex-1)
end
_this:refreshBossName()
_this:refreshResidueTime()
_this:refreshBossDamage(_this.actid,_this.subType,_this.subid)
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
local json_str=jsonHelper.encode({1,bossid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,json_str)
end
end

function UISubAct_taigushilianWin.onScrollChanged()

if not _this.isDrag then
local np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true)
_this.winlua:SetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true,Mathf.Lerp(np,_this.targetHor,Time.deltaTime*_this.smooting))
if _this.lastslIdx~=_this.shoulingIdx then
local grids=_this.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
if i==_this.shoulingIdx then
item:SetChildCanvasGroupDOFade(boss_index.rootimg,1,0.5,nil)
else
item:SetChildCanvasGroupAlpha(boss_index.rootimg,0.5)
end
end
end
_this.lastslIdx=_this.shoulingIdx
end
end
end

function UISubAct_taigushilianWin.pointBeginDragCallback()
_this.isAutoMovePoint=false
end



function UISubAct_taigushilianWin:isShowPingjibtn()
local reddot=activitiesHandle_taiguBoss:checkNowBossIsBattle(_this.actid,_this.subType,_this.subid,_this.shoulingIdx)
local flagreddot=activitiesHandle_taiguBoss:checkreddotBossAll(_this.actid,_this.subType,_this.subid)
local reddot2=activitiesHandle_taiguBoss:checkIsLastDayBossSingle(_this.actid,_this.subType,_this.subid,_this.shoulingIdx)
_this.bjbtnreddot:setActive(reddot2 or flagreddot)
_this.pjbtn:setActive(reddot)
_this.bxbtn:setActive(not reddot)


_this:refreshbjbtnimg(_this.actid,_this.subType,_this.subid)
end

function UISubAct_taigushilianWin:refreshbjbtnimg(actid,subType,subid)
local _isbjbtnimg=false
if not _this.showList then
return
end
for k,v in ipairs(_this.showList)do
local boss_config_single=_this.showList[k]
local bossid=boss_config_single[7]
local mydata=activitiesModel:getSubActInfoData(actid,subType,subid)
local severBosslist=mydata.severBosslist
local recvaimid=0
if severBosslist then
if severBosslist[bossid]then
if severBosslist[bossid].recvaimid then
recvaimid=severBosslist[bossid].recvaimid or 0
end
end
if recvaimid>=4 then
_isbjbtnimg=false
else
_isbjbtnimg=true
break
end
end
end
_this.bjbtnimg:setActive(_isbjbtnimg)

if _this.shoulingIdx then
local flagreddot=activitiesHandle_taiguBoss:checkreddotBossAll(actid,subType,subid)
local reddot2=activitiesHandle_taiguBoss:checkIsLastDayBossSingle(actid,subType,subid,_this.shoulingIdx)
_this.bjbtnreddot:setActive(reddot2 or flagreddot)
end
end


function UISubAct_taigushilianWin:onPjbtn()
local reddot2=activitiesHandle_taiguBoss:checkIsLastDayBossSingle(_this.actid,_this.subType,_this.subid,_this.shoulingIdx)
if reddot2 then
local info=activitiesModel:getSubActInfo(_this.actid,_this.subType,_this.subid)
local start_time=info.start_time
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgsllastday',_this.actid,_this.subid,start_time),true)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,_this.subType)
activitiesModel:callRefreshActEnter(_this.actid,_this.subType,_this.subid,"onUIEnterBigActivityIconChange",_this.actid)
self:checkArrowBtn()
end
self:isShowPingjibtn()
UIManager:showWindow('UISubAct_tgslRankWin',{_this.actid,_this.subType,_this.subid,2,_this.shoulingIdx})
end

function UISubAct_taigushilianWin:onClickItem(itemId,index,guid,attach)
if itemId>0 then
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
end



function UISubAct_taigushilianWin:checkzengyi()
local boss_config_single=_this.showList[_this.shoulingIdx]
local lhidx=boss_config_single[4]

if lhidx==0 then
_this.zybtn:setActive(false)
_this.cuitibtn:setActive(false)
_this.lgbtn:setActive(false)
_this.winlua:SetChildLocalPosY(_this.rulebtn:getID(),211)
else

local cfg_dizifaze=cfg_tsdzfzconfig_get(tefighttype)[lhidx]
if cfg_dizifaze.tm then
_this.zybtn:setActive(true)
_this.cuitibtn:setActive(false)
_this.lgbtn:setActive(false)
elseif cfg_dizifaze.lg then
_this.zybtn:setActive(false)
_this.cuitibtn:setActive(false)
_this.lgbtn:setActive(true)
elseif cfg_dizifaze.ct then
_this.zybtn:setActive(false)
_this.cuitibtn:setActive(true)
_this.lgbtn:setActive(false)
end
end
end
