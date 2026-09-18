







def_class("UIXianJie_yzTeamDzSelectWin",UIWindowBase)









function UIXianJie_yzTeamDzSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.roleListPanel=UIObject.get(self,1)
self.noDZTips=UIObject.get(self,2)
self.commitBtn=UIButton.get(self,3)
self.commitBtnText=UIText.get(self,4)
self.filterBtn=UIButton.get(self,5)
self.oneKeyBtn=UIButton.get(self,6)
self.oneKeyBtnText=UIText.get(self,7)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.oneKeyBtn:setButtonClick(function()self:onOneKeyBtn()end)



end


function UIXianJie_yzTeamDzSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.noDZTips);self.noDZTips=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitBtnText);self.commitBtnText=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.oneKeyBtn);self.oneKeyBtn=nil;
_UIObject_release(self.oneKeyBtnText);self.oneKeyBtnText=nil;
end
















local _this
local _maxSelectCount=5
local teamPosType={
eFront=1,
eBack=2,
}
local teamPosTypeIndexLookup={
[1]=teamPosType.eFront,
[2]=teamPosType.eFront,
[3]=teamPosType.eBack,
[4]=teamPosType.eBack,
[5]=teamPosType.eBack,
}




function UIXianJie_yzTeamDzSelectWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJie_yzTeamDzSelectWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJie_yzTeamDzSelectWin:onShow(argtable,afterOnloaded)
self.teamIndex=argtable and argtable.teamIndex
self.parentWin=argtable and argtable.parentWin
self.isOnlyEditTeam=argtable and argtable.isOnlyEditTeam
self.isCheckSMDData=argtable and argtable.isCheckSMDData
self.isCheckXJYZData=argtable and argtable.isCheckXJYZData
self.smdId=argtable and argtable.smdId
self.gx_id=argtable and argtable.gx_id
if not self.teamIndex then
return self.parentWin:onClickClose()
end
self:doFadeIn(0.15,0.5)
if self.isCheckXJYZData then
self.teamData=XianJunYanZhenModel:getXJYZYunZhouTeamDataByTeamIdx(self.teamIndex)or{}
else
self.teamData=xianjieModel:getXJYunZhouTeamDataByTeamIdx(self.teamIndex)or{}
end
local teamDzList=self.teamData.dzList or{}
self.selectList_lookup={}
self.selectList={}
for posIdx,dzGuidStr in pairs(teamDzList)do
if self.isCheckXJYZData then
local isInXJYZ=XianJunYanZhenModel:getIsUsedDZ(dzGuidStr,self.gx_id)
if not isInXJYZ then
self.selectList_lookup[dzGuidStr]=posIdx
self.selectList[posIdx]=dzGuidStr
end
else
self.selectList_lookup[dzGuidStr]=posIdx
self.selectList[posIdx]=dzGuidStr
end
end
self:refresh(true)
end


function UIXianJie_yzTeamDzSelectWin:onHide()

end

function UIXianJie_yzTeamDzSelectWin:doFadeIn(delay,duration)
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

function UIXianJie_yzTeamDzSelectWin:refresh(isInit)
local discipleList=self:getDisciplesList()
local teamSelectLookUp=self:getTeamSelectLookUp()


local dataNum=#discipleList
if isInit then
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,6)
end
local hasDZ=dataNum>0
if hasDZ then
local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local data=discipleList[i]
local netData=data.netData.net
local guid=netData.discipleguid
local discipleguidStr=netData.discipleguidStr
local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
local item=grids[i-1]

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(31,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,chuiwei)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)


local sortType=eDiscipleSortType.eFightSort
local fightValue=discipleLookup:getValueBySortType(guid,sortType)
local desc_str=discipleLookup:getValueDescBySortType(fightValue,sortType,'<color=#7D3B17>{0}</color> {1}')
if sortType~=eDiscipleSortType.eFightSort then
item:SetChildActive(6,false)
item:SetChildText(4,desc_str)
else

item:SetChildActive(6,true)
item:SetChildText(6,desc_str)

item:SetChildText(4,'')
end

