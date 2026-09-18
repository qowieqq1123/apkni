







def_class("UIXianTuChengJiuGuBaoLevelUpWin",UIWindowBase)









function UIXianTuChengJiuGuBaoLevelUpWin:bindComponents()

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


function UIXianTuChengJiuGuBaoLevelUpWin:unbindComponents()
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



function UIXianTuChengJiuGuBaoLevelUpWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianTuChengJiuGuBaoLevelUpWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianTuChengJiuGuBaoLevelUpWin:onShow(argtable,afterOnloaded)
self.oldLv=argtable.oldlv
self.newLv=argtable.newlv
self.data=gubaoModel:getDataByID(argtable.id)
self.config=cfgHelper.get1(cfg_gubaoconfig_get,argtable.id)

self.icon:setImageIcon(gubaoModel:getGuBaoIconName(self.config.icon),true)
self.iconBg:setSprite(globalABLookup.gubaomainicons,gubaoColorFrame:getName(self.config.color))
self.nameTx:setText(self.config.name)
self.attrTips1:setText(FMT.fmt("等级：{0}级",self.oldLv))
self.attrTips2:setText(FMT.fmt("等级：{0}级",self.newLv))

local oLookup={}
local nLookup={}
gubaoModel:calculationAttrLookup(oLookup,self.data.gubaoid,self.data.gubaolhlv,self.data.gubaostar,self.data.gubaojxlv,self.oldLv)
gubaoModel:calculationAttrLookup(nLookup,self.data.gubaoid,self.data.gubaolhlv,self.data.gubaostar,self.data.gubaojxlv,self.newLv)
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

local nlevel=gubaoModel:getSkillLvEx(self.data.gubaoid,self.data.gubaostar,self.data.gubaojxlv,self.newLv)
local olevel=gubaoModel:getSkillLvEx(self.data.gubaoid,self.data.gubaostar,self.data.gubaojxlv,self.oldLv)
local skillShow=false
if self.config.skill[olevel]then
local oStr1,oStr2,oStr3=gubaoModel:getSkillDesc(self.data.gubaoid,olevel)
local nStr1,nStr2,nStr3=gubaoModel:getSkillDesc(self.data.gubaoid,nlevel)
skillShow=oStr1~=nStr1
self.skillChange:setActive(skillShow)
if skillShow then
self.skillDesc1:setText(oStr1)
self.skillDesc2:setText(nStr1)
end
else
self.skillChange:setActive(false)
self.skillDesc1:setText("")
self.skillDesc2:setText("")
end

self:doAnimation(skillShow)
end


function UIXianTuChengJiuGuBaoLevelUpWin:onHide()

end





function UIXianTuChengJiuGuBaoLevelUpWin:onBackground()
if self.sequence then return end
self:closeSelf()
end

function UIXianTuChengJiuGuBaoLevelUpWin:doAnimation(skillShow)
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
self.skillChange:setChildAnchoredPos(0,178.5-200)
temp=self.skillChange:setChildDOAnchorPosY(178.5,0.2)
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

function UIXianTuChengJiuGuBaoLevelUpWin:animationCallback()
self.sequence=nil
end