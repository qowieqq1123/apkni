







def_class("UILunDaoDaHuiLeftWin",UIWindowBase)









function UILunDaoDaHuiLeftWin:bindComponents()

self.tagGroup=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.item1=UIObject.get(self,2)
self.item2=UIObject.get(self,3)
self.item3=UIObject.get(self,4)
self.comboScrollView=UIComboScrollView.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UILunDaoDaHuiLeftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tagGroup);self.tagGroup=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.comboScrollView);self.comboScrollView=nil;
end



















local comboIndex=
{
btn=0,
select=1,
name=2,
reddot=3,
}

local comboChildIndex=
{
btn=0,
select=1,
name=2,
reddot=3,
}

local _this


function UILunDaoDaHuiLeftWin:onLoaded(...)
self:bindComponents()

_this=self

self.item=
{
self.item1,
self.item2,
self.item3,
}

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.comboScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)

lundaodahuiController.req_17_20()
end



function UILunDaoDaHuiLeftWin:__delete()
self:unbindComponents()

_this=nil
end

function UILunDaoDaHuiLeftWin:onCloseBtn()
fullScreenUI.closeActiveUI()
end




function UILunDaoDaHuiLeftWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}

local juesaiMatchTime=lundaodahuiModel:getMatchTime(eLDMatchType.juesai)
local checkOpen=false
local now=timeHelper.getServerLongTime()
if juesaiMatchTime then
checkOpen=lundaodahuiModel:checkLunDaoDaHuiEntry()and now<juesaiMatchTime
end
local curType=lundaodahuiModel:getCurMatchType()
self.defaultMainIndex=argtable.page

self.defaultsubIndex=argtable.subPage

if curType and curType>eLDMatchType.xuanBa then
if not self.defaultMainIndex then
self.defaultMainIndex=2
end
if not self.defaultsubIndex then
if curType==eLDMatchType.banjuesai then
self.subIndex=2
elseif curType==eLDMatchType.jijunsai then
self.defaultMainIndex=3
self.subIndex=1
elseif curType==eLDMatchType.juesai then
self.defaultMainIndex=3
local jijumsaiMatchTime=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)
if now<=jijumsaiMatchTime+60 then
self.subIndex=1
else
self.subIndex=2
end
else
self.subIndex=1
end
end
else
if not self.defaultMainIndex then
self.defaultMainIndex=1
end
if not self.defaultsubIndex then
self.subIndex=1
end
end

self.checkOpen=checkOpen
if not self:haveXuanBaSaiData()and self.defaultMainIndex==1 then
self.defaultMainIndex=2
end

self:refreshComboWidget()

if argtable.openShop then
local config=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"shopId")
funcShopController:openShopWin({shopId=config})
end
end

function UILunDaoDaHuiLeftWin:initIndex()
if not self.defaultsubIndex then
self.subIndex=1
local curType=lundaodahuiModel:getCurMatchType()
if curType and curType>eLDMatchType.xuanBa then
local now=timeHelper.getServerLongTime()
if curType==eLDMatchType.banjuesai then
if self.mainIndex==2 then
self.subIndex=2
end
elseif curType==eLDMatchType.jijunsai then
if self.mainIndex==3 then
self.subIndex=1
end
elseif curType==eLDMatchType.juesai then
if self.mainIndex==3 then
local jijumsaiMatchTime=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)
if now<=jijumsaiMatchTime+5*60 then
self.subIndex=1
else
self.subIndex=2
end
end
else
self.subIndex=1
end
end
else
self.subIndex=self.defaultsubIndex
end
self.defaultsubIndex=nil
end

function UILunDaoDaHuiLeftWin:refreshComboWidget()
self.tagList=UIFullLunDaoDaHuiControl.tagList
local c=#self.tagList
self.comboScrollView:createMainGrids(c,1,true)



end

function UILunDaoDaHuiLeftWin:refreshMainItem(mainIndex)
if mainIndex then

local num=0
self.comboScrollView:rebuildSubItems(mainIndex-1,num,nil)
end
end



function UILunDaoDaHuiLeftWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local data=self.tagList[index]
if data then

mainItem:SetChildText(comboIndex.name,data.name)

self:refreshMainItemSelect(mainItem,index,false)