item:SetChildActive(8,true)
local state_str
local showBlack=false
local isInOtherTeam=false
local isInSMD=false
local isInXJYZ=false
if self.isCheckSMDData then
local id=xianjieModel:GetYetDizi(guid)
isInSMD=id~=0 and self.smdId~=id
end

local dzState,stateStr=xianjieModel:getDZState(guid,true)
local isOccupy=dzState~=nil
local teamSelectData=teamSelectLookUp[discipleguidStr]
if teamSelectData and teamSelectData.teamIdx~=self.teamIndex then
isInOtherTeam=true
end
if self.isCheckXJYZData then
isOccupy=false
isInXJYZ=XianJunYanZhenModel:getIsUsedDZ(guid,self.gx_id)
end
if isInXJYZ then
state_str="<color=#aae252>已锁定</color>"
elseif isInOtherTeam then

state_str="<color=#aae252>在其他队伍中</color>"
elseif isOccupy and not self.isOnlyEditTeam then
state_str=FMT.fmt("<color=#aae252>{0}</color>",stateStr)
elseif isInSMD then
state_str="<color=#aae252>狩魔队中</color>"
else
state_str=UIDiscipleModel:getDiscipleStateDesc(guid,' ')
end
item:SetChildText(9,state_str)
item:SetChildActive(16,showBlack)



item:SetChildActive(8,not chuiwei and(isInOtherTeam or isOccupy or isInSMD or isInXJYZ))
item:SetChildActive(9,not chuiwei and(isInOtherTeam or isOccupy or isInSMD or isInXJYZ))
item:SetChildActive(12,chuiwei)
item:SetChildActive(13,chuiwei)

local hasOrder=UIDiscipleModel:checkDZHasOrder(guid)
item:SetChildActive(15,hasOrder)

local posIdx=self.selectList_lookup[discipleguidStr]
local isSelect=posIdx~=nil
self:refreshRoleItemSelect(item,i,isSelect,posIdx)

UIDiscipleModel:setDiscipleXianMoBackImage(item,28,netData)


local func=function()
self:OnClickRoleItemCallback(1,i)
end
item:SetChildButtonClick(-1,func,true)
item:SetChildLongTouch(-1,i,0.5,function(...)
self:onLongClickRoleItem(i)
end)
end
end
self.noDZTips:setActive(not hasDZ)


self:refreshBtn()
end

function UIXianJie_yzTeamDzSelectWin:getDisciplesList(isReset)
if not isReset and self.disciplesList then
return self.disciplesList
end


self.sortCondition=xianjieModel:getXJYunZhouTeamDzFilterSortCondition()
local dzSortCondition={}
dzSortCondition[2]=self.sortCondition[1]
if not self.sortCondition[2]then
self.sortCondition[2]={1}
end
local sortType=eSortOrder.eUp
local flag=discipleLookup.getFilterFlagByCondition(self.sortCondition,2,2)
if not flag then
sortType=eSortOrder.eDown
end

local dzList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,dzSortCondition,sortType)

self.disciplesList=dzList
return self.disciplesList
end

function UIXianJie_yzTeamDzSelectWin:getAllDisciplesList()
if self.allDisciplesList then
return self.allDisciplesList
end

local dzList=UIDiscipleModel:getAllDiscipleDataX()
self.allDisciplesList=dzList
return self.allDisciplesList
end

function UIXianJie_yzTeamDzSelectWin:getTeamSelectLookUp(isReset)
if not isReset and self.teamSelectLookUp then
return self.teamSelectLookUp
end

if self.isCheckXJYZData then
self.teamSelectLookUp=XianJunYanZhenModel:getXJYZYunZhouTeamSelectLookUp()
else
self.teamSelectLookUp=xianjieModel:getXJYunZhouTeamSelectLookUp()
end
return self.teamSelectLookUp
end

