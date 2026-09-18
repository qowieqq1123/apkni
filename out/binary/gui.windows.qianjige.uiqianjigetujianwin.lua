







def_class("UIQianJiGeTuJianWin",UIWindowBase)









function UIQianJiGeTuJianWin:bindComponents()

self.animRoot=UIObject.get(self,0)
self.ListPanel=UIObject.get(self,1)
self.TabPanel=UIObject.get(self,2)
self.rightRoot=UIObject.get(self,3)
self.cloud=UIObject.get(self,4)
self.getButton=UIButton.get(self,5)
self.getReddot=UIObject.get(self,6)

self.getButton:setButtonClick(function()self:onGetButton()end)


self.sprite_button_qjgjnxx_1=0
self.sprite_button_qjgjnxx_2=1
self.sprite_button_qjgjnxx_3=2

end


function UIQianJiGeTuJianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.TabPanel);self.TabPanel=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.getButton);self.getButton=nil;
_UIObject_release(self.getReddot);self.getReddot=nil;
end


















local abname='ui/windows/qianjige/qjg_tj_atlas_pak.ab'
local colorName=
{
"3375c0","6833c0","ca631d"
}


function UIQianJiGeTuJianWin:onLoaded(...)
self:bindComponents()
local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.cloud:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)
end


function UIQianJiGeTuJianWin:__delete()
self:unbindComponents()
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end
end




function UIQianJiGeTuJianWin:onShow(argtable,afterOnloaded)
self:refreshTabList()
self:refreshShouJiReddot()
end


function UIQianJiGeTuJianWin:onHide()

end

function UIQianJiGeTuJianWin:refreshTabList()
local tabList=cfg_mijingfazetujiantagconfig()
local length=#tabList+1
self.TabPanel:setChildScrollViewCreateGrids(length,length)

local grids=self.TabPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local grid=grids[i]
if i==0 then
grid:SetChildText(1,"全部")
grid:SetChildButtonClick(2,function()
self:onAllTabClick()
end)
grid:SetChildActive(3,mysteryWeekActivityModel:checkAllTuJianReddot()or false)
else
local tab=tabList[i]
grid:SetChildText(1,tab.itemType)
grid:SetChildButtonClick(2,function()
self:onTabClick(i,tab)
end)
grid:SetChildActive(3,mysteryWeekActivityModel:checkTuJianReddotByTagId(tab.id)or mysteryWeekActivityModel:checkTujianShouJiTabReddot(tab.id)or false)
end

end

self:onAllTabClick()
end

function UIQianJiGeTuJianWin:setToggleOn(index,on)
local sitem=self.TabPanel:getChildScrollViewItemWidget(index)
sitem:SetChildActive(0,on)
sitem:SetChildActive(4,on)
end

function UIQianJiGeTuJianWin:onAllTabClick()
if self.selectTab==0 then
return
end
if self.selectTab~=nil then
self:setToggleOn(self.selectTab,false)
end
self.selectTab=0

self:setToggleOn(0,true)

local list=cfg_mijingfazetujianconfig()
self.list=list
self.selectRule=1

self.getButton:setActive(false)
self:refreshList()
end

function UIQianJiGeTuJianWin:onTabClick(index,tab)
if self.selectTab==index then
return
end
if self.selectTab~=nil then
self:setToggleOn(self.selectTab,false)
end
self.selectTab=index
self:setToggleOn(index,true)

local list=mysteryWeekActivityModel:getTuJianConfigByTagId(tab.id)or{}
self.list=list

self.selectRule=1

self.getButton:setActive(true)
self:refreshList()
self:refreshShouJiReddot()
end

function UIQianJiGeTuJianWin:refreshList()
local list=self.list
local length=#list

table.sort(list,function(a,b)
local sortA=a.sort
local sortB=b.sort
local flaga=mysteryWeekActivityModel:getTuJianJHReward(a.id)or false
local flagb=mysteryWeekActivityModel:getTuJianJHReward(b.id)or false
if flaga then
sortA=sortA-1000000
end
if flagb then
sortB=sortB-1000000
end
local activeA=mysteryWeekActivityModel:isTuJianActived(a.id)
local activeB=mysteryWeekActivityModel:isTuJianActived(b.id)
if activeA then
sortA=sortA-100000
end
if activeB then
sortB=sortB-100000
end
return sortA<sortB
end)

if not self.selectRule then
self.selectRule=1
end
local num=0
self.ListPanel:setChildScrollViewCreateGrids(length,3)
local grids=self.ListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local isActived=mysteryWeekActivityModel:isTuJianActived(list[i].id)
self:refreshTuJianItem(grid,i,list[i])
if i==self.selectRule then
self:refreshRightPanel(self.selectRule,list[i])
end
if isActived then
num=num+1
end
end
local sitem=self.TabPanel:getChildScrollViewItemWidget(self.selectTab)
if sitem then
sitem:SetChildText(5,FMT.fmt("{0}/{1}",num,length))
end
end

function UIQianJiGeTuJianWin:refreshTuJianItem(grid,index,tujianConfig)

local isActived=mysteryWeekActivityModel:isTuJianActived(tujianConfig.id)
local fzId=tujianConfig.fzId
local ruleCfg=cfgHelper.getSSlawRule(fzId)
local image=ruleCfg.image
local level=tujianConfig.fzLevel
local frameImg=iconHelper.getRuleQualityIcon3(level)

