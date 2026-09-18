







def_class("UIXianJieExplorationLingShouWin",UIWindowBase)









function UIXianJieExplorationLingShouWin:bindComponents()

self.applyBtn=UIButton.get(self,0)
self.applyBtnTxt=UIText.get(self,1)
self.comboScrollView=UIComboScrollView.get(self,2)
self.empty=UIObject.get(self,3)
self.qiehuan=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.uiPanel=UIObject.get(self,6)
self.useItem=UIBaseItem.get(self,7)
self.useItemEmpty=UIObject.get(self,8)
self.useItemPart=UIButton.get(self,9)
self.useTips=UIText.get(self,10)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.useItemPart:setButtonClick(function()self:onUseItemPart()end)



end


function UIXianJieExplorationLingShouWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.applyBtnTxt);self.applyBtnTxt=nil;
_UIObject_release(self.comboScrollView);self.comboScrollView=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.qiehuan);self.qiehuan=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.useItem);self.useItem=nil;
_UIObject_release(self.useItemEmpty);self.useItemEmpty=nil;
_UIObject_release(self.useItemPart);self.useItemPart=nil;
_UIObject_release(self.useTips);self.useTips=nil;
end
















local _this=nil
local comboIndex=
{
btn=0,
select=1,
name=2,
reddot=3,
up=4,
down=5,
}

local comboChildIndex=
{
btn=0,
select=1,
name=2,
reddot=3,
leftTime=4,
}

local _groupEnum={
NORMAL=1,
BHORDE=2,
}

local _groupInfoList={
[_groupEnum.NORMAL]={
name="游荡灵兽",
child={},
refreshChilds=function()
local datas=xianjieModel:getXJLingShouDatas()

local list={}
for infoGuidStr,data in pairs(datas)do
table.insert(list,data)
end

table.sort(list,function(a,b)
return a.expiresec<b.expiresec
end)

_this.childList[_groupEnum.NORMAL]=list
end,
reddot=function(_self)

end,
},
[_groupEnum.BHORDE]={
name="神秘兽巢",
child={},
refreshChilds=function(_self)
local datas=xianjieModel:getXJLingShouGroupDatas()

local list={}
for infoGuidStr,data in pairs(datas)do
table.insert(list,data)
end

table.sort(list,function(a,b)
return a.expiresec<b.expiresec
end)

_this.childList[_groupEnum.BHORDE]=list
end,
reddot=function(_self)

end,
},
}

function UIXianJieExplorationLingShouWin:onApplyBtn()
local itemID=self.selectID
if itemID and itemID>0 then
local needCount=cfgHelper.get(cfg_xianjielingshoulibconfig_get,itemID,'useNum')

UIManager:showWindow("UIXianJieLingShouSummonWin")

local func=function()
xianjieController:reqRandLingShouPosition(itemID)
end
itemsModel:useItem(itemID,needCount,func,WARNING_TYPE.eWarning)
else

end
end

function UIXianJieExplorationLingShouWin:onUseItemPart()
self:showSelectWin()
end




function UIXianJieExplorationLingShouWin:onLoaded(...)
self:bindComponents()

_this=self

self.selectID=nil
self.childList={}

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.comboScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)

local _onXianJieLingShouDataChange=function(type,infoGuid)
if _this==nil then return end

if _this.mainIndex==_groupEnum.NORMAL then
_this:refreshMainItem()
end
end
self:addNotify(notifyConfig.onXianJieLingShouDataChange,_onXianJieLingShouDataChange)

local _onXianJieLingShouGroupDataChange=function(type,infoGuid)
if _this==nil then return end

if _this.mainIndex==_groupEnum.BHORDE then
_this:refreshMainItem()
end
end
self:addNotify(notifyConfig.onXianJieLingShouGroupDataChange,_onXianJieLingShouGroupDataChange)
end


function UIXianJieExplorationLingShouWin:__delete()

self:stopLeftTimeTimer()

_this=nil
self:unbindComponents()
end




function UIXianJieExplorationLingShouWin:onShow(argtable,afterOnloaded)
self:initComboData()
self:refreshView()
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
end


function UIXianJieExplorationLingShouWin:onHide()

end

function UIXianJieExplorationLingShouWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIXianJieExplorationWin','playEnterAnim')
end
function UIXianJieExplorationLingShouWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end

