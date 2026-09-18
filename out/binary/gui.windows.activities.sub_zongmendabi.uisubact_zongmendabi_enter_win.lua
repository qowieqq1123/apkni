







def_class("UISubAct_zongmendabi_enter_win",UIWindowBase)









function UISubAct_zongmendabi_enter_win:bindComponents()

self.bgModel=UIObject.get(self,0)
self.changeDefBtn=UIButton.get(self,1)
self.chekBtn=UIButton.get(self,2)
self.desc2Txt=UIText.get(self,3)
self.descTxt=UIText.get(self,4)
self.fivepeople=UIObject.get(self,5)
self.headRewardGrid=UIObject.get(self,6)
self.joinBtn=UIButton.get(self,7)
self.joinBtnTxt=UIText.get(self,8)
self.joinRewardtBtn=UIButton.get(self,9)
self.joinSign=UIObject.get(self,10)
self.joinTimeTxt=UIText.get(self,11)
self.raceTimeTxt=UIText.get(self,12)
self.rightModel=UIObject.get(self,13)
self.root=UIObject.get(self,14)
self.ruleBtn=UIButton.get(self,15)
self.teamOneGrid=UIObject.get(self,16)
self.teamOneGridFive=UIObject.get(self,17)
self.teamTwoGrid=UIObject.get(self,18)
self.teamTwoGridFive=UIObject.get(self,19)
self.threepeople=UIObject.get(self,20)

self.changeDefBtn:setButtonClick(function()self:onChangeDefBtn()end)

self.chekBtn:setButtonClick(function()self:onChekBtn()end)

self.joinBtn:setButtonClick(function()self:onJoinBtn()end)

self.joinRewardtBtn:setButtonClick(function()self:onJoinRewardtBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UISubAct_zongmendabi_enter_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.changeDefBtn);self.changeDefBtn=nil;
_UIObject_release(self.chekBtn);self.chekBtn=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.fivepeople);self.fivepeople=nil;
_UIObject_release(self.headRewardGrid);self.headRewardGrid=nil;
_UIObject_release(self.joinBtn);self.joinBtn=nil;
_UIObject_release(self.joinBtnTxt);self.joinBtnTxt=nil;
_UIObject_release(self.joinRewardtBtn);self.joinRewardtBtn=nil;
_UIObject_release(self.joinSign);self.joinSign=nil;
_UIObject_release(self.joinTimeTxt);self.joinTimeTxt=nil;
_UIObject_release(self.raceTimeTxt);self.raceTimeTxt=nil;
_UIObject_release(self.rightModel);self.rightModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.teamOneGrid);self.teamOneGrid=nil;
_UIObject_release(self.teamOneGridFive);self.teamOneGridFive=nil;
_UIObject_release(self.teamTwoGrid);self.teamTwoGrid=nil;
_UIObject_release(self.teamTwoGridFive);self.teamTwoGridFive=nil;
_UIObject_release(self.threepeople);self.threepeople=nil;
end
















local _this


function UISubAct_zongmendabi_enter_win:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_zongmendabi_enter_win:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_zongmendabi_enter_win:onHide()

end




function UISubAct_zongmendabi_enter_win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.tab_idx=argtable.tab_idx

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self:initActTime()
self:refreshInfo()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(4038,1,{},0,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
self.rightModel:setChildUIModelShowTarget(4039,1,{},0,false,false,0,nil)
end
end

function UISubAct_zongmendabi_enter_win:initActTime()
local idx=self.sub_actInfo:getOpenDayIndex()
local isBaoMing=self.sub_actInfo:isBaoMing()
local isShow=idx<=1 and not isBaoMing
if isShow then

local y,m,d=timeHelper.getDateNumber(self.sub_actInfo.start_time_l)
local bm_end_time=timeHelper.getSeconds(y,m,d,24,0,0)
self.bm_end_time=bm_end_time

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
end
self:refreshActTime()
else
if self.myTimer~=nil then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
end
end
self.joinTimeTxt:setActive(isShow)
end

function UISubAct_zongmendabi_enter_win:refreshActTime()
local cur=gameUtilityModel.getServerLongTime()
local lerp=self.bm_end_time-cur
if lerp<0 then
lerp=0
end
local time_str=FMT.fmt('报名截止时间：{0}',timeHelper.format_time_stamp3(lerp))
self.joinTimeTxt:setText(time_str)
end

function UISubAct_zongmendabi_enter_win:refreshInfo()

local s_y,s_m,s_d=timeHelper.getDateNumber(self.sub_actInfo.start_time_l+timeSecLook.eOneDaySec)
local e_y,e_m,e_d=timeHelper.getDateNumber(self.sub_actInfo.end_time_l)
s_m=tonumber(s_m)
e_m=tonumber(e_m)
local time_str=FMT.fmt('{0}月{1}日-{2}月{3}日',s_m,s_d,e_m,e_d)
local race_str=FMT.fmt('比赛时间：<color=#000000>{0}</color>',time_str)
self.raceTimeTxt:setText(race_str)

local desc_str=cfgHelper.getlang('act_zongmendabi_tips_1')
self.descTxt:setText(desc_str)

local rewards=self.sub_actInfo:getHeadReward()
local grids=self.headRewardGrid:getChildCommonLayoutGroupWidgetList()
for i=1,#rewards do
local reward=rewards[i]
local item=grids[i-1]
local itemid=reward.itemid
local itemnum=reward.itemcount
local showCountBG=false
if itemnum>1 then
showCountBG=true
end
item:SetChildActive(1,showCountBG)
if showCountBG then
item:SetChildText(2,tostring(itemnum))
end
local showSign=itemsConfig.isFabao(itemid)
item:SetChildActive(3,showSign)
local iconName=itemsModel.getIconName(reward)
item:SetChildCSImageIcon(0,iconName,true)
item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onClickItem(i)
end)
item:SetChildShowEffect(4,10213,true)
end

