







def_class("UISubAct_fuyaoshilianWin",UIWindowBase)









function UISubAct_fuyaoshilianWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.sloganImg1=UIObject.get(self,1)
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
self.fyiconpanel=UIObject.get(self,61)
self.fylines=UIObject.get(self,62)
self.jlimged=UIObject.get(self,63)
self.fylinesd=UIObject.get(self,65)
self.baoXiangReddot=UIObject.get(self,66)
self.jiejibtn=UIButton.get(self,67)
self.jlspinebg=UIObject.get(self,68)
self.tzspinebg=UIObject.get(self,69)
self.txspinebg=UIObject.get(self,70)
self.fylines2=UIObject.get(self,71)
self.fylines3=UIObject.get(self,72)
self.cuitibtn=UIButton.get(self,73)
self.lgbtn=UIButton.get(self,74)
self.slList=UIObject.get(self,75)
self.jjbg=UIObject.get(self,76)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UISubAct_fuyaoshilianWin")end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.bxbtn:setButtonClick(function()self:onBxbtn()end)

self.zybtn:setButtonClick(function()self:onZybtn()end)

self.rulebtn:setButtonClick(function()self:onRulebtn()end)

self.tiaozhanbtn:setButtonClick(function()self:onTiaozhanbtn()end)

self.rankbtn:setButtonClick(function()self:onRankbtn()end)

self.damageiconbg:setButtonClick(function()self:onDamageiconbg()end)

self.pjbtn:setButtonClick(function()self:onPjbtn()end)

self.jiejibtn:setButtonClick(function()self:onJiejibtn()end)

self.cuitibtn:setButtonClick(function()self:onCuitibtn()end)

self.lgbtn:setButtonClick(function()self:onLgbtn()end)



end


function UISubAct_fuyaoshilianWin:unbindComponents()
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
_UIObject_release(self.fyiconpanel);self.fyiconpanel=nil;
_UIObject_release(self.fylines);self.fylines=nil;
_UIObject_release(self.jlimged);self.jlimged=nil;
_UIObject_release(self.fylinesd);self.fylinesd=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
_UIObject_release(self.jiejibtn);self.jiejibtn=nil;
_UIObject_release(self.jlspinebg);self.jlspinebg=nil;
_UIObject_release(self.tzspinebg);self.tzspinebg=nil;
_UIObject_release(self.txspinebg);self.txspinebg=nil;
_UIObject_release(self.fylines2);self.fylines2=nil;
_UIObject_release(self.fylines3);self.fylines3=nil;
_UIObject_release(self.cuitibtn);self.cuitibtn=nil;
_UIObject_release(self.lgbtn);self.lgbtn=nil;
_UIObject_release(self.slList);self.slList=nil;
_UIObject_release(self.jjbg);self.jjbg=nil;
end















