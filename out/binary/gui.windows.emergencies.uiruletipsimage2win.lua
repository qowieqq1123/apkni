







def_class("UIRuleTipsImage2Win",UIWindowBase)









function UIRuleTipsImage2Win:bindComponents()

self.spinebg=UIObject.get(self,0)
self.view=UIScrollView.get(self,1)
self.packScrollerView=UIObject.get(self,2)
self.left=UIObject.get(self,3)
self.right=UIObject.get(self,4)
self.pointScrollerView=UIObject.get(self,5)
self.leftBtn=UIButton.get(self,6)
self.rightBtn=UIButton.get(self,7)
self.pointContent=UIObject.get(self,8)
self.pointProgressBar=UIObject.get(self,9)
self.pointProgressValue=UIObject.get(self,10)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UIRuleTipsImage2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.view);self.view=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.pointScrollerView);self.pointScrollerView=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.pointContent);self.pointContent=nil;
_UIObject_release(self.pointProgressBar);self.pointProgressBar=nil;
_UIObject_release(self.pointProgressValue);self.pointProgressValue=nil;
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
}

local showModelType={
eGubao=1,
eBuilding=2,
}
local _this


local items_cmp=
{
panela=1,
tipstext=2,
tipstitle=12,

panelb=3,
imagea=4,
bga=5,
texta=6,
textatitle=7,

imageb=8,
bgb=9,
textb=10,
textbtitle=11,

}

local abname_yyhy='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'


function UIRuleTipsImage2Win:onLoaded(...)
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


function UIRuleTipsImage2Win:__delete()
_this=nil
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
end
self:unbindComponents()
end




function UIRuleTipsImage2Win:onShow(argtable,afterOnloaded)
self.ruleGroupID=argtable.ruleGroupID
self.view:setChildCanvasGroupDOFade(0,0,nil)

self:refreshScrollerView()
self:checkArrowBtn()
local delay=0.3
if argtable.page then
self.smooting=1000
end
self.spinebg:setChildUIModelShowTarget(4086,1,{},0,false,false,0.3,function()
self:delayDo(delay,function()
self.smooting=10
_this.view:setChildCanvasGroupDOFade(1,0.2,nil)
end)
end)

if argtable.page then
self:onClickPagePoint(argtable.page,true)
end
end


function UIRuleTipsImage2Win:onHide()

end


function UIRuleTipsImage2Win:refreshScrollerView()
local gcfg=cfgHelper.get1(cfg_ruletipsimagegroupconfig_get,self.ruleGroupID)
self.showList={}



if gcfg.group then
local n=#gcfg.group
for i=1,n,2 do
local d={}
local cfg1,cfg2
local idx=gcfg.group[i]
if idx then
cfg1=cfgHelper.get1(cfg_ruletipsimageconfig_get,idx)
end
idx=gcfg.group[i+1]
if idx then
cfg2=cfgHelper.get1(cfg_ruletipsimageconfig_get,idx)
end
table.insert(self.showList,{cfg1=cfg1,cfg2=cfg2})
end
else
if gcfg.textgroup then
local n=#gcfg.textgroup
for i=1,n do
local cfg
local idx=gcfg.textgroup[i]
if idx then
cfg=cfgHelper.get1(cfg_ruletipstextconfig_get,idx)
table.insert(self.showList,{desc=cfg.desc,title=cfg.title})
end
end
end
end
if gcfg.desc then
if gcfg.descPos then
if gcfg.descPos==-1 then
table.insert(self.showList,{desc=gcfg.desc})
else
table.insert(self.showList,gcfg.descPos,{desc=gcfg.desc})
end
else
table.insert(self.showList,1,{desc=gcfg.desc})
end

end

self.pageCount=#self.showList
self.pageLength=1/((self.pageCount-1)==1 and 1 or(self.pageCount-1))
self.packScrollerView:setChildScrollViewCreateGrids(self.pageCount,self.pageCount)

local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local d=self.showList[i]
if d.desc~=nil then
item:SetChildActive(items_cmp.panela,true)
item:SetChildActive(items_cmp.panelb,false)
item:SetChildText(items_cmp.tipstext,d.desc)
if d.title then
item:SetChildText(items_cmp.tipstitle,d.title)
end
else
item:SetChildActive(items_cmp.panela,false)
item:SetChildActive(items_cmp.panelb,true)
local show1=d.cfg1~=nil
local show2=d.cfg2~=nil
item:SetChildActive(items_cmp.imagea,show1)
item:SetChildActive(items_cmp.imageb,show2)

if show1 then
item:SetChildCSImageSprite(items_cmp.bga,d.cfg1.image[1],d.cfg1.image[2])
item:SetChildText(items_cmp.textatitle,d.cfg1.title)
item:SetChildText(items_cmp.texta,d.cfg1.desc)
end
if show2 then
item:SetChildCSImageSprite(items_cmp.bgb,d.cfg2.image[1],d.cfg2.image[2])
item:SetChildText(items_cmp.textbtitle,d.cfg2.title)
item:SetChildText(items_cmp.textb,d.cfg2.desc)
end
end
end
end


if self.ruleGroupID and self.ruleGroupID==ruleTipsImageGroup.eMoJieForceSkill then
if self.showList and#self.showList==1 then
self.pointScrollerView:setActive(false)
end
end
self:refreshPointScrollerView()
end


function UIRuleTipsImage2Win:refreshPointScrollerView()
_this.pointScrollerView:setChildScrollViewCreateGrids(_this.pageCount,_this.pageCount)

local grids=_this.pointScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then

item:SetChildButtonClick(point_cmp_index.click,function()
_this:onClickPagePoint(i)
end)


item:SetChildActive(point_cmp_index.select,_this.pageIndex==i-1)
end
end
end


function UIRuleTipsImage2Win:checkArrowBtn()

_this.left:setActive(_this.pageIndex>0)

_this.right:setActive(_this.pageIndex<_this.pageCount-1)
end


function UIRuleTipsImage2Win:onLeftBtn()
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


function UIRuleTipsImage2Win:onRightBtn()
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

function UIRuleTipsImage2Win:onClickPagePoint(index,immediately)
if _this.pageIndex==index-1 then
return
end


_this.pageIndex=index-1
_this.targetHor=_this.pageLength*_this.pageIndex

_this:checkArrowBtn()

_this:refreshPointScrollerView()

if immediately then
_this.winlua:SetChildScrollRectNormalizedPosition(_this.pointScrollerView:getID(),true,_this.targetHor)
end
end



function UIRuleTipsImage2Win.beginDragCallback()
_this.isDrag=true
end

function UIRuleTipsImage2Win.endDragCallback()
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

function UIRuleTipsImage2Win.onScrollChanged()
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

function UIRuleTipsImage2Win.pointBeginDragCallback()
_this.isAutoMovePoint=false
end

function UIRuleTipsImage2Win.testChangSmooting(smooting)
_this.smooting=smooting
UIManager.info(FMT.fmt("页面切换速度更改为: {0}",_this.smooting))
end