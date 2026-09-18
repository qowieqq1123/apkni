







def_class("UIHongChenJieSummaryWin",UIWindowBase)









function UIHongChenJieSummaryWin:bindComponents()

self.Root=UIObject.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.uiRoot=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.bgRoot=UIObject.get(self,4)
self.model=UIObject.get(self,5)
self.ScrollView=UIObject.get(self,6)
self.bar2=UIObject.get(self,7)
self.bar1=UIObject.get(self,8)
self.progresstxt=UIText.get(self,9)
self.iname=UIText.get(self,10)
self.polygonAttrPanel=UIObject.get(self,11)
self.infoItem_1=UIObject.get(self,12)
self.infoItem_3=UIObject.get(self,13)
self.infoItem_2=UIObject.get(self,14)
self.nodelist=UIObject.get(self,15)
self.pname=UIText.get(self,16)
self.progress=UIObject.get(self,17)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.infoItem={
self.infoItem_1,
self.infoItem_2,
self.infoItem_3,
}



end


function UIHongChenJieSummaryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgRoot);self.bgRoot=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.bar2);self.bar2=nil;
_UIObject_release(self.bar1);self.bar1=nil;
_UIObject_release(self.progresstxt);self.progresstxt=nil;
_UIObject_release(self.iname);self.iname=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.infoItem_1);self.infoItem_1=nil;
_UIObject_release(self.infoItem_3);self.infoItem_3=nil;
_UIObject_release(self.infoItem_2);self.infoItem_2=nil;
_UIObject_release(self.nodelist);self.nodelist=nil;
_UIObject_release(self.pname);self.pname=nil;
_UIObject_release(self.progress);self.progress=nil;
self.infoItem=nil;
end















local CmpNodeItemIndex={
year=0,
line=1,
kuang1=2,
title1=3,
kuang2=4,
title2=5,
content2=6,
dizuoSpine=7,
}

local transPolygonIndex={
HongChenJieDiscipleAttrTypeEnum.JiYuan,
HongChenJieDiscipleAttrTypeEnum.MeiLi,
HongChenJieDiscipleAttrTypeEnum.QianLi,
HongChenJieDiscipleAttrTypeEnum.CongHui,
HongChenJieDiscipleAttrTypeEnum.GenGu,
HongChenJieDiscipleAttrTypeEnum.ZiZhi,
}



function UIHongChenJieSummaryWin:onLoaded(...)
self:bindComponents()
end


function UIHongChenJieSummaryWin:__delete()
self:unbindComponents()
end




function UIHongChenJieSummaryWin:onShow(argtable,afterOnloaded)
self.data=argtable.data
self.id=self.data.id


self:freshAll()

if afterOnloaded then
self.uiRoot:setChildCanvasGroupAlpha(0)
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgSpine:getID(),false,true,false)
end
self.bgSpine:setChildUIModelShowTarget(5417,1,{},eAnimationID.stand,false,false,0.2,function()
self.uiRoot:setChildCanvasGroupDOFade(1,0.2,nil)
end)
end
end


function UIHongChenJieSummaryWin:onHide()

end

function UIHongChenJieSummaryWin:freshAll()
self:freshTop()
self:freshRight()
self:freshModel()
end

function UIHongChenJieSummaryWin:freshTop()
local name=self.data:getIdentityName()
self.iname:setText(name)

self:freshPolygon()

local item1=self.infoItem_1:getWidgetBase()
item1:SetChildText(0,'享年：')
local totalYear=self.data:getGameTotalYear()
local yearStr=FMT.fmt("{0} 岁",totalYear)
item1:SetChildText(1,yearStr)

local item2=self.infoItem_2:getWidgetBase()
item2:SetChildText(0,'境界：')
local jjLevel=self.data:getJingJie()
local jjStr=self.data:getJingJieName(jjLevel)
item2:SetChildText(1,jjStr)

local item3=self.infoItem_3:getWidgetBase()
item3:SetChildText(0,'仙缘：')
local xianyuan=self.data:getSingleInfo(HongChenJieDiscipleAttrTypeEnum.XianYuan)
item3:SetChildText(1,xianyuan)

local addVal=self.data:getSingleInfo(HongChenJieDiscipleAttrTypeEnum.XianYuan)
local addLimit=hongChenJieConfig.getBaseInfo(self.id,'money_limit')
addVal=Mathf.Min(addVal,addLimit[2])
addVal=addVal+addLimit[1]
local moneyType=hongChenJieConfig.getBaseInfo(self.id,'money_type')
local maxMoney=hongChenJieConfig.getBaseInfo(self.id,'money_max')
local totalVal=itemsModel.getCount(moneyType)
local moneyName=itemsModel.getName(moneyType)
local oldVal=totalVal-addVal
totalVal=Mathf.Min(totalVal,maxMoney)
oldVal=Mathf.Min(oldVal,maxMoney)
self.pname:setText(FMT.fmt('{0}：',moneyName))

if addVal>0 and maxMoney>oldVal+addVal then
self.progresstxt:setText(FMT.fmt("{0}(+{1})/{2}",totalVal,addVal,maxMoney))
else
self.progresstxt:setText(FMT.fmt("{0}/{1}",totalVal,maxMoney))
end
self.bar1:setChildIconFillAmount(oldVal/maxMoney)
self.bar2:setChildIconFillAmount(totalVal/maxMoney)
end

function UIHongChenJieSummaryWin:freshPolygon()
local max_single_dimension=hongChenJieConfig.getBaseInfo(self.id,'max_single_dimension')
local max_single_value=max_single_dimension
local attrList={}

