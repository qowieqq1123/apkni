







def_class("UIFairTipsWin",UIWindowBase)









function UIFairTipsWin:bindComponents()

self.scrollview2=UIObject.get(self,0)
self.txtSpeciality=UIText.get(self,1)
self.dizi_lv=UIText.get(self,2)
self.huaxian=UIObject.get(self,3)
self.discountLine=UIObject.get(self,4)
self.discountNum=UIText.get(self,5)
self.oldprice=UIText.get(self,6)
self.guishiModel=UIObject.get(self,7)
self.diziPanel=UIObject.get(self,8)
self.nodiscount=UIText.get(self,9)
self.desc1=UIText.get(self,10)
self.addButton=UIButton.get(self,11)
self.dizi_name=UIText.get(self,12)
self.Icon=UIImage.get(self,13)
self.price=UIText.get(self,14)
self.discount=UIText.get(self,15)
self.item=UIBaseItem.get(self,16)
self.name=UIText.get(self,17)
self.diziIcon=UIObject.get(self,18)
self.fairPanel=UIObject.get(self,19)
self.title=UIText.get(self,20)
self.guishiPanel=UIObject.get(self,21)
self.title3=UIText.get(self,22)
self.title2=UIText.get(self,23)
self.title1=UIText.get(self,24)
self.desc_2=UIText.get(self,25)
self.desc_1=UIText.get(self,26)
self.buyBtn=UIButton.get(self,27)
self.buyBtnModel=UIObject.get(self,28)

self.addButton:setButtonClick(function()self:onAddButton()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)
self.desc={
self.desc_1,
self.desc_2,
}
self.dizi={
["lv"]=self.dizi_lv,
["name"]=self.dizi_name,
}



end


function UIFairTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview2);self.scrollview2=nil;
_UIObject_release(self.txtSpeciality);self.txtSpeciality=nil;
_UIObject_release(self.dizi_lv);self.dizi_lv=nil;
_UIObject_release(self.huaxian);self.huaxian=nil;
_UIObject_release(self.discountLine);self.discountLine=nil;
_UIObject_release(self.discountNum);self.discountNum=nil;
_UIObject_release(self.oldprice);self.oldprice=nil;
_UIObject_release(self.guishiModel);self.guishiModel=nil;
_UIObject_release(self.diziPanel);self.diziPanel=nil;
_UIObject_release(self.nodiscount);self.nodiscount=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.addButton);self.addButton=nil;
_UIObject_release(self.dizi_name);self.dizi_name=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.price);self.price=nil;
_UIObject_release(self.discount);self.discount=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.diziIcon);self.diziIcon=nil;
_UIObject_release(self.fairPanel);self.fairPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.guishiPanel);self.guishiPanel=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.desc_2);self.desc_2=nil;
_UIObject_release(self.desc_1);self.desc_1=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.buyBtnModel);self.buyBtnModel=nil;
self.desc=nil;
self.dizi=nil;
end
















local _this=nil
local _iscurr
local canbuy

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemCount=2,
cmpItemTxtStageBg=3,
cmpItemTxtStage=4,
}





function UIFairTipsWin:onLoaded(...)
self:bindComponents()
_this=self
_iscurr=true
canbuy=false
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UIFairTipsWin:__delete()
self:stopBuyBtnTimer()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end




function UIFairTipsWin:onShow(argtable,afterOnloaded)
if not argtable then
return
end
self:updateData(argtable)
self:refreshLeftPanel()
if self.fairType==eFairType.eMysteryMarket or self.fairType==eFairType.eMysteryEventMarket then
self:refreshOtherRightPanel()
else
self:refreshRightPanel()
end
self:refreshBuyBtn()
end


function UIFairTipsWin:onHide()

end



function UIFairTipsWin:updateData(argtable)
self.buyClickfun=argtable.func1
self.btClickfun=argtable.func2
self.currindex=argtable.index
self.fairType=argtable.fairtype
self.buildData=argtable.bdData
self.sysData=fairModel:get_sys_data()
end




