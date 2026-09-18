







def_class("UIFairWin",UIWindowBase)









function UIFairWin:bindComponents()

self.root=UIObject.get(self,0)
self.hulu=UIObject.get(self,1)
self.dzModel=UIObject.get(self,2)
self.setupBtn=UIButton.get(self,3)
self.fangshiModel=UIObject.get(self,4)
self.payBtnCostTxt=UIText.get(self,5)
self.payBtnCostImg=UIImage.get(self,6)
self.adImg=UIImage.get(self,7)
self.adBtnText=UIText.get(self,8)
self.freeBtnText=UIText.get(self,9)
self.payBtnCost=UIObject.get(self,10)
self.payBtnText=UIText.get(self,11)
self.dzName=UIText.get(self,12)
self.skill=UIText.get(self,13)
self.scrollView2=UIObject.get(self,14)
self.mutiaoScroller=UIObject.get(self,15)
self.adBtn=UIButton.get(self,16)
self.payBtn=UIButton.get(self,17)
self.freeBtn=UIButton.get(self,18)
self.txtSelect=UIText.get(self,19)
self.btnSelectReddot=UIObject.get(self,20)
self.btnSwitchReddot=UIObject.get(self,21)
self.zhekouInfoBtn=UIButton.get(self,22)
self.diziInfo=UIObject.get(self,23)
self.diziLock=UIText.get(self,24)
self.content=UIObject.get(self,25)
self.btnsPanel=UIObject.get(self,26)
self.goodsScrollview=UIObject.get(self,27)
self.btnSelect=UIButton.get(self,28)
self.btnSwitch=UIButton.get(self,29)
self.timeTitle=UIText.get(self,30)
self.timeText=UIText.get(self,31)

self.setupBtn:setButtonClick(function()self:onSetupBtn()end)

self.adBtn:setButtonClick(function()self:onAdBtn()end)

self.payBtn:setButtonClick(function()self:onPayBtn()end)

self.freeBtn:setButtonClick(function()self:onFreeBtn()end)

self.zhekouInfoBtn:setButtonClick(function()self:onZhekouInfoBtn()end)

self.btnSelect:setButtonClick(function()self:onBtnSelect()end)

self.btnSwitch:setButtonClick(function()self:onBtnSwitch()end)



end


function UIFairWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.hulu);self.hulu=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.setupBtn);self.setupBtn=nil;
_UIObject_release(self.fangshiModel);self.fangshiModel=nil;
_UIObject_release(self.payBtnCostTxt);self.payBtnCostTxt=nil;
_UIObject_release(self.payBtnCostImg);self.payBtnCostImg=nil;
_UIObject_release(self.adImg);self.adImg=nil;
_UIObject_release(self.adBtnText);self.adBtnText=nil;
_UIObject_release(self.freeBtnText);self.freeBtnText=nil;
_UIObject_release(self.payBtnCost);self.payBtnCost=nil;
_UIObject_release(self.payBtnText);self.payBtnText=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.mutiaoScroller);self.mutiaoScroller=nil;
_UIObject_release(self.adBtn);self.adBtn=nil;
_UIObject_release(self.payBtn);self.payBtn=nil;
_UIObject_release(self.freeBtn);self.freeBtn=nil;
_UIObject_release(self.txtSelect);self.txtSelect=nil;
_UIObject_release(self.btnSelectReddot);self.btnSelectReddot=nil;
_UIObject_release(self.btnSwitchReddot);self.btnSwitchReddot=nil;
_UIObject_release(self.zhekouInfoBtn);self.zhekouInfoBtn=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.btnsPanel);self.btnsPanel=nil;
_UIObject_release(self.goodsScrollview);self.goodsScrollview=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.timeTitle);self.timeTitle=nil;
_UIObject_release(self.timeText);self.timeText=nil;
end


















local _this
local _initModel

