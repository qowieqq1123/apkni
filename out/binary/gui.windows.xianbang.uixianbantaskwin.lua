







def_class("UIXianBanTaskWin",UIWindowBase)









function UIXianBanTaskWin:bindComponents()

self.bgspine=UIObject.get(self,0)
self.cddjzbProgress=UIObject.get(self,1)
self.cdPanel=UIObject.get(self,2)
self.djstxt=UIText.get(self,3)
self.doubleicon=UIObject.get(self,4)
self.finishbtn=UIButton.get(self,5)
self.gobtn=UIButton.get(self,6)
self.icon=UIImage.get(self,7)
self.MonsterFight=UIObject.get(self,8)
self.monsterFightText=UIText.get(self,9)
self.monsterIcon=UIObject.get(self,10)
self.monsterKuang=UIImage.get(self,11)
self.msspine=UIObject.get(self,12)
self.progressbar=UIProgress.get(self,13)
self.rename2=UIText.get(self,14)
self.root=UIObject.get(self,15)
self.rwItem1=UIObject.get(self,16)
self.rwItem2=UIObject.get(self,17)
self.rwItem3=UIObject.get(self,18)
self.rwItem4=UIObject.get(self,19)
self.rwItem5=UIObject.get(self,20)
self.rwItemtwo1=UIObject.get(self,21)
self.rwItemtwo2=UIObject.get(self,22)
self.rwItemtwo3=UIObject.get(self,23)
self.rwItemtwo4=UIObject.get(self,24)
self.rwItemtwo5=UIObject.get(self,25)
self.rwScrollView=UIObject.get(self,26)
self.rwScrollView2=UIObject.get(self,27)
self.rwScrollViewtwo=UIObject.get(self,28)
self.rwScrollViewtwo2=UIObject.get(self,29)
self.stateimg=UIImage.get(self,30)
self.taskname=UIText.get(self,31)
self.timedjzb=UIText.get(self,32)
self.tips=UIText.get(self,33)
self.topbg=UIImage.get(self,34)

self.finishbtn:setButtonClick(function()self:onFinishbtn()end)

self.gobtn:setButtonClick(function()self:onGobtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIXianBanTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgspine);self.bgspine=nil;
_UIObject_release(self.cddjzbProgress);self.cddjzbProgress=nil;
_UIObject_release(self.cdPanel);self.cdPanel=nil;
_UIObject_release(self.djstxt);self.djstxt=nil;
_UIObject_release(self.doubleicon);self.doubleicon=nil;
_UIObject_release(self.finishbtn);self.finishbtn=nil;
_UIObject_release(self.gobtn);self.gobtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.MonsterFight);self.MonsterFight=nil;
_UIObject_release(self.monsterFightText);self.monsterFightText=nil;
_UIObject_release(self.monsterIcon);self.monsterIcon=nil;
_UIObject_release(self.monsterKuang);self.monsterKuang=nil;
_UIObject_release(self.msspine);self.msspine=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.rename2);self.rename2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rwItem1);self.rwItem1=nil;
_UIObject_release(self.rwItem2);self.rwItem2=nil;
_UIObject_release(self.rwItem3);self.rwItem3=nil;
_UIObject_release(self.rwItem4);self.rwItem4=nil;
_UIObject_release(self.rwItem5);self.rwItem5=nil;
_UIObject_release(self.rwItemtwo1);self.rwItemtwo1=nil;
_UIObject_release(self.rwItemtwo2);self.rwItemtwo2=nil;
_UIObject_release(self.rwItemtwo3);self.rwItemtwo3=nil;
_UIObject_release(self.rwItemtwo4);self.rwItemtwo4=nil;
_UIObject_release(self.rwItemtwo5);self.rwItemtwo5=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.rwScrollView2);self.rwScrollView2=nil;
_UIObject_release(self.rwScrollViewtwo);self.rwScrollViewtwo=nil;
_UIObject_release(self.rwScrollViewtwo2);self.rwScrollViewtwo2=nil;
_UIObject_release(self.stateimg);self.stateimg=nil;
_UIObject_release(self.taskname);self.taskname=nil;
_UIObject_release(self.timedjzb);self.timedjzb=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.topbg);self.topbg=nil;
end
















