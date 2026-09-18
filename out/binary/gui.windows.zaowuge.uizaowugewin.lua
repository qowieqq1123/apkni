







def_class("UIZaoWuGeWin",UIWindowBase)









function UIZaoWuGeWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.baoxiang=UIObject.get(self,1)
self.bgSpine=UIObject.get(self,2)
self.btnSelectReddot=UIObject.get(self,3)
self.buildClickButton=UIButton.get(self,4)
self.buildCostList=UIObject.get(self,5)
self.buildCostPart=UIObject.get(self,6)
self.buildCostScrollView=UIObject.get(self,7)
self.buildCount=UIText.get(self,8)
self.buildCountRoot=UIObject.get(self,9)
self.buildInfoTxt=UIText.get(self,10)
self.buildingTip=UIText.get(self,11)
self.buildItem=UIImage.get(self,12)
self.buildpart=UIObject.get(self,13)
self.buildProgress=UIObject.get(self,14)
self.buildProgressBar=UIObject.get(self,15)
self.buildRateTipsBack=UIObject.get(self,16)
self.buildRateTipsList=UIObject.get(self,17)
self.buildRateTipsRoot=UIObject.get(self,18)
self.buildRateTipsScrollView=UIObject.get(self,19)
self.buildTip=UIText.get(self,20)
self.cancelClickButton=UIButton.get(self,21)
self.changeDzClickButton=UIButton.get(self,22)
self.changeImg=UIObject.get(self,23)
self.djsTxt=UIText.get(self,24)
self.dzInfo=UIText.get(self,25)
self.dzModel=UIObject.get(self,26)
self.dzRuleClickButton=UIButton.get(self,27)
self.dzTipsBack=UIObject.get(self,28)
self.dzTipsList=UIObject.get(self,29)
self.dzTipsRoot=UIObject.get(self,30)
self.dzZFLV=UIText.get(self,31)
self.dzZQLV=UIText.get(self,32)
self.emptyAddImg=UIObject.get(self,33)
self.emptySuitImg=UIObject.get(self,34)
self.finishClickButton=UIButton.get(self,35)
self.handleImg=UIObject.get(self,36)
self.handleImg2=UIObject.get(self,37)
self.infoList=UIObject.get(self,38)
self.leftPart=UIObject.get(self,39)
self.leftTop=UIObject.get(self,40)
self.maxText=UIText.get(self,41)
self.noDzTip=UIText.get(self,42)
self.preBuildTimeTxt=UIText.get(self,43)
self.pzInfo_1=UIObject.get(self,44)
self.pzInfo_2=UIObject.get(self,45)
self.pzInfo_3=UIObject.get(self,46)
self.pzRuleClickButton=UIButton.get(self,47)
self.rateList=UIObject.get(self,48)
self.receiveBuildButton=UIButton.get(self,49)
self.rightPart=UIObject.get(self,50)
self.Root=UIObject.get(self,51)
self.saveBuildCountBg=UIObject.get(self,52)
self.saveBuildCountTxt=UIText.get(self,53)
self.saveBuildReddot=UIObject.get(self,54)
self.scrollView2=UIObject.get(self,55)
self.selectCntSlider=UIObject.get(self,56)
self.selectCntTxt=UIText.get(self,57)
self.selectDzClickButton=UIButton.get(self,58)
self.sliderRect=UIObject.get(self,59)
self.sliderRoot=UIObject.get(self,60)
self.startClickButton=UIButton.get(self,61)
self.subBtn=UIButton.get(self,62)
self.timeImg=UIObject.get(self,63)
self.uiRoot=UIObject.get(self,64)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.buildClickButton:setButtonClick(function()self:onBuildClickButton()end)

self.cancelClickButton:setButtonClick(function()self:onCancelClickButton()end)

self.changeDzClickButton:setButtonClick(function()self:onChangeDzClickButton()end)

self.dzRuleClickButton:setButtonClick(function()self:onDzRuleClickButton()end)

