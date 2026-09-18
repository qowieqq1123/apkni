







def_class("UIXianJie_noteMonsterWin",UIWindowBase)









function UIXianJie_noteMonsterWin:bindComponents()

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


function UIXianJie_noteMonsterWin:unbindComponents()
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
exMiddleType=63,
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
local xjabname="ui/windows/xianjie/chongjianxianyu_atlas_pak.ab"
local cjson=require'cjson'
local string_gsub=string.gsub


function UIXianJie_noteMonsterWin:onLoaded(...)
self:bindComponents()
this=self
local id=self.LogScrollView:getID()
self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UIXianJie_noteMonsterWin:__delete()

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


function UIXianJie_noteMonsterWin:onHide()

if xianjieModel:jude_xianjielog_reddot()~=xianjieModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onXianjieLogReddotChange)
xianjieModel:Set_reddotchangeflag(not xianjieModel:Get_reddotchangeflag())
end

local win3=UIManager:findActiveWindow("UIXianJieFuncStorageWin")
if win3 then
win3:refreshFuncBtn_Log()
end
end

function UIXianJie_noteMonsterWin:onStartAction()

end

function UIXianJie_noteMonsterWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end

function UIXianJie_noteMonsterWin:splitStr(str)
return cjson.decode(str)
end

function UIXianJie_noteMonsterWin:onTips()
local d={}
d.title='规则说明'
d.mode=3
d.showBlack=true
d.name='XianJie_log_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXianJie_noteMonsterWin:onClearBtn()
local guid_tb=xianjieModel:Find_Monsterguid()
if next(guid_tb)then
xianjieController:reqXianJieLogDelete(#guid_tb,guid_tb)
UIManager.info("已清除日志记录")
end
end

function UIXianJie_noteMonsterWin:onOnekeyBtn()
local guid_tb=xianjieModel:Find_MonsterReward()
if next(guid_tb)then
xianjieController:reqXianJieLogReward(#guid_tb,guid_tb)
end
end

function UIXianJie_noteMonsterWin:onAlllog_tip()
local str=""
if xianjieModel:Jude_isShowMaxTips()then
str=cfgHelper.getlang("UIXianJie_noteMonsterWin_log_2")
else
str=cfgHelper.getlang("UIXianJie_noteMonsterWin_log_1")
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




function UIXianJie_noteMonsterWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
xianjieModel:jude_haveReward()
self.showtipsflag=xianjieModel:Jude_isShowTips()
if self.showtipsflag and not self.recordone then
self:onAlllog_tip()
self.recordone=true
end
self:RefreshWin()
if argtable then
if argtable[1]then
argtable[1]=nil
UIManager:showWindow("UIXM_ZZSH_noteJiJie")
end
if argtable[2]then
weakGuideController:beginGuide(argtable[2])
end
end
xianjieController:refreshUIReddot()
end

function UIXianJie_noteMonsterWin:RefreshWin()
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
local log_numtb=xianjieModel:Get_lognum()or{}
local logNum1=log_numtb[1]or 0
local logNum2=log_numtb[2]or 0
local logNum4=log_numtb[4]or 0
local curNum=math.max(logNum1,logNum2,logNum4)
self.tipsText:setText(string.format("奖励/记录日志保存上限：<color=%s>%d/100</color>",curNum<100 and"#549327"or"#c82c2c",curNum))
end

function UIXianJie_noteMonsterWin:refreshItem(item,idx)
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

self:Set_BigType(item,datatb,islose)
self:Set_Reward(item,datatb.len,datatb.list,datatb.recv,islose)
self:SetFightBtn(item,datatb,idx)
self:Set_Righttop(item,datatb,islose)
item:SetChildActive(itemCmp.openjijie,false)
item:ForceLayoutRect(itemCmp.xjrzpanel)
item:ForceLayoutRect(-1)
end


function UIXianJie_noteMonsterWin:Set_BigType(item,datatb,islose)
local logCfg=cfgHelper.get1(cfg_fairylandlogconfig_get,datatb.logtype)

if datatb.len==0 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,logCfg.iconReplace and logCfg.iconReplace[1]or icontype[1])
self:setExIcon(item,logCfg,1)
else
if islose and islose==1 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,logCfg.iconReplace and logCfg.iconReplace[1]or icontype[1])
self:setExIcon(item,logCfg,1)
else
if datatb.recv==0 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,logCfg.iconReplace and logCfg.iconReplace[2]or icontype[2])
self:setExIcon(item,logCfg,2)
elseif datatb.recv==1 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,logCfg.iconReplace and logCfg.iconReplace[3]or icontype[3])
self:setExIcon(item,logCfg,3)
else
item:SetChildCSImageIcon(itemCmp.exMiddleType,"",true)
end
end
end

