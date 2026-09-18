







def_class("UIWanBaoXunBaoDui_EmployeeWin",UIWindowBase)









function UIWanBaoXunBaoDui_EmployeeWin:bindComponents()

self.Root=UIObject.get(self,0)
self.dismissBtn=UIButton.get(self,1)
self.moveRoot=UIObject.get(self,2)
self.eymployeeNumber=UIText.get(self,3)
self.employeeScrollView=UIScrollView.get(self,4)
self.qualityDropDown=UIDropdownEx.get(self,5)
self.sortTypeDropdown=UIDropdown.get(self,6)
self.nocatimgbtn=UIObject.get(self,7)
self.featuresRoot=UIObject.get(self,8)
self.huifuBtn=UIButton.get(self,9)
self.quipRoot=UIObject.get(self,10)
self.baseAttr=UIObject.get(self,11)
self.employeeLevelRoot=UIObject.get(self,12)
self.progresstxt=UIText.get(self,13)
self.freatures=UIObject.get(self,14)
self.ploygonRoot=UIObject.get(self,15)
self.helpBtn=UIButton.get(self,16)
self.equipItemRoot=UIObject.get(self,17)
self.equip=UIBaseItem.get(self,18)
self.equipReddot=UIObject.get(self,19)
self.equipBtn=UIButton.get(self,20)
self.lvinfo=UIObject.get(self,21)
self.fillEquipReddot=UIObject.get(self,22)
self.fillEquipImg=UIObject.get(self,23)
self.equiplv=UIText.get(self,24)
self.leftRoot=UIObject.get(self,25)
self.rightRoot=UIObject.get(self,26)
self.restoreConsumeTip=UILinkImageText.get(self,27)
self.levelprogress=UIProgressBarAni.get(self,28)
self.addExpBtn=UIButton.get(self,29)
self.arraw=UIObject.get(self,30)
self.captiontxt=UIText.get(self,31)
self.levelinfo=UIText.get(self,32)

self.dismissBtn:setButtonClick(function()self:onDismissBtn()end)

self.huifuBtn:setButtonClick(function()self:onHuifuBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.equipBtn:setButtonClick(function()self:onEquipBtn()end)

self.addExpBtn:setButtonClick(function()self:onAddExpBtn()end)



end


function UIWanBaoXunBaoDui_EmployeeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.dismissBtn);self.dismissBtn=nil;
_UIObject_release(self.moveRoot);self.moveRoot=nil;
_UIObject_release(self.eymployeeNumber);self.eymployeeNumber=nil;
_UIObject_release(self.employeeScrollView);self.employeeScrollView=nil;
_UIObject_release(self.qualityDropDown);self.qualityDropDown=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.nocatimgbtn);self.nocatimgbtn=nil;
_UIObject_release(self.featuresRoot);self.featuresRoot=nil;
_UIObject_release(self.huifuBtn);self.huifuBtn=nil;
_UIObject_release(self.quipRoot);self.quipRoot=nil;
_UIObject_release(self.baseAttr);self.baseAttr=nil;
_UIObject_release(self.employeeLevelRoot);self.employeeLevelRoot=nil;
_UIObject_release(self.progresstxt);self.progresstxt=nil;
_UIObject_release(self.freatures);self.freatures=nil;
_UIObject_release(self.ploygonRoot);self.ploygonRoot=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.equipItemRoot);self.equipItemRoot=nil;
_UIObject_release(self.equip);self.equip=nil;
_UIObject_release(self.equipReddot);self.equipReddot=nil;
_UIObject_release(self.equipBtn);self.equipBtn=nil;
_UIObject_release(self.lvinfo);self.lvinfo=nil;
_UIObject_release(self.fillEquipReddot);self.fillEquipReddot=nil;
_UIObject_release(self.fillEquipImg);self.fillEquipImg=nil;
_UIObject_release(self.equiplv);self.equiplv=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.restoreConsumeTip);self.restoreConsumeTip=nil;
_UIObject_release(self.levelprogress);self.levelprogress=nil;
_UIObject_release(self.addExpBtn);self.addExpBtn=nil;
_UIObject_release(self.arraw);self.arraw=nil;
_UIObject_release(self.captiontxt);self.captiontxt=nil;
_UIObject_release(self.levelinfo);self.levelinfo=nil;
end
















