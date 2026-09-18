







def_class("UIXM_TYSCquickWin",UIWindowBase)









function UIXM_TYSCquickWin:bindComponents()

self.BattleText=UIText.get(self,0)
self.bgmodel=UIObject.get(self,1)
self.challengeAddBtn=UIButton.get(self,2)
self.challengeEffect=UIObject.get(self,3)
self.challengeNum=UIText.get(self,4)
self.changeZR=UIButton.get(self,5)
self.chanllengeroot=UIObject.get(self,6)
self.closebtn=UIButton.get(self,7)
self.Content=UIObject.get(self,8)
self.infoContent=UIObject.get(self,9)
self.infoContent2=UIObject.get(self,10)
self.infoPanel=UIObject.get(self,11)
self.introduceText=UIText.get(self,12)
self.List=UIObject.get(self,13)
self.model=UIObject.get(self,14)
self.name=UIText.get(self,15)
self.notinfo=UIObject.get(self,16)
self.quickBattle=UIButton.get(self,17)
self.quickbg=UIObject.get(self,18)
self.quickbtngray=UIObject.get(self,19)
self.quickinfo=UIObject.get(self,20)
self.quicking=UIText.get(self,21)
self.quickingNum=UIText.get(self,22)
self.quickmodel=UIObject.get(self,23)
self.root=UIObject.get(self,24)
self.ScrollerView=UIObject.get(self,25)
self.ZRbtngray=UIObject.get(self,26)

self.challengeAddBtn:setButtonClick(function()self:onChallengeAddBtn()end)

self.changeZR:setButtonClick(function()self:onChangeZR()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.quickBattle:setButtonClick(function()self:onQuickBattle()end)



end


function UIXM_TYSCquickWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.BattleText);self.BattleText=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.challengeAddBtn);self.challengeAddBtn=nil;
_UIObject_release(self.challengeEffect);self.challengeEffect=nil;
_UIObject_release(self.challengeNum);self.challengeNum=nil;
_UIObject_release(self.changeZR);self.changeZR=nil;
_UIObject_release(self.chanllengeroot);self.chanllengeroot=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.infoContent);self.infoContent=nil;
_UIObject_release(self.infoContent2);self.infoContent2=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.introduceText);self.introduceText=nil;
_UIObject_release(self.List);self.List=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.notinfo);self.notinfo=nil;
_UIObject_release(self.quickBattle);self.quickBattle=nil;
_UIObject_release(self.quickbg);self.quickbg=nil;
_UIObject_release(self.quickbtngray);self.quickbtngray=nil;
_UIObject_release(self.quickinfo);self.quickinfo=nil;
_UIObject_release(self.quicking);self.quicking=nil;
_UIObject_release(self.quickingNum);self.quickingNum=nil;
_UIObject_release(self.quickmodel);self.quickmodel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollerView);self.ScrollerView=nil;
_UIObject_release(self.ZRbtngray);self.ZRbtngray=nil;
end


















local _this

function UIXM_TYSCquickWin:onLoaded(...)
self:bindComponents()
_this=self
end
local _iconAb="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _iconBg={
[MONSTER_TYPE.eXiaoGuai]="image_gwtouxiangpjk_2",
[MONSTER_TYPE.eJingYing]="image_gwtouxiangpjk_3",
[MONSTER_TYPE.eShouLing]="image_gwtouxiangpjk_5",
}

function UIXM_TYSCquickWin:__delete()
self:unbindComponents()
_this:stopCDTick()
_this=nil
UIManager:invokeUIMethod('UIXM_TYSC_bossWin',"refreshChallengeNum")
end
local headcmp=
{
select=0,
image=1,
head=2,
shouling=3,
jingying=4,
}



function UIXM_TYSCquickWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.bgmodel:setChildUIModelShowTarget(5530,1,{},eAnimationID.enter)
self.monsterdata=argtable[1]
self.sc_level=argtable[2]
self.arg=argtable[3]


local childnum=0
self.monsterlist={}
self.allfight={}
self.before={}

self:delayDo(0.4,function()
self.root:setChildCanvasGroupDOFade(1,0.1)
end)
for k,v in pairs(self.monsterdata)do
for k2,v2 in pairs(v)do
childnum=childnum+1

