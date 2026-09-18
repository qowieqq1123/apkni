







def_class("UIDiscipleLinggenlInfoWin",UIWindowBase)









function UIDiscipleLinggenlInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.linggentotallv=UIText.get(self,1)
self.infoBtn=UIButton.get(self,2)
self.linggenroot=UIObject.get(self,3)
self.detailBtn=UIButton.get(self,4)
self.hiddenSkillList=UIObject.get(self,5)
self.hiddenSkillTotalPreviewBtn=UIButton.get(self,6)
self.hidden_0=UIBaseItem.get(self,7)
self.hidden_1=UIBaseItem.get(self,8)
self.hidden_2=UIBaseItem.get(self,9)
self.hidden_3=UIBaseItem.get(self,10)
self.hidden_4=UIBaseItem.get(self,11)
self.hidden_5=UIBaseItem.get(self,12)
self.varyLinggenRoot=UIBaseItem.get(self,13)
self.resetAllBackBtn=UIButton.get(self,14)
self.resetAllBackImage=UIObject.get(self,15)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.hiddenSkillTotalPreviewBtn:setButtonClick(function()self:onHiddenSkillTotalPreviewBtn()end)

self.resetAllBackBtn:setButtonClick(function()self:onResetAllBackBtn()end)
self.hidden={
[0]=self.hidden_0,
[1]=self.hidden_1,
[2]=self.hidden_2,
[3]=self.hidden_3,
[4]=self.hidden_4,
[5]=self.hidden_5,
}



end


function UIDiscipleLinggenlInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.linggentotallv);self.linggentotallv=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.linggenroot);self.linggenroot=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.hiddenSkillList);self.hiddenSkillList=nil;
_UIObject_release(self.hiddenSkillTotalPreviewBtn);self.hiddenSkillTotalPreviewBtn=nil;
_UIObject_release(self.hidden_0);self.hidden_0=nil;
_UIObject_release(self.hidden_1);self.hidden_1=nil;
_UIObject_release(self.hidden_2);self.hidden_2=nil;
_UIObject_release(self.hidden_3);self.hidden_3=nil;
_UIObject_release(self.hidden_4);self.hidden_4=nil;
_UIObject_release(self.hidden_5);self.hidden_5=nil;
_UIObject_release(self.varyLinggenRoot);self.varyLinggenRoot=nil;
_UIObject_release(self.resetAllBackBtn);self.resetAllBackBtn=nil;
_UIObject_release(self.resetAllBackImage);self.resetAllBackImage=nil;
self.hidden=nil;
end















local _this

local hiddenSkillLen=6


local layoutDatas={

[1]={[1]={90,-59}},
[2]={[1]={-10,-100},[2]={130,27}},
[3]={[1]={-105,-107},[2]={80,-58},[3]={148,95}},
[4]={[1]={-146,-118},[2]={5,-110},[3]={128,-26},[4]={160,104}},
[5]={[1]={-125,-101},[2]={37,-14},[3]={140,104},[4]={9,-143},[5]={171,-27.9}},
}

local CmpLinggenItemIndex={
info=0,
effect=1,
reddot=2,
}

local CmpHiddenSkillItemIndex={
quality=0,
icon=1,
lock=2,
unlocktip=3,
add=4,
mask=5,
reddot=6,
}




function UIDiscipleLinggenlInfoWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onDiscipleLingGenUpLevel,function(...)self:onDiscipleLingGenUpLevel(...)end)
self:addNotify(notifyConfig.onDiscipleLingGenVary,function(...)self:onDiscipleLingGenVary(...)end)
self:addNotify(notifyConfig.onDiscipleLingGenChangeVary,function(...)self:onDiscipleLingGenChangeVary(...)end)
self:addNotify(notifyConfig.onDiscipleLingGenEquipBoard,function(...)self:onDiscipleLingGenEquipBoard(...)end)
self:addNotify(notifyConfig.onDiscipleLingGenResetLevel,function(...)self:onDiscipleLingGenResetLevel(...)end)
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:on_item_list_changed(...)end)
self:addNotify(notifyConfig.onNewDay5am,function(...)self:onNewDay5am(...)end)
self:addNotify(notifyConfig.onNewDay,function(...)self:onNewDay(...)end)

self.lrAnimationList={}
self.lrAnimationTW={}

self:addProNotify(2,203,self.recv_2_203)

