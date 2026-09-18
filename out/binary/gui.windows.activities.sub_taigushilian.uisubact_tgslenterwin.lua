







def_class("UISubAct_tgslEnterWin",UIWindowBase)









function UISubAct_tgslEnterWin:bindComponents()

self.background=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.source=UIObject.get(self,3)
self.shareBtn=UIButton.get(self,4)
self.buttonBg1=UIObject.get(self,5)
self.settingBtn=UIButton.get(self,6)
self.costBg=UIObject.get(self,7)
self.fightNum=UIText.get(self,8)
self.fightBtn=UIButton.get(self,9)
self.rankBtn=UIButton.get(self,10)
self.monsterType=UIImage.get(self,11)
self.moneyBg=UIButton.get(self,12)
self.leastTime=UIText.get(self,13)
self.progressBar=UIProgress.get(self,14)
self.model=UIObject.get(self,15)
self.skillList=UIObject.get(self,16)
self.closeBtn=UIButton.get(self,17)
self.fightPeople=UIText.get(self,18)
self.buttonBg2=UIObject.get(self,19)
self.sourceHead=UIObject.get(self,20)
self.sourceName=UIText.get(self,21)
self.costIcon=UIImage.get(self,22)
self.costNum=UIText.get(self,23)
self.moneyNum=UIText.get(self,24)
self.moneyIcon=UIImage.get(self,25)
self.moneyAdd=UIButton.get(self,26)
self.rewardList=UIObject.get(self,27)
self.nameTx=UIText.get(self,28)
self.shuomingpanel=UIObject.get(self,29)
self.jianlipanel=UIObject.get(self,30)
self.xiangqingtxt=UIText.get(self,31)
self.shuomingtxt=UIText.get(self,32)
self.item1=UIObject.get(self,33)
self.item2=UIObject.get(self,34)
self.item3=UIObject.get(self,35)
self.item4=UIObject.get(self,36)
self.item5=UIObject.get(self,37)
self.damagetxt=UIText.get(self,38)
self.fighttxt=UIText.get(self,39)
self.diziitem1=UIObject.get(self,40)
self.diziitem2=UIObject.get(self,41)
self.diziitem3=UIObject.get(self,42)
self.yunyintxt=UIText.get(self,43)
self.fbreddot=UIObject.get(self,44)
self.guinfopanel=UIObject.get(self,45)
self.xianqingpanel=UIObject.get(self,46)
self.gwtxt=UIText.get(self,47)

self.background:setButtonClick(function()self:onBackground()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.settingBtn:setButtonClick(function()self:onSettingBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.moneyAdd:setButtonClick(function()self:onMoneyAdd()end)



end


function UISubAct_tgslEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.source);self.source=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.buttonBg1);self.buttonBg1=nil;
_UIObject_release(self.settingBtn);self.settingBtn=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.fightNum);self.fightNum=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.monsterType);self.monsterType=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.leastTime);self.leastTime=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.fightPeople);self.fightPeople=nil;
_UIObject_release(self.buttonBg2);self.buttonBg2=nil;
_UIObject_release(self.sourceHead);self.sourceHead=nil;
_UIObject_release(self.sourceName);self.sourceName=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyAdd);self.moneyAdd=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.shuomingpanel);self.shuomingpanel=nil;
_UIObject_release(self.jianlipanel);self.jianlipanel=nil;
_UIObject_release(self.xiangqingtxt);self.xiangqingtxt=nil;
_UIObject_release(self.shuomingtxt);self.shuomingtxt=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.damagetxt);self.damagetxt=nil;
_UIObject_release(self.fighttxt);self.fighttxt=nil;
_UIObject_release(self.diziitem1);self.diziitem1=nil;
_UIObject_release(self.diziitem2);self.diziitem2=nil;
_UIObject_release(self.diziitem3);self.diziitem3=nil;
_UIObject_release(self.yunyintxt);self.yunyintxt=nil;
_UIObject_release(self.fbreddot);self.fbreddot=nil;
_UIObject_release(self.guinfopanel);self.guinfopanel=nil;
_UIObject_release(self.xianqingpanel);self.xianqingpanel=nil;
_UIObject_release(self.gwtxt);self.gwtxt=nil;
end
















