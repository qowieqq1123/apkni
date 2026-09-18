







def_class("UIWanLingTa_XYHL",UIWindowBase)









function UIWanLingTa_XYHL:bindComponents()

self.dzList=UILoopListView.new(self,0)
self.filterBtn=UIButton.get(self,1)
self.filterSelect_0=UIObject.get(self,2)
self.filterSelect_1=UIObject.get(self,3)
self.filterSelect_2=UIObject.get(self,4)
self.filterSelect_3=UIObject.get(self,5)
self.filterSelect_4=UIObject.get(self,6)
self.filterSelect_5=UIObject.get(self,7)
self.root=UIObject.get(self,8)

self.dzList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.filterBtn:setButtonClick(function()self:onFilterBtn()end)
self.filterSelect={
[0]=self.filterSelect_0,
[1]=self.filterSelect_1,
[2]=self.filterSelect_2,
[3]=self.filterSelect_3,
[4]=self.filterSelect_4,
[5]=self.filterSelect_5,
}



end


function UIWanLingTa_XYHL:unbindComponents()
local _UIObject_release=UIObject.release
self.dzList:deleteSelf();self.dzList=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.filterSelect_0);self.filterSelect_0=nil;
_UIObject_release(self.filterSelect_1);self.filterSelect_1=nil;
_UIObject_release(self.filterSelect_2);self.filterSelect_2=nil;
_UIObject_release(self.filterSelect_3);self.filterSelect_3=nil;
_UIObject_release(self.filterSelect_4);self.filterSelect_4=nil;
_UIObject_release(self.filterSelect_5);self.filterSelect_5=nil;
_UIObject_release(self.root);self.root=nil;
self.filterSelect=nil;
end


















local _dzItemCmp={
name=0,
dzModel=1,
tmIcon1=2,
tmIcon2=3,
tmIcon3=4,
tmIcon={2,3,4},
notHave=5,
click=6,
reddot=7,
}
local this

function UIWanLingTa_XYHL:onLoaded(...)
self:bindComponents()
this=self
self.type=eWanLingTaShowcaseType.eXYHL
self:addNotify(notifyConfig.onWanLingTaTuJianChange,self.onWanLingTaTuJianChange)

self.dzListViewCmp=self.winlua:GetChildLoopListView2(self.dzList:getID())
self.filterSpeType=0
self.config=cfg_xumitaxyhlconfig()
end


function UIWanLingTa_XYHL:__delete()
self:unbindComponents()
this=nil
end




function UIWanLingTa_XYHL:onShow(argtable,afterOnloaded)
if argtable and argtable.showAnim then
self.root:setChildAnchoredPos(0,-800)
local tween=self.root:setChildDOAnchorPosY(0,2)
tween:SetEase(_Ease.Linear)
UIManager:invokeUIMethod("UIWanLingTaBgWin","moveAnim")
else
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
self:refreshDiscipleList(true)
self:refreshFilterSelect()
end

function UIWanLingTa_XYHL.onWanLingTaTuJianChange(tjId,tjLevel)
if not this then return end
local dataIndex=this.tjId2IdxLookup[tjId]
if dataIndex then
local widget=this.dzList:getListViewItemWidgetByDataIndex(dataIndex)

local reddot=wanLingTaModel:checkTuJianReddot(tjId)
widget:SetChildActive(_dzItemCmp.reddot,reddot)
end

end

function UIWanLingTa_XYHL:refreshFilterSelect()
for i,v in pairs(self.filterSelect)do
v:setActive(i==self.filterSpeType)
end
end

function UIWanLingTa_XYHL:checkFilterDiscipleSpeRoot(dzId)
if self.filterSpeType==0 then
return true
end
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzId)
for i1,v1 in ipairs(dzData.specialityList)do
if v1.specialityLst and v1.specialitytype==1 then
for _,spe in ipairs(v1.specialityLst)do
if spe.param_1==self.filterSpeType then
return true
end
end
end
end
return false
end

function UIWanLingTa_XYHL:checkFilterDisciple(dzId)
if self.filterCondition==nil then
return true
end
local filterCondition=self.filterCondition
local add=true
if filterCondition[1]~=nil and#filterCondition[1]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[1])do
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzId)
local job=dzData.imageInfo.job
if job==v1 then
addx=true
break
end
end
add=add and addx
end
return add
end

