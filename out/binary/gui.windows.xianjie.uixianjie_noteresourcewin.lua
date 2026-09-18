







def_class("UIXianJie_noteResourceWin",UIWindowBase)









function UIXianJie_noteResourceWin:bindComponents()

self.checkTxt=UIText.get(self,0)
self.clearBtn=UIButton.get(self,1)
self.itemGridPanel=UIObject.get(self,2)
self.itemScrollView=UIObject.get(self,3)
self.logGridPanel=UIObject.get(self,4)
self.LogScrollView=UILoopListView.new(self,5)
self.notLog=UIObject.get(self,6)
self.onekeyBtn=UIButton.get(self,7)
self.onekeyReddot=UIObject.get(self,8)
self.root=UIObject.get(self,9)
self.tips=UIButton.get(self,10)
self.tipsText=UIText.get(self,11)

self.clearBtn:setButtonClick(function()self:onClearBtn()end)

self.LogScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.onekeyBtn:setButtonClick(function()self:onOnekeyBtn()end)

self.tips:setButtonClick(function()self:onTips()end)



end


function UIXianJie_noteResourceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.checkTxt);self.checkTxt=nil;
_UIObject_release(self.clearBtn);self.clearBtn=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.logGridPanel);self.logGridPanel=nil;
self.LogScrollView:deleteSelf();self.LogScrollView=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.onekeyBtn);self.onekeyBtn=nil;
_UIObject_release(self.onekeyReddot);self.onekeyReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
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
itemlist={14,15,16,17,18,19,20,28,29,30,31,32,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62},
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
[1]="icon_typaiqianzjui_1",
[2]="icon_typaiqianzjui_2",
[3]="icon_typaiqianzjui_3",
[4]="image_xingjunxiangqing_12",
[5]="image_xingjunxiangqing_13",
}
local abname="ui/windows/xianmeng/act_zhengzhanshanhai/zhengzhanshanhaiicons_atlas_pak.ab"
local abname_search="ui/windows/xianjie/xianjiemain_investigate_atlas_pak.ab"
local xjabname="ui/windows/xianjie/chongjianxianyu_atlas_pak.ab"
local cjson=require'cjson'
local string_gsub=string.gsub


function UIXianJie_noteResourceWin:onLoaded(...)
self:bindComponents()
local id=self.LogScrollView:getID()
this=self
self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UIXianJie_noteResourceWin:__delete()

if xianjieModel:jude_xianjielog_reddot()~=xianjieModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onXianjieLogReddotChange)
xianjieModel:Set_reddotchangeflag(not xianjieModel:Get_reddotchangeflag())
end
local win3=UIManager:findActiveWindow("UIXianJieFuncStorageWin")
if win3 then
win3:refreshFuncBtn_Log()
end
local win4=UIManager:findActiveWindow("UIFuncStorageWin")
if win4 then
win4:refreshXianJieRiZhi()
end
this=nil
self:unbindComponents()
end


function UIXianJie_noteResourceWin:onHide()
if xianjieModel:jude_xianjielog_reddot()~=xianjieModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onXianjieLogReddotChange)
xianjieModel:Set_reddotchangeflag(not xianjieModel:Get_reddotchangeflag())
end

local win3=UIManager:findActiveWindow("UIXianJieFuncStorageWin")
if win3 then
win3:refreshFuncBtn_Log()
end
end

function UIXianJie_noteResourceWin:onStartAction(index,widget)

end

function UIXianJie_noteResourceWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end

function UIXianJie_noteResourceWin:splitStr(str)
return cjson.decode(str)
end

