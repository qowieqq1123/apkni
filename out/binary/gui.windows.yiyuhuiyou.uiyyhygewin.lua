







def_class("UIYYHYGeWin",UIWindowBase)









function UIYYHYGeWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.sloganImg1=UIImage.get(self,1)
self.Text=UIText.get(self,2)
self.packScrollerView=UIObject.get(self,3)
self.leftBtn=UIButton.get(self,4)
self.rightBtn=UIButton.get(self,5)
self.pointScrollerView=UIObject.get(self,6)
self.pointContent=UIObject.get(self,7)
self.leftReddot=UIObject.get(self,8)
self.rightReddot=UIObject.get(self,9)
self.left=UIObject.get(self,10)
self.right=UIObject.get(self,11)
self.pointProgressBar=UIObject.get(self,12)
self.pointProgressValue=UIObject.get(self,13)
self.spinebg=UIObject.get(self,14)
self.view=UIScrollView.get(self,15)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIYYHYGeWin")end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UIYYHYGeWin:unbindComponents()
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
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.pointProgressBar);self.pointProgressBar=nil;
_UIObject_release(self.pointProgressValue);self.pointProgressValue=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.view);self.view=nil;
end



















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
}
local _this


local items_cmp=
{
panela=15,
panelb=16,
tipstext=17,

bga=18,
bgb=19,
bgc=20,
texta=21,
textb=22,
textc=23,
textatitle=24,
textbtitle=25,
textctitle=26,

panelc=27,
bgd=28,
bge=29,
textd=30,
texte=31,
textdtitle=32,
textetitle=33,

}

local abname_yyhy='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'


function UIYYHYGeWin:onLoaded(...)
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
end


function UIYYHYGeWin:__delete()
self:endAllReddotPunchRotation()
_this=nil
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
end
self:unbindComponents()
end




function UIYYHYGeWin:onShow(argtable,afterOnloaded)


self.view:setChildCanvasGroupDOFade(0,0,nil)


self:refreshScrollerView()

self:checkArrowBtn()

self.spinebg:setChildUIModelShowTarget(4086,1,{},0,false,false,0.3,function()
self:delayDo(0.3,function()
_this.view:setChildCanvasGroupDOFade(1,0.2,nil)
end)
end)
end


function UIYYHYGeWin:onHide()
self:endAllReddotPunchRotation()
end


function UIYYHYGeWin:refreshScrollerView()
local sortList=rechargeModel:getZhenBaoGeSortList()
_this.showList={1,2,3}









local cfg=cfg_yiyuhuiyoubaseconfig_get(1)

_this.pageCount=#_this.showList
_this.pageLength=1/((_this.pageCount-1)==1 and 1 or(_this.pageCount-1))
_this.packScrollerView:setChildScrollViewCreateGrids(_this.pageCount,_this.pageCount)

local grids=_this.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then


















































if i==1 then
item:SetChildActive(items_cmp.panela,true)
item:SetChildActive(items_cmp.panelb,false)
item:SetChildActive(items_cmp.panelc,false)

local tips_text=cfg.tips1
item:SetChildText(items_cmp.tipstext,tips_text)

elseif i==2 then
item:SetChildActive(items_cmp.panela,false)
item:SetChildActive(items_cmp.panelb,true)
item:SetChildActive(items_cmp.panelc,false)

local cfg_data=cfg.tips2


item:SetChildCSImageSprite(items_cmp.bga,abname_yyhy,cfg_data[1][2])
item:SetChildCSImageSprite(items_cmp.bgb,abname_yyhy,cfg_data[2][2])



item:SetChildText(items_cmp.textatitle,cfg_data[1][1])
item:SetChildText(items_cmp.textbtitle,cfg_data[2][1])



item:SetChildText(items_cmp.texta,cfg_data[1][3])
item:SetChildText(items_cmp.textb,cfg_data[2][3])


elseif i==3 then

item:SetChildActive(items_cmp.panela,false)
item:SetChildActive(items_cmp.panelb,false)
item:SetChildActive(items_cmp.panelc,true)

local cfg_data=cfg.tips2


item:SetChildCSImageSprite(items_cmp.bgd,abname_yyhy,cfg_data[3][2])
item:SetChildCSImageSprite(items_cmp.bge,abname_yyhy,cfg_data[4][2])


item:SetChildText(items_cmp.textdtitle,cfg_data[3][1])
item:SetChildText(items_cmp.textetitle,cfg_data[4][1])


item:SetChildText(items_cmp.textd,cfg_data[3][3])
item:SetChildText(items_cmp.texte,cfg_data[4][3])
end
end
end


