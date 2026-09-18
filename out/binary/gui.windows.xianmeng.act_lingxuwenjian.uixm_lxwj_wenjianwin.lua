







def_class("UIXM_LXWJ_WenJianWin",UIWindowBase)









function UIXM_LXWJ_WenJianWin:bindComponents()

self.effectObj=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.leftPanel=UIObject.get(self,2)
self.bottomPanel=UIObject.get(self,3)
self.middlePanel=UIObject.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.ruleInfoPanel=UIObject.get(self,6)
self.tips2Txt=UIText.get(self,7)
self.defBtn=UIButton.get(self,8)
self.notestBtn=UIButton.get(self,9)
self.scoreRanktBtn=UIButton.get(self,10)
self.pipeiBtn=UIButton.get(self,11)
self.ruleBtn=UIButton.get(self,12)
self.leftGridPanel=UIObject.get(self,13)
self.rightGridPanel=UIObject.get(self,14)
self.tipsObj=UIButton.get(self,15)
self.tipsTxt=UIText.get(self,16)
self.catSp=UIObject.get(self,17)
self.tipsLine=UIObject.get(self,18)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.defBtn:setButtonClick(function()self:onDefBtn()end)

self.notestBtn:setButtonClick(function()self:onNotestBtn()end)

self.scoreRanktBtn:setButtonClick(function()self:onScoreRanktBtn()end)

self.pipeiBtn:setButtonClick(function()self:onPipeiBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.tipsObj:setButtonClick(function()self:onTipsObj()end)



end


function UIXM_LXWJ_WenJianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effectObj);self.effectObj=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.middlePanel);self.middlePanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.ruleInfoPanel);self.ruleInfoPanel=nil;
_UIObject_release(self.tips2Txt);self.tips2Txt=nil;
_UIObject_release(self.defBtn);self.defBtn=nil;
_UIObject_release(self.notestBtn);self.notestBtn=nil;
_UIObject_release(self.scoreRanktBtn);self.scoreRanktBtn=nil;
_UIObject_release(self.pipeiBtn);self.pipeiBtn=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.leftGridPanel);self.leftGridPanel=nil;
_UIObject_release(self.rightGridPanel);self.rightGridPanel=nil;
_UIObject_release(self.tipsObj);self.tipsObj=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.catSp);self.catSp=nil;
_UIObject_release(self.tipsLine);self.tipsLine=nil;
end
















local _this=nil


function UIXM_LXWJ_WenJianWin:onLoaded(...)
_this=self
self:bindComponents()
self.m_cav=self:getChildCanvas(-1)
self.root:setChildCanvas(self.m_cav[1],self.m_cav[2]+3)
end


function UIXM_LXWJ_WenJianWin:__delete()
_this=nil
self:unbindComponents()
UIManager:closeWindow('UIXM_LXWJ_wjBattleWin')
end


function UIXM_LXWJ_WenJianWin:onHide()

end




function UIXM_LXWJ_WenJianWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end
self:refreshTime()

self:refreshInfo()
self:initAllMyItem()
self:initAllEnemyItem()

if afterOnloaded then
local effectObjWidget=self.effectObj:getChildWidgetBase()
effectObjWidget:SetChildSpineAnimation(0,0,1,nil)
effectObjWidget:SetChildShowEffect(1,10361,true)
effectObjWidget:SetChildShowEffect(2,10360,true)
end


local checkJump=false
if argtable.openReplayEx then
local openReplayEx=argtable.openReplayEx
if openReplayEx.openReplay then
if openReplayEx.lxwjkey==-1 then
if lingxuwenjianModel:canOpenWJTNote()then
checkJump=true
UIManager:showWindow('UIXM_LXWJ_wjBattleWin',{openReplay=openReplayEx.openReplay})
end
else



end
end
end
if not checkJump then
lingxuwenjianController:doCloseCloud()
end
end

