







def_class("UIEquipRongHeWin",UIWindowBase)









function UIEquipRongHeWin:bindComponents()

self.leftDialogue=UIButton.get(self,0)
self.disciplePanel=UIObject.get(self,1)
self.leftPanel=UIObject.get(self,2)
self.effectRoot=UIObject.get(self,3)
self.leftdialogueinfo=UIObject.get(self,4)
self.equipList=UIObject.get(self,5)
self.effect1=UIObject.get(self,6)
self.effect2=UIObject.get(self,7)
self.effect3=UIObject.get(self,8)
self.effect4=UIObject.get(self,9)
self.effect0=UIObject.get(self,10)
self.effect=UIObject.get(self,11)
self.effect5=UIObject.get(self,12)
self.ScrollView=UIScrollViewSlow.get(self,13)
self.Dropdown2_Dialogue=UIDropdownEx.get(self,14)
self.Dropdown1_Dialogue=UIDropdownEx.get(self,15)
self.putBtnReddot_Dialogue=UIObject.get(self,16)
self.name=UIText.get(self,17)
self.discipleList=UIScrollView.get(self,18)
self.equipone=UIBaseItem.get(self,19)
self.equiptwo=UIBaseItem.get(self,20)
self.tipsbtn=UIButton.get(self,21)
self.cost1=UIObject.get(self,22)
self.nlbtn=UIButton.get(self,23)
self.cost2=UIObject.get(self,24)
self.btnpanel=UIObject.get(self,25)
self.maxtxt=UIText.get(self,26)
self.sxleft=UIObject.get(self,27)
self.sxright=UIObject.get(self,28)
self.ScrollView2=UIScrollViewSlow.get(self,29)
self.cost3=UIObject.get(self,30)

self.leftDialogue:setButtonClick(function()self:onLeftDialogue()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.nlbtn:setButtonClick(function()self:onNlbtn()end)
self.Dropdown2={
["Dialogue"]=self.Dropdown2_Dialogue,
}
self.Dropdown1={
["Dialogue"]=self.Dropdown1_Dialogue,
}
self.putBtnReddot={
["Dialogue"]=self.putBtnReddot_Dialogue,
}



end


function UIEquipRongHeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftDialogue);self.leftDialogue=nil;
_UIObject_release(self.disciplePanel);self.disciplePanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.leftdialogueinfo);self.leftdialogueinfo=nil;
_UIObject_release(self.equipList);self.equipList=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect0);self.effect0=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Dropdown2_Dialogue);self.Dropdown2_Dialogue=nil;
_UIObject_release(self.Dropdown1_Dialogue);self.Dropdown1_Dialogue=nil;
_UIObject_release(self.putBtnReddot_Dialogue);self.putBtnReddot_Dialogue=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
_UIObject_release(self.equipone);self.equipone=nil;
_UIObject_release(self.equiptwo);self.equiptwo=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.cost1);self.cost1=nil;
_UIObject_release(self.nlbtn);self.nlbtn=nil;
_UIObject_release(self.cost2);self.cost2=nil;
_UIObject_release(self.btnpanel);self.btnpanel=nil;
_UIObject_release(self.maxtxt);self.maxtxt=nil;
_UIObject_release(self.sxleft);self.sxleft=nil;
_UIObject_release(self.sxright);self.sxright=nil;
_UIObject_release(self.ScrollView2);self.ScrollView2=nil;
_UIObject_release(self.cost3);self.cost3=nil;
self.Dropdown2=nil;
self.Dropdown1=nil;
self.putBtnReddot=nil;
end
















local _this
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"
local equipSlotIndex={
[EQUIP_TYPE.eWeapon]=0,
[EQUIP_TYPE.eClothes]=1,
[EQUIP_TYPE.eCap]=2,
[EQUIP_TYPE.eShoot]=3,
}
local _equipTypeLookup={}
for k,v in pairs(equipSlotIndex)do
_equipTypeLookup[v]=k
end
local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpSuitIcon=13,
cmpSelect=14,
xmicons=15,
xmstagetxt=16,
xmtxt=17,
}
local shuxidx=
{
selfshux=0,
arrs={1,2,3,4},
value={5,6,7,8},
}
local moneyidx=
{
selfcost=0,
micon=1,
mtxt=2
}
local _colomn=5
local _row=5




function UIEquipRongHeWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChange)
self._on_select_dis=function(...)
self:on_select_dis(...)
end
self.discipleList:setClickAction(self._on_select_dis)
self.isInitDiscipleList=false

