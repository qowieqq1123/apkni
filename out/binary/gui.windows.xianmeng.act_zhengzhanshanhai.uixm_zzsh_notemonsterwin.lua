







def_class("UIXM_ZZSH_noteMonsterWin",UIWindowBase)









function UIXM_ZZSH_noteMonsterWin:bindComponents()

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


function UIXM_ZZSH_noteMonsterWin:unbindComponents()
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
time1=7,
reward_flag=8,
new=9,
middleType=12,
itemroot=13,
itemlist={14,15,16,17,18,19,20,28,29,30,31,32},
itembg=21,
logtips=22,
gotoroot=23,
time2=25,
openjijie=26,
opentext=27,
}
local huifang_value={
[40]=function(logtb)
return mathHelper.formatNumber(logtb[2])
end,
[296]=function(logtb)
return mathHelper.formatNumber(logtb[2])
end,
}

local string_gsub=string.gsub
local this=nil

function UIXM_ZZSH_noteMonsterWin:onLoaded(...)

self:bindComponents()
this=self
local id=self.LogScrollView:getID()

self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)

end


function UIXM_ZZSH_noteMonsterWin:__delete()

if zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()~=zhengzhanshanhaiModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange)
zhengzhanshanhaiModel:Set_reddotchangeflag(not zhengzhanshanhaiModel:Get_reddotchangeflag())
end
this=nil
self:unbindComponents()
end
function UIXM_ZZSH_noteMonsterWin:onStartAction()

end


function UIXM_ZZSH_noteMonsterWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end



function UIXM_ZZSH_noteMonsterWin:onShow(argtable,afterOnloaded)

self.root:setActive(true)






zhengzhanshanhaiModel:jude_haveReward()




self.showtipsflag=zhengzhanshanhaiModel:Jude_isShowTips()
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


function UIXM_ZZSH_noteMonsterWin:onHide()

if zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()~=zhengzhanshanhaiModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange)
zhengzhanshanhaiModel:Set_reddotchangeflag(not zhengzhanshanhaiModel:Get_reddotchangeflag())
end
self.root:setActive(false)
end

function UIXM_ZZSH_noteMonsterWin:RefreshWin()
zhengzhanshanhaiModel:saveRecord_Monster()

local itemIdList={}
local monstertb=zhengzhanshanhaiModel:Get_monstertb()
self.LogScrollView:initData("log_Item",itemIdList)
if next(monstertb)then
self.notLog:setActive(false)

self.clearBtn:setActive(true)
for i=1,#monstertb do

itemIdList[i]=i
end

self.LogScrollView:initData("log_Item",itemIdList)
local nowShowItemCount=self.logGridPanelCmp.ShownItemCount
for i=0,nowShowItemCount-1 do
local item=self.logGridPanelCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshItem(item.Widget,index)
end
end
zhengzhanshanhaiModel:ChaiFenLog()
else
self.notLog:setActive(true)

self.clearBtn:setActive(false)
end
self.onekeyReddot:setActive(zhengzhanshanhaiModel:get_monsterReddot())
self.onekeyBtn:setActive(zhengzhanshanhaiModel:get_monsterReddot())

local logNum1,logNum2=zhengzhanshanhaiModel:Get_groupLogNum(1),zhengzhanshanhaiModel:Get_groupLogNum(2)
local curNum=math.max(logNum1,logNum2)
local maxNum=zhengzhanshanhaiModel:Get_groupLogMaxNum()
self.tipsText:setText(string.format("奖励/记录日志保存上限：<color=%s>%d/%d</color>",curNum<maxNum and"#549327"or"#c82c2c",curNum,maxNum))
end

local icontype=
{
[1]="icon_typaiqianzjui_1",
[2]="icon_typaiqianzjui_2",
[3]="icon_typaiqianzjui_3",
}




function UIXM_ZZSH_noteMonsterWin:refreshItem(item,idx)
if item==nil then

return
end


















local datatb=zhengzhanshanhaiModel:Get_singleMonstertb(idx)
local cfgid=datatb.logtype
local config=zhengzhanshanhaiController:getZZSHCfg_log(cfgid)
local str_cfg=config.str

