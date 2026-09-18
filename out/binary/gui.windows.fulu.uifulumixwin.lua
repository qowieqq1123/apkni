







def_class("UIFuLuMixWin",UIWindowBase)









function UIFuLuMixWin:bindComponents()

self.root=UIObject.get(self,0)
self.flyIcon=UIImage.get(self,1)
self.selectFuLu=UIObject.get(self,2)
self.addBtn=UIButton.get(self,3)
self.fenjie=UIButton.get(self,4)
self.handbook=UIButton.get(self,5)
self.btnSwitch=UIObject.get(self,6)
self.pause=UIImage.get(self,7)
self.btnSelect=UIObject.get(self,8)
self.lockImg=UIObject.get(self,9)
self.targetItem=UIObject.get(self,10)
self.name=UIText.get(self,11)
self.changeBtn=UIButton.get(self,12)
self.materials=UIObject.get(self,13)
self.wieghtRoot=UIObject.get(self,14)
self.quickBtn=UIButton.get(self,15)
self.stepPBRoot=UIObject.get(self,16)
self.zhifuBtn=UIButton.get(self,17)
self.hbReddot=UIObject.get(self,18)
self.lockText=UIText.get(self,19)
self.orangeRoot=UIObject.get(self,20)
self.purpleRoot=UIObject.get(self,21)
self.blueRoot=UIObject.get(self,22)
self.greenRoot=UIObject.get(self,23)
self.btnWieghtRule=UIButton.get(self,24)
self.redRoot=UIObject.get(self,25)
self.stepProgressBar=UIObject.get(self,26)
self.receiveBtn=UIButton.get(self,27)
self.stepCount=UIText.get(self,28)
self.addMatBtn=UIButton.get(self,29)
self.materialsItem_3=UIObject.get(self,30)
self.materialsItem_2=UIObject.get(self,31)
self.materialsItem_1=UIObject.get(self,32)
self.fzMatText=UIObject.get(self,33)
self.costMoneyRoot=UIObject.get(self,34)
self.stepTime=UIText.get(self,35)
self.moneyIcon=UIObject.get(self,36)
self.moneyValue=UIText.get(self,37)
self.rewardCount=UIText.get(self,38)
self.dzName=UIText.get(self,39)
self.skill=UIText.get(self,40)
self.scrollView2=UIObject.get(self,41)
self.rewardIcon=UIImage.get(self,42)
self.diziLock=UIText.get(self,43)
self.diziInfo=UIObject.get(self,44)
self.qipao=UIButton.get(self,45)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.fenjie:setButtonClick(function()self:onFenjie()end)

self.handbook:setButtonClick(function()self:onHandbook()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)

self.zhifuBtn:setButtonClick(function()self:onZhifuBtn()end)

self.btnWieghtRule:setButtonClick(function()self:onBtnWieghtRule()end)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)

self.addMatBtn:setButtonClick(function()self:onAddMatBtn()end)

self.qipao:setButtonClick(function()self:onQipao()end)
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
}



end


function UIFuLuMixWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.flyIcon);self.flyIcon=nil;
_UIObject_release(self.selectFuLu);self.selectFuLu=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.fenjie);self.fenjie=nil;
_UIObject_release(self.handbook);self.handbook=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.pause);self.pause=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.lockImg);self.lockImg=nil;
_UIObject_release(self.targetItem);self.targetItem=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.wieghtRoot);self.wieghtRoot=nil;
_UIObject_release(self.quickBtn);self.quickBtn=nil;
_UIObject_release(self.stepPBRoot);self.stepPBRoot=nil;
_UIObject_release(self.zhifuBtn);self.zhifuBtn=nil;
_UIObject_release(self.hbReddot);self.hbReddot=nil;
_UIObject_release(self.lockText);self.lockText=nil;
_UIObject_release(self.orangeRoot);self.orangeRoot=nil;
_UIObject_release(self.purpleRoot);self.purpleRoot=nil;
_UIObject_release(self.blueRoot);self.blueRoot=nil;
_UIObject_release(self.greenRoot);self.greenRoot=nil;
_UIObject_release(self.btnWieghtRule);self.btnWieghtRule=nil;
_UIObject_release(self.redRoot);self.redRoot=nil;
_UIObject_release(self.stepProgressBar);self.stepProgressBar=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.stepCount);self.stepCount=nil;
_UIObject_release(self.addMatBtn);self.addMatBtn=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.fzMatText);self.fzMatText=nil;
_UIObject_release(self.costMoneyRoot);self.costMoneyRoot=nil;
_UIObject_release(self.stepTime);self.stepTime=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyValue);self.moneyValue=nil;
_UIObject_release(self.rewardCount);self.rewardCount=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.rewardIcon);self.rewardIcon=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.qipao);self.qipao=nil;
self.materialsItem=nil;
end

















