







def_class("UISubAct_SZCJ_xinyuanwin",UIWindowBase)









function UISubAct_SZCJ_xinyuanwin:bindComponents()

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
self.xytext=UIText.get(self,16)
self.xytipsbtn=UIButton.get(self,17)
self.closebtn=UIButton.get(self,18)
self.packScrollerViewnew=UIObject.get(self,19)
self.szcjxyPageItema=UIObject.get(self,20)
self.szcjxyPageItemb=UIObject.get(self,21)
self.szcjxyPageItemc=UIObject.get(self,22)
self.szcjxyPageItemd=UIObject.get(self,23)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UISubAct_SZCJ_xinyuanwin")end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.xytipsbtn:setButtonClick(function()self:onXytipsbtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)



end


function UISubAct_SZCJ_xinyuanwin:unbindComponents()
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
_UIObject_release(self.xytext);self.xytext=nil;
_UIObject_release(self.xytipsbtn);self.xytipsbtn=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.packScrollerViewnew);self.packScrollerViewnew=nil;
_UIObject_release(self.szcjxyPageItema);self.szcjxyPageItema=nil;
_UIObject_release(self.szcjxyPageItemb);self.szcjxyPageItemb=nil;
_UIObject_release(self.szcjxyPageItemc);self.szcjxyPageItemc=nil;
_UIObject_release(self.szcjxyPageItemd);self.szcjxyPageItemd=nil;
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

local xinyuanindex=
{
xgbg=34,
xychoose=35,
xymopdel=36,
xyjob=37,
xyquan=38,
xygou=39,
xybtn=40,
xyspinebtn=41,
xyroleimg=42,
effectchoose=43,
galvbtn=45,
gailvimg=44,
}
local xinyuanindextwo=
{
xgbg=0,
xychoose=1,
xymopdel=2,
xyjob=3,
xyquan=4,
xygou=5,
xybtn=6,
xyspinebtn=7,
xyroleimg=8,
effectchoose=9,
galvbtn=10,
gailvimg=11,
}

local abname='ui/windows/activities/sub_shizhuangchoujian/shizhuangchoujian_atlas_pak.ab'


function UISubAct_SZCJ_xinyuanwin:onLoaded(...)
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
self.leftidx=0
self.rightidxnum=0
self.itemperfab={self.szcjxyPageItema,self.szcjxyPageItemb,self.szcjxyPageItemc,self.szcjxyPageItemd}




end


function UISubAct_SZCJ_xinyuanwin:__delete()

_this=nil
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
end
self:unbindComponents()
end




function UISubAct_SZCJ_xinyuanwin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.actid=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subid=argtable.sub_act_id
end
end
self.selectIndex=0

self.packScrollerView:setChildScrollRectEnable(false)
self.spinebg:setChildUIModelShowTarget(4884,1,nil,eAnimationID.stand)
self:refreshScrollerView()
self:checkArrowBtn()
end


function UISubAct_SZCJ_xinyuanwin:onHide()

end


function UISubAct_SZCJ_xinyuanwin:refreshScrollerView()
local mydata=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid)
local cfg=cfg_lotteryact3config_get(_this.subid)


local getIndex=nil
_this.selectIndex=mydata.idx
_this.showList=cfg.showdresslist
_this.pageCount=#_this.showList
_this.pageLength=1/((_this.pageCount-1)==1 and 1 or(_this.pageCount-1))

if#_this.showList<=4 then
_this.packScrollerViewnew:setActive(true)
_this.packScrollerView:setActive(false)
for i=1,#_this.itemperfab do
if i<=#_this.showList then
_this.itemperfab[i]:setActive(true)
local item=_this.itemperfab[i]:getWidgetBase()
if item and _this.showList[i]then

local itemid=_this.showList[i][1]

local job=_this.showList[i][2]
local jobicon=UIDiscipleModel:getJobIconName(job)
item:SetChildCSImageSprite(xinyuanindextwo.xyjob,globalABLookup.global,jobicon)

local bgstr=FMT.fmt("image_qbdzxx_{0}",_this.showList[i][5])
item:SetChildCSImageSprite(xinyuanindextwo.xyroleimg,abname,bgstr)

