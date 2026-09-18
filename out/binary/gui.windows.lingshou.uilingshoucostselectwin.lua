







def_class("UILingShouCostSelectWin",UIWindowBase)









function UILingShouCostSelectWin:bindComponents()

self.bagLine=UIObject.get(self,0)
self.blackImg=UIButton.get(self,1)
self.cndTips=UIText.get(self,2)
self.dressToggle=UIToggleButton.get(self,3)
self.Dropdown1=UIDropdownEx.get(self,4)
self.Dropdown2=UIDropdownEx.get(self,5)
self.gainPage=UIObject.get(self,6)
self.gainScrollView=UIScrollView.get(self,7)
self.Item_Label=UIText.get(self,8)
self.lingshouGrid=UIObject.get(self,9)
self.lingshouItem=UIObject.get(self,10)
self.lingshouRoot=UIObject.get(self,11)
self.noLingShouTitle=UIObject.get(self,12)
self.quickBtn=UIButton.get(self,13)
self.root=UIObject.get(self,14)

self.blackImg:setButtonClick(function()self:onBlackImg()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)



end


function UILingShouCostSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bagLine);self.bagLine=nil;
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.cndTips);self.cndTips=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.gainPage);self.gainPage=nil;
_UIObject_release(self.gainScrollView);self.gainScrollView=nil;
_UIObject_release(self.Item_Label);self.Item_Label=nil;
_UIObject_release(self.lingshouGrid);self.lingshouGrid=nil;
_UIObject_release(self.lingshouItem);self.lingshouItem=nil;
_UIObject_release(self.lingshouRoot);self.lingshouRoot=nil;
_UIObject_release(self.noLingShouTitle);self.noLingShouTitle=nil;
_UIObject_release(self.quickBtn);self.quickBtn=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this

local _costLsItemCmpIndex={
select=0,
quality=1,
head=2,
sign=3,
name=4,
fight=5,
info=6,
BG=7,
head2=8,
iconBG=9,
fightTxt=10,
headClick=11,
select2=12,
order=13,
}


function UILingShouCostSelectWin:onLoaded(...)
_this=self
self:bindComponents()
self.dressToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(...)end)
self.Dropdown2:setChangeAction(function(...)self:onDropdown2Change(...)end)
self.gainScrollView:setClickAction(function(...)self:onGainItemClick(...)end)

self.gainScrollView:bindScrollWidget(function(...)
self:fillGainData(...)
end)
notifySystem:listenNotify(notifyConfig.onDiscipleLingShouChange,self.onDiscipleLingShouChange)
end


function UILingShouCostSelectWin:__delete()
_this=nil
self:unbindComponents()
UIManager:closeWindow('UILingShouTipsWin')

notifySystem:removelistener(notifyConfig.onDiscipleLingShouChange,self.onDiscipleLingShouChange)
end


function UILingShouCostSelectWin:onHide()

end




function UILingShouCostSelectWin:onShow(argtable,afterOnloaded)
self.lsGuid=argtable.lsGuid
self.lsData=lingshouModel:getLingShouData2(self.lsGuid)
self.speType=argtable.speType


self.selectCount=argtable.selectCount
self.selectedLSGuidList=argtable.selectLSGuidList or{}


self.limitLSIDList=argtable.limitLSIDList
self.excludeLSGuidStrList=argtable.excludeLSGuidStrList
self.limitColorList=argtable.limitColorList


self.selectCallBack=argtable.selectCallBack

self.selectedLSGuidLookUp={}
if next(self.selectedLSGuidList)then
for index,lsGuid in ipairs(self.selectedLSGuidList)do
self.selectedLSGuidLookUp[tostring(lsGuid)]=lsGuid
end
end

self.produce=cfgHelper.get(cfg_lingshoubasicconfig_get,1,"produce")

self.lockRefresh=true

self.pyTypeList={0,1,2}
self.pyTypeNameList={'所有',"已培养","未培养"}

self.Dropdown1:setOption(self.pyTypeNameList)
self.pyTypeIndex=3
self.pyType=self.pyTypeList[self.pyTypeIndex]
self.Dropdown1:setValue(self.pyTypeIndex-1)

