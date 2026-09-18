







def_class("UITianShuDaZhenLogWin",UIWindowBase)









function UITianShuDaZhenLogWin:bindComponents()

self.checkTxt=UIText.get(self,0)
self.clearBtn=UIButton.get(self,1)
self.itemGridPanel=UIObject.get(self,2)
self.itemScrollView=UIObject.get(self,3)
self.logGridPanel=UIObject.get(self,4)
self.LogScrollView=UILoopListView.new(self,5)
self.notLog=UIObject.get(self,6)
self.onekeyBtn=UIButton.get(self,7)
self.onekeyReddot=UIObject.get(self,8)
self.tips=UIButton.get(self,9)
self.tipsText=UIText.get(self,10)

self.clearBtn:setButtonClick(function()self:onClearBtn()end)

self.LogScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.onekeyBtn:setButtonClick(function()self:onOnekeyBtn()end)

self.tips:setButtonClick(function()self:onTips()end)



end


function UITianShuDaZhenLogWin:unbindComponents()
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
local huifang_value={
[40]=function(logtb)
return mathHelper.formatNumber(logtb[2])
end,
[296]=function(logtb)
return mathHelper.formatNumber(logtb[2])
end,
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
local cjson=require'cjson'


function UITianShuDaZhenLogWin:onLoaded(...)
self:bindComponents()
this=self
local id=self.LogScrollView:getID()
self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UITianShuDaZhenLogWin:__delete()

if xianjieModel:jude_xianjielog_reddot()~=xianjieModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onXianjieLogReddotChange)
xianjieModel:Set_reddotchangeflag(not xianjieModel:Get_reddotchangeflag())
end
this=nil
self:unbindComponents()
end


function UITianShuDaZhenLogWin:onHide()

if xianjieModel:jude_xianjielog_reddot()~=xianjieModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onXianjieLogReddotChange)
xianjieModel:Set_reddotchangeflag(not xianjieModel:Get_reddotchangeflag())
end

local win3=UIManager:findActiveWindow("UIXianJieFuncStorageWin")
if win3 then
win3:refreshFuncBtn_Log()
end
end

function UITianShuDaZhenLogWin:onStartAction()

end

function UITianShuDaZhenLogWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end

function UITianShuDaZhenLogWin:splitStr(str)
return cjson.decode(str)
end

function UITianShuDaZhenLogWin:onTips()
local d={}
d.title='规则说明'
d.mode=3
d.showBlack=true
d.name='XianJie_log_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UITianShuDaZhenLogWin:onClearBtn()
local guid_tb=xianjieModel:Find_Monsterguid()
if next(guid_tb)then
xianjieController:reqXianJieLogDelete(#guid_tb,guid_tb)
UIManager.info("已清除日志记录")
end
end

function UITianShuDaZhenLogWin:onOnekeyBtn()
local guid_tb=xianjieModel:Find_MonsterReward()
if next(guid_tb)then
xianjieController:reqXianJieLogReward(#guid_tb,guid_tb)
end
end

function UITianShuDaZhenLogWin:onAlllog_tip()
local str=""
if xianjieModel:Jude_isShowMaxTips()then
str=cfgHelper.getlang("zhengzhanshanhai_log_2")
else
str=cfgHelper.getlang("zhengzhanshanhai_log_1")
end
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确定',
allowclickBG=true,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end




function UITianShuDaZhenLogWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
xianjieModel:jude_haveReward()
self.showtipsflag=xianjieModel:Jude_isShowTips()
if self.showtipsflag and not self.recordone then
self:onAlllog_tip()
self.recordone=true
end
self:RefreshWin()
if argtable and argtable[1]then
argtable[1]=nil
UIManager:showWindow("UIXM_ZZSH_noteJiJie")
end
end

function UITianShuDaZhenLogWin:RefreshWin()
xianjieModel:saveRecord_Monster()
local itemIdList={}
local monstertb=xianjieModel:Get_monstertb()
self.LogScrollView:initData("xjlog_Item",itemIdList)
if next(monstertb)then
self.notLog:setActive(false)
self.clearBtn:setActive(true)
for i=1,#monstertb do
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
self.onekeyReddot:setActive(xianjieModel:get_monsterReddot())
self.onekeyBtn:setActive(xianjieModel:get_monsterReddot())
local logNum1,logNum2=xianjieModel:Get_groupLogNum(1),xianjieModel:Get_groupLogNum(2)
local curNum=math.max(logNum1,logNum2)
self.tipsText:setText(string.format("奖励/记录日志保存上限：<color=%s>%d/100</color>",curNum<100 and"#549327"or"#c82c2c",curNum))
end

function UITianShuDaZhenLogWin:refreshItem(item,idx)
if item==nil then
return
end
local datatb=xianjieModel:Get_singleMonstertb(idx)
local cfgid=datatb.logtype
local config=cfgHelper.get1(cfg_fairylandlogconfig_get,cfgid)
local str_cfg=config.str
local islose=config.islose
local handletype=config.handletype or 0
item:SetChildActive(itemCmp.gotoroot,false)
item:SetChildActive(itemCmp.xjrzpanel,false)
item:SetChildActive(itemCmp.xjtcpanel,false)
self:setRiZhiInfo(item,cfgid,datatb,str_cfg,handletype)

self:Set_BigType(item,datatb)
self:Set_Reward(item,datatb.len,datatb.list,datatb.recv,islose)
self:SetFightBtn(item,datatb,idx)
self:Set_Righttop(item,datatb)
item:SetChildActive(itemCmp.openjijie,false)











end


function UITianShuDaZhenLogWin:Set_BigType(item,datatb)

if datatb.len==0 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,icontype[1])
else
if datatb.recv==0 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,icontype[2])
elseif datatb.recv==1 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,icontype[3])
end
end

