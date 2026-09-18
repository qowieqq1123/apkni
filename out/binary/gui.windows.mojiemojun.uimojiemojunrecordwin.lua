







def_class("UIMoJieMoJunRecordWin",UIWindowBase)









function UIMoJieMoJunRecordWin:bindComponents()

self.logGridPanel=UIObject.get(self,0)
self.LogScrollView=UILoopListView.new(self,1)
self.notLog=UIObject.get(self,2)

self.LogScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIMoJieMoJunRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.logGridPanel);self.logGridPanel=nil;
self.LogScrollView:deleteSelf();self.LogScrollView=nil;
_UIObject_release(self.notLog);self.notLog=nil;
end
















local _this
local cjson=require'cjson'
local string_gsub=string.gsub
local _abname="ui/windows/mojiemojun/mojiemojun_atlas_pak.ab"




function UIMoJieMoJunRecordWin:onLoaded(...)
self:bindComponents()
local id=self.LogScrollView:getID()
_this=self
self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UIMoJieMoJunRecordWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieMoJunRecordWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id

xianjieController:reqMoJunFightRecordList(self.seasonType,self.stageIndex)

self:updataView()
end

function UIMoJieMoJunRecordWin:updataView()
self:updataData()
self:RefreshWin()
end

function UIMoJieMoJunRecordWin:updataData()
xianjieModel:loadRecord_MoJun()
self.data=xianjieModel:getMoJunRecord(self.seasonType,self.stageIndex)
xianjieModel:saveRecord_MoJun()
end

function UIMoJieMoJunRecordWin:RefreshWin()
local itemIdList={}
local resourcetb=self.data
self.LogScrollView:initData("xjlog_Item",itemIdList)
if resourcetb and next(resourcetb)then
for i=1,#resourcetb do
itemIdList[i]=i
end
self.maxLen=#itemIdList
self.LogScrollView:initData("xjlog_Item",itemIdList)
local nowShowItemCount=self.logGridPanelCmp.ShownItemCount
for i=0,nowShowItemCount-1 do
local item=self.logGridPanelCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshItem(item.Widget,index)
end
end
end
self.notLog:setActive(not resourcetb or not next(resourcetb))
self.LogScrollView:setActive(resourcetb~=nil and next(resourcetb)~=nil)
end

function UIMoJieMoJunRecordWin:refreshItem(item,idx)
if item==nil then

return
end
local index=self.maxLen-idx+1
local log_data=self.data
local logData=log_data[index]

local cfgid=logData.logType
local icon=cfgHelper.get2(cfg_seasonmojunrecordconfig_get,cfgid,"icon")
local str_cfg=cfgHelper.get2(cfg_seasonmojunrecordconfig_get,cfgid,"name")
local logtxt=self:SetStr(str_cfg,item,logData.jsonStr,cfgid)
item:SetChildText(0,logtxt)
item:SetChildCSImageSprite(1,_abname,icon)

local time_str=timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(logData.logTime)))
item:SetChildText(2,time_str)

item:SetChildActive(3,logData.isnew==1)
end


function UIMoJieMoJunRecordWin:onHide()

end

function UIMoJieMoJunRecordWin:onStartAction()

end

function UIMoJieMoJunRecordWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end


function UIMoJieMoJunRecordWin:SetStr(str_cfg,item,json_str,cfgid)
local str_2="暂无信息"
local str_1=str_cfg
local tbstr=self:splitStr(json_str)
self.rijbdata={}

if cfgid==1 then
local serverName=loginModel:getServerName(tbstr[1])
local str=FMT.fmt('[{0}]',serverName)
tbstr[1]=str

local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,tbstr[3])
local namestr=FMT.fmt("【{0}】",buildCfg.name)


tbstr[3]=namestr

tbstr[4]=mathHelper.formatNumber(tbstr[4])

xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif cfgid==2 then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,tbstr[1])
local namestr=FMT.fmt("【{0}】",buildCfg.name)


tbstr[1]=namestr

local number=tbstr[2]/1000000
tbstr[2]=number

xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
end
return str_2
end


function UIMoJieMoJunRecordWin:splitStr(str)
return cjson.decode(str)
end

function UIMoJieMoJunRecordWin.fmt(content,...)
local args={...}
local temp={}
for i,v in ipairs(args)do
temp[tostring(i-1)]=tostring(v)
end
local ret=string_gsub(content,"{(%d+)}",temp)
return ret
end



function UIMoJieMoJunRecordWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end