self.finishClickButton:setButtonClick(function()self:onFinishClickButton()end)

self.pzRuleClickButton:setButtonClick(function()self:onPzRuleClickButton()end)

self.receiveBuildButton:setButtonClick(function()self:onReceiveBuildButton()end)

self.selectDzClickButton:setButtonClick(function()self:onSelectDzClickButton()end)

self.startClickButton:setButtonClick(function()self:onStartClickButton()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)
self.pzInfo={
self.pzInfo_1,
self.pzInfo_2,
self.pzInfo_3,
}



end


function UIZaoWuGeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.baoxiang);self.baoxiang=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.btnSelectReddot);self.btnSelectReddot=nil;
_UIObject_release(self.buildClickButton);self.buildClickButton=nil;
_UIObject_release(self.buildCostList);self.buildCostList=nil;
_UIObject_release(self.buildCostPart);self.buildCostPart=nil;
_UIObject_release(self.buildCostScrollView);self.buildCostScrollView=nil;
_UIObject_release(self.buildCount);self.buildCount=nil;
_UIObject_release(self.buildCountRoot);self.buildCountRoot=nil;
_UIObject_release(self.buildInfoTxt);self.buildInfoTxt=nil;
_UIObject_release(self.buildingTip);self.buildingTip=nil;
_UIObject_release(self.buildItem);self.buildItem=nil;
_UIObject_release(self.buildpart);self.buildpart=nil;
_UIObject_release(self.buildProgress);self.buildProgress=nil;
_UIObject_release(self.buildProgressBar);self.buildProgressBar=nil;
_UIObject_release(self.buildRateTipsBack);self.buildRateTipsBack=nil;
_UIObject_release(self.buildRateTipsList);self.buildRateTipsList=nil;
_UIObject_release(self.buildRateTipsRoot);self.buildRateTipsRoot=nil;
_UIObject_release(self.buildRateTipsScrollView);self.buildRateTipsScrollView=nil;
_UIObject_release(self.buildTip);self.buildTip=nil;
_UIObject_release(self.cancelClickButton);self.cancelClickButton=nil;
_UIObject_release(self.changeDzClickButton);self.changeDzClickButton=nil;
_UIObject_release(self.changeImg);self.changeImg=nil;
_UIObject_release(self.djsTxt);self.djsTxt=nil;
_UIObject_release(self.dzInfo);self.dzInfo=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.dzRuleClickButton);self.dzRuleClickButton=nil;
_UIObject_release(self.dzTipsBack);self.dzTipsBack=nil;
_UIObject_release(self.dzTipsList);self.dzTipsList=nil;
_UIObject_release(self.dzTipsRoot);self.dzTipsRoot=nil;
_UIObject_release(self.dzZFLV);self.dzZFLV=nil;
_UIObject_release(self.dzZQLV);self.dzZQLV=nil;
_UIObject_release(self.emptyAddImg);self.emptyAddImg=nil;
_UIObject_release(self.emptySuitImg);self.emptySuitImg=nil;
_UIObject_release(self.finishClickButton);self.finishClickButton=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.handleImg2);self.handleImg2=nil;
_UIObject_release(self.infoList);self.infoList=nil;
_UIObject_release(self.leftPart);self.leftPart=nil;
_UIObject_release(self.leftTop);self.leftTop=nil;
_UIObject_release(self.maxText);self.maxText=nil;
_UIObject_release(self.noDzTip);self.noDzTip=nil;
_UIObject_release(self.preBuildTimeTxt);self.preBuildTimeTxt=nil;
_UIObject_release(self.pzInfo_1);self.pzInfo_1=nil;
_UIObject_release(self.pzInfo_2);self.pzInfo_2=nil;
_UIObject_release(self.pzInfo_3);self.pzInfo_3=nil;
_UIObject_release(self.pzRuleClickButton);self.pzRuleClickButton=nil;
_UIObject_release(self.rateList);self.rateList=nil;
_UIObject_release(self.receiveBuildButton);self.receiveBuildButton=nil;
_UIObject_release(self.rightPart);self.rightPart=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.saveBuildCountBg);self.saveBuildCountBg=nil;
_UIObject_release(self.saveBuildCountTxt);self.saveBuildCountTxt=nil;
_UIObject_release(self.saveBuildReddot);self.saveBuildReddot=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntTxt);self.selectCntTxt=nil;
_UIObject_release(self.selectDzClickButton);self.selectDzClickButton=nil;
_UIObject_release(self.sliderRect);self.sliderRect=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.startClickButton);self.startClickButton=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.timeImg);self.timeImg=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.pzInfo=nil;
end
