function UIXianJie_yzTeamDzSelectWin:refreshRoleItemSelect(item,idx,isSelect,posIdx)
if item==nil then
item=self.roleListPanel:getChildScrollViewItemWidget(idx-1)
end
item:SetChildActive(10,isSelect)
if isSelect then
local posIdxType=teamPosTypeIndexLookup[posIdx]
local isFront=posIdxType==teamPosType.eFront
item:SetChildActive(29,isFront)
item:SetChildActive(30,not isFront)
end
end


function UIXianJie_yzTeamDzSelectWin:OnClickRoleItemCallback(clicknum,index)
local data=self.disciplesList[index]
local netData=data.netData.net
local guid=netData.discipleguid
local discipleguidStr=netData.discipleguidStr












local isInSMD=false
local isInXJYZ=false
if self.isCheckSMDData then
local id=xianjieModel:GetYetDizi(guid)
isInSMD=id~=0 and self.smdId~=id
end
if self.isCheckXJYZData then
isInXJYZ=XianJunYanZhenModel:getIsUsedDZ(guid,self.gx_id)
end
if isInSMD then
return UIManager.error("弟子处于其他狩魔队中 无法入队")
end
if isInXJYZ then
return UIManager.error("弟子处于仙军演阵锁定中 无法入队")
end

local posIdx=self.selectList_lookup[discipleguidStr]
local isSelect=posIdx~=nil
local freePosIndex

if isSelect then
self.selectList_lookup[discipleguidStr]=nil
self.selectList[posIdx]=nil
else
freePosIndex=self:getFreePosIndex()
if freePosIndex then
self.selectList_lookup[discipleguidStr]=freePosIndex
self.selectList[freePosIndex]=discipleguidStr
else
return UIManager.error("当前队伍已满")
end
end
isSelect=not isSelect

self:refreshRoleItemSelect(nil,index,isSelect,freePosIndex)
self:refreshBtn()
end

function UIXianJie_yzTeamDzSelectWin:getFreePosIndex()
for posIdx=1,_maxSelectCount do
if not self.selectList[posIdx]then
return posIdx
end
end
return nil
end

function UIXianJie_yzTeamDzSelectWin:refreshBtn()

local num=self:getSelectNum()
local has=num>0



self.commitBtnText:setText(FMT.fmt("布阵({0}/{1})",num,_maxSelectCount))



local isFull=num>=_maxSelectCount
local oneKeyStr=isFull and"一键下阵"or"一键上阵"
self.oneKeyBtnText:setText(oneKeyStr)
end

function UIXianJie_yzTeamDzSelectWin:getSelectNum()
local num=0
for posIdx,guidStr in pairs(self.selectList)do
if guidStr~=nil then
num=num+1
end
end
return num
end

function UIXianJie_yzTeamDzSelectWin:onLongClickRoleItem(index)
local data=self.disciplesList[index]
local netData=data.netData.net
local guid=netData.discipleguid
otherPlayerController:openSelfPlayerDZInfoWin({guid})
end

function UIXianJie_yzTeamDzSelectWin:getConditonFilterEx(sortCondition)
local c=1
local filterName={}
local filterFlag={}

filterName[c]={}
filterName[c][1]='弟子职业'
filterName[c][2]={}
filterName[c][3]=true
filterName[c][4]=false
filterFlag[c]={}
local jobcfgs=cfg_disciplevocationconfig()
for k,v in pairs(jobcfgs)do
if v.id~=nil and not v.hide then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,v.id)
table.insert(filterFlag[c],flag)
end
end
c=c+1
filterName[c]={}
filterName[c][1]='战力排序'
filterName[c][2]={}
filterName[c][3]=false
filterName[c][4]=true
filterFlag[c]={}
local sortTypeList={
{name="从高到低",id=1},
{name="从低到高",id=2}
}
for i,v in ipairs(sortTypeList)do
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,v.id)
table.insert(filterFlag[c],flag)
end

return filterName,filterFlag
end

function UIXianJie_yzTeamDzSelectWin.selectConditionBack(data)
if _this==nil then
return
end
local filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end

xianjieModel:setXJYunZhouTeamDzFilterSortCondition(table.deepCopy(_this.sortCondition))
_this:getDisciplesList(true)
_this:refresh(true)
end




