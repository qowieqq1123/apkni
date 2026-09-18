







def_class("UIXingYuListRewardWin",UIWindowBase)









function UIXingYuListRewardWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.dropItem=UIObject.get(self,1)
self.LoopContent=UIObject.get(self,2)
self.LoopScrollView=UILoopListView.new(self,3)
self.title=UIText.get(self,4)
self.ToggleGroup=UIObject.get(self,5)
self.Viewport=UIObject.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.LoopScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXingYuListRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dropItem);self.dropItem=nil;
_UIObject_release(self.LoopContent);self.LoopContent=nil;
self.LoopScrollView:deleteSelf();self.LoopScrollView=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.ToggleGroup);self.ToggleGroup=nil;
_UIObject_release(self.Viewport);self.Viewport=nil;
end















local menu_slot_name='button_dytab'
local _this

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



function UIXingYuListRewardWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXingYuListRewardWin:__delete()
self:unbindComponents()
end




function UIXingYuListRewardWin:onShow(argtable,afterOnloaded)
self.level=JiuYuZhengFengModel:getData_rank_level()or 0
self.selectLevel=self.level
self:initlookup()
local Cfg=cfg_xingyuconfig()
local cnt=#Cfg
self.curXYId=argtable and argtable.xyId
self.indexlookup={}
self.lastDataIndexList={}
self.ToggleGroup:setChildLayoutGroupCreateItems(cnt)
for i=1,cnt do
local xyCfg=Cfg[i]
local item=self.ToggleGroup:getChildLayoutGroupGridItem(i-1)
item:SetChildButtonClickWithID(0,self.onToggleChange,xyCfg.id,true)
item:SetChildText(1,xyCfg.name)
self.indexlookup[xyCfg.id]=i
local isSelected=self.curXYId==xyCfg.id
local func=function()
if isSelected then

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end

if afterOnloaded then
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
else
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_stand,false,false,0,func)
end
end
self:refresh()

if self.level>0 then
self:showWindow("UIXingYu_JYZFLevelDropDownWin",{
parent=self,
item=self.dropItem:getWidgetBase(),
node='bottom',
})
end
end

function UIXingYuListRewardWin:initlookup()
self.datalookup={}
local Cfg=cfg_xingyuconfig()
local col=11
for i,v in ipairs(Cfg)do
local xyId=v.id
self.datalookup[xyId]={}
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local datalist={}
local prefabnameList={}


local xyInfoItemTemp={}
xyInfoItemTemp.itemType=ItemType.eXyInfoItem
xyInfoItemTemp.showRIconName=xyCfg.showRIconName
xyInfoItemTemp.name=xyCfg.name

xyInfoItemTemp.colorAssest=xyCfg.colorAssest
table.insert(prefabnameList,ItemName[ItemType.eXyInfoItem])
table.insert(datalist,xyInfoItemTemp)


local tsTitleItemTemp={}
tsTitleItemTemp.itemType=ItemType.eTitleItem
tsTitleItemTemp.name="探索期奖励"
table.insert(prefabnameList,ItemName[ItemType.eTitleItem])
table.insert(datalist,tsTitleItemTemp)

local IntervalItemTempts1={}
IntervalItemTempts1.itemType=ItemType.eIntervalItem
IntervalItemTempts1.hight=7
table.insert(prefabnameList,ItemName[ItemType.eIntervalItem])
table.insert(datalist,IntervalItemTempts1)

local tstipsItemTemp={}
tstipsItemTemp.itemType=ItemType.eTipItem
tstipsItemTemp.tips="星域品质越高，高品质星辰获得几率越高"
table.insert(prefabnameList,ItemName[ItemType.eTipItem])
table.insert(datalist,tstipsItemTemp)

local tsSubTitleItemTemp={}
tsSubTitleItemTemp.itemType=ItemType.eSubTitleItem
tsSubTitleItemTemp.name="探索有机会获得以下奖励"
table.insert(prefabnameList,ItemName[ItemType.eSubTitleItem])
table.insert(datalist,tsSubTitleItemTemp)


local tsZYRewards=table.deepCopy(xyCfg.tsZYRewards)
local lookup={}
for i,v in ipairs(tsZYRewards)do
if lookup[v[1]]then
lookup[v[1]]=lookup[v[1]]+v[2]
else
lookup[v[1]]=v[2]
end
end
tsZYRewards={}
for k,v in pairs(lookup)do
local color=itemsConfig.getItemColor(k)
table.insert(tsZYRewards,{k,v,color})
end
table.sort(tsZYRewards,function(a,b)
return a[3]>b[3]
end)

