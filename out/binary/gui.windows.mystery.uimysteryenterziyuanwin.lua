







def_class("UIMysteryEnterZiYuanWin",UIWindowBase)









function UIMysteryEnterZiYuanWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.closeButton=UIButton.get(self,1)
self.closeMJButton=UIButton.get(self,2)
self.colorTitle=UIImage.get(self,3)
self.continueButton=UIButton.get(self,4)
self.continueButtonRoot=UIObject.get(self,5)
self.costImg=UILinkImageText.get(self,6)
self.costText=UILinkImageText.get(self,7)
self.curBeiShu=UIText.get(self,8)
self.detailBtn=UIButton.get(self,9)
self.effect=UIObject.get(self,10)
self.enterButton=UIButton.get(self,11)
self.environmentTxt=UIText.get(self,12)
self.fbTitleTxt=UIText.get(self,13)
self.handleImg=UIObject.get(self,14)
self.handleImg2=UIObject.get(self,15)
self.isGot=UIObject.get(self,16)
self.maxText=UIText.get(self,17)
self.model=UIObject.get(self,18)
self.moneybar=UIObject.get(self,19)
self.moneyBars_1=UIButton.get(self,20)
self.moneyBars_2=UIButton.get(self,21)
self.moneyBars_3=UIButton.get(self,22)
self.probeNumTxt=UIText.get(self,23)
self.quitButton=UIButton.get(self,24)
self.rewards=UIObject.get(self,25)
self.rightPanel=UIObject.get(self,26)
self.root=UIObject.get(self,27)
self.selectCntSlider=UIObject.get(self,28)
self.selectCntText=UIText.get(self,29)
self.shoutongeffect=UIObject.get(self,30)
self.shoutongrewards=UIObject.get(self,31)
self.sliderRect=UIObject.get(self,32)
self.sliderRoot=UIObject.get(self,33)
self.startButtonRoot=UIObject.get(self,34)
self.strengthTxt=UIText.get(self,35)
self.subBtn=UIButton.get(self,36)
self.unlockMulitText=UIText.get(self,37)
self.unlockText=UIText.get(self,38)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIMysteryEnterZiYuanWin")end)

self.closeMJButton:setButtonClick(function()self:onCloseMJButton()end)

self.continueButton:setButtonClick(function()self:onContinueButton()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.enterButton:setButtonClick(function()self:onEnterButton()end)

self.moneyBars_1:setButtonClick(function()self:onMoneyBars_1()end)

self.moneyBars_2:setButtonClick(function()self:onMoneyBars_2()end)

self.moneyBars_3:setButtonClick(function()self:onMoneyBars_3()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)
self.moneyBars={
self.moneyBars_1,
self.moneyBars_2,
self.moneyBars_3,
}



end


function UIMysteryEnterZiYuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.closeMJButton);self.closeMJButton=nil;
_UIObject_release(self.colorTitle);self.colorTitle=nil;
_UIObject_release(self.continueButton);self.continueButton=nil;
_UIObject_release(self.continueButtonRoot);self.continueButtonRoot=nil;
_UIObject_release(self.costImg);self.costImg=nil;
_UIObject_release(self.costText);self.costText=nil;
_UIObject_release(self.curBeiShu);self.curBeiShu=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.enterButton);self.enterButton=nil;
_UIObject_release(self.environmentTxt);self.environmentTxt=nil;
_UIObject_release(self.fbTitleTxt);self.fbTitleTxt=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.handleImg2);self.handleImg2=nil;
_UIObject_release(self.isGot);self.isGot=nil;
_UIObject_release(self.maxText);self.maxText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.moneybar);self.moneybar=nil;
_UIObject_release(self.moneyBars_1);self.moneyBars_1=nil;
_UIObject_release(self.moneyBars_2);self.moneyBars_2=nil;
_UIObject_release(self.moneyBars_3);self.moneyBars_3=nil;
_UIObject_release(self.probeNumTxt);self.probeNumTxt=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.shoutongeffect);self.shoutongeffect=nil;
_UIObject_release(self.shoutongrewards);self.shoutongrewards=nil;
_UIObject_release(self.sliderRect);self.sliderRect=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.startButtonRoot);self.startButtonRoot=nil;
_UIObject_release(self.strengthTxt);self.strengthTxt=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.unlockMulitText);self.unlockMulitText=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
self.moneyBars=nil;
end


