local _this=nil
local abname='ui/windows/activities/sub_taigushilian/taigushilian_atlas_pak.ab'
local tefighttype=8



function UISubAct_tgslEnterWin:onLoaded(...)
self:bindComponents()
_this=self
self.ndperfab={self.item1,self.item2,self.item3,self.item4,self.item5,}
self.diziperfab={self.diziitem1,self.diziitem2,self.diziitem3,}
end


function UISubAct_tgslEnterWin:__delete()
self:unbindComponents()
_this=nil

end




function UISubAct_tgslEnterWin:onShow(argtable,afterOnloaded)
if argtable then
self.actId=argtable[1]
self.subType=argtable[2]
self.subId=argtable[3]
self.bossid=argtable[4]or 1


self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)

self.bossData=self.config.boss[self.bossid]
self.cfg_nandu_list=self.bossData[1]or{}
self.guankaIdx=1

local len=activitiesHandle_taiguBoss:getBossTongGuangIdx(self.actId,self.subType,self.subId,self.bossid)
if len>0 then
local damagevalue=activitiesHandle_taiguBoss:getBossJieDuanDamageValue(self.actId,self.subType,self.subId,self.bossid,len)

if damagevalue<0 then
self.guankaIdx=len+1
else
self.guankaIdx=len
end
end
self.monster=self.bossData[1][self.guankaIdx][1][1]

self.bgModel:setChildUIModelShowTarget(4922,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(0.4,function()
self.root:setChildCanvasGroupAlpha(1)
self.canClose=true
end)
end)
UISubAct_tgslEnterWin:initShouLingData()
local red=activitiesHandle_taiguBoss:checkIsNewBoss(self.actId,self.subType,self.subId,self.bossid)
self.fbreddot:setActive(red)
self:needLg()
end
end

function UISubAct_tgslEnterWin:onHide()

end


function UISubAct_tgslEnterWin:initShouLingData()

local lhidx=_this.bossData[4]
if lhidx==0 then
_this.guinfopanel:setActive(true)
_this.xianqingpanel:setActive(false)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,_this.monster)
_this.gwtxt:setText(monsterCfg.desc or"")
else
local cfg_dizifaze=cfg_tsdzfzconfig_get(tefighttype)[lhidx]
if cfg_dizifaze.tm then
_this.guinfopanel:setActive(false)
_this.xianqingpanel:setActive(true)
local diziList=cfg_dizifaze.diziList
local alldata=cfg_dizifaze.tm
local tm=alldata[2]
local diziList_id={}
for k,v in pairs(diziList)do
if k then
diziList_id[#diziList_id+1]=k
end
end
local disciplesList=discipleLookup:getSortDiscipleList()
local templist={}
for k,v in ipairs(diziList_id)do
templist[#templist+1]={nil,v,0,0,0}
end
for k,v in ipairs(disciplesList)do
local netdata=v.netData
local guid=netdata.net.discipleguid
local netData=UIDiscipleModel:getDiscipleData(guid)
local diziid=netData.id
for i,j in ipairs(templist)do
if diziid==j[2]then
local limitlvl_idx=#tm
for m,n in ipairs(tm)do
if netData.tmlv<=n then
limitlvl_idx=m
break
end
end
templist[i]={guid,diziid,netData.tmlv,limitlvl_idx,100}
end
end
end


table.sort(templist,function(a,b)
if a[4]==b[4]then
return a[3]>b[3]
else
return a[4]>b[4]
end
end)
local maxfaze_idx=1
local maxfaze_dizi_name
for k,v in ipairs(templist)do
if maxfaze_idx==nil then
maxfaze_idx=v[4]
end
if v[4]>maxfaze_idx then
maxfaze_idx=v[4]
end
end
for i,j in ipairs(_this.diziperfab)do
local widget=j:getWidgetBase()
local dizidatalist=templist[i]
if dizidatalist then
widget:SetChildActive(-1,true)
if dizidatalist[1]then

local diziid=dizidatalist[2]
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(diziid)
local imageInfo=dizidata.imageInfo
local tmdazelevel=dizidatalist[4]
comHelper.setChildModelHeadIconBGByColor(widget,0,imageInfo.color)
comHelper.setChildModelRawImageByDiziId(widget,diziid,1,0,eHeadCenterType.eHead,nil,false)
local strname=FMT.fmt("<color=#59412d>{0}</color>",dizidata.disciplename)
widget:SetChildText(5,strname)
if maxfaze_idx==tmdazelevel then
widget:SetChildActive(8,true)
maxfaze_dizi_name=dizidata.disciplename
end

local tmlv=dizidatalist[3]
local chong=UIDiscipleModel.getTianMingLevelChong(tmlv)
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
widget:SetChildLayoutGroupCreateItems(7,chong)
local tmGrids=widget:GetChildLayoutGroupGridList(7)
for i=1,chong do
local fireItem=tmGrids[i-1]
fireItem:SetChildCSImageSprite(0,abName,iconName)
end
widget:SetChildButtonClick(9,function()

local tabType=FULL_TAB_TYPE.eDiscipleInfo
local _subType=_this.subType
local _subId=_this.subId
local _bossid
UIFullCommonControl:jumpDiscipleMain(dizidatalist[1],tabType,function()
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(_subType,_subId)
if#sub_actList>0 then
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=_subType,subid=_subId,extraParams={isopentiaozhan=true,jumpbossid=_bossid}}},function()
jumpManager:clearJump()
end)
else
UIManager.error("活动已结束")
return UIFullDiscipleMainControl:closeUI()
end
end)
end)
else

