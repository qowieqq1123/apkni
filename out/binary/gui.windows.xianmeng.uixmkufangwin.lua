







def_class("UIXMKuFangWin",UIWindowBase)









function UIXMKuFangWin:bindComponents()

self.root=UIObject.get(self,0)
self.rankFirstList=UIObject.get(self,1)
self.tipsBtn=UIButton.get(self,2)
self.rankLogList=UILoopListView.new(self,3)
self.noteBtn=UIButton.get(self,4)
self.ranktips=UIObject.get(self,5)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.rankLogList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.noteBtn:setButtonClick(function()self:onNoteBtn()end)



end


function UIXMKuFangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rankFirstList);self.rankFirstList=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
self.rankLogList:deleteSelf();self.rankLogList=nil;
_UIObject_release(self.noteBtn);self.noteBtn=nil;
_UIObject_release(self.ranktips);self.ranktips=nil;
end


















local itemidex=
{
title=0,
icon=1,
txtbg=2,
txtnum=3,
btn=4,
btnTxt=5,
mancang=6,
}
local _this
local abNmae="ui/windows/xianmeng/xianmengkufang_atlas_pak.ab"
local iocnTypeName={
'image_xianmengkufang_wz2',
'image_xianmengkufang_wz3',
'image_xianmengkufang_wz4',
}


function UIXMKuFangWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXMKuFangWin:__delete()
self:unbindComponents()
_this=nil
local win=UIManager:findActiveWindow('UIXMKuFangRJWin')
if win then
UIManager:closeWindow("UIXMKuFangRJWin")
end
end




function UIXMKuFangWin:onShow(argtable,afterOnloaded)


self:refreshKuFangMoneyPanel()


self:refreshKuFangJXPanel()
end


function UIXMKuFangWin:onHide()

end





function UIXMKuFangWin:onCommitBtn()
end



function UIXMKuFangWin:onRewardObj()
end


function UIXMKuFangWin:onNoteBtn()
UIManager:showWindow("UIXMKuFangRJWin")
end

function UIXMKuFangWin:onTipsBtn()
local d={}
d.title='捐赠说明'
d.mode=3
d.name='UIXMKuFangWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end



function UIXMKuFangWin:refreshKuFangJXPanel()