if cfgid~=16 then
local logtxt=self:SetStr(str_cfg,item,datatb.params,cfgid)
item:SetChildText(2,logtxt)

item:SetChildActive(itemCmp.gotoroot,false)
else
local logtb=self:splitStr(datatb.params)
local monsterid=tonumber(tostring(logtb[1]))
local player_rank=tonumber(tostring(logtb[2]))


local logtxt=self:SetStr(str_cfg,item,datatb.params,cfgid)

item:SetChildText(2,logtxt)

local gototext="前往打开"
item:SetChildActive(itemCmp.gotoroot,true)
item:SetChildText(10,gototext)
item:SetChildButtonClick(itemCmp.gotoroot,function()
jumpManager:jump({id=7011})
end)
end

self:Set_BigType(item,datatb)


self:Set_Reward(item,datatb.len,datatb.list,datatb.recv)
self:SetFightBtn(item,datatb,idx)
self:Set_Righttop(item,datatb)

item:SetChildActive(itemCmp.openjijie,false)

if(config.jijie)and datatb.recordguid~=0 then
item:SetChildActive(itemCmp.openjijie,true)
item:SetChildText(itemCmp.opentext,FMT.fmt("集结战报"))
item:SetChildButtonClick(itemCmp.openjijie,function()
self:showjijie(datatb.recordguid)
end)
else
item:SetChildActive(itemCmp.openjijie,false)
end


end


function UIXM_ZZSH_noteMonsterWin:SetFightBtn(item,datatb,idx)
local have_huifang=zhengzhanshanhaiController:getZZSHCfg_log(datatb.logtype,"have_huifang")
if have_huifang then

local logtb=self:splitStr(datatb.params)

local reportId=tostring(logtb[have_huifang])
if reportId==""then
item:SetChildActive(24,false)
item:SetChildActive(itemCmp.time1,true)
item:SetChildText(itemCmp.time1,
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
else
item:SetChildActive(itemCmp.time1,false)
item:SetChildActive(24,true)
item:SetChildText(itemCmp.time2,
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
local hurt_hp=nil
local huifang_handle=huifang_value[datatb.logtype]
if huifang_handle then
hurt_hp=huifang_handle(logtb)
else
hurt_hp=tonumber(tostring(logtb[2]))/100
end
local huifang_txt=zhengzhanshanhaiController:getZZSHCfg_log(datatb.logtype,"huifang_txt")

local is_win=zhengzhanshanhaiController:getZZSHCfg_log(datatb.logtype,"is_win")
item:SetChildButtonClick(24,function()


local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local isSeason=shSeasonId~=-1
local isBigCrossServer=isSeason
fightController:send_254_29(reportId,{nil,reportId,eRePlayerType.shanhailog,huifang_txt,0,hurt_hp,nil,is_win},true,isBigCrossServer,nil,isSeason)end)
end

else
item:SetChildActive(24,false)
item:SetChildActive(itemCmp.time1,true)
item:SetChildText(itemCmp.time1,
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
end

end



function UIXM_ZZSH_noteMonsterWin:showjijie(guid)
zhengzhanshanhaiController:Send_JiJie_Req(guid)

end

function UIXM_ZZSH_noteMonsterWin:Set_Righttop(item,datatb)
item:SetChildActive(itemCmp.new,datatb.isnew==1)
if datatb.len>0 then
item:SetChildActive(itemCmp.reward_flag,datatb.recv==1)
else
item:SetChildActive(itemCmp.reward_flag,false)
end

end


function UIXM_ZZSH_noteMonsterWin:Set_BigType(item,datatb)
local abname=globalABLookup.zzshicons

if datatb.len==0 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,icontype[1])
else
if datatb.recv==0 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,icontype[2])
elseif datatb.recv==1 then
item:SetChildCSImageSprite(itemCmp.middleType,abname,icontype[3])
end
end


item:SetChildCSImageSprite(11,abname,zhengzhanshanhaiController:getZZSHCfg_log(datatb.logtype,"small_type"))













end


function UIXM_ZZSH_noteMonsterWin:SetStr(str_cfg,item,json_str,cfgid)

local str_1=FMT.fmt("                      {0}",str_cfg)


local tbstr=self:splitStr(json_str)

if cfgid~=5 then
local name,stage=self:GetName(cfgid,tbstr[1])
if not stage then

local str_2=FMT.fmt(str_1,name)
local str_3=comHelper.getCheckLayoutStr(self.checkTxt:getGameObject(),item:GetChildSizeDeltaX(2),str_2)
return str_3
end
else
local name,stage=self:GetName(cfgid,tbstr[2])
if not stage then

local str_2=FMT.fmt(str_1,name)
local str_3=comHelper.getCheckLayoutStr(self.checkTxt:getGameObject(),item:GetChildSizeDeltaX(2),str_2)
return str_3
end
end



local str_2=nil

if#tbstr==1 then
local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,name)
str_2=FMT.fmt(str_1,namestr and namestr or tbstr[1])
elseif cfgid==5 then

