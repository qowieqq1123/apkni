specialfontHelper={}

local check_spec_chars_list={'？','?','！','!','/','\\','*','[',']','"','<','>','|',':','%','&','#','{','}','(',')','.',',','。','，',' ','\'','·','：','“','”','、'}
local check_spec_chars_lookup={}
for i,v in ipairs(check_spec_chars_list)do
local _c=#v
if check_spec_chars_lookup[_c]==nil then
check_spec_chars_lookup[_c]={}
end
check_spec_chars_lookup[_c][#check_spec_chars_lookup[_c]+1]=v
end








function specialfontHelper.find_spec_chars_weak(_str)

local _,count=string.gsub(_str,'[？?！!/\\%*%[%]"<>|:%%&#{}%(%)%.,。， ]','o')
return count>0
end
function specialfontHelper.check_spec_char_same(_str,n)
if check_spec_chars_lookup[n]then
for i,v in ipairs(check_spec_chars_lookup[n])do
if _str==v then
return true
end
end
end
return false
end