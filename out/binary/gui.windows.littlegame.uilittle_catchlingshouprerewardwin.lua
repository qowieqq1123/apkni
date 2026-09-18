







def_class("UILittle_CatchLingShouPreRewardWin",UIWindowBase)









function UILittle_CatchLingShouPreRewardWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.centerLayout=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.qualityList=UIObject.get(self,3)
self.Root=UIObject.get(self,4)
self.scrollview=UIScrollView.get(self,5)
self.uiRoot=UIObject.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UILittle_CatchLingShouPreRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.qualityList);self.qualityList=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local _itemCmpIndex={
pzBg=0,
head=1,
name=2,
rate=3,
}




function UILittle_CatchLingShouPreRewardWin:onLoaded(...)
self:bindComponents()

_this=self

self.selectQualityIndex=1

self.qualityItemList=self.qualityList:getChildCommonLayoutGroupWidgetList()
for index=1,self.qualityItemList.Count do
local item=self.qualityItemList[index-1]
item:SetChildActive(-1,false)
end

local _bindWidgetFunc=function(index,item)
if _this==nil then return end
_this:bindScrollViewWidget(index,item)
end
self.scrollview:bindScrollWidget(_bindWidgetFunc)
end


function UILittle_CatchLingShouPreRewardWin:__delete()
_this=nil

self:unbindComponents()
end




function UILittle_CatchLingShouPreRewardWin:onShow(argtable,afterOnloaded)
self.gameID=argtable.gameID
self.quality=argtable.quality

self.lingshouLib=cfgHelper.get(cfg_buzhuolingshouconfig_get,self.gameID,'lingshouLib')

self.selectQualityIndex=self.quality or self.selectQualityIndex
if self.lingshouLib[self.selectQualityIndex]==nil then
local index,lib=next(self.lingshouLib)
self.selectQualityIndex=index
end

self:initData()
self:refreshAll()
end


function UILittle_CatchLingShouPreRewardWin:onHide()

end





function UILittle_CatchLingShouPreRewardWin:onCloseBtn()
self:closeSelf()
end


function UILittle_CatchLingShouPreRewardWin:initData()
self.totalWidgetLookup={}

for index,lib in pairs(self.lingshouLib)do
for _,data in ipairs(lib)do
self.totalWidgetLookup[index]=data[2]+(self.totalWidgetLookup[index]or 0)
end
end
end

function UILittle_CatchLingShouPreRewardWin:refreshAll()
self:refreshQualityTabs()

self:refreshRateItems()
end

function UILittle_CatchLingShouPreRewardWin:refreshQualityTabs()
for index=1,self.qualityItemList.Count do
local item=self.qualityItemList[index-1]
local qualityData=self.lingshouLib[index]
local isShow=qualityData~=nil
item:SetChildActive(-1,isShow)
if isShow then
local name=eQualityColorName[index]
item:SetChildText(1,name)

local isSelect=self.selectQualityIndex==index
item:SetChildActive(0,isSelect)

item:SetBaseItemClickEvent(-1,function()
if _this==nil then return end

local preItem=self.qualityItemList[self.selectQualityIndex-1]
preItem:SetChildActive(0,false)

_this.selectQualityIndex=index
item:SetChildActive(0,true)
_this:refreshRateItems()
end)
end

end
end

function UILittle_CatchLingShouPreRewardWin:refreshRateItems()
self.lib=self.lingshouLib[self.selectQualityIndex]

local len=#self.lib

local m=mathHelper.safe_ceil(len/3)
self.scrollview:freshGridsNum(len,m,3,true)
end

function UILittle_CatchLingShouPreRewardWin:bindScrollViewWidget(index,item)
local data=self.lib[index]

local isShow=data~=nil
item:SetChildActive(-1,isShow)
if not isShow then return end

local lsID=data[1]
local rate=data[2]

local lsCfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
local color,name
if lsCfg then
color=lsCfg.color
name=lsCfg.name
end
comHelper.setChildModelHeadIconBGByColor(item,_itemCmpIndex.pzBg,color)

comHelper.setChildModelRawImage_lingshou(item,lsID,_itemCmpIndex.head,0,eHeadCenterType.eHead,1)

item:SetChildText(_itemCmpIndex.name,name)

item:SetChildText(_itemCmpIndex.rate,string.format("获取概率：%0.2f%%",rate/self.totalWidgetLookup[self.selectQualityIndex]*100))

item:SetBaseItemClickEvent(-1,function()

end)
end

