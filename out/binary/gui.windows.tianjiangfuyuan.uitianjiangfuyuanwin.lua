







def_class("UITianjiangfuyuanWin",UIWindowBase)









function UITianjiangfuyuanWin:bindComponents()

self.Root=UIObject.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.uiRoot=UIObject.get(self,2)
self.modelbg=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.countdownbg=UIObject.get(self,5)
self.artWord=UIImage.get(self,6)
self.taskList=UIScrollView.get(self,7)
self.themeList=UIScrollView.get(self,8)
self.countdowntxt=UIText.get(self,9)
self.itemInfobtn=UIButton.get(self,10)
self.itemName=UIText.get(self,11)
self.model=UIObject.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.itemInfobtn:setButtonClick(function()self:onItemInfobtn()end)



end


function UITianjiangfuyuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.modelbg);self.modelbg=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.countdownbg);self.countdownbg=nil;
_UIObject_release(self.artWord);self.artWord=nil;
_UIObject_release(self.taskList);self.taskList=nil;
_UIObject_release(self.themeList);self.themeList=nil;
_UIObject_release(self.countdowntxt);self.countdowntxt=nil;
_UIObject_release(self.itemInfobtn);self.itemInfobtn=nil;
_UIObject_release(self.itemName);self.itemName=nil;
_UIObject_release(self.model);self.model=nil;
end

















local CmpThemeItemIndex={
unselect=0,
select=1,
name=2,
reddot=3,
root=4,
}

local CmpTaskItemIndex={
item1=0,
item2=1,
item3=2,
item4=3,
lock=4,
freeBtn=5,
czBtn=6,
czVal=7,
jiantou=8,
reddot=9,
mask=10,
item1bg=11,
item2bg=12,
item3bg=13,
item4bg=14,
hjiantou=15,
bg=16,
recvImg=17,
layout1=18,
layout2=19,
}

local TaskItemSlotList={
CmpTaskItemIndex.item1,
CmpTaskItemIndex.item2,
CmpTaskItemIndex.item3,
CmpTaskItemIndex.item4,
}

local _this

local ab='ui/windows/tianjiangfuyuan/tianjiangfuyuan_atlas_pak.ab'

local themeSlotPosXList={20,-22.5}




function UITianjiangfuyuanWin:onLoaded(...)
self:bindComponents()

self.themeList:bindScrollWidget(function(...)self:bindThemeWidget(...)end)
self.taskList:bindScrollWidget(function(...)self:bindTaskWidget(...)end)

self.selectThemeIndex=1

_this=self
end


function UITianjiangfuyuanWin:__delete()
self:unbindComponents()

self:stopTimer()
self:clearBt()
end




function UITianjiangfuyuanWin:onShow(argtable,afterOnloaded)

self.isFull=self.isFull or(argtable and argtable.isFull)
self.selectThemeIndex=argtable and argtable.selectIndex or tianJiangFuYuanModel:getHasReddotTabIndex()

self:refreshAll(afterOnloaded)
end


function UITianjiangfuyuanWin:onHide()

end

function UITianjiangfuyuanWin:refreshAll(afterOnloaded)
self.themeDataList=tianJiangFuYuanModel:getThemeList()
if self.themeDataList==nil or next(self.themeDataList)==nil then
self:onCloseBtn()
return
end

self.selectThemeIndex=#self.themeDataList>=self.selectThemeIndex and self.selectThemeIndex or 1

self:refreshThemeList()

self:refreshTaskList()

self:startTimer()

if afterOnloaded then

self.modelbg:setChildCanvasGroupAlpha(0)
self:delayDo(0.5,function()
self:refreshModel()
self.modelbg:setChildCanvasGroupDOFade(1,0.2)
end)
else
self:refreshModel()
end
end

