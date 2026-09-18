





local xgTeQuanInfo_SiZhangShengSi={name="xgTeQuanInfo_SiZhangShengSi"}

function xgTeQuanInfo_SiZhangShengSi:onInit()
end

function xgTeQuanInfo_SiZhangShengSi:onDelete()

end

function xgTeQuanInfo_SiZhangShengSi:onUpdate()

end

function xgTeQuanInfo_SiZhangShengSi:use(args)
local num=xianjieModel:getSoldierAllHurtNum(xjSoldierHurtType.eSeriousInjury)
if num==0 then
UIManager.error("尚无受伤修士")
return
end

args=args or{}
if self:checkUseCondition(args)then
YuLingZhaiController.req_6_133()
xianguanController.sendUsePrivilege(self.data.xgid,self.data.tqid,args.exInfoJsonStr)
UIManager.info("修士已全部治愈")
end
end

return xgTeQuanInfo_SiZhangShengSi