local _this
local abname="ui/windows/xianbang/xianbang_atlas_pak.ab"
local rwidex=
{
type1=1,
type2=2
}
local abName=""



function UIXianBanTaskWin:onLoaded(...)
self:bindComponents()
_this=self
self.rwlist={self.rwItem1,self.rwItem2,self.rwItem3,self.rwItem4,self.rwItem5}
self.rwlist2={self.rwItemtwo1,self.rwItemtwo2,self.rwItemtwo3,self.rwItemtwo4,self.rwItemtwo5}
end


function UIXianBanTaskWin:__delete()
self:unbindComponents()
self:clearTimer()
self:stopMarchTick()
_this=nil
end




function UIXianBanTaskWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
self.taskId=argtable.taskId
self.cfg_task=cfg_xianbangtaskconfig_get(self.taskId)
self.taskdata=xianjiexianbangModel:getXBTaskDatabyId(self.taskId)
self.alltime=0
self.doubleicon:setActive(false)

self.rqdata=nil
self.taskflag=1
local taskreLists=xianjieModel:findResPointsByXianBangTask(self.taskId)

if taskreLists and#taskreLists>0 then
self.rqdata=taskreLists[1]
self.taskflag=1
else
self.taskflag=2
local srcArgs={
scrtype=xjResPointSourceType.eXianBangTask,
taskid=self.taskId,
}
local taskreLists2=xianjieModel:findResPointCacheDatasBySource(srcArgs)
if taskreLists2 and#taskreLists2>0 then
self.rqdata=taskreLists2[1]
end

end
self.tips:setActive(false)
if self.cfg_task.flag and self.cfg_task.flag==1 then
self.jobflag,self.xgid=xianguanController:checkSelfHasJobByType(10)
if self.taskdata and self.taskdata.actorId then
self.doubleicon:setActive(tostring(playerModel:getActorID())==tostring(self.taskdata.actorId))
end

self.tips:setActive(true)
end













self:initdata()
end


function UIXianBanTaskWin:onHide()

end
function UIXianBanTaskWin:onCloseClick()
self:closeSelf()
end

function UIXianBanTaskWin:severfresh()
_this:initdata()
end

function UIXianBanTaskWin:onClickItemitem(itemId)
if itemId then
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true,move=TIPS_MOVE_POS.eCenter})
end
end

function UIXianBanTaskWin:startCountDown(_djtime)
self:clearTimer()
local djstime=_djtime
if djstime>0 then
self.cdPanel:setActive(true)
local alltiem=djstime-gameUtilityModel.getServerShortTime()
local tick=function()
local dt=djstime-gameUtilityModel.getServerShortTime()
local nowtime=alltiem-dt+1
if dt>0 then
self.timedjzb:setText(timeHelper.format_time_stamp11(dt))
self.cddjzbProgress:setChildUIProgressbar(nowtime,alltiem)
else
self:clearTimer()
self.cdPanel:setActive(false)
end
end
self.timer=self:setTimer(1,0,tick)
tick()
end
end

function UIXianBanTaskWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIXianBanTaskWin:onFinishbtn()
xianjiexianbangController:send_37_82()
self:closeSelf()
end

function UIXianBanTaskWin:onGobtn()
if self.taskflag==1 then
if self.rqdata then
if self.rqdata.sceneidx then
local mapid=xianjieModel:sceneIndex2SceneType(self.rqdata.sceneidx)
local temp={
gridX=self.rqdata.gridX,
gridZ=self.rqdata.gridZ,
sceneidx=self.rqdata.sceneidx,
}
jumpManager:jump({id=JUMP_TYPE.eXianJie_ResPoint_4,args={mapid=mapid,taskid=self.taskId,autoclick=true,xtemp=temp}})
end
end
elseif self.taskflag==2 then
local sceneidx,gridX,gridZ=xianjiexianbangController:jumpxjzm()
if sceneidx then
self:closeSelf()
local func=function()
xianjieController:openWin('UIXianJieExplorationWin',{page=5})
end
xianjieController:jumpGrid(sceneidx,gridX,gridZ,func,true)
end
end
end