self.monsterlist[#self.monsterlist+1]={monType=k,monsterId=v2[1].monsterGroupId,monstdt=v2[1]}
end
end
table.sort(self.monsterlist,function(a,b)
if a.monType==b.monType then
return a.monsterId<b.monsterId
end
return a.monType>b.monType
end)
if not self.arg then
self.selectindex=1
else
if self.arg[1]~=MONSTER_TYPE.eShouLing then
for k,v in ipairs(self.monsterlist)do
if self.arg[1]==v.monType and self.arg[2]==v.monsterId then
self.selectindex=k
end
end
else
for k,v in ipairs(self.monsterlist)do
if self.arg[1]==v.monType and self.arg[2]==v.monsterId and self.arg[3]==v.monstdt.m_id then
self.selectindex=k
end
end
end
end
self.selectMstdata=self.monsterlist[self.selectindex]
self.quickbg:setActive(false)
self.chanllengeroot:setActive(true)

self.List:setChildScrollViewCreateGrids(childnum,1)
local childGrids=self.List:getChildScrollViewItemWidgets()
for i=1,childnum do
local childItem=childGrids[i-1]
local mstdata=self.monsterlist[i]
if _iconBg[mstdata.monType]then
childItem:SetChildCSImageSprite(headcmp.image,_iconAb,_iconBg[mstdata.monType])
end
childItem:SetChildActive(headcmp.select,i==self.selectindex)
childItem:SetChildButtonClick(-1,function()
if not self:ClickEventJude()then return end
local beforeitem=childGrids[self.selectindex-1]
beforeitem:SetChildActive(headcmp.select,false)
self.selectindex=i
self.selectMstdata=mstdata

childItem:SetChildActive(headcmp.select,i==self.selectindex)
self:refreshAllRightinfo(mstdata)
self:SetRightquickinfo()
end)
childItem:SetChildActive(headcmp.shouling,mstdata.monType==MONSTER_TYPE.eShouLing)
childItem:SetChildActive(headcmp.jingying,mstdata.monType==MONSTER_TYPE.eJingYing)
comHelper.setChildModelRawImage_monsterGroup(childItem,mstdata.monsterId,2,0,eHeadCenterType.eHead)
end
self.List:setChildScrollViewSelectItem(self.selectindex-1)
self.rewardlist={}
self:refreshAllRightinfo(self.selectMstdata)
self.stage=false

_this:SetBattleText()
self.ZRbtngray:setActive(self.stage)
end




function UIXM_TYSCquickWin:onHide()

end


function UIXM_TYSCquickWin:refreshRightWin(mstdata)
if not mstdata then
mstdata=self.selectMstdata
end
local modelParams=comHelper.getMonsterGroupModelParams(mstdata.monsterId)
local monstdt=mstdata.monstdt
local size=monstdt.scale_quick
local cfg=cfgHelper.get1(cfg_monstergroup_get,mstdata.monsterId)
local name=cfg.name

self.model:setChildUIModelShowTarget(modelParams.body,size,modelParams.componets or{},eAnimationID.stand,false,false,0,nil)
self.model:setChildUIModelShowTargetOffset(monstdt.quick_x,monstdt.quick_y)
self.name:setText(name)
self.introduceText:setActive(self.selectMstdata["monType"]~=MONSTER_TYPE.eShouLing)

end

function UIXM_TYSCquickWin:onClickClose()
if not self:ClickEventJude()then
return
end
self:closeSelf()
end


function UIXM_TYSCquickWin:onClosebtn()
if not self:ClickEventJude()then
return
end
self:closeSelf()
end

function UIXM_TYSCquickWin:ClickEventJude()
if self.stage then
UIManager.info("快速挑战进行中")
return false
end
return true
end

function UIXM_TYSCquickWin:ClickEventJude2()
if self.stage then
return false
end
return true
end

function UIXM_TYSCquickWin:onChangeZR()
if not self:ClickEventJude()then
return
end
local score
local tyJiFen=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,self.sc_level,'tyJiFen')
local monsterType=self.selectMstdata["monType"]
local monsterGroupId=self.selectMstdata["monsterId"]
local m_id=self.selectMstdata.monstdt.m_id
if monsterType==MONSTER_TYPE.eXiaoGuai then
score=tyJiFen[1]
else
score=tyJiFen[2]
end
local args={}
fightModel:setSendExtraArgs(eBattleType.tianyuanshouchao,args)
xianmengController:doReqFight_TYSCquick(monsterType,monsterGroupId,m_id,score)
end
function UIXM_TYSCquickWin:refreshQuickBattle()

