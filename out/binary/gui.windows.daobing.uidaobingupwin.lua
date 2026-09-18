







def_class("UIDaoBingUpWin",UIWindowBase)









function UIDaoBingUpWin:bindComponents()

self.dzbg=UIImage.get(self,0)
self.dzhead=UIObject.get(self,1)
self.dzname=UIText.get(self,2)
self.starItem=UIBaseItem.get(self,3)
self.titleName=UIImage.get(self,4)
self.starAttr=UIObject.get(self,5)
self.starjl=UIObject.get(self,6)
self.star=UIObject.get(self,7)
self.jlTile=UIText.get(self,8)
self.btnJinglian=UIButton.get(self,9)
self.btnTuPo=UIButton.get(self,10)
self.jlItemCreater=UIObject.get(self,11)
self.jlCostTitle=UIText.get(self,12)
self.jldesc=UIText.get(self,13)
self.jlTab=UIObject.get(self,14)
self.starTab=UIObject.get(self,15)
self.jlAttr4=UIObject.get(self,16)
self.jlAttr2=UIObject.get(self,17)
self.jlAttr1=UIObject.get(self,18)
self.jlAttr3=UIObject.get(self,19)
self.model=UIObject.get(self,20)
self.dizi=UIButton.get(self,21)
self.modelClick=UIButton.get(self,22)
self.chongzhi=UIButton.get(self,23)
self.starItemCreater=UIObject.get(self,24)
self.starTitle=UIText.get(self,25)
self.stardesc=UIText.get(self,26)
self.btnStar=UIButton.get(self,27)
self.starCostTitle=UIText.get(self,28)
self.skill_2=UIObject.get(self,29)
self.skill_3=UIObject.get(self,30)
self.skill_1=UIObject.get(self,31)
self.tupo=UIText.get(self,32)
self.starSkill2=UIObject.get(self,33)
self.starSkill3=UIObject.get(self,34)
self.starSkill1=UIObject.get(self,35)
self.starPanel=UIObject.get(self,36)
self.jinglianPanel=UIObject.get(self,37)
self.ScrollView=UIScrollViewSlow.get(self,38)
self.shentongicon=UIButton.get(self,39)
self.Content=UIObject.get(self,40)
self.liandonBtn=UIButton.get(self,41)
self.chooseBox=UIToggleButton.get(self,42)

self.btnJinglian:setButtonClick(function()self:onBtnJinglian()end)

self.btnTuPo:setButtonClick(function()self:onBtnTuPo()end)

self.dizi:setButtonClick(function()self:onDizi()end)

self.modelClick:setButtonClick(function()self:onModelClick()end)

self.chongzhi:setButtonClick(function()self:onChongzhi()end)

self.btnStar:setButtonClick(function()self:onBtnStar()end)

self.shentongicon:setButtonClick(function()self:onShentongicon()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)
self.skill={
self.skill_1,
self.skill_2,
self.skill_3,
}



end


function UIDaoBingUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dzbg);self.dzbg=nil;
_UIObject_release(self.dzhead);self.dzhead=nil;
_UIObject_release(self.dzname);self.dzname=nil;
_UIObject_release(self.starItem);self.starItem=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.starAttr);self.starAttr=nil;
_UIObject_release(self.starjl);self.starjl=nil;
_UIObject_release(self.star);self.star=nil;
_UIObject_release(self.jlTile);self.jlTile=nil;
_UIObject_release(self.btnJinglian);self.btnJinglian=nil;
_UIObject_release(self.btnTuPo);self.btnTuPo=nil;
_UIObject_release(self.jlItemCreater);self.jlItemCreater=nil;
_UIObject_release(self.jlCostTitle);self.jlCostTitle=nil;
_UIObject_release(self.jldesc);self.jldesc=nil;
_UIObject_release(self.jlTab);self.jlTab=nil;
_UIObject_release(self.starTab);self.starTab=nil;
_UIObject_release(self.jlAttr4);self.jlAttr4=nil;
_UIObject_release(self.jlAttr2);self.jlAttr2=nil;
_UIObject_release(self.jlAttr1);self.jlAttr1=nil;
_UIObject_release(self.jlAttr3);self.jlAttr3=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.dizi);self.dizi=nil;
_UIObject_release(self.modelClick);self.modelClick=nil;
_UIObject_release(self.chongzhi);self.chongzhi=nil;
_UIObject_release(self.starItemCreater);self.starItemCreater=nil;
_UIObject_release(self.starTitle);self.starTitle=nil;
_UIObject_release(self.stardesc);self.stardesc=nil;
_UIObject_release(self.btnStar);self.btnStar=nil;
_UIObject_release(self.starCostTitle);self.starCostTitle=nil;
_UIObject_release(self.skill_2);self.skill_2=nil;
_UIObject_release(self.skill_3);self.skill_3=nil;
_UIObject_release(self.skill_1);self.skill_1=nil;
_UIObject_release(self.tupo);self.tupo=nil;
_UIObject_release(self.starSkill2);self.starSkill2=nil;
_UIObject_release(self.starSkill3);self.starSkill3=nil;
_UIObject_release(self.starSkill1);self.starSkill1=nil;
_UIObject_release(self.starPanel);self.starPanel=nil;
_UIObject_release(self.jinglianPanel);self.jinglianPanel=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.shentongicon);self.shentongicon=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.chooseBox);self.chooseBox=nil;
self.skill=nil;
end

















local _colomn=1
local _menu_slot_name='button_dytab'
local _sortKey='daobingsortkey'
local _orderKey='daobingorderkey'

function UIDaoBingUpWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)
self.ScrollView:bindSlowWidget(function(...)
self:bindGrid(...)
end)

self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemsChanged(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
self.selectBentiList={}
self.sortType=userActorSetting.get(_sortKey,1)
self.sortOrder=userActorSetting.get(_orderKey,eSortOrder.eDown)
self.needFocus=true
end

function UIDaoBingUpWin:__delete()
self:unbindComponents()
UIManager:hideWindow('UITopMoneyWin2')
end

function UIDaoBingUpWin:onShow(argtable,afterOnloaded)
local tabType=argtable and argtable.tabType or SEC_FULL_TAB_TYPE.daobingjinglian
local itemguid=argtable and argtable.itemguid or self.bagList[1]
self.tabType=tabType
self.itemguid=itemguid
self:freshInfo()
end

function UIDaoBingUpWin:onHide()

end





function UIDaoBingUpWin:onBtnTuPo()
local itemguid=self.itemguid
local ret,args=daobingHelper.isCanJinglian(itemguid)
if not ret then
if args==nil then
UIManager.error('已达当前精炼等级上限')
return
end
local itemid=args[1]
local need=args[2]
gainControl:showGainWin(itemid,need,{needCount=need})
UIManager.error(FMT.fmt('{0}不足',itemsModel.getName(itemid)))
return
end
daobingController.reqJinglian(itemguid,1)
end



function UIDaoBingUpWin:onBtnJinglian()
local itemguid=self.itemguid
local isFast=self.chooseBox:getToggle()
local ret,args=daobingHelper.isCanJinglian(itemguid,isFast)
if not ret then
if args==nil then
UIManager.error('已达当前精炼等级上限')
return
end
local itemid=args[1]
local need=args[2]
gainControl:showGainWin(itemid,nil,{needCount=need})
UIManager.error(FMT.fmt('{0}不足',itemsModel.getName(itemid)))
return
end
local jllv=daobingModel:getJilianLv(itemguid)
local nexttplv=daobingHelper.getNextTuPoLv(itemguid)
local isTPlv=nexttplv==(jllv+1)
local nextJllv=(isFast and not isTPlv)and nexttplv-1 or jllv+1
daobingController.reqJinglian(itemguid,nextJllv-jllv)
end



function UIDaoBingUpWin:onBtnStar()
local itemguid=self.itemguid
local ret,args=daobingHelper.isCanStar(itemguid,false)
if not ret then
if args==nil then
UIManager.error('已达星级上限')
return
end
local itemid=args[1]
local need=args[2]
gainControl:showGainWin(itemid)
UIManager.error(FMT.fmt('{0}不足',itemsModel.getName(itemid)))
return
end
local list=self.selectBentiList
daobingController.reqStar(itemguid,list)
end

function UIDaoBingUpWin:onModelClick()
tipsManager.showTips({itemguid=self.itemguid})
end

function UIDaoBingUpWin:onShentongicon()
local equip=daobingHelper.getEquip(self.itemguid)
local itemid=equip.itemid
local skillids=daobingHelper.getWeaponShentong(itemid)
local skillid=skillids[1]
self:showSkillTips(skillid,self.itemguid)
end

function UIDaoBingUpWin:onLiandonBtn()
local itemguid=self.itemguid
local equip=daobingHelper.getEquip(itemguid)
local itemid=equip.itemid
local linkageId=liandonModel:getLianDonLinkageIdByItemId(itemid)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end

function UIDaoBingUpWin:onClickGrid(id,index,guid,attach)
if tostring(self.itemguid)==tostring(guid)then return end
local lastguid=self.itemguid
self.selectBentiList={}

if not self:onSelectItem(guid)then return end
if lastguid then
self.ScrollView:freshSlowItemByGUID(lastguid)
end
self.ScrollView:freshSlowItemByGUID(guid)
self:freshBtnReddot()
end


function UIDaoBingUpWin:onSelectTab(tabType)
if tabType==self.tabType then return end
self.chooseBox:setToggle(false)
self.tabType=tabType
local money=tabScreenConfig.getTabMoneyByConfig(self.tabType)
UIManager:showWindow('UITopMoneyWin2',money)
self:freshTabBtns()
self:freshRightPanel()
self:freshBtnReddot()
end


function UIDaoBingUpWin:onSelectItem(itemguid)
if tostring(itemguid)==tostring(self.itemguid)then return end
self.chooseBox:setToggle(false)
self.itemguid=itemguid
self:freshMidPanel()
self:freshRightPanel()
return true
end

function UIDaoBingUpWin:onSelectBenti()
local equip=equipsHelper.getEquip(self.itemguid)
local itemid=equip.itemid


local filter={}
filter[ITEM_FILTER_TYPE.eItemid]=itemid
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,{self.itemguid}}
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eDaoBingBag,filter)