function UIFairTipsWin:refreshLeftPanel()

self.fairPanel:setActive(self.fairType==eFairType.eBooth)
self.guishiPanel:setActive(self.fairType==eFairType.eBlackMarket or self.fairType==eFairType.eBlackSpeGoods or self.fairType==eFairType.eMysteryMarket)
if self.fairType==eFairType.eBooth then
local config=cfgHelper.get1(cfg_monijybuildconfig_get,self.buildData.build_id)
self.bdType=config.build_type
local dzId=self.buildData.dizi_id
self.diziPanel:setActive(tostring(dzId)~='0')
self.addButton:setActive(tostring(dzId)=='0')
self.desc1:setActive(tostring(dzId)=='0')
self.discount:setActive(tostring(dzId)~='0')
if tostring(dzId)~='0'then
self.dizi_name:setText(UIDiscipleModel:getDiscipleName(dzId))


comHelper.setChildInSideModel(self.diziIcon,dzId,0.58,nil,0,25)


local skill_id=config.pro_skill_id
if skill_id then
self.level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local pro_skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local addEffect=0
if pro_skill_cfg.fangshi_discount then
addEffect=pro_skill_cfg.fangshi_discount[self.level]
end
self.dizi_lv:setText(FMT.fmt("{0}：{1}级",pro_skill_cfg.name,self.level))
self.nodiscount:setActive(addEffect==0)
self.discount:setActive(addEffect>0)
self.dizi_zhekou=addEffect
end


self.dizi_speciality=self:getPlantEffects(dzId)
if self.dizi_speciality~=nil and#self.dizi_speciality>0 then
self.scrollview2:setChildScrollViewInit(0,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)
self.scrollview2:setChildScrollViewCreateGrids(#self.dizi_speciality,0)
local grids=self.scrollview2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.dizi_speciality[i]
UIDiscipleModel.refreshSpecialityItemEx(item,data)
end
self.txtSpeciality:setText('特质:')
else
self.txtSpeciality:setText('')
end
end
self.title:setText('购买弟子')
elseif self.fairType==eFairType.eBlackMarket or self.fairType==eFairType.eBlackSpeGoods or self.fairType==eFairType.eMysteryMarket then

self.title:setText('购买需知')
local modelId=2113001
local cfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelId)
local scale=cfg.scales and(cfg.scales[1]~=1 and cfg.scales[1]or cfg.scales[2])or 0.9
self.guishiModel:setChildUIModelShowTarget(modelId,scale,nil,eAnimationID.stand)
end
end


function UIFairTipsWin:refreshRightPanel()
local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList
local fairCfg
local item_lib
local libType=goodsList[self.currindex].param_3
if self.fairType==eFairType.eBooth then
fairCfg=fairModel.get_booth_config(fairData.cfg_key_1,fairData.cfg_key_2)
item_lib=libType==1 and fairCfg.randomItem_lib or fairCfg.story_randomItem_lib
elseif self.fairType==eFairType.eBlackMarket or self.fairType==eFairType.eBlackSpeGoods then
fairCfg=fairModel.get_black_market_config(fairData.cfg_key_1,fairData.cfg_key_2)
item_lib=libType==1 and fairCfg.randomItem_lib or fairCfg.randomItem_lib2
end

local libIndex=goodsList[self.currindex].param_1
local libItem=item_lib[libIndex]

local shopItemId=libIndex
libItem=cfgHelper.get(cfg_fangshishopitemconfig_get,shopItemId,"Item_conf")


if self.fairType==eFairType.eBlackSpeGoods then
goodsList=fairData.speGoodList
libIndex=goodsList[self.currindex].param_1
libItem=fairCfg.randomItem_spelib[libIndex]
end
local itemId=libItem[1]
local itemCount=libItem[2]
local moneyType=libItem[3]
local moneyValue=libItem[4]
local distance=(100-libItem[5])
local israre=libItem[6]
local candistance=libItem[7]

