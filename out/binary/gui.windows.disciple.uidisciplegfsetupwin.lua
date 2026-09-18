







def_class("UIDiscipleGFSetupWin",UIWindowBase)









function UIDiscipleGFSetupWin:bindComponents()

self.gongfaGrid=UIObject.get(self,0)
self.gongfaNumTxt=UIText.get(self,1)
self.noGFSign=UIObject.get(self,2)
self.checkBtnImage=UIObject.get(self,3)
self.frameAnim=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.jumpBtnReddot=UIObject.get(self,6)



end


function UIDiscipleGFSetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gongfaGrid);self.gongfaGrid=nil;
_UIObject_release(self.gongfaNumTxt);self.gongfaNumTxt=nil;
_UIObject_release(self.noGFSign);self.noGFSign=nil;
_UIObject_release(self.checkBtnImage);self.checkBtnImage=nil;
_UIObject_release(self.frameAnim);self.frameAnim=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.jumpBtnReddot);self.jumpBtnReddot=nil;
end
















local myab='ui/sharedtextures/uiglobalspriteatlas_1.ab'


function UIDiscipleGFSetupWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
end


function UIDiscipleGFSetupWin:__delete()
self:unbindComponents()
local win=UIManager:findActiveWindow('UIDiscipleSkillInfoWin')
if win then
win:resetGFCanvas()
end
local cb=self.callback
if cb then
cb()
end
end


function UIDiscipleGFSetupWin:onHide()

end




function UIDiscipleGFSetupWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.callback=argtable.callback
self.selectpos=argtable.pos

if afterOnloaded then
local win=UIManager:findActiveWindow('UIDiscipleSkillInfoWin')
if win then
local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]
win:setGFCanvas(sortLayer,sortOrder+1)
end
end

self:refreshView()

local cb=function()
self:onLoadFinish()
end
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameAnim:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,cb)
else
self.root:setChildCanvasGroupAlpha(0)
self.frameAnim:setChildModelAnimationState(eAnimationID.bd_stand)
cb()
end
end

function UIDiscipleGFSetupWin:getSelectPos()
return self.selectpos
end

function UIDiscipleGFSetupWin:getMyCanvas()
local arrs=self:getChildCanvas(-1)
return arrs
end

function UIDiscipleGFSetupWin:onLoadFinish()
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.3,func)
end

function UIDiscipleGFSetupWin:resetData(argtable)
self.callback=argtable.callback
self.selectpos=argtable.pos
end

function UIDiscipleGFSetupWin:getList()
local guid=self.disciple_guid
local list=UIDiscipleModel:getDiscipleAllGFData(guid)
if#list>0 then
for i,v in ipairs(list)do
local gfID=v.param_1
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local sorts={}
v.sorts=sorts
if UIDiscipleModel:isDiscipleGFUsing(guid,gfID)then
sorts[1]=1
else
sorts[1]=0
end
sorts[2]=v.param_2
sorts[3]=cfg.color
sorts[4]=1000-gfID
end
mathHelper.sortWeightList(list)
for i,v in ipairs(list)do
v.sorts=nil
end
end
self.gongfalist=list
end

function UIDiscipleGFSetupWin:refreshNum()
local cur=#self.gongfalist
local max=UIGongFaModel:getLearnGFMaxNum()
self.gongfaNumTxt:setText(FMT.fmt('{0}/{1}',cur,max))

local showSign=cur<=0
self.noGFSign:setActive(showSign)


local reddot=false
if showSign then

reddot=gongfaLookup:checkCanLearnGongFaReddot(self.disciple_guid)
end
self.jumpBtnReddot:setActive(reddot)
end

function UIDiscipleGFSetupWin:refreshView()
self:getList()
local cur=#self.gongfalist
self.gongfaGrid:setChildScrollViewCreateGrids(cur,1)

local grids=self.gongfaGrid:getChildScrollViewItemWidgets()
local count=grids.Count
local dzNetData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local usingGFList=UIDiscipleModel:getDiscipleUsingGFList(dzNetData)
local isEquipGF=usingGFList and usingGFList[self.selectpos]>0 or false

for i=1,count do
local item=grids[i-1]
local netData=self.gongfalist[i]
local gfID=netData.param_1
local gflv=netData.param_2
local gfExp=netData.param_3
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)

item:SetChildButtonClick(8,function()
self:onClickGFSlotCallback(gfID)
end)