local _this
local boss_index=
{
root=0,
npcmodel=1,
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
local tefighttype=9
local _bossTips={
[monType.LittleMonster]=nil,
[monType.EliteMonster]="icon_guaiwubiaoqian_2",
[monType.Boss]="icon_guaiwubiaoqian_1",
[monType.BigBoss]="icon_guaiwubiaoqian_1",
[monType.GodAnimal]="icon_guaiwubiaoqian_1",
}
local _bossKuang={
[monType.LittleMonster]="frame_guaiwukuang_1",
[monType.EliteMonster]="frame_guaiwukuang_1",
[monType.Boss]="frame_guaiwukuang_2",
[monType.BigBoss]="frame_guaiwukuang_2",
[monType.GodAnimal]="frame_guaiwukuang_2",
}



function UISubAct_fuyaoshilianWin:onLoaded(...)
_this=self
self:bindComponents()
self.fylinesds={self.fylinesd,self.fylines,self.fylines2,self.fylines3}
self.topimg={0,1,2,3}
self.topimg2={4,5,6,7}
self.topimgtxt2={8,9,10,11}
self.pageCount=0
self.pageLength=1
self.pageIndex=0
self.isDrag=false
self.targetHor=0
self.smooting=10
self.shoulingIdx=1

self.pointTargetHor=0
self.pointSmooting=6
self.isAutoMovePoint=false
self.startAutoMoveDV=0.001

self.isFastJump=false
self.itemsarry={self.itemone,self.itemtwo}

self.winlua:SetChildUIDragEvent(self.packScrollerView:getID(),0,self.beginDragCallback,self.endDragCallback,nil)

self.updateTimer=self:setTimer(0.02,0,self.onScrollChanged)
end


function UISubAct_fuyaoshilianWin:__delete()
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
if _this.refreshTimeId3 then
_this:stopTimerByID(_this.refreshTimeId3)
_this.refreshTimeId3=nil
end
self.isopentiaozhan=false
self.isopenzenyi=false
self.isopenjianli=false
self:unbindComponents()
_this=nil
end

local _format=string.format
local _floor=math.floor
function UISubAct_fuyaoshilianWin.format_time_stamp2(inteval)
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
function UISubAct_fuyaoshilianWin.format_time_stampbyboss(inteval)
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


function UISubAct_fuyaoshilianWin:onHide()
self.taskScroller:setActive(false)
self.isopentiaozhan=false
self.isopenzenyi=false
self.isopenjianli=false
self:endAllReddotPunchRotation()
end




function UISubAct_fuyaoshilianWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eFuYaoShiLian
self.subid=argtable.sub_act_id
if argtable.extraParams then
self.jumpbossid=argtable.extraParams.jumpbossid
self.isopentiaozhan=argtable.extraParams.isopentiaozhan
self.isopenzenyi=argtable.extraParams.isopenzenyi
self.isopenjianli=argtable.extraParams.isopenjianli
self.isopenlc=argtable.extraParams.isopenlc
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.startday=self.info.start_day_idx
self.start_time=self.info.start_time
self.end_time=self.info.end_time

self.isShowMoney=self.config.isShowMoney
self.fmTweenerList={}
self.taskScroller:setActive(false)

if self.info then
local leftTime=self.info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("活动剩余时间：{0}",UISubAct_fuyaoshilianWin.format_time_stamp2(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("活动剩余时间：{0}",UISubAct_fuyaoshilianWin.format_time_stamp2(leftTime)))
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

self.cfg_all=cfg_fuyaoshilianconfig_get(self.subid)
self.spinebg:setChildUIModelShowTarget(4941,1,nil,eAnimationID.stand)
self.jlspinebg:setChildUIModelShowTarget(4943,1,nil,eAnimationID.stand)
_this.ranktag:setActive(false)


local list=activitiesHandle_fuyaoBoss:checkbossOpen(_this.actid,_this.subType,_this.subid)
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
self:initandJumpShow(self.jumpbossid)


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


local flag2=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_fyslopen',_this.actid,_this.subid,_this.start_time),false)
if flag2 then

if flag2~=_this.nowbossID then
flag2=_this.nowbossID
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_fyslopen',_this.actid,_this.subid,_this.start_time),flag2)
end
end


local flag4=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_fysldjtwo',_this.actid,_this.subid,_this.start_time),false)

if flag4~=0 then
if flag4==_this.nowbossID then

else
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_fysldjtwo',_this.actid,_this.subid,_this.start_time),0)

end
if _this.nowbossID==1 and _this.endbossID==5 then
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_fysldjtwo',_this.actid,_this.subid,_this.start_time),0)

end
end


activitiesModel:callRefreshActEnter(self.actid,self.subType,self.subid,"onUIEnterBigActivityIconChange",self.actid)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)

self:refreshAllTime()
self:freshTopScrollerView()
end


function UISubAct_fuyaoshilianWin:refreshAllTime()
if _this.refreshTimeId2 then
_this:stopTimerByID(_this.refreshTimeId2)
_this.refreshTimeId2=nil
end
_this.refreshTimeFunc2=function()
local cfg_bossData=cfg_fuyaoshilianconfig_get(_this.subid).boss
local boss_config_single=cfg_bossData[_this.nowbossID]
local nowstamp=timeHelper.getServerShortTime()

local bossend=boss_config_single[3]+_this.start_time
if _this.endbossID==#cfg_bossData then
_this.timebgs:setActive(true)
_this.timeimg:setActive(false)
end

if nowstamp>=bossend then

local list=activitiesHandle_fuyaoBoss:checkbossOpen(_this.actid,_this.subType,_this.subid)
for k,v in ipairs(list)do
if v==1 then
_this.nowbossID=k
end
if v==2 then
_this.endbossID=k
end
end

if _this.endbossID==#cfg_bossData then

if _this.refreshTimeId2 then
_this:stopTimerByID(_this.refreshTimeId2)
_this.refreshTimeId2=nil
end
return
end
self:initandJumpShow(_this.nowbossID)
end
end
_this.refreshTimeFunc2()
_this.refreshTimeId2=_this:setTimer(1,0,_this.refreshTimeFunc2)
end


function UISubAct_fuyaoshilianWin:initandJumpShow(jumpbossid)
self:refreshScrollerView()
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
_this.packScrollerView:setChildScrollViewSelectItem(_this.pageIndex,false,false,false)

_this:refreshBossName()
_this:refreshResidueTime()


_this:refreshBossDamage(_this.actid,_this.subType,_this.subid)

_this:checkArrowBtn()
_this:refreshReddot()
end


function UISubAct_fuyaoshilianWin:refreshScrollerView()
_this.showList=UISubAct_fuyaoshilianWin:GetShouLingList()
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
local mosterid=boss_config_single[1][1][1]
local modelParams=comHelper.getMonsterGroupModelParams(mosterid)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,17)
item:SetChildUIModelShowTarget(boss_index.npcmodel,modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
item:SetChildUIModelShowTargetOffset(boss_index.npcmodel,scaleParam[2],scaleParam[3])
end
end
end
end


function UISubAct_fuyaoshilianWin:freshTopScrollerView()
local cfg_List=_this.config.boss
local bosstopimage=_this.config.bosstopimage
if cfg_List and#cfg_List>0 then
_this.slList:setChildScrollViewCreateGrids(#cfg_List,#cfg_List)
self:refreshTopTime()
local grids=_this.slList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=cfg_List[i]







if bosstopimage[i]then
item:SetChildCSImageSprite(7,abname,bosstopimage[i])
else
item:SetChildCSImageSprite(7,abname,"icon_head_boss_410141")
end

local red=activitiesHandle_fuyaoBoss:checkIsNewBoss(_this.actid,_this.subType,_this.subid,i)
item:SetChildActive(4,red)

item:SetChildActive(8,_this.shoulingIdx==i)

item:SetChildButtonClick(6,function()
if _this==nil then return end
self:onTopBtn(i,data)
end)
end
end
end


function UISubAct_fuyaoshilianWin:freshTopSingleItem()
local grids=_this.slList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildActive(8,false)
item:SetChildActive(8,_this.shoulingIdx==i)
end
end


function UISubAct_fuyaoshilianWin:refreshTopTime()
local cfg_List=_this.config.boss
if _this.refreshTimeId3 then
_this:stopTimerByID(_this.refreshTimeId3)
_this.refreshTimeId3=nil
end
_this.refreshTimeFunc3=function()
for k,v in ipairs(cfg_List)do
local item=_this.slList:getChildScrollViewItemWidget(k-1)
local nowstamp=timeHelper.getServerShortTime()
local bossstart=v[2]+_this.start_time
if nowstamp>=bossstart then
item:SetChildText(3,"")
item:SetChildGray(1,false)
item:SetChildGray(7,false)
else
local str=timeHelper.format_time_stamp3((bossstart-nowstamp))
item:SetChildText(3,str)
item:SetChildGray(1,true)
item:SetChildGray(7,true)
end
end

local nowstamp=timeHelper.getServerShortTime()
local lastbossend=cfg_List[#cfg_List][3]+_this.start_time
if nowstamp>=lastbossend then
_this.timebgs:setActive(true)
_this.winlua:SetChildLocalPosY(_this.timebgs:getID(),240)
_this.winlua:SetChildLocalPosY(_this.jjbg:getID(),282)
if _this.refreshTimeId3 then
_this:stopTimerByID(_this.refreshTimeId3)
_this.refreshTimeId3=nil
end
end
end
_this.refreshTimeFunc3()
_this.refreshTimeId3=_this:setTimer(1,0,_this.refreshTimeFunc3)
end


function UISubAct_fuyaoshilianWin:GetShouLingList()
local boss_config=_this.config.boss
local list={}
local statelist=activitiesHandle_fuyaoBoss:checkbossOpen(_this.actid,_this.subType,_this.subid)
for k,v in ipairs(boss_config)do
if statelist[k]==rankstate.finish or statelist[k]==rankstate.open then
table.insert(list,v)
end
end
return list

end

function UISubAct_fuyaoshilianWin:refreshReddot()
local flag=activitiesHandle_fuyaoBoss:checkreddotBossAll(_this.actid,_this.subType,_this.subid)
_this.bxreddot:setActive(flag)
end


function UISubAct_fuyaoshilianWin:getbosslist(bossid)
local bossState=activitiesHandle_fuyaoBoss:checkbossOpen(_this.actid,_this.subType,_this.subid)
return bossState[bossid]
end


function UISubAct_fuyaoshilianWin:initFirstShowPage()
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


function UISubAct_fuyaoshilianWin:refreshBossName()
local guankaIdx=1

local len=activitiesHandle_fuyaoBoss:getBossTongGuangIdx(_this.actid,_this.subType,_this.subid,_this.shoulingIdx)
if len>0 then
local damagevalue=activitiesHandle_fuyaoBoss:getBossJieDuanDamageValue(_this.actid,_this.subType,_this.subid,_this.shoulingIdx,len)
if damagevalue<0 then
guankaIdx=len+1
else
guankaIdx=len
end
end
local boss_config_single=_this.showList[_this.shoulingIdx]

local mostergroupid=boss_config_single[1][guankaIdx][1]
local bossmonlv=boss_config_single[1][guankaIdx][2]
local mosterGroupcfg=cfgHelper.get(cfg_monstergroup_get,mostergroupid)
local mosterId=mosterGroupcfg.monList[4]
if mosterId==0 then
for k,v in ipairs(mosterGroupcfg.monList)do
if v~=0 then
mosterId=v
break
end
end
end
local mcfg=cfgHelper.get1(cfg_monsterconfig_get,mosterId)
_this.bossname:setText(mcfg.name)
local level=mcfg.level
local severmonlv=activitiesHandle_fuyaoBoss:getMonlv(_this.actid,_this.subType,_this.subid)
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

local red=activitiesHandle_fuyaoBoss:checkIsNewBoss(_this.actid,_this.subType,_this.subid,_this.shoulingIdx)
self:showtiaozhanReddot(red)
self:isShowPingjibtn()
self:checkzengyi()
self:freshTopSingleItem()
end


function UISubAct_fuyaoshilianWin:refreshResidueTime()


































end


function UISubAct_fuyaoshilianWin:refreshBossDamage(actID,subType,subid)
if _this.actid==actID and _this.subType==subType and _this.subid==subid then
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]


local all_damage=activitiesHandle_fuyaoBoss:getDamageRole(actID,subType,subid,bossid)
local all_damage_str=FMT.fmt('总伤害:{0}',mathHelper.formatNumber(all_damage))
_this.mydamage:setText(all_damage_str or'')

local idx=activitiesHandle_fuyaoBoss:getBossJieDuanDamegeIdx(actID,subType,subid,bossid)
local damagelist=activitiesHandle_fuyaoBoss:getBossJieDuanDamegelist(actID,subType,subid,bossid)
local tgIdx=activitiesHandle_fuyaoBoss:getBossTongGuangIdx(actID,subType,subid,bossid)
if tgIdx>0 then
local damagevalue=activitiesHandle_fuyaoBoss:getBossJieDuanDamageValue(actID,subType,subid,bossid,tgIdx)
if damagevalue>=0 then
tgIdx=tgIdx-1
end
end
local isJieShuan=UISubAct_fuyaoshilianWin:getbosslist(bossid)

local normalidx,iconidx=activitiesHandle_fuyaoBoss:getBossNormalIdx(actID,subType,subid,bossid)
local initimg=cfg_fuyaoshilianconfig_get(subid).initImg
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
local mostergroupid=boss_config_single[1][tgIdx+1][1]
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

_this.ajlpanel:setActive(false)
_this.bjlpanel:setActive(false)
_this.cjlpanel:setActive(true)




local str=FMT.fmt('下一评级奖励')
_this.bxtxt:setActive(true)
_this.bxtxt:setText(str)
_this.bxtxt2:setActive(true)
_this.bxtxt3:setActive(false)
_this.progressbar:setActive(false)
_this.jlimged:setActive(false)
local iconName
local maxidx=#damagelist
if idx==maxidx then
iconName=FMT.fmt('image_shilianzhandou_dj{0}',damagelist[idx][3])
else
iconName=FMT.fmt('image_shilianzhandou_dj{0}',damagelist[idx+1][3])
end
_this.winlua:SetChildCSImageSprite(_this.jlimg:getID(),abname,iconName)




local reward
local maxidx=#damagelist
if idx==maxidx then
reward=damagelist[idx][2]
else
reward=damagelist[idx+1][2]
end
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
if idx==maxidx then
local str=FMT.fmt('最终评级奖励')
_this.bxtxt:setText(str)

local severBosslist=mydata.severBosslist
local recvaimid=0
if severBosslist and severBosslist[bossid]then
recvaimid=severBosslist[bossid].recvaimid or 0
end
if idx==maxidx and maxidx==recvaimid then
_this.jlimged:setActive(true)
end
end
end
_this:refreshPingJi()
end
end


function UISubAct_fuyaoshilianWin:checkArrowBtn()

self.left:setActive(self.pageIndex>0)

self.right:setActive(self.pageIndex<self.pageCount-1)
end


function UISubAct_fuyaoshilianWin:onLeftBtn()

if self.pageIndex-1>=0 then
self.pageIndex=self.pageIndex-1
self.targetHor=self.pageLength*self.pageIndex
self.shoulingIdx=self.pageIndex+1
end

_this.ranktag:setActive(false)

self:checkArrowBtn()
self:refreshBossName()
self:refreshResidueTime()

self:refreshBossDamage(_this.actid,_this.subType,_this.subid)




end


function UISubAct_fuyaoshilianWin:onRightBtn()

if self.pageIndex+1<self.pageCount then
self.pageIndex=self.pageIndex+1
self.targetHor=self.pageLength*self.pageIndex
self.shoulingIdx=self.pageIndex+1
end


_this.ranktag:setActive(false)

self:checkArrowBtn()
self:refreshBossName()
self:refreshResidueTime()

self:refreshBossDamage(_this.actid,_this.subType,_this.subid)




end


function UISubAct_fuyaoshilianWin:onTopBtn(pageIndex,_data)
local nowstamp=timeHelper.getServerShortTime()
local bossstart=_data[2]+_this.start_time
if nowstamp<bossstart then
local str=FMT.fmt('首领{0}后开启',timeHelper.format_time_stamp3((bossstart-nowstamp)))
UIManager.error(str)
return
end
if self.shoulingIdx and self.shoulingIdx==pageIndex then
return
end
if pageIndex>=0 and pageIndex<=self.pageCount then
self.pageIndex=pageIndex-1
self.targetHor=self.pageLength*self.pageIndex
self.shoulingIdx=pageIndex
end
_this.ranktag:setActive(false)
self:checkArrowBtn()
self:refreshBossName()
self:refreshResidueTime()
self:refreshBossDamage(_this.actid,_this.subType,_this.subid)
end


function UISubAct_fuyaoshilianWin:refreshPingJi()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
local alldamage=activitiesHandle_fuyaoBoss:getDamageRole(_this.actid,_this.subType,_this.subid,bossid)
if type(alldamage)~="number"then
alldamage=mathHelper.int64_to_number(alldamage)
end
local nextid,nextdmg
local widget=_this.fyiconpanel:getChildWidgetBase()

for k,v in ipairs(_this.topimg2)do
widget:SetChildActive(v,false)
end
for k,v in ipairs(self.fylinesds)do
v:setChildIconFillAmount(0)
end

local jianglilist=activitiesHandle_fuyaoBoss:getBossJieDuanDamegelist(_this.actid,_this.subType,_this.subid,bossid)
for k,v in ipairs(jianglilist)do
if v[3]then
local chenghaoTxt=FMT.fmt('image_shilianzhandou_dj{0}',v[3])
widget:SetChildCSImageSprite(_this.topimg[k],abname,chenghaoTxt)
end
widget:SetChildGray(_this.topimg[k],alldamage<v[1])
end


local jddamage=jianglilist[1][1]
if alldamage>0 then
local rate=alldamage/jddamage
if rate>1 then rate=1 end
self.fylinesd:setChildIconFillAmount(rate)
end

local alldamage2=alldamage-jianglilist[1][1]
if alldamage2>0 then
local jddamage2=jianglilist[2][1]-jianglilist[1][1]
local rate2=alldamage2/jddamage2
if rate2>1 then rate2=1 end
self.fylines:setChildIconFillAmount(rate2)
end

local alldamage3=alldamage-jianglilist[2][1]
if alldamage3>0 then
local jddamage3=jianglilist[3][1]-jianglilist[2][1]
local rate3=alldamage3/jddamage3
if rate3>1 then rate3=1 end
self.fylines2:setChildIconFillAmount(rate3)
end

local alldamage4=alldamage-jianglilist[3][1]
if alldamage4>0 then
local jddamage4=jianglilist[4][1]-jianglilist[3][1]
local rate4=alldamage4/jddamage4
if rate4>1 then rate4=1 end
self.fylines3:setChildIconFillAmount(rate4)
end
local len=activitiesHandle_fuyaoBoss:getBossTongGuangIdx(_this.actid,_this.subType,_this.subid,bossid)
if len and len>=3 then
self.txspinebg:setActive(true)
self.txspinebg:setChildUIModelShowTarget(4945,1,nil,eAnimationID.stand)
else
self.txspinebg:setActive(false)
end

local txtidx=1
for k,v in ipairs(jianglilist)do
if alldamage>=v[1]then
txtidx=k+1
end
end
if alldamage>=jianglilist[4][1]then
txtidx=4
end
widget:SetChildActive(_this.topimg2[txtidx],true)
widget:SetChildText(_this.topimgtxt2[txtidx],mathHelper.formatNumber(jianglilist[txtidx][1]))
end


function UISubAct_fuyaoshilianWin:onTiaozhanbtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_fyslEnterWin',{_this.actid,_this.subType,_this.subid,bossid})
end


function UISubAct_fuyaoshilianWin:onZybtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_fyslZenYiWin',{_this.actid,_this.subType,_this.subid,bossid,1})
end

function UISubAct_fuyaoshilianWin:onLgbtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_fyslZenYiLCWin',{_this.actid,_this.subType,_this.subid,bossid,1})
end

function UISubAct_fuyaoshilianWin:onCuitibtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_fyslZenYiLCWin',{_this.actid,_this.subType,_this.subid,bossid,1})
end


function UISubAct_fuyaoshilianWin:onRankbtn()
end


function UISubAct_fuyaoshilianWin:onBxbtn()
local flag
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
if flag then
self:showWindow('UISubAct_fyslRankWin',{_this.actid,_this.subType,_this.subid,2,bossid})
else
self:showWindow('UISubAct_fyslRankWin',{_this.actid,_this.subType,_this.subid,2,bossid})
end
end

function UISubAct_fuyaoshilianWin:onJiejibtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
self:showWindow('UISubAct_fyslRankWin',{_this.actid,_this.subType,_this.subid,2,bossid})
end

function UISubAct_fuyaoshilianWin:onDamageiconbg()
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]
self:showWindow('UISubAct_fyslRankWin',{_this.actid,_this.subType,_this.subid,2,bossid})
end


function UISubAct_fuyaoshilianWin:onRulebtn()
local boss_config_single=_this.showList[_this.shoulingIdx]
local lhidx=boss_config_single[4]
local d={}
if lhidx==0 then
d.title='规则'
d.mode=3
d.name='fuyaoshilianwin_rule_wzy_%d'
d.showBlack=true
else

local cfg_dizifaze=cfg_tsdzfzconfig_get(tefighttype)[lhidx]
if cfg_dizifaze.tm then
d.title='规则'
d.mode=3
d.name='fuyaoshilianwin_rule_%d'
d.showBlack=true
elseif cfg_dizifaze.lg then
d.title='规则'
d.mode=3
d.name='fuyaoshilianwin_rule_linggeng_%d'
d.showBlack=true
elseif cfg_dizifaze.ct then
d.title='规则'
d.mode=3
d.name='fuyaoshilianwin_rule_cuiti_%d'
d.showBlack=true
end
end
UIManager:showWindow('UIRuleWin',d)
end







function UISubAct_fuyaoshilianWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
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

function UISubAct_fuyaoshilianWin:endAllReddotPunchRotation()
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

function UISubAct_fuyaoshilianWin.beginDragCallback()
_this.isDrag=true
end
function UISubAct_fuyaoshilianWin.endDragCallback()
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
_this.shoulingIdx=_this.pageIndex+1
_this:refreshBossName()
_this:refreshResidueTime()
_this:refreshBossDamage(_this.actid,_this.subType,_this.subid)
local boss_config_single=_this.showList[_this.shoulingIdx]
local bossid=boss_config_single[7]


end

end
function UISubAct_fuyaoshilianWin.onScrollChanged()

if not _this.isDrag then
local np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true)
_this.winlua:SetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true,Mathf.Lerp(np,_this.targetHor,Time.deltaTime*_this.smooting))
end
end

