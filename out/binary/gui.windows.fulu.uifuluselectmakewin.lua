







def_class("UIFuLuSelectMakeWin",UIWindowBase)









function UIFuLuSelectMakeWin:bindComponents()

self.icon=UIObject.get(self,0)
self.name=UIText.get(self,1)
self.des=UIText.get(self,2)
self.nAttr=UIText.get(self,3)
self.rwScrollView=UIObject.get(self,4)
self.selectBtn=UIButton.get(self,5)
self.unlockTips=UIText.get(self,6)
self.gotoBtn=UIButton.get(self,7)
self.headRoot=UIObject.get(self,8)
self.scrollview=UIObject.get(self,9)
self.comboBox=UIObject.get(self,10)
self.head=UIBaseItem.get(self,11)
self.dzLevel=UIText.get(self,12)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIFuLuSelectMakeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.des);self.des=nil;
_UIObject_release(self.nAttr);self.nAttr=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.unlockTips);self.unlockTips=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.headRoot);self.headRoot=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.comboBox);self.comboBox=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.dzLevel);self.dzLevel=nil;
end
















local _this




function UIFuLuSelectMakeWin:onLoaded(...)
self:bindComponents()

_this=self

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_select,nil)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.comboBox:setChildComboBoxInit(self.on_combobox_change)


UIFuLuFangModel:clearNewUnlockData(FULU_TAB_TYPE.eXianLu)

self.checkList={}
self.on_money_changed=function(mtype,last,curr)
if self.checkList[mtype]then
self:refreshRightPanel()
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIFuLuSelectMakeWin:__delete()
self:unbindComponents()

_this=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end

function UIFuLuSelectMakeWin.on_item_select(cnum,index)
if _this.selectIndex==index then
return
end
if _this.selectIndex then
local widget=_this.scrollview:getChildScrollViewItemWidget(_this.selectIndex)
widget:SetChildActive(1,false)
end

_this.selectIndex=index

local widget=_this.scrollview:getChildScrollViewItemWidget(_this.selectIndex)
widget:SetChildActive(1,true)

_this:refreshRightPanel()
end

function UIFuLuSelectMakeWin.on_combobox_change(index)
_this.datas=_this.filterDatas[index]
_this:setItemList()
_this.selectIndex=nil
local sel=_this.selIndex or 0
_this.on_item_select(1,sel)
end




function UIFuLuSelectMakeWin:onShow(argtable,afterOnloaded)
local args=tempDataControl:getWinData('UIFuLuMixWin')
self.args=args
self.pData=args.pData
self.bdData=zongmenModel:getBuildingData(args.ubdId)
self.filterDatas=self:getDatas()

if args.selectItem then
self.selIndex=self:getSelectParam(args.selectItem)
end

local filterOption=cfgHelper.get2(cfg_fubaofangbasicconfig_get,1,'filter_option')
self.comboBox:setChildComboBoxOption(0,filterOption)
end

function UIFuLuSelectMakeWin:getSelectParam(selectItem)
for i,v in ipairs(self.filterDatas[0])do
if v.id==selectItem then
return i
end
end
end


function UIFuLuSelectMakeWin:onHide()

end

function UIFuLuSelectMakeWin:getDatas()
local cfgs=cfg_fulufangconfig()
local list={}
for k,v in pairs(cfgs)do
if k~='const_def'then
table.insert(list,{id=v.id,cfg=v,unlock=UIFuLuFangModel:isFuLuUnlock(v.id)})
end
end

table.sort(list,function(a,b)
if a.unlock and not b.unlock then
return true
elseif not a.unlock and b.unlock then
return false
else
return a.id<b.id
end
end)

local flist={}
for i,v in ipairs(list)do
local st=flist[v.cfg.filter]or{}
table.insert(st,v)
flist[v.cfg.filter]=st
end
flist[0]=list
return flist
end

function UIFuLuSelectMakeWin:setItemList()
local len=#self.datas
self.scrollview:setChildScrollViewCreateGrids(len,0)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=self.datas[i]

item:SetChildIcon(0,iconHelper.getIconName(data.cfg.itemId),true)
item:SetChildActive(1,false)
item:SetChildText(2,data.cfg.name)
item:SetChildText(3,'符箓')
item:SetChildActive(4,not data.unlock)
item:SetChildGraphicGray(-1,not data.unlock,true)
end
end

function UIFuLuSelectMakeWin:refreshRightPanel()
local data=self.datas[self.selectIndex+1]
self.name:setText(data.cfg.name)

self.icon:setChildIcon(iconHelper.getIconName(data.cfg.itemId),true)

self.nAttr:setText(data.cfg.effects_desc or'')

local cost=data.cfg.cost
local len=#cost
self.rwScrollView:setChildScrollViewCreateGrids(len,0)
self.grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local cdata=cost[i]
local itemId=cdata[1]
local itemCount=cdata[2]
self.checkList[itemId]=true
if itemId==eMoneyType.mtFuZhi then
itemCount=itemCount*(1+(self.pData[1]or 0)*0.01)
end
widgetHelper.setNormalRewardItem(item,0,{itemId,itemCount,showStage=true,checkAmount=true})
end

local check,rtype,tips,arg1=self:checkMake(data)
if check then
self.selectBtn:setActive(true)
self.unlockTips:setText('')
self.gotoBtn:setActive(false)
self.headRoot:setActive(false)
else
self.selectBtn:setActive(false)
self.unlockTips:setText(tips)
self.gotoBtn:setActive(rtype==3)
local showHead=rtype==1
self.headRoot:setActive(showHead)
if showHead then
local widget=self.head:getChildWidgetBase()
local dzguid=self.bdData.dizi_id
comHelper.setChildModelHeadIconBG(widget,0,dzguid)
comHelper.setChildModelRawImage(widget,dzguid,1,0,eHeadCenterType.eHead)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
self.dzLevel:setText(FMT.fmt('{0}级',arg1))
end
end
end

function UIFuLuSelectMakeWin:checkMake(data)
if not data.unlock then
local tips=UIFuLuFangModel:getUnlockTips(data.cfg)
local needItem=data.cfg.unlock[1]==2
return false,needItem and 3 or 2,tips
end

local bd_tybe_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
local skill_id=bd_tybe_cfg.pro_skill_id
local level=UIDiscipleModel:getDiscipleJobLevel(self.bdData.dizi_id,skill_id)
if level<data.cfg.need_fl_lvl then
local tips=FMT.fmt('弟子符箓等级须达到{0}级',data.cfg.need_fl_lvl)
return false,1,tips,level
end

return true
end





function UIFuLuSelectMakeWin:onSelectBtn()
local data=self.datas[self.selectIndex+1]
UIManager:callWindowFunc('UIFuLuMixWin','refreshPanelState',{FULU_TAB_TYPE.eXianLu,data.cfg})
oneTabScreenController:closeUI()
end

function UIFuLuSelectMakeWin:onGotoBtn()
local data=self.datas[self.selectIndex+1]
local args=self.args
args.selectItem=data.id
local exArgs={
jumpCB=function()
tempDataControl:recordWinData('UIFuLuMixWin',args)
end
}
gainControl:showGainWin(data.cfg.unlock[2][1][1],nil,exArgs)
end



