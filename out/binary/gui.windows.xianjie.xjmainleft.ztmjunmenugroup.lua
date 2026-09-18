







def_class("ztmjunmenuGroup",UICloneObject)





ztmjunmenuGroup.abName="ui/windows/xianjie/xjmainleft/ztmjunmenugroup.ab"

ztmjunmenuGroup.assetName="ztmjunmenuGroup"


function ztmjunmenuGroup:bindComponents()

self.content=UIObject.get(self,0)
self.listBg=UIObject.get(self,1)
self.mjBtn=UIButton.get(self,2)
self.mjGoToBtn=UIButton.get(self,3)
self.mjHp=UIObject.get(self,4)
self.mjHpTxt=UIText.get(self,5)
self.mjModel=UIObject.get(self,6)
self.mjName=UIText.get(self,7)
self.mjPanel=UIObject.get(self,8)
self.mjSelect=UIObject.get(self,9)
self.mjType=UIButton.get(self,10)
self.mjTypeName=UIText.get(self,11)
self.mojun=UIObject.get(self,12)
self.noneTips=UIObject.get(self,13)
self.noneTxt=UIText.get(self,14)
self.scrollView=UIObject.get(self,15)
self.title=UIText.get(self,16)
self.xjBtn=UIButton.get(self,17)
self.xjSelect=UIObject.get(self,18)

self.mjBtn:setButtonClick(function()self:onMjBtn()end)

self.mjGoToBtn:setButtonClick(function()self:onMjGoToBtn()end)

self.mjType:setButtonClick(function()self:onMjType()end)

self.xjBtn:setButtonClick(function()self:onXjBtn()end)

end


function ztmjunmenuGroup:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.listBg);self.listBg=nil;
_UIObject_release(self.mjBtn);self.mjBtn=nil;
_UIObject_release(self.mjGoToBtn);self.mjGoToBtn=nil;
_UIObject_release(self.mjHp);self.mjHp=nil;
_UIObject_release(self.mjHpTxt);self.mjHpTxt=nil;
_UIObject_release(self.mjModel);self.mjModel=nil;
_UIObject_release(self.mjName);self.mjName=nil;
_UIObject_release(self.mjPanel);self.mjPanel=nil;
_UIObject_release(self.mjSelect);self.mjSelect=nil;
_UIObject_release(self.mjType);self.mjType=nil;
_UIObject_release(self.mjTypeName);self.mjTypeName=nil;
_UIObject_release(self.mojun);self.mojun=nil;
_UIObject_release(self.noneTips);self.noneTips=nil;
_UIObject_release(self.noneTxt);self.noneTxt=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.xjBtn);self.xjBtn=nil;
_UIObject_release(self.xjSelect);self.xjSelect=nil;
end






local _this=nil
local _itemCmp={
nameTx=0,
hpTx=1,
bg=2,
headKuang=3,
icon=4,
jumpBtn=5,
open=6,
close=7,
cdTx=8,
dead=9,
}




function ztmjunmenuGroup:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onXianJieMapDataInit,self.onXianJieMapDataInit)
self:addNotify(notifyConfig.onXianJieEntityAdd,self.onXianJieEntityAdd)
self:addNotify(notifyConfig.onXianJieEntityRemove,self.onXianJieEntityRemove)


self:addProNotify(39,17,self.on_39_17)
self:addProNotify(39,20,self.on_39_20)
self:addProNotify(39,23,self.on_39_23)
end


function ztmjunmenuGroup:__delete()
self:unbindComponents()
_this=nil
end




function ztmjunmenuGroup:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parent
if not self.selectMenuPageIndex then
self.selectMenuPageIndex=1
end
self.oldSortLen=0

local mojunData=xianjieModel:getMoJunData()
if mojunData.killTime>0 then
self.selectMenuPageIndex=2
end

local mojunData=xianjieModel:getMoJunData()
local seasonType=mojunData.seasonType
local stageIndex=mojunData.stageIndex
local yaomoTime=seasonModel:getStageConfigEx(seasonType,stageIndex,"yaomoTime")
self.stage=seasonModel:findFirstDoingStage(seasonStageType.eTZMJ)
local zeroSec=timeHelper.getServerZeroShortStamp(self.stage.beginTime)
self.yaomoStartTime=zeroSec+yaomoTime[1]*3600+yaomoTime[2]*60+yaomoTime[3]
if self.stage.beginTime>self.yaomoStartTime then
self.yaomoStartTime=self.yaomoStartTime+24*3600
end

self:initView()
self:refreshBtn()
self:refreshPanel()
self:refreshXianJieMainWinSimpleStateChange()
end


