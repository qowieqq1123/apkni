







def_class("UILingShouRongHeSelectWin",UIWindowBase)









function UILingShouRongHeSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.jingjieDropdown=UIDropdown.get(self,1)
self.colorDropdown=UIDropdown.get(self,2)
self.lsToggle=UIToggleButton.get(self,3)
self.none=UIObject.get(self,4)
self.gainWays=UIObject.get(self,5)
self.lingshouGrid=UIObject.get(self,6)



end


function UILingShouRongHeSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.jingjieDropdown);self.jingjieDropdown=nil;
_UIObject_release(self.colorDropdown);self.colorDropdown=nil;
_UIObject_release(self.lsToggle);self.lsToggle=nil;
_UIObject_release(self.none);self.none=nil;
_UIObject_release(self.gainWays);self.gainWays=nil;
_UIObject_release(self.lingshouGrid);self.lingshouGrid=nil;
end
















local _this=nil
local colorSavaKey='lingshouRongHeColor2'
local jjSavaKey='lingshouRongHeJJ2'


function UILingShouRongHeSelectWin:onLoaded(...)
self:bindComponents()
_this=self

self.colorSortTypeName={}
for i=1,5 do
table.insert(self.colorSortTypeName,FMT.fmt('{0}及以下',eQualityColorName[i]))
end
self.jjSortTypeName={}
local jjfloors=cfgHelper.getglobal('jingjiename')
for i,v in ipairs(jjfloors)do
table.insert(self.jjSortTypeName,FMT.fmt('{0}及以下',v))
end
self.colorDropdown:setChangeAction(function(...)self:onColorChange(...)end)
self.jingjieDropdown:setChangeAction(function(...)self:onJingJieChange(...)end)
self.lsToggle:setToggleChange(function(name,isOn,data)self:onToggleChange(isOn)end)

local gainWayCfg=cfg_lingshougainwayconfig()
local num=#gainWayCfg
local func=function(idx)
self:refreshGainWayItem(idx)
end
self.gainWays:setChildLayoutGroupCreateItems(num,func)
self.onlyXM=lingshouModel:getOnlyXueMaiSelect()

notifySystem:listenNotify(notifyConfig.onLingShouStateChange,self.onLingShouStateChange)
end


function UILingShouRongHeSelectWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onLingShouStateChange,self.onLingShouStateChange)
end


function UILingShouRongHeSelectWin:onHide()

end




function UILingShouRongHeSelectWin:onShow(argtable,afterOnloaded)
self.ls_guid=argtable.guid
self.cur_ls=lingshouModel:getLingShouData(self.ls_guid)
self.select_lp={}
local selectlist=argtable.selectlist or{}
self.selectNum=#selectlist
if self.selectNum>0 then
for i,v in ipairs(selectlist)do
self.select_lp[v.guid]=v
end
end
self.onAddBack=argtable.onAddBack
self.onSubtractBack=argtable.onSubtractBack

self.lockRefresh=true
self.jjSortType=userActorSetting.get(jjSavaKey,1)
self.jingjieDropdown:setOption(self.jjSortTypeName)
self.jingjieDropdown:setValue(self.jjSortType-1)

self.colorSortType=userActorSetting.get(colorSavaKey,1)
self.colorDropdown:setOption(self.colorSortTypeName)
self.colorDropdown:setValue(self.colorSortType-1)
self.lockRefresh=false

local toggleShow=self.lsToggle:getToggle()
if toggleShow==self.onlyXM then
self:refreshLSList()
else
self.lsToggle:setToggle(self.onlyXM)
end
end

function UILingShouRongHeSelectWin.onLingShouStateChange(lsGuid,stateType,o,c)
for i,v in ipairs(_this.lingshoulist)do
if mathHelper.compareInt64(v.item.guid,lsGuid)then
local item=_this.lingshouGrid:getChildLayoutGroupGridItem(i-1)
_this:refreshLsItem(item,i)
end
end
end

function UILingShouRongHeSelectWin:onToggleChange(isOn)
self.onlyXM=isOn
lingshouModel:setOnlyXueMaiSelect(self.onlyXM)
self:refreshLSList()
end

function UILingShouRongHeSelectWin:getLingShouList()
local reject_cb=function(lsData)
if self.ls_guid~=nil then
if mathHelper.compareInt64(lsData.guid,self.ls_guid)then
return true
end
end
if lingshouModel.checkZhenLingEx(lsData.cfg.race)then
return true
end

if not self.onlyXM then
return false
elseif lsData.xuemai_type~=0 then
return false
end

return true
end
local sort_cb=function(a,b)
if a.item.pet_state~=b.item.pet_state then
return a.item.pet_state<b.item.pet_state
elseif a.color~=b.color then
return a.color>b.color
elseif a.item.jj_lvl~=b.item.jj_lvl then
return a.item.jj_lvl>b.item.jj_lvl
elseif a.item.id~=b.item.id then
return a.item.id<b.item.id
else
return a.item.guid<b.item.guid
end
end
local list=lingshouLookup:getSortList2Ex(self.jjSortType,1,self.colorSortType,1,reject_cb,sort_cb)
self.lingshoulist=list
end

