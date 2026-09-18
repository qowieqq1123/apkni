







def_class("UIZongmenDailyWin",UIWindowBase)









function UIZongmenDailyWin:bindComponents()

self.shenxiaoText=UIText.get(self,0)
self.weather=UIImage.get(self,1)
self.weekText=UIText.get(self,2)
self.piaoChong=UIObject.get(self,3)
self.timeText=UIText.get(self,4)
self.speakObj=UIObject.get(self,5)
self.descText=UIText.get(self,6)
self.jumpBtn=UIButton.get(self,7)
self.notEventInfo=UIObject.get(self,8)
self.reporterText=UIText.get(self,9)
self.tipsBtn=UIButton.get(self,10)
self.notDzInfo=UIObject.get(self,11)
self.selectDropdown=UIDropdown.get(self,12)
self.txtSpeak=UIText.get(self,13)
self.zmTime=UIText.get(self,14)
self.Content=UIObject.get(self,15)
self.zmStateScrollerView=UIObject.get(self,16)
self.moneyIcon=UIImage.get(self,17)
self.moneyCnt=UIText.get(self,18)
self.detailBtn=UIButton.get(self,19)
self.reporterHead=UIObject.get(self,20)
self.zmStability=UIText.get(self,21)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)



end


function UIZongmenDailyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.shenxiaoText);self.shenxiaoText=nil;
_UIObject_release(self.weather);self.weather=nil;
_UIObject_release(self.weekText);self.weekText=nil;
_UIObject_release(self.piaoChong);self.piaoChong=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.notEventInfo);self.notEventInfo=nil;
_UIObject_release(self.reporterText);self.reporterText=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.notDzInfo);self.notDzInfo=nil;
_UIObject_release(self.selectDropdown);self.selectDropdown=nil;
_UIObject_release(self.txtSpeak);self.txtSpeak=nil;
_UIObject_release(self.zmTime);self.zmTime=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.zmStateScrollerView);self.zmStateScrollerView=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyCnt);self.moneyCnt=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.reporterHead);self.reporterHead=nil;
_UIObject_release(self.zmStability);self.zmStability=nil;
end

















local mouseYear=2020
local shenxiaoStr={'鼠','牛','虎','兔','龙','蛇','马','羊','猴','鸡','狗','猪'}

local abName='ui/windows/dailypaper/sharedtextures/zmdailypaper.ab'

local changeType=
{
[eZMDailyPaperType.eDzAllType]=0,
[eZMDailyPaperType.eJingJie]=1,
[eZMDailyPaperType.eProSkill]=2,
[eZMDailyPaperType.eShouYuan]=3,
[eZMDailyPaperType.eChuiWeiInjury]=4,
[eZMDailyPaperType.eChuiWeiShouYuan]=5,
}


function UIZongmenDailyWin:onLoaded(...)
self:bindComponents()
self.selectDropdown:setChangeAction(function(...)self:onClickSXTypeDropdown(...)end)
self.zmStateScrollerView:setChildScrollViewInit(-1,true,nil,nil)

UIDailyPaperModel:initData()
UIDailyPaperModel:initShowEvent()
end


function UIZongmenDailyWin:__delete()

self:removePiaoChongBT()
self:killSpeakTween()
self:unbindComponents()
end




function UIZongmenDailyWin:onShow(argtable,afterOnloaded)
self:flushReporterInfo()
self:flushZMInfo()
self:initDropdown()
self:flushDiscpilesInfo()
self:flushOtherInfo()
end


function UIZongmenDailyWin:onHide()

end

function UIZongmenDailyWin:flushOtherInfo()

local imgIdx=math.random(1,3)
self.weather:setSprite(abName,FMT.fmt('icon_zmrbtianqi_{0}',imgIdx))


local y,m,d=timeHelper.getServerData()
local index=(y-mouseYear+1)%12
self.shenxiaoText:setText(shenxiaoStr[index])
self.timeText:setText(FMT.fmt('{0}年{1}月{2}日',y,m,d))


