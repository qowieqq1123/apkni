







def_class("UIXMZZSH_YuBeiDuiMainWin",UIWindowBase)









function UIXMZZSH_YuBeiDuiMainWin:bindComponents()

self.cliskMask=UIButton.get(self,0)
self.onekeyBtn=UIButton.get(self,1)
self.ruleBtn=UIButton.get(self,2)
self.tipsTxt=UIText.get(self,3)
self.noSign=UIObject.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.itemScrollView=UIObject.get(self,6)
self.fightSortBtn=UIButton.get(self,7)
self.ruleSelect=UIObject.get(self,8)
self.fightSortIcon=UIImage.get(self,9)
self.itemPanel=UIObject.get(self,10)
self.shuaxinBtn=UIButton.get(self,11)
self.root=UIObject.get(self,12)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.onekeyBtn:setButtonClick(function()self:onOnekeyBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fightSortBtn:setButtonClick(function()self:onFightSortBtn()end)

self.shuaxinBtn:setButtonClick(function()self:onShuaxinBtn()end)



end


function UIXMZZSH_YuBeiDuiMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.onekeyBtn);self.onekeyBtn=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.fightSortBtn);self.fightSortBtn=nil;
_UIObject_release(self.ruleSelect);self.ruleSelect=nil;
_UIObject_release(self.fightSortIcon);self.fightSortIcon=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.shuaxinBtn);self.shuaxinBtn=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this



function UIXMZZSH_YuBeiDuiMainWin:onLoaded(...)
self:bindComponents()
_this=self
self.teamsList={}
end


function UIXMZZSH_YuBeiDuiMainWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXMZZSH_YuBeiDuiMainWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
self.fightSortType=1
self:refreshSortBtn()
self.qbGuid=zhengzhanshanhaiModel:getqbguid()
if not self.qbGuid then
logErr("情报guid为空")
return
end
local qbData=zhengzhanshanhaiModel:getQingBaoData(_this.qbGuid)

if qbData then
local cfg=qbData:getCfg()
self.stage=cfg.stage

end

self:refreshtemnum()
self:refreshDZlist()
end


function UIXMZZSH_YuBeiDuiMainWin:onHide()

end


function UIXMZZSH_YuBeiDuiMainWin:onCliskMask()
self:onCloseBtn()
end
function UIXMZZSH_YuBeiDuiMainWin:onCloseBtn()
self:closeSelf()
end

function UIXMZZSH_YuBeiDuiMainWin:onOnekeyBtn()
local alllist=self.teamsList
if alllist and next(alllist)then


local qbGuid=_this.qbGuid
local qbData_=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData_==nil then return end
local teamData_=zhengzhanshanhaiModel:getMyPvETeam(qbGuid,qbData_.infotype)
if teamData_==nil then return end
if teamData_.sec>0 then
UIManager.error('队伍已出发，不可再加入')
self:closeSelf()
return
end

local needplayernum=0
local detail_xm=qbData_:getDetail_xm()
local setoutnum=detail_xm.setoutnum
local list={}
for key,v in pairs(detail_xm.allTeam)do
table.insert(list,v)
end
local num=#list
if setoutnum>0 then
needplayernum=setoutnum-num
else
local maxNum,fixNum=zhengzhanshanhaiModel:getMaxMonsterTeamNum()
needplayernum=maxNum-num
end
local hasnum=#alllist
needplayernum=math.min(needplayernum,hasnum)

