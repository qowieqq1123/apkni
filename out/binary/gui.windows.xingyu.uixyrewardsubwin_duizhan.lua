







def_class("UIXYRewardSubWin_DuiZhan",UIWindowBase)









function UIXYRewardSubWin_DuiZhan:bindComponents()

self.bigItem=UIBaseItem.get(self,0)
self.dropItem=UIObject.get(self,1)
self.LoopContent=UIObject.get(self,2)
self.LoopScrollView=UILoopListView.new(self,3)
self.ScrollView=UIScrollView.get(self,4)
self.Viewport=UIObject.get(self,5)

self.LoopScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXYRewardSubWin_DuiZhan:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bigItem);self.bigItem=nil;
_UIObject_release(self.dropItem);self.dropItem=nil;
_UIObject_release(self.LoopContent);self.LoopContent=nil;
self.LoopScrollView:deleteSelf();self.LoopScrollView=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Viewport);self.Viewport=nil;
end















local ItemType={
eXyInfoItem=1,
eIntervalItem=2,
eTitleItem=3,
eSubTitleItem=4,
eRewardItem=5,
eHzRItem=6,
eTipItem=7,
eLevelRewardItem=8,
}

local ItemName={
[ItemType.eXyInfoItem]="xyInfoItem",
[ItemType.eIntervalItem]="IntervalItem",
[ItemType.eTitleItem]="titleItem",
[ItemType.eSubTitleItem]="subTitleItem",
[ItemType.eRewardItem]="rewardItem",
[ItemType.eHzRItem]="hzRItem",
[ItemType.eTipItem]="tipItem",
[ItemType.eLevelRewardItem]="duanweiRewardItem",
}

local abName="ui/windows/xingyu/xingyu_atlas_pak.ab"



function UIXYRewardSubWin_DuiZhan:onLoaded(...)
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
self.bigItem:setBaseItemClickEvent(itemsComponentHelper.onItemClick)
end


function UIXYRewardSubWin_DuiZhan:__delete()
self:unbindComponents()
end




function UIXYRewardSubWin_DuiZhan:onShow(argtable,afterOnloaded)
local xyId=argtable.xyId
if self.xyId==xyId then
return
end
self.xyId=xyId
self.level=JiuYuZhengFengModel:getData_rank_level()or 0
self.selectLevel=self.level
























































self:initlookup()
self:refresh()

if self.level>0 then
self:showWindow("UIXingYu_JYZFLevelDropDownWin",{
parent=self,
item=self.dropItem:getWidgetBase(),
node='bottom',
})
end
end


function UIXYRewardSubWin_DuiZhan:onHide()

end

function UIXYRewardSubWin_DuiZhan:onFreshAction(index,widget,data)
local itemType=data.itemType
if itemType==ItemType.eXyInfoItem then
widget:SetChildCSImageSprite(0,abName,data.showRIconName)
widget:SetChildText(1,data.name)
widget:SetChildCSImageSprite(3,abName,data.colorAssest)
elseif itemType==ItemType.eTitleItem then
widget:SetChildText(1,data.name)
elseif itemType==ItemType.eSubTitleItem then
widget:SetChildText(0,data.name)
elseif itemType==ItemType.eRewardItem then
if data.titleName then
widget:SetChildActive(1,true)
widget:SetChildCSImageSprite(1,abName,data.titleName)
else
widget:SetChildActive(1,false)
end
self:SetChildLayoutGroup(widget,data.rewardList,0)
elseif itemType==ItemType.eIntervalItem then
widget:SetChildSizeDelta(0,1050,data.hight)
elseif itemType==ItemType.eHzRItem then
self:SetChildLayoutGroup(widget,data.winItemList,1)
self:SetChildLayoutGroup(widget,data.failItemList,2)
elseif itemType==ItemType.eTipItem then
widget:SetChildText(2,data.tips)
elseif itemType==ItemType.eLevelRewardItem then
self:SetChildLayoutGroup(widget,data.mustWinList,0)
self:SetChildLayoutGroup(widget,data.mustLoseList,1)
end
end

function UIXYRewardSubWin_DuiZhan:SetChildLayoutGroup(widget,list,cmpIndex)
widget:SetChildLayoutGroupCreateItems(cmpIndex,#list,function(index)
local item=widget:GetChildLayoutGroupGridItem(cmpIndex,index-1)
local rewardData=list[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""


local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
if itemsConfig.isMoney(itemId)then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)

local duanwei=rewardData.duanwei or 0
item:SetChildActive(14,duanwei==1)
end)
end

function UIXYRewardSubWin_DuiZhan:onStartAction()
end

function UIXYRewardSubWin_DuiZhan:initlookup()
local datalist={}
local prefabnameList={}
local col=11
local xyCfg=XingYuModel:getXingYuConfig(self.xyId)








local hzTitleItemTemp={}
hzTitleItemTemp.itemType=ItemType.eTitleItem
hzTitleItemTemp.name="混战每轮奖励"
table.insert(prefabnameList,ItemName[ItemType.eTitleItem])
table.insert(datalist,hzTitleItemTemp)

local hzRItemTemp={}
local hzRcfg=cfgHelper.get(cfg_xingyuhunzhanrewardconfig_get,xyCfg.color,1)
local winRewards=hzRcfg.winRewards
local lostRewards=hzRcfg.lostRewards
if self.level>0 then
local level_hzRcfg=cfgHelper.get(cfg_xingyuhunzhanrewardconfig_get,xyCfg.color,1,'dwRewards',self.selectLevel)
if level_hzRcfg then
winRewards=table.concatTable(level_hzRcfg[1],winRewards)
lostRewards=table.concatTable(level_hzRcfg[2],lostRewards)
end
end
hzRItemTemp.itemType=ItemType.eHzRItem
hzRItemTemp.winItemList=winRewards
hzRItemTemp.failItemList=lostRewards
table.insert(prefabnameList,ItemName[ItemType.eHzRItem])
table.insert(datalist,hzRItemTemp)