local row=math.ceil(#tsZYRewards/col)
for _r=1,row do
local rewardItemTemp={}
rewardItemTemp.titleName=_r==1 and"image_xyjl_zy"or nil
rewardItemTemp.itemType=ItemType.eRewardItem
table.insert(prefabnameList,ItemName[ItemType.eRewardItem])
local _rewardList={}
for _c=1,col do
local index=(_r-1)*col+_c
local rewardData=tsZYRewards[index]
if rewardData then
table.insert(_rewardList,rewardData)
end
end
rewardItemTemp.rewardList=_rewardList
table.insert(datalist,rewardItemTemp)
end


local tsOtherRewards=table.deepCopy(xyCfg.tsOtherRewards)
lookup={}
for i,v in ipairs(tsOtherRewards)do
if lookup[v[1]]then
lookup[v[1]]=lookup[v[1]]+v[2]
else
lookup[v[1]]=v[2]
end
end
tsOtherRewards={}
for k,v in pairs(lookup)do
local color=itemsConfig.getItemColor(k)
table.insert(tsOtherRewards,{k,v,color})
end
table.sort(tsOtherRewards,function(a,b)
return a[3]>b[3]
end)

local row=math.ceil(#tsOtherRewards/col)
for _r=1,row do
local rewardItemTemp={}
rewardItemTemp.titleName=_r==1 and"image_xyjl_qt"or nil
rewardItemTemp.itemType=ItemType.eRewardItem
table.insert(prefabnameList,ItemName[ItemType.eRewardItem])
local _rewardList={}
for _c=1,col do
local index=(_r-1)*col+_c
local rewardData=tsOtherRewards[index]
if rewardData then
table.insert(_rewardList,rewardData)
end
end
rewardItemTemp.rewardList=_rewardList
table.insert(datalist,rewardItemTemp)
end




local IntervalItemTemp1={}
IntervalItemTemp1.itemType=ItemType.eIntervalItem
IntervalItemTemp1.hight=9
table.insert(prefabnameList,ItemName[ItemType.eIntervalItem])
table.insert(datalist,IntervalItemTemp1)

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

self.datalookup[xyId].datalist=datalist
self.datalookup[xyId].prefabnameList=prefabnameList
end
end


function UIXingYuListRewardWin:refresh()
local xyCfg=XingYuModel:getXingYuConfig(_this.curXYId)
self.title:setText(xyCfg.name)
local datalist=self.datalookup[_this.curXYId].datalist
local prefabnameList=self.datalookup[_this.curXYId].prefabnameList
if#datalist>0 then
self.LoopScrollView:initDataEx(prefabnameList,datalist)
else
self.LoopScrollView:initData(nil,nil,0)
end
local lastShowIndex=self.lastDataIndexList[_this.curXYId]
if lastShowIndex then
self.LoopScrollView:jumpItem(lastShowIndex)
end
end

function UIXingYuListRewardWin:onFreshAction(index,widget,data)
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

function UIXingYuListRewardWin:SetChildLayoutGroup(widget,list,cmpIndex)
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
if itemNum==-1 then
item:SetChildActive(13,true)
item:SetChildCSImageSprite(13,"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hailiang")
else
item:SetChildActive(13,false)
end

local duanwei=rewardData.duanwei or 0
item:SetChildActive(14,duanwei==1)
end)
end

function UIXingYuListRewardWin:onStartAction()
end

function UIXingYuListRewardWin:getCurShowDataIndex()
local jumptargetIndex
local cnt=self.LoopScrollView:getListViewItemShowCount()
local tran=self.Viewport:getCommonComponent('RectTransform')
local minY
for showIndex=1,cnt do
local showItem=self.LoopScrollView:getListViewItemByItemIdx(showIndex)
local position=showItem.Widget:GetChildPosition(-1)
local screenPoint=CS.CSGUIManager.Instance:WorldToScreenPoint(position)

local lpos=CS.CSGUIManager.Instance:ScreenPointToRectTransform(tran,screenPoint,true)
local absY=math.abs(lpos.y)
if not minY or minY>absY then
minY=absY
jumptargetIndex=showItem.ItemIndex+1
end
end
return jumptargetIndex

end


function UIXingYuListRewardWin:onHide()

end

function UIXingYuListRewardWin:setToggleOn(xyid,on)
local index=self.indexlookup[xyid]
local item=self.ToggleGroup:getChildLayoutGroupGridItem(index-1)
if on then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,on and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end







function UIXingYuListRewardWin:onCloseBtn()
self:closeSelf()
end

function UIXingYuListRewardWin.onToggleChange(xyid)


if _this.curXYId~=xyid then
if _this.curXYId then
_this:setToggleOn(_this.curXYId,false)
end
_this.lastDataIndexList[_this.curXYId]=_this:getCurShowDataIndex()
_this.curXYId=xyid

_this:setToggleOn(_this.curXYId,true)
_this:refresh(_this.curXYId)

end
end

function UIXingYuListRewardWin:onChangeLevel(level)
self.selectLevel=level
self:initlookup()
self:refresh()
end