local diziid=dizidatalist[2]
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(diziid)
local imageInfo=dizidata.imageInfo
comHelper.setChildModelHeadIconBGByColor(widget,0,imageInfo.color)
comHelper.setChildModelRawImageByDiziId(widget,diziid,1,0,eHeadCenterType.eHead,nil,true)
local strname=FMT.fmt("<color=#65615f>{0}</color>",dizidata.disciplename)
widget:SetChildText(5,strname)
widget:SetChildImageExGray(0,true)
if maxfaze_idx==1 then
widget:SetChildActive(8,true)
maxfaze_dizi_name=dizidata.disciplename
end
widget:SetChildActive(8,false)
widget:SetChildButtonClick(9,function()

local dizidaoju=cfg_taigushilianconfig_get(_this.subId).dizidaoju
if dizidaoju[diziid]then
gainControl:showGainWin(dizidaoju[diziid])
end
end)
end
else
widget:SetChildActive(-1,false)
end
end
else
_this.guinfopanel:setActive(true)
_this.xianqingpanel:setActive(false)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,_this.monster)
_this.gwtxt:setText(monsterCfg.desc or"")
end
end

_this:refreshShouLingData()
end


function UISubAct_tgslEnterWin:refreshShouLingData()

_this.monster=_this.bossData[1][_this.guankaIdx][1][1]
local bossmonlv=_this.bossData[1][_this.guankaIdx][2]
_this.monsterCfg=cfgHelper.get1(cfg_monstergroup_get,_this.monster)
_this.monType=_this.monsterCfg.monType
local modelParams=comHelper.getMonsterGroupModelParams(_this.monster)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,14)
_this.model:setChildUIModelShowTarget(modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
_this.model:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])
local abName=globalABLookup.global
local assetName=monTypeTagA[_this.monType]
if assetName then
_this.monsterType:setSprite(abName,assetName)
else
_this.monsterType:setImageIcon("",false)
end
_this.nameTx:setText(_this.monsterCfg.name)


local mosterId=_this.monsterCfg.monList[4]
local mcfg=cfgHelper.get1(cfg_monsterconfig_get,mosterId)
local level=mcfg.level

local severmonlv=activitiesHandle_taiguBoss:getMonlv(_this.actId,_this.subType,_this.subId)
if severmonlv and severmonlv>0 and bossmonlv then
level=severmonlv+bossmonlv
end

local n,p,pN=UIDiscipleModel:getJJNameX(level)

local jj_str=''
if p~=nil then
jj_str=FMT.fmt('境界：{0}{1}',n,pN)
else
jj_str=FMT.fmt('境界：{0}',n)
end
_this.yunyintxt:setText(jj_str)


