







def_class("UIDiscipleInfoComponent",UIWindowBase)









function UIDiscipleInfoComponent:bindComponents()

self.dialogTx=UIText.get(self,0)
self.discipleModelRoot=UIObject.get(self,1)
self.infoGrd=UIObject.get(self,2)
self.dialog=UIObject.get(self,3)
self.kickoutBtn=UIButton.get(self,4)
self.wagesHelp=UIButton.get(self,5)
self.nameText=UIText.get(self,6)
self.discipleJobIcon=UIImage.get(self,7)
self.discipleJobIcon2=UIImage.get(self,8)
self.spBg=UIObject.get(self,9)

self.kickoutBtn:setButtonClick(function()self:onKickoutBtn()end)

self.wagesHelp:setButtonClick(function()self:onWagesHelp()end)



end


function UIDiscipleInfoComponent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dialogTx);self.dialogTx=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.infoGrd);self.infoGrd=nil;
_UIObject_release(self.dialog);self.dialog=nil;
_UIObject_release(self.kickoutBtn);self.kickoutBtn=nil;
_UIObject_release(self.wagesHelp);self.wagesHelp=nil;
_UIObject_release(self.nameText);self.nameText=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.spBg);self.spBg=nil;
end
















local _this=nil




function UIDiscipleInfoComponent:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onDiscipleBagAddItem,self.onDiscipleBagAddItem)
notifySystem:listenNotify(notifyConfig.onDiscipleBagDeleteItem,self.onDiscipleBagDeleteItem)
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.onDiscipleRemove)
end


function UIDiscipleInfoComponent:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onDiscipleBagAddItem,self.onDiscipleBagAddItem)
notifySystem:removelistener(notifyConfig.onDiscipleBagDeleteItem,self.onDiscipleBagDeleteItem)
notifySystem:removelistener(notifyConfig.onDiscipleRemove,self.onDiscipleRemove)
_this=nil
end




function UIDiscipleInfoComponent:onShow(argtable,afterOnloaded)
local isChangeDz=false
if not afterOnloaded then
isChangeDz=not mathHelper.compareInt64(self.disciple_guid,argtable.guid)
end
self.disciple_guid=argtable.guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
self:refreshModel()
self:refreshInfo()

self.menuPageIndex=argtable.menuPageIndex
local showKickout=self.menuPageIndex==1 and self.showType==dicipleType.eSystem
self.kickoutBtn:setActive(showKickout)

if isChangeDz then

self:hideSpeak()
end
end


function UIDiscipleInfoComponent:onHide()

end



function UIDiscipleInfoComponent:refreshInfo()
for i=0,5 do
local item=self.infoGrd:getChildCommonLayoutGroupWidgetItem(i)
local str=''
if i==0 then
str=FMT.fmt('<color=#7d3b17>道龄：</color>{0}年',UIDiscipleModel:getDiscipleAge(self.disciple_guid))
elseif i==1 then
local post=UIDiscipleModel:getDisciplePost(self.disciple_guid)
local postName=eZongMenPostType.getName(post)
str=FMT.fmt('<color=#7d3b17>职位：</color>{0}',postName)
elseif i==2 then
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
str=FMT.fmt('<color=#7d3b17>境界：</color>{0}',UIDiscipleModel:getJJNameEx(jjlv))
elseif i==3 then
local ltlv=UIDiscipleModel:getDiscipleLTLevel(self.disciple_guid)
str=FMT.fmt('<color=#7d3b17>炼体：</color>{0}',UIDiscipleModel:getLTNameEx(ltlv))
elseif i==4 then
local coupleName='无'
local coupleGuid=DiscipleCoupleModel:getDiscipleCoupleGuid(self.disciple_guid)
if coupleGuid then
coupleName=UIDiscipleModel:getDiscipleName(coupleGuid)
else
local haveFateCouple,fateCoupleId=DiscipleCoupleModel:getDiscipleFateCouple(self.disciple_guid)
if haveFateCouple then
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(fateCoupleId)
if not netData then
netData=UIDiscipleModel:getDiscipleDataByDiziId(fateCoupleId)
end
if netData then
coupleName=netData.disciplename
end
end
end
str=FMT.fmt('<color=#7d3b17>道侣：</color>{0}',coupleName)
elseif i==5 then
local num=UIDiscipleModel:getDisciplePostWages(self.disciple_guid)
str=FMT.fmt('<color=#7d3b17>俸禄：</color>{0}灵石/年',num)
end
item:SetChildText(0,str)
end
end

function UIDiscipleInfoComponent:refreshModel()

self.nameText:setText(UIDiscipleModel:getDiscipleName(self.disciple_guid))

