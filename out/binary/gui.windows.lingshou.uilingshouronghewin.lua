







def_class("UILingShouRongHeWin",UIWindowBase)









function UILingShouRongHeWin:bindComponents()

self.root=UIObject.get(self,0)
self.leftPanel=UIObject.get(self,1)
self.rightPanel=UIObject.get(self,2)
self.planBtn=UIButton.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.changeBtn=UIButton.get(self,5)
self.jingjieDropdown=UIDropdown.get(self,6)
self.colorDropdown=UIDropdown.get(self,7)
self.autoBtn=UIButton.get(self,8)
self.commitBtn=UIButton.get(self,9)

self.planBtn:setButtonClick(function()self:onPlanBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.autoBtn:setButtonClick(function()self:onAutoBtn()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UILingShouRongHeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.planBtn);self.planBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.jingjieDropdown);self.jingjieDropdown=nil;
_UIObject_release(self.colorDropdown);self.colorDropdown=nil;
_UIObject_release(self.autoBtn);self.autoBtn=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
end
















local leftChild={
lingshouModelShow=0,
lingshoufight=1,
lingshoufightTx=2,
bianyi=3,
changeBtn=4,
helpBtn=5,
planBtn=6,
lingshouName=7,
}
local rightChild={
jingjieTx=0,
ntjingjieTx=1,
jingjieProgress=2,
xuemaiTx=3,
xuemaiProgress=4,
selectGrid=5,
btnsObj=6,
infoRoot=7,
noneRoot=8,
jingjieSubProgress=9,
xuemaiSubProgress=10,
}
local _this=nil
local colorSavaKey='lingshouRongHeColor1'
local jjSavaKey='lingshouRongHeJJ1'
local slotMax=4


function UILingShouRongHeWin:onLoaded(...)
self:bindComponents()
_this=self

self.colorSortTypeName={}
for i=1,5 do
table.insert(self.colorSortTypeName,FMT.fmt('{0}及以下',eQualityColorName[i]))
end
self.jjSortTypeName={}
local jjfloors=cfgHelper.getglobal('jingjiename')
for i,v in ipairs(jjfloors)do
table.insert(self.jjSortTypeName,FMT.fmt('{0}及以下',v))
end
self.colorDropdown:setChangeAction(function(...)self:onColorChange(...)end)
self.jingjieDropdown:setChangeAction(function(...)self:onJingJieChange(...)end)

notifySystem:listenNotify(notifyConfig.onLingShouAttrChange,self.onLingShouAttrChange)
notifySystem:listenNotify(notifyConfig.onLingShouRongHe,self.onLingShouRongHe)

self.rightWidget=self.rightPanel:getWidgetBase()
self.leftWidget=self.leftPanel:getWidgetBase()
end


function UILingShouRongHeWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onLingShouAttrChange,self.onLingShouAttrChange)
notifySystem:removelistener(notifyConfig.onLingShouRongHe,self.onLingShouRongHe)
end

function UILingShouRongHeWin:doFadeIn(delay,duration)
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

function UILingShouRongHeWin.onLingShouAttrChange(guid,attrType)
if _this==nil then return end
if not mathHelper.compareInt64(guid,_this.select_ls)then return end

_this:refreshFightView()
end

function UILingShouRongHeWin.onLingShouRongHe(guid)
if _this==nil then return end


_this:rece_RongHe(guid)
end


function UILingShouRongHeWin:onHide()

end




function UILingShouRongHeWin:onShow(argtable,afterOnloaded)


if argtable==nil then return end

local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end

self.entityId=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(self.entityId)

self.jjSortType=userActorSetting.get(jjSavaKey,1)
self.jingjieDropdown:setOption(self.jjSortTypeName)
self.jingjieDropdown:setValue(self.jjSortType-1)

self.colorSortType=userActorSetting.get(colorSavaKey,1)
self.colorDropdown:setOption(self.colorSortTypeName)
self.colorDropdown:setValue(self.colorSortType-1)
self.lockRefresh=false

local select_ls=self.select_ls or lingshouModel:getJiuLiDianSelect1(self.bdData.un_build_id)
if select_ls then
local select_lsData=lingshouModel:getLingShouData(select_ls)
if not select_lsData then
select_ls=nil
end
end

self:onSelectLingShou(select_ls)





end

function UILingShouRongHeWin:initAddLS()
self.addLSList={}
self.addLSData=lingshouModel.getRongHeData(nil,self.addLSList)
end

function UILingShouRongHeWin:setSelect(guid,save)
self.select_ls=guid
lingshouModel:setJiuLiDianSelect1(self.bdData.un_build_id,self.select_ls)
self:initAddLS()
end