local colorEffect={
[1]=10119,
[2]=10120,
[3]=10121,
[4]=10122,
[5]=10123,
}


function UIMysteryEnterZiYuanWin:onLoaded(...)
self:bindComponents()

self:addNotify(notifyConfig.swipe,self.on_swipe)
self:addNotify(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)

self.min=1
self.max=5
self.selectCnt=1

self.sliDerFunc=function(val)
self:onSliderChange(val)
end
self.maxText:setText(self.max)
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>1)


self:setLiederInit(self.min,self.max)



end

function UIMysteryEnterZiYuanWin:setLiederInit(min,max)


self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,min,max,self.sliDerFunc)
self.sliderRect:setChildLayoutGroupCreateItems(max-min+1,function(i)
local rect=self.sliderRect:getChildLayoutGroupGridItem(i-1)
if rect then
rect:SetChildButtonClick(-1,function()
self:onSliderChange(min+i-1)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),min+i-1)
end)
end
end)
end

function UIMysteryEnterZiYuanWin:onSliderChange(value)
if self.useItem then
return
end
self.selectCnt=value
self.selectCntText:setText(self.selectCnt)
if self.groupId then
local probeNum=mysteryZiYuanFuBenModel:getprobeNum(self.groupId)
if probeNum~=-1 and value>probeNum then
self.selectCntText:setText(FMT.fmt("探索次数：<color=#d73737>{0}</color>",value))
else
self.selectCntText:setText(FMT.fmt("探索次数：<color=#f7f7f7>{0}</color>",value))
end
else
self.selectCntText:setText(FMT.fmt("探索次数：<color=#f7f7f7>{0}</color>",value))
end

if self.cost then
local have=itemsModel.getCount(self.cost[1])


local color=have>=self.cost[2]*self.selectCnt and"#d4d4d4"or"#d73737"
self.costText:setText(FMT.fmt("<color={0}>{1}</color>",color,self.cost[2]*self.selectCnt))
end
end

function UIMysteryEnterZiYuanWin:onMoneyChanged(moneytype)
if self.moneyMap and self.moneyMap[moneytype]then
self:refreshMoneyBar(moneytype)
if self.cost then
local have=itemsModel.getCount(self.cost[1])
local color=have>=self.cost[2]*self.selectCnt and"#d4d4d4"or"#d73737"
self.costText:setText(FMT.fmt("<color={0}>{1}</color>",color,self.cost[2]*self.selectCnt))
end
end
end


function UIMysteryEnterZiYuanWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
end




function UIMysteryEnterZiYuanWin:onShow(argtable,afterOnloaded)
notifySystem:listenNotify(notifyConfig.swipe,self.on_swipe)
notifySystem:listenNotify(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
local groupId=tonumber(argtable[1])
local zyId=tonumber(argtable[2])
local isSelectSame=self.groupId==groupId
self.groupId=groupId

self.zyId=zyId
self.poskey=table.concat({groupId,zyId},'-')
local allconfig=cfg_secretsceneziyuanfubenconfig()
local config=allconfig[groupId][zyId]
self.config=config
self.selectIndex=nil

if not isSelectSame then
local showTongConfig=allconfig[groupId][1]
local showTongTable={}
for i,v in pairs(showTongConfig.firstReward)do
local list=v
table.sort(list,function(a,b)
local aConfig=itemsConfig.getConfig(a[1])
local bConfig=itemsConfig.getConfig(b[1])
return aConfig.color>bConfig.color
end)
showTongTable[i]=list
end
self.showTongTable=showTongTable
end

self:initWin(config)


self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),1)
end


