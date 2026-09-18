







def_class("UIDiscipleSkillInfoWin",UIWindowBase)









function UIDiscipleSkillInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.gfSlot1=UIButton.get(self,1)
self.gfSlot2=UIButton.get(self,2)
self.fbSkillGrid=UIObject.get(self,3)
self.gfSkillGrid=UIObject.get(self,4)
self.changeSkillBtn=UIButton.get(self,5)
self.resetSkillBtn=UIButton.get(self,6)
self.gfDescPanel=UIObject.get(self,7)
self.fbSlot1=UIBaseItem.get(self,8)
self.jobSkillGrid=UIObject.get(self,9)

self.gfSlot1:setButtonClick(function()self:onGfSlot1()end)

self.gfSlot2:setButtonClick(function()self:onGfSlot2()end)

self.changeSkillBtn:setButtonClick(function()self:onChangeSkillBtn()end)

self.resetSkillBtn:setButtonClick(function()self:onResetSkillBtn()end)



end


function UIDiscipleSkillInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.gfSlot1);self.gfSlot1=nil;
_UIObject_release(self.gfSlot2);self.gfSlot2=nil;
_UIObject_release(self.fbSkillGrid);self.fbSkillGrid=nil;
_UIObject_release(self.gfSkillGrid);self.gfSkillGrid=nil;
_UIObject_release(self.changeSkillBtn);self.changeSkillBtn=nil;
_UIObject_release(self.resetSkillBtn);self.resetSkillBtn=nil;
_UIObject_release(self.gfDescPanel);self.gfDescPanel=nil;
_UIObject_release(self.fbSlot1);self.fbSlot1=nil;
_UIObject_release(self.jobSkillGrid);self.jobSkillGrid=nil;
end
















local _this=nil


function UIDiscipleSkillInfoWin:onLoaded(...)
_this=self
self:bindComponents()
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
self:addNotify(notifyConfig.onDiscipleFaBaoChange,function(...)self:onDiscipleFaBaoChange(...)end)
end


function UIDiscipleSkillInfoWin:__delete()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.onItemListChanged)
if self.fabaoReddotKey and self._onBenMingFabaoReddot then
reddotClassManager.unregister_event(self.fabaoReddotKey,self._onBenMingFabaoReddot)
end
end


function UIDiscipleSkillInfoWin:onHide()

end

function UIDiscipleSkillInfoWin.onItemListChanged(list)
if list==nil then return end
local needRefreshFBReddot=false

local isEquipFBNeedTuPo=false
local equip=equipsHelper.getEquipByDizi(_this.diziguid,EQUIP_TYPE.eFabao)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
if fabaoConfig.isBenMingFabao(itemid)then

local lxlv=fabaoModel.getLingXingLv(itemguid)
local tupocost=fabaoConfig.getTuPoLxCost(lxlv)
isEquipFBNeedTuPo=tupocost~=nil
end

if not isEquipFBNeedTuPo then

isEquipFBNeedTuPo=fabaoHelper.isInTuPo(itemguid,itemid)
end

if isEquipFBNeedTuPo then
needRefreshFBReddot=true
end
end

for i,v in ipairs(list)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
if itemsConfig.isFabao(itemid)then
_this:rec_FBItemChange()
end

if not needRefreshFBReddot and fabaoConfig.isJilianItem(itemid)then
needRefreshFBReddot=true
end
end

if needRefreshFBReddot then
_this:refreshFBReddot()
end
end




function UIDiscipleSkillInfoWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
self._netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self:initUsingGongFa()
self:refreshView()

if afterOnloaded then
local win=UIManager:findActiveWindow('UIDiscipleGFSetupWin')
if win then
local arrs=win:getMyCanvas()
local sortLayer=arrs[1]
local sortOrder=arrs[2]
self:setGFCanvas(sortLayer,sortOrder+1)
local selectpos=win:getSelectPos()
self:refreshGFSkillSlotSelect(selectpos,true)
local func=function()
if _this==nil then return end
_this:refreshGFSkillSlotSelect(selectpos,false)
end
local args={guid=self.disciple_guid,pos=selectpos,callback=func}
win:resetData(args)
end
end
end

function UIDiscipleSkillInfoWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIDiscipleSkillInfoWin:refreshView()

self:refreshFBSkillSlot()


self:refreshGFSkillSlot()


self:refreshJobSkillGrid()


self:refreshGFSkillGrid()


self:refreshFBSkillGrid()
end

function UIDiscipleSkillInfoWin:refreshFBSkillSlot(useCache)