function UILingShouRongHeSelectWin:refreshLSList()
self:getLingShouList()
local c=#self.lingshoulist
local func=function(idx)
local item=self.lingshouGrid:getChildLayoutGroupGridItem(idx-1)
self:refreshLsItem(item,idx)
end
self.lingshouGrid:setChildLayoutGroupCreateItems(c,func)
self.none:setActive(#self.lingshoulist<=0)
end

function UILingShouRongHeSelectWin:refreshLsItem(item,idx)
local lsData=self.lingshoulist[idx].item
local lsID=lsData.id
local lscfg=lsData.cfg
local guid=lsData.guid


local isSelect=self.select_lp[guid]~=nil
item:SetChildActive(0,isSelect)




comHelper.setChildModelHeadIconBGByColor(item,1,lingshouModel.getColorEx(lsData))

comHelper.setChildModelRawImage_lingshou(item,lsData.id,2,0,eHeadCenterType.eHead,1)

local showSign=lscfg.bianyi==1
item:SetChildActive(3,showSign)

item:SetChildText(4,lsData.name)

local desc_str=FMT.fmt('境界：{0}',lingshouModel:getJJName(guid,2))
item:SetChildText(5,desc_str)

local has_xm=lsData.xuemai_type~=0
item:SetChildActive(10,has_xm)
if has_xm then
local xmCfg=cfgHelper.get1(cfg_lingshouxuemaiconfig_get,lsData.xuemai_type)
item:SetChildCSImageIcon(8,xmCfg.icon,false)

if self.cur_ls.xuemai_type==lsData.xuemai_type then
local xm_rate=cfgHelper.get2(cfg_lingshoubasicconfig_get,1,'xm_conversion_rate')
local xm=math.floor((xm_rate/100)*lsData.xuemai_val)
local xm_str=FMT.fmt('血脉+{0}%',xm)
item:SetChildText(9,xm_str)
item:SetChildActive(9,true)
else
item:SetChildActive(9,false)
end
end

item:SetChildActive(7,isSelect)
if isSelect then
item:SetChildButtonClick(7,function()
self:onLSItemSubClick(idx)
end,true)
end

item:SetChildButtonClick(6,function()
self:onLSItemClick(idx)
end,true)

local blackStr=lingshouModel:getStateDescEx(lsData.pet_state)

item:SetChildActive(11,blackStr~=nil)
item:SetChildText(12,blackStr or"")
end

function UILingShouRongHeSelectWin:onLSItemClick(idx)
local lsData=self.lingshoulist[idx].item

local blackStr=lingshouModel:getStateDescEx(lsData.pet_state)
if blackStr then
return UIManager.error(FMT.fmt("灵兽{0}，暂无法进行融合",blackStr))
end

local guid=lsData.guid
local selectData=self.select_lp[guid]

if selectData==nil then

local num=self.selectNum
if self.onAddBack(num,lsData)~=true then return end
self.selectNum=self.selectNum+1
self.select_lp[guid]=lsData
else

if self.onSubtractBack(selectData.guid)~=true then return end
self.selectNum=self.selectNum-1
self.select_lp[guid]=nil
end

local item=self.lingshouGrid:getChildLayoutGroupGridItem(idx-1)
self:refreshLsItem(item,idx)
end

function UILingShouRongHeSelectWin:onLSItemSubClick(idx)
local lsData=self.lingshoulist[idx].item
local guid=lsData.guid
local selectData=self.select_lp[guid]
if selectData==nil then return end

if self.onSubtractBack(selectData.guid)~=true then return end
self.selectNum=self.selectNum-1
self.select_lp[guid]=nil

local item=self.lingshouGrid:getChildLayoutGroupGridItem(idx-1)
self:refreshLsItem(item,idx)
end

function UILingShouRongHeSelectWin:onColorChange(idx)

if self.lockRefresh then return end
idx=idx+1
self.colorSortType=idx
userActorSetting.flushVal(colorSavaKey,idx)

self:refreshLSList()
end

function UILingShouRongHeSelectWin:onJingJieChange(idx)

if self.lockRefresh then return end
idx=idx+1
self.jjSortType=idx
userActorSetting.flushVal(jjSavaKey,idx)

self:refreshLSList()
end

function UILingShouRongHeSelectWin:refreshGainWayItem(idx)
local item=self.gainWays:getChildLayoutGroupGridItem(idx-1)
local config=cfgHelper.get1(cfg_lingshougainwayconfig_get,idx)
item:SetChildText(0,config.name)
item:SetChildButtonClick(-1,function()
jumpManager:jump(config.jump)
end)
end