item:SetChildCSImageSprite(itemCmp.smallType,abname,cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"small_type"))
end

function UITianShuDaZhenLogWin:Set_Reward(item,len,list,recv,islose)
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

function UITianShuDaZhenLogWin:SetFightBtn(item,datatb,idx)
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
item:SetChildActive(itemCmp.timeback2,true)
item:SetChildActive(itemCmp.time1,false)
item:SetChildText(itemCmp.time2,timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
local hurt_hp
local huifang_txt=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"huifang_txt")
local is_win=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"is_win")
item:SetChildButtonClick(itemCmp.timeback2,function()

fightController:send_254_29(reportId,{nil,reportId,eRePlayerType.xianjielog,huifang_txt,0,hurt_hp,nil,is_win},true)
end)
end
end
if isyuanjun then
item:SetChildActive(itemCmp.timeback2,true)
item:SetChildActive(itemCmp.time1,false)
item:SetChildText(itemCmp.time2,timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
item:SetChildButtonClick(itemCmp.timeback2,function()
self:showjijie(datatb.guid)
end)
end
else
item:SetChildActive(itemCmp.timeback2,false)
item:SetChildActive(itemCmp.time1,true)
item:SetChildText(itemCmp.time1,
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))

item:SetChildActive(itemCmp.time_tc,true)
item:SetChildText(itemCmp.time_tc,
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(),timeHelper.convertLongStamp(tonumber(datatb.sec))))
end
end

function UITianShuDaZhenLogWin:Set_Righttop(item,datatb)
item:SetChildActive(itemCmp.new,datatb.isnew==1)
if datatb.len>0 then
item:SetChildActive(itemCmp.reward_flag,datatb.recv==1)
else
item:SetChildActive(itemCmp.reward_flag,false)
end
end

function UITianShuDaZhenLogWin:showjijie(guid)

local zbdata=xianjieModel:GetJiJie_Databy(guid)
if zbdata then
self:showWindow("UIXianJie_noteJiJie",{guid})
else
xianjieController:reqXianJieJiJieFightLog(guid)
end
end

