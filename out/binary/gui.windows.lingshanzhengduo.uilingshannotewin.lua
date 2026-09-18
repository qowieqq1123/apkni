







def_class("UILingShanNoteWin",UIWindowBase)









function UILingShanNoteWin:bindComponents()

self.checkTxt=UIText.get(self,0)
self.clearBtn=UIButton.get(self,1)
self.logGridPanel=UIObject.get(self,2)
self.LogScrollView=UILoopListView.new(self,3)
self.notLog=UIObject.get(self,4)
self.onekeyBtn=UIButton.get(self,5)
self.onekeyReddot=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.tips=UIButton.get(self,8)
self.tipsText=UIText.get(self,9)

self.clearBtn:setButtonClick(function()self:onClearBtn()end)

self.LogScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.onekeyBtn:setButtonClick(function()self:onOnekeyBtn()end)

self.tips:setButtonClick(function()self:onTips()end)



end


function UILingShanNoteWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.checkTxt);self.checkTxt=nil;
_UIObject_release(self.clearBtn);self.clearBtn=nil;
_UIObject_release(self.logGridPanel);self.logGridPanel=nil;
self.LogScrollView:deleteSelf();self.LogScrollView=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.onekeyBtn);self.onekeyBtn=nil;
_UIObject_release(self.onekeyReddot);self.onekeyReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end
















local _this

local itemCmp=
{
desc=2,
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
time2=25,
openjijie=26,
opentext=27,
}

local icontype=
{
[1]="icon_typaiqianzjui_1",
[2]="icon_typaiqianzjui_2",
[3]="icon_typaiqianzjui_3",
}




function UILingShanNoteWin:onLoaded(...)
self:bindComponents()

_this=self

self.areaNames={
'山底',
'山腰',
'山顶'
}

local id=self.LogScrollView:getID()
self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UILingShanNoteWin:__delete()
self:unbindComponents()

_this=nil

if zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()~=zhengzhanshanhaiModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange)
zhengzhanshanhaiModel:Set_reddotchangeflag(not zhengzhanshanhaiModel:Get_reddotchangeflag())
end

UIManager:callWindowFunc('UILingShanZhengDuoWin','setLogReddot')
end

function UILingShanNoteWin:onStartAction(index,widget)

end


function UILingShanNoteWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end




function UILingShanNoteWin:onShow(argtable,afterOnloaded)
self.root:setActive(true)
zhengzhanshanhaiModel:jude_haveReward()
self:RefreshWin()
end


function UILingShanNoteWin:onHide()
self.root:setActive(false)
end

function UILingShanNoteWin:onStartAction(index,widget)

end

function UILingShanNoteWin:getDatas()
local lingShantb=zhengzhanshanhaiModel:Get_lingShantb()
return lingShantb
end

function UILingShanNoteWin:RefreshWin()
zhengzhanshanhaiModel:saveRecord_lingShan()

local itemIdList={}
self.datas=self:getDatas()
self.LogScrollView:initData("log_Item",itemIdList)
if next(self.datas)then
self.notLog:setActive(false)
self.clearBtn:setActive(true)
for i=1,#self.datas do
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
local check=zhengzhanshanhaiModel:get_LingShanReddot()
self.onekeyReddot:setActive(check)
self.onekeyBtn:setActive(check)

local logNum1,logNum2=zhengzhanshanhaiModel:Get_groupLogNum(6),zhengzhanshanhaiModel:Get_groupLogNum(7)
local curNum=math.max(logNum1,logNum2)
local maxNum=zhengzhanshanhaiModel:Get_groupLogMaxNum()
self.tipsText:setText(string.format("奖励/记录日志保存上限：<color=%s>%d/%d</color>",curNum<maxNum and"#549327"or"#c82c2c",curNum,maxNum))
end

function UILingShanNoteWin:refreshItem(item,idx)
if item==nil then
return
end
















local datatb=self.datas[idx]
local cfgid=datatb.logtype
local cfg=cfgHelper.get1(cfg_zhengzhanshanhailognewconfig_get,cfgid)
local param=jsonHelper.decode_josn(datatb.params)
local logtxt=self:SetStr(item,param,cfg)
item:SetChildText(2,logtxt)

item:SetChildActive(itemCmp.gotoroot,false)

self:Set_BigType(item,datatb)


