







def_class("UIXM_ZZSH_noteResourceWin",UIWindowBase)









function UIXM_ZZSH_noteResourceWin:bindComponents()

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


function UIXM_ZZSH_noteResourceWin:unbindComponents()
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

local this=nil

function UIXM_ZZSH_noteResourceWin:onLoaded(...)
self:bindComponents()
local id=self.LogScrollView:getID()
this=self

self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UIXM_ZZSH_noteResourceWin:__delete()

if zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()~=zhengzhanshanhaiModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange)
zhengzhanshanhaiModel:Set_reddotchangeflag(not zhengzhanshanhaiModel:Get_reddotchangeflag())
end

this=nil
self:unbindComponents()
end

function UIXM_ZZSH_noteResourceWin:onStartAction(index,widget)

end


function UIXM_ZZSH_noteResourceWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end



function UIXM_ZZSH_noteResourceWin:onShow(argtable,afterOnloaded)

self.root:setActive(true)
zhengzhanshanhaiModel:jude_haveReward()
self:RefreshWin()

end


function UIXM_ZZSH_noteResourceWin:onHide()
if zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()~=zhengzhanshanhaiModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange)
zhengzhanshanhaiModel:Set_reddotchangeflag(not zhengzhanshanhaiModel:Get_reddotchangeflag())
end
self.root:setActive(false)
end


function UIXM_ZZSH_noteResourceWin:RefreshWin()
zhengzhanshanhaiModel:saveRecord_Resource()

local itemIdList={}
local resourcetb=zhengzhanshanhaiModel:Get_resourcetb()
self.LogScrollView:initData("log_Item",itemIdList)
if next(resourcetb)then
self.notLog:setActive(false)

self.clearBtn:setActive(true)
for i=1,#resourcetb do

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
self.onekeyReddot:setActive(zhengzhanshanhaiModel:get_ResourceReddot())
self.onekeyBtn:setActive(zhengzhanshanhaiModel:get_ResourceReddot())

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


function UIXM_ZZSH_noteResourceWin:refreshItem(item,idx)
if item==nil then

return
end


















local datatb=zhengzhanshanhaiModel:Get_singleResourcetb(idx)
local cfgid=datatb.logtype
local str_cfg=zhengzhanshanhaiController:getZZSHCfg_log(cfgid,"str")
if cfgid~=16 then
local logtxt=self:SetStr(str_cfg,item,datatb.params,cfgid)
item:SetChildText(2,logtxt)

item:SetChildActive(itemCmp.gotoroot,false)

end

self:Set_BigType(item,datatb)


self:Set_Reward(item,datatb.len,datatb.list,datatb.recv)

self:SetFightBtn(item,datatb,idx)
self:Set_Righttop(item,datatb)

item:SetChildActive(itemCmp.openjijie,false)
end


function UIXM_ZZSH_noteResourceWin:SetFightBtn(item,datatb,idx)
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
local huifang_txt=zhengzhanshanhaiController:getZZSHCfg_log(datatb.logtype,"huifang_txt")
local is_win=zhengzhanshanhaiController:getZZSHCfg_log(datatb.logtype,"is_win")
item:SetChildButtonClick(24,function()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local isSeason=shSeasonId~=-1
local isBigCrossServer=isSeason
fightController:send_254_29(reportId,{nil,reportId,eRePlayerType.shanhailog,huifang_txt,1,nil,datatb.list,is_win},true,isBigCrossServer,nil,isSeason)end)
end