item:SetChildCSImageSprite(itemCmp.smallType,abname,logCfg.small_type)
end

function UIXianJie_noteMonsterWin:setExIcon(item,logCfg,index)
if logCfg.exIcon and logCfg.exIcon[index]then
item:SetChildCSImageSprite(itemCmp.exMiddleType,abname,logCfg.exIcon[index])
else
item:SetChildCSImageIcon(itemCmp.exMiddleType,"",true)
end
end

function UIXianJie_noteMonsterWin:Set_Reward(item,len,list,recv,islose)
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

for index,rwItemID in ipairs(itemCmp.itemlist)do
local rwItem=item:GetChildWidgetBase(rwItemID)
local itemdData=list[index]
local isShow=itemdData~=nil
rwItem:SetChildActive(-1,isShow)
if isShow then
rwItem:SetChildActive(11,true)
local itemid=itemdData.param_1
local itemnum=itemdData.param_2
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
itemsComponentHelper.onItemClickEx(itemdData.param_1)
end)
rwItem:SetChildActive(12,recv==0)
end
end
else
item:SetChildActive(itemCmp.itembg,false)
item:SetChildActive(itemCmp.itemroot,false)
end
end

function UIXianJie_noteMonsterWin:SetFightBtn(item,datatb,idx)

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

local _timetxt=timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(),timeHelper.convertLongStamp(tonumber(datatb.sec)))
_timetxt=FMT.fmt("战斗简报时间：{0}",_timetxt)

local huifang_txt=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"huifang_txt")
local is_win=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"is_win")
local newLogic
local resultCfg=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"resultCfg")
if resultCfg then
local resultType=resultCfg[1]
if resultType==1 then
newLogic={}
newLogic.resultType=resultType

local kuangAssetName="image_gwtouxiangpjk_3"
local entityType=logtb[1]
local cfgid=logtb[2]
if entityType==xjServerEnityType.eMoJieMoZong_Small then
kuangAssetName="image_gwtouxiangpjk_3"
elseif entityType==xjServerEnityType.eMoJieMoZong_Big then
kuangAssetName="image_gwtouxiangpjk_3"
end
newLogic.kuangAbName="ui/sharedtextures/uiglobalspriteatlas_1.ab"
newLogic.kuangAssetName=kuangAssetName
local xj_cfg=xianjieController:xjrzgetCfg_hj(entityType,cfgid)
newLogic.groupid=xj_cfg.monster[1]
local hideStage=xjMonsterInfoHideStage[entityType]and xjMonsterInfoHideStage[entityType]==1
local gwname=xianjieController:xjrzgetgwName_hj(xj_cfg,hideStage)
newLogic.name=gwname