local _this

local _showProSkillList={6,5}

local _defaultRateVal=0
local _pzNameList={"绿",'蓝','紫','橙','红'}

local _modelFade=0.2

local _ab="ui/windows/zaowuge/zaowuge_atlas_pak.ab"




function UIZaoWuGeWin:onLoaded(...)
_this=self

self.selectCnt=1
self.freshCostItemList={}

self:bindComponents()

self:addNotify(notifyConfig.building_event,function(etype,sfId,ubdId,dzId,olddzId)
if _this==nil then return end
_this:onBuildingEvent(etype,sfId,ubdId,dzId,olddzId)
end)

UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtZhenShi}})

self:addNotify(notifyConfig.on_item_list_changed,function(args)
if _this==nil then return end
self:on_item_list_changed(args)
end)
end


function UIZaoWuGeWin:__delete()

self:stopBuildTimer()

_this=nil

self:unbindComponents()

UIManager:closeWindow('UITopMoneyWin')
end




function UIZaoWuGeWin:onShow(argtable,afterOnloaded)

if argtable==nil then
return
end

if argtable then
local guid=argtable.entityId
self.entityId=guid
self.bdData=zongmenModel:findBuildingByEntityId(guid)



self:refreshRandomGetTip()
end
self.sfId=zongmenModel:getMountainId()


if afterOnloaded then
self:preRefreshPanel()
end

self.disciple=zaoWuGeModel:getBuildDisciple()
self.isHasDz=not mathHelper.compareInt64(self.disciple,Int64_0)
self:refreshAll()
end


function UIZaoWuGeWin:onHide()

end

function UIZaoWuGeWin:onShowArgRecv(argtable)
local oldId=self.entityId
local newId=argtable.entityId
if newId~=oldId then
self:__delete()
self:onLoaded()
self:onShow(argtable)
end
end


function UIZaoWuGeWin:preRefreshPanel()

self.bgSpine:setChildUIModelShowTarget(6027,1,{},eAnimationID.stand)
end

function UIZaoWuGeWin:refreshRandomGetTip()
local equipNum=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'equipNum')

local min=equipNum[1][1]
local len=#equipNum
local max=equipNum[len][1]

if min==max then
self.buildTip:setText(FMT.fmt("每次打造将产出{0}个随机阵器部位",min))
else
self.buildTip:setText(FMT.fmt("每次打造将产出{0}~{1}个随机阵器部位",min,max))
end
end

function UIZaoWuGeWin:initData()

self.buildingProgressInfo=zaoWuGeModel:getBuildingProgressInfo()
self.suitId=self.buildingProgressInfo.suitId
self.isSelectSuit=self.suitId>0
self.selectCnt=1
end



function UIZaoWuGeWin:refreshAll()

self:initData()

self:refreshAllPart()
end

function UIZaoWuGeWin:refreshAllPart()
self:refreshLeftTop()
self:refreshLeft()
self:refreshRight()
self:refreshSelectDz()
end

function UIZaoWuGeWin:refreshSelectItem(suitId)
self.suitId=suitId
self.isSelectSuit=true
self:refreshLeftTop()
self:refreshLeft()
self:refreshRight()
end

function UIZaoWuGeWin:refreshBuild()
self:initData()
self:refreshLeft()
self:refreshRight()
end


