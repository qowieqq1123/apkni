







def_class("UILoginServerListWin",UIWindowBase)









function UILoginServerListWin:bindComponents()

self.frame=UIButton.get(self,0)
self.rightPanelOne=UIObject.get(self,1)
self.rightPanelTwo=UIObject.get(self,2)
self.rightPanelThree=UIObject.get(self,3)
self.bt_close=UIButton.get(self,4)
self.leftPanel=UIObject.get(self,5)
self.zhuanquBtn=UIButton.get(self,6)
self.zhuanquName=UIObject.get(self,7)

self.frame:setButtonClick(function()self:onClickClose()end)

self.bt_close:setButtonClick(function()self:onClickClose()end)
self.zhuanquBtn:setButtonClick(function()self:onZhuanquBtn()end)
self.bt={
["close"]=self.bt_close,
}



end


function UILoginServerListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.rightPanelOne);self.rightPanelOne=nil;
_UIObject_release(self.rightPanelTwo);self.rightPanelTwo=nil;
_UIObject_release(self.rightPanelThree);self.rightPanelThree=nil;
_UIObject_release(self.bt_close);self.bt_close=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.zhuanquBtn);self.zhuanquBtn=nil;
_UIObject_release(self.zhuanquName);self.zhuanquName=nil;
self.bt=nil;
end















local _lastStamp=0
local _tuijianStamp=0
local _roleStamp=0
local _zoneStamp=0
local _stampPageTemp={}
local _requestSpace=30
local _this

local _cmp_right_index=
{
cmp_flag0=0,
cmp_servername=1,
cmp_recommend=2,
cmp_flag1=3,
cmp_flag2=4,
cmp_severtime=5,
whimg=6,
cmp_severid=7,
cmp_back=8,
}

local _cmp_right_2_index=
{
cmp_head=0,
cmp_level=1,
cmp_name=2,
cmp_flag0=3,
cmp_servername=4,
cmp_flag1=5,
cmp_flag2=6,
cmp_back=7,
}

local _cmp_left_index=
{
cmp_bg=0,
cmp_name=1,
cmp_select=2,
cmp_hot=3,
cmp_bg_2=4,
cmp_select_2=5,
}

local _fixTabIdx=
{
loginSeverType.eRole,
loginSeverType.eLast,
loginSeverType.eTuijian,
loginSeverType.eZone
}
local abname1='ui/windows/login/sharedtextures/image_denglufuui_1.ab'
local abname2='ui/windows/login/sharedtextures/image_denglufuui_2.ab'
local abname3='ui/windows/login/sharedtextures/image_denglufuui_3.ab'
local tabConfig={}
local _div=#_fixTabIdx
local _themediv=0
local _themeTabList={}
if deviceHelper.isRunNoneOrEditor()then
tabConfig=
{
[loginSeverType.eRole]=
{
name='角色',
},
[loginSeverType.eLast]=
{
name='最近',
},
[loginSeverType.eTuijian]=
{
name='推荐',
},
[loginSeverType.eZone]=
{
name='大区',
},
}
_div=_div-1
else
_fixTabIdx=
{
loginSeverType.eRole,
loginSeverType.eLast,
loginSeverType.eTuijian,
}
_div=#_fixTabIdx

tabConfig=
{
[loginSeverType.eRole]=
{
name='已有角色',
request=function(force)
local stamp=os.time()
local lastStamp=_roleStamp or 0
if force or lastStamp==0 or stamp>=(lastStamp+_requestSpace)then
_roleStamp=stamp
return loginControl:requestRoleServerList()
end
return false
end,
},
[loginSeverType.eLast]=
{
name='最近',
request=function(force)
local stamp=os.time()
local lastStamp=_lastStamp or 0
if force or lastStamp==0 or stamp>=(lastStamp+_requestSpace)then
_lastStamp=stamp
loginControl:requestTuiJianServer()
return loginControl:requestLastServerList()
end
return false
end
},
[loginSeverType.eTuijian]=
{
name='推荐',
request=function(force)
local stamp=os.time()
local lastStamp=_lastStamp or 0
if force or lastStamp==0 or stamp>=(lastStamp+_requestSpace)then
_lastStamp=stamp
loginControl:requestLastServerList()
return loginControl:requestTuiJianServer()
end
return false
end
},
}
end