newLogic.curProValue=tonumber(logtb[resultCfg[2]])
newLogic.maxProValue=100
newLogic.tips=resultCfg[4]
newLogic.progressValueTxt=FMT.fmt("{0}%",newLogic.curProValue)
newLogic.iconFlagCfg={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_mozontouxiang_1"}
newLogic.oldProValue=newLogic.curProValue+tonumber(logtb[resultCfg[3]])
elseif resultType==2 then
newLogic={}
newLogic.resultType=resultType
local curhp=logtb[resultCfg[2]]or 1
local nowhp=logtb[resultCfg[3]]or 1
local maxhp=logtb[resultCfg[4]]or 1
newLogic.curhp=curhp
newLogic.nowhp=nowhp
newLogic.maxhp=maxhp
end
end
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
fightarry={reportId,{nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,eReplayType=eRePlayerType.xianjielog,newLogic=newLogic,useReportMapId=useReportMapId}},
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
local args={nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,extraCall=_fun,newLogic=newLogic}
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
local args={nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,extraCall=_fun,newLogic=newLogic}
if fightLogType==1 then
fightController:send_log_list({reportId},args)
elseif fightLogType==2 then
fightController:send_log_list({reportId},args,true)
elseif fightLogType==3 then
fightController:send_log_list({reportId},args,nil,true)
end
end
else
local args={nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,eReplayType=eRePlayerType.xianjielog,newLogic=newLogic}
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
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(),timeHelper.convertLongStamp(tonumber(datatb.sec))))
end
end

function UIXianJie_noteMonsterWin:Set_Righttop(item,datatb,islose)
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


function UIXianJie_noteMonsterWin:showjijie(guid)

local zbdata=xianjieModel:GetJiJie_Databy(guid)
if zbdata then
self:showWindow("UIXianJie_noteJiJie",{guid})
else
xianjieController:reqXianJieJiJieFightLog(guid)
end
end

function UIXianJie_noteMonsterWin:setRiZhiInfo(item,cfgid,datatb,str_cfg,handletype)
if cfgid==1 then
item:SetChildActive(itemCmp.xjtcpanel,true)
local logtb=self:splitStr(datatb.params)
local actiorName=tostring(logtb[1])
local actorid=int64.new(tostring(logtb[3]))
item:SetChildText(itemCmp.title_tc," 侦 查 成 功")
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
item:SetChildText(itemCmp.title_tc,"遭 到 侦 查")
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
xpcall(function()
local logtxt=self:SetStr(str_cfg,item,datatb.params,cfgid,handletype)
item:SetChildText(itemCmp.deac,logtxt)
end,function(err)
item:SetChildText(itemCmp.deac,"暂无信息")
logErr(FMT.fmt('日志参数解析报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
item:ForceLayoutRect(itemCmp.deac)
end
end

function UIXianJie_noteMonsterWin:SetStr(str_cfg,item,json_str,cfgid,handletype)
local str_2="暂无信息"
local str_1=FMT.fmt("                        {0}",str_cfg)
local tbstr=self:splitStr(json_str)
self.rijbdata={}


local common_convert=cfgHelper.get2(cfg_fairylandlogconfig_get,cfgid,"common_convert")
if common_convert then
for i,v in pairs(common_convert)do
if tbstr[i]then
if v==1 then
if type(tbstr[i])=='number'then
tbstr[i]=mathHelper.formatNumber(tbstr[i])
else
local number=mathHelper.int64_to_number(int64.new(tbstr[i]))

tbstr[i]=mathHelper.formatNumber(number)
end
end
end
end
end

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
local hideStage=xj_entitytype==xjServerEnityType.eMoJieMoZong_Small or xj_entitytype==xjServerEnityType.eMoJieMoZong_Big or xj_entitytype==xjServerEnityType.eMoJieMoJunYaoMo or xj_entitytype==xjServerEnityType.eMoJieShangGuMoster or xj_entitytype==xjServerEnityType.eMoJieZhenYan_Small or xj_entitytype==xjServerEnityType.eMoJieZhenYan_Big or xj_entitytype==xjServerEnityType.eMoJieZhenYan_Spe
local gwname
if xj_entitytype==xjServerEnityType.eMoJingZhenJi_Normal then
gwname=xj_cfg.name
else
gwname=xianjieController:xjrzgetgwName_hj(xj_cfg,hideStage)
end
local namestr=FMT.fmt("【{0}】（{1}，{2}）",gwname,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
local ok,ret=xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
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
str_2=self.fmt(str_1,unpack(tbstr))
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
str_2=self.fmt(str_1,unpack(tbstr))
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
str_2=self.fmt(str_1,unpack(tbstr))
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
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)

elseif handletype==8 then
local xj_tqid=tbstr[1]or 20
local tqname=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,xj_tqid,'name')
tbstr[1]=tqname or''
xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
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
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==10 then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,tbstr[1])
local buildName=buildCfg.name
local sceneIdx=xianjieController:getXJClientBuildSceneIndex(tbstr[1])
if xianjienSceneIndexType:isMoJie(sceneIdx)then
sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
end
self.rijbdata={handletype,xjServerEnityType.eClientBuild,tbstr[1],sceneIdx,buildCfg.x,buildCfg.y}
self.rijbdata.monster=tbstr[9]

if buildCfg and buildCfg.clientParam then
local gateId=buildCfg.clientParam.gateId
if gateId then

local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,gateId)
local gateName=gateCfg.name
local gateXYSceneIndex=gateCfg.area
local xyName=xianjieController:getCrossServerNamebySCidx(gateXYSceneIndex)
buildName=FMT.fmt("{0}-{1}",xyName,gateName)
end
end
local namestr=FMT.fmt("【{0}】（{1}，{2}）",buildName,buildCfg.x,buildCfg.y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,buildCfg.x,buildCfg.y,sceneIdx)
tbstr[1]=link
xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==11 then

