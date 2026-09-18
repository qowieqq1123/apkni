







def_class("UIXianJunYanZhen_YunZhouPrepareWin",UIWindowBase)









function UIXianJunYanZhen_YunZhouPrepareWin:bindComponents()

self.addDzBtn=UIButton.get(self,0)
self.addDzPanel=UIObject.get(self,1)
self.buffDesc=UIText.get(self,2)
self.buffmage=UIImage.get(self,3)
self.buffPanel=UIObject.get(self,4)
self.confirmBtn=UIButton.get(self,5)
self.confirmBtnText=UIText.get(self,6)
self.delDzPanel=UIObject.get(self,7)
self.discipleScrollView=UIObject.get(self,8)
self.fightText=UIText.get(self,9)
self.loseDesc=UIText.get(self,10)
self.mbg=UIObject.get(self,11)
self.mbg2=UIObject.get(self,12)
self.mBuff=UIObject.get(self,13)
self.monsterModel=UIObject.get(self,14)
self.monsterName=UIText.get(self,15)
self.monsterNameBg=UIObject.get(self,16)
self.monsterPanel=UIObject.get(self,17)
self.paibuBtn=UIButton.get(self,18)
self.progressBarHp=UIProgress.get(self,19)
self.root=UIObject.get(self,20)
self.selectCntSliderPanel=UIObject.get(self,21)
self.singleFight=UIObject.get(self,22)
self.soldierCountText=UIText.get(self,23)
self.soldierLock=UIObject.get(self,24)
self.speTipsPanel=UIObject.get(self,25)
self.targetFightIcon=UIImage.get(self,26)
self.teamScrollView=UIObject.get(self,27)
self.tipsDesc=UIText.get(self,28)

self.addDzBtn:setButtonClick(function()self:onAddDzBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.paibuBtn:setButtonClick(function()self:onPaibuBtn()end)



end


function UIXianJunYanZhen_YunZhouPrepareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addDzBtn);self.addDzBtn=nil;
_UIObject_release(self.addDzPanel);self.addDzPanel=nil;
_UIObject_release(self.buffDesc);self.buffDesc=nil;
_UIObject_release(self.buffmage);self.buffmage=nil;
_UIObject_release(self.buffPanel);self.buffPanel=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.confirmBtnText);self.confirmBtnText=nil;
_UIObject_release(self.delDzPanel);self.delDzPanel=nil;
_UIObject_release(self.discipleScrollView);self.discipleScrollView=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.loseDesc);self.loseDesc=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mbg2);self.mbg2=nil;
_UIObject_release(self.mBuff);self.mBuff=nil;
_UIObject_release(self.monsterModel);self.monsterModel=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.monsterNameBg);self.monsterNameBg=nil;
_UIObject_release(self.monsterPanel);self.monsterPanel=nil;
_UIObject_release(self.paibuBtn);self.paibuBtn=nil;
_UIObject_release(self.progressBarHp);self.progressBarHp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectCntSliderPanel);self.selectCntSliderPanel=nil;
_UIObject_release(self.singleFight);self.singleFight=nil;
_UIObject_release(self.soldierCountText);self.soldierCountText=nil;
_UIObject_release(self.soldierLock);self.soldierLock=nil;
_UIObject_release(self.speTipsPanel);self.speTipsPanel=nil;
_UIObject_release(self.targetFightIcon);self.targetFightIcon=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
_UIObject_release(self.tipsDesc);self.tipsDesc=nil;
end
















local _this
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
panel=10,
state=11,
tianminObj=12,
banFlag=13,
ban=14,
leaderFlag=15,
back_xianmo=16,
spDzFlag=17,
}

local _teamItemCmpIndex={
bg=0,
select=1,
name=2,
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




function UIXianJunYanZhen_YunZhouPrepareWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJunYanZhen_YunZhouPrepareWin:__delete()
self:unbindComponents()
XianJunYanZhenModel:saveXJYZYunZhouDataList()
_this=nil
end




function UIXianJunYanZhen_YunZhouPrepareWin:onShow(argtable,afterOnloaded)
self.gx_id=argtable.gx_id
self.mon_groub_idx=argtable.mon_groub_idx
self.conf=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.gx_id)
local canTz=XianJunYanZhenModel:getGxCanTz(self.gx_id)
self.isHasSpe=self.conf.spe_cond~=nil and not canTz

