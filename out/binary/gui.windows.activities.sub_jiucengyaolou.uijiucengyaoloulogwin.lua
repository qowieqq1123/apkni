







def_class("UIJiuCengYaoLouLogWin",UIWindowBase)









function UIJiuCengYaoLouLogWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.noImage=UIObject.get(self,1)
self.packScrollerView=UIObject.get(self,2)
self.descFrame=UIObject.get(self,3)
self.hideDescFrameBtn=UIButton.get(self,4)
self.desc=UIText.get(self,5)
self.citiaoRoot=UIObject.get(self,6)
self.citiaoScrollerView=UIObject.get(self,7)
self.nocitiao=UIObject.get(self,8)
self.layer=UIText.get(self,9)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIJiuCengYaoLouLogWin")end)

self.hideDescFrameBtn:setButtonClick(function()self:onHideDescFrameBtn()end)



end


function UIJiuCengYaoLouLogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.noImage);self.noImage=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.descFrame);self.descFrame=nil;
_UIObject_release(self.hideDescFrameBtn);self.hideDescFrameBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.citiaoRoot);self.citiaoRoot=nil;
_UIObject_release(self.citiaoScrollerView);self.citiaoScrollerView=nil;
_UIObject_release(self.nocitiao);self.nocitiao=nil;
_UIObject_release(self.layer);self.layer=nil;
end


















local cmpIndex=
{
bg1=1,
bg2=2,
bg3=3,
kuang=4,
icon=5,
zmname=6,
name=7,
teamButton=8,
playButton=9,
}


function UIJiuCengYaoLouLogWin:onLoaded(...)
self:bindComponents()
end


function UIJiuCengYaoLouLogWin:__delete()
self:unbindComponents()
end




function UIJiuCengYaoLouLogWin:onShow(argtable,afterOnloaded)
self.selectedLayer=argtable.layer
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
self.subid=argtable.sub_act_id
self.floorDataList=argtable.data

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

self.layer:setText(FMT.fmt("第{0}层",self.selectedLayer))
if self.info then
local logList=self.info:getFloorLog(self.selectedLayer,true)
if logList then
self.noImage:setActive(false)
self.packScrollerView:setActive(true)
self:onRefresh(logList)
else
self.noImage:setActive(true)
self.packScrollerView:setActive(false)
end
end
end


function UIJiuCengYaoLouLogWin:onHide()

end

function UIJiuCengYaoLouLogWin:onRecv()
if self.info then
local logList=self.info:getFloorLog(self.selectedLayer)
if logList then
self.noImage:setActive(false)
self.packScrollerView:setActive(true)
self:onRefresh(logList)
else
self.noImage:setActive(true)
self.packScrollerView:setActive(false)
end

end
end

function UIJiuCengYaoLouLogWin:onRefresh(recordList)
local num
local haveJiXian=activitiesHandle_jiucengyaolou:get_jixianCiTiaoNum(self.subid,self.selectedLayer)
if haveJiXian then
num=2
self.citiaoRoot:setLocalPosY(-90)
else
num=1
self.citiaoRoot:setLocalPosY(0)
end
self.packScrollerView:setChildLayoutGroupCreateItems(num,function(i)
local item=self.packScrollerView:getChildLayoutGroupGridItem(i-1)
if item then
local data
local isJiXianLog=false
if haveJiXian then
if i==1 then
isJiXianLog=true
data=recordList.jiXianLog
else
data=recordList.diZhanLog
end
else
data=recordList.diZhanLog
end


item:SetChildActive(cmpIndex.bg1,isJiXianLog)
item:SetChildActive(cmpIndex.bg2,not isJiXianLog)
if data then

item:SetChildActive(cmpIndex.kuang,true)
item:SetChildActive(10,false)
playerController:setHeadIcon(item,cmpIndex.kuang,{scale=0.7,iconInfo=data.iconInfo})

item:SetChildText(cmpIndex.zmname,data.sectname)
item:SetChildText(cmpIndex.name,data.actorname)
item:SetChildActive(cmpIndex.teamButton,true)
item:SetChildActive(cmpIndex.playButton,true)
item:SetChildButtonClick(cmpIndex.teamButton,function()
otherPlayerController:reqCommonInfo(int64.zero,otherPlayerInfoType.eJiuCengYaoLouDef2,{actID=self.actid,subType=self.subType,subid=self.subid,floor=self.selectedLayer,idx=isJiXianLog and 2 or 1},self.onShowZhenRong)
end)
item:SetChildButtonClick(cmpIndex.playButton,function()
fightController:send_254_29(data.fightlogid,{nil,data.fightlogid,eRePlayerType.jiucengyaolou,data={act_id=self.actid,act2_id=self.subid,jumpIndex=self.selectedLayer}},false)
end)
else
item:SetChildActive(cmpIndex.kuang,false)
item:SetChildActive(10,true)
item:SetChildText(cmpIndex.zmname,"\n虚位以待")
item:SetChildActive(cmpIndex.teamButton,false)
item:SetChildActive(cmpIndex.playButton,false)
end
end
end)
local dizhanlog=recordList.diZhanLog
if not dizhanlog then
dizhanlog=recordList.jiXianLog
end
if dizhanlog then
local logData=dizhanlog
local citiaoList=logData.citiaoList
local floorCiTiaoList=self.floorDataList[self.selectedLayer].citiaoList
if citiaoList then
local len=logData.citiaolistlen>6 and 6 or logData.citiaolistlen
self.citiaoScrollerView:setChildLayoutGroupCreateItems(len,function(i)
local item=self.citiaoScrollerView:getChildLayoutGroupGridItem(i-1)
if item then
local ruleId=floorCiTiaoList[citiaoList[i]]
if ruleId then
local ruleCfg=cfgHelper.getSSlawRule(ruleId)
if ruleCfg then
local icon=ruleCfg.image
local name=ruleCfg.name
local desc=ruleCfg.desc
item:SetChildIcon(0,icon,false)
item:SetChildText(1,name)
item:SetChildButtonClick(0,function()
self.descFrame:setActive(true)
self.desc:setText(FMT.fmt("<color=#f36666>{0}</color>：{1}",name,desc))
self.descFrame:setChildPosition(item:GetChildPosition(0)+Vector3(0,0.9,0))
end)
end
end
end
end)
self.nocitiao:setActive(false)
else
self.nocitiao:setActive(true)
end
end
end

function UIJiuCengYaoLouLogWin.onShowZhenRong(args)
local diziLimt=args
UIManager:showWindow("UIDiZiLookRivalWin",{teamList=diziLimt,attachView={"UIShiLianTaLookRivalBgWin"}})
end

function UIJiuCengYaoLouLogWin:onHideDescFrameBtn()
self.descFrame:setActive(false)
end


