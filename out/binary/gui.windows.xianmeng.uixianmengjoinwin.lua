







def_class("UIXianMengJoinWin",UIWindowBase)









function UIXianMengJoinWin:bindComponents()

self.ruleBtn=UIButton.get(self,0)
self.coolTimeTxt=UIText.get(self,1)
self.searchInput=UIInputField.get(self,2)
self.sortTypeDropdown=UIDropdown.get(self,3)
self.joinTimeTxt=UIText.get(self,4)
self.btnRefresh=UIButton.get(self,5)
self.searchBtn=UIButton.get(self,6)
self.searchCancelBtn=UIButton.get(self,7)
self.xmScrollView=UIEnhancedScrollerLua.get(self,8)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.btnRefresh:setButtonClick(function()self:onBtnRefresh()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)



end


function UIXianMengJoinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.coolTimeTxt);self.coolTimeTxt=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.joinTimeTxt);self.joinTimeTxt=nil;
_UIObject_release(self.btnRefresh);self.btnRefresh=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.xmScrollView);self.xmScrollView=nil;
end
















local UIXMJoinScroller=simple_class(UIEnhancedScroller)
local _this=nil
local maxJoinNum
local refreshLerpTime=30


function UIXianMengJoinWin:onLoaded(...)
_this=self
self:bindComponents()

self.scrollscript=UIXMJoinScroller(self.xmScrollView:getGameObject(),self.xmScrollView:getCSharpObject(),nil,nil)
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)

maxJoinNum=cfgHelper.get3(cfg_guildbaseconfig_get,1,'application',1)
end


function UIXianMengJoinWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXianMengJoinWin:onHide()

end




function UIXianMengJoinWin:onShow(argtable,afterOnloaded)
self.sortTypeDropdown:setOption(xianmengModel:getSearchXMSortNames())
self.sortType=1
self.sortCondition={}
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortType-1)
self.lockRefresh=false

self:refreshInputBtns()
self:initCoolDownView()

self:resetDatList()
self:refreshView()
self:updateRefreshBtn()
end

function UIXianMengJoinWin:initCoolDownView()
local lerp=xianmengModel:getJoinCoolDownTime()
self.showCooldownTime=lerp>0
local lerp2=xianmengController:getKuafuMemberOpenTime()
self.showCooldownTime2=lerp2>0

if self.cooldowmTimer~=nil then
self:stopTimerByID(self.cooldowmTimer)
self.cooldowmTimer=nil
end
local isshow=self.showCooldownTime or self.showCooldownTime2
if isshow then
self.cooldowmTimer=self:setTimer(1,0,function()
self:refreshCoolDown()
end)
self:refreshCoolDown()
end
end

function UIXianMengJoinWin:refreshCoolDown()
local lerp=xianmengModel:getJoinCoolDownTime()
self.showCooldownTime=lerp>0
if self.showCooldownTime then
local timestr=FMT.fmt('加入冷却时间：{0}',timeHelper.format_time_stamp3(lerp))
self.coolTimeTxt:setText(timestr)
end
local lerp2=xianmengController:getKuafuMemberOpenTime()
self.showCooldownTime2=lerp2>0
if self.showCooldownTime2 then
local timestr=FMT.fmt(cfgHelper.getlang('xianmeng_tips3'),timeHelper.formatSimpleTime(lerp2))
self.joinTimeTxt:setText(timestr)
end

self.coolTimeTxt:setActive(self.showCooldownTime)
self.joinTimeTxt:setActive(self.showCooldownTime2)
local isshow=self.showCooldownTime or self.showCooldownTime2
if not isshow then
if self.cooldowmTimer~=nil then
self:stopTimerByID(self.cooldowmTimer)
self.cooldowmTimer=nil
end
end
end

function UIXianMengJoinWin:resetDatList()
local list_=xianmengModel:getAllSearchXMData()







local list=xianmengModel:getSearchXMSortList(list_,self.sortType,self.sortCondition,self.sortOrder)





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

function UIXianMengJoinWin:findItemIndex(guildid)
for i,data in ipairs(self.xmDataListSort)do
if mathHelper.compareInt64(data.guildid,guildid)then
return i
end
end
return nil
end

function UIXianMengJoinWin:refreshView()
local c=#self.xmDataListSort
self.scrollscript:initData(self.xmDataListSort,84,c)
end



function UIXMJoinScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIXMJoinScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIXMJoinScroller:RefreshCell(dataIndex,cellIndex,item)
local data=self.data[dataIndex]

local image=xianmengModel.splitGuildIcon(data.guildicon)
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

item:SetChildText(5,data.guildlevel)

local maxNum=xianmengModel.getXMMaxMemberNum(data.guildlevel)
local curNum=data.membernum
local isfullnum=curNum>=maxNum
local num_str=isfullnum and FMT.fmt('<color=#c82c2c>{0}/{1}</color>',curNum,maxNum)or FMT.fmt('{0}/{1}',curNum,maxNum)
item:SetChildText(6,num_str)

