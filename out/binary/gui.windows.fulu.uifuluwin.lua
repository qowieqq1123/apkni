







def_class("UIFuLuWin",UIWindowBase)









function UIFuLuWin:bindComponents()

self.comboBox=UIObject.get(self,0)
self.fenjie=UIButton.get(self,1)
self.scrollview=UIObject.get(self,2)

self.fenjie:setButtonClick(function()self:onFenjie()end)



end


function UIFuLuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.comboBox);self.comboBox=nil;
_UIObject_release(self.fenjie);self.fenjie=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
end
















local _itemIndex={
item=0,
name=1,
lockpanel=2,
unlockpanel=3,
cost1=4,
cost2=5,
cost3=6,
makebtn=7,
unlocktips=8,
needlevel=9,
}

local _this




function UIFuLuWin:onLoaded(...)
self:bindComponents()

_this=self

self.comboBox:setChildComboBoxInit(self.on_combobox_change)

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIFuLuWin:__delete()
self:unbindComponents()

_this=nil
end

function UIFuLuWin.on_combobox_change(index)
local color=_this.indexToColor[index+1]
_this.currColor=color
_this:refreshFuLuList(color)
end

function UIFuLuWin:refresh()
if self.currColor then
self:refreshFuLuList(_this.currColor)
end
end




function UIFuLuWin:onShow(argtable,afterOnloaded)
self.sfId=zongmenModel:getMountainId()
self.bdData=argtable
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self:initSort()
end


function UIFuLuWin:onHide()

end

function UIFuLuWin:initSort()
self.option={
'所有',
'5阶符箓',
'4阶符箓',
'3阶符箓',
'2阶符箓',
'1阶符箓',
}
self.indexToColor={0,5,4,3,2,1}
self.comboBox:setChildComboBoxOption(0,self.option)
end

function UIFuLuWin:getFuBaoDatas(color)
local cfgs=cfg_fubaofangconfig()
if color==0 then
return cfgs
else
local list={}
for i,v in ipairs(cfgs)do
if v.color==color then
table.insert(list,v)
end
end
return list
end
end

function UIFuLuWin:refreshFuLuList(color)
self.datas=self:getFuBaoDatas(color or 0)
local len=#self.datas
self.scrollview:setChildScrollViewCreateGrids(len,1)

local dzId=self.bdData.dizi_id
local skill_id=self.config.pro_skill_id
local skill_cfg=cfgHelper.get1(cfg_discipleproskillconfig_get,skill_id)
local level=0
if tostring(dzId)~='0'then
level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
end

local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cfg=self.datas[i]
widgetHelper.setNormalRewardItem(item,_itemIndex.item,{cfg.itemId,0})
item:SetChildText(_itemIndex.name,cfg.name)
local isUnlock=UIFuLuFangModel:isFuBaoUnlock(cfg.id)
item:SetChildActive(_itemIndex.unlockpanel,isUnlock)
item:SetChildActive(_itemIndex.lockpanel,not isUnlock)
if isUnlock then
self:setCostItem(item,_itemIndex.cost1,cfg.cost[1])
self:setCostItem(item,_itemIndex.cost2,cfg.cost[2])
self:setCostItem(item,_itemIndex.cost3,cfg.cost[3])
local canMake=level>=cfg.need_fl_lvl
item:SetChildActive(_itemIndex.makebtn,canMake)
if canMake then
item:SetChildButtonClickWithID(_itemIndex.makebtn,self.onCreateClick,cfg.id)
item:SetChildText(_itemIndex.needlevel,'')
else
item:SetChildText(_itemIndex.needlevel,FMT.fmt('{0}等级{1}级',skill_cfg.name,cfg.need_fl_lvl))
end
else
item:SetChildText(_itemIndex.unlocktips,'可通过宗门大殿解锁')
end
end
end

function UIFuLuWin:checkMake(id)
local cfg=cfgHelper.get1(cfg_fulufangconfig_get,id)
for i,v in ipairs(cfg.cost)do
local itemId=v[1]
local itemCount=v[2]
local itemConfig=itemsConfig.getConfig(itemId)
local have
if moneyConfig.isMoney(itemId)then
have=moneyModel.getMoney(itemId)
else
have=bagModel.getItemCountById(itemId)
end
if have<itemCount then
UIManager.error(FMT.fmt('{0}不足',itemConfig.name))
gainControl:showGainWin(itemId)
return false
end
end
return true
end

function UIFuLuWin.onCreateClick(id)
if _this:checkMake(id)then
UIFullFuLuFangControl:reqMakeFuLu(0,id,_this.sfId,_this.bdData.un_build_id)
end
end

function UIFuLuWin:setCostItem(item,index,data)
if data then
item:SetChildActive(index,true)
widgetHelper.setNormalRewardItem(item,index,{data[1],data[2],checkAmount=true})
else
item:SetChildActive(index,false)
end
end




function UIFuLuWin:onFenjie()
UIManager:showWindow('UIFuLuFJWin')
end