self._refreshSpritRootReddot=function()
_this:refresh()
end
reddotClassManager.register_event(REDDIT_SUB_TYPE.sDiscipleLingGen,self._refreshSpritRootReddot)
end


function UIDiscipleLinggenlInfoWin:__delete()
reddotClassManager.unregister_event(REDDIT_SUB_TYPE.sDiscipleLingGen,self._refreshSpritRootReddot)

for k,v in pairs(self.lrAnimationList)do
v:cancel()
end
self.lrAnimationList=nil

self:unbindComponents()
end




function UIDiscipleLinggenlInfoWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid

if afterOnloaded then

end

mzbkController.check_req_disciple_mzbk_list(self.disciple_guid)

self:refresh()
self:onShowResetAllBack()
end


function UIDiscipleLinggenlInfoWin:onHide()
self:hideVaryItem()
end

function UIDiscipleLinggenlInfoWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIDiscipleLinggenlInfoWin:refresh()
self:refreshLingGenList()
self:refreshHiddenSkillList()
self:refreshTotalLevel()
self:refreshVaryItem()
end


function UIDiscipleLinggenlInfoWin:refreshHiddenSkillList()
local hiddenSkillList=UIDiscipleModel:getDiscipleHoard(self.disciple_guid)
local linggenTotalLv=UIDiscipleModel:getDiscipleTotalLinggenLevel(self.disciple_guid)
local limit=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,"limit")

for index,item in pairs(self.hidden)do

local data




if index==0 then

local varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
varySrid=varySrid==0 and 1 or varySrid
data=hiddenSkillList[-varySrid]




else

data=hiddenSkillList[index]



end


self:refreshSingleHiddenSkill(index,data)

end
end


function UIDiscipleLinggenlInfoWin:refreshSingleHiddenSkill(index,data)
local item=self.hidden[index]
local limit=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,"limit")
local isUnlock
local isEquiped
local unlockTip
local tips
if index==0 then

local varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
isUnlock=UIDiscipleModel:checkLinggenVary(self.disciple_guid)and UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)
isEquiped=data.activelistlen>0 and varySrid==Mathf.Abs(data.pos)
unlockTip=FMT.fmt("变异")
if systemModel.isOpen(SYSTEM_DEFINE.eVarySpriteRoot)then
tips='灵根变异解锁'
else
tips='灵根变异尚未开启，敬请期待'
end
else

isUnlock=UIDiscipleModel:checkHiddenSkillSlotUnlock(self.disciple_guid,index)
isEquiped=data.activelistlen>0
unlockTip=FMT.fmt("{0}级",limit[index])
tips=FMT.fmt("灵根总等级达到{0}级后解锁",limit[index])
end
self:freshHiddenSkill(item,index,data,isUnlock,isEquiped,unlockTip,tips)
end

function UIDiscipleLinggenlInfoWin:freshHiddenSkill(item,index,data,isUnlock,isEquiped,unlockTip,tips)
local itemWidget=item:getChildWidgetBase()
itemWidget:SetChildActive(CmpHiddenSkillItemIndex.icon,isUnlock and isEquiped)

itemWidget:SetChildActive(CmpHiddenSkillItemIndex.lock,not isUnlock)
itemWidget:SetChildActive(CmpHiddenSkillItemIndex.unlocktip,not isUnlock)
itemWidget:SetChildActive(CmpHiddenSkillItemIndex.add,isUnlock and(not isEquiped))
itemWidget:SetChildActive(CmpHiddenSkillItemIndex.mask,not isUnlock)
local reddot=isUnlock and((not isEquiped)and(UIDiscipleModel:checkDiscipleCanFindHoardReddot()or UIDiscipleModel:checkDiscipleHoardFree(self.disciple_guid,index))or mzbkModel:getOneTimeReddot())
itemWidget:SetChildActive(CmpHiddenSkillItemIndex.reddot,reddot)
if isUnlock then

if isEquiped then

local hiddenid=data.activeList[1].hoardid
local hiddenCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,hiddenid)
local skillIconName=iconHelper.getSkillIcon(hiddenCfg.icon)
itemWidget:SetChildIcon(CmpHiddenSkillItemIndex.icon,skillIconName,false)
else


end
else

itemWidget:SetChildText(CmpHiddenSkillItemIndex.unlocktip,unlockTip)
end