local itemConfig=itemsHelper:get_item_config(itemId)
self:refreshgoods(itemId,itemConfig)
self:fillOtherInfo(itemId,itemConfig)

self.desc_1:setText(itemConfig.desc)


local zhekouprice
local dizi_zhekou=self.dizi_zhekou or 0
self.Icon:setImageIcon(iconHelper.getIconName(moneyType),false)
if self.fairType==eFairType.eBooth then
if candistance~=0 then
zhekouprice=math.floor((moneyValue*(distance-dizi_zhekou)/100)+0.5)
self.discountNum:setText(pfwindowslController:convertDiscount_yuenan(string.format('%.1f折',(distance-dizi_zhekou)/10)))
else
zhekouprice=math.floor((moneyValue*(distance/100))+0.5)
self.discountNum:setText(pfwindowslController:convertDiscount_yuenan(string.format('%d折',distance/10)))
end
self.price:setText(FMT.fmt('<color=#ca631dff>{0}</color>',zhekouprice))
elseif self.fairType==eFairType.eBlackMarket or self.fairType==eFairType.eBlackSpeGoods then
zhekouprice=math.floor((moneyValue*(distance/100))+0.5)
self.price:setText(FMT.fmt('<color=#ca631dff>{0}</color>',zhekouprice))
end


self.needMoney=zhekouprice
self.moneyType=moneyType




end

function UIFairTipsWin:refreshOtherRightPanel()
local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList


local libItem=goodsList[self.currindex]
if not libItem then
return
end

local itemId=libItem[1]
local itemCount=libItem[2]
local moneyType=libItem[3]
local moneyValue=libItem[4]
local distance=libItem[5]or 100
local israre=libItem[6]
local candistance=libItem[7]

local itemConfig=itemsHelper:get_item_config(itemId)
self:refreshgoods(itemId,itemConfig)
self:fillOtherInfo(itemId,itemConfig)

self.desc_1:setText(itemConfig.desc)


local zhekouprice
self.Icon:setImageIcon(iconHelper.getIconName(moneyType),false)

zhekouprice=math.floor((moneyValue*(distance/100))+0.5)
self.price:setText(FMT.fmt('<color=#ca631dff>{0}</color>',zhekouprice))


self.needMoney=zhekouprice
self.moneyType=moneyType




end

function UIFairTipsWin:refreshgoods(itemid,cfg)

local name=cfg.name
self.name:setText(name)



local prop={}
local color=cfg.color
local countTxt=''
local stageTxt=not self.showStage and cfg.stage and FMT.fmt('{0}阶',cfg.stage)or''
local showStage=stageTxt~=''
prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpItemIconIdx)]=iconHelper.getIconName(itemid)
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemCount)]=countTxt
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemTxtStageBg)]=showStage
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtStage)]=stageTxt
prop[DataPropKey.eItemID]=itemid
self.item:setChildPropData(prop)
end

function UIFairTipsWin:fillOtherInfo(itemid,itemConfig)
local color=itemConfig.color
local name=FMT.cfmt(color,itemConfig.name)
self.name:setText(name)

local typename=FMT.fmt("{0}{1}",FMT.cfmt(FONT_COLOR.eOrangeDescColor,'类型：'),itemConfig.typename)
self.title1:setText(typename)
for i=2,3 do
self[FMT.fmt('title{0}',i)]:setActive(false)
end
local idx=2
if itemConfig.level then
local title=FMT.cfmt(FONT_COLOR.eOrangeDescColor,'使用等级：')
self.title2:setText(FMT.fmt('{0}宗门{1}级',title,itemConfig.level))
self.title2:setActive(true)
idx=idx+1
elseif itemConfig.stage then
local title=FMT.cfmt(FONT_COLOR.eOrangeDescColor,'阶数：')
self.title2:setText(FMT.fmt('{0}{1}阶',title,itemConfig.stage))
self.title2:setActive(true)
self.showStage=true
idx=idx+1
end

