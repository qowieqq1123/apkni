







def_class("UIXiaoZhuShou_WuDaoTang_SetupWin",UIWindowBase)









function UIXiaoZhuShou_WuDaoTang_SetupWin:bindComponents()

self.root=UIObject.get(self,0)
self.selectType_1=UIObject.get(self,1)
self.selectType_2=UIObject.get(self,2)
self.selectType_3=UIObject.get(self,3)
self.qdbtn=UIButton.get(self,4)
self.Item1=UIButton.get(self,5)
self.Item2=UIButton.get(self,6)
self.Item3=UIButton.get(self,7)
self.changebtn=UIButton.get(self,8)
self.type1=UIButton.get(self,9)
self.type2=UIButton.get(self,10)
self.type3=UIButton.get(self,11)

self.qdbtn:setButtonClick(function()self:onQdbtn()end)

self.Item1:setButtonClick(function()self:onItem1()end)

self.Item2:setButtonClick(function()self:onItem2()end)

self.Item3:setButtonClick(function()self:onItem3()end)

self.changebtn:setButtonClick(function()self:onChangebtn()end)

self.type1:setButtonClick(function()self:onType1()end)

self.type2:setButtonClick(function()self:onType2()end)

self.type3:setButtonClick(function()self:onType3()end)
self.selectType={
self.selectType_1,
self.selectType_2,
self.selectType_3,
}



end


function UIXiaoZhuShou_WuDaoTang_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectType_1);self.selectType_1=nil;
_UIObject_release(self.selectType_2);self.selectType_2=nil;
_UIObject_release(self.selectType_3);self.selectType_3=nil;
_UIObject_release(self.qdbtn);self.qdbtn=nil;
_UIObject_release(self.Item1);self.Item1=nil;
_UIObject_release(self.Item2);self.Item2=nil;
_UIObject_release(self.Item3);self.Item3=nil;
_UIObject_release(self.changebtn);self.changebtn=nil;
_UIObject_release(self.type1);self.type1=nil;
_UIObject_release(self.type2);self.type2=nil;
_UIObject_release(self.type3);self.type3=nil;
self.selectType=nil;
end
















local _this
local wudaoState={
eNone=1,
eDoing=2,
eRewrad=3,
}



function UIXiaoZhuShou_WuDaoTang_SetupWin:onLoaded(...)
self:bindComponents()
self.Itemlist={self.Item1,self.Item2,self.Item3}
self.typelist={self.type1,self.type2,self.type3}
self.curSelectList={}
self.WinsetupData={}
self.selectdzlist={}
_this=self
end


function UIXiaoZhuShou_WuDaoTang_SetupWin:__delete()
self:unbindComponents()
_this=nil
end

function UIXiaoZhuShou_WuDaoTang_SetupWin:onType1()
self:OnEvent2(1)
end
function UIXiaoZhuShou_WuDaoTang_SetupWin:onType2()
self:OnEvent2(2)
end
function UIXiaoZhuShou_WuDaoTang_SetupWin:onType3()
self:OnEvent2(3)
end

function UIXiaoZhuShou_WuDaoTang_SetupWin:onQdbtn()

local planid=self.WinsetupData[xzsDataKey.wdtAutoshijian]
local attr6=wudaotangModel:getPointNeedAttr6(planid)
local attr6Type=attr6[1]
local needAttr6Value=attr6[2]
for k,v in ipairs(self.curSelectList)do
local attr6Value=UIDiscipleModel:getDiscipleBaseAttr(v,attr6Type)
local checkFlag,cantStateType=UIDiscipleModel:checkDZStateToDoSomething(v,eCheckDiscipleStateOpType.eWuDao,false)
local checkAttr6=attr6Value>=needAttr6Value
if(not checkFlag)or(not checkAttr6)then
local state_str="有弟子不能悟道"
if not checkFlag then
if not DISCIPLE_STATE_TYPE:isClientState(cantStateType)then
state_str=FMT.fmt("<color=#7d3b17>{0}</color>{1}，不能悟道",UIDiscipleModel:getDiscipleName(v),DISCIPLE_STATE_TYPE:getName(cantStateType))
else
state_str=FMT.fmt("<color=#7d3b17>{0}</color>{1}，不能悟道",UIDiscipleModel:getDiscipleName(v),UIDiscipleModel:checkDZClientStateDesc(cantStateType)or'')
end
elseif not checkAttr6 then
state_str=FMT.fmt("<color=#7d3b17>{0}</color>{1}不足，不能悟道",UIDiscipleModel:getDiscipleName(v),UIDiscipleModel:getDiscipleBaseAttrName(attr6Type))
end
UIManager.info(state_str)
return
end
end

