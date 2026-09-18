







def_class("UINPCIntimacyRewardWin",UIWindowBase)









function UINPCIntimacyRewardWin:bindComponents()

self.root=UIObject.get(self,0)
self.rewardScrollView=UIObject.get(self,1)
self.jingjieTxt=UIText.get(self,2)
self.descTxt=UIText.get(self,3)
self.rewardContent=UIObject.get(self,4)
self.modelRoot=UIObject.get(self,5)
self.nameTxt=UIText.get(self,6)
self.jobIcon=UIImage.get(self,7)
self.rewardProgressBar=UIObject.get(self,8)
self.rewardGrid=UIObject.get(self,9)
self.rewadProgress=UIObject.get(self,10)



end


function UINPCIntimacyRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.jingjieTxt);self.jingjieTxt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.nameTxt);self.nameTxt=nil;
_UIObject_release(self.jobIcon);self.jobIcon=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
end
















local _this=nil


function UINPCIntimacyRewardWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UINPCIntimacyRewardWin:__delete()
_this=nil
self:unbindComponents()
end


function UINPCIntimacyRewardWin:onHide()

end




function UINPCIntimacyRewardWin:onShow(argtable,afterOnloaded)
self.npcid=argtable.npcid

self:refreshInfo()
self:initData()
if afterOnloaded then
self:initRewards(true)
else
self:refreshRewards()
end
end

function UINPCIntimacyRewardWin:refreshInfo()
local npcid=self.npcid
local imagecfg=npcModel:getNPCImageCfg(npcid)
local npccfg=cfgHelper.get1(cfg_npcconfig_get,npcid)

self.nameTxt:setText(imagecfg.name)

local jobid=npcModel:getNPCJob(npcid)
local jobicon=UIDiscipleModel:getJobIconName(jobid)
self.jobIcon:setSprite(globalABLookup.global,jobicon)

local jjlv=npcModel:getNPCJingJie(npcid)
local jjname=UIDiscipleModel.getJJNameCommon(jjlv,3)
local jjstr=FMT.fmt('[{0}]',jjname)
self.jingjieTxt:setText(jjstr)

self.descTxt:setText(npcModel:getNPCDesc(npcid))

self.modelRoot:setChildUIModelRemoveTarget()
local modelParams=npcModel:getImageInfo(imagecfg.id)
comHelper.setChildInSideModelEx(self.modelRoot,modelParams,1,0,0,0,false,true)
end

function UINPCIntimacyRewardWin:initData()
local hgd=npcModel:getNPCIntimacy(self.npcid)
local hgdlv,rate=npcModel.getHaoGanDuLevel(hgd)
self.hgdlv=hgdlv
self.hgdrate=rate
self.hgd=hgd
self.hgdflag=npcModel:getNPCIntimacyRewardFlag(self.npcid)
end

function UINPCIntimacyRewardWin:findRewardIndex(hgdlv)
for i,v in ipairs(self.hgdlvList)do
if v.id==hgdlv then
return i
end
end
end

function UINPCIntimacyRewardWin:initRewards(isInit)
local list={}
local cfgs=cfg_npcintimacyconfig()
for i,v in pairs(cfgs)do
table.insert(list,v)
end
table.sort(list,function(a,b)
return a.id<b.id
end)
self.hgdlvList=list
self.speed=400
self.stepHeight=150

local npcid=self.npcid
local max=#self.hgdlvList

self.rewardGrid:setChildLayoutGroupCreateItems(max)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for idx=1,max do
local item=grids[idx-1]
local cfg=self.hgdlvList[idx]
local lv=cfg.id
local reward=npcModel:getIntimacyReward(npcid,lv)


local posY=(idx-1)*self.stepHeight
item:SetChildAnchoredPosition(-1,Vector2(0,posY))

local abName,icon=npcModel.getIntimacyIcon(lv)
item:SetChildCSImageSprite(1,abName,icon)

local showGoods=reward~=nil
item:SetChildActive(2,showGoods)
if showGoods then
local info=npcModel.getIntimacyRewardInfo(reward)
local goodlist=npcModel.getIntimacyShowReward(reward)

item:SetChildCSImageSprite(4,globalABLookup.npcCommonIcons,info[2])

item:SetChildText(5,info[1])

local c=#goodlist
item:SetChildLayoutGroupCreateItems(6,c)
local grids2=item:GetChildLayoutGroupGridList(6)
for i2=1,c do
local rewardItem=grids2[i2-1]
local reward=goodlist[i2]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickGoodItem(itemid)
end)
end
end
item:SetChildButtonClick(0,function(...)
if _this==nil then return end
_this:onClickItem(lv)
end)
self:refreshRewardItem(item,idx)
end

local max_height=max*self.stepHeight+55
self.rewardContent:setChildSizeDelta(430,max_height)


self:refreshProgress()

if isInit then
local showHeight=self.rewardScrollView:getChildRectHeight()
local progress_height=self.cur_height+showHeight/2+55
local moveY=progress_height-showHeight
if moveY>0 then
self.rewardContent:setLocalPosY(-moveY)
end
end
end

function UINPCIntimacyRewardWin:refreshRewards()
local max=#self.hgdlvList
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for idx=1,max do
local item=grids[idx-1]
self:refreshRewardItem(item,idx)
end
self:refreshProgress()
end

function UINPCIntimacyRewardWin:refreshRewardItem(item,idx)
if item==nil then
item=self.rewardGrid:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.hgdlvList[idx]
local lv=cfg.id
local reward=npcModel:getIntimacyReward(self.npcid,lv)
local showGoods=reward~=nil
local rewardFlag=bitHelper.check_pos(self.hgdflag,lv)
local fix=self.hgdlv>=lv









item:SetChildActive(8,showGoods and fix and not rewardFlag)

item:SetChildActive(7,showGoods and rewardFlag)


end

function UINPCIntimacyRewardWin:refreshProgress(anim)
local curIndex=0
for i,d in ipairs(self.hgdlvList)do
if self.hgdlv==d.id then
curIndex=i
break
end
end
local max=#self.hgdlvList
local max_height=max*self.stepHeight
self.rewardProgressBar:setChildSizeDelta(36,max_height)

local max_height_=max_height-6
local stepHeight_=max_height_/max
local cur_height
if curIndex>=max then
cur_height=max_height_
else
cur_height=((curIndex-1)+self.hgdrate)*stepHeight_
end
self.cur_height=cur_height

if anim then
local old_height=self.rewardProgressBar:getChildSizeDeltaY()
local lerp=math.abs(cur_height-old_height)
self.rewadProgress:setChildDOSizeDelta(Vector2(26,cur_height),lerp/self.speed,nil)
else
self.rewadProgress:setChildSizeDelta(26,cur_height)
end
end

function UINPCIntimacyRewardWin:onClickGoodItem(itemid)
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UINPCIntimacyRewardWin:onClickItem(hgdlv)
local reward=npcModel:getIntimacyReward(self.npcid,hgdlv)
local showGoods=reward~=nil
local fix=self.hgdlv>=hgdlv
local rewardFlag=bitHelper.check_pos(self.hgdflag,hgdlv)
if showGoods then
if not rewardFlag then
if fix then
npcController:reqIntimacyReward(self.npcid,hgdlv)
else
UIManager.error('亲密度不足')
end
end
end
end

function UINPCIntimacyRewardWin:recv_reward(npcid,hgdlv)
if self.npcid==npcid then
self:initData()
local idx=self:findRewardIndex(hgdlv)
if idx then
self:refreshRewardItem(nil,idx)
end
end
end