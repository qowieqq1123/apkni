







def_class("UIShiLianZhengTu_MainWin",UIWindowBase)









function UIShiLianZhengTu_MainWin:bindComponents()

self.lock=UIObject.get(self,0)
self.buyBtn=UIButton.get(self,1)
self.priceLeft=UIText.get(self,2)
self.listScroller=UIObject.get(self,3)
self.click=UIButton.get(self,4)
self.btnClose=UIButton.get(self,5)
self.menuScrollView=UIObject.get(self,6)
self.listBg=UIImage.get(self,7)
self.bgEffModel=UIObject.get(self,8)
self.cloudModel=UIObject.get(self,9)
self.Image=UIImage.get(self,10)
self.priceRight=UIText.get(self,11)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.click:setButtonClick(function()self:onClick()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIShiLianZhengTu_MainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.priceLeft);self.priceLeft=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.menuScrollView);self.menuScrollView=nil;
_UIObject_release(self.listBg);self.listBg=nil;
_UIObject_release(self.bgEffModel);self.bgEffModel=nil;
_UIObject_release(self.cloudModel);self.cloudModel=nil;
_UIObject_release(self.Image);self.Image=nil;
_UIObject_release(self.priceRight);self.priceRight=nil;
end

















local menuCmpIndex={
cmpSelfItem=0,
cmpName=1,
cmpReddot=2,
cmpBg=3,
select=4,
top=5,
}

local taskItemIndex={
select=0,
taskDesc=1,
baseRewards=2,
upRewards=3,
getRewardBtn=4,
rewardBtnText=5,
gotFlag=6,
unfinishFlag=7,
rewardBtnReddot=8,
}


local PfSpriteCfg=
{
[pfwindowslController.priceTypeStr.CNY]={'image_shilianzhengtu_20',{-122.5,0},1},
[pfwindowslController.priceTypeStr.USD]={'image_shilianzhengtu_21',{-204,0},2},
[pfwindowslController.priceTypeStr.HKD]={'image_shilianzhengtu_22',{-204,0},2},
[pfwindowslController.priceTypeStr.TWD]={'image_shilianzhengtu_23',{-204,0},2},
[pfwindowslController.priceTypeStr.VND]={'image_shilianzhengtu_20',{-122.5,0},1},
}


local _this=nil
local _scrollLen=7
local _defaultSelectPageIndex=1



function UIShiLianZhengTu_MainWin:onLoaded(...)
_this=self
self:bindComponents()


self.menuScrollView:setChildScrollViewInit(0,true,function(...)self:onClickMenu(...)end)
end


function UIShiLianZhengTu_MainWin:__delete()

self:unbindComponents()
_this=nil
end




function UIShiLianZhengTu_MainWin:onShow(argtable,afterOnloaded)
self.jumpMenuId=argtable and argtable.jumpMenuId
self.allMenuCfg=cfg_traintowerzhengtutagconfig()


shiLianTaController:getShiLianZhengTuData()

self:refresh(true)


local modelId=4213
self.cloudModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.stand)
end

function UIShiLianZhengTu_MainWin:refresh(init)

self:refreshMenu(init)

end


function UIShiLianZhengTu_MainWin:onHide()

end


function UIShiLianZhengTu_MainWin:refreshMenu(init)
if init then

self.menuList=self:getMenuList()
end

local tNum=#self.menuList
self.menuScrollView:setChildScrollRectEnable(tNum>_scrollLen)

self.menuScrollView:setChildScrollViewCreateGrids(tNum,1)
for i,v in ipairs(self.menuList)do
self:fillMenu(i,v,init)
end

if init then

local initPageIndex=self.initPageIndex or _defaultSelectPageIndex
if self.initPageIndex then
self.initPageIndex=nil
end
self:onClickMenu(nil,initPageIndex-1)
end
end

function UIShiLianZhengTu_MainWin:fillMenu(index,menuCfg,init)
local tabIndex=index
local selectMenuIdx=self.selectMenuIdx
local isSelect=selectMenuIdx==index