local _goods_cmp_index={
txt_money=0,
img_money=1,
image_isbuy=2,
zhekouCor=3,
discount=4,
line=5,
special=6,
item=7,
fightup=8,
}



function UIFairWin:onLoaded(...)
self:bindComponents()
_this=self
self:initUI()
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)

local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]

local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.root:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)
local showSetup=guildOrderModel:checkOrderActive(GUILD_ORDER_TYPE.eAutoBuy)
self.setupBtn:setActive(showSetup)
self.setupBtn:setChildCanvas(sortLayer,sortOrder+4)
end


function UIFairWin:__delete()
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end
_this=nil
_initModel=nil
roleAudioController:stopRoleSpeak()

uiAIManager:clearUIWinData('UIFairWin')
self:stopFairTimer()
self:killAllDoTween()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function UIFairWin:refreshAfterItemUse(utype,arg1,arg2)
self:refreshUI()
end




function UIFairWin:onShow(argtable,afterOnloaded)
if argtable then
self:updateData(argtable)
end
self:refreshUI()


self:delayDo(0.6,function(...)
local haveDz=tostring(self.dzId)~='0'
local anim=haveDz and 2063 or 2051
self.fangshiModel:setChildUIModelShowTarget(2031,1,nil,anim)
self.hulu:setChildUIModelShowTarget(2033,1,nil,2052)
end)
end

function UIFairWin:onShowArgRecv(argtable)
if argtable then
self:updateData(argtable)
end
self:refreshUI()
end


function UIFairWin:onHide()

end

function UIFairWin:refreshCatAction()
local haveDz=tostring(self.dzId)~='0'
if haveDz then
self.fangshiModel:setChildModelAnimationState(2058)
else
self.fangshiModel:setChildModelAnimationState(2052)
end
end



function UIFairWin:updateData(argtable)

local guid=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)

self.sysData=fairModel:get_sys_data()
self.fairType=eFairType.eBooth
self.buildData=zongmenModel:getBuildingData(self.bdData.un_build_id)
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.buildData.build_id)
self.bdType=self.bdData.build_id
self.dzId=self.buildData.dizi_id
end


function UIFairWin:initUI()
local clickEvent=function(...)
self:onClickItemCallback(...)
end
self.goodsScrollview:setChildScrollViewInit(0.5,true,clickEvent,nil)
end

function UIFairWin:refreshUI()
self:refreshLeftPanel()
self:refreshGoodsUI()
end

function UIFairWin:refreshGoodsUI()
self:initGoods()
self:refreshBtns()
self:refreshTime()
end

function UIFairWin:refreshBtns()

local hasFreeCount=fairModel:has_free_flush_count()
local haveAdCount=fairModel:has_Ad_flush_count()
self.freeBtn:setActive(hasFreeCount)
self.adBtn:setActive(haveAdCount and not hasFreeCount)
self.payBtn:setActive(not hasFreeCount and not haveAdCount)
if haveAdCount and not hasFreeCount then
self.adImg:setSprite(globalABLookup.global,'icon_djguankanshipin')
end

if hasFreeCount then

local strFree='免费补货'
self.freeBtnText:setText(strFree)
else
local payTimesLimits=fairModel:get_booth_pay_flush_times_limit()
local nowTimes=fairModel:enough_pay_flush_count()
local remainTimes=payTimesLimits-nowTimes
local strPay=FMT.fmt("补货({0}/{1})",remainTimes,payTimesLimits)
self.payBtnText:setText(strPay)

local priceList=fairModel.get_booth_flush_price_list()
self.payBtnCost:setActive(nowTimes~=payTimesLimits)
if nowTimes<payTimesLimits then
local price=priceList[nowTimes+1]
local priceType=price[1]
local priceValue=price[2]
self.payBtnCostImg:setImageIcon(iconHelper.getIconName(priceType),false)
self.payBtnCostTxt:setText(priceValue)
self.payBtn:setChildImageExGray(false)
elseif nowTimes==payTimesLimits then
self.payBtn:setChildImageExGray(true)
else
self.payBtnCostImg:setImageIcon(iconHelper.getIconName(priceList[payTimesLimits][1]),false)
self.payBtnCostTxt:setText(priceList[payTimesLimits][2])
self.payBtn:setChildImageExGray(false)
end
end
end