function UIXianJie_noteResourceWin:onTips()
local d={}
d.title='规则说明'
d.mode=3
d.showBlack=true
d.name='XianJie_log_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXianJie_noteResourceWin:onClearBtn()
local tb=xianjieModel:Find_Resourceguid()
if next(tb)then
xianjieController:reqXianJieLogDelete(#tb,tb)
UIManager.info("已清除日志记录")
end
end

function UIXianJie_noteResourceWin:onOnekeyBtn()
local tb=xianjieModel:Find_ResourceReward()
if next(tb)then
xianjieController:reqXianJieLogReward(#tb,tb)
end
end




function UIXianJie_noteResourceWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
xianjieModel:jude_haveReward()
self:RefreshWin()
xianjieController:refreshUIReddot()
end

function UIXianJie_noteResourceWin:RefreshWin()
xianjieModel:saveRecord_Resource()
local itemIdList={}
local resourcetb=xianjieModel:Get_resourcetb()
self.LogScrollView:initData("xjlog_Item",itemIdList)
if next(resourcetb)then
self.notLog:setActive(false)
self.clearBtn:setActive(true)
for i=1,#resourcetb do
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
xianjieModel:ChaiFenLog()
else
self.notLog:setActive(true)
self.clearBtn:setActive(false)
end
self.onekeyReddot:setActive(xianjieModel:get_ResourceReddot())
self.onekeyBtn:setActive(xianjieModel:get_ResourceReddot())
local log_numtb=xianjieModel:Get_lognum()or{}
local logNum1=log_numtb[1]or 0
local logNum2=log_numtb[2]or 0
local logNum4=log_numtb[4]or 0
local curNum=math.max(logNum1,logNum2,logNum4)
self.tipsText:setText(string.format("奖励/记录日志保存上限：<color=%s>%d/100</color>",curNum<100 and"#549327"or"#c82c2c",curNum))
end

function UIXianJie_noteResourceWin:refreshItem(item,idx)
if item==nil then
return
end
local datatb=xianjieModel:Get_singleResourcetb(idx)
local cfgid=datatb.logtype
local config=cfgHelper.get1(cfg_fairylandlogconfig_get,cfgid)
local str_cfg=config.str
local islose=config.islose
local handletype=config.handletype or 0
item:SetChildActive(itemCmp.gotoroot,false)
self:setRiZhiInfo(item,cfgid,datatb,str_cfg,handletype)

self:Set_BigType(item,datatb,islose)
self:Set_Reward(item,datatb.len,datatb.list,datatb.recv,islose)
self:SetFightBtn(item,datatb,idx)
self:Set_Righttop(item,datatb,islose)
item:SetChildActive(itemCmp.openjijie,false)
end


function UIXianJie_noteResourceWin:Set_BigType(item,datatb,islose)

if datatb.logtype==1 then
item:SetChildCSImageSprite(itemCmp.middleType_tc,abname_search,icontype[4])
return
elseif datatb.logtype==2 then
item:SetChildCSImageSprite(itemCmp.middleType_tc,abname_search,icontype[5])
return
elseif datatb.len==0 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,icontype[1])
else
if islose and islose==1 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,icontype[1])
else
if datatb.recv==0 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,icontype[2])
elseif datatb.recv==1 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,icontype[3])
end
end
end

item:SetChildCSImageSprite(itemCmp.smallType,abname,cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"small_type"))
end

function UIXianJie_noteResourceWin:Set_Reward(item,len,list,recv,islose)
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

function UIXianJie_noteResourceWin:SetFightBtn(item,datatb,idx)
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
local _fun=function(fightLoglist)
local fightLog=fightLoglist[1]
local _fightInfo=fightModel:getJsonReport(fightLog)
local useReportMapId=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"useReportMapId")
local temp=
{
win=is_win,
yunjun=false,
cfgid=datatb.logtype,
fightInfo=_fightInfo,
timetxt=_timetxt,
fightarry={reportId,{nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,eReplayType=eRePlayerType.xianjielog,useReportMapId=useReportMapId}},
rijbdata=_rijbdata,
datatb_guid=datatb.guid,
rewlist=datatb.list,
}
UIManager:showWindow('UIXianJie_notejianbao',temp)
end
local fightLogType=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"fightLogType")
item:SetChildButtonClick(itemCmp.timeback2,function()
if jianbaotxt then
local sceneType=xianjieModel:getScenceType()and true or nil
if not sceneType then
local enterCallBack=function()
local args={nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,extraCall=_fun}
if fightLogType==1 then
fightController:send_log_list({reportId},args)
elseif fightLogType==2 then
fightController:send_log_list({reportId},args,true)
elseif fightLogType==3 then
fightController:send_log_list({reportId},args,nil,true)
end
return xianjieController:OpenZhengZhanShanHaiMonsterLog()
end
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText="战斗简报需前往仙界查看，是否前往？",
closetopbtn=true,
cellcallback=function()
return xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,enterCallBack)
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
else
local args={nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,extraCall=_fun}
if fightLogType==1 then
fightController:send_log_list({reportId},args)
elseif fightLogType==2 then
fightController:send_log_list({reportId},args,true)
elseif fightLogType==3 then
fightController:send_log_list({reportId},args,nil,true)
end
end
else
local args={nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,eReplayType=eRePlayerType.xianjielog}
if fightLogType==1 then
fightController:send_log_list({reportId},args)
elseif fightLogType==2 then
fightController:send_log_list({reportId},args,true)
elseif fightLogType==3 then
fightController:send_log_list({reportId},args,nil,true)
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

