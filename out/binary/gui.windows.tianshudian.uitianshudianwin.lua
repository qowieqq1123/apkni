







def_class("UITianShuDianWin",UIWindowBase)









function UITianShuDianWin:bindComponents()

self.bdLevel=UIText.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.chuzhenCount=UIObject.get(self,2)
self.chuzhenCountTxt=UIText.get(self,3)
self.chuzhengInfo=UIText.get(self,4)
self.closeTipsBtn=UIButton.get(self,5)
self.detailsPart=UIObject.get(self,6)
self.detialsBtn=UIButton.get(self,7)
self.dzAI=UIObject.get(self,8)
self.dzAIContent=UIObject.get(self,9)
self.dzAiItem_1=UIObject.get(self,10)
self.dzAiItem_2=UIObject.get(self,11)
self.dzAiItem_3=UIObject.get(self,12)
self.dzAiItem_4=UIObject.get(self,13)
self.dzAiItem_5=UIObject.get(self,14)
self.dzAiItem_6=UIObject.get(self,15)
self.dzAiItem_7=UIObject.get(self,16)
self.goZhaoHunBtn=UIButton.get(self,17)
self.goZhiLiaoBtn=UIButton.get(self,18)
self.groupModel=UIObject.get(self,19)
self.jijieInfo=UIText.get(self,20)
self.levelUpBtn=UIButton.get(self,21)
self.levelUpBtnText=UIText.get(self,22)
self.Root=UIObject.get(self,23)
self.ruleBtn=UIButton.get(self,24)
self.ruleList=UIObject.get(self,25)
self.rulePart=UIObject.get(self,26)
self.totalCount=UIObject.get(self,27)
self.totalCountTxt=UIText.get(self,28)
self.uiRoot=UIObject.get(self,29)
self.upLevelReddot=UIObject.get(self,30)
self.xianlingInfo=UILinkImageText.get(self,31)
self.xsCountList=UIObject.get(self,32)
self.xsDetailScrollView=UIObject.get(self,33)
self.zhaohunCount=UIObject.get(self,34)
self.zhaohunCountTxt=UIText.get(self,35)
self.zhiliaoCount=UIObject.get(self,36)
self.zhiliaoCountTxt=UIText.get(self,37)

self.closeTipsBtn:setButtonClick(function()self:onCloseTipsBtn()end)

self.detialsBtn:setButtonClick(function()self:onDetialsBtn()end)

self.goZhaoHunBtn:setButtonClick(function()self:onGoZhaoHunBtn()end)

self.goZhiLiaoBtn:setButtonClick(function()self:onGoZhiLiaoBtn()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)
self.dzAiItem={
self.dzAiItem_1,
self.dzAiItem_2,
self.dzAiItem_3,
self.dzAiItem_4,
self.dzAiItem_5,
self.dzAiItem_6,
self.dzAiItem_7,
}



end


function UITianShuDianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.chuzhenCount);self.chuzhenCount=nil;
_UIObject_release(self.chuzhenCountTxt);self.chuzhenCountTxt=nil;
_UIObject_release(self.chuzhengInfo);self.chuzhengInfo=nil;
_UIObject_release(self.closeTipsBtn);self.closeTipsBtn=nil;
_UIObject_release(self.detailsPart);self.detailsPart=nil;
_UIObject_release(self.detialsBtn);self.detialsBtn=nil;
_UIObject_release(self.dzAI);self.dzAI=nil;
_UIObject_release(self.dzAIContent);self.dzAIContent=nil;
_UIObject_release(self.dzAiItem_1);self.dzAiItem_1=nil;
_UIObject_release(self.dzAiItem_2);self.dzAiItem_2=nil;
_UIObject_release(self.dzAiItem_3);self.dzAiItem_3=nil;
_UIObject_release(self.dzAiItem_4);self.dzAiItem_4=nil;
_UIObject_release(self.dzAiItem_5);self.dzAiItem_5=nil;
_UIObject_release(self.dzAiItem_6);self.dzAiItem_6=nil;
_UIObject_release(self.dzAiItem_7);self.dzAiItem_7=nil;
_UIObject_release(self.goZhaoHunBtn);self.goZhaoHunBtn=nil;
_UIObject_release(self.goZhiLiaoBtn);self.goZhiLiaoBtn=nil;
_UIObject_release(self.groupModel);self.groupModel=nil;
_UIObject_release(self.jijieInfo);self.jijieInfo=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.ruleList);self.ruleList=nil;
_UIObject_release(self.rulePart);self.rulePart=nil;
_UIObject_release(self.totalCount);self.totalCount=nil;
_UIObject_release(self.totalCountTxt);self.totalCountTxt=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.upLevelReddot);self.upLevelReddot=nil;
_UIObject_release(self.xianlingInfo);self.xianlingInfo=nil;
_UIObject_release(self.xsCountList);self.xsCountList=nil;
_UIObject_release(self.xsDetailScrollView);self.xsDetailScrollView=nil;
_UIObject_release(self.zhaohunCount);self.zhaohunCount=nil;
_UIObject_release(self.zhaohunCountTxt);self.zhaohunCountTxt=nil;
_UIObject_release(self.zhiliaoCount);self.zhiliaoCount=nil;
_UIObject_release(self.zhiliaoCountTxt);self.zhiliaoCountTxt=nil;
self.dzAiItem=nil;
end
















