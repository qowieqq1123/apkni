







def_class("UIXYZDZRoundRewardWin",UIWindowBase)









function UIXYZDZRoundRewardWin:bindComponents()

self.dropItem=UIObject.get(self,0)
self.loseItemList=UIObject.get(self,1)
self.ScrollView=UIScrollView.get(self,2)
self.winItemList=UIObject.get(self,3)



end


function UIXYZDZRoundRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dropItem);self.dropItem=nil;
_UIObject_release(self.loseItemList);self.loseItemList=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.winItemList);self.winItemList=nil;
end



















function UIXYZDZRoundRewardWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClickEx)

end


function UIXYZDZRoundRewardWin:__delete()
self:unbindComponents()
end




function UIXYZDZRoundRewardWin:onShow(argtable,afterOnloaded)
self.level=JiuYuZhengFengModel:getData_rank_level()or 0
self.selectLevel=self.level

self.argtable=argtable

self:refresh()

if self.level>0 then
self:showWindow("UIXingYu_JYZFLevelDropDownWin",{
parent=self,
item=self.dropItem:getWidgetBase(),
node='bottom',
})
end
end


function UIXYZDZRoundRewardWin:onHide()

end

function UIXYZDZRoundRewardWin:refresh()
local xyId=self.argtable.xyId
self.xyId=xyId
local round=self.argtable.menuPageIndex

local tabCfg=oneTabScreenConfig:getScreenConfig(SEC_FULL_TYPE.XYZDZReward)
local childCfg=tabCfg.children
self.tabType=childCfg[round]
self.round=round
local winRwList=XingYuController.getZDRoundRwList(xyId,round,true,self.selectLevel)
local failRwList=XingYuController.getZDRoundRwList(xyId,round,false,self.selectLevel)

self.winItemList:setChildLayoutGroupCreateItems(#winRwList,function(index)
local item=self.winItemList:getChildLayoutGroupGridItem(index-1)
local winRewardData=winRwList[index]

local showCount=winRewardData[2]>1
local fillData=itemsComponentHelper.getCommonFillData({itemid=winRewardData[1]},{showname=false,itemcount=showCount and winRewardData[2]or"",showCountBG=showCount,showStageBg=true})
if itemsConfig.isMoney(winRewardData[1])then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
fillData[PropIndex(DataPropKey.eWidgetActive,14)]=winRewardData.duanwei~=nil and winRewardData.duanwei==1

item:SetChildPropData(0,fillData)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)


self.loseItemList:setChildLayoutGroupCreateItems(#winRwList,function(index)
local item=self.loseItemList:getChildLayoutGroupGridItem(index-1)
local loseRewardData=failRwList[index]

local showCount=loseRewardData[2]>1
local fillData=itemsComponentHelper.getCommonFillData({itemid=loseRewardData[1]},{showname=false,itemcount=showCount and loseRewardData[2]or"",showCountBG=showCount,showStageBg=true})
if itemsConfig.isMoney(loseRewardData[1])then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
fillData[PropIndex(DataPropKey.eWidgetActive,14)]=loseRewardData.duanwei~=nil and loseRewardData.duanwei==1

item:SetChildPropData(0,fillData)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)

local propDatas={}
local list=XingYuController.getZhenDouRoundWinRewardList(xyId,round,true)
local itemList={}
for i,v in ipairs(list)do
local itemId,num=v[1],v[2]
local cfg=itemsConfig.getConfig(itemId)

local score=cfg.color








table.insert(itemList,{itemId,num,score})
end
table.sort(itemList,function(a,b)
return a[3]>b[3]
end)

for i,v in ipairs(itemList)do
local itemid=v[1]
local num=v[2]
local showCount=num>1
local cnt=showCount and num or""
local isTeZhi=false
local isGaiLv=false
local isActReward=false
local fillData=itemsComponentHelper.getCommonFillData({itemid=itemid},{showname=false,itemcount=cnt,showCountBG=showCount,showStageBg=true,range=v.range})
fillData[PropIndex(DataPropKey.eWidgetActive,11)]=isGaiLv or isActReward
fillData[PropIndex(DataPropKey.eWidgetActive,12)]=isTeZhi
table.insert(propDatas,fillData)
end
local count=#propDatas
self.colomn=11
self.row=math.ceil(count,self.colomn)

self.ScrollView:freshGridsNum(0,0,0,false)
self.ScrollView:freshGridsNum(count,self.row,self.colomn,false)
self.ScrollView:initPropData(propDatas)
end


function UIXYZDZRoundRewardWin:onChangeLevel(level)
self.selectLevel=level
self:refresh()
end


