







def_class("UIXianJIeFuMoMainWin",UIWindowBase)









function UIXianJIeFuMoMainWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.addTx=UIText.get(self,1)
self.bossModel=UIObject.get(self,2)
self.bossName=UIImage.get(self,3)
self.bossTime=UIText.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.closeTx=UIText.get(self,6)
self.gotoBtn=UIButton.get(self,7)
self.helpBtn=UIButton.get(self,8)
self.myPersonalRankInfo=UIObject.get(self,9)
self.myXianMengRankInfo=UIObject.get(self,10)
self.noneTips=UIText.get(self,11)
self.personalRankHeader=UIObject.get(self,12)
self.rankList=UIObject.get(self,13)
self.rankScrollView=UILoopListView.new(self,14)
self.rankTab_1=UIObject.get(self,15)
self.rankTab_2=UIObject.get(self,16)
self.rankTierDivisionDropdown=UIDropdownEx.get(self,17)
self.rewardBtn=UIButton.get(self,18)
self.rewardReddot=UIObject.get(self,19)
self.skillList=UIObject.get(self,20)
self.skillView=UIObject.get(self,21)
self.xianMengRankHeader=UIObject.get(self,22)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.rankScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)
self.rankTab={
self.rankTab_1,
self.rankTab_2,
}



end


function UIXianJIeFuMoMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.addTx);self.addTx=nil;
_UIObject_release(self.bossModel);self.bossModel=nil;
_UIObject_release(self.bossName);self.bossName=nil;
_UIObject_release(self.bossTime);self.bossTime=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeTx);self.closeTx=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.myPersonalRankInfo);self.myPersonalRankInfo=nil;
_UIObject_release(self.myXianMengRankInfo);self.myXianMengRankInfo=nil;
_UIObject_release(self.noneTips);self.noneTips=nil;
_UIObject_release(self.personalRankHeader);self.personalRankHeader=nil;
_UIObject_release(self.rankList);self.rankList=nil;
self.rankScrollView:deleteSelf();self.rankScrollView=nil;
_UIObject_release(self.rankTab_1);self.rankTab_1=nil;
_UIObject_release(self.rankTab_2);self.rankTab_2=nil;
_UIObject_release(self.rankTierDivisionDropdown);self.rankTierDivisionDropdown=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.skillView);self.skillView=nil;
_UIObject_release(self.xianMengRankHeader);self.xianMengRankHeader=nil;
self.rankTab=nil;
end
















local _this=nil
local _rankItemCmp={
no=0,
value=1,
name=2,
}
local _skillCmp={
widget=-1,
icon=0,
sign=1,
lvText=2,
click=3,
lv=4,
new=5,
}

local rankTabCmp={
bg=0,
select=1,
name=2,
click=3,
}

local _myRankInfoSubWidgetID={
no=0,
name=1,
xianMengName=2,
value=3
}

local _rankItemSubWidgetID={
me=0,
personalRankInfo=1,
xianMengRankInfo=2
}

local _rankInfoSubCompID={
no=0,
name=1,
xianMengTex=2,
value=3
}


local _altasAB='ui/windows/xianjiefumo/xianjiefumo_atlas_pak.ab'



function UIXianJIeFuMoMainWin:onLoaded(...)
self:bindComponents()
_this=self
local str=limitActivitiesModel:getActConfig(LIMIT_ACT_TYPE.eXianJieFuMo,"name")
self.closeTx:setText(str)
self.rankTabWidget={}
local sortTemp={
[XJFMRankType.eGeRen]=self.rankTab[1],
[XJFMRankType.eXianMeng]=self.rankTab[2],
}
for k,v in pairs(XJFMRankType)do
local obj=sortTemp[v]
local widget=obj:getWidgetBase()
local func=function()
self:OnClickRankTab(v)
end
widget:SetChildButtonClick(rankTabCmp.click,func,true)
self.rankTabWidget[v]=widget
end
self:addReddotNotify(REDDIT_TYPE.eXianjieFuMo,function(...)
self:refreshRewardReddot(...)
end)
end


function UIXianJIeFuMoMainWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJIeFuMoMainWin:onShow(argtable,afterOnloaded)
self.rankType=XJFMRankType.eGeRen
if argtable and argtable.rankType then
self.rankType=argtable.rankType
end
if argtable and argtable.showTarget then
if XianJieFuMoModel.init then
local args={
monsterIdx=XianJieFuMoModel:getMonsterIdx()
}
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eXJFMreward_Target,args)
end
end
if XianJieFuMoModel.init then
self:initRankTierDivisionDropdown()
self:updateView()
else
XianJieFuMoController.req_248_103()
end
end


function UIXianJIeFuMoMainWin:onHide()

