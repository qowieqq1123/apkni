







def_class("UIFuLuSelectListWin",UIWindowBase)









function UIFuLuSelectListWin:bindComponents()

self.fubaoList=UIScrollView.get(self,0)
self.comboBox=UIObject.get(self,1)
self.materialScroller=UIObject.get(self,2)
self.matTypeText=UIText.get(self,3)
self.selectBtn=UIButton.get(self,4)
self.fubaoItem=UIObject.get(self,5)
self.name=UIText.get(self,6)
self.effect_3=UIObject.get(self,7)
self.effect_2=UIObject.get(self,8)
self.effect_1=UIObject.get(self,9)
self.lockImg=UIObject.get(self,10)
self.requireText=UIText.get(self,11)
self.item=UIObject.get(self,12)
self.selectBg=UIObject.get(self,13)
self.reddot=UIObject.get(self,14)
self.effectText_1=UIText.get(self,15)
self.effectText_2=UIText.get(self,16)
self.effectText_3=UIText.get(self,17)
self.selectBtnText=UIText.get(self,18)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)
self.effect={
self.effect_1,
self.effect_2,
self.effect_3,
}
self.effectText={
self.effectText_1,
self.effectText_2,
self.effectText_3,
}



end


function UIFuLuSelectListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fubaoList);self.fubaoList=nil;
_UIObject_release(self.comboBox);self.comboBox=nil;
_UIObject_release(self.materialScroller);self.materialScroller=nil;
_UIObject_release(self.matTypeText);self.matTypeText=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.fubaoItem);self.fubaoItem=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.effect_3);self.effect_3=nil;
_UIObject_release(self.effect_2);self.effect_2=nil;
_UIObject_release(self.effect_1);self.effect_1=nil;
_UIObject_release(self.lockImg);self.lockImg=nil;
_UIObject_release(self.requireText);self.requireText=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.selectBg);self.selectBg=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.effectText_1);self.effectText_1=nil;
_UIObject_release(self.effectText_2);self.effectText_2=nil;
_UIObject_release(self.effectText_3);self.effectText_3=nil;
_UIObject_release(self.selectBtnText);self.selectBtnText=nil;
self.effect=nil;
self.effectText=nil;
end

















local _this
local option={
[FULU_TAB_TYPE.eFuBao]=
{
'所有',
'5阶符宝',
'4阶符宝',
'3阶符宝',
'2阶符宝',
'1阶符宝',
},
[FULU_TAB_TYPE.eXianLu]=
{
'所有',
FMT.fmt('{0}仙箓',eQualityColorName[5]),
FMT.fmt('{0}仙箓',eQualityColorName[4]),
FMT.fmt('{0}仙箓',eQualityColorName[3]),
FMT.fmt('{0}仙箓',eQualityColorName[2]),
FMT.fmt('{0}仙箓',eQualityColorName[1]),
}
}

local menuItemInex=
{
item=0,
select=1,
showItem=2,
require=3,
lock=4,
reddot=5,
name=6,
}


function UIFuLuSelectListWin:onLoaded(...)
self:bindComponents()
_this=self
self.comboBox:setChildComboBoxInit(self.on_combobox_change)
local _onClickMenuCallBack=function(...)
self:onClickMenuCallBack(...)
end
self.fubaoList:setClickAction(_onClickMenuCallBack)
local _onClickBaseItem=function(...)
self:onClickBaseItem(...)
end
self.materialScroller:setChildScrollViewInit(0.5,true,_onClickBaseItem,nil)
end


function UIFuLuSelectListWin:__delete()
_this=nil
self:unbindComponents()
end




function UIFuLuSelectListWin:onShow(argtable,afterOnloaded)
local ubdId=argtable.ubdId
self.fuluType=argtable.menuPageIndex

self.bdData=zongmenModel:getBuildingData(ubdId)
zongmenModel:countManufacturePercent(self.bdData)
self:refresh()
end

function UIFuLuSelectListWin:refresh()
self.buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
if self.fuluType==FULU_TAB_TYPE.eFuBao then
self.allConfig=cfg_fubaofangconfig()
self.selectBtnText:setText('选择符宝')
else
self.allConfig=cfg_fulufangconfig()
self.selectBtnText:setText('选择配方')
end
self:initSort()
end

function UIFuLuSelectListWin:refreshAfterItemUse(utype,arg1,arg2)
self:refresh()
end


function UIFuLuSelectListWin:onHide()

end

function UIFuLuSelectListWin.on_combobox_change(index)
local color=_this.indexToColor[index+1]
_this.currColor=color
_this:refreshLeftList(color)
end

function UIFuLuSelectListWin:initSort()
self.indexToColor={0,5,4,3,2,1}
self.comboBox:setChildComboBoxOption(0,option[self.fuluType])
end

function UIFuLuSelectListWin:getFuBaoDatas(color)
local list={}
local cfgs=self.allConfig
if color==0 then
for k,v in ipairs(cfgs)do
table.insert(list,v)
end
else
if self.fuluType==FULU_TAB_TYPE.eFuBao then
for i,v in ipairs(cfgs)do
if v.stage==color then
table.insert(list,v)
end
end
else
for i,v in ipairs(cfgs)do
if v.color==color then
table.insert(list,v)
end
end
end
end
list=self:getSortTagList(list)
table.sort(list,function(a,b)return a.sortTag<b.sortTag end)
return list
end

