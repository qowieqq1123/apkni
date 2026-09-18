







def_class("UIWDCQGJXXWin",UIWindowBase)









function UIWDCQGJXXWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.bgModel2=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.dropDownRoot=UIObject.get(self,3)
self.fadeRoot=UIObject.get(self,4)
self.head=UIObject.get(self,5)
self.loseHead=UIObject.get(self,6)
self.loseModel=UIObject.get(self,7)
self.playerModel=UIObject.get(self,8)
self.playerName=UIText.get(self,9)
self.playerNameBg=UIObject.get(self,10)
self.qfInfo=UIText.get(self,11)
self.qfInfoBg=UIObject.get(self,12)
self.roleInfo=UIObject.get(self,13)
self.Root=UIObject.get(self,14)
self.showDiscipleBtn=UIButton.get(self,15)
self.uiRoot=UIObject.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.showDiscipleBtn:setButtonClick(function()self:onShowDiscipleBtn()end)



end


function UIWDCQGJXXWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bgModel2);self.bgModel2=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dropDownRoot);self.dropDownRoot=nil;
_UIObject_release(self.fadeRoot);self.fadeRoot=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.loseHead);self.loseHead=nil;
_UIObject_release(self.loseModel);self.loseModel=nil;
_UIObject_release(self.playerModel);self.playerModel=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.playerNameBg);self.playerNameBg=nil;
_UIObject_release(self.qfInfo);self.qfInfo=nil;
_UIObject_release(self.qfInfoBg);self.qfInfoBg=nil;
_UIObject_release(self.roleInfo);self.roleInfo=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.showDiscipleBtn);self.showDiscipleBtn=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _shiftInterval=10




function UIWDCQGJXXWin:onLoaded(...)
self:bindComponents()


self.isPause=false
end


function UIWDCQGJXXWin:__delete()
self:unbindComponents()

self:clearTimer()
self:clearDT()
end




function UIWDCQGJXXWin:onShow(argtable,afterOnloaded)

self:refreshAll()

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),true,true,true)
self.bgModel:setChildUIModelShowTarget(5568,1,nil,eAnimationID.enter)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel2:getID(),true,true,true)
self.bgModel2:setChildUIModelShowTarget(5576,1,nil,eAnimationID.enter)

WDCQController.setMsgWinOpenFlag(msgWinType.eWDCQGJXX,true,false)
end


function UIWDCQGJXXWin:onHide()

end


function UIWDCQGJXXWin:refreshAll()
self:refreshDropDown()

self:refreshGJInfo()
end

function UIWDCQGJXXWin:refreshGJInfo()

local cfg=self.dropItemInfoList[self.selectGroup]
local championRoleInfo=WDCQModel:getRankRoleInfo(cfg.id,1)
championRoleInfo=championRoleInfo and championRoleInfo[1]

if championRoleInfo then
local isLose=mathHelper.validInt64(championRoleInfo.actorId)and championRoleInfo.name==''
self.playerModel:setActive(not isLose)
self.head:setActive(not isLose)
self.loseHead:setActive(isLose)
self.loseModel:setActive(isLose)






if not isLose then
playerController:setImage(self.widget,self.playerModel:getID(),championRoleInfo.sex,championRoleInfo.iconInfo,playerController:supportDynamic(),0.8)
playerController:setHeadIcon(self.widget,self.head:getID(),{scale=0.7,iconInfo=championRoleInfo.iconInfo})
end

local serverName=loginModel:getServerName(championRoleInfo.serverId)
serverName=FMT.fmt("[{0}]",serverName)
self.qfInfo:setText(serverName)

self.playerName:setText(playerModel:getOtherActorName(championRoleInfo.name))
else
logErr("未获取到冠军信息")
end
end


function UIWDCQGJXXWin:startShiftShowChampion()
local duration=0

local _this=self
local func=function()
if self.isPause then return end

duration=duration+1
if duration>_shiftInterval then
_this:playShiftChampionAni()
end
end

self:clearTimer()

self.timer=self:setTimer(1,0,func)
func()
end

function UIWDCQGJXXWin:playShiftChampionAni()
self:clearDT()

local startFadeCallBack=function()
self.selectGroup=self.selectGroup%self.self.dropItemNum+1

self:refreshSelectItem()

self:refreshGJInfo()

self.fadeDT2=self.fadeRoot:setChildCanvasGroupDOFade(1,0.2,nil)
end
self.fadeDT1=self.fadeRoot:setChildCanvasGroupDOFade(0,0.2,startFadeCallBack)
end

