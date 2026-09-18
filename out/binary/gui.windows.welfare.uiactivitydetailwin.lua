







def_class("UIActivityDetailWin",UIWindowBase)









function UIActivityDetailWin:bindComponents()

self.clicker=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.rect=UIObject.get(self,2)
self.name=UIText.get(self,3)
self.activeStateing=UIObject.get(self,4)
self.Desc=UIText.get(self,5)
self.ItemScrollView=UIObject.get(self,6)
self.Content=UIObject.get(self,7)
self.itemcreater=UIObject.get(self,8)
self.jumpBtn=UIButton.get(self,9)
self.activeStateno=UIText.get(self,10)
self.gariImage=UIObject.get(self,11)

self.clicker:setButtonClick(function()self:onClicker()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UIActivityDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clicker);self.clicker=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rect);self.rect=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.activeStateing);self.activeStateing=nil;
_UIObject_release(self.Desc);self.Desc=nil;
_UIObject_release(self.ItemScrollView);self.ItemScrollView=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.itemcreater);self.itemcreater=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.activeStateno);self.activeStateno=nil;
_UIObject_release(self.gariImage);self.gariImage=nil;
end


















local _csguiManager=CS.CSGUIManager.Instance


function UIActivityDetailWin:onLoaded(...)
self:bindComponents()
end


function UIActivityDetailWin:__delete()
self:unbindComponents()
end




function UIActivityDetailWin:onShow(argtable,afterOnloaded)
self.data=argtable.data
self.callbackFun=argtable.callbackFun
self.isDoing=self:checkActivtyDoing(argtable.data)
self:refresh()





self:setPos(argtable)
end

function UIActivityDetailWin:refresh()
local data=self.data
local timeInfo=data.timeInfo
local startTimeInfo=timeInfo.startTimeInfo
local endTimeInfo=timeInfo.endTimeInfo
local isSamemmonth=startTimeInfo.month==endTimeInfo.month
local timeStr
if isSamemmonth then
timeStr=FMT.fmt("<color=#7d3b17>活动时间：{0}月{1}日~{2}日</color>\n",startTimeInfo.month,startTimeInfo.day,endTimeInfo.day)
else
timeStr=FMT.fmt("<color=#7d3b17>活动时间：{0}月{1}日~{2}月{3}日</color>\n",startTimeInfo.month,startTimeInfo.day,endTimeInfo.month,endTimeInfo.day)
end
local descStr=FMT.fmt("{0}{1}",timeStr,data.desc)
self.name:setText(self.isDoing and data.name or FMT.fmt("<color=#3f4d58>{0}</color>",data.name))
self.Desc:setText(descStr)
if self.isDoing then
self.activeStateing:setActive(true)
self.jumpBtn:setActive(true)
self.activeStateno:setActive(false)
self.gariImage:setActive(false)
else
self.activeStateing:setActive(false)
self.jumpBtn:setActive(false)
self.activeStateno:setActive(true)
self.gariImage:setActive(true)
end
local rewardsCfg=data.rewards
local rewards=rewardsCfg[2]
local rewardType=rewardsCfg[1]
self.Content:setChildLayoutGroupCreateItems(#rewards,function(Index)
local data={}
local reward=rewards[Index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local itemwidget=self.Content:getChildLayoutGroupGridItem(Index-1)
if rewardType==1 then
itemwidget:SetChildActive(0,true)
itemwidget:SetChildActive(1,false)
widgetHelper.setNormalRewardItem(itemwidget,0,data)
itemwidget:SetChildActive(5,reward[3]==1)
itemwidget:SetChildActive(6,reward[3]==2)
elseif rewardType==2 then
itemwidget:SetChildActive(0,false)
itemwidget:SetChildActive(1,true)
local diId=data[1]






itemwidget:SetChildButtonClick(4,function()
self:onItemClick(diId)
end,true)

local itemid=diId
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemid)
local info=dzData.imageInfo

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)


comHelper.setChildModelRawImageEx(3,itemwidget,modelParams,eHeadCenterType.eHead,1,false)
local bgName=FMT.fmt('image_gwtouxiangpjk_{0}',info.color)
itemwidget:SetChildCSImageSprite(2,globalABLookup.global,bgName)
end



end)
end


function UIActivityDetailWin:onHide()
UIManager.info(1)

end

function UIActivityDetailWin:setPos(argtable)
local screenPoint=argtable.screenPoint
local screenWidth=argtable.screenWidth
local screenhight=argtable.screenhight
local viewOffest=argtable.viewOffest
local posOffest=argtable.posOffest

local tran=self.rect:getCommonComponent('RectTransform')
local lpos=_csguiManager:ScreenPointToRectTransform(tran,screenPoint,true)


local screenhalfhight=screenhight/2
local screenHalfWidth=screenWidth/2
local viewTop=screenhalfhight-viewOffest.top
local viewBottom=-(screenhalfhight-viewOffest.bottom)
local viewLeft=-(screenHalfWidth-viewOffest.left)
local viewRight=screenHalfWidth-viewOffest.right

local offesttop=posOffest.top
local offestbottom=posOffest.bottom
local offestleft=posOffest.left
local offestright=posOffest.right
local selfH=self.root:getChildRectHeight()
local selfW=self.root:getChildRectWidth()


local targetPosX=0
local targetPosY=0
local pivotY=0.5
local pivotX=0.5

local bottomY=lpos.y-offestbottom-selfH
local topY=lpos.y+offesttop+selfH
local rightX=lpos.x+offestright+selfW
local leftX=lpos.x-offestleft-selfW

if bottomY>=viewBottom then
targetPosY=lpos.y-offestbottom
pivotY=1
else
targetPosY=lpos.y+offesttop
pivotY=0
end

if rightX<=viewRight then
targetPosX=lpos.x+offestleft
pivotX=0
else
targetPosX=lpos.x+offestright-(rightX-viewRight)
pivotX=0
end
self.winlua:SetChildPivot(self.root:getID(),Vector2.New(pivotX,pivotY))
self.winlua:SetChildAnchoredPosition(self.root:getID(),Vector2.New(targetPosX,targetPosY))
end





function UIActivityDetailWin:onClicker(newDay)
if not newDay and self.callbackFun then
self.callbackFun()
end
self:closeSelf()

end

function UIActivityDetailWin:onJumpBtn()








welfareController:ActivityCalendarJump(self.data)
local func=function()
UIFullWelfareController:showWindowActivityCalendar()
end
fullScreenUI.setNextActiveUICallback(func)
end

function UIActivityDetailWin:onItemClick(itemId)
UIRecruitControl:showItemDiscipleInfoByItemId2(itemId)
end

function UIActivityDetailWin:checkActivtyDoing(data)






return welfareController:checkActivtyDoing(data)
end