end

function UIXianJIeFuMoMainWin:updateView()
self.monsterIdx=XianJieFuMoModel:getMonsterIdx()
self:refreshRankTab()
self:refreshRankList()
self:refreshBossInfo()
self:refreshTimes()
self:refreshRewardReddot()
end




function UIXianJIeFuMoMainWin:onCloseBtn()
UIFullXianJieFuMoController:closeUI()
end


function UIXianJIeFuMoMainWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='xianjiefumo_rank_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end


function UIXianJIeFuMoMainWin:onGotoBtn()

if XianJieFuMoController.checkStopFight()then
UIManager.info("首领已击败，无法挑战")
return
end

if bagControl.checkShowFullEquipBagTips('无法继续挑战')then
return
end

UIFullXianJieFuMoController:closeUI()
local fun=function()
XianJieFuMoController:jumpBossPos(function()
UIFullXianJieFuMoController:showChallengeWin()
end)
end
local sceneType=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"sceneType")
if xianjieModel:checkSceneType(sceneType)then
fun()
return
end
xianjieController:jumpXianJie(sceneType,{},fun)
end


function UIXianJIeFuMoMainWin:onRewardBtn()
local args={
monsterIdx=self.monsterIdx,
}
oneTabScreenController:openUI(SEC_FULL_TYPE.XJFMRewardSecondary,args)
end

function UIXianJIeFuMoMainWin:onAddBtn()
XianJieFuMoController:showBuyDialogue()
end

function UIXianJIeFuMoMainWin:OnClickRankTab(rankType)
self.rankType=rankType
self:refreshRankTab()
self:refreshRankList()
end

function UIXianJIeFuMoMainWin:refreshRankTab()
for k,v in pairs(self.rankTabWidget)do
v:SetChildActive(rankTabCmp.select,k==self.rankType)
end
local setHeader=function(type)
local isPersonalType=type==XJFMRankType.eGeRen
self.personalRankHeader:setActive(isPersonalType)
self.xianMengRankHeader:setActive(not isPersonalType)
self.rankTierDivisionDropdown:setActive(isPersonalType)
local widget=self.rankScrollView:getChildWidgetBase()
widget:SetChildSizeWithCurrentAnchors(-1,1,isPersonalType and 321.78 or 374.78)
end

setHeader(self.rankType)

end

function UIXianJIeFuMoMainWin:refreshRankList()

local getMyRankInfoWb=function(type)
if type==XJFMRankType.eGeRen then
return self.myPersonalRankInfo:getChildWidgetBase()
else
return self.myXianMengRankInfo:getChildWidgetBase()
end
end


local rankInfo=XianJieFuMoModel:getRank(self.rankType)
local rankData=XianJieFuMoModel:getData()

if rankInfo==nil then
self.rankScrollView:initData("rankItem",{},0)
self.noneTips:setActive(false)



XianJieFuMoController.req_RankList(self.rankType,self:getRankTierID())
return
end

local rankCount=rankInfo.len

self.rankScrollView:initData("rankItem",rankInfo.list or{},rankCount)
local check=rankInfo.rankIdx>0
local myRankNo=check and FMT.fmt("第{0}名",rankInfo.rankIdx)or"未上榜"

local isPersonalType=self.rankType==XJFMRankType.eGeRen
self.myPersonalRankInfo:setActive(isPersonalType)
self.myXianMengRankInfo:setActive(not isPersonalType)

local myRankInfoWb=getMyRankInfoWb(self.rankType)

myRankInfoWb:SetChildText(_myRankInfoSubWidgetID.no,myRankNo)
local damageTotalValue=""
local name=""
local xianMengName=""
local serverName=loginModel:getServerName(playerModel:getActorServerID())
if isPersonalType then
damageTotalValue=XianJieFuMoModel:getTotaldamage()and mathHelper.formatNumber(XianJieFuMoModel:getTotaldamage(),false)or"————"
name=playerModel:getActorName()
xianMengName=xianmengModel:getXMName()
myRankInfoWb:SetChildText(_myRankInfoSubWidgetID.name,FMT.fmt("{0}\n[{1}]",name,serverName))
myRankInfoWb:SetChildText(_myRankInfoSubWidgetID.xianMengName,xianMengName)
local isInRank=self:getRankTierID()==rankData.lvIdx
myRankInfoWb:SetChildText(_myRankInfoSubWidgetID.value,isInRank and damageTotalValue or 0)
else
damageTotalValue=XianJieFuMoModel:getXMTotaldamage()and mathHelper.formatNumber(XianJieFuMoModel:getXMTotaldamage(),false)or"————"
name=xianmengModel:getXMName()or""
if name~=""then
myRankInfoWb:SetChildText(_myRankInfoSubWidgetID.xianMengName,FMT.fmt("{0}\n[{1}]",name,serverName))
else
myRankInfoWb:SetChildText(_myRankInfoSubWidgetID.xianMengName,"")
end
myRankInfoWb:SetChildText(_myRankInfoSubWidgetID.value,damageTotalValue)