else
item:SetChildActive(24,false)
item:SetChildActive(itemCmp.time1,true)
item:SetChildText(itemCmp.time1,
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
end

end























function UIXM_ZZSH_noteResourceWin:Set_Righttop(item,datatb)

item:SetChildActive(itemCmp.new,datatb.isnew==1)
if datatb.len>0 then
item:SetChildActive(itemCmp.reward_flag,datatb.recv==1)
else
item:SetChildActive(itemCmp.reward_flag,false)
end

end



function UIXM_ZZSH_noteResourceWin:Set_BigType(item,datatb)
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



function UIXM_ZZSH_noteResourceWin:SetStr(str_cfg,item,json_str,cfgid)
local str_1=FMT.fmt("                      {0}",str_cfg)


local tbstr=self:splitStr(json_str)
local name,stage=self:GetName(cfgid,tbstr[1])
if not stage then

local str_2=FMT.fmt(str_1,name)
local str_3=comHelper.getCheckLayoutStr(self.checkTxt:getGameObject(),item:GetChildSizeDeltaX(2),str_2)
return str_3
end
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,name)
local str_2=nil

if cfgid==7 or cfgid==12 or cfgid==14 or cfgid==15 then
local namestr2=FMT.fmt("【{0}阶{1}】",stage,name)
local qbData=zhengzhanshanhaiModel:getQingBaoData(tbstr[2])

local link=FMT.fmt("<a;{0};{1};1;19,{2};/>",namestr2,stage,tbstr[2])
str_2=FMT.fmt(str_1,link)


elseif cfgid==8 or cfgid==9 or cfgid==10 or cfgid==11 then
local namestr2=FMT.fmt("【{0}阶{1}】",stage,name)
local qbData=zhengzhanshanhaiModel:getQingBaoData(tbstr[5])


local link=FMT.fmt("<a;{0};{1};1;19,{2};/>",namestr2,stage,tbstr[5])
local link2=FMT.fmt("<a;{0};4;1;14,{1},0;/>",tbstr[3],tbstr[6])
str_2=FMT.fmt(str_1,link,tbstr[2],link2)

elseif cfgid==6 then
str_2=FMT.fmt(str_1,namestr and namestr or tbstr[1])
elseif#tbstr==1 then

str_2=FMT.fmt(str_1,namestr and namestr or tbstr[1])
elseif#tbstr==2 then
str_2=FMT.fmt(str_1,namestr and namestr or tbstr[1],tbstr[2])

else
str_2=FMT.fmt(str_1,namestr and namestr or tbstr[1],tbstr[2],tbstr[3])
end

local str_3=comHelper.getCheckLayoutStr(self.checkTxt:getGameObject(),item:GetChildSizeDeltaX(2),str_2)
return str_3
end


local cjson=require'cjson'

function UIXM_ZZSH_noteResourceWin:splitStr(str)
return cjson.decode(str)









end


function UIXM_ZZSH_noteResourceWin:GetName(id,baodiID)


if not baodiID or type(baodiID)=="userdata"then
logErr("baodiID为空",id)
return"未知宝地",nil
end
local type=zhengzhanshanhaiController:getZZSHCfg_log(id).type
if type==2 then
local baoditb=zhengzhanshanhaiController:getZZSHCfg_baodi(baodiID)
local stage=baoditb.stage

local moneytype=baoditb.moneytype
local moneyname=moneyModel.getMoneyName(moneytype)


return moneyname,stage
end
end


function UIXM_ZZSH_noteResourceWin:onClearBtn()
local tb=zhengzhanshanhaiModel:Find_Resourceguid()
if next(tb)then
zhengzhanshanhaiController:Send_Clear_req(#tb,tb)
UIManager.info("已清除日志记录")
end
end
function UIXM_ZZSH_noteResourceWin:onOnekeyBtn()
local tb=zhengzhanshanhaiModel:Find_ResourceReward()
if next(tb)then
zhengzhanshanhaiController:Send_reward_req(#tb,tb)
end
end

function UIXM_ZZSH_noteResourceWin:Set_Reward(item,len,list,recv)
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

function UIXM_ZZSH_noteResourceWin:onTips()
local d={}
d.title='规则说明'
d.mode=3
d.name='zhengzhanshanhai_log_rule_%d'
d.closeCB=function()

end
UIManager:showWindow('UIRuleWin',d)
end