local item=self.menuScrollView:getChildScrollViewItemWidget(index-1)

item:SetChildActive(menuCmpIndex.select,isSelect)
local tabName
if isSelect then
tabName=FMT.fmt("<color=#fff9f9>{0}</color>",menuCfg.name)
else
tabName=FMT.fmt("<color=#ffeee1>{0}</color>",menuCfg.name)
end
item:SetChildText(menuCmpIndex.cmpName,tabName)
if init then

local btnAbName="ui/windows/shilianta/shilianzhengtu_button_atlas_pak.ab"
local normalImageName
if menuCfg.cfg.menuImage then
normalImageName=menuCfg.cfg.menuImage
else
normalImageName="button_shilianzhengtu_3"
end
item:SetChildCSImageSprite(menuCmpIndex.cmpBg,btnAbName,normalImageName)
end

local menuId=menuCfg.id
local isreddot=shiLianTaController:checkShiLianZhengTuMenuReddot(menuId)
if init and self.jumpMenuId and menuId==self.jumpMenuId then
self.initPageIndex=index
self.jumpMenuId=nil
end

item:SetChildActive(menuCmpIndex.cmpReddot,isreddot)
item:SetChildActive(menuCmpIndex.top,index==1)
end

function UIShiLianZhengTu_MainWin:freshMenuSelect(index)
if index==nil then
return
end

local menuCfg=self.menuList[index]
if not menuCfg then
return
end

local selectMenuIdx=self.selectMenuIdx

local item=self.menuScrollView:getChildScrollViewItemWidget(index-1)

local isSelect=selectMenuIdx~=index
item:SetChildActive(menuCmpIndex.select,isSelect)
local tabName
if isSelect then
tabName=FMT.fmt("<color=#fff9f9>{0}</color>",menuCfg.name)
else
tabName=FMT.fmt("<color=#ffeee1>{0}</color>",menuCfg.name)
end
item:SetChildText(menuCmpIndex.cmpName,tabName)
item:SetChildActive(menuCmpIndex.top,index==1)
end

function UIShiLianZhengTu_MainWin:getMenuList()
local menuList={}
for i,v in ipairs(self.allMenuCfg)do
local menuCfg={
id=v.id,
name=v.name,
rechargeId=v.czId,
cfg=v,
}


local menuId=v.id
local isUnlock=shiLianTaController:checkShiLianZhengTuMenu(menuId)

if isUnlock then
table.insert(menuList,menuCfg)
end
end

return menuList
end

function UIShiLianZhengTu_MainWin:refreshPage(refreshMenuId,needAutoJump)
local menuCfg=self.menuList[self.selectMenuIdx]
local menuId=menuCfg.id
if refreshMenuId and menuId~=refreshMenuId then
return
end


self:refreshListTop()


self:refreshTaskList(needAutoJump)


if menuCfg.cfg.listBgImageName then
local listBgAbName="ui/windows/shilianta/shilianzhengtu_listbg_atlas_pak.ab"
self.listBg:setSprite(listBgAbName,menuCfg.cfg.listBgImageName)
self.listBg:setActive(true)
else
self.listBg:setActive(false)
end


if menuCfg.cfg.bgEffModelParam then
local modelParam=menuCfg.cfg.bgEffModelParam
local modelId=modelParam.modelid
local animId=modelParam.animid or eAnimationID.stand
local size=modelParam.size or 1
local offset=modelParam.offset or{0,0}
self.bgEffModel:setChildUIModelShowTarget(modelId,size,{},animId)
self.bgEffModel:setChildUIModelShowTargetOffset(offset[1],offset[2])
else

self.bgEffModel:setChildUIModelRemoveTarget()
end
end


function UIShiLianZhengTu_MainWin:refreshListTop()
local menuCfg=self.menuList[self.selectMenuIdx]
local menuId=menuCfg.id

self.isBuyChaozhi=shiLianTaModel:checkShiLianZhengTuIsRechargeByMenuId(menuId)