function UIZaoWuGeWin:refreshLeftTop()
self.infoList:setActive(self.isHasDz)
self.scrollView2:setActive(self.isHasDz)
self.noDzTip:setActive(not self.isHasDz)
if self.isHasDz then
local infolist={}

local name=UIDiscipleModel:getDiscipleName(self.disciple)
local nameInfo=FMT.fmt("执事弟子：{0}",toColorStringX("#7d3b17",name))
infolist[#infolist+1]=nameInfo

local pro_skill_cfg,desc
for index,proSkillId in ipairs(_showProSkillList)do
pro_skill_cfg=cfg_discipleproskillconfig_get(proSkillId)

local dzProSkillLevel=UIDiscipleModel:getDiscipleJobLevel(self.disciple,proSkillId)
local levelStr=toColorStringX("#7d3b17",FMT.fmt("{0}级",dzProSkillLevel))

local dzProSkillEffectDesc
local descFmt









descFmt="{0}等级：{1}"


desc=FMT.fmt(descFmt,pro_skill_cfg.name,levelStr,dzProSkillEffectDesc)
infolist[#infolist+1]=desc
end









self.dzInfo:setText(infolist[1])
self.dzZFLV:setText(infolist[2])
self.dzZQLV:setText(infolist[3])

local dizi_speciality=discipleSelectController.getSpeciallistByBuild(self.disciple,self.bdData.build_id,1)
local isShowSpe=dizi_speciality and#dizi_speciality>0
self.scrollView2:setActive(isShowSpe)
if isShowSpe then
self.scrollView2:setChildScrollViewInit(0,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)
self.scrollView2:setChildScrollViewCreateGrids(#self.dizi_speciality,0)
local grids=self.scrollView2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.dizi_speciality[i]
UIDiscipleModel.refreshSpecialityItemEx(item,data)
end
end
end
end

function UIZaoWuGeWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView2:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.dzId,config=data})
end


function UIZaoWuGeWin:refreshLeft()
local progressInfo=self.buildingProgressInfo
local startTime=progressInfo.startTime
local isShowProgress=startTime>0

self.emptyAddImg:setActive(not self.isSelectSuit)
self.buildItem:setActive(self.isSelectSuit)
self.buildProgress:setActive(isShowProgress)
self.changeImg:setActive((not isShowProgress)and self.isSelectSuit)

if self.isSelectSuit then
local suitCfg=cfgHelper.get1(cfg_zaowugesuitconfig_get,self.suitId)

self.buildItem:setCSImageSprite(_ab,suitCfg.icon)

self.buildInfoTxt:setText(suitCfg.name)

self:refreshProgress()

self:refreshSaveCount()
end
end

function UIZaoWuGeWin:refreshSaveCount()
local hasCount=zaoWuGeModel:getBuildCount()

self.saveBuildCountTxt:setText(hasCount)
self.saveBuildReddot:setActive(hasCount>0)
end

function UIZaoWuGeWin:refreshProgress()
local progressInfo=self.buildingProgressInfo
local startTime=progressInfo.startTime
local isShowProgress=startTime>0
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
local buildDuration=progressInfo.suitNum*singleBuildDuration
local curTime=timeHelper.getServerShortTime()
local endTime=progressInfo.startTime+buildDuration
local isStartProgress=endTime>curTime

self.buildingTip:setActive(isStartProgress)

if isShowProgress then
self.timeImg:setActive(isStartProgress)
if isStartProgress then

self.widget:SetChildIconFillAmount(self.buildProgressBar:getID(),0)
self:startBuildTimer(startTime,endTime,buildDuration,singleBuildDuration)
else
self.djsTxt:setText("打造完成")

self.widget:SetChildIconFillAmount(self.buildProgressBar:getID(),1)
end
end
end

function UIZaoWuGeWin:startBuildTimer(startTime,endTime,buildDuration,singleBuildDuration)
self:stopBuildTimer()

local hasTime=endTime-buildDuration

local hasSRTime=hasTime%singleBuildDuration
local oldHasSRTime=hasSRTime

local pId=_this.buildProgressBar:getID()

local callback=function()
if _this==nil then return end

local curTime=timeHelper.getServerShortTime()
if endTime>=curTime then
hasTime=endTime-curTime
hasSRTime=hasTime%singleBuildDuration


_this.djsTxt:setText(timeHelper.format_time_stamp(hasSRTime))
local val=1-(hasSRTime/singleBuildDuration)
if curTime==startTime then
val=0
end

_this.widget:SetChildIconFillAmount(pId,val)


if oldHasSRTime>hasSRTime then

_this:refreshCountInfo()
end
oldHasSRTime=hasSRTime
else
_this:stopBuildTimer()
_this:refreshAll()
end
end

self.buildTimer=self:setTimer(0.01,0,callback)
callback()
end

function UIZaoWuGeWin:stopBuildTimer()
if self.buildTimer then
self:stopTimerByID(self.buildTimer)
self.buildTimer=nil
end
end

function UIZaoWuGeWin:refreshCountInfo()
self:refreshBuildCount()
self:refreshSaveCount()
end



function UIZaoWuGeWin:refreshRight()
local buildLevelCfg
if self.isHasDz then
local dzProSkillLevel=UIDiscipleModel:getDiscipleJobLevel(self.disciple,DISCIPLE_PROSKILL_TYPE.eLianQi)
buildLevelCfg=cfgHelper.get1(cfg_zaowugelianqilevelconfig_get,dzProSkillLevel)

if buildLevelCfg==nil then
logErr("造物阁 缺少 当前安排弟子的炼器专业等级 的 配置",dzProSkillLevel)
end
end


local rate,desc

local totalVal=0
if buildLevelCfg~=nil then
for index,val in ipairs(buildLevelCfg.oddsColor)do
totalVal=totalVal+val
end
end

for index,rateInfo in ipairs(self.pzInfo)do
rate=buildLevelCfg~=nil and buildLevelCfg.oddsColor[index]or _defaultRateVal

local pzNamtStr=toColorString(index,FMT.fmt("{0}品质",_pzNameList[index]))

local rateStr=0

if buildLevelCfg~=nil then
rateStr=Mathf.Round((rate/totalVal)*10000)/100
end

desc=FMT.fmt("概率\n{1}%",pzNamtStr,rateStr)
local wb=rateInfo:getWidgetBase()
wb:SetChildText(0,desc)
end

self.buildCostPart:setActive(self.isSelectSuit)
self.emptySuitImg:setActive(not self.isSelectSuit)
self.pzRuleClickButton:setActive(self.isHasDz)

self:refreshCostList()

self:refreshSlider()

self:refreshBuildCount()

self:refreshOptionBtns()
end

function UIZaoWuGeWin:refreshCostList()

local isShowCost=self.isSelectSuit
self.buildCostScrollView:setActive(isShowCost)
if isShowCost then
local dzProSkillLevel
if self.isHasDz then
dzProSkillLevel=UIDiscipleModel:getDiscipleJobLevel(self.disciple,DISCIPLE_PROSKILL_TYPE.eZhenFa)
else
dzProSkillLevel=1
end
local dzPSkillCostCfg=cfgHelper.get1(cfg_zaowugezhenfalevelconfig_get,dzProSkillLevel)
if dzPSkillCostCfg then
local costInfoList=dzPSkillCostCfg.useItems[self.suitId]

self.buildCostScrollView:setChildScrollRectEnable(#costInfoList>4)

local len=#costInfoList
self.buildCostList:setChildLayoutGroupCreateItems(len,function(index)
if _this==nil then return end

local item=_this.buildCostList:getChildLayoutGroupGridItem(index-1)
local data=costInfoList[index]

local itemId=data[1]
local itemCount=data[2]
local isShowCount=self.isHasDz

self.freshCostItemList[index]=itemId

local totalNum=itemCount*self.selectCnt

local isEnough=itemsModel.checkItemEnough(itemId,itemCount)
local isMoney=itemsConfig.isMoney(itemId)

local itemCountStr=""
if isShowCount then
if isMoney then
itemCountStr=isEnough and totalNum or toColorString(FONT_COLOR.eRedColor,totalNum)
else
local hasNum=itemsModel.getCount(itemId)
hasNum=mathHelper.formatNumber4(hasNum)
totalNum=mathHelper.formatNumber4(totalNum)

local hasNumStr=isEnough and hasNum or toColorString(FONT_COLOR.eRedColor,hasNum)
itemCountStr=FMT.fmt("{0}/{1}",hasNumStr,totalNum)
end

end


local conf={itemid=itemId,itemcount=itemCountStr,showCountBG=isShowCount,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,propData)

item:SetBaseItemClickEvent(-1,function()
itemsComponentHelper.onItemClick(itemId)
end)
end)
else
logErr("造物阁 缺少 当前安排弟子的阵法专业等级 的 配置",dzProSkillLevel)
return
end
end
end

function UIZaoWuGeWin:refreshSlider()
local isShowSlider=self.buildingProgressInfo.startTime==0 and self.isSelectSuit and self.isHasDz
self.sliderRoot:setActive(isShowSlider)
self.buildCountRoot:setActive(self.buildingProgressInfo.startTime>0)
if isShowSlider then
self.min=1
self.max=zaoWuGeController:checkCanBuildCount(self.disciple,self.suitId)

if self.max==0 then
self.max=1
end

self.selectCnt=1

self:setSliderVal(self.min,self.max)
end
end

function UIZaoWuGeWin:setSliderVal(min,max)
self.widget:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,min,max,function(val)self:onSliderChange(val)end)
self.maxText:setText(max)
self.selectCntTxt:setText(self.selectCnt)
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
local totalTime=self.selectCnt*singleBuildDuration
self.preBuildTimeTxt:setText(timeHelper.format_time_stamp(totalTime))









end

function UIZaoWuGeWin:onSliderChange(value)
local oldCnt=self.selectCnt
self.selectCnt=value
if oldCnt~=self.selectCnt then
self.selectCntTxt:setText(self.selectCnt)
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
local totalTime=self.selectCnt*singleBuildDuration
self.preBuildTimeTxt:setText(timeHelper.format_time_stamp(totalTime))
self:refreshCostList()
end
end

function UIZaoWuGeWin:refreshBuildCount()
local buildCount=zaoWuGeModel:getBuildCount()
local recedueCnt=self.buildingProgressInfo.suitNum-buildCount
local needBuildCountInfo=FMT.fmt("剩余打造数量：{0}",toColorString(FONT_COLOR.eOrangeColor,recedueCnt))
self.buildCount:setText(needBuildCountInfo)
end

function UIZaoWuGeWin:refreshOptionBtns()
local progressInfo=self.buildingProgressInfo
local startTime=progressInfo.startTime
local isShowProgress=startTime>0
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
local buildDuration=progressInfo.suitNum*singleBuildDuration
local curTime=timeHelper.getServerShortTime()
local endTime=progressInfo.startTime+buildDuration

self.preBuildTimeTxt:setActive(self.isSelectSuit and self.isHasDz)

local isShowCancalBtn=isShowProgress and endTime>curTime
self.cancelClickButton:setActive(isShowCancalBtn)

local isShowStartBtn=startTime==0 and self.isSelectSuit
self.startClickButton:setActive(isShowStartBtn)

local isShowFinishBtn=isShowProgress and curTime>=endTime
self.finishClickButton:setActive(isShowFinishBtn)
end


function UIZaoWuGeWin:refreshSelectDz()
self.disciple=zaoWuGeModel:getBuildDisciple()
self.isHasDz=not mathHelper.compareInt64(self.disciple,Int64_0)

self.dzModel:setActive(self.isHasDz)
if self.isHasDz then
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.disciple)
self.dzModel:setChildUIModelShowTarget(modelParams.body,0.8,modelParams.componets,eAnimationID.stand,false,false,_modelFade)
self.dzModel:setChildUIModelShowFlipX(true)
else
self.dzModel:setChildUIModelRemoveTarget()
end

