







def_class("UIXianJie_noteJiJie",UIWindowBase)









function UIXianJie_noteJiJie:bindComponents()

self.closeButton=UIButton.get(self,0)
self.title=UIText.get(self,1)
self.LogScrollView=UILoopListView.new(self,2)
self.logGridPanel=UIObject.get(self,3)
self.frame=UIButton.get(self,4)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXianJie_noteJiJie")end)

self.LogScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.frame:setButtonClick(function()self:onFrame()end)



end


function UIXianJie_noteJiJie:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
self.LogScrollView:deleteSelf();self.LogScrollView=nil;
_UIObject_release(self.logGridPanel);self.logGridPanel=nil;
_UIObject_release(self.frame);self.frame=nil;
end


















local this=nil
local itemcmp=
{
hpslider=0,
head=1,
idx=2,
severid=3,
playername=4,
hfbtn=5,
mybg=6,

shpanel=8,
txtlist={9,10,11},
}
local colors=
{
[1]="#549327",
[2]="#ca631d",
[3]="#c82c2c",
}
local names=
{
[1]="轻伤修士",
[2]="重伤修士",
[3]="陨落修士",
}


function UIXianJie_noteJiJie:onLoaded(...)
self:bindComponents()
local id=self.LogScrollView:getID()
this=self
self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UIXianJie_noteJiJie:__delete()
self:unbindComponents()
end




function UIXianJie_noteJiJie:onShow(argtable,afterOnloaded)
self.rzguid=argtable[1]
if self.rzguid then

self:updataData()
self:RefreshWin()
end
end


function UIXianJie_noteJiJie:onHide()

end
function UIXianJie_noteJiJie:onStartAction()

end

function UIXianJie_noteJiJie:onFreshAction(index,widget)
self:refreshItem(widget,index)
end



function UIXianJie_noteJiJie:updataData()
self.data=xianjieModel:GetJiJie_Databy(self.rzguid)
self.isBoss=false
end


function UIXianJie_noteJiJie:RefreshWin()
local itemIdList={}
local resourcetb=self.data
self.LogScrollView:initData("xjjijie_Item",itemIdList)
if next(resourcetb)then
for i=1,#resourcetb do
itemIdList[i]=i
end
self.LogScrollView:initData("xjjijie_Item",itemIdList)
local nowShowItemCount=self.logGridPanelCmp.ShownItemCount
for i=0,nowShowItemCount-1 do
local item=self.logGridPanelCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshItem(item.Widget,index)
end
end
end
end

function UIXianJie_noteJiJie:refreshItem(item,idx)
if item==nil then
return
end
local jijieData=self.data[idx]

local myactorid=playerModel:getActorID()
item:SetChildActive(itemcmp.mybg,myactorid==jijieData.actorid)
item:SetChildText(itemcmp.idx,idx)

local incoinfo_table={iconInfo=jijieData.iconInfo,scale=0.9}
playerController:setHeadIcon(item,itemcmp.head,incoinfo_table)


local guildname=FMT.fmt("【{0}】",jijieData.guildname)
item:SetChildText(itemcmp.severid,guildname)
item:SetChildText(itemcmp.playername,jijieData.actorname)


local shdatalen=jijieData.len
local shdata=jijieData.list
if shdatalen>0 and shdata then
item:SetChildActive(itemcmp.shpanel,true)
local allsh=0
for k,v in ipairs(shdata)do
allsh=allsh+v
end
if allsh==0 then allsh=1 end

for k=1,3 do
if itemcmp.txtlist[k]then
local v=shdata[k+1]or 0
local bfbnum=(v/allsh)*100
local bfbnumstr=string.format('%0.2f',bfbnum)
local str=FMT.fmt("{0}：<color=#ca631d>{1}</color><color=#549327>（{2}%）</color>",names[k],mathHelper.formatNumber4(v,2),bfbnumstr)
item:SetChildText(itemcmp.txtlist[k],str)
end
end
else
item:SetChildActive(itemcmp.shpanel,false)
end


local reportId=jijieData.fightlogid
if not reportId or reportId==""then
item:SetChildActive(itemcmp.hfbtn,false)
else
local xianJieLog=xianjieModel:Get_logtb()
local logtype
local datatb
for k,v in ipairs(xianJieLog)do
if v.guid and v.guid==self.rzguid then
logtype=v.logtype
datatb=v
end
end
if logtype then
item:SetChildActive(itemcmp.hfbtn,true)
item:SetChildButtonClick(itemcmp.hfbtn,function()
local fightLogType=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"fightLogType")
local _timetxt=timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(),timeHelper.convertLongStamp(tonumber(datatb.sec)))
_timetxt=FMT.fmt("战斗简报时间：{0}",_timetxt)
local huifang_txt=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"huifang_txt")
local is_win=cfgHelper.get2(cfg_fairylandlogconfig_get,datatb.logtype,"is_win")
local _rijbdata=this.rijbdata
local _fun=function(fightLoglist)
local fightLog=fightLoglist[1]
local _fightInfo=fightModel:getJsonReport(fightLog)
local temp=
{
win=is_win,
yunjun=true,
cfgid=datatb.logtype,
fightInfo=_fightInfo,
timetxt=_timetxt,
fightarry={reportId,{nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,eReplayType=eRePlayerType.xianjielog}},
rijbdata=_rijbdata,
rewlist=datatb.list,
isyuanjun=true,
}
this:showWindow('UIXianJie_notejianbao',temp)
end
local args={nil,reportId,eRePlayerType.xianjielog,huifang_txt,is_win,showBattle=true,extraCall=_fun}
if fightLogType==1 then
fightController:send_log_list({reportId},args)
elseif fightLogType==2 then
fightController:send_log_list({reportId},args,true)
elseif fightLogType==3 then
fightController:send_log_list({reportId},args,nil,true)
end
end)
end
end

end

function UIXianJie_noteJiJie:onFrame()
UIManager:closeWindow("UIXianJie_noteJiJie")
end