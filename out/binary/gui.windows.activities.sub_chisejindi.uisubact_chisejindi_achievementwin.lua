







def_class("UISubAct_ChiSeJinDi_AchievementWin",UIWindowBase)









function UISubAct_ChiSeJinDi_AchievementWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_ChiSeJinDi_AchievementWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
end















local _this=nil
local _itemCmp={
name=0,
content=1,
rewards=2,
finish=3,
getted=4,
gray=5,
warning=6,
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UISubAct_ChiSeJinDi_AchievementWin:onLoaded(...)
self:bindComponents()
_this=self

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

socketManager:addNotify(249,235,self.on_249_235)
socketManager:addNotify(249,240,self.on_249_240)
end


function UISubAct_ChiSeJinDi_AchievementWin:__delete()
self:unbindComponents()
_this=nil

socketManager:removeNotify(249,235,self.on_249_235)
socketManager:removeNotify(249,240,self.on_249_240)
end




function UISubAct_ChiSeJinDi_AchievementWin:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin

self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.sortList={}
for i,v in ipairs(self.config.aim)do
table.insert(self.sortList,i)
end
self:refreshList()
end


function UISubAct_ChiSeJinDi_AchievementWin:onHide()

end




function UISubAct_ChiSeJinDi_AchievementWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_AchievementWin:onBackground()
self:onCloseBtn()
end

function UISubAct_ChiSeJinDi_AchievementWin:refreshList()
table.sort(self.sortList,self.onSortList)
local listCnt=math.ceil(#self.sortList/2)
self.enhancedscrollscript:initData(listCnt,196,listCnt)
end

function UISubAct_ChiSeJinDi_AchievementWin:refreshItem(item,targetIdx)
local zmLevel=zongmenModel:getLevel()
local strCfg=self.config.aimStr[targetIdx]
local rewardId=self.config.aim[targetIdx][2]
local rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(rewardId,zmLevel)
local rewards=rewardCfg.showItems
local flag=self.info:getTargetFlag(targetIdx)
local count=#rewards
item:SetChildText(_itemCmp.name,strCfg[1])
item:SetChildText(_itemCmp.content,strCfg[2])
item:SetChildText(_itemCmp.warning,strCfg[3]or"")
item:SetChildActive(_itemCmp.getted,flag==1)
item:SetChildActive(_itemCmp.gray,flag==1)
item:SetChildLayoutGroupCreateItems(_itemCmp.rewards,count,function(idx)
local _item=item:GetChildLayoutGroupGridItem(_itemCmp.rewards,idx-1)
local _data=rewards[idx]
local showCountBG=_data[2]>1
local countStr=showCountBG and mathHelper.formatNumber(_data[2])or""
local conf={itemid=_data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
_item:SetChildPropData(0,prop)
_item:SetBaseItemClickEvent(0,function(...)
if flag==0 then
local list=self.info:getAllTargetFlag0()
call_activitiesHandle_func("activitiesHandle_chisejindi","reqGetTargetReward",self.actId,self.subId,list)
else
itemsComponentHelper.onItemClickEx(...)
end
end)
_item:SetChildActive(1,flag==0)
_item:SetChildActive(2,liandonModel:getIsLianDonItem(_data[1]))
end)
end

function UISubAct_ChiSeJinDi_AchievementWin.onSortList(a,b)
local aSort=_this.info:getTargetFlag(a)or 0.5
local bSort=_this.info:getTargetFlag(b)or 0.5
if aSort==bSort then
return a<b
else
return aSort<bSort
end
end

function UISubAct_ChiSeJinDi_AchievementWin.on_249_235(actId,subId,targetIdx)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshList()
end
end

function UISubAct_ChiSeJinDi_AchievementWin.on_249_240(args)
local actId=args[1]
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local subId=args[2]
if _this.info:compare(actId,subType,subId)then
_this:refreshList()
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
for i=0,1 do
local index=(dataIndex-1)*2+1+i
local data=self.window.sortList[index]
cell:SetChildActive(i,data~=nil)
if data then
local widget=cell:GetChildWidgetBase(i)
self.window:refreshItem(widget,data)
end
end
end