itemWidget:SetBaseItemClickEvent(-1,function()

local isLDLock=UIDiscipleModel:checkDZClientState(self.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
if isUnlock then
if isEquiped then
if mzbkModel:checkActiveTeQuan()then
_this:showWindow("UIDiscipleLinggen_QuickLookHoardWin",{
disciple_guid=_this.disciple_guid,
item=itemWidget,
parentWin=_this,
pos=data.pos,
data=data,
})
else
_this:showWindow("UIDiscipleLinggen_HiddenSkillTipsWn",{
disciple_guid=_this.disciple_guid,
item=itemWidget,
data=data,
parentWin=_this,
})
end
else
_this:showWindow("UIDiscipleLinggen_HiddenSkillSelectWin",{
disciple_guid=_this.disciple_guid,
boardPosData=data,
})
end
else
UIManager.info(tips)
end
end)
end


function UIDiscipleLinggenlInfoWin:refreshLingGenList()
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)

self.linggenroot:setChildLayoutGroupCreateItems(lglen,function(index)
local item=self.linggenroot:getChildLayoutGroupGridItem(index-1)
local lgdata=lglist[index]


local layout=layoutDatas[lglen]

item:SetChildActive(-1,lgdata~=nil or index==0)
_this:freshLingGen(item,lgdata,layout[index],index)
end)
end


function UIDiscipleLinggenlInfoWin:refreshSingleLingGen(lglen,index,data)
local item=self.linggenroot:getChildLayoutGroupGridItem(index-1)
local layout=layoutDatas[lglen]
self:freshLingGen(item,data,layout[index],index)
end

function UIDiscipleLinggenlInfoWin:freshLingGen(item,data,pos,index)
local lgCfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,data.type)



local effectId=lgCfg.showlist[LingGenShowListIndex.varyEffect]
item:SetChildShowEffect(CmpLinggenItemIndex.effect,0,false)
item:SetChildShowEffect(CmpLinggenItemIndex.effect,effectId,true)
local namecolor=UIDiscipleModel:getLingGenTypeNameColor(lgCfg.id)
item:SetChildText(CmpLinggenItemIndex.info,toColorStringX(namecolor,FMT.fmt("{0}{1}级",lgCfg.name,data.lv)))

item:SetChildActive(CmpLinggenItemIndex.reddot,UIDiscipleModel:checkDiscipleStrengthenLingGenReddotByLgdata(self.disciple_guid,data))
item:SetChildLocalPosition(-1,Vector3(pos[1],pos[2],0))

item:SetBaseItemClickEvent(-1,function()
local isLDLock=UIDiscipleModel:checkDZClientState(_this.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end

_this:showWindow("UIDiscipleLinggen_StrengthenLinggenWin",{
disciple_guid=_this.disciple_guid,
data=data,
isShowStrengthenPanel=true,
})
end)

item:SetChildNewBieComponentId(-1,FMT.fmt('UIDiscipleLinggenlInfoWin.baseLinggenItem_{0}',index))
end


function UIDiscipleLinggenlInfoWin:refreshTotalLevel()
local curTotalLv=UIDiscipleModel:getDiscipleTotalLinggenLevel(self.disciple_guid)
local maxTotalLv=UIDiscipleModel:getLingGenTotalMaxLevel(self.disciple_guid)
self.linggentotallv:setText(FMT.fmt("灵根总强化等级：{0}/{1}",curTotalLv,maxTotalLv))
end

local CmpVaryItemIndex={
effect=0,
info=1,
reddot=2,
}
function UIDiscipleLinggenlInfoWin:refreshVaryItem()
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
local totallv=UIDiscipleModel:getDiscipleTotalLinggenLevel(self.disciple_guid)
local vary=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'vary')
local maxlv=vary[2]

local itemwb=self.varyLinggenRoot:getChildWidgetBase()


if not systemModel.isOpen(SYSTEM_DEFINE.eVarySpriteRoot)then
if UIManager:isActive('UIDiscipleLinggenlInfoWin')then
itemwb:SetChildShowEffect(CmpVaryItemIndex.effect,10394,true)
end
itemwb:SetChildActive(CmpVaryItemIndex.info,false)
itemwb:SetChildActive(CmpVaryItemIndex.reddot,false)
itemwb:SetBaseItemClickEvent(-1,function()
UIManager.info('灵根变异尚未开启，敬请期待')
end)
return
end