local common_cfg=daobingConfig.getCommonConfig().common
local common_cfg_arry=common_cfg or{}







local temp={}
local color=itemsConfig.getConfig(itemid).color

if common_cfg_arry and common_cfg_arry[color]then
temp[#temp+1]=common_cfg_arry[color]

if#temp>0 then

local baglistarry={}
for k,v in ipairs(temp)do
local filtertemp={}
filtertemp[ITEM_FILTER_TYPE.eItemid]=v
local baglisttemp=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filtertemp)
if#baglisttemp>0 and baglisttemp[1].itemcount and baglisttemp[1].itemcount>0 then
for i=1,baglisttemp[1].itemcount do
baglistarry[#baglistarry+1]=baglisttemp[1]
end
end
end


for k,v in ipairs(baglistarry)do
baglist[#baglist+1]=v
end
end
end


if#baglist==0 then
gainControl:showGainWin(itemid)
local itemname=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}数量不足',itemname))
return
end


local args={}
args.titleName="道兵选择"
args.pos=1
args.extraWin='UIDaoBingSelectWin'
local extraParams={}
local selectList=self.selectBentiList
local starlv=daobingModel:getStarLv(self.itemguid)
local maxnum=daobingConfig.getCostBenTiNum(starlv)

extraParams.selectList=selectList
extraParams.maxnum=maxnum
extraParams.list=baglist
extraParams.call=function(list)
if self and not self.isClose then
self.selectBentiList=list

self:freshStarItem()
end
end
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIDaoBingUpWin:onDizi()
local itemguid=self.itemguid
local dzguid=daobingModel:getDiziguidByItemguid(itemguid)
UIFullCommonControl:jumpDiscipleMain(dzguid,
FULL_TAB_TYPE.eDiscipleEquip)
end

function UIDaoBingUpWin:freshInfo()
local money=tabScreenConfig.getTabMoneyByConfig(self.tabType)
UIManager:showWindow('UITopMoneyWin2',money)
self:freshBtns()
self:freshLeftPanel()
self:freshMidPanel()
self:freshRightPanel()
end

function UIDaoBingUpWin:freshBtns()
local tabType=SEC_FULL_TAB_TYPE.daobingjinglian
local vis=fullScreenModel.isTabActive(tabType)
self.jlTab:setActive(vis)
if vis then
local widget1=self.jlTab:getChildWidgetBase()
local func=function()
widget1:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,self.tabType==SEC_FULL_TAB_TYPE.daobingjinglian and'button_dytab_2'or'button_dytab_1')
end
local isFast=self.chooseBox:getToggle()
local ret=daobingHelper.isCanJinglian(self.itemguid,isFast)
widget1:SetChildUIModelShowTarget(0,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
widget1:SetChildText(1,'精炼')
widget1:SetChildActive(2,ret)
widget1:SetChildButtonClick(3,function()
self:onSelectTab(SEC_FULL_TAB_TYPE.daobingjinglian)
end,true)
end

local tabType=SEC_FULL_TAB_TYPE.daobingstar
local vis=fullScreenModel.isTabActive(tabType)
self.starTab:setActive(vis)
if vis then
local widget2=self.starTab:getChildWidgetBase()
local func=function()
widget2:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,self.tabType==SEC_FULL_TAB_TYPE.daobingstar and'button_dytab_2'or'button_dytab_1')
end
local ret=daobingHelper.isCanStar(self.itemguid,true)
widget2:SetChildUIModelShowTarget(0,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
widget2:SetChildText(1,'升星')
widget2:SetChildActive(2,ret)
widget2:SetChildButtonClick(3,function()
self:onSelectTab(SEC_FULL_TAB_TYPE.daobingstar)
end,true)
end
end

function UIDaoBingUpWin:freshTabBtns()
local isSelect=self.tabType==SEC_FULL_TAB_TYPE.daobingjinglian
local widget=self.jlTab:getChildWidgetBase()
if isSelect then
widget:SetChildModelAnimationState(0,eAnimationID.common_window_dianji)
end
widget:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,isSelect and'button_dytab_2'or'button_dytab_1')

