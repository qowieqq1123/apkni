







def_class("UIXJCaravanEscort_recordWin",UIWindowBase)









function UIXJCaravanEscort_recordWin:bindComponents()

self.checkTxt=UIText.get(self,0)
self.itemGridPanel=UIObject.get(self,1)
self.itemScrollView=UIObject.get(self,2)
self.logGridPanel=UIObject.get(self,3)
self.LogScrollView=UILoopListView.new(self,4)
self.notLog=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.tips=UIButton.get(self,7)
self.tipsText=UIText.get(self,8)
self.closeBtn=UIButton.get(self,9)
self.clickMask=UIButton.get(self,10)

self.LogScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.tips:setButtonClick(function()self:onTips()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UIXJCaravanEscort_recordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.checkTxt);self.checkTxt=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.logGridPanel);self.logGridPanel=nil;
self.LogScrollView:deleteSelf();self.LogScrollView=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
end
















local itemCmp=
{
deac=2,
time1=7,
reward_flag=8,
new=9,
smallType=11,
middleType=12,
itemroot=13,
itemlist={14,15,16,17,18,19,20,28,29,30,31,32},
itembg=21,
logtips=22,
gotoroot=23,
timeback2=24,
time2=25,
openjijie=26,
opentext=27,
xjrzpanel=33,
xjtcpanel=34,
title_tc=35,
desc_tc=36,
time_tc=37,
middleType_tc=38,
tc_seeBtn=39,
tc_gotoBtn=40,
}
local this
local icontype=
{
[1]="image_pqjsshengbai_1",
[2]="image_pqjsshengbai_2",
}
local abname="ui/windows/xianmeng/act_zhengzhanshanhai/zhengzhanshanhaiicons_atlas_pak.ab"
local abname_arena="ui/windows/xianjiearenaact/xianjiearena_atlas_pak.ab"
local xjabname="ui/windows/xianjie/chongjianxianyu_atlas_pak.ab"
local cjson=require'cjson'




function UIXJCaravanEscort_recordWin:onLoaded(...)
self:bindComponents()
local id=self.LogScrollView:getID()
this=self
self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UIXJCaravanEscort_recordWin:__delete()
this=nil
self:unbindComponents()
end




function UIXJCaravanEscort_recordWin:onShow(argtable,afterOnloaded)
self.shipGuid=argtable and argtable.shipGuid
self.startTime=argtable and argtable.startTime
self.shipId=argtable and argtable.shipId
self.isOpenWithMainWin=argtable and argtable.isOpenWithMainWin
self.logList=xianJieCaravanEscortModel:getSelfEscortShipLogList(self.shipGuid,self.startTime,self.shipId)

self:RefreshWin()
end


function UIXJCaravanEscort_recordWin:onHide()

end

function UIXJCaravanEscort_recordWin:onStartAction(index,widget)

end

function UIXJCaravanEscort_recordWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end


function UIXJCaravanEscort_recordWin:splitStr(str)
return cjson.decode(str)
end


function UIXJCaravanEscort_recordWin:RefreshWin()
local itemIdList={}
local mxslSingletb=self.logList
local logCount=#mxslSingletb
self.LogScrollView:initData("xjlog_Item",itemIdList)
if next(mxslSingletb)then
self.notLog:setActive(false)
for i=1,logCount do
itemIdList[i]=i
end
self.LogScrollView:initData("xjlog_Item",itemIdList)
local nowShowItemCount=self.logGridPanelCmp.ShownItemCount
for i=0,nowShowItemCount-1 do
local item=self.logGridPanelCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshItem(item.Widget,index)
end
end
else
self.notLog:setActive(true)
end
self.tipsText:setText(string.format("相关日志数量：<color=%s>%d</color>",logCount<100 and"#549327"or"#c82c2c",logCount))
end


function UIXJCaravanEscort_recordWin:refreshItem(item,idx)
if item==nil then
return
end
local datatb=self.logList[idx]
local cfgid=datatb.logtype
local config=cfgHelper.get1(cfg_fairylandlogconfig_get,cfgid)
local str_cfg=config.str
local islose=config.islose
local handletype=config.handletype or 0
item:SetChildActive(itemCmp.gotoroot,false)
self:setRiZhiInfo(item,cfgid,datatb,str_cfg,handletype)

self:Set_BigType(item,cfgid)
self:Set_Reward(item,datatb.len,datatb.list,datatb.recv,islose)
self:SetFightBtn(item,datatb,idx)
self:Set_Righttop(item,datatb)
item:SetChildActive(itemCmp.openjijie,false)
end


function UIXJCaravanEscort_recordWin:Set_BigType(item,cfgid)