function ztmjunmenuGroup:onHide()

end



function ztmjunmenuGroup:onMjBtn()
if self.selectMenuPageIndex==2 then
self.selectMenuPageIndex=1
if self.dataChange then
self.dataChange=false

self:updateData()
end
self:refreshBtn()
self:refreshPanel()
end
end

function ztmjunmenuGroup:onXjBtn()
if self.selectMenuPageIndex==1 then
self.selectMenuPageIndex=2
self:refreshBtn()
self:refreshPanel()
end
end

function ztmjunmenuGroup:onMjGoToBtn()
xianjieController:jumpMoJieMoJun()
end

function ztmjunmenuGroup.onNewDay()
if _this==nil then return end
if _this.selectMenuPageIndex==1 then
_this:refreshMJPanel()
end
end



function ztmjunmenuGroup:setRemainingTimeTimer()
self:clearTimer()
local mojunData=xianjieModel:getMoJunData()
local seasonType=mojunData.seasonType
local stageIndex=mojunData.stageIndex
local mojunTime=seasonModel:getStageConfigEx(seasonType,stageIndex,"mojunTime")
local yaomoTime=seasonModel:getStageConfigEx(seasonType,stageIndex,"yaomoTime")
local func=function()
local nowTime=timeHelper.getServerShortTime()
local lerp=_this.endTime-nowTime
if lerp>=0 then
if mojunData.state==0 then
if timeHelper.checkInSameDay2(nowTime,_this.endTime)then
_this.noneTxt:setText(FMT.fmt("魔宫护卫匿于幽瘴\n今日<color=#f1ce78>{0}时</color>现身，可讨伐之",yaomoTime[1]))
else
_this.noneTxt:setText(FMT.fmt("魔宫护卫匿于幽瘴\n明日<color=#f1ce78>{0}时</color>现身，可讨伐之",yaomoTime[1]))
end
else
if timeHelper.checkInSameDay2(nowTime,_this.endTime)then
self.noneTxt:setText(FMT.fmt("魔宫护卫已灭\n今日<color=#f1ce78>{0}时</color>可讨伐魔君",mojunTime[1]))
else
self.noneTxt:setText(FMT.fmt("魔宫护卫已灭\n明日<color=#f1ce78>{0}时</color>可讨伐魔君",mojunTime[1]))
end
end
else
if mojunData.state==0 then
xianjieController.recv_39_23(seasonType,stageIndex,1,0)
_this:refreshMJYM()
else
_this:refreshMJPanel()
end

_this:clearTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function ztmjunmenuGroup:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function ztmjunmenuGroup:getSelectMenuPageIndex()
return self.selectMenuPageIndex
end

function ztmjunmenuGroup:updateData()
local list=xianjieController:getEntitysByEntityType(XJ_ENTITY_TYPE.eMonster)

self.mjSortLookup={}
self.mjSortList={}
for i,entity in ipairs(list)do
local infoguid=entity.infoguid
local monsterData=xianjieModel:getMonsterData(infoguid)
if not entity.dead and monsterData and monsterData.entitytype==xjServerEnityType.eMoJieMoJunYaoMo then
table.insert(self.mjSortList,infoguid)
self.mjSortLookup[monsterData.ent_key]=infoguid
end
end

local count=#self.mjSortList
if count~=self.oldSortLen then
self.content:setChildLayoutGroupCreateItems(count,function(index)
local item=self.content:getChildLayoutGroupGridItem(index-1)
item:SetChildButtonClick(_itemCmp.jumpBtn,function()
self:onClickJump(index)
end)
item:SetChildButtonClick(_itemCmp.bg,function()
self:onClickItem(index)
end)
end)
self.oldSortLen=count
end
end

function ztmjunmenuGroup:initView()
self:updateData()
end

function ztmjunmenuGroup:refreshBtn()
self.xjSelect:setActive(self.selectMenuPageIndex==2)
self.mjSelect:setActive(self.selectMenuPageIndex==1)
end

function ztmjunmenuGroup:refreshPanel()
if self.selectMenuPageIndex==1 then
self:refreshMJPanel()
elseif self.selectMenuPageIndex==2 then
self:refreshXJPanel()
end
end

function ztmjunmenuGroup:refreshMJPanel()
self.mjPanel:setActive(true)
self.parentWin.xjPanel:setActive(false)


local mojunData=xianjieModel:getMoJunData()
if not mojunData then
return
end
local seasonType=mojunData.seasonType
local stageIndex=mojunData.stageIndex
local yaomo=seasonModel:getStageConfigEx(seasonType,stageIndex,"yaomo")