self.changeDzClickButton:setActive(self.isHasDz)
self.selectDzClickButton:setActive(not self.isHasDz)
end

function UIZaoWuGeWin:onBuildingEvent(etype,sfId,ubdId,dzId,olddzId)

if etype==buildingEvent.replaceDisciple and ubdId==self.bdData.un_build_id then
self.disciple=dzId
self.isHasDz=not mathHelper.compareInt64(dzId,Int64_0)
self:refreshAllPart()
end
end




function UIZaoWuGeWin:onSubBtn()
local cnt=self.selectCnt
if cnt<=self.min then
return
end
self.widget:SetChildSliderValue(self.selectCntSlider:getID(),cnt-1)
end



function UIZaoWuGeWin:onAddBtn()
local cnt=self.selectCnt
if cnt>=self.max then

return
end
self.widget:SetChildSliderValue(self.selectCntSlider:getID(),cnt+1)
end



function UIZaoWuGeWin:onBuildClickButton()
if self.buildingProgressInfo.startTime==0 then
self:showWindow("UIZaoWuGeSelectSuitWin")
end
end



function UIZaoWuGeWin:onCancelClickButton()
local show_data={
type='UIDialouge',
title='提示',
content="是否取消当前打造需求，取消打造只会返还当前打造还有未打造的材料，已打造的不会进行返还。",
oktext='确定',
canceltext='取消',
okcallback=function()
zaoWuGeController:req_CancelBuild()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end



function UIZaoWuGeWin:onChangeDzClickButton()

if self.buildingProgressInfo.startTime==0 then

self:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eZaoWuGe)
else
UIManager.error("打造中")
end
end