local _tabConfig={}
for i,v in ipairs(_fixTabIdx)do
_tabConfig[i]=tabConfig[v]
_tabConfig[i].typo=v
end

if deviceHelper.isRunNoneOrEditor()then
_tabConfig[loginSeverType.eZone]=nil

local themeList=loginModel:getThemeSeverInfo()
local themeTabList={}
local pfid=loginModel:getPfid()
for i,v in ipairs(themeList)do
local index=#_tabConfig
local themeTab={
name=(v.spname~=nil and v.spname[pfid]~=nil)and v.spname[pfid]or v.name,
typo=loginSeverType.eTheme,
config=v,
freshTime=timeHelper.timeServer(v.time[1],v.time[2],v.time[3],v.time[4],v.time[5],v.time[6])
}
_tabConfig[index+1]=themeTab
themeTabList[#themeTabList+1]=themeTab
end
_themeTabList=themeTabList
_themediv=#themeList

for i,v in ipairs(loginLocal.tabConfigs)do
local index=#_tabConfig
_tabConfig[index+1]=v
end
end

local _requestTuiJian=function(page,zoneid,force)
local stamp=os.time()
local lastStamp=_stampPageTemp[page]or 0
if force or lastStamp==0 or stamp>=(lastStamp+_requestSpace)then
_stampPageTemp[page]=stamp
loginControl:requestZoneServerList(page,zoneid)
return true
end
return false
end

local _getServerType=function(index)
if index==nil then return end
local severType=_fixTabIdx[index]
if severType and severType~=loginSeverType.eZone then
return severType
else
return loginSeverType.eZone,index-_div-_themediv
end
end

local _getServerList=function(index)
if index==nil then return end
local servertypo,page=_getServerType(index)
if servertypo==loginSeverType.eRole then
return loginModel:getRoleServerList()
elseif servertypo==loginSeverType.eLast then
return loginModel:getLastServerList()
elseif servertypo==loginSeverType.eTuijian then
return loginModel:getTuiJianServerList()
else
return loginModel:getZoneServerList(page)
end
end

local threedaytime=86400*3


function UILoginServerListWin:onLoaded(...)
self:bindComponents()
_this=self

local _onClickCallLeftCallback=function(...)
self:onClickLeftCallback(...)
end
self.leftPanel:setChildScrollViewInit(0.5,true,_onClickCallLeftCallback,nil)

local _onClickRightItemOneCallBack=function(...)
self:onClickRightItemOneCallBack(...)
end
self.rightPanelOne:setChildScrollViewInit(0.5,true,_onClickRightItemOneCallBack,nil)

local _onClickRightItemTwoCallBack=function(...)
self:onClickRightItemTwoCallBack(...)
end
self.rightPanelTwo:setChildScrollViewInit(0.5,true,_onClickRightItemTwoCallBack,nil)

local _onClickRightItemThreeCallBack=function(...)
self:onClickRightItemThreeCallBack(...)
end
self.rightPanelThree:setChildScrollViewInit(0.5,true,_onClickRightItemThreeCallBack,nil)



self.defaultSelectIndex=_div

self._freshServerList=function(...)
self:freshServerList(...)
end
notifySystem:listenNotify(notifyConfig.serverListFresh,self._freshServerList)
loginControl:reportOpenServerList()
_lastStamp=0
_roleStamp=0
_zoneStamp=0
_tuijianStamp=0
_stampPageTemp={}
self.tabConfig={}
end


function UILoginServerListWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.serverListFresh,self._freshServerList)
end

function UILoginServerListWin:onShow(argtable,afterOnloaded)
if deviceHelper.isRunNoneOrEditor()then
self.themeTabList=_themeTabList
if _themediv>0 then
self:startTimer()
end
self.selectIndex=self.defaultSelectIndex
self.tabConfig=_tabConfig
self:freshInfo()
else
self:freshServerZoneInfo()
end
end

function UILoginServerListWin:onHide()

end


function UILoginServerListWin:freshSelectServer()
UIManager:invokeUIMethod('UILogin','showServerObj')
end