self.elementTypeList={0}
self.elementTypeNameList={'元素/所有'}
local elementTypes=ELEMENT_TYPE:getFive()
for i,v in ipairs(elementTypes)do
local elementName=ELEMENT_TYPE.getName(v)
self.elementTypeList[#self.elementTypeList+1]=v
self.elementTypeNameList[#self.elementTypeNameList+1]=elementName
end
self.Dropdown2:setOption(self.elementTypeNameList)
self.elementTypeIndex=1
self.elementType=self.elementTypeList[self.elementTypeIndex]
self.Dropdown2:setValue(self.elementTypeIndex-1)

self.lockRefresh=false

self:refreshView()

self:refreshTips()
end

function UILingShouCostSelectWin:refreshTips()

end

function UILingShouCostSelectWin:getLingShouList()
self.lslist={}
self.sortCNDList={}
local checkDress=self.dressToggle:getToggle()
local lsList=lingshouModel:getUpXueMaiSpeCostLsList(self.lsGuid,self.speType,checkDress)
if lsList==nil or next(lsList)==nil then return end
for index,lsData in ipairs(lsList)do
local add=true

local lsID=lsData.id
local lsGuidStr=lsData.guid_str


if add and self.pyType~=0 then
local isPy=lingshouModel:checkIsInitLingShou(lsData.guid)
local pyVal=isPy and 2 or 1
if self.pyType~=pyVal then
add=false
end
end


if add and self.elementType~=0 then
local element=lingshouModel:getLingShouConfig(lsID,'element')
if element~=self.elementType then
add=false
end
end


if add then
table.insert(self.lslist,lsData)
self.sortCNDList[lsGuidStr]={
isSelect=_this.selectedLSGuidLookUp[lsGuidStr]and 1 or 0,
fightVal=lingshouModel:getFightValue(lsData.guid)
}
end
end
end

function UILingShouCostSelectWin:sortLingShouList()
if#self.lslist>0 then
table.sort(self.lslist,function(lsDataA,lsDataB)
local sortCNDA=self.sortCNDList[lsDataA.guid_str]
local sortCNDB=self.sortCNDList[lsDataB.guid_str]

if sortCNDA.isSelect==sortCNDB.isSelect then
return sortCNDA.fightVal>sortCNDB.fightVal
else
return sortCNDA.isSelect>sortCNDB.isSelect
end
end)
end
end

function UILingShouCostSelectWin:refreshView()
self:getLingShouList()
self:sortLingShouList()

self:refreshLSListView()

local list=self:getQuickSelectList()
local len=#list
self.winlua:SetChildButtonEnable(self.quickBtn:getID(),len>0,len<=0)
end

function UILingShouCostSelectWin:refreshLSListView()
local num=#self.lslist
local showBagLs=#self.lslist>0
self.gainPage:setActive(not showBagLs)
self.bagLine:setActive(showBagLs)
local func=function(idx)
self:refreshLSItem(idx)
end
self.lingshouGrid:setChildLayoutGroupCreateItems(num,func)

if not showBagLs then
self:refreshGainPage()
end

self.cndTips:setActive(num<=0)
end

function UILingShouCostSelectWin:refreshGainPage()


local produce=self.produce or nil
local len=produce and#produce or 0
self.gainScrollView:freshGridsNum(len,len,1,self.initGain~=true)
self.initGain=true
end

function UILingShouCostSelectWin:fillGainData(index,widget)
local info=self.produce and self.produce[index]or nil
local jump=info and info.jump
local hasjump=jump~=nil
local unLock,err=self:checkGainUnLock(info)
local isUnlock=jump and unLock or false
widget:SetChildText(0,info.desc)
widget:SetChildActive(1,not unLock)
widget:SetChildActive(2,isUnlock)
widget:SetChildButtonClick(3,function()
if not hasjump then

return
end
if isUnlock then
jumpManager:jump(jump)
else
UIManager.error(err)
end
end,true)
end

function UILingShouCostSelectWin:checkGainUnLock(v)
local sysid=v.sysid
local lv=v.lv
if sysid then
if not systemModel.isOpen(sysid)then
return false,systemModel.getOpenTips(sysid)
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false,FMT.fmt('宗门等级不足{0}级，无法跳转',lv)
end
end
return true
end

function UILingShouCostSelectWin:refreshItemSelect(item,isselect)
item:SetChildActive(_costLsItemCmpIndex.select,isselect)
item:SetChildActive(_costLsItemCmpIndex.select2,isselect)
end


function UILingShouCostSelectWin:refreshLSItem(idx)
local item=self.lingshouGrid:getChildLayoutGroupGridItem(idx-1)
local lsData=self.lslist[idx]
local guid=lsData.guid
local guidStr=lsData.guid_str
local lscfg=lsData.cfg

local isSelect=self.selectedLSGuidLookUp[guidStr]and true or false
self:refreshItemSelect(item,isSelect)


comHelper.setChildModelHeadIconBGByColor(item,_costLsItemCmpIndex.quality,lingshouModel.getColorEx(lsData))

comHelper.setChildModelRawImage_lingshou(item,lsData.id,_costLsItemCmpIndex.head,0,eHeadCenterType.eHead,1)

local showSign=lscfg.bianyi==1
item:SetChildActive(_costLsItemCmpIndex.sign,showSign)

item:SetChildText(_costLsItemCmpIndex.name,lsData.name)

local desc_str=nil

local showDesc=desc_str~=nil
item:SetChildActive(_costLsItemCmpIndex.fight,not showDesc)
item:SetChildActive(_costLsItemCmpIndex.info,showDesc)
item:SetChildText(_costLsItemCmpIndex.fightTxt,lingshouModel:getFightValue(guid))
item:SetChildActive(_costLsItemCmpIndex.order,lsData.follow_level and lsData.follow_level>0)

item:SetChildButtonClick(_costLsItemCmpIndex.BG,function()
_this:onItemClick(idx)
end,true)
item:SetChildButtonClick(_costLsItemCmpIndex.headClick,function()
_this:showLingShouTips(idx)
end,true)

local netData=UIDiscipleModel:checkHasLingShouDZ(guid)
local showDZ=netData~=nil
item:SetChildActive(_costLsItemCmpIndex.iconBG,showDZ)
if showDZ then
comHelper.setChildModelRawImage(item,netData.discipleguid,_costLsItemCmpIndex.head2,0,eHeadCenterType.eHead)
end
end

function UILingShouCostSelectWin:showLingShouTips(idx)

local lsData=self.lslist[idx]
local dis_guid=UIDiscipleModel:checkHasLingShouDZ(lsData.guid)

local fromType=TIPS_FORM_TYPE.eNone

local tipswin=UIManager:findActiveWindow('UILingShouTipsWin')
if tipswin~=nil then
tipswin:onSelectLS(lsData.guid,fromType,nil)
else
UIManager:showWindow('UILingShouTipsWin',{ls_guid=lsData.guid,dzOwner=dis_guid,fromType=fromType,blackImgAlpha=0,offsetx=200})
end
end

local _clickCheckType={
eState=1,
eBianYi=2,
eNoneInit=3,
eFull=4,
eFollow=5,
}

function UILingShouCostSelectWin:onItemClick(idx,checkList)

checkList=checkList or{}

local item=self.lingshouGrid:getChildLayoutGroupGridItem(idx-1)
local lsData=self.lslist[idx]

local lsID=lsData.id
local guid=lsData.guid
local guidStr=lsData.guid_str

local isSelect=self.selectedLSGuidLookUp[guidStr]and true or false

local nowCount=table.numsEx(self.selectedLSGuidLookUp)

if not isSelect then

if checkList[_clickCheckType.eFull]==nil then
if nowCount+1>self.selectCount then
UIManager.info("灵兽已达最大数量")
return
end
checkList[_clickCheckType.eFull]=1
end

if checkList[_clickCheckType.eBianYi]==nil then
local bianyiFlag=lingshouModel:getLingShouConfig(lsID,'bianyi')
if bianyiFlag==1 then
local content="变异灵兽十分稀有，是否放入？"
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
allowclickBG=true,
showclosebtn=true,
okcallback=function(...)

checkList[_clickCheckType.eBianYi]=1
_this:onItemClick(idx,checkList)
end,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
return
end
checkList[_clickCheckType.eBianYi]=1
end

if checkList[_clickCheckType.eFollow]==nil then
if lsData.follow_level and lsData.follow_level==1 then
local content="灵兽已被关注，是否继续放入？"
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
allowclickBG=true,
showclosebtn=true,
okcallback=function(...)
checkList[_clickCheckType.eFollow]=1
_this:onItemClick(idx,checkList)
end,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
return
end
checkList[_clickCheckType.eFollow]=1
end

if checkList[_clickCheckType.eState]==nil then
local state=lingshouModel:getHighestStateType(guid)
if state~=eLingShouStateType.petFree then
lingshouModel:removeLingShouResponsbility(guid,function()
if _this==nil then return end
_this:refreshView()
end)
return
else
checkList[_clickCheckType.eState]=1
end
end

if checkList[_clickCheckType.eNoneInit]==nil then
local isInit=lingshouModel:checkIsInitLingShou(guid)
if not isInit then
local onlyJJ=lingshouModel:checkIsInitLingShou_onlyJingJie(guid)
if onlyJJ then
local content="<color='#ca6b37'>此灵兽的境界已培养过，是否继续放入</color>"
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
allowclickBG=true,
showclosebtn=true,
okcallback=function(...)
checkList[_clickCheckType.eNoneInit]=1
_this:onItemClick(idx,checkList)
end,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
local content="<color='#ca6b37'>已培养过血脉、主动技能、潜力值的灵兽无法放入，是否前往传功？</color>"
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='前往传功',
canceltext='取消',
allowclickBG=true,
showclosebtn=true,
okcallback=function(...)
local buildID=SLG_SYSTEM_TYPE.eChuanGongGe
if not zongmenModel:haveBuildByBuildId(buildID)then
UIManager.error("尚未建造传功阁")
return
end
if not systemModel.isOpen(SYSTEM_DEFINE.eLingShouChuangGong)then



return
end

jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eChuanGongGe,tabType=FULL_TAB_TYPE.eLingShouChuanGong}})
end,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end
return
end
checkList[_clickCheckType.eNoneInit]=1
end