function UIXM_LXWJ_WenJianWin:refreshTime()
local fightState,left_=lingxuwenjianModel:getFightState()
local fightState_old=self.fightState
self.fightState=fightState
if self.fightState~=fightState_old then
self:refreshDefBtn()
self:refreshPipeiBtn()
self:refreshTips()
if fightState_old~=nil then
if self.fightState==eLXWJ_Fight_State.eWJIdle then
self:refreshAllMyItem()
end
end
end
if fightState_old~=nil and self.fightState>eLXWJ_Fight_State.eWJIdle then
local old_inWJTFightIndex=self.inWJTFightIndex
self.inWJTFightIndex=lingxuwenjianModel:checkInWJTFightIndex(self.fightState)
if old_inWJTFightIndex~=self.inWJTFightIndex then
if old_inWJTFightIndex~=nil then
self:refreshMyItem(nil,old_inWJTFightIndex)
self:refreshEnemyItem(nil,old_inWJTFightIndex)
end
if self.inWJTFightIndex~=nil then
self:refreshMyItem(nil,self.inWJTFightIndex)
self:refreshEnemyItem(nil,self.inWJTFightIndex)
end
end
end


local raceState=lingxuwenjianModel:getLunState()
local standbyTime_str=nil
local fightingTime_str=nil
local showline=false
if raceState==eLXWJ_State.eFight then
if not lingxuwenjianModel:hasEnemy()then
standbyTime_str='未匹配对手\n无需问剑'
elseif lingxuwenjianModel:checkBattleResult()~=nil then
standbyTime_str='胜负已分\n无需问剑'
else
if fightState==eLXWJ_Fight_State.eFight then
standbyTime_str=FMT.fmt('将于<color=#FD8950>{0}</color>后\n开始问剑',timeHelper.format_time_stamp3(left_))
elseif fightState>eLXWJ_Fight_State.eFight then
if fightState==eLXWJ_Fight_State.eWJIdle then
fightingTime_str=FMT.fmt('第一轮将于\n<color=#FD8950>{0}</color>后开启',timeHelper.format_time_stamp3(left_))
elseif fightState==eLXWJ_Fight_State.eWJ1 then
if lingxuwenjianModel:checkInWJTFight(fightState,1)then
fightingTime_str='第一轮激战中\n<color=#FD8950>点击进入观战</color>'
showline=true
else
fightingTime_str=FMT.fmt('第二轮将于\n<color=#FD8950>{0}</color>后开启',timeHelper.format_time_stamp3(left_))
end
elseif fightState==eLXWJ_Fight_State.eWJ2 then
if lingxuwenjianModel:checkInWJTFight(fightState,2)then
fightingTime_str='第二轮激战中\n<color=#FD8950>点击进入观战</color>'
showline=true
else
fightingTime_str=FMT.fmt('第三轮将于\n<color=#FD8950>{0}</color>后开启',timeHelper.format_time_stamp3(left_))
end
elseif fightState==eLXWJ_Fight_State.eWJ3 then
if lingxuwenjianModel:checkInWJTFight(fightState,3)then
fightingTime_str='第三轮激战中\n<color=#FD8950>点击进入观战</color>'
showline=true
end
end
end
end
end
local showTips=standbyTime_str~=nil or fightingTime_str~=nil
self.tipsObj:setActive(showTips)
if showTips then
self.tipsTxt:setText(standbyTime_str or fightingTime_str)
self.tipsLine:setActive(showline)
if self.catSpID==nil then
self.catSpID=4792
self.tipsTxt:setActive(false)
self.catSp:setChildUIModelShowTarget(4792,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(1,function()
_this.tipsTxt:setActive(true)
end)
end)
end
end
end

function UIXM_LXWJ_WenJianWin:refreshTips()
local str
local check=false
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eStandby then
check=true
elseif raceState==eLXWJ_State.eFight then
if self.fightState==eLXWJ_Fight_State.eFight then
check=true
end
end
if check then
str='请盟主/副盟主及时安排问剑成员'
else
str='问剑开始后，锁定双方参战成员'
end
self.tips2Txt:setText(str)
end

function UIXM_LXWJ_WenJianWin:refreshDefBtn()
local raceState=lingxuwenjianModel:getLunState()
local isshow=raceState==eLXWJ_State.eStandby or self.fightState==eLXWJ_Fight_State.eFight
self.defBtn:setActive(isshow)
end

