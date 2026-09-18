







def_class("UIXZSWuDaoTangSelectWin",UIWindowBase)









function UIXZSWuDaoTangSelectWin:bindComponents()

self.selectGrid=UIObject.get(self,0)
self.roleListPanel=UIObject.get(self,1)
self.costNumTxt=UIText.get(self,2)
self.needNumTxt=UIText.get(self,3)
self.timeTxt=UIText.get(self,4)
self.discipleNum=UIText.get(self,5)
self.costIcon=UIImage.get(self,6)
self.commitBtn=UIButton.get(self,7)
self.tipsTxt=UIText.get(self,8)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIXZSWuDaoTangSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.selectGrid);self.selectGrid=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.costNumTxt);self.costNumTxt=nil;
_UIObject_release(self.needNumTxt);self.needNumTxt=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.discipleNum);self.discipleNum=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
end
















local maxMan=3
local lock_str='建筑{0}级解锁'


function UIXZSWuDaoTangSelectWin:onLoaded(...)
self:bindComponents()
local onDisciplClick_=function(...)
self:onDisciplClick(...)
end
self.roleListPanel:setChildScrollViewInit(-1,true,onDisciplClick_,nil)
end


function UIXZSWuDaoTangSelectWin:__delete()
self:unbindComponents()
end


function UIXZSWuDaoTangSelectWin:onHide()

end

function UIXZSWuDaoTangSelectWin:refreshAfterItemUse(...)
self:refreshCostView()
end




function UIXZSWuDaoTangSelectWin:onShow(argtable,afterOnloaded)
local entityID=argtable.entityID
self.parentWin=argtable.parentWin
self.sfId=mapIdType.zhufeng
self.bdData=zongmenModel:findBuildingByEntityId(entityID)
self.buildLv=self.bdData.level
self.curPlanIndex=argtable.curPlanIndex
self.chooselist=argtable.chooselist

if self.selectWidgets==nil then
self.selectWidgets={}
local grid=self.selectGrid:getChildCommonLayoutGroupWidgetList()
local c=grid.Count
for i=1,c do
self.selectWidgets[i]=grid[i-1]
end
end
self:getPlanList()
self:refreshSelectPlanGrid()
self.curSelectLookup={}
if self.chooselist then
for k,v in ipairs(self.chooselist)do
local discipleguidStr=tostring(v)
self.curSelectLookup[discipleguidStr]=true
end
end
self:refreshDiscipleGrid()

self:refreshCostView()
self:refreshDiscipleNum()
end


function UIXZSWuDaoTangSelectWin:getPlanList()
self.planlist={}
local checkSelect=self.curPlanIndex==nil
local buildLv=self.buildLv
local cfgs=cfg_wudaotangplanconfig()
for i,cfg in ipairs(cfgs)do
self.planlist[i]=cfg
if checkSelect then
local planid=cfg.id
local lockLv=wudaotangModel:getLocakBuildLv(planid)
local isopen=buildLv>=lockLv
if isopen and self:getDZFixNum(planid)>0 then
self.curPlanIndex=i
end
end
end
if self.curPlanIndex==nil then
self.curPlanIndex=1
end
end

function UIXZSWuDaoTangSelectWin:refreshSelectPlanGrid()
local buildLv=self.buildLv
for i,v in ipairs(self.planlist)do
local cfg=v
local widget=self.selectWidgets[i]
local planid=cfg.id
local lockLv=wudaotangModel:getLocakBuildLv(planid)
local isopen=buildLv>=lockLv

widget:SetChildCSImageIcon(1,wudaotangModel:getPlanIcon(planid),true)

widget:SetChildActive(5,not isopen)
widget:SetChildActive(7,isopen)
if isopen then

widget:SetChildText(2,cfg.name)

widget:SetChildText(3,cfg.rewarddesc)
else

widget:SetChildText(6,FMT.fmt(lock_str,lockLv))
end

widget:SetChildButtonClickWithID(4,function(idx)
self:onSelectPlan(idx)
end,i)

self:refreshSelectPlanItem(i,self.curPlanIndex==i)
end
end

function UIXZSWuDaoTangSelectWin:onSelectPlan(index)
if self.curPlanIndex==index then return end

local cfg=self.planlist[index]
local planid=cfg.id
local buildLv=self.buildLv
local lockLv=wudaotangModel:getLocakBuildLv(planid)
if buildLv<lockLv then
UIManager.error(FMT.fmt(lock_str,lockLv))
return
end