local jobicon=UIDiscipleModel:getJobIconNameX(self.disciple_guid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(self.disciple_guid)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(self.disciple_guid,switchidx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end

comHelper.setChildInSideModel(self.discipleModelRoot,self.disciple_guid,nil,nil,0,-15,false,true)
end

function UIDiscipleInfoComponent.onDiscipleBagAddItem(discipleguid,items)
if mathHelper.compareInt64(discipleguid,_this.disciple_guid)and _this.menuPageIndex==2 then
local job=UIDiscipleModel:getDiscipleJob(_this.disciple_guid)
local cfg=cfgHelper.get1(cfg_disciplevocationbuildspeakconfig_get,job)
local library=cfg.bagChange and cfg.bagChange[1]or{}
local count=#library
if count>0 then
local index=math.random(count)
_this:speak(library[index])
end
end
end

function UIDiscipleInfoComponent.onDiscipleBagDeleteItem(discipleguid,itemid)
if discipleguid==_this.disciple_guid and _this.menuPageIndex==2 then
local job=UIDiscipleModel:getDiscipleJob(_this.disciple_guid)
local cfg=cfgHelper.get1(cfg_disciplevocationbuildspeakconfig_get,job)
local library=cfg.bagChange and cfg.bagChange[2]or{}
local count=#library
if count>0 then
local index=math.random(count)
_this:speak(library[index])
end
end
end

function UIDiscipleInfoComponent:speak(word)
self.dialogTx:setText(word)
if self.speakTimer~=nil then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

self.dialog:setChildCanvasGroupAlpha(1)
self.dialog:setScale(Vector3.zero)

self.dialog:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.dialog:setChildDOScale(1,0.1)
end)
self.speakTimer=self:delayDo(5,function()
return self:hideSpeak()
end)
end

function UIDiscipleInfoComponent:hideSpeak()
if self.speakTimer~=nil then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

self.dialog:setChildCanvasGroupDOFade(0,0.3)
end

function UIDiscipleInfoComponent.onDiscipleRemove(reason,guid)
if _this==nil then return end

if reason==discipleRemoveReason.eKickout then
_this:removeDisciple(guid)
end
end

function UIDiscipleInfoComponent:removeDisciple(guid)
oneTabScreenController:closeUI()
end

function UIDiscipleInfoComponent:onKickoutBtn()
local guid=self.disciple_guid
if not UIDiscipleModel:checkCanKickOutDzAndTips(guid,true)then
return
end
local flag=SiFangPingYaoModel:isCanKitOut(guid)
if flag then
UIManager.error("四方平妖挑战中，不可逐出")
return
end

local doFunc=function()
if not guid then return end
UIManager:showWindow('UIDiscipleKickoutWin',{guid=guid})
end

local curID=WenXinGuanModel:getDtDzGuid()

if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie3)and not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
if curID==guid then
UIManager.error('九重天劫期间，参与问心关的弟子无法逐出')
return
elseif WenXinGuanModel:checkDzWXGState(guid)then
UIManager.error('九重天劫期间，完成问心关的弟子无法逐出')
return
end
end
local xianmoCheckFunc=function()
if UIDiscipleModel:checkDiscipleXianMoVoc(guid)then
local showdata=
{
type='UIDialouge',
title='提示',
content='弟子已完成转职，是否驱逐？驱逐后将返还弟子在转职与问心关的所有材料与75%的传道点数与仙魔气',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=doFunc,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
elseif curID==guid or WenXinGuanModel:checkDzWXGState(guid)then
local showdata=
{
type='UIDialouge',
title='提示',
content='弟子参与了问心关，逐出将清除问心关状态并返回所有材料和75%传道点数，是否继续？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=doFunc,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
else
doFunc()
end
end

local coupleGuid=DiscipleCoupleModel:getDiscipleCoupleGuid(guid)
if coupleGuid then
local coupleName=UIDiscipleModel:getDiscipleName(coupleGuid)
local coupleSpeList=UIDiscipleModel:getDiscipleSpeciality(coupleGuid,DISCIPLE_SPECIALITY_TYPE.eDaoLv)or{}
local speStr=""
for _,v in pairs(coupleSpeList)do
local sid=v.param_1
local speName=UIDiscipleModel:getSpecialityName(DISCIPLE_SPECIALITY_TYPE.eDaoLv,sid,true)
speStr=string.format("%s“<color=#CA631D>%s</color>”",speStr,speName)
end
local content=string.format("逐出弟子将<color=#C82C2C>解除</color>与“<color=#CA631D>%s</color>”的<color=#C82C2C>道侣关系</color>,其道侣“<color=#CA631D>%s</color>”将<color=#C82C2C>失去特质</color>%s",coupleName,coupleName,speStr)
UIDialogManager.getConfirmDialog3(nil,content,xianmoCheckFunc,REPEAT_TYPE.eKickoutDiscipleCouple)
else
xianmoCheckFunc()
end
end

function UIDiscipleInfoComponent:onWagesHelp()
local offset=Vector2.New(15,10)
local desc_str=UIDiscipleModel:getDisciplePostWagesDesc(self.disciple_guid)
UIManager:showWindow('UIConditionTipsOne',{showType=2,str=desc_str,posItem=self.wagesHelp,pos=offset})
end