local showBigIconTypeList_victory={
[35]=true,[37]=true,[39]=true,[41]=true,
[47]=true,[49]=true,[51]=true,
}
local showBigIconTypeList_lose={
[36]=true,[38]=true,[40]=true,
[48]=true,[50]=true,[52]=true,
}
local isShowBigIcon_victory=showBigIconTypeList_victory[cfgid]
local isShowBigIcon_lose=showBigIconTypeList_lose[cfgid]
if isShowBigIcon_victory then

item:SetChildCSImageSprite(itemCmp.middleType,globalABLookup.global,icontype[1])
elseif isShowBigIcon_lose then

item:SetChildCSImageSprite(itemCmp.middleType,globalABLookup.global,icontype[2])
end


local isUseArenaAbTypeList={
[39]=true,[41]=true,
[51]=true,
}
local iconAbName=abname
if isUseArenaAbTypeList[cfgid]then
iconAbName=abname_arena
end
item:SetChildCSImageSprite(itemCmp.smallType,iconAbName,cfgHelper.get2(cfg_fairylandlogconfig_get,cfgid,"small_type"))
end


function UIXJCaravanEscort_recordWin:Set_Reward(item,len,list,recv,islose)
if len>0 and list then
item:SetChildActive(itemCmp.itembg,true)
if islose and islose==1 then
item:SetChildCSImageSprite(itemCmp.itembg,abname,"image_typaiqianzjui_5")
end
item:SetChildActive(itemCmp.itemroot,true)
table.sort(list,function(a,b)
local itemConfig=itemsConfig.getConfig(a.param_1)
local color=itemConfig.color
local itemConfig2=itemsConfig.getConfig(b.param_1)
local color2=itemConfig2.color
return color>color2
end)

for k,v in ipairs(list)do
if itemCmp.itemlist[k]then
local rwItem=item:GetChildWidgetBase(itemCmp.itemlist[k])
rwItem:SetChildActive(11,true)
local itemid=v.param_1
local itemnum=v.param_2
local itemcount,showCountBG
if itemnum>1 then
itemcount=mathHelper.formatNumber(itemnum,false)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildActive(11,true)
rwItem:SetChildPropData(11,prop)
rwItem:SetBaseItemClickEvent(11,function(...)
itemsComponentHelper.onItemClickEx(v.param_1)
end)
rwItem:SetChildActive(12,recv==0)
end
end
else
item:SetChildActive(itemCmp.itembg,false)
item:SetChildActive(itemCmp.itemroot,false)
end
end


function UIXJCaravanEscort_recordWin:SetFightBtn(item,datatb,idx)
local have_huifang=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"have_huifang")
local isyuanjun=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"isyuanjun")
if have_huifang or isyuanjun then
if have_huifang then
local logtb=self:splitStr(datatb.params)
local reportId=tostring(logtb[have_huifang])
if reportId==""then
item:SetChildActive(itemCmp.timeback2,false)
item:SetChildActive(itemCmp.time1,true)
item:SetChildText(itemCmp.time1,timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
else
local jianbaotxt=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"jianbaotxt")
item:SetChildActive(itemCmp.timeback2,true)
if jianbaotxt then
item:SetChildCSImageSprite(itemCmp.timeback2,xjabname,"button_zhandoujianbao_1")
else
item:SetChildCSImageSprite(itemCmp.timeback2,xjabname,"button_zhandouxiangqing_1")
end
item:SetChildActive(itemCmp.time1,false)
item:SetChildText(itemCmp.time2,timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))