local _this

local fuluABName='ui/windows/fulu/sharedtextures/fulufang.ab'
local quickImageName=
{
[3]='image_fulukuang_3',
[4]='image_fulukuang_4',
[5]='image_fulukuang_2',
}


function UIFuLuMixWin:onLoaded(...)
self:bindComponents()
_this=self

self.weightWidgetList={
self.greenRoot,
self.blueRoot,
self.purpleRoot,
self.orangeRoot,
self.redRoot
}

self.costMoneyRoot:setActive(false)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UIFuLuMixWin:__delete()
_this=nil
tempDataControl:recordWinData('UIFuLuMixWin',nil)

uiAIManager:removeUIInstance(self.currDZ)
uiAIManager:clearUIWinData('UIFuLuMixWin')
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end




function UIFuLuMixWin:onShow(argtable,afterOnloaded)
local page
if argtable then
page=argtable.args and argtable.args.page
local guid=argtable.entityId
self.entityId=guid
self.bdData=zongmenModel:findBuildingByEntityId(guid)
self.sfId=zongmenModel:getMountainId()
self.pData=zongmenModel:countManufacturePercentByType(self.bdData,edzFuncSpecialityType.eSpeciality_fulufang2)
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.dzId=self.bdData.dizi_id
self.ubdId=self.bdData.un_build_id
end
self:refreshDzInfo()
self:refreshMainPanel()
self:refreshHandBookRoddot()

if page then
self:showPage(page)
end
end

function UIFuLuMixWin:onShowArgRecv(argtable)
local oldId=self.entityId
local newId=argtable.entityId
if newId~=oldId then
self:stopAllNotify()
self:stopAllTimer()
self:stopProduceTimer()
self:__delete()
self:onLoaded()
self:onShow(argtable)
end
end

function UIFuLuMixWin:showPage(page)
if page==1 then
self:showSelectWin(SEC_FULL_TAB_TYPE.fuluFuBao)
elseif page==2 then
self:showSelectWin(SEC_FULL_TAB_TYPE.fuluXianFu)
elseif page==3 then
self:onHandbook()
elseif page==4 then
self:onFenjie()
end
end


function UIFuLuMixWin:onHide()

end

function UIFuLuMixWin:getDZId()
local dzid=self.bdData.dizi_id
if tostring(dzId)=='0'then return end
return dzid
end

function UIFuLuMixWin:onClickSelect()
if tostring(self.bdData.dizi_id)~='0'then
if self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
end
end
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eManager,dzSelectEffectType.ePlan,2)
end

function UIFuLuMixWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.replaceDisciple then
_this.dzId=arg1
zongmenModel:countManufacturePercent(_this.bdData)
_this:refreshDzInfo()
_this:refreshMainPanel()
end
end

function UIFuLuMixWin:refreshDzInfo()
local dzId=self.dzId

local name=''
local haveDz=tostring(dzId)~='0'
self.diziLock:setActive(not haveDz)
self.diziInfo:setActive(haveDz)
self.btnSelect:setActive(not haveDz)
self.btnSwitch:setActive(haveDz)
if haveDz then
name=UIDiscipleModel:getDiscipleName(dzId)
local skill_id=self.buildConfig.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
self.skill:setText(string.format('%s：%s级',skill_cfg.name,level))
end

