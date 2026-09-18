







def_class("UIXM_ZZSH_resourceDiZiWin",UIWindowBase)









function UIXM_ZZSH_resourceDiZiWin:bindComponents()

self.mask=UIButton.get(self,0)
self.back=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.jiuzhiAllBtn=UIButton.get(self,3)
self.ruleBtn=UIButton.get(self,4)
self.selectTeamBtn=UIButton.get(self,5)
self.commitBtn=UIButton.get(self,6)
self.onkeyBtn=UIButton.get(self,7)
self.teamGrid=UIObject.get(self,8)
self.resRateTxt=UIText.get(self,9)
self.ruleSelect=UIObject.get(self,10)
self.onkeyBtnTxt=UIText.get(self,11)
self.resProgressTxt=UIText.get(self,12)
self.resProgress2Txt=UIText.get(self,13)
self.itemGridPanel=UIObject.get(self,14)
self.chooseBox=UIToggleButton.get(self,15)
self.chooseText=UIText.get(self,16)

self.mask:setButtonClick(function()self:onMask()end)

self.jiuzhiAllBtn:setButtonClick(function()self:onJiuzhiAllBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.selectTeamBtn:setButtonClick(function()self:onSelectTeamBtn()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.onkeyBtn:setButtonClick(function()self:onOnkeyBtn()end)



end


function UIXM_ZZSH_resourceDiZiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.jiuzhiAllBtn);self.jiuzhiAllBtn=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.selectTeamBtn);self.selectTeamBtn=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.onkeyBtn);self.onkeyBtn=nil;
_UIObject_release(self.teamGrid);self.teamGrid=nil;
_UIObject_release(self.resRateTxt);self.resRateTxt=nil;
_UIObject_release(self.ruleSelect);self.ruleSelect=nil;
_UIObject_release(self.onkeyBtnTxt);self.onkeyBtnTxt=nil;
_UIObject_release(self.resProgressTxt);self.resProgressTxt=nil;
_UIObject_release(self.resProgress2Txt);self.resProgress2Txt=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
_UIObject_release(self.chooseBox);self.chooseBox=nil;
_UIObject_release(self.chooseText);self.chooseText=nil;
end
















local body_id={
back=2016,
}
local _this
local teamNum=5
local singleH=204
local itemPanelH=447

function UIXM_ZZSH_resourceDiZiWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_resourceDiZiWin:__delete()
local flag=self.chooseBox:getToggle()
local allow=userActorSetting.get('UIXM_ZZSH_resourceDiZiWin_Toggle',true)
if flag==not allow then
userActorSetting.set('UIXM_ZZSH_resourceDiZiWin_Toggle',flag)
userActorSetting.flush()
end
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_resourceDiZiWin:onHide()

end




function UIXM_ZZSH_resourceDiZiWin:onShow(argtable,afterOnloaded)
self.qbGuid=argtable.qbGuid
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local cfg=qbData:getCfg()
self.moneyType=cfg.moneytype
self.selectLookup={}
self.selectList={}
local cb=function()
self:onLoadFinish()
end
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.back:setChildUIModelShowTarget(body_id.back,1,{},eAnimationID.common_window_enter,false,false,0,cb)
else
self.root:setChildCanvasGroupAlpha(0)
cb()
end

self:refreshDZListPanel()
self:refreshInfo()
self:refreshOneKeyBtn()









local allow=userActorSetting.get('UIXM_ZZSH_resourceDiZiWin_Toggle',true)
self.chooseBox:setToggle(allow)
end

