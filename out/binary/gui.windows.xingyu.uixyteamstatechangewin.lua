







def_class("UIXYTeamStateChangeWin",UIWindowBase)









function UIXYTeamStateChangeWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.hzlayout=UIObject.get(self,1)
self.zdlayout=UIObject.get(self,2)
self.hzitemlayout=UIObject.get(self,3)
self.zditemlayout=UIObject.get(self,4)
self.layout=UIObject.get(self,5)
self.bgModel=UIObject.get(self,6)
self.root=UIObject.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXYTeamStateChangeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.hzlayout);self.hzlayout=nil;
_UIObject_release(self.zdlayout);self.zdlayout=nil;
_UIObject_release(self.hzitemlayout);self.hzitemlayout=nil;
_UIObject_release(self.zditemlayout);self.zditemlayout=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
end















local cmpIndex={
teamTxt=0,
tips=1,
gjIcon=2,
slotList={3,4,5,6,7},
nodzTipList={8,9,10,11,12}
}



function UIXYTeamStateChangeWin:onLoaded(...)
self:bindComponents()
self.bgModel:setChildUIModelShowTarget(5652,1,nil,eAnimationID.enter,false,false,0,function()
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
end)
end


function UIXYTeamStateChangeWin:__delete()
self:unbindComponents()
end




function UIXYTeamStateChangeWin:onShow(argtable,afterOnloaded)
local args={}
local xyId=argtable.xyId
self.xyId=xyId
local hzList=argtable.hzList
local zdList=argtable.zdList

self.hzlayout:setActive(#hzList>0)
if#hzList>0 then
self.hzitemlayout:setChildLayoutGroupCreateItems(#hzList,function(index)
local data=hzList[index]
local itemTemp=self.hzitemlayout:getChildLayoutGroupGridItem(index-1)
itemTemp:SetChildText(cmpIndex.teamTxt,FMT.fmt("{0}队",data.teamIndex))
itemTemp:SetChildActive(cmpIndex.gjIcon,false)
local isWin=data.isWin
local str
if isWin then
if data.isJJZDZ then
str="晋级争夺战"
else
str=FMT.fmt("晋级第{0}轮",data.showRound)
end
else
str=FMT.fmt("第{0}轮淘汰",data.showRound)
end
itemTemp:SetChildText(cmpIndex.tips,str)

local dzList=data.guidList
if dzList then
for i,cmp in ipairs(cmpIndex.slotList)do
local guid=dzList[i]
if guid then
itemTemp:SetChildActive(cmp,true)
local headshot=itemTemp:GetChildWidgetBase(cmp)
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
headshot:SetChildGray(0,not isWin)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headshot,modelParams,eHeadCenterType.eHead,nil,not isWin)
else
itemTemp:SetChildActive(cmp,false)
end
end
else
logErr("拿不到队伍数据",xyId,data.teamIndex)
end
end)
self.winlua:ForceLayoutVertical(self.hzitemlayout:getID())
self.winlua:ForceLayoutVertical(self.hzlayout:getID())
end

self.zdlayout:setActive(#zdList>0)
if#zdList>0 then
self.zditemlayout:setChildLayoutGroupCreateItems(#zdList,function(index)
local data=zdList[index]
local itemTemp=self.zditemlayout:getChildLayoutGroupGridItem(index-1)
itemTemp:SetChildText(cmpIndex.teamTxt,FMT.fmt("{0}队",data.teamIndex))
itemTemp:SetChildActive(cmpIndex.gjIcon,false)
local isWin=data.isWin
local str
if isWin then
if data.isGJ then
str=""
itemTemp:SetChildActive(cmpIndex.gjIcon,true)
else
str=FMT.fmt("晋级第{0}轮",data.showRound)
end
else
str=FMT.fmt("第{0}轮淘汰",data.showRound)
end
itemTemp:SetChildText(cmpIndex.tips,str)

local guidList=data.guidList
if guidList then
for i,cmp in ipairs(cmpIndex.slotList)do
local guid=guidList[i]
if guid then
local discipleData=UIDiscipleModel:getDiscipleDataX(guid)
if discipleData then
itemTemp:SetChildActive(cmp,true)
local headshot=itemTemp:GetChildWidgetBase(cmp)
local netdata=discipleData.netData.net
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
headshot:SetChildGray(0,not isWin)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headshot,modelParams,eHeadCenterType.eHead,nil,not isWin)
else
itemTemp:SetChildActive(cmp,false)
itemTemp:SetChildActive(cmpIndex.nodzTipList[i],true)
end
else
itemTemp:SetChildActive(cmpIndex.nodzTipList[i],false)
itemTemp:SetChildActive(cmp,false)
end
end
else
logErr("拿不到队伍数据",xyId,data.teamIndex)
end
end)
self.winlua:ForceLayoutVertical(self.zditemlayout:getID())
self.winlua:ForceLayoutVertical(self.zdlayout:getID())
end

self.winlua:ForceLayoutVertical(self.layout:getID())
end


function UIXYTeamStateChangeWin:onHide()

end





function UIXYTeamStateChangeWin:onCloseBtn()
self:closeSelf()
end

