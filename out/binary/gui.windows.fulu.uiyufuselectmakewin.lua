







def_class("UIYuFuSelectMakeWin",UIWindowBase)









function UIYuFuSelectMakeWin:bindComponents()

self.stageScrollView=UIObject.get(self,0)
self.cbScrollview=UIObject.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.time=UIText.get(self,3)
self.head=UIBaseItem.get(self,4)
self.comboBox=UIObject.get(self,5)
self.scrollview=UIObject.get(self,6)
self.icon=UIObject.get(self,7)
self.name=UIText.get(self,8)
self.des=UIText.get(self,9)
self.nAttr=UIText.get(self,10)
self.rAttr=UIText.get(self,11)
self.rwScrollView=UIObject.get(self,12)
self.selectBtn=UIButton.get(self,13)
self.unlockTips=UIText.get(self,14)
self.gotoBtn=UIButton.get(self,15)
self.headRoot=UIObject.get(self,16)
self.dzLevel=UIText.get(self,17)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIYuFuSelectMakeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.stageScrollView);self.stageScrollView=nil;
_UIObject_release(self.cbScrollview);self.cbScrollview=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.comboBox);self.comboBox=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.des);self.des=nil;
_UIObject_release(self.nAttr);self.nAttr=nil;
_UIObject_release(self.rAttr);self.rAttr=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.unlockTips);self.unlockTips=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.headRoot);self.headRoot=nil;
_UIObject_release(self.dzLevel);self.dzLevel=nil;
end
















local _this




function UIYuFuSelectMakeWin:onLoaded(...)
self:bindComponents()

_this=self

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_select,nil)

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.comboBox:setChildComboBoxInit(self.on_combobox_change,nil,self.on_combobox_change_check)


UIFuLuFangModel:clearNewUnlockData(FULU_TAB_TYPE.eFuBao)

self.checkList={}
self.on_money_changed=function(mtype,last,curr)
if self.checkList[mtype]then
self:refreshRightPanel()
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIYuFuSelectMakeWin:__delete()
self:unbindComponents()

_this=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end

function UIYuFuSelectMakeWin.on_item_select(cnum,index)
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

function UIYuFuSelectMakeWin.on_stage_select(cnum,index)
local datas=_this.stageDatas[index+1]
if not datas.unlock then
UIManager.error(FMT.fmt('需宗门达到{0}级',datas.unlockLevel))
return
end
if _this.selectStage==index then
return
end
if _this.selectStage then
local widget=_this.stageScrollView:getChildScrollViewItemWidget(_this.selectStage)
widget:SetChildActive(1,false)
end

_this.selectStage=index

local widget=_this.stageScrollView:getChildScrollViewItemWidget(_this.selectStage)
widget:SetChildActive(1,true)

_this.datas=datas
_this.selectIndex=nil
_this:setItemList()
_this.on_item_select(1,0)
end

function UIYuFuSelectMakeWin.on_combobox_change_check(index)
local id=#_this.stageDatas-index

local datas=_this.stageDatas[id]
if not datas.unlock then
UIManager.error(FMT.fmt('需宗门达到{0}级',datas.unlockLevel))
return false
end

return true
end

function UIYuFuSelectMakeWin.on_combobox_change(index)
local id=#_this.stageDatas-index

local datas=_this.stageDatas[id]





if _this.selectStage==id then
return
end

_this.selectStage=id

_this.datas=datas
_this.selectIndex=nil
_this:setItemList()
local sel=_this.selIndex or 0
_this.on_item_select(1,sel)
end




function UIYuFuSelectMakeWin:onShow(argtable,afterOnloaded)
local args=tempDataControl:getWinData('UIFuLuMixWin')or argtable
self.args=args
self.pData=args.pData
self.bdData=zongmenModel:getBuildingData(args.ubdId)

self:setStageComboBox(args.selectItem)

end

function UIYuFuSelectMakeWin:getSelectParam(selectItem)
for i,v in ipairs(self.stageDatas)do
for ii,vv in ipairs(v)do
if vv.id==selectItem then
return i,ii-1
end
end
end
end


function UIYuFuSelectMakeWin:onHide()

end