self.isMultiBattle=self.conf.multi_battle_mon_id~=nil and self.conf.multi_battle_mon_id[self.mon_groub_idx]~=nil
self.cancelCallBack=argtable.cancelCallBack
self.enterTxt=argtable and argtable.enterTxt
self.callback=argtable and argtable.callback
self.minDzNum=argtable and argtable.minDzNum
self.maxDzNum=argtable and argtable.maxDzNum
self.usedSoldierList=argtable and argtable.usedSoldierList
self.confirmBtnStr=argtable and argtable.confirmBtnStr or"出战"
self.targetFight=argtable and argtable.targetFight

self.canTzOtherMonsterNum=0
local monsterLen=#self.conf.mon_groub_list
for i=1,monsterLen do
if i~=self.mon_groub_idx then
local isKill=XianJunYanZhenModel:getIsKill(self.gx_id,i)
local usedData=XianJunYanZhenModel:getUsedData(i,self.gx_id)
if not isKill and not usedData then
self.canTzOtherMonsterNum=self.canTzOtherMonsterNum+1
end
end
end

local monster=self.conf.mon_groub_list[self.mon_groub_idx]
local monsterId=monster[1]
self.minTeamNum=monster[2]
local dzBuffs=monster[3]
local monsterBuffs=monster[4]
local buffTxt=monster[5]or"加成说明"
local buffType=monster[6]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)

local usedTotleXSCount=0
for soldierIdx,count in pairs(self.usedSoldierList)do
if count>0 then
usedTotleXSCount=usedTotleXSCount+count
end
end
if self.conf.max_xiushi_cnt then
self.maxSoldierNum=self.conf.max_xiushi_cnt-usedTotleXSCount
end
for soldierIdx,count in pairs(self.conf.team_xiushi)do
if soldierIdx then
self.minSoldierNum=count
self.minSoldierIdx=soldierIdx
break
end
end

local otherTeamLen=#self.conf.mon_groub_list-1
self.yzBoatDataList=XianYunGangModel:getBoatList()or defaultT
self.maxYunZhouCount=#self.yzBoatDataList-otherTeamLen
self.selectTeamIndex=1

self.yzDataList={}
self.yzUsedLookup={}
local used_data=XianJunYanZhenModel:getUsedData(self.mon_groub_idx,self.gx_id)
if used_data~=nil then
for i=1,used_data.boat_len do
local yzid=used_data.boatList[i]
self.yzDataList[i]={}
self.yzDataList[i].yzid=yzid
self.yzDataList[i].soldierSelectList={}
self.yzUsedLookup[yzid]=i

local xiushiList=used_data.xiushiList[i]
for ii=1,xiushiList.len do
local soldierIdx=xiushiList.list[ii].param_1
local count=xiushiList.list[ii].param_2
self.yzDataList[i].soldierSelectList[soldierIdx]=count
end

self:refreshTeamDzList(i,true)
end
self.maxYunZhouCount=used_data.boat_len
else
if self.maxYunZhouCount<self.minTeamNum then
self.maxYunZhouCount=self.minTeamNum
end
end

self.mapId=monsterCfg.mapId or 0


self:refreshYunZhouList()

self:refresh()

local hasDzBuff=dzBuffs~=nil and next(dzBuffs)~=nil
local hasmonsterBuff=monsterBuffs~=nil and next(monsterBuffs)~=nil
local hasBuff=hasDzBuff or hasmonsterBuff
self.buffPanel:setActive(hasBuff)
if hasBuff then
local abname="ui/windows/xianjunyanzhen/xianjunyanzhen_atlas_pak.ab"
local iconname
if hasDzBuff then
if buffType==1 then
iconname="image_xianjunyanzhen_jt02"
else
iconname="image_xianjunyanzhen_jt01"
end
else
iconname="image_xianjunyanzhen_boss01"
end
self.buffmage:setCSImageSprite(abname,iconname)
self.buffDesc:setText(buffTxt)
end

if afterOnloaded then
local isKill,hp,maxHp=XianJunYanZhenModel:getIsKill(self.gx_id,self.mon_groub_idx)
self.monsterPanel:setActive(not isKill)
if not isKill then
local modelParams=comHelper.getMonsterGroupModelParams(monsterId)
local scales=cfgHelper.get3(cfg_dbbodyconfig_get,modelParams.body,'scales2',28)or{1,0,0}
self.monsterModel:setChildUIModelShowTarget(modelParams.body,scales[1]or 1,modelParams.componets or defaultT,eAnimationID.stand)
self.winlua:SetChildLocalPos(self.monsterModel:getID(),scales[2]or 0,scales[3]or 0,0)
self.monsterName:setText(monsterCfg.name)
end