_this:refreshPointScrollerView()
end


function UIYYHYGeWin:refreshPointScrollerView()
_this.pointScrollerView:setChildScrollViewCreateGrids(_this.pageCount,_this.pageCount)

local grids=_this.pointScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
local finishIndex=0
local money=0

for i=1,count do
local item=grids[i-1]
if item then
local config={}
if config then








item:SetChildActive(point_cmp_index.finishFlag,false)

item:SetChildActive(point_cmp_index.gotFlag,false)


item:SetChildButtonClick(point_cmp_index.click,function()
_this:onClickPagePoint(i)
end)


item:SetChildActive(point_cmp_index.select,_this.pageIndex==i-1)
end
end
end




















































end


function UIYYHYGeWin:setShowItemInfo(itemWidget,showItemConfig)
local showItemType=showItemConfig[1]
local showItemPram=showItemConfig[2]
local name="未知名称"
local typeIconName=""
local desc=""
local effectDesc=""
local abName="ui/windows/recharge/zhenbaoge_atlas_pak.ab"
if showItemType==showModelType.eGubao then

local gubaoItemId=showItemPram
local gbId=gubaoLookup:good2GuBao(gubaoItemId)
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbId)


itemWidget:SetChildActive(cmp_index.icon,true)
itemWidget:SetChildActive(cmp_index.buildingModel,false)
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

itemWidget:SetChildActive(cmp_index.icon,false)
itemWidget:SetChildActive(cmp_index.buildingModel,true)


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
else
logErr(FMT.fmt("找不到展示类型: {0} 请检查配置是否正确",showItemType))
return
end


itemWidget:SetChildText(cmp_index.name,name)

itemWidget:SetChildCSImageSprite(cmp_index.rewardType,abName,typeIconName)

itemWidget:SetChildText(cmp_index.desc,desc)
itemWidget:SetChildText(cmp_index.effectDesc,effectDesc)
end


function UIYYHYGeWin:checkArrowBtn()





_this.left:setActive(true)
_this.right:setActive(true)





local leftIsReddot=false
local rightIsReddot=false































_this.leftReddot:setActive(leftIsReddot)
_this.rightReddot:setActive(rightIsReddot)

_this.leftReddotIndex=_this:doPunchRotation(_this.widget,_this.leftReddot:getID(),_this.leftReddotIndex,leftIsReddot)
_this.rightReddotIndex=_this:doPunchRotation(_this.widget,_this.rightReddot:getID(),_this.rightReddotIndex,rightIsReddot)
end


function UIYYHYGeWin:initFirstShowPage()

local firstShowIndex=1
local firstCanGetIndex=nil
local firstNotFinishIndex=nil

local money=rechargeModel:getTotalRecharge()/10
for i=1,self.pageCount do
local config=self.showList[i]
if config then
local got=rechargeModel:getZhenBaoGeData(config.id)
local target=config.target
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

function UIYYHYGeWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 or itemId==0 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIYYHYGeWin:onClickGetBtn(id)
socketManager:send_15_12(id)
end


function UIYYHYGeWin:onLeftBtn()
if not(_this.pageIndex>0)then
return
end

if _this.pageIndex-1>=0 then
_this.pageIndex=_this.pageIndex-1
_this.targetHor=_this.pageLength*_this.pageIndex
end
_this:checkArrowBtn()

_this:refreshPointScrollerView()
end


function UIYYHYGeWin:onRightBtn()
if not(_this.pageIndex<_this.pageCount-1)then
return
end
if _this.pageIndex+1<_this.pageCount then
_this.pageIndex=_this.pageIndex+1
_this.targetHor=_this.pageLength*_this.pageIndex
end
_this:checkArrowBtn()

_this:refreshPointScrollerView()
end

function UIYYHYGeWin:onClickPagePoint(index)
if _this.pageIndex==index-1 then
return
end


_this.pageIndex=index-1
_this.targetHor=_this.pageLength*_this.pageIndex

_this:checkArrowBtn()

_this:refreshPointScrollerView()
end







function UIYYHYGeWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
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


function UIYYHYGeWin:endAllReddotPunchRotation()
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



function UIYYHYGeWin.beginDragCallback()
_this.isDrag=true
end

function UIYYHYGeWin.endDragCallback()
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

function UIYYHYGeWin.onScrollChanged()
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

function UIYYHYGeWin.pointBeginDragCallback()
_this.isAutoMovePoint=false
end

function UIYYHYGeWin.testChangSmooting(smooting)
_this.smooting=smooting
UIManager.info(FMT.fmt("页面切换速度更改为: {0}",_this.smooting))
end
