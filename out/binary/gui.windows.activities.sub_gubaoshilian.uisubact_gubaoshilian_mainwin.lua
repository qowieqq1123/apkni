







def_class("UISubAct_GuBaoShiLian_MainWin",UIWindowBase)









function UISubAct_GuBaoShiLian_MainWin:bindComponents()

self.challengeBtn=UIButton.get(self,0)
self.effectBtn=UIButton.get(self,1)
self.gbCheckBtn=UIButton.get(self,2)
self.gbClick=UIButton.get(self,3)
self.gbLeftBtn=UIButton.get(self,4)
self.gbModel=UIObject.get(self,5)
self.gbRightBtn=UIButton.get(self,6)
self.helperBtn=UIButton.get(self,7)
self.levelView=UILoopListView.new(self,8)
self.model=UIObject.get(self,9)
self.rankBtn=UIButton.get(self,10)
self.rewardBtn=UIButton.get(self,11)
self.rewardList=UIObject.get(self,12)
self.rewardView=UIObject.get(self,13)
self.root=UIObject.get(self,14)
self.timeTx=UIText.get(self,15)
self.tipsTx=UIText.get(self,16)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.effectBtn:setButtonClick(function()self:onEffectBtn()end)

self.gbCheckBtn:setButtonClick(function()self:onGbCheckBtn()end)

self.gbClick:setButtonClick(function()self:onGbClick()end)

self.gbLeftBtn:setButtonClick(function()self:onGbLeftBtn()end)

self.gbRightBtn:setButtonClick(function()self:onGbRightBtn()end)

self.helperBtn:setButtonClick(function()self:onHelperBtn()end)

self.levelView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UISubAct_GuBaoShiLian_MainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.effectBtn);self.effectBtn=nil;
_UIObject_release(self.gbCheckBtn);self.gbCheckBtn=nil;
_UIObject_release(self.gbClick);self.gbClick=nil;
_UIObject_release(self.gbLeftBtn);self.gbLeftBtn=nil;
_UIObject_release(self.gbModel);self.gbModel=nil;
_UIObject_release(self.gbRightBtn);self.gbRightBtn=nil;
_UIObject_release(self.helperBtn);self.helperBtn=nil;
self.levelView:deleteSelf();self.levelView=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
end















local _this=nil
local _gubaoLoopTime=5
local _levelCmp={
root=-1,
name=0,
pass=1,
current=2,
lock=3,
select=4,
}
local _abName="ui/windows/activities/sub_gubaoshilian/gubaoshilian_atlas_pak.ab"



function UISubAct_GuBaoShiLian_MainWin:onLoaded(...)
self:bindComponents()
_this=self

self.defaultGuBaoScale=self.gbModel:getScale()
end


function UISubAct_GuBaoShiLian_MainWin:__delete()
self:unbindComponents()
_this=nil

self:stopGBTick()
self:stopCDTick()
self:killGBTweener()
end




function UISubAct_GuBaoShiLian_MainWin:onShow(argtable,afterOnloaded)
if argtable then
local old=self.info and self.info:compare(argtable.act_id,argtable.sub_act_type,argtable.sub_act_id)or false
self.actId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.argtable=argtable
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
if not old then
self:initView()
end

if self.info and self.info:hasData()then
self:refreshView()
end
end
end


function UISubAct_GuBaoShiLian_MainWin:onHide()

end