local zdzTitleItemTemp={}
zdzTitleItemTemp.itemType=ItemType.eTitleItem
zdzTitleItemTemp.name="争夺战奖励"
table.insert(prefabnameList,ItemName[ItemType.eTitleItem])
table.insert(datalist,zdzTitleItemTemp)

local IntervalItemTemp2={}
IntervalItemTemp2.itemType=ItemType.eIntervalItem
IntervalItemTemp2.hight=15
table.insert(prefabnameList,ItemName[ItemType.eIntervalItem])
table.insert(datalist,IntervalItemTemp2)

local tipsItemTemp={}
tipsItemTemp.itemType=ItemType.eTipItem
tipsItemTemp.tips="每轮获胜奖励将从多种奖励中随机一种，战败奖励与之对应"
table.insert(prefabnameList,ItemName[ItemType.eTipItem])
table.insert(datalist,tipsItemTemp)

local color=xyCfg.color
for round=1,5 do
local zdzSubTitleItemTemp={}
zdzSubTitleItemTemp.itemType=ItemType.eSubTitleItem
zdzSubTitleItemTemp.name=FMT.fmt("第{0}轮",round)
table.insert(prefabnameList,ItemName[ItemType.eSubTitleItem])
table.insert(datalist,zdzSubTitleItemTemp)
local realLun=5-round+1

local colorcfg=cfgHelper.get(cfg_xingyuzhengduozhanrewardconfig_get,color)
local winRlist={}
local failRlist={}
local faillookup={}
local mustWinRLookup={}
local mustLoseRLookup={}
local luncfg=colorcfg[realLun]
local winRewards=luncfg.winRewards
for __,v2 in ipairs(winRewards)do
local rwid=v2[1]
local cfg=cfgHelper.get(cfg_xingyuzhengduozhanjiangliconfig_get,rwid)
for ___,v3 in ipairs(cfg.winRewards)do
local itemId=v3[1]
local num=v3[2]
local itemColor=itemsConfig.getItemColor(itemId)
table.insert(winRlist,{itemId,num,itemColor})
end
for ___,v3 in ipairs(cfg.lostRewards)do
local itemId=v3[1]
local num=v3[2]
local itemColor=itemsConfig.getItemColor(itemId)
if not faillookup[itemId]then
faillookup[itemId]={}
end
if not faillookup[itemId][num]then
faillookup[itemId][num]=true
table.insert(failRlist,{itemId,num,itemColor})
end
end

local dwRewards=cfg.dwRewards[self.selectLevel]
if dwRewards then
for ___,v3 in ipairs(dwRewards[1])do
local itemId=v3[1]
mustWinRLookup[itemId]=v3
end

for ___,v3 in ipairs(dwRewards[2])do
local itemId=v3[1]
mustLoseRLookup[itemId]=v3
end
end
end







local row=math.ceil(#winRlist/col)
for _r=1,row do
local rewardItemTemp={}
rewardItemTemp.titleName=_r==1 and"image_xyjl_hs"or nil
rewardItemTemp.itemType=ItemType.eRewardItem
table.insert(prefabnameList,ItemName[ItemType.eRewardItem])
local _rewardList={}
for _c=1,col do
local index=(_r-1)*col+_c
local rewardData=winRlist[index]
if rewardData then
table.insert(_rewardList,rewardData)
end
end
rewardItemTemp.rewardList=_rewardList
table.insert(datalist,rewardItemTemp)
end



















local row=math.ceil(#failRlist/col)
for _r=1,row do
local rewardItemTemp={}
rewardItemTemp.titleName=_r==1 and"image_xyjl_zb"or nil
rewardItemTemp.itemType=ItemType.eRewardItem
table.insert(prefabnameList,ItemName[ItemType.eRewardItem])
local _rewardList={}
for _c=1,col do
local index=(_r-1)*col+_c
local rewardData=failRlist[index]
if rewardData then
table.insert(_rewardList,rewardData)
end
end
rewardItemTemp.rewardList=_rewardList
table.insert(datalist,rewardItemTemp)
end

local mustWinList={}
local mustLoseList={}

for index,data in pairs(mustWinRLookup)do
mustWinList[#mustWinList+1]=data
end

for index,data in pairs(mustLoseRLookup)do
mustLoseList[#mustLoseList+1]=data
end
if self.level>0 then
local mustRewardItemTemp={}
mustRewardItemTemp.itemType=ItemType.eLevelRewardItem
mustRewardItemTemp.mustWinList=mustWinList
mustRewardItemTemp.mustLoseList=mustLoseList
table.insert(prefabnameList,ItemName[ItemType.eLevelRewardItem])
table.insert(datalist,mustRewardItemTemp)
end
end

self.datalist=datalist
self.prefabnameList=prefabnameList
end

function UIXYRewardSubWin_DuiZhan:refresh()
if#self.datalist>0 then
self.LoopScrollView:initDataEx(self.prefabnameList,self.datalist)
else
self.LoopScrollView:initData(nil,nil,0)
end
end

function UIXYRewardSubWin_DuiZhan:onChangeLevel(level)
self.selectLevel=level
self:initlookup()
self:refresh()
end