function UILingShouRongHeWin:onPlanBtn()
local args={
current=self.select_ls,
callback=function(guid)
self:onSelectLingShou(guid)
end
}
lingshouSelectController:openLingShouSelect(args)
end

function UILingShouRongHeWin:onHelpBtn()
local d={}
d.title='灵兽融合'
d.mode=3
d.name='lingshou_ronghe_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UILingShouRongHeWin:onChangeBtn()
local args={
current=self.select_ls,
callback=function(guid)
self:onSelectLingShou(guid)
end
}
lingshouSelectController:openLingShouSelect(args)
end

function UILingShouRongHeWin:onSelectLingShou(guid)
self:setSelect(guid)
self:refreshLeft()
self:refreshRight()
end

function UILingShouRongHeWin:refreshFightView()
local fight=lingshouModel:getFightValue(self.select_ls)
self.leftWidget:SetChildText(leftChild.lingshoufightTx,tostring(fight))
self.leftWidget:ForceLayoutRect(leftChild.lingshoufight)
end

function UILingShouRongHeWin:refreshLeft()
local show=self.select_ls~=nil
self.leftWidget:SetChildActive(leftChild.planBtn,not show)
self.leftWidget:SetChildActive(leftChild.changeBtn,show)
self.leftWidget:SetChildActive(leftChild.lingshoufight,show)
if show then
local lsData=lingshouModel:getLingShouData(self.select_ls)
local fight=lingshouModel.getFightValueEx(lsData)
local lscfg=lsData.cfg
local modelParams=lingshouModel.getModelParamsEx(lscfg.model)
local scale=0.8
self.leftWidget:SetChildText(leftChild.lingshoufightTx,tostring(fight))
self.leftWidget:SetChildUIModelRemoveTarget(leftChild.lingshouModelShow)
self.leftWidget:SetChildUIModelShowTarget(leftChild.lingshouModelShow,modelParams.body,scale,modelParams.componets,0,false,true)
self.leftWidget:SetChildUIModelShowTargetOffset(leftChild.lingshouModelShow,0,-350)
self.leftWidget:SetChildActive(leftChild.bianyi,lscfg.bianyi==1)
self.leftWidget:SetChildText(leftChild.lingshouName,lsData.name)
else
self.leftWidget:SetChildUIModelRemoveTarget(leftChild.lingshouModelShow)
self.leftWidget:SetChildActive(leftChild.bianyi,false)
self.leftWidget:SetChildText(leftChild.lingshouName,"")
end
end




function UILingShouRongHeWin:refreshRight()
local show=self.select_ls~=nil
self.rightWidget:SetChildActive(rightChild.infoRoot,show)
self.rightWidget:SetChildActive(rightChild.noneRoot,not show)
if show then
self:refreshSelectGrid()
self:refreshLingShouInfo(true)
end
end

function UILingShouRongHeWin:refreshLingShouInfo(init)
local guid=self.select_ls
local lsData=lingshouModel:getLingShouData(guid)
local lscfg=lsData.cfg
local curlv=lsData.jj_lvl
local curexp=lsData.jj_exp

local rightWidget=self.rightWidget

local jj_str=lingshouModel:getJJName(guid,2)
rightWidget:SetChildText(rightChild.jingjieTx,FMT.fmt("境界：{0}",jj_str))

self.isfull=lingshouModel:checkJJFull(guid)
self.needBroke=false
if self.isfull then

rightWidget:SetChildActive(rightChild.ntjingjieTx,false)

if init then
rightWidget:SetChildProgressValue(rightChild.jingjieProgress,1,1)
else
rightWidget:SetChildProgress(rightChild.jingjieProgress,1,1)
end
rightWidget:SetChildProgressText(rightChild.jingjieProgress,'满级')
else
local needBroke,brokeCost=lingshouModel:checkJJNeedBroke(guid)
self.needBroke=needBroke
if needBroke then

rightWidget:SetChildActive(rightChild.ntjingjieTx,false)

local maxexp=cfgHelper.get2(cfg_lingshoujingjieconfig_get,curlv,'xiuwei')
if init then
rightWidget:SetChildProgressValue(rightChild.jingjieSubProgress,maxexp,maxexp)
else
rightWidget:SetChildProgress(rightChild.jingjieSubProgress,maxexp,maxexp)
end
rightWidget:SetChildProgressText(rightChild.jingjieProgress,FMT.fmt('{0}/{1}',curexp,maxexp))

