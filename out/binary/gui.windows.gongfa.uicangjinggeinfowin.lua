







def_class("UICangJingGeInfoWin",UIWindowBase)









function UICangJingGeInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.postIcon=UIImage.get(self,1)
self.tipsText=UIText.get(self,2)
self.discipleRoot=UIObject.get(self,3)
self.build=UIObject.get(self,4)
self.descText1=UIText.get(self,5)
self.descText2=UIText.get(self,6)
self.descText3=UIText.get(self,7)
self.cddNum=UIText.get(self,8)
self.questionBtn=UIButton.get(self,9)
self.discipleInfoPanel=UIObject.get(self,10)
self.colorSign=UIImage.get(self,11)
self.discipleModelRoot=UIObject.get(self,12)
self.cddIcon=UIImage.get(self,13)
self.discipleNameText=UIText.get(self,14)
self.discipleJobIcon=UIImage.get(self,15)
self.posBtnText=UIText.get(self,16)
self.discipleJobIcon2=UIImage.get(self,17)
self.spBg=UIObject.get(self,18)

self.questionBtn:setButtonClick(function()self:onQuestionBtn()end)



end


function UICangJingGeInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.postIcon);self.postIcon=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.discipleRoot);self.discipleRoot=nil;
_UIObject_release(self.build);self.build=nil;
_UIObject_release(self.descText1);self.descText1=nil;
_UIObject_release(self.descText2);self.descText2=nil;
_UIObject_release(self.descText3);self.descText3=nil;
_UIObject_release(self.cddNum);self.cddNum=nil;
_UIObject_release(self.questionBtn);self.questionBtn=nil;
_UIObject_release(self.discipleInfoPanel);self.discipleInfoPanel=nil;
_UIObject_release(self.colorSign);self.colorSign=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.cddIcon);self.cddIcon=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.posBtnText);self.posBtnText=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.spBg);self.spBg=nil;
end

















function UICangJingGeInfoWin:onLoaded(...)
self:bindComponents()
end


function UICangJingGeInfoWin:__delete()
self:unbindComponents()
end


function UICangJingGeInfoWin:onHide()

end

function UICangJingGeInfoWin:doFadeIn(fadeInData,old_page,page)
local delay=0
if fadeInData then
delay=delay+fadeInData[1]
end
if old_page==1 then
delay=delay+0.2
end
if delay>0 then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.5,nil)
end
self:delayDo(delay,func)
else
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5,nil)
end
end




function UICangJingGeInfoWin:onShow(argtable,afterOnloaded)
local fadeInData=argtable.fadeInData
if not afterOnloaded then
fadeInData=nil
end
local page=argtable.page
local old_page=argtable.old_page
self:doFadeIn(fadeInData,old_page,page)

self.bdData=argtable.bdData
self.postType=eZongMenPostType.eChuanGong
local list=UIDiscipleModel:getDiscipleByZongMenPost(self.postType)or{}
self.hasZhangLao=#list>0
if self.hasZhangLao then
self.zhanglao_data=list[1]
end


local pIcon=UISectPalaceModel:getPostIcon(self.postType)
self.postIcon:setSprite(globalABLookup.diciplemain,pIcon)

self:refreshZhangLaoInfo()
self:refreshView()
end

function UICangJingGeInfoWin:refreshZhangLaoInfo()
self.discipleRoot:setActive(self.hasZhangLao)
if self.hasZhangLao then
local netData=self.zhanglao_data
local dis_guid=netData.discipleguid

self.discipleModelRoot:setChildUIModelRemoveTarget()
comHelper.setChildInSideModel(self.discipleModelRoot,dis_guid,nil,nil,0,0,false,true)

local dis_name=UIDiscipleModel:getDiscipleName(dis_guid)
self.discipleNameText:setText(dis_name)

local jobicon=UIDiscipleModel:getJobIconNameX(dis_guid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(dis_guid)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(dis_guid,switchidx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end

local color=UIDiscipleModel:getDiscipleColor(dis_guid)
local color_icon=FMT.fmt('image_pinjishibie_{0}',color)
self.colorSign:setSprite(globalABLookup.global,color_icon)

local grids=self.discipleInfoPanel:getChildCommonLayoutGroupWidgetList()

local jobstr=UIDiscipleModel:getJobNameX(dis_guid)
grids[0]:SetChildText(0,FMT.fmt('职业：<color=#7d3b17>{0}</color>',jobstr))

local zmname=UISettingModel:getZMName()
grids[1]:SetChildText(0,FMT.fmt('门派：<color=#7d3b17>{0}</color>',zmname~=''and zmname or'暂无'))

local jjlv=netData.jingjielv
local jjstr=UIDiscipleModel:getJJNameEx(jjlv)
grids[2]:SetChildText(0,FMT.fmt('境界：<color=#7d3b17>{0}</color>',jjstr))

local ltlv=netData.liantilv
local ltstr=UIDiscipleModel:getLTNameEx(ltlv)
grids[3]:SetChildText(0,FMT.fmt('炼体：<color=#7d3b17>{0}</color>',ltstr))


self.tipsText:setText('')
self.posBtnText:setText('更换')
else

self.discipleModelRoot:setChildUIModelRemoveTarget()

self.tipsText:setText('尚未委任传功长老')
self.posBtnText:setText('委任')
end
end

function UICangJingGeInfoWin:refreshView()

local models=cfgHelper.get2(cfg_monijybuildconfig_get,self.bdData.build_id,'model')
local modelID=models[self.bdData.level]
self.build:setChildUIModelShowTarget(modelID,0.3,nil,eAnimationID.bd_stand)

self.descText1:setText(cfgHelper.get1(cfg_lang_get,'cangjingge_desc_1'))
self.descText2:setText(cfgHelper.get1(cfg_lang_get,'cangjingge_desc_2'))
self.descText3:setText(cfgHelper.get1(cfg_lang_get,'cangjingge_desc_3'))

self.cddIcon:setImageIcon(moneyModel.getIconNameEx(eMoneyType.mtChuanDao),true)
local cddNum=moneyAutoIncreaseModel:ccdNum(eMoneyType.mtChuanDao)
cddNum=math.floor(cddNum)
self.cddNum:setText(FMT.fmt('每年获得传道点数：{0}',cddNum))
end

function UICangJingGeInfoWin:onPosBtnClick()
local func=function()
UIFullCangJingGeControl:showMyWindowEx(FULL_TAB_TYPE.eGongFaInfo)
end
local flag=UIFullSectPalaceControl:showMyWindowEx(FULL_TAB_TYPE.eSectPalacePost,func)
end

function UICangJingGeInfoWin:onMoneyBtn()
local pos=Vector2.New(16,10)
local rule_str=cfgHelper.getlang(FMT.fmt('money_tips_{0}',eMoneyType.mtChuanDao))
UIManager:showWindow('UIConditionTipsOne',{str=rule_str,posItem=self.cddIcon,pos=pos,showType=2})
end

function UICangJingGeInfoWin:onQuestionBtn()
local pos=Vector2.New(16,10)

local rule_str=cfgHelper.getlang(FMT.fmt('money_tips_{0}',eMoneyType.mtChuanDao))
UIManager:showWindow('UIConditionTipsOne',{str=rule_str,posItem=self.questionBtn,pos=pos,showType=2})
end