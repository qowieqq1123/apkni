







def_class("UIZhenBaoGeWin",UIWindowBase)









function UIZhenBaoGeWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.sloganImg1=UIImage.get(self,1)
self.Text=UIText.get(self,2)
self.packScrollerView=UIObject.get(self,3)
self.leftBtn=UIButton.get(self,4)
self.rightBtn=UIButton.get(self,5)
self.pointScrollerView=UIObject.get(self,6)
self.pointContent=UIObject.get(self,7)
self.leftReddot=UIImage.get(self,8)
self.rightReddot=UIImage.get(self,9)
self.left=UIObject.get(self,10)
self.right=UIObject.get(self,11)
self.pointProgressBar=UIImage.get(self,12)
self.pointProgressValue=UIImage.get(self,13)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIZhenBaoGeWin")end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UIZhenBaoGeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.sloganImg1);self.sloganImg1=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.pointScrollerView);self.pointScrollerView=nil;
_UIObject_release(self.pointContent);self.pointContent=nil;
_UIObject_release(self.leftReddot);self.leftReddot=nil;
_UIObject_release(self.rightReddot);self.rightReddot=nil;
end


local _this

















local cmp_index=
{
root=0,
icon=1,
name=2,
targetText=3,
getBtn=4,
got=5,
rewardItem1=6,
rewardItem2=7,
rewardItem3=8,
rewardItem4=9,
progress=10,
desc=11,
effectDesc=12,
rewardType=13,
buildingModel=14,
playerImageChangeMask=15,
playerImageChangeModel=16,
}
local point_cmp_index=
{
click=0,
select=1,
finishFlag=2,
gotFlag=3,
}

local showModelType={
eGubao=1,
eBuilding=2,
ePlayerimagechange=3,
}


function UIZhenBaoGeWin:onLoaded(...)
_this=self
self:bindComponents()

self.pageCount=0
self.pageLength=1
self.pageIndex=0
self.isDrag=false
self.targetHor=0
self.smooting=10

self.pointTargetHor=0
self.pointSmooting=6
self.isAutoMovePoint=false
self.startAutoMoveDV=0.001

self.isFastJump=false

self.winlua:SetChildUIDragEvent(self.packScrollerView:getID(),0,self.beginDragCallback,self.endDragCallback,nil)
self.winlua:SetChildUIDragEvent(self.pointScrollerView:getID(),0,self.pointBeginDragCallback,nil,nil)

self.updateTimer=self:setTimer(0.02,0,self.onScrollChanged)
if not pfwindowslController:checkIsGameVersion_guofu()then
self.Text:setText("每储值10仙玉可获得1仙缘")
end
end


function UIZhenBaoGeWin:__delete()
self:endAllReddotPunchRotation()
_this=nil
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
end
self:unbindComponents()
end




function UIZhenBaoGeWin:onShow(argtable,afterOnloaded)
if argtable then
self.jumpToGet=argtable
end
self:refreshScrollerView()
self:initFirstShowPage()
self:checkArrowBtn()
end


function UIZhenBaoGeWin:onHide()
self:endAllReddotPunchRotation()
end

function UIZhenBaoGeWin:refreshScrollerView()
local sortList=rechargeModel:getZhenBaoGeSortList()
self.showList={}
local money=rechargeModel:getTotalRecharge()/10
for i,v in ipairs(sortList)do
if rechargeModel:canZhenBaoGeShow(v.id)then













table.insert(self.showList,v)
end
end





local getIndex=nil
self.pageCount=#self.showList
self.pageLength=1/((self.pageCount-1)==1 and 1 or(self.pageCount-1))
self.packScrollerView:setChildScrollViewCreateGrids(self.pageCount,self.pageCount)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local config=self.showList[i]
if config then
local got=rechargeModel:getZhenBaoGeData(config.id)
local target=rechargeModel:getZhenBaoGetarget(config.target)
local canGet=(not got)and money>=target

if canGet and not getIndex then
getIndex=i
end











self:setShowItemInfo(item,config.showItem,config)


local dValue=target-money
item:SetChildText(cmp_index.targetText,FMT.fmt('再获得 <color=#549327>{0}</color> 仙缘\n可获得奖励',dValue))
item:SetChildActive(cmp_index.targetText,not canGet and not got)


