







def_class("UISubAct_zongmendabi_info_win",UIWindowBase)









function UISubAct_zongmendabi_info_win:bindComponents()

self.root=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.ruleBtn=UIButton.get(self,2)
self.rankGrid=UIObject.get(self,3)
self.rewardPoolBtn=UIButton.get(self,4)
self.rewardEffect=UIObject.get(self,5)
self.battleBtn=UIButton.get(self,6)
self.rankTxt=UIText.get(self,7)
self.rewardTipsTxt=UIText.get(self,8)
self.rewardSign=UIButton.get(self,9)
self.scoreRewardGrid=UIObject.get(self,10)
self.rewardNameTxt=UIText.get(self,11)
self.scoreTxt=UIText.get(self,12)
self.scoreTipsTxt=UIText.get(self,13)
self.rankBtn=UIButton.get(self,14)
self.scoreIcon=UIImage.get(self,15)
self.scorelvIcon=UIImage.get(self,16)
self.racePlaceTxt=UIText.get(self,17)
self.defBtn=UIButton.get(self,18)
self.raceTimeTxt=UIText.get(self,19)
self.rewardPoolTxt=UIText.get(self,20)
self.scoreProgress=UIObject.get(self,21)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.rewardPoolBtn:setButtonClick(function()self:onRewardPoolBtn()end)

self.battleBtn:setButtonClick(function()self:onBattleBtn()end)

self.rewardSign:setButtonClick(function()self:onRewardSign()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.defBtn:setButtonClick(function()self:onDefBtn()end)



end


function UISubAct_zongmendabi_info_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.rankGrid);self.rankGrid=nil;
_UIObject_release(self.rewardPoolBtn);self.rewardPoolBtn=nil;
_UIObject_release(self.rewardEffect);self.rewardEffect=nil;
_UIObject_release(self.battleBtn);self.battleBtn=nil;
_UIObject_release(self.rankTxt);self.rankTxt=nil;
_UIObject_release(self.rewardTipsTxt);self.rewardTipsTxt=nil;
_UIObject_release(self.rewardSign);self.rewardSign=nil;
_UIObject_release(self.scoreRewardGrid);self.scoreRewardGrid=nil;
_UIObject_release(self.rewardNameTxt);self.rewardNameTxt=nil;
_UIObject_release(self.scoreTxt);self.scoreTxt=nil;
_UIObject_release(self.scoreTipsTxt);self.scoreTipsTxt=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.scoreIcon);self.scoreIcon=nil;
_UIObject_release(self.scorelvIcon);self.scorelvIcon=nil;
_UIObject_release(self.racePlaceTxt);self.racePlaceTxt=nil;
_UIObject_release(self.defBtn);self.defBtn=nil;
_UIObject_release(self.raceTimeTxt);self.raceTimeTxt=nil;
_UIObject_release(self.rewardPoolTxt);self.rewardPoolTxt=nil;
_UIObject_release(self.scoreProgress);self.scoreProgress=nil;
end
















local _this


function UISubAct_zongmendabi_info_win:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_zongmendabi_info_win:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_zongmendabi_info_win:onHide()

end




function UISubAct_zongmendabi_info_win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.tab_idx=argtable.tab_idx

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
end
self:refreshActTime()
self:refreshInfo()
self:refreshRewardPool()