local addexp=self.addLSData.jjexp
local progress_str
if addexp>0 then
progress_str=FMT.fmt('{0}<color=#549327>(+{1})</color>/{2}',curexp,addexp,maxexp)
else
progress_str=FMT.fmt('{0}/{1}',curexp,maxexp)
end
rightWidget:SetChildProgressText(rightChild.jingjieProgress,progress_str)
else
local addexp=self.addLSData.jjexp
local changlv=curlv
local changeexp=curexp
if addexp>0 then
changlv,changeexp=lingshouModel:jjChangeAddExp(curlv,curexp,addexp)
end
local addlv=changlv-curlv
self.tempfull=lingshouModel.checkJJFullEx(changlv,lsData.generation)

local up=addlv>0
rightWidget:SetChildActive(rightChild.ntjingjieTx,up)
if up then
rightWidget:SetChildText(rightChild.ntjingjieTx,lingshouModel.getJJNameEx(changlv,2))
end

local maxexp=cfgHelper.get2(cfg_lingshoujingjieconfig_get,curlv,'xiuwei')

if init then
rightWidget:SetChildProgressValue(rightChild.jingjieSubProgress,curexp,maxexp)
else
rightWidget:SetChildProgress(rightChild.jingjieSubProgress,curexp,maxexp)
end

local subCur=self.tempfull and maxexp or math.min(curexp+addexp,maxexp)








if init then
rightWidget:SetChildProgressValue(rightChild.jingjieProgress,subCur,maxexp)
else
rightWidget:SetChildProgress(rightChild.jingjieProgress,subCur,maxexp)
end
local progress_str
if addexp>0 then
progress_str=FMT.fmt('{0}<color=#549327>(+{1})</color>/{2}',curexp,addexp,maxexp)
else
progress_str=FMT.fmt('{0}/{1}',curexp,maxexp)
end
rightWidget:SetChildProgressText(rightChild.jingjieProgress,progress_str)
end
end


local showXueMai=lsData.xuemai_type~=0
local tipsStr="血脉："
if not showXueMai then
tipsStr=FMT.fmt("{0}无",tipsStr)
end

rightWidget:SetChildText(rightChild.xuemaiTx,tipsStr)
rightWidget:SetChildActive(rightChild.xuemaiProgress,showXueMai)
if showXueMai then
local addxm=self.addLSData.xuemai
self.isfull_xm=lsData.xuemai_val>=100
local cur=lsData.xuemai_val
if cur>100 then
cur=100
end
local changexm=cur
changexm=changexm+addxm
if changexm>100 then
changexm=100
end
if init then
rightWidget:SetChildProgressValue(rightChild.xuemaiProgress,changexm,100)
rightWidget:SetChildProgressValue(rightChild.xuemaiSubProgress,cur,100)
else
rightWidget:SetChildProgress(rightChild.xuemaiProgress,changexm,100)
rightWidget:SetChildProgress(rightChild.xuemaiSubProgress,cur,100)
end
local progress_str
if addxm>0 then
progress_str=FMT.fmt('{0}<color=#549327>(+{1})</color>%',cur,changexm-cur)
else
progress_str=FMT.fmt('{0}%',cur)
end
rightWidget:SetChildProgressText(rightChild.xuemaiProgress,progress_str)
end
end

function UILingShouRongHeWin:refreshSelectGrid()
local rightWidget=self.rightWidget
local num=4
local func=function(idx)
self:refreshSelectGridItem(idx)
end
rightWidget:SetChildLayoutGroupCreateItems(rightChild.selectGrid,num,func)
end

function UILingShouRongHeWin:refreshSelectGridItem(idx)
local rightWidget=self.rightWidget
local item=rightWidget:GetChildLayoutGroupGridItem(rightChild.selectGrid,idx-1)
local lsData=self.addLSList[idx]
local hasls=lsData~=nil
item:SetChildActive(0,hasls)
item:SetChildActive(1,not hasls)
item:SetChildActive(2,hasls)
item:SetChildActive(5,not hasls)
if hasls then

comHelper.setChildModelRawImage_lingshou(item,lsData.id,0,0,eHeadCenterType.eHead,1)

item:SetChildButtonClick(2,function()
self:onSelectGridItemSubClick(idx)
end,true)


comHelper.setChildModelHeadIconBGByColor(item,4,lingshouModel.getColorEx(lsData))
else
item:SetChildCSImageIcon(4,"",false)
end
item:SetChildButtonClick(3,function()
self:onSelectGridItemClick(idx)
end,true)
end

function UILingShouRongHeWin:onSelectGridItemClick(idx)
local args={guid=self.select_ls,selectlist=self.addLSList,onAddBack=self.onAddBack,onSubtractBack=self.onSubtractBack}
UIManager:showWindow('UILingShouRongHeSelectWin',args)
end