local old=self.curPlanIndex
self.curPlanIndex=index
if old then
self:refreshSelectPlanItem(old,false)
end
self:refreshSelectPlanItem(index,true)

self.curSelectLookup={}

self:refreshCostView()
self:refreshDiscipleNum()
self:refreshDiscipleGrid()
end

function UIXZSWuDaoTangSelectWin:refreshSelectPlanItem(index,isselect)
local widget=self.selectWidgets[index]
widget:SetChildActive(0,isselect)
end

function UIXZSWuDaoTangSelectWin:getCurPlanID()
local cfg=self.planlist[self.curPlanIndex]
local planid=cfg.id
return planid
end



function UIXZSWuDaoTangSelectWin:getDZFixNum(planid)
local attr6=wudaotangModel:getPointNeedAttr6(planid)
local attr6Type=attr6[1]
local needAttr6Value=attr6[2]

local list=UIDiscipleModel:getSortList()
local fixnum=0
for i,data in ipairs(list)do
local guid=data.discipleguid

local attr6Value=UIDiscipleModel:getDiscipleBaseAttr(guid,attr6Type)
local checkAttr6=attr6Value>=needAttr6Value
if not UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eWuDao,false)and
not checkAttr6 then
fixnum=fixnum+1
end
end
return fixnum
end

function UIXZSWuDaoTangSelectWin:getDiscipleList()
local planid=self:getCurPlanID()
local attr6=wudaotangModel:getPointNeedAttr6(planid)
local attr6Type=attr6[1]
local needAttr6Value=attr6[2]

local disciplelist={}
local list=UIDiscipleModel:getSortList()
for i,data in ipairs(list)do
local locData={}
locData.disciple=data
local guid=data.discipleguid

local checkFlag,cantStateType=UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eWuDao,false)
locData.checkFlag=checkFlag
locData.cantStateType=cantStateType
local attr6Value=UIDiscipleModel:getDiscipleBaseAttr(guid,attr6Type)
local checkAttr6=attr6Value>=needAttr6Value

locData.attr6Type=attr6Type
locData.attr6Value=attr6Value
locData.checkAttr6=checkAttr6

local weight=-1
if not checkAttr6 then
weight=0
end
if not checkFlag then
if cantStateType then
if not DISCIPLE_STATE_TYPE:isClientState(cantStateType)then
weight=cfgHelper.get2(cfg_disciplestateconfig_get,cantStateType,'priority_weight')
elseif cantStateType==DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty then
weight=99999
end
end
end
weight=100000-weight

local sorts={}
locData.sorts=sorts
sorts[1]=(checkFlag==true and checkAttr6)and 1 or 0
sorts[2]=attr6Value
sorts[3]=weight


if self.curSelectLookup[data.discipleguidStr]then
if(not locData.checkFlag)or(not locData.checkAttr6)then
self.curSelectLookup[data.discipleguidStr]=nil
end
end

table.insert(disciplelist,locData)
end
mathHelper.sortWeightList(disciplelist)

return disciplelist
end

function UIXZSWuDaoTangSelectWin:refreshDiscipleGrid()
self.disciplelist=self:getDiscipleList()
local dataNum=#self.disciplelist
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,4)

local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local locData=self.disciplelist[i]
local netdata=locData.disciple

local guid=netdata.discipleguid
local item=grids[i-1]

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(29,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHalf)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netdata.jingjielv)
item:SetChildText(5,lv_str)

item:SetChildActive(6,false)

local desc=FMT.fmt('{0} {1}',UIDiscipleModel:getDiscipleBaseAttrName(locData.attr6Type),locData.attr6Value)
item:SetChildText(4,desc)

local isblack=(not locData.checkFlag)or(not locData.checkAttr6)
item:SetChildActive(16,isblack)

item:SetChildActive(8,true)
local state_str
if not locData.checkFlag then
if not DISCIPLE_STATE_TYPE:isClientState(locData.cantStateType)then
state_str=DISCIPLE_STATE_TYPE:getName(locData.cantStateType)
else
state_str=UIDiscipleModel:checkDZClientStateDesc(locData.cantStateType)
end
elseif not locData.checkAttr6 then
state_str=FMT.fmt('{0}不足',UIDiscipleModel:getDiscipleBaseAttrName(locData.attr6Type))
else
state_str=UIDiscipleModel:getDiscipleStateDesc(guid,' ')
end

item:SetChildText(9,state_str)