local CmpCatItemIndex={
quality=0,
drawing=1,
name=2,
energy=3,
levelbg=4,
leveltxt=5,
select=6,
gray=7,
}




function UIWanBaoXunBaoDui_EmployeeWin:onLoaded(...)
self:bindComponents()
local employeeCardClick=function(id,index,guid,attach)
self:onClickEmployeeCard(id,index,guid,attach)
end
self.employeeScrollView:setClickAction(employeeCardClick)
local qualityDropDownChangeEvent=function(...)
self:onChangeQualityDropDown(...)
end
self.sortTypeDropdown:setChangeAction(qualityDropDownChangeEvent)

self.employeeScrollView:bindScrollWidget(function(...)self:bindEmployeeItem(...)end)

self:addNotify(notifyConfig.onWanBaoXunBaoDuiDealCatInterView,function(...)self:onWanBaoXunBaoDuiDealCatInterView(...)end)

UIManager.setMoneyMsgShowState(true,true)

self.moveRoot:setChildAnchoredPos(0,700)
end


function UIWanBaoXunBaoDui_EmployeeWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_EmployeeWin:onShow(argtable,afterOnloaded)
self.selectIndex=1
self.dropDownIndex=1
self.needEnergy=argtable and(argtable.needEnergy or 0)or 0
self:initUI()

self:playAnimation()
end


function UIWanBaoXunBaoDui_EmployeeWin:onHide()

end

function UIWanBaoXunBaoDui_EmployeeWin:onShowArgRecv()

self:initUI()
self:playAnimation()
end

function UIWanBaoXunBaoDui_EmployeeWin:playAnimation()
if self.tw then
self.tw:Kill()
self.tw=nil
end

UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MenuWin','playSwitchAnimation',10)
self.moveRoot:setChildAnchoredPos(0,800)
self.tw=self.moveRoot:setChildDOAnchorPosY(0,0.5,function()
UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MenuWin','playSwitchAnimation',0)
end)
end





function UIWanBaoXunBaoDui_EmployeeWin:onAddExpBtn()
local itemlist=wanBaoXunBaoDuiModel:getEmployeeExpItemdata()
local constDef=wanBaoXunBaoDuiModel:getConstDef()
local up_exp_item_list=constDef.up_exp_item_list
if#itemlist>0 then
UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDui_UpLevelWin",{data=self.employeeDatas[self.selectIndex]})
else
gainControl:showGainWin(up_exp_item_list[1])
end
end

function UIWanBaoXunBaoDui_EmployeeWin:onDismissBtn()
local data=self.employeeDatas[self.selectIndex]
if data then
local cfg=cfgHelper.get1(cfg_catshowconfig_get,data.wx_id)
if cfg.cantDel then
UIManager.info("该雇员不能解雇")
return
end
if wanBaoXunBaoDuiModel:isWorking(data.guid)then
UIManager.info("该猫猫已派遣到航船上")
return
end
UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDui_DismissDialogWin",{employeeData=data})
end
end

function UIWanBaoXunBaoDui_EmployeeWin:onHuifuBtn()
local data=self.employeeDatas[self.selectIndex]
self:showBuyTiliDialoug(data)
end

function UIWanBaoXunBaoDui_EmployeeWin:onHelpBtn()
local d={}
d.title='提示'
d.mode=3
d.name='wbxbd_attr_rule_help_%d'
self:showWindow('UIRuleWin',d)
end

function UIWanBaoXunBaoDui_EmployeeWin:onEquipBtn()
local catdata=self.employeeDatas[self.selectIndex]
if catdata~=nil then
if not wanBaoXunBaoDuiModel:isWorking(catdata.guid)or catdata.state~=1 then
if catdata.equip_num>0 then
local equipItemData=catdata.equipList[1]
local attach={catguid=catdata.guid}
tipsManager.showTips({formType=TIPS_FORM_TYPE.eMMCommonEquip,itemid=equipItemData.itemid,itemguid=equipItemData.itemguid,attach=attach})
else
UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDui_SelectEquipWin",{
type=WBXBD_SelectEquip_TYPE.ER,
catguid=catdata.guid,
removecallback=function(itemguid,catguid)
wanBaoXunBaoDuiController:reqRemoveEquipment(catguid,1,itemguid)
end,
equipcallback=function(itemguid,catguid)
wanBaoXunBaoDuiController:reqRemoveEquipment(catguid,0,itemguid)
end
})
end
else
UIManager.info('该猫猫冒险中…')
end
end
end


