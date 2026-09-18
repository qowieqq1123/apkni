







def_class("UIWDCQSecondJCWin",UIWindowBase)









function UIWDCQSecondJCWin:bindComponents()

self.emptyRoot=UIObject.get(self,0)
self.failerList=UIObject.get(self,1)
self.failerPart=UIObject.get(self,2)
self.resultInfo=UILinkImageText.get(self,3)
self.Root=UIObject.get(self,4)
self.scrollview=UIObject.get(self,5)
self.sucessList=UIObject.get(self,6)
self.sucessPart=UIObject.get(self,7)



end


function UIWDCQSecondJCWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.emptyRoot);self.emptyRoot=nil;
_UIObject_release(self.failerList);self.failerList=nil;
_UIObject_release(self.failerPart);self.failerPart=nil;
_UIObject_release(self.resultInfo);self.resultInfo=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.sucessList);self.sucessList=nil;
_UIObject_release(self.sucessPart);self.sucessPart=nil;
end
















local CmpJCSlotIndex={
mcIcon=0,
roleInfo1=1,
roleInfo2=2,
hbIcon=3,
hbNum=4,
loseHead=5,
}

local CmpRoleInfoIndex={
sucessFlag=0,
head=1,
qufu=2,
name=3,
loseHead=4,
}




function UIWDCQSecondJCWin:onLoaded(...)
self:bindComponents()
end


function UIWDCQSecondJCWin:__delete()
self:unbindComponents()
end




function UIWDCQSecondJCWin:onShow(argtable,afterOnloaded)

self:refreshAll()
end


function UIWDCQSecondJCWin:onHide()

end

function UIWDCQSecondJCWin:refreshAll()

self.jcDataList,self.totalNum=WDCQController.getJCInfoList()





local transMoneyId=eMoneyType.mtYunQian



local winListLen=#self.jcDataList.sucessList
local failListLen=#self.jcDataList.failList

local isShowWinList=winListLen>0
local isShowFailList=failListLen>0

local fillItemFunc=function(index,item,data)
local matchData=data[1]
local result=data[2]
local num=data[3]
local stageIndex=data[4]
local groupIndex=data[5]

local stageIcon=WDCQController.getStageIconName(groupIndex,stageIndex)
item:SetChildCSImageSprite(CmpJCSlotIndex.mcIcon,globalABLookup.wendingcangqiong,stageIcon)


local role1InfoWidget=item:GetChildWidgetBase(CmpJCSlotIndex.roleInfo1)
local role1SucessFlag=mathHelper.compareInt64(matchData.actor_id_1,matchData.win_actor_id)
local isLose1=mathHelper.validInt64(matchData.actor_id_1)and matchData.name_1==''
role1InfoWidget:SetChildActive(CmpRoleInfoIndex.sucessFlag,role1SucessFlag)
playerController:setHeadIcon(role1InfoWidget,CmpRoleInfoIndex.head,{scale=0.55,iconInfo=matchData.iconInfo1})
local serverName1=loginModel:getServerName(matchData.server_id_1)
serverName1=FMT.fmt("[{0}]",serverName1)
role1InfoWidget:SetChildText(CmpRoleInfoIndex.qufu,serverName1)
role1InfoWidget:SetChildText(CmpRoleInfoIndex.name,playerModel:getOtherActorName(matchData.name_1))
role1InfoWidget:SetChildActive(CmpRoleInfoIndex.head,not isLose1)
role1InfoWidget:SetChildActive(CmpRoleInfoIndex.loseHead,isLose1)


local role2InfoWidget=item:GetChildWidgetBase(CmpJCSlotIndex.roleInfo2)
local role2SucessFlag=mathHelper.compareInt64(matchData.actor_id_2,matchData.win_actor_id)
local isLose2=mathHelper.validInt64(matchData.actor_id_2)and matchData.name_2==''
role2InfoWidget:SetChildActive(CmpRoleInfoIndex.sucessFlag,role2SucessFlag)
playerController:setHeadIcon(role2InfoWidget,CmpRoleInfoIndex.head,{scale=0.55,iconInfo=matchData.iconInfo2})
local serverName2=loginModel:getServerName(matchData.server_id_2)
serverName2=FMT.fmt("[{0}]",serverName2)
role2InfoWidget:SetChildText(CmpRoleInfoIndex.qufu,serverName2)
role2InfoWidget:SetChildText(CmpRoleInfoIndex.name,playerModel:getOtherActorName(matchData.name_2))
role2InfoWidget:SetChildActive(CmpRoleInfoIndex.head,not isLose2)
role2InfoWidget:SetChildActive(CmpRoleInfoIndex.loseHead,isLose2)



local iconName=iconHelper.getIconName(transMoneyId)
item:SetChildIcon(CmpJCSlotIndex.hbIcon,iconName,false)

local numStr=num
local color=num>0 and"#549327"or"#c82c2c"
if num>0 then
numStr=FMT.fmt("+{0}",num)
end
numStr=toColorStringX(color,numStr)
item:SetChildText(CmpJCSlotIndex.hbNum,numStr)
end

local isShow=isShowFailList or isShowWinList
self.scrollview:setActive(isShow)
self.resultInfo:setActive(isShow)
self.emptyRoot:setActive(not isShow)



self.sucessPart:setActive(isShowWinList)
if isShowWinList then
self.sucessList:setChildLayoutGroupCreateItems(winListLen,function(index)
local item=self.sucessList:getChildLayoutGroupGridItem(index-1)
local data=self.jcDataList.sucessList[index]

fillItemFunc(index,item,data)
end)
end



self.failerPart:setActive(isShowFailList)
if isShowFailList then
self.failerList:setChildLayoutGroupCreateItems(failListLen,function(index)
local item=self.failerList:getChildLayoutGroupGridItem(index-1)
local data=self.jcDataList.failList[index]

fillItemFunc(index,item,data)
end)
end


local iconname=iconHelper.getIconName(transMoneyId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)
local numStr=self.totalNum>0 and FMT.fmt("+{0}",self.totalNum)or self.totalNum
local color=self.totalNum>0 and"#549327"or"#c82c2c"
local str=FMT.fmt('合计 {0} {1}',iconStr,toColorStringX(color,numStr))
self.resultInfo:setText(str)
end



function UIWDCQSecondJCWin:getTestData()
local tempList={}
local totalNum=0

tempList.sucessList={}
tempList.failList={}

local randomLen=Mathf.Random(0,5)

for index=1,randomLen do
local randomResult=Mathf.Random(0,1)==1
local matchData=WDCQController.getTestMatcgData()
local numFlag=randomResult and 1 or-1
local randomStageIndex=Mathf.Random(1,6)
local randomGroupIndex=Mathf.Random(1,3)

local temp={matchData,randomResult,numFlag*matchData.self_money_cnt,randomStageIndex,randomGroupIndex}
if randomResult then
tempList.sucessList[#tempList.sucessList+1]=temp
else
tempList.failList[#tempList.failList+1]=temp
end

totalNum=totalNum+(numFlag*matchData.self_money_cnt)
end

return tempList,totalNum
end



