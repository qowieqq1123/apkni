







def_class("UIQQLobbyGiftWin",UIWindowBase)









function UIQQLobbyGiftWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.content=UIObject.get(self,2)
self.giftTab_1=UIBaseItem.get(self,3)
self.giftTab_2=UIBaseItem.get(self,4)
self.giftTab_3=UIBaseItem.get(self,5)
self.giftTypeList=UIObject.get(self,6)
self.levelGift=UIObject.get(self,7)
self.Root=UIObject.get(self,8)
self.singleGift=UIObject.get(self,9)
self.uiRoot=UIObject.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.giftTab={
self.giftTab_1,
self.giftTab_2,
self.giftTab_3,
}



end


function UIQQLobbyGiftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.giftTab_1);self.giftTab_1=nil;
_UIObject_release(self.giftTab_2);self.giftTab_2=nil;
_UIObject_release(self.giftTab_3);self.giftTab_3=nil;
_UIObject_release(self.giftTypeList);self.giftTypeList=nil;
_UIObject_release(self.levelGift);self.levelGift=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.singleGift);self.singleGift=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.giftTab=nil;
end
















local _this=nil

local _stageTabEnum={
eDayActiveGift=1,
eLoginGift=2,
eLevelGift=3,
}

local _contentTypeEnum={
eSigle=1,
eList=2,
}













local _stageClientConfig={
[_stageTabEnum.eLoginGift]={
name='新手注册礼包',
contentType=_contentTypeEnum.eSigle,
cfgKey=shopLibaoType.eQQLobby_Login,
reddot=function()
return qqLobbyActController:checkLoginRewardReddot()
end,
enterAnimId=3402,
standAnimId=3405,
},
[_stageTabEnum.eDayActiveGift]={
name='每日活跃礼包',
contentType=_contentTypeEnum.eSigle,
cfgKey=shopLibaoType.eQQLobby_Active,
reddot=function()
return qqLobbyActController:checkDayActiveReddot()
end,
enterAnimId=3401,
standAnimId=3404,
},
[_stageTabEnum.eLevelGift]={
name='游戏成长礼包',
contentType=_contentTypeEnum.eList,
cfgKey=shopLibaoType.eQQLobby_Grown,
reddot=function()
return qqLobbyActController:checkLevelRewardReddot()
end,
enterAnimId=3403,
standAnimId=3406,
getData=function(self)
local tempDataList=self.levelDataList[shopLibaoType.eQQLobby_Grown]

if tempDataList==nil then
tempDataList=rechargeModel:getXianGouLiBaoConfig(shopLibaoType.eQQLobby_Grown)
self.levelDataList[shopLibaoType.eQQLobby_Grown]=tempDataList
end

if tempDataList==nil or next(tempDataList)==nil then
return
end

local isCanRecv,isRecved,buyNum,sortVal
for index,levelData in ipairs(tempDataList)do
isCanRecv=rechargeModel:checkXianGouLiBaoOpen(levelData.conditions)
buyNum=rechargeModel:getXianGouLiBaoBuyNum(levelData.id)
isRecved=buyNum>=levelData.maxcount

sortVal=10000-levelData.sortid

if isRecved then
levelData.sortTag=10000+sortVal
elseif isCanRecv then
levelData.sortTag=30000+sortVal
else
levelData.sortTag=20000+sortVal
end
end

table.sort(tempDataList,function(a,b)
return a.sortTag>b.sortTag
end)

return tempDataList
end
}
}




function UIQQLobbyGiftWin:onLoaded(...)
self:bindComponents()

_this=self

self.levelDataList={}


self.typeSelectIdx=_stageTabEnum.eDayActiveGift

for index=_stageTabEnum.eDayActiveGift,_stageTabEnum.eLevelGift do
local data=_stageClientConfig[index]
if data.reddot()then
self.typeSelectIdx=index
break
end
end
end


function UIQQLobbyGiftWin:__delete()
_this=nil

self:unbindComponents()
end




function UIQQLobbyGiftWin:onShow(argtable,afterOnloaded)


self:refreshAll()

if afterOnloaded then
self.uiRoot:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(6182,1,nil,_stageClientConfig[self.typeSelectIdx].enterAnimId)
self:delayDo(0.2,function()
if _this==nil then return end
_this.uiRoot:setChildCanvasGroupDOFade(1,0.2)
end)
end
end


function UIQQLobbyGiftWin:onHide()

end

function UIQQLobbyGiftWin:onCloseBtn()
self:closeSelf()
end



function UIQQLobbyGiftWin:refreshAll()
self:refreshTypeTabList()

self:refreshContent()
end

function UIQQLobbyGiftWin:refreshTypeTabList()
local typeLen=#_stageClientConfig

local craeteFunc=function(index,item)
if _this==nil then return end

local data=_stageClientConfig[index]

item:SetChildText(0,data.name)
item:SetChildActive(1,_this.typeSelectIdx==index)

local isReddot=data.reddot()

item:SetChildActive(2,isReddot)

item:SetBaseItemClickEvent(-1,function()

if _this==nil then return end

local preItem=self.giftTab[self.typeSelectIdx]:getWidgetBase()
preItem:SetChildActive(1,false)

_this.typeSelectIdx=index
item:SetChildActive(1,true)

_this:refreshContent()
_this.bgModel:setChildUIModelShowTarget(6182,1,nil,_stageClientConfig[_this.typeSelectIdx].standAnimId)
end)
end