function UISubAct_fuyaoshilianWin.pointBeginDragCallback()
_this.isAutoMovePoint=false
end



function UISubAct_fuyaoshilianWin:isShowPingjibtn()
local reddot=activitiesHandle_fuyaoBoss:checkNowBossIsBattle(_this.actid,_this.subType,_this.subid,_this.shoulingIdx)
local flagreddot=activitiesHandle_fuyaoBoss:checkreddotBossAll(_this.actid,_this.subType,_this.subid)
local reddot2=activitiesHandle_fuyaoBoss:checkIsLastDayBossSingle(_this.actid,_this.subType,_this.subid,_this.shoulingIdx)
_this.bjbtnreddot:setActive(reddot2 or flagreddot)
_this.pjbtn:setActive(reddot)
_this.bxbtn:setActive(not reddot)

_this:refreshbjbtnimg(_this.actid,_this.subType,_this.subid)
end

function UISubAct_fuyaoshilianWin:refreshbjbtnimg(actid,subType,subid)
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
local flagreddot=activitiesHandle_fuyaoBoss:checkreddotBossAll(actid,subType,subid)
local reddot2=activitiesHandle_fuyaoBoss:checkIsLastDayBossSingle(actid,subType,subid,_this.shoulingIdx)
_this.bjbtnreddot:setActive(reddot2 or flagreddot)
end
end


