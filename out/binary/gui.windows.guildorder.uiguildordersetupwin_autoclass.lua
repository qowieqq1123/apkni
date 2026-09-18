







def_class("UIGuildOrderSetupWin_autoClass",UIWindowBase)









function UIGuildOrderSetupWin_autoClass:bindComponents()

self.back=UIImage.get(self,0)
self.checkFlag=UIObject.get(self,1)
self.classLevel=UIText.get(self,2)
self.controllBtn=UIButton.get(self,3)
self.controllClose=UIObject.get(self,4)
self.controllOpen=UIObject.get(self,5)
self.desc=UIText.get(self,6)
self.dzScrollView=UIObject.get(self,7)
self.head=UIObject.get(self,8)
self.jobImg=UIImage.get(self,9)
self.name=UIText.get(self,10)
self.newImg=UIObject.get(self,11)
self.sixAttr=UIText.get(self,12)
self.slScrollView=UIObject.get(self,13)

self.controllBtn:setButtonClick(function()self:onControllBtn()end)



end


function UIGuildOrderSetupWin_autoClass:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.checkFlag);self.checkFlag=nil;
_UIObject_release(self.classLevel);self.classLevel=nil;
_UIObject_release(self.controllBtn);self.controllBtn=nil;
_UIObject_release(self.controllClose);self.controllClose=nil;
_UIObject_release(self.controllOpen);self.controllOpen=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.dzScrollView);self.dzScrollView=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.jobImg);self.jobImg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.newImg);self.newImg=nil;
_UIObject_release(self.sixAttr);self.sixAttr=nil;
_UIObject_release(self.slScrollView);self.slScrollView=nil;
end
















local itemIndex={
bg=0,
name=1,
head=2,
desc=3,
sixAttr=4,
flag=5,
level=6,
newFlag=7,
jobImg=8,
lv_obj=9,
spDzFlag=11,
}




function UIGuildOrderSetupWin_autoClass:onLoaded(...)
self:bindComponents()

local sixAttrCfg=cfgHelper.getglobal1('discipleattr')
self.sixAttrType=DISCIPLE_BASE_ATTR_TYPE.eCongHui
self.sixAttrName=sixAttrCfg[self.sixAttrType].name

self.orderID=GUILD_ORDER_TYPE.eAutoAttendClass

self.slScrollView:setChildScrollViewInit(0,true,function(...)self:onSkillClassClick(...)end,nil)
self.dzScrollView:setChildScrollViewInit(0.5,true,function(...)self:onDZListClick(...)end,nil)
end


function UIGuildOrderSetupWin_autoClass:__delete()
self:unbindComponents()
end

function UIGuildOrderSetupWin_autoClass:onSkillClassClick(num,index)
local currIndex=index+1
if self.selectIndex==currIndex then
return
end

local data=self.datas[currIndex]
local lock=zongmenModel:getLevel()<data.unlocklevel
if lock then
UIManager.error('未达到教学要求，请选择已解封的课程')
return
end

if self.selectIndex then
local item=self.slScrollView:getChildScrollViewItemWidget(self.selectIndex-1)
item:SetChildActive(0,false)
end

self.selectIndex=currIndex
local setup=guildOrderModel:getSetupData(self.orderID)
setup.selectId=data.id
guildOrderModel:flushSetupData(self.orderID)
self.diziList=UISchoolModel:getClassSelectDzDataListByClassType(setup.selectId)
self:refreshDZList(self.diziList)

local item=self.slScrollView:getChildScrollViewItemWidget(self.selectIndex-1)
item:SetChildActive(0,true)
end

function UIGuildOrderSetupWin_autoClass:onDZListClick(num,index)
if index+1>self.tableCount then
UIManager.error('当前座位尚未解锁，请升级学院')
return
end
local setup=guildOrderModel:getSetupData(self.orderID)
UIManager:showWindow('UISchoolDiscipleSelectWin',{curClass=setup.selectId,tableCount=self.tableCount,tableIdx=index,diziList=self.diziList})
end

