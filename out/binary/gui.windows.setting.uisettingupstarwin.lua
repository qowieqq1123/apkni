







def_class("UISettingUpStarWin",UIWindowBase)









function UISettingUpStarWin:bindComponents()

self.btnReset=UIButton.get(self,0)
self.btnStar=UIButton.get(self,1)
self.maxStar=UIText.get(self,2)
self.maxStarImg=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.star=UIObject.get(self,5)
self.starAttr_1=UIObject.get(self,6)
self.starAttr_2=UIObject.get(self,7)
self.starAttr_3=UIObject.get(self,8)
self.starAttr_4=UIObject.get(self,9)
self.starCostTitle=UIText.get(self,10)
self.stardesc=UIText.get(self,11)
self.starItemCreater=UIObject.get(self,12)
self.starPanel=UIObject.get(self,13)
self.starTitle=UIText.get(self,14)
self.upTitle=UIObject.get(self,15)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnStar:setButtonClick(function()self:onBtnStar()end)
self.starAttr={
self.starAttr_1,
self.starAttr_2,
self.starAttr_3,
self.starAttr_4,
}



end


function UISettingUpStarWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnStar);self.btnStar=nil;
_UIObject_release(self.maxStar);self.maxStar=nil;
_UIObject_release(self.maxStarImg);self.maxStarImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.star);self.star=nil;
_UIObject_release(self.starAttr_1);self.starAttr_1=nil;
_UIObject_release(self.starAttr_2);self.starAttr_2=nil;
_UIObject_release(self.starAttr_3);self.starAttr_3=nil;
_UIObject_release(self.starAttr_4);self.starAttr_4=nil;
_UIObject_release(self.starCostTitle);self.starCostTitle=nil;
_UIObject_release(self.stardesc);self.stardesc=nil;
_UIObject_release(self.starItemCreater);self.starItemCreater=nil;
_UIObject_release(self.starPanel);self.starPanel=nil;
_UIObject_release(self.starTitle);self.starTitle=nil;
_UIObject_release(self.upTitle);self.upTitle=nil;
self.starAttr=nil;
end



















function UISettingUpStarWin:onLoaded(...)
self:bindComponents()
end


function UISettingUpStarWin:__delete()
self:unbindComponents()
end




function UISettingUpStarWin:onShow(argtable,afterOnloaded)
self.settingType=argtable.settingType
self.settingId=argtable.settingId

self:freshPanel()

if afterOnloaded then
self.isAnim=true
self.root:setChildAnchoredPos(610,0)
self.root:setChildDOAnchorPosX(0,0.25,function()
self.isAnim=false
end)
end

end

function UISettingUpStarWin:freshPanel()
local settingType=self.settingType
local selectId=self.settingId
local settingcfg=UISettingConfig.getCfg(settingType,selectId)
local starNum=UISettingModel:getStarNum(settingType,selectId)
local maxStarNum=#settingcfg.star
local isMax=starNum==maxStarNum
local widget=self.star:getChildWidgetBase()

widget:SetChildLocalPosX(1,isMax and 0 or-100)
widget:SetChildActive(2,not isMax)
widget:SetChildStarNumber(1,starNum)
widget:SetChildGroundStarNum(1,starNum==0 and 1 or starNum)
widget:SetChildActive(2,not isMax)

if not isMax then
widget:SetChildStarNumber(3,starNum+1)
widget:SetChildGroundStarNum(3,starNum+1)
end

self.upTitle:setActive(not isMax)

self.maxStarImg:setActive(isMax)
self.btnStar:setActive(not isMax)
self.starItemCreater:setActive(not isMax)