self.dizi_speciality=discipleSelectController.getSpeciallistByBuild(dzId,self.buildConfig.build_type,2)
local haveSpeciality=self.dizi_speciality~=nil and#self.dizi_speciality>0
self.scrollView2:setActive(haveSpeciality)
if haveSpeciality then
self.scrollView2:setChildScrollViewInit(0,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)
self.scrollView2:setChildScrollViewCreateGrids(#self.dizi_speciality,0)
local grids=self.scrollView2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.dizi_speciality[i]
UIDiscipleModel.refreshSpecialityItemEx(item,data)
end
end


end
self.dzName:setText(FMT.fmt('执事弟子：<color=#7d3b17>{0}</color>',name))

self:refreshDzModel()
end

function UIFuLuMixWin:refreshDzModel()
local dzId=self.dzId
local state=UIDiscipleModel:getDiscipleState(dzId)or nil
if state==nil or state==DISCIPLE_STATE_TYPE.edsDispatch then
self.pause:setActive(true)
return
end
self.pause:setActive(false)

uiAIManager:removeUIInstance(self.currDZ)
self.currDZ=nil
self.leftPos={-316,-270}
if tostring(dzId)~='0'then
self:createDZ(self.bdData.dizi_id,self.leftPos,function(bt)
self.currDZ=bt
end)
end
end

function UIFuLuMixWin:createDZ(dzId,pos,callback)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=0,
leftPos=self.leftPos,
rightPos={-196,-270},
UIstateId=1,
waitspeak=0,
}
local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])





local otherData={
weaponslot='maobislotname',
}
uiAIManager:createUIDisciple('UIFuLuMixWin','bt_ui_fulu',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end


function UIFuLuMixWin:getSpeakText(bt,tkey)
local dzId=self.dzId
local str=''
if self.fuluType then
local voc=UIDiscipleModel:getDiscipleJob(dzId)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'fulu')
local speakStr=speakList[math.random(1,#speakList)]or''
str=speakStr
else
str='请选择合适的符箓配方'
end
bt:setSharedVar(tkey,str)
end

function UIFuLuMixWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView2:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.dzId,config=data})
end

function UIFuLuMixWin:showYuFuReward()
local pdata=UIFuLuFangModel:getProduceData(self.bdData.un_build_id)
if pdata then
local cddata=buildingCDControl:getCDData(buildingCDType.zhifu,self.bdData.un_build_id)
if cddata.currStep>pdata.rec_cnt then
self.qipao:setActive(true)
local icon=iconHelper.getIconName(self.config.itemId)
self.rewardIcon:setChildIcon(icon,true)
self.rewardCount:setText(cddata.currStep-pdata.rec_cnt)
return
end
end
self.qipao:setActive(false)
end

function UIFuLuMixWin:playFlyIcon()
self.flyIcon:setActive(true)
local icon=iconHelper.getIconName(self.config.itemId)
self.flyIcon:setChildIcon(icon,true)
local spos=self.targetItem:getChildPosition()
self.flyIcon:setChildPosition(spos)
local tpos=self.qipao:getChildPosition()
local tweener=self.flyIcon:setChildDOJump(tpos,2.5,1,1.5,function()
if _this then
self.flyIcon:setActive(false)
self:showYuFuReward()
end
end)
tweener:SetEase(_Ease.InSine)
end

function UIFuLuMixWin:resetProducePanel(pdata)
self.stepPBRoot:setActive(true)
self.materials:setActive(false)
self.changeBtn:setActive(false)
self.addBtn:setActive(false)
self.zhifuBtn:setActive(false)
self.selectFuLu:setActive(true)

self.fuluType=FULU_TAB_TYPE.eFuBao

local yfId=pdata.yufu_id
local cfg=cfgHelper.get1(cfg_yufufangconfig_get,yfId)
self.config=cfg
widgetHelper.setNormalRewardItem(self.winlua,self.targetItem:getID(),{cfg.itemId,0,clickFunc=function()end})
self.name:setText(cfg.name)

