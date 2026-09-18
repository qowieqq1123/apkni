







def_class("UIHuanJingZhenLingChallengeWin",UIWindowBase)









function UIHuanJingZhenLingChallengeWin:bindComponents()

self.Root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.uiRoot=UIObject.get(self,2)
self.leftRoot=UIObject.get(self,3)
self.rightRoot=UIObject.get(self,4)
self.zlSkillShowScrollView=UIObject.get(self,5)
self.modeltype=UIImage.get(self,6)
self.leftTimeRoot=UIObject.get(self,7)
self.modelPallet=UIObject.get(self,8)
self.zlNameBg=UIObject.get(self,9)
self.zlmodel=UIObject.get(self,10)
self.zlSkillList=UIObject.get(self,11)
self.typeList=UIObject.get(self,12)
self.layerList=UILoopListView.new(self,13)
self.lockRoot=UIObject.get(self,14)
self.leftTime=UIText.get(self,15)
self.infoBtn=UIButton.get(self,16)
self.zlName=UIText.get(self,17)
self.unlocktip=UIText.get(self,18)
self.unlockBtn=UIButton.get(self,19)
self.unlockBtnTxt=UILinkImageText.get(self,20)
self.zlSkillShowList=UIObject.get(self,21)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.layerList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.unlockBtn:setButtonClick(function()self:onUnlockBtn()end)



end


function UIHuanJingZhenLingChallengeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.zlSkillShowScrollView);self.zlSkillShowScrollView=nil;
_UIObject_release(self.modeltype);self.modeltype=nil;
_UIObject_release(self.leftTimeRoot);self.leftTimeRoot=nil;
_UIObject_release(self.modelPallet);self.modelPallet=nil;
_UIObject_release(self.zlNameBg);self.zlNameBg=nil;
_UIObject_release(self.zlmodel);self.zlmodel=nil;
_UIObject_release(self.zlSkillList);self.zlSkillList=nil;
_UIObject_release(self.typeList);self.typeList=nil;
self.layerList:deleteSelf();self.layerList=nil;
_UIObject_release(self.lockRoot);self.lockRoot=nil;
_UIObject_release(self.leftTime);self.leftTime=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.zlName);self.zlName=nil;
_UIObject_release(self.unlocktip);self.unlocktip=nil;
_UIObject_release(self.unlockBtn);self.unlockBtn=nil;
_UIObject_release(self.unlockBtnTxt);self.unlockBtnTxt=nil;
_UIObject_release(self.zlSkillShowList);self.zlSkillShowList=nil;
end
















local zlTypeList={
{
name='金',
id=1
},
{
name='木',
id=2
},
{
name='水',
id=3
},
{
name='火',
id=4
},
{
name='土',
id=5
},
}

local CmpLayerSlotIndex={
bg=0,
title=1,
rewardinfo=2,
rewardlist=3,
finishimg=4,
challengebtn=5,
btnTxt_sd=6,
curBg=7,
btnTxt_tz=8,
btnTxt_lock=9,
}

local CmpTypeSlotIndex={
icon=0,
select=1,
name=2
}

local _ab='ui/windows/huanjing/huanjing_atlas_pak.ab'

local planeSpineResId={5376,5377,5378,5375,5379}



function UIHuanJingZhenLingChallengeWin:onLoaded(...)
self:bindComponents()

self.loopListView=self.winlua:GetChildUILoopListView(self.layerList:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.layerList:getID())
self.loopListView:SetAction(function(...)
self:bindLayerWidget(...)
end,function(...)
self:onStartView(...)
end)



self:addNotify(notifyConfig.onZongMengLevelChange,function(...)self:onZongMengLevelChange(...)end)
end


function UIHuanJingZhenLingChallengeWin:__delete()
self:unbindComponents()

self:stopLeftTimer()
end




function UIHuanJingZhenLingChallengeWin:onShow(argtable,afterOnloaded)

self.selectType=argtable and argtable.selectType or UIHuanJingControl:getTodayFirstOpenType()