function UIXM_LXWJ_WenJianWin:refreshPipeiBtn()
local isshow=lingxuwenjianModel:canOpenWJTNote()
self.pipeiBtn:setActive(isshow)
end

function UIXM_LXWJ_WenJianWin:refreshInfo()
local widget=self.ruleInfoPanel:getWidgetBase()
local cfg=cfgHelper.get1(cfg_lingxuwenjianconfig_get,1)
local desc_str=cfg.wjDesc
widget:SetChildText(0,desc_str)
local moneyNum=cfg.score[5][1]
local money_str=tostring(moneyNum)
widget:SetChildText(1,money_str)
end

function UIXM_LXWJ_WenJianWin:initAllMyItem()
local leftWidget=self.leftGridPanel:getWidgetBase()
for i=1,3 do
local widget=leftWidget:GetChildWidgetBase(i-1)

widget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onMyItemClick(i)
end)

widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onMyItemHeadClick(i)
end)
self:refreshMyItem(widget,i)
end
end

function UIXM_LXWJ_WenJianWin:refreshAllMyItem()
local leftWidget=self.leftGridPanel:getWidgetBase()
for i=1,3 do
local widget=leftWidget:GetChildWidgetBase(i-1)
self:refreshMyItem(widget,i)
end
end









function UIXM_LXWJ_WenJianWin:refreshMyItem(widget,idx)
if widget==nil then
local leftWidget=self.leftGridPanel:getWidgetBase()
widget=leftWidget:GetChildWidgetBase(idx-1)
end

local zyData=lingxuwenjianModel:getWJTData(0,idx)
local has=zyData~=nil

local showadd=false
if not has and lingxuwenjianModel:isLeader()then
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eStandby then
showadd=true
elseif self.fightState==eLXWJ_Fight_State.eFight then
if lingxuwenjianModel:hasEnemy()and lingxuwenjianModel:checkBattleResult()==nil then
showadd=true
end
end
end
widget:SetChildActive(0,showadd)

local showTips=not has and not showadd
widget:SetChildActive(9,showTips)

local showman=has
widget:SetChildActive(3,showman)
if showman then

local headParams={iconInfo=zyData.iconInfo,scale=0.5}
playerController:setHeadIcon(widget,4,headParams)

widget:SetChildText(5,zyData.actorname)

widget:SetChildText(6,mathHelper.formatNumber6(zyData.fightvalue_num))

local result=lingxuwenjianModel:getWJTResult(idx)
local isshow=false
if result~=nil then
isshow=not lingxuwenjianModel:checkInWJTFight(self.fightState,idx)
end
widget:SetChildActive(7,isshow)
if isshow then
local abname_,icon_=lingxuwenjianModel:getResultIcon3(result,true)
widget:SetChildCSImageSprite(7,abname_,icon_)
end

self:refreshMyItemSign(widget,idx)
end
end

function UIXM_LXWJ_WenJianWin:refreshMyItemSign(widget,idx)
if widget==nil then
local leftWidget=self.leftGridPanel:getWidgetBase()
widget=leftWidget:GetChildWidgetBase(idx-1)
end

local fightState=self.fightState
local showSign=false
if idx==1 and fightState==eLXWJ_Fight_State.eWJ1 then
if lingxuwenjianModel:checkInWJTFight(fightState,1)then
showSign=true
end
elseif idx==2 and fightState==eLXWJ_Fight_State.eWJ2 then
if lingxuwenjianModel:checkInWJTFight(fightState,2)then
showSign=true
end
elseif idx==3 and fightState==eLXWJ_Fight_State.eWJ3 then
if lingxuwenjianModel:checkInWJTFight(fightState,3)then
showSign=true
end
end
widget:SetChildActive(8,showSign)
end