self:Set_Reward(item,datatb.len,datatb.list,datatb.recv)

self:SetFightBtn(item,datatb)
self:Set_Righttop(item,datatb)


self:setZhengDuoBtn(item,cfgid,param)
end

function UILingShanNoteWin:setZhengDuoBtn(item,cfgid,param)
if cfgid==44 or cfgid==45 then
item:SetChildActive(itemCmp.openjijie,true)
item:SetChildText(itemCmp.opentext,'前往争夺')
item:SetChildButtonClick(itemCmp.openjijie,function()
local id=zhengzhanshanhaiModel:getLunState()
if id==eZZSH_State.ePVPFight or id==eZZSH_State.ePVPStandby then
UIManager.info('山海世界正处于战争期，灵山已封山，无法前往争夺')
return
end

local args={mountId=param[1],areaId=param[2],pos=param[3]}
local win=UIManager:findActiveWindow('UILingShanZhengDuoWin')
if win then
win:refresh(args)
oneTabScreenController:closeUI()
else
UILSZDControl:showLSZDWinEx(args,true)
end
end)
else
item:SetChildActive(itemCmp.openjijie,false)
end
end

function UILingShanNoteWin:Set_BigType(item,datatb)
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


item:SetChildCSImageSprite(itemCmp.smallType,abname,cfgHelper.get2(cfg_zhengzhanshanhailognewconfig_get,datatb.logtype,"small_type"))
end

function UILingShanNoteWin:Set_Reward(item,len,list,recv)
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


function UILingShanNoteWin:SetFightBtn(item,datatb)
local have_huifang=cfgHelper.get2(cfg_zhengzhanshanhailognewconfig_get,datatb.logtype,"have_huifang")
if have_huifang then
local logtb=jsonHelper.decode_josn(datatb.params)
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
local huifang_txt=cfgHelper.get2(cfg_zhengzhanshanhailognewconfig_get,datatb.logtype,"huifang_txt")
local is_win=cfgHelper.get2(cfg_zhengzhanshanhailognewconfig_get,datatb.logtype,"is_win")
item:SetChildButtonClick(24,function()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local isSeason=shSeasonId~=-1
local isBigCrossServer=isSeason
local args={nil,reportId,eRePlayerType.shanhailog,huifang_txt,4,nil,datatb.list,is_win}
fightController:send_254_29(reportId,args,true,isBigCrossServer,nil,isSeason)
end)
end
else
item:SetChildActive(24,false)
item:SetChildActive(itemCmp.time1,true)
item:SetChildText(itemCmp.time1,
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
end
end

function UILingShanNoteWin:Set_Righttop(item,datatb)
item:SetChildActive(itemCmp.new,datatb.isnew==1)
if datatb.len>0 then
item:SetChildActive(itemCmp.reward_flag,datatb.recv==1)
else
item:SetChildActive(itemCmp.reward_flag,false)
end
end


function UILingShanNoteWin:SetStr(item,param,logCfg)
local str_1=FMT.fmt("                      {0}",logCfg.str)

local id=param[1]
local cfg=UILSZDControl:getLingShanConfig(id)
local str_2=FMT.fmt(str_1,cfg.mount_name,self.areaNames[param[2]])
if logCfg.have_huifang then
str_2=FMT.fmt(str_1,cfg.mount_name,self.areaNames[param[2]],param[4]or'')
else
str_2=FMT.fmt(str_1,cfg.mount_name,self.areaNames[param[2]])
end
local str_3=comHelper.getCheckLayoutStr(self.checkTxt:getGameObject(),item:GetChildSizeDeltaX(2),str_2)
return str_3
end



function UILingShanNoteWin:onClearBtn()
local tb=zhengzhanshanhaiModel:Find_LingShanguid()
if next(tb)then
zhengzhanshanhaiController:Send_Clear_req(#tb,tb)
UIManager.info("已清除日志记录")
end
end

function UILingShanNoteWin:onOnekeyBtn()
local tb=zhengzhanshanhaiModel:Find_LingShanReward()
if next(tb)then
zhengzhanshanhaiController:Send_reward_req(#tb,tb)
end
end

function UILingShanNoteWin:onTips()
local d={}
d.title='规则说明'
d.mode=3
d.name='zhengzhanshanhai_log_rule_%d'
d.closeCB=function()

end
UIManager:showWindow('UIRuleWin',d)
end

