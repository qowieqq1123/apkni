







def_class("UIWorldXiuZhenJiaZuInfoWin",UIWindowBase)









function UIWorldXiuZhenJiaZuInfoWin:bindComponents()

self.teamInfoBtn=UIButton.get(self,0)
self.stateText=UIText.get(self,1)
self.costImage=UIImage.get(self,2)
self.costTxt=UIText.get(self,3)
self.firstRewardBtn=UIButton.get(self,4)
self.costPanel=UIObject.get(self,5)
self.zzName=UIText.get(self,6)
self.speakObj=UIObject.get(self,7)
self.firstRewardImg=UIObject.get(self,8)
self.fengluText=UIText.get(self,9)
self.fengluIcon=UIImage.get(self,10)
self.jiazuIcon=UIImage.get(self,11)
self.jiazuName=UIText.get(self,12)
self.jinzhuBtn=UIButton.get(self,13)
self.giveupBtn=UIButton.get(self,14)
self.quzhuBtn=UIButton.get(self,15)
self.changeBtn=UIButton.get(self,16)
self.zhengduoBtn=UIButton.get(self,17)
self.people=UIText.get(self,18)
self.specialityIcon=UIImage.get(self,19)
self.specialityText=UIText.get(self,20)
self.tedianText=UIText.get(self,21)
self.tedianScrollerView=UIObject.get(self,22)
self.guimo=UIText.get(self,23)
self.zuzhangModel=UIObject.get(self,24)
self.txtSpeak=UIText.get(self,25)
self.jichengText=UIText.get(self,26)
self.jichengScrollerView=UIObject.get(self,27)

self.teamInfoBtn:setButtonClick(function()self:onTeamInfoBtn()end)

self.firstRewardBtn:setButtonClick(function()self:onFirstRewardBtn()end)

self.jinzhuBtn:setButtonClick(function()self:onJinzhuBtn()end)

self.giveupBtn:setButtonClick(function()self:onGiveupBtn()end)

self.quzhuBtn:setButtonClick(function()self:onQuzhuBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.zhengduoBtn:setButtonClick(function()self:onZhengduoBtn()end)



end


function UIWorldXiuZhenJiaZuInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.teamInfoBtn);self.teamInfoBtn=nil;
_UIObject_release(self.stateText);self.stateText=nil;
_UIObject_release(self.costImage);self.costImage=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.firstRewardBtn);self.firstRewardBtn=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.zzName);self.zzName=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.firstRewardImg);self.firstRewardImg=nil;
_UIObject_release(self.fengluText);self.fengluText=nil;
_UIObject_release(self.fengluIcon);self.fengluIcon=nil;
_UIObject_release(self.jiazuIcon);self.jiazuIcon=nil;
_UIObject_release(self.jiazuName);self.jiazuName=nil;
_UIObject_release(self.jinzhuBtn);self.jinzhuBtn=nil;
_UIObject_release(self.giveupBtn);self.giveupBtn=nil;
_UIObject_release(self.quzhuBtn);self.quzhuBtn=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.zhengduoBtn);self.zhengduoBtn=nil;
_UIObject_release(self.people);self.people=nil;
_UIObject_release(self.specialityIcon);self.specialityIcon=nil;
_UIObject_release(self.specialityText);self.specialityText=nil;
_UIObject_release(self.tedianText);self.tedianText=nil;
_UIObject_release(self.tedianScrollerView);self.tedianScrollerView=nil;
_UIObject_release(self.guimo);self.guimo=nil;
_UIObject_release(self.zuzhangModel);self.zuzhangModel=nil;
_UIObject_release(self.txtSpeak);self.txtSpeak=nil;
_UIObject_release(self.jichengText);self.jichengText=nil;
_UIObject_release(self.jichengScrollerView);self.jichengScrollerView=nil;
end
















local _this=nil




function UIWorldXiuZhenJiaZuInfoWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIWorldXiuZhenJiaZuInfoWin:__delete()
_this=nil
self:unbindComponents()
self:stopStrTimer()
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
end