function UIMysteryEnterZiYuanWin:getLittleWorldDiff(config)
if not systemModel.isOpen(SYSTEM_DEFINE.eSmallWorld)then
if config.smallworldlevel then
local lv=10000
for i,v in ipairs(config.smallworldlevel)do
lv=math.min(lv,v[2])
end
return lv
end
end
end

function UIMysteryEnterZiYuanWin:initWin(config)
local name=config.name
local mjGroup=config.mjGroup
self.condList={}
self.fbTitleTxt:setText(name)
local max=#mjGroup
local lwDiff=self:getLittleWorldDiff(config)
if lwDiff then
max=math.min(max,lwDiff-1)
end
self.rightPanel:setChildScrollViewCreateGrids(max,1)
local firstIdx=1
local cmpList=self.rightPanel:getChildScrollViewItemWidgets()
local gridNum=cmpList.Count
local curLayer=mysteryZiYuanFuBenModel:getCurLayer(self.groupId)
local unlock=mysteryZiYuanFuBenModel:checkUnlock(config)
local useItemIdx=nil
local useItem=false
if gridNum>0 then
for i=1,gridNum do

local canSelect=curLayer==0
local ret=unlock and mysteryZiYuanFuBenModel:checkCond(self.groupId,self.zyId,i)

if canSelect then
if ret then
firstIdx=i
end
end
if not useItem then
useItem=mysteryZiYuanFuBenModel:getZiYuanMysteryUseItem(self.groupId,i)==0
if useItem then
useItemIdx=i
end
end
local cmp=cmpList[i-1]
self:refreshRightItem(i,cmp,config,max)
cmp:SetChildActive(3,false)
cmp:SetChildActive(6,not ret)
self.condList[i]=ret
local ret=mysteryZiYuanFuBenModel:checkPassButNotGetReward(self.groupId,self.zyId,i)
cmp:SetChildActive(1,ret)
end
end
if curLayer>0 then
firstIdx=curLayer
else
if useItemIdx then

firstIdx=useItemIdx
end
end
useItem=false
self.useItem=useItem
self.useItemIdx=useItemIdx

self.selectCntSlider:setGray(useItem)


self:selectItem(firstIdx,useItemIdx)


self:setModel()
end

function UIMysteryEnterZiYuanWin:setModel()
local random_dis=UIDiscipleModel:getRandomDiscipleData()
self.dis_guid=random_dis.discipleguid
local image=UIDiscipleModel:getDiscipleOutsideModelInfo(self.dis_guid)
if image then
self.model:setChildUIModelShowTarget(image.body,1,image.componets,eAnimationID.stand)
end
end

function UIMysteryEnterZiYuanWin:refreshWin()
local selectIndex=self.selectIndex
self.useItem=mysteryZiYuanFuBenModel:getZiYuanMysteryUseItem(self.groupId,selectIndex)==0
if self.useItem then
self.useItemIdx=selectIndex
end
local config=self.config
local fbGroup=config.mjGroup

local fbId=fbGroup[selectIndex]
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,fbId)
local jinjie=fbConfig.fixedJingJie
if not jinjie then
loggerUtil.logErrFMT("副本表的固定秘境境界fixedJindJie为空")
end
self.jinjie=jinjie or 1
local JJName=UIDiscipleModel.getJJNameCommon(jinjie or 1,3)
self.strengthTxt:setText(FMT.fmt("推荐平均境界：<color=#fd8950>{0}</color>",JJName))
local fb_color=config.color[selectIndex]
self.effect:setChildShowEffect(colorEffect[fb_color],true)

