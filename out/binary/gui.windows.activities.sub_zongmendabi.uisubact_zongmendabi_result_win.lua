







def_class("UISubAct_zongmendabi_result_win",UIWindowBase)









function UISubAct_zongmendabi_result_win:bindComponents()

self.rewardPanel=UIObject.get(self,0)
self.rankTxt=UIText.get(self,1)
self.rankArrowObj=UIObject.get(self,2)
self.addRankTxt=UIText.get(self,3)
self.rankArrowIcon=UIImage.get(self,4)
self.scoreTxt=UIText.get(self,5)
self.scoreIcon=UIImage.get(self,6)



end


function UISubAct_zongmendabi_result_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rankTxt);self.rankTxt=nil;
_UIObject_release(self.rankArrowObj);self.rankArrowObj=nil;
_UIObject_release(self.addRankTxt);self.addRankTxt=nil;
_UIObject_release(self.rankArrowIcon);self.rankArrowIcon=nil;
_UIObject_release(self.scoreTxt);self.scoreTxt=nil;
_UIObject_release(self.scoreIcon);self.scoreIcon=nil;
end
















local _this=nil


function UISubAct_zongmendabi_result_win:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_zongmendabi_result_win:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_zongmendabi_result_win:onHide()

end




function UISubAct_zongmendabi_result_win:onShow(argtable,afterOnloaded)
local data=argtable.data
local rewards=activitiesHandle_zongmendabi:get_showRewards()or{}
local actID=data.act_id
local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local subid=data.act2_id
local score=data.pk_score
local old_myrank=data.old_my_rank
local old_score=data.old_score

local myrank=data.new_rank_idx
local old_canInRank=activitiesHandle_zongmendabi.canInRank(subid,old_score)
local old_inRank=old_myrank>0 and old_canInRank
local canInRank=activitiesHandle_zongmendabi.canInRank(subid,score)
local inRank=myrank>0 and canInRank
local rank_str
local add=0
if inRank then
rank_str=FMT.fmt('排名:{0}',myrank)
else
rank_str='未上榜'
end
self.rankTxt:setText(rank_str)
local add=0
if old_inRank and inRank then
add=old_myrank-myrank
end
local showAdd=add~=0
self.rankArrowObj:setActive(showAdd)
self.addRankTxt:setActive(showAdd)
if showAdd then
local add_str
local addIcon
if add>0 then
add_str=FMT.fmt('<color=#549327>{0}</color>',add)
addIcon='icon_jiantou_1'
else
add_str=FMT.fmt('<color=#c82c2c>{0}</color>',add)
addIcon='icon_jiantou_2'
end
self.addRankTxt:setText(add_str)
self.rankArrowIcon:setSprite(globalABLookup.global,addIcon)
end

local add_score=score-old_score
local score_str
if add_score>0 then
score_str=FMT.fmt('{0}<color=#549327>(+{1})</color>',score,add_score)
elseif add_score<0 then
score_str=FMT.fmt('{0}<color=#c82c2c>({1})</color>',score,add_score)
else
score_str=tostring(score)
end
self.scoreTxt:setText(score_str)
self.scoreIcon:setImageIcon(moneyModel.getIconNameEx(eMoneyType.mtSectScore),true)
self.scoreIcon:setScale(Vector3(0.5,0.5,1))

local rewardlist={}
if#rewards>0 then
for i,v in ipairs(rewards)do
local itemid=v.itemid
if itemid~=eMoneyType.mtSectScore then
local itemConfig=itemsConfig.getConfig(itemid)
table.insert(rewardlist,{itemid,v.num,itemConfig.color})
end
end
end
local num=#rewardlist
if num>1 then
table.sort(rewardlist,function(a,b)
return a[3]>b[3]
end)
end
self.rewardPanel:setChildLayoutGroupCreateItems(num)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
local reward=rewardlist[i]
local itemid=reward[1]
local itemNum=reward[2]
local itemcount,showCountBG
if itemNum>1 then
itemcount=tostring(itemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end

function UISubAct_zongmendabi_result_win:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end