local nanduarry=_this.config.nanduArry or{}
for k,v in ipairs(_this.ndperfab)do
local wedigt=v:getWidgetBase()
if _this.cfg_nandu_list[k]then
wedigt:SetChildActive(1,true)
local chenghao=nanduarry[k]

wedigt:SetChildText(2,chenghao)

if k==1 then
wedigt:SetChildActive(5,false)
else

local last_pass=activitiesHandle_taiguBoss:checkBossNanDuPass(_this.actId,_this.subType,_this.subId,_this.bossid,k-1)
if last_pass and last_pass<0 then

wedigt:SetChildActive(5,false)
else
wedigt:SetChildActive(5,true)
end
end

if _this.guankaIdx==k then
wedigt:SetChildCSImageSprite(1,abname,'button_shilianboss_1')
else
wedigt:SetChildCSImageSprite(1,abname,'button_shilianboss_2')
end
else
wedigt:SetChildActive(0,false)
end
wedigt:SetChildButtonClick(4,function()
if _this==nil then return end
_this:nanduOnClick(k)
end)
end


if _this.guankaIdx<#_this.cfg_nandu_list then
_this.shuomingpanel:setActive(false)
_this.jianlipanel:setActive(true)
local rewards={}
if _this.monsterCfg.drops and _this.monsterCfg.drops[1]then
local boss_level=_this.cfg_nandu_list[_this.guankaIdx][2]or 1
rewards=worldFightModel:getMonsterShowAwardsEx2({_this.monsterCfg.drops[1]},boss_level)
end
_this.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=_this.rewardList:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local showCountBG=data.range~=nil or data[2]>1
local countStr=data[2]>1 and data[2]or""
local conf={itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,range=data.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildActive(1,data[2]==-1)
end)
else

_this.shuomingpanel:setActive(true)
_this.jianlipanel:setActive(false)
_this.shuomingtxt:setText("祖师可以反复挑战无限难度首领，提升最高伤害，获取伤害阶段奖励，夺取排名")
end




local skillList={}
skillList=_this.config.texing[_this.monster]or{}
_this.skillCnt=#skillList
_this.skillList:setChildLayoutGroupCreateItems(_this.skillCnt,function(index)
local item=_this.skillList:getChildLayoutGroupGridItem(index-1)

local skillType
local skillIndex
local iconName=""
local skillParam=skillList[index]
if skillParam then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillParam)
iconName=iconHelper.getSkillIcon(skillCfg.icon)
else
loggerUtil.logWarnFMT("太古试炼怪物无效怪物特性:{0},{1},{2}",_this.monster,skillType,skillIndex)
end
item:SetChildCSImageIcon(-1,iconName,false)
item:SetChildButtonClick(-1,function()
_this:onClickSkill(index)
end)
end)


local damage=activitiesHandle_taiguBoss:checkBossNanDuPass(_this.actId,_this.subType,_this.subId,_this.bossid,_this.guankaIdx)
if _this.guankaIdx<#_this.cfg_nandu_list then
if damage and damage<0 then

_this.fightBtn:setActive(false)
_this.fighttxt:setActive(true)
else

_this.fightBtn:setActive(true)
_this.fighttxt:setActive(false)
end
if damage then
local strnum=mathHelper.formatNumber(math.abs(damage))
_this.damagetxt:setText(FMT.fmt("最高伤害：{0}",strnum))
else
_this.damagetxt:setText('尚未挑战，暂无积分')
end
else

_this.fightBtn:setActive(true)
_this.fighttxt:setActive(false)
if damage and math.abs(damage)>0 then
local strnum=mathHelper.formatNumber(math.abs(damage))
_this.damagetxt:setText(FMT.fmt("最高伤害：{0}",strnum))
else
_this.damagetxt:setText('尚未挑战，暂无积分')
end
end
end


