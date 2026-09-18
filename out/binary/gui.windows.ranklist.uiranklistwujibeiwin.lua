







def_class("UIRankListWuJiBeiWin",UIWindowBase)









function UIRankListWuJiBeiWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.leftList=UIComboScrollView.get(self,2)
self.rightList=UIScrollView.get(self,3)
self.talk=UIObject.get(self,4)
self.title_1=UIText.get(self,5)
self.title_2=UIText.get(self,6)
self.title_3=UIText.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.title={
self.title_1,
self.title_2,
self.title_3,
}



end


function UIRankListWuJiBeiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.leftList);self.leftList=nil;
_UIObject_release(self.rightList);self.rightList=nil;
_UIObject_release(self.talk);self.talk=nil;
_UIObject_release(self.title_1);self.title_1=nil;
_UIObject_release(self.title_2);self.title_2=nil;
_UIObject_release(self.title_3);self.title_3=nil;
self.title=nil;
end
















local comboItemKid={
select=0,
name=1,
reddot=2,
}
local listItemKid={
leftframe=0,
rightframe=1,
head=2,


levelTx=4,
playerName=5,
descTx=6,
effect=7,
getted=8,
item=9,
headEmpty=10,
levelBg=11,
headBg=12,
reddot=13,
}




function UIRankListWuJiBeiWin:onLoaded(...)
self:bindComponents()
local _mainClickLeft=function(...)self:mainClickLeft(...)end
local _subClickLeft=function(...)self:subClickLeft(...)end
local _mainCreateLeft=function(...)self:mainCreateLeft(...)end
local _subCreateLeft=function(...)self:subCreateLeft(...)end
local _onExpandLeft=function(...)self:onExpandLeft(...)end

self.leftList:setAction(_mainClickLeft,_subClickLeft,_mainCreateLeft,_subCreateLeft,_onExpandLeft)




self.mainSelect=1
self.subSelect=1
local cnt=#wuJiBeiModel.mainShowList
self.leftList:createMainGrids(cnt,1,true)
self.leftList:clickItem(0)


end


function UIRankListWuJiBeiWin:__delete()
self:unbindComponents()
end




function UIRankListWuJiBeiWin:onShow(argtable,afterOnloaded)
self.root:setActive(true)
if not afterOnloaded then
self:jumpList()
end
end


function UIRankListWuJiBeiWin:onHide()
self.root:setActive(false)
end




function UIRankListWuJiBeiWin:onCloseBtn()
UIFullZaoHuaTianBeiControl:closeWuJiBei()
end

function UIRankListWuJiBeiWin:mainCreateLeft(mainItem)
local mainIdx=mainItem.Index+1
local mainType=wuJiBeiModel.mainShowList[mainIdx]
local mainTypeCfg=cfgHelper.get1(cfg_wujibeitypeconfig_get,mainType)
local mainReddot=wuJiBeiModel:getTypeReddot(mainType)
local subCnt=#(wuJiBeiModel.subShowList[mainType]or{})
mainItem:SetChildActive(comboItemKid.select,self.mainSelect==mainIdx)
mainItem:SetChildText(comboItemKid.name,mainTypeCfg.name)
mainItem:SetChildActive(comboItemKid.reddot,mainReddot)
mainItem:SetAddExpandColumCount(subCnt)
end

function UIRankListWuJiBeiWin:subCreateLeft(subItem)
local subIdx=subItem.Index+1
local mainIdx=subItem.Mainindex+1

local mainType=wuJiBeiModel.mainShowList[mainIdx]
local subTypeList=wuJiBeiModel.subShowList[mainType]
local subType=subTypeList[subIdx]
local subTypeCfg=cfgHelper.get2(cfg_wujibeichildtypeconfig_get,mainType,subType)
local subReddot=wuJiBeiModel:getChildTypeReddot(mainType,subType)
subItem:SetChildActive(comboItemKid.select,self.mainSelect==mainIdx and self.subSelect==subIdx)
subItem:SetChildText(comboItemKid.name,subTypeCfg.name)
subItem:SetChildActive(comboItemKid.reddot,subReddot)

if self.mainSelect==mainIdx and self.subSelect==subIdx then
self:refreshList()
self:jumpList()
end
end

function UIRankListWuJiBeiWin:mainClickLeft(mainItem)
local mainIdx=mainItem.Index+1

if self.mainSelect~=mainIdx then
if self.mainSelect then
local lMainItem=self.leftList:getMainItem(self.mainSelect-1)
lMainItem:SetChildActive(comboItemKid.select,false)
end
self.mainSelect=mainIdx
self.subSelect=1
local cMainItem=self.leftList:getMainItem(mainIdx-1)
cMainItem:SetChildActive(comboItemKid.select,true)





end
end

function UIRankListWuJiBeiWin:subClickLeft(subItem)
local subIdx=subItem.Index+1
local mainIdx=self.mainSelect
if mainIdx and self.subSelect~=subIdx then


