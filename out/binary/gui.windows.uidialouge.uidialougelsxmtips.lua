







def_class("UIDialougeLSXMTips",UIWindowBase)









function UIDialougeLSXMTips:bindComponents()

self.cancelButton=UIButton.get(self,0)
self.cancelText=UIText.get(self,1)
self.chooseBox=UIToggleButton.get(self,2)
self.chooseText=UIText.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.Content=UIObject.get(self,5)
self.okButton=UIButton.get(self,6)
self.okText=UIText.get(self,7)
self.rewardview=UIObject.get(self,8)
self.root=UIObject.get(self,9)
self.tip=UIText.get(self,10)
self.titleText=UIText.get(self,11)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeLSXMTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.chooseBox);self.chooseBox=nil;
_UIObject_release(self.chooseText);self.chooseText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.rewardview);self.rewardview=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end
















local _this




function UIDialougeLSXMTips:onLoaded(...)
self:bindComponents()

_this=self

self.rewardview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIDialougeLSXMTips:__delete()
_this=nil

self:unbindComponents()
end




function UIDialougeLSXMTips:onShow(argtable,afterOnloaded)

self.showdata=argtable
self.lsGuid=argtable.lsGuid
self.lsData=lingshouModel:getLingShouData2(self.lsGuid)

self.costList=argtable.costList
self.okCallBack=argtable.okCallBack
self.cancelCallBack=argtable.cancelCallBack

if self.costList and next(self.costList)then
table.sort(self.costList,function(a,b)
return a[1]<b[2]
end)
end

local content=argtable.content
local okButtonTxt=argtable.okButtonTxt or"确认"
local cancelButtonTxt=argtable.cancelButtonTxt or"取消"

local noCancelButton=argtable.noCancelButton

self.tip:setText(content)

self.okText:setText(okButtonTxt)
self.cancelText:setText(cancelButtonTxt)

self.cancelButton:setActive(not noCancelButton)

if argtable.canvasindex then
self.winlua:SetCanvasIndex(10,argtable.canvasindex)
end

if argtable.choosetext~=nil and argtable.choosecallback~=nil then
self.chooseBox:setActive(true)
self.chooseText:setText(argtable.choosetext)
else
self.chooseBox:setActive(false)
end

local len=#self.costList
self.rewardview:setChildScrollViewCreateGrids(len,len)
local grids=self.rewardview:getChildScrollViewItemWidgets()

for index=1,grids.Count do
local item=grids[index-1]

local costData=self.costList[index]

local isSpe=costData[1]<0

item:SetChildActive(0,not isSpe)
item:SetChildActive(1,isSpe)
if isSpe then
if costData[1]==-1 then
self:refreshCostItem_Spe1(item,costData)
elseif costData[1]==-2 then
self:refreshCostItem_Spe2(item,costData)
end
else
local itemId=costData[1]
local itemNum=costData[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(itemId)
end)
end
end
end

function UIDialougeLSXMTips:refreshCostItem_Spe1(item,costData)
local subItem=item:GetChildWidgetBase(1)

local selectList=costData[3]or{}

local selectLen=#selectList
local countStr=selectLen

subItem:SetChildActive(0,selectLen>0)
subItem:SetChildText(2,countStr)
local cost_ls=self.lsData.cfg.xuemai_cost_ls[self.lsData.xuemai_val]
local id=next(cost_ls)
local color=cfgHelper.get(cfg_lingshouconfig_get,id,'color')
subItem:SetChildQulaity(3,color)

item:SetBaseItemClickEvent(1,function(...)

end)
end

function UIDialougeLSXMTips:refreshCostItem_Spe2(item,costData)
local subItem=item:GetChildWidgetBase(1)


local selectList=costData[3]or defaultT

local selectLen=#selectList
local countStr=selectLen

subItem:SetChildActive(0,selectLen>0)
subItem:SetChildText(2,countStr)
subItem:SetChildQulaity(3,self.lsData.cfg.color)

item:SetBaseItemClickEvent(1,function(...)

end)
end


function UIDialougeLSXMTips:onHide()

end





function UIDialougeLSXMTips:onCancelButton()
local cancelCallBack=self.cancelCallBack

self:onCloseBtn()

if cancelCallBack then
cancelCallBack()
end
end



function UIDialougeLSXMTips:onCloseBtn()
local choosecallback=self.showdata.choosecallback
if choosecallback then
choosecallback(self.chooseBox:getToggle())
end

self:close()
end



function UIDialougeLSXMTips:onOkButton()
local okCallBack=self.okCallBack

self:onCloseBtn()

if okCallBack then
okCallBack()
end
end

function UIDialougeLSXMTips:onBGClick()
if self.showdata.bgClick then
self:onCancelButton()
end
end

function UIDialougeLSXMTips:onChangeChoose()

AudioManager.playBtnClick()
end