function UILoginServerListWin:freshInfo()
self:freshLeftGrids()
self:freshRightGrids()
end



function UILoginServerListWin:freshLeftGrids()

local dataNum=#self.tabConfig

self.leftPanel:setChildScrollViewCreateGrids(dataNum,1)
self:freshLeftInfo()
end

function UILoginServerListWin:freshLeftInfo()

local dataNum=#self.tabConfig
if dataNum>0 then
local grids=self.leftPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local info=self.tabConfig[i]
local isSelect=self.selectIndex==i
local name=info.name

item:SetChildText(_cmp_left_index.cmp_name,name)
item:SetChildActive(_cmp_left_index.cmp_bg,not isSelect)
item:SetChildActive(_cmp_left_index.cmp_select,isSelect)

item:SetChildActive(_cmp_left_index.cmp_hot,info.typo==loginSeverType.eTheme)
item:SetChildActive(_cmp_left_index.cmp_bg_2,info.typo==loginSeverType.eTheme)
item:SetChildActive(_cmp_left_index.cmp_select_2,info.typo==loginSeverType.eTheme)
end
end
end

function UILoginServerListWin:freshRightGridsOne(listData)
local dataNum=#(listData or{})
self.rightPanelOne:setChildScrollViewCreateGrids(dataNum,4)
if dataNum>0 then
local grids=self.rightPanelOne:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local data=listData[i]
local sid=data.show_sid
local status=data.status
local statusType=loginConfig.getStatusType(status)
local name=data.name
local isTuijian=statusType==1
local online=data.online
local item=grids[i-1]

item:SetChildActive(_cmp_right_index.cmp_severtime,false)
if online then
local localtime=loginModel:getServerCurTimestamp()
platformSDK.printSDK(FMT.fmt('当前时间：{0} 开服时间：{1}',localtime,online))
if localtime and localtime>online then
local isthreedays=(localtime-online)<threedaytime
if online>0 and isthreedays then
local y,m,d=timeHelper.getServerStampData(online)
local strtime=FMT.fmt('[{0}月{1}日开服]',tonumber(m),tonumber(d))
if pfwindowslController:checkIsGameVersion_yuenan()then
strtime=FMT.fmt('{0}/{1}/{2} mở',tonumber(d),tonumber(m),tonumber(y))
end
item:SetChildActive(_cmp_right_index.cmp_severtime,true)
item:SetChildText(_cmp_right_index.cmp_severtime,strtime)
end
end
end

local isNomal=statusType~=2 and statusType~=3
item:SetChildActive(_cmp_right_index.cmp_flag0,isNomal)
item:SetChildActive(_cmp_right_index.cmp_flag1,statusType==2)
item:SetChildActive(_cmp_right_index.cmp_flag2,statusType==3)
item:SetChildActive(_cmp_right_index.whimg,statusType==3)
if statusType==2 then
item:SetChildCSImageSprite(_cmp_right_index.cmp_back,abname2,'image_denglufuui_2')
elseif statusType==3 then
item:SetChildCSImageSprite(_cmp_right_index.cmp_back,abname3,'image_denglufuui_3')
item:SetChildActive(_cmp_right_index.cmp_severtime,false)
else
item:SetChildCSImageSprite(_cmp_right_index.cmp_back,abname1,'image_denglufuui_1')
end

local name_str=name
item:SetChildText(_cmp_right_index.cmp_servername,name_str)



item:SetChildActive(_cmp_right_index.cmp_recommend,isTuijian)
end
end
end

function UILoginServerListWin:freshRightGridsTwo(listData)
local dataNum=#(listData or{})
self.rightPanelTwo:setChildScrollViewCreateGrids(dataNum,4)
if dataNum>0 then
local grids=self.rightPanelTwo:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local data=listData[i]
local sid=data.show_sid
local status=data.status
local actorIcon=data.actorIcon
local statusType=loginConfig.getStatusType(status)
local actorName=data.actorName
local name=data.name
local level=data.actorLevel or 1

local item=grids[i-1]


if actorIcon~=nil then
local headKuang,headicon=mathHelper.splitToInt16(actorIcon)
local icon=iconHelper.getHeadIcon(playerModel:getActorIconById(headicon))