function UIXianJie_yzTeamDzSelectWin:onCommitBtn()
local teamIdx=self.teamIndex
local dzList=self.selectList
local idx
if self.isCheckXJYZData then
idx=XianJunYanZhenModel:setXJYZYunZhouTeamDzListByTeamIdx(teamIdx,dzList)
XianJunYanZhenModel:saveXJYZYunZhouTeamDataList()
else
idx=xianjieModel:setXJYunZhouTeamDzListByTeamIdx(teamIdx,dzList)
xianjieModel:saveXJYunZhouTeamDataList()
end

UIManager:invokeUIMethod("UIXianJie_yzTeamSelectWin","selectTeam",idx,true,true)

self.parentWin:onClickClose()
end

function UIXianJie_yzTeamDzSelectWin:onFilterBtn()
local filterName,filterFlag=self:getConditonFilterEx(self.sortCondition)
self.filterName=filterName
local args={filterName=filterName,filterFlag=filterFlag,confirmCallback=self.selectConditionBack}
self:showWindow('UIXianJie_yzTeamDzFilterWin',args)
end


function UIXianJie_yzTeamDzSelectWin:onOneKeyBtn()
local isFull=true
local teamNum=5
for i=1,teamNum do
if self.selectList[i]==nil then
isFull=false
break
end
end
local teamSelectLookUp=self:getTeamSelectLookUp()
if not isFull then
local isChange=false
local copyList={}
local dzList=self:getAllDisciplesList()
for i=1,teamNum do
if not self.selectList[i]then
copyList={}
local posType=teamPosTypeIndexLookup[i]
for i2,locData in pairs(dzList)do
local netData=locData.netData.net
local dzguid=netData.discipleguid
local dzguid_str=netData.discipleguidStr



local dzState,stateStr=xianjieModel:getDZState(dzguid,true)
local isOccupy=dzState~=nil
local isInSMD=false
local isInXJYZ=false
if self.isCheckSMDData then
local id=xianjieModel:GetYetDizi(dzguid)
isInSMD=id~=0 and self.smdId~=id
end
if self.isCheckXJYZData then
isOccupy=false
isInXJYZ=XianJunYanZhenModel:getIsUsedDZ(dzguid,self.gx_id)
local teamSelectData=teamSelectLookUp[dzguid_str]
if not isInXJYZ and teamSelectData and teamSelectData.teamIdx~=self.teamIndex then
isInXJYZ=true
end
end
if self.isOnlyEditTeam then
isOccupy=false
end








if self.selectList_lookup[dzguid_str]==nil and not isOccupy and not isInSMD and not isInXJYZ then
local fight=UIDiscipleModel:getDiscipleFightValue(dzguid)
local job=UIDiscipleModel:getDiscipleJob(dzguid)
local pospriorty=UIDiscipleModel.getJobPosPriorty(job)
local priIdx=5
for ii,vv in ipairs(pospriorty)do
local posIdxType=teamPosTypeIndexLookup[vv]

if posIdxType==posType then
priIdx=ii
break
end
end
table.insert(copyList,{discipleguid=dzguid,discipleguidStr=dzguid_str,fight=fight,pospriorty=priIdx})
end
end
table.sort(copyList,function(a,b)
if a.pospriorty==b.pospriorty then
return a.fight>b.fight
else
return a.pospriorty<b.pospriorty
end
end)

local dizi=copyList[1]
if dizi then
self.selectList[i]=dizi.discipleguidStr
self.selectList_lookup[dizi.discipleguidStr]=i
isChange=true
end
end
end
if isChange then
self:refresh()

local idx
for _k,_v in ipairs(self.disciplesList)do
local netData=_v.netData.net
local dzguid_str=netData.discipleguidStr
if self.selectList_lookup[dzguid_str]then
idx=_k
break
end
end
if idx then

self.roleListPanel:setChildScrollRectEnable(false)
self.roleListPanel:setChildScrollViewSelectItem(idx,false,false,true)
self.roleListPanel:setChildScrollRectEnable(true)
end
end
else
self.selectList_lookup={}
self.selectList={}
self:refresh()
end
end