function UIFairWin:refreshBoothTime()
local isFull=fairModel:is_enough_free_flush_count()
local freeCnt=fairModel:get_free_flush_count()
local freeLimit=fairModel.get_booth_free_flush_times_limit()
if isFull then

local timeStr=FMT.fmt('<color=#1C1919>补货次数{0}/{1}</color>\n次数已满',freeCnt,freeLimit)
self.timeText:setText(timeStr)
self:stopFairTimer()
else

local cd=fairModel:get_free_flush_cd()
local timeStr=FMT.fmt('<color=#1C1919>补货次数（{0}/{1}）</color>\n{2}',freeCnt,freeLimit,timeHelper.format_time_stamp2(math.floor(cd)))

self.timeText:setText(timeStr)
self:refreshBtns()
end
end

function UIFairWin:refreshTime()
local tick=function()
self:refreshBoothTime()
end
tick()
self:stopFairTimer()
self.fairTimer=self:setTimer(1,0,tick)
end

function UIFairWin:initGoods()
local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList or{}
local maxGoodsCount=#goodsList
local cols=2
self.goodsScrollview:setChildScrollViewCreateGrids(maxGoodsCount,cols)
self.mutiaoScroller:setChildScrollViewCreateGrids(math.ceil(maxGoodsCount/2),1)
self.needMoney={}
for i=1,maxGoodsCount do
self:flushGoods(i-1)
end
end

function UIFairWin:flushGoods(index)
local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList

local fairCfg=fairModel.get_booth_config(fairData.cfg_key_1,fairData.cfg_key_2)
local libIndex=goodsList[index+1].param_1
local isBuy=goodsList[index+1].param_2==1
local libType=goodsList[index+1].param_3
local item_lib=libType==1 and fairCfg.randomItem_lib or fairCfg.story_randomItem_lib
local libItem=item_lib[libIndex]
local shopItemId=libIndex
libItem=cfgHelper.get(cfg_fangshishopitemconfig_get,shopItemId,"Item_conf")
local slot=self.goodsScrollview:getChildScrollViewItemWidget(index)
if libItem==nil then
return
end


local itemId=libItem[1]
local itemCount=libItem[2]
local moneyType=libItem[3]
local moneyValue=libItem[4]
local distance=(100-libItem[5])
local israre=libItem[6]
local candistance=libItem[7]

local curMoney=itemsModel.getCount(moneyType)

self.dizi_zhekou=self.dizi_zhekou or 0



if isBuy then
slot:SetChildActive(_goods_cmp_index.img_money,not isBuy)
else
slot:SetChildIcon(_goods_cmp_index.img_money,iconHelper.getMoneyIconName(moneyType),false)
end

slot:SetChildActive(_goods_cmp_index.image_isbuy,isBuy)

slot:SetChildActive(_goods_cmp_index.special,israre==1)

slot:SetChildText(_goods_cmp_index.txt_money,curMoney<moneyValue and FMT.cfmt(FONT_COLOR.eRedColor,mathHelper.formatNumber(moneyValue))or mathHelper.formatNumber(moneyValue))

local showCount=itemCount>1 and itemCount or''
local item=fairData.itemList[index+1]
local conf={itemcount=showCount,showCountBG=showCount~='',nomalname=true}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(itemId)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=not isBuy
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isBuy
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isBuy
prop[PropIndex(DataPropKey.eWidgetActive,8)]=itemConfig.stage and itemConfig.stage>0 and true or false
slot:SetChildPropData(_goods_cmp_index.item,prop)
local widget=slot:GetChildWidgetBase(_goods_cmp_index.item)
local suitIconName=equipsHelper.getEquipSuitIcon(item)
widget:SetChildIcon(10,suitIconName,false)