self.loseDesc:setActive(used_data~=nil and not isKill)

self.mBuff:setActive(hasBuff)
if hasBuff then
self.mBuff:setChildUIModelShowTarget(772162,1,{},eAnimationID.enter)
end

if isKill then
self.mbg:setChildUIModelShowTarget(772161,1,{},eAnimationID.enter)
self.mbg2:setActive(false)
else
self.mbg2:setActive(true)
self.mbg:setChildUIModelShowTarget(772160,1,{},eAnimationID.enter)
self.mbg2:setChildUIModelShowTarget(772159,1,{},eAnimationID.enter)
end
self.root:setChildCanvasGroupAlpha(0)
self.monsterPanel:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
self.monsterPanel:setChildCanvasGroupDOFade(1,0.2)
end)
end
end


function UIXianJunYanZhen_YunZhouPrepareWin:onHide()

end

function UIXianJunYanZhen_YunZhouPrepareWin:refresh()


self:refreshTopPanel()


self:refreshBottomPanel(true)
end

function UIXianJunYanZhen_YunZhouPrepareWin:refreshYunZhouList()
self.teamScrollView:setActive(self.isMultiBattle)
if not self.isMultiBattle then
local isAutoFree=not self.yzDataList[1]or not next(self.yzDataList[1])
self.yzDataList[1]=self.yzDataList[1]or{}

if isAutoFree then

local freeYzId=XianJunYanZhenModel:getXJYZFreeAndHasTeamYzIndex(self.gx_id)
if not self.isHasSpe and freeYzId then
self.yzDataList[1].yzid=freeYzId
self.yzUsedLookup[freeYzId]=1

self:refreshTeamDzList(1)
end
end
return
end
self.teamScrollView:setChildScrollViewCreateGrids(self.maxYunZhouCount,1)
local grids=self.teamScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local isAutoFree=not self.yzDataList[i]or not next(self.yzDataList[i])
self.yzDataList[i]=self.yzDataList[i]or{}
if isAutoFree then

local freeYzId=XianJunYanZhenModel:getXJYZFreeAndHasTeamYzIndex(self.gx_id,self.yzUsedLookup)
if not self.isHasSpe and freeYzId then
self.yzDataList[i].yzid=freeYzId
self.yzUsedLookup[freeYzId]=i

self:refreshTeamDzList(i)
end
end

local isSelect=self.selectTeamIndex==i


widget:SetChildActive(_teamItemCmpIndex.bg,not isSelect)
widget:SetChildActive(_teamItemCmpIndex.select,isSelect)

widget:SetChildText(_teamItemCmpIndex.name,FMT.fmt("第{0}队",i))


widget:SetChildButtonClick(_teamItemCmpIndex.bg,function()
if _this==nil then return end
_this:selectTeam(i)
end,true)
end
end

function UIXianJunYanZhen_YunZhouPrepareWin:selectTeam(teamidx)
if self.selectTeamIndex==teamidx then
return
end
local grids=self.teamScrollView:getChildScrollViewItemWidgets()
local old_widget=grids[self.selectTeamIndex-1]
old_widget:SetChildActive(_teamItemCmpIndex.bg,true)
old_widget:SetChildActive(_teamItemCmpIndex.select,false)

local widget=grids[teamidx-1]
widget:SetChildActive(_teamItemCmpIndex.bg,false)
widget:SetChildActive(_teamItemCmpIndex.select,true)

self.selectTeamIndex=teamidx
self:refresh()
end

function UIXianJunYanZhen_YunZhouPrepareWin:refreshTopPanel()
local yzData=self.yzDataList[self.selectTeamIndex]or defaultT
local teamDzList=yzData.teamDzList

local dzFightList={}
if teamDzList and next(teamDzList)then
for i,v in ipairs(teamDzList)do
local dzGuidStr=tostring(v.dzGuid)
local fightValue=UIDiscipleModel:getDiscipleFightValue(v.dzGuid)
dzFightList[dzGuidStr]=fightValue
end
end
local soldierSelectList=yzData.soldierSelectList
local soldierList={}
if soldierSelectList and next(soldierSelectList)then
for soldierIdx,count in pairs(soldierSelectList)do
soldierList[soldierIdx]=count
end
end
local jzAttrList={}
local yzId=yzData.yzid
if yzId then
local yzAttrLookUp=XianYunGangModel:getYunZhouComponentsAttrsLookup(yzId)
for attrId,value in pairs(yzAttrLookUp)do
jzAttrList[attrId]=value
end
end