function UISubAct_GuBaoShiLian_MainWin:onChallengeBtn()
if self.info and self.info:hasData()then
local current=self.info:getData()
if self.levelIndex==current+1 then
local levelCfg=cfgHelper.get1(cfg_gubaoshilianlayerconfig_get,self.config.layer_list[self.levelIndex])
local monCfg=cfgHelper.get1(cfg_monstergroup_get,levelCfg.mon_group_list[1])
local faZeList2Args={}
for i,v in ipairs(levelCfg.faze_list)do
local fzId=v[1]
local fzlv=v[2]
local fzRuleCfg=cfgHelper.getSSlawRule(fzId)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local fzdesc=not hasParam and fzRuleCfg.desc or string.format(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
table.insert(faZeList2Args,{name=fzRuleCfg.name,icon=fzRuleCfg.image,desc=fzdesc})
end
local actId=self.actId
local subType=self.subType
local subId=self.subId
local winArgs=
{
enterCallBack=function(guidList,zfId,map)
fightLaunchController:sendFight(eBattleLaunch.gubaoshilian,guidList,map or 0,zfId or 0,{actId,subType,subId})
end,
enterTxt=self.config.sub_name,
cancelCallBack=function()
fightController:closeSelectStage()
activitiesController:jump(actId,subType,subId)
end,
placeTxt=FMT.fmt("第{0}层",self.levelIndex),
monsterFight=levelCfg.view_fight,
monsterList=monCfg.monList,
groupId=monCfg.id,
mapId=monCfg.mapId,

dontCloseStage=true,
statePriorityCheck=true,
faZeList2Args=faZeList2Args,
faZeList2Default=false,
extraWin="UISubAct_GuBaoShiLian_FightPrepareWin",
extraParams={
actId=self.actId,
subType=self.subType,
subId=self.subId,
},
gbslAddInfo={
job=self.config.voc_limit,
list=self.config.disciple_up,
},
}
fightController.showPrepareWin(eFightPreSelectType.gubaoshilian,winArgs)
elseif self.levelIndex<=current then
UIManager.info("本层已通关")
else
UIManager.info(FMT.fmt("需要通关第{0}层",current+1))
end
end
end


function UISubAct_GuBaoShiLian_MainWin:onEffectBtn()
if self.info and self.info:hasData()then
local current=self.info:getData()
local id=self.config.layer_list[self.levelIndex]
local faze_list=cfgHelper.get2(cfg_gubaoshilianlayerconfig_get,id,"faze_list")
local args={
parentWin=self,
fazeDatas=faze_list,
}
self:showWindow("UISubAct_GuBaoShiLian_FaZeListWin",args)
end
end


function UISubAct_GuBaoShiLian_MainWin:onGbCheckBtn()
local args={
parentWin=self,
actId=self.actId,
subType=self.subType,
subId=self.subId,
gubaoIDs=self.gubaoIDs,
}
self:showWindow("UISubAct_GuBaoShiLian_GuBaoWin",args)
end


function UISubAct_GuBaoShiLian_MainWin:onGbClick()
self:onGbRightBtn()
end


function UISubAct_GuBaoShiLian_MainWin:onGbLeftBtn()
self.showGubaoIdx=self.showGubaoIdx-1
if self.showGubaoIdx<=0 then
self.showGubaoIdx=self.showGubaoIdx+#self.gubaoIDs
end
self:refreshGuBao()
end


function UISubAct_GuBaoShiLian_MainWin:onGbRightBtn()
self.showGubaoIdx=self.showGubaoIdx+1
if self.showGubaoIdx>#self.gubaoIDs then
self.showGubaoIdx=self.showGubaoIdx-#self.gubaoIDs
end
self:refreshGuBao()
end


function UISubAct_GuBaoShiLian_MainWin:onHelperBtn()
local d={}
d.title='规则'
d.mode=3
d.name='gubaoshilian_help_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UISubAct_GuBaoShiLian_MainWin:onRankBtn()
if self.info:checkRankDirty()then
call_activitiesHandle_func("activitiesHandle_gubaoshilian","reqRankData",self.actId,self.subId)
end

local args={
parentWin=self,
actId=self.actId,
subType=self.subType,
subId=self.subId,
}
self:showWindow("UISubAct_GuBaoShiLian_RankWin",args)
end


function UISubAct_GuBaoShiLian_MainWin:onRewardBtn()
local args={
parentWin=self,
actId=self.actId,
subType=self.subType,
subId=self.subId,
}
self:showWindow("UISubAct_GuBaoShiLian_RewardDetailWin",args)
end

function UISubAct_GuBaoShiLian_MainWin:onStartAction()

end

function UISubAct_GuBaoShiLian_MainWin:onClickLevel(level)
local index=#self.config.layer_list-self.levelIndex+1
local widget=self.levelView:getListViewItemWidgetByDataIndex(index)
if widget then
widget:SetChildActive(_levelCmp.select,false)
end

self.levelIndex=level

index=#self.config.layer_list-self.levelIndex+1
widget=self.levelView:getListViewItemWidgetByDataIndex(index)
if widget then
widget:SetChildActive(_levelCmp.select,true)
end

self:refreshPanel()
end

function UISubAct_GuBaoShiLian_MainWin:onFreshAction(index,widget,data)
local level=#self.config.layer_list-index+1
local current=self.info:getData()
widget:SetChildText(_levelCmp.name,FMT.fmt("第{0}层",level))
widget:SetChildActive(_levelCmp.pass,level<=current)
widget:SetChildActive(_levelCmp.current,level==current+1)
widget:SetChildActive(_levelCmp.lock,level>current+1)
widget:SetChildActive(_levelCmp.select,level==self.levelIndex)
widget:SetChildButtonClick(_levelCmp.root,function()
self:onClickLevel(level)
end)
end

function UISubAct_GuBaoShiLian_MainWin:initView()
self.gubaoIDs={}
for id,temp in pairs(self.config.gubao_up1)do
table.insert(self.gubaoIDs,id)
end
for id,temp in pairs(self.config.gubao_up2)do
if not self.config.gubao_up1[id]then
table.insert(self.gubaoIDs,id)
end
end
table.sort(self.gubaoIDs)
self.showGubaoIdx=1

self:refreshGuBao()
self:startGBTick()

self.levelView:initData('levelItem',{})

self.tipsTx:setText(FMT.fmt("本期弟子出战要求：至少上阵<color=#efb150>1名{0}</color>",UIDiscipleModel:getJobName(self.config.voc_limit)))
end

function UISubAct_GuBaoShiLian_MainWin:startGBTick()
if not self.gbTick then
self.gbTick=self:setTimer(1,0,function()
if self.gbTickTime<timeHelper.getServerShortTime()then
self:onGbRightBtn()
end
end)
end
end

function UISubAct_GuBaoShiLian_MainWin:stopGBTick()
if self.gbTick then
self:stopTimerByID(self.gbTick)
self.gbTick=nil
end
end

function UISubAct_GuBaoShiLian_MainWin:startCDTick()
if not self.cdTick then
if self:updateCDTick()then
self.cdTick=self:setTimer(1,0,function()
if not self:stopCDTick()then
self:updateCDTick()
end
end)
end
end
end

function UISubAct_GuBaoShiLian_MainWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_GuBaoShiLian_MainWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.info.end_time-nowTime
if leastTime>0 then
self.timeTx:setText(FMT.fmt("活动剩余时间：<color=#efb150>{0}</color>",timeHelper.format_time_stamp3(leastTime)))
return true
else
self.timeTx:setText("<color=#efb150>活动已结束</color>")
return false
end
end

function UISubAct_GuBaoShiLian_MainWin:refreshGuBao()
local gbId=self.gubaoIDs[self.showGubaoIdx]
local itemCfg=itemsConfig.getConfig(gbId,ITEM_CONFIG_TYPE.eGuBao)
local pram=itemCfg.relevantPram.pram
local effectId=pram.effectid
self:killGBTweener()
local scale=self.defaultGuBaoScale.x or 0.44
self.gbModel:setScale(Vector3.zero)
self.gbModel:setChildShowEffect(effectId,true)
self.gbTweener=self.gbModel:setChildDOScale(scale,0,nil)
self.gbTweener:SetDelay(0.2)

self.gbTickTime=timeHelper.getServerShortTime()+_gubaoLoopTime
end

function UISubAct_GuBaoShiLian_MainWin:killGBTweener()
if self.gbTweener and self.gbTweener:IsActive()then
self.gbTweener:Kill()
self.gbTweener=nil
end
end

function UISubAct_GuBaoShiLian_MainWin:refreshView()
local current=self.info:getData()
self.levelIndex=Mathf.Clamp(current+1,1,#self.config.layer_list)

local createList={}
for i,v in ipairs(self.config.layer_list)do
createList[#createList+1]=i
end
self.levelView:initData('levelItem',createList)
self.levelView:jumpItem(#self.config.layer_list-self.levelIndex)

self:refreshPanel(current)

self:startCDTick()
end

function UISubAct_GuBaoShiLian_MainWin:refreshPanel(current)
current=current or self.info:getData()
local levelCfg=cfgHelper.get1(cfg_gubaoshilianlayerconfig_get,self.config.layer_list[self.levelIndex])
local monCfg=cfgHelper.get1(cfg_monstergroup_get,levelCfg.mon_group_list[1])
self.model:setChildUIModelShowTarget(monCfg.model[1],1,monCfg.model[3],eAnimationID.stand,false,false,0)


local buttonName=self.levelIndex==current+1 and"button_gbsl_tiaozhan_1"or"button_tiaozhan_2"
self.winlua:SetChildCSImageSprite(self.challengeBtn:getID(),_abName,buttonName)

local dropCfg=cfgHelper.get1(cfg_awardconfig_get,levelCfg.drop_id)
local rewardDatas=dropCfg.showItems or{}
self.rewardList:setChildLayoutGroupCreateItems(#rewardDatas,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local itemData=rewardDatas[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local itemRange=itemData.range
local showCountBG=itemNum>1 or itemData.range~=nil
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,range=itemRange}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(0,itemProp)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildActive(1,itemNum==-1 and itemRange==nil)
end)
self.rewardView:setChildScrollRectEnable(#rewardDatas>4)
end