function UITianShuDaZhenLogWin:setRiZhiInfo(item,cfgid,datatb,str_cfg,handletype)
if cfgid==1 then
item:SetChildActive(itemCmp.xjtcpanel,true)
local logtb=self:splitStr(datatb.params)
local actiorName=tostring(logtb[1])
local actorid=int64.new(tostring(logtb[3]))
item:SetChildText(itemCmp.title_tc,"侦查成功")
item:SetChildText(itemCmp.desc_tc,FMT.fmt(str_cfg,actiorName))
local maxTime=cfg_fairylandlogconfig().const_def.spy_maxTime
item:SetChildActive(itemCmp.tc_seeBtn,true)
item:SetChildActive(itemCmp.tc_gotoBtn,false)
item:SetChildButtonClick(itemCmp.tc_seeBtn,function()
local nowTime=timeHelper.getServerShortTime()
local left=nowTime-tonumber(datatb.sec)
if left>=maxTime then
local zmData=xianjieModel:getZongMenData(actorid)
local gridX_c,gridZ_c=xianjieModel:getZongMenWorldGridCenterPos(zmData)
xianjieController:jumpGrid(zmData.sceneidx,gridX_c,gridZ_c,nil,true)
UIManager.error('侦查信息已过期，请重新侦查')
oneTabScreenController:closeUI()
return
end
local zmData=xianjieModel:getZongMenData(actorid)
local args={actorid=actorid,serverid=zmData.serverid,guid=datatb.guid,stationguid=0,markRecored=true}
local callback=function(args,other)
if this==nil then return end
oneTabScreenController:closeUI()
UIManager:showWindow('UIXianJie_zmSearchLogTipsWin',{args=args,actorId=actorid})
end
otherPlayerModel:reqActorXianJieInfo(otherPlayerInfoType.eXianJieSearchLog,actorid,args,callback)
end)
elseif cfgid==2 then
item:SetChildActive(itemCmp.xjtcpanel,true)
local logtb=self:splitStr(datatb.params)
local actiorName=tostring(logtb[1])
local actorid=int64.new(tostring(logtb[2]))
item:SetChildText(itemCmp.title_tc,"遭到侦查")
item:SetChildText(itemCmp.desc_tc,FMT.fmt(str_cfg,actiorName))
item:SetChildActive(itemCmp.tc_seeBtn,false)
item:SetChildActive(itemCmp.tc_gotoBtn,true)
item:SetChildButtonClick(itemCmp.tc_gotoBtn,function()
local zmData=xianjieModel:getZongMenData(actorid)
local gridX_c,gridZ_c=xianjieModel:getZongMenWorldGridCenterPos(zmData)
xianjieController:jumpGrid(zmData.sceneidx,gridX_c,gridZ_c,nil,true)
oneTabScreenController:closeUI()
end)
elseif cfgid>=3 then
item:SetChildActive(itemCmp.xjrzpanel,true)
local logtxt=self:SetStr(str_cfg,item,datatb.params,cfgid,handletype)
xpcall(function()
item:SetChildText(itemCmp.deac,logtxt)
end,function(err)
item:SetChildText(itemCmp.deac,"暂无信息")
end)
end
end

function UITianShuDaZhenLogWin:SetStr(str_cfg,item,json_str,cfgid,handletype)
local str_2="暂无信息"
local str_1=FMT.fmt("                      {0}",str_cfg)
local tbstr=self:splitStr(json_str)
if handletype==1 then
local xj_entitytype=tbstr[1]or 3
local xj_cfgid=tbstr[2]or 1
local xj_sceneidx=tbstr[3]or 1
local xj_x=tbstr[4]or 1
local xj_y=tbstr[5]or 1
local xj_cfg=xianjieController:xjrzgetCfg_hj(xj_entitytype,xj_cfgid)
local gwname=xianjieController:xjrzgetgwName_hj(xj_cfg)
local namestr=FMT.fmt("【{0}】（{1}，{2}）",gwname,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
xpcall(function()
str_2=FMT.fmt(str_1,table.unpackEx(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)

elseif handletype==2 then
local xj_playername=tbstr[1]or 1
local xj_sceneidx=tbstr[2]or 1
local xj_x=tbstr[3]or 1
local xj_y=tbstr[4]or 1
local namestr=FMT.fmt("【{0}】（{1}，{2}）",xj_playername,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
xpcall(function()
str_2=FMT.fmt(str_1,table.unpackEx(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)

elseif handletype==3 then
local xj_zydtype=tbstr[1]or 1
local xj_cfgid=tbstr[2]or 1
local xj_sceneidx=tbstr[3]or 1
local xj_x=tbstr[4]or 1
local xj_y=tbstr[5]or 1
local xj_cfg=xianjieController:xjrzgetCfg_zyd(xj_zydtype,xj_cfgid)
local gwname=xianjieController:xjrzgetgwName_zyd(xj_cfg)
local namestr=FMT.fmt("【{0}】（{1}，{2}）",gwname,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
xpcall(function()
str_2=FMT.fmt(str_1,table.unpackEx(tbstr))
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
str_2=FMT.fmt(str_1,table.unpackEx(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
end
return str_2
end