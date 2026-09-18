







def_class("UIXYRewardSubWin_Reward",UIWindowBase)









function UIXYRewardSubWin_Reward:bindComponents()

self.ScrollView=UIObject.get(self,0)
self.rewardTeam_1=UIObject.get(self,1)
self.rewardTeam_2=UIObject.get(self,2)
self.rewardTeam_3=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.Content=UIObject.get(self,5)
self.LoopScrollView=UILoopListView.new(self,6)
self.LoopContent=UIObject.get(self,7)
self.dropItem=UIObject.get(self,8)

self.LoopScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)self.rewardTeam={
self.rewardTeam_1,
self.rewardTeam_2,
self.rewardTeam_3,
}



end


function UIXYRewardSubWin_Reward:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.rewardTeam_1);self.rewardTeam_1=nil;
_UIObject_release(self.rewardTeam_2);self.rewardTeam_2=nil;
_UIObject_release(self.rewardTeam_3);self.rewardTeam_3=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.Content);self.Content=nil;
self.LoopScrollView:deleteSelf();self.LoopScrollView=nil;
_UIObject_release(self.LoopContent);self.LoopContent=nil;
_UIObject_release(self.dropItem);self.dropItem=nil;
self.rewardTeam=nil;
end
















local cmpIndex={
teamIndex=0,
headSlotList={1,2,3,4,5},
rewardItemlayout=6,
tips=7,
jiyuan=8,
}

local ItemType={
eTeamInfoItem=1,
eRewardItem=2,
eNoRewardtipItem=3,
}

local ItemName={
[ItemType.eTeamInfoItem]="teamInfoItem",
[ItemType.eRewardItem]="rewardItem",
[ItemType.eNoRewardtipItem]="noRewardtipItem",
}

local TeamInfoItemCmpIndex={
teamIndex=0,
headSlotList={1,2,3,4,5},
jiyuan=6,
}




function UIXYRewardSubWin_Reward:onLoaded(...)
self:bindComponents()



self.root:setChildCanvasGroupDOFade(1,0.5)
end


function UIXYRewardSubWin_Reward:__delete()
self:unbindComponents()
end




function UIXYRewardSubWin_Reward:onShow(argtable,afterOnloaded)
local xyId=argtable.xyId
if self.xyId==xyId then
return
end
self.xyId=xyId
self.level=JiuYuZhengFengModel:getData_rank_level()or 0
self.selectLevel=self.level



































































local datalist={}
local prefabnameList={}
for teamIndex=1,3 do
local dzList=XingYuController.getXingYuTeamDzList_TeamIndex(xyId,teamIndex)
if dzList then
local teamInfoItemTemp={}
teamInfoItemTemp.itemType=ItemType.eTeamInfoItem

local addValue=XingYuController.getXingYuTeamAdd_TeamIndex(xyId,teamIndex)
teamInfoItemTemp.valueStr=addValue==0 and"探索奖励无加成"or FMT.fmt("探索奖励+{0}%",addValue*100)


teamInfoItemTemp.dzList=dzList
teamInfoItemTemp.teamIndex=teamIndex
table.insert(prefabnameList,ItemName[ItemType.eTeamInfoItem])
table.insert(datalist,teamInfoItemTemp)
local rewardList=XingYuController.getXingYuTeamRewardList_TeamIndex(xyId,teamIndex)
if rewardList and#rewardList>0 then
local col=11
local row=math.ceil(#rewardList/col)
for _r=1,row do
local rewardItemTemp={}
rewardItemTemp.itemType=ItemType.eRewardItem
table.insert(prefabnameList,ItemName[ItemType.eRewardItem])
local _rewardList={}
for _c=1,col do
local index=(_r-1)*col+_c
local rewardData=rewardList[index]
if rewardData then
table.insert(_rewardList,rewardData)
end
end
rewardItemTemp.rewardList=_rewardList
table.insert(datalist,rewardItemTemp)
end
else
local noRewardtipItemTemp={}
noRewardtipItemTemp.itemType=ItemType.eNoRewardtipItem
table.insert(prefabnameList,ItemName[ItemType.eNoRewardtipItem])
table.insert(datalist,noRewardtipItemTemp)
end

end
end

if#datalist>0 then
self.LoopScrollView:initDataEx(prefabnameList,datalist)
else
self.LoopScrollView:initData(nil,nil,0)
end

end


function UIXYRewardSubWin_Reward:onHide()

end

function UIXYRewardSubWin_Reward:onFreshAction(index,widget,data)
local itemType=data.itemType
if itemType==ItemType.eTeamInfoItem then

local valueStr=data.valueStr
local dzList=data.dzList
local teamIndex=data.teamIndex
widget:SetChildText(TeamInfoItemCmpIndex.teamIndex,FMT.fmt("第{0}队",teamIndex))

widget:SetChildText(TeamInfoItemCmpIndex.jiyuan,valueStr)
for i,cmp in ipairs(TeamInfoItemCmpIndex.headSlotList)do
local guid=dzList[i]
if guid then
widget:SetChildActive(cmp,true)
local headshot=widget:GetChildWidgetBase(cmp)
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local dzId=netdata.id
local isSpDz=UIDiscipleModel:isSPDisciple(dzId)
local switchidx
if isSpDz then
local netDzId=XingYuModel:getXingYuData_teamListDzId(self.xyId,guid)
if netDzId and netDzId~=dzId then
switchidx=1
end
end

local image=UIDiscipleModel.calculationDiscipleImageBase(netdata,switchidx)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headshot,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
headshot:SetChildCSImageSprite(2,globalABLookup.global,jobicon)

local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)

comHelper.setChildModelHeadIconBGByColor(headshot,0,color)

UIDiscipleModel:setDiscipleXianMoHeadImage(headshot,3,netdata)
else
widget:SetChildActive(cmp,false)
end
end
elseif itemType==ItemType.eRewardItem then
local rewardList=data.rewardList
widget:SetChildLayoutGroupCreateItems(0,#rewardList,function(index)
local item=widget:GetChildLayoutGroupGridItem(0,index-1)
local rewardData=rewardList[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""


local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
elseif itemType==ItemType.eNoRewardtipItem then

end
end


function UIXYRewardSubWin_Reward:onStartAction()
end