item:SetChildProgressValue(cmp_index.progress,money,target)
item:SetChildProgressText(cmp_index.progress,FMT.fmt('{0}/{1}',money,target))


item:SetChildActive(cmp_index.got,got)
item:SetChildActive(cmp_index.getBtn,canGet)


local rewards=config.rewards
for i=0,3 do
item:SetChildActive(cmp_index.rewardItem1+i,i<#rewards)
if i<#rewards then
local reward=rewards[i+1]
local itemid=reward[1]
local itemCount=reward[2]
local count=itemCount>1 and itemCount or''
local conf={itemid=itemid,itemcount=count,showCountBG=count~=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


item:SetChildPropData(cmp_index.rewardItem1+i,prop)
local func=function(...)
self:onClickRewardItem(...)
end
item:SetBaseItemClickEvent(cmp_index.rewardItem1+i,func)
end
end

item:SetChildButtonClick(cmp_index.getBtn,function()
self:onClickGetBtn(config.id)
end)
end
end
end


self:refreshPointScrollerView()

if getIndex and self.jumpToGet then
self.packScrollerView:setChildScrollRectEnable(false)
self.packScrollerView:setChildScrollViewSelectItem(getIndex-1,false,false,false)
self.packScrollerView:setChildScrollRectEnable(true)
end
end


function UIZhenBaoGeWin:refreshPointScrollerView()
self.pointScrollerView:setChildScrollViewCreateGrids(self.pageCount,self.pageCount)
local grids=self.pointScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
local finishIndex=0
local money=rechargeModel:getTotalRecharge()/10
for i=1,count do
local item=grids[i-1]
if item then
local config=self.showList[i]
if config then
local got=rechargeModel:getZhenBaoGeData(config.id)
local target=rechargeModel:getZhenBaoGetarget(config.target)
local isFinish=money>=target
if isFinish and i>finishIndex then
finishIndex=i
end


item:SetChildActive(point_cmp_index.finishFlag,isFinish)

item:SetChildActive(point_cmp_index.gotFlag,got)


item:SetChildButtonClick(point_cmp_index.click,function()
self:onClickPagePoint(i)
end)


item:SetChildActive(point_cmp_index.select,self.pageIndex==i-1)
end
end
end


local width_sw=self.pointScrollerView:getChildSizeDeltaX()
local width_con=self.pointContent:getChildSizeDeltaX()
local npLength=width_con-width_sw
local width_item=40
local space=40

if npLength>0 then

local point_np=self.winlua:GetChildScrollRectNormalizedPosition(self.pointScrollerView:getID(),true)
local showWidth_left=point_np*npLength
if showWidth_left>npLength then
showWidth_left=npLength
elseif showWidth_left<0 then
showWidth_left=0
end

local showWidth_right=showWidth_left+width_sw

local selectPoint_left=self.pageIndex*(width_item+space)
local selectPoint_right=selectPoint_left+width_item

local newPointTargetHor=self.pointTargetHor
local isNeedMove=false

if selectPoint_left<=showWidth_left then

newPointTargetHor=selectPoint_left/npLength
isNeedMove=true
elseif selectPoint_right>=showWidth_right then

newPointTargetHor=(selectPoint_right-width_sw)/npLength
isNeedMove=true
end

if isNeedMove and math.abs(newPointTargetHor-point_np)>=self.startAutoMoveDV then
self.pointTargetHor=newPointTargetHor
self.isAutoMovePoint=true
end
end


local progressMaxWidth=(width_item+space)*(count-1)
local progressValue=finishIndex/count
local nowProgressWidth=(progressMaxWidth+space)*progressValue-(width_item/2+space)
local height=self.pointProgressBar:getChildSizeDeltaY()
self.pointProgressBar:setChildSizeDelta(progressMaxWidth,height)
self.pointProgressValue:setChildSizeDelta(nowProgressWidth,height)

end


function UIZhenBaoGeWin:setShowItemInfo(itemWidget,showItemConfig,zbgConfig)
local showItemType=showItemConfig[1]
local showItemPram=showItemConfig[2]
local name="未知名称"
local typeIconName=""
local desc=""
local effectDesc=""
local abName="ui/windows/recharge/zhenbaoge_atlas_pak.ab"

itemWidget:SetChildActive(cmp_index.icon,showItemType==showModelType.eGubao)
itemWidget:SetChildActive(cmp_index.buildingModel,showItemType==showModelType.eBuilding)
itemWidget:SetChildActive(cmp_index.playerImageChangeMask,showItemType==showModelType.ePlayerimagechange)
if showItemType==showModelType.eGubao then

local gubaoItemId=showItemPram
local gbId=gubaoLookup:good2GuBao(gubaoItemId)
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbId)


itemWidget:SetChildCSImageIcon(cmp_index.icon,gubaoModel:getGuBaoBigIconName(gbCfg.icon),false)


name=gbCfg.name
typeIconName="image_zbgjlbiaoji_1"


desc=gbCfg.story

local skilllv=1
effectDesc=gubaoModel:getSkillDesc(gbId,skilllv)

elseif showItemType==showModelType.eBuilding then

local bdId=showItemPram.bdid
local size=showItemPram.size or 1
local offset=showItemPram.offset or{0,0}
local animId=showItemPram.anim or eAnimationID.bd_stand
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
if bdcfg then



local model=bdcfg.model[1]
itemWidget:SetChildUIModelShowTarget(cmp_index.buildingModel,model,size,nil,animId)
itemWidget:SetChildUIModelShowTargetOffset(cmp_index.buildingModel,offset[1],offset[2])


name=bdcfg.name
typeIconName="image_zbgjlbiaoji_2"


desc=bdcfg.desc

local level=1
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdId,level)
local buff=levelCfg.effects
if buff then
for k,v in pairs(buff[1].param)do
local bcfg=cfgHelper.get1(cfg_monijybuildconfig_get,k)
effectDesc=FMT.fmt('{0}{1}产量+{2}% ',effectDesc,bcfg.name,v)
end
else