local _this

local CmpSoldierItemIndex={
name=0,
jdtDi=1,
jdt=2,
count=3,
}






function UITianShuDianWin:onLoaded(...)

_this=self

self.tipsIndex=1


self:bindComponents()
end


function UITianShuDianWin:__delete()

self:stopPlayDzAITimer()
self:clearDzAiDtList()

_this=nil

self:unbindComponents()
end




function UITianShuDianWin:onShow(argtable,afterOnloaded)
if argtable then
local guid=argtable.entityId
self.entityId=guid
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end

if afterOnloaded then
self:initFresh()
end

self:refreshAll()

self:refreshRulePart()
end


function UITianShuDianWin:onHide()

end



function UITianShuDianWin:initFresh()
self.detailsPart:setActive(false)

UIManager:callWindowFunc('UIXianJieBottomMaskWin','showModel',6013)

self:startPlayDzAI()
end

function UITianShuDianWin:refreshAll()

self:refreshInfoPart()

end

function UITianShuDianWin:refreshInfoPart()

local bdLevel=self.bdData.level
self.bdLevel:setText(FMT.fmt("{0}级天枢殿",bdLevel))

self.upLevelReddot:setActive(tianShuDianController:checkCanLevelUp())

local tsdLevelCfg=cfgHelper.get1(cfg_tianshudianconfig_get,bdLevel)
local tsdNextLevelCfg=cfgHelper.get1(cfg_tianshudianconfig_get,bdLevel+1)

local isFullLevel=tsdNextLevelCfg==nil
self.levelUpBtnText:setText(isFullLevel and"满级"or"升级")

local jijieContentFmt="仙令存储上限：{0}{1}"
local xl_money_id=eMoneyType.mtXianLing
local iconName=iconHelper.getIconName(xl_money_id)
local iconStr=chatEmotHelper.getIconEmotMesg(iconName,32)
self.xianlingInfo:setText(FMT.fmt(jijieContentFmt,iconStr,mathHelper.formatNumber4(tsdLevelCfg.auto_max_cnt[eMoneyType.mtXianLing],1)))

local jijieContentFmt="集结修士上限：{0}"
self.jijieInfo:setText(FMT.fmt(jijieContentFmt,tsdLevelCfg.jjxs_max_cnt))

local chuzhengContentFmt="弟子携带修士上限：{0}"
self.chuzhengInfo:setText(FMT.fmt(chuzhengContentFmt,tsdLevelCfg.czxs_max_cnt))


local totalXsCountContent="总修士数量：{0}"
local totalXsCount=xianjieModel:getTotalSoldierCount()
self.totalCountTxt:setText(FMT.fmt(totalXsCountContent,totalXsCount))

local chuzhengCountContent="可出征修士：{0}"
local chuzhenCount=xianjieModel:getSoldierAllHurtNum(xjSoldierHurtType.eHealthy)
self.chuzhenCountTxt:setText(FMT.fmt(chuzhengCountContent,chuzhenCount))

local totalTreatCountContent="在治疗修士：{0}"
local totalTreatCount=xianjieModel:getSoldierAllHurtNum(xjSoldierHurtType.eSeriousInjury)
self.zhiliaoCountTxt:setText(FMT.fmt(totalTreatCountContent,totalTreatCount))

