







def_class("UIXM_TYSC_MainWin",UIWindowBase)









function UIXM_TYSC_MainWin:bindComponents()

self.rankReddot=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.bgImg=UIImage.get(self,2)
self.descTxt=UIText.get(self,3)
self.scoreTxt=UIText.get(self,4)
self.itemGridPanel=UIObject.get(self,5)
self.ruleBtn=UIButton.get(self,6)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UIXM_TYSC_MainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rankReddot);self.rankReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.scoreTxt);self.scoreTxt=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
end
















local _this
local lvModelLookup={
[1]=4023,
[2]=4024,
[3]=4025,
}


function UIXM_TYSC_MainWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_TYSC_MainWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_TYSC_MainWin:onHide()

end




function UIXM_TYSC_MainWin:onShow(argtable,afterOnloaded)
self.isFull=argtable.isFull
self:initItemGridPanel()

local actID=LIMIT_ACT_TYPE.eTianYuanShouChao
local actCfg=limitActivitiesModel:getActConfig(actID)
local desc_str=limitActivitiesModel.getTimeDesc(actCfg)
self.descTxt:setText(desc_str)

local preScore=xianmengModel:getPreScore_TYSC()
local score_str=FMT.fmt('上轮活动仙盟天渊积分：{0}',preScore)
self.scoreTxt:setText(score_str)

self:refreshRankReddot()
end


function UIXM_TYSC_MainWin:testItemAnim(idx,animId)
local item=self.itemGridPanel:getChildCommonLayoutGroupWidgetItem(idx-1)
item:SetChildModelAnimationState(2,animId)
end

function UIXM_TYSC_MainWin:initItemGridPanel()
local preScore=xianmengModel:getPreScore_TYSC()
self.curLevel=xianmengModel:getLevel_TYSC()
local grids=self.itemGridPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local level=i
local cfg=cfgHelper.get1(cfg_skyshouchaojibieconfig_get,level)
local item=grids[i-1]
local score=cfg.needJiFen
local fix=preScore>=score
local isSelect=self.curLevel==level


local modelId=lvModelLookup[i]
local animId
if i==1 then
animId=2016
else
if not fix then
animId=2016
else
animId=2019
end
end
item:SetChildUIModelShowTarget(2,modelId,1,{},animId,false,false,0,nil)




local score_str
if score>0 then
score_str=FMT.fmt('{0}天渊积分',score)
else
score_str=''
end
item:SetChildText(1,score_str)

self:refreshItemSelect(item,i,isSelect)

item:SetChildButtonClick(0,function()
self:onItemClick(i)
end)
end
end

function UIXM_TYSC_MainWin:refreshItemSelect(item,idx,flag)
if item==nil then
item=self.itemGridPanel:getChildCommonLayoutGroupWidgetItem(idx-1)
end

item:SetChildActive(4,flag)
end

function UIXM_TYSC_MainWin:onItemClick(idx)
local level=idx

local args={}
args.titleName=xianmengModel:getLevelName2_TYSC(level)
args.pos=3
args.showBG=false
args.extraWin='UIXM_TYSC_LevelInfoWin'
local extraParams={level=level}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIXM_TYSC_MainWin:refreshRankReddot()
local isreddot=xianmengModel:checkRankReddot_TYSC()
self.rankReddot:setActive(isreddot)
end

function UIXM_TYSC_MainWin:onClickClose()
if self.isFull then
UIFullCommonControl:closeUI()
else
self:closeSelf()
end
end

function UIXM_TYSC_MainWin:onRankClick()
xianmengController:openRankWin_TYSC()
end

function UIXM_TYSC_MainWin:onRuleBtn()
local d={}
d.title='活动规则'
d.mode=3
d.name='limit_act_tysc_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXM_TYSC_MainWin:rec_select()
local curLevel=xianmengModel:getLevel_TYSC()
if self.curLevel~=curLevel then
if self.curLevel then
self:refreshItemSelect(nil,self.curLevel,false)
end
self:refreshItemSelect(nil,curLevel,true)
self.curLevel=curLevel
end
end

function UIXM_TYSC_MainWin:recv_reward()
self:refreshRankReddot()
end