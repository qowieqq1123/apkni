







def_class("UILingShanZTCJPageWin",UIWindowBase)









function UILingShanZTCJPageWin:bindComponents()

self.count=UIText.get(self,0)
self.helpBtn=UIButton.get(self,1)
self.page_1=UIObject.get(self,2)
self.page_2=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.scrollView=UIObject.get(self,5)
self.teamCount=UIText.get(self,6)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)
self.page={
self.page_1,
self.page_2,
}



end


function UILingShanZTCJPageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.count);self.count=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.page_1);self.page_1=nil;
_UIObject_release(self.page_2);self.page_2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.teamCount);self.teamCount=nil;
self.page=nil;
end
















local _this

local _itemIndex={
normal=0,
empty=1,
icon=2,
name=3,
buff_icon=4,
buff_name=5,
buff_desc=6,
leave_btn=7,
goto_btn=8,
view_btn=9,
count=10,
items={11,12,13,14},
rwTips=15,
rewards=16
}




function UILingShanZTCJPageWin:onLoaded(...)
self:bindComponents()

_this=self

self.areaNames={
'山底',
'山腰',
'山顶'
}

self.pageData={
{2,'混元灵山'},
{1,'素尘灵山'}
}

self.abName='ui/windows/lingshanzhengduo/lszd_atlas_pak.ab'

self.iconNames={
'image_lingshanzhengduo_8',
'image_lingshanzhengduo_9'
}

self.countType={
eMoneyType.mtLingShanBattleTimes1,

}

for i,v in ipairs(self.page)do
local data=self.pageData[i]
local widget=v:getChildWidgetBase()
widget:SetChildText(0,data[2])
widget:SetChildButtonClick(1,function()
self:selectPage(i)
end)
widget:SetChildActive(2,false)
end

self.teamMaxNum=cfgHelper.get2(cfg_lingshanbattlebaseconfig_get,1,'actor_team_limit')
self.rewardTimeH=cfgHelper.get2(cfg_lingshanbattlebaseconfig_get,1,'income_interval')
self.rewardTime=self.rewardTimeH*3600

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UILingShanZTCJPageWin:__delete()
self:unbindComponents()

_this=nil
end




function UILingShanZTCJPageWin:onShow(argtable,afterOnloaded)
self:selectPage(1)
end


function UILingShanZTCJPageWin:onHide()

end

function UILingShanZTCJPageWin:refresh()
self:selectPage(self.currPage)
end

function UILingShanZTCJPageWin:selectPage(page)
if self.currPage then
local pageItem=self.page[self.currPage]
local widget=pageItem:getChildWidgetBase()
widget:SetChildActive(2,false)
end

self.currPage=page or self.currPage

local pageItem=self.page[self.currPage]
local widget=pageItem:getChildWidgetBase()
widget:SetChildActive(2,true)

local pdata=self.pageData[self.currPage]
local mtype=pdata[1]
local mname=pdata[2]
local num=self.teamMaxNum
local teamDatas=UILSZDControl:getAllMyTeam()
self.scrollView:setChildScrollViewCreateGrids(num,1)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
local tcount=0
for i=1,count do
local item=grids[i-1]
local data=teamDatas[i]
if data then
tcount=tcount+1
local mountId=data.mountId
local areaId=data.area_id
local pos=data.pos
local cfg=UILSZDControl:getLingShanConfig(mountId)
local rewardData=cfg.set_up_income
local buffData=cfg.set_up_buff
local rewards=rewardData[areaId]
local bfdata=buffData[areaId][1]
local iconName,buffName,buffDesc=UILSZDControl:getBuffInfo(bfdata)
item:SetChildActive(_itemIndex.normal,true)
item:SetChildActive(_itemIndex.empty,false)

