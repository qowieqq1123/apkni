







def_class("UIGuBaoLianHuaSelectWin",UIWindowBase)









function UIGuBaoLianHuaSelectWin:bindComponents()

self.bagGrid=UIObject.get(self,0)
self.colorDropdown=UIDropdown.get(self,1)
self.elementDropdown=UIDropdown.get(self,2)



end


function UIGuBaoLianHuaSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bagGrid);self.bagGrid=nil;
_UIObject_release(self.colorDropdown);self.colorDropdown=nil;
_UIObject_release(self.elementDropdown);self.elementDropdown=nil;
end
















local _this=nil
local colorSavaKey='gubaolianhuaColor2'
local elementSavaKey='gubaolianhuaElement2'
local shownum=35


function UIGuBaoLianHuaSelectWin:onLoaded(...)
self:bindComponents()
_this=self

local all_str='所有'
self.colorSortTypeName={}
self.colorSortTypeName[1]=all_str
for i=1,5 do
table.insert(self.colorSortTypeName,FMT.fmt('{0}品材料',i))
end
self.elementSortTypeName={}
self.elementSortTypeName[1]=all_str
local elementlist=ELEMENT_TYPE:getFive()
for i,v in ipairs(elementlist)do
table.insert(self.elementSortTypeName,ELEMENT_TYPE.getName5(v))
end
self.colorDropdown:setChangeAction(function(...)self:onColorChange(...)end)
self.elementDropdown:setChangeAction(function(...)self:onElementChange(...)end)
end


function UIGuBaoLianHuaSelectWin:__delete()

UIManager:closeActiveWindow('UITipsWin')
self:unbindComponents()
end


function UIGuBaoLianHuaSelectWin:onHide()

end




function UIGuBaoLianHuaSelectWin:onShow(argtable,afterOnloaded)
self.lockDropDown=true
self.colorSortType=userActorSetting.get(colorSavaKey,1)
self.colorDropdown:setOption(self.colorSortTypeName)
self.colorDropdown:setValue(self.colorSortType-1)
self.elementSortType=userActorSetting.get(elementSavaKey,1)
self.elementDropdown:setOption(self.elementSortTypeName)
self.elementDropdown:setValue(self.elementSortType-1)
self.lockDropDown=false

self.goodlist=argtable.goodlist
self.onAddBack=argtable.onAddBack
self.onSubtractBack=argtable.onSubtractBack
self.needExp=argtable.needExp
self:resetSelectList()

self:updataBagView()
end

function UIGuBaoLianHuaSelectWin:resetSelectList()
self.selectList={}
for i,v in ipairs(self.goodlist)do
local itemguid=v.item.itemguid
local cnt=v.cnt
local itemid=v.item.itemid
self.selectList[tostring(itemguid)]={cnt,i,itemid}
end
end

function UIGuBaoLianHuaSelectWin:getBaglist()
self.baglist=gubaoLookup:getGoodsSortList2(self.colorSortType,2,self.elementSortType)
end

function UIGuBaoLianHuaSelectWin:updataBagView()
self:getBaglist()
local cc=#self.baglist
local c=shownum
if cc>c then
c=cc
end
self.bagGrid:setChildLayoutGroupCreateItems(c)
local grid=self.bagGrid:getChildLayoutGroupGridList()
for i=1,c do
local item=grid[i-1]
self:refreshItemView(item,i)

item:SetChildButtonClick(1,function()
self:onItemSubtract(i)
end)
end
end

