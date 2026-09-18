







commonTipsHelper={}



function commonTipsHelper.addThrowOutAndSliderTips(throwType,txt,fontSize,fontColor,sortLayer,sortOrder)
local args={throwType,txt,fontSize,fontColor,sortLayer,sortOrder}
commonTipsHelper.addThrowOutAndSliderTipsEx(args)
end

function commonTipsHelper.addThrowOutAndSliderTipsEx(args)
local win=UIManager:findActiveWindow('UIThrowOutAndSlideWin')
if win then
win:addMessage(args)
else
UIManager:showWindow('UIThrowOutAndSlideWin',args)
end
end




























function commonTipsHelper.showDiscipleInjuryHelp(posItem,offset,showType)
local desc_str=cfgHelper.getlang('disciple_Injury_tips')
UIManager:showWindow('UIConditionTipsOne',{showType=showType,str=desc_str,posItem=posItem,pos=offset})
end

function commonTipsHelper.showDiscipleLoyaltyHelp(posItem,offset)
local param1=cfgHelper.get2(cfg_discipleloyaltyconfig_get,1,'deepinjury')
local param2=cfgHelper.get2(cfg_discipleloyaltyconfig_get,1,'work')
local desc_str=FMT.fmt(cfgHelper.getlang('disciple_loyalty_tips'),param1,param2)
UIManager:showWindow('UIConditionTipsOne',{showType=2,str=desc_str,posItem=posItem,pos=offset})
end

function commonTipsHelper.showDiscipleJpbTips(dzID,jobid,args)
local cfg=cfgHelper.get1(cfg_disciplevocationconfig_get,jobid)
local stand_str=UIDiscipleModel:getJobStandStr(jobid,dzID)
local desc=UIDiscipleModel:getJobDesc(jobid,dzID)
args.title=cfg.name
args.title2=FMT.fmt('推荐站位：{0}',stand_str)
args.desc=desc
UIManager:showWindow('UIDescribeTips6',args)
end

function commonTipsHelper.showExpFlow(args)
local win=UIManager:findActiveWindow('UIThrowOutExpWin')
if win then
win:addMessage(args)
else
UIManager:showWindow('UIThrowOutExpWin',args)
end
end