self.selectLayer=UIHuanJingControl:getJumpLayer(self.selectType)



self:refreshAll()
local showMoneys=cfgHelper.get2(cfg_houshanzhenlingbaseconfig_get,1,'showMoneys')
if showMoneys and next(showMoneys)then
self.isShowMoney=true
local idSdq=cfgHelper.get2(cfg_houshanzhenlingbaseconfig_get,1,'idSdq')
for k,v in ipairs(showMoneys)do
if v[1]==idSdq then
v.addCallBack=function(moneyType)
if UIHuanJingControl:checkSdCount()then
UIHuanJingControl:showBuyCountDialouge()
else
gainControl:showGainWin(moneyType)
end
end
end
end
self:showWindow("UITopMoneyWin2",{moneys=showMoneys,offsetX=345,offsetY=-40})
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHouShanZhenLingCanChalleng)
if not flag then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHouShanZhenLingCanChalleng,true)
end
end


function UIHuanJingZhenLingChallengeWin:onHide()
if self.isShowMoney then
self:hideWindow("UITopMoneyWin2")
end
self.layerList:setActive(false)
end

function UIHuanJingZhenLingChallengeWin:onShowArgRecv(args)
self:onShow({selectType=self.selectType})
end

function UIHuanJingZhenLingChallengeWin:refreshAll()
self.isDoJump=false

self:refreshLeftRoot()

self:refreshRightRoot()
end

function UIHuanJingZhenLingChallengeWin:refreshLeftRoot(layerIndex)

local suitLayer=layerIndex or UIHuanJingControl:getTypeSuitLayer(self.selectType)
local layerCfg=cfgHelper.get2(cfg_houshanzhenlingjiecengconfig_get,self.selectType,suitLayer)
local groudID=layerCfg.boos
local model=cfgHelper.get2(cfg_monstergroup_get,groudID,'model')
local name=cfgHelper.get2(cfg_monstergroup_get,groudID,'name')
local modelID=model[1]
local scales=cfgHelper.get2(cfg_dbbodyconfig_get,modelID,'scales2')or{}

local modelArgs=scales[19]or{1,0,0}
local components=model[3]
self.zlmodel:setChildUIModelShowTarget(modelID,modelArgs[1],components,eAnimationID.stand,false,false,0.3,nil)
self.zlmodel:setChildUIModelShowTargetOffset(modelArgs[2],modelArgs[3])
self.zlName:setText(name)

self:hideZlSkillShowScrollView()

local palletSpineId=planeSpineResId[self.selectType]
self.modelPallet:setChildUIModelShowTarget(palletSpineId,1,{},eAnimationID.stand,false,false,0.2,nil)

local monsterType=layerCfg.mostertype
local isShowType=monsterType~=nil
self.modeltype:setActive(isShowType)
if isShowType then
local typeIconName=FMT.fmt("icon_gwbz_{0}A",monsterType)
self.modeltype:setCSImageSprite(globalABLookup.global,typeIconName)
end


local showSkills=layerCfg.showSkillList
local showSkillLen=#(showSkills or{})
local isShowSkill=showSkillLen>0
self.zlSkillList:setActive(isShowSkill)
if isShowSkill then
self.zlSkillList:setChildLayoutGroupCreateItems(showSkillLen,function(index)
local item=self.zlSkillList:getChildLayoutGroupGridItem(index-1)
local data=showSkills[index]
local isShowSkillItem=data~=nil
item:SetChildActive(-1,isShowSkillItem)
if isShowSkillItem then
local cfg=cfgHelper.get1(cfg_skillconfig_get,data[1])
local icon=iconHelper.getSkillIcon(cfg.icon)
item:SetChildIcon(0,icon,true)
item:SetChildActive(1,false)

item:SetBaseItemClickEvent(-1,function()
self.isShowSkillRoot=not self.isShowSkillRoot
self.zlSkillShowScrollView:setActive(self.isShowSkillRoot)
end)
end
end)