local name=FMT.fmt('{0}-{1}',cfg.mount_name,self.areaNames[areaId])
item:SetChildText(_itemIndex.name,name)
item:SetChildCSImageSprite(_itemIndex.icon,self.abName,self.iconNames[cfg.mount_type])
item:SetChildIcon(_itemIndex.buff_icon,iconName,true)
item:SetChildText(_itemIndex.buff_name,buffName)
item:SetChildText(_itemIndex.buff_desc,buffDesc)
item:SetChildButtonClick(_itemIndex.leave_btn,function()
local content='撤离队伍将无法继续获得入驻奖励且结算累计获得的入驻奖励，请确认是否撤离队伍？'
self:showDialog(content,function()
UILSZDControl:reqLeaveMount(mountId,areaId,pos)
UIManager.info('队伍已撤离')
end)
end)
item:SetChildButtonClick(_itemIndex.view_btn,function()
UILSZDControl:showLSZDWinEx({mountId=mountId,areaId=areaId,pos=pos},true)
end)
local tnum=UILSZDControl:getMountAreaTeamNum(mountId,areaId)
local tmax=UILSZDControl:getMountAreaMaxTeamNum(mountId,areaId)
item:SetChildText(_itemIndex.count,FMT.fmt('{0}/{1}',tnum,tmax))
local currtime=gameUtilityModel.getServerShortTime()
local dtime=currtime-data.set_up_sec
if dtime>=self.rewardTime then
item:SetChildActive(_itemIndex.rewards,true)
item:SetChildText(_itemIndex.rwTips,'')
local rate=self:getRewardTime(data.set_up_sec)
for ii=1,4 do
local index=_itemIndex.items[ii]
local rw=rewards[ii]
if rw then
item:SetChildActive(index,true)
widgetHelper.setNormalRewardItem(item,index,{rw[1],rw[2]*rate})
else
item:SetChildActive(index,false)
end
end
else
item:SetChildActive(_itemIndex.rewards,false)
item:SetChildText(_itemIndex.rwTips,FMT.fmt('暂无奖励（入驻时长不足{0}小时）',self.rewardTimeH))
end
else
item:SetChildActive(_itemIndex.normal,false)
item:SetChildActive(_itemIndex.empty,true)
item:SetChildButtonClick(_itemIndex.goto_btn,self.goToIntelligenceWin)
end
end

self.teamCount:setText(FMT.fmt('入驻灵山队伍上限：<color=#549327>{0}/{1}</color>（每个灵山共享队伍上限，不占用外派队伍名额）',tcount,count))
self:setChallengeCount(mtype,mname)
end

function UILingShanZTCJPageWin:getRewardTime(stime)
local currtime=gameUtilityModel.getServerShortTime()
local dtime=currtime-stime
local ds=86400
local hs=3600
local t0=math.floor(currtime/ds)*ds
local t5=t0+5*hs
local ctime
if currtime<t5 then
ctime=currtime-t0+19*hs
else
ctime=currtime-t5
end
local htime=math.min(dtime,ctime)
local rate=math.floor(htime/self.rewardTime)
return rate
end

function UILingShanZTCJPageWin:setChallengeCount(mount_type,mname)
local mtype=self.countType[1]
local mcfg=moneyModel.getMoneyConfig(mtype)
local num=moneyModel.getMoney(mtype)
local max=mcfg.autoincr[5]

self.count:setText(FMT.fmt('挑战次数：<color=#549327>{0}/{1}</color>',num,max))
end

function UILingShanZTCJPageWin.goToIntelligenceWin()
local mtype=_this.pageData[_this.currPage][1]
_this:closeNoteWin()
UILSZDControl:closeUI(nil,true)
UILSZDControl:openIntelligenceWin(mtype)
end

function UILingShanZTCJPageWin:closeNoteWin()
UIManager:callWindowFunc('UIXM_ZZSH_noteWin','onClickClose')
end

function UILingShanZTCJPageWin:showDialog(content,callback)
local dialog=UIDialogManager.getConfirmDialog(nil,nil,content,nil,nil,callback)
dialog:show()
end




function UILingShanZTCJPageWin:onHelpBtn()
local pdata=self.pageData[self.currPage]
local mtype=pdata[1]
local d={}
d.title='提示'
d.mode=3
d.name=mtype==1 and'LingShan_SuChen_help_%d'or'LingShan_HunYuan_help_%d'
UIManager:showWindow('UIRuleWin',d)
end