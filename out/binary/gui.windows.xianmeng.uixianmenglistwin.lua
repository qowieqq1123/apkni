







def_class("UIXianMengListWin",UIWindowBase)









function UIXianMengListWin:bindComponents()

self.huoyueBtn=UIButton.get(self,0)
self.searchInput=UIInputField.get(self,1)
self.sortTypeDropdown=UIDropdown.get(self,2)
self.btnRefresh=UIButton.get(self,3)
self.searchBtn=UIButton.get(self,4)
self.searchCancelBtn=UIButton.get(self,5)
self.xmScrollView=UIEnhancedScrollerLua.get(self,6)

self.huoyueBtn:setButtonClick(function()self:onHuoyueBtn()end)

self.btnRefresh:setButtonClick(function()self:onBtnRefresh()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)



end


function UIXianMengListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.huoyueBtn);self.huoyueBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.btnRefresh);self.btnRefresh=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.xmScrollView);self.xmScrollView=nil;
end
















local UIXMListScroller=simple_class(UIEnhancedScroller)
local _this=nil
local refreshLerpTime=30


function UIXianMengListWin:onLoaded(...)
_this=self
self:bindComponents()

self.scrollscript=UIXMListScroller(self.xmScrollView:getGameObject(),self.xmScrollView:getCSharpObject(),nil,nil)
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIXianMengListWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXianMengListWin:onHide()

end




function UIXianMengListWin:onShow(argtable,afterOnloaded)
self.sortTypeDropdown:setOption(xianmengModel:getSearchXMSortNames())
self.sortType=1
self.sortCondition={}
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortType-1)
self.lockRefresh=false

local flag=xianmengModel:checkSearchXMData()
if flag then
self.isInit=false
self:clearView()
else
self.isInit=true
self:resetDatList()
self:refreshView()
end
self:updateRefreshBtn()
end

function UIXianMengListWin:resetDatList()
local list_=xianmengModel:getAllSearchXMData()







local list=xianmengModel:getSearchXMSortList2(list_,self.sortType,self.sortCondition,self.sortOrder)





if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in ipairs(list)do
local guildid_str=v.guildid_str
local str=self.nameSearchList[guildid_str]
if str==nil then
str=UIDiscipleModel.getSearchName(guildid_str,v.guildname)
self.nameSearchList[guildid_str]=str
end
local d={v,str}
table.insert(temp_search,d)
end
if#temp_search>0 then
for i,v in ipairs(temp_search)do
local str=v[2]
if string.find(str,self.inputstr)then
table.insert(temp,v[1])
end
end
end
self.xmDataListSort=temp
else
self.xmDataListSort=list
end
end

function UIXianMengListWin:findItemIndex(guildid)
for i,data in ipairs(self.xmDataListSort)do
if mathHelper.compareInt64(data.guildid,guildid)then
return i
end
end
return nil
end

function UIXianMengListWin:clearView()
self.scrollscript:initData(self.xmDataListSort,85,0)
end


function UIXianMengListWin:refreshView()
local c=#self.xmDataListSort
self.scrollscript:initData(self.xmDataListSort,85,c)
end



function UIXMListScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIXMListScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIXMListScroller:RefreshCell(dataIndex,cellIndex,item)
local data=self.data[dataIndex]
local ismy=xianmengModel:isMyXM(data.guildid)
local guildlevel
local xmname
local leadername
local image
if ismy then
guildlevel=xianmengModel:getXMLevel()
xmname=xianmengModel:getXMName()
image=xianmengModel:getGuildImage()
leadername=xianmengModel:getXMLeaderName()
else
guildlevel=data.guildlevel
xmname=data.guildname
image=xianmengModel.splitGuildIcon(data.guildicon)
leadername=data.leadername
end

local abname=globalABLookup.xianmengicons

item:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local name_str=data.guildname
if xianmengController:checkKuafuMemberOpen()then
local serverName=loginModel:getServerName(data.leaderserverid)
if serverName~=''then
name_str=FMT.fmt('<color=#b67b36>[{0}]</color>\n{1}',serverName,name_str)
end
end
item:SetChildText(4,name_str)