local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
setupData[xzsDataKey.wdtAutoshijian]=self.WinsetupData[xzsDataKey.wdtAutoshijian]or 1
setupData[xzsDataKey.wdtAutodizi1]=self.curSelectList[1]and tostring(self.curSelectList[1])or 0
setupData[xzsDataKey.wdtAutodizi2]=self.curSelectList[2]and tostring(self.curSelectList[2])or 0
setupData[xzsDataKey.wdtAutodizi3]=self.curSelectList[3]and tostring(self.curSelectList[3])or 0
UIManager.info('设置成功')

UIManager:invokeUIMethod('UIXiaoZhuShouWin','onOkBtn')
end

function UIXiaoZhuShou_WuDaoTang_SetupWin:onChangebtn()
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eWuDaoTang)then
return false
end
local arg=
{
curPlanIndex=self.curPlanIndex,
entityID=self.entityID,
chooselist=self.curSelectList,
curPlanIndex=self.WinsetupData[xzsDataKey.wdtAutoshijian]
}
local winParams={
titleName='选择弟子',
extraWin='UIXZSWuDaoTangSelectWin',
extraParams=arg,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end


function UIXiaoZhuShou_WuDaoTang_SetupWin:getPlanList()
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
function UIXiaoZhuShou_WuDaoTang_SetupWin:getDZFixNum(planid)
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




function UIXiaoZhuShou_WuDaoTang_SetupWin:onShow(argtable,afterOnloaded)
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eWuDaoTang)then
logErr('悟道堂未开启')
return false
end
local data=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eWuDaoTang)
self.entityID=data[1].entityId
self.bdData=zongmenModel:findBuildingByEntityId(self.entityID)
self.buildLv=self.bdData.level
self:getPlanList()
for i,v in ipairs(self.typelist)do
local lockLv=wudaotangModel:getLocakBuildLv(i)
local isopen=self.buildLv>=lockLv
v:setActive(isopen)
end


self.orderID=XIAOZHUSHU_ENUM.xzs_WuDaoTang
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
self.WinsetupData[xzsDataKey.wdtAutoshijian]=setupData[xzsDataKey.wdtAutoshijian]or self.curPlanIndex
self.WinsetupData[xzsDataKey.wdtAutodizi1]=setupData[xzsDataKey.wdtAutodizi1]or 0
self.WinsetupData[xzsDataKey.wdtAutodizi2]=setupData[xzsDataKey.wdtAutodizi2]or 0
self.WinsetupData[xzsDataKey.wdtAutodizi3]=setupData[xzsDataKey.wdtAutodizi3]or 0

local dizi1=self.WinsetupData[xzsDataKey.wdtAutodizi1]
local dizi2=self.WinsetupData[xzsDataKey.wdtAutodizi2]
local dizi3=self.WinsetupData[xzsDataKey.wdtAutodizi3]
local xzsdz={dizi1,dizi2,dizi3}
self.selectdzlist={}
for k,v in ipairs(xzsdz)do
local dzguid=int64.new(v)
local netdata=UIDiscipleModel:getDiscipleData(dzguid)
if netdata then
table.insert(self.selectdzlist,netdata.discipleguid)
end
end
self.curSelectList=self.selectdzlist
self.wdState=self:getwdSatet()




self:refreshCleanupType()

self:freshwddizi()


if tonumber(setupData[xzsDataKey.wdtAutodizi1])==0 and tonumber(setupData[xzsDataKey.wdtAutodizi2])==0 and tonumber(setupData[xzsDataKey.wdtAutodizi3])==0 then
self:onDisciplClick()
UIManager.info("请选择悟道弟子")
end
end


