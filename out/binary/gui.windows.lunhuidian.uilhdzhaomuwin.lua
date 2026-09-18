







def_class("UILHDZhaoMuWin",UIWindowBase)









function UILHDZhaoMuWin:bindComponents()

self.Content=UIObject.get(self,0)
self.levelName=UIText.get(self,1)
self.levelScrollView=UIObject.get(self,2)
self.trainCostRoot=UIObject.get(self,3)
self.trainCountSelectRoot=UIObject.get(self,4)
self.zhaoHunBtn=UIButton.get(self,5)

self.zhaoHunBtn:setButtonClick(function()self:onZhaoHunBtn()end)



end


function UILHDZhaoMuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.levelName);self.levelName=nil;
_UIObject_release(self.levelScrollView);self.levelScrollView=nil;
_UIObject_release(self.trainCostRoot);self.trainCostRoot=nil;
_UIObject_release(self.trainCountSelectRoot);self.trainCountSelectRoot=nil;
_UIObject_release(self.zhaoHunBtn);self.zhaoHunBtn=nil;
end
















local this
local moneyId={137,136}

local levelItemCmpIndex={
bg=0,
levelNameIcon=1,
select=2,
lockFlag=3,
lvUpFlag=4,
}




function UILHDZhaoMuWin:onLoaded(...)
self:bindComponents()

this=self
end


function UILHDZhaoMuWin:__delete()
self:unbindComponents()

this=nil
end




function UILHDZhaoMuWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
self.selectLevelIdx=1
self.trainSelectCount=1
self.config=cfg_lunhuidianconfig_get(1)
self.buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,self.bdData.level)
self:refresh()

if not UIManager:isActive("UITopMoneyWin")then
UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtHunPo},{eMoneyType.mtLunHuiDian}})
end
end


function UILHDZhaoMuWin:onHide()
end

function UILHDZhaoMuWin:refresh()

self:refreshLeftPanel()


self:refreshRightPanel()
end

function UILHDZhaoMuWin:refreshLeftPanel()

self:refreshLevelScrollView()
end

function UILHDZhaoMuWin:refreshRightPanel()

local costWidget=self.trainCostRoot:getWidgetBase()
local config=self.config.soul_call_back
local costList=config[self.selectLevelIdx]

if costList then
costWidget:SetChildLayoutGroupCreateItems(0,2)
local grids=costWidget:GetChildLayoutGroupGridList(0)
for i=1,grids.Count do
local widget=grids[i-1]
local itemid=moneyId[i]
local itemCount=costList[i+1]*self.trainSelectCount
local hasCount=itemsModel.getCount(itemid)
local countStr=''
countStr=mathHelper.formatNumber(itemCount)
if hasCount<itemCount then
countStr=FMT.fmt("<color=#FF0000>{0}</color>",countStr)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end


local minCount=1
local maxCount=yunjiayingModel:getRemainingCanMakeSoldierCount()
maxCount=self:getMaxCost(maxCount)

local count=self.trainSelectCount or 1

if maxCount<=1 then
self.zhaoHunBtn:setButtonEnable(true,true)
self.trainCountSelectRoot:setActive(false)
else
self.zhaoHunBtn:setButtonEnable(true,false)
self.trainCountSelectRoot:setActive(true)

local countSelectWidget=self.trainCountSelectRoot:getWidgetBase()
countSelectWidget:SetChildActive(2,maxCount<=1)

countSelectWidget:SetChildInputFieldChange(0,true,function(...)
if not this then return end
return this:changeSelectCount(maxCount,...)
end)

local func=function(...)
if not this then return end
return this:onSliderChange(...)
end
countSelectWidget:SetChildSliderInit(1,count,minCount,maxCount,func)
countSelectWidget:SetChildInputFieldValue(0,count)
countSelectWidget:SetChildSliderValue(1,count)


countSelectWidget:SetChildButtonClick(3,function()
if not this then return end
return this:onSubBtn()
end,true)
countSelectWidget:SetChildButtonClick(4,function()
if not this then return end
return this:onAddBtn(maxCount)
end,true)
end
end

function UILHDZhaoMuWin:onSubBtn()
if self.trainSelectCount<=1 then
return
end

self.trainSelectCount=self.trainSelectCount-1
if self.trainSelectCount<1 then
self.trainSelectCount=1
end

self:refreshRightPanel()
end

function UILHDZhaoMuWin:onAddBtn(maxCount)
if self.trainSelectCount>=maxCount then
return
end

self.trainSelectCount=self.trainSelectCount+1
if self.trainSelectCount>maxCount then
self.trainSelectCount=maxCount
end

self:refreshRightPanel()
end

function UILHDZhaoMuWin:changeSelectCount(maxCount,str)

