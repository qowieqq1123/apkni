







def_class("UIXianJie_yzTeamSelectWin",UIWindowBase)









function UIXianJie_yzTeamSelectWin:bindComponents()

self.mask=UIObject.get(self,0)
self.back=UIObject.get(self,1)
self.bgRoot=UIObject.get(self,2)
self.title=UIText.get(self,3)
self.btnClose=UIButton.get(self,4)
self.root=UIObject.get(self,5)
self.commitBtn=UIButton.get(self,6)
self.teamListPanel=UIObject.get(self,7)
self.Content=UIObject.get(self,8)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIXianJie_yzTeamSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.bgRoot);self.bgRoot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.teamListPanel);self.teamListPanel=nil;
_UIObject_release(self.Content);self.Content=nil;
end
















local _this
local _teamItemCmpIndex={
hasDzPanel=0,
notDzPanel=1,
select=2,
dzGroup=3,
notClick=4,
teamNameText=5,
changeTeamNameBtn=6,
hasDzClickMask=7,
removeTeamBtn=8,
}

local _dzItemCmpIndex=
{
name=0,
fight=1,
stateName=2,
head=3,
color=4,
job=5,
mask=6,
root=7,
stateImg=8,
self=9,
hasPanel=10,
state=11,
tianminObj=12,
banFlag=13,
ban=14,
notPanel=15,
posFlag=16,
back_xianmo=17,
spDzFlag=18,
}
local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local diziabname='ui/windows/disciple/sharedtextures/uidisciplecolorframeicons.ab'
local ColorToFrame={
[eQualityColor.eGreen]='frame_dzkplvse',
[eQualityColor.eBlue]='frame_dzkplanse',
[eQualityColor.ePurple]='frame_dzkpzise',
[eQualityColor.eOrange]='frame_dzkpchengse',
[eQualityColor.eRed]='frame_dzkphongse',
}



function UIXianJie_yzTeamSelectWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJie_yzTeamSelectWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJie_yzTeamSelectWin:onShow(argtable,afterOnloaded)
self.yzIndex=argtable and argtable.yzIndex
self.selectTeamIndex=argtable and argtable.selectTeamIndex or nil
self.isIgnoreYz=argtable and argtable.isIgnoreYz
self.isOnlyEditTeam=argtable and argtable.isOnlyEditTeam
self.isCheckSMDData=argtable and argtable.isCheckSMDData
self.isCheckXJYZData=argtable and argtable.isCheckXJYZData
self.smdId=argtable and argtable.smdId
self.gx_id=argtable and argtable.gx_id
if not self.yzIndex and not self.isIgnoreYz then
return self:onBtnClose()
end
self.title:setText("布阵队伍")

if not self.selectTeamIndex then
local teamList
if self.isCheckXJYZData then
teamList=XianJunYanZhenModel:getXJYZYunZhouTeamDataList()
else
teamList=xianjieModel:getXJYunZhouTeamDataList()
end

for i,teamData in ipairs(teamList)do
if teamData and teamData.dzList and next(teamData.dzList)then

self.selectTeamIndex=i
break
end
end
end

self.root:setChildCanvasGroupAlpha(0)
local cb=function()
self:doFadeIn(0.15,0.5)
end

if afterOnloaded then
self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,cb)
else
cb()
end
self:refresh(true)
end


function UIXianJie_yzTeamSelectWin:onHide()

end

function UIXianJie_yzTeamSelectWin:doFadeIn(delay,duration)
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end

function UIXianJie_yzTeamSelectWin:refresh(needJump)
local teamList
if self.isCheckXJYZData then
teamList=XianJunYanZhenModel:getXJYZYunZhouTeamDataList()
else
teamList=xianjieModel:getXJYunZhouTeamDataList()
end


local showTeamCount=#teamList+1
self.teamListPanel:setChildScrollViewCreateGrids(showTeamCount,1)
local grids=self.teamListPanel:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local teamData=teamList[i]
local isSelect=self.selectTeamIndex and self.selectTeamIndex==i or false
widget:SetChildActive(_teamItemCmpIndex.select,isSelect)

widget:SetChildActive(_teamItemCmpIndex.changeTeamNameBtn,isSelect)
widget:SetChildButtonClick(_teamItemCmpIndex.changeTeamNameBtn,function()
if _this==nil then return end
return _this:onChangeTeamNameClick(i)
end,true)