local attrTypeList={
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
}

local sceneIdx=xianjieModel:getSceneIndex()
for i,attrType in ipairs(attrTypeList)do
local value=xianjieModel:getJZAttrLookup(attrType,sceneIdx)
if value then
if jzAttrList[attrType]then
jzAttrList[attrType]=jzAttrList[attrType]+value
else
jzAttrList[attrType]=value
end
end
end

local fightValue=xianjieModel:getXJYZTeamFightValue(dzFightList,soldierList,jzAttrList)
self.fightText:setText(mathHelper.formatNumber3(fightValue))

local isKill,hp,maxHp=XianJunYanZhenModel:getIsKill(self.gx_id,self.mon_groub_idx)
if not isKill then
if self.isMultiBattle then
self.progressBarHp:setActive(true)
self.targetFightIcon:setActive(false)
self.progressBarHp:setProgress(hp or 0,maxHp or 100)

self.progressBarHp:setChildProgressText(FMT.fmt("{0}%",hp or 0))
else
self.progressBarHp:setActive(false)
self.targetFightIcon:setActive(self.targetFight~=nil and fightValue>0)
if self.targetFight~=nil and fightValue>0 then
local icon
local abname="ui/windows/xianjunyanzhen/xianjunyanzhen_atlas_pak.ab"
if self.targetFight<fightValue*0.7 then
icon="image_chuzhanbuzhen_bkyj"
elseif self.targetFight<=fightValue*1.2 then
icon="image_chuzhanbuzhen_sjld"
else
icon="image_chuzhanbuzhen_bkld"
end
self.targetFightIcon:setCSImageSprite(abname,icon)
end
end
else
self.targetFightIcon:setActive(false)
self.progressBarHp:setActive(false)
end
end

function UIXianJunYanZhen_YunZhouPrepareWin:refreshBottomPanel(isInit)

local yzData=self.yzDataList[self.selectTeamIndex]
local teamDzList=yzData.teamDzList or defaultT
local usedData=XianJunYanZhenModel:getUsedData(self.mon_groub_idx,self.gx_id)
local isSuoDin=usedData~=nil and next(usedData)~=nil

local dzCount=#teamDzList
local addDzFightValue=0
self.discipleScrollView:setChildSizeDelta(dzCount*150+20,210)
self.discipleScrollView:setChildScrollViewCreateGrids(dzCount,dzCount)
local grids=self.discipleScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local teamDzData=teamDzList[i]
local guid=teamDzData.dzGuid
local netdata=UIDiscipleModel:getDiscipleData(guid)

widget:SetChildText(_dzItemCmpIndex.name,UIDiscipleModel:getDiscipleName(guid))

local fightValue=UIDiscipleModel:getDiscipleFightValue(guid)
addDzFightValue=addDzFightValue+fightValue
widget:SetChildText(_dzItemCmpIndex.fight,FMT.fmt('<color=#7d3b17>战</color> {0}',fightValue))


if isSuoDin then

widget:SetChildText(_dzItemCmpIndex.stateName,"已锁定")
widget:SetChildActive(_dzItemCmpIndex.banFlag,true)
else
widget:SetChildActive(_dzItemCmpIndex.banFlag,false)
end

comHelper.setChildModelRawImage(widget,guid,_dzItemCmpIndex.head,0,eHeadCenterType.eHalf)

local color=UIDiscipleModel:getDiscipleColor(guid)
widget:SetChildCSImageSprite(_dzItemCmpIndex.color,diziabname,ColorToFrame[color])