function UIGuBaoLianHuaSelectWin:refreshItemView(item,idx)
local data=self.baglist[idx]
local isshow=data~=nil
item:SetChildActive(0,isshow)
item:SetChildActive(1,isshow)
if isshow then
local itemData=data.item
local itemguid=itemData.itemguid
local itemid=itemData.itemid
local itemcount=itemData.itemcount
local selectData=self.selectList[tostring(itemguid)]
local scount=0
if selectData then scount=selectData[1]end
local isSelect=scount>0
item:SetChildActive(1,isSelect)
local num_str=tostring(itemData.itemcount)
if isSelect then
num_str=FMT.fmt('{0}/{1}',scount,itemcount)
else
num_str=tostring(itemcount)
end
local conf={itemid=itemid,itemcount=num_str,showname=false,itemIndex=idx,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
item:SetBaseItemLongTouchEvent(0,function(...)
self:onItemLongClick(...)
end)
end
end

function UIGuBaoLianHuaSelectWin:onColorChange(idx)
if self.lockDropDown==true then return end

idx=idx+1
self.colorSortType=idx
userActorSetting.flushVal(colorSavaKey,idx)

self:updataBagView()
end

function UIGuBaoLianHuaSelectWin:onElementChange(idx)
if self.lockDropDown==true then return end

idx=idx+1
self.elementSortType=idx
userActorSetting.flushVal(elementSavaKey,idx)

self:updataBagView()
end

function UIGuBaoLianHuaSelectWin:onItemClick(itemid,index,guid,attach)


self:yetAddExp()
if self.yetadd>=self.needExp then

UIManager.error(cfgHelper.getlang('gubao_tips_4'))
return
end

local valmax=itemsModel.getCount(itemid)
local cfg=itemsConfig.getConfig(itemid)
local score=cfg.gubaolianhua

local needExp=self.needExp-self.yetadd

local canmaxnum=math.ceil(needExp/score)
if valmax<canmaxnum then
canmaxnum=valmax
end
local selectNumCmpArgs={numFormat='放入：<color=#f1ce78>{0}/{1}</color>',
min=1,max=canmaxnum,val=canmaxnum}
local isMain=false
tipsManager.showTips({formType=TIPS_FORM_TYPE.eGuBaoUpLvBag,
itemid=itemid,
itemguid=guid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,
selectNumCmpArgs=selectNumCmpArgs,
isMain=isMain,
isMakeByEquip=false},
move=TIPS_MOVE_POS.eCenter})

end
function UIGuBaoLianHuaSelectWin:yetAddExp()
self.yetadd=0
for k,v in pairs(self.selectList)do
local cfg=itemsConfig.getConfig(v[3])
local score=cfg.gubaolianhua
self.yetadd=self.yetadd+score*v[1]
end
end
function UIGuBaoLianHuaSelectWin:putItem(index,itemid,itemguid,num)
self:AddItem(itemid,index,itemguid,nil,num)

end
function UIGuBaoLianHuaSelectWin:AddItem(itemid,index,guid,attach,num)

local itemData=self.baglist[index].item
local itemguid=itemData.itemguid
local itemcount=itemData.itemcount
local guid_str=tostring(itemguid)
local selectData=self.selectList[guid_str]

if selectData==nil then

local c=#self.goodlist
if self.onAddBack(c,itemData,true,num)~=true then return end
local n_idx=c+1
self.selectList[guid_str]={num,n_idx,itemid}
else

if selectData[1]>=itemcount then return end
if self.onAddBack(selectData[2],itemData,false,num)~=true then return end
selectData[1]=num
end

local item=self.bagGrid:getChildLayoutGroupGridItem(index-1)
self:refreshItemView(item,index)

end

function UIGuBaoLianHuaSelectWin:onItemLongClick(itemid,index,guid,attach)
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UIGuBaoLianHuaSelectWin:onItemSubtract(index)
local itemData=self.baglist[index].item
local itemguid=itemData.itemguid
local guid_str=tostring(itemguid)
local selectData=self.selectList[guid_str]
if selectData==nil then return end

if self.onSubtractBack(selectData[2])~=true then return end

if selectData[1]<=1 then
self:resetSelectList()
else
selectData[1]=selectData[1]-1
end

local item=self.bagGrid:getChildLayoutGroupGridItem(index-1)
self:refreshItemView(item,index)
end