AudioManager.playBtnClick()

if self.subSelect then
local lSubItem=self.leftList:getSubItem(mainIdx-1,self.subSelect-1)
lSubItem:SetChildActive(comboItemKid.select,false)
end
self.subSelect=subIdx
local lSubItem=self.leftList:getSubItem(mainIdx-1,subIdx-1)
lSubItem:SetChildActive(comboItemKid.select,true)

self:refreshList()
self:jumpList()
end
end

function UIRankListWuJiBeiWin:onExpandLeft(index)

end

function UIRankListWuJiBeiWin:jumpList()
local first=nil
for index,achievementId in ipairs(self.achievementList)do
local actor=wuJiBeiModel:getActor(achievementId)
local award=wuJiBeiModel:getAward(achievementId)or 0
local reddot=actor~=nil and award<=0
if reddot then
self.rightList:jumpToLockX(index)
return
elseif first==nil then
if actor==nil then
first=index
end
end
end
first=first or 1
self.rightList:jumpToLockX(first)
end

function UIRankListWuJiBeiWin:updateListData(mainType,subType)
self.achievementList=cfgHelper.get2(cfg_lookupwujibeiconfig_get,mainType,subType)
end

function UIRankListWuJiBeiWin:updateList(mainType,subType)
self:updateListData(mainType,subType)

local listCnt=#self.achievementList

self.rightList:freshGridsNum(listCnt,listCnt,1,true)
for index=1,listCnt do
self:onCreateRightItem(index)
end

end

function UIRankListWuJiBeiWin:refreshList()

local subIdx=self.subSelect
local mainIdx=self.mainSelect
local mainType=wuJiBeiModel.mainShowList[mainIdx]
local subTypeList=wuJiBeiModel.subShowList[mainType]
local subType=subTypeList[subIdx]
self:updateList(mainType,subType)
end

function UIRankListWuJiBeiWin:freshList()
for i=1,#wuJiBeiModel.mainShowList do
local mainItem=self.leftList:getMainItem(i-1)
local _type=wuJiBeiModel.mainShowList[i]
local mainReddot=wuJiBeiModel:getTypeReddot(_type)
mainItem:SetChildActive(comboItemKid.reddot,mainReddot)
end
local mainType=wuJiBeiModel.mainShowList[self.mainSelect]
local subTypeList=wuJiBeiModel.subShowList[mainType]

local subItems=self.leftList:getSubItemsList()
for i=1,subItems.Count do
local subItem=subItems[i-1]
local _type=subTypeList[i]
local subReddot=wuJiBeiModel:getChildTypeReddot(mainType,_type)
subItem:SetChildActive(comboItemKid.reddot,subReddot)
end
for i=1,#self.achievementList do
self:onCreateRightItem(i)
end
end

function UIRankListWuJiBeiWin:onRefreshList(achievementId)
local subIdx=self.subSelect
local mainIdx=self.mainSelect
local mainType=wuJiBeiModel.mainShowList[mainIdx]
local subTypeList=wuJiBeiModel.subShowList[mainType]
local subType=subTypeList[subIdx]
local achievementCfg=cfgHelper.get1(cfg_wujibeiconfig_get,achievementId)

local mainItem=self.leftList:getMainItem(mainIdx-1)
local mainReddot=wuJiBeiModel:getTypeReddot(mainType)
mainItem:SetChildActive(comboItemKid.reddot,mainReddot)

local subItem=self.leftList:getSubItem(mainIdx-1,subIdx-1)
local subReddot=wuJiBeiModel:getChildTypeReddot(mainType,subType)
subItem:SetChildActive(comboItemKid.reddot,subReddot)

if achievementCfg.type==mainType and achievementCfg.child_type==subType then
self:updateList(mainType,subType)
end
end

function UIRankListWuJiBeiWin:onClickItem(itemId,achievementId)
local reddot=wuJiBeiModel:getReddot(achievementId)
if reddot then
rankListController:send_24_22(achievementId)
elseif itemId>0 then
tipsManager.showTips({itemid=itemId})
end
end

function UIRankListWuJiBeiWin:onClickHead(achievementId)
local actor=wuJiBeiModel:getActor(achievementId)
if actor then
if actor.playerName==""then
return
end
otherPlayerController:openOtherPlayerInfoWin(actor.actorId,true)
end
end

function UIRankListWuJiBeiWin:refreshAchievement(achievementId)
local subIdx=self.subSelect
local mainIdx=self.mainSelect
local mainType=wuJiBeiModel.mainShowList[mainIdx]
local subTypeList=wuJiBeiModel.subShowList[mainType]
local subType=subTypeList[subIdx]
local achievementCfg=cfgHelper.get1(cfg_wujibeiconfig_get,achievementId)
if achievementCfg.type==mainType then
local subItem=self.leftList:getSubItem(mainIdx-1,subIdx-1)
local subReddot=wuJiBeiModel:getChildTypeReddot(mainType,subType)
subItem:SetChildActive(comboItemKid.reddot,subReddot)