local jobIcon=UIDiscipleModel:getJobIconNameX(guid)
widget:SetChildCSImageSprite(_dzItemCmpIndex.job,globalab,jobIcon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
widget:SetChildActive(_dzItemCmpIndex.spDzFlag,isSpDz)

UIDiscipleController.refreshCommonItemTianMing(widget,netdata,_dzItemCmpIndex.tianminObj)

UIDiscipleModel:setDiscipleXianMoBackImage(widget,_dzItemCmpIndex.back_xianmo,netdata)


widget:SetChildActive(_dzItemCmpIndex.leaderFlag,false)


widget:SetChildButtonClick(_dzItemCmpIndex.panel,function()
if not _this then return end
if isSuoDin then return end

return self:onChangeTeamBtn()
end)
end


self:refreshSoldierCount()

self.confirmBtnText:setText(self.confirmBtnStr)


local isHasDz=isSuoDin or dzCount>0
self.selectCntSliderPanel:setActive(isHasDz)
self.singleFight:setActive(isHasDz)
self.addDzPanel:setActive(not isHasDz and not self.isHasSpe)
self.tipsDesc:setActive(not isHasDz)
self.speTipsPanel:setActive(self.isHasSpe)
self.delDzPanel:setActive(isSuoDin and dzCount<=0)

self.soldierLock:setActive(isSuoDin)
self.paibuBtn:setActive(not isSuoDin)
self.confirmBtn:setActive(not isSuoDin)
end

function UIXianJunYanZhen_YunZhouPrepareWin:onYunZhouTeamDZUpdateRecv(yzid)
if XianJunYanZhenModel:getIsUsedYZ(yzid,self.gx_id)then
UIManager.error('云舟已出征')
return
end
local pos=self.yzUsedLookup[yzid]
if pos then
self:refreshTeamDzList(pos)
if pos==self.selectTeamIndex then
self:refreshTeamDzList()
self:refresh()
end
end
end

function UIXianJunYanZhen_YunZhouPrepareWin:onYunZhouTeamSelectRecv(yzid)
if XianJunYanZhenModel:getIsUsedYZ(yzid,self.gx_id)then
UIManager.error('云舟已出征')
return
end
local pos=self.yzUsedLookup[yzid]
local oldyzid=self.yzDataList[self.selectTeamIndex].yzid
if pos then
self.yzDataList[pos].yzid=oldyzid
if oldyzid then
self.yzUsedLookup[oldyzid]=pos
end
self:refreshTeamDzList(pos)
elseif oldyzid then
self.yzUsedLookup[oldyzid]=nil
end
self.yzDataList[self.selectTeamIndex].yzid=yzid
self.yzUsedLookup[yzid]=self.selectTeamIndex

self:refreshTeamDzList()
self:refresh()
end

function UIXianJunYanZhen_YunZhouPrepareWin:onPaiBuSetSelectListRecv(list)
for i,v in pairs(self.yzDataList)do
local yzIdx=self.yzDataList[i].yzid
self.yzDataList[i].soldierSelectList=table.weakCopy(list[i])or{}
XianJunYanZhenModel:setXJYZYunZhouDataSoldierByYzIdx(yzIdx,list[i])
end

self:refreshSoldierCount()
self:refreshTopPanel()
XianJunYanZhenModel:saveXJYZYunZhouDataList()
end

function UIXianJunYanZhen_YunZhouPrepareWin:refreshSoldierCount()

local soldierSelectList=self.yzDataList[self.selectTeamIndex].soldierSelectList or defaultT

local allSoldierCount=0
for soldierIdx,count in pairs(soldierSelectList)do
if count>0 then
allSoldierCount=allSoldierCount+count
end
end

self.soldierCountText:setText(mathHelper.formatNumber4(allSoldierCount,1))
end

function UIXianJunYanZhen_YunZhouPrepareWin:onDzTeamSelectRecv(teamList)
self:refreshTeamDzList()
self:refresh()
end

function UIXianJunYanZhen_YunZhouPrepareWin:refreshTeamDzList(i,isUsed)
local idx=i or self.selectTeamIndex
local yzData
local yzid=self.yzDataList[idx].yzid
if yzid then

yzData=XianJunYanZhenModel:getXJYZYunZhouDataByYzIdx(yzid)
end

local teamDzList={}
local lookup={}

local teamDzList_lookup=yzData and yzData.team or nil
local hasTeam=teamDzList_lookup~=nil and next(teamDzList_lookup)~=nil
if hasTeam then
for idx,dzGuidStr in pairs(teamDzList_lookup)do
local dzGuid=int64.new(dzGuidStr)
teamDzList[#teamDzList+1]={
posIdx=idx,
dzGuid=dzGuid,
}
lookup[idx]=dzGuidStr
end
end

self.yzDataList[idx].teamDzList=teamDzList
self.yzDataList[idx].teamDzList_lookup=lookup

if not isUsed then
self:refreshSoldierList(idx)
end
end

function UIXianJunYanZhen_YunZhouPrepareWin:refreshSoldierList(i)
local idx=i or self.selectTeamIndex
self:getCurSoldierList(idx)
local yzData
local yzid=self.yzDataList[idx].yzid
if yzid then

yzData=XianJunYanZhenModel:getXJYZYunZhouDataByYzIdx(yzid)
end
local soldierList={}
local soldierList_lookup=yzData and yzData.soldier or nil
local hasSoldier=soldierList_lookup~=nil and next(soldierList_lookup)~=nil


local tsdMaxUseCount=xianjieModel:getJiJieAddCount()
local maxSelectCount
if tsdMaxUseCount then
local teamDzList=self.yzDataList[idx].teamDzList
local dzCount=#teamDzList
maxSelectCount=math.min(self.allSoldierCount[idx],tsdMaxUseCount*dzCount)
else
maxSelectCount=self.allSoldierCount[idx]
end
if hasSoldier then
local totleCount=0
local soldierIdxLookup={}
for soldierIdx,count in pairs(soldierList_lookup)do
table.insert(soldierIdxLookup,soldierIdx)
end
table.sort(soldierIdxLookup,function(a,b)
return a>b
end)
for i,soldierIdx in ipairs(soldierIdxLookup)do
local count=soldierList_lookup[soldierIdx]
if self.soldierCountList[idx][soldierIdx]<count then
count=self.soldierCountList[idx][soldierIdx]
end
if totleCount+count>maxSelectCount then
count=maxSelectCount-totleCount
end
if count>0 then
soldierList[soldierIdx]=count
totleCount=totleCount+count
end
end
end

self.yzDataList[idx].soldierSelectList=soldierList

XianJunYanZhenModel:setXJYZYunZhouDataSoldierByYzIdx(yzid,soldierList)
end

function UIXianJunYanZhen_YunZhouPrepareWin:getCurSoldierList(teamIdx)
if not self.isMultiBattle and self.soldierCountList~=nil and self.soldierCountList[teamIdx]~=nil then
return
end
local usedSoldierList=table.weakCopy(self.usedSoldierList)or{}
local yzSoldierList={}
for i,v in pairs(self.yzDataList)do
yzSoldierList[i]=self.yzDataList[i].soldierSelectList or{}
end
local otherTeamTotleXSCount=0
if yzSoldierList and#yzSoldierList>0 then
for i,soldierSelectList in ipairs(yzSoldierList)do
if teamIdx~=i then
for soldierIdx,count in pairs(soldierSelectList)do
usedSoldierList[soldierIdx]=(usedSoldierList[soldierIdx]or 0)+count
otherTeamTotleXSCount=otherTeamTotleXSCount+count
end
end
end
end

local soldierCountList,allSoldierCount

local canUseXSList=XianJunYanZhenModel:getCanUseXSList(self.gx_id)
local isHasCanUseXS=canUseXSList and next(canUseXSList)~=nil
if isHasCanUseXS then
soldierCountList,allSoldierCount=yunjiayingModel:getSoldierCountEx(canUseXSList,usedSoldierList,self.minSoldierIdx)
else
soldierCountList,allSoldierCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy,nil,usedSoldierList,self.minSoldierIdx)
end
self.soldierCountList=self.soldierCountList or{}
self.allSoldierCount=self.allSoldierCount or{}
self.soldierCountList[teamIdx]=soldierCountList