local stage=zhengzhanshanhaiController:getZZSHCfg_yishou(tonumber(tostring(tbstr[2])),"stage")
local item_name=zhengzhanshanhaiController:getZZSHCfg_box(stage,"item_name")
local item_color=zhengzhanshanhaiController:getZZSHCfg_box(stage,"color")
local itemstr=FMT.fmt("<color={0}>{1}</color>",FONT_COLOR_VAL[item_color],item_name)
local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[2])))
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,name)
local link2=FMT.fmt("<a;{0};4;1;14,{1},0;/>",tbstr[1],tbstr[3])
str_2=FMT.fmt(str_1,link2,namestr and namestr or tbstr[2],itemstr,1)

elseif cfgid==261 then

local stage=zhengzhanshanhaiController:getZZSHCfg_yishou(tonumber(tostring(tbstr[2])),"stage")
local item_name=zhengzhanshanhaiController:getZZSHCfg_box(stage,"item_name")
local item_color=zhengzhanshanhaiController:getZZSHCfg_box(stage,"color")
local itemstr=FMT.fmt("<color={0}>{1}</color>",FONT_COLOR_VAL[item_color],item_name)
local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[2])))
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,name)
local link2=FMT.fmt("<a;{0};4;1;14,{1},0;/>",tbstr[1],tbstr[3])
str_2=FMT.fmt(str_1,link2,namestr and namestr or tbstr[2],itemstr,1)

elseif cfgid==2 then

local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=string.format("【%s阶%s】",tostring(stage),tostring(name))


local link=FMT.fmt("<a;{0};{1};1;19,{2};/>",namestr,stage,tbstr[5])
str_2=FMT.fmt(str_1,link,(tonumber(tostring(tbstr[2]))/100),(tonumber(tostring(tbstr[3]))/100))

elseif cfgid==258 then

local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=string.format("【%s阶%s】",tostring(stage),tostring(name))

local link=FMT.fmt("<a;{0};{1};1;19,{2};/>",namestr,stage,tbstr[5])
str_2=FMT.fmt(str_1,link,(tonumber(tostring(tbstr[2]))/100),(tonumber(tostring(tbstr[3]))/100))

elseif cfgid==3 then
local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,name)
str_2=FMT.fmt(str_1,namestr and namestr or tbstr[1],(tonumber(tostring(tbstr[2]))/100))

elseif cfgid==259 then
local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,name)
str_2=FMT.fmt(str_1,namestr and namestr or tbstr[1],(tonumber(tostring(tbstr[2]))/100))

elseif cfgid==17 or cfgid==18 then

local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=string.format("【%s阶%s】",tostring(stage),tostring(name))


local link=FMT.fmt("<a;{0};{1};1;19,{2};/>",namestr,stage,tbstr[2])
str_2=FMT.fmt(str_1,link)

elseif cfgid==273 or cfgid==274 then

local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=string.format("【%s阶%s】",tostring(stage),tostring(name))


local link=FMT.fmt("<a;{0};{1};1;19,{2};/>",namestr,stage,tbstr[2])
str_2=FMT.fmt(str_1,link)