local isOpenVary=UIDiscipleModel:checkDiscipleOpenVary(self.disciple_guid)
local isCanVary=UIDiscipleModel:checkDiscipleCanVary(self.disciple_guid)
local varyid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
local data
for k,v in pairs(lglist)do
if v.type==varyid then
data=v
break
end
end
itemwb:SetChildActive(CmpVaryItemIndex.info,totallv>=maxlv)

itemwb:SetChildShowEffect(CmpVaryItemIndex.effect,0,false)
if data and isOpenVary and isCanVary then
local netdata=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local cfg=UIDiscipleModel:getSpecialityConfigEx(netdata,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,data.source)

local namecolor=UIDiscipleModel:getLingGenTypeNameColor(cfg.id)
itemwb:SetChildText(CmpVaryItemIndex.info,toColorStringX(namecolor,FMT.fmt("{0}",cfg.name)))

itemwb:SetChildActive(CmpVaryItemIndex.reddot,false)
if UIManager:isActive('UIDiscipleLinggenlInfoWin')then
itemwb:SetChildShowEffect(CmpVaryItemIndex.effect,cfg.showlist[LingGenShowListIndex.varyEffect],true)
end
else


if totallv>=maxlv and isOpenVary then
itemwb:SetChildText(CmpVaryItemIndex.info,'灵根可变异')
if UIManager:isActive('UIDiscipleLinggenlInfoWin')then
itemwb:SetChildShowEffect(CmpVaryItemIndex.effect,10393,true)
end
else
itemwb:SetChildText(CmpVaryItemIndex.info,'')
if UIManager:isActive('UIDiscipleLinggenlInfoWin')then
itemwb:SetChildShowEffect(CmpVaryItemIndex.effect,10394,true)
end
end
itemwb:SetChildActive(CmpVaryItemIndex.reddot,UIDiscipleModel:checkDiscipleVaryLingGenReddot(self.disciple_guid))
end


itemwb:SetBaseItemClickEvent(-1,function()
local isLDLock=UIDiscipleModel:checkDZClientState(_this.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
if totallv>=maxlv and isOpenVary then
_this:showWindow("UIDiscipleLinggen_variationLinggenWin",{
disciple_guid=_this.disciple_guid,
parentWin=_this
})
else
local logStr

if varyid>0 then
logStr=FMT.fmt('灵根总等级达到{0}级后激活灵根变异',maxlv)
else
logStr=FMT.fmt('灵根总等级达到{0}级，即可开启',maxlv)
end
UIManager.info(logStr)
end
end)
end

function UIDiscipleLinggenlInfoWin:hideVaryItem()
local itemwb=self.varyLinggenRoot:getChildWidgetBase()
itemwb:SetChildShowEffect(CmpVaryItemIndex.effect,0,false)
itemwb:SetChildActive(CmpVaryItemIndex.info,false)
end



function UIDiscipleLinggenlInfoWin:onDiscipleLingGenUpLevel(dz_guid,linggen_id,linggen_lv)
if mathHelper.compareInt64(dz_guid,self.disciple_guid)then
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(dz_guid)
local index
for k,v in pairs(lglist)do
if v.type==linggen_id then
index=k
end
end
self:refreshSingleLingGen(lglen,index,lglist_lookup[linggen_id])
self:refreshTotalLevel()
self:refreshHiddenSkillList()
self:refreshVaryItem()
end
end

function UIDiscipleLinggenlInfoWin:onDiscipleLingGenVary(dz_guid,linggen_id,vary)
if dz_guid==self.disciple_guid then
self:refreshVaryItem()
self:refreshHiddenSkillList()
self:refreshTotalLevel()
end
end

function UIDiscipleLinggenlInfoWin:onDiscipleLingGenChangeVary(dz_guid,linggen_id)
if mathHelper.compareInt64(dz_guid,self.disciple_guid)then
self:refreshVaryItem()

local boardList=UIDiscipleModel:getDiscipleHoard(dz_guid)
local varyIndex=-linggen_id
local data={}
for k,v in pairs(boardList)do
if v.pos==varyIndex then
data=v
end
end

self:refreshLingGenList()
self:refreshSingleHiddenSkill(0,data)
self:refreshTotalLevel()
end
end


function UIDiscipleLinggenlInfoWin:onDiscipleLingGenEquipBoard(dz_guid,pos,data)
if dz_guid==self.disciple_guid then
pos=pos>0 and pos or 0
self:refreshSingleHiddenSkill(pos,data)
end
end

function UIDiscipleLinggenlInfoWin:onDiscipleLingGenResetLevel(dz_guid,linggen_id,linggen_lv)
if mathHelper.compareInt64(dz_guid,self.disciple_guid)then
self:refresh()
end
end

function UIDiscipleLinggenlInfoWin:on_item_list_changed(argstable)
for i,v in ipairs(argstable)do
local itemid=v[3]
if itemid==eMoneyType.mtWuXingYuBi or itemid==12187 then
self:refresh()
end
end
end

function UIDiscipleLinggenlInfoWin:onNewDay()
self:onShowResetAllBack()
end

function UIDiscipleLinggenlInfoWin:onNewDay5am()
self:onShowResetAllBack()
end

function UIDiscipleLinggenlInfoWin.recv_2_203(dzGuid,pos,idx,len,mzInfoList)
if _this==nil then return end
if mathHelper.compareInt64(_this.disciple_guid,dzGuid)then
local realPos=pos>0 and pos or 0
local hiddenSkillList=UIDiscipleModel:getDiscipleHoard(_this.disciple_guid)
local hiddenSkillInfo=hiddenSkillList[pos]
_this:refreshSingleHiddenSkill(realPos,hiddenSkillInfo)
end
end

function UIDiscipleLinggenlInfoWin:onShowResetAllBack()
self.resetAllBackArgs=nil
local reset_all_back=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'reset_all_back')

