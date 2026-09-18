







def_class("UIJiuYouTaLogWin",UIWindowBase)









function UIJiuYouTaLogWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.Content=UIObject.get(self,1)
self.layer=UIText.get(self,2)
self.noImage=UIObject.get(self,3)
self.packScrollerView=UIObject.get(self,4)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIJiuYouTaLogWin")end)



end


function UIJiuYouTaLogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.noImage);self.noImage=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
end


















local cmpIndex=
{
bg1=1,
bg2=2,
bg3=3,
bg4=4,
icon=5,
zmname=6,
name=7,
teamButton=8,
playButton=9,
noneIocn=10,
empty=11,
notEmpty=12,
}


function UIJiuYouTaLogWin:onLoaded(...)
self:bindComponents()
end


function UIJiuYouTaLogWin:__delete()
self:unbindComponents()
end




function UIJiuYouTaLogWin:onShow(argtable,afterOnloaded)
self.selectedLayer=argtable.layer
local req=JiuYouTaController.req_13_22(argtable.layer)
self:onRefresh()
end


function UIJiuYouTaLogWin:onHide()

end

local RECORD_TYPE=
{
maxF=1,
minF=2,
last=3,
maxS=4,
}

function UIJiuYouTaLogWin:onRefresh()
self.layer:setText(FMT.fmt("{0}层",self.selectedLayer))
local record=JiuYouTaModel:getRecord(self.selectedLayer)

local rankType=JiuYouTaModel:getJiuYouTaRankType()or JIUYOUTA_RANK_TYPE.eLocal
local logType=JiuYouTaModel:getJiuYouTaLogType(rankType)

if not record then
self.noImage:setActive(true)
self.packScrollerView:setChildScrollViewCreateGrids(0,1)
return
end

local recordList={}
if next(record.list)then
recordList[1]=record.maxFightInfo
recordList[1].rType=RECORD_TYPE.maxF
recordList[2]=record.minFightInfo
recordList[2].rType=RECORD_TYPE.minF
recordList[3]=record.list[#record.list]or{}
recordList[3].rType=RECORD_TYPE.last
if JiuYouTaModel:getExLayer(self.selectedLayer)then
local newRecord=record.maxScoreInfo
newRecord.rType=RECORD_TYPE.maxS
table.insert(recordList,1,newRecord)
end
end

local rankType=JiuYouTaModel:getJiuYouTaRankType()

self.noImage:setActive(next(record.list)==nil)
self.packScrollerView:setChildScrollViewCreateGrids(#recordList,1)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=recordList[i]
if item then
local recordType=data.rType
item:SetChildActive(cmpIndex.bg1,recordType==1)
item:SetChildActive(cmpIndex.bg2,recordType==2)
item:SetChildActive(cmpIndex.bg3,recordType==3)
item:SetChildActive(cmpIndex.bg4,recordType==4)

item:SetChildActive(cmpIndex.empty,data==nil)
item:SetChildActive(cmpIndex.notEmpty,data~=nil)


if data and data.log_time~=0 then



if recordType<=3 then
item:SetChildActive(13,true)
item:SetChildActive(15,false)
item:SetChildText(14,UIDiscipleModel:fightValueConversion(mathHelper.int64_to_number(data.fight_val)))
else
item:SetChildActive(13,false)
item:SetChildActive(15,true)
item:SetChildText(14,data.max_score)
end
playerController:setHeadIcon(item,cmpIndex.icon,{scale=0.6,iconInfo=data.iconInfo})
item:SetChildActive(cmpIndex.noneIocn,false)
if data.actor_name==''then
item:SetChildActive(cmpIndex.icon,false)
item:SetChildActive(cmpIndex.noneIocn,true)
item:SetChildLocalPosY(cmpIndex.name,0)
item:SetChildText(cmpIndex.zmname,'')
else
item:SetChildText(cmpIndex.zmname,loginModel:getServerName(data.server_id))
end


item:SetChildText(cmpIndex.name,playerModel:getOtherActorName(data.actor_name))
item:SetChildActive(cmpIndex.teamButton,true)
item:SetChildButtonClick(cmpIndex.teamButton,function()
local args={}
args.serverid=data.server_id
args.guidList=data.teamList
args.checkEmpty=true

local _callback=function(teamDzList)
local winArgs={}
winArgs.title='通关阵容'
winArgs.bgType=2
if((not teamDzList)or(not teamDzList.discipleList)or next(teamDzList.discipleList)==nil)then
UIManager.error("查看失败，阵容记录已过期")
else

local teamList={}
for i,v in ipairs(teamDzList.discipleList)do
if v.discipleguid then
teamList[i]=otherPlayerModel:getDZData(v.discipleguid)
local dzData=otherPlayerModel.detailDisciple_to_discipleStruct3(v)
local dzData_=otherPlayerModel:addDZData(data.actor_id,dzData,false,true)
teamList[i]=dzData_

end
end

local teamMaxDiscipleCount=5

local teamCount=math.ceil(#teamDzList.discipleList/teamMaxDiscipleCount)
if teamCount>1 then
winArgs.winName="UICommonLookRival_selectTeamWin"
winArgs.winArgs={teamCount=teamCount}
end

winArgs.teamList=teamList
winArgs.showFight=data.diziFightList
winArgs.bgImg={"ui/windows/jiuyouta/jiuyouta_atlas_pak.ab","image_jiuyouta_ditu"}
UIManager:showWindow("UICommonLookRivalWin",winArgs)
end
end
if rankType==JIUYOUTA_RANK_TYPE.eXianJie then
args.isXianJie=true
end
otherPlayerController:reqOtherZRInfo(data.actor_id,otherPlayerInfoType.eDZInfoList,args,data.server_id,_callback)

end)
item:SetChildButtonClick(cmpIndex.playButton,function()
local fightList=data.fightList
if fightList then
local args={
eReplayType=eRePlayerType.jiuyaota,
layer=self.selectedLayer,
}

if#fightList==1 then
args.showBattle=true
fightController:send_log_list_ex(fightList,args,logType,{data.server_id})
self:closeSelf()
else
local monsterList=JiuYouTaModel.getLayerMonsterGroupList(self.selectedLayer)
local groupID
if monsterList then
groupID=monsterList[1]
end
args.player1={data.actor_id,data.actor_name,data.iconInfo}
args.monId2=groupID
fightController:send_log_list_ex(fightList,args,logType,{data.server_id})
self:closeSelf()
end
end
end)
item:SetChildActive(cmpIndex.notEmpty,true)
item:SetChildActive(cmpIndex.empty,false)
else
item:SetChildActive(cmpIndex.notEmpty,false)
item:SetChildActive(cmpIndex.empty,true)
end



end
end
end