elseif cfgid==40 or cfgid==296 then
local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,name)
str_2=FMT.fmt(str_1,namestr and namestr or tbstr[1],mathHelper.formatNumber(tbstr[2]),tbstr[3])
elseif cfgid==50 or cfgid==306 then
local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,name)
tbstr[1]=namestr
tbstr[3]=xianmengModel.getXMPostName(tbstr[3])
xpcall(function()
str_2=self.fmt(str_1,unpack(tbstr))
end,function(err)
logErr(FMT.fmt('日志参数报错,cfgid={0}',cfgid))
end)
elseif#tbstr==2 then
local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,name)
str_2=FMT.fmt(str_1,namestr and namestr or tbstr[1],tbstr[2])
else

local name,stage=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,name)

str_2=FMT.fmt(str_1,namestr and namestr or tbstr[1],tbstr[2],tbstr[3])
end

local str_3=comHelper.getCheckLayoutStr(self.checkTxt:getGameObject(),item:GetChildSizeDeltaX(2),str_2)

return str_3
end



function UIXM_ZZSH_noteMonsterWin:onClearBtn()
local guid_tb=zhengzhanshanhaiModel:Find_Monsterguid()
if next(guid_tb)then
zhengzhanshanhaiController:Send_Clear_req(#guid_tb,guid_tb)
UIManager.info("已清除日志记录")
end
end


function UIXM_ZZSH_noteMonsterWin:onOnekeyBtn()
local guid_tb=zhengzhanshanhaiModel:Find_MonsterReward()
if next(guid_tb)then
zhengzhanshanhaiController:Send_reward_req(#guid_tb,guid_tb)
end
end
local cjson=require'cjson'

function UIXM_ZZSH_noteMonsterWin:splitStr(str)
return cjson.decode(str)










end


function UIXM_ZZSH_noteMonsterWin:GetName(id,monsterid)


if not monsterid or type(monsterid)=="userdata"then
logErr("monsterid为空",id)
return"未知异兽",nil
end
local type=zhengzhanshanhaiController:getZZSHCfg_log(id).type
if type==1 then

local ZZSHmonstercfg=zhengzhanshanhaiController:getZZSHCfg_yishou(monsterid)
local monstertb=ZZSHmonstercfg.monster
local stage=ZZSHmonstercfg.stage

if monstertb and monstertb[1]then
local monstername=cfgHelper.get2(cfg_monstergroup_get,monstertb[1],'name')

return monstername,stage
end
end
end


function UIXM_ZZSH_noteMonsterWin.fmt(content,...)
local args={...}
local temp={}
for i,v in ipairs(args)do
temp[tostring(i-1)]=tostring(v)
end
local ret=string_gsub(content,"{(%d+)}",temp)
return ret
end

function UIXM_ZZSH_noteMonsterWin:Set_Reward(item,len,list,recv)
for i=1,#itemCmp.itemlist do
local rwItem=item:GetChildWidgetBase(itemCmp.itemlist[i])
rwItem:SetChildActive(11,false)
end
if len==0 then
item:SetChildActive(itemCmp.itembg,false)
return
end
item:SetChildActive(itemCmp.itembg,true)


table.sort(list,function(a,b)
local itemConfig=itemsConfig.getConfig(a.param_1)
local color=itemConfig.color
local itemConfig2=itemsConfig.getConfig(b.param_1)
local color2=itemConfig2.color
return color>color2
end)


for k,v in ipairs(list)do
if not itemCmp.itemlist[k]then
break
end
local rwItem=item:GetChildWidgetBase(itemCmp.itemlist[k])
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


function UIXM_ZZSH_noteMonsterWin:onAlllog_tip()

local str=nil
if zhengzhanshanhaiModel:Jude_isShowMaxTips()then
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
okcallback=function(...)

end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end


function UIXM_ZZSH_noteMonsterWin:onTips()
local d={}
d.title='规则说明'
d.mode=3
d.name='zhengzhanshanhai_log_rule_%d'
d.closeCB=function()

end
UIManager:showWindow('UIRuleWin',d)
end