function UIWDCQGJXXWin:setTimerPause()
self.isPause=true
end

function UIWDCQGJXXWin:setTimerConsume()
self.isPause=false
end

function UIWDCQGJXXWin:clearTimer()
if self.timer~=nil then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIWDCQGJXXWin:clearDT()
if self.fadeDT1 then
self.fadeDT1:Complete()
self.fadeDT1:Kill()
self.fadeDT1=nil
end

if self.fadeDT2 then
self.fadeDT2:Complete()
self.fadeDT2:Kill()
self.fadeDT2=nil
end
end


local CmpDropDownWidgetIndex={
scrollView=0,
list=1,
selectItem=2,
open=3,
selectTxt=4,
}


local _dropOptionItemHeight=62
local _dropOptionListTopPadding=45
local _dropOptionListBottonPadding=30
local _dropOptionListSpacing=5
local _dropOptionScrollViewWidth=108


local _aniMoveDuration=0.2


function UIWDCQGJXXWin:refreshDropDown()

self.isOpenOptionList=false

self.dropDownWidget=self.dropDownRoot:getWidgetBase()

self.dropItemInfoList=WDCQController.getChampionGroupCfgList()
self.dropItemNum=#self.dropItemInfoList


self.selectGroup=self.dropItemNum


self:refreshSelectItem()

self:refreshSubItemList()
end

function UIWDCQGJXXWin:refreshSelectItem()



local name=self.dropItemInfoList[self.selectGroup].name
self.dropDownWidget:SetChildText(CmpDropDownWidgetIndex.selectTxt,name)

self.dropDownWidget:SetChildButtonClick(CmpDropDownWidgetIndex.selectItem,function()

self.isOpenOptionList=not self.isOpenOptionList

if self.isOpenOptionList then
self:setTimerPause()
self:playOpenAni()
else
self:setTimerConsume()
self:hideOptionList()
end
end,true)
end

function UIWDCQGJXXWin:refreshSubItemList()

local createFunc=function(index)
self:refreshSubItem(index)
end

self.dropDownWidget:SetChildLayoutGroupCreateItems(CmpDropDownWidgetIndex.list,self.dropItemNum,createFunc)
end

function UIWDCQGJXXWin:refreshSubItems()
for index=1,self.dropItemNum do
self:refreshSubItem(index)
end
end

function UIWDCQGJXXWin:refreshSubItem(index)
local dropItem=self.dropDownWidget:GetChildLayoutGroupGridItem(CmpDropDownWidgetIndex.list,index-1)

local isSelect=index==self.selectGroup

local name=self.dropItemInfoList[index].name

dropItem:SetChildActive(0,isSelect)
dropItem:SetChildText(1,name)

dropItem:SetBaseItemClickEvent(-1,function()
self.selectGroup=index

self.isOpenOptionList=false

self:hideOptionList()

self:refreshSelectItem()

self:onDropClickCallBack()
end)
end

function UIWDCQGJXXWin:playOpenAni()
self:refreshSubItems()

self.dropDownWidget:SetChildActive(CmpDropDownWidgetIndex.scrollView,true)


local totalHeight=self:caculateDropListHeight()

self.openDropDownListDt=self.dropDownWidget:SetChildDOSizeDelta(CmpDropDownWidgetIndex.scrollView,Vector2(_dropOptionScrollViewWidth,totalHeight),_aniMoveDuration)
end

function UIWDCQGJXXWin:hideOptionList()
self.dropDownWidget:SetChildActive(CmpDropDownWidgetIndex.scrollView,false)

if self.openDropDownListDt then
self.openDropDownListDt:Complete()
self.openDropDownListDt:Kill()
end

self.dropDownWidget:SetChildSizeDelta(CmpDropDownWidgetIndex.scrollView,_dropOptionScrollViewWidth,0)
end

function UIWDCQGJXXWin:caculateDropListHeight()
local num=self.dropItemNum

return(num*_dropOptionItemHeight)+((num-1)*_dropOptionListSpacing)+_dropOptionListTopPadding+_dropOptionListBottonPadding
end

function UIWDCQGJXXWin:onDropClickCallBack()

self:startShiftShowChampion()

self:refreshGJInfo()
end

function UIWDCQGJXXWin:onCloseBtn()
self:closeSelf()
end

function UIWDCQGJXXWin:onShowDiscipleBtn()
local cfg=self.dropItemInfoList[self.selectGroup]
WDCQController.showWinActorInfo(cfg.id,WDCQCGameStageEnum.eChampion,1)
end



