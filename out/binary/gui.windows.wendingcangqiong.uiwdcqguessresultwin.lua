







def_class("UIWDCQGuessResultWin",UIWindowBase)









function UIWDCQGuessResultWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.scrollview=UIObject.get(self,2)
self.Content=UIObject.get(self,3)
self.icon=UIImage.get(self,4)
self.Cnt=UIText.get(self,5)
self.rootalpha=UIObject.get(self,6)



end


function UIWDCQGuessResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.Cnt);self.Cnt=nil;
_UIObject_release(self.rootalpha);self.rootalpha=nil;
end



















local CmpJCSlotIndex={
leftInfo=0,
rightInfo=1,
hbIcon=2,
hbNum=3,
winBg=4,
failBg=5,
replay=6,
fightIcon=7,
}

local CmpRoleInfoIndex={
head=0,
qufu=1,
name=2,
secFlag=3,
selfFlag=4,
loseHead=5,
}



function UIWDCQGuessResultWin:onLoaded(...)
self:bindComponents()
self.rootalpha:setScale(Vector3.zero)
self.bgModel:setChildUIModelShowTarget(5581,1,nil,eAnimationID.enter,false,false,0,function()
self.rootalpha:setChildCanvasGroupAlpha(1)
end)



self.rootalpha:setChildDOScale(1,0.5,function()
self.bgModel:setChildModelAnimationState(eAnimationID.stand)
end)




end


function UIWDCQGuessResultWin:__delete()
self:unbindComponents()
end




function UIWDCQGuessResultWin:onShow(argtable,afterOnloaded)
self.stageId=argtable and argtable.stage
self.title:setText(WDCQCGameStageNmae[self.stageId])
self.jcDataList,self.totalNum=WDCQController.getStageJCInfoList(self.stageId)
self.moneyType=eMoneyType.mtYunQian
local iconName=iconHelper.getIconName(self.moneyType)
self.icon:setChildIcon(iconName)
self.Cnt:setText(FMT.fmt("<color=#{0}>{1}{2}</color>",self.totalNum>=0 and"549327"or"c82c2c",self.totalNum>=0 and"+"or"",self.totalNum))
self:refreshContent()
end


function UIWDCQGuessResultWin:onHide()

end

function UIWDCQGuessResultWin:refreshContent()
local tempList={}
local winListLen=#self.jcDataList.sucessList
local failListLen=#self.jcDataList.failList
if winListLen>0 then
for i,v in ipairs(self.jcDataList.sucessList)do
table.insert(tempList,v)
end
end
if failListLen>0 then
for i,v in ipairs(self.jcDataList.failList)do
table.insert(tempList,v)
end
end

local fillItemFunc=function(index,item,data)
local matchData=data[1]
local result=data[2]
local num=data[3]
local stageIndex=data[4]
local group=data[5]
local idx=data[6]

item:SetChildActive(CmpJCSlotIndex.winBg,result)
item:SetChildActive(CmpJCSlotIndex.failBg,not result)

local iconName=iconHelper.getIconName(self.moneyType)
item:SetChildIcon(CmpJCSlotIndex.hbIcon,iconName,false)

local numStr=num
local color="#c82c2c"
if num>0 then
numStr=FMT.fmt("+{0}",num)
color="#549327"
end
numStr=toColorStringX(color,numStr)
item:SetChildText(CmpJCSlotIndex.hbNum,numStr)

local hasFight=WDCQController.checkRoundHasFight(group,stageIndex,idx)
if hasFight then
item:SetChildActive(CmpJCSlotIndex.replay,true)
item:SetChildActive(CmpJCSlotIndex.fightIcon,false)
item:SetChildButtonClick(CmpJCSlotIndex.replay,function()
self:onClickReplay(group,stageIndex,idx)
end)
else
item:SetChildActive(CmpJCSlotIndex.replay,false)
item:SetChildActive(CmpJCSlotIndex.fightIcon,true)
end


local isLose_1=mathHelper.validInt64(matchData.actor_id_1)and matchData.name_1==''
local leftInfoWidget=item:GetChildWidgetBase(CmpJCSlotIndex.leftInfo)
local role1SucessFlag=mathHelper.compareInt64(matchData.actor_id_1,matchData.win_actor_id)
leftInfoWidget:SetChildActive(CmpRoleInfoIndex.secFlag,role1SucessFlag)
local self1Flag=mathHelper.compareInt64(matchData.actor_id_1,playerModel:getActorID())
leftInfoWidget:SetChildActive(CmpRoleInfoIndex.selfFlag,self1Flag)
if not isLose_1 then
playerController:setHeadIcon(leftInfoWidget,CmpRoleInfoIndex.head,{scale=0.55,iconInfo=matchData.iconInfo1,gray=not role1SucessFlag})
end
color=role1SucessFlag and"#ca631d"or"#65615f"
if self1Flag then
color="#549327"
end
local serverName_1=loginModel:getServerName(matchData.server_id_1)
serverName_1=toColorStringX(color,serverName_1)
local name_1=toColorStringX(color,matchData.name_1)
leftInfoWidget:SetChildText(CmpRoleInfoIndex.qufu,serverName_1)
leftInfoWidget:SetChildText(CmpRoleInfoIndex.name,playerModel:getOtherActorName(name_1))
leftInfoWidget:SetChildActive(CmpRoleInfoIndex.head,not isLose_1)
leftInfoWidget:SetChildActive(CmpRoleInfoIndex.loseHead,isLose_1)


local isLose_2=mathHelper.validInt64(matchData.actor_id_2)and matchData.name_2==''
local rightInfoWidget=item:GetChildWidgetBase(CmpJCSlotIndex.rightInfo)
local role2SucessFlag=mathHelper.compareInt64(matchData.actor_id_2,matchData.win_actor_id)
rightInfoWidget:SetChildActive(CmpRoleInfoIndex.secFlag,role2SucessFlag)
local self2Flag=mathHelper.compareInt64(matchData.actor_id_2,playerModel:getActorID())
rightInfoWidget:SetChildActive(CmpRoleInfoIndex.selfFlag,self2Flag)
playerController:setHeadIcon(rightInfoWidget,CmpRoleInfoIndex.head,{scale=0.55,iconInfo=matchData.iconInfo2,gray=not role2SucessFlag})
color=role2SucessFlag and"#ca631d"or"#65615f"
if self2Flag then
color="#549327"
end
local serverName_2=loginModel:getServerName(matchData.server_id_2)
serverName_2=toColorStringX(color,serverName_2)
local name_2=toColorStringX(color,matchData.name_2)
rightInfoWidget:SetChildText(CmpRoleInfoIndex.qufu,serverName_2)
rightInfoWidget:SetChildText(CmpRoleInfoIndex.name,name_2)
rightInfoWidget:SetChildActive(CmpRoleInfoIndex.head,not isLose_2)
rightInfoWidget:SetChildActive(CmpRoleInfoIndex.loseHead,isLose_2)
end

self.Content:setChildLayoutGroupCreateItems(#tempList,function(index)
local item=self.Content:getChildLayoutGroupGridItem(index-1)
local data=tempList[index]
fillItemFunc(index,item,data)
end)

end

function UIWDCQGuessResultWin:onClickReplay(group,stage,idx)



local fightCloseCallBack=function()
UIManager:showWindow("UIWDCQGuessResultWin",{stage=stage})
end

local args={}
args.groupId=group
args.stageId=stage
args.idx=idx
args.tabIndex=2
args.closeFunc=fightCloseCallBack
UIManager:showWindow("UIWDCQGuessWin",args)
self:closeSelf()
end