self.lock:setActive(not self.isBuyChaozhi)

self.buyBtn:setActive(not self.isBuyChaozhi)
self.click:setActive(not self.isBuyChaozhi)
if not self.isBuyChaozhi then

local rechargeId=menuCfg.rechargeId
local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,rechargeId)
local price=rechargeCfg.rmb
if price then
local MoneyType=pfwindowslController:getPFMoneyType()
local GameVersion=pfwindowslController:getGameVersion()
local cfg=PfSpriteCfg[MoneyType]
local moneyCount=rechargeCfg.pay[GameVersion][MoneyType]
if cfg then
local isLeft=cfg[3]==1
self.priceLeft:setActive(isLeft)
self.priceRight:setActive(not isLeft)
if isLeft then
self.priceLeft:setText(moneyCount)
else
self.priceRight:setText(moneyCount)
end


self.Image:setSprite(globalABLookup.shilianzhengtu_base_atlas,cfg[1],true)
self.Image:setChildAnchoredPosition(Vector2.New(cfg[2][1],cfg[2][2]))
end
else
logErr(FMT.fmt("找不到充值id: {0}对应的rmb价格配置",rechargeId))
end
end
end




function UIShiLianZhengTu_MainWin:refreshTaskList(needAutoJump)

self.autoJumpIndex=nil

self.firstUnfinishTaskIndex=nil

local menuCfg=self.menuList[self.selectMenuIdx]
local menuId=menuCfg.id

self.pageTaskList=self:getSortTaskListByMenuId(menuId)
local count=#self.pageTaskList
self.listScroller:setChildScrollRectEnable(false)
self.listScroller:setChildScrollViewCreateGrids(count,1)
self.listScroller:setChildScrollRectEnable(true)

local grids=self.listScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshTaskItem(grids[i-1],i)
end

if needAutoJump then

if not self.autoJumpIndex then

self.autoJumpIndex=self.firstUnfinishTaskIndex or 0
end


local jumpIndex=self.autoJumpIndex-1
if jumpIndex<0 then
jumpIndex=0
end

self.listScroller:setChildScrollViewSelectItem(jumpIndex,false,false,false)
end
end


function UIShiLianZhengTu_MainWin:refreshTaskItem(item,index)
if item==nil then
item=self.listScroller:getChildScrollViewItemWidget(index-1)
end

local menuCfg=self.menuList[self.selectMenuIdx]
local menuId=menuCfg.id
local nowClearFloor=shiLianTaModel:getClearLayer()
local taskData=self.pageTaskList[index]
if item and taskData then

local targetFloor=taskData.targetFloor
local isFinish=nowClearFloor>=targetFloor
local numStr
if isFinish then
numStr=FMT.cfmt(FONT_COLOR.eGreenColor,"{0}/{1}",nowClearFloor,targetFloor)
else
numStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",nowClearFloor,targetFloor)
end
local descStr=FMT.fmt("锁妖塔通关({0})层",numStr)
item:SetChildText(taskItemIndex.taskDesc,descStr)


item:SetChildActive(taskItemIndex.unfinishFlag,not isFinish)



local taskGotState=shiLianTaModel:checkShiLianZhengTuTaskState(menuId,targetFloor)
item:SetChildActive(taskItemIndex.getRewardBtn,isFinish and taskGotState~=2)
local rewardBtnText="继续领取"
if taskGotState==1 and self.isBuyChaozhi or taskGotState==0 then
rewardBtnText="领取"
end

item:SetChildText(taskItemIndex.rewardBtnText,rewardBtnText)
item:SetChildButtonClick(taskItemIndex.getRewardBtn,function()
self:onClickGetRewardBtn(menuId,taskGotState)
end)


local isShowReddot=false
if isFinish and taskGotState~=2 then
if taskGotState==0 then
isShowReddot=true
elseif taskGotState==1 and self.isBuyChaozhi then
isShowReddot=true
end
end
item:SetChildActive(taskItemIndex.rewardBtnReddot,isShowReddot)