function UIWanBaoXunBaoDui_EmployeeWin:onClickEmployeeCard(id,index,guid,attach)


local preitem=self.employeeScrollView:getGridObjectByindex(self.selectIndex-1)
preitem:SetChildActive(CmpCatItemIndex.select,false)

self.selectIndex=index
local item=self.employeeScrollView:getGridObjectByindex(index-1)
item:SetChildActive(CmpCatItemIndex.select,true)

self:freshSelectLeftPart()
end



local colorSort={1,2,3,4,5}

function UIWanBaoXunBaoDui_EmployeeWin:onChangeQualityDropDown(dropIdx)
self.selectIndex=1
local idx=dropIdx+1
self.dropDownIndex=idx

self:initData()
self:freshEmployCardPart()
self:freshSelectLeftPart()
end


function UIWanBaoXunBaoDui_EmployeeWin:initUI()
self:initData()
self:freshEmployCardPart()
self:freshSelectLeftPart()
self:freshQualityDropDown()
end

function UIWanBaoXunBaoDui_EmployeeWin:initData()

local elist=wanBaoXunBaoDuiModel:getEmployeeList()
local temp={}
for k,v in pairs(elist)do
if v.color>=colorSort[self.dropDownIndex]then
temp[#temp+1]=v
end
end

self.employeeDatas=wanBaoXunBaoDuiModel:sortEmployeeDatas(temp)
self.selectIndex=Mathf.Min(self.selectIndex,Mathf.Max(1,#self.employeeDatas))
end

function UIWanBaoXunBaoDui_EmployeeWin:freshQualityDropDown()
local optiontxts=wanBaoXunBaoDuiModel:getEmployeeQualityOptionTxts()
self.sortTypeDropdown:setOption(optiontxts)
self.sortTypeDropdown:setValue(self.dropDownIndex-1)
end

function UIWanBaoXunBaoDui_EmployeeWin:freshEmployCardPart()
local maxEmployeeNumber=wanBaoXunBaoDuiModel:getEmployMaxNumber()
local employeeCurNumber=#self.employeeDatas
self.eymployeeNumber:setText(toColorStringX("#000000",FMT.fmt("猫猫雇员\n({0}/{1})",employeeCurNumber,maxEmployeeNumber)))

self.employeeScrollView:freshGridsNum(employeeCurNumber,Mathf.Ceil(employeeCurNumber/3),3,not self.emzero)
self.emzero=true

self.nocatimgbtn:setActive(employeeCurNumber==0)
end

function UIWanBaoXunBaoDui_EmployeeWin:bindEmployeeItem(index,item)
local data=self.employeeDatas[index]

item:SetChildActive(-1,data~=nil)
if data~=nil then
self:freshSingleEmployeeItem(index,item,data)
end
end

function UIWanBaoXunBaoDui_EmployeeWin:freshSingleEmployeeItem(index,item,data)


local quliatyIcon,qab=wanbaoXunBaoDuiHelper:getCatQualityFrame(data.color)
item:SetChildCSImageSprite(CmpCatItemIndex.quality,qab,quliatyIcon)


local modelid,components=wanbaoXunBaoDuiHelper:getCatModelCaptureImageParam(data)
item:SetChildModelCaptureImage(CmpCatItemIndex.drawing,modelid,components,2.5,eAnimationID.idle,0,-15,Vector2(0,55),1,false)


local name=cfgHelper.get2(cfg_catnameconfig_get,data.name_id,'name')
item:SetChildText(CmpCatItemIndex.name,name)


local lvbgIcon,lab=wanbaoXunBaoDuiHelper:getCatLevelFrame(data.color)
item:SetChildCSImageSprite(CmpCatItemIndex.levelbg,lab,lvbgIcon)


item:SetChildText(CmpCatItemIndex.leveltxt,data.lv)


item:SetChildActive(CmpCatItemIndex.select,self.selectIndex==index)


local grayState=bitHelper.check_pos(data.state,0)
item:SetChildActive(CmpCatItemIndex.gray,grayState)


local maxTili=wanBaoXunBaoDuiModel:caculationMaxTili(data)
if data.tili>=self.needEnergy then
item:SetChildText(CmpCatItemIndex.energy,FMT.fmt('{0} {1}/{2}',toColorStringX('#7D3B17','体力'),data.tili,maxTili))
else
item:SetChildText(CmpCatItemIndex.energy,FMT.fmt('{0} {1}/{2}',toColorStringX('#7D3B17','体力'),toColorString(FONT_COLOR.eRedColor,data.tili),maxTili))
end
end

function UIWanBaoXunBaoDui_EmployeeWin:freshSelectLeftPart()
local data=self.employeeDatas[self.selectIndex]
local isCanDismiss=data~=nil and data.state~=1


self:freshEmployeeLevel(data)
self:freshEmployeeFeatures(data)
self:freshEmployeePloygon(data)
self:freshEmployeeEquip(data)
self:freshRestoreBtn(data)

self.dismissBtn:setButtonEnable(isCanDismiss,not isCanDismiss)
end

function UIWanBaoXunBaoDui_EmployeeWin:freshEmployeeLevel(data)
local isMax=true
if data then
local uplvcfg=cfgHelper.get1(cfg_catlvconfig_get,data.lv+1)
local maxExp=uplvcfg and uplvcfg.exp or cfgHelper.get1(cfg_catlvconfig_get,data.lv).exp

local info
local exp
isMax=wanBaoXunBaoDuiModel:getMaxUpLevel()==data.lv
if isMax then
info="满级"
exp=maxExp
else
exp=data.exp
info=FMT.fmt("{0}/{1}",data.exp,maxExp)
end

self.levelinfo:setText(FMT.fmt("{0}级",data.lv))
self.levelprogress:animateThreeParams(exp,maxExp,0.1)
self.progresstxt:setText(info)
else
self.levelinfo:setText(FMT.fmt("{0}级",0))
self.levelprogress:animateThreeParams(0,100,0.1)
self.progresstxt:setText(FMT.fmt("{0}/{1}",0,0))
end

self.addExpBtn:setButtonEnable(not isMax,isMax)
end

function UIWanBaoXunBaoDui_EmployeeWin:freshEmployeeFeatures(data)
if data then
self.freatures:setActive(data~=nil)
self.freatures:setChildLayoutGroupCreateItems(data.texing_num,function(index)
local txid=data.txList[index]
local item=self.freatures:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(-1,txid~=nil)
if txid then
local txconfig=cfgHelper.get1(cfg_cattxconfig_get,txid)
local name=UIDiscipleModel.getSpecialityNameStr(txconfig.name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(txconfig.frame)
item:SetChildCSImageSprite(0,abName,frameIcon)
item:SetChildText(1,name)
item:SetBaseItemClickEvent(-1,function(id,index,guid,attach)

self:showWindow('UIWanBaoXunBaoDui_SpeicialWin',{
item=item,
node='top',
spid=txid,
})
end)
end
end)
end
end

function UIWanBaoXunBaoDui_EmployeeWin:freshEmployeePloygon(data)
local baseAttrData=wanBaoXunBaoDuiModel:getSelectEmployeeBaseAttrData(data)
local widght=self.ploygonRoot:getWidgetBase()

if data then
widght:SetChildActive(6,true)
local const_def=wanBaoXunBaoDuiModel:getConstDef()
local ploygonData=wanBaoXunBaoDuiModel:getEmployeePloygonData(data,const_def.singlePropMax)
widght:SetChildUIPolygonImage(6,ploygonData,270)
else
widght:SetChildActive(6,false)
end

for k,v in pairs(baseAttrData)do
local cweight=widght:GetChildWidgetBase(k)
cweight:SetChildText(1,v.name)
cweight:SetChildText(2,v.value)
end
end

function UIWanBaoXunBaoDui_EmployeeWin:freshEmployeeDressEquip(catdata)
self:freshEmployeePloygon(catdata)
self:freshEmployeeEquip(catdata)
local index
for k,v in pairs(self.employeeDatas)do
if v.guid==catdata.guid then
index=k
end
end
local item=self.employeeScrollView:getGridObjectByindex(index-1)
self:bindEmployeeItem(index,item)
end


function UIWanBaoXunBaoDui_EmployeeWin:freshEmployeeEquip(catdata)
local bagEquipNum=#wanBaoXunBaoDuiController:getMaomaoEquipBagDataInBag(1)
self.equip:setActive(catdata and catdata.equip_num>0)
self.fillEquipImg:setActive(catdata==nil or catdata.equip_num==0)
self.fillEquipImg:setGray(catdata==nil)
self.lvinfo:setActive(catdata~=nil and catdata.equip_num>0)
self.equipReddot:setActive(catdata~=nil and catdata.equip_num==0 and bagEquipNum>0)
if catdata then
local hasEquip=catdata.equip_num>0
local equipWidget=self.equip:getWidgetBase()
equipWidget:SetChildActive(0,hasEquip)
equipWidget:SetChildActive(1,hasEquip)
if hasEquip then
local equip=catdata.equipList[1]
local equipid=equip.itemid
local color=itemsConfig.getItemColor(equipid)
local icon=iconHelper.getIconName(equipid)
equipWidget:SetChildCSImageSprite(0,globalABLookup.wanbaoxunbaodui,FMT.fmt('image_mmtanxianzbpz_{0}',color))
equipWidget:SetChildIcon(1,icon,true)

self.lvinfo:setActive(equip.itemData.jl_lv>0)
self.equiplv:setText(FMT.fmt('{0}级',equip.itemData.jl_lv))
end
end
end

function UIWanBaoXunBaoDui_EmployeeWin:freshRestoreBtn(data)
local isActiveRestoreBtn=data~=nil
if data then
local maxTili=data~=nil and wanBaoXunBaoDuiModel:caculationMaxTili(data)or 0
isActiveRestoreBtn=data~=nil and data.state~=1 and maxTili>data.tili

self.restoreConsumeTip:setActive(isActiveRestoreBtn)
if isActiveRestoreBtn then
local const_def=wanBaoXunBaoDuiModel:getConstDef()
local moneyid=const_def.add_tili_need[1]
local rate=const_def.add_tili_need[2]
local least=maxTili-data.tili
local iconname=iconHelper.getIconName(moneyid)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,28)

local needNum=rate*least
local numStr=needNum
local contentStr=FMT.fmt('{0} {1} {2}',toColorString(FONT_COLOR.eOrangeDescColor,'花费'),iconStr,numStr)
self.restoreConsumeTip:setText(contentStr)
end
end
self.huifuBtn:setButtonEnable(isActiveRestoreBtn,not isActiveRestoreBtn)
end

function UIWanBaoXunBaoDui_EmployeeWin:showBuyTiliDialoug(data,needTili)
local const_def=wanBaoXunBaoDuiModel:getConstDef()
local maxTili=wanBaoXunBaoDuiModel:caculationMaxTili(data)
local moneyid=const_def.add_tili_need[1]
local rate=const_def.add_tili_need[2]
local least=maxTili-data.tili

local iconname=iconHelper.getIconName(moneyid)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,40)

local needNum=rate*least
local numStr=needNum
local contentStr=FMT.fmt('目前猫猫体力为{0}/{1},是否消耗{2} {3} 购买<color=#6833c0>{4}</color>点体力',data.tili,maxTili,numStr,iconStr,least)

local callback=function()
local moneyNum=itemsModel.getCount(moneyid)
if moneyNum>=needNum then
wanBaoXunBaoDuiController:reqRecoverCatTiliByUseMoney(1,{{data.guid,least}})
else
gainControl:showGainWin(moneyid,needNum)
end
end

local show_data={
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=callback,
moneytypes={{eMoneyType.mtYuBi}},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


function UIWanBaoXunBaoDui_EmployeeWin:freshEmployee()
self:freshEmployCardPart()
self:freshSelectLeftPart()
end

function UIWanBaoXunBaoDui_EmployeeWin:refreshEmployeeUp(catinfo)
self:initData()
for k,v in ipairs(self.employeeDatas)do
if v.guid==catinfo.guid then
self.selectIndex=k
break
end
end
self:freshEmployee()
end

function UIWanBaoXunBaoDui_EmployeeWin:onWanBaoXunBaoDuiDealCatInterView(index,type)
self:initUI()
end

function UIWanBaoXunBaoDui_EmployeeWin:onNoCatBtn()
UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiRecruitWindow()
end