local isSelect=self.tabType==SEC_FULL_TAB_TYPE.daobingstar
local widget=self.starTab:getChildWidgetBase()
if isSelect then
widget:SetChildModelAnimationState(0,eAnimationID.common_window_dianji)
end
widget:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,isSelect and'button_dytab_2'or'button_dytab_1')
end

function UIDaoBingUpWin:freshBtnReddot()
local widget=self.jlTab:getChildWidgetBase()
local isFast=self.chooseBox:getToggle()
local ret=daobingHelper.isCanJinglian(self.itemguid,isFast)
widget:SetChildActive(2,ret)

local widget=self.starTab:getChildWidgetBase()
local ret=daobingHelper.isCanStar(self.itemguid,true)
widget:SetChildActive(2,ret)
end

function UIDaoBingUpWin:freshLeftPanel()
local filter={}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eDaoBing
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eDaoBingBag,filter,false)
local equips=daobingModel:getAllEquip()
bagList=table.concatTableX(bagList,equips)
bagList=self:sortDaoBing(bagList)

self.bagList=bagList
local rNum=#bagList
local row=math.ceil(rNum/_colomn)
self.ScrollView:clearSlowItems()
self.ScrollView:freshSlowGrids(rNum,row,_colomn,true)
end

function UIDaoBingUpWin:sortDaoBing(list)
return daobingHelper.sortDaoBing(list,self.sortType,self.sortOrder)
end

function UIDaoBingUpWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemCfgs=itemsConfig.getConfig(itemid)
local color=itemCfgs.color
local iconName=itemsModel.getIconName(itemInfo)
local isSelect=tostring(self.itemguid)==tostring(itemguid)
local jinglianlv=daobingModel:getJilianLv(itemguid)
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local isEquiped=daobingModel:isEquipedOnAnyDizi(itemguid)
local starlv=daobingModel:getStarLv(itemguid)
local isLD=liandonModel:getIsLianDonItem(itemid)
widget:SetChildQulaity(0,color)
widget:SetChildIcon(1,iconName,false)
widget:SetChildActive(2,jinglianStr~='')
widget:SetChildText(3,jinglianStr)
widget:SetChildActive(4,isSelect)
widget:SetChildActive(5,isEquiped)
widget:SetChildStarNumber(6,starlv)
widget:SetChildActive(7,isLD)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
if self.needFocus and isSelect then
self.needFocus=nil
self.ScrollView:jumpToSlowItem(index)
end
end