local sceneType=xianjieModel:getScenceType()and true or nil
if not sceneType then
local guid=datatb.guid
local enterCallBack=function()
local zbdata=xianjieModel:GetJiJie_Databy(guid)
if zbdata then
UIManager:showWindow("UIXianJie_noteJiJie",{guid})
else
xianjieController:reqXianJieJiJieFightLog(guid)
end
return xianjieController:OpenZhengZhanShanHaiMonsterLog()
end
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText="战斗简报需前往仙界查看，是否前往？",
closetopbtn=true,
cellcallback=function()
return xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,enterCallBack)
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
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

function UIXianJie_noteResourceWin:Set_Righttop(item,datatb,islose)
item:SetChildActive(itemCmp.new,datatb.isnew==1)
if datatb.len>0 then
if islose and islose==1 then
item:SetChildActive(itemCmp.reward_flag,false)
else
item:SetChildActive(itemCmp.reward_flag,datatb.recv==1)
end
else
item:SetChildActive(itemCmp.reward_flag,false)
end
end

function UIXianJie_noteResourceWin:showjijie(guid)

local zbdata=xianjieModel:GetJiJie_Databy(guid)
if zbdata then
self:showWindow("UIXianJie_noteJiJie",{guid})
else
xianjieController:reqXianJieJiJieFightLog(guid)
end
end

function UIXianJie_noteResourceWin:setRiZhiInfo(item,cfgid,datatb,str_cfg,handletype)
if cfgid==1 then
item:SetChildActive(itemCmp.xjrzpanel,false)
item:SetChildActive(itemCmp.xjtcpanel,true)
local logtb=self:splitStr(datatb.params)
local actiorName=tostring(logtb[1])
local actorid=int64.new(tostring(logtb[3]))
local stationguid=tonumber(logtb[4])
item:SetChildText(itemCmp.title_tc,"侦 查 成 功")
item:SetChildText(itemCmp.desc_tc,FMT.fmt(str_cfg,actiorName))
local maxTime=cfg_fairylandlogconfig().const_def.spy_maxTime
item:SetChildActive(itemCmp.tc_seeBtn,true)
item:SetChildActive(itemCmp.tc_gotoBtn,false)
item:SetChildButtonClick(itemCmp.tc_seeBtn,function()
local nowTime=timeHelper.getServerShortTime()
local left=nowTime-tonumber(datatb.sec)
if left>=maxTime then
UIManager.error('侦查信息已过期，请重新侦查')
return
end
local zmData=xianjieModel:getZongMenData(actorid)
local args={actorid=actorid,serverid=zmData.serverid,guid=datatb.guid,stationguid=stationguid,markRecored=true}
local callback=function(args,other)
if this==nil then return end
oneTabScreenController:closeUI()
UIManager:showWindow('UIXianJie_zmSearchLogTipsWin',{args=args,actorId=actorid})
end
otherPlayerModel:reqActorXianJieInfo(otherPlayerInfoType.eXianJieSearchLog,actorid,args,callback)
end)
elseif cfgid==2 or cfgid==105 then
item:SetChildActive(itemCmp.xjrzpanel,false)
item:SetChildActive(itemCmp.xjtcpanel,true)
local logtb=self:splitStr(datatb.params)
local name=tostring(logtb[1])
item:SetChildText(itemCmp.title_tc,"遭 到 侦 查")
item:SetChildText(itemCmp.desc_tc,FMT.fmt(str_cfg,name))
item:SetChildActive(itemCmp.tc_seeBtn,false)
item:SetChildActive(itemCmp.tc_gotoBtn,true)
item:SetChildButtonClick(itemCmp.tc_gotoBtn,function()
xianjieController:jumpGrid(logtb[4],logtb[5],logtb[6],nil,true)
oneTabScreenController:closeUI()
end)
elseif cfgid==32 then
item:SetChildActive(itemCmp.xjrzpanel,false)
item:SetChildActive(itemCmp.xjtcpanel,true)
local logtb=self:splitStr(datatb.params)
local actiorName=tostring(logtb[1])

