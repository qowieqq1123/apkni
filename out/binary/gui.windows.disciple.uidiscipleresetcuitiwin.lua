







def_class("UIDiscipleResetCuiTiWin",UIWindowBase)









function UIDiscipleResetCuiTiWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.cost1=UIText.get(self,1)
self.costroot=UIObject.get(self,2)
self.icon1=UIImage.get(self,3)
self.introducionTxt=UIText.get(self,4)
self.resetBtn=UIButton.get(self,5)
self.resetnum=UIText.get(self,6)
self.Scrollview=UIObject.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIDiscipleResetCuiTiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cost1);self.cost1=nil;
_UIObject_release(self.costroot);self.costroot=nil;
_UIObject_release(self.icon1);self.icon1=nil;
_UIObject_release(self.introducionTxt);self.introducionTxt=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.resetnum);self.resetnum=nil;
_UIObject_release(self.Scrollview);self.Scrollview=nil;
end


















local _this=nil

function UIDiscipleResetCuiTiWin:onLoaded(...)
_this=self
self:bindComponents()

end


function UIDiscipleResetCuiTiWin:__delete()
self:unbindComponents()
end




function UIDiscipleResetCuiTiWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.dis_guid
self.qizhenlist=UIDiscipleModel:geteatitem(self.disciple_guid)

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self.ctlv=netData.qzctlv
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
self.job=imageInfo.job
self.cuitilist=self:getDZCuiTiReset(self.ctlv,self.job)
self:GetItemlist()
self:refreshintroduce()
self:do_refreshList()


_this:updateTime()
local usenum,allnum=UIDiscipleModel:resetnum()
if allnum<=usenum then
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
_this:updateTime()
end)
end
end


end

function UIDiscipleResetCuiTiWin:updateTime()
local stemp=timeHelper.getNextMonthDateDisStamp2(1,5,1,0)
local time=timeHelper.format_time_stamp3(stemp)
local usenum,allnum=UIDiscipleModel:resetnum()
if allnum<=usenum then
self.resetnum:setText(string.format("<color=#549327>重置时间：%s</color>",time))
else
self.resetnum:setText(string.format("<color=#549327>本月剩余次数：%d</color>",allnum-usenum))
end


end

function UIDiscipleResetCuiTiWin:onHide()

end


function UIDiscipleResetCuiTiWin:GetItemlist()
self.itemlist={}

for k,v in ipairs(self.qizhenlist)do
if not self.cuitilist[v['param_1']]then
self.cuitilist[v['param_1']]=0
end
self.cuitilist[v['param_1']]=self.cuitilist[v['param_1']]+v['param_2']
end

for k,v in pairs(self.cuitilist)do
local sort1=itemsConfig.getItemColor(k)*1000000
local sort2=k
table.insert(self.itemlist,{k,v,sort1,sort2})
end

table.sort(self.itemlist,function(a,b)
if a[3]==b[3]then
return a[4]<b[4]
end
return a[3]>b[3]
end)

end




function UIDiscipleResetCuiTiWin:onCloseBtn()
_this:closeSelf()
end

function UIDiscipleResetCuiTiWin:refreshintroduce()
local cuitiname=UIDiscipleModel:getCuiTiName(self.disciple_guid,3)
local disname=UIDiscipleModel:getDiscipleName(self.disciple_guid)

local str=string.format("将%s<color=#ca631d>%s</color>重置为<color=#ca631d>淬体金身（0级）</color>,\n并返还消耗的所有奇珍材料、突破材料等。\n<color=#c82c2c>（重置淬体所需灵玉随弟子淬体等级提升而增加）</color>",disname,cuitiname)

self.introducionTxt:setText(str)


local reset=UIDiscipleModel:resetcost(self.ctlv,self.job)
local iconname1=iconHelper.getIconName(reset[1][1])
self.icon1:setImageIcon(iconname1,false)
self.cost1:setText("x"..reset[1][2])

local usenum,allnum=UIDiscipleModel:resetnum()
self.resetBtn:setGray(allnum<=usenum)
end

function UIDiscipleResetCuiTiWin:do_refreshList()
local c=#self.itemlist
self.Scrollview:setChildScrollViewCreateGrids(c,5)

local grids=self.Scrollview:getChildScrollViewItemWidgets()
for i=1,c do
self:refreshItem(grids[i-1],i)
end
end

function UIDiscipleResetCuiTiWin:refreshItem(item,index)

local widget=item:GetChildWidgetBase(0)
local reward=self.itemlist[index]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickBaseItem(...)
end)
end

function UIDiscipleResetCuiTiWin:onClickBaseItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UIDiscipleResetCuiTiWin:getDZCuiTiReset(ctlv,job)
local ctlv=ctlv-1
local goods={}
for i=1,ctlv do
local cfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,i)
local consume=cfg.consume
local temp=consume[job]or consume[0]
for k,v in ipairs(temp)do
if not goods[v[1]]then
goods[v[1]]=0
end
goods[v[1]]=goods[v[1]]+v[2]
end
end
return goods
end




function UIDiscipleResetCuiTiWin:onResetBtn()
local usenum,allnum=UIDiscipleModel:resetnum()
if allnum<=usenum then
UIManager.info("本月重置次数已用完，次月1号刷新重置次数")
return
end


local reset=UIDiscipleModel:resetcost(self.ctlv,self.job)
local disguid=_this.disciple_guid
local func=function()
UIDiscipleController:reqCuiTiReset(disguid)
_this:closeSelf()
end

local disname=UIDiscipleModel:getDiscipleName(self.disciple_guid)
local iconStr=iconHelper.getIconName(reset[1][1])
local costStr=FMT.fmt("quad-icon={0}-quad",iconStr)
local contentStr=FMT.fmt("是否花费{0}<color=#7d3b17>{1}</color>将<color=#ca631d>{2}</color>的淬体等级重置为初始值",costStr,reset[1][2],disname)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',

okcallback=function(...)
moneySystem:useMoneys(reset,func,WARNING_TYPE.eWarning)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