function UIWanLingTa_XYHL:refreshDiscipleList(init)
self.tjId2IdxLookup={}
self.cfgData={}
for id,v in pairs(self.config)do
local dzId=v.needItem
if self:checkFilterDiscipleSpeRoot(dzId)and self:checkFilterDisciple(dzId)then
local show=true
if v.activeShow then
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzId)
if not dzData then
show=false
end
end
if show then
local dzId=v.needItem
local datas={id=v.id,dzId=dzId}
if UIDiscipleModel:isSPDisciple(dzId)then
local data=cfgHelper.get1(cfg_discipleconfig_get,dzId)
local switchDzId=data.switch[1]
datas.switchDzId=switchDzId
datas.spDzId=dzId
datas.isSwitching=false
end
table.insert(self.cfgData,datas)
end
end
end
table.sort(self.cfgData,function(a,b)
return a.id<b.id
end)
if init then
self.jumpIdx=nil
end
for idx,v in ipairs(self.cfgData)do
self.tjId2IdxLookup[v.id]=idx
end
self.dzList:initData('dzItem',self.cfgData,#self.cfgData)
end

function UIWanLingTa_XYHL:onFreshAction(dataIndex,widget,data)
local tjId=data.id
local dzId=data.dzId
local hasDZ=true
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzId)
local dzCfgData=UIDiscipleModel:getDiscipleDataByDiziId(dzId)
if not dzData then
hasDZ=false
dzData=dzCfgData
end
local imageInfo=dzCfgData.imageInfo
local args={bgFisrt=true}
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo,args)
widget:SetChildUIModelRemoveTarget(_dzItemCmp.dzModel)
comHelper.setChildInSideModel3(widget,modelParams,_dzItemCmp.dzModel,0.85,nil,0,0,false,false,nil)


local dzName=dzData.disciplename
widget:SetChildText(_dzItemCmp.name,dzName)

local dzNowTmLv=dzData.tmlv or-1
local chong=UIDiscipleModel.getTianMingLevelChong(dzNowTmLv)
local floor=UIDiscipleModel.getTianMingLevelFloor(dzNowTmLv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
for i,cmp in ipairs(_dzItemCmp.tmIcon)do
if chong>=i then
widget:SetChildActive(cmp,true)
widget:SetChildCSImageSprite(cmp,abName,iconName)
else
widget:SetChildActive(cmp,false)
end
end

widget:SetChildActive(_dzItemCmp.notHave,not hasDZ)

widget:SetChildButtonClick(_dzItemCmp.click,function()
if self and not self.isClose then
self:onClickDz(dataIndex,tjId)
end
end)

local reddot=wanLingTaModel:checkTuJianReddot(tjId)
widget:SetChildActive(_dzItemCmp.reddot,reddot)
if reddot and self.jumpIdx==nil then
self.jumpIdx=dataIndex
self.dzList:jumpItem(self.jumpIdx)
end
end

function UIWanLingTa_XYHL:onClickDz(dataIndex,tjId)
self:showWindow("UIWanLingTaDiscipleInfoWin",{data=self.cfgData,index=dataIndex})
end

function UIWanLingTa_XYHL:onStartAction()

end

function UIWanLingTa_XYHL:getFilterData(isReset)
if self.filterName==nil then
local c=1
local filterName={}
filterName[c]={}
filterName[c][1]='职业'
filterName[c][2]={}
local jobcfgs=cfg_disciplevocationconfig()
for k,v in pairs(jobcfgs)do
if v.id~=nil and not v.hide then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
end
end

self.filterName=filterName
end

if isReset or self.filterFlag==nil then
self.filterFlag={}
for i,v in ipairs(self.filterName)do
self.filterFlag[i]={}
for ii,_ in pairs(v[2])do
self.filterFlag[i][ii]=false
end
end
end

return self.filterName,self.filterFlag
end

function UIWanLingTa_XYHL:onFilterBtn()
local filterName,filterFlag=self:getFilterData()
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')

args.extraWin='UIFilterThreeWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selectConditionBack}
args.extraParams=extraParams
self:showWindow('UICommonPageTwoWin',args)
end

function UIWanLingTa_XYHL.selectConditionBack(data)
if this==nil then
return
end
this.filterFlag=data.filterFlag
this.filterCondition={}
for i,v in ipairs(data.filterFlag)do
this.filterCondition[i]={}
local fns=this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(this.filterCondition[i],fns[i1].typeid)
end
end
end
this:refreshDiscipleList()
end

function UIWanLingTa_XYHL:OnFilterType(type)
if self.filterSpeType~=type then
self.filterSelect[self.filterSpeType]:setActive(false)
self.filterSpeType=type
self.filterSelect[self.filterSpeType]:setActive(true)
self:refreshDiscipleList()
end
end