end



if rankCount<=0 then
self.noneTips:setActive(true)
self.noneTips:setText(self.rankType==XJFMRankType.eGeRen and"暂无祖师上榜"or"暂无仙盟上榜")
self.rankScrollView:initData("rankItem",{},rankCount)
return
else
self.noneTips:setActive(false)
end































end

function UIXianJIeFuMoMainWin:onFreshAction(index,widget,data)
local getRankItemWb=function(type,itemWidget)
if type==XJFMRankType.eGeRen then
return itemWidget:GetChildWidgetBase(_rankItemSubWidgetID.personalRankInfo)
else
return itemWidget:GetChildWidgetBase(_rankItemSubWidgetID.xianMengRankInfo)
end
end
local rankInfo=XianJieFuMoModel:getRank(self.rankType)

widget:SetChildActive(_rankItemSubWidgetID.me,rankInfo.rankIdx>0 and(rankInfo.rankIdx==data.rank)or false)
local isPersonalType=self.rankType==XJFMRankType.eGeRen
widget:SetChildActive(_rankItemSubWidgetID.personalRankInfo,isPersonalType)
widget:SetChildActive(_rankItemSubWidgetID.xianMengRankInfo,not isPersonalType)

local rankInfoWb=getRankItemWb(self.rankType,widget)
rankInfoWb:SetChildText(_rankInfoSubCompID.no,FMT.fmt("第{0}名",data.rank))
local server_name=loginModel:getServerName(data.server_id)
if isPersonalType then
rankInfoWb:SetChildText(_rankInfoSubCompID.name,FMT.fmt("{0}\n[{1}]",data.name,server_name))
rankInfoWb:SetChildText(_rankInfoSubCompID.xianMengTex,data.guild_name)
else
rankInfoWb:SetChildText(_rankInfoSubCompID.xianMengTex,FMT.fmt("{0}\n[{1}]",data.name,server_name))
end
rankInfoWb:SetChildText(_rankInfoSubCompID.value,mathHelper.formatNumber(data.damage,false))
end

function UIXianJIeFuMoMainWin:onStartAction()

end

function UIXianJIeFuMoMainWin:refreshBossInfo()
local baseCfg=cfgHelper.get1(cfg_fairylandbossconfig_get,1)
local cfg=baseCfg.monster[self.monsterIdx]
if cfg then
local monsterId=cfg[1][self:getRankTierID()]
local uiModelPos=baseCfg.uiModelPos[self.monsterIdx]
local uiNamePos=baseCfg.uiNamePos[self.monsterIdx]
local monsterParam=comHelper.getMonsterGroupModelParams(monsterId)
local scaleParam=isometricMapSystem:getModelScales2Pram(monsterParam.body,26)
self.bossModel:setChildUIModelShowTarget(monsterParam.body,scaleParam[1],monsterParam.componets,eAnimationID.stand)
self.bossModel:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])
local imageName=cfgHelper.get3(cfg_fairylandbossconfig_get,1,"nameImage",self.monsterIdx)
self.bossName:setSprite(_altasAB,imageName)

self.bossModel:setChildAnchoredPosition(mathHelper.convertArrayToVector(uiModelPos))
self.bossName:setChildAnchoredPosition(mathHelper.convertArrayToVector(uiNamePos))

local preMonster=monsterId
local preSkills=preMonster and cfgHelper.get2(cfg_monstergroup_get,preMonster,"showSkills")or{}
local preSkillLookup={}
for i,v in ipairs(preSkills)do
preSkillLookup[v[1]]=v[2]
end