local fightnum=data.memberfight_num
item:SetChildText(7,mathHelper.formatNumber3(fightnum))

item:SetChildText(8,tostring(data.weekscore))

local cond_str=''
local check_cond=not isfullnum
local joinlimit=data.joinlimit
if mathHelper.getBitValue(joinlimit,1)then
check_cond=false
cond_str='<color=#c82c2c>不再招人</color>'
else
local levellimit=data.levellimit
local zmlv=zongmenModel:getLevel()
if zmlv<levellimit then
check_cond=false
cond_str=FMT.fmt('<color=#c82c2c>{0}级</color>',levellimit)
else
if mathHelper.getBitValue(joinlimit,0)then
cond_str='无限制'
else
cond_str=FMT.fmt('{0}级',levellimit)
end
end
end
item:SetChildText(9,cond_str)

if check_cond then
check_cond=not xianmengModel:checkApplyJoinState(data.guildid)
end
item:SetChildGray(10,not check_cond)
item:SetChildButtonClick(0,function()
self:onItemClick(dataIndex)
end)
item:SetChildButtonClick(10,function()
self:onJoinBtnClick(dataIndex)
end)
end

function UIXMJoinScroller:onItemClick(index)
local data=self.data[index]
local guildid=data.guildid

xianmengController:openXMDetailInfoWin(guildid)
end

function UIXMJoinScroller:onJoinBtnClick(index)



local data=self.data[index]
if not data:checkfunc(true)then
return
end

local guildid=data.guildid
if xianmengModel:checkApplyJoinState(guildid)then
UIManager.error('不能重复申请同一仙盟')
return
end


local func=function()
if _this and not _this.isClose then
xianmengController:reqApllyJoinXM({guildid},true)
end
end

xianmengController:checkFreeCDTimes(func)



end

function UIXMJoinScroller:refreshItemNum(index)
local item=self:GetCell(index-1)
if item then
self:RefreshCell(index,nil,item)
end
end



function UIXianMengJoinWin:onOneKeyBtn()

AudioManager.playBtnClick()




local f1=nil
local list={}
local num=0
for i,v in ipairs(self.xmDataListSort)do
if v:checkfunc()then
if not xianmengModel:checkApplyJoinState(v.guildid)then
if mathHelper.getBitValue(v.joinlimit,0)then

f1=v
break
else

if num<maxJoinNum then
num=num+1
table.insert(list,v.guildid)
end
end
end
end
end

if not f1 and num<=0 then
UIManager.error('没有适合加入的仙盟')
return
end

local func=function()
if self and not self.isClose then
if f1 then
xianmengController:reqApllyJoinXM({f1.guildid},true)
return
end
if num>0 then
xianmengController:reqApllyJoinXM(list,true)
return
end
end
end

xianmengController:checkFreeCDTimes(func)
end

function UIXianMengJoinWin:onCreateBtn()

AudioManager.playBtnClick()

UIManager:showWindow('UIXianMengCreateWin')
end

function UIXianMengJoinWin:onRuleBtn()
local args={}
args.posItem=self.ruleBtn
args.pos=Vector2.New(0,45)
args.title='活跃'
args.desc=cfgHelper.getlang('xianmeng_huoyue_tips2')
UIManager:showWindow('UIDescribeTips5',args)
end



function UIXianMengJoinWin:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
self.sortType=idx

self:clearSearchInput()
self:resetDatList()
self:refreshView()
end

function UIXianMengJoinWin:onSortConditionClick()
local filterName,filterFlag=xianmengModel:getSearchXMFilter(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIXianMengJoinWin.selecConditionBack(data)
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

function UIXianMengJoinWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:resetDatList()
self:refreshView()
end

function UIXianMengJoinWin:onSearchBtn()
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

function UIXianMengJoinWin:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:resetDatList()
self:refreshView()
end

function UIXianMengJoinWin:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIXianMengJoinWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIXianMengJoinWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end



function UIXianMengJoinWin:updateRefreshBtn()
local isshow=false
if self.refreshTime==nil or gameUtilityModel.getServerShortTime()-self.refreshTime>=refreshLerpTime then
isshow=true
end
self.btnRefresh:setChildImageExGray(not isshow)
end

function UIXianMengJoinWin:onBtnRefresh()
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



function UIXianMengJoinWin:changeRefresh()
self:resetDatList()
self:refreshView()
end

function UIXianMengJoinWin:refresh_item(guildid)
local idx=self:findItemIndex(guildid)
if idx then
self.scrollscript:refreshItemNum(idx)
end
end

function UIXianMengJoinWin:rec_data()
self:resetDatList()
self:refreshView()
end