local weekIdx=timeHelper.getWeakDateEx()
local weekStr=''
if weekIdx==0 then
weekStr='日'
else
if pfwindowslController:checkIsGameVersion_yuenan()then
weekStr=weekIdx+1
else
weekStr=mathHelper.numberToChinese(weekIdx)
end
end
self.weekText:setText(FMT.fmt('星期{0}',weekStr))
if pfwindowslController:checkIsGameVersion_yuenan()and weekIdx==0 then
self.weekText:setText("Chủ Nhật")
end


self.piaoChong:setChildUIModelShowTarget(2053,1,nil,eAnimationID.stand)
self:createPiaoChongBT()
end


function UIZongmenDailyWin:createPiaoChongBT()
self:removePiaoChongBT()
local initData={
dzWidget=self.winlua,
dzIndex=self.piaoChong:getID(),
UIstateId=1,
standPos=0,
outPos={1000,322},
}
local bt=behaviorManager:addBehaviorTree('bt_ui_piaochong',nil,true,initData)
self.piaoCBT=bt
end

function UIZongmenDailyWin:getNextPoint(bt,tkey)
local minPos={200,250}
local maxPos={480,322}

local x=math.random(minPos[1],maxPos[1])
local y=math.random(minPos[2],maxPos[2])
bt:setSharedVar(tkey,{x,y})
end

function UIZongmenDailyWin:removePiaoChongBT()
if self.piaoCBT then
behaviorManager:removeBehaviorTree(self.piaoCBT)
end
end


function UIZongmenDailyWin:flushReporterInfo()
local netData,posType=UIDailyPaperModel:getReporterDisciple()
if netData then
local guid=netData.discipleguid
local model=UIDiscipleModel:getDiscipleInsideModelInfo(guid)
self.reporterHead:setChildUIModelShowTarget(model.body,1.16,model.componets,0,false,true)

local title=''
if posType then
title=eZongMenPostType.getName(posType)
else
title='大弟子'
end
local name=UIDiscipleModel:getDiscipleName(guid)
self.reporterText:setText(FMT.fmt('{0}：{1}',title,name))
roleAudioController:playRoleSpeak(guid,roleAudioNodeType.ZongMenDiBao)
end


local stableData=homeBuffModel.getStableScaleData()
local stableStr=stableData[3]
self.zmStability:setText(FMT.fmt('{0}',stableStr))


local speakList=stableData[4]
self:flushSpeakStr(speakList)
self:refreshSpeakObj(speakList)

local showEvent=UIDailyPaperModel:getShowEvent()
local descStr=''
local showJump=showEvent~=nil
if showEvent then
descStr=showEvent.desc
if showEvent.showType==eDailyPaperShowEventType.eJiQuanBuNing then
showJump=false
end
end
self.descText:setText(descStr)
self.jumpBtn:setActive(showJump)
self.notEventInfo:setActive(showEvent==nil)
end

