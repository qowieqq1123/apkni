







def_class("UIFabaoWin",UIWindowBase)









function UIFabaoWin:bindComponents()

self.root=UIObject.get(self,0)
self.selectPanel=UIObject.get(self,1)
self.selectBg=UIButton.get(self,2)
self.flyIcon=UIImage.get(self,3)
self.weightPanel=UIObject.get(self,4)
self.diziModel=UIObject.get(self,5)
self.rightPanel=UIObject.get(self,6)
self.batchCreateBtn=UIButton.get(self,7)
self.luzi=UIObject.get(self,8)
self.closeBtn=UIButton.get(self,9)
self.selectDesc=UIText.get(self,10)
self.item7=UIBaseItem.get(self,11)
self.wieghtRoot=UIObject.get(self,12)
self.attrPanel=UIObject.get(self,13)
self.moneyRoot=UIObject.get(self,14)
self.btnLianzhi=UIButton.get(self,15)
self.lianzhiRoot=UIObject.get(self,16)
self.item1=UIBaseItem.get(self,17)
self.costItems=UIObject.get(self,18)
self.item6=UIBaseItem.get(self,19)
self.nameBg=UIObject.get(self,20)
self.item5=UIBaseItem.get(self,21)
self.item3=UIBaseItem.get(self,22)
self.item2=UIBaseItem.get(self,23)
self.item4=UIBaseItem.get(self,24)
self.money1Root=UIObject.get(self,25)
self.money2Root=UIObject.get(self,26)
self.redRoot=UIObject.get(self,27)
self.orangeRoot=UIObject.get(self,28)
self.purpleRoot=UIObject.get(self,29)
self.blueRoot=UIObject.get(self,30)
self.greenRoot=UIObject.get(self,31)
self.weighthelp=UIButton.get(self,32)
self.lianzhiDesc=UIText.get(self,33)
self.progress=UIObject.get(self,34)
self.lianzhiTitle=UIText.get(self,35)
self.btnReward=UIButton.get(self,36)
self.btnStopLianzhi=UIButton.get(self,37)
self.attrScrollview=UIObject.get(self,38)
self.moneyIcon2=UIImage.get(self,39)
self.moneyVal2=UIText.get(self,40)
self.moneyVal1=UIText.get(self,41)
self.moneyIcon1=UIImage.get(self,42)
self.progressBar=UIProgressBarAni.get(self,43)
self.rewardCount=UIText.get(self,44)
self.selectEquip=UIObject.get(self,45)
self.lock=UIObject.get(self,46)
self.selectMaterilas=UIObject.get(self,47)
self.attrItem=UIObject.get(self,48)
self.shentongBtn=UIButton.get(self,49)
self.btnFuncTxt_3=UIText.get(self,50)
self.btnSelects_3=UIObject.get(self,51)
self.btnFuncTxt_5=UIText.get(self,52)
self.btnSelects_5=UIObject.get(self,53)
self.btnFuncTxt_4=UIText.get(self,54)
self.btnSelects_4=UIObject.get(self,55)
self.btnFuncTxt_1=UIText.get(self,56)
self.btnSelects_1=UIObject.get(self,57)
self.btnSelects_2=UIObject.get(self,58)
self.btnFuncTxt_2=UIText.get(self,59)
self.rewardIcon=UIImage.get(self,60)
self.btnMaterials=UIButton.get(self,61)
self.btnEquips=UIButton.get(self,62)
self.jingcuidesc=UIText.get(self,63)
self.attrCreater=UIObject.get(self,64)
self.shentong=UIObject.get(self,65)
self.dzName=UIText.get(self,66)
self.scrollView2=UIObject.get(self,67)
self.skill=UIText.get(self,68)
self.rightArrowImg=UIObject.get(self,69)
self.leftArrowImg=UIObject.get(self,70)
self.btnFunc_1=UIButton.get(self,71)
self.btnFunc_2=UIButton.get(self,72)
self.btnFunc_4=UIButton.get(self,73)
self.btnFunc_3=UIButton.get(self,74)
self.btnFunc_5=UIButton.get(self,75)
self.qipao=UIObject.get(self,76)
self.btnOnekey=UIButton.get(self,77)
self.btnReset=UIButton.get(self,78)
self.Content=UIObject.get(self,79)
self.ScrollView=UIScrollViewSlow.get(self,80)
self.Dropdown2=UIDropdownEx.get(self,81)
self.Dropdown1=UIDropdownEx.get(self,82)
self.titleRoot=UIObject.get(self,83)
self.tempSize=UIObject.get(self,84)
self.btnsRoot=UIObject.get(self,85)
self.attrContect=UIObject.get(self,86)
self.diziInfo=UIObject.get(self,87)
self.diziLock=UIText.get(self,88)
self.rightArrow=UIButton.get(self,89)
self.leftArrow=UIButton.get(self,90)
self.btnSelect=UIObject.get(self,91)
self.btnSwitch=UIObject.get(self,92)
self.weighthelp2=UIButton.get(self,93)

self.selectBg:setButtonClick(function()self:onSelectBg()end)

self.batchCreateBtn:setButtonClick(function()self:onBatchCreateBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.btnLianzhi:setButtonClick(function()self:onBtnLianzhi()end)

self.weighthelp:setButtonClick(function()self:onWeighthelp()end)

self.btnReward:setButtonClick(function()self:onBtnReward()end)

self.btnStopLianzhi:setButtonClick(function()self:onBtnStopLianzhi()end)

self.shentongBtn:setButtonClick(function()self:onShentongBtn()end)

self.btnMaterials:setButtonClick(function()self:onBtnMaterials()end)

self.btnEquips:setButtonClick(function()self:onBtnEquips()end)

self.btnFunc_1:setButtonClick(function()self:onBtnFunc_1()end)

self.btnFunc_2:setButtonClick(function()self:onBtnFunc_2()end)

self.btnFunc_4:setButtonClick(function()self:onBtnFunc_4()end)

self.btnFunc_3:setButtonClick(function()self:onBtnFunc_3()end)

self.btnFunc_5:setButtonClick(function()self:onBtnFunc_5()end)

self.btnOnekey:setButtonClick(function()self:onBtnOnekey()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.weighthelp2:setButtonClick(function()self:onWeighthelp2()end)
self.btnFuncTxt={
self.btnFuncTxt_1,
self.btnFuncTxt_2,
self.btnFuncTxt_3,
self.btnFuncTxt_4,
self.btnFuncTxt_5,
}
self.btnSelects={
self.btnSelects_1,
self.btnSelects_2,
self.btnSelects_3,
self.btnSelects_4,
self.btnSelects_5,
}
self.btnFunc={
self.btnFunc_1,
self.btnFunc_2,
self.btnFunc_3,
self.btnFunc_4,
self.btnFunc_5,
}



end


function UIFabaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.selectBg);self.selectBg=nil;
_UIObject_release(self.flyIcon);self.flyIcon=nil;
_UIObject_release(self.weightPanel);self.weightPanel=nil;
_UIObject_release(self.diziModel);self.diziModel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.batchCreateBtn);self.batchCreateBtn=nil;
_UIObject_release(self.luzi);self.luzi=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.selectDesc);self.selectDesc=nil;
_UIObject_release(self.item7);self.item7=nil;
_UIObject_release(self.wieghtRoot);self.wieghtRoot=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.btnLianzhi);self.btnLianzhi=nil;
_UIObject_release(self.lianzhiRoot);self.lianzhiRoot=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.costItems);self.costItems=nil;
_UIObject_release(self.item6);self.item6=nil;
_UIObject_release(self.nameBg);self.nameBg=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.money2Root);self.money2Root=nil;
_UIObject_release(self.redRoot);self.redRoot=nil;
_UIObject_release(self.orangeRoot);self.orangeRoot=nil;
_UIObject_release(self.purpleRoot);self.purpleRoot=nil;
_UIObject_release(self.blueRoot);self.blueRoot=nil;
_UIObject_release(self.greenRoot);self.greenRoot=nil;
_UIObject_release(self.weighthelp);self.weighthelp=nil;
_UIObject_release(self.lianzhiDesc);self.lianzhiDesc=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.lianzhiTitle);self.lianzhiTitle=nil;
_UIObject_release(self.btnReward);self.btnReward=nil;
_UIObject_release(self.btnStopLianzhi);self.btnStopLianzhi=nil;
_UIObject_release(self.attrScrollview);self.attrScrollview=nil;
_UIObject_release(self.moneyIcon2);self.moneyIcon2=nil;
_UIObject_release(self.moneyVal2);self.moneyVal2=nil;
_UIObject_release(self.moneyVal1);self.moneyVal1=nil;
_UIObject_release(self.moneyIcon1);self.moneyIcon1=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.rewardCount);self.rewardCount=nil;
_UIObject_release(self.selectEquip);self.selectEquip=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.selectMaterilas);self.selectMaterilas=nil;
_UIObject_release(self.attrItem);self.attrItem=nil;
_UIObject_release(self.shentongBtn);self.shentongBtn=nil;
_UIObject_release(self.btnFuncTxt_3);self.btnFuncTxt_3=nil;
_UIObject_release(self.btnSelects_3);self.btnSelects_3=nil;
_UIObject_release(self.btnFuncTxt_5);self.btnFuncTxt_5=nil;
_UIObject_release(self.btnSelects_5);self.btnSelects_5=nil;
_UIObject_release(self.btnFuncTxt_4);self.btnFuncTxt_4=nil;
_UIObject_release(self.btnSelects_4);self.btnSelects_4=nil;
_UIObject_release(self.btnFuncTxt_1);self.btnFuncTxt_1=nil;
_UIObject_release(self.btnSelects_1);self.btnSelects_1=nil;
_UIObject_release(self.btnSelects_2);self.btnSelects_2=nil;
_UIObject_release(self.btnFuncTxt_2);self.btnFuncTxt_2=nil;
_UIObject_release(self.rewardIcon);self.rewardIcon=nil;
_UIObject_release(self.btnMaterials);self.btnMaterials=nil;
_UIObject_release(self.btnEquips);self.btnEquips=nil;
_UIObject_release(self.jingcuidesc);self.jingcuidesc=nil;
_UIObject_release(self.attrCreater);self.attrCreater=nil;
_UIObject_release(self.shentong);self.shentong=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
_UIObject_release(self.btnFunc_1);self.btnFunc_1=nil;
_UIObject_release(self.btnFunc_2);self.btnFunc_2=nil;
_UIObject_release(self.btnFunc_4);self.btnFunc_4=nil;
_UIObject_release(self.btnFunc_3);self.btnFunc_3=nil;
_UIObject_release(self.btnFunc_5);self.btnFunc_5=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.btnOnekey);self.btnOnekey=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.titleRoot);self.titleRoot=nil;
_UIObject_release(self.tempSize);self.tempSize=nil;
_UIObject_release(self.btnsRoot);self.btnsRoot=nil;
_UIObject_release(self.attrContect);self.attrContect=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.weighthelp2);self.weighthelp2=nil;
self.btnFuncTxt=nil;
self.btnSelects=nil;
self.btnFunc=nil;
end

