self.equipListWidget=self.equipList:getChildWidgetBase()
for equipType,idx in ipairs(equipSlotIndex)do
self.equipListWidget:SetBaseItemClickEvent(idx,function(...)self:onBaseItemClick(...)end)
self.equipListWidget:SetBaseItemChildIndex(idx,equipType)
end

self.ScrollView2:setSlowClickAction(function(...)self:onClickGrid(...)end)
self.ScrollView2:setSlowLongClickAction(function(...)self:onClickLongGridButton(...)end)
self.ScrollView2:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
self.unlockItem={}

self.equipxm={self.equipone,self.equiptwo}
self.costMoney={self.cost1,self.cost2,self.cost3}
end


function UIEquipRongHeWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChange)
_this=nil
end


function UIEquipRongHeWin:onHide()
self.discipleList:setActive(false)
self.equipList:setActive(false)
self:closeProvideSelectGrids()
end

function UIEquipRongHeWin:resetData()
end

function UIEquipRongHeWin:onEquipClickNobtn(itemid,itemguid)
if itemid then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eNoBtns,itemid=itemid,itemguid=itemguid,})
end
end

function UIEquipRongHeWin:onTipsbtn()
local d={}
d.title='规则'
d.mode=3
d.name='UIEquipRongHeWin_Tips_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIEquipRongHeWin:onNlbtn()
local rhequip=self.rhitem
if not rhequip then
UIManager.info("请选择融合装备")
return
end
local equip=self.item
local cost=equipsModel.getEquipXMRHNeedCost(equip.itemid)
for k,v in ipairs(cost)do
local itemid=v[1]
local itemnum=v[2]
local havecount=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end
if havecount<itemnum then
gainControl:showGainWin(itemid)
return
end
end
local leftjllvl=equip.itemData.jinglianlv or 0
local rightjllvl=rhequip.itemData.jinglianlv or 0



local data=equipsModel:getChongZhuEquipData(equip.itemguid)
local flag=data~=nil and data.flag or 0
local selectAttr=bitHelper.check_pos(flag,0)
local selectSuit=bitHelper.check_pos(flag,1)



local _czfunc=function()
if selectAttr then
local show_data=
{
title='提示',
_okText="确认",
_cancelText="取消",
tipsText='当前融合装备有重铸属性未确认，确认融合后该装备的<color=#ca631d>重铸属性会消失</color>。是否融合？',
closetopbtn=true,
cellcallback=function()
return equipsProtocolControl:send_2_164(equip.itemguid,rhequip.itemguid)
end,
cellcallback3=function()
return oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipChongZhu,{itemguid=equip.itemguid})
end,
}
UIManager:showWindow('UIXMCZDialougeTips',show_data)
else
equipsProtocolControl:send_2_164(equip.itemguid,rhequip.itemguid)
end
end


local itemConfig=itemsConfig.getConfig(rhequip.itemid)


local str=FMT.fmt("将所选的<color={1}>【{0}】</color>消耗掉\n并把<color=#549327>随机属性</color>和<color=#549327>精炼等级</color>迁移到仙魔装备上\n是否执行？",itemConfig.name,FONT_COLOR_VAL[itemConfig.color])
local _func=function()
if leftjllvl>rightjllvl then
local showdata=
{
type='UIDialouge',
title='提示',
content='<color=#c82c2c>仙魔装备</color>精炼等级会被<color=#c82c2c>融合装备</color>精炼等级覆盖\n是否确认？',
oktext='确定',
canceltext='取消',
allowclickBG='false',



okcallback=_czfunc,
showclosebtn=true,
}
local comfirmDialog3=UIDialogManager.newDialog(showdata)
comfirmDialog3:show()
else

_czfunc()
end
end

local reveal_times=equipsModel:getDianHuaCnt(rhequip)
if reveal_times and reveal_times>0 then
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText=str,
closetopbtn=true,
cellcallback=function()
local showdata=
{
type='UIDialouge',
title='提示',

content=FMT.fmt("当前<color={1}>【{0}】</color>已点化过\n消耗会返还<color=#549327>100%</color>的点化材料\n是否确认?",itemConfig.name,FONT_COLOR_VAL[itemConfig.color]),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=_func,
showclosebtn=true,
}
local comfirmDialog2=UIDialogManager.newDialog(showdata)
comfirmDialog2:show()
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
else