local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,tbstr[1])
local buildName=buildCfg.name
local sceneIdx=xianjieController:getXJClientBuildSceneIndex(tbstr[1])

if buildCfg and buildCfg.clientParam then
local gateId=buildCfg.clientParam.gateId
if gateId then

local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,gateId)
local gateName=gateCfg.name
local gateXYSceneIndex=gateCfg.area
local xyName=xianjieController:getCrossServerNamebySCidx(gateXYSceneIndex)
buildName=FMT.fmt("{0}-{1}",xyName,gateName)
local monsterGroupId=tbstr[3]
self.rijbdata={handletype,xjServerEnityType.eClientBuild,tbstr[1],sceneIdx,buildCfg.x,buildCfg.y}
self.rijbdata.monster=monsterGroupId
end
end
local namestr=FMT.fmt("【{0}】（{1}，{2}）",buildName,buildCfg.x,buildCfg.y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,buildCfg.x,buildCfg.y,sceneIdx)
tbstr[1]=link
local dmgPercent=tbstr[4]
local dmgPercentStr=string.format('%0.2f',dmgPercent*100)
tbstr[4]=dmgPercentStr

local remainingPercent=tbstr[5]
if remainingPercent then
local remainingPercentStr=string.format('%0.2f',remainingPercent*100)
tbstr[5]=remainingPercentStr
end
xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==12 then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,tbstr[1])
local namestr=FMT.fmt("【{0}】（{1}，{2}）",buildCfg.name,buildCfg.x,buildCfg.y)
local sceneIdx=xianjieController:getXJClientBuildSceneIndex(tbstr[1])
if xianjienSceneIndexType:isMoJie(sceneIdx)then
sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
end
self.rijbdata={handletype,xjServerEnityType.eClientBuild,tbstr[1],sceneIdx,buildCfg.x,buildCfg.y}
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,buildCfg.x,buildCfg.y,sceneIdx)
tbstr[1]=link
xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==13 then
local xj_entitytype=tbstr[1]or 3
local xj_cfgid=tbstr[2]or 1
local xj_sceneidx=tbstr[6]or 1
local xj_x=tbstr[7]or 1
local xj_y=tbstr[8]or 1
local xj_cfg=xianjieController:xjrzgetCfg_hj(xj_entitytype,xj_cfgid)
self.rijbdata={handletype,xj_entitytype,xj_cfgid,xj_sceneidx,xj_x,xj_y}
local namestr=FMT.fmt("【{0}】（{1}，{2}）",xj_cfg.name,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
local ok,ret=xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==14 then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,tbstr[1])
local sceneIdx=xianjieController:getXJClientBuildSceneIndex(tbstr[1])
if xianjienSceneIndexType:isMoJie(sceneIdx)then
sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
end
self.rijbdata={handletype,xjServerEnityType.eClientBuild,tbstr[1],sceneIdx,buildCfg.x,buildCfg.y}
self.rijbdata.monster=tbstr[2]
local namestr=FMT.fmt("【{0}】（{1}，{2}）",buildCfg.name,buildCfg.x,buildCfg.y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,buildCfg.x,buildCfg.y,sceneIdx)
tbstr[1]=link
xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==15 then
local effectCfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,tbstr[1])
if effectCfg.effectType==3 then
local mojunData=xianjieModel:getMoJunData()
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,tbstr[2])
local sceneIdx=xianjieController:getXJClientBuildSceneIndex(tbstr[2])
if xianjienSceneIndexType:isMoJie(sceneIdx)then
sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
end
self.rijbdata={handletype,xjServerEnityType.eMoJieMoJunFenShen,cfg.fenshen,sceneIdx,buildCfg.x,buildCfg.y}
self.rijbdata.monster=cfg.fenshen
end
local namestr=FMT.fmt("【{0}】",effectCfg.name)
tbstr[1]=namestr
xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==16 then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,tbstr[1])
local sceneIdx=xianjieController:getXJClientBuildSceneIndex(tbstr[1])
if xianjienSceneIndexType:isMoJie(sceneIdx)then
sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
end
self.rijbdata={handletype,xjServerEnityType.eClientBuild,tbstr[1],sceneIdx,buildCfg.x,buildCfg.y}
self.rijbdata.monster=tbstr[2]
local namestr=FMT.fmt("【{0}】（{1}，{2}）",buildCfg.name,buildCfg.x,buildCfg.y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,buildCfg.x,buildCfg.y,sceneIdx)
tbstr[1]=link

