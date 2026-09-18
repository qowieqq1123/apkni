







def_class("UISubAct_ZhongLiXieXinRewardPreviewWin",UIWindowBase)









function UISubAct_ZhongLiXieXinRewardPreviewWin:bindComponents()

self.myRank=UIText.get(self,0)
self.rankContect=UIObject.get(self,1)
self.scrollView=UIObject.get(self,2)
self.upRank=UIText.get(self,3)



end


function UISubAct_ZhongLiXieXinRewardPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.myRank);self.myRank=nil;
_UIObject_release(self.rankContect);self.rankContect=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.upRank);self.upRank=nil;
end
















local _this




function UISubAct_ZhongLiXieXinRewardPreviewWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_ZhongLiXieXinRewardPreviewWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_ZhongLiXieXinRewardPreviewWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self:refreshPanel()
end


function UISubAct_ZhongLiXieXinRewardPreviewWin:onHide()

end

function UISubAct_ZhongLiXieXinRewardPreviewWin:refreshPanel()
local nextRank
local myRankData=self.sub_actInfo:getMyRankData()
local myScore=self.sub_actInfo:getMyScore()or 0

local rank_config=self.sub_actcfg.rank_config
local rank_limit_len=self.sub_actcfg.reward_rank_limit_len
local min_rank_score=self.sub_actcfg.min_rank_score
local score_name=self.sub_actcfg.score_name

local bindWidget=function(index)
local widget=_this.rankContect:getChildLayoutGroupGridItem(index-1)

local startIndex=rank_config[index][1]
local endIndex=rank_config[index][2]
local rewards=rank_config[index][3]
local isMe=false
if endIndex==-1 then
endIndex=rank_limit_len
end
if myRankData~=nil and myRankData.rank>=startIndex and myRankData.rank<=endIndex then
isMe=true
nextRank=startIndex-1
end

if startIndex==endIndex then
widget:SetChildText(1,FMT.fmt("第{0}名",startIndex))
else
widget:SetChildText(1,FMT.fmt("第{0}~{1}名",startIndex,endIndex))
end
widget:SetChildActive(3,isMe)


local bindItem=function(idx)
local item=widget:GetChildLayoutGroupGridItem(2,idx-1)
local data=rewards[idx]
local count=data[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=data[2]
end
local prop=itemsComponentHelper.getCommonFillDataSmall({itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false})
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end
widget:SetChildLayoutGroupCreateItems(2,#rewards,bindItem)
end
self.rankContect:setChildLayoutGroupCreateItems(#rank_config,bindWidget)

if nextRank==nil then
nextRank=rank_limit_len
end
if myRankData~=nil then
self.myRank:setText(FMT.fmt("当前排名：<color=#549327>第{0}名</color>",myRankData.rank))
else
self.myRank:setText("当前排名：<color=#7d3b17>未上榜</color>")
end
local str=""
if nextRank>0 then
local score=self.sub_actInfo:getRankScore(nextRank)
if score~=nil then
str=FMT.fmt("再获得<color=#7d3b17>{0}{1}</color>可提升到下一奖励档次",score-myScore+1,score_name)
else
if min_rank_score>0 then
str=FMT.fmt("再获得<color=#7d3b17>{0}{1}</color>可提升到下一奖励档次",min_rank_score-myScore,score_name)
else
str=FMT.fmt("获得<color=#7d3b17>任意{0}</color>可提升到下一奖励档次",score_name)
end
end
else
str="没有下一奖励档次"
end
self.upRank:setText(str)
end




function UISubAct_ZhongLiXieXinRewardPreviewWin:onCloseClick()
self:closeSelf()
end