function UIZongmenDailyWin:flushSpeakStr(speakList)
local index=math.random(1,#speakList)
local speakStr=speakList[index]
self.txtSpeak:setText(speakStr)
end

function UIZongmenDailyWin:refreshSpeakObj(speakList)
self:killSpeakTween()
self.speakTween=self.speakObj:setChildCanvasGroupDOFade(0,1,function(...)
self:flushSpeakStr(speakList)
self:killSpeakTween()
self.speakTween=self.speakObj:setChildCanvasGroupDOFade(1,1,function(...)
self:refreshSpeakObj(speakList)
end)
self.speakTween:SetDelay(5)
end)
self.speakTween:SetDelay(2)
end

function UIZongmenDailyWin:killSpeakTween()
if self.speakTween then
self.speakTween:Kill(false)
self.speakTween=nil
end
end


function UIZongmenDailyWin:flushZMInfo()

local offlineTime=UIDailyPaperModel:getOfflineTime()
local gameYear=gameUtilityModel.calculateGameYearFloor(offlineTime)
local offlineTimeStr=''
if offlineTime>=3600 then
offlineTimeStr=timeHelper.format_time_stamp3(offlineTime)
else
offlineTimeStr=timeHelper.format_time_stamp7(offlineTime)
end
self.zmTime:setText(FMT.fmt('{0}年（{1}）',gameYear,offlineTimeStr))

local stateList=homeBuffModel.getEffectList()
local list={}
for i,v in ipairs(stateList)do
local id=v[1]
if not zongmenBuildingSuitModel:isSuitBuff(id)then
table.insert(list,v)
end
end
self.zmStateScrollerView:setChildScrollViewCreateGrids(#list,4)
self.grids=self.zmStateScrollerView:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=list[i]
local id=data[1]
local guildstateconfig=cfg_guildstateconfig_get(id)
local iconname=iconHelper.getzmStateIcon(guildstateconfig.icon)
item:SetChildCSImageIcon(0,iconname,false)
item:SetChildButtonClick(0,function(...)
local args={}
args.posWidget=item
local desclist={}
local effects=guildstateconfig.effects
for i,v in ipairs(effects)do
local effectid=effects[i]
table.insert(desclist,homeBuffModel:getBuffDesc(effectid))
end
local name=FMT.fmt('<color=#D0BB8F>{0}</color>',guildstateconfig.name)
args.title=name
args.desclist=desclist
args.offsetY=item:GetCommonComponent(-1,'RectTransform').sizeDelta.y/2
args.pivot=Vector2(0.5,0)
args.alignment=3
UIManager:showWindow('UIDescribeTips2',args)
end)
end

local moneyType=eMoneyType.mtLingShi
local moneyName=moneyModel.getMoneyName(moneyType)
local iconName=iconHelper.getIconName(moneyType)
local moneyCount=UIDailyPaperModel:checkMoneyChange(moneyType)
self.moneyIcon:setImageIcon(iconName,false)
local moneyStr=moneyCount
if moneyCount>=0 then
moneyStr=FMT.fmt('+{0}',moneyCount)
else
moneyStr=FMT.fmt('<color=#E33021FF>{0}</color>',moneyCount)
end
self.moneyCnt:setText(FMT.fmt('{0}{1}',moneyName,moneyStr))
end


function UIZongmenDailyWin:initDropdown()
local sxConfig=cfg_zongmendailypaperconfig()
local option={'所有'}
for i=1,#sxConfig do
local sxType=sxConfig[i]
option[#option+1]=sxType.typename
end
self.dropDownIdx=0
self.selectDropdown:setOption(option)
self.selectDropdown:setValue(self.dropDownIdx)
end


function UIZongmenDailyWin:onClickSXTypeDropdown(idx)
self.dropDownIdx=idx
self.Content:setChildLayoutGroupCreateItems(0)
self:flushDiscpilesInfo()
end

function UIZongmenDailyWin:getTextList(data)
local infoType=data.recordtype
local textList
if infoType==eZMDailyPaperType.eProSkill then
local idxList=UIDailyPaperModel:getConfigServerText(changeType[infoType])
local proskillId=data.param_2
for i,v in ipairs(idxList)do
if v[1]==proskillId then
textList=v[2]
break
end
end
else
textList=UIDailyPaperModel:getConfigServerText(changeType[infoType])
if data.client then
textList=UIDailyPaperModel:getConfigClientText(changeType[infoType])
end
end
return textList
end


function UIZongmenDailyWin:flushDiscpilesInfo()
local datas=UIDailyPaperModel:getDzInfoData(self.dropDownIdx)
local num=#datas
self.notDzInfo:setActive(num==0)
if num>0 then
self.Content:setChildLayoutGroupCreateItems(num,function(index)
local item=self.Content:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
item:SetChildActive(0,true)
local textList=self:getTextList(data)
if textList then
local rand=math.random(1,#textList)
local selectList=textList[rand]
local formatStr=selectList[1]
local jumpStr=selectList[2]
local jumpParams=selectList[3]

local params=UIDailyPaperModel:dealDataParams(data)
local str=FMT.fmt(formatStr,unpack(params))
item:SetChildText(1,str)

item:SetChildActive(2,jumpStr~=nil)
if jumpStr then
item:SetChildButtonClick(3,function(...)
self:jumpTo(data,jumpParams)
end)
item:SetChildText(4,jumpStr)
end
else
logErr('宗门日报弟子信息未配置文本：{0}类型',cfgHelper.get2(cfg_zongmendailypaperconfig_get,changeType[infoType],'name'))
end
end)
end
end

function UIZongmenDailyWin:jumpTo(data,jumpParams)
local infoType=data.recordtype
local disguid=data.param_1
if infoType==eZMDailyPaperType.eJingJie then
self:jumpTOJingJieBreak(disguid)
elseif infoType==eZMDailyPaperType.eChuiWeiInjury or infoType==eZMDailyPaperType.eChuiWeiShouYuan then
UIFullDiscipleMainControl:showWindowInfo({dis_guid=disguid})
UIManager:showWindow('UIDiscipleChuiweiWin',{guid=disguid})
elseif jumpParams then
local args=jumpParams.args
args.disguid=disguid
jumpManager:jump(jumpParams)
end
self:closeSelf()
end


function UIZongmenDailyWin:jumpTOJingJieBreak(disguid)
local show_broke=UIDailyPaperModel:checkShowBroke(disguid)
if not show_broke then return end

local jjlv=UIDiscipleModel:getDiscipleJJLevel(disguid)
if not UIDiscipleModel:checkJJAutoBrokeConditon3(jjlv,true)then
return
end

if UIDiscipleModel:checkJJAutoBrokeConditon(jjlv)then

local args={guid=disguid}
local goFunc=function()
UIFullCommonControl:showDuJieWindowEx(args)
end
UIFullCommonControl:showDuJieWindow(goFunc,args,disguid)
else

local isOverMaxFeiShengLv=UIDiscipleModel:checkJJIsOverMaxFeiShengLv(jjlv)
local isJumpFeiShengTai=not isOverMaxFeiShengLv
if isJumpFeiShengTai then

local buildID=SLG_SYSTEM_TYPE.eFeiShengTai2
if not zongmenModel:haveBuildByBuildId(buildID)then
return
end
local buildType=cfgHelper.get2(cfg_monijybuildconfig_get,buildID,'build_type')
local jumpParam={type=0,id=1001,args={type=buildType}}
jumpManager:jump(jumpParam)
else
local isHasAfterTXCost=UIDiscipleModel:checkJJIsHasAfterTXCost(jjlv)
if not isHasAfterTXCost then

UIManager.error("暂未开启")
return
end
local args={guid=disguid}
local goFunc=function()
UIFullCommonControl:showDuJieWindowEx_AfterTianXian(args)
end
UIFullCommonControl:showDuJieWindow(goFunc,args,disguid,true)
end
end
end



function UIZongmenDailyWin:onDetailBtn()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.dailyPaperShangpu)
end

function UIZongmenDailyWin:onTipsBtn()
local d={}
d.title='提示'
d.mode=3
d.name='zmdailypaper_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIZongmenDailyWin:onClickClose()
self:closeSelf()
end

function UIZongmenDailyWin:onClickPiaoChong()
local bt=self.piaoCBT
if bt then
bt:setSharedVar('UIstateId',2)
bt:broke()
bt:reset()
end
end

function UIZongmenDailyWin:onJumpBtn()
local showEvent=UIDailyPaperModel:getShowEvent()
if showEvent then
local showType=showEvent.showType
if showType==eDailyPaperShowEventType.eDiscipleBaiShan then
local bdType=shanmenModel.getBaiShanConfigField('buildid')
local smData=zongmenModel:findBuildingDataByType(zongmenModel:getMountainId(),bdType)
if smData then
isometricMapSystem:moveCameraToObject(smData.entityId,false,nil)
end
elseif showType==eDailyPaperShowEventType.eZongmenOptionEvent then
UIManager:invokeUIMethod('UIFuncStorageWin','onShiWuBtn')
elseif showType==eDailyPaperShowEventType.eBuildingOnFire or
showType==eDailyPaperShowEventType.eMonsterInvasion then
local hasHandle=emergenciesModel:hasHandleData()
local updateEvent=emergenciesModel:isInEventTime()
if not hasHandle and updateEvent then
emergenciesControl:moveCameraToEventPos()
else
UIManager.info('事件已结束')
end
end
end
self:closeSelf()
end