self.zlSkillShowScrollView:setChildScrollRectEnable(false)
self:delayDo(0.25,function()
self.zlSkillShowScrollView:setChildScrollRectEnable(true)
end)

self.zlSkillShowList:setChildLayoutGroupCreateItems(showSkillLen,function(index)
local item=self.zlSkillShowList:getChildLayoutGroupGridItem(index-1)
local data=showSkills[index]
local cfg=cfgHelper.get1(cfg_skillconfig_get,data[1])
local skillDesc=skillModel:getSkillDesc(data[1],data[2])
item:SetChildText(0,cfg.name)
item:SetChildText(1,skillDesc)
end)
end

local isOpen=UIHuanJingControl:checkTypeOpen(self.selectType)
if isOpen then
self:startLeftTime()
else
self:stopLeftTimer()
self.leftTime:setText(FMT.fmt("挑战剩余时间:{0}",toColorString(FONT_COLOR.eGreenTxtColor,'未开启')))
end
end

function UIHuanJingZhenLingChallengeWin:hideZlSkillShowScrollView()
self.isShowSkillRoot=false
self.zlSkillShowScrollView:setActive(self.isShowSkillRoot)
end


function UIHuanJingZhenLingChallengeWin:startLeftTime()
self:stopLeftTimer()

local leftTime=UIHuanJingControl:getTypeLeftTime(self.selectType)
local endStamp=timeHelper.getServerShortTime()+leftTime

local func=function()
local sererTime=timeHelper.getServerShortTime()
local interval=endStamp-sererTime
if interval>0 then
local formateTimeStr=timeHelper.format_time_stamp3(interval)
local showStr=FMT.fmt("挑战剩余时间：{0}",toColorString(FONT_COLOR.eGreenTxtColor,formateTimeStr))
self.leftTime:setText(showStr)
else
local formateTimeStr=timeHelper.format_time_stamp3(0)
local showStr=FMT.fmt("挑战剩余时间：{0}",toColorString(FONT_COLOR.eGreenTxtColor,formateTimeStr))
self.leftTime:setText(showStr)

self:stopLeftTimer()
end
end

self.lefeTimer=self:setTimer(1,0,func)
func()
end

function UIHuanJingZhenLingChallengeWin:stopLeftTimer()
if self.lefeTimer then
self:stopTimerByID(self.lefeTimer)
self.lefeTimer=nil
end
end

function UIHuanJingZhenLingChallengeWin:refreshRightRoot()
self:refreshLayerRoot()

self:refreshTypeList()
end

function UIHuanJingZhenLingChallengeWin:refreshLayerRoot()
self:refreshLockRoot()
self:refreshLayerList()
end

function UIHuanJingZhenLingChallengeWin:refreshTypeList()
local len=#zlTypeList

self.typeList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.typeList:getChildLayoutGroupGridItem(index-1)
local data=zlTypeList[index]


local isOpen=UIHuanJingControl:checkTypeOpen(index)~=nil

local iconPre=isOpen and'button_houshanlzuia_'or'button_houshanlzuib_'
local icon=FMT.fmt('{0}{1}',iconPre,index)
item:SetChildCSImageSprite(CmpTypeSlotIndex.icon,_ab,icon)
item:SetChildText(CmpTypeSlotIndex.name,data.name)
item:SetChildActive(CmpTypeSlotIndex.select,self.selectType==index)

item:SetBaseItemClickEvent(-1,function()
if self.selectType==index then return end

local preItem=self.typeList:getChildLayoutGroupGridItem(self.selectType-1)
preItem:SetChildActive(CmpTypeSlotIndex.select,false)
item:SetChildActive(CmpTypeSlotIndex.select,true)
self.selectType=index
self.selectLayer=UIHuanJingControl:getJumpLayer(index)
self.isDoJump=false
self:refreshLeftRoot()
self:refreshLayerRoot()
end)
end)
end

function UIHuanJingZhenLingChallengeWin:refreshLockRoot()
local curTypeLockState=UIHuanJingControl:checkTypeOpen(self.selectType)~=nil