function UIYuFuSelectMakeWin:setStageComboBox(selectItem)
self.stageDatas=self:getDatas()
if selectItem then
self.selStage,self.selIndex=self:getSelectParam(selectItem)
end
local option={}
for i,v in ipairs(self.stageDatas)do
if v.stage==0 then
table.insert(option,'所有')
else
table.insert(option,FMT.fmt('{0}阶',v.stage))
end
end
option=table.reverse(option)
local top=#option-1
local sel=self.selStage and(#option-self.selStage)or top
self.comboBox:setChildComboBoxOption(sel,option)

for i=0,top do
local data=self.stageDatas[top-i+1]
local widget=self.cbScrollview:getChildScrollViewItemWidget(i)
widget:SetChildGraphicGray(-1,not data.unlock,true)
widget:SetChildActive(2,not data.unlock)
end
end

function UIYuFuSelectMakeWin:setStageList()
self.stageDatas=self:getDatas()
local len=#self.stageDatas
self.stageScrollView:setChildScrollViewCreateGrids(len,0)
self.grids=self.stageScrollView:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=self.stageDatas[i]
if data.stage==0 then
item:SetChildText(0,"所有")
else
item:SetChildText(0,FMT.fmt('{0}阶',data.stage))
end
item:SetChildActive(1,false)
item:SetChildActive(2,not data.unlock)
end
end

function UIYuFuSelectMakeWin:getAttr(itemCfg,id)
for i,v in ipairs(itemCfg.static)do
if v[1]==id then
return v
end
end
end

function UIYuFuSelectMakeWin:getBaseAttrStr(cfg)
local items=cfg.random_item_conf
local itemCfgA=itemsConfig.getConfig(items[1])
local itemCfgB=itemsConfig.getConfig(items[2])
local attrList={}
for i,v in ipairs(itemCfgA.static)do
local vv=self:getAttr(itemCfgB,v[1])
attrList[i]={v[1],v[2]*v[4],vv[3]*vv[4]}
end
local str
for i,v in ipairs(attrList)do
local name=helper.getAttributeName(v[1])
local attr=FMT.fmt('<color=#7d3b17>{0}</color>：{1}~{2}',name,v[2],v[3])
if str then
str=FMT.fmt('{0}\n{1}',str,attr)
else
str=attr
end
end
return str
end

function UIYuFuSelectMakeWin:getEquipCondition(cfg)
local items=cfg.random_item_conf
local itemCfg=itemsConfig.getConfig(items[1])
local cnd=itemCfg.wear_conditions[1]
if cnd[1]==1 then
local n,p,pN=UIDiscipleModel:getJJNameX(cnd[2])
local des=FMT.fmt('<color=#7d3b17>穿戴要求</color>：{0}期',n)
return des
end
end

function UIYuFuSelectMakeWin:refreshRightPanel()
local data=self.datas[self.selectIndex+1]
self.name:setText(data.cfg.name)
self.des:setText(self:getEquipCondition(data.cfg))

self.icon:setChildIcon(iconHelper.getIconName(data.cfg.itemId),true)
self.nAttr:setText(self:getBaseAttrStr(data.cfg))
self.rAttr:setText(data.cfg.random_attr_desc or'')

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
widgetHelper.setNormalRewardItem(item,0,{itemId,itemCount,itemCountshowStage=true,checkAmount=true})
end

local check,rtype,tips,arg1=self:checkMake(data)
if check then
self.selectBtn:setActive(true)
self.unlockTips:setText('')
self.gotoBtn:setActive(false)
self.headRoot:setActive(false)
self.time:setText(FMT.fmt('{0}秒',data.cfg.lz_time))
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

function UIYuFuSelectMakeWin:checkMake(data)
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

function UIYuFuSelectMakeWin:getDatas()
local cfgs=cfg_yufufangconfig()
local list={}
for k,v in pairs(cfgs)do
if k~='const_def'then
local unlock=UIFuLuFangModel:isYuFuUnlock(v.id)
if unlock or not v.lock_hide then
local cfg=itemsConfig.getConfig(v.itemId)
local isRed=UIFuLuFangModel:checkCanMakeItem(v,self.bdData)
local sortWeight=v.id
if unlock then
sortWeight=sortWeight+100000+cfg.stage*1000
if isRed then
sortWeight=sortWeight+10000
end
else
sortWeight=sortWeight-cfg.stage*1000
end
table.insert(list,{id=v.id,cfg=v,unlock=unlock,isRed=isRed,sortWeight=sortWeight})
end
end
end

table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)

local slist={}
for i,v in ipairs(list)do
local cfg=itemsConfig.getConfig(v.cfg.itemId)
local st=slist[cfg.stage]or{}
table.insert(st,v)
slist[cfg.stage]=st

local stAll=slist[0]or{}
table.insert(stAll,v)
slist[0]=stAll
end

local rlist={}
for k,v in pairs(slist)do
v.stage=k
table.insert(rlist,v)
end

table.sort(rlist,function(a,b)
return a.stage<b.stage
end)

local baseCfg=cfgHelper.get1(cfg_fubaofangbasicconfig_get,1)
local level=zongmenModel:getLevel()
local check=false
local ulist={}
for i,v in ipairs(rlist)do
local stage=v.stage==0 and 1 or v.stage
local sl=baseCfg.stage_unlock[stage]
v.unlock=level>=sl
if not v.unlock then
if not check then
check=true
else
break
end
end
v.unlockLevel=sl
table.insert(ulist,v)
end

return ulist
end

function UIYuFuSelectMakeWin:setItemList()
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
local cfg=itemsConfig.getConfig(data.cfg.itemId)
item:SetChildText(3,FMT.fmt('{0}阶玉符',cfg.stage))
item:SetChildActive(4,not data.unlock)
item:SetChildActive(5,data.isRed)
item:SetChildGraphicGray(-1,not data.unlock,true)
end
end





function UIYuFuSelectMakeWin:onSelectBtn()
local data=self.datas[self.selectIndex+1]
UIManager:callWindowFunc('UIFuLuMixWin','refreshPanelState',{FULU_TAB_TYPE.eFuBao,data.cfg})
oneTabScreenController:closeUI()
end

function UIYuFuSelectMakeWin:onGotoBtn()
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

function UIYuFuSelectMakeWin:onHelpBtn()
local data=self.datas[self.selectIndex+1]
local sargs={
pos={79,-49},
width=350,
title=FMT.fmt('{0}可获得以下随机属性：',data.cfg.name),
dlist=data.cfg.attr_tips,
pivot={0,1},
playScale=true,
scaleStartVal={0,1}
}
UIManager:showWindow('UICommonHelpC',sargs)
end