local attrList
local attr=settingcfg.attr
if attr then
attrList={}
for i,v in ipairs(attr)do
table.insert(attrList,v)
end
if starNum>0 then
local star_attr=settingcfg.star_attr[starNum]
attrList=table.concatTableXX(attrList,star_attr)
end
end
local jzattr=settingcfg.jzattr
if jzattr then
if not attrList then
attrList={}
end
for i,v in ipairs(jzattr)do
table.insert(attrList,v)
end
if starNum>0 then
local star_jzattr=settingcfg.star_jzattr[starNum]
attrList=table.concatTableXX(attrList,star_jzattr)
end
end

local UpAttrList
if not isMax then
if attr then
UpAttrList={}
for i,v in ipairs(attr)do
table.insert(UpAttrList,v)
end
local star_attr=settingcfg.star_attr[starNum+1]
UpAttrList=table.concatTableXX(UpAttrList,star_attr)
end
local jzattr=settingcfg.jzattr
if jzattr then
if not UpAttrList then
UpAttrList={}
end
for i,v in ipairs(jzattr)do
table.insert(UpAttrList,v)
end
local star_jzattr=settingcfg.star_jzattr[starNum+1]
UpAttrList=table.concatTableXX(UpAttrList,star_jzattr)
end
end

for i=1,#self.starAttr do
local widget_attr=self.starAttr[i]:getChildWidgetBase()
if attrList[i]then
self.starAttr[i]:setActive(true)

local name,str=equipsHelper.getAttr(attrList[i][1],attrList[i][2])

widget_attr:SetChildText(1,FMT.fmt("{0}：{1}",name,str))
widget_attr:SetChildActive(2,UpAttrList~=nil)
if UpAttrList then
local upName,addStr=equipsHelper.getAttr(UpAttrList[i][1],UpAttrList[i][2])
widget_attr:SetChildText(3,addStr)
end
else
self.starAttr[i]:setActive(false)
end
end

if not isMax then
local costList=settingcfg.star[starNum+1]or{}
local len=#costList
self.starItemCreater:setChildLayoutGroupCreateItems(len)
local grids=self.starItemCreater:getChildLayoutGroupGridList()
if len then
for i=1,len do
local cost=costList[i]
local itemid=cost[1]
local count=cost[2]
local countStr=self:getItemCountStr(itemid,count)
local item=grids[i-1]
local conf={itemid=itemid,itemcount=countStr,showCountBG=false,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
end
end
end
end

function UISettingUpStarWin:getItemCountStr(itemId,needCount)
local have=self:getHaveItemCount(itemId)
local colorStr=have<needCount and'#E33021FF'or'#171311'
local countStr=''
if moneyConfig.isMoney(itemId)then
countStr=FMT.fmt('<color={0}>{1}</color>',colorStr,mathHelper.formatBIGNumbereEx(needCount))
else
countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,mathHelper.formatBIGNumbereEx(have),mathHelper.formatBIGNumbereEx(needCount))
end
return countStr
end

function UISettingUpStarWin:getHaveItemCount(itemid)
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
return have
end


function UISettingUpStarWin:onHide()

end





function UISettingUpStarWin:onBtnReset()
end



function UISettingUpStarWin:onBtnStar()
local settingType=self.settingType
local selectId=self.settingId
local settingcfg=UISettingConfig.getCfg(settingType,selectId)
local starNum=UISettingModel:getStarNum(settingType,selectId)
local maxStarNum=#settingcfg.star
local isMax=starNum==maxStarNum
if isMax then
UIManager.error('已达星级上限')
return
end
local costList=settingcfg.star[starNum+1]or{}
local len=#costList
if len>0 then
for i=1,len do
local itemid=costList[i][1]
local need=costList[i][2]
local has=itemsModel.getCount(itemid)
if has<need then
gainControl:showGainWin(itemid)
UIManager.error(FMT.fmt('{0}不足',itemsModel.getName(itemid)))
return
end
end
end
UISettingController:req_upStar(self.settingType,self.settingId)
end

function UISettingUpStarWin:onClose()
if self.isAnim then return end
self.root:setChildDOAnchorPosX(610,0.25,function()
self.isAnim=false
self:closeSelf()
end)
end