item:SetChildText(itemCmp.title_tc,"侦 查 成 功")
item:SetChildText(itemCmp.desc_tc,FMT.fmt(str_cfg,actiorName))
item:SetChildActive(itemCmp.tc_gotoBtn,false)
item:SetChildActive(itemCmp.tc_seeBtn,true)
item:SetChildButtonClick(itemCmp.tc_seeBtn,function()
local nowTime=timeHelper.getServerShortTime()
local left=nowTime-tonumber(datatb.sec)
local maxTime=cfg_fairylandlogconfig().const_def.spy_maxTime
if left>=maxTime then
xianjieController:jumpGrid(logtb[5],logtb[6],logtb[7],nil,true)
UIManager.error('侦查信息已过期，请重新侦查')
oneTabScreenController:closeUI()
return
end
local targetData=xianjieModel:getStationData(logtb[4])
if not targetData then
xianjieController:jumpGrid(logtb[5],logtb[6],logtb[7],nil,true)
oneTabScreenController:closeUI()
return
end
local actorid=targetData.actorid
local zmData=xianjieModel:getZongMenData(actorid)
local args={actorid=actorid,serverid=zmData.serverid,guid=datatb.guid,stationguid=logtb[4],markRecored=true}
local callback=function(args,other)
if this==nil then return end
oneTabScreenController:closeUI()
UIManager:showWindow('UIXianJie_zmSearchLogTipsWin',{args=args,actorId=actorid})
end
otherPlayerModel:reqActorXianJieInfo(otherPlayerInfoType.eXianJieSearchLog,actorid,args,callback,true)
end)
elseif cfgid==33 then
item:SetChildActive(itemCmp.xjrzpanel,false)
item:SetChildActive(itemCmp.xjtcpanel,true)
local logtb=self:splitStr(datatb.params)
local actiorName=tostring(logtb[1])
item:SetChildText(itemCmp.title_tc,"侦 查 失 败")
item:SetChildText(itemCmp.desc_tc,FMT.fmt(str_cfg,actiorName))
item:SetChildActive(itemCmp.tc_gotoBtn,false)
item:SetChildActive(itemCmp.tc_seeBtn,false)
elseif cfgid==34 then
item:SetChildActive(itemCmp.xjrzpanel,false)
item:SetChildActive(itemCmp.xjtcpanel,true)
local logtb=self:splitStr(datatb.params)
local actiorName=tostring(logtb[1])
item:SetChildText(itemCmp.title_tc,"遭 到 侦 查")
item:SetChildText(itemCmp.desc_tc,FMT.fmt(str_cfg,actiorName))
item:SetChildActive(itemCmp.tc_gotoBtn,true)
item:SetChildActive(itemCmp.tc_seeBtn,false)
item:SetChildButtonClick(itemCmp.tc_gotoBtn,function()
xianjieController:jumpGrid(logtb[4],logtb[5],logtb[6],nil,true)
oneTabScreenController:closeUI()
end)
elseif cfgid==104 then
item:SetChildActive(itemCmp.xjrzpanel,false)
item:SetChildActive(itemCmp.xjtcpanel,true)
local logtb=self:splitStr(datatb.params)
local guildName=logtb[1]
local guildIdStr=logtb[2]
local guid=datatb.guid
item:SetChildText(itemCmp.title_tc,"侦 查 成 功")
item:SetChildText(itemCmp.desc_tc,FMT.fmt(str_cfg,guildName))
local maxTime=cfg_fairylandlogconfig().const_def.spy_maxTime
item:SetChildActive(itemCmp.tc_seeBtn,true)
item:SetChildActive(itemCmp.tc_gotoBtn,false)
item:SetChildButtonClick(itemCmp.tc_seeBtn,function()
local nowTime=timeHelper.getServerShortTime()
local left=nowTime-tonumber(datatb.sec)
if left>=maxTime then
UIManager.error('侦查信息已过期，请重新侦查')
return
end
local xmData=xianjieModel:getXianMengDataEx(guildIdStr)
if not xmData then
UIManager.error('该仙盟已不存在')
return
end
local guildId=int64.new(guildIdStr)
local garrison=xianjieModel:getXianMengGarrisonEx(guildIdStr)
if garrison==nil or(nowTime-garrison.serverTime)>=maxTime then
xianjieController:send_35_43(guid)
end
local args={
guild=guildId,
}
UIManager:showWindow("UIXianJie_XMBLDefendInfoWin",args)
end)
elseif cfgid>=3 then
item:SetChildActive(itemCmp.xjrzpanel,true)
item:SetChildActive(itemCmp.xjtcpanel,false)
xpcall(function()
local logtxt=self:SetStr(str_cfg,item,datatb.params,cfgid,handletype)
item:SetChildText(itemCmp.deac,logtxt)
end,function(err)
item:SetChildText(itemCmp.deac,"暂无信息")
logErr(FMT.fmt('日志参数解析报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
end
end

function UIXianJie_noteResourceWin:SetStr(str_cfg,item,json_str,cfgid,handletype)
local str_2="暂无信息"
local str_1=FMT.fmt("                        {0}",str_cfg)
local tbstr=self:splitStr(json_str)
self.rijbdata={}
if handletype==1 then
local xj_entitytype=tbstr[1]or 3
local xj_cfgid=tbstr[2]or 1
local xj_sceneidx=tbstr[3]or 1
local xj_x=tbstr[4]or 1
local xj_y=tbstr[5]or 1

local isMoJieNote=xianjienSceneIndexType:isMoJie(xj_sceneidx)or false
if isMoJieNote then
xj_sceneidx=xianjieModel:getCurrentMoJieSceneIndex()or xj_sceneidx
end

self.rijbdata={handletype,xj_entitytype,xj_cfgid,xj_sceneidx,xj_x,xj_y}
local xj_cfg=xianjieController:xjrzgetCfg_hj(xj_entitytype,xj_cfgid)
local gwname=xianjieController:xjrzgetgwName_hj(xj_cfg)
local namestr=FMT.fmt("【{0}】（{1}，{2}）",gwname,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
xpcall(function()
str_2=FMT.fmt(str_1,unpack(tbstr,1,9))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)

elseif handletype==2 then
local xj_playername=tbstr[1]or 1
local xj_sceneidx=tbstr[2]or 1
local xj_x=tbstr[3]or 1
local xj_y=tbstr[4]or 1

local isMoJieNote=xianjienSceneIndexType:isMoJie(xj_sceneidx)or false
if isMoJieNote then
xj_sceneidx=xianjieModel:getCurrentMoJieSceneIndex()or xj_sceneidx
end

local namestr=FMT.fmt("【{0}】（{1}，{2}）",xj_playername,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
xpcall(function()
str_2=FMT.fmt(str_1,unpack(tbstr,1,9))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)

elseif handletype==3 then
local xj_zydtype=tbstr[1]or 1
local xj_cfgid=tbstr[2]or 1
local xj_sceneidx=tbstr[3]or 1
local xj_x=tbstr[4]or 1
local xj_y=tbstr[5]or 1
local srctype=tbstr[7]or 0

local isMoJieNote=xianjienSceneIndexType:isMoJie(xj_sceneidx)or false
if isMoJieNote then
xj_sceneidx=xianjieModel:getCurrentMoJieSceneIndex()or xj_sceneidx
end

self.rijbdata={handletype,xj_zydtype,xj_cfgid,xj_sceneidx,xj_x,xj_y}
local xj_cfg=xianjieController:xjrzgetCfg_zyd(xj_zydtype,xj_cfgid)
local gwname=xianjieController:xjrzgetgwName_zyd(xj_cfg,srctype)
local namestr=FMT.fmt("【{0}】（{1}，{2}）",gwname,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
xpcall(function()
str_2=FMT.fmt(str_1,unpack(tbstr,1,9))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)

elseif handletype==4 then
local xj_buildid=tbstr[1]or 1
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,xj_buildid)
local name=""
if cfg then
name=cfg.name or""
end
tbstr[1]=name
xpcall(function()
str_2=FMT.fmt(str_1,unpack(tbstr,1,9))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)

elseif handletype==6 then
local xj_playername=tbstr[1]or 1
local xj_sceneidx=tbstr[2]or 1
local xj_x=tbstr[3]or 1
local xj_y=tbstr[4]or 1

local xj_playername2=tbstr[5]or 1
local xj_sceneidx2=tbstr[6]or 1
local xj_x2=tbstr[7]or 1
local xj_y2=tbstr[8]or 1

local isMoJieNote=xianjienSceneIndexType:isMoJie(xj_sceneidx)or false
if isMoJieNote then
xj_sceneidx=xianjieModel:getCurrentMoJieSceneIndex()or xj_sceneidx
end

local namestr=FMT.fmt("【{0}】（{1}，{2}）",xj_playername,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
local namestr2=FMT.fmt("【{0}】（{1}，{2}）",xj_playername2,xj_x2,xj_y2)
local link2=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr2,xj_x2,xj_y2,xj_sceneidx2)
tbstr[2]=link2
xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr,1,11))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)

elseif handletype==8 then
local xj_tqid=tbstr[1]or 20
local tqname=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,xj_tqid,'name')
tbstr[1]=tqname or''
xpcall(function()
str_2=FMT.fmt(str_1,unpack(tbstr,1,9))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)

elseif handletype==9 then
local xj_xgid=tbstr[1]or 130
local xj_tqid=tbstr[3]or 20
local jobCfg=cfgHelper.get1(cfg_xianguanconfig_get,xj_xgid)
tbstr[1]=jobCfg.name or''
local tqname=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,xj_tqid,'name')
tbstr[3]=tqname or''
xpcall(function()
str_2=FMT.fmt(str_1,unpack(tbstr,1,9))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==18 then
local xj_entitytype=tbstr[1]or 3
local xj_cfgid=tbstr[2]or 1
local xj_sceneidx=tbstr[3]or 1
local xj_x=tbstr[4]or 1
local xj_y=tbstr[5]or 1

local isMoJieNote=xianjienSceneIndexType:isMoJie(xj_sceneidx)or false
if isMoJieNote then
xj_sceneidx=xianjieModel:getCurrentMoJieSceneIndex()or xj_sceneidx
end

self.rijbdata={handletype,xj_entitytype,xj_cfgid,xj_sceneidx,xj_x,xj_y}
local xj_cfg=xianjieController:xjrzgetCfg_hj(xj_entitytype,xj_cfgid)
local hideStage=xjMonsterInfoHideStage[xj_entitytype]and xjMonsterInfoHideStage[xj_entitytype]==1

local groupid=xj_cfg.monster[2]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local stage=xj_cfg.stage or 1
local gwname=hideStage and groupcfg.name or FMT.fmt("{0}阶{1}",stage,groupcfg.name)
local namestr=FMT.fmt("【{0}】（{1}，{2}）",gwname,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
local ok,ret=xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==23 then

local xj_playername=tbstr[1]or 1
local xj_sceneidx=tbstr[2]or 1
local xj_x=tbstr[3]or 1
local xj_y=tbstr[4]or 1

local xj_entitytype=tbstr[5]
local xj_cfgid=tbstr[6]

local xj_sceneidx2=tbstr[7]or 1
local xj_x2=tbstr[8]or 1
local xj_y2=tbstr[9]or 1
local xj_cfg=xianjieController:xjrzgetCfg_hj(xj_entitytype,xj_cfgid)
local hideStage=xjMonsterInfoHideStage[xj_entitytype]and xjMonsterInfoHideStage[xj_entitytype]==1
local xj_playername2=xianjieController:xjrzgetgwName_hj(xj_cfg,hideStage)

local isMoJieNote=xianjienSceneIndexType:isMoJie(xj_sceneidx)or false
if isMoJieNote then
xj_sceneidx=xianjieModel:getCurrentMoJieSceneIndex()or xj_sceneidx
end

local namestr=FMT.fmt("【{0}】（{1}，{2}）",xj_playername,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
local namestr2=FMT.fmt("【{0}】（{1}，{2}）",xj_playername2,xj_x2,xj_y2)
local link2=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr2,xj_x2,xj_y2,xj_sceneidx2)
tbstr[2]=link2
xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
end



return str_2
end


function UIXianJie_noteResourceWin.fmt(content,...)
local args={...}
local temp={}
for i,v in ipairs(args)do
temp[tostring(i-1)]=tostring(v)
end
local ret=string_gsub(content,"{(%d+)}",temp)
return ret
end
