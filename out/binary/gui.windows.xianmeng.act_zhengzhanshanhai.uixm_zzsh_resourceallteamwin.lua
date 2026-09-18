







def_class("UIXM_ZZSH_resourceAllTeamWin",UIWindowBase)









function UIXM_ZZSH_resourceAllTeamWin:bindComponents()

self.cliskMask=UIButton.get(self,0)
self.infoItem=UIObject.get(self,1)
self.itemScrollView=UIObject.get(self,2)
self.noSign=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.itemPanel=UIObject.get(self,5)
self.fightPaixu=UIButton.get(self,6)
self.timePaixu=UIButton.get(self,7)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fightPaixu:setButtonClick(function()self:onFightPaixu()end)

self.timePaixu:setButtonClick(function()self:onTimePaixu()end)



end


function UIXM_ZZSH_resourceAllTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.infoItem);self.infoItem=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.fightPaixu);self.fightPaixu=nil;
_UIObject_release(self.timePaixu);self.timePaixu=nil;
end
















local _this


function UIXM_ZZSH_resourceAllTeamWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_resourceAllTeamWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_resourceAllTeamWin:onHide()

end

local signicon=
{
'image_benmeng_1',
'image_dimeng_1',
}




function UIXM_ZZSH_resourceAllTeamWin:onShow(argtable,afterOnloaded)
self.qbGuid=argtable.qbGuid
self.paixudata=4

self:refreshInfo()

if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshAllItem()
end)
end
end

function UIXM_ZZSH_resourceAllTeamWin:refreshView(guid)
if guid~=self.qbGuid then return end
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then
return
end
self:refreshInfo()
end

function UIXM_ZZSH_resourceAllTeamWin:refreshInfo()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local detail=qbData:getDetail()
local checkFlag=detail:checkXM()
local cfg=qbData:getCfg()
local max_atkNum=cfg.max

self.all_resource=detail.resource


local widget=self.infoItem:getWidgetBase()

local showModel=cfg.model~=nil
widget:SetChildActive(0,showModel)
if showModel then
local modelParams=comHelper.getMonsterModelParamsEx(cfg.model)
local size=cfg.modelSet[5]or cfg.modelSet[1]
widget:SetChildUIModelShowTarget(0,modelParams.body,size,modelParams.componets,eAnimationID.stand)
end
local showModelIcon=cfg.modelIcon~=nil
widget:SetChildActive(9,showModelIcon)
if showModelIcon then
widget:SetChildCSImageSprite(9,globalABLookup.zzshentityicons,cfg.modelIcon)
end

widget:SetChildCSImageIcon(1,moneyModel.getIconNameEx(cfg.moneytype),true)

local nameStr=qbData:getColorName2()
widget:SetChildText(2,nameStr)

local collectNum=detail.collectNum or 0
local teamNum_str=FMT.fmt('队伍：<color=#171311>{0}/{1}</color>',collectNum,max_atkNum)
widget:SetChildText(3,teamNum_str)
local showTeamSign=checkFlag~=0
widget:SetChildActive(4,showTeamSign)
if showTeamSign then
local teamSignIcon=checkFlag==1 and'image_ben_1'or'image_di_1'
widget:SetChildCSImageSprite(4,globalABLookup.global,teamSignIcon)
end

