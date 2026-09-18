







def_class("UIXM_ZZSH_lingliWin",UIWindowBase)









function UIXM_ZZSH_lingliWin:bindComponents()

self.root=UIObject.get(self,0)
self.lingliTxt=UIText.get(self,1)
self.addBtn=UIButton.get(self,2)
self.descTxt=UIText.get(self,3)

self.addBtn:setButtonClick(function()self:onAddBtn()end)



end


function UIXM_ZZSH_lingliWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.lingliTxt);self.lingliTxt=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
end
















local _this=nil


function UIXM_ZZSH_lingliWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_lingliWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_lingliWin:onHide()

end




function UIXM_ZZSH_lingliWin:onShow(argtable,afterOnloaded)
self.m_zrData=argtable.zrData
self.teamguid_str=argtable.teamguid_str

local typo=argtable.typo or 1
local moveX=argtable.moveX
local moveY=argtable.moveY
local offsetX=argtable.offsetX or 0
local offsetY=argtable.offsetY or 0
local width=self.root:getChildSizeDeltaX()
local h_w=width/2
local x=moveX+offsetX
if typo==1 then
x=x-h_w
else
x=x+h_w
end
self.root:setLocalPos(x,moveY+offsetY,0)

self:refreshView()
end

function UIXM_ZZSH_lingliWin:refreshView()

local data=self.m_zrData.detailLookup[self.teamguid_str]
local cur=data.power
local max=zhengzhanshanhaiModel.maxLingLi
local num_str=FMT.fmt('灵力值：{0}',cur)
self.lingliTxt:setText(num_str)

local costNum=data:getReverCost()
local showBtn=costNum>0
self.addBtn:setActive(showBtn)

local faze_str
if cur<=0 then
faze_str='无法战斗'
else
local fzData=zhengzhanshanhaiModel:getLingLiFaZe(cur)
if fzData==nil or fzData[2]==nil or#fzData[2]==0 then
faze_str='无'
else
local fz=fzData[2][1]
faze_str=mysteryEnvironmentEffectModel.getRuleDesc(fz[1],fz[2])
end
end
local str=FMT.fmt('影响：{0}',faze_str)
self.descTxt:setText(str)
end

function UIXM_ZZSH_lingliWin:onAddBtn()
local data=self.m_zrData.detailLookup[self.teamguid_str]
if data==nil then
self:closeSelf()
return
end
local costType=zhengzhanshanhaiModel:getReverLingLiCostType()
local costNum=data:getReverCost()
if costNum>0 then
local have=moneyModel.getMoney(costType)
local moneyName=moneyModel.getMoneyName(costType)
local colorStr=have>=costNum and"549327"or"FF0000"
local iconStr=iconHelper.getIconName(costType)
local costStr=FMT.fmt("<color=#{0}>{1}</color>{2}quad-icon={3}-quad",colorStr,costNum,moneyName,iconStr)
local contentStr=FMT.fmt("是否消耗{0}恢复该队伍灵力",costStr)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',

okcallback=function(...)
if _this==nil then return end
if not moneyModel.checkEnoughMoney(costType,costNum)then
local str=FMT.fmt('{0}不足',moneyModel.getMoneyName(costType))
UIManager.error(str)
gainControl:showGainWin(costType)
return
end
zhengzhanshanhaiController:reqLingLi({data.teamguid})
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
end

function UIXM_ZZSH_lingliWin:rec_lingli(lp)
if lp[self.teamguid_str]then
self:refreshView()
end
end