local scale=_this.showList[i][3]
local modelid=_this.showList[i][4]
item:SetChildUIModelShowTarget(xinyuanindextwo.xymopdel,modelid,scale,{},eAnimationID.stand,false,true)

_this:refreshRoleItemSelect(item,i,_this.selectIndex==i)

item:SetChildButtonClick(xinyuanindextwo.xyspinebtn,function()
if _this==nil then return end
_this:onSuitClick(itemid)
end)

item:SetChildButtonClick(xinyuanindextwo.xybtn,function()
if _this==nil then return end
_this:onRoleItemClick(item,i)
end)
end
else
_this.itemperfab[i]:setActive(false)
end
end
else
_this.packScrollerViewnew:setActive(false)
_this.packScrollerView:setActive(true)
_this.packScrollerView:setChildScrollViewCreateGrids(_this.pageCount,_this.pageCount)
local grids=_this.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
getIndex=i
local item=grids[i-1]
if item and _this.showList[i]then

local itemid=_this.showList[i][1]

local job=_this.showList[i][2]
local jobicon=UIDiscipleModel:getJobIconName(job)
item:SetChildCSImageSprite(xinyuanindex.xyjob,globalABLookup.global,jobicon)

local bgstr=FMT.fmt("image_qbdzxx_{0}",_this.showList[i][5])
item:SetChildCSImageSprite(xinyuanindex.xyroleimg,abname,bgstr)

local scale=_this.showList[i][3]
local modelid=_this.showList[i][4]
item:SetChildUIModelShowTarget(xinyuanindex.xymopdel,modelid,scale,{},eAnimationID.stand,false,true)

_this:refreshRoleItemSelect(item,i,_this.selectIndex==i)

item:SetChildButtonClick(xinyuanindex.xyspinebtn,function()
if _this==nil then return end
_this:onSuitClick(itemid)
end)

item:SetChildButtonClick(xinyuanindex.xybtn,function()
if _this==nil then return end
_this:onRoleItemClick(item,i)
end)
end
end
end


_this:refreshPointScrollerView()

_this.leftidx=0
_this.rightidxnum=_this.pageCount-5-_this.leftidx
end


function UISubAct_SZCJ_xinyuanwin:testss(getIndex)

_this.packScrollerView:setChildScrollViewSelectItem(getIndex,true,false,false)
end


function UISubAct_SZCJ_xinyuanwin:refreshPointScrollerView()






























end



function UISubAct_SZCJ_xinyuanwin:checkArrowBtn()





_this.left:setActive(_this.leftidx>0)
_this.right:setActive(_this.rightidxnum>0)

if _this.pageCount<=5 then
_this.left:setActive(false)
_this.right:setActive(false)
end






local leftIsReddot=false
local rightIsReddot=false
_this.leftReddot:setActive(leftIsReddot)
_this.rightReddot:setActive(rightIsReddot)



end

function UISubAct_SZCJ_xinyuanwin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 or itemId==0 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UISubAct_SZCJ_xinyuanwin:onClickGetBtn(id)
socketManager:send_15_12(id)
end


function UISubAct_SZCJ_xinyuanwin:onLeftBtn()
if not(_this.pageIndex>0)then
return
end

if _this.pageIndex-1>=0 then
_this.pageIndex=_this.pageIndex-1
_this.targetHor=_this.pageLength*_this.pageIndex
end


_this.leftidx=_this.leftidx-1
_this.rightidxnum=_this.pageCount-5-_this.leftidx
if _this.leftidx>=0 then
_this.packScrollerView:setChildScrollViewSelectItem(_this.leftidx,true,false,false)
end
_this:checkArrowBtn()
end


function UISubAct_SZCJ_xinyuanwin:onRightBtn()
if not(_this.pageIndex<_this.pageCount-1)then
return
end
if _this.pageIndex+1<_this.pageCount then
_this.pageIndex=_this.pageIndex+1
_this.targetHor=_this.pageLength*_this.pageIndex
end


_this.leftidx=_this.leftidx+1
_this.rightidxnum=_this.pageCount-5-_this.leftidx
if _this.rightidxnum>=0 then
_this.packScrollerView:setChildScrollViewSelectItem(_this.leftidx,true,false,false)
end
_this:checkArrowBtn()
end

function UISubAct_SZCJ_xinyuanwin:onClickPagePoint(index)
if _this.pageIndex==index-1 then
return
end