function UIXianJieExplorationLingShouWin:checkIsEmpty()
local num=0
for index,data in ipairs(self.tagList)do
num=num+#self.childList[index]
end
return num<=0
end


function UIXianJieExplorationLingShouWin:refreshView()
local isEmpty=self:checkIsEmpty()
self.empty:setActive(isEmpty)
self.comboScrollView:setActive(not isEmpty)

if not isEmpty then
self:refreshComboWidget()

self:startLeftTimeTimer()
end

self:refreshOptionPart()
end


function UIXianJieExplorationLingShouWin:initComboData()
self.tagList=_groupInfoList

for index,data in ipairs(self.tagList)do
data:refreshChilds()
end
end

function UIXianJieExplorationLingShouWin:refreshComboWidget()

local c=#self.tagList
self.comboScrollView:createMainGrids(c,1,true)
end

function UIXianJieExplorationLingShouWin:refreshMainItem(mainIndex)
mainIndex=self.mainIndex
if mainIndex then
local oldLen=#self.comboSubItemLookup
local data=self.tagList[mainIndex]
data:refreshChilds()

local num=#data.child
if num==oldLen then
local list=self.comboSubItemLookup
self.comboSubItemLookup={}
for index,subItem in pairs(list)do
self:subCreateAction(subItem)
end
self:startLeftTimeTimer()
else
self.comboSubItemLookup={}
self.comboScrollView:rebuildSubItems(mainIndex-1,num,function()
self:startLeftTimeTimer()
end)
end
end
end

function UIXianJieExplorationLingShouWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local data=self.tagList[index]
if data then
data:refreshChilds()

mainItem:SetChildText(comboIndex.name,data.name)

self:refreshMainItemSelect(mainItem,index,false)