function UIZaoWuGeWin:onDzRuleClickButton()
self:showRefreshDzTips()
end



function UIZaoWuGeWin:onFinishClickButton()
local buildCount=zaoWuGeModel:getBuildCount()
if buildCount>0 then
zaoWuGeController:req_ReceiveBuild()
else
UIManager.error("还未打造完成")
end
end



function UIZaoWuGeWin:onPzRuleClickButton()
self:showBuildRateTips()
end



function UIZaoWuGeWin:onStartClickButton()
if self.isHasDz then
if self.isSelectSuit then
local isCanBuild,errItemId,needItemNum=zaoWuGeController:checkIsCanBuild(self.disciple,self.suitId,self.selectCnt)
if isCanBuild then
zaoWuGeController:req_StartBuild(self.suitId,self.selectCnt)
else
gainControl:showGainWin(errItemId,needItemNum)
end
else
UIManager.error("需要选择套装才可进行打造")
end
else
UIManager.error("请先选择执事弟子")
end
end

function UIZaoWuGeWin:onSelectDzClickButton()
self:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eZaoWuGe)

end

function UIZaoWuGeWin:onReceiveBuildButton()
local buildCount=zaoWuGeModel:getBuildCount()
if buildCount>0 then
zaoWuGeController:req_ReceiveBuild()
else
UIManager.error("还未打造完成")
end
end