item:SetChildText(5,guildlevel)

local maxNum=xianmengModel.getXMMaxMemberNum(guildlevel)
local curNum
if ismy then
curNum=xianmengModel:getXMMemberNum()
else
curNum=data.membernum
end
local isfullnum=curNum>=maxNum
local num_str=isfullnum and FMT.fmt('<color=red>{0}/{1}</color>',curNum,maxNum)or FMT.fmt('{0}/{1}',curNum,maxNum)
item:SetChildText(6,num_str)

item:SetChildText(7,leadername)

local fightnum=data.memberfight_num
item:SetChildText(8,mathHelper.formatNumber3(fightnum))

item:SetChildText(9,tostring(data.weekscore))

item:SetChildActive(10,ismy)

item:SetChildButtonClick(0,function()
self:onItemClick(dataIndex)
end)
end

function UIXMListScroller:onItemClick(index)
local data=self.data[index]
local guildid=data.guildid
if xianmengModel:isMyXM(guildid)then
return
end

xianmengController:openXMDetailInfoWin(guildid)
end

function UIXMListScroller:refreshItemNum(index)
local item=self:GetCell(index-1)
if item then
self:RefreshCell(index,nil,item)
end
end





function UIXianMengListWin:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
self.sortType=idx

self:clearSearchInput()
self:resetDatList()
self:refreshView()
end

function UIXianMengListWin:onSortConditionClick()
local filterName,filterFlag=xianmengModel:getSearchXMFilter2(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIXianMengListWin.selecConditionBack(data)
if _this==nil then
return
end
local filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end

_this:clearSearchInput()
_this:resetDatList()
_this:refreshView()
end

function UIXianMengListWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:resetDatList()
self:refreshView()
end

function UIXianMengListWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
self:resetDatList()
self:refreshView()
else
UIManager.info('请输入搜索内容')
end
return
end
if self.inputstr==inputstr then
return
end
if helper.check_spec_chars(inputstr)then
UIManager.info('名称含敏感字符')
return
end
self.inputstr=inputstr
self:resetDatList()
if#self.xmDataListSort<=0 then
self.inputstr=nil
UIManager.info('查无此仙盟')
return
end
self.searchInput:setInputFieldValue('')
self:refreshView()
end

function UIXianMengListWin:onSearchCancelBtn()
if self.inputstr==nil then return end
self:clearSearchInput()
self:resetDatList()
self:refreshView()
end

function UIXianMengListWin:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIXianMengListWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIXianMengListWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end



function UIXianMengListWin:updateRefreshBtn()
local isshow=false
if self.refreshTime==nil or gameUtilityModel.getServerShortTime()-self.refreshTime>=refreshLerpTime then
isshow=true
end
self.btnRefresh:setChildImageExGray(not isshow)
end

function UIXianMengListWin:onBtnRefresh()
if self.refreshTime~=nil then
local lerp=gameUtilityModel.getServerShortTime()-self.refreshTime
if lerp<refreshLerpTime then
UIManager.error(FMT.fmt(cfgHelper.getlang('xianmeng_tips2'),refreshLerpTime-lerp))
return
end
end
self.refreshTime=gameUtilityModel.getServerShortTime()
self:delayDo(refreshLerpTime,function()
self:updateRefreshBtn()
end)
self:updateRefreshBtn()
UIManager.info(cfgHelper.getlang('xianmeng_tips1'))
xianmengModel:checkSearchXMData(true)
end

function UIXianMengListWin:onHuoyueBtn()
local args={}
args.posItem=self.huoyueBtn
args.pos=Vector2.New(0,45)
args.title='活跃'
args.desc=cfgHelper.getlang('xianmeng_huoyue_tips2')
self:showWindow('UIDescribeTips5',args)
end

function UIXianMengListWin:onLeaveBtn()
xianmengController:onClickLeaveXM()
end

function UIXianMengListWin:rec_data()
self.isInit=true
self:resetDatList()
self:refreshView()
end

function UIXianMengListWin:refresh_item(guildid)
local idx=self:findItemIndex(guildid)
if idx then
self.scrollscript:refreshItemNum(idx)
end
end