local shoutong=self.showTongTable[selectIndex]
self.shoutongrewards:setChildLayoutGroupCreateItems(#shoutong)
local items=self.shoutongrewards:getChildLayoutGroupGridList()
local tongguanDiff=mysteryZiYuanFuBenModel:getTongGuanDiff(self.groupId)
local probeNum=mysteryZiYuanFuBenModel:getprobeNum(self.groupId)

local zheXianLingret=true
local cond=config.condition
local book_id
local index
if cond then
book_id=cond[1]
index=cond[2]or 0
zheXianLingret=zheXianLingModel:checkFinish(book_id,index)
end
self.probeNumTxt:setActive(false)
if probeNum>-1 then
self.probeNumTxt:setActive(true)
self.probeNumTxt:setText(FMT.fmt("剩余探索次数：<color=#fd8950>{0}次</color>",probeNum))
end

local isGot=mysteryZiYuanFuBenModel:isGotShouTongReward(self.groupId,selectIndex)
local isGet=(not isGot)and zheXianLingret and mysteryZiYuanFuBenModel:checkPassReward(self.groupId,self.zyId,selectIndex)

for i=0,items.Count-1 do
local item=items[i]
local r=shoutong[i+1]
local conf={itemid=r[1],showCountBG=r[2]>1,itemcount=r[2]>1 and r[2]or'',showStage=true,showname=false,itemIndex=i}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(2,function()
self:onClickItemShouTong(i+1,r[1],isGet,selectIndex)
end)
prop[PropIndex(DataPropKey.eWidgetActive,10)]=isGet or false

item:SetChildPropData(2,prop)
item:SetChildGray(2,isGot or false)

end

self.isGot:setActive(isGot or false)
local rewards,detail=MysteryModel:getShowAwards(fbId,jinjie)
self.detail=detail
if rewards then
self.rewards:setChildLayoutGroupCreateItems(#rewards)
local items=self.rewards:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local data=rewards[i+1]
if data[2]==-1 then
data.itemCount=-1
elseif data[2]==-2 then
data.itemCount=-2
elseif data[2]==1 then
data.countText=''
end
local cfg=itemsConfig.getConfig(data[1])
data.stage=cfg.stage
widgetHelper.setNormalRewardItem(item,0,data)
end
else
self.rewards:setChildLayoutGroupCreateItems(0)
end

if detail and next(detail)then
self.detailBtn:setActive(true)
else
self.detailBtn:setActive(false)
end

local ret=self.condList[selectIndex]

if(not ret)or(not zheXianLingret)then
self.startButtonRoot:setActive(false)
self.continueButtonRoot:setActive(false)

if not zheXianLingret then
local condStr=""
local bookStr=mathHelper.numberToChinese(book_id)
if book_id and index>0 then
local chapterStr=mathHelper.numberToChinese(index)
condStr=FMT.fmt('完成谪仙令卷{0}·第{1}章',bookStr,chapterStr)
else
condStr=FMT.fmt('完成谪仙令卷{0}',bookStr)
end
self.unlockText:setText(condStr)
else
local checkLW,lv=mysteryZiYuanFuBenModel:checkLittleWorldLevel(self.groupId,self.zyId,selectIndex)
if not checkLW then
self.unlockText:setText(FMT.fmt("小世界达到{0}级解锁",lv))
else
local diffCond=config.diffCond
if diffCond then
local cond=diffCond[selectIndex]
if cond then
local cnd=systemConfig.isEnoughSingleCnd(SYSTEM_OPEN_TYPE.eZongmemLevelChanged,cond)
if cnd then
self.unlockText:setText(FMT.fmt("通关{0}阶遗迹秘境解锁",mathHelper.numberToChinese(selectIndex-1)))
else
if selectIndex-tongguanDiff>1 then
self.unlockText:setText(FMT.fmt("通关{0}阶遗迹秘境\n且宗门等级达到{1}级解锁",mathHelper.numberToChinese(selectIndex-1),cond))
else
self.unlockText:setText(FMT.fmt("宗门等级达到{0}级解锁",cond))
end
end
end
else
self.unlockText:setText(FMT.fmt("通关{0}阶遗迹秘境解锁",mathHelper.numberToChinese(selectIndex-1)))
end
end

end

self.sliderRoot:setActive(false)
self.unlockMulitText:setActive(false)
else

self.unlockText:setText("")

self.fbid=fbId
local isOpenMulti=tongguanDiff-selectIndex>=0 or mysteryZiYuanFuBenModel:checkPassRewardInitLevel(self.groupId,self.zyId,selectIndex)
self.isOpenMulti=isOpenMulti

self.unlockMulitText:setActive((not isOpenMulti))

if not isOpenMulti then
self.selectCnt=1
end


local cost=fbConfig.useResEnter

if cost and next(cost)then
self.cost=type(cost[1])=="number"and cost or cost[1]
local icon=iconHelper.getIconName(self.cost[1])
local iconStr=chatEmotHelper.getIconEmotMesg(icon,32)
local have=itemsModel.getCount(self.cost[1])
local color=have>=self.cost[2]*self.selectCnt and"#d4d4d4"or"#d73737"
self.costImg:setText(FMT.fmt("消耗：{0}",iconStr))
self.costImg:setActive(true)
self.costText:setActive(true)
if self.useItem then
color="#d4d4d4"
self.costText:setText("")
self.costImg:setScale(Vector3.zero)
self.closeMJButton:setActive(true)
else
self.closeMJButton:setActive(false)
self.costImg:setScale(Vector3.one)
self.costText:setText(FMT.fmt("<color={0}>{1}</color>",color,self.useItem and 0 or self.cost[2]*self.selectCnt))
end
else
self.costImg:setActive(false)
self.costText:setActive(false)
end


local curLayer=mysteryZiYuanFuBenModel:getCurLayer(self.groupId)
self.startButtonRoot:setActive(curLayer==0 or curLayer~=selectIndex)
self.continueButtonRoot:setActive(curLayer~=0 and curLayer==selectIndex)

self.sliderRoot:setActive(isOpenMulti)
if isOpenMulti then
if curLayer~=0 and curLayer==selectIndex then
local multi=mysteryZiYuanFuBenModel:getMultiChallenge(self.groupId,selectIndex)
self.curBeiShu:setText(FMT.fmt("当前探索倍数X{0}",multi))
else

self:setLiederInit(self.min,self.max)

self.curBeiShu:setText("")
end
else
self.curBeiShu:setText("")
end
if self.useItem then
local multi=mysteryZiYuanFuBenModel:getMultiChallenge(self.groupId,selectIndex)

self.selectCntText:setText(FMT.fmt("探索次数：<color=#f7f7f7>{0}</color>",multi))

if isOpenMulti then
self:setLiederInit(multi,multi)
self.handleImg2:setActive(true)
self.handleImg:setScale(Vector3.zero)
self.handleImg2:setChildAnchoredPos((multi-self.min)/self.max*238,13.75)
end
else
self.handleImg:setScale(Vector3.one)
self.handleImg2:setActive(false)
end

end

local moneyMap={}
local moneyList={}
if fbConfig.moneyBar then
for i,v in ipairs(fbConfig.moneyBar)do
table.insert(moneyList,v)
moneyMap[v]=i
end
else
local cost=fbConfig.useResEnter
if cost then
for i,v in ipairs(cost)do
table.insert(moneyList,v[1])
moneyMap[v[1]]=i
end
end
end

self.moneyList=moneyList
self.moneyMap=moneyMap
self:initMoneyBar(moneyList)





self:refreshReddot()
end

function UIMysteryEnterZiYuanWin:onClickItemShouTong(i,itemId,isGet,selectIndex)
if isGet then

mysteryZiYuanFuBenController.send_4_79(self.groupId,1,selectIndex)
else
itemsComponentHelper.onItemClick(itemId,i)
end
end

function UIMysteryEnterZiYuanWin.on_swipe()
if worldController:isInWorld()and not MysteryModel:is_enter_Mystery()and UIManager:isActive('UIMysteryEnterZiYuanWin')then
AudioManager.playCloseUI()
worldController:resetRightView()
end
end

function UIMysteryEnterZiYuanWin.onClickEmptyInWorld()
if worldController:isInWorld()and not MysteryModel:is_enter_Mystery()and not UIManager:isActive('UIMysteryEnterZiYuanWin')then
AudioManager.playCloseUI()
worldController:resetRightView()
end
end

function UIMysteryEnterZiYuanWin:refreshRightItem(itemIdx,itemCmp,config,max)
itemCmp:SetChildText(0,FMT.fmt("{0}阶",mathHelper.numberToChinese(itemIdx)))
itemCmp:SetChildActive(1,false)

itemCmp:SetChildButtonClick(5,function()
self:selectItem(itemIdx)
end)
itemCmp:SetChildActive(4,itemIdx==max)


end

function UIMysteryEnterZiYuanWin:refreshReddot()
local cmpList=self.rightPanel:getChildScrollViewItemWidgets()
local gridNum=cmpList.Count
if gridNum>0 then
for i=1,gridNum do
local ret=mysteryZiYuanFuBenModel:checkPassButNotGetReward(self.groupId,self.zyId,i)
local cmp=cmpList[i-1]
cmp:SetChildActive(1,ret)
end
end
end

function UIMysteryEnterZiYuanWin:selectItem(idx,useItemIdx)
local oldIndex=self.selectIndex
if oldIndex==idx then
return
end








if oldIndex then
local itemCmp=self.rightPanel:getChildScrollViewItemWidget(oldIndex-1)
if itemCmp then
itemCmp:SetChildActive(3,false)
end
end
local itemCmp=self.rightPanel:getChildScrollViewItemWidget(idx-1)
if itemCmp then
itemCmp:SetChildActive(3,true)
end

self.selectIndex=idx

self.rightPanel:setChildScrollViewSelectItem(idx-1)

self:refreshWin()
end

function UIMysteryEnterZiYuanWin:onHide()
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
self.selectIndex=nil
end
function UIMysteryEnterZiYuanWin.on_swipe()
if worldController:isInWorld()and MysteryModel:get_cur_fbid()==nil then
worldController:resetRightView()
end
end

function UIMysteryEnterZiYuanWin.onClickEmptyInWorld()
if worldController:isInWorld()and MysteryModel:get_cur_fbid()==nil then

AudioManager.playCloseUI()
worldController:resetRightView()
end
end
















function UIMysteryEnterZiYuanWin:refreshMoneyBar(moneytype)


local index=self.moneyMap[moneytype]
if index then
local wb=self.moneyBars[index]:getChildWidgetBase()
wb:SetChildText(1,moneyModel.getMoneyDesc1(moneytype))
end
end

function UIMysteryEnterZiYuanWin:initMoneyBar(moneyList)
if webGLHelper:isRunMiniGame()then
self.moneybar:setChildAnchoredPosition3D(Vector3.New(-200,0,0))
end
if moneyList==nil then moneyList={}end
self.moneyList=moneyList
for i,v in ipairs(self.moneyBars)do
local wb=v:getChildWidgetBase()
local mType=moneyList[i]
if mType then
v:setActive(true)
local icon=iconHelper.getMoneyIconName(mType)

wb:SetChildIcon(0,icon,false)
if mType~=eMoneyType.mtLingPai then
wb:SetChildButtonClickWithID(2,function()
if mType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(mType)
end
end,i)
else
wb:SetChildButtonClickWithID(2,function()
moneySystem:showBuyTips(mType)
end,i)
end
wb:SetChildText(1,moneyModel.getMoneyDesc1(mType))
else
v:setActive(false)
end
end
end














function UIMysteryEnterZiYuanWin:onMoneyBars_1()
end
function UIMysteryEnterZiYuanWin:onMoneyBars_2()
end
function UIMysteryEnterZiYuanWin:onMoneyBars_3()
end

function UIMysteryEnterZiYuanWin:checkOtherEnterFBDialouge(okcallback)
local useItemIdx=self.useItemIdx

local config=self.config
local fbGroup=config.mjGroup

local fbId=fbGroup[useItemIdx]
local cnt=self.selectCnt
local isOpenMulti=self.isOpenMulti
if not isOpenMulti then
cnt=1
end
local curLayer=mysteryZiYuanFuBenModel:getCurLayer(self.groupId)
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('当前正在探索<color=#549327>{0}阶</color>秘境\n需要先将其关闭，是否确认？\n\n（<color=#c82c2c>关闭秘境不返还投入令牌</color>）',mathHelper.numberToChinese(self.useItemIdx)),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
if curLayer~=0 and curLayer==useItemIdx then
MysteryController.send_4_4(fbId)
end
MysteryController.send_4_5(fbId,1)
mysteryZiYuanFuBenModel.data.waitToCloseAndEnter=true


end,
showclosebtn=false,
}
self.comfirmDialogEnter=UIDialogManager.newDialog(showdata)
self.comfirmDialogEnter:show()
end


function UIMysteryEnterZiYuanWin:afterOhterCloseFB()
self.useItemIdx=nil
self:onEnterButton()
end





function UIMysteryEnterZiYuanWin:onQuitButton()
if self.fbid then
local probeNum=mysteryZiYuanFuBenModel:getprobeNum(self.groupId)
local contenttips='撤离后可再派遣弟子进入，是否确定？'
if probeNum~=-1 then
contenttips="是否关闭秘境？\n<color=red>（关闭秘境不返还所投入的令牌、次数）</color>"
end
local showdata=
{
type='UIDialougeHighest',
title='提示',
content=contenttips,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
MysteryController.send_4_4(self.fbid)


end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end



function UIMysteryEnterZiYuanWin:onContinueButton()
self:onEnterButton(true)
end



function UIMysteryEnterZiYuanWin:onDetailBtn()
if not self.detail then
return
end
UIManager:showWindow("UIDetailDropWin",{detail=self.detail})
end


function UIMysteryEnterZiYuanWin:onEnterButton(nocheck)
if self.useItemIdx~=nil and self.useItemIdx~=self.selectIndex then

self:checkOtherEnterFBDialouge()
return
end

if bagControl.checkShowFullEquipBagTips('无法继续挑战')then
return
end


if not nocheck then
local maxnum=mysteryZiYuanFuBenModel:getprobeNum(self.groupId)
if maxnum~=-1 then
if self.selectCnt>maxnum then
UIManager.error("探索次数不足")
return
end
end
end


local fbid=self.fbid
local posKey=self.poskey
local isOpenMulti=self.isOpenMulti
local cnt=self.selectCnt
if fbid then

local posData=mysteryZiYuanFuBenModel:get_mysteryFB_unit(posKey)
if not posData then
error(FMT.fmt("找不到对应秘境单位{0}",fbid))
return
end

local pos,block=worldPositionConfig:getPosition(posData[1],{posData[2],posData[3]})
local cState=worldBlockModel:getBlockState(tonumber(posData[1]),block)
if cState~=worldBlockModel.BLOCKSTATE.OPEN then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,posData[1],block)
if blockCfg then
UIManager.error(FMT.fmt("{0}未解锁",blockCfg.name))
end
return
end
local curLayer=mysteryZiYuanFuBenModel:getCurLayer(self.groupId)
if curLayer>0 then
if curLayer==self.selectIndex then
if worldModel:isSameWorld(posData[1])then
worldController:resetLeftView()
worldController:resetRightView()
local zhenFaId=MysteryModel:get_mysteryFB_zhenFa(fbid)
MysteryModel:set_select_zhenFa(zhenFaId)
local multi=mysteryZiYuanFuBenModel:getMultiChallenge(self.groupId,self.selectIndex)
MysteryController:enterMysteryFB(fbid,multi)
else
local groupId=self.groupId
local selectIndex=self.selectIndex
local worldName=cfgHelper.get2(cfg_worldconfig_get,posData[1],'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG='false',
cancelcallback=function()
worldController:displayHUD(true)
worldController:displayUI(true)
end,
okcallback=function()
local position=worldPositionConfig:getPosition(posData[1],{posData[2],posData[3]})
local args={lookAt=position}
mainControl:enterWorld({posData[1],args},function()
worldController:resetLeftView()
worldController:resetRightView()
local zhenFaId=MysteryModel:get_mysteryFB_zhenFa(fbid)
MysteryModel:set_select_zhenFa(zhenFaId)
local multi=mysteryZiYuanFuBenModel:getMultiChallenge(groupId,selectIndex)
MysteryController:enterMysteryFB(fbid,multi)
end)
end,
showclosebtn=false,
}
self.comfirmDialogEnter=UIDialogManager.newDialog(showdata)
self.comfirmDialogEnter:show()
end

end
else
if not isOpenMulti then
cnt=1
end
self:enterFB(fbid,cnt)
end

end
end

function UIMysteryEnterZiYuanWin:enterFB(fbid,cnt)
local posKey=self.poskey
local cfg_fb=cfg_secretscenefubenconfig_get(fbid)
local posData=mysteryZiYuanFuBenModel:get_mysteryFB_unit(posKey)
if(not self.useItem)and self.cost and not moneyModel.checkEnoughMoney(self.cost[1],self.cost[2]*cnt)then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(self.cost[1])))
gainControl:showGainWin(self.cost[1])
else
local jj=self.jinjie
local cancelCB=self.cancelCallBack
local ret,errType=downAssetManager:needDownLoadMiJing(fbid)
if ret then return end
local selectDiscipleCallBack=function(guidList,zhenfaId)