local skillList=cfgHelper.get2(cfg_monstergroup_get,monsterId,"showSkills")or{}
self.skillList:setChildLayoutGroupCreateItems(#skillList,function(index)
local skillItem=self.skillList:getChildLayoutGroupGridItem(index-1)
local skillData=skillList[index]
local skillID=skillData[1]
local skillLv=skillData[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
skillItem:SetChildActive(_skillCmp.widget,true)

skillItem:SetChildIcon(_skillCmp.icon,iconHelper.getSkillIcon(skillCfg.icon),false)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
skillItem:SetChildActive(_skillCmp.sign,is_bd)

local isNew=preSkillLookup[skillID]==nil and not XianJieFuMoModel:isSkillReaded(self.monsterIdx,skillID)

skillItem:SetChildActive(_skillCmp.new,isNew)

skillItem:SetChildButtonClick(_skillCmp.click,function()
if isNew then
XianJieFuMoModel:setSkillReaded(self.monsterIdx,skillID)
skillItem:SetChildActive(_skillCmp.new,false)
end
local pos=skillItem:GetChildScreenPointToLocalPointRectangle(-1)

local x=pos.x+20
local y=pos.y
local center=Vector2.one*0.5
local leftBottom=Vector2.zero
local args={
skillId=skillID,
skillLv=skillLv,
rootPoint={
anchorsMin=center,
anchorsMax=center,
pivot=leftBottom,
anchoredPosition=Vector2.New(x,y)
}
}
UIManager:showWindow('UISimpleSkillTipsWin',args)
end)
end)
self.skillView:setChildScrollRectEnable(#skillList>4)
else
self.bossModel:setChildUIModelRemoveTarget()
self.bossName:setImageIcon("",true)

end

self:refreshBossTimes()
end

function UIXianJIeFuMoMainWin:refreshBossTimes()
if XianJieFuMoController.checkStopFight()then
local info=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianJieFuMo)
self.bossTime:setText(FMT.fmt("活动将于{0}结算",timeHelper.dateServerStamp('%H:%M',info.end_time_l)))
else
local stopFightTime=XianJieFuMoController.getStopFightTime()
self.bossTime:setText(FMT.fmt("首领将于{0}离开",timeHelper.dateServerStamp('%H:%M',stopFightTime)))
end
end

function UIXianJIeFuMoMainWin:refreshTimes()
local cur=XianJieFuMoModel:getChallengedCnt()
local buy=XianJieFuMoModel:getBuyedCnt()
local free=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"free")
self.addTx:setText(FMT.fmt("挑战次数：{0}/{1}",cur,buy+free))
end

function UIXianJIeFuMoMainWin:refreshRewardReddot()
local flag=XianJieFuMoController:checkTargetReddot()
self.rewardReddot:setActive(flag)
end

function UIXianJIeFuMoMainWin:initRankTierDivisionDropdown()
self.rankTierDivisionDropdown:setChangeAction(function(...)
self:onRankTierDivisionDropdownChanged(...)
end)
self.rankTierDivisionDropdown:setDropdownCreatedAction(function(...)
self:onRankTierDivisionDropdownCreated(...)
end)

self.rankTierCfg=self:getFairyLandBossLevelCfgList()
local lvIdx=XianJieFuMoModel:getData().lvIdx;

self.optionNameList=self:getRankTierNameList(self.rankTierCfg)
self.rankTierDivisionDropdown:setOption(self.optionNameList)

self.optionIndex=lvIdx~=-1 and lvIdx-1 or 0

self.optionIndex=math.min(math.max(self.optionIndex,0),#self.optionNameList-1)
self.rankTierDivisionDropdown:setValue(self.optionIndex)
self:onRankTierDivisionDropdownChanged(self.optionIndex)
end

function UIXianJIeFuMoMainWin:getFairyLandBossLevelCfgList()
local cfgTable=cfg_fairylandbosslevelconfig()
local result={}
for _,data in pairs(cfgTable)do
local maxLv=data['2']
local limitLv=zongmenModel:getZongMenLimitLv()

repeat
if maxLv>limitLv then
break
end
table.insert(result,{
id=data.id,
minLevel=data['1'],
maxLevel=maxLv,
showStageName=data.showStageName
})
until true
end
return result
end

function UIXianJIeFuMoMainWin:getRankTierNameList(cfgTable)
local labelList={}
for _,v in pairs(cfgTable)do
table.insert(labelList,FMT.fmt("祖师榜段位 <color={1}>{0}</color>",v.showStageName,FONT_COLOR_VAL[FONT_COLOR.eOrangeColor]))
end
return labelList
end

function UIXianJIeFuMoMainWin:getRankTierID()
return(self.optionIndex~=nil and self.optionIndex>=0)and self.optionIndex+1 or 1
end

function UIXianJIeFuMoMainWin:onRankTierDivisionDropdownChanged(index)
self.optionIndex=index
local rankTierId=index+1
XianJieFuMoController.req_RankList(self.rankType,rankTierId)
end

function UIXianJIeFuMoMainWin:onRankTierDivisionDropdownCreated()
local optionCount=#self.optionNameList
for index=1,optionCount do
local item=self.rankTierDivisionDropdown:getDropdownItemWidget(index-1)
if index~=self.optionIndex+1 then
item:SetChildText(0,FMT.fmt("祖师榜段位 {0}",self.rankTierCfg[index].showStageName))
item:SetChildActive(0,true)
else
item:SetChildActive(0,false)
end

item:SetChildActive(1,index~=optionCount)
end

end