function UISubAct_tgslEnterWin:nanduOnClick(idx)
if _this.guankaIdx==idx then
return
end
if idx>1 then
local last_pass=activitiesHandle_taiguBoss:checkBossNanDuPass(_this.actId,_this.subType,_this.subId,_this.bossid,idx-1)
if last_pass and last_pass<0 then
else
UIManager.error('请先挑战上一个难度并且通关')
return
end
end
local lastidx=_this.guankaIdx
_this.guankaIdx=idx


_this:refreshShouLingData()

local last_wedigt=_this.ndperfab[lastidx]:getWidgetBase()

last_wedigt:SetChildCSImageSprite(1,abname,'button_shilianboss_2')

local wedigt=_this.ndperfab[_this.guankaIdx]:getWidgetBase()

wedigt:SetChildCSImageSprite(1,abname,'button_shilianboss_1')
end


function UISubAct_tgslEnterWin:onClickSkill(index)
local startdayidx=activitiesHandle_taiguBoss:getSubOpenDayIndex(_this.actId,_this.subType,_this.subId)
local fazedata=_this.config.faze[startdayidx]
local skillList={}
skillList=_this.config.texing[_this.monster]or{}

local x=-146+78*(index-(_this.skillCnt/2+0.5))
local txInfo=skillList[index]

local txType
local txIndex
local name,icon,desc,bottomLeft
























local skillParam=skillList[index]
if skillParam then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillParam)
name=skillCfg.name
icon=iconHelper.getSkillIcon(skillCfg.icon)
else
loggerUtil.logWarnFMT("太古试炼怪物无效怪物特性:{0},{1},{2}",_this.monster)
end
desc=skillModel:getSkillDesc(skillParam,1)
local halfVector=Vector2.right*0.5
local args={
name=name,
icon=icon,
desc=desc,
bottomLeft=nil,
rootPoint={
anchorsMin=halfVector,
anchorsMax=halfVector,
pivot=halfVector,
anchoredPosition=Vector2.New(x,245),
}
}
UISubAct_tgslEnterWin:showWindow('UISimpleTeXingTipsWin',args)
end


function UISubAct_tgslEnterWin:onBackground()
if _this.canClose then
self:closeSelf()
end
end


function UISubAct_tgslEnterWin:onFightBtn()
local mosterGroupId=_this.monster
local mcfg=cfgHelper.get(cfg_monstergroup_get,mosterGroupId)
local _actid=_this.actId
local _subType=_this.subType
local _subId=_this.subId
local _bossid=_this.bossid
local _guankaIdx=_this.guankaIdx