if tbstr[3]then
tbstr[3]=mathHelper.formatNumber(tbstr[3])
end
if tbstr[4]then
tbstr[4]=mathHelper.formatNumber(tbstr[4])
end

xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==17 then
local boxCfg=cfgHelper.get2(cfg_seasonmojunboxconfig_get,tbstr[1])

xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
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
local hideStage=xj_entitytype==xjServerEnityType.eMoJieMoZong_Small or xj_entitytype==xjServerEnityType.eMoJieMoZong_Big

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
elseif handletype==19 then
local xj_entitytype=tbstr[1]or 3
local xj_cfgid=tbstr[2]or 1
local xj_sceneidx=tbstr[7]or 1
local xj_x=tbstr[8]or 1
local xj_y=tbstr[9]or 1

local isMoJieNote=xianjienSceneIndexType:isMoJie(xj_sceneidx)or false
if isMoJieNote then
xj_sceneidx=xianjieModel:getCurrentMoJieSceneIndex()or xj_sceneidx
end

self.rijbdata={handletype,xj_entitytype,xj_cfgid,xj_sceneidx,xj_x,xj_y}
local xj_cfg=xianjieController:xjrzgetCfg_hj(xj_entitytype,xj_cfgid)
local hideStage=xj_entitytype==xjServerEnityType.eMoJieMoZong_Small or xj_entitytype==xjServerEnityType.eMoJieMoZong_Big or xj_entitytype==xjServerEnityType.eMoJieMoJunYaoMo
local gwname=xianjieController:xjrzgetgwName_hj(xj_cfg,hideStage)
local namestr=FMT.fmt("【{0}】（{1}，{2}）",gwname,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
local ok,ret=xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==20 then
local name=tbstr[1]
local xj_entitytype=tbstr[2]
local xj_cfgid=tbstr[3]
local xj_cfg=xianjieController:xjrzgetCfg_hj(xj_entitytype,xj_cfgid)
local hideStage=xj_entitytype==xjServerEnityType.eMoJieMoZong_Small or xj_entitytype==xjServerEnityType.eMoJieMoZong_Big or xj_entitytype==xjServerEnityType.eMoJieMoJunYaoMo
local gwname=xianjieController:xjrzgetgwName_hj(xj_cfg,hideStage)
local namestr=FMT.fmt("【{0}】",gwname)
str_2=self.fmt(str_1,name,namestr)
elseif handletype==21 then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,tbstr[1])
local namestr=FMT.fmt("【{0}】",buildCfg.name)
tbstr[1]=namestr

