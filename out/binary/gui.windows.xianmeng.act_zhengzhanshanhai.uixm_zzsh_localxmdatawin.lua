







def_class("UIXM_ZZSH_localXmDataWin",UIWindowBase)









function UIXM_ZZSH_localXmDataWin:bindComponents()

self.HisScrollerScript=UIEnhancedScrollerLua.get(self,0)
self.RaceTitleImage=UIImage.get(self,1)
self.RaceTimeText=UIText.get(self,2)
self.myXMName=UIText.get(self,3)
self.oldWinValue=UIText.get(self,4)
self.oldAttackWinValue=UIText.get(self,5)
self.oldDefendWinValue=UIText.get(self,6)



end


function UIXM_ZZSH_localXmDataWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.HisScrollerScript);self.HisScrollerScript=nil;
_UIObject_release(self.RaceTitleImage);self.RaceTitleImage=nil;
_UIObject_release(self.RaceTimeText);self.RaceTimeText=nil;
_UIObject_release(self.myXMName);self.myXMName=nil;
_UIObject_release(self.oldWinValue);self.oldWinValue=nil;
_UIObject_release(self.oldAttackWinValue);self.oldAttackWinValue=nil;
_UIObject_release(self.oldDefendWinValue);self.oldDefendWinValue=nil;
end



















local UIEnScroller=simple_class(UIEnhancedScroller)

local UIXM_ZZSH_localXmDataWinindex=
{
TitleText=0,
allWinvalue=1,
AttacWinvalue=2,
DefendWinvalue=3,
zuijiaImage=4,
}
local Recordid=1000
local CdTime=30
local this
function UIXM_ZZSH_localXmDataWin:bindEnScroller()
self.enhancedscrollscript=UIEnScroller(self.HisScrollerScript:getGameObject(),self.HisScrollerScript:getCSharpObject(),nil,nil)

end

function UIXM_ZZSH_localXmDataWin:onLoaded(...)
this=self
self:bindComponents()
self:bindEnScroller()
self.TimeRecord=zhengzhanshanhaiModel:getTimeRecord()
end


function UIXM_ZZSH_localXmDataWin:__delete()
self:unbindComponents()
end




function UIXM_ZZSH_localXmDataWin:onShow(argtable,afterOnloaded)
self.MomentumData=zhengzhanshanhaiModel:getMomentumData()
self:refreshRaceIcon()
self:refreshRaceTimer()
if self.TimeRecord[Recordid]and self.MomentumData then
local reqCd=((os.time()-self.TimeRecord[Recordid])>=CdTime)
if reqCd then
self.TimeRecord[Recordid]=os.time()
self:reqHandle()
else
self:refreshRight()
end
else
self.TimeRecord[Recordid]=os.time()
self:reqHandle()
end
end


function UIXM_ZZSH_localXmDataWin:onHide()

end



function UIXM_ZZSH_localXmDataWin:onCloseClick()
self:closeSelf()
end


function UIXM_ZZSH_localXmDataWin:reqHandle()
zhengzhanshanhaiController:reqlocalXMData()
end


function UIXM_ZZSH_localXmDataWin:refreshRight()
self.MomentumData=zhengzhanshanhaiModel:getMomentumData()
self:refreshWinCount()
local name
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then
local raceIndex=zhengzhanshanhaiModel:getRaceIndex()
name=cfgHelper.get2(cfg_zhengzhanshanhaisessionconfig_get,raceIndex,'name')
else

name=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId,'name')
end
self.enhancedscrollscript:initData(self.MomentumData.localRaceXMDataList,101,#self.MomentumData.localRaceXMDataList)

end

function UIEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local curdata=this.MomentumData.localRaceXMDataList[dataIndex]
local seasonId=curdata.param_1
local isSeason=curdata.isSeason
local raceName
if not isSeason then
raceName=cfgHelper.get2(cfg_zhengzhanshanhaisessionconfig_get,seasonId,'name')
else

raceName=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,seasonId,'name')
end

cell:SetChildText(UIXM_ZZSH_localXmDataWinindex.TitleText,raceName or"")
cell:SetChildText(UIXM_ZZSH_localXmDataWinindex.allWinvalue,curdata.param_2+curdata.param_3)
cell:SetChildText(UIXM_ZZSH_localXmDataWinindex.AttacWinvalue,curdata.param_2)
cell:SetChildText(UIXM_ZZSH_localXmDataWinindex.DefendWinvalue,curdata.param_3)
cell:SetChildActive(UIXM_ZZSH_localXmDataWinindex.zuijiaImage,dataIndex==this.zuijiaindex)
end


function UIXM_ZZSH_localXmDataWin:refreshRaceTimer()
local actID=LIMIT_ACT_TYPE.eZhengZhanShanHai
local data=limitActivitiesModel:getActInfo(actID)
if data then
local startstr=timeHelper.getFiveFormatByStamp(data.start_time_l)
local endstr=timeHelper.getFiveFormatByStamp(data.end_time_l)
self.RaceTimeText:setText(string.format("%s-%s",startstr,endstr))
end
end


function UIXM_ZZSH_localXmDataWin:refreshRaceIcon()
local icon
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then
local raceIndex=zhengzhanshanhaiModel:getRaceIndex()
icon=cfgHelper.get2(cfg_zhengzhanshanhaisessionconfig_get,raceIndex,'mapicon')
else

icon=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId,"seasonIconid")
end
self.RaceTitleImage:setSprite(globalABLookup.zzshtitleicons,FMT.fmt('image_shanhaishijiebt_{0}',icon))
end


function UIXM_ZZSH_localXmDataWin:refreshWinCount()
if self.MomentumData.localRaceXMDataList then
local oldWinValue,oldAttackWinValue,oldDefendWinValue=0,0,0
local zuijiaList={}
for i,v in ipairs(self.MomentumData.localRaceXMDataList)do
oldAttackWinValue=v.param_2+oldAttackWinValue
oldDefendWinValue=v.param_3+oldDefendWinValue
table.insert(zuijiaList,{index=i,value=oldAttackWinValue+oldDefendWinValue})
end
table.sort(zuijiaList,function(a,b)
return a.value>b.value
end)
self.zuijiaindex=zuijiaList[1].index
oldWinValue=oldAttackWinValue+oldDefendWinValue
self.oldWinValue:setText(oldWinValue)
self.oldAttackWinValue:setText(oldAttackWinValue)
self.oldDefendWinValue:setText(oldDefendWinValue)
local detailData=xianmengModel:getMyXMDetialData()
self.myXMName:setText(detailData.guildname)
end
end