_this.pageIndex=index-1
_this.targetHor=_this.pageLength*_this.pageIndex

_this:checkArrowBtn()


end







function UISubAct_SZCJ_xinyuanwin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
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


function UISubAct_SZCJ_xinyuanwin:endAllReddotPunchRotation()
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



function UISubAct_SZCJ_xinyuanwin.beginDragCallback()
_this.isDrag=true
end

function UISubAct_SZCJ_xinyuanwin.endDragCallback()
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


end

function UISubAct_SZCJ_xinyuanwin.onScrollChanged()
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

function UISubAct_SZCJ_xinyuanwin.pointBeginDragCallback()
_this.isAutoMovePoint=false
end

function UISubAct_SZCJ_xinyuanwin.testChangSmooting(smooting)
_this.smooting=smooting
UIManager.info(FMT.fmt("页面切换速度更改为: {0}",_this.smooting))
end


function UISubAct_SZCJ_xinyuanwin:refreshRoleItemSelect(item,index,flag)
if index<=0 then
return
end

local cfg=cfg_lotteryact3config_get(_this.subid)
_this.showList=cfg.showdresslist
if#_this.showList<=4 then
if item==nil then
item=_this.itemperfab[index]:getWidgetBase()
end

if flag then
item:SetChildShowEffect(xinyuanindextwo.effectchoose,10454,true)
item:SetChildActive(xinyuanindextwo.xygou,true)
else
item:SetChildShowEffect(xinyuanindextwo.effectchoose,0,false)
item:SetChildActive(xinyuanindextwo.xygou,false)
end
item:SetChildActive(xinyuanindextwo.galvbtn,flag)
if flag then
item:SetChildUIModelShowTarget(xinyuanindextwo.gailvimg,5295,1,{},5,false,false,0)
end
else
if item==nil then
local grids=_this.packScrollerView:getChildScrollViewItemWidgets()
item=grids[index-1]
end

if flag then
item:SetChildShowEffect(xinyuanindex.effectchoose,10454,true)
item:SetChildActive(xinyuanindex.xygou,true)
else
item:SetChildShowEffect(xinyuanindex.effectchoose,0,false)
item:SetChildActive(xinyuanindex.xygou,false)
end
item:SetChildActive(xinyuanindex.galvbtn,flag)
if flag then
item:SetChildUIModelShowTarget(xinyuanindex.gailvimg,5295,1,{},5,false,false,0)
end
end
end


function UISubAct_SZCJ_xinyuanwin:closeeffextall()
local cfg=cfg_lotteryact3config_get(_this.subid)
_this.showList=cfg.showdresslist
if#_this.showList<=4 then
for i=1,#_this.itemperfab do
if i<=#_this.showList then
local item=_this.itemperfab[i]:getWidgetBase()
if item and _this.showList[i]then
item:SetChildShowEffect(xinyuanindextwo.effectchoose,0,false)
end
end
end
else
local grids=_this.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item and _this.showList[i]then
item:SetChildShowEffect(xinyuanindex.effectchoose,0,false)
end
end
end
end


function UISubAct_SZCJ_xinyuanwin:onRoleItemClick(item,index)

if _this.selectIndex==index then
return
end
if _this.selectIndex~=nil then
_this:refreshRoleItemSelect(nil,_this.selectIndex,false)
end
_this.selectIndex=index
_this:refreshRoleItemSelect(nil,index,true)
end

function UISubAct_SZCJ_xinyuanwin:onSuitClick(itemId)
if not itemId or itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end

function UISubAct_SZCJ_xinyuanwin:checkSelect()
if _this.selectIndex==nil or _this.selectIndex<=0 then
return
end
local mydata=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid)
local severselectIndex=mydata.idx or 0
if _this.selectIndex==severselectIndex then
return
end
local json_str=jsonHelper.encode({2,_this.selectIndex})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,json_str)
end

function UISubAct_SZCJ_xinyuanwin:onXytipsbtn()
local d={}
d.title='心愿规则'
d.mode=3
d.name='SZCJ_xinyuan_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_SZCJ_xinyuanwin:onClickClose()
self:closeeffextall()
self:checkSelect()
self:closeSelf()
end
function UISubAct_SZCJ_xinyuanwin:onClosebtn()
self:onClickClose()
end