local wiget=self.polygonAttrPanel:getWidgetBase()
for index=1,6 do
local val=self.data:getSingleInfo(index)
local name=HongChenJieDiscipleAttrNameList[index]
local str=FMT.fmt("{0}\n{1}",name,toColorStringX('#aae252',val))
wiget:SetChildText(index-1,str)
max_single_value=max_single_value>val and max_single_value or val
local transformIndex=transPolygonIndex[index]
attrList[transformIndex]=val
end

for index=1,6 do
attrList[index]=attrList[index]/max_single_value
end

wiget:SetChildUIPolygonImage(6,attrList,0)



end

function UIHongChenJieSummaryWin:freshRight()
local list=self.data:getLabelList()














local listLen=#list


local listHeight=220
local itemWidth=190
local itemSpace=28
local listLeftPadding=37
local listWidth=listLen*itemWidth+(listLen-1)*itemSpace+listLeftPadding
self.nodelist:setChildSizeDelta(listWidth,listHeight)
self.nodelist:setChildAnchoredPos(0,0)

local itemList={}
self.nodelist:setChildLayoutGroupCreateItems(listLen,function(index)
local item=self.nodelist:getChildLayoutGroupGridItem(index-1)
local data=list[index]
local isShowItem=data~=nil
item:SetChildActive(-1,isShowItem)
if isShowItem then
itemList[index]=item

local isShowBase=data.type==1
local isShowJc=data.type==2

local sy=index%2==0 and-1 or 1


item:SetChildText(CmpNodeItemIndex.year,FMT.fmt("第{0}年",data.year))

item:SetChildActive(CmpNodeItemIndex.kuang1,isShowBase)
item:SetChildActive(CmpNodeItemIndex.kuang2,isShowJc)


item:SetChildCanvasGroupAlpha(CmpNodeItemIndex.kuang1,0)
item:SetChildCanvasGroupAlpha(CmpNodeItemIndex.kuang2,0)
item:SetChildAnchoredPos(CmpNodeItemIndex.kuang1,0,20)
item:SetChildAnchoredPos(CmpNodeItemIndex.kuang2,0,20)

item:SetChildScale(CmpNodeItemIndex.line,Vector3(1,sy,1))
if sy==-1 then
item:SetChildAnchoredPos(CmpNodeItemIndex.line,111.4,-75)
end
item:SetChildIconFillAmount(CmpNodeItemIndex.line,0)

item:SetChildActive(CmpNodeItemIndex.year,false)
item:SetChildActive(CmpNodeItemIndex.dizuoSpine,false)
item:SetChildUIModelEnableInitUISpineParaEx(CmpNodeItemIndex.dizuoSpine,true,true,true)
item:SetChildUIModelShowTarget(CmpNodeItemIndex.dizuoSpine,5418,1,{},eAnimationID.stand)



if isShowBase then
item:SetChildText(CmpNodeItemIndex.title1,data.label)
end

if isShowJc then
item:SetChildText(CmpNodeItemIndex.title2,data.label)
item:SetChildText(CmpNodeItemIndex.content2,data.verdict)
end
end
end)


self.ScrollView:setChildScrollRectEnable(false)



local canvasDuration=0.3
local moveDuration=0.3
local lineDuration=0.3
local moveEndPosY=50
local curScrollRectPosX=itemWidth*2+listLeftPadding
local nodeListMoveDuration=0.3



local _this=self
local scrollRectSizeX=self.ScrollView:getChildSizeDeltaX()
local canMoveWidth=listWidth-scrollRectSizeX
local moveSingleVal=itemWidth+itemSpace

local curIndex=1
local itemAnimFunc
itemAnimFunc=function()
local item=itemList[curIndex]
local data=list[curIndex]
if item~=nil then



local kuangIndex
if data.type==1 then
kuangIndex=CmpNodeItemIndex.kuang1
else
kuangIndex=CmpNodeItemIndex.kuang2
end
item:SetChildActive(CmpNodeItemIndex.year,true)
item:SetChildActive(CmpNodeItemIndex.dizuoSpine,true)
item:SetChildCanvasGroupDOFade(kuangIndex,1,canvasDuration,nil)
item:SetChildDOAnchorPosY(kuangIndex,moveEndPosY,moveDuration,function()
curIndex=curIndex+1
if itemList[curIndex]~=nil then
item:SetChildImageDOFillAmount(CmpNodeItemIndex.line,1,lineDuration,function()
if listWidth>scrollRectSizeX then
local residue=listWidth-curScrollRectPosX
local moveVal=residue>moveSingleVal and moveSingleVal or(residue>0 and residue or 0)
curScrollRectPosX=curScrollRectPosX+moveVal
if curScrollRectPosX>scrollRectSizeX-itemWidth then
local endMovelVal=-(curScrollRectPosX-scrollRectSizeX)
_this.nodelist:setChildDOAnchorPosX(endMovelVal,nodeListMoveDuration,nil)
end
end
itemAnimFunc()
end)
else

_this.ScrollView:setChildScrollRectEnable(true)
end
end)
end
end

self:delayDo(0.2,itemAnimFunc)
end

function UIHongChenJieSummaryWin:freshModel()
local discipleGuidStr=self.data:getSelectDisciple()
local isShowDz=discipleGuidStr~=nil
self.model:setActive(isShowDz)
if isShowDz then
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(discipleGuidStr,false,1)
self.model:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false,0)
end
end





function UIHongChenJieSummaryWin:onCloseBtn()
UIFullHongChenJieControl:closeWindow('UIHongChenJieSummaryWin')
end