local _maxAttrLine=10
local _bag_filter_desc={}
local _bag_filter_val={}
local _colomn=4
local _row=6
local _this=nil
local _dropItemHeight=40
local _dropViewHeight=150
local _mainIdx=1
local _fzIdx=6
local _jhIdx=7

local _equipIdxArray={1,6,2,3,4,5,7}
local _materialIdxArray={1,2,3,4,5,7}

local _equipIdxOneKeyArray={1,6,2,3,4,5}
local _materialIdxOneKeyArray={1,2,3,4,5}


function UIFabaoWin:onLoaded(...)
self:bindComponents()

self.ScrollView:setSlowClickAction(nil)




self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(1,...)end)
self.Dropdown2:setChangeAction(function(...)self:onDropdownChange(2,...)end)
self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(1,...)end)
self.Dropdown2:setDropdownLayoutedAction(function(...)self:onDropdownCreate(2,...)end)

self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)

self._onMoneyChanged=function(...)self:onMoneyChanged(...)end
notifySystem:listenNotify(notifyConfig.on_money_changed,self._onMoneyChanged)



self.scrollView2:setChildScrollViewInit(0.5,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.onBuildingEvent)
notifySystem:listenNotify(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)

_this=self

local itemsList={}
self.itemsList=itemsList
itemsList[#itemsList+1]=self.item1
itemsList[#itemsList+1]=self.item2
itemsList[#itemsList+1]=self.item3
itemsList[#itemsList+1]=self.item4
itemsList[#itemsList+1]=self.item5
itemsList[#itemsList+1]=self.item6
itemsList[#itemsList+1]=self.item7

for _,v in ipairs(itemsList)do
v:setBaseItemClickEvent(function(...)
if not self.isClose then
self:onSelectItemClick(...)
end
end)
end

local weightWidgetList={}
weightWidgetList[#weightWidgetList+1]=self.greenRoot
weightWidgetList[#weightWidgetList+1]=self.blueRoot
weightWidgetList[#weightWidgetList+1]=self.purpleRoot
weightWidgetList[#weightWidgetList+1]=self.orangeRoot
weightWidgetList[#weightWidgetList+1]=self.redRoot
self.weightWidgetList=weightWidgetList

local list=table.toTable(ELEMENT_TYPE.eGold,ELEMENT_TYPE.eSoil)
_bag_filter_desc[ITEM_FILTER_TYPE.eElement]=itemsFilterHelper.getFilterNames(list,function(element)
return ELEMENT_TYPE.getNameX(element)
end,'所有')
_bag_filter_val[ITEM_FILTER_TYPE.eElement]=list

local maxStage=fabaoConfig.getFabaoMaxEquipStage()
local list=table.toTable(1,maxStage)
self.equipStageVal=list
self.equipStageDesc=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}阶',stage)
end,'所有')

local list=table.toTable(1,5)
self.nomalStageVal=list
self.nomalStageDesc=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}阶',stage)
end,'所有')

local list=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
_bag_filter_desc[ITEM_FILTER_TYPE.eColor]=itemsFilterHelper.getFilterNames(list,function(color)
return FMT.fmt('{0}',eQualityColorName[color])
end,'所有')

_bag_filter_val[ITEM_FILTER_TYPE.eColor]=list


local weaponCfg=cfg_discipleweaponconfig()
local types=table.toTable(EQUIP_TYPE.eWeapon,EQUIP_TYPE.eShoot)
local list={}
for _,v in ipairs(types)do
if v==EQUIP_TYPE.eWeapon then
for ii,_ in ipairs(weaponCfg)do
list[#list+1]=v*100+ii
end
else
list[#list+1]=v*100
end
end
_bag_filter_val[ITEM_FILTER_TYPE.eItemType1AndType2]=list
_bag_filter_desc[ITEM_FILTER_TYPE.eItemType1AndType2]=itemsFilterHelper.getFilterNames(list,function(num)
local type1=math.floor(num/100)
local type2=num-type1*100
local name1=cfg_discipleequiptypeconfig_get(type1).name
local name2=type2>0 and cfg_discipleweaponconfig_get(type2).name
if name2 then
return FMT.fmt('{0}-{1}',name1,name2)
end
return FMT.fmt('{0}',name1)
end,'所有')

self.jingcaiStageDesc={'所有'}

_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=self.nomalStageDesc

self.filter={}
self.filter[ITEM_FILTER_TYPE.eElement]=0
self.filter[ITEM_FILTER_TYPE.eStage]=0
self.filter[ITEM_FILTER_TYPE.eColor]=0

self.selectBagType=BAG_TYPE.eMaterialsBag

self.selectList={}
self.selectNumList={}
self.showAttrPanel=false
self.lianzhiType=FABAO_LIANZHI_TYPE.eNomal

self.selectDesc:setActive(false)
self.selectBg:setActive(false)
self.luzi:setChildUIModelShowTarget(2048,1,nil,eAnimationID.stand,nil,nil,nil,function(...)
if self==nil or self.isClose then return end
local isMakeByEquip=self:isMakeByEquip()
self.winlua:SetChildUIModelShowSlotAttachment(self.luzi:getID(),'frame_lqgteshudjk',isMakeByEquip and'frame_lqgteshudjk'or'')
end)
self.unlockItem={}
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
self.item1:setActive(true)
self.curPageIndex=1
self.isSetZero=false
self.selectItemguid=nil
self.selectItemguidIdx=nil
self.isSelectGrid=nil
self.funcFilter=0
self:setFunctionBtns()

end



function UIFabaoWin:__delete()

if self.tweener~=nil then
self.tweener:Kill(false)
self.tweener=nil
end
self.flyIcon:setActive(false)
self.qipao:setActive(false)
self:hideAttrPanel()
self:hideWeightPanel()
self:closeProvideSelectGrids()
uiAIManager:removeUIInstance(self.currDZ)
uiAIManager:clearUIWinData('UIFabaoWin')
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
notifySystem:removelistener(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)
notifySystem:removelistener(notifyConfig.building_event,self.onBuildingEvent)
notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChanged)
_this=nil
self.currDZ=nil
tipsManager.closeTips()
end




function UIFabaoWin:onShow(argtable,afterOnloaded)
if argtable then
local guid=argtable.entityId
self.entityId=guid
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
zongmenModel:countManufacturePercent(self.bdData)
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
self.bdType=self.config.id
local build_id=self.bdData.build_id
self.ubdId=self.bdData.un_build_id
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
self:freshLianzhiType()
self.bdDatas=zongmenModel:getBuildingDataByBdId(self.sfId,build_id)
end
self:freshInfo()
end

function UIFabaoWin:onShowArgRecv(argtable)
local oldId=self.entityId
local newId=argtable.entityId
if newId~=oldId then
self:__delete()
self:onLoaded()
self:onShow(argtable)
end
end


function UIFabaoWin:onHide()
self:closeProvideSelectGrids()
end



function UIFabaoWin:getDZId()
local dzid=self.bdData.dizi_id
if tostring(dzId)=='0'then return end
return dzid
end

function UIFabaoWin:freshInfo()
local diziguid=self.bdData.dizi_id
self.diziguid=tostring(diziguid)=='0'and 0 or diziguid

self:freshDiziInfo()

self:setDropdowns()
self:setSelectItems()
self:freshAttrPanel()
self:freshBagBtns()
self:freshLianZhiRoot()
self:freshLianZhiStatus()
self:freshLuziAni()

self:refreshShowRewardBox()

self.rightArrow:setActive(#self.bdDatas>1)
self.leftArrow:setActive(#self.bdDatas>1)
end


function UIFabaoWin:freshDiziInfo()
local diziguid=self.diziguid
local name=''
local haveDz=diziguid and diziguid~=0
self.diziLock:setActive(not haveDz)
self.diziInfo:setActive(haveDz)
self.btnSelect:setActive(not haveDz)
self.btnSwitch:setActive(haveDz)
if haveDz then
name=UIDiscipleModel:getDiscipleName(diziguid)
self.dzName:setText(FMT.fmt('执事弟子：<color=#7d3b17>{0}</color>',name))

local bd_tybe_cfg=cfg_monijybuildconfig_get(self.config.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(diziguid,skill_id)
local effect=nil
if skill_cfg.buildplant_effects then
effect=skill_cfg.buildplant_effects[level]
end
local content=string.format('%s：%s级',skill_cfg.name,level)
self.skill:setText(content)
end

self.dizi_speciality=discipleSelectController.getSpeciallistByBuild(diziguid,bd_tybe_cfg.build_type,2)
if self.dizi_speciality and#self.dizi_speciality>0 then
self.scrollView2:setActive(true)
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
else
self.scrollView2:setActive(false)
end
end
self:freshDzModel()
end

function UIFabaoWin:freshDzModel()
local hasDizi=self.diziguid and self.diziguid~=0


uiAIManager:removeUIInstance(self.currDZ)
self.currDZ=nil
if hasDizi then
self:createDZ(self.bdData.dizi_id,Vector2.New(-100,-20),function(bt)
self.currDZ=bt
end)
end
end

function UIFabaoWin:createDZ(dzId,pos,callback)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=0,
leftPos={-250,-20},
rightPos={0,-20},
waitspeak=0,
}
local tran=self.diziModel:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])



local otherData=
{
keepButtonEvent=true,
}

uiAIManager:createUIDisciple('UIFabaoWin','bt_ui_lqf',dzId,tran,vpos,initData,otherData,function(bt)
local stWidget=bt:getSharedVar('dzWidget')
stWidget:SetChildButtonClick(2,function()
local chuiwei=UIDiscipleModel:checkDiscipleState2(dzId,DISCIPLE_STATE_TYPE.eChuiWei)
if chuiwei then
UIManager.error('弟子垂危，无法炼制法宝')
UIManager:showWindow('UIDiscipleChuiweiWin',{guid=dzId})
end
end)
callback(bt)
end)
end


function UIFabaoWin:getSpeakText(bt,tkey)
local ret,idx=self:isFullHoles()
local hasMainItem=self:hasPutMainItem()
local hasDizi=self.diziguid and self.diziguid~=0
local txt=''
if hasDizi then
if self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal then
if ret then
txt=self:getBuildSpeakConfig(self.diziguid)
elseif not self:isMainHole(idx)then
txt='放入合适的辅助材料'
elseif self:isMainHole(idx)then
txt='放入合适的主材料'
end
else
txt=self:getBuildSpeakConfig(self.diziguid)
end
end

bt:setSharedVar(tkey,txt)
end

function UIFabaoWin:getBuildSpeakConfig(diziguid)
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'lianqi')
local txt=speakList[math.random(1,#speakList)]or''
return txt
end

function UIFabaoWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView2:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.diziguid,config=data})
end


function UIFabaoWin:freshAttrPanel()
local itemguid=self:getMainGUID()
local showFlag=itemguid~=nil and self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal
if self.showAttrPanel~=showFlag then
self.showAttrPanel=showFlag
self.winlua:SetChildDOTweenAnimation_DOPlay(self.attrPanel:getID(),showFlag and'2'or'1',0,1)
else
if showFlag then
self:freshAttrs()
end
end
end

function UIFabaoWin:hideAttrPanel()
if self.showAttrPanel then
self.showAttrPanel=false
self.winlua:SetChildDOTweenAnimation_DOPlay(self.attrPanel:getID(),'1',0,1)
end
end

function UIFabaoWin:onOpenAniComplete()
self:freshAttrs()
self:delayDo(0.1,function()
self.winlua:SetStopChildScrollRect(self.attrScrollview:getID())
self.winlua:SetChildAnchoredPos(self.attrContect:getID(),0,0)
end)
end


function UIFabaoWin:freshAttrs()
local itemguid=self:getMainGUID()
if itemguid==nil then
self.attrCreater:setChildLayoutGroupCreateItems(0)
self.shentong:setActive(false)
return
end
local mainid,itemlist=self:getSelectMaterials()
local stage=fabaoHelper.computeStage(itemlist)
local isMakeByEquip=self:isMakeByEquip()
local itemConfig=itemsConfig.getConfig(mainid)
local itemid=mainid
local hasAttr=true
if isMakeByEquip then
itemid=itemlist[1]
hasAttr=self:isfull(_fzIdx)or false
end


local shentong=itemConfig.shentong
local color=itemConfig.color
local hasShentong=shentong~=nil
self.shentong:setActive(hasShentong)
if hasShentong then
self.shentongId=shentong
self.shentonglv=color
local shentongConfig=fabaoConfig.getShentongConfig(shentong)
local stage=itemConfig.stage
stage=isMakeByEquip and fabaoConfig.getFabaoStageByEquipStage(stage)or stage
local shentongname=shentongConfig.name
local widget=self.winlua:GetChildWidgetBase(self.shentong:getID())
local shentongIcon=iconHelper.getSkillIcon(shentongConfig.icon)
widget:SetChildIcon(0,shentongIcon,true)
widget:SetChildText(1,shentongname)
end

local baseLianhuaRangeLookupAttrs=fabaoHelper.getAddLianhuaAttrsListByLianzhi(itemlist)
local baseLianhuaRangeListAttrs={}
for attrType,_ in pairs(baseLianhuaRangeLookupAttrs)do
baseLianhuaRangeListAttrs[#baseLianhuaRangeListAttrs+1]=attrType
end
local len=#baseLianhuaRangeListAttrs
if#baseLianhuaRangeListAttrs>1 then
table.sort(baseLianhuaRangeListAttrs,function(a,b)
return a<b
end)
end
local lianhualen=#baseLianhuaRangeListAttrs
local nowlen=0
local grids
if hasAttr then
local baseRangeAttrs=itemid and fabaoHelper.getBaseAttrsRange(itemid,stage)
local elementRangeAttrs=fabaoHelper.getAllElementAttrsRange(itemlist)
local baselen=#baseRangeAttrs
local elementLen=#elementRangeAttrs
local tlen=baselen+elementLen+lianhualen
self.attrCreater:setChildLayoutGroupCreateItems(tlen)
grids=self.attrCreater:getChildLayoutGroupGridList()
if baselen>0 then
for i=1,baselen do
local gidx=i+nowlen-1
local widget=grids[gidx]
self:fillAttr(widget,baseRangeAttrs[i])
end
end
nowlen=baselen
if elementLen>0 then
for i=1,elementLen do
local gidx=i+nowlen-1
local widget=grids[gidx]
self:fillAttr(widget,elementRangeAttrs[i],'#efb150')
end
end
nowlen=baselen+elementLen
else
local tlen=2+lianhualen
nowlen=2
self.attrCreater:setChildLayoutGroupCreateItems(tlen)
grids=self.attrCreater:getChildLayoutGroupGridList()
local widget=grids[0]
widget:SetChildText(0,FMT.cfmt(FONT_COLOR.eRedColor,'需放入炼制材料确定法宝属性'))
local widget=grids[1]
widget:SetChildText(0,FMT.cfmt(FONT_COLOR.eRedColor,'需放入炼制材料确定五行类别'))
end

if lianhualen>0 then
for i=1,lianhualen do
local gidx=i+nowlen-1
local widget=grids[gidx]
local attrType=baseLianhuaRangeListAttrs[i]
local range=baseLianhuaRangeLookupAttrs[attrType]
self:fillAttr(widget,{attrType,range},'#efb150')
end
end
self.winlua:SetChildDOAnchorPosY(self.attrContect:getID(),0,0)
end

function UIFabaoWin:fillAttr(widget,attr,colorCode)
if attr then
local attrid=attr[1]
local range=attr[2]
local min=range[1]
local max=range[2]

local name,minValstr,ifMod=equipsHelper.getAttr(attrid,min,TO_INT_TYPE.eDown)
local name,maxValstr,ifMod=equipsHelper.getAttr(attrid,max,TO_INT_TYPE.eDown)
name=string.replace(name,'威力','')
local desc=FMT.fmt('{0}：{1}',name,FMT.fmt('{0}~{1}',minValstr,maxValstr))
desc=colorCode and FMT.cfmt2(colorCode,desc)or desc
widget:SetChildText(0,desc)
end
end


function UIFabaoWin:flyItemIcon(ubdId)
if ubdId~=self.ubdId then return end
local firshMainItemId=fabaoModel.getLianqiMainid(self.ubdId)
local iconName=iconHelper.getIconName(firshMainItemId)
self.flyIcon:setImageIcon(iconName,false)
self.flyIcon:setActive(true)
local tran=self.flyIcon:getTransform()
local spos=self.flyIcon:getChildPosition()
local tpos=self.rewardIcon:getChildPosition()
if self.tweener~=nil then
self.tweener:Kill(false)
self.tweener=nil
end
self.tweener=_DOTweenProxy.DoPath(tran,{tpos,Vector3(spos.x-3,spos.y+2,0),tpos},1,_pathType.CubicBezier)
self.tweener:SetEase(_Ease.InSine)
self.tweener:OnComplete(function()
self.flyIcon:setChildPosition(spos)
self.flyIcon:setActive(false)
self.tweener:Kill(false)
self.tweener=nil
self:refreshShowRewardBox()
end)
end


function UIFabaoWin:refreshShowRewardBox()
local rewardCount=fabaoModel.getLianzhiInfoNowFinishIdx(self.ubdId)
local hasReward=rewardCount and rewardCount>0
self.qipao:setActive(hasReward)
if hasReward then
local firshMainItemId=fabaoModel.getLianqiMainid(self.ubdId)
local iconName=iconHelper.getIconName(firshMainItemId)
self.rewardIcon:setImageIcon(iconName,false)
self.rewardCount:setText(rewardCount)
end
end


function UIFabaoWin:onBeforeCompleteReward()
fabaoProtocolControl.reqFabaoPrize(self.ubdId)
end


function UIFabaoWin:setDropdowns()
local isMaterilas=self.selectBagType==BAG_TYPE.eMaterialsBag
self.Dropdown1:setActive(true)
local filterType=ITEM_FILTER_TYPE.eStage
local descList=_bag_filter_desc[filterType]
local descCopyList=table.deepCopy(descList)
local options=table.reverse(descCopyList)
self.Dropdown1:setOption(options)
local len=#descList
local idx=self.filter[filterType]or 0
local reIdx=len-1-idx
self.Dropdown1:setValue(reIdx)

local filterType=isMaterilas and ITEM_FILTER_TYPE.eElement or ITEM_FILTER_TYPE.eItemType1AndType2
local descList=_bag_filter_desc[filterType]
local descCopyList=table.deepCopy(descList)
local options=table.reverse(descCopyList)
self.Dropdown2:setOption(options)
local len=#descList
local idx=self.filter[filterType]or 0
local reIdx=len-1-idx
self.Dropdown2:setValue(reIdx)
end


function UIFabaoWin:freshLianzhiType()
self.lianzhiType=fabaoModel.getFabaoLianzhiType(self.ubdId)
end


function UIFabaoWin:freshLianZhiStatus()
self.lianzhiRoot:setActive(self.lianzhiType~=FABAO_LIANZHI_TYPE.eNomal)
if self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal then return end

local nowIndex=fabaoModel.getLianzhiInfoNowIdx(self.ubdId)
local finalIndex=fabaoModel.getLianzhiInfoFinalIdx(self.ubdId)
local finishIndex=fabaoModel.getLianzhiInfoNowFinishIdx(self.ubdId)
local isMaking=fabaoModel.isLianZhiFabao(self.ubdId)
local isBatchCreate=fabaoModel.checkLianzhiIsBatch(self.ubdId)
local isPrize=not isMaking and self.lianzhiType==FABAO_LIANZHI_TYPE.ePrize
self.progress:setActive(isMaking)
self.btnReward:setActive(isPrize)
local finishCount=finishIndex or 0
self.btnStopLianzhi:setActive(isMaking and isBatchCreate)


local lianzhiInfo=fabaoModel.getLianzhiInfoByIdx(self.ubdId,nowIndex)

local mianid=lianzhiInfo.param_4
local stage=itemsConfig.getConfig(mianid).stage
local fixtime=fabaoConfig.getCreateTime(stage)

self.fixtime=fixtime
if isMaking then

self.lianzhiDesc:setText(FMT.fmt("炼制中（<color=#FF9B3D>{0}/{1}</color>）",finishCount,finalIndex))
local left=fabaoModel.getLianzhiLeftTime(self.ubdId,nowIndex)

self.progressBar:animateFiveParams(fixtime-left,fixtime,fixtime,left)
self:startProgressTimer(function()
if self and not self.isClose then
self:onProgress()
end
end)
elseif isPrize then
self.lianzhiDesc:setText('炼制完成')
self:stopProgressTimer()
end
end

function UIFabaoWin:startProgressTimer(callback)
self:stopProgressTimer()
callback()
self.progressTimer=timer.new()
self.progressTimer:start(1,callback)
end

function UIFabaoWin:stopProgressTimer()
if self.progressTimer then
self.progressTimer:cancel()
end
end


function UIFabaoWin:onProgress()
local finalIndex=fabaoModel.getLianzhiInfoFinalIdx(self.ubdId)
local left=fabaoModel.getLianzhiLeftTime(self.ubdId,finalIndex)
local fixtime=self.fixtime
local timeStr=timeHelper.format_time_stamp11(left,true)
self.lianzhiTitle:setText(timeStr)
if left<=0 then
self:freshLianzhiType()
self:freshLianZhiStatus()
self:freshLuziAni()
end
end


function UIFabaoWin:hasPutMainItem()
return self:getMainGUID()~=nil
end

function UIFabaoWin:getMainGUID()
return self.selectList[_mainIdx]
end

function UIFabaoWin:onlyHasMainItem()
local flag=nil
local array=self:getIdxArray()
for _,i in ipairs(array)do
local guid=self.selectList[i]
if flag==nil then
if guid~=nil then
flag=true
else
return false
end
else
if guid then
return false
end
end
end
return true
end


function UIFabaoWin:getLeftPutNum(itemid)
local hasMain=self:getMainGUID()
if not hasMain then return 1 end
if itemsConfig.isEquip(itemid)then
return 0
elseif itemsConfig.isItem(itemid)or itemsConfig.isMaterials(itemid)then
local hasNum=0
local needNum=0
local flag=false
local array=self:getIdxArray()
local mainItemguid=self:getMainGUID()
for _,i in ipairs(array)do
if flag and(self:isTempHole(i)or
self:isPutHoleByItemid(itemid,i))and
not self:isJHIdxHole(i)then
needNum=needNum+self:getNeedNumByItemid(mainItemguid,itemid,i)
hasNum=hasNum+self:getPutNum(i)
end
flag=flag or true
end
return needNum-hasNum
end
return 0
end

function UIFabaoWin:isMainHole(idx)
return _mainIdx==idx
end

function UIFabaoWin:isFzHole(idx)
return _fzIdx==idx
end

function UIFabaoWin:isJHIdxHole(idx)
return _jhIdx==idx
end

function UIFabaoWin:isPutHoleByItemid(itemid,idx)
local guid=self.selectList[idx]
if guid then
local item=bagModel.getItem(guid)
return item.itemid==itemid
end
return false
end


function UIFabaoWin:isPutAnyHoleByGUID(itemguid)
local array=self:getIdxArray()
for _,i in ipairs(array)do
local guid=self.selectList[i]
if guid and tostring(guid)==tostring(itemguid)then
return true
end
end
return false
end

function UIFabaoWin:isTempHole(idx)
return self.selectList[idx]==nil
end

function UIFabaoWin:getPutNum(idx)
return self.selectNumList[idx]or 0
end

function UIFabaoWin:setPutNum(idx,num)
self.selectNumList[idx]=num
end

function UIFabaoWin:addPutNum(idx,num)
self.selectNumList[idx]=self:getPutNum(idx)+num
end

function UIFabaoWin:deletePutNum(idx,num)
local num1=self:getPutNum(idx)-num
if num1<=0 then num1=0 end
self.selectNumList[idx]=num1
end

function UIFabaoWin:freshSelectItemBG()
local diziguid=self.diziguid
local hasMainItemid=self:hasPutMainItem()
local haveDz=diziguid and diziguid~=0
self.costItems:setActive(haveDz and hasMainItemid and self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal)
self.nameBg:setActive(haveDz and(hasMainItemid or self.lianzhiType~=FABAO_LIANZHI_TYPE.eNomal))
end

function UIFabaoWin:freshMainItem()
local widget=self.item1
local isNomal=self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal
local idx=_mainIdx
local mainItemguid=self:getMainGUID()
if isNomal then
local itemguid=self:getMainGUID()
local item=bagModel.getItem(itemguid)
local needNum=item and self:getNeedNumByItemid(mainItemguid,item.itemid,idx)or 0
local isSelect=false
local itemcount=''
if needNum>1 and item then
local handle=tostring(itemguid)
local hasNum=self:getPutNum(idx)
itemcount=needNum>hasNum and FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',hasNum,needNum)or FMT.fmt('{0}/{1}',hasNum,needNum)
isSelect=self.isSelectGrid==false and tostring(self.selectItemguid)==tostring(itemguid)and self.selectItemguidIdx==idx or false
end
local conf={showname=true,itemcount=itemcount,nomalname=true,showCountBG=itemcount~='',select=isSelect}
widget:setChildPropData(self:getSelectFillData(idx,item,conf))
else
local nowIndex=fabaoModel.getLianzhiInfoNowIdx(self.ubdId)

local lianzhiInfo=fabaoModel.getLianzhiInfoByIdx(self.ubdId,nowIndex)
local itemid=lianzhiInfo.param_4
local conf={showname=true,showcount=false,nomalname=true,select=false}
local item={itemid=itemid}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
widget:setChildPropData(prop)
end
end


function UIFabaoWin:setSelectItems()
self:freshSelectItemBG()
local isNotSelectGrid=self.isSelectGrid==false
local hasSelect=false

local widget=self.item1
local isNomal=self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal
local idx=_mainIdx
local mainItemguid=self:getMainGUID()
if isNomal then
local itemguid=self:getMainGUID()
local item=bagModel.getItem(itemguid)
local needNum=item and self:getNeedNumByItemid(mainItemguid,item.itemid,idx)or 0
local isSelect=false
local itemcount=''
if needNum>1 and item then
local handle=tostring(itemguid)
local hasNum=self:getPutNum(idx)
itemcount=needNum>hasNum and FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',hasNum,needNum)or FMT.fmt('{0}/{1}',hasNum,needNum)
isSelect=self.isSelectGrid==false and tostring(self.selectItemguid)==tostring(itemguid)and self.selectItemguidIdx==idx or false
hasSelect=isSelect or hasSelect
end
local conf={showname=true,itemcount=itemcount,nomalname=true,showCountBG=itemcount~='',select=isSelect}
widget:setChildPropData(self:getSelectFillData(idx,item,conf))
else
local nowIndex=fabaoModel.getLianzhiInfoNowIdx(self.ubdId)

local lianzhiInfo=fabaoModel.getLianzhiInfoByIdx(self.ubdId,nowIndex)
local itemid=lianzhiInfo.param_4
local conf={showname=true,showcount=false,nomalname=true,select=false}
local item={itemid=itemid}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
widget:setChildPropData(prop)
end
local itemsList=self.itemsList
if self.selectList==nil then self.selectList={}end
for i,v in ipairs(itemsList)do
if not self:isMainHole(i)then
local itemguid=self.selectList[i]
local item=itemguid and bagModel.getItem(itemguid)or nil
local isSelect=itemguid and self.isSelectGrid==false and tostring(self.selectItemguid)==tostring(itemguid)and self.selectItemguidIdx==i or false
hasSelect=isSelect or hasSelect
local needNum=itemguid and self:getNeedNumByGUID(mainItemguid,itemguid,i)or 0
local itemcount=''
if needNum>1 and item then
local hasNum=self:getPutNum(i)
itemcount=needNum>hasNum and FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',hasNum,needNum)or FMT.fmt('{0}/{1}',hasNum,needNum)
end
local conf={showname=false,itemcount=itemcount,showCountBG=itemcount~='',select=isSelect}
v:setChildPropData(self:getSelectFillData(i,item,conf))
end
end

local isMakeByEquip=self:isMakeByEquip()
local showItem6=isMakeByEquip and self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal
self.item6:setActive(showItem6)
local showItem7=self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal and self:hasPutMainItem()
self.item7:setActive(showItem7)
self.winlua:SetChildUIModelShowSlotAttachment(self.luzi:getID(),'frame_lqgteshudjk',showItem6 and'frame_lqgteshudjk'or'')
if isNotSelectGrid and not hasSelect then
self.selectItemguidIdx=nil
self.selectItemguid=nil
end
end

function UIFabaoWin:getSelectFillData(index,item,conf)
local prop
if item==nil then
prop=self:getSelectTempFillData(index)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=true
else
prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
local showStage=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetActive,8)]=showStage
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
end
prop[DataPropKey.eItemIndex]=index
return prop
end


function UIFabaoWin:getSelectTempFillData(index)
local conf={}

conf.showbg=true
return itemsComponentHelper.getTempFillData(conf)
end

function UIFabaoWin:isfull(fillIdx)
local guid=self.selectList[fillIdx]
if guid==nil then return false end
local mainItemguid=self:getMainGUID()
local needNum=self:getNeedNumByGUID(mainItemguid,guid,fillIdx)
local hasNum=self:getPutNum(fillIdx)
return hasNum>=needNum
end


function UIFabaoWin:getNextFillIdx(itemguid,containsJh)
local handle=tostring(itemguid)
local array=self:getIdxArray()
for _,i in ipairs(array)do
local isJHIdxHole=self:isJHIdxHole(i)
if not isJHIdxHole or isJHIdxHole and containsJh then
local guid=self.selectList[i]
if guid==nil or tostring(guid)==handle and not self:isfull(i)then
return i
end
end
end
end

function UIFabaoWin:getIdxArray()
local array
if self:isMakeByEquip()then
array=_equipIdxArray
else
array=_materialIdxArray
end
return array
end

function UIFabaoWin:getOneKeyIdxArray()
local array
if self:isMakeByEquip()then
array=_equipIdxOneKeyArray
else
array=_materialIdxOneKeyArray
end
return array
end

function UIFabaoWin:getBagType(index)
local isMainHole=self:isMainHole(index)
local isMakeByEquip=self:isMakeByEquip()
if isMakeByEquip and isMainHole then return BAG_TYPE.eEquipBag end
return BAG_TYPE.eMaterialsBag
end

function UIFabaoWin:addSelectHole(itemguid,index,num)
if num<=0 then return end
local array=self:getIdxArray()
local handle=tostring(itemguid)
local mainItemguid=self:getMainGUID()
for _,i in ipairs(array)do
local needNum=self:getNeedNumByGUID(mainItemguid,itemguid,i)
local hasNum=self:getPutNum(i)
local guid=self.selectList[i]
local guidStr=tostring(guid)
if guid==nil or guidStr==handle and hasNum<needNum then
local maxNum=needNum-hasNum
local add=math.min(num,maxNum)
self:addSelectNum(itemguid,i,add)
num=num-add
if num<=0 then
break
end
end
end
end

function UIFabaoWin:addSelectNum(itemguid,index,num)
local lastGuid=self.selectList[index]
self.selectList[index]=itemguid
self:addPutNum(index,num)
end

function UIFabaoWin:deleteSelectNum(index,num)
local lastGuid=self.selectList[index]
self:deletePutNum(index,num)
if self:getPutNum(index)<=0 then
self.selectList[index]=nil
end
end

function UIFabaoWin:getSelectIndex(itemguid)
if self.selectList==nil then self.selectList={}end
local array=self:getIdxArray()
local len=#array
for i=len,1,-1 do
local index=array[i]
if tostring(self.selectList[index])==tostring(itemguid)then
return index
end
end
end


function UIFabaoWin:isFullHoles(containsJh)
local array=self:getIdxArray()
for _,i in ipairs(array)do
local isJHIdxHole=self:isJHIdxHole(i)
if isJHIdxHole then
if containsJh and not self:isfull(i)then
return false,i
end
else
if not self:isfull(i)then
return false,i
end
end
end
return true
end

function UIFabaoWin:getSelectItemNum(itemguid)
if self.selectList==nil then self.selectList={}end
local handle=tostring(itemguid)
local num=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
if tostring(self.selectList[i])==handle then
num=num+self:getPutNum(i)
end
end
return num
end


function UIFabaoWin:getSelectMaterials()
local temp={}
local selectList=self.selectList or{}
local mainid
local array=self:getIdxArray()
for _,i in ipairs(array)do
if not self:isJHIdxHole(i)then
local itemguid=selectList[i]
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
if self:isMainHole(i)then
mainid=itemid
if not itemsConfig.isEquip(itemid)then
temp[#temp+1]=itemid
end
else
temp[#temp+1]=itemid
end
end
end
end

return mainid,temp
end


function UIFabaoWin:getNeedNumByMainHole(itemid)
return self:getNeedNumInCfgItemid(itemid)
end

function UIFabaoWin:getNeedNumByItemid(mainguid,itemid,fillIdx)
if self:isMainHole(fillIdx)or self:isFzHole(fillIdx)then
return self:getNeedNumInCfgItemid(itemid)
elseif self:isJHIdxHole(fillIdx)then
return self:getJhNeedNumInCfgItemid(mainguid,itemid)
else
return 1
end
end

function UIFabaoWin:getNeedNumInCfgItemid(itemid)
if itemsConfig.isEquip(itemid)then return 1 end
local stage=itemsConfig.getConfig(itemid).stage
local needNum=fabaoConfig.getCommonConfig().materialnum[stage]
return needNum
end

function UIFabaoWin:getJhNeedNumInCfgItemid(mainguid,itemid)
local mainitem=bagModel.getItem(mainguid)
local mainid=mainitem.itemid
local stage=itemsConfig.getConfig(mainid).stage
local cfg=fabaoConfig.getJingHuaCfg()
if cfg[itemid]then
local needlist=cfg[itemid][1]
return needlist[stage]
end
return 1
end


function UIFabaoWin:getNeedNumByGUID(mainguid,guid,fillIdx)
local _guid=self.selectList[fillIdx]
if _guid and tostring(guid)~=tostring(guid)then return end
if self:isMainHole(fillIdx)or
self:isFzHole(fillIdx)then
return self:getNeedNumInCfg(guid)
elseif self:isJHIdxHole(fillIdx)then
return self:getHjNeedNumInCfg(mainguid,guid)
else
return 1
end
end

function UIFabaoWin:getNeedNumInCfg(guid)
if not guid then return 9999999 end
local item=bagModel.getItem(guid)
local itemid=item.itemid
return self:getNeedNumInCfgItemid(itemid)
end

function UIFabaoWin:getHjNeedNumInCfg(mainguid,guid)
if not guid then return 9999999 end
local item=bagModel.getItem(guid)
local itemid=item.itemid
return self:getJhNeedNumInCfgItemid(mainguid,itemid)
end

function UIFabaoWin:freshCostMoney()
local selectList=self.selectList or{}
local itemguid=self:getMainGUID()
if itemguid==nil then return end
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local mainid,itemidlist=self:getSelectMaterials()
local stage=fabaoHelper.computeStage(itemidlist)
local cost=fabaoConfig.getCostByLianzhi(stage)
if cost==nil then
loggerUtil.logErrFMT('当前材料/装备{0}没有配置对应阶数的金钱消耗',itemid)
end

local percent=self.bdData.pcreatesubpercent or 0
local costMoney1=cost[1]
local costMoney2=cost[2]
self.money1Root:setActive(costMoney1~=nil)
self.money2Root:setActive(costMoney2~=nil)
if costMoney1 then
local price=costMoney1[2]
price=math.ceil(price*(1+percent/100))
local enoughMoney1=moneyModel.checkEnoughMoney(costMoney1[1],price)
self.moneyIcon1:setImageIcon(iconHelper.getIconName(costMoney1[1]),false)
self.moneyVal1:setText(enoughMoney1 and price or FMT.cfmt(FONT_COLOR.eRedColor,price))
end

if costMoney2 then
local price=costMoney2[2]
price=math.ceil(price*(1+percent/100))
local enoughMoney2=moneyModel.checkEnoughMoney(costMoney2[1],price)
self.moneyIcon2:setImageIcon(iconHelper.getIconName(costMoney2[1]),false)
self.moneyVal2:setText(enoughMoney2 and price or FMT.cfmt(FONT_COLOR.eRedColor,price))
end
end

function UIFabaoWin:freshLianZhiRoot()
local flag=true
local isMakeByEquip=self:isMakeByEquip()
if self.lianzhiType~=FABAO_LIANZHI_TYPE.eNomal or self.diziguid==0 or not self:isFullHoles()then
flag=false
end
self.moneyRoot:setActive(flag)
self.btnLianzhi:setActive(flag)
local isOpenBatchCreate=systemModel.isOpen(SYSTEM_DEFINE.eFaBaoBatch)
local isCanShowBatchCreate=isOpenBatchCreate and self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal and
self.diziguid and self.diziguid~=0 and not self:isFullHoles()
self.batchCreateBtn:setActive(isCanShowBatchCreate)
local showWeight=self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal and self.diziguid~=0 and self:hasPutMainItem()
self:freshWeight(showWeight)
if flag then
self:freshCostMoney()
end
end

function UIFabaoWin:freshWeight(flag)
self.wieghtRoot:setActive(flag)
if flag then
local isFullHoles=self:isFullHoles()
local mainid,itemlist=self:getSelectMaterials()
local jhitemguid=self.selectList[_jhIdx]
local jhid=jhitemguid and bagModel.getItem(jhitemguid).itemid or nil
local weightList=fabaoHelper.lianzhiWeight(self.diziguid,mainid,itemlist,jhid)or{}
for i=1,5 do
local color=i
local cmp=self.weightWidgetList[i]
local cmpIdx=cmp:getID()
local widget=self.winlua:GetChildWidgetBase(cmpIdx)
if isFullHoles then
local num=weightList[color]or 0
local numStr1=string.format('%.1f',num)
local num2=math.floor(num)
local num1=tonumber(numStr1)
local isIntValue=num1==num2
local numStr=isIntValue and num2 or numStr1
self.winlua:SetChildActive(cmpIdx,true)
widget:SetChildText(0,numStr)
else
widget:SetChildText(0,'?')
end
end
end
end

function UIFabaoWin:fillWidgetWeight(widget,num)
local numStr1=string.format('%.1f',num)
local num2=math.floor(num)
local num1=tonumber(numStr1)
local isIntValue=num1==num2
local numStr=isIntValue and num2 or numStr1
widget:SetChildText(0,numStr)
end

function UIFabaoWin:hideWeightPanel()
if not self.isShowWeightPanel then return end
self.isShowWeightPanel=nil
self.weightPanel:setActive(false)
self.weighthelp2:setActive(self.isShowWeightPanel==true)
self.weighthelp:setActive(self.isShowWeightPanel~=true)
end

function UIFabaoWin:showWeightPanel()
if self.isShowWeightPanel then
self:hideWeightPanel()
return
end
self.isShowWeightPanel=true
self.weighthelp2:setActive(self.isShowWeightPanel==true)
self.weighthelp:setActive(self.isShowWeightPanel~=true)
self.weightPanel:setActive(true)
local widget=self.weightPanel:getWidgetBase()
local mainid,itemidlist=self:getSelectMaterials()
local mainname=itemsConfig.getTipsColorName(mainid)
local dzguid=self.diziguid
local bd_tybe_cfg=cfg_monijybuildconfig_get(self.config.id)
local skill_id=bd_tybe_cfg.pro_skill_id
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzguid,skill_id)
local nextlv=fabaoHelper.getNextLianzhiWeightlv(mainid,level)
local weightList=fabaoHelper.lianzhiBaseWeight(mainid,level)
local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local isMax=nextlv==nil or explist[nextlv]==nil
local colorlv=FMT.cfmt3("fd8950",level)
local str1=FMT.fmt('当前炼制法宝主材料：{0}\n当前弟子的炼制等级：{1}\n对应的基础炼制概率：',mainname,colorlv)
widget:SetChildText(0,str1)

local widget1=widget:GetChildWidgetBase(1)
for i=1,5 do
local widget2=widget1:GetChildWidgetBase(i-1)
self:fillWidgetWeight(widget2,weightList[i])
end

widget:SetChildActive(4,not isMax)
widget:SetChildActive(5,isMax)
if not isMax then
local colorlv=FMT.cfmt3("fd8950",nextlv)
local weightList2=fabaoHelper.lianzhiBaseWeight(mainid,nextlv)
local str2=FMT.fmt('将弟子炼器等级提升至：{0}\n基础炼制概率可提升至：',colorlv)
widget:SetChildText(2,str2)
local widget3=widget:GetChildWidgetBase(3)
for i=1,5 do
local widget4=widget3:GetChildWidgetBase(i-1)
self:fillWidgetWeight(widget4,weightList2[i])
end
else
widget:SetChildText(7,'弟子炼器造诣已登峰造极，成败只能看天意了')
end
local ratiodesc=fabaoConfig.getCommonConfig().ratiodesc
widget:SetChildText(6,ratiodesc[1])
widget:SetChildText(8,ratiodesc[2])
end

function UIFabaoWin:freshLuziAni()

local isLianzhi=fabaoModel.isLianZhiFabao(self.ubdId)
self.luzi:setChildModelAnimationState(isLianzhi and 2057 or eAnimationID.stand)
end


function UIFabaoWin:freshBagBtns()

local isMaterilas=self.selectBagType==BAG_TYPE.eMaterialsBag
local isEquip=self.selectBagType==BAG_TYPE.eEquipBag
self.btnsRoot:setActive(false)
self.titleRoot:setActive(isEquip)
self.tempSize:setActive(false)
self.selectEquip:setActive(isEquip)
self.selectMaterilas:setActive(isMaterilas)
self.btnOnekey:setActive(isMaterilas)

local tabType=FULL_TAB_TYPE.eFabao_zhuangbei

self.btnEquips:setActive(false)
self.lock:setActive(not fullScreenModel.isTabOpen(tabType))
end



function UIFabaoWin:setFunctionBtns()
self.funcBtnIdx=1
for i,v in ipairs(self.btnFunc)do
v:setButtonClick(function()
self:onClickBtnFunc(i)
end,true)
end
local names={'全部'}
for i=1,4 do
names[#names+1]=FABAO_LIANZHI_METRAILAS_FUNC_TYPE_Name[i]
end
for i,v in ipairs(self.btnFuncTxt)do
v:setText(names[i])
self.btnSelects[i]:setActive(self.funcBtnIdx==i)
end
end

function UIFabaoWin:showProvideSelectGrids()
if self.showDialogue then
self:freshProvideSelectGrids(true)
return
end
self.showDialogue=true
self.selectBg:setActive(true)
self:freshProvideSelectGrids(true)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'1',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
end

function UIFabaoWin:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
self.curPageIndex=1
self.isSetZero=false
self.selectBg:setActive(false)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'2',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
end

function UIFabaoWin:onClickBtnFunc(index)
if self.funcBtnIdx==index then return end
self.funcBtnIdx=index
self.funcFilter=index-1
self.curPageIndex=1
self.isSetZero=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
self:freshProvideSelectGrids(true)
for i,v in ipairs(self.btnFuncTxt)do
self.btnSelects[i]:setActive(self.funcBtnIdx==i)
end
tipsManager.closeTips()
end

function UIFabaoWin:hasPutAny()
local array=self:getIdxArray()
for _,i in ipairs(array)do
if self:getPutNum(i)>0 then
return true
end
end
return false
end

function UIFabaoWin:isMakeByEquip()
local itemguid=self:getMainGUID()
if itemguid then
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
return itemsConfig.isEquip(itemid)
end
return false
end


























function UIFabaoWin:onSortEquipItems()
if self.selectBagType~=BAG_TYPE.eEquipBag then return end
local sortCompareType=ITEM_SORT_COMPARE_TYPE.eDownOrder
local sortRule={}
sortRule.sort=sortCompareType
sortRule[1]={ITEM_SORT_TYPE.eNewFlag}
sortRule[2]={ITEM_SORT_TYPE.eStage}
sortRule[3]={ITEM_SORT_TYPE.eElement}
sortRule[4]={ITEM_SORT_TYPE.eColor}
table.sort(self.bagList,function(a,b)
local aVal=itemsSortHelper.sort(a,sortRule)
local bVal=itemsSortHelper.sort(b,sortRule)
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return aVal<bVal
end
return aVal>bVal
end)
end

function UIFabaoWin:freshBagList()
local hasMain=self:hasPutMainItem()
local filter={}
for k,v in pairs(self.filter)do
if v==0 then
filter[k]=nil
else
filter[k]=_bag_filter_val[k][v]
end
end


local iseMaterialsBag=self.selectBagType==BAG_TYPE.eMaterialsBag
if iseMaterialsBag then
if filter[ITEM_FILTER_TYPE.eElement]==nil then
filter[ITEM_FILTER_TYPE.eElement]={ITEM_FILTER_COMPARE.eNotNull}
end
filter[ITEM_FILTER_TYPE.eItemConfigAttr]={ITEM_FILTER_COMPARE.eEquals,{{'type1',1}}}
else
filter[ITEM_FILTER_TYPE.eItemConfigAttr]={ITEM_FILTER_COMPARE.eNotNull,{'shentong'}}
end

if self.funcFilter>0 then
filter[ITEM_FILTER_TYPE.eFaBaoMaterialsFuncType]={ITEM_FILTER_COMPARE.eEquals,self.funcFilter}
end


local sortFunc=function(items)
if items and#items>1 then
table.sort(items,function(a,b)
local aUseFlag=not self:isLock(a.itemid)and 1 or 0
local bUseFlag=not self:isLock(b.itemid)and 1 or 0
local aConfig=itemsConfig.getConfig(a.itemid)
local bConfig=itemsConfig.getConfig(b.itemid)
local aneedNum=self:getNeedNumByMainHole(a.itemid)
local agray=not hasMain and aneedNum>a.itemcount or false
local bneedNum=self:getNeedNumByMainHole(a.itemid)
local bgray=not hasMain and bneedNum>b.itemcount or false
local agrayNum=agray and 0 or 1
local bgrayNum=bgray and 0 or 1
if aUseFlag~=bUseFlag then
return aUseFlag>bUseFlag
elseif agrayNum~=bgrayNum then
return agrayNum>bgrayNum
elseif aConfig.stage~=bConfig.stage then
return aConfig.stage>bConfig.stage
elseif aConfig.color~=bConfig.color then
return aConfig.color>bConfig.color
elseif a.itemid~=b.itemid then
return-a.itemid>-b.itemid
else
return true
end
end)
end
end
local bagList=bagControl.getBagItemsByFilter(self.selectBagType,filter)
local sortTag={}
for i,v in ipairs(bagList)do
local itemid=v.itemid
local itemguidStr=tostring(v.itemguid)
local isLock=self:isLock(itemid)
local useFlag=not isLock and 1 or 0
local itemCfg=itemsConfig.getConfig(itemid)

local stageUseFlag=useFlag*itemCfg.stage
if hasMain then
stageUseFlag=itemCfg.stage
end
local needNum=self:getNeedNumByMainHole(v.itemid)
local gray=not hasMain and(isLock or needNum>v.itemcount)or false
local grayNum=gray and 0 or 1
if gray then
stageUseFlag=0
end
sortTag[itemguidStr]=stageUseFlag*9999999+grayNum*999999+(100-itemCfg.stage)*999+itemid/1000
end
table.sort(bagList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
local list={}
local lookup={}

















if#bagList>0 then
for i=#bagList,1,-1 do
local item=bagList[i]
if not lookup[tostring(item.itemguid)]and self:isPutAnyHoleByGUID(item.itemguid)then
list[#list+1]=item
lookup[tostring(item.itemguid)]=true
table.remove(bagList,i)
end
end

for i,v in ipairs(list)do
table.insert(bagList,1,v)
end
end

self.bagList=bagList
self:onSortEquipItems()
end


function UIFabaoWin:isLock(itemid)
return not fabaoHelper.isUnlockByCreate(itemid)
end

function UIFabaoWin:freshProvideSelectGrids(freshData)
if not self.showDialogue then return end
if freshData then
self:freshBagList()
end
local list=self.bagList
local rNum=#list
local pageNum=_row*_colomn
if rNum<pageNum then rNum=pageNum end
local tRow=math.ceil(rNum/_colomn)
local tPage=math.ceil(rNum/pageNum)
self.tPage=tPage
local curPageIndex=self.curPageIndex
local showNum=curPageIndex*pageNum
local showRow=math.ceil(showNum/_colomn)
if curPageIndex==1 then
self.ScrollView:clearSlowItems()
end
self.ScrollView:freshSlowGrids(showNum,showRow,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIFabaoWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local isTemp=itemInfo==nil
local hasPutMainItem=self:hasPutMainItem()
local inGray=not hasPutMainItem or false
if not isTemp then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local num=self:getSelectItemNum(itemguid)
local has=num>0
local itemTxt=num>0 and FMT.fmt('{0}/{1}',num,itemInfo.itemcount)or itemInfo.itemcount>1 and itemInfo.itemcount or''
local showbg=true
local islock=not hasPutMainItem and self:isLock(itemid)or false
local showStage=itemConfig.stage~=nil
local needNum=self:getNeedNumByMainHole(itemid)
local isGray=needNum>itemcount and inGray or islock or false
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true

widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)

widgetHelper.setItemQulaity(widget,itemid,2)
widget:SetChildImageExGray(2,isGray)
widget:SetChildIcon(3,iconName,false)
widget:SetChildImageExGray(3,isGray)
widget:SetChildText(4,itemTxt)
widget:SetChildActive(5,itemTxt~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,islock)
widget:SetChildActive(10,has)
widget:SetChildButtonClick(10,function()self:onClickGridButton(index,itemid,itemguid)end,true)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetChildButtonClick(-1,function()
self:onClickGrid(itemid,index,itemguid,nil)
end)
else
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildText(4,'')
widget:SetChildActive(5,false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildButtonClick(-1,function()
self:onClickGrid(-1,index,-1,nil)
end)
end

local newbieName=FMT.fmt('UIFabaoWin.#ScrollView.Item_{0}',index)
widget:SetChildNewBieComponentId(-1,newbieName)
end


function UIFabaoWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
end
end
end

function UIFabaoWin:freshProvideGridLock(itemguid,isUnlock)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(9,isUnlock)
end
end
end

function UIFabaoWin:freshProvideGridSelect(itemguid)
local idx=self:getBagItemIdx(itemguid)

if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(1,tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true)
else
loggerUtil.logErrFMT('没找到序号的widget：{0}',tostring(itemguid))
end
else

end
end

function UIFabaoWin:freshProvideSelectSingleItemNum(itemguid)
local idx=self:getBagItemIdx(itemguid)
if idx then
local num=self:getSelectItemNum(itemguid)
local item=bagModel.getItem(itemguid)
local itemcount=num>0 and FMT.fmt('{0}/{1}',num,item.itemcount)or item.itemcount
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildText(4,itemcount)
end
end
end


function UIFabaoWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i
end
end
end
































function UIFabaoWin:onDropdownChange(dropIdx,reIdx)
local isMaterials=self.selectBagType==BAG_TYPE.eMaterialsBag
local typo=isMaterials and(dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eElement)or
dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eItemType1AndType2
local len=#_bag_filter_desc[typo]
local idx=len-1-reIdx
if self.filter[typo]==idx then return end
self.curPageIndex=1
self.isSetZero=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
local val=_bag_filter_val[typo][idx]
self.filter[typo]=idx
self:freshProvideSelectGrids(true)
tipsManager.closeTips()
end

function UIFabaoWin:onDropdownCreate(dropIdx,scrollTrans,contentTrans)
local isMaterials=self.selectBagType==BAG_TYPE.eMaterialsBag
local typo=isMaterials and(dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eElement)or
dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eItemType1AndType2
local filterType=typo
local idx=self.filter[filterType]or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=height-(idx)*_dropItemHeight-_dropViewHeight
else
posY=0
end
if posY<=0 then posY=0 end
contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end

function UIFabaoWin:onBtnReset()
if self:hasPutAny()then
for _,itemguid in pairs(self.selectList)do
self:freshProvideSelectSingleGirid(itemguid,false)
self:freshProvideSelectSingleItemNum(itemguid)
end
self.selectList={}
self.selectNumList={}
self.lastSelectIndex=nil
self:setSelectItems()
self:freshAttrPanel()
self:freshLianZhiRoot()
self:freshBagBtns()
self:freshAllItems()
self:hideWeightPanel()
tipsManager.closeTips()
end
end

function UIFabaoWin:onBtnOnekey()
local isChange=false
local mainguid=self:getMainGUID()
local moniSelectList={}
local moniSelectNumList={}
local array=self:getIdxArray()
for _,i in ipairs(array)do
moniSelectList[i]=self.selectList[i]
moniSelectNumList[i]=self:getPutNum(i)
end


local _getSelectItemNum=function(itemguid)
local handle=tostring(itemguid)
local num=0
for _,i in ipairs(array)do
if tostring(moniSelectList[i])==handle then
num=num+(moniSelectNumList[i]or 0)
end
end
return num
end


local _getLeftNum=function(itemguid)
local num=_getSelectItemNum(itemguid)or 0
local item=bagModel.getItem(itemguid)
local itemcount=item.itemcount
return itemcount-num
end


local _getNextFillItemGuid=function(holeIdx)
local bagList=self.bagList or{}
for i,v in ipairs(bagList)do
local left=_getLeftNum(v.itemguid)
local needNum=self:getNeedNumByGUID(moniSelectList[_mainIdx],v.itemguid,holeIdx)
if left>=needNum then
return v.itemguid,left,i
end
end
end


local _getMainFillGuid=function()
local bagList=self.bagList or{}
local idx=_mainIdx
for i,v in ipairs(bagList)do
if not self:isLock(v.itemid)then
local itemguid=v.itemguid
local left=_getLeftNum(itemguid)
local needNum=self:getNeedNumByGUID(moniSelectList[_mainIdx],itemguid,idx)
if left>=needNum then
return itemguid
end
end
end
end

local _addItem=function(index,itemguid,num)
moniSelectList[index]=itemguid
moniSelectNumList[index]=moniSelectNumList[index]+num
end

if mainguid==nil then
local itemguid=_getMainFillGuid()
if itemguid==nil then
UIManager.error('暂无一键放入的合适材料')
return
end
mainguid=itemguid
end
if mainguid==nil then
UIManager.error('暂无一键放入的合适材料')
return
end
local array=self:getOneKeyIdxArray()
for _,i in ipairs(array)do
local hasNum=moniSelectNumList[i]or 0
if self:isMainHole(i)then
local needNum=self:getNeedNumByGUID(moniSelectList[_mainIdx],mainguid,i)
local canAddNum=needNum-hasNum
local leftNum=_getLeftNum(mainguid)
local fillNum=math.min(leftNum,canAddNum)
if fillNum>0 then
_addItem(i,mainguid,fillNum)
isChange=true
self:freshProvideSelectSingleItemNum(mainguid)
self:freshProvideSelectSingleGirid(mainguid,true)
end
else
local itemguid=moniSelectList[i]
if itemguid==nil then
local guid=_getNextFillItemGuid(i)
itemguid=guid
end
if itemguid then
local leftNum=_getLeftNum(itemguid)
local needNum=self:getNeedNumByGUID(moniSelectList[_mainIdx],itemguid,i)
needNum=needNum-hasNum
local addNum=needNum
if needNum>leftNum then
addNum=leftNum
end
local fillNum=math.min(leftNum,addNum)
_addItem(i,itemguid,fillNum)
self:freshProvideSelectSingleItemNum(itemguid)
self:freshProvideSelectSingleGirid(itemguid,true)
isChange=true
end
end
end

if isChange then
self.lastSelectIndex=nil
for _,i in ipairs(array)do
self.selectList[i]=moniSelectList[i]
self:setPutNum(i,moniSelectNumList[i]or 0)
end


self:freshAllItems()
self:setSelectItems()
self:freshAttrPanel()
self:freshLianZhiRoot()
end
tipsManager.closeTips()
end

function UIFabaoWin:freshProvideGrids(bagType)
self.isSetZero=false
self.curPageIndex=1
self.selectBagType=bagType
self.filter={}
self.filter[ITEM_FILTER_TYPE.eElement]=0
self.filter[ITEM_FILTER_TYPE.eStage]=0
self.ScrollView:clearSlowItems()
self:freshFilterDesc()
self:setDropdowns()
self:freshProvideSelectGrids(true)
self:freshBagBtns()
end

function UIFabaoWin:freshAllItems()
if self.selectBagType~=BAG_TYPE.eEquipBag then
self.curPageIndex=1
self.isSetZero=false
self:freshProvideSelectGrids(true)
return true
end
return false
end

function UIFabaoWin:getNextFillItemGuid()
local bagList=self.bagList or{}
for i,v in ipairs(bagList)do
local left=self:getLeftNum(v.itemguid)
if left>0 then
return v.itemguid,left
end
end
end

function UIFabaoWin:getLeftNum(itemguid)
local num=self:getSelectItemNum(itemguid)or 0
local item=bagModel.getItem(itemguid)
local itemcount=item.itemcount
return itemcount-num
end

function UIFabaoWin:startLianzhi(ubdId)
if ubdId~=self.ubdId then return end
self.selectList={}
self.selectNumList={}
self.curPageIndex=1
self.isSetZero=false
self.selectItemguid=nil
self.isSelectGrid=nil
self.selectItemguidIdx=nil
self:freshLianzhiType()
self:closeProvideSelectGrids()
self:setDropdowns()
self:setSelectItems()
self:freshAttrPanel()
self:freshBagBtns()
self:freshLianZhiRoot()
self:freshLianZhiStatus()
self:freshLuziAni()
self:hideWeightPanel()
tipsManager.closeTips()
end

function UIFabaoWin:onFabaoLianzhiInfo()
if not self.needFreshByCreatInfo then return end
self.needFreshByCreatInfo=nil
self:setDropdowns()
self:setSelectItems()
self:freshAttrPanel()
self:freshBagBtns()
self:freshLianZhiRoot()
self:freshLianZhiStatus()
end

function UIFabaoWin:onClickSelect()
if self.diziguid~=0 then
if self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
elseif self.bdData.plant_id>0 then
UIManager.error('建筑执行生产中, 不能更换弟子')
return
end
end
if self.lianzhiType~=FABAO_LIANZHI_TYPE.eNomal then
UIManager.error('弟子正专注炼器，请静候佳音')
return
end
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eManager,dzSelectEffectType.ePlan,2)
end

function UIFabaoWin:checkLianzhi()
if self.diziguid==0 then
return false
end
if not UIDiscipleModel:checkDZStateToDoSomething(self.diziguid,eCheckDiscipleStateOpType.eLianQi,false)then
return false
end
return true
end

function UIFabaoWin:onBtnLianzhi()
if self.diziguid==0 then
UIManager.error('没有进驻弟子')
return
end

if not UIDiscipleModel:checkDZStateToDoSomething(self.diziguid,eCheckDiscipleStateOpType.eLianQi,true)then
return
end

local ret,idx=self:isFullHoles()
if not ret then
if self:isMainHole(idx)then
UIManager.error('请放入主材料')
elseif self:isFzHole(idx)then
UIManager.error('请放入五行精粹')
else
UIManager.error('材料不足')
end
return
end
local percent=self.bdData.pcreatesubpercent or 0
local mainid,itemidlist=self:getSelectMaterials()
local ret,err,args=fabaoHelper.isCanLianzhiMoney(itemidlist,percent)
if not ret then
if err==fabaoHelper.lianzhiErr.eNotEnoughMoney then
local moneyType=args[1]
local moneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt('{0}不足',moneyName))
gainControl:showGainWin(moneyType)
end
return
end
local temp={}
local fzGUID=self.selectList[_fzIdx]or int64.new(0)
local jhGUID=self.selectList[_jhIdx]or int64.new(0)
for i=1,5 do
local itemguid=self.selectList[i]
temp[#temp+1]=itemguid
end
fabaoProtocolControl.reqCreateFabao(self.diziguid,temp,fzGUID,jhGUID,self.ubdId)
end

function UIFabaoWin:onClickBg()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIFabaoWin:onWeighthelp()
self:showWeightPanel()
end

function UIFabaoWin:onBtnMaterials()
if self.selectBagType==BAG_TYPE.eMaterialsBag then return end
self:freshProvideGrids(BAG_TYPE.eMaterialsBag)
tipsManager.closeTips()
end

function UIFabaoWin:onBtnEquips()
if not fullScreenModel.isTabOpen(FULL_TAB_TYPE.eFabao_zhuangbei,true)then return end
if self.selectBagType==BAG_TYPE.eEquipBag then return end
self:freshProvideGrids(BAG_TYPE.eEquipBag)
tipsManager.closeTips()
end

function UIFabaoWin:onBtnReward()
fabaoProtocolControl.reqFabaoPrize(self.ubdId)
end

function UIFabaoWin:onSelectBg()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIFabaoWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
local comCfg=fabaoConfig.getCommonConfig()
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local isEquip=itemsConfig.isEquip(itemid)
local refstage=stage
if isEquip then
refstage=comCfg.stage[stage]or nil
end

local hasMain=self:hasPutMainItem()

if refstage and not hasMain then
local systemLimit=comCfg.system
local sysid=systemLimit[refstage]
if sysid then
local isOpen=systemModel.isOpen(sysid)
if not isOpen then
local tips=systemModel.getOpenTips(sysid)
UIManager.info(tips)
return
end
end
end

local item=bagModel.getItem(itemguid)
local num=item.itemcount
local hasPut=self:getSelectItemNum(itemguid)
num=num-hasPut
local leftNum=self:getLeftPutNum(itemid)
local maxNum=math.min(num,leftNum)
maxNum=math.max(maxNum,1)
local isMakeByEquip=self:isMakeByEquip()
if isMakeByEquip and self:isTempHole(_fzIdx)then
maxNum=1
end

local selectNumCmpArgs={numFormat='放入：<color=#f1ce78>{0}/{1}</color>',
min=1,max=maxNum,val=maxNum}
local fzGUID=self.selectList[_fzIdx]
local isMain=not hasMain or(hasMain and isMakeByEquip and fzGUID==nil)

tipsManager.showTips({formType=TIPS_FORM_TYPE.eLianqiGeBagItem,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,
selectNumCmpArgs=selectNumCmpArgs,
isMain=isMain,
isMakeByEquip=isMakeByEquip},
move=TIPS_MOVE_POS.eCenter})

self:onSelectOneGrid(itemguid,true,index)
end

function UIFabaoWin:putItem(index,itemid,itemguid,fillnum)
if itemid==-1 then return end
local putFinish=itemid~=nil
local handle=tostring(itemguid)
local num=self:getSelectItemNum(itemguid)
local item=bagModel.getItem(itemguid)
local lastHasMain=self:hasPutMainItem()
local itemcount=item.itemcount
if num>=itemcount then
UIManager.error('物品已达上限')
tipsManager.closeTips()
return
end
local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('当前无空位可放入')
tipsManager.closeTips()
return
end
local lastFillNum=self:getPutNum(fillIdx)
local isMainHole=self:isMainHole(fillIdx)
local fillBagType=self:getBagType(fillIdx)
local isFzHole=self:isFzHole(fillIdx)
local isJhHole=self:isJHIdxHole(fillIdx)
local changeBagType=fillBagType~=self.selectBagType
if itemsConfig.isEquip(item.itemid)and not isMainHole then
UIManager.error('装备只能作为主材料')
return
end
if bagHelper.isLock(item)then
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'装备锁定','该装备已锁定，是否解锁并进行精炼消耗？')
self.dialog.okcallback=function()
bagProtocolControl.req_change_bag_item_lockflag(itemguid,true)
if self and not self.isClose then
self:onUnlockItem(itemguid)
end
end
self.dialog:show()
return
end
local lastNum=num
local addNum=1
local curNum=num+addNum
if isMainHole or isFzHole or isJhHole then
local mainItemguid=self:getMainGUID()
local needNum=self:getNeedNumByGUID(mainItemguid,itemguid,fillIdx)
local leibie=isMainHole and'主材料'or
isFzHole or'副材料'or
'精华材料'

if needNum and itemcount<needNum then
local itemName=itemsConfig.getConfig(itemid).name
UIManager.error(FMT.fmt('{0}数量不足以作为{3}({1}/{2})',itemName,itemcount,needNum,leibie))
gainControl:showGainWin(itemid)
return
end
addNum=needNum
curNum=addNum
else
addNum=fillnum
end
if lastNum==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
end
self:addSelectHole(itemguid,fillIdx,addNum)
self:freshProvideSelectSingleItemNum(itemguid)
self:setSelectItems()
self:freshAttrPanel()
self:freshLianZhiRoot()
self:freshBagBtns()
tipsManager.closeTips()

local isMain=isMainHole and not lastHasMain
local mainItemguid=self:getMainGUID()
local mainItem=bagModel.getItem(mainItemguid)
local isEquip=itemsConfig.isEquip(mainItem.itemid)
if changeBagType then
self:freshProvideGrids(fillBagType)
elseif not lastHasMain then
self:freshBagList()
self.ScrollView:freshAllItems()
end
end

function UIFabaoWin:onClickGridButton(index,itemid,itemguid,selectIndex)
if itemid==-1 then return end
local num=self:getSelectItemNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
return
end




local selectIdx=selectIndex or self:getSelectIndex(itemguid)
local isMainItem=self:isMainHole(selectIdx)
local deleteNum=1
local isFzHole=self:isFzHole(selectIdx)
if isMainItem then
deleteNum=num
elseif isFzHole then
deleteNum=self:getPutNum(selectIdx)
end
local lastSelectList=table.deepCopy(self.selectList)
self:deleteSelectNum(selectIdx,deleteNum)
num=num-deleteNum
if self:isMainHole(selectIdx)then
if num<=0 or self:getPutNum(selectIdx)<=0 then
self.selectList={}
self.selectNumList={}
self.curPageIndex=1
self.isSetZero=false
self:freshProvideSelectGrids(true)
else
self:freshProvideSelectSingleItemNum(itemguid)
end
else
local onlyHasMainItem=self:onlyHasMainItem()
local flag=false
if onlyHasMainItem then
flag=self.ScrollView:freshAllItems()
end
if not flag then
if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:freshProvideSelectSingleItemNum(itemguid)
end
end
self:setSelectItems()
self:freshAttrPanel()
self:freshLianZhiRoot()
self:freshBagBtns()
end


function UIFabaoWin:onSelectOneGrid(itemguid,isBagGrid,index)
local lastSelectGrid=self.isSelectGrid
self.isSelectGrid=isBagGrid

local lastItemguid=self.selectItemguid
self.selectItemguid=itemguid

local lastSelectIndex=self.selectItemguidIdx
self.selectItemguidIdx=index

if itemguid==nil or isBagGrid==nil or index==nil then
loggerUtil.logErrFMT('传入参数有问题：itemguid：{0} isBagGrid：{1} index：{2}',itemguid,isBagGrid,index)
return
end
if lastSelectGrid==isBagGrid and tostring(lastItemguid)==tostring(itemguid)and lastSelectIndex==index then
return
end

if lastItemguid then
if lastSelectGrid then
self:freshProvideGridSelect(lastItemguid)
elseif lastSelectGrid==false then
if lastSelectIndex then
local _lastItemguid=self.selectList[lastSelectIndex]
if lastItemguid and tostring(_lastItemguid)==tostring(lastItemguid)then
self:freshOneSelectItemSelectBg(lastSelectIndex)
else


self:closeAllSelectItemSelectBg()
end
else


self:closeAllSelectItemSelectBg()
end
end
end
if isBagGrid then
self:freshProvideGridSelect(itemguid)
elseif isBagGrid==false then
if index then
self:freshOneSelectItemSelectBg(index)
else
loggerUtil.logErrFMT('传入选中序号为空')
end
end
end

function UIFabaoWin:freshOneSelectItemSelectBg(idx)
local slot=self.itemsList[idx]or self.item6
local itemguid=self.selectList[idx]
local widget=slot:getWidgetBase()
widget:SetChildActive(1,self.isSelectGrid==false and
tostring(self.selectItemguid)==tostring(itemguid)and
self.selectItemguidIdx==idx)
end

function UIFabaoWin:closeAllSelectItemSelectBg()
for i,v in ipairs(self.itemsList)do
local widget=v:getWidgetBase()
widget:SetChildActive(1,false)
end
local widget=self.item6:getWidgetBase()
widget:SetChildActive(1,false)
end

function UIFabaoWin:takeOffByTips(index,itemid,itemguid)
self.lastSelectIndex=nil
if self.isSelectGrid==false then
if index==self.selectItemguidIdx then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
end
self:onClickGridButton(nil,itemid,itemguid,index)
end






function UIFabaoWin:onEdgeEvent()

if self.curPageIndex>=self.tPage then return end
self.curPageIndex=self.curPageIndex+1
self:freshProvideSelectGrids()
end

function UIFabaoWin:onClickLuzi()
local itemguid=self:getMainGUID()
self:onSelectItemClick(-1,1,itemguid)
end

function UIFabaoWin:onSelectItemClick(itemid,index,itemguid,attach)

local diziguid=self.diziguid
local haveDz=diziguid and diziguid~=0
local isNomal=self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal
if haveDz then

if UIDiscipleModel:checkDiscipleState(diziguid,DISCIPLE_STATE_TYPE.eChuiWei)then
UIManager.error('弟子垂危，无法炼制法宝')
UIManager:showWindow('UIDiscipleChuiweiWin',{guid=diziguid})
return
elseif self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 无法炼制法宝')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能炼制法宝')
return
end

local lastIndex=self.lastSelectIndex
if not isNomal then
return
end

if lastIndex==index and UIManager:isActive('UITipsWin',true)then
return
end

self.lastSelectIndex=index

local hasItem=itemid~=nil and itemid>0
local isJHIdxHole=self:isJHIdxHole(index)
if isJHIdxHole then
self:showJingHuaSelectWin()
self:onSelectOneGrid(itemguid,false,index)
return
else

local isEquip=hasItem and itemsConfig.isEquip(itemid)or false
local selectBagType=isEquip and BAG_TYPE.eEquipBag or BAG_TYPE.eMaterialsBag
local changeSelectBag=selectBagType~=self.selectBagType
self.selectBagType=selectBagType
self:freshBagBtns()
self:freshFilterDesc()
self:setDropdowns()
if changeSelectBag or not self.showDialogue then
self.ScrollView:clearSlowItems()
self:showProvideSelectGrids()
end
end
if hasItem then
local isMakeByEquip=self:isMakeByEquip()
local isMain=index==_fzIdx or index==_mainIdx
tipsManager.showTips({formType=TIPS_FORM_TYPE.eLianqiGeItem,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,isMain=isMain,isMakeByEquip=isMakeByEquip},
move=TIPS_MOVE_POS.eCenter})
self:onSelectOneGrid(itemguid,false,index)
end
else
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eManager,dzSelectEffectType.ePlan,2)
end
end

function UIFabaoWin:showJingHuaSelectWin()
self:closeProvideSelectGrids()
local dzguid=self.diziguid
if dzguid==nil then
UIManager.error('请先选择主人')
return
end
local itemguid=self.selectList[_jhIdx]
local mainguid=self.selectList[_mainIdx]
local mainitemid=bagModel.getItem(mainguid).itemid
local args={}
args.titleName="升品材料"
args.pos=1
args.extraWin='UIFabaoJingHuaSelectWin'
local extraParams={}
extraParams.itemguid=itemguid
extraParams.mainitemid=mainitemid
extraParams.selectCB=function(guid,itemid,need)
self.selectList[_jhIdx]=guid
self:setPutNum(_jhIdx,need or 0)
self:setSelectItems()
self:freshLianZhiRoot()
end
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIFabaoWin:freshFilterDesc()
local isEquipBag=self.selectBagType==BAG_TYPE.eEquipBag
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=isEquipBag and self.equipStageDesc or
self.nomalStageDesc
_bag_filter_val[ITEM_FILTER_TYPE.eStage]=isEquipBag and self.equipStageVal or
self.nomalStageVal
end

function UIFabaoWin:onLianzhiRet(ubdId)
if ubdId~=self.ubdId then return end
self:freshLianzhiType()
self:freshLianZhiStatus()
self:freshProvideSelectGrids(true)
self:freshAttrPanel()
self:setSelectItems()
self:freshLianZhiRoot()
self:freshLuziAni()
self:refreshShowRewardBox()
end

function UIFabaoWin:onShentongBtn()
local shentong=self.shentongId
local shentongConfig=fabaoConfig.getShentongConfig(shentong)
local lv=self.shentonglv
local args={skillID=shentong,skillLv=lv,fromCfg=true}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
tipsManager.closeTips()
if self.selectItemguid==nil then return end
local itemguid=self.selectItemguid
local isSelectGrid=self.isSelectGrid
self.selectItemguid=nil
self.selectItemguidIdx=nil
self.isSelectGrid=nil
if isSelectGrid==true then
self:freshProvideGridSelect(itemguid)
else
self:freshMainItem()
self:setSelectItems()
end
end


function UIFabaoWin:onBatchCreateBtn()

self:closeProvideSelectGrids()
tipsManager.closeTips()


local ubdId=self.ubdId
self:showWindow('UIFabaoBatchCreateWin',{ubdId=ubdId})
end


function UIFabaoWin:onBtnStopLianzhi()
local ubdId=self.ubdId
local showdata=
{
type='UIDialouge',
title='提示',
content='终止当前批量炼制法宝将返回未炼制方案的材料，是否终止？',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function()
fabaoProtocolControl.reqStopFabaoBatchCreate(ubdId)
end,
showclosebtn=false,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()

end

function UIFabaoWin.onDiscipleJobChange(diziguid,skillId)

end

function UIFabaoWin:onMoneyChanged(moneytype,oldvalue,newvalue)
if moneytype==eMoneyType.mtLingShi or moneytype==eMoneyType.mtXuanTie then
self:freshCostMoney()
end
end

function UIFabaoWin.onBuildingEvent(etype,sfId,bdId,diziguid,olddiziguid)
if _this.bdData.un_build_id~=bdId then return end
if tostring(diziguid)=='0'then diziguid=0 end
if etype==buildingEvent.replaceDisciple then
_this.diziguid=diziguid
zongmenModel:countManufacturePercent(_this.bdData)
_this:freshDiziInfo()
_this:setSelectItems()
_this:freshLianZhiRoot()
end
end

function UIFabaoWin:onItemLockChanged(itemid,itemguid,isUnlock)
self:freshProvideGridLock(itemguid,isUnlock)
if self.unlockItem[tostring(itemguid)]then
self.unlockItem[tostring(itemguid)]=nil
self:putItem(nil,nil,itemguid)
end
end

function UIFabaoWin:onUnlockItem(itemguid)
self.unlockItem[tostring(itemguid)]=true
end

function UIFabaoWin:onCloseSelect()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIFabaoWin:onCloseBtn()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIFabaoWin:onLeftArrow()
self:moveNextBuild(-1)
end

function UIFabaoWin:onRightArrow()
self:moveNextBuild(1)
end

function UIFabaoWin:moveNextBuild(arrow)
local ubdId=self.ubdId
local index
for i,v in ipairs(self.bdDatas)do
if v.un_build_id==ubdId then
index=i
break
end
end

if not index then
return
end

index=index+arrow
local len=#self.bdDatas
if index>len then
index=index-len
elseif index<1 then
index=index+len
end
local bdData=self.bdDatas[index]
local args={entityId=bdData.entityId}
UIFullLianQiGeControl:setAttach(args)
self:onShowArgRecv(args)
end