self.resetAllBackImage:setActive(false)
if not reset_all_back then
self.resetAllBackBtn:setActive(false)
return false
end
local jobStr
local openStamp=timeHelper.getServerLongTime()
for jobId,v in pairs(reset_all_back)do
local minTime=timeHelper.dataToTimeStam(v[1])
local maxTime=timeHelper.dataToTimeStam(v[2])
if openStamp>=minTime and openStamp<=maxTime then
if not self.resetAllBackArgs then
self.resetAllBackArgs={}
self.resetAllBackArgs.type=1
self.resetAllBackArgs.timeStr=FMT.fmt("{0} - {1}",v[1],v[2])
end
local jobName=UIDiscipleModel:getJobName(jobId)
if not jobStr then
jobStr=jobName
else
jobStr=FMT.fmt("{0}、{1}",jobStr,jobName)
end
end
end
if self.resetAllBackArgs~=nil then
local moneyStr
local resetlgpercent=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'resetlgpercent')
for id,v in pairs(resetlgpercent)do
local name=itemsModel.getName(id)
if not moneyStr then
moneyStr=name
else
moneyStr=FMT.fmt("{0}、{1}",moneyStr,name)
end
end
self.resetAllBackArgs.descStr=FMT.fmt("活动期间<color=#fd8950>{0}</color>职业重置灵根将<color=#fd8950>返还100%</color>强化消耗的<color=#fd8950>{1}</color>",jobStr,moneyStr)
end
self.resetAllBackBtn:setActive(self.resetAllBackArgs~=nil)
return self.resetAllBackArgs~=nil
end





function UIDiscipleLinggenlInfoWin:onInfoBtn()
local d={}
d.title='提示'
d.mode=3
d.name='linggen_rule_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIDiscipleLinggenlInfoWin:onDetailBtn()
local totallv=UIDiscipleModel:getDiscipleTotalLinggenLevel(self.disciple_guid)
if totallv>0 then
self:showWindow("UIDiscipleLinggen_StrengthenDetaileWin",{
disciple_guid=self.disciple_guid
})
else
UIManager.info('尚未强化灵根，无额外属性加成')
end
end

function UIDiscipleLinggenlInfoWin:onHiddenSkillTotalPreviewBtn()
self:showWindow("UIDiscipleLinggen_HiddenSkillRecordWin")
end

function UIDiscipleLinggenlInfoWin:onResetAllBackBtn()
if not self.resetAllBackArgs then
if not self:onShowResetAllBack()then
UIManager.info('不在返还活动期间')
return
end
end
self.resetAllBackArgs.closeFunc=function()
_this.resetAllBackImage:setActive(false)
end
self.resetAllBackImage:setActive(true)
self:showWindow("UIDiscipleLinggenResetAllBackWin",self.resetAllBackArgs)
end

function UIDiscipleLinggenlInfoWin:refreshPageWin()
local dis_guid=self.disciple_guid
self:onShow({guid=dis_guid})
end