function UIZaoWuGeWin:showRefreshDzTips()
local infoList=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'dzTipsList')

self.dzTipsList:setChildLayoutGroupCreateItems(#infoList,function(index)
local item=self.dzTipsList:getChildLayoutGroupGridItem(index-1)

local info=infoList[index]
item:SetChildText(0,info)
end)

self.dzTipsRoot:setActive(true)
end

function UIZaoWuGeWin:onDzTipsBack()
self.dzTipsRoot:setActive(false)
end

function UIZaoWuGeWin:showBuildRateTips()
self.buildRateTipsRoot:setActive(true)

local dzProSkillLevel=UIDiscipleModel:getDiscipleJobLevel(self.disciple,DISCIPLE_PROSKILL_TYPE.eLianQi)
local buildLevelCfg=cfgHelper.get1(cfg_zaowugelianqilevelconfig_get,dzProSkillLevel)
if buildLevelCfg then
local oddsColor=buildLevelCfg.oddsColor
local oddsStar=buildLevelCfg.oddsStar
local pzLen=3

local totalColorVal=0
for index=1,#oddsColor do
totalColorVal=totalColorVal+oddsColor[index]
end
self.buildRateTipsList:setChildLayoutGroupCreateItems(pzLen,function(pindex)
local pitem=self.buildRateTipsList:getChildLayoutGroupGridItem(pindex-1)

local pzName=FMT.fmt("{0}品概率",_pzNameList[pindex])
pzName=toColorString(pindex,pzName)

pitem:SetChildText(0,pzName)

local starLen=#oddsStar[pindex]

local totalStarVal=0
for index=1,starLen do
totalStarVal=totalStarVal+oddsStar[pindex][index]
end

local colorRate=oddsColor[pindex]/totalColorVal

pitem:SetChildLayoutGroupCreateItems(1,starLen,function(rindex)
local ritem=pitem:GetChildLayoutGroupGridItem(1,rindex-1)

local rdata=oddsStar[pindex][rindex]
local star=rindex-1

local starLen=Mathf.Max(1,star)
ritem:SetChildLayoutGroupCreateItems(0,starLen,nil)
if star==0 then
local sGrid=ritem:GetChildLayoutGroupGridItem(0,0)
sGrid:SetChildActive(0,false)
end

local info=FMT.fmt("{0}品{1}星概率",_pzNameList[pindex],star)
ritem:SetChildText(1,info)

local rateStr=Mathf.Round((rdata/totalStarVal)*10000*colorRate)/100
ritem:SetChildText(2,FMT.fmt("{0}%",rateStr))
end)

local height=25+starLen*30
pitem:SetChildSizeDelta(-1,400,height)
pitem:SetChildSizeDelta(1,340,starLen*30)
end)

