







def_class("UIDiscipleCoupleWin",UIWindowBase)









function UIDiscipleCoupleWin:bindComponents()

self.terminateBtn=UIButton.get(self,0)
self.redRope=UIObject.get(self,1)
self.roleListPanel=UIScrollView.get(self,2)
self.emptyImage=UIObject.get(self,3)
self.infoPanel=UIObject.get(self,4)
self.pairBtn=UIButton.get(self,5)
self.relieveEffect=UIObject.get(self,6)
self.manName=UIText.get(self,7)
self.womanName=UIText.get(self,8)
self.manModel=UIObject.get(self,9)
self.womanModel=UIObject.get(self,10)

self.terminateBtn:setButtonClick(function()self:onTerminateBtn()end)

self.pairBtn:setButtonClick(function()self:onPairBtn()end)



end


function UIDiscipleCoupleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.terminateBtn);self.terminateBtn=nil;
_UIObject_release(self.redRope);self.redRope=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.emptyImage);self.emptyImage=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.pairBtn);self.pairBtn=nil;
_UIObject_release(self.relieveEffect);self.relieveEffect=nil;
_UIObject_release(self.manName);self.manName=nil;
_UIObject_release(self.womanName);self.womanName=nil;
_UIObject_release(self.manModel);self.manModel=nil;
_UIObject_release(self.womanModel);self.womanModel=nil;
end



















function UIDiscipleCoupleWin:onLoaded(...)
self:bindComponents()
self._on_select_role=function(...)
self:on_select_role(...)
end
self.roleListPanel:setClickAction(self._on_select_role)
end


function UIDiscipleCoupleWin:__delete()
self:unbindComponents()
end




function UIDiscipleCoupleWin:onShow(argtable,afterOnloaded)
self.isAnim=false
self.coupleList=DiscipleCoupleModel:getCoupleList()
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
self.fateCouple=cfg.couple
self.selectIndex=1
self:refreshRoleListPanel()
self:refreshRightInfoPanel()




end


function UIDiscipleCoupleWin:onHide()

end



function UIDiscipleCoupleWin:refreshRoleListPanel()
local tNum=#self.coupleList
local fNum=#self.fateCouple
self.roleListPanel:freshGridsNum(tNum+fNum,tNum+fNum,1,true)
for i=1,tNum do
local item=self.roleListPanel:getGridObjectByindex(i-1)
local netdata=self.coupleList[i]
local manGuid=netdata.man
local womanGuid=netdata.woman

comHelper.setChildModelRawImage(item,manGuid,1,0,eHeadCenterType.eHead)
comHelper.setChildModelHeadIconBG(item,3,manGuid)
comHelper.setChildModelRawImage(item,womanGuid,2,0,eHeadCenterType.eHead)
comHelper.setChildModelHeadIconBG(item,4,womanGuid)

local isSelect=self.selectIndex==i
self:changItemSelect(item,isSelect)
end
for i=tNum+1,tNum+fNum do
local idx=i-tNum
local item=self.roleListPanel:getGridObjectByindex(i-1)
local netdata=self.fateCouple[idx]
local manGuid=netdata[1]
local womanGuid=netdata[2]
local manData=UIDiscipleModel:getDiscipleDataByDiziId(manGuid)
local womanData=UIDiscipleModel:getDiscipleDataByDiziId(womanGuid)

comHelper.setChildModelRawImageByDiziId(item,manGuid,1,0,eHeadCenterType.eHead)
local manColor=manData.imageInfo.color
comHelper.setChildModelHeadIconBGByColor(item,3,manColor)

comHelper.setChildModelRawImageByDiziId(item,womanGuid,2,0,eHeadCenterType.eHead)
local womanColor=womanData.imageInfo.color
comHelper.setChildModelHeadIconBGByColor(item,4,womanColor)

local isSelect=self.selectIndex==i
self:changItemSelect(item,isSelect)
end
end