local isShow=not curTypeLockState
self.lockRoot:setActive(isShow)
if isShow then

local weekStr=FMT.fmt("{0}、六、日",timeHelper.format_week_chinese(self.selectType))
local unlockTipStr=FMT.fmt("{0}行阵灵{1}开启",zlTypeList[self.selectType].name,toColorString(FONT_COLOR.eGreenTxtColor,weekStr))
self.unlocktip:setText(unlockTipStr)

local buyCost=cfgHelper.get3(cfg_houshanzhenlingbaseconfig_get,1,'buyZhenLing',self.selectType)

local itemIconName=iconHelper.getIconName(buyCost[1])
local iconStr=chatEmotHelper.getIconEmotMesg(itemIconName,28)
local buyCostTxt=FMT.fmt("{0} {1} 解封",buyCost[2],iconStr)
self.unlockBtnTxt:setText(buyCostTxt)
end
end

function UIHuanJingZhenLingChallengeWin:refreshLayerList()
local allLayerCfg=cfgHelper.get1(cfg_houshanzhenlingjiecengconfig_get,self.selectType)
local len=#allLayerCfg
self.layerList:setActive(len>0)
local prefabNameList={}
local guidList={}

for k,v in ipairs(allLayerCfg)do
prefabNameList[k]='layertemp'
guidList[k]=k
end

self.loopListView:InitDataList(len,prefabNameList,guidList,nil,nil)


if not self.isDoJump then
self.loopListView:JumpIndex(self.selectLayer)
self.isDoJump=true
end
end



function UIHuanJingZhenLingChallengeWin:onStartView()

end
function UIHuanJingZhenLingChallengeWin:bindLayerWidget(index,item)
index=index+1
local data=UIHuanJingControl:getZLLayerData(self.selectType,index)

local isShow=data~=nil
item:SetChildActive(-1,isShow)

if isShow then
item:SetChildText(CmpLayerSlotIndex.title,data.cfg.name)
item:SetChildActive(CmpLayerSlotIndex.finishimg,data.layerState==HouShanZhenLingLayerStateList.LayerFinish)

local rewardInfoIconName=data.layerState>HouShanZhenLingLayerStateList.Challenge and'image_houshanlzui_13'or'image_houshanlzui_16'
item:SetChildCSImageSprite(CmpLayerSlotIndex.rewardinfo,_ab,rewardInfoIconName)

item:SetChildActive(CmpLayerSlotIndex.curBg,data.layerState==HouShanZhenLingLayerStateList.Challenge)

local isActiveChanllengeBtn=data.layerState==HouShanZhenLingLayerStateList.QuickChallenge or
data.layerState==HouShanZhenLingLayerStateList.Challenge or
data.layerState==HouShanZhenLingLayerStateList.NoChallenge or
data.layerState==HouShanZhenLingLayerStateList.Lock

local isShowCostInfo=data.layerState==HouShanZhenLingLayerStateList.QuickChallenge
local isShowTZInfo=data.layerState==HouShanZhenLingLayerStateList.Challenge or data.layerState==HouShanZhenLingLayerStateList.NoChallenge
local isShowLock=data.layerState==HouShanZhenLingLayerStateList.Lock
item:SetChildActive(CmpLayerSlotIndex.challengebtn,isActiveChanllengeBtn)
item:SetChildActive(CmpLayerSlotIndex.btnTxt_sd,isShowCostInfo)
item:SetChildActive(CmpLayerSlotIndex.btnTxt_tz,isShowTZInfo)
item:SetChildActive(CmpLayerSlotIndex.btnTxt_lock,isShowLock)
if isActiveChanllengeBtn then
local clickFunc=function()logErr(FMT.fmt("状态出错 --{0} --{1} --{2}",self.selectType,index,data.layerState))end
if data.layerState==HouShanZhenLingLayerStateList.QuickChallenge then

clickFunc=function()
self:hideZlSkillShowScrollView()
UIHuanJingControl:doSaoDang(self.selectType,index)
end
end