function UIXM_LXWJ_WenJianWin:onMyItemClick(idx)
local zyData=lingxuwenjianModel:getWJTData(0,idx)
local has=zyData~=nil
if has then
local params={}
params.server_id=playerModel:getActorServerID()
params.actorid=zyData.actorid
params.lxwjteamtype=2
params.posData={0,0,idx}
params.extraParams={}
lingxuwenjianController:openBattleWin(params)
else
local check=false
if lingxuwenjianModel:isLeader()then
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eStandby then
check=true
elseif self.fightState==eLXWJ_Fight_State.eFight then
if lingxuwenjianModel:hasEnemy()and lingxuwenjianModel:checkBattleResult()==nil then
check=true
end
end
end
if check then
lingxuwenjianController:openMemberList(4)
end
end
end

function UIXM_LXWJ_WenJianWin:onMyItemHeadClick(idx)
local zyData=lingxuwenjianModel:getWJTData(0,idx)
if zyData then
local callback=function(teamDzList_,other)
if _this==nil then return end
lingxuwenjianController:showOtherPlayerRivalInfo(teamDzList_)
end
local server_id=playerModel:getActorServerID()
local send_args={serverid=server_id,lxwjteamtype=2}
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eLingXuWenJianDef2,zyData.actorid,send_args,callback,false,true)
else
self:onMyItemClick(idx)
end
end

function UIXM_LXWJ_WenJianWin:initAllEnemyItem()
local rightWidget=self.rightGridPanel:getWidgetBase()
for i=1,3 do
local widget=rightWidget:GetChildWidgetBase(i-1)

widget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onEnemyItemClick(i)
end)

widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onEnemyItemHeadClick(i)
end)
self:refreshEnemyItem(widget,i)
end
end

function UIXM_LXWJ_WenJianWin:refreshAllEnemyItem()
local rightWidget=self.rightGridPanel:getWidgetBase()
for i=1,3 do
local widget=rightWidget:GetChildWidgetBase(i-1)
self:refreshEnemyItem(widget,i)
end
end









function UIXM_LXWJ_WenJianWin:refreshEnemyItem(widget,idx)
if widget==nil then
local rightWidget=self.rightGridPanel:getWidgetBase()
widget=rightWidget:GetChildWidgetBase(idx-1)
end

local zyData=lingxuwenjianModel:getWJTData(1,idx)
local has=zyData~=nil

local showTips=not has
widget:SetChildActive(9,showTips)

local showman=has
widget:SetChildActive(3,showman)
if showman then

local headParams={iconInfo=zyData.iconInfo,scale=0.5}
playerController:setHeadIcon(widget,4,headParams)

widget:SetChildText(5,zyData.actorname)

widget:SetChildText(6,mathHelper.formatNumber6(zyData.fightvalue_num))

local result=lingxuwenjianModel:getWJTResult(idx)
local isshow=false
if result~=nil then
isshow=not lingxuwenjianModel:checkInWJTFight(self.fightState,idx)
end
widget:SetChildActive(7,isshow)
if isshow then
local abname_,icon_=lingxuwenjianModel:getResultIcon3(result,false)
widget:SetChildCSImageSprite(7,abname_,icon_)
end

self:refreshEnemyItemSign(widget,idx)
end
end

function UIXM_LXWJ_WenJianWin:refreshEnemyItemSign(widget,idx)
if widget==nil then
local rightWidget=self.rightGridPanel:getWidgetBase()
widget=rightWidget:GetChildWidgetBase(idx-1)
end

local fightState=self.fightState
local showSign=false
if idx==1 and fightState==eLXWJ_Fight_State.eWJ1 then
if lingxuwenjianModel:checkInWJTFight(fightState,1)then
showSign=true
end
elseif idx==2 and fightState==eLXWJ_Fight_State.eWJ2 then
if lingxuwenjianModel:checkInWJTFight(fightState,2)then
showSign=true
end
elseif idx==3 and fightState==eLXWJ_Fight_State.eWJ3 then
if lingxuwenjianModel:checkInWJTFight(fightState,3)then
showSign=true
end
end
widget:SetChildActive(8,showSign)
end

