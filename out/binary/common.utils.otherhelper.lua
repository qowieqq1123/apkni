




otherHelper={}

function otherHelper.invokeFuncOnEveryData(handle_data,handle_func)
for i,v in ipairs(handle_data)do
handle_func(i,v)
end
end