self:stopProduceTimer()
local cddataS=buildingCDControl:getCDData(buildingCDType.zhifu,self.bdData.un_build_id)
local playStep=cddataS.currStep
local percent=1
local tick=function()
local cddata=buildingCDControl:getCDData(buildingCDType.zhifu,self.bdData.un_build_id)
if cddata.isPause and not cddata.complete then
self.stepProgressBar:setChildUIProgressbar(1,1,false)
self.stepTime:setText('制符暂停中')
self.stepCount:setText(FMT.fmt('炼制中：{0}/{1}',cddata.currStep,cddata.makeNum))
else
if cddata.currStep>playStep then
self:playFlyIcon()
playStep=cddata.currStep
end
local showAnim=cddata.stepPercent>percent
percent=cddata.stepPercent
local dt=cddata.stepDTime
if showAnim then
dt=dt+1
end
if cddata.complete then
self.receiveBtn:setActive(true)
self.stepProgressBar:setActive(false)
self.stepCount:setText('制符完成')
self:stopProduceTimer()
else
self.stepProgressBar:setChildUIProgressbar(dt,cddata.stepTime,showAnim)
self.stepTime:setText(timeHelper.format_time_stamp11(cddata.cd))
self.stepCount:setText(FMT.fmt('炼制中：{0}/{1}',cddata.currStep,cddata.makeNum))
end
end
end
self.receiveBtn:setActive(false)
self.stepProgressBar:setActive(true)
self.ptimer=self:setTimer(1,0,tick)
tick()

self:freshWeight(false)
end

function UIFuLuMixWin:stopProduceTimer()
if self.ptimer then
self:stopTimerByID(self.ptimer)
self.ptimer=nil
end
end

function UIFuLuMixWin:refreshMainPanel()
local pdata=UIFuLuFangModel:getProduceData(self.bdData.un_build_id)
if pdata then
self:resetProducePanel(pdata)
else
self:refreshPanelState()
end
self:showYuFuReward()
end

function UIFuLuMixWin:refreshPanelState(args)
local selected=args~=nil
self.addBtn:setActive(not selected)
self.selectFuLu:setActive(selected)
self.stepPBRoot:setActive(false)
self.changeBtn:setActive(true)
self.addBtn:setActive(true)
self.zhifuBtn:setActive(true)
self.materials:setActive(true)
self.quickBtn:setActive(false)
if selected then
self.fuluType=args[1]
self.config=args[2]
self.spMatItemId=nil




self:refreshInfo()
end

self:freshWeight(true)
end

function UIFuLuMixWin:refreshInfo()










local clickFunc=function()
self:onAddBtn()
end
widgetHelper.setNormalRewardItem(self.winlua,self.targetItem:getID(),{self.config.itemId,0,clickFunc=clickFunc})
self.name:setText(self.config.name)


self:refreshCostList()



























self:showQuickBtn()
end

function UIFuLuMixWin:refreshCostList()
local costList=self:getCostList()
local costs=costList.norCost
local percent=self.pData[1]or 0
for i=1,2 do
local data=costs[i+1]
local item=self.materialsItem[i]
if data then
item:setActive(true)
local id=data[1]
local count=data[2]
if moneyConfig.isMoney(id)then
count=math.ceil(count*(1+percent*0.01))
end
widgetHelper.setNormalRewardItem(self.winlua,item:getID(),{id,count,showStage=true,checkAmount=true})
else
item:setActive(false)
end
end

self.costMoneyRoot:setActive(true)
local mtype=costs[1][1]
local need=costs[1][2]
need=need*(1+(self.pData[1]or 0)*0.01)
self.moneyIcon:setIcon(moneyModel.getIconNameEx(mtype),true)
local have=moneyModel.getMoney(mtype)
if have<need then
self.moneyValue:setText(FMT.fmt('<color=#c82c2c>{0}</color>',need))
else
self.moneyValue:setText(need)
end

if costList.spCost then
self.fzMatText:setActive(true)
self:setSPMatItem(self.spMatItemId)
else
local useSPMat=self.fuluType==FULU_TAB_TYPE.eFuBao
self.materialsItem_3:setActive(false)
self.addMatBtn:setActive(useSPMat)
self.fzMatText:setActive(useSPMat)
end
end

function UIFuLuMixWin:onClickMaterialItem(index)
local costs=self.config.cost
local cost=costs[index]
local itemid=cost[1]
if itemid==-1 then
return
end
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eFuluMake,itemid=itemid})
else
loggerUtil.logErrFMT('没有找到此道具：',itemid)
end
end

function UIFuLuMixWin:refreshHandBookRoddot()
local hbRodot=UIFuLuFangModel:checkHaveReward()
self.hbReddot:setActive(hbRodot)
end

function UIFuLuMixWin:showQuickBtn()

