function UIDaoBingUpWin:freshMidPanel()
local itemguid=self.itemguid
local dzguid=daobingModel:getDiziguidByItemguid(itemguid)
local equip=daobingHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemsCfg=itemsConfig.getConfig(itemid)
local modelParams=itemsCfg.model
local isMaxStar=daobingHelper.isMaxStar(equip)
local isLD=liandonModel:getIsLianDonItem(itemid)
self.liandonBtn:setActive(isLD)

self.titleName:setSprite(globalABLookup.daobingsprite,iconHelper.getDaobingNameIcon(itemsCfg.nameicon))


local effectInfo=isMaxStar and modelParams[2]or modelParams[1]
self.model:setChildShowEffect(effectInfo[1],true)

if dzguid then
self.dizi:setActive(true)
comHelper.setChildModelHeadIconBG(self.widget,self.dzbg:getID(),dzguid)
comHelper.setChildModelRawImage(self.widget,dzguid,self.dzhead:getID(),0,eHeadCenterType.eHead)
self.dzname:setText(UIDiscipleModel:getDiscipleName(dzguid))
else
self.dizi:setActive(false)
end

local skills=daobingHelper.getWeaponShentong(itemid)
local starlv=daobingModel:getStarLv(itemguid)
local skilllv=daobingConfig.getWeaponShentongLvByStar(starlv)
local len=#self.skill
for i=1,len do
local item=self.skill[i]
local skillid=skills[i]
item:setActive(skillid~=nil)
if skillid then
local widget=item:getWidgetBase()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillid)
widget:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
widget:SetChildText(1,cfgHelper.get2(cfg_skillconfig_get,skillid,'name'))
widget:SetChildButtonClick(2,function()
if self and not self.isClose then
self:showSkillTips(skillid,self.itemguid)
end
end,true)
end
end





end

function UIDaoBingUpWin:showSkillTips(skillid,itemguid)
local starlv=daobingModel:getStarLv(itemguid)
local skilllv=daobingConfig.getWeaponShentongLvByStar(starlv)
local itemguid=self.itemguid
local equip=daobingHelper.getEquip(itemguid)
local itemid=equip.itemid
UIManager:showWindow('UIDaoBingSkillWin',{itemid=itemid,skillid=skillid,skilllv=skilllv})
end

function UIDaoBingUpWin:freshRightPanel()
local visJinglian=self.tabType==SEC_FULL_TAB_TYPE.daobingjinglian
local visStar=self.tabType==SEC_FULL_TAB_TYPE.daobingstar
self.jinglianPanel:setActive(visJinglian)
self.starPanel:setActive(visStar)
if visJinglian then
self:freshJinglianPanel()
end
if visStar then
self:freshStarPanel()
end

local equip=equipsHelper.getEquip(self.itemguid)
if not equip then
self.chongzhi:setActive(false)
return
end
local itemData=equip.itemData
self.chongzhi:setActive(itemData.star>0 or itemData.jinglianlv>0)
end

function UIDaoBingUpWin:freshJinglianPanel()
local isFast=self.chooseBox:getToggle()
local itemguid=self.itemguid
local equip=daobingHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local starlv=daobingModel:getStarLv(itemguid)
local curMaxlv=daobingConfig.getCurrentJinglianMaxLv(itemid,starlv)
local maxlv=daobingConfig.getJinglianMaxLv(itemid)
local jllv=daobingModel:getJilianLv(itemguid)
local nexttplv=daobingHelper.getNextTuPoLv(itemguid)
local isCurMax=jllv>=curMaxlv
local isMax=maxlv>=maxlv
local maxStarlv=daobingConfig.getStarMaxLv(itemid)
local maxStar=starlv>=maxStarlv
local isTPlv=nexttplv==(jllv+1)

