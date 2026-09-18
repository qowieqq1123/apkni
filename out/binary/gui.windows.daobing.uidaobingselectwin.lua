







def_class("UIDaoBingSelectWin",UIWindowBase)









function UIDaoBingSelectWin:bindComponents()

self.btnComfirm=UIButton.get(self,0)
self.desc=UIText.get(self,1)
self.Item=UIObject.get(self,2)
self.creater=UIObject.get(self,3)

self.btnComfirm:setButtonClick(function()self:onBtnComfirm()end)



end


function UIDaoBingSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnComfirm);self.btnComfirm=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.Item);self.Item=nil;
_UIObject_release(self.creater);self.creater=nil;
end


















function UIDaoBingSelectWin:onLoaded(...)
self:bindComponents()
end

function UIDaoBingSelectWin:__delete()
self:unbindComponents()
end

function UIDaoBingSelectWin:onShow(argtable,afterOnloaded)

local baglist=argtable.list
local selectList=argtable.selectList or{}
self.maxnum=argtable.maxnum
self.call=argtable.call
local selectLookup={}
for i,v in ipairs(selectList)do

if selectLookup[tostring(v)]then
selectLookup[tostring(v)][#selectLookup[tostring(v)]+1]=0
else
selectLookup[tostring(v)]={0}
end
end
self.selectList=selectList
self.selectLookup=selectLookup










local sortTag={}
for i,v in ipairs(baglist)do
local itemguid=v.itemguid
local starlv=daobingModel:getStarLv(itemguid)
local jllv=daobingModel:getJilianLv(itemguid)
sortTag[tostring(itemguid)]=starlv*1000000+jllv*10000+i












end
self.selectLookup=selectLookup


table.sort(baglist,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)

for i,v in ipairs(baglist)do
local itemguid=v.itemguid
if selectLookup[tostring(itemguid)]then
for k,j in ipairs(selectLookup[tostring(itemguid)])do
if selectLookup[tostring(itemguid)][k]==0 then
selectLookup[tostring(itemguid)][k]=i
break
end
end
end
end
self.selectLookup=selectLookup


local len=#baglist
self.creater:setChildLayoutGroupCreateItems(len,function(i)
local widget=self.creater:getChildLayoutGroupGridItem(i-1)
local item=baglist[i]
local itemid=item.itemid
local itemguid=item.itemguid
local itemCfg=itemsConfig.getConfig(itemid)


if itemCfg.purpose then
local diziguid=daobingModel:getDiziguidByItemguid(itemguid)
local has=itemsModel.getCount(itemid)
local jllv=daobingModel:getJilianLv(itemguid)
local starlv=daobingModel:getStarLv(itemguid)
local conf={showCountBG=jllv>1}
local prop=itemsComponentHelper.getDaoBingSmallData(item,conf)
widget:SetChildPropData(0,prop)
local baseWidget=widget:GetChildWidgetBase(0)
baseWidget:SetChildStarNumber(6,starlv)

local isLD=liandonModel:getLianDonLinkageIdByItemId(itemid)>0
baseWidget:SetChildActive(7,isLD)
widget:SetBaseItemClickEvent(0,function()
self:onClickItem(itemid,i,itemguid)
end)

widget:SetChildText(1,itemCfg.name)
widget:SetChildStarNumber(2,starlv)

local isselect=false
if self.selectLookup[tostring(itemguid)]~=nil then
for k,v in ipairs(self.selectLookup[tostring(itemguid)])do
if v==i then
isselect=true
break
end
end
end
widget:SetChildActive(3,isselect)
widget:SetChildActive(4,diziguid~=nil)
if diziguid then
comHelper.setChildModelRawImage(widget,diziguid,5,0,eHeadCenterType.eHead,0.6)
end
widget:SetChildButtonClick(6,function()
self:onClickItem(itemid,i,itemguid)
end,true)
widget:SetChildActive(7,false)

else
local conf={showCountBG=false}
local prop=itemsComponentHelper.getDaoBingSmallData(item,conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function()
self:onClickItem(itemid,i,itemguid)
end)
widget:SetChildText(1,itemCfg.name)
widget:SetChildActive(2,false)

local isselect=false
if self.selectLookup[tostring(itemguid)]~=nil then
for k,v in ipairs(self.selectLookup[tostring(itemguid)])do
if v==i then
isselect=true
break
end
end
end
widget:SetChildActive(3,isselect)
widget:SetChildActive(4,false)
widget:SetChildButtonClick(6,function()
self:onClickItem(itemid,i,itemguid)
end,true)
widget:SetChildActive(7,true)
end

end)
end

function UIDaoBingSelectWin:onHide()

end





function UIDaoBingSelectWin:onBtnComfirm()
UIManager:closeWindow('UICommonPageWin')
self:closeSelf()
end

function UIDaoBingSelectWin:onComfirm()
local list={}
for guidStr,_ in pairs(self.selectLookup)do

for k,v in ipairs(_)do
list[#list+1]=int64.new(guidStr)
end
end

self.call(list)
end

function UIDaoBingSelectWin:freshSelect(itemguid,index)
local widget=self.creater:getChildLayoutGroupGridItem(index-1)

local isselect=false
if self.selectLookup[tostring(itemguid)]~=nil then
for k,v in ipairs(self.selectLookup[tostring(itemguid)])do
if v==index then
isselect=true
break
end
end
end
widget:SetChildActive(3,isselect)

end

function UIDaoBingSelectWin:onClickItem(itemid,index,itemguid,attach)
local guidStr=tostring(itemguid)
local selectIdx=self.selectLookup[guidStr]
local isselect=false
if selectIdx~=nil and#selectIdx>0 then
for k,v in ipairs(selectIdx)do
if v==index then
isselect=true
break
end
end
end
if isselect then

if#self.selectLookup[guidStr]==1 then
self.selectLookup[guidStr]=nil
else
local temp={}
for k,v in ipairs(self.selectLookup[guidStr])do
if v~=index then
temp[#temp+1]=v
end
end
self.selectLookup[guidStr]=temp
end

self:freshSelect(itemguid,index)
self:onComfirm()
return
else
local num=0
for k,v in pairs(self.selectLookup)do

for i,j in ipairs(v)do
num=num+1
end
end

if num>=self.maxnum then
UIManager.error('选择已满')
return
end
local jllv=daobingModel:getJilianLv(itemguid)
local starlv=daobingModel:getStarLv(itemguid)
if jllv>0 or starlv>0 then
UIManager.error('已强化的道兵不可使用')
return
end
local dzguid=daobingModel:getDiziguidByItemguid(itemguid)
local func=function()

if not self.selectLookup[guidStr]then
self.selectLookup[guidStr]={index}
elseif#self.selectLookup[guidStr]>0 then
self.selectLookup[guidStr][#self.selectLookup[guidStr]+1]=index
end

self:freshSelect(itemguid,index)
self:onComfirm()
end
if dzguid then
local dzname=UIDiscipleModel:getDiscipleName(dzguid)
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSelectDaoBing)
if flag then
func()
return
end

local desc=FMT.fmt('该道兵已被{0}装备，确定要选择吗？',dzname)
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'提示',desc)
self.dialog.okcallback=func
self.dialog.choosetext="今日不再提示"
self.dialog.choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSelectDaoBing,flag)
end
self.dialog:show()
else
func()
end
end
end