self.fbSlot1:setBaseItemClickEvent(function(...)self:onFBItemClick(...)end)
self.fbSlot1:setBaseItemChildIndex(EQUIP_TYPE.eFabao)
local equip=equipsHelper.getEquipByDizi(self.disciple_guid,EQUIP_TYPE.eFabao)

local prop={}
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stage=itemConfig.stage and FMT.fmt('{0}阶',itemConfig.stage)or''
local iconName=itemsModel.getIconName(equip)
local reddot=false
if self.showType==dicipleType.eSystem then
reddot=equipsReddotHelper.getBetterFabaoReddotByDZ(self.disciple_guid)
if not reddot then
if fabaoConfig.isBenMingFabao(itemid)then
reddot=benMingFaBaoHelper.canlxUp(itemguid)
end
if not reddot then
reddot=fabaoHelper.checkFabaoIsCanJiLian(itemguid)
end
end
end

prop[PropIndex(DataPropKey.eWidgetQuality,0)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetActive,3)]=true
prop[PropIndex(DataPropKey.eWidgetText,4)]=stage
prop[PropIndex(DataPropKey.eWidgetActive,5)]=reddot
prop[PropIndex(DataPropKey.eWidgetText,6)]=''
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid or-1
else
local showAdd=true
local name='可装备'
if self.showType==dicipleType.eTemp then
showAdd=false
name=''
end
local reddot=false
if self.showType==dicipleType.eSystem then
reddot=equipsReddotHelper.getBetterFabaoReddotByDZ(self.disciple_guid)
end
prop[PropIndex(DataPropKey.eWidgetActive,0)]=false
prop[PropIndex(DataPropKey.eWidgetActive,1)]=false
prop[PropIndex(DataPropKey.eWidgetActive,2)]=showAdd
prop[PropIndex(DataPropKey.eWidgetActive,3)]=false
prop[PropIndex(DataPropKey.eWidgetActive,5)]=reddot
prop[PropIndex(DataPropKey.eWidgetText,6)]=name
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1
end
self.fbSlot1:setChildPropData(prop)
end

function UIDiscipleSkillInfoWin:refreshFBReddot()
local equip=equipsHelper.getEquipByDizi(self.disciple_guid,EQUIP_TYPE.eFabao)
local prop={}
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local reddot=false
if self.showType==dicipleType.eSystem then
reddot=equipsReddotHelper.getBetterFabaoReddotByDZ(self.disciple_guid)
if not reddot then
if fabaoConfig.isBenMingFabao(itemid)then
reddot=benMingFaBaoHelper.canlxUp(itemguid)
end
if not reddot then
reddot=fabaoHelper.checkFabaoIsCanJiLian(itemguid)
end
end
end
prop[PropIndex(DataPropKey.eWidgetActive,5)]=reddot
else
local reddot=false
if self.showType==dicipleType.eSystem then
reddot=equipsReddotHelper.getBetterFabaoReddotByDZ(self.disciple_guid)
end
prop[PropIndex(DataPropKey.eWidgetActive,5)]=reddot
end
self.fbSlot1:setChildPropData(prop)
end

function UIDiscipleSkillInfoWin:refreshJobSkillGrid()
local jobSkillList=UIDiscipleModel:getDiscipleJobSkillList(self.disciple_guid)
self:refreshSkillGrid(self.jobSkillGrid,jobSkillList,eSkillTipsType.eDZSkill)
self:refreshChangeBtn(jobSkillList)
end

function UIDiscipleSkillInfoWin:refreshGFSkillGrid()
local gfSkillList=UIDiscipleModel:getDiscipleUsingGFSkillList(self.disciple_guid)
self:refreshSkillGrid(self.gfSkillGrid,gfSkillList,eSkillTipsType.eDZGFSkill)
end

function UIDiscipleSkillInfoWin:refreshFBSkillGrid()
local fbSkillList={}
local equip=equipsHelper.getEquipByDizi(self.disciple_guid,EQUIP_TYPE.eFabao)
if equip then
local stid,stlv=fabaoHelper.getShentongid(equip)
fbSkillList[1]={stid,stlv}
end
self:refreshSkillGrid(self.fbSkillGrid,fbSkillList,eSkillTipsType.eDZSTSkill)
end

