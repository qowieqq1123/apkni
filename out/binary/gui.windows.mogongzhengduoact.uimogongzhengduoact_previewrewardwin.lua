







def_class("UIMoGongZhengDuoAct_PreviewRewardWin",UIWindowBase)









function UIMoGongZhengDuoAct_PreviewRewardWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.dropItem=UIObject.get(self,2)
self.rankScrollview=UIScrollView.get(self,3)
self.Root=UIObject.get(self,4)
self.uiRoot=UIObject.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIMoGongZhengDuoAct_PreviewRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dropItem);self.dropItem=nil;
_UIObject_release(self.rankScrollview);self.rankScrollview=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local _itemCmpIndex={
rankIcon=0,
rank=1,
rewardList=2,
}





function UIMoGongZhengDuoAct_PreviewRewardWin:onLoaded(...)
self:bindComponents()

local _this=self

local _bindScrollView=function(index,item)
if _this==nil then return end

_this:bindScrollView(index,item)
end
self.rankScrollview:bindScrollWidget(_bindScrollView)
end


function UIMoGongZhengDuoAct_PreviewRewardWin:__delete()
self:unbindComponents()
end




function UIMoGongZhengDuoAct_PreviewRewardWin:onShow(argtable,afterOnloaded)
self.level=JiuYuZhengFengModel:getData_rank_level()or 0
self.selectLevel=self.level

self:initData()
self:refreshAll()

if self.level>0 then
self:showWindow("UIXingYu_JYZFLevelDropDownWin",{
parent=self,
item=self.dropItem:getWidgetBase(),
node='bottom',
})
end
end


function UIMoGongZhengDuoAct_PreviewRewardWin:onHide()

end

function UIMoGongZhengDuoAct_PreviewRewardWin:initData()
self.rankDataList=cfgHelper.get2(cfg_mogongzhengduobaseconfig_get,1,'rankRewards4')
local levelRankDataList=defaultT
if self.selectLevel>0 then
levelRankDataList=cfgHelper.get2(cfg_mogongduanweirewardconfig_get,self.selectLevel,'rankRewards4')
end

self.levelRankDataLookUp={}

local rank=0
for _,data in ipairs(levelRankDataList)do
local up=data[1]
local down=data[2]
local reward=data[3]

for index=up,down do
rank=rank+1
self.levelRankDataLookUp[rank]=reward
end
end
end

function UIMoGongZhengDuoAct_PreviewRewardWin:refreshAll()
self:refreshRankScrollView()
end

function UIMoGongZhengDuoAct_PreviewRewardWin:refreshRankScrollView()
local len=#self.rankDataList

self.rankScrollview:freshGridsNum(len,len,1,false)
end

function UIMoGongZhengDuoAct_PreviewRewardWin:bindScrollView(index,item)
local rankData=self.rankDataList[index]

local rankUp=rankData[1]
local rankDown=rankData[2]

local interval=rankDown-rankUp
local isSingle=interval==0

local isTop3=rankDown<=3
local isShowRankIcon=isTop3 and isSingle

item:SetChildActive(_itemCmpIndex.rankIcon,isShowRankIcon)
if isShowRankIcon then
item:SetChildCSImageSprite(_itemCmpIndex.rankIcon,globalABLookup.global,'icon_phbmingci_'..rankDown)
end

if isSingle then
item:SetChildText(_itemCmpIndex.rank,rankDown)
else
local rankTxt=FMT.fmt("{0}~{1}",rankUp,rankDown)
item:SetChildText(_itemCmpIndex.rank,rankTxt)
end

local rewardDataList=rankData[3]
local levelDataList=self.levelRankDataLookUp[rankUp]or defaultT
local list=table.concatTable(levelDataList,rewardDataList)

local rewardLen=#list
item:SetChildLayoutGroupCreateItems(_itemCmpIndex.rewardList,rewardLen,function(index)
local item=item:GetChildLayoutGroupGridItem(_itemCmpIndex.rewardList,index-1)

local data=list[index]

local itemid=data[1]
local itemcount=data[2]
local showCountBG=itemcount>1

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,propData)

item:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemid)
end)

item:SetChildActive(1,data.duanwei and data.duanwei==1 or false)
end)
end

function UIMoGongZhengDuoAct_PreviewRewardWin:onChangeLevel(level)
self.selectLevel=level
self:initData()
self:refreshAll()
end





function UIMoGongZhengDuoAct_PreviewRewardWin:onCloseBtn()
self:closeSelf()
end