local nextJllv=(isFast and nexttplv and not isTPlv)and nexttplv-1 or jllv+1



local widget=self.jlAttr1:getChildWidgetBase()
widget:SetChildText(0,'精炼等级')
widget:SetChildText(1,FMT.fmt('{0}/{1}',jllv,curMaxlv))
widget:SetChildActive(2,not isCurMax)
if not isCurMax then
widget:SetChildText(3,FMT.fmt('{0}/{1}',nextJllv,curMaxlv))
end

local baseAttrList=daobingHelper.getBaseAttrsList(itemCfg)
local baseAttrLookup=daobingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv,jllv)
local nextAttrLookup=not isCurMax and daobingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv,nextJllv)or baseAttrLookup
local jlSlotList={self.jlAttr2,self.jlAttr3,self.jlAttr4}
for i,v in ipairs(jlSlotList)do
local attr=baseAttrList[i]
local has=attr~=nil
v:setActive(has)
if has then
local widget=v:getChildWidgetBase()
local attrId=attr[1]
local attVal=baseAttrLookup[attrId]
local name,valStr=equipsHelper.getAttr(attrId,attVal,TO_INT_TYPE.eDown)
widget:SetChildText(0,name)
widget:SetChildText(1,valStr)
widget:SetChildActive(2,not isCurMax)
if not isCurMax then
local nextVal=nextAttrLookup[attrId]
local name,valStr=equipsHelper.getAttr(attrId,nextVal,TO_INT_TYPE.eDown)
widget:SetChildText(3,valStr)
end
end
end

local jinglianCfg=daobingHelper.getJlAttrs(itemCfg)
local jinglianLvCfg=jinglianCfg[jllv]
local precent=jinglianLvCfg[3]or 0
local desc=FMT.fmt('基础属性：{0}',FMT.cfmt(FONT_COLOR.eNomalBlackColor,'{0}%',precent))
if nexttplv then
local tpjlTable=jinglianCfg[nexttplv]
local tpprecent=tpjlTable[3]
desc=FMT.fmt('{0}\n{1}',desc,
FMT.cfmt2('#549327','(精炼{0}级，基础属性提升{1}%)',nexttplv,tpprecent))
end
self.tupo:setText(desc)
local costs={}
for lv=jllv,nextJllv-1 do
local cfg=jinglianCfg[lv]
for i,v in ipairs(cfg[1]or{})do
local itemid=v[1]
local count=v[2]
costs[itemid]=costs[itemid]or 0
costs[itemid]=costs[itemid]+count
end
end
local costList=jinglianLvCfg[1]or{}
local len=maxStar and isCurMax and 0 or#costList
self.jlItemCreater:setChildLayoutGroupCreateItems(len)
local grids=self.jlItemCreater:getChildLayoutGroupGridList()
if len then
for i=1,len do
local cost=costList[i]
local itemid=cost[1]
local count=isCurMax and cost[2]or(costs[itemid]or 0)
local enough=itemsModel.getCount(itemid)>=count
local countStr=UIDanYaoModel:getItemCountStr(itemid,count)
local item=grids[i-1]
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
if enough then
itemsComponentHelper.onItemClick(...)
else
gainControl:showGainWin(itemid)
end
end)
item:SetChildPropData(0,prop)
end
end

local enoughStar,needStarLv=daobingHelper.isCanJinglianLv(itemguid)
if isCurMax then
local desc1=not maxStar and FMT.fmt('{0}星可解锁更高精炼上限',starlv+1)or''
local desc2=maxStar and'精炼已满级'or''
self.jldesc:setText(desc1)
self.jlTile:setText(desc2)
self.btnTuPo:setActive(false)
self.btnJinglian:setActive(false)
self.chooseBox:setActive(false)
elseif isTPlv then
self.jldesc:setText('')
self.jlTile:setText('')
self.btnTuPo:setActive(true)
self.btnJinglian:setActive(false)
self.chooseBox:setActive(false)
else
self.jldesc:setText('')
self.jlTile:setText('')
self.btnTuPo:setActive(false)
self.btnJinglian:setActive(true)
self.chooseBox:setActive(true)
end
end


