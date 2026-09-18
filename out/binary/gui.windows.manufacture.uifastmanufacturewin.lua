







def_class("UIFastManufactureWin",UIWindowBase)









function UIFastManufactureWin:bindComponents()

self.clickPanel=UIButton.get(self,0)
self.planScrollview=UIObject.get(self,1)
self.scrollview=UIObject.get(self,2)
self.empty=UIObject.get(self,3)
self.startBtn=UIButton.get(self,4)
self.topComboBox=UIObject.get(self,5)

self.clickPanel:setButtonClick(function()self:onClickPanel()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)



end


function UIFastManufactureWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickPanel);self.clickPanel=nil;
_UIObject_release(self.planScrollview);self.planScrollview=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.topComboBox);self.topComboBox=nil;
end
















local _widgetIndex={
icon=0,
name=1,
planName=2,
reward=3,
cost1=4,
cost2=5,
time=6,
setBtn=7,
startBtn=8,
info1=9,
info2=10,
tips1=11,
tips2=12,
}

local _this




function UIFastManufactureWin:onLoaded(...)
self:bindComponents()

_this=self
self.customize={}
self.sfId=zongmenModel:getMountainId()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
self.planScrollview:setChildScrollViewInit(0.5,true,self.on_plan_item_click,nil)


self.topComboBox:setChildComboBoxInit(self.on_top_combobox_change)

self:addNotify(notifyConfig.building_event,self.on_building_event)
end


function UIFastManufactureWin:__delete()
self:unbindComponents()

_this=nil






end

function UIFastManufactureWin.on_top_combobox_change(index)
local type=_this.topTypes[index+1]
if _this.top_type~=type then
_this.top_type=type
_this:refresh()
end
end

function UIFastManufactureWin:initSort()
if self.top_type==nil or#self.topTypes==0 then
self.topComboBox:setActive(false)
return
end
self.topComboBox:setActive(true)
self.option={}
local index=0
for i,v in ipairs(self.topTypes)do
if v==self.top_type then
index=i-1
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v)
self.option[i]=FMT.fmt('{0}置顶',cfg.name)
end
self.topComboBox:setChildComboBoxOption(index,self.option)
end




function UIFastManufactureWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}

self:setDatas(argtable[1],argtable[2])
self:initSort()
self:refresh(self.datas,self.topTypes)
end

function UIFastManufactureWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.planStart then
_this:refresh()
_this:initSort()
end
end

function UIFastManufactureWin:setDatas(datas,topTypes)
if not datas then
datas,topTypes=zongmenControl:fastManufacture(self.customize,self.top_type)
end
self.datas=datas
self.topTypes=topTypes

self.top_type=self.top_type or self.topTypes[1]
end

function UIFastManufactureWin:refresh(datas,topTypes)
self:onClickPanel()

self:setDatas(datas,topTypes)

local len=#self.datas
local dataslist=guildOrderController:getAllDefId()or{}

self.empty:setActive(len<=0)

self.scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local data=self.datas[i+1]
local localdefId=dataslist[tostring(data.data.un_build_id)]
if data.data and data.data.un_build_id and localdefId then
if data.defId>=localdefId then
data.defId=localdefId
end
end



item:SetChildIcon(_widgetIndex.icon,data.cfg.icon,true)
item:SetChildText(_widgetIndex.name,FMT.fmt('{0}级 {1}',data.data.level,data.cfg.name))
local showStart=true
if data.defId>0 then
local enough=#data.need<=0
item:SetChildActive(_widgetIndex.info1,enough)
item:SetChildActive(_widgetIndex.info2,not enough)
if enough then
local plan=data.lcfg.produce_plans[data.defId]
local times=plan.groups and plan.groups[1]or 1
item:SetChildText(_widgetIndex.planName,plan.display[1])
self:setCost(item,_widgetIndex.reward,plan.rewards[1],data.data.pcreateaddpercent or 0,true,times)
self:setCost(item,_widgetIndex.cost1,plan.cost[1],data.data.pcreatesubpercent or 0,false,1)
self:setCost(item,_widgetIndex.cost2,plan.cost[2],data.data.pcreatesubpercent or 0,false,1)
item:SetChildText(_widgetIndex.time,timeHelper.format_time_stamp11(self:countPlanValue(plan[1],
data.data.pcreatetimepercent or 0,times),true))
else
item:SetChildText(_widgetIndex.tips1,'无法生产')
item:SetChildText(_widgetIndex.tips2,self:getNeedText(data.need))
end
else
item:SetChildActive(_widgetIndex.info1,false)
item:SetChildActive(_widgetIndex.info2,true)
item:SetChildText(_widgetIndex.tips1,'不安排生产')
item:SetChildText(_widgetIndex.tips2,'点击<color=red>调整</color>安排生产')
showStart=false
end
item:SetChildButtonClickWithID(_widgetIndex.setBtn,self.on_setbtn_click,i)
item:SetChildActive(_widgetIndex.startBtn,showStart)
if showStart then
item:SetChildButtonClickWithID(_widgetIndex.startBtn,self.on_startbtn_click,i)
end
end
end