item:SetChildActive(taskItemIndex.gotFlag,isFinish and taskGotState==2)





local baseRewards=taskData.baseRewards
item:SetChildLayoutGroupCreateItems(taskItemIndex.baseRewards,#baseRewards)
local grids=item:GetChildLayoutGroupGridList(taskItemIndex.baseRewards)
for i=1,#baseRewards do
local widget=grids[i-1]
local reward=baseRewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


local isGot=taskGotState~=0
local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


widget:SetChildActive(1,isGot)
end


local upRewards=taskData.rechargeRewards
item:SetChildLayoutGroupCreateItems(taskItemIndex.upRewards,#upRewards)
local grids=item:GetChildLayoutGroupGridList(taskItemIndex.upRewards)
for i=1,#upRewards do
local widget=grids[i-1]
local reward=upRewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


local isLock=not self.isBuyChaozhi
local isGot=taskGotState==2
local isGrayMask=isGot or isLock
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


widget:SetChildActive(1,isGot)
end


if isFinish and not self.autoJumpIndex then

if taskGotState==1 and self.isBuyChaozhi or taskGotState==0 then

self.autoJumpIndex=index-1
end
elseif not isFinish then

local nowIndex=index-1
if not self.firstUnfinishTaskIndex or nowIndex<self.firstUnfinishTaskIndex then

self.firstUnfinishTaskIndex=nowIndex
end
end
end
end

function UIShiLianZhengTu_MainWin:getSortTaskListByMenuId(menuId)
local sortList={}
local taskCfgList=cfgHelper.get1(cfg_traintowerzhengturewardconfig_get,menuId)

if not taskCfgList then
logErr(FMT.fmt("找不到页签id为{0}对应的试炼奖励列表 请检查配置是否正确",menuId))
return sortList
end
local nowClearFloor=shiLianTaModel:getClearLayer()
for i,v in pairs(taskCfgList)do
local targetFloor=v.id
local sortWeight=targetFloor

local isFinish=nowClearFloor>=targetFloor
if isFinish then
sortWeight=sortWeight-100000
end

local taskGotState=shiLianTaModel:checkShiLianZhengTuTaskState(menuId,targetFloor)
local isGot=taskGotState==2
if isGot then
sortWeight=sortWeight+1000000
end

local taskItem={
targetFloor=targetFloor,
baseRewards=v.freeItems,
rechargeRewards=v.moneyItems,
sortWeight=sortWeight,
}

table.insert(sortList,taskItem)
end


table.sort(sortList,function(a,b)
return a.sortWeight<b.sortWeight
end)

return sortList
end





function UIShiLianZhengTu_MainWin:onBuyBtn()
local menuCfg=self.menuList[self.selectMenuIdx]
local menuId=menuCfg.id
shiLianTaController:showShiLianZhengTuBuyWindow(menuId)
end



function UIShiLianZhengTu_MainWin:onClick()
local menuCfg=self.menuList[self.selectMenuIdx]
local menuId=menuCfg.id
shiLianTaController:showShiLianZhengTuBuyWindow(menuId)
end

function UIShiLianZhengTu_MainWin:onBtnClose()
self:closeSelf()
end

function UIShiLianZhengTu_MainWin:onClickMenu(id,index,guid,attach)
local menuIdx=index+1
if menuIdx==self.selectMenuIdx then
return
end

if self.menuList[menuIdx]then
self:freshMenuSelect(self.selectMenuIdx)
self:freshMenuSelect(menuIdx)
self.selectMenuIdx=menuIdx

AudioManager.playOpenUI()
end


self:refreshPage(nil,true)

end


function UIShiLianZhengTu_MainWin:onClickGetRewardBtn(menuId,taskGotState)
if taskGotState==1 and not self.isBuyChaozhi then


shiLianTaController:showShiLianZhengTuBuyWindow(menuId)
return
end


shiLianTaController:getShiLianZhengTuRewardByMenuId(menuId)
end

function UIShiLianZhengTu_MainWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end