function UIDaoBingUpWin:freshStarPanel()
local itemguid=self.itemguid
local equip=daobingHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local maxlv=daobingConfig.getStarMaxLv(itemid)
local starlv=daobingModel:getStarLv(itemguid)
local isMax=maxlv==starlv
local starCfg=daobingHelper.getStarAttrs(itemCfg)
local starlvCfg=starCfg[starlv]
local precent=starlvCfg[3]or 0
local nextprecent=isMax and precent or starCfg[starlv+1][3]or 0
local skilllv=daobingConfig.getWeaponShentongLvByStar(starlv)
local nextSkilllv=isMax and skilllv or
daobingConfig.getWeaponShentongLvByStar(starlv+1)
local nextUpSkill=nextSkilllv>skilllv
local skillids=daobingHelper.getWeaponShentong(itemid)
local skillid=skillids[1]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillid)

local widget=self.star:getChildWidgetBase()
widget:SetChildText(0,'道兵星级')
widget:SetChildStarNumber(1,starlv)
widget:SetChildGroundStarNum(1,starlv==0 and 1 or 0)
widget:SetChildActive(2,not isMax)
if not isMax then
widget:SetChildStarNumber(3,starlv+1)
end

local jllimitlv=daobingConfig.getCurrentJinglianMaxLv(itemid,starlv)
local maxjllv=daobingConfig.getJinglianMaxLv(itemid)
local widget=self.starjl:getChildWidgetBase()
widget:SetChildText(0,'精炼上限')
widget:SetChildText(1,jllimitlv)
widget:SetChildActive(2,false)
if not isMax then
local nextjllimitlv=daobingConfig.getCurrentJinglianMaxLv(itemid,starlv+1)
if nextjllimitlv>jllimitlv then
widget:SetChildActive(2,true)
widget:SetChildText(3,nextjllimitlv)
end
end

local widget=self.starAttr:getChildWidgetBase()
widget:SetChildText(0,'基础属性')
widget:SetChildText(1,FMT.fmt('{0}%',precent))
widget:SetChildActive(2,nextprecent>precent)
if nextprecent>precent then
widget:SetChildText(3,FMT.fmt('{0}%',nextprecent))
end


self.shentongicon:setChildIcon(iconHelper.getSkillIcon(skillCfg.icon),false)

local widget=self.starSkill1:getChildWidgetBase()
widget:SetChildText(0,skillCfg.name)
widget:SetChildText(1,FMT.fmt('{0}级',skilllv))
widget:SetChildActive(2,nextUpSkill)
if nextUpSkill then
widget:SetChildText(3,FMT.fmt('{0}级',nextSkilllv))
end