function UIWorldXiuZhenJiaZuInfoWin:onShow(argtable,afterOnloaded)
notifySystem:listenNotify(notifyConfig.swipe,self.on_swipe)
notifySystem:listenNotify(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
if not argtable then
return
end
local world=worldModel.world
self.curGuid=argtable
worldXiuZhenJiaZuModel:setCurSelectGuid(argtable)
local familyData=worldXiuZhenJiaZuModel:getFamilyDataByGuid(self.curGuid)
if not familyData then
worldController:resetRightView()
return
end
self.familyData=familyData
local unFamilyId=familyData.unFamilyId
local familyId=familyData.familyId
local peopleCnt=familyData.peopleCnt
local tedianId=familyData.tedianId
local specialityId=familyData.specialityId
local state=familyData.state
local firstRewardFlag=familyData.firstRewardFlag
local familyCfg=worldXiuZhenJiaZuModel:getFamilyConfig(familyId)

local zuZhangCfg=worldXiuZhenJiaZuModel:getElderConfig(familyId)

local zuZhangName=worldXiuZhenJiaZuModel:getZuZhangName(self.curGuid)
self.zzName:setText(zuZhangName)

local model=worldXiuZhenJiaZuModel:getZuZhangImageInfoInSide(zuZhangCfg.model)

self.zuzhangModel:setChildUIModelShowTarget(model.body,1.8,model.componets,0,false,true)
self.zuzhangModel:setChildUIModelShowTargetOffset(0,65)


local talkList=zuZhangCfg.talk






local rand=math.random(1,#talkList)
local talkContent=talkList[rand]
self:showElderTalk(talkContent)

local model=familyCfg.modelid
local scale=isometricMapSystem:getModelScale(model,true)

local index,preNameList=worldXiuZhenJiaZuModel:getFamilyScaleData(self.curGuid)
local scaleCfg=cfgHelper.get(cfg_xiuzhenfamilyscaleconfig_get,index)
local icon
if familyCfg.icon then
icon=FMT.fmt("icon_family_{0}",familyCfg.icon[index])
self.winlua:SetChildCSImageIcon(self.jiazuIcon:getID(),icon,true)
else
if scaleCfg then
icon=scaleCfg.icon
self.winlua:SetChildCSImageIcon(self.jiazuIcon:getID(),icon,true)

end
end


local name=worldXiuZhenJiaZuModel:getFamilyName(self.curGuid,true)
local index,preNameList=worldXiuZhenJiaZuModel:getFamilyScaleData(self.curGuid)
self.jiazuName:setText(FMT.fmt("{0}",name))




local guimoStr=index~=-1 and preNameList[4]or''
self.guimo:setText(FMT.fmt('{0}型家族（{1}人）',guimoStr,peopleCnt))

local baseFengLu=familyCfg.family_wages
local moneyIconName=iconHelper.getIconName(baseFengLu[1])
self.fengluIcon:setImageIcon(moneyIconName)
local allFengLu=familyCfg.per_wage*peopleCnt+baseFengLu[2]
local fl_rate=gubaoModel:getGBSkil_MoneyUpRate(1,eMoneyType.mtLingShi)
if fl_rate>0 then
allFengLu=math.floor(allFengLu*(1+fl_rate/100))
end
self.fengluText:setText(FMT.fmt('{0}/年',allFengLu))

self:refreshTeDianTeZhi(tedianId,specialityId)







self:refreshStateInfo(self.curGuid)

local cost=familyCfg.cost
self.costPanel:setActive(cost~=nil)
if cost then
local itemid=cost[1][1]
local count=cost[1][2]
local iconName=iconHelper.getIconName(itemid)
self.costImage:setImageIcon(iconName,false)
self.costTxt:setText(count)
end

self:refreshJobPanel()
end


function UIWorldXiuZhenJiaZuInfoWin:onHide()
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
end

function UIWorldXiuZhenJiaZuInfoWin:refreshFirstReward(data)


end

function UIWorldXiuZhenJiaZuInfoWin:refreshStateInfo(guid)
if self.curGuid~=guid then return end
local familyData=worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)
local state=familyData.state
local jinzhuzhong=worldXiuZhenJiaZuModel:isJinZhuZhong(guid)

local stateStr=''
if jinzhuzhong then
stateStr='附庸：中立(<color=#2DCD19FF>弟子进驻中...</color>)'
elseif state==0 then
stateStr='未附庸宗门'
elseif state==1 then
local dzList=familyData.dzList
local dzCount=0
if dzList then
for i,v in ipairs(dzList)do
if tostring(v.unitId)~='0'then
dzCount=dzCount+1
end
end
end
local numStr=dzCount<5 and'(<color=#c82c2cff>客卿未满</color>)'or'(客卿已满)'
stateStr=FMT.fmt('附庸：{0}{1}',UISettingModel:getZMName(),numStr)
elseif state==2 then
stateStr='附庸：系统宗门'
end
self.stateText:setText(stateStr)

self.quzhuBtn:setActive((state==familyState.neutral or state==familyState.system)and not jinzhuzhong)
self.jinzhuBtn:setActive(state==familyState.neutral and not jinzhuzhong)
self.giveupBtn:setActive(state==familyState.player and not jinzhuzhong)
self.changeBtn:setActive(state==familyState.player and not jinzhuzhong)
self.zhengduoBtn:setActive(state==familyState.system and not jinzhuzhong)
self.teamInfoBtn:setActive(false)
end

function UIWorldXiuZhenJiaZuInfoWin:refreshJobPanel()
local familyId=self.familyData.familyId
local familyCfg=worldXiuZhenJiaZuModel:getFamilyConfig(familyId)
local voc_citiao=familyCfg.voc_citiao
local len=#voc_citiao
self.jichengScrollerView:setChildScrollViewCreateGrids(len,len)
local grids=self.jichengScrollerView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]
if item then
local jobicon=UIDiscipleModel:getJobIconName(voc_citiao[i])
item:SetChildCSImageSprite(0,globalABLookup.global,jobicon)
item:SetChildButtonClick(1,function()
local name=UIDiscipleModel:getJobName(voc_citiao[i])
local pos=Vector2.New(-30-(i-1)*50,30)
local cond_str=FMT.fmt("家族传承\n该家族有祖上传承，可为宗门培养\n<color=#76d81e>{0}</color>职业弟子",name)
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
end)
end
end
end