local xmData=qbData:getXM()
local hasXM=xmData~=nil
widget:SetChildActive(5,hasXM)
local xmName_str
if hasXM then
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(6,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(5,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(7,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
xmName_str='无'
end
widget:SetChildText(8,xmName_str)


local num=qbData:getAllTeamNum()
local isshow=num>0
self.itemScrollView:setActive(isshow)
self.noSign:setActive(not isshow)
if isshow then
local list={}
for k,v in pairs(detail.allTeam)do
v.sortTag=v.sec>0 and 1 or 0
table.insert(list,v)
end










self.teamsList=list
self:judepaixu()
self.itemPanel:setChildLayoutGroupCreateItems(num,function(idx)
if _this==nil then return end
local item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
local team=self.teamsList[idx]






item:SetChildText(1,tostring(idx))

item:SetChildText(2,team.actorname)

local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(team.guildicon)

item:SetChildCSImageSprite(4,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(5,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

item:SetChildText(6,team.guildname)

item:SetChildText(7,mathHelper.formatNumber5(team.fight_num,2))

local dzlist=team.discipleList or{}
local dznum=5
item:SetChildLayoutGroupCreateItems(8,dznum)
local grids=item:GetChildLayoutGroupGridList(8)
for i=1,dznum do
local netData=dzlist[i]
local dzitem=grids[i-1]
local has=netData~=nil and netData.flag>0
dzitem:SetChildActive(0,not has)
dzitem:SetChildActive(1,has)




if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzitem,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,dzitem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzitem:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
end
end
self:refreshItem(item,idx)

item:SetChildActive(14,false)
item:SetChildActive(13,false)
item:SetChildActive(15,false)
item:SetChildActive(16,false)
if team.isMy then
item:SetChildActive(14,true)
item:SetChildActive(15,true)
elseif team.isMyXM then
item:SetChildActive(13,true)
item:SetChildCSImageSprite(13,globalABLookup.zzshicons,signicon[1])
else
item:SetChildActive(13,true)
item:SetChildCSImageSprite(13,globalABLookup.zzshicons,signicon[2])
item:SetChildActive(16,true)
end

end)
end
end

function UIXM_ZZSH_resourceAllTeamWin:refreshItem(item,idx)
if item==nil then
item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local team=self.teamsList[idx]

local curRes=0
local maxRes=math.min(self.all_resource,team.max)
if team.sec>0 then
local cur=gameUtilityModel.getServerShortTime()
local l=cur-team.sec
if l<0 then l=0 end
curRes=curRes+math.floor(l*team.speed)
if curRes>maxRes then curRes=maxRes end
end
local rate
if maxRes<=0 then
rate=0
else
rate=curRes/maxRes
end
item:SetChildIconFillAmount(9,rate)
local rate_str=FMT.fmt('{0}/{1}',curRes,maxRes)
item:SetChildText(10,rate_str)

local state,time=zhengzhanshanhaiModel:getPvETeamState(zhengzhanshanhaiModel.qbType.eResource,team.sec,true)
item:SetChildText(11,state)

local time_str
if time>0 then
time_str=timeHelper.format_time_stamp3(time)
else
time_str='--'
end
item:SetChildText(12,time_str)
end

function UIXM_ZZSH_resourceAllTeamWin:refreshAllItem()
if self.teamsList then
local num=#self.teamsList
if num>0 then
for idx,v in ipairs(self.teamsList)do
self:refreshItem(nil,idx)
end
end
end
end

function UIXM_ZZSH_resourceAllTeamWin:fight_PaixuUp()
if#self.teamsList>1 then
table.sort(self.teamsList,function(a,b)

return a.fight_num<b.fight_num
end)
end

end

function UIXM_ZZSH_resourceAllTeamWin:fight_PaixuDown()
if#self.teamsList>1 then
table.sort(self.teamsList,function(a,b)

return a.fight_num>b.fight_num
end)
end
end

function UIXM_ZZSH_resourceAllTeamWin:time_PaixuUp()
if#self.teamsList>1 then
table.sort(self.teamsList,function(a,b)
if a.sortTag==b.sortTag then
return a.sec>b.sec
else
return a.sortTag>b.sortTag
end
end)
end
end

function UIXM_ZZSH_resourceAllTeamWin:time_PaixuDown()
if#self.teamsList>1 then
table.sort(self.teamsList,function(a,b)
if a.sortTag==b.sortTag then
return a.sec<b.sec
else
return a.sortTag>b.sortTag
end
end)
end
end

local fightIcon=
{
'button_tybukepailie',
'button_tykepailie_2',
'button_tykepailie_1',
}

function UIXM_ZZSH_resourceAllTeamWin:onFightPaixu()
if self.fight~=2 then
self.fight=2
self.paixudata=2
else
self.fight=1
self.paixudata=1

end


self:refreshInfo()
end
function UIXM_ZZSH_resourceAllTeamWin:onTimePaixu()
if self.timepaixudata~=2 then
self.timepaixudata=2
self.paixudata=4

else
self.timepaixudata=1
self.paixudata=3

end

self:refreshInfo()
end



function UIXM_ZZSH_resourceAllTeamWin:judepaixu()
if self.paixudata==1 then
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[2])
self.timePaixu:setSprite(globalABLookup.global,fightIcon[3])
self.timepaixudata=0
self:fight_PaixuUp()
elseif self.paixudata==2 then
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[1])
self.timePaixu:setSprite(globalABLookup.global,fightIcon[3])
self.timepaixudata=0
self:fight_PaixuDown()
elseif self.paixudata==3 then
self.timePaixu:setSprite(globalABLookup.global,fightIcon[2])
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[3])
self.fight=0
self:time_PaixuUp()
elseif self.paixudata==4 then
self.timePaixu:setSprite(globalABLookup.global,fightIcon[1])
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[3])
self.fight=0
self:time_PaixuDown()
end
end

function UIXM_ZZSH_resourceAllTeamWin:onCliskMask()
self:onCloseBtn()
end

function UIXM_ZZSH_resourceAllTeamWin:onCloseBtn()
self:closeSelf()
end