if self.fuluType==FULU_TAB_TYPE.eXianLu then
local level=UIFuLuFangModel:getRating(self.config.id)
local need=cfgHelper.get2(cfg_fubaofangbasicconfig_get,1,'qm_level')
self.quickBtn:setActive(level>=need)
else
self.quickBtn:setActive(false)
end
end

function UIFuLuMixWin:setSPMatItem(itemId)
self.spMatItemId=itemId
local count=self.config.supply_costs[itemId]
local clickFunc=function()
self:onAddMatBtn()
end
self.materialsItem_3:setActive(true)
widgetHelper.setNormalRewardItem(self.winlua,self.materialsItem_3:getID(),{itemId,count,showStage=true,clickFunc=clickFunc,checkAmount=true})
self.addMatBtn:setActive(false)
self:freshWeight(true)
end


function UIFuLuMixWin:onFenjie()
UIManager:showWindow('UIFuLuFJWin')
end

function UIFuLuMixWin:onAddBtn()
if tostring(self.dzId)=='0'then
UIManager.error('未安排弟子')
return
end
local state=UIDiscipleModel:getDiscipleState(self.dzId)
if state==DISCIPLE_STATE_TYPE.eChuiWei then
UIManager.error('弟子已垂危，不堪重负')
return
end
if state==DISCIPLE_STATE_TYPE.edsDispatch then
UIManager.error('弟子派遣中')
return
end
self:showSelectWin(SEC_FULL_TAB_TYPE.fuluFuBao)
end

function UIFuLuMixWin:showSelectWin(stype)
tempDataControl:recordWinData('UIFuLuMixWin',{ubdId=self.ubdId,pData=self.pData})
oneTabScreenController:openTabUI(stype,{})
end

function UIFuLuMixWin:getCostList()
local costs=self.config.cost
local list={}
for i,v in ipairs(costs)do
table.insert(list,v)
end
list.norCost=costs
if self.spMatItemId then
local count=self.config.supply_costs[self.spMatItemId]
local spCost={self.spMatItemId,count}
table.insert(list,spCost)
list.spCost=spCost
end
return list
end

function UIFuLuMixWin:checkLianzhi()
if not UIDiscipleModel:checkDZStateToDoSomething(self.dzId,eCheckDiscipleStateOpType.eYuFu,false)then
return false
end






return true
end

function UIFuLuMixWin:onZhifuBtn()
if not UIDiscipleModel:checkDZStateToDoSomething(self.dzId,eCheckDiscipleStateOpType.eYuFu,true)then
return
end

local bd_tybe_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
local skill_id=bd_tybe_cfg.pro_skill_id
local level=UIDiscipleModel:getDiscipleJobLevel(self.bdData.dizi_id,skill_id)
if level<self.config.need_fl_lvl then
UIManager.error(FMT.fmt('弟子符箓等级须达到{0}级',self.config.need_fl_lvl))
return
end

local cost=self:getCostList()
local percent=self.pData[1]or 0
if self.fuluType==FULU_TAB_TYPE.eFuBao then
local num=UIFuLuFangModel:getCanMakeNum(cost,percent)
if num>0 then
if num>1 then
UIManager:showWindow('UIFuLuMatUseWin',{id=self.config.id,cfg=self.config,cost=cost,
bdData=self.bdData,pData=self.pData})
else
local spItemId=cost.spCost and cost.spCost[1]or 0
local ubdId=self.bdData.un_build_id
UIFullFuLuFangControl:reqMakeYuFu(mapIdType.zhufeng,ubdId,self.config.id,spItemId,1)
end
else
UIFuLuFangModel:checkCanMake(cost,true,1,percent)
end
else
if UIFuLuFangModel:checkCanMake(cost,true,1,percent)then
UIManager:showWindow('UIFuBaoDrawWin',{self.config.id,self.sfId,self.bdData.un_build_id,self.dzId})
end
end









end

function UIFuLuMixWin:onHandbook()
UIManager:showWindow('UIFuBaoHBWin')
end

function UIFuLuMixWin:onChangeBtn()
self:onAddBtn()
end

function UIFuLuMixWin:onQuickBtn()
local level=UIFuLuFangModel:getRating(self.config.id)
UIManager:showWindow('UIFuBaoQuickMakeWin',{self.sfId,self.bdData.un_build_id,level,self.config,pData=self.pData})
end