end

if not isSelect then
self.selectedLSGuidLookUp[guidStr]=guid
nowCount=nowCount+1
else
self.selectedLSGuidLookUp[guidStr]=nil
nowCount=nowCount-1
end

self:refreshItemSelect(item,not isSelect)

if self.selectCallBack then
local list={}
if nowCount>0 then
for guidStr,guid in pairs(self.selectedLSGuidLookUp)do
list[#list+1]=guid
end
end
self.selectCallBack(list)
end
end

function UILingShouCostSelectWin:onToggleChanged(name,isToggle,data)

self:getLingShouList()
self:sortLingShouList()
self:refreshLSListView()
self:refreshTips()
end

function UILingShouCostSelectWin:onDropdownChange(idx)

if self.lockRefresh then return end
idx=idx+1
if self.pyTypeIndex==idx then return end
self.pyTypeIndex=idx
self.pyType=self.pyTypeList[idx]

self:refreshView()
end

function UILingShouCostSelectWin:onDropdown2Change(idx)

if self.lockRefresh then return end
idx=idx+1
if self.elementTypeIndex==idx then return end
self.elementTypeIndex=idx
self.elementType=self.elementTypeList[idx]

self:refreshView()
end

function UILingShouCostSelectWin:onBlackImg()
self:closeSelf()
end

function UILingShouCostSelectWin:checkCanSelectCost(lsData,qList)

local guidStr=lsData.guid_str
if self.selectedLSGuidLookUp[guidStr]then
return true
end

local nowCount=#qList
if nowCount+1>self.selectCount then
return false
end

if lsData.follow_level and lsData.follow_level>0 then
return false
end

local state=lingshouModel:getHighestStateType(lsData.guid)
if state~=eLingShouStateType.petFree then
return false
end

local lsID=lsData.id
local bianyiFlag=lingshouModel:getLingShouConfig(lsID,'bianyi')
if bianyiFlag==1 then
return false
end

local isInit=lingshouModel:checkIsInitLingShou(lsData.guid)
if not isInit then
return false
end

return true
end

function UILingShouCostSelectWin:onGainItemClick(id,index,guid,attach)








end

function UILingShouCostSelectWin:getQuickSelectList()
local list={}
for index,lsData in ipairs(self.lslist)do
local state=self:checkCanSelectCost(lsData,defaultT)
if state then
list[#list+1]=lsData
end
end
return list
end

function UILingShouCostSelectWin:onQuickBtn()

local list={}
local lookup={}

for index,lsData in ipairs(self.lslist)do
local state=self:checkCanSelectCost(lsData,list)
if state then
list[#list+1]=lsData.guid
lookup[lsData.guid_str]=lsData.guid
end
end

if#list>0 then
if self.selectCallBack then
self.selectCallBack(list)
end
end

self.selectedLSGuidList=list
self.selectedLSGuidLookUp=lookup
self:refreshLSListView()
end