function UIDiscipleCoupleWin:refreshRightInfoPanel()
local couple=self.coupleList[self.selectIndex]
local fateCouple=self.fateCouple[self.selectIndex-#self.coupleList]
if couple then
self.emptyImage:setActive(false)
self.infoPanel:setActive(true)
local manGuid=couple.man
local womanGuid=couple.woman
local manName=UIDiscipleModel:getDiscipleName(manGuid)
local womanName=UIDiscipleModel:getDiscipleName(womanGuid)
local manData=UIDiscipleModel:getDiscipleData(manGuid)
local womanData=UIDiscipleModel:getDiscipleData(womanGuid)
local offset=cfgHelper.get1(cfg_disciplecoupleconfig_get,1).offset or{}
local manOffset=offset[manData.id]or{0,0}
local womanOffset=offset[womanData.id]or{0,0}

self.manName:setText(manName)
self.womanName:setText(womanName)

comHelper.setChildInSideModel(self.manModel,manGuid,0.7,nil,manOffset[1],manOffset[2],false,false,nil)
comHelper.setChildInSideModel(self.womanModel,womanGuid,0.7,nil,womanOffset[1],womanOffset[2],false,false,nil)

self.winlua:SetChildUIModelShowTarget(self.redRope:getID(),5384,1,{},eAnimationID.stand)
elseif fateCouple then
self.emptyImage:setActive(false)
self.infoPanel:setActive(true)
local manGuid=fateCouple[1]
local womanGuid=fateCouple[2]
local manData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(manGuid)
if not manData then
manData=UIDiscipleModel:getDiscipleDataByDiziId(manGuid)
end
local womanData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(womanGuid)
if not womanData then
womanData=UIDiscipleModel:getDiscipleDataByDiziId(womanGuid)
end

self.manName:setText(manData.disciplename)
self.womanName:setText(womanData.disciplename)

local info1=manData.imageInfo
local modelParams1=UIDiscipleModel:getDiscipleInsideModelInfoByData(info1)
self.winlua:SetChildUIModelShowTarget(self.manModel:getID(),modelParams1.body,1,modelParams1.componets,eAnimationID.stand)
local info2=womanData.imageInfo
local modelParams2=UIDiscipleModel:getDiscipleInsideModelInfoByData(info2)
self.winlua:SetChildUIModelShowTarget(self.womanModel:getID(),modelParams2.body,1,modelParams2.componets,eAnimationID.stand)

self.winlua:SetChildUIModelShowTarget(self.redRope:getID(),5384,1,{},eAnimationID.stand)
else
self.emptyImage:setActive(true)
self.infoPanel:setActive(false)
self.manName:setText("")
self.womanName:setText("")
self.manModel:setChildUIModelRemoveTarget()
self.womanModel:setChildUIModelRemoveTarget()
self.winlua:SetChildUIModelRemoveTarget(self.redRope:getID())
end
end


function UIDiscipleCoupleWin:on_select_role(id,index,guid,attach)
if self.isAnim then
return
end
if self.selectIndex==index then return end
self:onChangeSelect(self.selectIndex,index)
end

function UIDiscipleCoupleWin:changItemSelect(item,isSelect)
item:SetChildActive(0,isSelect)
end

function UIDiscipleCoupleWin:onChangeSelect(old,cur,isjump)
if old==cur then return end
self.selectIndex=cur
if old~=nil then
local olditem=self.roleListPanel:getGridObjectByindex(old-1)
self:changItemSelect(olditem,false)
end
local item=self.roleListPanel:getGridObjectByindex(cur-1)
self:changItemSelect(item,true)
self:refreshRightInfoPanel()
if isjump then
self.roleListPanel:jumpToLockX(cur)
end
end
function UIDiscipleCoupleWin:test()
local random_dis1=UIDiscipleModel:getRandomDiscipleData().discipleguid
local random_dis2=UIDiscipleModel:getRandomDiscipleData().discipleguid
self:onTerminateCallBack(random_dis1,random_dis2)
end

function UIDiscipleCoupleWin:onTerminateCallBack(guid1,guid2)
self.isAnim=true
local imageInfo1=UIDiscipleModel:getDiscipleImageInfo(guid1)
local sex1=imageInfo1.sex
local manGuid=sex1==1 and guid1 or guid2
local womanGuid=sex1==1 and guid2 or guid1
local releationValue1=UIDiscipleModel:getReleationValue(manGuid,womanGuid,DISCIPLE_RELATION_TYPE.eFriend)
local releationType1=UIDiscipleModel:getRelationChildType(DISCIPLE_RELATION_TYPE.eFriend,releationValue1)
local releationValue2=UIDiscipleModel:getReleationValue(womanGuid,manGuid,DISCIPLE_RELATION_TYPE.eFriend)
local releationType2=UIDiscipleModel:getRelationChildType(DISCIPLE_RELATION_TYPE.eFriend,releationValue2)
local cfg=cfg_relievecouplestoryconfig()
local storyId
if cfg[releationType1]and cfg[releationType1][releationType2]then
storyId=cfg[releationType1][releationType2].storyId
end
if storyId then
self.winlua:SetChildModelAnimationState(self.redRope:getID(),2195)
local func=function()


UIManager:invokeUIMethod("UIDiscipleCoupleWin","onShow")
end
self:delayDo(2,func)
else
self.winlua:SetChildModelAnimationState(self.redRope:getID(),2195)
local func=function()
UIManager:invokeUIMethod("UIDiscipleCoupleWin","onShow")
end
self:delayDo(2,func)

end
self.relieveEffect:setChildShowEffect(20206,true)
end

function UIDiscipleCoupleWin:onTerminateBtn()
if self.isAnim then
return
end
if self.selectIndex>#self.coupleList then
UIManager.error("该道侣为指定道侣，无法解除道侣关系")
return
end


local couple=self.coupleList[self.selectIndex]
local manGuid=couple.man
local womanGuid=couple.woman

local manGuidStr=tostring(manGuid)
if manGuidStr~='0'and
DiscipleCoupleModel:getCoupleDzIsLive(manGuidStr)and
not UIDiscipleModel:checkDZStateToDoSomething(manGuid,eCheckDiscipleStateOpType.eFireDaoLv,true)then
return
end

local womanGuidStr=tostring(womanGuid)
if womanGuidStr~='0'and
DiscipleCoupleModel:getCoupleDzIsLive(womanGuidStr)and
not UIDiscipleModel:checkDZStateToDoSomething(womanGuid,eCheckDiscipleStateOpType.eFireDaoLv,true)then return end

local manName=UIDiscipleModel:getDiscipleName(manGuid)
local womanName=UIDiscipleModel:getDiscipleName(womanGuid)
local manSpeList=UIDiscipleModel:getDiscipleSpeciality(manGuid,DISCIPLE_SPECIALITY_TYPE.eDaoLv)or{}
local womanSpeList=UIDiscipleModel:getDiscipleSpeciality(womanGuid,DISCIPLE_SPECIALITY_TYPE.eDaoLv)or{}
local commonSpeList={}
for i,v in ipairs(manSpeList)do
if not commonSpeList[v.param_1]then
commonSpeList[v.param_1]=true
end
end
for i,v in ipairs(womanSpeList)do
if not commonSpeList[v.param_1]then
commonSpeList[v.param_1]=true
end
end
local speStr=""
for sid,_ in pairs(commonSpeList)do
local speName=UIDiscipleModel:getSpecialityName(DISCIPLE_SPECIALITY_TYPE.eDaoLv,sid,true)
speStr=string.format("%s“%s”",speStr,speName)
end

local content=string.format("解除道侣关系，弟子将失去道侣专属特质%s\n祖师是否依然解除？",speStr)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='解除',
canceltext='取消',
allowclickBG='false',
okcallback=function()
DiscipleCoupleController.send_2_145(manGuid,womanGuid)
end,
showclosebtn=true,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()
end

function UIDiscipleCoupleWin:onPairBtn()
if self.isAnim then
return
end
UIManager:showWindow("UIDiscipleCoupleSelectWin")
end