local nowTime=timeHelper.getServerShortTime()
local state=mojunData.state
if state==0 then
local yaomoTime=seasonModel:getStageConfigEx(seasonType,stageIndex,"yaomoTime")
if nowTime<self.yaomoStartTime then
self.noneTips:setActive(true)
self.mojun:setActive(false)
if timeHelper.checkInSameDay2(nowTime,self.yaomoStartTime)then
_this.noneTxt:setText(FMT.fmt("魔宫护卫匿于幽瘴\n今日<color=#f1ce78>{0}时</color>现身，可讨伐之",yaomoTime[1]))
else
_this.noneTxt:setText(FMT.fmt("魔宫护卫匿于幽瘴\n明日<color=#f1ce78>{0}时</color>现身，可讨伐之",yaomoTime[1]))
end
self.endTime=self.yaomoStartTime

self:setRemainingTimeTimer()
else
xianjieController.recv_39_23(seasonType,stageIndex,1,0)
self:refreshMJYM()
end
elseif state==1 then
self.noneTips:setActive(false)
self.mojun:setActive(false)
self.title:setText(FMT.fmt("当前波数：{0}<color=#f1ce78>（{1}/{2}）</color>",mojunData.yaomoIndex,mojunData.yaomoIndex,#yaomo))
for index,infoguid in ipairs(self.mjSortList)do
local item=self.content:getChildLayoutGroupGridItem(index-1)
self:refreshMJItem(infoguid,item)
end
elseif state==2 then
local mojunTime=seasonModel:getStageConfigEx(seasonType,stageIndex,"mojunTime")
if mojunData.timeType==1 then
self.noneTips:setActive(true)
self.mojun:setActive(false)
if timeHelper.checkInSameDay2(nowTime,mojunData.endTime)then
self.noneTxt:setText(FMT.fmt("魔宫护卫已灭\n今日<color=#f1ce78>{0}时</color>可讨伐魔君",mojunTime[1]))
else
self.noneTxt:setText(FMT.fmt("魔宫护卫已灭\n明日<color=#f1ce78>{0}时</color>可讨伐魔君",mojunTime[1]))
end
self.endTime=mojunData.endTime

self:setRemainingTimeTimer()
elseif mojunData.timeType==2 then
local entityData=xianjieModel:getMoJunEntityData(seasonType,stageIndex)
local cfg=entityData:getCfg()
local isMoJun,isMoJunInit=xianjieModel:isMoJunBuild(mojunData.build_id)
local _ab,iconname=xianjieModel:getMoJunTypeIcon(mojunData.build_id)
local body,componets,scale,flip,offset=xianjieModel:getMoJunModelData()

local _x=20
local _y=-100
local idx=isMoJunInit and 1 or 2
local showParams=cfgHelper.get2(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu,"showParams")
if showParams and showParams[idx]then
scale=showParams[idx][1]or 1
_x=showParams[idx][2]or 20
_y=showParams[idx][3]or-100
end
self.mjModel:setLocalPos(_x,_y,0)
self.mjModel:setChildUIModelShowTarget(body,scale,componets or defaultT,eAnimationID.stand,false,false,0,nil)
self.mjType:setCSImageSprite(_ab,iconname)
self.mjTypeName:setText(isMoJunInit and"初形"or"真身")
self.mjName:setText(cfg.name)
local hp=mojunData.hp
self.mjHp:setChildIconFillAmount(hp/100000000)
local num=math.floor(hp/10000)/100
if hp>0 and hp<=10000 then
num=0.01
end
local rate_str=FMT.fmt('{0}%',num)
self.mjHpTxt:setText(rate_str)
end
self.noneTips:setActive(mojunData.timeType==1)
self.mojun:setActive(mojunData.timeType==2)
local MJZJID=xianjieModel:getMoJunZhangJieID()
if MJZJID==MoJunZhangJieID.two then
self.mjType:setActive(false)
end
end
self.title:setActive(state==1)
self.scrollView:setActive(state==1)
end

function ztmjunmenuGroup:refreshMJItem(infoguid,item)
local monsterData=xianjieModel:getMonsterData(infoguid)
item:SetChildActive(-1,monsterData~=nil)
if not monsterData then
return
end
local cfg=monsterData:getCfg()
local monsterGroup=cfg.monster[1]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroup)

item:SetChildActive(_itemCmp.hpTx,false)
item:SetChildActive(_itemCmp.cdTx,false)
item:SetChildActive(_itemCmp.open,true)
item:SetChildActive(_itemCmp.close,false)
item:SetChildActive(_itemCmp.dead,false)
item:SetChildText(_itemCmp.nameTx,monsterData:getName())
item:SetChildCSImageSprite(_itemCmp.headKuang,globalABLookup.global,monTypeBg[monsterCfg.monType])
comHelper.setChildModelRawImage_monsterGroup(item,monsterGroup,_itemCmp.icon,eAnimationID.stand,eHeadCenterType.eHead)
end

function ztmjunmenuGroup:onClickItem(index)
local infoguid=self.mjSortList[index]
xianjieController:openMonsterInfoWin(infoguid)
end

function ztmjunmenuGroup:onClickJump(index)
local infoguid=self.mjSortList[index]
xianjieController:openMonsterInfoWin(infoguid)
end

function ztmjunmenuGroup:refreshXJPanel()
self.mjPanel:setActive(false)
self.parentWin.xjPanel:setActive(true)
self.parentWin:refreshTeamPanel()
end

function ztmjunmenuGroup.on_39_17(seasonType,stageIndex,mojunHP)
if _this.selectMenuPageIndex==1 then
local mojunData=xianjieModel:getMoJunData()
local _seasonType=mojunData.seasonType
local _stageIndex=mojunData.stageIndex
if seasonType==_seasonType and _stageIndex==stageIndex then
_this:refreshMJPanel()
end
end
end

function ztmjunmenuGroup.on_39_20(args)
if _this.selectMenuPageIndex==1 then
local seasonType=args[1]
local stageIndex=args[2]
local mojunDieTime=args[3]
local mojunData=xianjieModel:getMoJunData()
local _seasonType=mojunData.seasonType
local _stageIndex=mojunData.stageIndex
if seasonType==_seasonType and _stageIndex==stageIndex then
_this:refreshMJPanel()
end
end
end

function ztmjunmenuGroup.on_39_23(seasonType,stageIndex,boshu,ymEndTime)
if _this.selectMenuPageIndex==1 then
local mojunData=xianjieModel:getMoJunData()
local _seasonType=mojunData.seasonType
local _stageIndex=mojunData.stageIndex
if seasonType==_seasonType and _stageIndex==stageIndex then
_this:refreshMJPanel()
end
end
end

function ztmjunmenuGroup.onSeasonChange()
if _this.selectMenuPageIndex==1 then
_this.stage=seasonModel:findFirstDoingStage(seasonStageType.eTZMJ)
if _this.stage then
_this:initView()
_this:refreshPanel()
end
else
_this.dataChange=true
end
end

function ztmjunmenuGroup.onSeasonStageChange(seasonType,stageIndex)
local mojunData=xianjieModel:getMoJunData()
local _seasonType=mojunData.seasonType
local _stageIndex=mojunData.stageIndex
if seasonType==_seasonType and _stageIndex==stageIndex then
if _this.selectMenuPageIndex==1 then
_this:refreshMJYM()
else
_this.dataChange=true
end
end
end

function ztmjunmenuGroup.onXianJieMonsterChange(typo,infoguid)
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData.entitytype==xjServerEnityType.eMoJieMoJunYaoMo then
if _this.selectMenuPageIndex==1 then
_this:refreshMJYM()
else
_this.dataChange=true
end
end
end

function ztmjunmenuGroup.onXianJieMapDataInit()
if _this.selectMenuPageIndex==1 then
_this:refreshMJYM()
else
_this.dataChange=true
end
end

function ztmjunmenuGroup.onXianJieEntityAdd(key,entitytype)
if entitytype==xjServerEnityType.eMoJieMoJunYaoMo and(not _this.mjSortLookup or not _this.mjSortLookup[key])then
if _this.selectMenuPageIndex==1 then
_this:refreshMJYM()
else
_this.dataChange=true
end
end
end

function ztmjunmenuGroup.onXianJieEntityRemove(key)
if _this.mjSortLookup and _this.mjSortLookup[key]~=nil then
if _this.selectMenuPageIndex==1 then
_this:refreshMJYM()
else
_this.dataChange=true
end
end
end

function ztmjunmenuGroup:refreshMJYM()
if not _this.refreshTimer then
_this.refreshTimer=_this:delayDo(0.2,function()
_this:updateData()
_this:refreshMJPanel()
_this.refreshTimer=nil
end)
end
end

function ztmjunmenuGroup:onMjType()
local pos=self.mjType:getChildLocalPosition()
UIManager:showWindow("UIMoJie_MoJunTypeTipsWin",{isRight=false})
end

local simpleKey="xianjieMainWin.meueGropEx.ztmjunmenuGroup"
function ztmjunmenuGroup:refreshXianJieMainWinSimpleStateChange()
local simpleState=xianjieMainWinSimpleModeConfig:getRecordState(simpleKey)

self.widget:SetChildActive(-1,not simpleState)
end