function UILingShouRongHeWin:onSelectGridItemSubClick(idx)
local lsData=self.addLSList[idx]
if lsData==nil then return end

table.remove(self.addLSList,idx)
self:refreshSelectGrid()

self.addLSData=lingshouModel.getRongHeData(self.select_ls,self.addLSList)
self:refreshLingShouInfo()
end

function UILingShouRongHeWin.onAddBack(idx,lsData)
if _this==nil then return nil end






if idx>=slotMax then

UIManager.error('灵兽融合选择达到上限')
return false
end
idx=idx+1
_this.addLSList[idx]=lsData

_this:refreshSelectGridItem(idx)

_this.addLSData=lingshouModel.getRongHeData(_this.select_ls,_this.addLSList)

_this:refreshLingShouInfo()

return true
end

function UILingShouRongHeWin.onSubtractBack(guid)
if _this==nil then return nil end
local idx=nil
for i,v in ipairs(_this.addLSList)do
if mathHelper.compareInt64(v.guid,guid)then
idx=i
end
end
if idx==nil then return false end
_this:onSelectGridItemSubClick(idx)
return true
end

function UILingShouRongHeWin:onColorChange(idx)

idx=idx+1
self.colorSortType=idx
userActorSetting.flushVal(colorSavaKey,idx)
end

function UILingShouRongHeWin:onJingJieChange(idx)

idx=idx+1
self.jjSortType=idx
userActorSetting.flushVal(jjSavaKey,idx)
end


function UILingShouRongHeWin:onAutoBtn()





local reject_cb=function(lsData)
if self.select_ls~=nil then
if mathHelper.compareInt64(lsData.guid,self.select_ls)then
return true
end
end
if lingshouModel.checkZhenLingEx(lsData.cfg.race)then
return true
end
if lsData.xuemai_type~=0 then
return true
end
if lsData.cfg.bianyi==1 then
return true
end
if UIDiscipleModel:checkHasLingShouDZ(lsData.guid)then
return true
end
return false
end
local sort_cb=function(a,b)
return a.color>b.color
end
local temp=lingshouLookup:getSortList2Ex(self.jjSortType,1,self.colorSortType,1,reject_cb,sort_cb)

if#temp<0 then
UIManager.error('没有合适的灵兽')
return
end
local list={}
local num=0
for i,v in ipairs(temp)do
if num<slotMax then
num=num+1
table.insert(list,v.item)
end
end
if num>0 then
self.addLSList=list
self.addLSData=lingshouModel.getRongHeData(self.select_ls,self.addLSList)

self:refreshLingShouInfo()
self:refreshSelectGrid()
end
end

function UILingShouRongHeWin:onCommitBtn()
if#self.addLSList<=0 then
UIManager.error('请选择融合的灵兽')
return
end







local lslist={}
local hasZhenLing=false
for i,v in ipairs(self.addLSList)do
table.insert(lslist,v.guid)
hasZhenLing=hasZhenLing or(v.xuemai_type~=0)
end
local rewards=lingshouModel:getQianLiReturnEx(lslist)
local r_count=#rewards
if r_count<=0 then rewards=nil end
local desc1=nil
local desc2=nil
if hasZhenLing and r_count>0 then
desc1='当前选中的灵兽具有真灵血脉和已进行潜力培养\n是否进行融合'
elseif hasZhenLing then
desc1='当前选中的灵兽具有真灵血脉\n是否进行融合？'
elseif r_count>0 then
desc1='当前选中的灵兽已进行潜力培养\n是否进行融合？'
end
if r_count>0 then
desc2='（已培养的潜力的灵兽在融合时会返回已消耗的材料）'
end

if desc1~=nil then
local args={
title='灵兽融合',
desc1=desc1,
desc2=desc2,
rewards=rewards,
rewardTitle='将获得以下材料',
showCancel=true,
cancelName=nil,
commitName='融合',
cancelCB=nil,
commitCB=function()
lingshouController:reqRongHe(self.select_ls,lslist)
end,
}
UIManager:showWindow('UIDialougeRewardWin',args)
else
lingshouController:reqRongHe(self.select_ls,lslist)
end
end

function UILingShouRongHeWin:rece_RongHe(guid)
local str=FMT.fmt('增加{0}修为',self.addLSData.jjexp)
commonTipsHelper.addThrowOutAndSliderTips(1,str)

if mathHelper.compareInt64(guid,self.select_ls)then
self:onSelectLingShou(guid)
return
end

for i,v in pairs(self.addLSList)do
if mathHelper.compareInt64(v.guid,guid)then
self.onSubtractBack(guid)
end
end
end