if needplayernum>0 then
for i=1,needplayernum do
local severdata=alllist[i]
local playerguid=severdata.actorid
local temp=
{
playerguid
}
if qbGuid and playerguid then
zhengzhanshanhaiController:send_20_252(qbGuid,#temp,temp)
end
end
else
UIManager.info("讨伐队已达上限")
end
else
UIManager.info("暂无满足条件的集结队伍")
end
end

function UIXMZZSH_YuBeiDuiMainWin:onShuaxinBtn()
zhengzhanshanhaiController:send_20_251(self.stage,_this.qbGuid)
end


function UIXMZZSH_YuBeiDuiMainWin:refreshDZlist()
local alllist=zhengzhanshanhaiModel:getybd_Allguildlist()


if alllist and next(alllist)then
_this.itemScrollView:setActive(true)
_this.noSign:setActive(false)


self.teamsList=alllist
local len=#self.teamsList
if len>1 then
table.sort(self.teamsList,function(a,b)
if self.fightSortType==1 then
return a.fight_num>b.fight_num
else
return a.fight_num<b.fight_num
end
end)
end

_this.itemPanel:setChildLayoutGroupCreateItems(len,function(i)
local item=_this.itemPanel:getChildLayoutGroupGridItem(i-1)
local severdata=self.teamsList[i]
local playerguid=severdata.actorid
local playerserverid=severdata.serverid
local playername=severdata.actorname
local dzlist=severdata.discipleList or{}
local _fight=severdata.fight_num

item:SetChildText(1,tostring(i))

local headParams={iconInfo=severdata.iconInfo,scale=0.7}
playerController:setHeadIcon(item,2,headParams)

local serverName=loginModel:getServerName(playerserverid)
local serverNamestr=FMT.fmt('[{0}]',serverName)
item:SetChildText(3,serverNamestr)

item:SetChildText(4,playername)

local dznum=5
item:SetChildLayoutGroupCreateItems(5,dznum)
local grids=item:GetChildLayoutGroupGridList(5)
for i=1,dznum do
local diziseverData=dzlist[i]


local dzitem=grids[i-1]
local has=diziseverData~=nil and diziseverData.flag>0

dzitem:SetChildActive(0,not has)
dzitem:SetChildActive(1,has)
if has then

local image=UIDiscipleModel.calculationDiscipleImage(diziseverData.discipledata,diziseverData.discipleimage)

comHelper.setChildModelHeadIconBGByColor(dzitem,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,dzitem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzitem:SetChildCSImageSprite(3,globalABLookup.global,jobicon)


end
end

item:SetChildText(6,mathHelper.formatNumber5(_fight,2))





local playerlist=zhengzhanshanhaiModel:getybd_playerlist()
local playerkey=tostring(playerguid)
local isshowjoin=true
if playerlist[playerkey]and playerlist[playerkey].playchuzhan then
isshowjoin=false
end
item:SetChildActive(9,isshowjoin)
item:SetChildActive(10,not isshowjoin)
if isshowjoin then
item:SetChildButtonClick(9,function()
if _this==nil then return end
_this:onjoinBtnClick(i)
end)
end
if isshowjoin then
item:SetChildButtonClick(10,function()
if _this==nil then return end
_this:onKickoutBtnClick(i)
end)
end
end)
else
_this.itemScrollView:setActive(false)
_this.noSign:setActive(true)
end
end


function UIXMZZSH_YuBeiDuiMainWin:refreshtemnum()
local maxNum,fixNum=zhengzhanshanhaiModel:getMaxMonsterTeamNum()
local qbData=zhengzhanshanhaiModel:getQingBaoData(_this.qbGuid)

if qbData==nil then return end
local list={}
local detail_xm=qbData:getDetail_xm()
for key,v in pairs(detail_xm.allTeam)do
table.insert(list,v)
end
local num=#list

_this.tipsTxt:setText(FMT.fmt('征讨异兽集结队伍数量: <color=#549327>{0}/{1}</color>',num,maxNum))
end

function UIXMZZSH_YuBeiDuiMainWin:containQBGuid(guid)
return self.qbGuid==guid
end


function UIXMZZSH_YuBeiDuiMainWin:onjoinBtnClick(idx,_severdata)
local qbGuid=_this.qbGuid
local qbData_=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData_==nil then return end
local teamData_=zhengzhanshanhaiModel:getMyPvETeam(qbGuid,qbData_.infotype)
if teamData_==nil then return end
if teamData_.sec>0 then
UIManager.error('队伍已出发，不可再加入')
self:closeSelf()
return
end
local severdata=self.teamsList[idx]
local playerguid=severdata.actorid
local temp=
{
playerguid
}
if qbGuid and playerguid then
local playkey=tostring(playerguid)

zhengzhanshanhaiModel:setybd_playerflag(playkey,true)
zhengzhanshanhaiController:send_20_252(qbGuid,#temp,temp)
end
end

function UIXMZZSH_YuBeiDuiMainWin:onKickoutBtnClick(idx,_severdata)
local qbGuid=_this.qbGuid
local qbData=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData==nil then return end
local detail_xm=qbData:getDetail_xm()
if detail_xm==nil then return end

local severdata=self.teamsList[idx]
local taractorid=severdata.actorid
local isCreater=true
local isMy=false
if isCreater and not isMy then
local content='是否将该玩家踢出退伍'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
local qbData_=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData_==nil then return end
local teamData_=zhengzhanshanhaiModel:getMyPvETeam(qbGuid,qbData_.infotype)
if teamData_==nil then return end
if teamData_.sec>0 then
UIManager.error('队伍已出发，无法踢出')
return
end
local kitoutplaykey=tostring(taractorid)

zhengzhanshanhaiModel:setkitoutplayerid(kitoutplaykey)
zhengzhanshanhaiController:reqMonsterJiJieKickout(qbGuid,taractorid)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end


function UIXMZZSH_YuBeiDuiMainWin:onFightSortBtn()
if self.fightSortType==1 then
self.fightSortType=2
else
self.fightSortType=1
end
self:refreshSortBtn()
self:refreshDZlist()
end
function UIXMZZSH_YuBeiDuiMainWin:refreshSortBtn()
local fightIcon
if self.fightSortType==1 then
fightIcon='button_tybukepailie'
else
fightIcon='button_tykepailie'
end
self.fightSortIcon:setSprite(globalABLookup.global,fightIcon)
end