item:SetChildCSImageIcon(_cmp_right_2_index.cmp_head,icon,false)
else
local headicon=cfgHelper.get2(cfg_headportraitconfig_get,1,'icon')
local icon=iconHelper.getHeadIcon(playerModel:getActorIconById(headicon))
item:SetChildCSImageIcon(_cmp_right_2_index.cmp_head,icon,false)
end


item:SetChildText(_cmp_right_2_index.cmp_level,level or 1)

if deviceHelper.isRunEditor()then
local ip_text=data.server_ip_string
local servername,sid,ip,port,status=string.match(ip_text,loginModel.matchStr)
actorName=FMT.fmt('{0}_{1}',servername,data.userid or'')
end
item:SetChildText(_cmp_right_2_index.cmp_name,actorName)

local isNomal=statusType~=2 and statusType~=3
item:SetChildActive(_cmp_right_2_index.cmp_flag0,isNomal)
item:SetChildActive(_cmp_right_2_index.cmp_flag1,statusType==2)
item:SetChildActive(_cmp_right_2_index.cmp_flag2,statusType==3)
if statusType==2 then
item:SetChildCSImageSprite(_cmp_right_2_index.cmp_back,abname2,'image_denglufuui_2')
elseif statusType==3 then
item:SetChildCSImageSprite(_cmp_right_2_index.cmp_back,abname3,'image_denglufuui_3')
else
item:SetChildCSImageSprite(_cmp_right_2_index.cmp_back,abname1,'image_denglufuui_1')
end

item:SetChildText(_cmp_right_2_index.cmp_servername,name)
end
end
end

function UILoginServerListWin:freshRightGridsThree(data)
local config=data.config

local openTime=config.time
local dataNum=config.server
local pfid=loginModel:getPfid()
local name=(config.spname~=nil and config.spname[pfid]~=nil)and config.spname[pfid]or config.name
self.rightPanelThree:setChildScrollViewCreateGrids(dataNum,4)
local time=data.freshTime
if dataNum>0 then
local grids=self.rightPanelThree:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local name=name..i..'服'
local item=grids[i-1]


item:SetChildText(_cmp_right_index.cmp_servername,name)
time=math.ceil(time/86400)*86400
local y,m,d=timeHelper.getServerStampData(time)
local strtime=FMT.fmt('[{0}月{1}日开服]',m,d)
if pfwindowslController:checkIsGameVersion_yuenan()then
strtime=FMT.fmt('{0}/{1}/{2} mở',tonumber(d),tonumber(m),tonumber(y))
end
item:SetChildActive(_cmp_right_index.cmp_severtime,true)
item:SetChildText(_cmp_right_index.cmp_severtime,strtime)

item:SetChildActive(_cmp_right_index.cmp_flag0,false)
item:SetChildActive(_cmp_right_index.cmp_flag1,false)
item:SetChildActive(_cmp_right_index.cmp_flag2,false)
item:SetChildActive(_cmp_right_index.whimg,false)
item:SetChildActive(_cmp_right_index.cmp_recommend,false)
end
end
end


function UILoginServerListWin:freshRightGrids()
local selectIndex=self.selectIndex
local selectTypo,page=_getServerType(selectIndex)
local info=self.tabConfig[selectIndex]
if info and info.typo==loginSeverType.eTheme then
selectTypo=info.typo
end
if selectTypo==loginSeverType.eRole then

local list=loginModel:getRoleServerList()
self.list=list
self.rightPanelOne:setActive(false)
self.rightPanelTwo:setActive(true)
self.rightPanelThree:setActive(false)
self:freshRightGridsTwo(list)
elseif selectTypo==loginSeverType.eTheme then
self.rightPanelOne:setActive(false)
self.rightPanelTwo:setActive(false)
self.rightPanelThree:setActive(true)
local list=info
self.list=list
self:freshRightGridsThree(list)
else
self.rightPanelOne:setActive(true)
self.rightPanelTwo:setActive(false)
self.rightPanelThree:setActive(false)
local list
if selectTypo==loginSeverType.eLast then
list=loginModel:getLastServerList()
elseif selectTypo==loginSeverType.eTuijian then
list=loginModel:getTuiJianServerList()
else
list=loginModel:getZoneServerList(page)
end
self.list=list
self:freshRightGridsOne(list)
end
end