local count=tonumber(str)

local originalCount=self.trainSelectCount or 0
local isNeedReset=false
if count==nil then

count=1
isNeedReset=true
elseif count==originalCount then

return
elseif count<1 then

count=1
isNeedReset=true
elseif count>maxCount then

count=maxCount
isNeedReset=true
end

if isNeedReset then
local countSelectWidget=self.trainCountSelectRoot:getWidgetBase()
countSelectWidget:SetChildInputFieldValue(0,count)
return
end

if self.trainSelectCount==count then
return
end

self.trainSelectCount=count
self:refreshRightPanel()
end

function UILHDZhaoMuWin:onSliderChange(value)
if not value then
return
end

if self.trainSelectCount==value then
return
end

self.trainSelectCount=value

self:refreshRightPanel()
end

function UILHDZhaoMuWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UILHDZhaoMuWin:refreshLevelScrollView()
local levelCfgList=cfg_fairylandsoldierconfig()
local soul_call_back=self.config.soul_call_back
local count=soul_call_back and#soul_call_back or 6
self.maxListIndex=count
local buildLv=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)

self.levelScrollView:setChildScrollViewCreateGrids(count,3)
local grids=self.levelScrollView:getChildScrollViewItemWidgets()

for i=1,grids.Count do
local widget=grids[i-1]
local levelCfg=levelCfgList[i]
local unlockBuildLevel=yunjiayingModel:getSoldierUnlockBuildLevel(levelCfg.id)

if levelCfg then
widget:SetChildActive(-1,true)
local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(levelItemCmpIndex.bg,iconAb,bgIconName)

local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(levelItemCmpIndex.levelNameIcon,iconAb,levelIconName)

local isSelect=self.selectLevelIdx==levelCfg.id
widget:SetChildActive(levelItemCmpIndex.select,isSelect)

local isUnlock=buildLv>=unlockBuildLevel
widget:SetChildActive(levelItemCmpIndex.lockFlag,not isUnlock)
if isUnlock then
widget:SetChildButtonClick(levelItemCmpIndex.bg,function()
return self:selectLevel(i)
end,true)
else
widget:SetChildButtonClick(levelItemCmpIndex.bg,function()
return UIManager.error(FMT.fmt("云甲营{0}级解锁",unlockBuildLevel))
end,true)
end

else
widget:SetChildActive(-1,false)
end
end
end

function UILHDZhaoMuWin:selectLevel(levelIdx)
if self.selectLevelIdx==levelIdx then
return
end
self.selectLevelIdx=levelIdx
self.trainSelectCount=1
self:refresh()
end


function UILHDZhaoMuWin:checkIsEnoughCost()
local config=this.config.soul_call_back
local costList=config[this.selectLevelIdx]

local itemId=moneyId[1]
local itemCount=costList[2]*this.trainSelectCount
local hasCount=itemsModel.getCount(itemId)

if hasCount<itemCount then
gainControl:showGainWin(itemId)
return false
end

itemId=moneyId[2]
itemCount=costList[3]*this.trainSelectCount
hasCount=itemsModel.getCount(itemId)

if hasCount<itemCount then
gainControl:showGainWin(itemId)
return false
end

return true
end

function UILHDZhaoMuWin:getMaxCost(value)
local maxNum=value
local cfg=self.config.soul_call_back
cfg=cfg[self.selectLevelIdx]

local itemNum1=cfg[2]
local itemNum2=cfg[3]
local itemId2=eMoneyType.mtHunPo
local itemId1=eMoneyType.mtLunHuiDian

local needNum1=itemNum1*maxNum
local needNum2=itemNum2*maxNum
local haveNum1=itemsModel.getCount(itemId1)
local haveNum2=itemsModel.getCount(itemId2)

if haveNum1<needNum1 or haveNum2<needNum2 then
needNum1=math.floor(haveNum1/itemNum1)
needNum2=math.floor(haveNum2/itemNum2)

if needNum1<needNum2 then
maxNum=needNum1
else
maxNum=needNum2
end
end

return maxNum
end





function UILHDZhaoMuWin:onZhaoHunBtn()
if yunjiayingModel:getRemainingCanMakeSoldierCount()<=0 then
UIManager.error("云甲营容纳数量已达上限，不能进行招魂")
return
end

if this:checkIsEnoughCost()then
LunHuiDianController.send_6_163(self.selectLevelIdx,self.trainSelectCount)
self:closeSelf()
UIManager:invokeUIMethod('UILunHuiDianWin','playZhaoMuAnim')
end
end


function UILHDZhaoMuWin:onFinishBtn()
end


function UILHDZhaoMuWin:onSpeedUpBtn()
end

function UILHDZhaoMuWin:onClickClose()
self:closeSelf()
end