function UISubAct_fuyaoshilianWin:onPjbtn()
local reddot2=activitiesHandle_fuyaoBoss:checkIsLastDayBossSingle(_this.actid,_this.subType,_this.subid,_this.shoulingIdx)
if reddot2 then
local info=activitiesModel:getSubActInfo(_this.actid,_this.subType,_this.subid)
local start_time=info.start_time
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_fysllastday',_this.actid,_this.subid,start_time),true)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,_this.subType)
activitiesModel:callRefreshActEnter(_this.actid,_this.subType,_this.subid,"onUIEnterBigActivityIconChange",_this.actid)
end
self:isShowPingjibtn()
self:showWindow('UISubAct_fyslRankWin',{_this.actid,_this.subType,_this.subid,2,_this.shoulingIdx})
end
function UISubAct_fuyaoshilianWin:onClickItem(itemId,index,guid,attach)
if itemId>0 then
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
end

function UISubAct_fuyaoshilianWin:showtiaozhanReddot(isreddot)
self.baoXiangReddot:setActive(isreddot)
if isreddot then
if self.reddotTweener==nil then
self.baoXiangReddot:setRotation(0,0,0)
local tweener=self.baoXiangReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.baoXiangReddot:setRotation(0,0,0)
end
end
end


function UISubAct_fuyaoshilianWin:checkzengyi()
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