widget:SetChildButtonClick(_teamItemCmpIndex.removeTeamBtn,function()
if _this==nil then return end
return _this:onRemoveTeamClick(i)
end,true)

if teamData and teamData.dzList and next(teamData.dzList)then

widget:SetChildActive(_teamItemCmpIndex.hasDzPanel,true)
widget:SetChildActive(_teamItemCmpIndex.notDzPanel,false)

widget:SetChildActive(_teamItemCmpIndex.hasDzClickMask,not isSelect)

widget:SetChildButtonClick(_teamItemCmpIndex.hasDzClickMask,function()
if _this==nil then return end
return _this:selectTeam(i)
end,true)


local teamName=teamData.name
if not teamName or teamName==''then

teamName=FMT.fmt("队伍{0}",mathHelper.numberToChinese(i))
end
widget:SetChildText(_teamItemCmpIndex.teamNameText,teamName)

widget:SetChildActive(_teamItemCmpIndex.dzGroup,true)
local dzList=teamData.dzList or{}
local dzItemGrids=widget:GetChildCommonLayoutGroupWidgetList(_teamItemCmpIndex.dzGroup)
for posIdx=1,dzItemGrids.Count do
local dzWidget=dzItemGrids[posIdx-1]
local guid=dzList[posIdx]
local hasDz=guid~=nil
local netdata
if hasDz then
netdata=UIDiscipleModel:getDiscipleData(guid)
if not netdata then
hasDz=false
end
end

dzWidget:SetChildActive(_dzItemCmpIndex.hasPanel,hasDz)
dzWidget:SetChildActive(_dzItemCmpIndex.notPanel,not hasDz)
dzWidget:SetChildActive(_dzItemCmpIndex.posFlag,hasDz)
if hasDz then




dzWidget:SetChildText(_dzItemCmpIndex.name,UIDiscipleModel:getDiscipleName(guid))

local fightValue=UIDiscipleModel:getDiscipleFightValue(guid)
dzWidget:SetChildText(_dzItemCmpIndex.fight,FMT.fmt('<color=#7d3b17>战</color> {0}',fightValue))




local dzState,stateStr=xianjieModel:getDZState(guid,true)
local isOccupy=dzState~=nil
local isInSMD=false
local isInXJYZ=false
if self.isCheckSMDData then
local id=xianjieModel:GetYetDizi(guid)
isInSMD=id~=0 and self.smdId~=id
end
if self.isCheckXJYZData then
isOccupy=false
isInXJYZ=XianJunYanZhenModel:getIsUsedDZ(guid,self.gx_id)
end
dzWidget:SetChildActive(_dzItemCmpIndex.mask,isInSMD)
if(isOccupy or isInSMD or isInXJYZ)and not self.isOnlyEditTeam then

if not isOccupy and isInSMD then
stateStr="已参战"
end
if not isOccupy and isInXJYZ then
stateStr="已锁定"
end
dzWidget:SetChildText(_dzItemCmpIndex.stateName,stateStr)
dzWidget:SetChildActive(_dzItemCmpIndex.state,true)
else
dzWidget:SetChildActive(_dzItemCmpIndex.state,false)
end

comHelper.setChildModelRawImage(dzWidget,guid,_dzItemCmpIndex.head,0,eHeadCenterType.eHalf)

local color=UIDiscipleModel:getDiscipleColor(guid)
dzWidget:SetChildCSImageSprite(_dzItemCmpIndex.color,diziabname,ColorToFrame[color])