local lhidx=self.bossData[4]
local tmlist,tmidx,lglist,lgalllevel
local ctlist,ctalllevel
if lhidx~=0 then
local cfg_dizifaze=cfg_tsdzfzconfig_get(tefighttype)[lhidx]
if cfg_dizifaze.tm then
local diziList=cfg_dizifaze.diziList
local alldata=cfg_dizifaze.tm
local tm=alldata[2]
local diziList_id={}
for k,v in pairs(diziList)do
if k then
diziList_id[#diziList_id+1]=k
end
end
tmlist,tmidx=self:Getspecialfaze(diziList_id,tm)
elseif cfg_dizifaze.lg then
local alldata=cfg_dizifaze.lg
local lg=alldata[2]
lglist,lgalllevel=self:GetspecialLGfaze(lg)

elseif cfg_dizifaze.ct then
local alldata=cfg_dizifaze.ct
local ct=alldata[2]
ctlist,ctalllevel=self:GetspecialCTfaze(ct)

end
end
local teamData={}
local multipleMonsterList={}
for k,v in ipairs(self.bossData[1][self.guankaIdx][1])do
teamData[#teamData+1]={}
local mcfg_=cfgHelper.get(cfg_monstergroup_get,v)
multipleMonsterList[#multipleMonsterList+1]=mcfg_.monList
end
local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.taigushilian,#teamData)

local arge=
{
specialfaze_fuyao_templist=tmlist or nil,
specialfaze_fuyao_fazeidx=tmidx or nil,

lg_fuyao_templist=lglist or nil,
lg_fuyao_alllevel=lgalllevel or nil,

ct_fuyao_templist=ctlist or nil,
ct_fuyao_alllevel=ctalllevel or nil,
}

local dzlist=self:needLgdz()
local lgbg,lgiconlist,lgid=self:needLg()
local defTeamLingGenLimitlist={}
if lgiconlist then
for k,v in ipairs(lgiconlist)do
defTeamLingGenLimitlist[#defTeamLingGenLimitlist+1]={lgbg,v}
end
end
if lgid then
teamData=fightPreSelectModel:getMulTeamSaveDataByLinggen(eFightPreSelectType.taigushilian,lgid)
end


local winArgs=
{
enterTxt="返回",
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
multipleTeams=teamData,
defTeamLingGenLimitlist=#defTeamLingGenLimitlist>0 and defTeamLingGenLimitlist or nil,
linggen=lgid,
isHomeBattle=false,
showZhenFa=false,
editorTeam=false,

groupId=mosterGroupId,
multipleMonsterList=multipleMonsterList,

lockSelectList=dzlist,
isSortByTeamSelect=true,


fuyao_datas=arge,

cancelCallBack=function()
UIManager:closeWindow('UISubAct_fyslFightExtraWin')

jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=_subType,subid=_subId}},function()
jumpManager:clearJump()
end)

end,
enterCallBack=function(guidList,zfId)
UIManager:closeWindow('UISubAct_fyslFightExtraWin')
local info=activitiesModel:getSubActInfo(_actid,_subType,_subId)
if not info then
UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end



fightLaunchController:sendFightEx(eBattleLaunch.taigushilian,guidList,
{_actid,_subType,_subId,_bossid,_guankaIdx})


end,

}


fightController.showPrepareWin(fightPreSelectModel.fightType.taigushilian,winArgs,function(...)
UIManager:showWindow('UISubAct_fyslFightExtraWin',{_actid,_subType,_subId,_bossid,tmlist,tmidx,2})
end)
end

function UISubAct_tgslEnterWin:needLgdz()

local allData=UIDiscipleModel:getAllDiscipleData()
local dzlist={}
local needlg=self.bossData[8]
if not needlg then
return
end
for a,b in ipairs(needlg)do
dzlist[a]={}
for k,v in pairs(allData)do
local dzguid=v.netData.net.discipleguid
for c,d in ipairs(b)do
if UIDiscipleModel:getDiscipleSpecialityByID(dzguid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,d)then
dzlist[a][#dzlist[a]+1]=dzguid
end
end
end
end
return dzlist
end


function UISubAct_tgslEnterWin:needLg()
local needlg=self.bossData[8]
local prepareLgSprite=self.config.prepareLgSprite
if not needlg then
return
end

local lgbgParam=prepareLgSprite[0]
local lgParamlist={}
for a,b in ipairs(needlg)do
lgParamlist[a]=prepareLgSprite[b[1]]
end

return lgbgParam,lgParamlist,needlg[1][1]
end


function UISubAct_tgslEnterWin:Getspecialfaze(diziList_id,tmlist)
local getlist=diziList_id
local tm=tmlist
local disciplesList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort)
local templist={}
for k,v in ipairs(disciplesList)do
local netdata=v.netData
local guid=netdata.net.discipleguid
local netData=UIDiscipleModel:getDiscipleData(guid)
local diziid=netData.id
for i,j in ipairs(getlist)do
if diziid==j then
local limitlvl_idx=#tm
for m,n in ipairs(tm)do
if netData.tmlv<=n then
limitlvl_idx=m
break
end
end
templist[#templist+1]={diziid,limitlvl_idx,guid}
end
end
end

local maxfaze_id=0
if#templist>0 then
for k,v in ipairs(templist)do
if maxfaze_id==nil then
maxfaze_id=v[2]
end
if maxfaze_id<v[2]then
maxfaze_id=v[2]
end
end
end
return templist,maxfaze_id
end


function UISubAct_tgslEnterWin:GetspecialLGfaze()
local disciplesList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort)
local templist={}

for k,v in ipairs(disciplesList)do
local netdata=v.netData
local guid=netdata.net.discipleguid
local netData=UIDiscipleModel:getDiscipleData(guid)
local diziid=netData.id
local fightvalue=tonumber(tostring(netData.fightvalue))
local lglevel=UIDiscipleModel:getDiscipleTotalLinggenLevel(guid)
if lglevel>0 then
templist[#templist+1]={diziid,lglevel,fightvalue,tostring(guid)}
end
end


local _list={}
local alllglevel=0
if#templist>0 then
if#templist>5 then
table.sort(templist,function(a,b)
if a[2]==b[2]then
return a[3]>b[3]
else
return a[2]>b[2]
end
end)
end

for k,v in ipairs(templist)do
alllglevel=alllglevel+v[2]
end







for i=1,5 do
if templist[i]then
_list[templist[i][4]]=templist[i]
end
end
end

return _list,alllglevel
end


function UISubAct_tgslEnterWin:GetspecialCTfaze()
local disciplesList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort)
local templist={}

for k,v in ipairs(disciplesList)do
local netdata=v.netData
local guid=netdata.net.discipleguid
local netData=UIDiscipleModel:getDiscipleData(guid)
local diziid=netData.id
local fightvalue=tonumber(tostring(netData.fightvalue))

local ltlv=netData.qzctlv
if ltlv>0 then
templist[#templist+1]={diziid,ltlv,fightvalue,tostring(guid)}
end
end

local _list={}
local allctlevel=0
if#templist>0 then
if#templist>5 then
table.sort(templist,function(a,b)
if a[2]==b[2]then
return a[3]>b[3]
else
return a[2]>b[2]
end
end)
end

for k,v in ipairs(templist)do
allctlevel=allctlevel+v[2]
end

for i=1,5 do
if templist[i]then
_list[templist[i][4]]=templist[i]
end
end
end

return _list,allctlevel
end














































function UISubAct_tgslEnterWin:onShareBtn()
end
function UISubAct_tgslEnterWin:onRankBtn()
end


function UISubAct_tgslEnterWin:onCloseBtn()
self:onBackground()
end


function UISubAct_tgslEnterWin:onSettingBtn()

end

function UISubAct_tgslEnterWin:startLeaveTick()
local nowTime=timeHelper.getServerShortTime()
if not self.leaveTick then
if self.leaveTime>0 and nowTime<self.leaveTime then
self.leaveTick=self:setTimer(1,0,function()
self:updateLeaveTick()
end)
end
end
end

function UISubAct_tgslEnterWin:updateLeaveTick()
if self.leaveTime>0 then
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.leaveTime-nowTime
if leastTime>0 then
self.leastTime:setText(FMT.fmt("{0}后离开",timeHelper.format_time_stamp(leastTime)))
else
self.leastTime:setText("已离开")
self:stopLeaveTick()
end
else
self.leastTime:setText("")
self:stopLeaveTick()
end
end

function UISubAct_tgslEnterWin:stopLeaveTick()
if self.leaveTick then
self:stopTimerByID(self.leaveTick)
self.leaveTick=nil
end
end

function UISubAct_tgslEnterWin:on_249_134(actId,subId,monsterGuid,flag)
if self.info:compare(actId,self.subType,subId)and self.guid==monsterGuid then
self.shared=flag
end
end

function UISubAct_tgslEnterWin.on_money_changed(moneyType,lastVal,val)
if moneyType==_this.costItem then
_this:refreshMoney(val)
end
end

function UISubAct_tgslEnterWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if itemid==_this.costItem then
_this:refreshMoney(newcount)
end
end

function UISubAct_tgslEnterWin:initMoney()
self.costItem=self.config.money[1]
local iconName=iconHelper.getIconName(self.costItem)
self.moneyIcon:setImageIcon(iconName,false)

self:refreshMoney()
end

function UISubAct_tgslEnterWin:refreshMoney(val)
local cur=val or itemsModel.getCount(self.costItem)
self.moneyNum:setText(cur)
end

function UISubAct_tgslEnterWin:onMoneyAdd()
self.info:showMoneyBuyPanel(self.costItem)
end

function UISubAct_tgslEnterWin:onMoneyBg()
gainControl:showGainWin(self.costItem)
end

function UISubAct_tgslEnterWin:onActivityEnd(actId,subType,subId)
if _this.info:compare(actId,subType,subId)then
_this:closeSelf()
end
end