function UIFuLuSelectListWin:getSortTagList(list)
local dzId=self.bdData.dizi_id
local skill_id=self.buildCfg.pro_skill_id
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
if self.fuluType==FULU_TAB_TYPE.eFuBao then
for i,v in ipairs(list)do
local checkMake=level>=v.need_fl_lvl
v.sortTag=v.id+v.stage*100000000
if not checkMake then
v.sortTag=v.sortTag+v.need_fl_lvl*10000
end
end
else
for i,v in ipairs(list)do
local checkMake=level>=v.need_fl_lvl
v.sortTag=v.id+v.color*100000000
if not checkMake then
v.sortTag=v.sortTag+v.need_fl_lvl*10000
end
end
end
return list
end

function UIFuLuSelectListWin:refreshLeftList(color)
self.datas=self:getFuBaoDatas(color or 0)
local len=#self.datas
self.fubaoList:freshGridsNum(len,len,1,true)
self.menuIndex=1

local dzId=self.bdData.dizi_id
local skill_id=self.buildCfg.pro_skill_id
local skill_cfg=cfgHelper.get1(cfg_discipleproskillconfig_get,skill_id)
local level=0
if tostring(dzId)~='0'then
level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
end
for i=1,#self.datas do
local item=self.fubaoList:getGridObjectByindex(i-1)
if item then
local config=self.datas[i]
item:SetChildActive(menuItemInex.item,true)

item:SetChildActive(menuItemInex.select,i==self.menuIndex)

item:SetChildText(menuItemInex.name,config.name)

local conf={itemid=config.itemId,showCountBG=false,showStage=self.fuluType==FULU_TAB_TYPE.eFuBao}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetQuality,0)]=config.color
prop[PropIndex(DataPropKey.eWidgetText,6)]=FMT.fmt('{0}阶',config.stage)
item:SetChildPropData(menuItemInex.showItem,prop)

local isUnlock=false
if self.fuluType==FULU_TAB_TYPE.eFuBao then
isUnlock=UIFuLuFangModel:isFuBaoUnlock(config.id)
else
isUnlock=UIFuLuFangModel:isFuLuUnlock(config.id)
end
local requireStr=''
local canMake=level>=config.need_fl_lvl
if isUnlock then
if canMake then
requireStr=''
else
requireStr=FMT.fmt('<color=#c82c2c>{0}等级需达到{1}级</color>',skill_cfg.name,config.need_fl_lvl)
end
else
requireStr='可通过宗门大殿解锁'
end
item:SetChildActive(menuItemInex.lock,not isUnlock)

item:SetChildText(menuItemInex.require,requireStr)

item:SetChildActive(menuItemInex.reddot,false)
end
end
if len>0 then
self:refreshRightInfo(self.datas[1])
end
end

function UIFuLuSelectListWin:onClickMenuCallBack(id,index,guid,attach)

if self.menuIndex==index then return end
self.menuIndex=index

for i=1,#self.datas do
local item=self.fubaoList:getGridObjectByindex(i-1)
if item then
item:SetChildActive(menuItemInex.select,i==self.menuIndex)
end
end
local data=self.datas[index]
self:refreshRightInfo(data)
end

function UIFuLuSelectListWin:refreshRightInfo(config)

local conf={itemid=config.itemId,showCountBG=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetQuality,0)]=config.color
prop[PropIndex(DataPropKey.eWidgetText,4)]=config.name
self.fubaoItem:setChildPropData(prop)

local effects=config.effects_desc or{}
for i=1,3 do
self.effect[i]:setActive(i<=#effects)
if i<=#effects then
local desc=effects[i]
self.effectText[i]:setText(desc)
end
end

local cost=config.cost
self.materialScroller:setChildScrollViewCreateGrids(#cost,#cost)
self.grids=self.materialScroller:getChildScrollViewItemWidgets()
local count=self.grids.Count
local percent=self.bdData.pcreatesubpercent or 0
for i=1,count do
local item=self.grids[i-1]
local data=cost[i]
local itemid=data[1]
local price=data[2]
local showStage=true
if itemsConfig.isMoney(itemid)then
price=math.ceil(price*(1+percent/100))
else
showStage=false
end
local have=UIFuLuFangModel:getHaveItemCount(itemid)
local countStr=UIFuLuFangModel:getItemCountStr(itemid,price)
local granNum=have<price and 3 or 0
local conf={itemid=itemid,itemcount=countStr,showCountBG=false,showStage=showStage,gray=granNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local widget=item:GetChildWidgetBase(0)
widget:SetChildActive(5,showStage)
end
end

function UIFuLuSelectListWin:onClickBaseItem(clickCount,index)
local percent=self.bdData.pcreatesubpercent or 0
local data=self.datas[self.menuIndex]
local cost=data.cost
local itemData=cost[index+1]
local itemid=itemData[1]
local price=itemData[2]
if itemsConfig.isMoney(itemid)then
price=math.ceil(price*(1+percent/100))
end
if itemid==-1 then
return
end
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg then
if gainControl:showGainWin(itemid,price)then return end
tipsManager.showTips({formType=TIPS_FORM_TYPE.eFuluSelect,itemid=itemid})
else
loggerUtil.logErrFMT('没有找到此道具：',itemid)
end
end

function UIFuLuSelectListWin:checkCanMake()
local data=self.datas[self.menuIndex]
local costs=data.cost
local needLv=data.need_fl_lvl
local dzId=self.bdData.dizi_id
local skill_id=self.buildCfg.pro_skill_id
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
if level<needLv then
UIManager.error('弟子符箓等级不足')
return
end
local percent=self.bdData.pcreatesubpercent or 0
if not UIFuLuFangModel:checkCanMake(costs,true,1,percent)then
return
end
return true
end


function UIFuLuSelectListWin:onSelectBtn()
if not self:checkCanMake()then
return
end
local data=self.datas[self.menuIndex]
UIManager:callWindowFunc('UIFuLuMixWin','refreshPanelState',{self.fuluType,data})
oneTabScreenController:closeUI()
end