function UIFuLuMixWin:onAddMatBtn()
UIManager:showWindow('UIFuLuMatSelectWin',{id=self.config.id})
end

function UIFuLuMixWin:onQipao()
local pdata=UIFuLuFangModel:getProduceData(self.bdData.un_build_id)
if pdata then
local cddata=buildingCDControl:getCDData(buildingCDType.zhifu,self.bdData.un_build_id)
if cddata.currStep>pdata.rec_cnt then
local count=cddata.currStep-pdata.rec_cnt
UIFullFuLuFangControl:reqReceiveYuFu(mapIdType.zhufeng,self.bdData.un_build_id,count)
end
end
end

function UIFuLuMixWin:onReceiveBtn()
self:onQipao()
end

function UIFuLuMixWin:onBtnWieghtRule()
local d={}
d.showType=2
d.pos=Vector2.New(15,30)
d.posWidget=self.winlua
d.posWidgetIndex=self.btnWieghtRule:getID()
d.name='fulu_wieght_rule_%d'
d.callback=function()
self.btnWieghtRule:setSprite(globalABLookup.global,'button_tyjieshao_1')
end
UIManager:showWindow('UIConditionTipsFour',d)
self.btnWieghtRule:setSprite(globalABLookup.global,'button_tyjieshao_2')
end

function UIFuLuMixWin:countWeightList()
local bd_tybe_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
local skill_id=bd_tybe_cfg.pro_skill_id
local level=UIDiscipleModel:getDiscipleJobLevel(self.bdData.dizi_id,skill_id)

local calc_weight=self.config.calc_weight
local wdata
for i,v in ipairs(calc_weight)do
if level>=v[1]and level<=v[2]then
wdata=v[3]
break
end
end
if not wdata then
return nil
end
local checkLevel=self.config.standard_fl_lvl
local lvDiff=level-checkLevel
local list={}
local tWeight=0
local temp={}
for i,v in ipairs(wdata)do
if v[2]<0 and level<checkLevel then
list[i]=v[1]+v[2]*lvDiff
elseif v[2]>0 and level>checkLevel then
list[i]=v[1]+v[2]*lvDiff
else
list[i]=v[1]
end
tWeight=tWeight+list[i]
end

if self.fuluType==FULU_TAB_TYPE.eXianLu then
local random_item_conf=self.config.random_item_conf
local rWeight=random_item_conf[2][1]
for i,v in ipairs(rWeight)do
if list[i]+v<0 then
v=list[i]*-1
end
list[i]=list[i]+v
tWeight=tWeight+v
end
end


for i,v in ipairs(list)do
temp[i]=math.floor(v/tWeight*10000)
end

if self.spMatItemId then
local supply_item=cfgHelper.get2(cfg_fubaofangbasicconfig_get,1,'supply_item')
local itemWeight=supply_item[self.spMatItemId]
local total=0


for i,v in ipairs(itemWeight)do
temp[i]=temp[i]+v
total=total+v
end


for i,v in ipairs(temp)do
if v>0 then
if total>v then
temp[i]=0
total=total-v
else
temp[i]=temp[i]-total
total=0
break
end
end
end
end


tWeight=0
for i,v in ipairs(temp)do
tWeight=tWeight+v
end

local precentArray={}
local left=100
local lastColor
for i=#temp,1,-1 do
local val=temp[i]
local precent=math.floor(val*1000/tWeight)/10
precentArray[i]=precent
left=left-precent
if val>0 then
lastColor=i
end
end
if left>0 then
precentArray[lastColor]=precentArray[lastColor]+left
end

return precentArray
end

function UIFuLuMixWin:freshWeight(flag)



if not self.config then
flag=false
end
if flag then
local weightList=self:countWeightList()
if weightList then
for i=1,5 do
local color=i
local cmp=self.weightWidgetList[i]
local num=weightList[color]or 0
num=string.format('%.1f',num)
num=tonumber(num)
local widget=cmp:getChildWidgetBase()
widget:SetChildText(0,num)
end
else
flag=false
end
end
self.wieghtRoot:setActive(flag)
self.btnWieghtRule:setActive(flag and self.fuluType==FULU_TAB_TYPE.eXianLu)
end