end

function UIXM_TYSCquickWin:onQuickBattle()
if not self:ClickEventJude2()then

_this.ZXnum=0
UIManager.info("取消快速挑战")
return
end
local lerpTiaoZhanNum=0
if self.selectMstdata["monType"]~=MONSTER_TYPE.eShouLing then
lerpTiaoZhanNum=xianmengModel:getChallengeNum1_TYSC()
else
lerpTiaoZhanNum=xianmengModel:getChallengeNum2_TYSC(self.selectMstdata.monstdt.guid)
end

if lerpTiaoZhanNum==0 then
self:onChallengeAddBtn()
return
end

if bagControl.checkShowFullEquipBagTips('无法继续挑战')then
return
end

local refresh=function(num)

local contentStr=FMT.fmt("是否消耗<color=#549327FF>{0}</color>次进行快速挑战？",num)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=lerpTiaoZhanNum,
defaultCnt=lerpTiaoZhanNum,

oktext='确定',
canceltext='取消',
okcallback=function(num)
local monType=self.selectMstdata["monType"]
if monType==MONSTER_TYPE.eShouLing then
local monsterGroupId=self.selectMstdata["monsterId"]
local m_id=self.selectMstdata.monstdt.m_id
local monster_=xianmengModel:getMonsterByIndex_TYSC(monType,m_id)
local slGuild=monster_.guid
if not xianmengController:canFightBoss2_TYSC(slGuild,true)then
return
end
end
UIManager.info("开始挑战")
self:quicktimer(num)
end,

}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()


end



function UIXM_TYSCquickWin:quicktimer(allnum)
_this.ZXnum=allnum
local nownum=0
self.continueData=xianmengController:getContinueData_TYSC()
local teamList=fightPreSelectModel:getTeamData(fightPreSelectModel.fightType.tianyuanshouchao)
if not teamList then
UIManager.info("请先设置挑战阵容")
self:onChangeZR()
return
end

self.stage=true
self:startCDTick()




_this:SetBattleText()
self.ZRbtngray:setActive(self.stage)

self.quickbg:setActive(true)
self.chanllengeroot:setActive(false)
self.quickmodel:setChildUIModelShowTarget(5531,1,{},eAnimationID.stand)
self.quickingNum:setText(string.format("%d/%d",0,_this.ZXnum))
local monsterGroupId=self.selectMstdata["monsterId"]
local monsterList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local winArgs=
{
enterTxt="天渊兽潮",
cancelCallBack=function()
fightController:closeSelectStage()
xianmengController:finishFightOpen_TYSC()
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,
closeByCloud=true,
closeByCloudDelay=0.5,
sureBodyid=2068,
}
local mapId=winArgs.mapId
if winArgs.groupId then
mapId=cfgHelper.get2(cfg_monstergroup_get,winArgs.groupId,"mapId")
end
local monType=self.selectMstdata["monType"]
local monsterGroupId=self.selectMstdata["monsterId"]
local m_id=self.selectMstdata.monstdt.m_id
local gwzId=monsterGroupId
local monster_=xianmengModel:getMonsterByIndex_TYSC(monType,m_id)

local check=monster_~=nil
if check then
local guid_=monster_.guid

local zfId=fightPreSelectModel:getZhenFaData(fightPreSelectModel.fightType.tianyuanshouchao)
local team={}
for i=1,fightPreSelectModel.maxPosNum do
if teamList[i]then
team[i]={1,teamList[i]}
else
team[i]={0,int64.zero}
end
end

local func=function(data)
if not _this then return end
if not data then

_this:delayDo(0.7,function()
_this.challengeEffect:setChildShowEffect(10522,true)
end)
_this:delayDo(1.7,function()
_this.stage=false


_this:SetBattleText()
_this.ZRbtngray:setActive(_this.stage)
_this.quickbg:setActive(false)
_this.chanllengeroot:setActive(true)
end)
_this:stopCDTick()
return
end