local isselect=self.curSelectLookup[netdata.discipleguidStr]==true
self:refreshDisclpleSelectEx(item,isselect)
end
local showTips=dataNum<=0
self.tipsTxt:setActive(showTips)
if showTips then
self.tipsTxt:setText(cfgHelper.getlang('wudaotang_tips_2'))
end
end

function UIXZSWuDaoTangSelectWin:refreshDisclpleSelect(idx,isselect)
local item=self.roleListPanel:getChildScrollViewItemWidget(idx-1)
self:refreshDisclpleSelectEx(item,isselect)
end

function UIXZSWuDaoTangSelectWin:refreshDisclpleSelectEx(item,isselect)
item:SetChildActive(10,isselect)
end

function UIXZSWuDaoTangSelectWin:onDisciplClick(clicknum,index)
index=index+1
if index==0 then
return
end
local locData=self.disciplelist[index]
local netdata=locData.disciple
local guid=netdata.discipleguid

if not locData.checkAttr6 then
UIManager.error(FMT.fmt('{0}不足',UIDiscipleModel:getDiscipleBaseAttrName(locData.attr6Type)))
return
end

if not UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eWuDao,true)then
return
end

local discipleguidStr=netdata.discipleguidStr
local isselect=self.curSelectLookup[discipleguidStr]==true
if isselect then
self.curSelectLookup[discipleguidStr]=nil
else
local num=self:getSelectDiscipleNum()
if num>=maxMan then
UIManager.error('悟道人数已满')
return
end
self.curSelectLookup[discipleguidStr]=true
end
self:refreshDisclpleSelect(index,not isselect)

self:refreshDiscipleNum()
end

function UIXZSWuDaoTangSelectWin:getSelectDiscipleNum()
local num=0
for k,v in pairs(self.curSelectLookup)do
num=num+1
end
return num
end


function UIXZSWuDaoTangSelectWin:refreshCostView()
local planid=self:getCurPlanID()
local buildLv=self.buildLv

local cost=wudaotangModel:getCost(planid,buildLv)

self.costIcon:setImageIcon(moneyModel.getIconNameEx(cost[1]),true)

local cost_str
if moneyModel.checkEnoughMoney(cost[1],cost[2])then
cost_str=tostring(cost[2])
else
cost_str=string.format('<color=red>%d</color>',cost[2])
end
self.costNumTxt:setText(cost_str)

local attr6=wudaotangModel:getPointNeedAttr6(planid)
local need_str=FMT.fmt('需要{0}：{1}',UIDiscipleModel:getDiscipleBaseAttrName(attr6[1]),attr6[2])
self.needNumTxt:setText(need_str)
end

function UIXZSWuDaoTangSelectWin:refreshDiscipleNum()
local planid=self:getCurPlanID()
local buildLv=self.buildLv

self.curSelectList={}
for k,v in pairs(self.curSelectLookup)do
local netdata=UIDiscipleModel:getDiscipleData(k)
table.insert(self.curSelectList,netdata.discipleguid)
end
local time=-1
if#self.curSelectList>0 then
time=wudaotangModel:getPlanNeedTime(planid,buildLv,self.curSelectList)
time=math.ceil(time)
end
local time_str
if time<0 then
time_str='--'
else
time_str=FMT.fmt('约{0}',timeHelper.format_time_stamp13(time))
end
self.timeTxt:setText(time_str)

local cur=self:getSelectDiscipleNum()
local max=maxMan
local color_str
local btnGray=false
if cur<=0 then
btnGray=true
color_str='<color=#c82c2cff>{0}/{1}</color>'
else
color_str='{0}/{1}'
end
local num_str=FMT.fmt(color_str,cur,max)
self.discipleNum:setText(num_str)
self.commitBtn:setGray(btnGray)
self.commitBtn:setButtonInteractable(not btnGray)
end


function UIXZSWuDaoTangSelectWin:onCommitBtn()
local planid=self:getCurPlanID()
local curSelectList=self.curSelectList
local buildLv=self.buildLv
local cost=wudaotangModel:getCost(planid,buildLv)
if not moneyModel.checkEnoughMoney(cost[1],cost[2])then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(cost[1])))
gainControl:showGainWin(cost[1])
return
end
self.parentWin:closeSelf()
UIManager:invokeUIMethod('UIXiaoZhuShou_WuDaoTang_SetupWin','callbackfreshpanel',{planid,curSelectList})
end

function UIXZSWuDaoTangSelectWin:onRewardBtn()
UIManager:showWindow('UIWuDaoBoxRewardWin')
end