local colorIcon=UIGongFaModel:getGFColorKuangIcon(cfg.color)
item:SetChildCSImageSprite(0,globalABLookup.cangjingge,colorIcon)

item:SetChildIcon(1,iconHelper.getGongFaIcon(cfg.icon),false)

local elements=UIGongFaModel:getGFElements(gfID)
local elementid=elements[1]
local elementIcon=ELEMENT_TYPE.getIcon(elementid)
item:SetChildCSImageSprite(9,globalABLookup.global,elementIcon)

local lv_str=UIGongFaModel:getGFLeverlStr(gflv)
item:SetChildText(2,lv_str)

item:SetChildText(3,cfg.name)

local isFull=false
local gfMaxLv=UIGongFaModel:getGFMaxLevel(gfID)
if gflv>=gfMaxLv then
isFull=true
end
local curExp=gfExp
local maxExp=cfg.exp[gflv]
if maxExp==nil or isFull then
curExp=1
maxExp=1
end
item:SetChildProgressValue(4,curExp,maxExp)
local progress_str=''
if isFull then
progress_str=UIGongFaModel:getGFLeverlStr(-1)
else
progress_str=FMT.fmt('{0}/{1}',curExp,maxExp)
end
item:SetChildProgressText(4,progress_str)

local isUse=UIDiscipleModel:isDiscipleGFUsing(self.disciple_guid,gfID)
item:SetChildActive(5,isUse)

local btn_str=''
local btn_icon
local isShowEquipReddot=false
if isUse then
btn_str='卸下'
btn_icon='button_chuangkou_4'
else
btn_str='装备'
btn_icon='button_chuangkou_2'
isShowEquipReddot=not isEquipGF
end
item:SetChildCSImageSprite(6,myab,btn_icon)
item:SetChildText(7,btn_str)
item:SetChildButtonClick(6,function()
self:onSetupClick(gfID)
end)


local reddot=UIDiscipleModel:checkDiscipleGFCanUpById(self.disciple_guid,gfID)
item:SetChildActive(10,reddot)


item:SetChildActive(11,isShowEquipReddot)
end

local list=UIGongFaModel:getDiscipleAllStudyGF(self.disciple_guid)
local showbtn=#list>0
self.checkBtnImage:setChildImageExGray(not showbtn)

self:refreshNum()
end

function UIDiscipleGFSetupWin:onClickGFSlotCallback(gfID)
UIManager:showWindow('UIGongFaTipsWin',{guid=self.disciple_guid,gfID=gfID,tipsType=2})
end

function UIDiscipleGFSetupWin:onSetupClick(gfID)
local isUse=UIDiscipleModel:isDiscipleGFUsing(self.disciple_guid,gfID)
if isUse then

local pos=UIDiscipleModel:getDiscipleGFUsingPos(self.disciple_guid,gfID)
UIDiscipleController:requireDiscipleSetupGF(self.disciple_guid,pos,0)
else
UIDiscipleController:requireDiscipleSetupGF(self.disciple_guid,self.selectpos,gfID)
end
end

function UIDiscipleGFSetupWin:onJumpBtn()
if zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eCangJingGe)==nil then
zongmenModel:noBuildingTips(SLG_SYSTEM_TYPE.eCangJingGe)
return
end
local disguid=self.disciple_guid
UIManager:showWindow('UIGongFaDiscipleInfoWin',{guid=disguid})
end

function UIDiscipleGFSetupWin:onCheckBtn()
local dis_guid=self.disciple_guid
local list=UIGongFaModel:getDiscipleAllStudyGF(dis_guid)
if#list>0 then
local args={gflist=list,dis_guid=dis_guid}
UIManager:showWindow('UIGongFaStudyAttrWin',args)
else
UIManager.error('弟子功法尚无研习属性')
end
end

function UIDiscipleGFSetupWin:rec_setupGF(pos,gfID)
self:refreshView()
end

function UIDiscipleGFSetupWin:rec_upGF(gfID,oldlv,newlv)
self:refreshView()
end

function UIDiscipleGFSetupWin:rec_forgetGF(guid,gfID,pos)
self:refreshView()
end

function UIDiscipleGFSetupWin:rec_learGF(guid,gfID)
self:refreshView()
end

function UIDiscipleGFSetupWin:onMoneyChanged(moneyType)
if moneyType==eMoneyType.mtChuanDao then
self:refreshView()
end
end