local totalHeight=0
local listHeight=0
for index=1,pzLen do
local starLen=#oddsStar[index]
local height=25+30*starLen
listHeight=listHeight+height
end
totalHeight=listHeight+5+10+10*(pzLen-1)
totalHeight=Mathf.Min(totalHeight,400)
self.buildRateTipsScrollView:setChildSizeDelta(400,totalHeight)
self.buildRateTipsList:setChildSizeDelta(400,totalHeight)
else
logErr("造物阁 缺少 当前安排弟子的炼器专业等级 的 配置",dzProSkillLevel)
end
end

function UIZaoWuGeWin:onbuildRateTipsBack()
self.buildRateTipsRoot:setActive(false)
end

function UIZaoWuGeWin:showSelectDzWin()
local args={
openType=dzSelectWinOpenType.eZaoWuGe,
bdData=self.bdData,
sfId=self.sfId,
funcIndex=1,
callback=function(dzId)
if dzId==0 then
self.disciple=nil
self.isHasDz=false
else
self.disciple=dzId
self.isHasDz=true
end
self:refreshAllPart()
end
}
discipleSelectController:openDiscipleSelect(args)
end

function UIZaoWuGeWin:on_item_list_changed(argstable)
local isChange=false
for index,data in ipairs(argstable)do
local itemId=data[3]
if table.findValue(self.freshCostItemList,itemId)then
isChange=true
break
end
end
if isChange then
self:refreshCostList()
self:refreshSlider()
end
end

function UIZaoWuGeWin:showSelectManagerWin(sfId,bdData,openType,effectType,funcIndex)
local args={
openType=openType or dzSelectWinOpenType.eManager,
effectType=effectType or dzSelectEffectType.ePlan,
bdData=bdData,
sfId=sfId,
funcIndex=funcIndex or 1,
callback=function(dzId)
if bdData.dizi_id then
roleAudioController:playRoleSpeak(dzId,roleAudioNodeType.RenMingJianZu)
end
zaoWuGeController:req_ArrangeDisciple(dzId)
end
}
discipleSelectController:openDiscipleSelect(args)
end