mysteryZiYuanFuBenModel:set_temp_Multi(cnt)

MysteryController.select_dizi_and_skill(fbid,guidList,nil,zhenfaId)

timeEventController.delayDo(0.5,function()
fightController:closeSelectStage(false)
end)

end
local winArgs=
{
enterCallBack=selectDiscipleCallBack,
enterTxt="秘境",
cancelCallBack=cancelCB,
fightCompareJingJie=jj,
fightCompareTips="该秘境里的敌人实力强大，是否确认？",
catCatMiJing=cfg_fb.teamFight~=nil and fbid or nil,
}

local preCB=function()
worldController:changeLeftView()
worldController:displayUI(false)
worldController:displayHUD(false)
worldController:displaySymbol(false)
worldController:resetRightView()
fightController.showPrepareWin(fightPreSelectModel.fightType.mystery,winArgs,function()
local mysteryPanelCfg=cfgHelper.get1(cfg_secretsceneuishowconfig_get,cfg_fb.uiOpen)
if mysteryPanelCfg.skillPanel then
local sysid=SYSTEM_DEFINE.eMiJingSkill
if systemModel.isOpen(sysid)then
UIFullFightPrepareControl:showWindow("UIMysterySkillSelectWin",{fbid})
end
end
end)
end

if worldModel:isSameWorld(posData[1])then
preCB()
else
local worldName=cfgHelper.get2(cfg_worldconfig_get,posData[1],'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG='false',
cancelcallback=function()

worldController:displayHUD(true)
worldController:displayUI(true)
end,
okcallback=function()
local position=worldPositionConfig:getPosition(posData[1],{posData[2],posData[3]})
local args={lookAt=position}
mainControl:enterWorld({posData[1],args},preCB)
end,
showclosebtn=false,
}
self.comfirmDialogEnter=UIDialogManager.newDialog(showdata)
self.comfirmDialogEnter:show()
end
end
end

function UIMysteryEnterZiYuanWin.cancelCallBack()
worldController:resetLeftView()
worldController:displayUI(true)
worldController:displayHUD(true)
worldController:displaySymbol(true)
UIManager:closeWindow("UIMysterySkillSelectWin")
end




function UIMysteryEnterZiYuanWin:onSubBtn()
if self.useItem then
UIManager.error("探索中的秘境无法更改倍数")
return
end
local cnt=self.selectCnt
if cnt<=self.min then
return
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),cnt-1)
end



function UIMysteryEnterZiYuanWin:onAddBtn()
if self.useItem then
UIManager.error("探索中的秘境无法更改倍数")
return
end
local cnt=self.selectCnt
if cnt>=self.max then
return
end

self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),cnt+1)
end

function UIMysteryEnterZiYuanWin:onCloseMJButton()
local fbid=self.fbid
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='是否确认关闭秘境？\n\n<color=#c82c2c>（关闭秘境不返还所投入的令牌）</color>',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
MysteryController.send_4_5(fbid,1)
worldController:resetRightView()
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
