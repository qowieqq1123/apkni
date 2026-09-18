







def_class("UIItemRecruitDiscipleInfoTwoWin",UIWindowBase)









function UIItemRecruitDiscipleInfoTwoWin:bindComponents()

self.alllAttrPointNumText=UIText.get(self,0)
self.descListPanel=UIObject.get(self,1)
self.guanlianBtn=UIButton.get(self,2)
self.jobSkillGrid=UIObject.get(self,3)
self.leftPanel=UIObject.get(self,4)
self.modelMask=UIObject.get(self,5)
self.polygonAttrPanel=UIObject.get(self,6)
self.rightPanel=UIObject.get(self,7)
self.root=UIObject.get(self,8)

self.guanlianBtn:setButtonClick(function()self:onGuanlianBtn()end)



end


function UIItemRecruitDiscipleInfoTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.alllAttrPointNumText);self.alllAttrPointNumText=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.guanlianBtn);self.guanlianBtn=nil;
_UIObject_release(self.jobSkillGrid);self.jobSkillGrid=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.modelMask);self.modelMask=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.root);self.root=nil;
end

















function UIItemRecruitDiscipleInfoTwoWin:onLoaded(...)
self:bindComponents()
end


function UIItemRecruitDiscipleInfoTwoWin:__delete()
local callback=self.closeCallBack
if callback then
callback()
self.closeCallBack=nil
end

self:unbindComponents()
end


function UIItemRecruitDiscipleInfoTwoWin:onHide()

end




function UIItemRecruitDiscipleInfoTwoWin:onShow(argtable,afterOnloaded)
self.dzItemId=argtable.itemId
self.closeCallBack=argtable.closeCallBack
self.defaultVersionId=pfwindowslController:getGameVersion()
local itemCfg=itemsConfig.getConfig(self.dzItemId)
local funcparam=itemCfg.funcparam
local itemType=funcparam.type
if itemType==item_funtion_type.disciple then
self.dzData=UIDiscipleModel:getItemDiscipleDataByItemId(self.dzItemId)
elseif itemType==item_funtion_type.selectDisciple then
self.dzItemIndex=argtable.dzItemIndex
self.dzData=UIDiscipleModel:getItemDiscipleDataByItemId(self.dzItemId,self.dzItemIndex)
end

local isSpecial=UIDiscipleModel:hasSpecialDiscipleLihuiByDiscipleId(self.dzData.id)or false
self.isNeedMask=not isSpecial
local maskCmp=self.modelMask:getCommonComponent('RectMask2D')
if maskCmp then
if self.isNeedMask then

maskCmp.enabled=true
else

maskCmp.enabled=false
end
end

self:refreshWin()

local showGlBtn=false
local isShowbtn=cfgHelper.get2(cfg_linkageresourceconfig_get,liandongZY.dizi,"isShowbtn")
if isShowbtn and isShowbtn[self.defaultVersionId]then
local glDiziID=liandonModel:CheckDiZi_Guanlian(self.dzData.id)
local guanLianDzIDList=isShowbtn[self.defaultVersionId]
for _,v in ipairs(guanLianDzIDList)do
if v==self.dzData.id or v==glDiziID then
showGlBtn=true
break
end
end
end
self.guanlianBtn:setActive(showGlBtn)
end

function UIItemRecruitDiscipleInfoTwoWin:refreshWin()
local ddata=self.dzData
local info=ddata.imageInfo

local leftWidget=self.leftPanel:getChildWidgetBase()



local args={bgFisrt=true}
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)
leftWidget:SetChildUIModelShowTarget(1,modelParams.body,1,modelParams.componets,eAnimationID.stand)

local jobicon=UIDiscipleModel:getJobIconName(info.job)
leftWidget:SetChildCSImageSprite(2,globalABLookup.global,jobicon)

leftWidget:SetChildText(3,ddata.disciplename)

local sex_str=FMT.fmt('性别：<color=#181412>{0}</color>',cfgHelper.get2(cfg_disciplesexconfig_get,info.sex,'name'))
leftWidget:SetChildText(4,sex_str)

local race_str=FMT.fmt('种族：<color=#181412>{0}</color>',cfgHelper.get2(cfg_discipleraceconfig_get,info.race,'name'))
leftWidget:SetChildText(5,race_str)

local stand_str=FMT.fmt('立场：<color=#181412>{0}</color>',cfgHelper.get2(cfg_disciplestandconfig_get,ddata.stand,'name'))
leftWidget:SetChildText(6,stand_str)


self.desclist=UIDiscipleModel:getDiscipleSpecialityConfigByData(ddata,true)
local dataNum=#self.desclist
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local cfg=self.desclist[i]
local name=cfg.name
local framecolor=cfg.framecolor
local item=gridlist[i-1]
item:SetChildActive(-1,true)
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onDescSlotClick(i)
end)
end
end


local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
for i,v in ipairs(ddata.attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
end
local tVal=0
local wiget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=ddata.attrList[attrType]==0 and 1 or ddata.attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#069067>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
tVal=tVal+v
end
wiget:SetChildUIPolygonImage(6,ratelist,0)

local color=info.color
local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)
self.alllAttrPointNumText:setText(FMT.fmt('总值：{0}',tVal))


local skillList=self:GetJobSkillList(ddata)
self.jobSkillGrid:setChildLayoutGroupCreateItems(#skillList)
local items=self.jobSkillGrid:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local sdata=skillList[i+1]
local skillID=sdata[1]
local skillLv=sdata[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0
item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),true)
item:SetChildImageExGray(0,islock)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)
local wincfg=UIManager.get_window_config('UIItemRecruitDiscipleInfoTwoWin')
local canvasIdx=wincfg.canvas
item:SetChildButtonClick(3,function()
UIManager:showWindow('UIDiscipleJobSkillTipsWin',{skillID=skillID,skillLv=skillLv,attend=1,canvasIdx=canvasIdx})
end)
item:SetChildActive(4,not islock)
if not islock then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end
item:SetChildActive(5,islock)
end
end

function UIItemRecruitDiscipleInfoTwoWin:GetJobSkillList(data)
local imageInfo=data.imageInfo
local groupid=data.vocsgidx
local result=UIDiscipleModel:getDiscipleJobSkillListEx(groupid,imageInfo.job,data.jingjielv)
return result
end

function UIItemRecruitDiscipleInfoTwoWin:onDescSlotClick(idx)
local cfg=self.desclist[idx]
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)
local ddata=self.dzData

if UIDiscipleModel.onClickClientSpeciality(item,ddata,cfg,eDirectionType.eLeft)then
return
end

UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guidNetData=ddata,config=cfg})
end

function UIItemRecruitDiscipleInfoTwoWin:getPorSkillDatas(proskilllist)
local list={}
if not proskilllist then
return list
end
local len=#proSkillSort
for i=1,len do
local ptype=proSkillSort[i]
local data=proskilllist[ptype]
if data.level>0 then
table.insert(list,{type=ptype,level=data.level})
end
end
return list
end

function UIItemRecruitDiscipleInfoTwoWin:onGuanlianBtn()
local arg={}
if self.dzData then
arg.dzid=self.dzData.id
end
UIManager:showWindow("UIGuanLianWin",arg)
end