if self.childList[index]then
mainItem:SetAddExpandColumCount(#self.childList[index])
else
mainItem:SetAddExpandColumCount(0)
end

local reddot=data:reddot()
mainItem:SetChildActive(comboIndex.reddot,reddot)

mainItem:SetChildGray(comboIndex.btn,true)
end

if index==#self.tagList then
if self.defaultMainIndex~=nil then
self.comboScrollView:clickItem(self.defaultMainIndex-1)
self.defaultMainIndex=nil
end
end
end


function UIXianJieExplorationLingShouWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local data=self.tagList[mainIndex]
if data then
if self.childList[index]then
self.comboSubItemLookup[index]=subItem
local cData=self.childList[mainIndex][index]

subItem:SetChildText(comboChildIndex.name,cData:getName())
subItem:SetChildActive(comboChildIndex.select,index==self.subIndex)

local reddot=false
subItem:SetChildActive(comboChildIndex.reddot,reddot)

self:refreshSubItemLeftTime(subItem,cData)
end
end
end

function UIXianJieExplorationLingShouWin:refreshSubItemLeftTime(subItem,subData)
local curTime=timeHelper.getServerShortTime()
local left=subData.expiresec-curTime
local isEnd=left<=0
if not isEnd then
subItem:SetChildText(comboChildIndex.leftTime,FMT.fmt("离开时间：{0}",timeHelper.format_time_stamp4(left)))
end
return isEnd
end


function UIXianJieExplorationLingShouWin:onExpandAction(index)
local mainIndex=index+1
local data=self.tagList[mainIndex]
if data then
if self.mainIndex~=nil then

AudioManager.playBtnClick()
end
self:afterClickMain(mainIndex)
elseif index==-1 then

AudioManager.playBtnClick()
end
end

function UIXianJieExplorationLingShouWin:refreshMainItemSelect(mainItem,mainIndex,flag)
if mainItem==nil then
mainItem=self.comboScrollView:getMainItem(mainIndex-1)
end
if mainItem then
mainItem:SetChildActive(comboIndex.select,flag)
mainItem:SetChildActive(comboIndex.up,not flag)
mainItem:SetChildActive(comboIndex.down,flag)
end
end

function UIXianJieExplorationLingShouWin:mainClickAction(mainItem)
local oldMainIndex=self.mainIndex
local index=mainItem.Index+1
if index==oldMainIndex then
return
end

self.mainIndex=index
self:refreshMainItemSelect(mainItem,index,true)
if oldMainIndex~=nil then
self:refreshMainItemSelect(nil,oldMainIndex,false)
end
end

function UIXianJieExplorationLingShouWin:subClickAction(subItem)
local subIndex=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local oldSubIndex=self.subIndex
if oldSubIndex and subIndex==oldSubIndex then
return
end
self.subIndex=subIndex
if oldSubIndex then
local oldSubItem=self.comboScrollView:getSubItem(mainIndex-1,oldSubIndex-1)
oldSubItem:SetChildActive(comboIndex.select,false)

AudioManager.playBtnClick()
end
subItem:SetChildActive(comboIndex.select,true)

local data=self.tagList[mainIndex]
local lsData=self.childList[mainIndex][subIndex]

local openFunc=function()
local entity=xianjieController:getEntity(lsData.ent_key)
local boxParams=entity:handleBoxParams()
entity:onClick(boxParams)
end

local sceneIdx=lsData.sceneidx
xianjieController:jumpGrid(sceneIdx,lsData.gridX_c,lsData.gridZ_c,openFunc,true,nil)
end

function UIXianJieExplorationLingShouWin:afterClickMain(mainIndex)

local oldMainIndex=self.mainIndex
self.mainIndex=mainIndex

self.comboSubItemLookup={}

self:refreshMainItemSelect(nil,mainIndex,true)
if oldMainIndex~=nil and oldMainIndex~=mainIndex then
self:refreshMainItemSelect(nil,oldMainIndex,false)
end
end

function UIXianJieExplorationLingShouWin:refreshCurSubItemLeftTime()
if self.comboSubItemLookup==nil or next(self.comboSubItemLookup)==nil then return end
if self.mainIndex==nil then return end
local data=self.tagList[self.mainIndex]

for index,subItem in pairs(self.comboSubItemLookup)do
local subData=self.childList[self.mainIndex][index]
local isBreak=self:refreshSubItemLeftTime(subItem,subData)
if isBreak then
_this:stopLeftTimeTimer()
break
end
end
end


function UIXianJieExplorationLingShouWin:stopLeftTimeTimer()
if self.leftTimeTimer then
self:stopTimerByID(self.leftTimeTimer)
self.leftTimeTimer=nil
end
end

function UIXianJieExplorationLingShouWin:startLeftTimeTimer()
self:stopLeftTimeTimer()

local func=function()
if _this==nil then return end
_this:refreshCurSubItemLeftTime()
end

self.leftTimeTimer=self:setTimer(1,0,func)
func()
end



function UIXianJieExplorationLingShouWin:refreshOptionPart()
local isFill=self.selectID~=nil

self.useItemEmpty:setActive(not isFill)
self.useItem:setActive(isFill)
self.qiehuan:setActive(isFill)

local tips="请选择<color=#549327>引妖香</color>吸引灵兽"

if isFill then
local itemID=self.selectID

local needCount=cfgHelper.get(cfg_xianjielingshoulibconfig_get,itemID,'useNum')
local itemCount=Mathf.Min(needCount,itemsModel.getCount(itemID))
local isFull=itemCount>=needCount
local color=isFull and FONT_COLOR.eNomalColor or FONT_COLOR.eRedColor
local countStr=FMT.fmt("{0}/{1}",toColorString(color,itemCount),needCount)

local conf={itemid=itemID,itemcount=countStr,showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.winlua:SetChildPropData(self.useItem:getID(),prop)
self.winlua:SetBaseItemClickEvent(self.useItem:getID(),function(...)
if _this==nil then return end
_this:showSelectWin()
end)

local remainingCount=xianjieController:getFindCostItemGuarantee(itemID)
tips=FMT.fmt("再使用{0}搜寻{1}次，必定发现<color=#c82c2c>红色灵兽</color>的踪迹",itemsConfig.getColorName(itemID),remainingCount)
end

self.useTips:setText(tips)

local applayTxt=isFill and'焚香引灵'or'灵兽寻踪'
self.applyBtnTxt:setText(applayTxt)
end

function UIXianJieExplorationLingShouWin:showSelectWin()
local args={
selectID=self.selectID,
parent=_this,
}
self:showWindow("UIXianJieLingShouYYXWin",args)
end

function UIXianJieExplorationLingShouWin:onFillItem(itemID)
self.selectID=itemID

self:refreshOptionPart()
end