local info=xianmengModel:getXMJuanXianLogData()
_this.ranktips:setActive(false)
local temp={}
if info and next(info)~=nil then
local temp2={}
for i=#info,1,-1 do
temp2[#temp2+1]=info[i]
end
for k,v in ipairs(temp2)do
if v.jsonStr then
local argsstr=jsonHelper.decode(v.jsonStr)
temp[#temp+1]={str=argsstr,logType=v.logType}
end
end
end


if#temp>0 then




































_this.rankLogList:initData("rankLogItem",temp)
end
if#temp==0 then
_this.ranktips:setActive(true)
end
end

function UIXMKuFangWin:onFreshAction(index,widget,data)
local item=widget
local cfg=cfg_xianmengjuanxianlogconfig()
if data.logType and data.str then
local logType=data.logType

local logtable=cfg[logType].log

local name=data.str[1]
local zmNmae=data.str[2]



if logType==1 then
local cfg_str_zm=logtable[1]
local cfg_str=logtable[2]
local itemId=tonumber(data.str[3]or 1)
local itemnum=tonumber(data.str[4]or 0)
local itemConfig=itemsConfig.getConfig(itemId)
local color=itemConfig.color
local str=FMT.fmt("{0}枚{1}",itemnum,itemConfig.name)
local item_name=FMT.cfmt(color,str)
local string=""
if type(zmNmae)~="string"or zmNmae==""then
string=FMT.fmt(cfg_str,name,item_name)
item:SetChildText(1,string)
else
string=FMT.fmt(cfg_str_zm,name,zmNmae,item_name)
item:SetChildText(1,string)
end
elseif logType==2 then
local costItemList=data.str[3]or{}
local getItemList=data.str[4]or{}
local posName=data.str[6]or""
local cfg_str=logtable[1]
local costStr=""
for i,v in ipairs(costItemList)do
local itemId=v[1]
local itemnum=v[2]
local itemConfig=itemsConfig.getConfig(itemId)
local color=itemConfig.color
local onestr=FMT.fmt(i==#costItemList and"{0}*{1}"or"{0}*{1}、",itemConfig.name,itemnum)
local item_name=FMT.cfmt(color,onestr)
costStr=costStr..item_name
end
local getStr=""
for i,v in ipairs(getItemList)do
local itemId=v[1]
local itemnum=v[2]
local itemConfig=itemsConfig.getConfig(itemId)
local color=itemConfig.color
local onestr=FMT.fmt(i==#getItemList and"{0}*{1}"or"{0}*{1}、",itemConfig.name,itemnum)
local item_name=FMT.cfmt(color,onestr)
getStr=getStr..item_name
end
local endStr=FMT.fmt(cfg_str,posName,name,costStr,getStr)
item:SetChildText(1,endStr)
elseif logType==3 then
local fpItemList=data.str[3]or{}
local targetName=data.str[4]or""
local posName=data.str[6]or""
local cfg_str=logtable[1]
local fpStr=""
for i,v in ipairs(fpItemList)do
local itemId=v[1]
local itemnum=v[2]
local itemConfig=itemsConfig.getConfig(itemId)
local color=itemConfig.color
local onestr=FMT.fmt(i==#fpItemList and"{0}*{1}"or"{0}*{1}、",itemConfig.name,itemnum)
local item_name=FMT.cfmt(color,onestr)
fpStr=fpStr..item_name
end
local endStr=FMT.fmt(cfg_str,posName,name,fpStr,targetName)
item:SetChildText(1,endStr)
end

item:SetChildCSImageSprite(0,abNmae,iocnTypeName[data.logType])
item:ForceLayoutVertical(1)
local txtY=item:GetChildRectHeight(1)
local itemHiget=txtY+20
item:SetChildSizeDelta(2,638,itemHiget)
end

end


function UIXMKuFangWin:onStartAction()
end



function UIXMKuFangWin:refreshKuFangMoneyPanel()
local huobilist=cfg_xianmengjuanxianbaseconfig_get(1).JXmoneylist
if not huobilist and next(huobilist)==nil then
return
end
local SelfLogData=xianmengModel:getXMJuanXianSelfLogData()

_this.rankFirstList:setChildScrollViewCreateGrids(#huobilist,#huobilist)
local grids=_this.rankFirstList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local itemId=huobilist[i]
local num=0
if moneyConfig.isMoney(itemId)then
num=moneyModel.getMoney(itemId)
end

local XMitemId=cfg_xianmengjuanxianconfig_get(itemId).xmhb
local itemConfig=itemsConfig.getConfig(XMitemId)
local color=itemConfig.color
local itemname=FMT.cfmt(color,itemConfig.name)
item:SetChildText(itemidex.title,itemname)
item:SetChildIcon(itemidex.icon,iconHelper.getIconName(XMitemId),false)


local nowNum=0
if SelfLogData and SelfLogData[itemId]then
nowNum=SelfLogData[itemId]
end

local cfg=cfg_xianmengjuanxianconfig_get(itemId).xmgx
local minNum=0
if cfg and cfg[1]then
minNum=cfg[1]
end


local maxNum=-1
local dayMax=cfg_xianmengjuanxianconfig_get(itemId).dayMax
if dayMax then
maxNum=dayMax
end

local flag=0
if maxNum>0 and nowNum>=maxNum then
flag=1
elseif num<minNum then
flag=2
end

if flag==1 then
item:SetChildGray(itemidex.btn,true)
else
item:SetChildGray(itemidex.btn,false)
end


local ck_num=moneyModel.getMoney(XMitemId)
if ck_num>0 then
item:SetChildText(itemidex.txtnum,FMT.fmt("储量：<color=#171311>{0}</color>",mathHelper.formatNumber(ck_num)))
else
item:SetChildText(itemidex.txtnum,FMT.fmt("储量：<color=#c82c2c>{0}</color>",mathHelper.formatNumber(ck_num)))
end

local depotarry=cfgHelper.get2(cfg_guildbaseconfig_get,1,'depot')
local max
if depotarry and depotarry[XMitemId]then
max=depotarry[XMitemId]
end
if max and ck_num>=max then
item:SetChildActive(itemidex.mancang,true)
else
item:SetChildActive(itemidex.mancang,false)
end

item:SetChildButtonClick(itemidex.btn,function()
self:onClickItemCallback(itemId,num,maxNum,minNum,nowNum,cfg,flag)
end)
end
end

function UIXMKuFangWin:onClickItemCallback(itemId,num,maxNum,minNum,nowNum,cfg,flag)
if flag==2 then
local itemConfig=itemsConfig.getConfig(itemId)
local str=""
if itemId==eMoneyType.mtXuKongJing or eMoneyType.mtJieShi then
str=FMT.fmt('{0}不足{1}个',itemConfig.name,minNum)
UIManager.error(str)
else
str=FMT.fmt('{0}不足{1}',itemConfig.name,minNum)
UIManager.error(str)
end
gainControl:showGainWin(itemId)
return
end
if flag==1 then
local itemConfig=itemsConfig.getConfig(itemId)


local str=FMT.fmt('今日捐赠{0}已达上限',itemConfig.name)
UIManager.error(str)
return
end

local gxid=eMoneyType.mtGongXuan
local costnum=cfg[1]
local getnum=cfg[2]
local haveCnt=moneyModel.getMoney(itemId)
local maxCnt=maxNum
local nowCnt=nowNum

local MaxLimitNum=0
if maxCnt>0 then
local canNum=maxCnt-nowCnt
local tNum=math.min(haveCnt,canNum)
MaxLimitNum=math.modf(tNum/costnum)
else
MaxLimitNum=math.modf(haveCnt/costnum)
end



if MaxLimitNum>0 then
local XMitemId=cfg_xianmengjuanxianconfig_get(itemId).xmhb
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianMenKuFang)
local depotarry=cfgHelper.get2(cfg_guildbaseconfig_get,1,'depot')
local max=0
if depotarry and depotarry[XMitemId]then
max=depotarry[XMitemId]
end
local val=moneyModel.getMoney(XMitemId)
if val>=max then
if not flag then
local itemConfig=itemsConfig.getConfig(itemId)
local color=itemConfig.color
local itemname=FMT.cfmt(color,itemConfig.name)
local desc=FMT.fmt('{0}库存已达上限，不会继续增加，但祖师仍可获得仙盟贡献，是否继续捐献？',itemname)
local show_data=
{
title='提示',
Str=desc or'',
oktext="捐献",
canceltext="取消",
okcallback=function()
UIManager:invokeUIMethod('UIXMKuFangWin','onClickItemCallback2',itemId,maxCnt,nowCnt,MaxLimitNum,cfg)
end
}
UIManager:showWindow('UIDialougeXMKFtips',show_data)
else
UIManager:invokeUIMethod('UIXMKuFangWin','onClickItemCallback2',itemId,maxCnt,nowCnt,MaxLimitNum,cfg)
end
else
UIManager:invokeUIMethod('UIXMKuFangWin','onClickItemCallback2',itemId,maxCnt,nowCnt,MaxLimitNum,cfg)
end
else
UIManager.error("次数不足")
end
end


function UIXMKuFangWin:onClickItemCallback2(itemId,maxCnt,nowCnt,MaxLimitNum,cfg)
local gxid=eMoneyType.mtGongXuan
local costnum=cfg[1]
local getnum=cfg[2]
local refresh=function(num)
local itemNum=num*getnum
return itemNum
end
local _cfg=itemsConfig.getConfig(itemId)
local MainiconStr=iconHelper.getIconName(itemId)
local limit=maxCnt-nowCnt
local tipContent=FMT.fmt("请选择捐献quad-icon={0}-quad{1}数量",MainiconStr,_cfg.name)
local tipContent2=FMT.fmt("（今日还可捐赠<color=#7d3b17>{0}</color>）",mathHelper.formatNumber(limit))
local iconStr=iconHelper.getIconName(gxid)
local tipContent3=FMT.fmt("可获得quad-icon={0}-quad功勋",iconStr)
if maxCnt<0 then
tipContent2=""
end
local show_data={
type='UIDialougeKuFangCount',
title='仙盟捐赠',
refreshcallback=refresh,
max=MaxLimitNum,
tips=tipContent or"",
tips2=tipContent2 or"",
tips3=tipContent3 or"",
oktext='捐赠',
canceltext='取消',
tipContent="",
singlenum=costnum or 1,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local _jxNum=costnum*num
local jxNum=int64.new(FMT.fmt("{0}",_jxNum))
xianmengController.req_20_137(itemId,jxNum)
end,

}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