if candistance~=0 and self.dizi_zhekou~=0 then
slot:SetChildText(_goods_cmp_index.discount,pfwindowslController:convertDiscount_yuenan(string.format('%.1f折',(distance-self.dizi_zhekou)/10)))

self.needMoney[index+1]=math.floor((moneyValue*(distance-self.dizi_zhekou)/100)+0.5)
local mv=mathHelper.formatNumber(self.needMoney[index+1])
slot:SetChildText(_goods_cmp_index.txt_money,curMoney<self.needMoney[index+1]and FMT.cfmt(FONT_COLOR.eRedColor,mv)or mv)
else
slot:SetChildText(_goods_cmp_index.discount,pfwindowslController:convertDiscount_yuenan(string.format('%d折',distance/10)))
self.needMoney[index+1]=math.floor(moneyValue*(distance/100)+0.5)
local mv=mathHelper.formatNumber(self.needMoney[index+1])
slot:SetChildText(_goods_cmp_index.txt_money,curMoney<self.needMoney[index+1]and FMT.cfmt(FONT_COLOR.eRedColor,mv)or mv)
end
slot:SetChildActive(_goods_cmp_index.zhekouCor,distance<100)

slot:SetBaseItemClickEvent(_goods_cmp_index.item,function(itemid,i,itemguid)
local attach=nil
if not isBuy then
attach={insertBtnList={TIPS_BTNS_TYPE.eBuy},buycallBack=function()
self:onClickItemCallback(1,index)
end}
end
self:onClickBaseItem(itemid,i,itemguid,attach)
end)


local showUp=not isBuy and fairModel:checkEquipFightUp(item)
slot:SetChildActive(_goods_cmp_index.fightup,showUp)
end

function UIFairWin:refreshGoods()
































































end


function UIFairWin:refreshLeftPanel()

local dzId=self.dzId

local name=''
local haveDz=tostring(dzId)~='0'
self.diziLock:setActive(not haveDz)
self.diziInfo:setActive(haveDz)
self.btnSelect:setActive(not haveDz)
self.btnSwitch:setActive(haveDz)

if haveDz then
local shake=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSwitchReddot:setActive(shake)
if shake then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.btnSwitch:getID())
else
self.winlua:SetChildDOTweenAnimation_DOPause(self.btnSwitch:getID())
self.btnSwitch:setRotation(0,0,0)
end
else
local reddot=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSelectReddot:setActive(reddot)
end

self.dizi_zhekou=nil
self.dizi_speciality=nil
if haveDz then

name=UIDiscipleModel:getDiscipleName(dzId)