local jobIcon=UIDiscipleModel:getJobIconNameX(guid)
dzWidget:SetChildCSImageSprite(_dzItemCmpIndex.job,globalab,jobIcon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
dzWidget:SetChildActive(_dzItemCmpIndex.spDzFlag,isSpDz)

UIDiscipleController.refreshCommonItemTianMing(dzWidget,netdata,_dzItemCmpIndex.tianminObj)

UIDiscipleModel:setDiscipleXianMoBackImage(dzWidget,_dzItemCmpIndex.back_xianmo,netdata)


dzWidget:SetChildButtonClick(_dzItemCmpIndex.hasPanel,function()
if _this==nil then return end
return _this:showDzSelectWin(i)
end,true)
else

dzWidget:SetChildButtonClick(_dzItemCmpIndex.notPanel,function()
if _this==nil then return end
return _this:showDzSelectWin(i)
end,true)
end
end
else

widget:SetChildActive(_teamItemCmpIndex.hasDzPanel,false)
widget:SetChildActive(_teamItemCmpIndex.notDzPanel,true)
widget:SetChildActive(_teamItemCmpIndex.dzGroup,false)


widget:SetChildButtonClick(_teamItemCmpIndex.notClick,function()
if _this==nil then return end
return _this:showDzSelectWin(i)
end,true)


local teamName=FMT.fmt("队伍{0}",mathHelper.numberToChinese(i))
widget:SetChildText(_teamItemCmpIndex.teamNameText,teamName)
end
end

if needJump and self.selectTeamIndex then
self.teamListPanel:setChildScrollRectEnable(false)
self.teamListPanel:setChildScrollViewSelectItem(self.selectTeamIndex,false,false,true)
self.teamListPanel:setChildScrollRectEnable(true)
end
end


function UIXianJie_yzTeamSelectWin:showDzSelectWin(teamIndex)
local isOnlyEditTeam=self.isOnlyEditTeam
local isCheckSMDData=self.isCheckSMDData
local isCheckXJYZData=self.isCheckXJYZData
local smdId=self.smdId
local gx_id=self.gx_id
local extraParams={teamIndex=teamIndex,isOnlyEditTeam=isOnlyEditTeam,isCheckSMDData=isCheckSMDData,smdId=smdId,isCheckXJYZData=isCheckXJYZData,gx_id=gx_id}

local winParams={
titleName='弟子安排',
extraWin='UIXianJie_yzTeamDzSelectWin',
extraParams=extraParams,
}
self:showWindow('UICommonDragonBoneWin',winParams)
end

function UIXianJie_yzTeamSelectWin:selectTeam(teamIndex,needRefresh,needJump)
if not needRefresh and self.selectTeamIndex==teamIndex then
return
end
local teamList
if self.isCheckXJYZData then
teamList=XianJunYanZhenModel:getXJYZYunZhouTeamDataList()
else
teamList=xianjieModel:getXJYunZhouTeamDataList()
end
if teamIndex and teamList[teamIndex]then

self.selectTeamIndex=teamIndex
else
if next(teamList)then
self.selectTeamIndex=1
else
self.selectTeamIndex=nil
end
end
self:refresh(needJump)
end

function UIXianJie_yzTeamSelectWin:onChangeTeamNameClick(teamIndex)
local func=function(changeName)
if _this==nil then return end
UIManager.info('编队名字修改成功')
_this:changeTeamNameRecv(teamIndex,changeName)
end
local nowName
local args={
changeNameType=changeNameType.eXJYunZhou_team,
title='编队改名',
defaultName=nowName,
is_Chinese=true,
callback=func,
}
self:showWindow('UICommonChangeNameWin',args)
end

function UIXianJie_yzTeamSelectWin:changeTeamNameRecv(teamIndex,changeName)
notifySystem:postNotify(notifyConfig.onChangeName,changeNameType.eXJYunZhou_team)
xianjieModel:setXJYunZhouTeamNameByTeamIdx(teamIndex,changeName)
xianjieModel:saveXJYunZhouTeamDataList()
self:refresh()
end

function UIXianJie_yzTeamSelectWin:onRemoveTeamClick(teamIndex)
local idx
if self.isCheckXJYZData then
idx=XianJunYanZhenModel:setXJYZYunZhouTeamDzListByTeamIdx(teamIndex,nil)
XianJunYanZhenModel:saveXJYZYunZhouTeamDataList()
else
idx=xianjieModel:setXJYunZhouTeamDzListByTeamIdx(teamIndex,nil)
xianjieModel:saveXJYunZhouTeamDataList()
end
local contentPos=self.Content:getChildAnchoredPosition()
self:selectTeam(idx,true)


local scrollerViewHight=self.teamListPanel:getChildSizeDeltaY()
local contentHight=self.Content:getChildSizeDeltaY()
local maxY=contentHight-scrollerViewHight
if maxY<0 then
maxY=0
end
local jumpY=contentPos.y<=maxY and contentPos.y or maxY
self.Content:setChildAnchoredPosition(Vector2.New(contentPos.x,jumpY))
end




function UIXianJie_yzTeamSelectWin:onBtnClose()
self:closeSelf()
end



function UIXianJie_yzTeamSelectWin:onCommitBtn()
if not self.selectTeamIndex then
return UIManager.error("当前未选择队伍")
end
local teamData
if self.isCheckXJYZData then
teamData=XianJunYanZhenModel:getXJYZYunZhouTeamDataByTeamIdx(self.selectTeamIndex)or{}
else
teamData=xianjieModel:getXJYunZhouTeamDataByTeamIdx(self.selectTeamIndex)or{}
end
local dzList=teamData.dzList or{}
local teamList={}
local yzIdx=self.yzIndex

local yzDataSelectLookUp
if self.isCheckXJYZData then
yzDataSelectLookUp=XianJunYanZhenModel:getXJYZYunZhouDataSelectLookUp()
else
yzDataSelectLookUp=xianjieModel:getXJYunZhouDataSelectLookUp()
end
local maxPos=5
local needChangeDzList={}
for posIdx=1,maxPos do
local dzGuidStr=dzList[posIdx]
if dzGuidStr then
teamList[posIdx]=dzGuidStr
local dzGuid=int64.new(dzGuidStr)


local dzState,stateStr=xianjieModel:getDZState(dzGuid,true)
local isOccupy=dzState~=nil
local isInSMD=false
local isInXJYZ=false
if self.isCheckSMDData then
local id=xianjieModel:GetYetDizi(dzGuid)
isInSMD=id~=0 and self.smdId~=id
end
if self.isCheckXJYZData then
isOccupy=false
isInXJYZ=XianJunYanZhenModel:getIsUsedDZ(dzGuid,self.gx_id)
end
if(isOccupy or isInSMD or isInXJYZ)and not self.isOnlyEditTeam then

if not isOccupy and isInSMD then
stateStr="已参战"
end
if not isOccupy and isInXJYZ then
stateStr="已锁定"
end
return UIManager.error(FMT.fmt("存在{0}弟子 无法编入云舟队伍",stateStr))
end

if not self.isIgnoreYz then
local yzDataSelectData=yzDataSelectLookUp[dzGuidStr]
if yzDataSelectData and yzDataSelectData.yzIdx~=yzIdx then

if self.isCheckXJYZData and XianJunYanZhenModel:getIsUsedYZ(yzDataSelectData.yzIdx,self.gx_id)then
return UIManager.error("存在已锁定弟子 无法编入云舟队伍")
end


needChangeDzList[#needChangeDzList+1]={
guidStr=dzGuidStr,
yzIdx=yzDataSelectData.yzIdx,
posIdx=yzDataSelectData.posIdx,
}
end
end
end
end

if not next(needChangeDzList)then
if self.isCheckXJYZData then
if not self.isIgnoreYz then
XianJunYanZhenModel:setXJYZYunZhouDataTeamByYzIdx(yzIdx,teamList)
XianJunYanZhenModel:saveXJYZYunZhouDataList()

UIManager:invokeUIMethod("UIXianJie_YunZhouSelectWin","refresh")
else
UIManager:invokeUIMethod("UIXianJunYanZhen_YunZhouPrepareWin","onDzTeamSelectRecv",teamList)
end
else
if not self.isIgnoreYz then
xianjieModel:setXJYunZhouDataTeamByYzIdx(yzIdx,teamList)
xianjieModel:saveXJYunZhouDataList()

UIManager:invokeUIMethod("UIXianJie_YunZhouSelectWin","refresh")
else
UIManager:invokeUIMethod("UIXianJie_YunZhouPrepareWin","onDzTeamSelectRecv",teamList)
end
end

return self:onBtnClose()
else

local showdata=
{
type='UIDialouge',
title='提示',
content="存在其他云舟队伍弟子\n是否将其替换到该云舟？",
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
if _this.isCheckXJYZData then
XianJunYanZhenModel:removeXJYZYunZhouDataSelectDzByList(needChangeDzList)
XianJunYanZhenModel:setXJYZYunZhouDataTeamByYzIdx(yzIdx,teamList)
XianJunYanZhenModel:saveXJYZYunZhouDataList()
else
xianjieModel:removeXJYunZhouDataSelectDzByList(needChangeDzList)
xianjieModel:setXJYunZhouDataTeamByYzIdx(yzIdx,teamList)
xianjieModel:saveXJYunZhouDataList()
end

UIManager:invokeUIMethod("UIXianJie_YunZhouSelectWin","refresh")
UIManager:invokeUIMethod("UIXianJie_yzTeamSelectWin","onBtnClose")
end,
showclosebtn=true,
}
self.confirmDialog=UIDialogManager.newDialog(showdata)
self.confirmDialog:show()
end
end