function UILoginServerListWin:onClickLeftCallback(clicknum,i)
local index=i+1
if deviceHelper.isRunSDK()then
self:onSelectNomal(index)
else
self:onSelectEditor(index)
end
end


function UILoginServerListWin:onClickRightItemOneCallBack(clicknum,i)
if loginControl:isBuildConnect()or socketManager.connecting then
UIManager.info("正在连接服务器")
return
end
local index=i+1
local info=self.list[index]
local ip_text=info.server_ip_string
local name,sid,ip,port,status=string.match(ip_text,loginModel.matchStr)
loginModel:selectSever(name,sid,ip,port,status)
self:freshSelectServer()
self:closeSelf()
end


function UILoginServerListWin:onClickRightItemTwoCallBack(clicknum,i)
if loginControl:isBuildConnect()or socketManager.connecting then
UIManager.info("正在连接服务器")
return
end
local index=i+1
local info=self.list[index]

local ip_text=info.server_ip_string

local name,sid,ip,port,status=string.match(ip_text,loginModel.matchStr)
if deviceHelper.isRunNoneOrEditor()then
loginModel:setUserId(tostring(info.userid))
UIManager:callWindowFunc('UILogin','showUserName')
end
loginModel:selectSever(name,sid,ip,port,status)
self:freshSelectServer()
self:closeSelf()
end

function UILoginServerListWin:onClickRightItemThreeCallBack(clicknum,i)
local info=self.list
local config=info.config
local openTime=config.time
local time=info.freshTime
time=math.ceil(time/86400)*86400
local y,m,d=timeHelper.getServerStampData(time)
UIManager.info(FMT.fmt("活动区服将于{0}月{1}日开启，敬请期待",tonumber(m),tonumber(d)))
end



function UILoginServerListWin:freshServerZoneInfo()
if deviceHelper.isRunNoneOrEditor()then return end
local stamp=os.time()
local serverZoneInfo=loginModel:getServerZoneInfo()
if serverZoneInfo==nil then
_zoneStamp=stamp
_stampPageTemp={}
loginControl:requestZoneServerInfo()
return
end

local lastStamp=_zoneStamp or 0
if lastStamp==0 or stamp>=(lastStamp+_requestSpace)then
_zoneStamp=stamp
_stampPageTemp={}
loginControl:requestZoneServerInfo()
return
end

self.tabConfig={}
local tabConfig=self.tabConfig