local huifang_txt=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"huifang_txt")
local is_win=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"is_win")
local _timetxt=timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(),timeHelper.convertLongStamp(tonumber(datatb.sec)))
_timetxt=FMT.fmt("战斗简报时间：{0}",_timetxt)
local _rijbdata=this.rijbdata
local isOpenWithMainWin=self.isOpenWithMainWin
local shipGuid=self.shipGuid
local _fun=function(fightLoglist)
local fightLog=fightLoglist[1]
local _fightInfo=fightModel:getJsonReport(fightLog)
local temp=
{
win=is_win,
yunjun=false,
cfgid=datatb.logtype,
fightInfo=_fightInfo,
timetxt=_timetxt,
fightarry={
reportId,
{nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,eReplayType=eRePlayerType.xianjielog,
isMXSL=true,isOpenWithMainWin=isOpenWithMainWin,shipGuid=shipGuid,
}
},
rijbdata=_rijbdata,
}
this:showWindow('UIXianJie_notejianbao',temp)
end
local fightLogType=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"fightLogType")
item:SetChildButtonClick(itemCmp.timeback2,function()
local win=UIManager:findActiveWindow("UITianShuDaZhenWin")
if win then
local enterCallBack=function()
xianjieController:OpenZhengZhanShanHaiMonsterLog()
end
xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,enterCallBack)
else
if jianbaotxt then
local args={nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,extraCall=_fun,
isMXSL=true,isOpenWithMainWin=isOpenWithMainWin,shipGuid=shipGuid,}
if fightLogType==1 then
fightController:send_log_list({reportId},args)
elseif fightLogType==2 then
fightController:send_log_list({reportId},args,true)
elseif fightLogType==3 then
fightController:send_log_list({reportId},args,nil,true)
end
else
local args={nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,eReplayType=eRePlayerType.xianjielog,
isMXSL=true,isOpenWithMainWin=isOpenWithMainWin,shipGuid=shipGuid,}
if fightLogType==1 then
fightController:send_log_list({reportId},args)
elseif fightLogType==2 then
fightController:send_log_list({reportId},args,true)
elseif fightLogType==3 then
fightController:send_log_list({reportId},args,nil,true)
end
end
end
end)
end
end
if isyuanjun then
item:SetChildActive(itemCmp.timeback2,true)
item:SetChildCSImageSprite(itemCmp.timeback2,xjabname,"button_yuanjunjianbao_1")
item:SetChildActive(itemCmp.time1,false)
item:SetChildText(itemCmp.time2,timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
item:SetChildButtonClick(itemCmp.timeback2,function()

local win=UIManager:findActiveWindow("UITianShuDaZhenWin")
if win then
local enterCallBack=function()
xianjieController:OpenZhengZhanShanHaiMonsterLog()
end
xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,enterCallBack)
else
self:showjijie(datatb.guid)
end
end)
end
else
item:SetChildActive(itemCmp.timeback2,false)
item:SetChildActive(itemCmp.time1,true)
item:SetChildText(itemCmp.time1,
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))

item:SetChildActive(itemCmp.time_tc,true)
item:SetChildText(itemCmp.time_tc,
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
end
end


function UIXJCaravanEscort_recordWin:Set_Righttop(item,datatb)

item:SetChildActive(itemCmp.new,false)
if datatb.len>0 then
local cfgid=datatb.logtype
local config=cfgHelper.get1(cfg_fairylandlogconfig_get,cfgid)
local str_cfg=config.str
local isloseFlag=config.islose
local islose=isloseFlag and isloseFlag==1 or false

item:SetChildActive(itemCmp.reward_flag,datatb.recv==1 and not islose)
else
item:SetChildActive(itemCmp.reward_flag,false)
end
end


function UIXJCaravanEscort_recordWin:showjijie(guid)

local zbdata=xianjieModel:GetJiJie_Databy(guid)
if zbdata then
self:showWindow("UIXianJie_noteJiJie",{guid})
else
xianjieController:reqXianJieJiJieFightLog(guid)
end
end


function UIXJCaravanEscort_recordWin:setRiZhiInfo(item,cfgid,datatb,str_cfg,handletype)
if cfgid>=3 then
item:SetChildActive(itemCmp.xjrzpanel,true)
item:SetChildActive(itemCmp.xjtcpanel,false)
local logtxt=self:SetStr(str_cfg,item,datatb.params,cfgid,handletype)
xpcall(function()
item:SetChildText(itemCmp.deac,logtxt)
end,function(err)
item:SetChildText(itemCmp.deac,"暂无信息")
end)
end
end


function UIXJCaravanEscort_recordWin:SetStr(str_cfg,item,json_str,cfgid,handletype)
local str_2="暂无信息"
local str_1=FMT.fmt("                        {0}",str_cfg)
local tbstr=self:splitStr(json_str)
self.rijbdata={}


local common_convert=cfgHelper.get2(cfg_fairylandlogconfig_get,cfgid,"common_convert")
if common_convert then
for i,v in pairs(common_convert)do
if tbstr[i]then
if v==1 then
local number=mathHelper.int64_to_number(int64.new(tbstr[i]))

tbstr[i]=mathHelper.formatNumber(number)
end
end
end
end

if handletype==22 then
xpcall(function()
str_2=FMT.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
end



return str_2
end





function UIXJCaravanEscort_recordWin:onTips()
local langId=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1,"logHelpLangId")or''
local d={}
d.title='规则说明'
d.mode=3
d.showBlack=true
d.name=langId
self:showWindow('UIRuleWin',d)
end



function UIXJCaravanEscort_recordWin:onCloseBtn()
self:closeSelf()
end


function UIXJCaravanEscort_recordWin:onClickMask()
return self:onCloseBtn()
end