if achievementCfg.child_type==subType then
for i,v in ipairs(self.achievementList)do
if v==achievementId then
local item=self.rightList:getGridObjectByindex(i-1)
local actor=wuJiBeiModel:getActor(achievementId)
local award=wuJiBeiModel:getAward(achievementId)or 0
local reddot=actor~=nil and award<=0
item:SetChildActive(listItemKid.reddot,reddot)
item:SetChildActive(listItemKid.leftframe,reddot)
item:SetChildActive(listItemKid.rightframe,reddot)
local isGetted=award>0
item:SetChildActive(listItemKid.getted,isGetted)
local propData={}

local gray=0
if isGetted then
gray=mathHelper.setbit(0,eGrayType.eGray-1)
gray=mathHelper.setbit(gray,eGrayType.eMaskGray-1)
end
local itemData={
itemid=achievementCfg.rewards[1][1],
itemcount=achievementCfg.rewards[1][2],
}
local rewardConf={
gray=gray,
showname=false,
}
propData=itemsComponentHelper.getCommonFillData(itemData,rewardConf)
if actor and actor.playerName~=""then
item:SetChildActive(listItemKid.headEmpty,false)














playerController:setHeadIcon(item,listItemKid.head,{iconInfo=actor.head})

item:SetChildText(listItemKid.levelTx,actor.zmLevel)
item:SetChildText(listItemKid.playerName,actor.playerName)
item:SetChildActive(listItemKid.levelBg,true)
else
item:SetChildActive(listItemKid.headEmpty,true)





playerController:setHeadIcon(item,listItemKid.head,nil)

item:SetChildText(listItemKid.levelTx,"")
if actor and actor.playerName==""then
item:SetChildText(listItemKid.playerName,"神秘祖师")
else
item:SetChildText(listItemKid.playerName,"虚位以待")
end
item:SetChildActive(listItemKid.levelBg,false)
end
item:SetChildPropData(listItemKid.item,propData)
end
end
end
end

local mainItem=self.leftList:getMainItem(mainIdx-1)
local mainReddot=wuJiBeiModel:getTypeReddot(mainType)
mainItem:SetChildActive(comboItemKid.reddot,mainReddot)
end

function UIRankListWuJiBeiWin:onCreateRightItem(index)
local achievementId=self.achievementList[index]
local achievementCfg=cfgHelper.get1(cfg_wujibeiconfig_get,achievementId)

local item=self.rightList:getGridObjectByindex(index-1)
local actor=wuJiBeiModel:getActor(achievementId)
local award=wuJiBeiModel:getAward(achievementId)or 0
local reddot=actor~=nil and award<=0
local descStr=wuJiBeiModel:getConditionStr(achievementCfg.conditions[1],achievementCfg.conditions[2])

item:SetChildActive(listItemKid.leftframe,reddot)
item:SetChildActive(listItemKid.rightframe,reddot)

item:SetChildActive(listItemKid.reddot,reddot)

local isGetted=award>0
item:SetChildActive(listItemKid.getted,isGetted)
item:SetChildText(listItemKid.descTx,descStr)

local gray=0
if isGetted then
gray=mathHelper.setbit(0,eGrayType.eGray-1)
gray=mathHelper.setbit(gray,eGrayType.eMaskGray-1)
end
if actor and actor.playerName~=""then
item:SetChildActive(listItemKid.headEmpty,false)













playerController:setHeadIcon(item,listItemKid.head,{iconInfo=actor.head})

item:SetChildText(listItemKid.levelTx,actor.zmLevel)
item:SetChildText(listItemKid.playerName,actor.playerName)
item:SetChildActive(listItemKid.levelBg,true)
else
item:SetChildActive(listItemKid.headEmpty,true)

playerController:setHeadIcon(item,listItemKid.head,nil)





item:SetChildText(listItemKid.levelTx,"")
if actor and actor.playerName==""then
item:SetChildText(listItemKid.playerName,"神秘祖师")
else
item:SetChildText(listItemKid.playerName,"虚位以待")
end
item:SetChildActive(listItemKid.levelBg,false)
end

local itemData={
itemid=achievementCfg.rewards[1][1],
itemcount=achievementCfg.rewards[1][2],
}
local rewardConf={
gray=gray,
showname=false,
}
local propData=itemsComponentHelper.getCommonFillData(itemData,rewardConf)
item:SetChildPropData(listItemKid.item,propData)
item:SetBaseItemClickEvent(listItemKid.item,function(itemId,index,guid,attach)
self:onClickItem(itemId,achievementId)
end)
item:SetChildButtonClickWithID(listItemKid.headBg,function(...)
self:onClickHead(...)
end,achievementId)
end