function UIGuildOrderSetupWin_autoClass:getMaxTableNum()
local cfgs=cfg_collegearchitectureconfig()
local num=cfgs[#cfgs].sea
return num
end




function UIGuildOrderSetupWin_autoClass:onShow(argtable,afterOnloaded)
local bdData=UISchoolModel:getSchoolBDData()
self.tableCount=cfgHelper.get2(cfg_collegearchitectureconfig_get,bdData.level,'sea')
self.maxtableNum=self:getMaxTableNum()

self:refreshItemControllBtn(self.orderID,true)
self:refreshSkillList()

local setup=guildOrderModel:getSetupData(self.orderID)
local index=0
for i,v in ipairs(self.datas)do
if v.id==setup.selectId then
index=i-1
break
end
end
self:onSkillClassClick(0,index)
end


function UIGuildOrderSetupWin_autoClass:onHide()

end

function UIGuildOrderSetupWin_autoClass:refreshDZList(diziList)
local setup=guildOrderModel:getSetupData(self.orderID)
if diziList then
self.diziList=diziList
else
diziList=self.diziList or{}
self.diziList=UISchoolController:autoSelectDZ(diziList,setup.selectId,self.tableCount)
end
self.dzScrollView:setChildScrollViewCreateGrids(self.maxtableNum,0)
local grids=self.dzScrollView:getChildScrollViewItemWidgets()
local count=self.maxtableNum
for i=1,count do
local item=grids[i-1]
local guid=self.diziList[i]
self:refreshTeamGrid(item,guid,i>self.tableCount)
end
end

function UIGuildOrderSetupWin_autoClass:refreshTeamGrid(item,guid,lock)
if guid and tostring(guid)~='0'then
local cardGrid=item:GetChildWidgetBase(0)
item:SetChildActive(0,true)
item:SetChildActive(1,false)
item:SetChildActive(2,false)
self:setTeamItem(cardGrid,guid)
else
item:SetChildActive(0,false)
item:SetChildActive(1,not lock)
item:SetChildActive(2,lock)
end
end

function UIGuildOrderSetupWin_autoClass:setTeamItem(item,guid)
local setup=guildOrderModel:getSetupData(self.orderID)
local selectId=setup.selectId
local dzData=UIDiscipleModel:getDiscipleDataX(guid)
local netdata=dzData.netData


local sixAttrValue=UIDiscipleModel:getDiscipleBaseAttr(guid,self.sixAttrType)

local classLevel=UIDiscipleModel:getDiscipleJobLevel(guid,selectId)

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(itemIndex.bg,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(itemIndex.jobImg,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(itemIndex.spDzFlag,isSpDz)

local isnew=netdata.isnew==true
item:SetChildActive(itemIndex.newFlag,isnew)

item:SetChildText(itemIndex.name,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,itemIndex.head,0,eHeadCenterType.eHalf)

local showClassLevel=true
item:SetChildActive(itemIndex.lv_obj,showClassLevel)
if showClassLevel then

item:SetChildCSImageSprite(itemIndex.lv_obj,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])
item:SetChildText(itemIndex.level,tostring(classLevel))
end

local sixAttrStr=FMT.fmt('{0} <color=#171311ff>{1}</color>',self.sixAttrName,sixAttrValue)
item:SetChildText(itemIndex.sixAttr,sixAttrStr)


local desc=UIDiscipleModel:getDiscipleStateDesc(guid)





local proSkillConst=cfgHelper.getdef(cfg_discipleproskillconfig)
local expList=proSkillConst.exp
local nextlevel=expList[classLevel+1]
if nextlevel==nil then
desc=FMT.fmt('<color=#FF7C80>已满级</color>')
end
item:SetChildText(itemIndex.desc,desc)


item:SetChildActive(itemIndex.flag,false)
end

function UIGuildOrderSetupWin_autoClass:refreshSkillList()
self.datas=UISchoolModel:get_sort_class()

local zongmengLv=zongmenModel:getLevel()
self.slScrollView:setChildScrollViewCreateGrids(#self.datas,5)
local grids=self.slScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.datas[i]
local lock=zongmengLv<data.unlocklevel
item:SetChildActive(0,false)
local sname=lock and FMT.fmt('<color=#65615f>{0}（未解锁）</color>',data.name)or FMT.fmt('<color=#171311>{0}</color>',data.name)
item:SetChildText(1,sname)
item:SetChildActive(2,lock)
end
end

function UIGuildOrderSetupWin_autoClass:refreshItemControllBtn(orderID,firstOpen)
local isSetupOpen=guildOrderModel:isOrderSetupOpen(orderID)
self.winlua:SetChildActive(self.controllClose:getID(),not isSetupOpen)
self.winlua:SetChildActive(self.controllOpen:getID(),isSetupOpen)


end




function UIGuildOrderSetupWin_autoClass:onControllBtn()
local orderID=self.orderID
local setup=guildOrderModel:getSetupData(orderID)
setup.isOpen=not setup.isOpen
guildOrderModel:flushSetupData(orderID)
guildOrderModel:changeSetupOpen(orderID,setup.isOpen)
self:refreshItemControllBtn(orderID)
UIManager:invokeUIMethod('UIGuildOrderWin','checkitemorder',GUILD_ORDER_TYPE.eAutoAttendClass)
end