local bd_tybe_cfg=cfg_monijybuildconfig_get(self.config.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local pro_skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local effectStr=discipleSelectController.getEffectDesc_fs(pro_skill_cfg,level)
local addEffect
if pro_skill_cfg.fangshi_discount then
addEffect=pro_skill_cfg.fangshi_discount[level]
end
if addEffect and addEffect>0 then
self.skill:setText(FMT.fmt('{0}：{1}级 <color=#549327>{2}</color>',pro_skill_cfg.name,level,effectStr))
self.dizi_zhekou=addEffect
else
self.skill:setText(FMT.fmt('{0}：{1}级',pro_skill_cfg.name,level))
end
end
self.dizi_speciality=discipleSelectController.getSpeciallistByBuild(dzId,bd_tybe_cfg.build_type)
if self.dizi_speciality~=nil and#self.dizi_speciality>0 then
self.scrollView2:setChildScrollViewInit(0.5,true,function(clicknum,i)
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
else
self.scrollView2:setChildScrollViewCreateGrids(0,0)
end
else
self.dizi_zhekou=nil
end
self.dzName:setText(FMT.fmt('执事弟子：<color=#7d3b17>{0}</color>',name))

if not _initModel then
_initModel=true
self:delayDo(0.5,function(...)
self:refreshDzModel()
end)
else
self:refreshDzModel()
end
end

function UIFairWin:refreshDzModel()
local dzId=self.dzId

uiAIManager:removeUIInstance(self.currDZ)
self.currDZ=nil
if tostring(dzId)~='0'then
self:createDZ(self.dzId,Vector2.New(-260,-226),function(bt)
self.currDZ=bt
end)
end
end

function UIFairWin:createDZ(dzId,pos,callback)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
standPos=0,
offset={0,0},
leftPos={-320,-226},
rightPos={-160,-226},
waitspeak=0,
}
local tran=self.dzModel:getCommonComponent('Transform')




uiAIManager:createUIDisciple('UIFairWin','bt_ui_fangshi',dzId,tran,pos,initData,nil,function(bt)
callback(bt)
end)
end


function UIFairWin:getSpeakText(bt,tkey)
local dzId=self.dzId
local voc=UIDiscipleModel:getDiscipleJob(dzId)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'fangshi')
local speakStr=speakList[math.random(1,#speakList)]
bt:setSharedVar(tkey,speakStr)
end




function UIFairWin:stopFairTimer()
if self.fairTimer then
self:stopTimerByID(self.fairTimer)
self.fairTimer=nil
end
end



function UIFairWin:checkBought(index)
local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList
if goodsList[index].param_2==1 then
UIManager.error("商品已被购买")
return true
end
return false
end

function UIFairWin:onClickItemCallback(clickNum,index)

index=index+1
if index==0 then
return
end
if self:checkBought(index)then
return
end
local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList
local fairCfg=fairModel.get_booth_config(fairData.cfg_key_1,fairData.cfg_key_2)
local libIndex=goodsList[index].param_1
local libType=goodsList[index].param_3
local item_lib=libType==1 and fairCfg.randomItem_lib or fairCfg.story_randomItem_lib
local libItem=item_lib[libIndex]

local shopItemId=libIndex
libItem=cfgHelper.get(cfg_fangshishopitemconfig_get,shopItemId,"Item_conf")

local moneyType=libItem[3]
local needValue=self.needMoney[index]


local showDiaLog=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eFangShiBuyDialog)
if not showDiaLog then
local iconname=iconHelper.getIconName(moneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local str=FMT.fmt('是否确认花费{0}{1} 购买此商品？',iconStr,needValue)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=str,
oktext='购买',
canceltext='取消',
allowclickBG=false,
okcallback=function(...)
local flag=moneySystem:useMoney(moneyType,needValue,function(...)
fairController:req_buy(_this.fairType,index)
_this.comfirmDialog:deleteSelf()
end,WARNING_TYPE.eWarning)
if not flag then

UIDiscipleController.doTriggerSomething(dzTriggerDoSomething.ePrivateMoney,{moneyType,needValue})
end
end,
showclosebtn=true,
choosetext='今日不再提示',
choosecallback=function(flag)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eFangShiBuyDialog,flag)
end,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
local flag=moneySystem:useMoney(moneyType,needValue,function(...)
fairController:req_buy(self.fairType,index)
end,WARNING_TYPE.eWarning)
if not flag then

UIDiscipleController.doTriggerSomething(dzTriggerDoSomething.ePrivateMoney,{moneyType,needValue})
end
end
end


function UIFairWin:onClickBaseItem(itemid,index,itemguid,attach)



















if itemsConfig.isGubao(itemid)then
gubaoController:gubaoShowTips(itemid)
return
end
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end

function UIFairWin.on_building_event(etype,sfId,bdId,args)
if etype==buildingEvent.replaceDisciple then
_this.dzId=args
_this:refreshUI()
_this:refreshCatAction()
end
end

function UIFairWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView2:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.bdData.dizi_id,config=data})
end
function UIFairWin:onFreeBtn()
if self.tweenPlaying then
return
end
fairController:req_refresh(eFairRefreshType.eFree)
end