local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText=str,
closetopbtn=true,
cellcallback=_func,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
end
end

function UIEquipRongHeWin.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
if _this==nil then
return
end
_this:refreshXMRHcost()
end

function UIEquipRongHeWin.onMoneyChange(moneyType,lastVal,val)
if _this==nil then
return
end
_this:refreshXMRHcost()
end




function UIEquipRongHeWin:onShow(argtable,afterOnloaded)
self:freshEquip(argtable)
end


function UIEquipRongHeWin:freshEquip(argtable)
self:resetData()
if argtable then
local itemguid=argtable.itemguid
self.item=equipsHelper.getEquip(itemguid)
local isEquip=equipsModel.isEquipedOnAnyDizi(itemguid)
self.isEquip=isEquip

self.rhitem=nil
self.rhitemguid=nil
end
self.disciplelist={}
if self.isEquip then
self.disciple_guid=equipsModel.getDiziguidByItemguid(argtable.itemguid)
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
local sortType=UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local sortParams={true}
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder,sortParams)
for i,v in ipairs(list)do
local equipList=equipsModel.getAllEquipsByDizi(v.netData.net.discipleguid)
if equipList and#equipList>0 then
table.insert(self.disciplelist,v)
end
end
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,self.disciple_guid)then
self.curDisIndex=i
break
end
end
end
local len=#self.disciplelist
if len>0 then
if not self.isInitDiscipleList then
self.isInitDiscipleList=true
self:refreshDiscipleList()
self:refreshEquipList()
else
self.discipleList:setActive(true)
self.equipList:setActive(true)
end
end
self.disciplePanel:setActive(len>0)
if not self.isEquip then
self.equipList:setActive(false)
end

self:refreshXMRHLeft()
self:refreshXMRHRight()
self:refreshXMRHcost()
self:closeProvideSelectGrids()
self:showProvideSelectGrids()
end


function UIEquipRongHeWin:RefreshRongHE()
_this:refreshXMRHLeft()
_this.rhitem=nil
_this.rhitemguid=nil
_this:refreshXMRHRight()
_this:refreshXMRHcost()
_this:closeProvideSelectGrids()
_this:showProvideSelectGrids()
_this:refreshEquipList()
end

function UIEquipRongHeWin:chenggongEffect()
_this.effect:setChildShowEffect(10060,true)
end


function UIEquipRongHeWin:refreshXMRHLeft()
local equip=self.item
local widget=self.equipxm[1]:getChildWidgetBase()
local ninglian_star=equipsModel.getNingLianStar(equip)
self:fillItemXM(equip,widget,ninglian_star)


local randattrList=equipsModel.getXMRandattrList(equip)
local lweight=self.sxleft:getChildWidgetBase()
for k,v in ipairs(shuxidx.arrs)do
if randattrList and randattrList[k]then
lweight:SetChildActive(shuxidx.arrs[k],true)
local sxdata=randattrList[k]
local arrtype=sxdata.param_1
local arrvalue=sxdata.param_2
local name,valstr=equipsHelper.getAttr(arrtype,arrvalue)
lweight:SetChildText(shuxidx.arrs[k],name)
lweight:SetChildText(shuxidx.value[k],FMT.fmt("+{0}",valstr))
else
lweight:SetChildActive(shuxidx.arrs[k],false)
end
end
end
function UIEquipRongHeWin:fillItemXM(equip,widget,ninglianStar)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=showStage and FMT.fmt('仙·{0}{1}',stage,stageTitile)or''
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=showStage and FMT.fmt('魔·{0}{1}',stage,stageTitile)or''
end
local star=0
local reddot=false
local suitIconName=''
if itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
suitIconName=equipsHelper.getEquipSuitIcon(equip)
end
widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)

widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildText(_itemWidgetIdx.xmstagetxt,xmstageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end

if ninglianStar and ninglianStar>0 then
widget:SetChildActive(_itemWidgetIdx.xmicons,true)
local xmWidget=widget:GetChildWidgetBase(_itemWidgetIdx.xmicons)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_jinlian1")
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_moyan1")
end
end
end
else
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
end
widget:SetBaseItemClickEvent(-1,function()
self:onEquipClickNobtn(itemid,itemguid)
end)
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetBaseItemClickEvent(-1,function()
self:onEquipClickNobtn()
end)
end
end

function UIEquipRongHeWin:refreshXMRHRight()
local equip=self.rhitem
local widget=self.equipxm[2]:getChildWidgetBase()
self:fillItemXM(equip,widget)

local randattrList=equipsModel.getXMRandattrList(equip)
local lweight=self.sxright:getChildWidgetBase()
for k,v in ipairs(shuxidx.arrs)do
if randattrList and randattrList[k]then
lweight:SetChildActive(shuxidx.arrs[k],true)
local sxdata=randattrList[k]
local arrtype=sxdata.param_1
local arrvalue=sxdata.param_2
local name,valstr=equipsHelper.getAttr(arrtype,arrvalue)
lweight:SetChildText(shuxidx.arrs[k],name)
lweight:SetChildText(shuxidx.value[k],FMT.fmt("+{0}",valstr))
else
lweight:SetChildActive(shuxidx.arrs[k],false)
end
end
end


function UIEquipRongHeWin:refreshXMRHcost()
local equip=self.item
local cost=equipsModel.getEquipXMRHNeedCost(equip.itemid)
for k,v in ipairs(self.costMoney)do
local mwidget=v:getChildWidgetBase()
if cost[k]then
mwidget:SetChildActive(moneyidx.selfcost,true)
local costdata=cost[k]
local mtype=costdata[1]
local mval=costdata[2]
local have=moneyModel.getMoney(mtype)
mwidget:SetChildIcon(moneyidx.micon,iconHelper.getIconName(mtype),false)
if have<mval then
mwidget:SetChildText(moneyidx.mtxt,FMT.fmt('<color=#c82c2c>{0}</color>',mathHelper.formatNumber9(mval,1)))
else
mwidget:SetChildText(moneyidx.mtxt,mathHelper.formatNumber9(mval,1))
end
else
mwidget:SetChildActive(moneyidx.selfcost,false)
end
end
end



function UIEquipRongHeWin:refreshDiscipleList()
local tNum=#self.disciplelist
self.discipleList:freshGridsNum(tNum,tNum,1,true)
local idx=1
for i=1,tNum do
local item=self.discipleList:getGridObjectByindex(i-1)
local netdata=self.disciplelist[i].netData.net
local discipleguid=netdata.discipleguid
comHelper.setChildModelHeadIconBG(item,0,discipleguid)

UIDiscipleModel:setDiscipleXianMoHeadImage(item,8,netdata)

comHelper.setChildModelRawImage(item,discipleguid,1,0,eHeadCenterType.eHead)

local isSelect=mathHelper.compareInt64(self.disciple_guid,discipleguid)
if isSelect then
idx=i
self.curDisIndex=idx
end
self:changItemSelect(item,isSelect)

self:refreshItemReddot(item,i)
end
self.discipleList:jumpToLockX(idx)
end

function UIEquipRongHeWin:changItemSelect(item,isSelect)
item:SetChildActive(3,isSelect)
end

function UIEquipRongHeWin:refreshItemReddot(item,idx)
if item==nil then
item=self.discipleList:getGridObjectByindex(idx-1)
end
item:SetChildActive(6,false)
end

function UIEquipRongHeWin:refreshAllItemReddot()
for i,v in ipairs(self.disciplelist)do
self:refreshItemReddot(nil,i)
end
end

function UIEquipRongHeWin:on_select_dis(id,index,guid,attach)

if self.curDisIndex==index then return end
local oldItem=self.item
local old=self.curDisIndex
self.curDisIndex=index
if old then
local olditem=self.discipleList:getGridObjectByindex(old-1)
self:changItemSelect(olditem,false)
end
local item=self.discipleList:getGridObjectByindex(self.curDisIndex-1)
self:changItemSelect(item,true)

local netdata=self.disciplelist[self.curDisIndex].netData.net
local dis_guid=netdata.discipleguid
self.disciple_guid=dis_guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)

for equipType,idx in ipairs(equipSlotIndex)do
local equip=equipsModel.getEquipByDizi(self.disciple_guid,equipType)
if equip then
self.item=equipsHelper.getEquip(equip.itemguid)
break
end
end

local oldIsCanChongZhu=equipsHelper.isCanChongZhu(oldItem.itemguid)
local isCanChongZhu=equipsHelper.isCanChongZhu(self.item.itemguid)

local oldIsxm=equipsHelper.isEquipXM(oldItem.itemguid)
local isxm=equipsHelper.isEquipXM(self.item.itemguid)
local isxmzbfresh=oldIsxm~=isxm


if isCanChongZhu then