effectDesc=levelCfg.effects_desc
end
else
logErr(FMT.fmt("找不到建筑id:{0} 对应的建筑配置",bdId))
return
end
elseif showItemType==showModelType.ePlayerimagechange then
local sex=playerModel:getActorSex()
local modelParam=showItemConfig[3]and showItemConfig[3][sex]or{}
local playerImageList=playerImageController.getSuitImageList(showItemPram)

local offsetx=modelParam.offsetx or 0
local offsety=modelParam.offsety or 0
local scale=modelParam.scale or 1
local ani=eAnimationID.idle



local widget=itemWidget:GetChildWidgetBase(cmp_index.playerImageChangeModel)
comHelper.setChildPlayerImage(widget,-1,playerImageList,sex,scale,ani,offsetx,offsety,playerController:supportDynamic())

typeIconName="image_zbgjlbiaoji_3"
name=zbgConfig and zbgConfig.modelname or""
desc=zbgConfig and zbgConfig.desc or""
effectDesc=zbgConfig and zbgConfig.effectdesc or""
else
logErr(FMT.fmt("找不到展示类型: {0} 请检查配置是否正确",showItemType))
return
end


itemWidget:SetChildText(cmp_index.name,name)

itemWidget:SetChildCSImageSprite(cmp_index.rewardType,abName,typeIconName)

itemWidget:SetChildText(cmp_index.desc,desc)
itemWidget:SetChildText(cmp_index.effectDesc,effectDesc)
end


function UIZhenBaoGeWin:checkArrowBtn()

self.left:setActive(self.pageIndex>0)

self.right:setActive(self.pageIndex<self.pageCount-1)


local money=rechargeModel:getTotalRecharge()/10
local nowIndex=self.pageIndex+1
local leftIsReddot=false
local rightIsReddot=false


for i=1,nowIndex-1 do
local config=self.showList[i]
if config then
local got=rechargeModel:getZhenBaoGeData(config.id)
local target=rechargeModel:getZhenBaoGetarget(config.target)
local canGet=(not got)and money>=target
if canGet then
leftIsReddot=true
break
end
end
end


for i=nowIndex+1,self.pageCount do
local config=self.showList[i]
if config then
local got=rechargeModel:getZhenBaoGeData(config.id)
local target=rechargeModel:getZhenBaoGetarget(config.target)
local canGet=(not got)and money>=target
if canGet then
rightIsReddot=true
break
end
end
end