local check=self.sub_actInfo:checkRankTopThree()
if not check then
self:refreshRankPanel()
else
self.rankGrid:setActive(false)
end

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(4040,1,{},0,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end

function UISubAct_zongmendabi_info_win:refreshActTime()
local lerp=self.sub_actInfo:getEndLeftTime()
if lerp<0 then
lerp=0
end
local time_str=FMT.fmt('宗门大比结束倒计时：<color=#f7f7f7>{0}</color>',timeHelper.format_time_stamp3(lerp))
self.raceTimeTxt:setText(time_str)
end

function UISubAct_zongmendabi_info_win:refreshMyRank()
local rank=self.myData.my_rank
local canInRank=activitiesHandle_zongmendabi.canInRank(self.subid,self.myData.score)
local rank_str
if rank>0 and canInRank then
rank_str=FMT.fmt('排名：<color=#CA631D>第{0}名</color>',rank)
else
rank_str='排名：未上榜'
end
self.rankTxt:setText(rank_str)
end

function UISubAct_zongmendabi_info_win:refreshInfo()

local racelv=self.myData.zone_type
local race_str=FMT.fmt('当前赛场：{0}组',activitiesHandle_zongmendabi.getRaceLevelName(self.subid,racelv))
self.racePlaceTxt:setText(race_str)

self:refreshMyRank()


local score=self.myData.score
local lv,cur,max,isfull=activitiesHandle_zongmendabi.getZMRewardLevel(self.subid,score)
local zmlv=activitiesHandle_zongmendabi.getZMLevelByScore(self.subid,score)
local duanweiName,duanweiIcon,rewardName,duanweiName2=activitiesHandle_zongmendabi.getZMLevelInfo(self.subid,zmlv)
self.scorelvIcon:setSprite(globalABLookup.zonmengdabi_rank,duanweiIcon)
self.scoreIcon:setImageIcon(moneyModel.getIconNameEx(eMoneyType.mtSectScore),true)
self.scoreIcon:setScale(Vector3(0.5,0.5,1))
self.scoreTxt:setText(tostring(score))
local scoreTips_str
if isfull then
scoreTips_str=''
else
scoreTips_str=FMT.fmt('(再得{0}积分升至{1})',max-cur,duanweiName2)
end
self.scoreTipsTxt:setText(scoreTips_str)
self.scoreProgress:setChildIconFillAmount(cur/max)
self.curRewardLevel=lv
self.curRewardLevelFull=isfull

self:refreshScoreReward()
end

function UISubAct_zongmendabi_info_win:refreshScoreReward()
local getreward_lv=self.myData.recv_lv
local hasReward=getreward_lv<self.curRewardLevel
local isshow=hasReward or not self.curRewardLevelFull
self.rewardNameTxt:setActive(isshow)
self.scoreRewardGrid:setActive(isshow)
self.rewardTipsTxt:setActive(not isshow)
self.rewardSign:setActive(hasReward)
if hasReward then
self.rewardEffect:setChildShowEffect(10207,true)
else
self.rewardEffect:setChildShowEffect(0,false)
end
if isshow then
local lv_=hasReward==true and getreward_lv+1 or self.curRewardLevel+1

local scorelvname,scorelvIcon,scoreRewardName=activitiesHandle_zongmendabi.getZMLevelInfo(self.subid,lv_)
self.rewardNameTxt:setText(scoreRewardName)

local rewards=activitiesHandle_zongmendabi.getZMLevelReward(self.subid,lv_)
self.scoreRewardGrid:setChildLayoutGroupCreateItems(#rewards)
local grids=self.scoreRewardGrid:getChildLayoutGroupGridList()
for i=1,#rewards do
local reward=rewards[i]
local item=grids[i-1]
local itemid=reward[1]
local itemnum=reward[2]
local countStr=''
local showCountBG=false
if itemnum>1 then
showCountBG=true
countStr=tostring(itemnum)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end

function UISubAct_zongmendabi_info_win:refreshRankPanel()
local ranks=self.myData.top3RankList or{}
self.rankGrid:setActive(true)
local grids=self.rankGrid:getChildCommonLayoutGroupWidgetList()
for i=1,3 do
local data=ranks[i]
local has=false
if data~=nil then
local canInRank=activitiesHandle_zongmendabi.canInRank(self.subid,data.score)
if canInRank then
has=true
end
end

local item=grids[i-1]
item:SetChildActive(-1,true)

local name_str
if has then
name_str=data.zm_name
else
name_str='虚位以待'
end
item:SetChildText(1,name_str)

item:SetChildActive(2,has)
if has then

item:SetChildCSImageIcon(3,moneyModel.getIconNameEx(eMoneyType.mtSectScore),true)
item:SetChildScale(3,Vector3(0.5,0.5,1))
item:SetChildText(4,data.score)
end

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onRankItemClick(i)
end)
end
end

function UISubAct_zongmendabi_info_win:refreshRewardPool()
local poolnum=self.myData.item_pool_num
local pool_str=FMT.fmt('灵玉奖池：{0}',poolnum)
self.rewardPoolTxt:setText(pool_str)
end

function UISubAct_zongmendabi_info_win:onRankItemClick(idx)
local ranks=self.myData.top3RankList or{}
local data=ranks[idx]
if data==nil then return end

local has=false
local canInRank=activitiesHandle_zongmendabi.canInRank(self.subid,data.score)
if canInRank then
has=true
end
if not has then return end

local myActorid=playerModel:getActorID()
if not mathHelper.compareInt64(data.actor_id,myActorid)then
local callback=function(teamDzList)
if _this==nil then return end
activitiesHandle_zongmendabi.showOtherPlayerRivalInfo(_this.subid,teamDzList)
end
local args={serverid=data.server_id,actID=self.actID,subType=self.subType,subid=self.subid}
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eZongMenDaBiDef2,data.actor_id,args,callback,true)
end
end

function UISubAct_zongmendabi_info_win:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_zongmendabi_info_win:onRewardSign()
local getreward_lv=self.myData.recv_lv
local hasReward=getreward_lv<self.curRewardLevel
if hasReward then
local json_str=jsonHelper.encode({6,getreward_lv+1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end
end

function UISubAct_zongmendabi_info_win:onRuleBtn()
local d={}
d.title='活动规则'
d.mode=3
d.name='act_zongmendabi_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_zongmendabi_info_win:onBattleBtn()
local tab_idx=activitiesModel:getSubActDefineTabIndex(SUBACT_DEFINETAB_TYPE.eZongMenDaBi_battle)
activitiesController:jump(self.actID,self.subType,self.subid,{tab_idx=tab_idx})
end

function UISubAct_zongmendabi_info_win:onRewardPoolBtn()
local tab_idx=activitiesModel:getSubActDefineTabIndex(SUBACT_DEFINETAB_TYPE.eZongMenDaBi_reward)
activitiesController:jump(self.actID,self.subType,self.subid,{tab_idx=tab_idx})
end

function UISubAct_zongmendabi_info_win:onRankBtn()
self:showWindow("UISubAct_zongmendabi_rank_win",{act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid})
end

function UISubAct_zongmendabi_info_win:onDefBtn()
activitiesHandle_zongmendabi.setupDefTeams(self.actID,self.subType,self.subid,self.tab_idx)
end

function UISubAct_zongmendabi_info_win:recv_scoreReward()
self:refreshScoreReward()
end

function UISubAct_zongmendabi_info_win:recv_rankTopThree()
self:refreshRankPanel()
self:refreshMyRank()
end