function UIXM_LXWJ_WenJianWin:onEnemyItemClick(idx)
local zyData=lingxuwenjianModel:getWJTData(1,idx)
local has=zyData~=nil
if has then
local enemyData=lingxuwenjianModel:getEnemyData()
local params={}
params.server_id=enemyData.enemyserverid
params.actorid=zyData.actorid
params.lxwjteamtype=2
params.posData={1,0,idx}
params.extraParams={}
lingxuwenjianController:openBattleWin(params)
end
end

function UIXM_LXWJ_WenJianWin:onEnemyItemHeadClick(idx)
local zyData=lingxuwenjianModel:getWJTData(1,idx)
local has=zyData~=nil
if has then
local callback=function(teamDzList_,other)
if _this==nil then return end
lingxuwenjianController:showOtherPlayerRivalInfo(teamDzList_)
end
local enemyData=lingxuwenjianModel:getEnemyData()
local server_id=enemyData.enemyserverid
local send_args={serverid=server_id,lxwjteamtype=2}
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eLingXuWenJianDef2,zyData.actorid,send_args,callback,false,true)
end
end

function UIXM_LXWJ_WenJianWin:onTipsObj()
if lingxuwenjianModel:canOpenWJTNote()then
local fightState=self.fightState
local idx
if fightState==eLXWJ_Fight_State.eWJ1 then
if lingxuwenjianModel:checkInWJTFight(fightState,1)then
idx=1
end
elseif fightState==eLXWJ_Fight_State.eWJ2 then
if lingxuwenjianModel:checkInWJTFight(fightState,2)then
idx=2
end
elseif fightState==eLXWJ_Fight_State.eWJ3 then
if lingxuwenjianModel:checkInWJTFight(fightState,3)then
idx=3
end
end
if idx~=nil then
lingxuwenjianController:openWJTReplay(idx)
end
end
end

function UIXM_LXWJ_WenJianWin:onCloseBtn()
self:closeSelf()
end

function UIXM_LXWJ_WenJianWin:onScoreRanktBtn()
lingxuwenjianController:openScoreWin()
end

function UIXM_LXWJ_WenJianWin:onNotestBtn()
UIManager:showWindow('UIXM_LXWJ_notesWin')
end

function UIXM_LXWJ_WenJianWin:onPipeiBtn()
if lingxuwenjianModel:canOpenWJTNote()then
UIManager:showWindow('UIXM_LXWJ_wjBattleWin')
end
end

function UIXM_LXWJ_WenJianWin:onDefBtn()
local raceState=lingxuwenjianModel:getLunState()
local isshow=raceState==eLXWJ_State.eStandby or self.fightState==eLXWJ_Fight_State.eFight
if not isshow then
UIManager.error('当前阶段不能设置防守阵容')
return
end

local pos={0,0}
lingxuwenjianController.setupDefTeams(2,nil,{openPos=pos})
end

function UIXM_LXWJ_WenJianWin:onRuleBtn()
local pos=self.ruleBtn:getChildScreenPointToLocalPointRectangle()
pos.x=pos.x+15
pos.y=pos.y+20
local desc=cfgHelper.getlang('lxwj_tips_1')or'语言表lxwj_tips_1'
UIManager:showWindow('UIConditionTipsOne',{showType=2,str=desc,pos=pos})
end

function UIXM_LXWJ_WenJianWin:rec_posChange(src,lxwjkey)
if src==0 then
self:refreshMyItem(nil,lxwjkey)
else
self:refreshEnemyItem(nil,lxwjkey)
end
end

function UIXM_LXWJ_WenJianWin:rec_enemy()
self:refreshPipeiBtn()
self:refreshAllMyItem()
self:refreshAllEnemyItem()
end

function UIXM_LXWJ_WenJianWin:rec_posResult(idx)
self:refreshMyItem(nil,idx)
self:refreshEnemyItem(nil,idx)
end

function UIXM_LXWJ_WenJianWin:rec_result()
self:refreshAllMyItem()
end

function UIXM_LXWJ_WenJianWin:rec_over()
self:refreshPipeiBtn()
self:refreshAllMyItem()
self:refreshAllEnemyItem()
UIManager:invokeUIMethod('UIXM_LXWJ_memberFourWin','onClickClose')
end