if data.child then
mainItem:SetAddExpandColumCount(#data.child)
else
mainItem:SetAddExpandColumCount(0)
end
local reddot=false
local reddotCheck=data.reddot
if reddotCheck then
reddot=reddotCheck()
end
mainItem:SetChildActive(comboIndex.reddot,reddot)

if index==1 then
if self:haveXuanBaSaiData()then
mainItem:SetChildGray(comboIndex.btn,false)
else
mainItem:SetChildGray(comboIndex.btn,true)
end
else
mainItem:SetChildGray(comboIndex.btn,false)
end
end

if index==#self.tagList then
if self.defaultMainIndex~=nil then
self.comboScrollView:clickItem(self.defaultMainIndex-1)
self.defaultMainIndex=nil
end
end
end


function UILunDaoDaHuiLeftWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local data=self.tagList[mainIndex]
if data then
if data.child then
local cData=data.child[index]

subItem:SetChildText(comboChildIndex.name,cData.name)
subItem:SetChildActive(comboChildIndex.select,index==self.subIndex)

local reddot=false
if cData then
local reddotCheck=cData.reddot
if reddotCheck then
reddot=reddotCheck()
end
end
subItem:SetChildActive(comboChildIndex.reddot,reddot)
end
end


end


function UILunDaoDaHuiLeftWin:onExpandAction(index)
local mainIndex=index+1
local data=self.tagList[mainIndex]
if data then
if self.mainIndex~=nil then

AudioManager.playBtnClick()
end
if not data.child then
if mainIndex==1 then
if not self:haveXuanBaSaiData()then
UIManager.error("暂不可查看")
return
end
end
self:openWindow(data.panel)
else
self:afterClickMain(mainIndex)
end
elseif index==-1 then

AudioManager.playBtnClick()
end
end

function UILunDaoDaHuiLeftWin:refreshMainItemSelect(mainItem,mainIndex,flag)
if mainItem==nil then
mainItem=self.comboScrollView:getMainItem(mainIndex-1)
end
if mainItem then
mainItem:SetChildActive(comboIndex.select,flag)
end
end

function UILunDaoDaHuiLeftWin:mainClickAction(mainItem)
local oldMainIndex=self.mainIndex
local index=mainItem.Index+1
if index==oldMainIndex then
return
end
if index==1 then
if not self:haveXuanBaSaiData()then
UIManager.error("暂不可查看")
return
end
end

self.mainIndex=index
self:initIndex()
self:refreshMainItemSelect(mainItem,index,true)
if oldMainIndex~=nil then
self:refreshMainItemSelect(nil,oldMainIndex,false)
end
end

function UILunDaoDaHuiLeftWin:subClickAction(subItem)
local subIndex=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local oldSubIndex=self.subIndex
if subIndex==oldSubIndex then
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
if data.child then
self:openWindow(data.child[subIndex].panel,data.child[subIndex].args)
end
end

function UILunDaoDaHuiLeftWin:afterClickMain(mainIndex)
if mainIndex==1 then
if not self:haveXuanBaSaiData()then
UIManager.error("暂不可查看")
return
end
end
local oldMainIndex=self.mainIndex
self.mainIndex=mainIndex
self:initIndex()

local data=self.tagList[mainIndex]
if data.child then
local subIdex=self.subIndex or 1
self:openWindow(data.child[subIdex].panel,data.child[subIdex].args)
end

self:refreshMainItemSelect(nil,mainIndex,true)
if oldMainIndex~=nil and oldMainIndex~=mainIndex then
self:refreshMainItemSelect(nil,oldMainIndex,false)
end
end

function UILunDaoDaHuiLeftWin:openWindow(panel,args)
self:hideSubWin()
if self.showWinLookup==nil then
self.showWinLookup={}
end
self:showWindow(panel,args)
self.showWinLookup[panel]=true
end


function UILunDaoDaHuiLeftWin:hideSubWin()
local subwinLookup=self.showWinLookup
if subwinLookup then
for winName,sub_args in pairs(subwinLookup)do
self:hideWindow(winName)
end
self.subwinLookup=nil
end
end


function UILunDaoDaHuiLeftWin:onNormalWidgetClick(index,data,widget)

end


function UILunDaoDaHuiLeftWin:onHide()

end

function UILunDaoDaHuiLeftWin:refreshMainReddot(index)
local mItem=self.comboScrollView:getMainItem(index-1)
if mItem then
local data=self.tagList[index]
if data then
local reddot=false
local reddotCheck=data.reddot
if reddotCheck then
reddot=reddotCheck()
end
mItem:SetChildActive(comboIndex.reddot,reddot)
end
end
end

function UILunDaoDaHuiLeftWin:refreshChildReddot(index)
local subItem=self.comboScrollView:getSubItem(self.mainIndex-1,index-1)
if subItem then
local data=self.tagList[self.mainIndex]
if data then
if data.child then
local cData=data.child[index]
local reddot=false
if cData then
local reddotCheck=cData.reddot
if reddotCheck then
reddot=reddotCheck()
end
end
subItem:SetChildActive(comboChildIndex.reddot,reddot)
end
end
end
end
function UILunDaoDaHuiLeftWin:refreshMainItemGray(mainItem,mainIndex)
if mainItem==nil then
mainItem=self.comboScrollView:getMainItem(mainIndex-1)
end
if mainItem then
if mainIndex==1 then
if self:haveXuanBaSaiData()then
mainItem:SetChildGray(comboIndex.btn,false)
else
mainItem:SetChildGray(comboIndex.btn,true)
if self.mainIndex==1 then
self:afterClickMain(2)
end
end

else
mainItem:SetChildGray(comboIndex.btn,false)
end
end
end
function UILunDaoDaHuiLeftWin:haveXuanBaSaiData()
local data=lundaodahuiModel:getXBSGroupFilterGroup()
return next(data)~=nil
end