function UIXM_ZZSH_resourceDiZiWin:onLoadFinish()
self:delayDo(0.2,function()
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end

function UIXM_ZZSH_resourceDiZiWin:refreshDZListPanel()
self.dzList={}
self.dzLookup={}
local discipleNetData=UIDiscipleModel:getAllDiscipleDataX()
if discipleNetData~=nil then
for k,data in pairs(discipleNetData)do
local locData={}
locData.netData=data.netData.net
local guid=locData.netData.discipleguid
local res=zhengzhanshanhaiModel:getDZCollectCfg(guid,self.moneyType)

local keep=res[2]
locData.keep=keep

local rate=res[1]
locData.rate=rate
local infotype=zhengzhanshanhaiModel:checkDZInMyWaiPai(guid)
locData.in_infotype=infotype

local effects=discipleSelectController.getSpeciallistByFunction(guid,edzFuncSpecialityType.eSpeciality_zzsh_collect)or{}
locData.effects=effects

local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
locData.chuiwei=chuiwei
local injuryType
if chuiwei then
injuryType=eInjuryType.eImminent
else
local injury=UIDiscipleModel:getDiscipleInjury(guid)
injuryType=eInjuryType.getType(injury)
end
locData.injuryType=injuryType

local color=UIDiscipleModel:getDiscipleColor(guid)

local sorts={}
locData.sorts=sorts
sorts[1]=infotype==nil and 1 or 0
sorts[2]=injuryType
sorts[3]=keep
sorts[4]=rate
sorts[5]=color
table.insert(self.dzList,locData)
end
end
mathHelper.sortWeightList(self.dzList,nil,nil,nil,2,eSortOrder.eUp)
for i,v in ipairs(self.dzList)do
local dzguid=v.netData.discipleguid
self.dzLookup[tostring(dzguid)]=i
end
local c=#self.dzList
self.itemGridPanel:setChildLayoutGroupCreateItems(c,function(idx)
if _this==nil then return end
_this:initGridItem(nil,idx)
end)
end

function UIXM_ZZSH_resourceDiZiWin:refreshAllDZSelect()
local grids=self.itemGridPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshGridItemSelect(item,i)
end
end

function UIXM_ZZSH_resourceDiZiWin:initGridItem(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end

local locData=self.dzList[idx]
local netData=locData.netData
local dz_guid=netData.discipleguid
local chuiwei=locData.chuiwei
local infotype=zhengzhanshanhaiModel:checkDZInMyWaiPai(dz_guid)

item:SetChildButtonClick(16,function()
if _this==nil then return end
_this:onDZCheck(idx)
end)

local color=UIDiscipleModel:getDiscipleColor(dz_guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(7,abname,iconname)

local isGray=chuiwei or infotype~=nil
comHelper.setChildModelRawImage(item,dz_guid,1,0,eHeadCenterType.eHead,nil,isGray)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(dz_guid))

local jobicon=UIDiscipleModel:getJobIconNameX(dz_guid)
item:SetChildCSImageSprite(17,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(dz_guid)
item:SetChildActive(18,isSpDz)

item:SetChildActive(10,chuiwei)
item:SetChildActive(11,chuiwei)

local desc_str_1=FMT.fmt('携带量：<color=#171311>{0}</color>',locData.keep)
item:SetChildText(3,desc_str_1)
local desc_str_2=FMT.fmt('采集效率：<color=#171311>{0}/每分钟</color>',locData.rate*60)
item:SetChildText(4,desc_str_2)

local fight_str=FMT.fmt('<color=#7d3b17>战 </color>{0}',UIDiscipleModel:getDiscipleFightValue(dz_guid))
item:SetChildText(14,fight_str)

local injuryType=locData.injuryType
local injuryIcon
if injuryType~=eInjuryType.eHealth then
injuryIcon=eInjuryType:getNameEx(injuryType)
end
local showinjury=injuryIcon~=nil
item:SetChildActive(15,showinjury)
if showinjury then
item:SetChildCSImageSprite(15,globalABLookup.global,injuryIcon)
end

local effects=locData.effects
local effNum=#effects
local showSpe=effNum>0
item:SetChildActive(5,showSpe)
if showSpe then
item:SetChildLayoutGroupCreateItems(8,effNum)
local spegrids=item:GetChildLayoutGroupGridList(8)
for i=1,effNum do
local speitem=spegrids[i-1]
local effectcfg=effects[i]
UIDiscipleModel.refreshSpecialityItemExx(speitem,effectcfg)
speitem:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onDescSlotClick(idx,i)
end)
end
end

local state_str
if infotype then
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
state_str='集结中'
else
state_str='采集中'
end
end
local showState=state_str~=nil
item:SetChildActive(12,showState)
if showState then
item:SetChildText(13,state_str)
end

self:refreshGridItemSelect(item,idx)
end

function UIXM_ZZSH_resourceDiZiWin:refreshGridItemSelect(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local netData=self.dzList[idx].netData
local isSelect=self.selectLookup[netData.discipleguidStr]~=nil
item:SetChildActive(0,isSelect)
end

function UIXM_ZZSH_resourceDiZiWin:onDescSlotClick(disIdx,speIdx)
local data=self.dzList[disIdx]
local effects=data.effects
local cfg=effects[speIdx]
local item=self.itemGridPanel:getChildScrollViewItemWidget(disIdx-1)
local speitem=item:GetChildLayoutGroupGridItem(8,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.netData.net.discipleguid,config=cfg})
end

function UIXM_ZZSH_resourceDiZiWin:onDZCheck(idx)
local locData=self.dzList[idx]
local netData=locData.netData
local slot=self.selectLookup[netData.discipleguidStr]
if slot then
self.selectLookup[netData.discipleguidStr]=nil
self.selectList[slot]=nil
self:refreshGridItemSelect(nil,idx)
else
slot=self:finEmptySlot()
if slot==nil then

return
end
if not zhengzhanshanhaiModel:checkDZFree(netData.discipleguid,true)then
return
end
self.selectLookup[netData.discipleguidStr]=slot
self.selectList[slot]=netData.discipleguid
self:refreshGridItemSelect(nil,idx)
end
self:refreshInfo()
self:refreshOneKeyBtn()
end

function UIXM_ZZSH_resourceDiZiWin:finEmptySlot()
for i=1,teamNum do
if self.selectList[i]==nil then
return i
end
end
return nil
end

function UIXM_ZZSH_resourceDiZiWin:refreshInfo()
local list={}
self.teamGrid:setChildLayoutGroupCreateItems(teamNum)
local grids=self.teamGrid:getChildLayoutGroupGridList()
for i=1,teamNum do
local dzguid=self.selectList[i]
local item=grids[i-1]
local idx=dzguid and self.dzLookup[tostring(dzguid)]or nil
local locData=idx and self.dzList[idx]or nil
local has=dzguid~=nil and locData~=nil or false
item:SetChildActive(0,not has)
item:SetChildActive(1,has)
if has then
table.insert(list,dzguid)
local netData=locData.netData
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(item,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,item,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(3,globalABLookup.global,jobicon)

local isSpDz=netData.id and UIDiscipleModel:isSPDisciple(netData.id)or false
item:SetChildActive(5,isSpDz)
end

item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onHeadClick(i)
end)
end

local res,add=zhengzhanshanhaiModel:getDZGroupCollectCfg(list,self.moneyType)
local resRate_str=FMT.fmt('采集效率：<color=#549327>{0}</color>/每分钟',math.floor(res[1]*60))
if add[1]>0 then
resRate_str=FMT.fmt('{0}<color=#ca631d>(+{1}%)</color>',resRate_str,add[1])
end
self.resRateTxt:setText(resRate_str)

self.resProgressTxt:setText(mathHelper.formatNumber2(res[2]))

end












function UIXM_ZZSH_resourceDiZiWin:onHeadClick(idx)

end

function UIXM_ZZSH_resourceDiZiWin:onMask()
self:onClickClose()
end

function UIXM_ZZSH_resourceDiZiWin:onClickClose()
self:closeSelf()
end

function UIXM_ZZSH_resourceDiZiWin:onJiuzhiAllBtn()
UIFullDiscipleBatchTreatControl.showBatchZhiliaoWin(false,1,7)
end

function UIXM_ZZSH_resourceDiZiWin:onRuleBtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='act_zzsh_resource_select_rule_%d'
d.closeCB=function()
if _this==nil then return end
_this:refreshRuleSelect(false)
end
UIManager:showWindow('UIRuleWin',d)
self:refreshRuleSelect(true)
end

function UIXM_ZZSH_resourceDiZiWin:refreshRuleSelect(flag)
self.ruleSelect:setActive(flag)
end

function UIXM_ZZSH_resourceDiZiWin:onSelectTeamBtn()
local teamList={}
for i=1,teamNum do
local dzguid=self.selectList[i]
local idx=dzguid and self.dzLookup[tostring(dzguid)]or nil
local locData=idx and self.dzList[idx]or nil
if locData~=nil then
teamList[i]={1,dzguid}
else
teamList[i]={0,int64.zero}
end
end

UIManager:showWindow("UIFightTeamPrefabPanel",{teamList=teamList,winName=self.__name})
end

function UIXM_ZZSH_resourceDiZiWin:onCommitBtn()
local qbGuid=self.qbGuid
local qbData=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData==nil then
UIManager.info('该宝地已被采空')
return
end
local detail=qbData:getDetail()
local curRes=detail:getLerpRes()
if curRes<=0 then
UIManager.info('该宝地已被采空')
return
end
local list={}
local list2={}
for i=1,teamNum do
local dzguid=self.selectList[i]
local idx=dzguid and self.dzLookup[tostring(dzguid)]or nil
local locData=idx and self.dzList[idx]or nil
if locData~=nil then
table.insert(list,locData)
table.insert(list2,locData.netData.discipleguid)
else
table.insert(list2,int64.new('0'))
end
end
if#list<=0 then
UIManager.info('请先选择弟子')
return
end
local cb=function()
if _this==nil then return end

zhengzhanshanhaiController:reqResourceCollect(qbGuid,list2)
_this:closeSelf()
end
local injuryCheck=false
for i,locData in ipairs(list)do
if locData.injuryType>eInjuryType.eHealth then
injuryCheck=true
break
end
end
if injuryCheck then
local content='队伍有弟子处于负伤，采集发生战斗，将处于不利处境，是否继续前往？'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=cb,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
cb()
end
end

function UIXM_ZZSH_resourceDiZiWin:refreshOneKeyBtn()
local isFull=true
for i=1,teamNum do
if self.selectList[i]==nil then
isFull=false
break
end
end
local btn_str=isFull==true and'一键下阵'or'一键上阵'
self.onkeyBtnTxt:setText(btn_str)
end

function UIXM_ZZSH_resourceDiZiWin:onOnkeyBtn()
local isFull=true
for i=1,teamNum do
if self.selectList[i]==nil then
isFull=false
break
end
end
local Toggle=self.chooseBox:getToggle()
local self_list={}
if Toggle then
local selflist=zhengzhanshanhaiModel:getybd_guildlist()
for k,v in ipairs(selflist)do
local diziguid=v
self_list[tostring(diziguid)]=true
end
end

if not isFull then
local isChange=false
local copyList={}
for i=1,teamNum do
if not self.selectList[i]then
copyList={}
for i2,locData in ipairs(self.dzList)do
local dzguid=locData.netData.discipleguid
local dzguid_str=locData.netData.discipleguidStr
if self.selectLookup[dzguid_str]==nil and zhengzhanshanhaiModel:checkDZFree(dzguid,false)and self_list[dzguid_str]==nil then
local rate=locData.rate
local fight=UIDiscipleModel:getDiscipleFightValue(dzguid)
local job=UIDiscipleModel:getDiscipleJob(dzguid)
local pospriorty=UIDiscipleModel.getJobPosPriorty(job)
local priIdx=5
for ii,vv in ipairs(pospriorty)do
if vv==i then
priIdx=ii
break
end
end
table.insert(copyList,{discipleguid=dzguid,discipleguidStr=dzguid_str,rate=rate,fight=fight,pospriorty=priIdx})
end
end
table.sort(copyList,function(a,b)
if a.pospriorty==b.pospriorty then
if a.fight==b.fight then
return a.rate>b.rate
else
return a.fight>b.fight
end
else
return a.pospriorty<b.pospriorty
end
end)

local dizi=copyList[1]
if dizi then
self.selectList[i]=dizi.discipleguid
self.selectLookup[dizi.discipleguidStr]=i
isChange=true
end
end
end
if isChange then
self:refreshInfo()
self:refreshAllDZSelect()
self:refreshOneKeyBtn()

local idx=1
for _k,_v in ipairs(self.dzList)do
local dzguid_str=_v.netData.discipleguidStr
if self.selectLookup[dzguid_str]then
idx=_k
break
end
end
_this:delayDo(0.1,function()
if _this==nil then return end
local idx2=(idx+1)/2
local posy=singleH*idx2-itemPanelH
if posy<0 then
posy=0
end
_this.winlua:SetChildLocalPosY(self.itemGridPanel:getID(),posy)
end)
end
else
self.selectLookup={}
self.selectList={}
self:refreshInfo()
self:refreshAllDZSelect()
self:refreshOneKeyBtn()
end
end

function UIXM_ZZSH_resourceDiZiWin:checkPosEnough()
local list=self.selectList
for i=1,teamNum do
if list[i]==nil then
return false
end
end
return true
end


function UIXM_ZZSH_resourceDiZiWin:getJobPosPriorty(jobId)
local pospriorty=UIDiscipleModel.getJobPosPriorty(jobId)
if pospriorty then
for i,listPos in ipairs(pospriorty)do
if not self.selectList[listPos]then
return listPos
end
end
else
for i=1,teamNum do
if not self.selectList[i]then
return i
end
end
end
end

function UIXM_ZZSH_resourceDiZiWin:onDzItemListUse(array)
if self.dzLookup==nil then return end
local lookup={}
local flag=false
for i,v in ipairs(array)do
local dzguid=v.param_1
local idx=self.dzLookup[tostring(dzguid)]
if idx then
local data=self.dzList[idx]
local widget=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
if widget then
local state=UIDiscipleModel:getDiscipleState(dzguid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
local injuryType
if chuiwei then
injuryType=eInjuryType.eImminent
else
local injury=UIDiscipleModel:getDiscipleInjury(dzguid)
injuryType=eInjuryType.getType(injury)
end
local injuryIcon
if injuryType~=eInjuryType.eHealth then
injuryIcon=eInjuryType:getNameEx(injuryType)
end
local showinjury=injuryIcon~=nil
widget:SetChildActive(15,showinjury)
if showinjury then
widget:SetChildCSImageSprite(15,globalABLookup.global,injuryIcon)
end
comHelper.setChildModelRawImage(widget,dzguid,1,0,eHeadCenterType.eHead,nil,chuiwei)

widget:SetChildActive(10,chuiwei)
widget:SetChildActive(11,chuiwei)
end
end
end
end

function UIXM_ZZSH_resourceDiZiWin:onFastSelect(dzLookup,dzlist)
local num=0
local selectLookup={}
local selectList={}
for i,dzguid in ipairs(dzlist)do
local dzguid_str=tostring(dzguid)
if dzguid_str~='0'then
if zhengzhanshanhaiModel:checkDZFree(dzguid,false)then
num=num+1
selectList[num]=dzguid
selectLookup[dzguid_str]=num
end
end
if num>=teamNum then break end
end
if num>0 then
self.selectLookup=selectLookup
self.selectList=selectList
self:refreshInfo()
self:refreshAllDZSelect()
self:refreshOneKeyBtn()
end
end

function UIXM_ZZSH_resourceDiZiWin:onChangeChoose()

AudioManager.playBtnClick()
end