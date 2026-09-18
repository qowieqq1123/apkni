







def_class("UIXYTeamDetailWin",UIWindowBase)









function UIXYTeamDetailWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.Scroller=UILoopListView.new(self,1)
self.noItemTips=UIText.get(self,2)
self.xyteamListItem_1=UIObject.get(self,3)
self.xyteamListItem_2=UIObject.get(self,4)
self.xyteamListItem_3=UIObject.get(self,5)
self.nofazeTip=UIText.get(self,6)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXYTeamDetailWin")end)

self.Scroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)self.xyteamListItem={
self.xyteamListItem_1,
self.xyteamListItem_2,
self.xyteamListItem_3,
}



end


function UIXYTeamDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
self.Scroller:deleteSelf();self.Scroller=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.xyteamListItem_1);self.xyteamListItem_1=nil;
_UIObject_release(self.xyteamListItem_2);self.xyteamListItem_2=nil;
_UIObject_release(self.xyteamListItem_3);self.xyteamListItem_3=nil;
_UIObject_release(self.nofazeTip);self.nofazeTip=nil;
self.xyteamListItem=nil;
end
















local cmpIndex={
hss=0,
slotList={1,2,3,4,5},
fight=6,
teamtxt=7,
}

local fazeItemCmp={
itemSelf=0,
back=1,
content=2,
name=3,
icon=4,
}



function UIXYTeamDetailWin:onLoaded(...)
self:bindComponents()
self.widgetList={}
for i,v in ipairs(self.xyteamListItem)do
local widget=v:getWidgetBase()
self.widgetList[i]=widget
end
end


function UIXYTeamDetailWin:__delete()
self:unbindComponents()
end




function UIXYTeamDetailWin:onShow(argtable,afterOnloaded)
local xyId=argtable.xyId
self.xyId=xyId

if XingYuController.checkHasTeam(xyId)then
local teamList=XingYuModel:getXingYuData_teamList(xyId)
self.noItemTips:setActive(false)
for i,v in ipairs(self.widgetList)do
v:SetChildActive(-1,false)
end
for i,xingyuTeam in ipairs(teamList)do
local index=xingyuTeam.index
local widget=self.widgetList[index]
local hasDz=xingyuTeam.len>0
if hasDz then
widget:SetChildActive(-1,true)
local fight=mathHelper.int64_to_number(xingyuTeam.fightVal)

local guidList=XingYuController.getXingYuTeamDzList_TeamIndex(xyId,index)





local failFlag=xingyuTeam.tsevtResult==2 or xingyuTeam.hzqfail~=0 or xingyuTeam.zdzfail~=0 or xingyuTeam.glttFlag==1
for ii,cIndex in ipairs(cmpIndex.slotList)do
if guidList[ii]then
widget:SetChildActive(cIndex,true)
local headshot=widget:GetChildWidgetBase(cIndex)
local guid=guidList[ii]
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local dzId=netdata.id
local isSpDz=UIDiscipleModel:isSPDisciple(dzId)
local switchidx
if isSpDz then
local netDzId=XingYuModel:getXingYuData_teamListDzId(xyId,guid)
if netDzId and netDzId~=dzId then
switchidx=1
end
end
local image=UIDiscipleModel.calculationDiscipleImageBase(netdata,switchidx)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
headshot:SetChildCSImageSprite(2,globalABLookup.global,jobicon)

local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)

comHelper.setChildModelHeadIconBGByColor(headshot,0,color)


UIDiscipleModel:setDiscipleXianMoHeadImage(headshot,3,netdata)
headshot:SetChildGray(0,failFlag)


local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headshot,modelParams,eHeadCenterType.eHead,nil,failFlag)
else
widget:SetChildActive(cIndex,false)
end
end
widget:SetChildText(cmpIndex.fight,mathHelper.formatNumber3(fight))
local strTxt=failFlag and FMT.cfmt(FONT_COLOR.eRedColor,'重伤，无法对战')or FMT.fmt('第{0}队',index)
widget:SetChildText(cmpIndex.teamtxt,strTxt)
else
widget:SetChildActive(-1,false)
end
end
else
for i,v in ipairs(self.xyteamListItem)do
v:setActive(false)
end
self.noItemTips:setActive(true)
end

local list=XingYuModel:getXingYuData_fazeList(xyId)
if list and#list>0 then
self.nofazeTip:setActive(false)
self.Scroller:initData("scrollerItem_faze",list)
else
self.nofazeTip:setActive(true)
self.Scroller:initData(nil,nil,0)
end
end


function UIXYTeamDetailWin:onHide()

end

function UIXYTeamDetailWin:onFreshAction(index,widget,data)
local item=widget
local rid=data.id
local level=data.level
local ruleCfg=cfgHelper.getSSlawRule(rid)
local image=ruleCfg.image
local desc=ruleCfg.desc
local descparm=ruleCfg.descparm
if descparm and descparm[level]and next(descparm[level])then
desc=string.format(desc,unpack(descparm[level]))
end
widget:SetChildCSImageIcon(fazeItemCmp.icon,image,false)
widget:SetChildText(fazeItemCmp.content,desc)
widget:SetChildText(fazeItemCmp.name,ruleCfg.name)
item:ForceLayoutVertical(fazeItemCmp.content)
local bgY=item:GetChildRectHeight(fazeItemCmp.back)
local itemHiget=bgY+8
item:SetChildSizeDelta(fazeItemCmp.itemSelf,500,itemHiget)
end


function UIXYTeamDetailWin:onStartAction()
end

function UIXYTeamDetailWin:onCloseButton()
self:closeSelf()
end