function UIFairWin:onPayBtn()
if self.tweenPlaying then
return
end

local cb=function()
fairController:req_refresh(eFairRefreshType.ePay)
end
fairModel:is_enough_pay_flush(cb)



end

function UIFairWin:onAdBtn()
if self.tweenPlaying then
return
end

local id=fairModel.getAdid()
local sfId=self.sfId
local un_buildid=self.bdData.un_build_id
local ext=adController:getParam(sfId,un_buildid)

adController:showPlayADDialog(id,ext,nil,"是否观看广告或者使用{0}{1}进行补货")
end

function UIFairWin:onClickSelect()
if tostring(self.bdData.dizi_id)~='0'then
if self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑物正在建造中，不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
end
if self.bdData.plant_id>0 then
UIManager.error('建筑执行生产中, 不能更换弟子')
return
end
end
zongmenControl:showSelectManagerWin(self.sysData.mountain_id,self.bdData,dzSelectWinOpenType.eFangShi,dzSelectEffectType.eFangShi)
end

function UIFairWin:onBtnSelect()
self:onClickSelect()
end

function UIFairWin:onBtnSwitch()
self:onClickSelect()
end

function UIFairWin:playBoothItemDotween()
self.tweenList={}
self:killAllDoTween()
local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList
local delayTime=0
local rTimeList={0.4,0.5,0.7}
self.goodsScrollview:setChildScrollViewCreateGrids(#goodsList,2)
self.tweenPlaying=true
local comCall=function(...)
self.tweenPlaying=false
end
for i=1,#goodsList,2 do
delayTime=(i-1)*0.1
local rotateTime=rTimeList[math.ceil(i/2)]or 1
local cb
if i+1>=#goodsList then
cb=comCall
end
local item1=self.goodsScrollview:getChildScrollViewItemWidget(i-1)
self.tweenList[i]=item1:SetChildDOLocalRotate(-1,Vector3(360,0,0),rotateTime,DG.Tweening.RotateMode.FastBeyond360,cb)
self.tweenList[i]:SetDelay(delayTime)

local item2=self.goodsScrollview:getChildScrollViewItemWidget(i)
if item2 then
self.tweenList[i+1]=item2:SetChildDOLocalRotate(-1,Vector3(360,0,0),rotateTime,DG.Tweening.RotateMode.FastBeyond360)
self.tweenList[i+1]:SetDelay(delayTime)
end

self:delayDo(delayTime+rotateTime/2,function(...)
self:flushGoods(i-1)
self:flushGoods(i)
end)
end
self:refreshBtns()
self:refreshTime()
end

function UIFairWin:killAllDoTween()
if self.tweenList then
for i=1,#self.tweenList do
local t=self.tweenList[i]
if t then
t:Kill(false)
self.tweenList[i]=nil
end
end
end
end

function UIFairWin:refreshZheKouInfoImg()
self.winlua:SetChildCSImageSprite(self.zhekouInfoBtn:getID(),globalABLookup.global,'button_tyjieshao_1')
end

function UIFairWin:onZhekouInfoBtn()
self.winlua:SetChildCSImageSprite(self.zhekouInfoBtn:getID(),globalABLookup.global,'button_tyjieshao_2')
UIManager:showWindow('UIFairZheKouInfoTips',{guid=self.dzId})
end

local pageWinList={
[1]="UICommonPageWin",
[2]="UICommonPageTwoWin",
}
function UIFairWin:onSetupBtn()


local setupWin=cfgHelper.get2(cfg_guildorderconfig_get,GUILD_ORDER_TYPE.eAutoBuy,'setupWin')
if setupWin==nil then return end

local winname=setupWin[1]
local titleName=setupWin[2]
local pageType=setupWin[3]or 1
local pageWinName=pageWinList[pageType]
local args={}
args.titleName=titleName
args.pos=3
args.showBG=true
args.extraWin=winname
args.extraParams={}
self:showWindow(pageWinName,args)
end