local slotlist={self.starSkill2,self.starSkill3}
local upgradeDesc=skillCfg.upgradeDesc or''
local descParams=skillCfg.descParams
local descArray=string.split(upgradeDesc,',')
local lvdescParams=descParams[skilllv]
local nextlvdescParams=descParams[nextSkilllv]
local temp={}
for i,v in ipairs(descArray)do
if v and v~=''then
temp[#temp+1]=v
end
end

for i,v in ipairs(slotlist)do
local descfmt=temp[i]
local vis=descfmt~=nil
v:setActive(vis)
if vis then
descfmt=string.replace(descfmt,string.format('{%d}',i-1),'{0}')

descfmt=string.gsub(descfmt,'<color=#[%da-zA-z]+>','')
descfmt=string.gsub(descfmt,'</color>','')

local array=string.split(descfmt,'}')
local extra=array[2]or''
local replace=string.format('{0}%s',extra)

local name=string.replace(descfmt,replace,'')
local widget=v:getChildWidgetBase()
widget:SetChildText(0,name)
widget:SetChildText(1,FMT.fmt('{0}{1}',lvdescParams[i],extra))
widget:SetChildActive(2,false)
if nextUpSkill then
if nextlvdescParams==nil then



end
local up=nextlvdescParams[i]-lvdescParams[i]
widget:SetChildActive(2,up>0)
FMT.fmt('{0}{1}',nextlvdescParams[i],extra)
widget:SetChildText(3,FMT.fmt('{0}{1}',nextlvdescParams[i],extra))
end
end
end

self:freshStarItem()

local costList=starlvCfg[1]or{}
local len=isMax and 0 or#costList
self.starItemCreater:setChildLayoutGroupCreateItems(len)
local grids=self.starItemCreater:getChildLayoutGroupGridList()
if len then
for i=1,len do
local cost=costList[i]
local itemid=cost[1]
local count=cost[2]
local countStr=UIDanYaoModel:getItemCountStr(itemid,count)
local item=grids[i-1]
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
end
end

if isMax then

self.starTitle:setText('升星已满级')
self.btnStar:setActive(false)
else

self.starTitle:setText('')
self.btnStar:setActive(true)
local enough=self.enoughStarItem or false
self.winlua:SetChildButtonEnable(self.btnStar:getID(),enough,not enough)
end
end


function UIDaoBingUpWin:freshStarItem()
local itemguid=self.itemguid
local equip=daobingHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local starlv=daobingModel:getStarLv(itemguid)
local maxlv=daobingConfig.getStarMaxLv(itemid)
local isMax=maxlv==starlv
local bentinum=daobingConfig.getCostBenTiNum(starlv)
self.starItem:setActive(bentinum>0 and not isMax)
self.enoughStarItem=true
if bentinum>0 then
local num=#self.selectBentiList
local widget=self.starItem:getChildWidgetBase()
local put=num>0
self.enoughStarItem=num>=bentinum
self.starItem:setBaseItemClickEvent(function()
self:onSelectBenti()
end)
local countStr=self.enoughStarItem and FMT.fmt('{0}/{1}',num,bentinum)or
FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',num,bentinum)
widget:SetChildActive(2,true)
widget:SetChildText(3,countStr)
widget:SetChildActive(4,put)
widget:SetChildActive(6,not put)
widget:SetChildActive(5,not put)

if put then
widget:SetChildQulaity(0,itemCfg.color)
widget:SetChildScale(1,Vector3.one)
widget:SetChildIcon(1,iconHelper.getIconName(itemid),false)
else
widget:SetChildActive(0,false)
widget:SetChildScale(1,Vector3.zero)
end
end

if isMax then

self.starTitle:setText('升星已满级')
self.btnStar:setActive(false)
else

self.starTitle:setText('')
self.btnStar:setActive(true)
local enough=self.enoughStarItem or false
self.winlua:SetChildButtonEnable(self.btnStar:getID(),enough,not enough)
end
end

function UIDaoBingUpWin:onJinglianRet(itemguid,oldlv,newlv)
if self.tabType~=SEC_FULL_TAB_TYPE.daobingjinglian then return end
if tostring(itemguid)~=tostring(self.itemguid)then return end
self:freshRightPanel()
self:freshBtnReddot()
self:freshLeftPanel()
end

function UIDaoBingUpWin:onStarRet(itemguid,oldlv,newlv)
if self.tabType~=SEC_FULL_TAB_TYPE.daobingstar then return end
if tostring(itemguid)~=tostring(self.itemguid)then return end
self.selectBentiList={}
self:freshRightPanel()
self:freshBtnReddot()
self.needFocus=true
self:freshLeftPanel()
if daobingHelper.isMaxStarByGUID(itemguid)then
self:freshMidPanel()
end
end

function UIDaoBingUpWin:onMoneyChanged(moneytype)
if moneytype==eMoneyType.mtXuanTie then

self:freshBtnReddot()
self:freshRightPanel()
end
end

function UIDaoBingUpWin:onItemsChanged(argsTable)

self:freshBtnReddot()
self:freshRightPanel()
end


function UIDaoBingUpWin:onChongzhi()
local dzguid=daobingModel:getDiziguidByItemguid(self.itemguid)

UIManager:showWindow("UIDaoBingChongZhiWin",{self.itemguid,dzguid})
end

function UIDaoBingUpWin:onFastUpChoose()

AudioManager.playBtnClick()

self:freshBtnReddot()
self:freshRightPanel()
end