local totalZhaoHunCountContent="可招魂修士：{0}"
local totalZhaoHunCount=LunHuiDianModel:getLeastCanRecruit()
self.zhaohunCountTxt:setText(FMT.fmt(totalZhaoHunCountContent,totalZhaoHunCount))


end

function UITianShuDianWin:refreshDetailsPart()
local list=xianjieModel:getTotalSoldierList()

local len=#list

local maxCount=list[1].totalCount
for index=2,len do
if list[index].totalCount>maxCount then
maxCount=list[index].totalCount
end
end

self.xsCountList:setChildLayoutGroupCreateItems(len,function(index)
if _this==nil then return end
local item=_this.xsCountList:getChildLayoutGroupGridItem(index-1)
local data=list[index]

local name=cfgHelper.get2(cfg_fairylandsoldierconfig_get,index,'name')
item:SetChildText(CmpSoldierItemIndex.name,FMT.fmt("{0}修士:",name))

local rate=data.totalCount/maxCount
item:SetChildIconFillAmount(CmpSoldierItemIndex.jdt,rate)

item:SetChildText(CmpSoldierItemIndex.count,mathHelper.formatNumber4(data.totalCount,1))
end)
end

function UITianShuDianWin:refreshRulePart()
local desclist={}
local name="tianshudian_rule_%d"
for i=1,10 do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(desclist,str)
end
end

local descLen=#desclist

self.ruleList:setChildLayoutGroupCreateItems(descLen,function(index)
local item=self.ruleList:getChildLayoutGroupGridItem(index-1)

local desc=desclist[index]

item:SetChildText(0,desc)
end)
end






function UITianShuDianWin:onDetialsBtn()
self.tipsIndex=1
self:refreshDetailsPart()
self.detailsPart:setActive(true)
self.closeTipsBtn:setActive(true)
end



function UITianShuDianWin:onGoZhaoHunBtn()
local buildDataList=zongmenModel:getAllBuildingDataByBdId(mapIdType.fort,SLG_SYSTEM_TYPE.eLunHuiDian)or{}
local bdData=buildDataList[1]
if bdData then
isometricMapSystem:openBuildingWin(bdData)
else
local c=cfgHelper.get1(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eLunHuiDian)
local rdata=isometricMapSystem:getUnlockRepairDataByID(zongmenModel:getMountainId(),c.id)
if rdata then
isometricMapSystem:moveCameraToObject(rdata.guid,false,nil)
UIManager:showWindow('UIRepairWin',rdata)
else
isometricMapSystem:enterLayoutModel({model=layoutMode.eBuild,sortType=c.buildTab,bdId=c.id,isBuild=true})
end
end
end



function UITianShuDianWin:onGoZhiLiaoBtn()
local buildDataList=zongmenModel:getAllBuildingDataByBdId(mapIdType.fort,SLG_SYSTEM_TYPE.eYuLingZhai)or{}
local bdData=buildDataList[1]
if bdData then
isometricMapSystem:openBuildingWin(bdData)
else
local c=cfgHelper.get1(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eYuLingZhai)
local rdata=isometricMapSystem:getUnlockRepairDataByID(zongmenModel:getMountainId(),c.id)
if rdata then
isometricMapSystem:moveCameraToObject(rdata.guid,false,nil)
UIManager:showWindow('UIRepairWin',rdata)
else
isometricMapSystem:enterLayoutModel({model=layoutMode.eBuild,sortType=c.buildTab,bdId=c.id,isBuild=true})
end
end
end



function UITianShuDianWin:onLevelUpBtn()
if self.bdData then
if buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)then
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
else
UIManager:showWindow('UIXJTianShuDianBuildingInfoWin',self.bdData)
end
end
end



function UITianShuDianWin:onRuleBtn()
self.tipsIndex=2
self.rulePart:setActive(true)
self.closeTipsBtn:setActive(true)
end

function UITianShuDianWin:onCloseTipsBtn()
if self.tipsIndex==1 then
self.detailsPart:setActive(false)
elseif self.tipsIndex==2 then
self.rulePart:setActive(false)
end
self.closeTipsBtn:setActive(false)
end




local _doAlphaStartTime=1
local _doAlphaEndTime=1

local _moveStartPos={-270,270}
local _modeMoveDVal=_moveStartPos[2]-_moveStartPos[1]
local _dzPosY={-250,-150}

local _speakDuration=3

local _aiBtIntervalRange={2,4}

local _dzScale=0.65

local _maxDz=10

local _moveDurationRange={7,10}