for i,v in ipairs(_tabConfig)do
tabConfig[#tabConfig+1]=v
end

local pfid=loginModel:getPfid()
local themeList=loginModel:getThemeSeverInfo()
local themeTabList={}
for i,v in ipairs(themeList)do
local index=#tabConfig
local themeTab={
config=v,
name=(v.spname~=nil and v.spname[pfid]~=nil)and v.spname[pfid]or v.name,
typo=loginSeverType.eTheme,
freshTime=timeHelper.timeServer(v.time[1],v.time[2],v.time[3],v.time[4],v.time[5],v.time[6]),
request=function()
return false
end,
}
tabConfig[index+1]=themeTab
themeTabList[#themeTabList+1]=themeTab
end
_themediv=#themeList
self.themeTabList=themeTabList


for i,v in ipairs(serverZoneInfo)do
tabConfig[#tabConfig+1]=
{
name=v.zone_name,
request=function(force)
return _requestTuiJian(i,v.zone_id,force)
end,
typo=loginSeverType.eZone,
}
end
self.zoneLen=#serverZoneInfo
self:freshLeftGrids()
self:freshSelect()
end

function UILoginServerListWin:freshSelect()
local index=self.selectIndex or self.defaultSelectIndex
self:onSelectNomal(index)
end

function UILoginServerListWin:startTimer()
self:stopTimer()
local func=function()
if self.themeTabList then
local sStamp=loginModel:getServerRealCurTimestamp()
if not sStamp then sStamp=os.time()end
for i,v in ipairs(self.themeTabList)do
if v.freshTime and sStamp>=v.freshTime+_requestSpace then
if deviceHelper.isRunNoneOrEditor()then
self:freshEditorList()
else
if _zoneStamp then
_zoneStamp=_zoneStamp-_requestSpace
end
self.selectIndex=self.defaultSelectIndex
self:freshServerZoneInfo()
end
self:stopTimer()
break
end
end
end
end
self.checkTimer=self:setTimer(1,0,func)
end

function UILoginServerListWin:stopTimer()
if self.checkTimer then
self:stopTimerByID(self.checkTimer)
self.checkTimer=nil
end
end

function UILoginServerListWin:freshEditorList()
if deviceHelper.isRunNoneOrEditor()then
_tabConfig={}
for i,v in ipairs(_fixTabIdx)do
_tabConfig[i]=tabConfig[v]
_tabConfig[i].typo=v
end
_tabConfig[loginSeverType.eZone]=nil
local pfid=loginModel:getPfid()
local themeList=loginModel:getThemeSeverInfo()
local themeTabList={}
for i,v in ipairs(themeList)do
local index=#_tabConfig
local themeTab={
name=(v.spname~=nil and v.spname[pfid]~=nil)and v.spname[pfid]or v.name,
typo=loginSeverType.eTheme,
config=v,
freshTime=timeHelper.timeServer(v.time[1],v.time[2],v.time[3],v.time[4],v.time[5],v.time[6])
}
_tabConfig[index+1]=themeTab
themeTabList[#themeTabList+1]=themeTab
end
self.themeTabList=themeTabList
_themediv=#themeList
for i,v in ipairs(loginLocal.tabConfigs)do
local index=#_tabConfig
_tabConfig[index+1]=v
end
if _themediv>0 then
self:startTimer()
end
self.selectIndex=self.defaultSelectIndex
self.tabConfig=_tabConfig
self:freshInfo()
end
end


function UILoginServerListWin:onSelectNomal(index)

if self.selectIndex==index then return end
self.selectIndex=index

local max=#self.tabConfig
if index>=max then
self.selectIndex=max
index=max
end

self:freshLeftInfo()
self:freshSelectServerList(index)
end

function UILoginServerListWin:freshSelectServerList(index)
local servertypo,page=_getServerType(index)
local serverList=_getServerList(index)
local info=self.tabConfig[index]
if info.request(serverList==nil)then
return
end
self:freshRightGrids()
end

function UILoginServerListWin:onfreshPageServerList(page)
local servertypo,selectpage=_getServerType(self.selectIndex)
if selectpage~=page then return end
self:freshRightGrids()
end


function UILoginServerListWin:onfreshServerZone()
local serverZoneInfo=loginModel:getServerZoneInfo()
local len=#(serverZoneInfo or{})
if len~=self.zoneLen then
local zoneLen=self.zoneLen
self.zoneLen=len
if zoneLen and zoneLen>0 then
self.selectIndex=nil
end
self:freshServerZoneInfo()
end
end


function UILoginServerListWin.freshServerList()
if not _this or _this.isClose then return end
if _this.selectIndex==nil then _this.selectIndex=_this.defaultSelectIndex end
local servertypo=_getServerType(_this.selectIndex)
if servertypo~=loginSeverType.eLast then return end
if _this then
_this:freshRightGrids()
end
end

function UILoginServerListWin:onfreshRoleServerList()
if deviceHelper.isRunNoneOrEditor()then return end
local servertypo,selectpage=_getServerType(self.selectIndex)
if servertypo~=loginSeverType.eRole then return end
if _this then
_this:freshRightGrids()
end
end

function UILoginServerListWin:onfreshTuiJianServerList()
if deviceHelper.isRunNoneOrEditor()then return end
local servertypo,selectpage=_getServerType(self.selectIndex)
if servertypo~=loginSeverType.eTuijian then return end
if _this then
_this:freshRightGrids()
end
end



function UILoginServerListWin:onSelectEditor(index)
if deviceHelper.isRunSDK()then return end
if self.selectIndex==index then return end
self.selectIndex=index
self:freshInfo()
end

function UILoginServerListWin:onClickClose()
self:closeSelf()
end

function UILoginServerListWin:onZhuanquBtn()

end