xpcall(function()
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
local hideStage=xj_entitytype==xjServerEnityType.eMoJieMoZong_Small or xj_entitytype==xjServerEnityType.eMoJieMoZong_Big or xj_entitytype==xjServerEnityType.eMoJieMoJunYaoMo
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

elseif handletype==24 then
local xj_entitytype=tbstr[1]or 3
local xj_cfgid=tbstr[2]or 1
local xj_sceneidx=tbstr[3]or 1
local xj_x=tbstr[4]or 1
local xj_y=tbstr[5]or 1
local curhp=tbstr[10]or 1
local nowhp=tbstr[11]or 1
local maxhp=tbstr[12]or 1
curhp=tonumber(curhp)
nowhp=tonumber(nowhp)
maxhp=tonumber(maxhp)

local _shenyuhp=(nowhp/maxhp)*100
if _shenyuhp<0.01 and _shenyuhp>0 then
_shenyuhp=0.01
end
if _shenyuhp>0 then
_shenyuhp=string.format("%.2f",_shenyuhp)
end
local _shanghaihp=(curhp/maxhp)*100
if _shanghaihp<0.01 and _shanghaihp>0 then
_shanghaihp=0.01
end
if _shanghaihp>0 then
_shanghaihp=string.format("%.2f",_shanghaihp)
end

local isMoJieNote=xianjienSceneIndexType:isMoJie(xj_sceneidx)or false
if isMoJieNote then
xj_sceneidx=xianjieModel:getCurrentMoJieSceneIndex()or xj_sceneidx
end

self.rijbdata={handletype,xj_entitytype,xj_cfgid,xj_sceneidx,xj_x,xj_y}
local xj_cfg=xianjieController:xjrzgetCfg_hj(xj_entitytype,xj_cfgid)
local hideStage=xj_entitytype==xjServerEnityType.eMoJieShangGuMoster
local gwname=xianjieController:xjrzgetgwName_hj(xj_cfg,hideStage)
local namestr=FMT.fmt("【{0}】（{1}，{2}）",gwname,xj_x,xj_y)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",namestr,xj_x,xj_y,xj_sceneidx)
tbstr[1]=link
tbstr[10]=_shanghaihp
tbstr[11]=_shenyuhp

local ok,ret=xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
elseif handletype==26 then

local seasonId=tbstr[5]
if not seasonId then
seasonId=-1
end
local namestr=xianjieModel:getSgMonsterTypeNameEx(1,seasonId)
tbstr[5]=namestr

xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0},handletype={1}',cfgid,handletype))
end)
else
xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,非特殊处理类型,cfgid={0},handletype={1}',cfgid,handletype))
end)
end
return str_2
end

function UIXianJie_noteMonsterWin.fmt(content,...)
local args={...}
local temp={}
for i,v in ipairs(args)do
temp[tostring(i-1)]=tostring(v)
end
local ret=string_gsub(content,"{(%d+)}",temp)
return ret
end