if data.layerState==HouShanZhenLingLayerStateList.Challenge then
clickFunc=function()

UIHuanJingControl:showZLPrepareWin(self.selectType,index)
end
end

if data.layerState==HouShanZhenLingLayerStateList.NoChallenge then
clickFunc=function()

UIManager.info("通关上层关卡即可解锁")
end
end

item:SetChildButtonClick(CmpLayerSlotIndex.challengebtn,clickFunc,true)

local btnState=data.layerState==HouShanZhenLingLayerStateList.Lock
item:SetChildButtonEnable(CmpLayerSlotIndex.challengebtn,not btnState,false)

local isNotCanClick=data.layerState==HouShanZhenLingLayerStateList.NoChallenge or data.layerState==HouShanZhenLingLayerStateList.Lock

local btnSkinName=isNotCanClick and'button_houshanlzui_7'or'button_houshanlzui_6'
item:SetChildCSImageSprite(CmpLayerSlotIndex.challengebtn,_ab,btnSkinName)


if isShowTZInfo then
item:SetChildText(CmpLayerSlotIndex.btnTxt_tz,'挑战')
end

if isShowCostInfo then
item:SetChildText(CmpLayerSlotIndex.btnTxt_sd,data.costTxt)
end
end

if isShowLock then
item:SetChildText(CmpLayerSlotIndex.btnTxt_lock,data.openTip)
end

local rewardListLen=#data.showRewardList
local isShowRewardList=rewardListLen>0
item:SetChildActive(CmpLayerSlotIndex.rewardlist,isShowRewardList)
if isShowRewardList then
item:SetChildLayoutGroupCreateItems(CmpLayerSlotIndex.rewardlist,rewardListLen,function(rindex)

local rewardItem=item:GetChildLayoutGroupGridItem(CmpLayerSlotIndex.rewardlist,rindex-1)
local rdata=data.showRewardList[rindex]

local isShowReward=rdata~=nil
rewardItem:SetChildActive(-1,isShowReward)
if isShowReward then
local clickFunc=function()
itemsComponentHelper.onItemClick(rdata[1])
end
local data={
rdata[1],rdata[2],rdata[3],
clickFunc=clickFunc,
showStage=true,
range=rdata.range,

}
widgetHelper.setNormalRewardItem(rewardItem,-1,data)
end
end)
end
end
end


function UIHuanJingZhenLingChallengeWin:transLineStr(str)
if not str then return""end
local result=string.toTable(str)

local temp=result[1]
for i=2,#result do
temp=FMT.fmt("{0}\n{1}",temp,result[i])
end
return temp
end


function UIHuanJingZhenLingChallengeWin:onZongMengLevelChange(list)
self:refreshAll()
end





function UIHuanJingZhenLingChallengeWin:onInfoBtn()
self:hideZlSkillShowScrollView()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_hszl_help_%s'})
end



function UIHuanJingZhenLingChallengeWin:onUnlockBtn()
local cost=cfgHelper.get3(cfg_houshanzhenlingbaseconfig_get,1,'buyZhenLing',self.selectType)

if not cost then return end
self:hideZlSkillShowScrollView()

local content="是否花费{0}{1}解锁{2}灵阵"

local type=self.selectType
local costItemId=cost[1]
local costItemNum=cost[2]
local itemIconName=iconHelper.getIconName(costItemId)
local iconStr=chatEmotHelper.getIconEmotMesg(itemIconName,36)
content=FMT.fmt(content,iconStr,cost[2],zlTypeList[self.selectType].name)

local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function(...)
moneySystem:useMoney(costItemId,costItemNum,function()
UIHuanJingControl:req_unlock_zhenling(type)
end,WARNING_TYPE.eWarning)

end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIHuanJingZhenLingChallengeWin:onCloseBtn()
UIHuanJingControl:closeUI(nil,true)
end


function UIHuanJingZhenLingChallengeWin:testFreshModel(index)
self:refreshLeftRoot(index)
end