if self.maxSoldierNum then
local max=self.maxSoldierNum-otherTeamTotleXSCount
if max<0 then
max=0
end
self.allSoldierCount[teamIdx]=math.min(max,allSoldierCount)
else
self.allSoldierCount[teamIdx]=allSoldierCount
end
end






function UIXianJunYanZhen_YunZhouPrepareWin:onConfirmBtn()
local len=#self.yzDataList
if self.isMultiBattle and len<self.minTeamNum then
return UIManager.error(FMT.fmt("车轮战至少出战{0}支队伍",self.minTeamNum))
end

local boatList={}
local xiushiList={}
local teamList={}
local errStr
local allSoldierCount=0


for i,v in ipairs(self.yzDataList)do
local teamDzList=v.teamDzList or defaultT


if#teamDzList<=0 then

if len>1 then
errStr=FMT.fmt("请选择第{0}队的出战弟子",i)
self:selectTeam(i)
else
errStr="请选择出战弟子"
end
return UIManager.error(errStr)
end
local teamDzList_lookup=v.teamDzList_lookup or defaultT
if not next(teamDzList_lookup)then
if len>1 then
errStr=FMT.fmt("请选择第{0}队的出战弟子",i)
self:selectTeam(i)
else
errStr="请选择出战弟子"
end
return UIManager.error(errStr)
end