if itemConfig.element then
local elementName=ELEMENT_TYPE.getName(itemConfig.element)
local title=FMT.cfmt(FONT_COLOR.eOrangeDescColor,'五行属性：')
self[FMT.fmt('title{0}',idx)]:setText(FMT.fmt('{0}{1}属性',title,elementName))
self[FMT.fmt('title{0}',idx)]:setActive(true)
idx=idx+1
end


local funcparam=itemConfig.funcparam
if idx<=3 and funcparam and funcparam.condition then
local condition=funcparam.condition
local title=FMT.cfmt(FONT_COLOR.eOrangeDescColor,'使用限制：')
local jingjie=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eJingjieLv,condition)
local lianti=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLiantiLv,condition)
if jingjie then
local minJJLv=jingjie[1]
local title3Str=''
local jjName=UIDiscipleModel:getJJName(minJJLv)
title3Str=FMT.fmt('{0}期',jjName)
self[FMT.fmt('title{0}',idx)]:setText(FMT.fmt('{0}{1}',title,title3Str))
self[FMT.fmt('title{0}',idx)]:setActive(true)
elseif lianti then
local minltLv=lianti[1]
local title3Str=''
local ltName=UIDiscipleModel:getLTName(minltLv)
title3Str=FMT.fmt('{0}期',ltName)
self[FMT.fmt('title{0}',idx)]:setText(FMT.fmt('{0}{1}',title,title3Str))
self[FMT.fmt('title{0}',idx)]:setActive(true)
end
end
end


function UIFairTipsWin:getPlantEffects(dzId)
local configs=UIDiscipleModel:getDiscipleSpecialityConfig(dzId)
if#configs>0 then
local plant_effects={}
for i,cfg in ipairs(configs)do
local plant_effect=zongmenControl:getPlantEffect(cfg.build_effects,self.bdType)
if plant_effect then
cfg.sort_score=zongmenControl:getPlantEffectScore(plant_effect)
table.insert(plant_effects,cfg)
end
end
if#plant_effects>0 then
table.sort(plant_effects,function(a,b)
return a.sort_score>b.sort_score
end)
return plant_effects
end
end
end

function UIFairTipsWin:refreshBuyBtn()
self.buyBtnModel:setChildUIModelShowTarget(2017,1,{},eAnimationID.common_window_enter,false,false,0,nil)

end





function UIFairTipsWin:onBuyBtn()
self:stopBuyBtnTimer()
self.buyBtnModel:setChildModelAnimationState(eAnimationID.common_window_dianji)
local func=function()
if self==nil or self.isClose then return end
local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList

if self.fairType==eFairType.eBlackSpeGoods then
goodsList=fairData.speGoodList
end







if goodsList[self.currindex].param_2==1 then
UIManager.error("已购买")
return
end





















local fairType=self.fairType
local buyClickfun=self.buyClickfun
local currindex=self.currindex
local callback=function(...)
buyClickfun(fairType,currindex)
end
moneySystem:useMoney(self.moneyType,self.needMoney,callback,WARNING_TYPE.eWarning)
self:closeSelf()
end
self.buyBtnTimer=self:setTimer(0.1,1,func)
end






















function UIFairTipsWin:stopBuyBtnTimer()
if self.buyBtnTimer then
self:stopTimerByID(self.buyBtnTimer)
self.buyBtnTimer=nil
end
end

function UIFairTipsWin.on_building_event(etype,sfId,bdId,args)
if etype==buildingEvent.replaceDisciple then
_this:refreshLeftPanel()
_this:refreshRightPanel()
end
end


function UIFairTipsWin:onAddButton()
zongmenControl:showSelectManagerWin(self.sysData.mountain_id,self.buildData,dzSelectWinOpenType.eFangShi,dzSelectEffectType.eFangShi)
self.btClickfun()
self:closeSelf()
end

function UIFairTipsWin:onClickClose()
self:closeSelf()
end

function UIFairTipsWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollview2:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='top',guid=self.buildData.dizi_id,config=data})
end