if not _this.allfight[_this.selectindex]then
_this.allfight[_this.selectindex]={}
_this.before[_this.selectindex]={}
end
_this.before[_this.selectindex]=#_this.allfight[_this.selectindex]
_this.allfight[_this.selectindex][#_this.allfight[_this.selectindex]+1]=data


_this:delayDo(0.5,function()
local rewards=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eTianYuanShouChao,'getRewardList')
if not _this.rewardlist[_this.selectindex]then
_this.rewardlist[_this.selectindex]={}
end
_this.rewardlist[_this.selectindex][#_this.rewardlist[_this.selectindex]+1]={}
if#rewards>0 then
for i,v in ipairs(rewards)do
local itemConfig=itemsConfig.getConfig(v.itemid)
table.insert(_this.rewardlist[_this.selectindex][#_this.rewardlist[_this.selectindex]],{v.itemid,v.num,itemConfig.color,v.itemguid})
end
end
local num=#_this.rewardlist
if num>1 then
table.sort(_this.rewardlist[_this.selectindex][#_this.rewardlist[_this.selectindex]],function(a,b)
return a[3]>b[3]
end)
end
_this:SetRightquickinfo()
local monster_=xianmengModel:getMonsterByIndex_TYSC(monType,m_id)

local check=monster_~=nil
if check then
_this.ZXnum=_this.ZXnum-1
else
_this.ZXnum=0
if monType==MONSTER_TYPE.eShouLing then
UIManager.error('该首领已被盟友消灭')
end
end

if _this.ZXnum>0 then
nownum=nownum+1
if nownum>allnum then
nownum=allnum
end
_this.quickingNum:setText(string.format("%d/%d",nownum,allnum))
_this.quciktimer=0
fightLaunchController:sendFight(eBattleLaunch.tianyuanshouchao,team,mapId,zfId,{monType,gwzId,guid_})
else
nownum=nownum+1
if nownum>allnum then
nownum=allnum
end
_this.quickingNum:setText(string.format("%d/%d",nownum,allnum))
_this:delayDo(0.7,function()
_this.challengeEffect:setChildShowEffect(10522,true)
end)
_this:delayDo(1.7,function()
_this.stage=false


_this:SetBattleText()
_this.ZRbtngray:setActive(_this.stage)
_this.quickbg:setActive(false)
_this.chanllengeroot:setActive(true)
end)
_this:stopCDTick()
end
end)

end
local args={quickCallback=func}
fightModel:setSendExtraArgs(eBattleType.tianyuanshouchao,args)

fightLaunchController:sendFight(eBattleLaunch.tianyuanshouchao,team,mapId,zfId,{monType,gwzId,guid_})
end
end

function UIXM_TYSCquickWin:dealBOSSisDie(guid)
if self.selectMstdata and self.selectMstdata.monstdt and self.selectMstdata.monstdt.guid and self.selectMstdata.monstdt.guid==guid then
_this:delayDo(0.7,function()
_this.challengeEffect:setChildShowEffect(10522,true)
end)
_this:delayDo(1.7,function()
_this.stage=false


_this:SetBattleText()
_this.ZRbtngray:setActive(_this.stage)
_this.quickbg:setActive(false)
_this.chanllengeroot:setActive(true)
end)
_this:stopCDTick()
end

end

function UIXM_TYSCquickWin:refreshAllRightinfo(mstdata)
self:refreshRightWin(mstdata)
self:SetRightquickinfo()
end
local itemcmp=
{
infocontent=0,
lunci=1,
killnum=2,
yaoponum=3,
jifen=4,
hurtnum=5,
hp=6,
monsterroot=7,
bossroot=8,
quickScrollview=9,
info=10,
effect=11,
}



function UIXM_TYSCquickWin:SetRightquickinfo()
if self.selectMstdata["monType"]~=MONSTER_TYPE.eShouLing then
local num=xianmengModel:getChallengeNum1_TYSC()
local num_str=FMT.fmt('{0}',num)
self.challengeNum:setText(num_str)
else
local num=xianmengModel:getChallengeNum2_TYSC(self.selectMstdata.monstdt.guid)
local num_str=FMT.fmt('{0}',num)
self.challengeNum:setText(num_str)
end

if not self.allfight then
self.allfight={}
end

local infonum=self.allfight[self.selectindex]and#self.allfight[self.selectindex]or 0
self.notinfo:setActive(infonum<=0)

self.ScrollerView:setChildScrollViewCreateGrids(infonum,1)
local grids=self.ScrollerView:getChildScrollViewItemWidgets()
for i=1,infonum do
local childItem=grids[i-1]
self:refreshScrollviewdata(childItem,i)
if i>self.before[self.selectindex]then
childItem:SetChildCanvasGroupAlpha(itemcmp.info,0)
childItem:SetChildCanvasGroupDOFade(itemcmp.info,1,0.4)
else
childItem:SetChildCanvasGroupAlpha(itemcmp.info,1)
end

end
if infonum<=0 then
return
end
self.ScrollerView:setChildScrollViewSelectItem(infonum-1)
local lastchildItem=grids[infonum-1]
lastchildItem:SetChildShowEffect(itemcmp.effect,20442,true)

end

function UIXM_TYSCquickWin:refreshScrollviewdata(childItem,index)

local data=self.allfight[self.selectindex][index][1]
local killNum=data.killNumSrc
local yaohun=data.yaohun
local tyJiFen=data.tyJiFen
local slGuild=data.slGuild

local rewardlist=self.rewardlist[self.selectindex][index]
local desc1_str,desc2_str,desc3_str
local isBoss=false

if mathHelper.validInt64(slGuild)then
isBoss=true

local hurt=data.hurt/100
local hpPercent=data.hp/100
desc1_str=FMT.fmt('伤害：<color=#ffcc73>{0}%</color>',hurt)
desc2_str=FMT.fmt('剩余血量：<color=#ffcc73>{0}%</color>',hpPercent)
childItem:SetChildText(itemcmp.hurtnum,desc1_str)
childItem:SetChildText(itemcmp.hp,desc2_str)

else
desc1_str=FMT.fmt('击杀数：<color=#ffcc73>{0}</color>',killNum)
desc2_str=FMT.fmt('妖魂：<color=#ffcc73>{0}</color>',yaohun)
desc3_str=FMT.fmt('天渊积分：<color=#ffcc73>{0}</color>',tyJiFen)
childItem:SetChildText(itemcmp.killnum,desc1_str)
childItem:SetChildText(itemcmp.yaoponum,desc2_str)
childItem:SetChildText(itemcmp.jifen,desc3_str)
end
childItem:SetChildActive(itemcmp.monsterroot,not mathHelper.validInt64(slGuild))
childItem:SetChildActive(itemcmp.bossroot,mathHelper.validInt64(slGuild))
childItem:SetChildText(itemcmp.lunci,string.format("<color=#fff283>第%d次</color>",index))
self.introduceText:setActive(not mathHelper.validInt64(slGuild))


childItem:SetChildLayoutGroupCreateItems(itemcmp.infocontent,#rewardlist)
local grids=childItem:GetChildLayoutGroupGridList(itemcmp.infocontent)
childItem:SetChildScrollRectEnable(itemcmp.quickScrollview,#rewardlist>6)

for i=1,#rewardlist do
local item=grids[i-1]
local reward=rewardlist[i]
local itemid=reward[1]
local itemNum=reward[2]
local itemguid=reward[4]
local itemcount,showCountBG
if itemNum>1 then
itemcount=tostring(itemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,itemguid=itemguid,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
local suitIcon=equipsHelper.getSuitIconByArgs(itemguid,itemid)
local subItem=item:GetChildWidgetBase(0)
if subItem then
subItem:SetChildIcon(10,suitIcon,false)
end
end


end

function UIXM_TYSCquickWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end


function UIXM_TYSCquickWin:onChallengeAddBtn()
if not self:ClickEventJude()then
return
end
if self.selectMstdata["monType"]~=MONSTER_TYPE.eShouLing then
self:onChallengeAdd_notBOSS(true)
else
self:onChallengeAdd_isboss(true)
end
end

function UIXM_TYSCquickWin:onChallengeAdd_notBOSS(isWarning)
local shouchaoNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shouchaoNum')
local maxBuyNum=shouchaoNum[2]
local curBuyNum=xianmengModel:getChallengeBuyNum1_TYSC()
local lerpBuyNum=maxBuyNum-curBuyNum
if lerpBuyNum<=0 then
if isWarning then
UIManager.error('购买次数已用完')
end
return false
end

local costItemID=shouchaoNum[3]
local costNumList=shouchaoNum[4]
local getCostNum=function(num)
local costItemNum=0
for curBuyLevel=curBuyNum+1,curBuyNum+num do
local n=costNumList[curBuyLevel]
if n==nil then
n=costNumList[#costNumList]
end
costItemNum=costItemNum+n
end
return costItemNum
end
local refresh=function(num)
local itemNum=getCostNum(num)
local have=itemsModel.getCount(costItemID)
local colorStr=have>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costItemID)
local costStr=FMT.fmt("quad-icon={2}-quad <color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
local contentStr=FMT.fmt('是否花费{0}购买兽潮挑战次数，\n并自动开始快速挑战？',costStr)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=lerpBuyNum,
tips=FMT.fmt("（剩余购买次数：{0}）",lerpBuyNum),
oktext='购买',
canceltext='取消',
okcallback=function(num)
if _this==nil then return end
local itemNum=getCostNum(num)
local func=function()
xianmengController:send_248_14(num)
end
moneySystem:useMoney(costItemID,itemNum,func,WARNING_TYPE.eWarning)
end,
moneytypes={{costItemID},},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return true
end



function UIXM_TYSCquickWin:onChallengeAdd_isboss(isWarning)
local monType=self.selectMstdata["monType"]
local monsterGroupId=self.selectMstdata["monsterId"]
local m_id=self.selectMstdata.monstdt.m_id
local monster_=xianmengModel:getMonsterByIndex_TYSC(monType,m_id)
local slGuild=monster_.guid
local shoulingNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shoulingNum')
local maxBuyNum=shoulingNum[2]
local curBuyNum=xianmengModel:getChallengeBuyNum2_TYSC(slGuild)
local lerpBuyNum=maxBuyNum-curBuyNum
if lerpBuyNum<=0 then
if isWarning then
UIManager.error('购买次数已用完')
end
return
end

local costItemID=shoulingNum[3]
local costNumList=shoulingNum[4]
local getCostNum=function(num)
local costItemNum=0
for curBuyLevel=curBuyNum+1,curBuyNum+num do
local n=costNumList[curBuyLevel]
if n==nil then
n=costNumList[#costNumList]
end
costItemNum=costItemNum+n
end
return costItemNum
end

local refresh=function(num)
local itemNum=getCostNum(num)
local have=itemsModel.getCount(costItemID)
local colorStr=have>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costItemID)
local costStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
local contentStr=FMT.fmt('是否花费{0}购买首领挑战次数,\n并自动开始快速挑战？',costStr)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=lerpBuyNum,
tips=FMT.fmt("（剩余购买次数：{0}）",lerpBuyNum),
oktext='购买',
canceltext='取消',
okcallback=function(num)
if _this==nil then return end
if not xianmengController:canFightBoss2_TYSC(slGuild,true)then
_this:closeSelf()
return
end
local itemNum=getCostNum(num)
local func=function()
xianmengController:setBuyFightData_TYSC(nil)
xianmengController:send_248_15(slGuild,num)
end
moneySystem:useMoney(costItemID,itemNum,func,WARNING_TYPE.eWarning)
end,
moneytypes={{costItemID},},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return true
end


function UIXM_TYSCquickWin:stopCDTick()
if self.quickid then
self:stopTimerByID(self.quickid)
self.quickid=nil
end
end

function UIXM_TYSCquickWin:startCDTick()
self.quciktimer=0
if not self.quickid then
self.quickid=self:setTimer(1,0,function()
self.quciktimer=self.quciktimer+1
if self.quciktimer>=10 then
_this:delayDo(0.7,function()
_this.challengeEffect:setChildShowEffect(10522,true)
end)
_this:delayDo(1.7,function()
_this.stage=false


_this:SetBattleText()
_this.ZRbtngray:setActive(_this.stage)
_this.quickbg:setActive(false)
_this.chanllengeroot:setActive(true)
end)
_this:stopCDTick()
end
end)
end

end


function UIXM_TYSCquickWin:SetBattleText()
if _this.stage then
_this.BattleText:setText("取消挑战")
else
_this.BattleText:setText("快速挑战")
end
end