function UITianjiangfuyuanWin:refreshThemeList()
self.themeList:freshGridsNum(#self.themeDataList,#self.themeDataList,1)
end

function UITianjiangfuyuanWin:bindThemeWidget(index,item)

local themeData=self.themeDataList[index]

item:SetChildActive(-1,themeData~=nil)
if themeData then
local themeName=cfgHelper.get2(cfg_themegiftconfig_get,themeData.themeId,'theme_name')
item:SetChildText(CmpThemeItemIndex.name,themeName)
item:SetChildActive(CmpThemeItemIndex.select,self.selectThemeIndex==index)
item:SetChildActive(CmpThemeItemIndex.reddot,tianJiangFuYuanModel:checkThemeReddot(themeData.themeId))

local posIndex=index%2+1
item:SetChildAnchoredPos(CmpThemeItemIndex.root,themeSlotPosXList[posIndex],0)













item:SetChildButtonClick(CmpThemeItemIndex.root,function()
if index~=self.selectThemeIndex then
local preItem=self.themeList:getGridObjectByindex(self.selectThemeIndex-1)
preItem:SetChildActive(CmpThemeItemIndex.select,false)

self.selectThemeIndex=index
item:SetChildActive(CmpThemeItemIndex.select,true)

self:refreshTaskList()
self:refreshModel()
self:startTimer()
end
end)
end

end

function UITianjiangfuyuanWin:refreshTaskList()
local themeData=self.themeDataList[self.selectThemeIndex]





local taskList=tianJiangFuYuanModel:getThemeTaskList(themeData.themeId)
self.taskList:freshGridsNum(#taskList,1,#taskList)


local index=themeData.recvRewardMaxIndex
self.taskList:jumpToLockY(index-1)
end

function UITianjiangfuyuanWin:bindTaskWidget(index,item)
local themeId=self.themeDataList[self.selectThemeIndex].themeId
local taskData=tianJiangFuYuanModel:getThemeTaskData(themeId,index)
local isShow=taskData~=nil
item:SetChildActive(-1,isShow)

if isShow then
self:refreshTask(index,item,taskData)
end
end

function UITianjiangfuyuanWin:refreshTask(task_index,item,taskData)

local themeData=self.themeDataList[self.selectThemeIndex]
local themeId=themeData.themeId
local itemLen=#taskData.items
local recvState=tianJiangFuYuanModel:getTaskStateByIndex(themeId,task_index)
local beforeItemState
if task_index>1 then
beforeItemState=tianJiangFuYuanModel:getTaskStateByIndex(themeId,task_index-1)
else
beforeItemState=true
end
local isActive=beforeItemState or recvState
local bgResIconName=taskData.isRecharge and'image_tianjiangfuyuan_6'or'image_tianjiangfuyuan_5'
local taskMaskIconName=taskData.isRecharge and'image_tianjiangfuyuan_10'or'image_tianjiangfuyuan_11'



item:SetChildActive(CmpTaskItemIndex.lock,not isActive)
item:SetChildActive(CmpTaskItemIndex.mask,not isActive)

item:SetChildActive(CmpTaskItemIndex.jiantou,task_index~=1)
item:SetChildActive(CmpTaskItemIndex.hjiantou,not isActive)

item:SetChildActive(CmpTaskItemIndex.recvImg,recvState)

item:SetChildActive(CmpTaskItemIndex.reddot,not taskData.isRecharge and isActive)

item:SetChildCSImageSprite(CmpTaskItemIndex.bg,ab,bgResIconName)
if not isActive then
item:SetChildCSImageSprite(CmpTaskItemIndex.mask,ab,taskMaskIconName)
end

item:SetChildActive(CmpTaskItemIndex.freeBtn,not taskData.isRecharge and not recvState)
item:SetChildActive(CmpTaskItemIndex.czBtn,taskData.isRecharge and not recvState)
if taskData.isRecharge and not recvState then
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,taskData.rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
item:SetChildText(CmpTaskItemIndex.czVal,str)
end

item:SetChildActive(CmpTaskItemIndex.layout1,itemLen>0)
item:SetChildActive(CmpTaskItemIndex.layout2,itemLen>1)
for itemIndex=1,4 do
local itemCmpIndex=FMT.fmt("item{0}",itemIndex)
local itemBgCmpIndex=FMT.fmt("item{0}bg",itemIndex)
local isShowItem=itemIndex<=itemLen
item:SetChildActive(CmpTaskItemIndex[itemBgCmpIndex],isShowItem)
if isShowItem then
local itemData=taskData.items[itemIndex]
local itemid=itemData[1]
local itemnum=itemData[2]

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
item:SetChildPropData(CmpTaskItemIndex[itemCmpIndex],prop)
item:SetBaseItemClickEvent(CmpTaskItemIndex[itemCmpIndex],function(...)
if _this==nil then return end

itemsComponentHelper.onItemClick(...)
end)
end
end


item:SetChildButtonClick(CmpTaskItemIndex.freeBtn,function()
if isActive then
tianJiangFuYuanController:req_15_73(themeId)
else
UIManager.info("需先领取前一个礼包才能领取")
end
end)

item:SetChildButtonClick(CmpTaskItemIndex.czBtn,function()
if isActive then
payControl.reqPay(taskData.rechargeId,1,themeId)
else
UIManager.info("需先领取前一个礼包才能购买")
end
end)
end

function UITianjiangfuyuanWin:refreshModel()
local themeData=self.themeDataList[self.selectThemeIndex]
local themeId=themeData.themeId

local modelParam=cfgHelper.get2(cfg_themegiftconfig_get,themeId,'show_itemId')
local isShow=modelParam~=nil
self.modelbg:setActive(isShow)
self:clearBt()
if isShow then
local itemid=modelParam[1]
local param=modelParam[2]
local itemName=modelParam[3]or itemsModel.getName(itemid)
self.itemName:setText(itemName)
local modelid=param[1]
local scale=param[2]
local compoments=param[3]
local animation=param[4]
local offset=param[5]
local flipx=param[6]
self.model:setChildUIModelShowTarget(modelid,scale,compoments,animation,false,false,0.2,nil)
self.model:setChildUIModelShowTargetOffset(offset[1],offset[2])
self.model:setChildUIModelShowFlipX(flipx==1)

local speakParam=cfgHelper.get2(cfg_themegiftconfig_get,themeId,'speakParam')
if speakParam~=nil then

local initData={
winName='UITianjiangfuyuanWin',
winFunc='setSpeakContent',
widget=self.winlua,
target=self.model:getID(),
duration=speakParam[1],
skin=speakParam[2],
offset=speakParam[3],
interval=speakParam[4],

defaultAnim=animation,

content="",
animState=0,
}
self.speakBt=behaviorManager:addBehaviorTree('bt_ui_common_speak',nil,true,initData)
end
end
end

function UITianjiangfuyuanWin:setSpeakContent(bt)
local themeData=self.themeDataList[self.selectThemeIndex]
local themeId=themeData.themeId
local speakParam=cfgHelper.get2(cfg_themegiftconfig_get,themeId,'speakParam')

if not speakParam then
self:clearBt()
return
end

local speakContentList=speakParam[5]
local randomIndex=Mathf.Random(1,#speakContentList)
local content=speakContentList[randomIndex][1]
local animId=speakContentList[randomIndex][2]
bt:setSharedVar('content',content)
if animId then
bt:setSharedVar('animState',1)
bt:setSharedVar('animId',animId)
end
end

function UITianjiangfuyuanWin:clearBt()
if self.speakBt then
behaviorManager:removeBehaviorTree(self.speakBt)
self.speakBt=nil
end
end


function UITianjiangfuyuanWin:startTimer()

self:stopTimer()

local themeId=self.themeDataList[self.selectThemeIndex].themeId
local leftStamp=tianJiangFuYuanModel:getThemeLeftTime(themeId)

local func=function()
if not _this then return end

local serverTime=timeHelper.getServerShortTime()
local left=leftStamp-serverTime
if left>0 then
local timeStr=timeHelper.format_time_stamp3(left)
local showStr=FMT.fmt("{0}后结束",timeStr)
_this.countdowntxt:setText(showStr)
end
end

self.timeId=self:setTimer(1,0,func)
func()
end

function UITianjiangfuyuanWin:stopTimer()

if self.timeId then
self:stopTimerByID(self.timeId)
self.timeId=nil
end

end





function UITianjiangfuyuanWin:onCloseBtn()
if self.isFull then
UIFullTianJiangFuYuanControl:closeUI()
else
self:closeSelf()
end
end

function UITianjiangfuyuanWin:onClickModel()
if self.selectThemeIndex==nil then return end
local themeData=self.themeDataList[self.selectThemeIndex]
if themeData==nil then return end
local themeId=themeData.themeId
local modelParam=cfgHelper.get2(cfg_themegiftconfig_get,themeId,'show_itemId')
if modelParam==nil then return end
local itemid=modelParam[1]
itemsComponentHelper.onItemClick(itemid)
end

function UITianjiangfuyuanWin:onItemInfobtn()
self:onClickModel()
end