function UIFastManufactureWin:countPlanValue(val,percent,times)
local count=0
for i=1,times do
count=count+math.floor(val*(1+percent*0.01))
end
return count
end

function UIFastManufactureWin:countAddValue(val,add)
return math.floor(val*(1+add*0.01))
end

function UIFastManufactureWin.on_setbtn_click(id)
_this:setPlanPanel(id+1)
end

function UIFastManufactureWin.on_startbtn_click(id)
local data=_this.datas[id+1]
if emergenciesModel:isCreeper(data.data.un_build_id)then
UIManager.info('缠绕中无法使用')
return
end
_this:reqManufacture(data)
end

function UIFastManufactureWin:reqManufacture(data)

zongmenControl:reqSchemePlantEx(self.sfId,1,{{data.defId,data.data.un_build_id}})
end

function UIFastManufactureWin:setPlanPanel(index)
self.planScrollview:setActive(true)
self.clickPanel:setActive(true)

local widget=self.scrollview:getChildScrollViewItemWidget(index-1)
local wpos=widget:GetChildPosition(_widgetIndex.setBtn)
self.planScrollview:setChildPos(wpos.x-0.5,wpos.y+0.55,wpos.z)

local data=self.datas[index]
self.planScrollview:setChildScrollViewCreateGrids(data.maxId+1,0)
local grids=self.planScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
item:SetChildActive(0,i==data.defId)
if i==0 then
item:SetChildText(1,'不安排生产')
else
local plan=data.lcfg.produce_plans[i]
item:SetChildText(1,plan.display[1])
end
end
self.currData=data
end

function UIFastManufactureWin.on_plan_item_click(clicknum,index)
if _this.currData.defId~=index then
_this.customize[_this.currData.data.un_build_id]=index
guildOrderController:setAllDefId({_this.currData.data.un_build_id,index})
_this:refresh()
end
_this:onClickPanel()
end











function UIFastManufactureWin:onHide()

end

function UIFastManufactureWin:setCost(item,index,mdata,add,symbol,times)
if mdata then
item:SetChildActive(index,true)
local widget=item:GetChildWidgetBase(index)
widget:SetChildIcon(0,iconHelper.getIconName(mdata[1]),true)
local sval=0
for i=1,times do
sval=sval+self:countAddValue(mdata[2],add)
end
if symbol then
sval=FMT.fmt('{0}{1}',sval>0 and'+'or'',sval)
end
widget:SetChildText(1,sval)
else
item:SetChildActive(index,false)
end
end

function UIFastManufactureWin:getNeedText(need)
local str=''
for i,v in pairs(need)do
local name=moneyModel.getMoneyName(i)
str=string.format('%s或<color=red>%s</color>',str,name)
end
str=string.gsub(str,'或','',1)
return string.format('所需%s不足',str)
end




function UIFastManufactureWin:onStartBtn()
local showTips=false
local reqlist={}
for i,v in ipairs(self.datas)do
if v.defId>0 and#v.need<=0 then

if not emergenciesModel:isCreeper(v.data.un_build_id)then
table.insert(reqlist,{v.defId,v.data.un_build_id})
showTips=true
end
end
end
if mainControl:isInScene(eSceneType.eWorld)and showTips then
self:onCloseClick()
UIManager.info("大世界中不能进行批量生产")
return
end
local reqCnt=#reqlist
if reqCnt>0 then
zongmenControl:reqSchemePlantEx(self.sfId,#reqlist,reqlist)
end

if showTips then
UIManager.info('建筑已开始生产')
self:onCloseClick()
else
if#self.datas>0 then
UIManager.info('缠绕中无法使用')
else
self:onCloseClick()
end
end
end

















function UIFastManufactureWin:onClickPanel()
self.planScrollview:setActive(false)

self.clickPanel:setActive(false)
end

function UIFastManufactureWin:onCloseClick()
self:closeSelf()
end