local desc2_str=cfgHelper.getlang('act_zongmendabi_tips_2')
self.desc2Txt:setText(desc2_str)

self:refreshJoinBtn()
self:refreshDefTeam()
end

function UISubAct_zongmendabi_enter_win:refreshJoinBtn()
local idx=self.sub_actInfo:getOpenDayIndex()
local isBaoMing=self.sub_actInfo:isBaoMing()
local showBtn=not isBaoMing
self.joinBtn:setActive(showBtn)
self.joinSign:setActive(not showBtn)
if showBtn then
local btn_str=idx<=1 and'立即报名'or'立即参与'
self.joinBtnTxt:setText(btn_str)
end
local showReward=idx<=1 and not isBaoMing
self.joinRewardtBtn:setActive(showReward)
end

function UISubAct_zongmendabi_enter_win:refreshDefTeam()
self:refreshDefTeamEx(1)
self:refreshDefTeamEx(2)
end

function UISubAct_zongmendabi_enter_win:refreshDefTeamEx(teamIndex)
local def_team=self.sub_actInfo:getDefTeamThree(teamIndex)
local num=self.sub_actcfg.deflist[2]
local grids=nil
self.threepeople:setActive(num==3)
self.fivepeople:setActive(num~=3)
if num==3 then
local teamGrid=teamIndex==1 and self.teamOneGrid or self.teamTwoGrid
teamGrid:setChildLayoutGroupCreateItems(3)
grids=teamGrid:getChildLayoutGroupGridList()
else
local teamGrid=teamIndex==1 and self.teamOneGridFive or self.teamTwoGridFive
grids=teamGrid:getChildCommonLayoutGroupWidgetList()
end


for i=1,num do
local dis_guid=def_team[i]
local item=grids[i-1]
local has=dis_guid~=nil
item:SetChildActive(0,not has)
item:SetChildActive(1,has)
item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onChangeDefBtn(teamIndex)
end)
if has then

comHelper.setChildModelHeadIconBG(item,1,dis_guid)

comHelper.setChildModelRawImage(item,dis_guid,2,0,eHeadCenterType.eHead)

local jobicon=UIDiscipleModel:getJobIconNameX(dis_guid)
item:SetChildCSImageSprite(3,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(dis_guid)
item:SetChildActive(4,isSpDz)
end
end
end

function UISubAct_zongmendabi_enter_win:onClickItem(idx)
local rewards=self.sub_actInfo:getHeadReward()
local reward=rewards[idx]
local itemguid=reward.itemguid
local itemid=reward.itemid
local watch=watchModel.getItem(itemguid)
if watch==nil then
watchModel.setItem(reward)
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_zongmendabi_enter_win:onJoinBtn()
local def_team1=self.sub_actInfo:getDefTeamThree(1)
local def_team2=self.sub_actInfo:getDefTeamThree(2)
local checkTeam=false
if def_team1~=nil and def_team2~=nil and#def_team1>0 and#def_team2>0 then
checkTeam=true
end
if not checkTeam then
UIManager.error('请先设置防守阵容')

self:onChangeDefBtn()
return
end

local json_str=jsonHelper.encode({3})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end

function UISubAct_zongmendabi_enter_win:onJoinRewardtBtn()
local args={}
args.title='报名奖励'
args.desc='报名成功可获得以下奖励'
args.rewards=self.sub_actcfg.enterreward
self:showWindow('UICommonRewardShowWin',args)
end

function UISubAct_zongmendabi_enter_win:onChekBtn()
local args={act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid}
self:showWindow('UISubAct_zongmendabi_headreward_win',args)
end

function UISubAct_zongmendabi_enter_win:onChangeDefBtn(teamIndex)
activitiesHandle_zongmendabi.setupDefTeams(self.actID,self.subType,self.subid,self.tab_idx,teamIndex)
end

function UISubAct_zongmendabi_enter_win:onRuleBtn()
local d={}
d.title='活动规则'
d.mode=3
d.name='act_zongmendabi_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_zongmendabi_enter_win:rec_changeDef()
self:refreshDefTeam()
end

function UISubAct_zongmendabi_enter_win:rec_baoming()
self:initActTime()
self:refreshJoinBtn()
end

function UISubAct_zongmendabi_enter_win:rec_newday()
self:refreshJoinBtn()
end