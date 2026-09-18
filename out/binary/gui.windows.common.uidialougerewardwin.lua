







def_class("UIDialougeRewardWin",UIWindowBase)









function UIDialougeRewardWin:bindComponents()

self.tipsText=UIText.get(self,0)
self.cancelText=UIText.get(self,1)
self.titleTxt=UIText.get(self,2)
self.descText1=UIText.get(self,3)
self.descText2=UIText.get(self,4)
self.rewardRoot=UIObject.get(self,5)
self.cancelBtn=UIButton.get(self,6)
self.commitBtn=UIButton.get(self,7)
self.goodGrid=UIObject.get(self,8)
self.commitText=UIText.get(self,9)
self.downTipsText=UIText.get(self,10)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIDialougeRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.descText1);self.descText1=nil;
_UIObject_release(self.descText2);self.descText2=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.goodGrid);self.goodGrid=nil;
_UIObject_release(self.commitText);self.commitText=nil;
_UIObject_release(self.downTipsText);self.downTipsText=nil;
end
































function UIDialougeRewardWin:onLoaded(...)
self:bindComponents()

end


function UIDialougeRewardWin:__delete()

self:unbindComponents()
end


function UIDialougeRewardWin:onHide()

end




function UIDialougeRewardWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin

self.titleTxt:setText(argtable.title or'提示')

local showDesc1=argtable.desc1~=nil
self.descText1:setActive(showDesc1)
if showDesc1 then
self.descText1:setText(argtable.desc1)
end

local showDesc2=argtable.desc2~=nil
self.descText2:setActive(showDesc2)
if showDesc2 then
self.descText2:setText(argtable.desc2)
end

local showDownText=argtable.downText~=nil
self.downTipsText:setActive(showDownText)
if showDownText then
self.downTipsText:setText(argtable.downText)
end

local isCost=argtable.isCost or false
local showReward=argtable.rewards~=nil
self.rewardRoot:setActive(showReward)
if showReward then

local showRewardTitle=argtable.rewardTitle~=-1
self.tipsText:setActive(showRewardTitle)
if showRewardTitle then
self.tipsText:setText(argtable.rewardTitle or'奖励')
end

local rwlist=argtable.rewards
local num=#rwlist
self.goodGrid:setChildLayoutGroupCreateItems(num)
local grid=self.goodGrid:getChildLayoutGroupGridList()
local c=grid.Count
if c>4 then
self.goodGrid:setLocalPosX(500)
end
for i=1,num do
local item=grid[i-1]
local good=rwlist[i]
local itemid=good[1]
local itemnum=good[2]
local isSpe=good[1]<0
item:SetChildActive(0,not isSpe)
item:SetChildActive(2,isSpe)
local has
if itemid<0 then
self:refreshCostItem_Spe1(item,good)
else
has=itemsModel.getCount(itemid)
local num_str
local showCountBG
if itemnum>1 then
num_str=tostring(itemnum)
if argtable.formatNumber~=nil then
if argtable.formatNumber<=1 then
num_str=mathHelper.formatNumber(itemnum)
else
local func=mathHelper[FMT.fmt("formatNumber{0}",argtable.formatNumber)]
if func then
num_str=func(itemnum)
end
end
end
if isCost then
num_str=has>=itemnum and FMT.fmt('{0}/{1}',has,num_str)or
FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',has,num_str)
end
showCountBG=true
elseif itemnum==1 then
num_str=''
showCountBG=false
if isCost then
num_str=has>=itemnum and FMT.fmt('{0}/{1}',has,itemnum)or
FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',has,itemnum)
showCountBG=true
end
else
num_str=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=num_str,showname=false,itemIndex=i,showStage=true,showCountBG=showCountBG}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
end

end
end

local showCancel=argtable.showCancel
if showCancel==nil then showCancel=true end
self.cancelBtn:setActive(showCancel)
if showCancel then
self.cancelText:setText(argtable.cancelName or'取消')
end

local showCommit=argtable.showCommit
if showCommit==nil then showCommit=true end
self.commitBtn:setActive(showCommit)
if showCommit then
self.commitText:setText(argtable.commitName or'确定')
end

self.cancelCB=argtable.cancelCB
self.commitCB=argtable.commitCB
end

function UIDialougeRewardWin:onItemClick(itemid,index,guid,attach)
tipsManager.showTips({itemid=itemid,itemguid=guid})
end

function UIDialougeRewardWin:onCommitBtn()
local cb=self.commitCB
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
if cb then
cb()
end
end

function UIDialougeRewardWin:onCancelBtn()
local cb=self.cancelCB
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
if cb then
cb()
end
end

function UIDialougeRewardWin:refreshCostItem_Spe1(item,goodData)
local subItem=item:GetChildWidgetBase(2)
local selectList=goodData[3]or{}
local needCount=goodData[2]

local selectLen=#selectList
local isFull=selectLen>=needCount
local itemPZ=-goodData[1];
local color=isFull and FONT_COLOR.eGreenTxtColor or FONT_COLOR.eRedColor

local countStr=FMT.fmt("{0}",needCount)

subItem:SetChildActive(0,selectLen>0)
subItem:SetChildText(2,countStr)
subItem:SetChildQulaity(3,itemPZ)

end

function UIDialougeRewardWin:refreshCostItem_Spe2(item,costData)
local subItem=item:GetChildWidgetBase(1)
local selectList=costData[3]or defaultT
local needCount=costData[2]

local selectLen=#selectList
local isFull=selectLen>=needCount
local color=isFull and FONT_COLOR.eGreenTxtColor or FONT_COLOR.eRedColor
local countStr=FMT.fmt("{0}/{1}",toColorString(color,selectLen),needCount)

subItem:SetChildActive(0,selectLen>0)
subItem:SetChildText(2,countStr)
subItem:SetChildQulaity(3,5)


end