function UIXianBanTaskWin:getrewardlsit()
local list={}
local rewards=self.cfg_task.rewards
local type=rewards[1]
local redata=rewards[2]
if type==rwidex.type1 then
list=redata
elseif type==rwidex.type2 then
local exrewards=self.cfg_task.exrewards or{}
list=exrewards
end
return type,list
end

function UIXianBanTaskWin:initdata()

self.taskname:setText(self.cfg_task.name)


self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
self.bgspine:setChildUIModelShowTarget(self.cfg_task.spinecolor,1,nil,eAnimationID.enter)


local retype,rewards=self:getrewardlsit()
local len=#rewards
self.rwScrollView:setActive(false)
self.rwScrollView2:setActive(false)
if len>0 then
if len>5 then
self.rwScrollView:setActive(true)
self.rwScrollView:setChildScrollViewCreateGrids(len,len)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=false
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
self:onClickItemitem(itemId)
end)
item:SetChildActive(2,retype~=rwidex.type1)
end
else
self.rwScrollView2:setActive(true)
for i=1,len do
local item=self.rwlist[i]:getWidgetBase()
local data=rewards[i]
if data then
item:SetChildActive(0,true)
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=false
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(1,prop)
item:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
self:onClickItemitem(itemId)
end)
item:SetChildActive(2,retype~=rwidex.type1)
end
end
end
end


local failFlag=self.taskdata.failFlag
local finishFlag=self.taskdata.finishFlag
if finishFlag==0 then
self.gobtn:setActive(true)
self.finishbtn:setActive(false)
else
self.gobtn:setActive(false)
self.finishbtn:setActive(true)
end


self.MonsterFight:setActive(false)
self.cdPanel:setActive(false)
self.djstxt:setActive(false)
self.stateimg:setActive(false)

if self.rqdata then
self:rpHandleDtat(self.rqdata,self.taskflag,finishFlag)
else
if self.taskflag==1 then
logErr(FMT.fmt('1仙榜系统--该任务没有生成资源点数据,任务id={0},前后端检查',self.taskId))
elseif self.taskflag==2 then
logErr(FMT.fmt('2仙榜系统--该任务没有生成资源点数据,任务id={0},前后端检查',self.taskId))
end
end

end


function UIXianBanTaskWin:rpHandleDtat(rpData,taskflag,finishFlag)
if taskflag==1 then
local cfg=rpData:getCfg()
if rpData.rpType==XJ_ResPoint_TYPE.eMonster then

local modelParams=comHelper.getMonsterGroupModelParams(cfg.monster_id)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,18)
local scales2=cfg.scales2
if scales2 then
scaleParam=scales2[1]
end
self.msspine:setChildUIModelShowTarget(modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,1,nil)
self.msspine:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])

local fightvalue=self.cfg_task.fightvalue or 0
self.MonsterFight:setActive(true)
self.monsterFightText:setText(mathHelper.formatNumber5(fightvalue,2))

if finishFlag==0 then
self.guid=rpData.rpGuid
self:refreshMarchInfo()
end

elseif rpData.rpType==XJ_ResPoint_TYPE.eCollectible then
self.iseCollectible=true



local body=cfg.modelSet.model
local scaleParam={0.5,0,0}
local scales2=cfg.scales2
if scales2 then
scaleParam=scales2[1]
end
self.msspine:setChildUIModelShowTarget(body,scaleParam[1],{},eAnimationID.stand,false,false,1,nil)
self.msspine:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])

if finishFlag==0 then
self.guid=rpData.rpGuid
local battleTime=cfg.battleTime
self:refreshMarchInfo(true,battleTime)
end

elseif rpData.rpType==XJ_ResPoint_TYPE.eCtCollectible then

self.monsterKuang:setActive(true)
self.winlua:SetChildIcon(self.monsterIcon:getID(),cfg.headimage,false)
end
self:droprewards(rpData.rpType,cfg)

elseif taskflag==2 then
local rpId=rpData.rpId
local rqGuid=rpData.rqGuid
local cfg=xianjieModel:getXJResPointClassifyCfg(rpData.rpType,rpId)

if rpData.rpType==XJ_ResPoint_TYPE.eMonster then
local modelParams=comHelper.getMonsterGroupModelParams(cfg.monster_id)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,18)
local scales2=cfg.scales2
if scales2 then
scaleParam=scales2[1]
end
self.msspine:setChildUIModelShowTarget(modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,1,nil)
self.msspine:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])