local dzCount=0
local dzGuidList={}
for k=1,5 do
local guidStr=teamDzList_lookup[k]
local guid
if not guidStr or guidStr==""then
guid=Int64_0
else
guid=int64.new(guidStr)

local isOccupy=XianJunYanZhenModel:getIsUsedDZ(guid,self.gx_id)
if isOccupy then
if len>1 then
errStr=FMT.fmt("第{0}队存在已锁定弟子，无法出征",i)
self:selectTeam(i)
else
errStr="队伍中存在已锁定弟子，无法出征"
end
return UIManager.error(errStr)
end
dzCount=dzCount+1
end
table.insert(dzGuidList,{eTeamEntityType.dizi,guid})
end
table.insert(teamList,{#dzGuidList,dzGuidList,{self.mapId,0}})

if self.minDzNum and dzCount<self.minDzNum then
if len>1 then
errStr=FMT.fmt("第{0}队上阵弟子不足{1}名",i,self.minDzNum)
self:selectTeam(i)
else
errStr=FMT.fmt("最少上阵{0}名弟子",self.minDzNum)
end
return UIManager.error(errStr)
end
if self.maxDzNum and dzCount>self.maxDzNum then
if len>1 then
errStr=FMT.fmt("第{0}队上阵弟子超过{1}名",i,self.maxDzNum)
self:selectTeam(i)
else
errStr=FMT.fmt("最多上阵{0}名弟子",self.maxDzNum)
end
return UIManager.error(errStr)
end
end

local canUseXSList=XianJunYanZhenModel:getCanUseXSList(self.gx_id)
local isHasCanUseXS=canUseXSList and next(canUseXSList)~=nil

for i,v in ipairs(self.yzDataList)do
local soldierSelectList=v.soldierSelectList or defaultT
local soldierCfgList=cfg_fairylandsoldierconfig()
local moneyList={}
local curAllSoldierCount=0
for soldierIdx,count in pairs(soldierSelectList)do
local cfg=soldierCfgList[soldierIdx]
if cfg and count>0 then
if isHasCanUseXS then
moneyList[#moneyList+1]={soldierIdx,count}
curAllSoldierCount=curAllSoldierCount+count
else
local moneyType=cfg.money[xjSoldierHurtType.eHealthy]

local hasCount=itemsModel.getCount(moneyType)
if hasCount>=count then
moneyList[#moneyList+1]={soldierIdx,count}
curAllSoldierCount=curAllSoldierCount+count
else
self.yzDataList[i].soldierSelectList={}
self:refreshSoldierCount()
if len>1 then
errStr=FMT.fmt("请选择第{0}队的随队修士",i)
self:selectTeam(i)
else
errStr="请选择随队修士"
end
self:onPaibuBtn()
return UIManager.error(errStr)
end
end
end
end
allSoldierCount=allSoldierCount+curAllSoldierCount
table.insert(xiushiList,{#moneyList,moneyList})

if self.minSoldierNum and curAllSoldierCount<self.minSoldierNum then
if len>1 then
errStr=FMT.fmt("请选择第{0}队的随队修士",i)
self:selectTeam(i)
else
errStr="请选择随队修士"
end
self:onPaibuBtn()
return UIManager.error(errStr)
end

if self.maxSoldierNum and allSoldierCount>self.maxSoldierNum then
local max=mathHelper.formatNumber4(self.maxSoldierNum,1)
return UIManager.error(FMT.fmt("最多选择{0}个修士",max))
end

local yzId=v.yzid
if not yzId then
if len>1 then
errStr=FMT.fmt("请选择第{0}队的云舟",i)
self:selectTeam(i)
else
errStr="请选择云舟"
end
return UIManager.error(errStr)
end

table.insert(boatList,yzId)
end

if _this.callback then
local cb=_this.callback
cb(teamList,xiushiList,boatList)
return _this:onCloseFunc()
end
end



function UIXianJunYanZhen_YunZhouPrepareWin:onChangeTeamBtn()
local yzBoatDataList={}
local canUseYZNum=0
local list=XianYunGangModel:getBoatList()or{}
for i,v in ipairs(list)do
v.sortTag=v.boatid
local isUsedYZ=XianJunYanZhenModel:getIsUsedYZ(v.boatid,self.gx_id)
if isUsedYZ then
v.sortTag=v.boatid+10000
elseif not self.yzUsedLookup[v.boatid]or self.yzUsedLookup[v.boatid]==self.selectTeamIndex then
canUseYZNum=canUseYZNum+1
end
table.insert(yzBoatDataList,v)
end
if canUseYZNum==0 then
UIManager.error("暂无空闲云舟，请前往仙云港建造")
return
end
table.sort(yzBoatDataList,function(a,b)return a.sortTag<b.sortTag end)

local yzData=self.yzDataList[self.selectTeamIndex]
local selectYzIndex
for i,v in ipairs(yzBoatDataList)do
if v.boatid==yzData.yzid then
selectYzIndex=i
break
end
end

local args={
isCheckXJYZData=true,
isIgnoreYzOccupy=true,
yzUsedLookup=self.yzUsedLookup,
selectYzIndex=selectYzIndex,
curTeamIndex=self.selectTeamIndex,
gx_id=self.gx_id,
yzBoatDataList=yzBoatDataList,
}
local isHasYunZhou=xianjieModel:checkXJHasYunZhou()
if not isHasYunZhou then
UIManager.error("当前没有可用云舟")
local cb=function()
if not _this then return end
_this.cancelCallBack=nil
return _this:onCloseFunc()
end

return jumpManager:jump({id=JUMP_TYPE.eBuilding,args={
type=SLG_SYSTEM_TYPE.eXianYunGang,
mapid=mapIdType.fort,
scenetype=eSceneType.eZongmen
}},cb)
end

self:showWindow("UIXianJie_YunZhouSelectWin",args)
end



function UIXianJunYanZhen_YunZhouPrepareWin:onPaibuBtn()
local len=#self.yzDataList
local errStr=""
for i,v in ipairs(self.yzDataList)do
local teamDzList=v.teamDzList or defaultT
if#teamDzList<=0 then

if len>1 then
errStr=FMT.fmt("请选择第{0}队的出战弟子",i)
self:selectTeam(i)
else
errStr="请选择出战弟子"
end
return UIManager.error(errStr)
end
local yzId=v.yzid
if not yzId then
if len>1 then
errStr=FMT.fmt("请选择第{0}队的云舟",i)
self:selectTeam(i)
else
errStr="请选择云舟"
end
return UIManager.error(errStr)
end
end

local selectTeamIndex=self.selectTeamIndex
local yzSoldierList={}
local dzCountList={}
for i,yzData in pairs(self.yzDataList)do
yzSoldierList[i]=yzData.soldierSelectList or{}
dzCountList[i]=yzData.teamDzList and#yzData.teamDzList or 0
end
local selectList=yzSoldierList[selectTeamIndex]
local maxSoldierNum=self.maxSoldierNum
local minSoldierIdx=self.minSoldierIdx
local minSoldierNum=self.minSoldierNum
local usedSoldierList=self.usedSoldierList
local gxMaxSoldierNum=self.conf.max_xiushi_cnt
local canTzOtherMonsterNum=self.canTzOtherMonsterNum
local canUseXSList=XianJunYanZhenModel:getCanUseXSList(self.gx_id)

self:showWindow("UIXianJie_yzSoldierPaiBuWin",{
yzSoldierList=yzSoldierList,
selectTeamIndex=selectTeamIndex,
selectList=selectList,
minSoldierIdx=minSoldierIdx,
minSoldierNum=minSoldierNum,
usedSoldierList=usedSoldierList,
dzCountList=dzCountList,
maxSoldierNum=maxSoldierNum,
gxMaxSoldierNum=gxMaxSoldierNum,
canUseXSList=canUseXSList,
canTzOtherMonsterNum=canTzOtherMonsterNum,
isXJYZSet=true,
})
end

function UIXianJunYanZhen_YunZhouPrepareWin:onCloseFunc()
if self and not self.isClose then
self:onCancelFunc()
end
end

function UIXianJunYanZhen_YunZhouPrepareWin:onCancelFunc()
local cb=self.cancelCallBack
UIManager:closeWindow('UIXianJunYanZhen_YunZhouPrepareWin')
if cb then
cb()
end
end

function UIXianJunYanZhen_YunZhouPrepareWin:onAddDzBtn()
return self:onChangeTeamBtn()
end