equipsProtocolControl.req_equip_2_91_ex(self.item.itemguid)
end

local argtable={itemguid=self.item.itemguid}
if oldIsCanChongZhu~=isCanChongZhu or isxmzbfresh then
local isOpen=oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipJingLian,argtable)
local isOpen2=oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipNingLian,argtable)
local isOpen3=oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipRonghe,argtable)
if not isOpen or not isOpen2 or not isOpen3 then
oneTabScreenController:openUI(SEC_FULL_TYPE.equipSecondary,argtable)
end
else
oneTabScreenController:changeArgs(argtable,true)
end

if _this==nil then return end
self:refreshEquipList()
self:freshEquip(argtable)
end



function UIEquipRongHeWin:refreshEquipList()
for equipType,idx in ipairs(equipSlotIndex)do
local equip=equipsHelper.getEquipByDizi(self.disciple_guid,equipType)
if equip and not equipsHelper.isEquipXM(equip.itemguid)then
equip=nil
end
self:fillItem(equip,idx)
end
end
function UIEquipRongHeWin:fillItem(equip,equipSlotIdx)
local prop={}
local equipType=_equipTypeLookup[equipSlotIdx]
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=showStage and FMT.fmt('仙·{0}{1}',stage,stageTitile)or''
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=showStage and FMT.fmt('魔·{0}{1}',stage,stageTitile)or''
end
local star=0
local reddot=false
local suitIconName=''
if itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
suitIconName=equipsHelper.getEquipSuitIcon(equip)
end
widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildText(_itemWidgetIdx.xmstagetxt,xmstageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)

widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)

if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end

local curEquipType=equipsConfig.getEquipType(self.item.itemid)
local isSelect=curEquipType==equipType
self:changEquipSelect(widget,isSelect)


local ninglianStar=equipsModel.getNingLianStar(equip)
if ninglianStar and ninglianStar>0 then
widget:SetChildActive(_itemWidgetIdx.xmicons,true)
local xmWidget=widget:GetChildWidgetBase(_itemWidgetIdx.xmicons)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_jinlian1")
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_moyan1")
end
end
end
else
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
end
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end
function UIEquipRongHeWin:changEquipSelect(widget,isSelect)
widget:SetChildActive(_itemWidgetIdx.cmpSelect,isSelect)
end
function UIEquipRongHeWin:onBaseItemClick(id,equipType,guid,attach)
local equip=equipsHelper.getEquipByDizi(self.disciple_guid,equipType)
if equip and not equipsHelper.isEquipXM(equip.itemguid)then
equip=nil
end
if not equip then
if self.showType==dicipleType.eSystem then

end
return
end
local oldEquipType=equipsConfig.getEquipType(self.item.itemid)
if oldEquipType==equipType then return end

local old=equipSlotIndex[oldEquipType]
if oldEquipType then
local oldWidget=self.equipListWidget:GetChildWidgetBase(old)
self:changEquipSelect(oldWidget,false)
end

local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIndex[equipType])
self:changEquipSelect(widget,true)

local equip=equipsModel.getEquipByDizi(self.disciple_guid,equipType)

local oldIsCanChongZhu=equipsHelper.isCanChongZhu(self.item.itemguid)
local isCanChongZhu=equipsHelper.isCanChongZhu(equip.itemguid)
local oldIsxm=equipsHelper.isEquipXM(self.item.itemguid)
local isxm=equipsHelper.isEquipXM(equip.itemguid)
local isxmzbfresh=oldIsxm~=isxm

if isCanChongZhu then

equipsProtocolControl.req_equip_2_91_ex(equip.itemguid)
end

local argtable={itemguid=equip.itemguid}
if oldIsCanChongZhu~=isCanChongZhu or isxmzbfresh then
local isOpen=oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipJingLian,argtable)
local isOpen2
local isOpen3
if not isOpen or isxmzbfresh then
oneTabScreenController:openUI(SEC_FULL_TYPE.equipSecondary,argtable)
end
else
oneTabScreenController:changeArgs(argtable,true)
end
if _this==nil then return end
self:freshEquip(argtable)
end
function UIEquipRongHeWin:onChangeItem(guid,equipType)
if tostring(guid)~=tostring(self.disciple_guid)then return end
local diziguid=self.disciple_guid
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if equipSlotIndex[equipType]~=nil then
self:fillItem(equip,equipSlotIndex[equipType])
end
equipListManager.closeTips()
end




function UIEquipRongHeWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
if self.rhitemguid and mathHelper.compareInt64(self.rhitemguid,itemguid)then

return
end
local old_rhitemguid=self.rhitemguid
self.rhitemguid=itemguid

if old_rhitemguid then
self:freshProvideSelectSingleGirid(old_rhitemguid,false)
end
if self.rhitemguid then
local rhitem=equipsHelper.getEquip(self.rhitemguid)
self.rhitem=rhitem
self:refreshXMRHRight()
self:freshProvideSelectSingleGirid(itemguid,true)
end
end

function UIEquipRongHeWin:onClickLongGridButton(itemid,index,itemguid,attach)
if itemid~=-1 then
self:onEquipClickNobtn(itemid,itemguid)
self.islong=true
end
end


function UIEquipRongHeWin:showProvideSelectGrids()


self:freshProvideSelectGrids(true)
end

function UIEquipRongHeWin:closeProvideSelectGrids()

self.showDialogue=false
self.curPageIndex=1
self.isSetZero=false
self.ScrollView2:clearSlowItems()
end

function UIEquipRongHeWin:freshBagList()

local equip=self.item
local equipType2=equipsModel.getEquipType2(equip.itemid)
local rhConditon=equipsModel.getEquipXMRHConditon(equip.itemid)or{}
local minStage=rhConditon[1]or 2
local minColor=rhConditon[2]or 2
local filter={}
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eGreaterEquals,minStage}
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,minColor}
filter[ITEM_FILTER_TYPE.eEquipType1]=equipsConfig.getEquipType(equip.itemid)

local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eEquipBag,filter)
local equipList={}
for i,v in ipairs(baglist)do
local type2=equipsModel.getEquipType2(v.itemid)
if not equipsHelper.isEquipXM(v.itemguid)and type2==equipType2 and not bagHelper.isLock(v)then
equipList[#equipList+1]=v
end
end


if#equipList>0 then
table.sort(equipList,function(a,b)
local a_jl_lv=a.itemData.jinglianlv
local b_jl_lv=b.itemData.jinglianlv
return a_jl_lv>b_jl_lv
end)
end

self.bagList=equipList
end

function UIEquipRongHeWin:freshProvideSelectGrids(freshData)

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
local showNum=curPageIndex*rNum
local showRow=math.ceil(showNum/_colomn)
if curPageIndex==1 then
self.ScrollView2:clearSlowItems()
end
self.ScrollView2:freshSlowGrids(showNum,showRow,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIEquipRongHeWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local isTemp=itemInfo==nil
if not isTemp then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(itemInfo)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local num=0
local jinglianlv=itemInfo.itemData and itemInfo.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local countStr=jinglianlv>0 and jinglianStr or num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
local has=num>0



local showStage=itemConfig.stage~=nil
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)
local isLock=bagHelper.isLock(itemInfo)
local suitIconName=''
if itemsConfig.isEquip(itemid)then
suitIconName=equipsHelper.getEquipSuitIcon(itemInfo)
end
widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)
widget:SetChildQulaity(2,color)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,isLock)
widget:SetChildActive(10,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)


widget:SetChildActive(12,false)
widget:SetChildIcon(13,suitIconName,false)
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


widget:SetChildActive(12,false)
widget:SetChildIcon(13,'',false)
end
end

function UIEquipRongHeWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView2:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(12,flag)
if not flag then

self.useGoodTime=nil
end
end
end
end

function UIEquipRongHeWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i,v
end
end
end


function UIEquipRongHeWin:resetSelectItems()
self:resetData()

self:freshProvideSelectGrids(true)
end

function UIEquipRongHeWin:resetData()
self.selectItemsLookup={}
self.selectList={}
self.addExp=0
self.leftExp=0
self.overExp=0
self.addItemExp=0
self.addLastItemExp=0
self.addLv=0
self.randNum=0
self.curPageIndex=1
self.isSetZero=false
end

function UIEquipRongHeWin:longPressAction(idx,isAdd,itemid,itemguid)

if isAdd and not self.islong then
return
end

self:onEquipClickNobtn(itemid,itemguid)
end

function UIEquipRongHeWin:finishlongPressAction(idx,isAdd)
if isAdd then
self.islong=false
end
self.useGoodTime=nil
end
function UIEquipRongHeWin:StopItemLongPress(idx,index)
local widget=self.ScrollView2:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildLongPressStop(index)
end
end