local fightvalue=self.cfg_task.fightvalue
self.MonsterFight:setActive(true)
self.monsterFightText:setText(mathHelper.formatNumber5(fightvalue,2))

elseif rpData.rpType==XJ_ResPoint_TYPE.eCollectible then

local body=cfg.modelSet.model
local scaleParam={0.5,0,0}
local scales2=cfg.scales2
if scales2 then
scaleParam=scales2[1]
end
self.msspine:setChildUIModelShowTarget(body,scaleParam[1],{},eAnimationID.stand,false,false,1,nil)
self.msspine:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])

elseif rpData.rpType==XJ_ResPoint_TYPE.eCtCollectible then

self.monsterKuang:setActive(true)
self.winlua:SetChildIcon(self.monsterIcon:getID(),cfg.headimage,false)
end
self:droprewards(rpData.rpType,cfg)
end
end


function UIXianBanTaskWin:droprewards(flag,cfg)
local rewardList={}
if flag==XJ_ResPoint_TYPE.eMonster then
local dropCfg=cfgHelper.get(cfg_awardconfig_get,cfg.drop_id)
rewardList=dropCfg and dropCfg.showItems or{}
self.rename2:setText('征讨奖励')

elseif flag==XJ_ResPoint_TYPE.eCollectible then
local dropCfg=cfgHelper.get(cfg_awardconfig_get,cfg.drop_id)
rewardList=dropCfg and dropCfg.showItems or{}
self.rename2:setText('探索掉落')

elseif flag==XJ_ResPoint_TYPE.eCtCollectible then
rewardList=cfg and cfg.rewards or{}
self.rename2:setText('缴纳奖励')
end


local rewards=rewardList
local len=#rewards
self.rwScrollViewtwo:setActive(false)
self.rwScrollViewtwo2:setActive(false)
if len>0 then
if len>=5 then
self.rwScrollViewtwo:setActive(true)
self.rwScrollViewtwo:setChildScrollViewCreateGrids(len,len)
local grids=self.rwScrollViewtwo:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=false
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
self:onClickItemitem(itemId)
end)
item:SetChildActive(2,data.range==nil and itemCount<0)
end
else
self.rwScrollViewtwo2:setActive(true)
for i=1,len do
local item=self.rwlist2[i]:getWidgetBase()
local data=rewards[i]
if data then
item:SetChildActive(0,true)
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=false
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(1,prop)
item:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
self:onClickItemitem(itemId)
end)
item:SetChildActive(2,data.range==nil and itemCount<0)
end
end
end
end
end


function UIXianBanTaskWin:refreshMarchInfo(flag,battleTime)
local marching=xianjieModel:haveResPointMarch(self.guid)

if marching then

















self.djstxt:setActive(true)
else

self.djstxt:setActive(false)
end
end

function UIXianBanTaskWin:startMarchTick()
if not self.marchTick then
self.marchTick=self:setTimer(1,0,function()
self:updateMarchTick()
end)
end
end

function UIXianBanTaskWin:stopMarchTick()
if self.marchTick then
self:stopTimerByID(self.marchTick)
self.marchTick=nil
end
end

function UIXianBanTaskWin:updateMarchTick()
local march=xianjieModel:getResPointMarch(self.guid)
local teamHandle=march:getTeamHandle()
local state,times,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local time_str=lerp>0 and timeHelper.format_time_stamp3(lerp)or'--'
self.timedjzb:setText(time_str)

local nowtime=self.alltime-lerp+1

self.cddjzbProgress:setChildUIProgressbar(nowtime,self.alltime)
else
self.djstxt:setActive(true)
self.cdPanel:setActive(false)
if self.iseCollectible then


end
self:stopMarchTick()
end
end



function UIXianBanTaskWin:testchangemodel(id)
local cfg=cfg_fairylandmonsterresourceconfig_get(id)
local modelParams=comHelper.getMonsterGroupModelParams(cfg.monster_id)
local scaleParam={1,10,10}
local scales2=cfg.scales2
if scales2 then
scaleParam=scales2[1]
end
_this.msspine:setChildUIModelShowTarget(modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,1,nil)
_this.msspine:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])
end
