







def_class("UISchoolRewardWin",UIWindowBase)









function UISchoolRewardWin:bindComponents()

self.rewardListPanel=UIObject.get(self,0)
self.tipsText=UIText.get(self,1)
self.mutiaoScroller=UIObject.get(self,2)



end


function UISchoolRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardListPanel);self.rewardListPanel=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.mutiaoScroller);self.mutiaoScroller=nil;
end


















local itemIndex=
{
name=0,
requireText=1,
progressbar=2,
canGotText=3,
reddot=4,
rewardItem1=5,
rewardItem2=6,
rewardItem3=7,
progress=8,
mask=9,
}



function UISchoolRewardWin:onLoaded(...)
self:bindComponents()
local _OnClickRewardItemCallback=function(...)
self:OnClickRewardItemCallback(...)
end
self.rewardListPanel:setChildScrollViewInit(-1,true,_OnClickRewardItemCallback,nil)
end


function UISchoolRewardWin:__delete()
self:unbindComponents()
end




function UISchoolRewardWin:onShow(argtable,afterOnloaded)
self:initRewardListPanel()
end

function UISchoolRewardWin:onShowArgRecv(...)
self:initRewardListPanel()
end


function UISchoolRewardWin:onHide()

end



function UISchoolRewardWin:initRewardListPanel()
self.allReward=UISchoolModel:getSortRewardList()
local num=math.ceil(#self.allReward/2)
num=num<=3 and 3 or num
self.mutiaoScroller:setChildScrollViewCreateGrids(num,1)

self.rewardListPanel:setChildScrollViewCreateGrids(#self.allReward,2)

local grids=self.rewardListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local rewardList=self.allReward[i]
local lastConfig,config
local requireStr=''
local colorStr=''
local isCan=false

if rewardList.rewardType==UISchoolModel.achieveType.course then
lastConfig,config=UISchoolModel:getAchieveRewardConfig(rewardList.rewardType,rewardList.courseid)
if config then
local proData=UISchoolModel:get_classData_byType(config.courseid)
local curStudyNum=0
if proData then
curStudyNum=proData.teachNum
end
local needTeachNum=config.num
colorStr=curStudyNum<needTeachNum and'#c82c2cff'or'#181412ff'
if curStudyNum>=needTeachNum then
isCan=true
else
requireStr=FMT.fmt('累计开<color={0}>{1}/{2}</color>堂{3}课',colorStr,curStudyNum,config.num,rewardList.cfg.name)
end

item:SetChildIconFillAmount(itemIndex.progress,curStudyNum/needTeachNum)
else
requireStr=FMT.fmt('已完成{0}次教学',lastConfig.num)
item:SetChildIconFillAmount(itemIndex.progress,1)
end
else
lastConfig,config=UISchoolModel:getAchieveRewardConfig(rewardList.rewardType,rewardList.xyStatus)
if config then
local state=config.xyStatus
local needStateNum=config.statusNum
local totalNum=UISchoolModel:getStudyStatusNum(state)
local stateCfg=rewardList.cfg
colorStr=totalNum<needStateNum and'#c82c2cff'or'#181412ff'
if totalNum>=needStateNum then
isCan=true
requireStr='<color=#2DCD19FF>达成目标，点击领取奖励</color>'
else
requireStr=FMT.fmt('累计出现<color={0}>{1}/{2}</color>次{3}',colorStr,totalNum,needStateNum,stateCfg.status)
end

item:SetChildIconFillAmount(itemIndex.progress,totalNum/needStateNum)
else
local stateCfg=rewardList.cfg
requireStr=FMT.fmt('已出现{0}{1}次',stateCfg.status,lastConfig.statusNum)
item:SetChildIconFillAmount(itemIndex.progress,1)
end
end

if isCan then
requireStr='<color=#2DCD19FF>达成目标，点击领取奖励</color>'
end

item:SetChildText(itemIndex.name,config~=nil and config.name or lastConfig.name)

item:SetChildText(itemIndex.requireText,requireStr)


local isRewardAll=config==nil
item:SetChildActive(itemIndex.requireText,isRewardAll or not isCan)
item:SetChildActive(itemIndex.progressbar,isRewardAll or not isCan)
item:SetChildActive(itemIndex.canGotText,not isRewardAll and isCan)
item:SetChildActive(itemIndex.reddot,not isRewardAll and isCan)
item:SetChildActive(itemIndex.mask,not isRewardAll and isCan)


local rewardItems=config and config.items or lastConfig.items
for j=0,itemIndex.rewardItem3-itemIndex.rewardItem1 do
item:SetChildActive(itemIndex.rewardItem1+j,j<#rewardItems)
if j<#rewardItems then
local itemData=rewardItems[j+1]
local itemId=itemData[1]
local itemCount=itemData[2]
local countStr=itemCount>1 and mathHelper.formatBIGNumbereEx(itemCount)or''

local conf={itemid=itemId,itemcount=countStr,showCountBG=countStr~=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(itemIndex.rewardItem1+j,prop)

local _onClickBaseItem=function(...)
self:onClickBaseItem(...)
end
item:SetBaseItemChildID(itemIndex.rewardItem1+j,itemId)
item:SetBaseItemClickEvent(itemIndex.rewardItem1+j,_onClickBaseItem)
end
end
end
end

function UISchoolRewardWin:OnClickRewardItemCallback(clickCount,index)

local curConfig=self.allReward[index+1]
local lastConfig,config
local isCan=false

if curConfig.rewardType==UISchoolModel.achieveType.course then
lastConfig,config=UISchoolModel:getAchieveRewardConfig(curConfig.rewardType,curConfig.courseid)
if config then
local needTeachNum=config.num
local proData=UISchoolModel:get_classData_byType(config.courseid)
local curStudyNum=0
if proData then
curStudyNum=proData.teachNum
end
if curStudyNum>=needTeachNum then
isCan=true
end
end
else
lastConfig,config=UISchoolModel:getAchieveRewardConfig(curConfig.rewardType,curConfig.xyStatus)
if config then
local state=config.xyStatus
local needStateNum=config.statusNum
local totalNum=UISchoolModel:getStudyStatusNum(state)
if totalNum>=needStateNum then
isCan=true
end
end
end

if config==nil then
UIManager.info('已领取完')
return
end

if isCan then
UISchoolModel:set_sendReward_id(config.id)
UISchoolController:req_achieve_reward(config.id)
else
UIManager.info('未达到要求')
end
end

function UISchoolRewardWin:onClickBaseItem(itemId,index,guid,attach)

if itemId==-1 or itemId==0 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end