self.leftReddot:setActive(leftIsReddot)
self.rightReddot:setActive(rightIsReddot)

self.leftReddotIndex=self:doPunchRotation(self.widget,self.leftReddot:getID(),self.leftReddotIndex,leftIsReddot)
self.rightReddotIndex=self:doPunchRotation(self.widget,self.rightReddot:getID(),self.rightReddotIndex,rightIsReddot)
end


function UIZhenBaoGeWin:initFirstShowPage()

local firstShowIndex=1
local firstCanGetIndex=nil
local firstNotFinishIndex=nil

local money=rechargeModel:getTotalRecharge()/10
for i=1,self.pageCount do
local config=self.showList[i]
if config then
local got=rechargeModel:getZhenBaoGeData(config.id)
local target=rechargeModel:getZhenBaoGetarget(config.target)
local canGet=(not got)and money>=target
local isNotFinish=money<target
if canGet and not firstCanGetIndex then

firstCanGetIndex=i
break
end

if isNotFinish and not firstNotFinishIndex then

firstNotFinishIndex=i
if firstCanGetIndex then
break
end
end

end
end
firstShowIndex=firstCanGetIndex and firstCanGetIndex or firstNotFinishIndex or 1
self.pageIndex=firstShowIndex-1
self.targetHor=self.pageLength*self.pageIndex

self.packScrollerView:setChildScrollViewSelectItem(self.pageIndex,false,false,false)
self.pointScrollerView:setChildScrollViewSelectItem(self.pageIndex,false,false,false)

self:refreshPointScrollerView()
end

function UIZhenBaoGeWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 or itemId==0 then
return
end
if itemsConfig.isGubao(itemId)then
local gbid=gubaoLookup:good2GuBao(itemId)
tipsManager.showTipsGB({formType=TIPS_FORM_TYPE.eGubaoWin,tipsType=TIPS_TYPE.eCommonGubao,itemid=gbid,bg=false})
else
tipsManager.showTips({itemid=itemId,itemguid=guid,showModel=true,})
end
end

function UIZhenBaoGeWin:onClickGetBtn(id)
socketManager:send_15_12(id)
end

function UIZhenBaoGeWin:onLeftBtn()
if self.pageIndex-1>=0 then
self.pageIndex=self.pageIndex-1
self.targetHor=self.pageLength*self.pageIndex
end
self:checkArrowBtn()

self:refreshPointScrollerView()
end

function UIZhenBaoGeWin:onRightBtn()
if self.pageIndex+1<self.pageCount then
self.pageIndex=self.pageIndex+1
self.targetHor=self.pageLength*self.pageIndex
end
self:checkArrowBtn()

self:refreshPointScrollerView()
end

function UIZhenBaoGeWin:onClickPagePoint(index)
if self.pageIndex==index-1 then
return
end


self.pageIndex=index-1
self.targetHor=self.pageLength*self.pageIndex

self:checkArrowBtn()

self:refreshPointScrollerView()
end







function UIZhenBaoGeWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
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


function UIZhenBaoGeWin:endAllReddotPunchRotation()
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



function UIZhenBaoGeWin.beginDragCallback()
_this.isDrag=true
end

function UIZhenBaoGeWin.endDragCallback()
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

_this:refreshPointScrollerView()
end

function UIZhenBaoGeWin.onScrollChanged()
if not _this.isDrag then
local np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true)
_this.winlua:SetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true,Mathf.Lerp(np,_this.targetHor,Time.deltaTime*_this.smooting))
end

if _this.isAutoMovePoint then
local point_np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.pointScrollerView:getID(),true)
if math.abs(_this.pointTargetHor-point_np)>=_this.startAutoMoveDV then
_this.winlua:SetChildScrollRectNormalizedPosition(_this.pointScrollerView:getID(),true,Mathf.Lerp(point_np,_this.pointTargetHor,Time.deltaTime*_this.pointSmooting))
else
_this.isAutoMovePoint=false
end
end
end

function UIZhenBaoGeWin.pointBeginDragCallback()
_this.isAutoMovePoint=false
end

function UIZhenBaoGeWin.testChangSmooting(smooting)
_this.smooting=smooting
UIManager.info(FMT.fmt("页面切换速度更改为: {0}",_this.smooting))
end