function UIWorldXiuZhenJiaZuInfoWin:showElderTalk(str)














self.txtSpeak:setText(str)
self.speakObj:setScale(Vector3(0,0,0))
self:delayDo(0.1,function(...)
self.speakObj:setChildDOScale(1,0.2,nil)
end)
end

function UIWorldXiuZhenJiaZuInfoWin:stopStrTimer()
if self.strTimer then
self:stopTimerByID(self.strTimer)
self.strTimer=nil
end
end


function UIWorldXiuZhenJiaZuInfoWin:refreshTeDianTeZhi(tedianId,specialityId)
local tedianCfg=cfgHelper.get1(cfg_xiuzhenfamilycharacteristicconfig_get,tedianId)
local specialityCfg=cfgHelper.get1(cfg_xiuzhenfamilyspecialityconfig_get,specialityId)
local showScroller=tedianId>0 or specialityId>0
local onlySpecialty=tedianId<=0 and specialityId>0
self.tedianScrollerView:setActive(showScroller)
self.tedianText:setActive(tedianId<=0 and specialityId<=0)
if showScroller then
local showOne=tedianId<=0 or specialityId<=0
local col=showOne and 1 or 2
self.tedianScrollerView:setChildScrollViewInit(0.5,true,function(...)
self:onClickTeDianItem(...)
end,nil)
self.tedianScrollerView:setChildScrollViewCreateGrids(col,0)
local grids=self.tedianScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local framecolor
local name=''
if onlySpecialty or i==2 then
framecolor=specialityCfg.framecolor
name=specialityCfg.name
else
framecolor=tedianCfg.framecolor
name=tedianCfg.name
end
name=UIDiscipleModel.getSpecialityNameStr(name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(framecolor)
item:SetChildCSImageSprite(0,abName,frameIcon)
item:SetChildText(1,name)
end
end
end

function UIWorldXiuZhenJiaZuInfoWin:onClickTeDianItem(clicknum,index)
local tedianId=self.familyData.tedianId
local specialityId=self.familyData.specialityId
local tedianCfg=cfgHelper.get1(cfg_xiuzhenfamilycharacteristicconfig_get,tedianId)
local specialityCfg=cfgHelper.get1(cfg_xiuzhenfamilyspecialityconfig_get,specialityId)
local onlySpecialty=tedianId<=0 and specialityId>0

local item=self.tedianScrollerView:getChildScrollViewItemWidget(index)
local args={}
args.posWidget=item
local name=''
local framecolor
local desc
if onlySpecialty or index==1 then
name=specialityCfg.name
framecolor=specialityCfg.framecolor
local index=worldXiuZhenJiaZuModel:getFamilyScaleData(self.curGuid)
local descStr=specialityCfg.desc
local addTab=specialityCfg.descformat
if addTab then
local formatNums=addTab[index]
desc={FMT.fmt(descStr,unpack(formatNums))}
else
desc={descStr}
end
else
name=tedianCfg.name
framecolor=tedianCfg.framecolor
desc={tedianCfg.desc}
end
args.title=name
args.framecolor=framecolor
args.desclist=desc
args.pivot=Vector2(1,0)
UIManager:showWindow('UIDescribeTips2',args)
end

function UIWorldXiuZhenJiaZuInfoWin:checkJinZhuCost()
local familyId=self.familyData.familyId
local familyCfg=worldXiuZhenJiaZuModel:getFamilyConfig(familyId)
local cost=familyCfg.cost
if cost then
for i,v in ipairs(cost)do
local itemid=v[1]
local needCount=v[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if have<needCount then
return true,itemid
end
end
end
return false
end

function UIWorldXiuZhenJiaZuInfoWin:checkLingPaiPlanCost(callback)
local familyId=self.familyData.familyId
local familyCfg=worldXiuZhenJiaZuModel:getFamilyConfig(familyId)
local cost=familyCfg.cost
if cost then
local num=nil
for i,v in ipairs(cost)do
if v[1]==eMoneyType.mtLingPai then
num=needCount
break
end
end
if num then
local tipsStr=FMT.fmt("剩余{0}不足{1}，是否继续执行？",itemsConfig.getItemName(eMoneyType.mtLingPai),num)
moneyPlanModel:checkHandle(eMoneyType.mtLingPai,num,callback,tipsStr)
return
end
end
callback()
end

function UIWorldXiuZhenJiaZuInfoWin:getJinZhuMonsterList()
local familyId=self.familyData.familyId
local peopleCnt=self.familyData.peopleCnt
local familyCfg=worldXiuZhenJiaZuModel:getFamilyConfig(familyId)
local bossInfo=familyCfg.def_boss
if bossInfo then
local groupid
for i,v in ipairs(bossInfo)do
if peopleCnt>=v[1]and peopleCnt<=v[2]then
groupid=v[3]
end
end
if groupid then
local config=cfgHelper.get1(cfg_monstergroup_get,groupid)
return config.monList,groupid
else
logErr("找不到人数对应的怪物组id配置,人数：{0}",peopleCnt)
end
end
end



function UIWorldXiuZhenJiaZuInfoWin:onQuzhuBtn()
local guid=self.familyData.guid
local unitKey=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(unitKey)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task.progress_state<=eWorldTripProgress.Work then
return UIManager.error("正在进驻中")
end
end
local familyId=self.familyData.familyId
local guid=self.familyData.guid
local state=self.familyData.state
local familyCfg=worldXiuZhenJiaZuModel:getFamilyConfig(familyId)
if familyCfg then
local lv=familyCfg.quzhu_lv
local zmLv=zongmenModel:getLevel()
if lv and lv>zmLv then
UIManager.error(FMT.fmt("家族拒绝离开（需宗门{0}级）",lv))
return
end
end
if state==0 then
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='家族驱逐后将永久消失，是否确认？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
fightLaunchController:sendFight(eBattleLaunch.family,{},0,0,{1,worldModel.world,guid})

end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
elseif state==2 then


end
end


function UIWorldXiuZhenJiaZuInfoWin:onGiveupBtn()
local guid=self.familyData.guid
local unitKey=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(unitKey)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task.progress_state<=eWorldTripProgress.Work then
return UIManager.error("正在进驻中")
end
end

local guid=self.familyData.guid
worldXiuZhenJiaZuController:req_giveup_xzfamily(worldModel.world,guid)
end


function UIWorldXiuZhenJiaZuInfoWin:onJinzhuBtn()
local guid=self.familyData.guid
local unitKey=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(unitKey)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task.progress_state<=eWorldTripProgress.Work then
return UIManager.error("正在进驻中")
end
end

local check,haveCnt,limitCnt,isMax,nextLv=worldXiuZhenJiaZuModel:checkFamilyLimit(true)
if check then
if isMax then
UIManager.error(FMT.fmt("宗门{2}级可增加进驻上限（{0}/{1}）",haveCnt,limitCnt,nextLv[1]))
else
UIManager.error(FMT.fmt("附庸家族已达上限（{0}/{1}）",haveCnt,limitCnt))
end
return
end
local ret,itemid=self:checkJinZhuCost()
if ret then
UIManager.error('消耗不足')
gainControl:showGainWin(itemid)
return
end
local callback=function()
local guid=self.familyData.guid
local familyId=self.familyData.familyId
local enterCallBack=function(selectList,zfId)
fightController:closeSelectStage(false)
worldXiuZhenJiaZuController.startMission(guid,familyId,familyFightType.jinzhu,worldModel.world,selectList,zfId)
UIFullFightPrepareControl:closeUI()
worldController:displayUI(true)
worldController:displayHUD(true)
worldController:displaySymbol(true)
worldController:showView()
end
local monsterList,groupid=self:getJinZhuMonsterList()
self:showPrepareWin(enterCallBack,monsterList,groupid)
end
self:checkLingPaiPlanCost(callback)
end


function UIWorldXiuZhenJiaZuInfoWin:onChangeBtn()
UIManager:showWindow('UIWorldXiuZhenJiaZuManagerWin')
end


function UIWorldXiuZhenJiaZuInfoWin:onZhengduoBtn()


end


function UIWorldXiuZhenJiaZuInfoWin:onTeamInfoBtn()
UIManager.info('暂无此功能')
local dzList=self.familyData.dzList
if dzList then
for i,v in ipairs(dzList)do

end
end
end

function UIWorldXiuZhenJiaZuInfoWin:showPrepareWin(enterCallBack,monsterList,groupid)
local winArgs=
{
enterCallBack=enterCallBack,
enterTxt="家族",
monsterList=monsterList,
groupId=groupid,
cancelCallBack=function()
worldController:displayUI(true)
worldController:displayHUD(true)
worldController:displaySymbol(true)
worldController:showView()
end,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.xiuZhenJiaZu,winArgs)
worldController:displayUI(false)
worldController:displayHUD(false)
worldController:displaySymbol(false)
worldController:resetLeftView()
worldController:resetRightView()

end

function UIWorldXiuZhenJiaZuInfoWin:onFirstRewardBtn()





end

function UIWorldXiuZhenJiaZuInfoWin.on_swipe()
if _this then
worldController.on_swipe_end(0)
worldController:resetRightView()
end
end

function UIWorldXiuZhenJiaZuInfoWin.onClickEmptyInWorld()
if _this then
worldController:resetRightView()
end
end