function UIDiscipleSkillInfoWin:refreshSkillGrid(skillGrid,skilList,st)
skillGrid:setChildLayoutGroupCreateItems(#skilList)
local gridlist=skillGrid:getChildLayoutGroupGridList()
local c=gridlist.Count
if c>0 then
for i=1,c do
local item=gridlist[i-1]
local d=skilList[i]
local skillID=d[1]
local skillLv=d[2]
local skillCfg

if st==eSkillTipsType.eDZSTSkill then
skillCfg=fabaoConfig.getShentongConfig(skillID)

local icon=skillModel.getSkillIconChange(skillCfg,self._netData)
item:SetChildIcon(0,iconHelper.getSkillIcon(icon),false)

item:SetChildImageExGray(0,false)

item:SetChildActive(1,false)

item:SetChildActive(4,true)
item:SetChildText(2,FMT.fmt('{0}级',skillLv))

item:SetChildActive(5,false)
else
skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0

local icon=skillModel.getSkillIconChange(skillCfg,self._netData)
item:SetChildIcon(0,iconHelper.getSkillIcon(icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

item:SetChildActive(4,not islock)
if not islock then
local c_skillLv=skillLv
if st==eSkillTipsType.eDZGFSkill then
c_skillLv=UIDiscipleModel:getSkillLv(self.disciple_guid,skillID,c_skillLv)
end
item:SetChildText(2,skillModel:getSkillLvStr(c_skillLv))
end

item:SetChildActive(5,islock)
end

item:SetChildButtonClick(3,function()
self:onSkillItemClick(st,skillID,skillLv)
end)
end
end
end

function UIDiscipleSkillInfoWin:initUsingGongFa()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self.usingGFList=UIDiscipleModel:getDiscipleUsingGFList(netData)
end

function UIDiscipleSkillInfoWin:refreshGFSkillSlot()
for i=1,2 do
self:refreshGFSkillSlotEx(i)
end
end

function UIDiscipleSkillInfoWin:setGFCanvas(sortLayer,sortOrder)
self.gfDescPanel:setChildCanvas(sortLayer,sortOrder)
end

function UIDiscipleSkillInfoWin:resetGFCanvas()
self.gfDescPanel:setChildRemoveCanvas()
end

function UIDiscipleSkillInfoWin:refreshGFSkillSlotEx(idx,showEffect)
local slot=self:getGFSkillSlot(idx)
local slotItem=slot:getChildWidgetBase()
local gfID=self.usingGFList[idx]
local hasGF=gfID>0
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
local unlock,limitjj=UIDiscipleModel.checkGFPosUnLock(idx,jjlv,false)

if hasGF then
local gfIcon=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'icon')
slotItem:SetChildIcon(0,iconHelper.getGongFaIcon(gfIcon),false)
end

slotItem:SetChildActive(7,hasGF)

local showAdd=not hasGF
if self.showType==dicipleType.eTemp then
showAdd=false
else
if showAdd then
showAdd=showAdd and unlock
end
end
slotItem:SetChildActive(1,showAdd)

local showlock=not unlock
if self.showType==dicipleType.eTemp then
showlock=false
end
slotItem:SetChildActive(10,showlock)

local showReplace=hasGF
if self.showType==dicipleType.eTemp then
showReplace=false
end
slotItem:SetChildActive(2,showReplace)

slotItem:SetChildActive(3,hasGF)
if hasGF then
local gflv=UIDiscipleModel:getDiscipleGFLevel(self.disciple_guid,gfID)
slotItem:SetChildText(4,UIGongFaModel:getGFLeverlStr(gflv))
end

local name_str=''
if hasGF then
local gfname=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'name')
name_str=string.format('<color=#7d3b17>%s</color>',gfname)
else
if unlock then
name_str='可装备'
else
name_str=FMT.fmt('<color=#c82c2c>{0}</color>',UIDiscipleModel.getJJNameCommon(limitjj,3))
end
end
if self.showType==dicipleType.eTemp then
name_str=''
end
slotItem:SetChildText(5,name_str)

local reddot=false
if self.showType==dicipleType.eSystem then
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
reddot=UIDiscipleModel:checkDiscipleGFSlotCanSetup(netData,idx)
end
slotItem:SetChildActive(6,reddot)

if showEffect then


end


local lvUpReddot=false
if hasGF then
if self.showType==dicipleType.eSystem then
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
lvUpReddot=UIDiscipleModel:checkDiscipleGFSlotCanUp(netData,idx)
end
end
slotItem:SetChildActive(11,lvUpReddot)
end

function UIDiscipleSkillInfoWin:refreshGFSkillSlotSelect(idx,flag)
local slot=self:getGFSkillSlot(idx)
local slotItem=slot:getChildWidgetBase()
self:refreshGFSkillSlotSelectEx(slotItem,flag)
end

function UIDiscipleSkillInfoWin:refreshGFSkillSlotSelectEx(slotItem,flag)
slotItem:SetChildActive(8,flag)
end

function UIDiscipleSkillInfoWin:getGFSkillSlot(idx)
if idx==1 then
return self.gfSlot1
else
return self.gfSlot2
end
end

function UIDiscipleSkillInfoWin:onGfSlot1()
if self.changing then return end
self:onGFSlotClick(1)
end

function UIDiscipleSkillInfoWin:onGfSlot2()
if self.changing then return end
self:onGFSlotClick(2)
end

function UIDiscipleSkillInfoWin:onGFSlotClick(idx)
if self.changing then return end

local isLDLock=UIDiscipleModel:checkDZClientState(self.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end

local gfID=self.usingGFList[idx]
local hasGF=gfID>0
if self.showType==dicipleType.eSystem then
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
if not UIDiscipleModel.checkGFPosUnLock(idx,jjlv,true)then
return
end
for i=1,2 do
local isselect=idx==i
self:refreshGFSkillSlotSelect(i,isselect)
end
local func=function()
if self==nil or self.isClose then return end
self:refreshGFSkillSlotSelect(idx,false)
end
local args={guid=self.disciple_guid,pos=idx,callback=func}
local win=UIManager:findActiveWindow('UIDiscipleGFSetupWin')
if win then
win:resetData(args)
else
UIManager:showWindow('UIDiscipleGFSetupWin',{guid=self.disciple_guid,pos=idx,callback=func})
end
else
if hasGF then
UIManager:showWindow('UIGongFaTipsTwoWin',{guid=self.disciple_guid,gfID=gfID})
end
end
end

function UIDiscipleSkillInfoWin:onFBItemClick(id,equipType,guid,attach)

if self.changing then return end

local isLDLock=UIDiscipleModel:checkDZClientState(self.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end

if id~=-1 then
if self.showType==dicipleType.eSystem then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eEquipWin,
itemguid=guid,
attach={diziguid=self.disciple_guid}})
else
tipsManager.showTips({formType=TIPS_FORM_TYPE.eSkillFabaoItem,
itemid=id,
itemguid=guid,
move=TIPS_MOVE_POS.eLeft})
end
else
if self.showType==dicipleType.eSystem then

equipListManager.showTips({movepos=TIPS_MOVE_POS.eLeft,diziguid=self.disciple_guid,equipType=equipType})
end
end
end

function UIDiscipleSkillInfoWin:onSkillItemClick(skillType,skillID,skillLv)
if self.changing then return end
if skillType==eSkillTipsType.eDZSTSkill or skillType==eSkillTipsType.eDZSkill then


local args={skillID=skillID,skillLv=skillLv,attend=skillType,dis_guid=self.disciple_guid,changLv=false,fromCfg=self.change==true}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
elseif skillType==eSkillTipsType.eDZGFSkill then

local args={skillID=skillID,skillLv=skillLv,attend=skillType,dis_guid=self.disciple_guid,changLv=true}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end
end

function UIDiscipleSkillInfoWin:rec_setupGF(pos,gfID,oldpos)
local isSetup=gfID>0
for i=1,2 do
local showEffect=isSetup and(i==pos)
self:refreshGFSkillSlotEx(i,showEffect)
end
self:refreshGFSkillGrid()
end

function UIDiscipleSkillInfoWin:rec_upGF(gfID,oldlv,newlv)
local pos=UIDiscipleModel:getDiscipleGFUsingPos(self.disciple_guid,gfID)
if pos~=nil then
self:refreshGFSkillSlotEx(pos)
end
self:refreshGFSkillGrid()
end

function UIDiscipleSkillInfoWin:rec_forgetGF(guid,gfID,pos)
self:initUsingGongFa()
self:refreshGFSkillSlot()

self:refreshGFSkillGrid()
end

function UIDiscipleSkillInfoWin:rec_learGF(guid,gfID)
self:initUsingGongFa()
self:refreshGFSkillSlot()
end

function UIDiscipleSkillInfoWin:rec_FBItemChange()
self:refreshFBSkillSlot(true)
self:refreshJobSkillGrid()
self:refreshFBSkillGrid()

equipListManager.closeTips()
end

function UIDiscipleSkillInfoWin:rec_lianhuaFB(guid)
self:refreshJobSkillGrid()
end

function UIDiscipleSkillInfoWin:onMoneyChanged(moneyType)
if moneyType==eMoneyType.mtChuanDao then

self:refreshGFSkillSlot()
else

self:refreshFBReddot()
end
end

function UIDiscipleSkillInfoWin:freshBenMingFabaoReddotNotify()
local dzguid=self.disciple_guid
local fabao=fabaoModel.getFabaoByDizi(dzguid)
if fabao==nil then return end
local isAbsorbExp=benMingFaBaoHelper.isAbsorbExp(dzguid)
if not isAbsorbExp then return end
local itemguid=fabao.itemguid
local oldKey=self.fabaoReddotKey
local newKey=benMingFaBaoSheetReddot.getItemKey(itemguid)
if newKey==oldKey then return end
if oldKey and self._onBenMingFabaoReddot then
reddotClassManager.unregister_event(oldKey,self._onBenMingFabaoReddot)
end
self._onBenMingFabaoReddot=function()
self:onBenMingFabaoReddot(itemguid)
end
self.fabaoReddotKey=newKey
reddotClassManager.register_event(newKey,self._onBenMingFabaoReddot)
end

function UIDiscipleSkillInfoWin:onBenMingFabaoReddot(itemguid)
local fabao=fabaoModel.getFabaoByDizi(self.disciple_guid)
if fabao and tostring(itemguid)==tostring(fabao.itemguid)then
self:refreshFBReddot()
end
end

function UIDiscipleSkillInfoWin:onFabaoJiLianOrTuPo()

self:refreshFBReddot()
end

function UIDiscipleSkillInfoWin:onDiscipleFaBaoChange(diziguid,changeType)
if not mathHelper.compareInt64(diziguid,self.disciple_guid)then
return
end

if changeType==3 or changeType==4 then

self:refreshFBReddot()
end
end

function UIDiscipleSkillInfoWin:onChangeSkillBtn()
self.changing=true
self.change=not self.change
local modelParam=self.changeCfg.model

local equip=ClothingModel:getEquipByDizi(self.disciple_guid)
if equip then
local clothingId=equip.itemid
if self.changeCfg.modelClothing and self.changeCfg.modelClothing[clothingId]then
modelParam=self.changeCfg.modelClothing[clothingId]
end
end

UIManager:invokeUIMethod("UIDiscipleRoleInfoWin","forceDiscipleModel",modelParam[1],modelParam[2],modelParam[3],function()
local jobSkillList=UIDiscipleModel:getDiscipleJobSkillList(self.disciple_guid)
local tmLv=UIDiscipleModel:getTianMingLevel(self.disciple_guid)
local tSkillList

for i=tmLv,0,-1 do
if self.changeCfg.skillList[i]then
tSkillList=self.changeCfg.skillList[i]
break
end
end
for i,v in pairs(tSkillList)do
local jobData=jobSkillList[i]
if jobData then
jobData[1]=v
else
jobSkillList[i]={v,0}
end
end

self:refreshSkillGrid(self.jobSkillGrid,jobSkillList,eSkillTipsType.eDZSkill)
self:showAllJobSkillEffect(self.jobSkillGrid,10413)
self.changing=false
end)
self.resetSkillBtn:setActive(true)
self.changeSkillBtn:setActive(false)
end

function UIDiscipleSkillInfoWin:onResetSkillBtn()
self.changing=true
self.change=not self.change
UIManager:invokeUIMethod("UIDiscipleRoleInfoWin","resetDiscipleModel",function()
local jobSkillList=UIDiscipleModel:getDiscipleJobSkillList(self.disciple_guid)
self:refreshSkillGrid(self.jobSkillGrid,jobSkillList,eSkillTipsType.eDZSkill)
self:showAllJobSkillEffect(self.jobSkillGrid,10413)
self.changing=false
end)
self.resetSkillBtn:setActive(false)
self.changeSkillBtn:setActive(true)
end

function UIDiscipleSkillInfoWin:refreshChangeBtn(skilList)
skilList=skilList or UIDiscipleModel:getDiscipleJobSkillList(self.disciple_guid)
self.changeCfg=nil
for i,v in ipairs(skilList)do
local d=skilList[i]
local skillID=d[1]
local cfg=cfgHelper.get1(cfg_skillchangeshowconfig_get,skillID)
if cfg then
self.changeCfg=cfg
break
end
end
self.changeSkillBtn:setActive(self.changeCfg~=nil)
self.resetSkillBtn:setActive(false)
end

function UIDiscipleSkillInfoWin:showAllJobSkillEffect(skillGrid,effect)
local gridlist=skillGrid:getChildLayoutGroupGridList()
for i=1,gridlist.Count do
local item=gridlist[i-1]
item:SetChildShowEffect(6,effect,true)
end
end

function UIDiscipleSkillInfoWin:refreshPageWin()
local dis_guid=self.disciple_guid
self:onShow({guid=dis_guid})
end