local _speakRateRange={1,10,5}

local _sameSideLimitNum=2

local _accompanyPosOffsetY=10
local _accompanyPosAbsOffsetX=30


local _accompanyRange={1,10,8}

local _waitSpeakModeRange={1,10,8}
local _waitPosList={-50,0,50}
local _waitTimeRange={2,4}

local _modeEnum={
toEnd=1,
waitSpeakToEnd=2,
}

function UITianShuDianWin:startPlayDzAI()

self:stopPlayDzAITimer()
self:clearDzAiDtList()

self.dzAiItemList={}
self.dzAiItemIdleList={}
self.dzAiBusyGuidList={}
self.dzAiSpeakContentList={}
self.dzAiDtList={}
self.waitPosList=table.weakCopy(_waitPosList)
self.dzPosYList={}

for val=_dzPosY[1],_dzPosY[2],20 do
self.dzPosYList[#self.dzPosYList+1]=val
end

self.leftSideDzNum=0
self.rightSideDzNum=0

local baseCfg=cfg_tianshudianbaseconfig_get(1)
self.dzAiSpeakContentList=table.weakCopy(baseCfg.speakContentList)

self.dzAIContent:setChildLayoutGroupClearAllItems()
self.dzAIContent:setChildLayoutGroupCreateItems(_maxDz,function(index)
local item=self.dzAIContent:getChildLayoutGroupGridItem(index-1)
self.dzAiItemIdleList[#self.dzAiItemIdleList+1]=item
self.dzAiItemList[#self.dzAiItemList+1]=item

item:SetChildActive(-1,false)
item:SetChildCanvasGroupAlpha(-1,0)
end)

local createInterval=1
local curTime=timeHelper.getServerShortTime()
local oldTime=curTime
local checkAccompany
local animInfo,otherAnimInfo

local callback=function()
curTime=timeHelper.getServerShortTime()
if curTime-oldTime>=createInterval then
oldTime=curTime
createInterval=math.random(_aiBtIntervalRange[1],_aiBtIntervalRange[2])
animInfo=_this:getAnimInfo()
if animInfo==nil then return end
_this:createAIDZ(animInfo)

checkAccompany=math.random(_accompanyRange[1],_accompanyRange[2])>=_accompanyRange[3]
if not checkAccompany then return end
otherAnimInfo=_this:getAccompanyAnimInfo(animInfo)
if otherAnimInfo==nil then return end
_this:createAIDZ(otherAnimInfo)


otherAnimInfo=nil
end
end
self.dzAiTimer=self:setTimer(0.1,0,callback)
end

function UITianShuDianWin:stopPlayDzAITimer()
if self.dzAiTimer then
self:stopTimerByID(self.dzAiTimer)
self.dzAiTimer=nil
end
end


function UITianShuDianWin:getAnimInfo()
local idleItemLen=#self.dzAiItemIdleList
if idleItemLen<=0 then return end
local posYLen=#self.dzPosYList
if posYLen<=0 then return end

local selectFunc=function(data)
return not table.findValue(self.dzAiBusyGuidList,data.discipleguidStr)
end

local aiDzList=UIDiscipleModel:getSortList(selectFunc)
local selectRandomIndex=math.random(1,#aiDzList)
local dzData=aiDzList[selectRandomIndex]
table.insert(self.dzAiBusyGuidList,dzData.discipleguidStr)

local item=table.remove(self.dzAiItemIdleList,idleItemLen)

local animInfo={}

local isLeft=math.random(1,3)>=2
if isLeft then
if self.leftSideDzNum>_sameSideLimitNum then
if self.rightSideDzNum<_sameSideLimitNum then
isLeft=not isLeft
self.leftSideDzNum=self.leftSideDzNum-1
end
end
else
if self.rightSideDzNum>_sameSideLimitNum then
if self.leftSideDzNum<_sameSideLimitNum then
isLeft=not isLeft
self.rightSideDzNum=self.rightSideDzNum-1
end
end
end
if isLeft then
self.leftSideDzNum=self.leftSideDzNum+1
else
self.rightSideDzNum=self.rightSideDzNum+1
end

animInfo.isLeft=isLeft
animInfo.oprateItem=item
animInfo.oprateDzData=dzData
animInfo.startPos=animInfo.isLeft and _moveStartPos[1]or _moveStartPos[2]
animInfo.endPos=animInfo.isLeft and _moveStartPos[2]or _moveStartPos[1]

animInfo.moveTime=math.random(_moveDurationRange[1],_moveDurationRange[2])
animInfo.isSpeak=math.random(_speakRateRange[1],_speakRateRange[2])>=_speakRateRange[3]and#self.dzAiSpeakContentList>0
animInfo.isWaitSpeak=false
animInfo.speakDuration=_speakDuration

animInfo.mode=_modeEnum.toEnd

local randPosYIndex=math.random(1,#self.dzPosYList)
animInfo.posY=table.remove(self.dzPosYList,randPosYIndex)

local speakContentLen=#self.dzAiSpeakContentList
local waitPosLen=#self.waitPosList

if speakContentLen>0 and waitPosLen>0 then
animInfo.mode=math.random(_waitSpeakModeRange[1],_waitSpeakModeRange[2])>=_waitSpeakModeRange[3]and _modeEnum.waitSpeakToEnd or _modeEnum.toEnd
if animInfo.mode==_modeEnum.waitSpeakToEnd then
animInfo.isSpeak=#self.dzAiSpeakContentList>0
animInfo.waitTime=math.random(_waitTimeRange[1],_waitTimeRange[2])
animInfo.speakDuration=animInfo.waitTime

local waitPosIndex=math.random(1,waitPosLen)
animInfo.waitPos=table.remove(self.waitPosList,waitPosIndex)

animInfo.moveTime1=((animInfo.waitPos-_moveStartPos[1])/_modeMoveDVal)*animInfo.moveTime
animInfo.moveTime1=Mathf.Floor(animInfo.moveTime1*10)/10
animInfo.moveTime2=animInfo.moveTime-animInfo.moveTime1
end
end


return animInfo
end

function UITianShuDianWin:getAccompanyAnimInfo(animInfo)
local idleItemLen=#self.dzAiItemIdleList
if idleItemLen<=0 then return end

local selectFunc=function(data)
return not table.findValue(self.dzAiBusyGuidList,data.discipleguidStr)
end
local aiDzList=UIDiscipleModel:getSortList(selectFunc)
local selectRandomIndex=math.random(1,#aiDzList)
local dzData=aiDzList[selectRandomIndex]
table.insert(self.dzAiBusyGuidList,dzData.discipleguidStr)
local item=table.remove(self.dzAiItemIdleList,idleItemLen)

local otherAnimInfo=table.weakCopy(animInfo)

local offsetPosX=otherAnimInfo.isLeft and _accompanyPosAbsOffsetX or-_accompanyPosAbsOffsetX

otherAnimInfo.oprateItem=item
otherAnimInfo.oprateDzData=dzData
otherAnimInfo.posY=otherAnimInfo.posY+_accompanyPosOffsetY
otherAnimInfo.startPos=otherAnimInfo.startPos+offsetPosX
otherAnimInfo.endPos=otherAnimInfo.endPos+offsetPosX
otherAnimInfo.isSpeak=false

if otherAnimInfo.mode==_modeEnum.waitSpeakToEnd then
otherAnimInfo.waitPos=otherAnimInfo.waitPos+offsetPosX



end

return otherAnimInfo
end

function UITianShuDianWin:createAIDZ(animInfo)

local item=animInfo.oprateItem

item:SetChildAnchoredPos(-1,animInfo.startPos,animInfo.posY)
local dzData=animInfo.oprateDzData
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzData.discipleguid)
item:SetChildUIModelShowTarget(0,modelParams.body,_dzScale,modelParams.componets,eAnimationID.walk,false,false,0.2)
item:SetChildUIModelShowFlipX(0,animInfo.isLeft)
item:SetChildActive(-1,true)

if animInfo.isSpeak then
local randomSpeakIndex=math.random(1,#self.dzAiSpeakContentList)
animInfo.speakContent=table.remove(self.dzAiSpeakContentList,randomSpeakIndex)

end
item:SetChildCanvasGroupDOFade(-1,1,_doAlphaStartTime,function()
if _this==nil then return end
if animInfo.isSpeak then
if animInfo.mode==_modeEnum.toEnd then
_this:dzSpeak(item,animInfo)
end
end
end)

self:sortDzLayer()

if animInfo.mode==_modeEnum.toEnd then
self:moveToEnd(animInfo)
elseif animInfo.mode==_modeEnum.waitSpeakToEnd then
self:moveWaitToEnd(animInfo)
end
end

function UITianShuDianWin:dzSpeak(item,animInfo)
local contentIndex=animInfo.isLeft and 2 or 4
local itemIndex=animInfo.isLeft and 1 or 3

item:SetChildText(contentIndex,animInfo.speakContent)
item:SetChildActive(itemIndex,true)

self:delayDo(animInfo.speakDuration,function()
item:SetChildActive(itemIndex,false)
end)
end

function UITianShuDianWin:moveToEnd(animInfo)

local key=animInfo.oprateDzData.discipleguidStr
if self.dzAiDtList[key]then
self.dzAiDtList[key]:Complete()
self.dzAiDtList[key]:Kill()
end

local item=animInfo.oprateItem

local moveCompleteCallBack=function()
_this:endOption(animInfo)
end

local endPos=animInfo.endPos
self.dzAiDtList[key]=item:SetChildDOAnchorPosX(-1,endPos,animInfo.moveTime,moveCompleteCallBack)
self.dzAiDtList[key]:SetEase(DG.Tweening.Ease.Linear)

if animInfo.isSpeak then
self:delayDo(animInfo.moveTime-_doAlphaEndTime,function()
item:SetChildCanvasGroupDOFade(-1,0,_doAlphaEndTime)
end)
end
end

function UITianShuDianWin:moveWaitToEnd(animInfo)

local key=animInfo.oprateDzData.discipleguidStr
local item=animInfo.oprateItem

if self.dzAiDtList[key]then
self.dzAiDtList[key]:Complete()
self.dzAiDtList[key]:Kill()
end

local waitCompleteCallBack=function()
item:SetChildModelAnimationState(0,eAnimationID.stand,1,nil)
if animInfo.isSpeak then
_this:dzSpeak(item,animInfo)
end
end

local waitPos=animInfo.waitPos
self.dzAiDtList[key]=item:SetChildDOAnchorPosX(-1,waitPos,animInfo.moveTime1,waitCompleteCallBack)
self.dzAiDtList[key]:SetEase(DG.Tweening.Ease.Linear)

local moveCompleteCallBack=function()
_this:endOption(animInfo)
end

local toEndStartTime=animInfo.moveTime1+animInfo.waitTime
self:delayDo(toEndStartTime,function()
item:SetChildModelAnimationState(0,eAnimationID.walk,1,nil)
local endPos=animInfo.endPos
_this.dzAiDtList[key]=item:SetChildDOAnchorPosX(-1,endPos,animInfo.moveTime2,moveCompleteCallBack)
_this.dzAiDtList[key]:SetEase(DG.Tweening.Ease.Linear)
end)

if animInfo.isSpeak then
self:delayDo(animInfo.moveTime-_doAlphaEndTime+animInfo.waitTime,function()
item:SetChildCanvasGroupDOFade(-1,0,_doAlphaEndTime)
end)
end
end

function UITianShuDianWin:endOption(animInfo)
local key=animInfo.oprateDzData.discipleguidStr
local item=animInfo.oprateItem

item:SetChildActive(-1,false)
table.insert(_this.dzAiItemIdleList,item)
local dzIndex=table.findValue(_this.dzAiBusyGuidList,key)
table.remove(_this.dzAiBusyGuidList,dzIndex)
table.insert(_this.dzAiSpeakContentList,animInfo.speakContent)

if animInfo.isLeft then
self.leftSideDzNum=self.leftSideDzNum-1
else
self.rightSideDzNum=self.rightSideDzNum-1
end

if animInfo.mode==_modeEnum.waitSpeakToEnd then
table.insert(self.waitPosList,animInfo.waitPos)
end

table.insert(self.dzPosYList,animInfo.posY)
end


function UITianShuDianWin:clearDzAiDtList()
if self.dzAiDtList then
for index,dt in pairs(self.dzAiDtList)do
dt:Complete()
dt:Kill()
end
self.dzAiDtList={}
end
end

function UITianShuDianWin:sortDzLayer()
table.sort(self.dzAiItemList,function(itemA,itemB)
local aPosY=itemA:GetChildAnchoredPosition(-1).y
local bPosY=itemB:GetChildAnchoredPosition(-1).y
return aPosY>bPosY
end)

for index,item in ipairs(self.dzAiItemList)do
local trans=item:GetChildGameObject(-1).transform
trans:SetSiblingIndex(index-1)
end
end