grid:SetChildCSImageSprite(0,abname,frameImg)
grid:SetChildCSImageIcon(2,image,true)
if isActived then



grid:SetChildText(1,FMT.fmt("<color=#{0}>{1}</color>",colorName[level],ruleCfg.name))
grid:SetChildGray(4,false)
else
grid:SetChildText(1,"？？？")


grid:SetChildGray(4,true)
end
local flag=mysteryWeekActivityModel:getTuJianJHReward(tujianConfig.id)or false
grid:SetChildActive(5,flag)
grid:SetChildScale(3,self.selectRule==index and Vector3.one or Vector3.zero)
grid:SetChildButtonClick(4,function()
self:onRuleClick(index,tujianConfig)
end)

end

function UIQianJiGeTuJianWin:setToggleOn2(index,on)
if index then
local sitem=self.ListPanel:getChildScrollViewItemWidget(index-1)
if sitem then
sitem:SetChildScale(3,on and Vector3.one or Vector3.zero)
end
end
end

function UIQianJiGeTuJianWin:onRuleClick(index,tujianConfig)
if self.selectRule==index then
return
end
if self.selectRule~=nil then
self:setToggleOn2(self.selectRule,false)
end
self.selectRule=index
self:setToggleOn2(index,true)
self:refreshRightPanel(index,tujianConfig)
end

function UIQianJiGeTuJianWin:refreshRightPanel(index,tujianConfig)
local tuJianId=tujianConfig.id
local isActived=mysteryWeekActivityModel:isTuJianActived(tuJianId)

local grid=self.rightRoot:getWidgetBase()
local fzId=tujianConfig.fzId
local level=tujianConfig.fzLevel
local jhReward=tujianConfig.jhReward[1]
local ruleCfg=cfgHelper.getSSlawRule(fzId)

local image=ruleCfg.image
local frameImg=iconHelper.getRuleQualityIcon2(level)
grid:SetChildCSImageSprite(5,abname,frameImg)
grid:SetChildCSImageIcon(3,image,false)

if isActived then
grid:SetChildText(0,FMT.fmt("<color=#{0}>{1}</color>",colorName[level],ruleCfg.name))
local desc=ruleCfg.desc
local descparm=ruleCfg.descparm

if descparm and descparm[level]and next(descparm[level])then
desc=string.format(desc,unpack(descparm[level]))
end
grid:SetChildText(1,desc)
grid:SetChildText(8,FMT.fmt("拥有法则：{0}",ruleCfg.name))
grid:SetChildGray(5,false)

if ruleCfg.zhuanshuImg then
grid:SetChildActive(10,true)
grid:SetChildIcon(10,FMT.fmt('image_zhuan_shu_faze_{0}',ruleCfg.zhuanshuImg),true)
else
grid:SetChildActive(10,false)
end
else
grid:SetChildText(0,"？？？")
grid:SetChildText(1,"尚未知晓其效果")
grid:SetChildText(8,"？？？")
grid:SetChildGray(5,true)
end

local conf={itemid=jhReward[1],itemcount=jhReward[2],showCountBG=jhReward[2]>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

local tujianData=mysteryWeekActivityModel:getTuJianData(tuJianId)


local canGet=tujianData~=nil and tujianData.jhReward==0
local isGrayMask=(not isActived)or(not canGet)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask
grid:SetChildPropData(7,prop)
grid:SetBaseItemClickEvent(7,function(...)
if canGet then
mysteryWeekActivityController:send_4_76(tuJianId)
else
self:onClickRewardItem(...)
end

end)
grid:SetChildActive(9,canGet)

end

function UIQianJiGeTuJianWin:onGetButton()
self:showWindow("UIQianJiGeTuJianShouJiWin",{tab=self.selectTab})
end

function UIQianJiGeTuJianWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UIQianJiGeTuJianWin:refreshReddot()
local tabList=cfg_mijingfazetujiantagconfig()
local grids=self.TabPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local grid=grids[i]
if i==0 then
grid:SetChildActive(3,mysteryWeekActivityModel:checkAllTuJianReddot())
else
local tab=tabList[i]
grid:SetChildActive(3,mysteryWeekActivityModel:checkTuJianReddotByTagId(tab.id)or mysteryWeekActivityModel:checkTujianShouJiTabReddot(tab.id)or false)
end
end
if self.selectRule~=nil then
local sitem=self.ListPanel:getChildScrollViewItemWidget(self.selectRule-1)
local flag=mysteryWeekActivityModel:getTuJianJHReward(self.list[self.selectRule].id)or false
if sitem then
sitem:SetChildActive(5,flag)
end
local grid=self.rightRoot:getWidgetBase()
grid:SetChildActive(9,flag)
end
self:refreshShouJiReddot()
end

function UIQianJiGeTuJianWin:refreshShouJiReddot()
local reddot=self.selectTab~=0 and mysteryWeekActivityModel:checkTujianShouJiTabReddot(self.selectTab)
self.getReddot:setActive(reddot)
self:doPunchRotation(reddot)
end

function UIQianJiGeTuJianWin:doPunchRotation(reddot)
local index=self.getReddot:getID()
if reddot then
if self.reddotTweener==nil then
self:setChildRotation(index,0,0,0)
local tweener=self:setChildDOPunchRotation(index,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener=nil
self:setChildRotation(index,0,0,0)
end
end
end


