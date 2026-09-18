







def_class("UIXFWD_WDCQ_CSMD_Win",UIWindowBase)









function UIXFWD_WDCQ_CSMD_Win:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.mdScrollView=UIScrollView.get(self,1)
self.nullTips=UIText.get(self,2)
self.Root=UIObject.get(self,3)
self.tip=UIText.get(self,4)
self.tipbg=UIObject.get(self,5)
self.uiRoot=UIObject.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXFWD_WDCQ_CSMD_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mdScrollView);self.mdScrollView=nil;
_UIObject_release(self.nullTips);self.nullTips=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.tipbg);self.tipbg=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local CmpRankSlotIndex={
mc=0,
mcIcon=1,
head=2,
server=3,
name=4,
selfFlag=5,
tip=6,
default=7,
selfBg=8,
}




function UIXFWD_WDCQ_CSMD_Win:onLoaded(...)
self:bindComponents()

local _bindWidget=function(...)self:bindWidget(...)end
self.mdScrollView:bindScrollWidget(_bindWidget)

self:addNotify(notifyConfig.onXianFaLunDaoRankUpdate,function()
self:refreshAll()
end)
end


function UIXFWD_WDCQ_CSMD_Win:__delete()
self:unbindComponents()
end




function UIXFWD_WDCQ_CSMD_Win:onShow(argtable,afterOnloaded)

self:refreshAll()

end


function UIXFWD_WDCQ_CSMD_Win:onHide()

end

function UIXFWD_WDCQ_CSMD_Win:refreshAll()
local mdList,tip=self:getInfo()
self.mdList=mdList

local mdlen=#self.mdList

local isShow=mdlen>0

self.mdScrollView:setActive(isShow)
self.tipbg:setActive(isShow)
self.nullTips:setActive(not isShow)

if isShow then
self.mdScrollView:freshGridsNum(mdlen,mdlen,1)

self.tip:setText(tip)
end
end

function UIXFWD_WDCQ_CSMD_Win:bindWidget(index,item)
local data=self.mdList[index]
local isShow=data~=nil

item:SetChildActive(-1,isShow)
if isShow then

local isShowMcIcon=index<=3
item:SetChildActive(CmpRankSlotIndex.mcIcon,isShowMcIcon)
item:SetChildText(CmpRankSlotIndex.mc,data.index)

if isShowMcIcon then
item:SetChildCSImageSprite(CmpRankSlotIndex.mcIcon,globalABLookup.global,'icon_phbmingci_'..index)
end

local hasRankData=data.rankData~=nil
item:SetChildActive(CmpRankSlotIndex.default,not hasRankData)
item:SetChildActive(CmpRankSlotIndex.server,hasRankData)
item:SetChildActive(CmpRankSlotIndex.name,hasRankData)
item:SetChildActive(CmpRankSlotIndex.tip,not hasRankData)
if hasRankData then
playerController:setHeadIcon(item,CmpRankSlotIndex.head,{scale=0.7,iconInfo=data.rankData.iconInfo})

local serverName=loginModel:getServerName(data.rankData.serverid)






serverName=FMT.fmt("[{0}]",serverName)

item:SetChildText(CmpRankSlotIndex.server,serverName)
item:SetChildText(CmpRankSlotIndex.name,data.rankData.actorname)
else
item:SetChildText(CmpRankSlotIndex.tip,data.tip)
end
end

item:SetChildActive(CmpRankSlotIndex.selfFlag,data.isSelf)
item:SetChildActive(CmpRankSlotIndex.selfBg,data.isSelf)
end

function UIXFWD_WDCQ_CSMD_Win:getInfo()

local selfActorId=playerModel:getActorID()
local isReg=UIXianFaWenDaoControl:getRegister()
local isInTruceTime=UIXianFaWenDaoControl:isInTruceTime()


local tempList={}
local sindex=1

local level
if isReg then
level=UIXianFaWenDaoControl:getLevel()
else
local unlockCfg=WDCQController:getUnlockGroupCfgList()
for index=#unlockCfg,1,-1 do
if WDCQController.checkHasEntryGroup(unlockCfg[index].id)then
level=unlockCfg[index].id
break
end
end
end

local rankDatas=UIXianFaWenDaoControl:getRankDataByLevel(level)

if isInTruceTime then
for index,rankData in ipairs(rankDatas)do
if rankData~=nil and next(rankData)then
local isEntry=WDCQModel:getRankRoleInfo2(rankData.actorid)~=nil
if isEntry then
local temp={}
temp.index=sindex
temp.rankData=rankData
temp.isSelf=mathHelper.compareInt64(rankData.actorid,selfActorId)
tempList[sindex]=temp
sindex=sindex+1
end
end
end

else
local len=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'can_attend_rank')
for index=1,len do
local data=rankDatas[index]
local temp={}
temp.index=sindex
if data~=nil and next(data)then
temp.rankData=data
temp.isSelf=mathHelper.compareInt64(data.actorid,selfActorId)
tempList[sindex]=temp
else
temp.tip="<color=#827f78>虚位以待</color>"
tempList[sindex]=temp
end
sindex=sindex+1
end
end


local tip

if not isInTruceTime then
local len=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'can_attend_rank')
tempList[#tempList+1]={tip="<color=#827f78>赛季结束，根据区服数动态增加参赛名额</color>",index="?"}
tip=FMT.fmt("以赛季结算的最终排名为准，前{0}名祖师可参加问鼎苍穹\n并且根据区服数动态增加参赛名额",len)
else
tip="以上祖师将参加问鼎苍穹"
end


return tempList,tip
end

function UIXFWD_WDCQ_CSMD_Win:onCloseBtn()
self:closeSelf()
end


