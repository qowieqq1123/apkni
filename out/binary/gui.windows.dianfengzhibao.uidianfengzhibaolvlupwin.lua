







def_class("UIDianFengZhiBaoLvlUpWin",UIWindowBase)









function UIDianFengZhiBaoLvlUpWin:bindComponents()

self.background=UIButton.get(self,0)
self.icon=UIImage.get(self,1)
self.nameTx=UIText.get(self,2)
self.skillDesc1=UIText.get(self,3)
self.skillDesc2=UIText.get(self,4)
self.attrTips1=UIText.get(self,5)
self.attrTips2=UIText.get(self,6)
self.titleBg=UIObject.get(self,7)
self.iconBg=UIImage.get(self,8)
self.skillChange=UIObject.get(self,9)
self.attrArrow=UIObject.get(self,10)
self.attrList=UIObject.get(self,11)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIDianFengZhiBaoLvlUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.skillDesc1);self.skillDesc1=nil;
_UIObject_release(self.skillDesc2);self.skillDesc2=nil;
_UIObject_release(self.attrTips1);self.attrTips1=nil;
_UIObject_release(self.attrTips2);self.attrTips2=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.iconBg);self.iconBg=nil;
_UIObject_release(self.skillChange);self.skillChange=nil;
_UIObject_release(self.attrArrow);self.attrArrow=nil;
_UIObject_release(self.attrList);self.attrList=nil;
end
















local _this=nil
local _attrCmp={
old=0,
new=1,
root=2,
}



function UIDianFengZhiBaoLvlUpWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDianFengZhiBaoLvlUpWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDianFengZhiBaoLvlUpWin:onShow(argtable,afterOnloaded)
self.oldLv=argtable.oldlv
self.newLv=argtable.newlv
self.xbid=argtable.id


local xbType=XianBaoTypeEnum.eXianBao
local iconname=xianbaoConfig.getTypeFuncResult(xbType,'getIcon',self.xbid)

self.icon:setImageIcon(iconname,true)
local color=xianbaoConfig.getTypeFuncResult(xbType,'getColor',self.xbid)
self.iconBg:setSprite(globalABLookup.gubaomainicons,gubaoColorFrame:getName(color))

local name=xianbaoConfig.getTypeFuncResult(xbType,'getName',self.xbid)
self.nameTx:setText(name)
self.attrTips1:setText(FMT.fmt("巅峰等级：{0}级",self.oldLv))
self.attrTips2:setText(FMT.fmt("巅峰等级：{0}级",self.newLv))


local oLookup={}
local nLookup={}


DianFengLevelModel:calculationAttrLookup(oLookup,self.oldLv)
DianFengLevelModel:calculationAttrLookup(nLookup,self.newLv)

local attrs=attrListHelper.sortByLookup(nLookup)


self.attrList:setChildLayoutGroupCreateItems(#attrs,function(index)
local item=self.attrList:getChildLayoutGroupGridItem(index-1)
local nData=attrs[index]
local attrId=nData[1]
local nValue=nData[2]
local oValue=oLookup[attrId]or 0
item:SetChildText(_attrCmp.old,helper.getAttributeStr(attrId,oValue,2,"{0}：{1}"))
item:SetChildText(_attrCmp.new,helper.getAttributeStr(attrId,nValue,2,"{0}：{1}"))
end)























local skillShow=false
local cfglvl=cfg_dianfenglevelconfig_get(self.oldLv)
local maxpoint=cfglvl.point
local ncfglvl=cfg_dianfenglevelconfig_get(self.newLv)
local nmaxpoint=ncfglvl.point
skillShow=maxpoint~=nmaxpoint
self.skillChange:setActive(skillShow)
if skillShow then
local oStr1=string.format("天道感悟点数：%d",maxpoint)
self.skillDesc1:setText(oStr1)
local nStr1=string.format("天道感悟点数：%d",nmaxpoint)
self.skillDesc2:setText(nStr1)
end

self:doAnimation(skillShow)
end


function UIDianFengZhiBaoLvlUpWin:onHide()

end





function UIDianFengZhiBaoLvlUpWin:onBackground()
if self.sequence then return end
self:closeSelf()
end

function UIDianFengZhiBaoLvlUpWin:doAnimation(skillShow)
self.sequence=Lua.SequenceProxy.New()
self.titleBg:setScale(Vector3(2,2,2))
local temp=self.titleBg:setChildDOScale(1,0.15)
self.sequence:Append(temp)
self.sequence:AppendInterval(0.15)

local delay=0
self.attrArrow:setChildAnchoredPos(0,90-200)
self.attrArrow:setActive(false)
temp=self.attrArrow:setChildDOAnchorPosY(90,0.2)
self.sequence:AppendCallback(function()
self.attrArrow:setActive(true)
end)
self.sequence:Append(temp)
delay=delay+0.1

local attrItems=self.attrList:getChildLayoutGroupGridList()
local attrCnt=attrItems.Count

for i=1,attrCnt do
local tempSeq=Lua.SequenceProxy.New()
local attrItem=attrItems[i-1]
attrItem:SetChildAnchoredPos(_attrCmp.root,0,-200)
attrItem:SetChildActive(_attrCmp.root,false)

temp=attrItem:SetChildDOAnchorPosY(_attrCmp.root,0,0.2)
tempSeq:AppendInterval(delay)
tempSeq:AppendCallback(function()
attrItem:SetChildActive(_attrCmp.root,true)
end)
tempSeq:Append(temp)
self.sequence:Join(tempSeq)
delay=delay+0.1
end

if skillShow then
local tempSeq=Lua.SequenceProxy.New()
self.skillChange:setActive(false)
self.skillChange:setChildAnchoredPos(0,-328)
temp=self.skillChange:setChildDOAnchorPosY(-128,0.2)
tempSeq:AppendInterval(delay)
tempSeq:AppendCallback(function()
self.skillChange:setActive(true)
end)
tempSeq:Append(temp)
self.sequence:Join(tempSeq)
delay=delay+0.1
end

self.sequence:AppendCallback(function()
self:animationCallback()
end)
end

function UIDianFengZhiBaoLvlUpWin:animationCallback()
self.sequence=nil
end
