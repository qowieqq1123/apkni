







def_class("UIBagEquipSubFilterPartWin",UIWindowBase)









function UIBagEquipSubFilterPartWin:bindComponents()

self.comfireBtn=UIButton.get(self,0)
self.list=UIObject.get(self,1)
self.resetBtn=UIButton.get(self,2)
self.Root=UIObject.get(self,3)
self.uiRoot=UIObject.get(self,4)

self.comfireBtn:setButtonClick(function()self:onComfireBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIBagEquipSubFilterPartWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.comfireBtn);self.comfireBtn=nil;
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local _itemFilterFunc={
[BAG_FILTER_TYPE.eEquipPosType]={
initData=function(self)
local cfgs=cfg_discipleweaponconfig()
self.listData={}
for index,cfg in ipairs(cfgs)do
self.listData[index]=0
end
end,
recordData=function(self,recordData)
if next(recordData)==0 then return end

for index,val in ipairs(recordData)do
self.listData[val]=1
end
end,
getItemTxt=function(self,index)
local cfg=cfgHelper.get1(cfg_discipleweaponconfig_get,index)

return FMT.fmt("{0} ({1})",cfg.name,cfg.attrFlagDesc)
end,
sortList=function(self,list)
table.sort(list,function(a,b)
return a<b
end)
end,
getResult=function(self,list)
local rlist={}

if next(list)then
for index,val in ipairs(list)do
if val==1 then
rlist[#rlist+1]=index
end
end
else
rlist[1]=0
end

return rlist
end,
},
[BAG_FILTER_TYPE.eEquipSuit]={
initData=function(self)
local cfgs=cfg_discipleequipsuitconfig()
self.listData={}
self.lookup={}
self.suitLookup={}
local num=0
for index,cfg in ipairs(cfgs)do
if cfg.filter then
num=num+1
self.listData[num]=0
self.lookup[num]=cfg.id
self.suitLookup[cfg.id]=num
end
end
end,
recordData=function(self,recordData)
for index,val in ipairs(recordData)do
local sindex=self.suitLookup[val]
self.listData[sindex]=1
end
end,
getItemTxt=function(self,index)
local suitid=self.lookup[index]
local suitCfg=cfgHelper.get1(cfg_discipleequipsuitconfig_get,suitid)

local iconName=iconHelper.getSuitIcon(suitCfg.icon)
local chatIconName=chatEmotHelper.getIconEmotMesg(iconName,30)

return FMT.fmt("{0} {1}({2})",chatIconName,suitCfg.name,suitCfg.attrFlagDesc)
end,
sortList=function(self,list)
table.sort(list,function(a,b)
return a<b
end)
end,
getResult=function(self,list)
local rlist={}

for index,val in ipairs(list)do
if val==1 then
local suitid=self.lookup[index]
rlist[#rlist+1]=suitid
end
end

return rlist
end,
},
}




function UIBagEquipSubFilterPartWin:onLoaded(...)
self:bindComponents()

_this=self
end


function UIBagEquipSubFilterPartWin:__delete()

_this=nil

self:unbindComponents()
end




function UIBagEquipSubFilterPartWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.invokeWin=argtable.invokeWin
self.filterPartType=argtable.partType
self.recordData=argtable.recordData

self:initData()
self:refreshList()
end


function UIBagEquipSubFilterPartWin:onHide()

end





function UIBagEquipSubFilterPartWin:onComfireBtn()
local filterFunc=_itemFilterFunc[self.filterPartType]
local result=filterFunc.getResult(self,self.listData)

if self.invokeWin then
self.invokeWin:onEquipSubFilter(self.filterPartType,result)
end

self.parentWin:closeSelf()
end



function UIBagEquipSubFilterPartWin:onResetBtn()
local filterFunc=_itemFilterFunc[self.filterPartType]
filterFunc.initData(self)
self:refreshList()
end


function UIBagEquipSubFilterPartWin:initData()

local filterFunc=_itemFilterFunc[self.filterPartType]

filterFunc.initData(self)

if self.recordData then
filterFunc.recordData(self,self.recordData)
end
end


function UIBagEquipSubFilterPartWin:refreshList()

local len=#self.listData

local createFunc=function(index)
local item=_this.list:getChildLayoutGroupGridItem(index-1)

local isGray=_this.listData[index]==0

item:SetChildGray(-1,isGray)

local txt=_itemFilterFunc[_this.filterPartType].getItemTxt(_this,index)
item:SetChildText(0,txt)

item:SetBaseItemClickEvent(-1,function()
isGray=not isGray
item:SetChildGray(-1,isGray)

_this.listData[index]=isGray and 0 or 1
end)
end

self.list:setChildLayoutGroupCreateItems(len,createFunc)
end