function UIXiaoZhuShou_WuDaoTang_SetupWin:OnEvent2(idx)
if self.WinsetupData[xzsDataKey.wdtAutoshijian]~=idx then
self.WinsetupData[xzsDataKey.wdtAutoshijian]=idx
self:refreshCleanupType()
self:freshwddizi()
end
end
function UIXiaoZhuShou_WuDaoTang_SetupWin:refreshCleanupType()
local firstType=self.WinsetupData[xzsDataKey.wdtAutoshijian]
for i,v in ipairs(self.selectType)do
v:setActive(i==firstType)
end
end


function UIXiaoZhuShou_WuDaoTang_SetupWin:onDisciplClick(dzguid)
local arg=
{
curPlanIndex=self.curPlanIndex,
entityID=self.entityID,
chooselist=self.curSelectList,
curPlanIndex=self.WinsetupData[xzsDataKey.wdtAutoshijian]
}
local winParams={
titleName='选择弟子',
extraWin='UIXZSWuDaoTangSelectWin',
extraParams=arg,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end

function UIXiaoZhuShou_WuDaoTang_SetupWin:freshwddizi()
local planid=self.WinsetupData[xzsDataKey.wdtAutoshijian]
local attr6=wudaotangModel:getPointNeedAttr6(planid)
local attr6Type=attr6[1]
local needAttr6Value=attr6[2]

for k,v in ipairs(self.Itemlist)do
local item=v:getChildWidgetBase()
item:SetChildActive(29,true)
item:SetChildActive(30,false)
local guid=self.curSelectList[k]
if guid then
local netdata=UIDiscipleModel:getDiscipleData(guid)
if netdata then
item:SetChildActive(30,true)


local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(31,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHalf)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netdata.jingjielv)
item:SetChildText(5,lv_str)

item:SetChildActive(6,false)

local attr6Value=UIDiscipleModel:getDiscipleBaseAttr(guid,attr6Type)
local checkFlag,cantStateType=UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eWuDao,false)
local checkAttr6=attr6Value>=needAttr6Value
local desc=FMT.fmt('{0} {1}',UIDiscipleModel:getDiscipleBaseAttrName(attr6Type),attr6Value)
item:SetChildText(4,desc)

local isblack=(not checkFlag)or(not checkAttr6)
item:SetChildActive(16,isblack)

item:SetChildActive(8,true)
local state_str
if not checkFlag then
if not DISCIPLE_STATE_TYPE:isClientState(cantStateType)then
state_str=DISCIPLE_STATE_TYPE:getName(cantStateType)
else
state_str=UIDiscipleModel:checkDZClientStateDesc(cantStateType)
end
elseif not checkAttr6 then
state_str=FMT.fmt('{0}不足',UIDiscipleModel:getDiscipleBaseAttrName(attr6Type))
else
state_str=UIDiscipleModel:getDiscipleStateDesc(guid,' ')
end
item:SetChildText(9,state_str)


item:SetChildActive(29,false)
end
end


item:SetChildButtonClick(-1,function()
if _this==nil then return end
self:onDisciplClick(guid)
end)
end
end


function UIXiaoZhuShou_WuDaoTang_SetupWin:callbackfreshpanel(arg)

_this:freshpanel(arg)
end
function UIXiaoZhuShou_WuDaoTang_SetupWin:freshpanel(arg)
self.WinsetupData[xzsDataKey.wdtAutoshijian]=arg[1]
self.curSelectList=arg[2]
self:refreshCleanupType()
self:freshwddizi()
end

function UIXiaoZhuShou_WuDaoTang_SetupWin:getwdSatet()
if not wudaotangModel:hasPlan()then
return wudaoState.eNone
end
local buildLv=self.bdData.level
if wudaotangModel:checkHasReward(buildLv)then
return wudaoState.eRewrad
end
return wudaoState.eDoing
end


function UIXiaoZhuShou_WuDaoTang_SetupWin:ishaveDZlist()
if _this.curSelectList and next(_this.curSelectList)then
return true
else
return false
end
end