for index=1,typeLen do
local item=self.giftTab[index]:getWidgetBase()
craeteFunc(index,item)
end
end

function UIQQLobbyGiftWin:refreshContent()
local data=_stageClientConfig[self.typeSelectIdx]

local type=data.contentType

self.singleGift:setActive(type==_contentTypeEnum.eSigle)
self.levelGift:setActive(type==_contentTypeEnum.eList)

if type==_contentTypeEnum.eSigle then
self:refreshSingleContent()
elseif type==_contentTypeEnum.eList then
self:refreshLevelListContent()
end
end

function UIQQLobbyGiftWin:refreshSingleContent()
local data=_stageClientConfig[self.typeSelectIdx]
local giftList=rechargeModel:getXianGouLiBaoConfig(data.cfgKey)
local giftCfg=giftList[1]
local giftId=giftCfg.id
local rewards=giftCfg.rewards
rewards=rewards[1][3]
local rewardLen=#rewards

local wb=self.singleGift:getChildWidgetBase()


local conditions=giftCfg.conditions
local isCanRecv=rechargeModel:checkXianGouLiBaoOpen(conditions)
local isRecved=rechargeModel:getXianGouLiBaoBuyNum(giftId)>0

wb:SetChildActive(1,not isRecved)
wb:SetChildButtonEnable(1,true,not isCanRecv)

wb:SetChildButtonClick(1,function()
if isCanRecv then
rechargeController:reqXianGouLiBaoBuy(giftId,1)
else



end
end)

wb:SetChildActive(2,isRecved)


local clickFunc=function(clickCount,index)

end

wb:SetChildScrollViewInit(0,-1,true,clickFunc,clickFunc)

wb:SetChildScrollViewCreateGrids(0,rewardLen,rewardLen)
local grids=wb:GetChildScrollViewItemWidgets(0)
wb:SetChildScrollRectEnable(0,rewardLen>6)
for index=1,rewardLen do
local grid=grids[index-1]
local rewardData=rewards[index]

local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local itemCountStr=showCountBG and itemNum or""

local conf={itemid=itemId,itemcount=itemCountStr,showCountBG=showCountBG,showStage=true,showname=false,}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

grid:SetChildPropData(0,prop)
grid:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemId)
end)

grid:SetChildActive(1,(not isRecved)and isCanRecv)
end
end

local _levelItemIndex={
level=0,
list=1,
recvBtn=2,
recvImg=3,
}

function UIQQLobbyGiftWin:refreshLevelListContent()
local wb=self.levelGift:getChildWidgetBase()

local data=_stageClientConfig[self.typeSelectIdx]
local levelList=data.getData(self)

if levelList==nil or next(levelList)==nil then



return
end

local levelLen=#levelList

local clickFunc=function(clickCount,index)

end
wb:SetChildScrollViewInit(0,-1,true,clickFunc,clickFunc)
wb:SetChildScrollRectEnable(0,levelLen>3)
wb:SetChildScrollViewCreateGrids(0,levelLen,1)
local grids=wb:GetChildScrollViewItemWidgets(0)

for index=1,levelLen do
local grid=grids[index-1]
local levelData=levelList[index]

local giftId=levelData.id

local rewards=cfgHelper.get2(cfg_limitedgiftconfig_get,giftId,'rewards')
rewards=rewards[1][3]
local rewardLen=#rewards


local conditions=cfgHelper.get2(cfg_limitedgiftconfig_get,giftId,'conditions')
local isCanRecv=rechargeModel:checkXianGouLiBaoOpen(conditions)

local isRecved=rechargeModel:getXianGouLiBaoBuyNum(giftId)>0


grid:SetChildText(_levelItemIndex.level,levelData.name)


grid:SetChildScrollViewInit(_levelItemIndex.list,-1,true,clickFunc,clickFunc)
grid:SetChildScrollRectEnable(_levelItemIndex.list,rewardLen>4)
grid:SetChildScrollViewCreateGrids(_levelItemIndex.list,rewardLen,rewardLen)
local sgrids=grid:GetChildScrollViewItemWidgets(1)

for index=1,rewardLen do
local sgrid=sgrids[index-1]
local rewardData=rewards[index]

local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local itemCountStr=showCountBG and itemNum or""

local conf={itemid=itemId,itemcount=itemCountStr,showCountBG=showCountBG,showStage=true,showname=false,}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

sgrid:SetChildPropData(0,prop)
sgrid:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemId)
end)

sgrid:SetChildActive(1,(not isRecved)and isCanRecv)
end


grid:SetChildActive(_levelItemIndex.recvBtn,not isRecved)
local btnClick=function()
if isCanRecv then
rechargeController:reqXianGouLiBaoBuy(giftId,1)
else



end
end
grid:SetChildButtonClick(_levelItemIndex.recvBtn,btnClick,true)
grid:SetChildButtonEnable(_levelItemIndex.recvBtn,true,not isCanRecv)


grid:SetChildActive(_levelItemIndex.recvImg,isRecved)
end
end





